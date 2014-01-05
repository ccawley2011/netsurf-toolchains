--- js/src/jslibmath.h	2006-07-13 07:01:04 
+++ js-amiga/src/jslibmath.h	2012-07-06 23:06:50 
@@ -58,6 +58,12 @@
  * - fdlibm broken on OSF1/alpha
  */
 
+
+#if defined(XP_AMIGA)
+#define JS_USE_FDLIBM_MATH 1
+#endif
+
+
 #ifndef JS_USE_FDLIBM_MATH
 #define JS_USE_FDLIBM_MATH 0
 #endif

