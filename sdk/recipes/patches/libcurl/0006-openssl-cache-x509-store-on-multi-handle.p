diff --git a/lib/vtls/openssl.c b/lib/vtls/openssl.c
index b536b42da..6749b4be3 100644
--- lib/vtls/openssl.c
+++ lib/vtls/openssl.c
@@ -110,6 +110,10 @@
 #include <openssl/ui.h>
 #endif
 
+#if defined(USE_THREADS_POSIX) || defined(USE_THREADS_WIN32)
+#define HAVE_THREADS
+#endif
+
 #if OPENSSL_VERSION_NUMBER >= 0x00909000L
 #define SSL_METHOD_QUAL const
 #else
@@ -259,6 +263,15 @@
 #define HAVE_OPENSSL_VERSION
 #endif
 
+/*
+ * Whether the OpenSSL version has the API needed to support sharing an
+ * X509_STORE between connections. The API is:
+ * * `X509_STORE_up_ref`       -- Introduced: OpenSSL 1.1.0.
+ */
+#if (OPENSSL_VERSION_NUMBER >= 0x10100000L) /* OpenSSL >= 1.1.0 */
+#define HAVE_SSL_X509_STORE_SHARE
+#endif
+
 struct ssl_backend_data {
   struct Curl_easy *logger; /* transfer handle to pass trace logs to, only
                                using sockindex 0 */
@@ -272,6 +285,13 @@ struct ssl_backend_data {
 #endif
 };
 
+#if defined(HAVE_SSL_X509_STORE_SHARE)
+struct multi_ssl_backend_data {
+  char *CAfile;      /* CAfile path used to generate X509 store */
+  X509_STORE *store; /* cached X509 store or NULL if none */
+};
+#endif /* HAVE_SSL_X509_STORE_SHARE */
+
 #define push_certinfo(_label, _num)             \
 do {                              \
   long info_len = BIO_get_mem_data(mem, &ptr); \
@@ -3146,6 +3166,113 @@ static CURLcode populate_x509_store(struct Curl_easy *data,
   return result;
 }
 
+#if defined(HAVE_SSL_X509_STORE_SHARE)
+static bool cached_x509_store_different(
+  const struct multi_ssl_backend_data *mb,
+  const struct connectdata *conn)
+{
+  if(!mb->CAfile || !SSL_CONN_CONFIG(CAfile))
+    return mb->CAfile != SSL_CONN_CONFIG(CAfile);
+
+  return strcmp(mb->CAfile, SSL_CONN_CONFIG(CAfile));
+}
+
+static X509_STORE *get_cached_x509_store(const struct Curl_easy *data,
+                                         const struct connectdata *conn)
+{
+  struct Curl_multi *multi = data->multi_easy ? data->multi_easy : data->multi;
+  X509_STORE *store = NULL;
+
+  if(multi &&
+     multi->ssl_backend_data &&
+     multi->ssl_backend_data->store &&
+     !cached_x509_store_different(multi->ssl_backend_data, conn)) {
+    store = multi->ssl_backend_data->store;
+  }
+
+  return store;
+}
+
+static void set_cached_x509_store(const struct Curl_easy *data,
+                                  const struct connectdata *conn,
+                                  X509_STORE *store)
+{
+  struct Curl_multi *multi = data->multi_easy ? data->multi_easy : data->multi;
+  struct multi_ssl_backend_data *mbackend;
+
+  if(!multi)
+    return;
+
+  if(!multi->ssl_backend_data) {
+    multi->ssl_backend_data = calloc(1, sizeof(struct multi_ssl_backend_data));
+    if(!multi->ssl_backend_data)
+      return;
+  }
+
+  mbackend = multi->ssl_backend_data;
+
+  if(X509_STORE_up_ref(store)) {
+    char *CAfile = NULL;
+
+    if(SSL_CONN_CONFIG(CAfile)) {
+      CAfile = strdup(SSL_CONN_CONFIG(CAfile));
+      if(!CAfile) {
+        X509_STORE_free(store);
+        return;
+      }
+    }
+
+    if(mbackend->store) {
+      X509_STORE_free(mbackend->store);
+      free(mbackend->CAfile);
+    }
+
+    mbackend->store = store;
+    mbackend->CAfile = CAfile;
+  }
+}
+
+static CURLcode set_up_x509_store(struct Curl_easy *data,
+                                  struct connectdata *conn,
+                                  struct ssl_backend_data *backend)
+{
+  CURLcode result = CURLE_OK;
+  X509_STORE *cached_store = get_cached_x509_store(data, conn);
+
+  /* Consider the X509 store cacheable if it comes exclusively from a CAfile,
+     or no source is provided and we are falling back to openssl's built-in
+     default. */
+  bool cache_criteria_met = SSL_CONN_CONFIG(verifypeer) &&
+                            !SSL_CONN_CONFIG(CApath) &&
+                            !SSL_CONN_CONFIG(ca_info_blob) &&
+                            !SSL_SET_OPTION(primary.CRLfile) &&
+                            !SSL_SET_OPTION(native_ca_store);
+
+  if(cached_store && cache_criteria_met && X509_STORE_up_ref(cached_store)) {
+    SSL_CTX_set_cert_store(backend->ctx, cached_store);
+  }
+  else {
+    X509_STORE *store = SSL_CTX_get_cert_store(backend->ctx);
+
+    result = populate_x509_store(data, conn, store);
+    if(result == CURLE_OK && cache_criteria_met) {
+      set_cached_x509_store(data, conn, store);
+    }
+  }
+
+  return result;
+}
+#else /* HAVE_SSL_X509_STORE_SHARE */
+static CURLcode set_up_x509_store(struct Curl_easy *data,
+                                  struct connectdata *conn,
+                                  struct ssl_backend_data *backend)
+{
+  X509_STORE *store = SSL_CTX_get_cert_store(backend->ctx);
+
+  return populate_x509_store(data, conn, store);
+}
+#endif /* HAVE_SSL_X509_STORE_SHARE */
+
 static CURLcode ossl_connect_step1(struct Curl_easy *data,
                                    struct connectdata *conn, int sockindex)
 {
@@ -3443,8 +3570,7 @@ static CURLcode ossl_connect_step1(struct Curl_easy *data,
   }
 #endif
 
-  result = populate_x509_store(data, conn,
-                               SSL_CTX_get_cert_store(backend->ctx));
+  result = set_up_x509_store(data, conn, backend);
   if(result)
     return result;
 
@@ -4579,6 +4705,20 @@ static void ossl_disassociate_connection(struct Curl_easy *data,
   }
 }
 
+static void ossl_free_multi_ssl_backend_data(
+  struct multi_ssl_backend_data *mbackend)
+{
+#if defined(HAVE_SSL_X509_STORE_SHARE)
+  if(mbackend->store) {
+    X509_STORE_free(mbackend->store);
+  }
+  free(mbackend->CAfile);
+  free(mbackend);
+#else /* HAVE_SSL_X509_STORE_SHARE */
+  (void)mbackend;
+#endif /* HAVE_SSL_X509_STORE_SHARE */
+}
+
 const struct Curl_ssl Curl_ssl_openssl = {
   { CURLSSLBACKEND_OPENSSL, "openssl" }, /* info */
 
@@ -4620,7 +4760,7 @@ const struct Curl_ssl Curl_ssl_openssl = {
 #endif
   ossl_associate_connection, /* associate_connection */
   ossl_disassociate_connection, /* disassociate_connection */
-  NULL                      /* free_multi_ssl_backend_data */
+  ossl_free_multi_ssl_backend_data /* free_multi_ssl_backend_data */
 };
 
 #endif /* USE_OPENSSL */
-- 
2.34.1

