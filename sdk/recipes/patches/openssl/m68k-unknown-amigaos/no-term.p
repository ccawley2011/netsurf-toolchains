--- crypto/ui/ui_openssl.c.orig	2011-03-08 22:37:51.000000000 +0000
+++ crypto/ui/ui_openssl.c	2011-03-08 22:39:00.000000000 +0000
@@ -218,6 +218,12 @@
 
 #endif
 
+#if defined(OPENSSL_SYS_AMIGAOS3)
+#undef TERMIOS
+#undef TERMIO
+#undef SGTTY
+#endif
+
 #ifdef TERMIOS
 # include <termios.h>
 # define TTY_STRUCT             struct termios
@@ -266,7 +272,7 @@
 typedef int sig_atomic_t;
 #endif
 
-#if defined(OPENSSL_SYS_MACINTOSH_CLASSIC) || defined(MAC_OS_GUSI_SOURCE) || defined(OPENSSL_SYS_NETWARE)
+#if defined(OPENSSL_SYS_MACINTOSH_CLASSIC) || defined(MAC_OS_GUSI_SOURCE) || defined(OPENSSL_SYS_NETWARE) || defined(OPENSSL_SYS_AMIGAOS3)
 /*
  * This one needs work. As a matter of fact the code is unoperational
  * and this is only a trick to get it compiled.
