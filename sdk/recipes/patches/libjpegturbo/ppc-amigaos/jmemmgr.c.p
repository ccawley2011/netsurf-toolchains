--- jmemmgr.c.old	2016-10-05 22:58:26.559475774 +0000
+++ jmemmgr.c	2016-10-05 23:00:00.731473878 +0000
@@ -32,6 +32,7 @@
 #include "jinclude.h"
 #include "jpeglib.h"
 #include "jmemsys.h"            /* import the system-dependent declarations */
+#include <limits.h>
 #include <stdint.h>
 
 #ifndef NO_GETENV
