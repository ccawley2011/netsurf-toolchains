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
