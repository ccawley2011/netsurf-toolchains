--- configvars	2011-05-13 22:50:17.000000000 +0100
+++ configvars	2011-05-13 22:57:13.000000000 +0100
@@ -12,7 +12,7 @@
 # get installed.  You have to take car yourself that the libraries
 # and include files and so on will get installed in the right place
 # The easiest way to do this is to change "prefix", see below.
-#CROSS=yes
+CROSS=yes
 
 # Define this to "m68k-atari-mint-" if you cross compile.
 ifeq ($(CROSS),yes)
@@ -44,7 +44,7 @@
 # need be.  When cross-compiling you will usually want to set this
 # to "/usr/m68k-atari-mint".
 ifeq ($(CROSS),yes)
- prefix=/usr/m68k-atari-mint
+ prefix=/opt/netsurf/m68k-atari-mint/cross/m68k-atari-mint
 else
  prefix=/usr
 endif
