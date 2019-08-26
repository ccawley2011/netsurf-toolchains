--- configure.orig	2019-07-04 20:43:58.000000000 +0100
+++ configure	2019-08-26 01:11:13.365038420 +0100
@@ -14312,7 +14312,7 @@
 
   if test -n "$LIBPNG_CONFIG"; then
     PNG_INCLUDES=`$LIBPNG_CONFIG --cflags`
-    PNG_LIBS="`$LIBPNG_CONFIG --ldflags`"
+    PNG_LIBS="`$LIBPNG_CONFIG --static --ldflags`"
   fi
 
 
