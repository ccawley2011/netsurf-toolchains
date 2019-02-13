--- crypto/mem_sec.c.orig	2019-02-13 14:25:17.725058588 +0000
+++ crypto/mem_sec.c	2019-02-13 14:35:39.790029062 +0000
@@ -25,7 +25,11 @@
 #include <string.h>
 
 /* e_os.h includes unistd.h, which defines _POSIX_VERSION */
-#if !defined(OPENSSL_NO_SECURE_MEMORY) && defined(OPENSSL_SYS_UNIX) \
+#if !defined(OPENSSL_NO_SECURE_MEMORY) \
+    && !defined(OPENSSL_SYS_RISCOS) \
+    && !defined(OPENSSL_SYS_AMIGAOS3) \
+    && !defined(OPENSSL_SYS_AMIGAOS4) \
+    && defined(OPENSSL_SYS_UNIX)					\
     && ( (defined(_POSIX_VERSION) && _POSIX_VERSION >= 200112L) \
          || defined(__sun) || defined(__hpux) || defined(__sgi) \
          || defined(__osf__) )
