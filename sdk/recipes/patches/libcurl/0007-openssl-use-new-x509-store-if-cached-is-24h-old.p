diff --git a/lib/vtls/openssl.c b/lib/vtls/openssl.c
index 6749b4be3..9c752554e 100644
--- lib/vtls/openssl.c
+++ lib/vtls/openssl.c
@@ -287,8 +287,9 @@ struct ssl_backend_data {
 
 #if defined(HAVE_SSL_X509_STORE_SHARE)
 struct multi_ssl_backend_data {
-  char *CAfile;      /* CAfile path used to generate X509 store */
-  X509_STORE *store; /* cached X509 store or NULL if none */
+  char *CAfile;         /* CAfile path used to generate X509 store */
+  X509_STORE *store;    /* cached X509 store or NULL if none */
+  struct curltime time; /* when the cached store was created */
 };
 #endif /* HAVE_SSL_X509_STORE_SHARE */
 
@@ -3167,6 +3168,14 @@ static CURLcode populate_x509_store(struct Curl_easy *data,
 }
 
 #if defined(HAVE_SSL_X509_STORE_SHARE)
+#define X509_STORE_EXPIRY_MS (24 * 60 * 60 * 1000) /* 24 hours */
+static bool cached_x509_store_expired(const struct multi_ssl_backend_data *mb)
+{
+  struct curltime now = Curl_now();
+
+  return Curl_timediff(now, mb->time) >= X509_STORE_EXPIRY_MS;
+}
+
 static bool cached_x509_store_different(
   const struct multi_ssl_backend_data *mb,
   const struct connectdata *conn)
@@ -3186,6 +3195,7 @@ static X509_STORE *get_cached_x509_store(const struct Curl_easy *data,
   if(multi &&
      multi->ssl_backend_data &&
      multi->ssl_backend_data->store &&
+     !cached_x509_store_expired(multi->ssl_backend_data) &&
      !cached_x509_store_different(multi->ssl_backend_data, conn)) {
     store = multi->ssl_backend_data->store;
   }
@@ -3227,6 +3237,7 @@ static void set_cached_x509_store(const struct Curl_easy *data,
       free(mbackend->CAfile);
     }
 
+    mbackend->time = Curl_now();
     mbackend->store = store;
     mbackend->CAfile = CAfile;
   }
-- 
2.34.1

