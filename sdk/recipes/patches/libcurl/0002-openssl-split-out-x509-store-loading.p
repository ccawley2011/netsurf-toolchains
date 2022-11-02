diff --git a/lib/vtls/openssl.c b/lib/vtls/openssl.c
index ad2efa558..981075838 100644
--- lib/vtls/openssl.c
+++ lib/vtls/openssl.c
@@ -2891,13 +2891,274 @@ static CURLcode load_cacert_from_memory(SSL_CTX *ctx,
   return (count > 0 ? CURLE_OK : CURLE_SSL_CACERT_BADFILE);
 }
 
+static CURLcode populate_x509_store(struct Curl_easy *data,
+                                    struct connectdata *conn, int sockindex)
+{
+  CURLcode result = CURLE_OK;
+  X509_LOOKUP *lookup = NULL;
+  const struct curl_blob *ca_info_blob = SSL_CONN_CONFIG(ca_info_blob);
+  const char * const ssl_cafile =
+    /* CURLOPT_CAINFO_BLOB overrides CURLOPT_CAINFO */
+    (ca_info_blob ? NULL : SSL_CONN_CONFIG(CAfile));
+  const char * const ssl_capath = SSL_CONN_CONFIG(CApath);
+  const char * const ssl_crlfile = SSL_SET_OPTION(primary.CRLfile);
+  const bool verifypeer = SSL_CONN_CONFIG(verifypeer);
+  struct ssl_connect_data *connssl = &conn->ssl[sockindex];
+  struct ssl_backend_data *backend = connssl->backend;
+  bool imported_native_ca = false;
+
+#if defined(USE_WIN32_CRYPTO)
+  /* Import certificates from the Windows root certificate store if requested.
+     https://stackoverflow.com/questions/9507184/
+     https://github.com/d3x0r/SACK/blob/master/src/netlib/ssl_layer.c#L1037
+     https://datatracker.ietf.org/doc/html/rfc5280 */
+  if((SSL_CONN_CONFIG(verifypeer) || SSL_CONN_CONFIG(verifyhost)) &&
+     (SSL_SET_OPTION(native_ca_store))) {
+    X509_STORE *store = SSL_CTX_get_cert_store(backend->ctx);
+    HCERTSTORE hStore = CertOpenSystemStore(0, TEXT("ROOT"));
+
+    if(hStore) {
+      PCCERT_CONTEXT pContext = NULL;
+      /* The array of enhanced key usage OIDs will vary per certificate and is
+         declared outside of the loop so that rather than malloc/free each
+         iteration we can grow it with realloc, when necessary. */
+      CERT_ENHKEY_USAGE *enhkey_usage = NULL;
+      DWORD enhkey_usage_size = 0;
+
+      /* This loop makes a best effort to import all valid certificates from
+         the MS root store. If a certificate cannot be imported it is skipped.
+         'result' is used to store only hard-fail conditions (such as out of
+         memory) that cause an early break. */
+      result = CURLE_OK;
+      for(;;) {
+        X509 *x509;
+        FILETIME now;
+        BYTE key_usage[2];
+        DWORD req_size;
+        const unsigned char *encoded_cert;
+#if defined(DEBUGBUILD) && !defined(CURL_DISABLE_VERBOSE_STRINGS)
+        char cert_name[256];
+#endif
+
+        pContext = CertEnumCertificatesInStore(hStore, pContext);
+        if(!pContext)
+          break;
+
+#if defined(DEBUGBUILD) && !defined(CURL_DISABLE_VERBOSE_STRINGS)
+        if(!CertGetNameStringA(pContext, CERT_NAME_SIMPLE_DISPLAY_TYPE, 0,
+                               NULL, cert_name, sizeof(cert_name))) {
+          strcpy(cert_name, "Unknown");
+        }
+        infof(data, "SSL: Checking cert \"%s\"", cert_name);
+#endif
+
+        encoded_cert = (const unsigned char *)pContext->pbCertEncoded;
+        if(!encoded_cert)
+          continue;
+
+        GetSystemTimeAsFileTime(&now);
+        if(CompareFileTime(&pContext->pCertInfo->NotBefore, &now) > 0 ||
+           CompareFileTime(&now, &pContext->pCertInfo->NotAfter) > 0)
+          continue;
+
+        /* If key usage exists check for signing attribute */
+        if(CertGetIntendedKeyUsage(pContext->dwCertEncodingType,
+                                   pContext->pCertInfo,
+                                   key_usage, sizeof(key_usage))) {
+          if(!(key_usage[0] & CERT_KEY_CERT_SIGN_KEY_USAGE))
+            continue;
+        }
+        else if(GetLastError())
+          continue;
+
+        /* If enhanced key usage exists check for server auth attribute.
+         *
+         * Note "In a Microsoft environment, a certificate might also have EKU
+         * extended properties that specify valid uses for the certificate."
+         * The call below checks both, and behavior varies depending on what is
+         * found. For more details see CertGetEnhancedKeyUsage doc.
+         */
+        if(CertGetEnhancedKeyUsage(pContext, 0, NULL, &req_size)) {
+          if(req_size && req_size > enhkey_usage_size) {
+            void *tmp = realloc(enhkey_usage, req_size);
+
+            if(!tmp) {
+              failf(data, "SSL: Out of memory allocating for OID list");
+              result = CURLE_OUT_OF_MEMORY;
+              break;
+            }
+
+            enhkey_usage = (CERT_ENHKEY_USAGE *)tmp;
+            enhkey_usage_size = req_size;
+          }
+
+          if(CertGetEnhancedKeyUsage(pContext, 0, enhkey_usage, &req_size)) {
+            if(!enhkey_usage->cUsageIdentifier) {
+              /* "If GetLastError returns CRYPT_E_NOT_FOUND, the certificate is
+                 good for all uses. If it returns zero, the certificate has no
+                 valid uses." */
+              if((HRESULT)GetLastError() != CRYPT_E_NOT_FOUND)
+                continue;
+            }
+            else {
+              DWORD i;
+              bool found = false;
+
+              for(i = 0; i < enhkey_usage->cUsageIdentifier; ++i) {
+                if(!strcmp("1.3.6.1.5.5.7.3.1" /* OID server auth */,
+                           enhkey_usage->rgpszUsageIdentifier[i])) {
+                  found = true;
+                  break;
+                }
+              }
+
+              if(!found)
+                continue;
+            }
+          }
+          else
+            continue;
+        }
+        else
+          continue;
+
+        x509 = d2i_X509(NULL, &encoded_cert, pContext->cbCertEncoded);
+        if(!x509)
+          continue;
+
+        /* Try to import the certificate. This may fail for legitimate reasons
+           such as duplicate certificate, which is allowed by MS but not
+           OpenSSL. */
+        if(X509_STORE_add_cert(store, x509) == 1) {
+#if defined(DEBUGBUILD) && !defined(CURL_DISABLE_VERBOSE_STRINGS)
+          infof(data, "SSL: Imported cert \"%s\"", cert_name);
+#endif
+          imported_native_ca = true;
+        }
+        X509_free(x509);
+      }
+
+      free(enhkey_usage);
+      CertFreeCertificateContext(pContext);
+      CertCloseStore(hStore, 0);
+
+      if(result)
+        return result;
+    }
+    if(imported_native_ca)
+      infof(data, "successfully imported Windows CA store");
+    else
+      infof(data, "error importing Windows CA store, continuing anyway");
+  }
+#endif
+
+  if(ca_info_blob) {
+    result = load_cacert_from_memory(backend->ctx, ca_info_blob);
+    if(result) {
+      if(result == CURLE_OUT_OF_MEMORY ||
+         (verifypeer && !imported_native_ca)) {
+        failf(data, "error importing CA certificate blob");
+        return result;
+      }
+      /* Only warn if no certificate verification is required. */
+      infof(data, "error importing CA certificate blob, continuing anyway");
+    }
+  }
+
+  if(verifypeer && !imported_native_ca && (ssl_cafile || ssl_capath)) {
+#if defined(OPENSSL_VERSION_MAJOR) && (OPENSSL_VERSION_MAJOR >= 3)
+  /* OpenSSL 3.0.0 has deprecated SSL_CTX_load_verify_locations */
+    if(ssl_cafile &&
+       !SSL_CTX_load_verify_file(backend->ctx, ssl_cafile)) {
+      /* Fail if we insist on successfully verifying the server. */
+      failf(data, "error setting certificate file: %s", ssl_cafile);
+      return CURLE_SSL_CACERT_BADFILE;
+    }
+    if(ssl_capath &&
+       !SSL_CTX_load_verify_dir(backend->ctx, ssl_capath)) {
+      /* Fail if we insist on successfully verifying the server. */
+      failf(data, "error setting certificate path: %s", ssl_capath);
+      return CURLE_SSL_CACERT_BADFILE;
+    }
+#else
+    /* tell OpenSSL where to find CA certificates that are used to verify the
+       server's certificate. */
+    if(!SSL_CTX_load_verify_locations(backend->ctx, ssl_cafile, ssl_capath)) {
+      /* Fail if we insist on successfully verifying the server. */
+      failf(data, "error setting certificate verify locations:"
+            "  CAfile: %s CApath: %s",
+            ssl_cafile ? ssl_cafile : "none",
+            ssl_capath ? ssl_capath : "none");
+      return CURLE_SSL_CACERT_BADFILE;
+    }
+#endif
+    infof(data, " CAfile: %s", ssl_cafile ? ssl_cafile : "none");
+    infof(data, " CApath: %s", ssl_capath ? ssl_capath : "none");
+  }
+
+#ifdef CURL_CA_FALLBACK
+  if(verifypeer &&
+     !ca_info_blob && !ssl_cafile && !ssl_capath && !imported_native_ca) {
+    /* verifying the peer without any CA certificates won't
+       work so use openssl's built-in default as fallback */
+    SSL_CTX_set_default_verify_paths(backend->ctx);
+  }
+#endif
+
+  if(ssl_crlfile) {
+    /* tell OpenSSL where to find CRL file that is used to check certificate
+     * revocation */
+    lookup = X509_STORE_add_lookup(SSL_CTX_get_cert_store(backend->ctx),
+                                 X509_LOOKUP_file());
+    if(!lookup ||
+       (!X509_load_crl_file(lookup, ssl_crlfile, X509_FILETYPE_PEM)) ) {
+      failf(data, "error loading CRL file: %s", ssl_crlfile);
+      return CURLE_SSL_CRL_BADFILE;
+    }
+    /* Everything is fine. */
+    infof(data, "successfully loaded CRL file:");
+    X509_STORE_set_flags(SSL_CTX_get_cert_store(backend->ctx),
+                         X509_V_FLAG_CRL_CHECK|X509_V_FLAG_CRL_CHECK_ALL);
+
+    infof(data, "  CRLfile: %s", ssl_crlfile);
+  }
+
+  if(verifypeer) {
+    /* Try building a chain using issuers in the trusted store first to avoid
+       problems with server-sent legacy intermediates.  Newer versions of
+       OpenSSL do alternate chain checking by default but we do not know how to
+       determine that in a reliable manner.
+       https://rt.openssl.org/Ticket/Display.html?id=3621&user=guest&pass=guest
+    */
+#if defined(X509_V_FLAG_TRUSTED_FIRST)
+    X509_STORE_set_flags(SSL_CTX_get_cert_store(backend->ctx),
+                         X509_V_FLAG_TRUSTED_FIRST);
+#endif
+#ifdef X509_V_FLAG_PARTIAL_CHAIN
+    if(!SSL_SET_OPTION(no_partialchain) && !ssl_crlfile) {
+      /* Have intermediate certificates in the trust store be treated as
+         trust-anchors, in the same way as self-signed root CA certificates
+         are. This allows users to verify servers using the intermediate cert
+         only, instead of needing the whole chain.
+
+         Due to OpenSSL bug https://github.com/openssl/openssl/issues/5081 we
+         cannot do partial chains with a CRL check.
+      */
+      X509_STORE_set_flags(SSL_CTX_get_cert_store(backend->ctx),
+                           X509_V_FLAG_PARTIAL_CHAIN);
+    }
+#endif
+  }
+
+  return result;
+}
+
 static CURLcode ossl_connect_step1(struct Curl_easy *data,
                                    struct connectdata *conn, int sockindex)
 {
   CURLcode result = CURLE_OK;
   char *ciphers;
   SSL_METHOD_QUAL SSL_METHOD *req_method = NULL;
-  X509_LOOKUP *lookup = NULL;
   curl_socket_t sockfd = conn->sock[sockindex];
   struct ssl_connect_data *connssl = &conn->ssl[sockindex];
   ctx_option_t ctx_options = 0;
@@ -2919,17 +3180,10 @@ static CURLcode ossl_connect_step1(struct Curl_easy *data,
 #endif
   char * const ssl_cert = SSL_SET_OPTION(primary.clientcert);
   const struct curl_blob *ssl_cert_blob = SSL_SET_OPTION(primary.cert_blob);
-  const struct curl_blob *ca_info_blob = SSL_CONN_CONFIG(ca_info_blob);
   const char * const ssl_cert_type = SSL_SET_OPTION(cert_type);
-  const char * const ssl_cafile =
-    /* CURLOPT_CAINFO_BLOB overrides CURLOPT_CAINFO */
-    (ca_info_blob ? NULL : SSL_CONN_CONFIG(CAfile));
-  const char * const ssl_capath = SSL_CONN_CONFIG(CApath);
   const bool verifypeer = SSL_CONN_CONFIG(verifypeer);
-  const char * const ssl_crlfile = SSL_SET_OPTION(primary.CRLfile);
   char error_buffer[256];
   struct ssl_backend_data *backend = connssl->backend;
-  bool imported_native_ca = false;
 
   DEBUGASSERT(ssl_connect_1 == connssl->connecting_state);
   DEBUGASSERT(backend);
@@ -3196,249 +3450,9 @@ static CURLcode ossl_connect_step1(struct Curl_easy *data,
   }
 #endif
 
-
-#if defined(USE_WIN32_CRYPTO)
-  /* Import certificates from the Windows root certificate store if requested.
-     https://stackoverflow.com/questions/9507184/
-     https://github.com/d3x0r/SACK/blob/master/src/netlib/ssl_layer.c#L1037
-     https://datatracker.ietf.org/doc/html/rfc5280 */
-  if((SSL_CONN_CONFIG(verifypeer) || SSL_CONN_CONFIG(verifyhost)) &&
-     (SSL_SET_OPTION(native_ca_store))) {
-    X509_STORE *store = SSL_CTX_get_cert_store(backend->ctx);
-    HCERTSTORE hStore = CertOpenSystemStore(0, TEXT("ROOT"));
-
-    if(hStore) {
-      PCCERT_CONTEXT pContext = NULL;
-      /* The array of enhanced key usage OIDs will vary per certificate and is
-         declared outside of the loop so that rather than malloc/free each
-         iteration we can grow it with realloc, when necessary. */
-      CERT_ENHKEY_USAGE *enhkey_usage = NULL;
-      DWORD enhkey_usage_size = 0;
-
-      /* This loop makes a best effort to import all valid certificates from
-         the MS root store. If a certificate cannot be imported it is skipped.
-         'result' is used to store only hard-fail conditions (such as out of
-         memory) that cause an early break. */
-      result = CURLE_OK;
-      for(;;) {
-        X509 *x509;
-        FILETIME now;
-        BYTE key_usage[2];
-        DWORD req_size;
-        const unsigned char *encoded_cert;
-#if defined(DEBUGBUILD) && !defined(CURL_DISABLE_VERBOSE_STRINGS)
-        char cert_name[256];
-#endif
-
-        pContext = CertEnumCertificatesInStore(hStore, pContext);
-        if(!pContext)
-          break;
-
-#if defined(DEBUGBUILD) && !defined(CURL_DISABLE_VERBOSE_STRINGS)
-        if(!CertGetNameStringA(pContext, CERT_NAME_SIMPLE_DISPLAY_TYPE, 0,
-                               NULL, cert_name, sizeof(cert_name))) {
-          strcpy(cert_name, "Unknown");
-        }
-        infof(data, "SSL: Checking cert \"%s\"", cert_name);
-#endif
-
-        encoded_cert = (const unsigned char *)pContext->pbCertEncoded;
-        if(!encoded_cert)
-          continue;
-
-        GetSystemTimeAsFileTime(&now);
-        if(CompareFileTime(&pContext->pCertInfo->NotBefore, &now) > 0 ||
-           CompareFileTime(&now, &pContext->pCertInfo->NotAfter) > 0)
-          continue;
-
-        /* If key usage exists check for signing attribute */
-        if(CertGetIntendedKeyUsage(pContext->dwCertEncodingType,
-                                   pContext->pCertInfo,
-                                   key_usage, sizeof(key_usage))) {
-          if(!(key_usage[0] & CERT_KEY_CERT_SIGN_KEY_USAGE))
-            continue;
-        }
-        else if(GetLastError())
-          continue;
-
-        /* If enhanced key usage exists check for server auth attribute.
-         *
-         * Note "In a Microsoft environment, a certificate might also have EKU
-         * extended properties that specify valid uses for the certificate."
-         * The call below checks both, and behavior varies depending on what is
-         * found. For more details see CertGetEnhancedKeyUsage doc.
-         */
-        if(CertGetEnhancedKeyUsage(pContext, 0, NULL, &req_size)) {
-          if(req_size && req_size > enhkey_usage_size) {
-            void *tmp = realloc(enhkey_usage, req_size);
-
-            if(!tmp) {
-              failf(data, "SSL: Out of memory allocating for OID list");
-              result = CURLE_OUT_OF_MEMORY;
-              break;
-            }
-
-            enhkey_usage = (CERT_ENHKEY_USAGE *)tmp;
-            enhkey_usage_size = req_size;
-          }
-
-          if(CertGetEnhancedKeyUsage(pContext, 0, enhkey_usage, &req_size)) {
-            if(!enhkey_usage->cUsageIdentifier) {
-              /* "If GetLastError returns CRYPT_E_NOT_FOUND, the certificate is
-                 good for all uses. If it returns zero, the certificate has no
-                 valid uses." */
-              if((HRESULT)GetLastError() != CRYPT_E_NOT_FOUND)
-                continue;
-            }
-            else {
-              DWORD i;
-              bool found = false;
-
-              for(i = 0; i < enhkey_usage->cUsageIdentifier; ++i) {
-                if(!strcmp("1.3.6.1.5.5.7.3.1" /* OID server auth */,
-                           enhkey_usage->rgpszUsageIdentifier[i])) {
-                  found = true;
-                  break;
-                }
-              }
-
-              if(!found)
-                continue;
-            }
-          }
-          else
-            continue;
-        }
-        else
-          continue;
-
-        x509 = d2i_X509(NULL, &encoded_cert, pContext->cbCertEncoded);
-        if(!x509)
-          continue;
-
-        /* Try to import the certificate. This may fail for legitimate reasons
-           such as duplicate certificate, which is allowed by MS but not
-           OpenSSL. */
-        if(X509_STORE_add_cert(store, x509) == 1) {
-#if defined(DEBUGBUILD) && !defined(CURL_DISABLE_VERBOSE_STRINGS)
-          infof(data, "SSL: Imported cert \"%s\"", cert_name);
-#endif
-          imported_native_ca = true;
-        }
-        X509_free(x509);
-      }
-
-      free(enhkey_usage);
-      CertFreeCertificateContext(pContext);
-      CertCloseStore(hStore, 0);
-
-      if(result)
-        return result;
-    }
-    if(imported_native_ca)
-      infof(data, "successfully imported Windows CA store");
-    else
-      infof(data, "error importing Windows CA store, continuing anyway");
-  }
-#endif
-
-  if(ca_info_blob) {
-    result = load_cacert_from_memory(backend->ctx, ca_info_blob);
-    if(result) {
-      if(result == CURLE_OUT_OF_MEMORY ||
-         (verifypeer && !imported_native_ca)) {
-        failf(data, "error importing CA certificate blob");
-        return result;
-      }
-      /* Only warn if no certificate verification is required. */
-      infof(data, "error importing CA certificate blob, continuing anyway");
-    }
-  }
-
-  if(verifypeer && !imported_native_ca && (ssl_cafile || ssl_capath)) {
-#if defined(OPENSSL_VERSION_MAJOR) && (OPENSSL_VERSION_MAJOR >= 3)
-  /* OpenSSL 3.0.0 has deprecated SSL_CTX_load_verify_locations */
-    if(ssl_cafile &&
-       !SSL_CTX_load_verify_file(backend->ctx, ssl_cafile)) {
-      /* Fail if we insist on successfully verifying the server. */
-      failf(data, "error setting certificate file: %s", ssl_cafile);
-      return CURLE_SSL_CACERT_BADFILE;
-    }
-    if(ssl_capath &&
-       !SSL_CTX_load_verify_dir(backend->ctx, ssl_capath)) {
-      /* Fail if we insist on successfully verifying the server. */
-      failf(data, "error setting certificate path: %s", ssl_capath);
-      return CURLE_SSL_CACERT_BADFILE;
-    }
-#else
-    /* tell OpenSSL where to find CA certificates that are used to verify the
-       server's certificate. */
-    if(!SSL_CTX_load_verify_locations(backend->ctx, ssl_cafile, ssl_capath)) {
-      /* Fail if we insist on successfully verifying the server. */
-      failf(data, "error setting certificate verify locations:"
-            "  CAfile: %s CApath: %s",
-            ssl_cafile ? ssl_cafile : "none",
-            ssl_capath ? ssl_capath : "none");
-      return CURLE_SSL_CACERT_BADFILE;
-    }
-#endif
-    infof(data, " CAfile: %s", ssl_cafile ? ssl_cafile : "none");
-    infof(data, " CApath: %s", ssl_capath ? ssl_capath : "none");
-  }
-
-#ifdef CURL_CA_FALLBACK
-  if(verifypeer &&
-     !ca_info_blob && !ssl_cafile && !ssl_capath && !imported_native_ca) {
-    /* verifying the peer without any CA certificates won't
-       work so use openssl's built-in default as fallback */
-    SSL_CTX_set_default_verify_paths(backend->ctx);
-  }
-#endif
-
-  if(ssl_crlfile) {
-    /* tell OpenSSL where to find CRL file that is used to check certificate
-     * revocation */
-    lookup = X509_STORE_add_lookup(SSL_CTX_get_cert_store(backend->ctx),
-                                 X509_LOOKUP_file());
-    if(!lookup ||
-       (!X509_load_crl_file(lookup, ssl_crlfile, X509_FILETYPE_PEM)) ) {
-      failf(data, "error loading CRL file: %s", ssl_crlfile);
-      return CURLE_SSL_CRL_BADFILE;
-    }
-    /* Everything is fine. */
-    infof(data, "successfully loaded CRL file:");
-    X509_STORE_set_flags(SSL_CTX_get_cert_store(backend->ctx),
-                         X509_V_FLAG_CRL_CHECK|X509_V_FLAG_CRL_CHECK_ALL);
-
-    infof(data, "  CRLfile: %s", ssl_crlfile);
-  }
-
-  if(verifypeer) {
-    /* Try building a chain using issuers in the trusted store first to avoid
-       problems with server-sent legacy intermediates.  Newer versions of
-       OpenSSL do alternate chain checking by default but we do not know how to
-       determine that in a reliable manner.
-       https://rt.openssl.org/Ticket/Display.html?id=3621&user=guest&pass=guest
-    */
-#if defined(X509_V_FLAG_TRUSTED_FIRST)
-    X509_STORE_set_flags(SSL_CTX_get_cert_store(backend->ctx),
-                         X509_V_FLAG_TRUSTED_FIRST);
-#endif
-#ifdef X509_V_FLAG_PARTIAL_CHAIN
-    if(!SSL_SET_OPTION(no_partialchain) && !ssl_crlfile) {
-      /* Have intermediate certificates in the trust store be treated as
-         trust-anchors, in the same way as self-signed root CA certificates
-         are. This allows users to verify servers using the intermediate cert
-         only, instead of needing the whole chain.
-
-         Due to OpenSSL bug https://github.com/openssl/openssl/issues/5081 we
-         cannot do partial chains with a CRL check.
-      */
-      X509_STORE_set_flags(SSL_CTX_get_cert_store(backend->ctx),
-                           X509_V_FLAG_PARTIAL_CHAIN);
-    }
-#endif
-  }
+  result = populate_x509_store(data, conn, sockindex);
+  if(result)
+    return result;
 
   /* OpenSSL always tries to verify the peer, this only says whether it should
    * fail to connect if the verification fails, or if it should continue
-- 
2.34.1

