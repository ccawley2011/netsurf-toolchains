--- srclib/getprogname.c	2019-04-26 19:29:00.000000000 +0100
+++ srclib/getprogname.c	2020-03-06 19:32:44.157018596 +0000
@@ -245,7 +245,7 @@ getprogname (void)
     }
   return NULL;
 # else
-#  error "getprogname module not ported to this OS"
+  const char *p = ""; /* this is never used for anything important */
 # endif
 }
 
