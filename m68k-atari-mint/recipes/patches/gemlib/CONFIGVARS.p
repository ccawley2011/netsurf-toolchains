--- CONFIGVARS	2011-05-13 23:38:45.000000000 +0100
+++ CONFIGVARS	2011-05-13 23:40:11.000000000 +0100
@@ -2,13 +2,13 @@
 # 
 # cross compiling
 #CROSS = yes
-CROSS = no
+CROSS = yes
 
 #
 # build alternate libraries for processor variants
 #
-WITH_020_LIB = no
-WITH_V4E_LIB = no
+WITH_020_LIB = yes
+WITH_V4E_LIB = yes
 
 #
 # target and host compiler
@@ -21,7 +21,7 @@
 NATIVECFLAGS = -O
 CRLF = echo crlf -s
 
-PREFIX=/usr/m68k-atari-mint
+PREFIX=/opt/netsurf/m68k-atari-mint/cross/m68k-atari-mint
 
 else
 
