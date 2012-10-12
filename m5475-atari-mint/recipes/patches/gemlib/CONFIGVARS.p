--- CONFIGVARS.orig	2012-10-11 17:55:52.000000000 +0100
+++ CONFIGVARS	2012-10-11 17:56:37.000000000 +0100
@@ -1,8 +1,8 @@
 # 
 # 
 # cross compiling
-#CROSS = yes
-CROSS = no
+CROSS = yes
+#CROSS = no
 
 #
 # build alternate libraries for processor variants
@@ -15,13 +15,13 @@
 # 
 ifeq ($(CROSS),yes)
 
-CROSSPREFIX=m68k-atari-mint-
+CROSSPREFIX=m5475-atari-mint-
 
 NATIVECC = gcc
 NATIVECFLAGS = -O
 CRLF = echo crlf -s
 
-PREFIX=/usr/m68k-atari-mint
+PREFIX=/opt/netsurf/m5475-atari-mint/cross/m5475-atari-mint
 
 else
 
