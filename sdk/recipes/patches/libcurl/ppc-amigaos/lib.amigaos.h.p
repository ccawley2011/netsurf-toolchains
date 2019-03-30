--- lib/amigaos.h	2019-03-25 08:42:50.000000000 +0000
+++ lib/amigaos.h	2019-03-30 12:49:50.744493740 +0000
@@ -23,7 +23,7 @@
  ***************************************************************************/
 #include "curl_setup.h"
 
-#if defined(__AMIGA__) && defined(HAVE_BSDSOCKET_H) && !defined(USE_AMISSL)
+#if 0
 
 bool Curl_amiga_init();
 void Curl_amiga_cleanup();
