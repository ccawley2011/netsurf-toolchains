--- Makefile	(revision 6747)
+++ Makefile	(working copy)
@@ -73,7 +73,7 @@
 	--disable-libstdcxx-pch \
 	--disable-tls
 # FIXME: for Java support: --without-x --enable-libgcj
-BINUTILS_CONFIG_ARGS :=
+BINUTILS_CONFIG_ARGS := --enable-plugins
 GDB_CONFIG_ARGS :=
 else
 # Case arm-unknown-eabi target (use newlib):
