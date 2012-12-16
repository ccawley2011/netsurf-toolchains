--- /dev/null	2012-12-14 09:53:07.266043019 +0000
+++ js/src/mozilla-js.pc.in	2012-12-16 18:37:54.000000000 +0000
@@ -0,0 +1,6 @@
+
+Name: JavaScript
+Description: The Mozilla JavaScript Library
+Version: 1.7.0
+Libs: -L${prefix}/lib -ljs
+Cflags: -I${prefix}/include -DXP_UNIX
