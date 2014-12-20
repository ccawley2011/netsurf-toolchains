--- lib/amigaos.h	2014-06-11 18:52:29.000000000 +0100
+++ lib/amigaos.h	2014-12-20 21:34:20.390013061 +0000
@@ -23,7 +23,7 @@
  ***************************************************************************/
 #include "curl_setup.h"
 
-#if defined(__AMIGA__) && !defined(__ixemul__)
+#if 0
 
 bool Curl_amiga_init();
 void Curl_amiga_cleanup();
