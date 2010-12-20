--- gcc/config.host	2010-12-20 02:28:16.000000000 +0000
+++ gcc/config.host	2010-12-20 02:31:32.000000000 +0000
@@ -264,4 +264,9 @@
     out_host_hook_obj=host-hpux.o
     host_xmake_file="${host_xmake_file} x-hpux"
     ;;
+  m68k-*-amigaos*)
+    host_xm_file="m68k/xm-amigaos.h"
+    host_xmake_file="m68k/x-amigaos"
+    out_host_hook_obj=host-amigaos.o
+    ;;
 esac
