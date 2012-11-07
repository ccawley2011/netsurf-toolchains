--- src/H_Types.h.orig	2012-11-07 23:03:02.000000000 +0100
+++ src/H_Types.h	2012-11-07 23:05:47.000000000 +0100
@@ -16,7 +16,7 @@
 
 typedef int HermesHandle;
 
-#if (_MSC_VER>=1000) || defined(__VISUALC__)
+#if (defined(_MSC_VER) && (_MSC_VER>=1000)) || defined(__VISUALC__)
 
 typedef unsigned __int32 int32;
 typedef unsigned __int16 short16;
