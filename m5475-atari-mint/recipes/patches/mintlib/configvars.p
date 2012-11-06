--- ./configvars.orig	2012-05-03 19:26:10.000000000 +0200
+++ ./configvars	2012-11-05 23:03:52.000000000 +0100
@@ -12,14 +12,14 @@
 # get installed.  You have to take car yourself that the libraries
 # and include files and so on will get installed in the right place
 # The easiest way to do this is to change "prefix", see below.
-#CROSS=yes
+CROSS=yes
 
 # Silent build or verbose
 AM_DEFAULT_VERBOSITY = 1
 
 # Define this to "m68k-atari-mint-" if you cross compile.
 ifeq ($(CROSS),yes)
- toolprefix=m68k-atari-mint-
+ toolprefix=m5475-atari-mint-
 else
  toolprefix=
 endif
@@ -47,7 +47,7 @@
 # need be.  When cross-compiling you will usually want to set this
 # to "/usr/m68k-atari-mint".
 ifeq ($(CROSS),yes)
- prefix=/usr/m68k-atari-mint
+ prefix=/opt/netsurf/m5475-atari-mint/cross/m5475-atari-mint
 else
  prefix=/usr
 endif
@@ -124,7 +124,7 @@
 CFLAGS=-O2 -fomit-frame-pointer
 
 # Additional defines.
-DEFS=
+DEFS=-DREGEX_MALLOC
 
 # Define this to the warning level you want.
 WARN=-Wall
