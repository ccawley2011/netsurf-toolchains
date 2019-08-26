--- configure.ac.orig	2019-07-04 20:32:37.000000000 +0100
+++ configure.ac	2019-08-26 01:10:45.539132422 +0100
@@ -485,7 +485,7 @@
                  libpng12-config])
   if test -n "$LIBPNG_CONFIG"; then
     PNG_INCLUDES=`$LIBPNG_CONFIG --cflags`
-    PNG_LIBS="`$LIBPNG_CONFIG --ldflags`"
+    PNG_LIBS="`$LIBPNG_CONFIG --static --ldflags`"
   fi
 
   WITHLIB_OPTION([png], [PNG])
