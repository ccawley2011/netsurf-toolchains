--- lib/amigaos.c.old	2012-10-19 21:37:45.000000000 +0100
+++ lib/amigaos.c	2012-10-19 21:38:09.000000000 +0100
@@ -22,7 +22,7 @@
 
 #include "setup.h"
 
-#if defined(__AMIGA__) && !defined(__ixemul__)
+#if defined(__AMIGA__) && !(defined(__ixemul__) || defined(__amigaos4__))
 
 #include <amitcp/socketbasetags.h>
 
