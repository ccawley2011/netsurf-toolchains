--- lib/setup.h.old	2012-10-19 21:58:12.000000000 +0100
+++ lib/setup.h	2012-10-19 21:59:17.000000000 +0100
@@ -312,11 +312,15 @@
 
 #ifdef __AMIGA__
 #  ifndef __ixemul__
-#    include <exec/types.h>
-#    include <exec/execbase.h>
-#    include <proto/exec.h>
-#    include <proto/dos.h>
-#    define select(a,b,c,d,e) WaitSelect(a,b,c,d,e,0)
+#    ifdef __amigaos4__
+#      include <unistd.h>
+#    else
+#      include <exec/types.h>
+#      include <exec/execbase.h>
+#      include <proto/exec.h>
+#      include <proto/dos.h>
+#      define select(a,b,c,d,e) WaitSelect(a,b,c,d,e,0)
+#    endif
 #  endif
 #endif
 
