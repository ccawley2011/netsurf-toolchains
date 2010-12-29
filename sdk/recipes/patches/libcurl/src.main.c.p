--- src/main.c.old	2010-12-29 16:18:04.000000000 +0000
+++ src/main.c	2010-12-29 16:17:51.000000000 +0000
@@ -64,6 +64,10 @@
 #endif
 #endif
 
+#ifdef __AMIGA__
+#include <proto/dos.h>
+#endif
+
 #include "version.h"
 
 #ifdef HAVE_IO_H /* typical win32 habit */
