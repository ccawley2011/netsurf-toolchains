--- lib/curl_setup.h	2019-03-30 13:44:08.576270700 +0000
+++ lib/curl_setup.h	2019-03-30 13:44:33.011975643 +0000
@@ -314,7 +314,8 @@
 #  include <exec/execbase.h>
 #  include <proto/exec.h>
 #  include <proto/dos.h>
-#  ifdef HAVE_PROTO_BSDSOCKET_H
+#  define HAVE_SELECT 1
+#  if 0
 #    include <proto/bsdsocket.h> /* ensure bsdsocket.library use */
 #    define select(a,b,c,d,e) WaitSelect(a,b,c,d,e,0)
 #  endif
