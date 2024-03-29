--- gcc-3.4.6/gcc/config.gcc	2013-05-19 20:09:27.000000000 +0200
+++ gcc/config.gcc	2013-05-19 20:23:32.000000000 +0200
@@ -1466,6 +1466,14 @@
 	tm_defines="MOTOROLA USE_GAS"
 	extra_parts="crtbegin.o crtend.o"
 	;;
+m68k-*-amigaos*)
+	tmake_file=m68k/t-amigaos
+	tm_file="${tm_file} m68k/amigaos.h"
+	tm_p_file="${tm_p_file} m68k/amigaos-protos.h"
+	tm_defines="TARGET_AMIGAOS TARGET_DEFAULT=0" # 68000, no 68881, no bitfield ops
+	extra_objs=amigaos.o
+	gnu_ld=yes
+	;;
 mcore-*-elf)
 	tm_file="dbxelf.h elfos.h svr4.h ${tm_file} mcore/mcore-elf.h"
 	tmake_file=mcore/t-mcore
