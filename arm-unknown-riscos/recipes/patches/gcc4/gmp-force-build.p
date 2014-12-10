--- Makefile.orig	2014-12-09 22:08:21.680152640 +0000
+++ Makefile	2014-12-10 00:21:11.194955257 +0000
@@ -163,7 +163,7 @@
 RONATIVE_CONFIG_ARGS := --host=$(TARGET) --target=$(TARGET) --prefix=$(PREFIX_RONATIVE)
 
 # Configure arguments GMP:
-CROSS_GMP_CONFIG_ARGS := --disable-shared --prefix=$(PREFIX_CROSSGCC_LIBS)
+CROSS_GMP_CONFIG_ARGS := --disable-shared --prefix=$(PREFIX_CROSSGCC_LIBS) --build=x86_64-linux
 RONATIVE_GMP_CONFIG_ARGS := --disable-shared --host=$(TARGET) --prefix=$(PREFIX_RONATIVEGCC_LIBS)
 ifeq "$(GCC_USE_PPL_CLOOG)" "yes"
 CROSS_GMP_CONFIG_ARGS += --enable-cxx
