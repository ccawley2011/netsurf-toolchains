--- js/src/js.c	2007-04-20 18:45:18 
+++ js-amiga/src/js.c	2012-07-06 21:15:11 
@@ -88,6 +88,10 @@
 #include <sys/wait.h>
 #endif
 
+#ifdef XP_AMIGA
+#include <fcntl.h>
+#endif
+
 #if defined(XP_WIN) || defined(XP_OS2)
 #include <io.h>     /* for isatty() */
 #endif

