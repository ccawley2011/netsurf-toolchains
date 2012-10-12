--- configvars	2012-10-11 16:56:15.000000000 +0100
+++ configvars	2012-10-11 16:57:32.000000000 +0100
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
