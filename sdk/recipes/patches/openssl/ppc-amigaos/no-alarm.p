--- apps/speed.c.orig	2011-03-08 22:44:56.000000000 +0000
+++ apps/speed.c	2011-03-08 22:48:10.000000000 +0000
@@ -223,6 +223,10 @@
 #define NO_FORK
 #endif
 
+#ifdef OPENSSL_SYS_AMIGAOS4
+#undef SIGALRM
+#endif
+
 #undef BUFSIZE
 #define BUFSIZE	((long)1024*8+1)
 int run=0;
