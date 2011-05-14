--- src/lcms2_internal.h	2010-11-29 16:11:49.000000000 +0000
+++ src/lcms2_internal.h	2011-05-14 02:22:34.000000000 +0100
@@ -52,6 +52,10 @@
 #define sqrtf(x) (float)sqrt((float)x)
 #endif
 
+// MiNTLib omits sqrtf
+#ifdef __MINT__
+#define sqrtf(x) (float)sqrt((float)x)
+#endif
 
 // Alignment of ICC file format uses 4 bytes (cmsUInt32Number)
 #define _cmsSIZEOFLONGMINUS1    (sizeof(cmsUInt32Number)-1)
