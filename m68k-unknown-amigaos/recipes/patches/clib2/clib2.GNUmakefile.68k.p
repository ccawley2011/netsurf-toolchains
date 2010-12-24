--- GNUmakefile.68k	20 Oct 2010 13:50:16 -0000	1.107
+++ GNUmakefile.68k	24 Dec 2010 05:30:31 -0000
@@ -24,9 +24,9 @@
 
 # override certain things for non-native builds
 ifneq ($(HOST), AmigaOS)
-   CC = m68k-amigaos-gcc
-   AR = m68k-amigaos-ar -q
-   RANLIB = m68k-amigaos-ranlib
+   CC = m68k-unknown-amigaos-gcc
+   AR = m68k-unknown-amigaos-ar -q
+   RANLIB = m68k-unknown-amigaos-ranlib
    COPY = cp
    DELETE = rm -rf
    MAKEDIR = mkdir -p
@@ -530,6 +530,7 @@
 	stdlib_realloc.o \
 	stdlib_resetmemstats.o \
 	stdlib_system.o \
+	stubs.o \
 	systeminfo_sysinfo.o \
 	termios_cfgetispeed.o \
 	termios_cfgetospeed.o \
@@ -979,10 +980,10 @@
 	lib/n32bcrt0.o \
 	lib/n32rcrt0.o \
 	lib/libm020/libm.a \
-	lib/libm.a \
-	lib/libb/libm.a \
-	lib/libb/libm020/libm.a \
-	lib/libb32/libm020/libm.a
+	lib/libm.a
+#	lib/libb/libm.a \
+#	lib/libb/libm020/libm.a \
+#	lib/libb32/libm020/libm.a
 
 ##############################################################################
 
