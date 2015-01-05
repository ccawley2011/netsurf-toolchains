--- ./tool_getpass.c	2014-06-11 18:52:29.000000000 +0100
+++ src/tool_getpass.c	2015-01-05 21:42:31.826011647 +0000
@@ -24,6 +24,10 @@
 #ifndef HAVE_GETPASS_R
 /* this file is only for systems without getpass_r() */
 
+#ifdef __AMIGA__
+#undef HAVE_TERMIOS_H
+#endif
+
 #ifdef HAVE_FCNTL_H
 #  include <fcntl.h>
 #endif
