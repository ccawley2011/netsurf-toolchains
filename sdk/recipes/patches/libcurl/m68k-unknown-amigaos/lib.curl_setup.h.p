--- lib/curl_setup.h	2014-08-25 22:45:11.000000000 +0100
+++ lib/curl_setup.h	2014-12-20 21:35:26.494012868 +0000
@@ -311,7 +311,6 @@
 #    include <exec/execbase.h>
 #    include <proto/exec.h>
 #    include <proto/dos.h>
-#    define select(a,b,c,d,e) WaitSelect(a,b,c,d,e,0)
 #  endif
 #endif
 
