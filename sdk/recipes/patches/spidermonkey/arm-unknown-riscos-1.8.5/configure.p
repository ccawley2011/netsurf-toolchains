--- js/src/configure	2011-03-31 20:08:36.000000000 +0100
+++ js/src/configure	2012-12-10 00:34:27.312881924 +0000
@@ -7779,6 +7785,10 @@
     HOST_NSPR_MDCPUCFG='\"md/_os2.cfg\"'
     ;;
 
+*-riscos*)
+    TARGET_NSPR_MDCPUCFG='\"md/_riscos.cfg\"'
+    ;;
+
 *-android*)
     cat >> confdefs.h <<\EOF
 #define NO_PW_GECOS 1
@@ -13341,6 +13341,16 @@
       { echo "configure: error: --with-cpu-arch=armv7 is not supported for non-ARM CPU architectures" 1>&2; exit 1; }
     ;;
   esac
+elif test "$MOZ_ARM_ARCH" = "armv3"; then
+  case "$target_cpu" in
+    arm*)
+      if test "$GNU_CC"; then
+        CFLAGS="$CFLAGS -march=armv3 -mno-thumb-interwork -msoft-float"
+        CXXFLAGS="$CXXFLAGS -march=armv3 -mno-thumb-interwork -msoft-float"
+        ASFLAGS="$ASFLAGS -march=armv3 -mno-thumb-interwork -msoft-float"
+      fi
+      ;;
+  esac
 else
   case "$target_cpu" in
     arm*)
