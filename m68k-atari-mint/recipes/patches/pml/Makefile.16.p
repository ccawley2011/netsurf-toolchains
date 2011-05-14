--- pmlsrc/Makefile.16	2011-05-13 23:26:37.000000000 +0100
+++ pmlsrc/Makefile.16	2011-05-13 23:28:32.000000000 +0100
@@ -15,15 +15,23 @@
 #	they will be loaded into the library archive.  Although
 #	some machines support randomly ordered libraries, ordering
 #	them correctly doesn't hurt...
-CROSSDIR = /dsrg/bammi/cross-minix
+CROSSDIR = /opt/netsurf/m68k-atari-mint/cross/m68k-atari-mint
 CROSSLIB = $(CROSSDIR)/lib
 CROSSBIN = $(CROSSDIR)/bin
 CROSSINC = $(CROSSDIR)/include
 
-AR = /dsrg/bammi/cross-gcc/bin/car
-CC = $(CROSSBIN)/mgcc
+AR = m68k-atari-mint-ar
+CC = m68k-atari-mint-gcc
 CFLAGS = -mshort -O2 -fomit-frame-pointer -DIEEE -DNO_DBUG -I.
 
+ifeq ($(SUBTARGET),m68020-60)
+CFLAGS += -m68020-60
+endif
+
+ifeq ($(SUBTARGET),m5475)
+CFLAGS += -mcpu=5475
+endif
+
 LIB = $(CROSSLIB)
 
 INC = $(CROSSINC)
