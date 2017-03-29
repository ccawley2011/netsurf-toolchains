--- crypto/rand/rand_unix.c	2017-01-26 13:22:03.000000000 +0000
+++ crypto/rand/rand_unix.c	2017-03-29 17:42:59.932017575 +0100
@@ -116,7 +116,7 @@
 #include <openssl/rand.h>
 #include "rand_lcl.h"
 
-#if !(defined(OPENSSL_SYS_WINDOWS) || defined(OPENSSL_SYS_WIN32) || defined(OPENSSL_SYS_VMS) || defined(OPENSSL_SYS_OS2) || defined(OPENSSL_SYS_VXWORKS) || defined(OPENSSL_SYS_NETWARE))
+#if !(defined(OPENSSL_SYS_WINDOWS) || defined(OPENSSL_SYS_WIN32) || defined(OPENSSL_SYS_VMS) || defined(OPENSSL_SYS_OS2) || defined(OPENSSL_SYS_VXWORKS) || defined(OPENSSL_SYS_NETWARE) || defined(OPENSSL_SYS_AMIGAOS4) || defined(OPENSSL_SYS_AMIGAOS3))
 
 # include <sys/types.h>
 # include <sys/time.h>
