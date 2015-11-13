--- gcc4/Makefile	(revision 6747)
+++ gcc4/Makefile	(working copy)
@@ -73,7 +73,7 @@
 	--disable-tls \
 	--enable-__cxa_atexit
 # FIXME: for Java support: --without-x --enable-libgcj
-BINUTILS_CONFIG_ARGS :=
+BINUTILS_CONFIG_ARGS := --enable-plugins
 GDB_CONFIG_ARGS :=
 else
 # Case arm-unknown-eabi target (use newlib):
