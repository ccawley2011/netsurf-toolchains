--- jmorecfg.h	2016-07-10 00:36:02.965024562 +0100
+++ jmorecfg.h	2016-07-10 00:37:55.525024349 +0100
@@ -346,7 +346,7 @@ typedef int boolean;
  */
 
 #ifndef MULTIPLIER
-#define MULTIPLIER  int		/* type for fastest integer multiply */
+#define MULTIPLIER  short		/* type for fastest integer multiply */
 #endif
 
 
