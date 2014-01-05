--- js/src/jsosdep.h	2006-07-07 02:12:02 
+++ js-amiga/src/jsosdep.h	2012-07-06 21:18:43 
@@ -56,6 +56,11 @@
 #define JS_HAVE_LONG_LONG
 #endif
 
+#ifdef XP_AMIGA
+#undef JS_HAVE_LONG_LONG
+
+#include <stddef.h>
+#endif
 
 #ifdef XP_UNIX

