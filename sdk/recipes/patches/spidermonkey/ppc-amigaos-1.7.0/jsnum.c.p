--- js/src/jsnum.c	2007-04-06 20:53:22 
+++ js-amiga/src/jsnum.c	2012-07-06 21:14:25 
@@ -42,7 +42,7 @@
  * JS number type and wrapper class.
  */
 #include "jsstddef.h"
-#if defined(XP_WIN) || defined(XP_OS2)
+#if defined(XP_WIN) || defined(XP_OS2) || defined(XP_AMIGA)
 #include <float.h>
 #endif
 #include <locale.h>

