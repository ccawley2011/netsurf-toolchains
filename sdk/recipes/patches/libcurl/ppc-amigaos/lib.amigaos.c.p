--- lib/amigaos.c.orig	2017-10-10 15:19:45.611896396 +0100
+++ lib/amigaos.c	2017-10-17 15:42:25.304921197 +0100
@@ -86,7 +86,9 @@
       ULONG enabled = 0;
 
       SocketBaseTags(SBTM_SETVAL(SBTC_CAN_SHARE_LIBRARY_BASES), TRUE,
+#ifdef SBTC_HAVE_GETHOSTADDR_R_API
                      SBTM_GETREF(SBTC_HAVE_GETHOSTADDR_R_API), (ULONG)&enabled,
+#endif
                      TAG_DONE);
 
       if(enabled) {
@@ -132,20 +134,6 @@
   struct SocketIFace *ISocket = __CurlISocket;
 
   if(SocketFeatures & HAVE_BSDSOCKET_GETHOSTBYNAME_R) {
-    LONG h_errnop = 0;
-    struct hostent *buf;
-
-    buf = calloc(1, CURL_HOSTENT_SIZE);
-    if(buf) {
-      h = gethostbyname_r((STRPTR)hostname, buf,
-                          (char *)buf + sizeof(struct hostent),
-                          CURL_HOSTENT_SIZE - sizeof(struct hostent),
-                          &h_errnop);
-      if(h) {
-        ai = Curl_he2ai(h, port);
-      }
-      free(buf);
-    }
   }
   else {
     #ifdef CURLRES_THREADED
