--- zconf.h.in.old	2011-01-02 21:25:38.000000000 +0000
+++ zconf.h.in	2011-01-02 21:26:07.000000000 +0000
@@ -370,7 +370,7 @@
  * both "#undef _LARGEFILE64_SOURCE" and "#define _LARGEFILE64_SOURCE 0" as
  * equivalently requesting no 64-bit operations
  */
-#if -_LARGEFILE64_SOURCE - -1 == 1
+#if defined(_LARGEFILE64_SOURCE) && -_LARGEFILE64_SOURCE - -1 == 1
 #  undef _LARGEFILE64_SOURCE
 #endif
 
