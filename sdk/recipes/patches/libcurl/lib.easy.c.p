--- lib/easy.c.old	2010-12-29 16:14:23.000000000 +0000
+++ lib/easy.c	2010-12-29 16:15:10.000000000 +0000
@@ -263,13 +263,6 @@
       return CURLE_FAILED_INIT;
     }
 
-#ifdef __AMIGA__
-  if(!amiga_init()) {
-    DEBUGF(fprintf(stderr, "Error: amiga_init failed\n"));
-    return CURLE_FAILED_INIT;
-  }
-#endif
-
 #ifdef NETWARE
   if(netware_init()) {
     DEBUGF(fprintf(stderr, "Warning: LONG namespace not available\n"));
@@ -358,10 +351,6 @@
   if(init_flags & CURL_GLOBAL_WIN32)
     win32_cleanup();
 
-#ifdef __AMIGA__
-  amiga_cleanup();
-#endif
-
 #if defined(USE_LIBSSH2) && defined(HAVE_LIBSSH2_EXIT)
   (void)libssh2_exit();
 #endif
