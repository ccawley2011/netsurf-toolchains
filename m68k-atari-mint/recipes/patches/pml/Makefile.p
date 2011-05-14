--- pmlsrc/Makefile	2011-05-13 23:20:51.000000000 +0100
+++ pmlsrc/Makefile	2011-05-13 23:25:52.000000000 +0100
@@ -1,9 +1,13 @@
-CROSSDIR = /dsrg/bammi/cross-minix
-CROSSLIB = $(CROSSDIR)/lib
+CROSSDIR = /opt/netsurf/m68k-atari-mint/cross/m68k-atari-mint
+CROSSLIB := $(CROSSDIR)/lib
 CROSSBIN = $(CROSSDIR)/bin
 CROSSINC = $(CROSSDIR)/include
 WITH_SHORT_LIBS = 0
 
+ifneq ($(SUBTARGET),)
+CROSSLIB := $(CROSSLIB)/$(SUBTARGET)
+endif
+
 ALL = libpml32.a
 
 ifeq ($(WITH_SHORT_LIBS), 1)
