diff --git a/lib/vtls/openssl.c b/lib/vtls/openssl.c
index 981075838..d80f79921 100644
--- lib/vtls/openssl.c
+++ lib/vtls/openssl.c
@@ -2830,7 +2830,7 @@ static int ossl_new_session_cb(SSL *ssl, SSL_SESSION *ssl_sessionid)
   return res;
 }
 
-static CURLcode load_cacert_from_memory(SSL_CTX *ctx,
+static CURLcode load_cacert_from_memory(X509_STORE *store,
                                         const struct curl_blob *ca_info_blob)
 {
   /* these need to be freed at the end */
@@ -2839,16 +2839,11 @@ static CURLcode load_cacert_from_memory(SSL_CTX *ctx,
 
   /* everything else is just a reference */
   int i, count = 0;
-  X509_STORE *cts = NULL;
   X509_INFO *itmp = NULL;
 
   if(ca_info_blob->len > (size_t)INT_MAX)
     return CURLE_SSL_CACERT_BADFILE;
 
-  cts = SSL_CTX_get_cert_store(ctx);
-  if(!cts)
-    return CURLE_OUT_OF_MEMORY;
-
   cbio = BIO_new_mem_buf(ca_info_blob->data, (int)ca_info_blob->len);
   if(!cbio)
     return CURLE_OUT_OF_MEMORY;
@@ -2863,7 +2858,7 @@ static CURLcode load_cacert_from_memory(SSL_CTX *ctx,
   for(i = 0; i < (int)sk_X509_INFO_num(inf); ++i) {
     itmp = sk_X509_INFO_value(inf, i);
     if(itmp->x509) {
-      if(X509_STORE_add_cert(cts, itmp->x509)) {
+      if(X509_STORE_add_cert(store, itmp->x509)) {
         ++count;
       }
       else {
@@ -2873,7 +2868,7 @@ static CURLcode load_cacert_from_memory(SSL_CTX *ctx,
       }
     }
     if(itmp->crl) {
-      if(X509_STORE_add_crl(cts, itmp->crl)) {
+      if(X509_STORE_add_crl(store, itmp->crl)) {
         ++count;
       }
       else {
@@ -2892,7 +2887,8 @@ static CURLcode load_cacert_from_memory(SSL_CTX *ctx,
 }
 
 static CURLcode populate_x509_store(struct Curl_easy *data,
-                                    struct connectdata *conn, int sockindex)
+                                    struct connectdata *conn,
+                                    X509_STORE *store)
 {
   CURLcode result = CURLE_OK;
   X509_LOOKUP *lookup = NULL;
@@ -2903,10 +2899,11 @@ static CURLcode populate_x509_store(struct Curl_easy *data,
   const char * const ssl_capath = SSL_CONN_CONFIG(CApath);
   const char * const ssl_crlfile = SSL_SET_OPTION(primary.CRLfile);
   const bool verifypeer = SSL_CONN_CONFIG(verifypeer);
-  struct ssl_connect_data *connssl = &conn->ssl[sockindex];
-  struct ssl_backend_data *backend = connssl->backend;
   bool imported_native_ca = false;
 
+  if(!store)
+    return CURLE_OUT_OF_MEMORY;
+
 #if defined(USE_WIN32_CRYPTO)
   /* Import certificates from the Windows root certificate store if requested.
      https://stackoverflow.com/questions/9507184/
@@ -2914,7 +2911,6 @@ static CURLcode populate_x509_store(struct Curl_easy *data,
      https://datatracker.ietf.org/doc/html/rfc5280 */
   if((SSL_CONN_CONFIG(verifypeer) || SSL_CONN_CONFIG(verifyhost)) &&
      (SSL_SET_OPTION(native_ca_store))) {
-    X509_STORE *store = SSL_CTX_get_cert_store(backend->ctx);
     HCERTSTORE hStore = CertOpenSystemStore(0, TEXT("ROOT"));
 
     if(hStore) {
@@ -3053,7 +3049,7 @@ static CURLcode populate_x509_store(struct Curl_easy *data,
 #endif
 
   if(ca_info_blob) {
-    result = load_cacert_from_memory(backend->ctx, ca_info_blob);
+    result = load_cacert_from_memory(store, ca_info_blob);
     if(result) {
       if(result == CURLE_OUT_OF_MEMORY ||
          (verifypeer && !imported_native_ca)) {
@@ -3069,13 +3065,13 @@ static CURLcode populate_x509_store(struct Curl_easy *data,
 #if defined(OPENSSL_VERSION_MAJOR) && (OPENSSL_VERSION_MAJOR >= 3)
   /* OpenSSL 3.0.0 has deprecated SSL_CTX_load_verify_locations */
     if(ssl_cafile &&
-       !SSL_CTX_load_verify_file(backend->ctx, ssl_cafile)) {
+       !X509_STORE_load_file(store, ssl_cafile)) {
       /* Fail if we insist on successfully verifying the server. */
       failf(data, "error setting certificate file: %s", ssl_cafile);
       return CURLE_SSL_CACERT_BADFILE;
     }
     if(ssl_capath &&
-       !SSL_CTX_load_verify_dir(backend->ctx, ssl_capath)) {
+       !X509_STORE_load_path(store, ssl_capath)) {
       /* Fail if we insist on successfully verifying the server. */
       failf(data, "error setting certificate path: %s", ssl_capath);
       return CURLE_SSL_CACERT_BADFILE;
@@ -3083,7 +3079,7 @@ static CURLcode populate_x509_store(struct Curl_easy *data,
 #else
     /* tell OpenSSL where to find CA certificates that are used to verify the
        server's certificate. */
-    if(!SSL_CTX_load_verify_locations(backend->ctx, ssl_cafile, ssl_capath)) {
+    if(!X509_STORE_load_locations(store, ssl_cafile, ssl_capath)) {
       /* Fail if we insist on successfully verifying the server. */
       failf(data, "error setting certificate verify locations:"
             "  CAfile: %s CApath: %s",
@@ -3101,15 +3097,14 @@ static CURLcode populate_x509_store(struct Curl_easy *data,
      !ca_info_blob && !ssl_cafile && !ssl_capath && !imported_native_ca) {
     /* verifying the peer without any CA certificates won't
        work so use openssl's built-in default as fallback */
-    SSL_CTX_set_default_verify_paths(backend->ctx);
+    X509_STORE_set_default_paths(store);
   }
 #endif
 
   if(ssl_crlfile) {
     /* tell OpenSSL where to find CRL file that is used to check certificate
      * revocation */
-    lookup = X509_STORE_add_lookup(SSL_CTX_get_cert_store(backend->ctx),
-                                 X509_LOOKUP_file());
+    lookup = X509_STORE_add_lookup(store, X509_LOOKUP_file());
     if(!lookup ||
        (!X509_load_crl_file(lookup, ssl_crlfile, X509_FILETYPE_PEM)) ) {
       failf(data, "error loading CRL file: %s", ssl_crlfile);
@@ -3117,7 +3112,7 @@ static CURLcode populate_x509_store(struct Curl_easy *data,
     }
     /* Everything is fine. */
     infof(data, "successfully loaded CRL file:");
-    X509_STORE_set_flags(SSL_CTX_get_cert_store(backend->ctx),
+    X509_STORE_set_flags(store,
                          X509_V_FLAG_CRL_CHECK|X509_V_FLAG_CRL_CHECK_ALL);
 
     infof(data, "  CRLfile: %s", ssl_crlfile);
@@ -3131,8 +3126,7 @@ static CURLcode populate_x509_store(struct Curl_easy *data,
        https://rt.openssl.org/Ticket/Display.html?id=3621&user=guest&pass=guest
     */
 #if defined(X509_V_FLAG_TRUSTED_FIRST)
-    X509_STORE_set_flags(SSL_CTX_get_cert_store(backend->ctx),
-                         X509_V_FLAG_TRUSTED_FIRST);
+    X509_STORE_set_flags(store, X509_V_FLAG_TRUSTED_FIRST);
 #endif
 #ifdef X509_V_FLAG_PARTIAL_CHAIN
     if(!SSL_SET_OPTION(no_partialchain) && !ssl_crlfile) {
@@ -3144,8 +3138,7 @@ static CURLcode populate_x509_store(struct Curl_easy *data,
          Due to OpenSSL bug https://github.com/openssl/openssl/issues/5081 we
          cannot do partial chains with a CRL check.
       */
-      X509_STORE_set_flags(SSL_CTX_get_cert_store(backend->ctx),
-                           X509_V_FLAG_PARTIAL_CHAIN);
+      X509_STORE_set_flags(store, X509_V_FLAG_PARTIAL_CHAIN);
     }
 #endif
   }
@@ -3450,7 +3443,8 @@ static CURLcode ossl_connect_step1(struct Curl_easy *data,
   }
 #endif
 
-  result = populate_x509_store(data, conn, sockindex);
+  result = populate_x509_store(data, conn,
+                               SSL_CTX_get_cert_store(backend->ctx));
   if(result)
     return result;
 
-- 
2.34.1

