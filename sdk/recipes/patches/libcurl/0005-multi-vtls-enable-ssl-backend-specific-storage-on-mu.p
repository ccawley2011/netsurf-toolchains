diff --git a/lib/multi.c b/lib/multi.c
index 51acba73a..09965de83 100644
--- lib/multi.c
+++ lib/multi.c
@@ -2770,6 +2770,11 @@ CURLMcode curl_multi_cleanup(struct Curl_multi *multi)
     wakeup_close(multi->wakeup_pair[1]);
 #endif
 #endif
+
+#ifdef USE_SSL
+    Curl_free_multi_ssl_backend_data(multi->ssl_backend_data);
+#endif
+
     free(multi);
 
     return CURLM_OK;
diff --git a/lib/multihandle.h b/lib/multihandle.h
index a997784ea..5a83656d5 100644
--- lib/multihandle.h
+++ lib/multihandle.h
@@ -79,6 +79,10 @@ typedef enum {
 /* value for MAXIMUM CONCURRENT STREAMS upper limit */
 #define INITIAL_MAX_CONCURRENT_STREAMS ((1U << 31) - 1)
 
+/* Curl_multi SSL backend-specific data; declared differently by each SSL
+   backend */
+struct multi_ssl_backend_data;
+
 /* This is the struct known as CURLM on the outside */
 struct Curl_multi {
   /* First a simple identifier to easier detect if a user mix up
@@ -118,6 +122,10 @@ struct Curl_multi {
      times of all currently set timers */
   struct Curl_tree *timetree;
 
+#if defined(USE_SSL)
+  struct multi_ssl_backend_data *ssl_backend_data;
+#endif
+
   /* 'sockhash' is the lookup hash for socket descriptor => easy handles (note
      the pluralis form, there can be more than one easy handle waiting on the
      same actual socket) */
diff --git a/lib/vtls/bearssl.c b/lib/vtls/bearssl.c
index 1221ce8c8..e66dd8469 100644
--- lib/vtls/bearssl.c
+++ lib/vtls/bearssl.c
@@ -1208,7 +1208,8 @@ const struct Curl_ssl Curl_ssl_bearssl = {
   Curl_none_false_start,           /* false_start */
   bearssl_sha256sum,               /* sha256sum */
   NULL,                            /* associate_connection */
-  NULL                             /* disassociate_connection */
+  NULL,                            /* disassociate_connection */
+  NULL                             /* free_multi_ssl_backend_data */
 };
 
 #endif /* USE_BEARSSL */
diff --git a/lib/vtls/gskit.c b/lib/vtls/gskit.c
index 4ee4edea6..18bd47919 100644
--- lib/vtls/gskit.c
+++ lib/vtls/gskit.c
@@ -1323,7 +1323,8 @@ const struct Curl_ssl Curl_ssl_gskit = {
   Curl_none_false_start,          /* false_start */
   NULL,                           /* sha256sum */
   NULL,                           /* associate_connection */
-  NULL                            /* disassociate_connection */
+  NULL,                           /* disassociate_connection */
+  NULL                            /* free_multi_ssl_backend_data */
 };
 
 #endif /* USE_GSKIT */
diff --git a/lib/vtls/gtls.c b/lib/vtls/gtls.c
index cf3dbc523..68e3fe299 100644
--- lib/vtls/gtls.c
+++ lib/vtls/gtls.c
@@ -1699,7 +1699,8 @@ const struct Curl_ssl Curl_ssl_gnutls = {
   Curl_none_false_start,         /* false_start */
   gtls_sha256sum,                /* sha256sum */
   NULL,                          /* associate_connection */
-  NULL                           /* disassociate_connection */
+  NULL,                          /* disassociate_connection */
+  NULL                           /* free_multi_ssl_backend_data */
 };
 
 #endif /* USE_GNUTLS */
diff --git a/lib/vtls/mbedtls.c b/lib/vtls/mbedtls.c
index fbde8976e..a5250289d 100644
--- lib/vtls/mbedtls.c
+++ lib/vtls/mbedtls.c
@@ -1267,7 +1267,8 @@ const struct Curl_ssl Curl_ssl_mbedtls = {
   Curl_none_false_start,            /* false_start */
   mbedtls_sha256sum,                /* sha256sum */
   NULL,                             /* associate_connection */
-  NULL                              /* disassociate_connection */
+  NULL,                             /* disassociate_connection */
+  NULL                              /* free_multi_ssl_backend_data */
 };
 
 #endif /* USE_MBEDTLS */
diff --git a/lib/vtls/nss.c b/lib/vtls/nss.c
index b08808c43..55d777d69 100644
--- lib/vtls/nss.c
+++ lib/vtls/nss.c
@@ -2530,7 +2530,8 @@ const struct Curl_ssl Curl_ssl_nss = {
   nss_false_start,              /* false_start */
   nss_sha256sum,                /* sha256sum */
   NULL,                         /* associate_connection */
-  NULL                          /* disassociate_connection */
+  NULL,                         /* disassociate_connection */
+  NULL                          /* free_multi_ssl_backend_data */
 };
 
 #endif /* USE_NSS */
diff --git a/lib/vtls/openssl.c b/lib/vtls/openssl.c
index d80f79921..b536b42da 100644
--- lib/vtls/openssl.c
+++ lib/vtls/openssl.c
@@ -4619,7 +4619,8 @@ const struct Curl_ssl Curl_ssl_openssl = {
   NULL,                     /* sha256sum */
 #endif
   ossl_associate_connection, /* associate_connection */
-  ossl_disassociate_connection /* disassociate_connection */
+  ossl_disassociate_connection, /* disassociate_connection */
+  NULL                      /* free_multi_ssl_backend_data */
 };
 
 #endif /* USE_OPENSSL */
diff --git a/lib/vtls/rustls.c b/lib/vtls/rustls.c
index 77a49f1ab..45433bb85 100644
--- lib/vtls/rustls.c
+++ lib/vtls/rustls.c
@@ -630,7 +630,8 @@ const struct Curl_ssl Curl_ssl_rustls = {
   Curl_none_false_start,           /* false_start */
   NULL,                            /* sha256sum */
   NULL,                            /* associate_connection */
-  NULL                             /* disassociate_connection */
+  NULL,                            /* disassociate_connection */
+  NULL                             /* free_multi_ssl_backend_data */
 };
 
 #endif /* USE_RUSTLS */
diff --git a/lib/vtls/schannel.c b/lib/vtls/schannel.c
index fcfb9c6df..1e6a93106 100644
--- lib/vtls/schannel.c
+++ lib/vtls/schannel.c
@@ -2809,7 +2809,8 @@ const struct Curl_ssl Curl_ssl_schannel = {
   Curl_none_false_start,             /* false_start */
   schannel_sha256sum,                /* sha256sum */
   NULL,                              /* associate_connection */
-  NULL                               /* disassociate_connection */
+  NULL,                              /* disassociate_connection */
+  NULL                               /* free_multi_ssl_backend_data */
 };
 
 #endif /* USE_SCHANNEL */
diff --git a/lib/vtls/sectransp.c b/lib/vtls/sectransp.c
index d44f14ba6..d27adedca 100644
--- lib/vtls/sectransp.c
+++ lib/vtls/sectransp.c
@@ -3531,7 +3531,8 @@ const struct Curl_ssl Curl_ssl_sectransp = {
   sectransp_false_start,              /* false_start */
   sectransp_sha256sum,                /* sha256sum */
   NULL,                               /* associate_connection */
-  NULL                                /* disassociate_connection */
+  NULL,                               /* disassociate_connection */
+  NULL                                /* free_multi_ssl_backend_data */
 };
 
 #ifdef __clang__
diff --git a/lib/vtls/vtls.c b/lib/vtls/vtls.c
index 9dee5aa3b..8a251b270 100644
--- lib/vtls/vtls.c
+++ lib/vtls/vtls.c
@@ -655,6 +655,12 @@ void Curl_ssl_detach_conn(struct Curl_easy *data,
   }
 }
 
+void Curl_free_multi_ssl_backend_data(struct multi_ssl_backend_data *mbackend)
+{
+  if(Curl_ssl->free_multi_ssl_backend_data && mbackend)
+    Curl_ssl->free_multi_ssl_backend_data(mbackend);
+}
+
 void Curl_ssl_close_all(struct Curl_easy *data)
 {
   /* kill the session ID cache if not shared */
@@ -1310,7 +1316,8 @@ static const struct Curl_ssl Curl_ssl_multi = {
   Curl_none_false_start,             /* false_start */
   NULL,                              /* sha256sum */
   NULL,                              /* associate_connection */
-  NULL                               /* disassociate_connection */
+  NULL,                              /* disassociate_connection */
+  NULL                               /* free_multi_ssl_backend_data */
 };
 
 const struct Curl_ssl *Curl_ssl =
diff --git a/lib/vtls/vtls.h b/lib/vtls/vtls.h
index 50c53b3fb..1ab90c09e 100644
--- lib/vtls/vtls.h
+++ lib/vtls/vtls.h
@@ -47,6 +47,10 @@ struct ssl_connect_data;
 #define VTLS_INFOF_ALPN_ACCEPTED_LEN_1STR       \
   ALPN_ACCEPTED "%.*s"
 
+/* Curl_multi SSL backend-specific data; declared differently by each SSL
+   backend */
+struct multi_ssl_backend_data;
+
 struct Curl_ssl {
   /*
    * This *must* be the first entry to allow returning the list of available
@@ -102,6 +106,8 @@ struct Curl_ssl {
                                struct connectdata *conn,
                                int sockindex);
   void (*disassociate_connection)(struct Curl_easy *data, int sockindex);
+
+  void (*free_multi_ssl_backend_data)(struct multi_ssl_backend_data *mbackend);
 };
 
 #ifdef USE_SSL
@@ -311,6 +317,8 @@ void Curl_ssl_associate_conn(struct Curl_easy *data,
 void Curl_ssl_detach_conn(struct Curl_easy *data,
                           struct connectdata *conn);
 
+void Curl_free_multi_ssl_backend_data(struct multi_ssl_backend_data *mbackend);
+
 #define SSL_SHUTDOWN_TIMEOUT 10000 /* ms */
 
 #else /* if not USE_SSL */
diff --git a/lib/vtls/wolfssl.c b/lib/vtls/wolfssl.c
index 594c39a32..bc2a3c03f 100644
--- lib/vtls/wolfssl.c
+++ lib/vtls/wolfssl.c
@@ -1241,7 +1241,8 @@ const struct Curl_ssl Curl_ssl_wolfssl = {
   Curl_none_false_start,           /* false_start */
   wolfssl_sha256sum,               /* sha256sum */
   NULL,                            /* associate_connection */
-  NULL                             /* disassociate_connection */
+  NULL,                            /* disassociate_connection */
+  NULL                             /* free_multi_ssl_backend_data */
 };
 
 #endif
-- 
2.34.1

