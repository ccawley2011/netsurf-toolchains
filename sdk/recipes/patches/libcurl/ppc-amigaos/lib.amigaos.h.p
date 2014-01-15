--- lib/amigaos.h.old	2012-10-19 21:36:23.000000000 +0100
+++ lib/amigaos.h	2012-10-19 21:37:26.000000000 +0100
@@ -23,7 +23,7 @@
  ***************************************************************************/
 #include "curl_setup.h"
 
-#if defined(__AMIGA__) && !defined(__ixemul__)
+#if defined(__AMIGA__) && !(defined(__ixemul__) || defined(__amigaos4__))
 
 bool Curl_amiga_init();
 void Curl_amiga_cleanup();
