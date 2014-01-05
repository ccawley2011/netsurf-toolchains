--- js/src/jscpucfg.c	2007-06-29 20:30:27 
+++ js-amiga/src/jscpucfg.c	2012-07-06 23:27:54 
@@ -53,6 +53,10 @@
 
 /* Generate cpucfg.h */
 
+#ifdef XP_AMIGA
+#include <exec/types.h>
+#define INT64 ULONG
+#else
 #if defined(XP_WIN) || defined(XP_OS2)
 #ifdef WIN32
 #if defined(__GNUC__)
@@ -70,6 +74,7 @@
 #define INT64   long long
 #endif
 #endif
+#endif
 
 #endif /* CROSS_COMPILE */
 
