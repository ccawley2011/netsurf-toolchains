--- apps/speed.c.orig	2017-11-22 08:07:53.851790744 +0000
+++ apps/speed.c	2017-11-22 08:15:49.608768064 +0000
@@ -99,6 +99,12 @@
 #endif
 #include <openssl/modes.h>
 
+
+#if defined(OPENSSL_SYS_AMIGAOS3) || defined(OPENSSL_SYS_AMIGAOS4)
+# define HAVE_FORK 0
+# undef SIGALRM
+#endif
+
 #ifndef HAVE_FORK
 # if defined(OPENSSL_SYS_VMS) || defined(OPENSSL_SYS_WINDOWS) || defined(OPENSSL_SYS_VXWORKS)
 #  define HAVE_FORK 0
@@ -220,8 +226,10 @@
 static double Time_F(int s)
 {
     double ret = app_tminterval(s, usertime);
+    #ifdef SIGALRM
     if (s == STOP)
         alarm(0);
+    #endif
     return ret;
 }
 
