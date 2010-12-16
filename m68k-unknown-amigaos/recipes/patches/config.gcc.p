--- gcc/config.gcc	2010-12-16 13:06:35.000000000 +0000
+++ gcc/config.gcc	2010-12-16 13:09:52.000000000 +0000
@@ -1671,6 +1671,14 @@
 	tm_defines="${tm_defines} MOTOROLA=1"
 	extra_parts="crtbegin.o crtend.o"
 	;;
+m68k-*-amigaos*)
+	tmake_file="m68k/t-amigaos"
+	tm_file="${tm_file} m68k/amigaos.h"
+	tm_p_file="${tm_p_file} m68k/amigaos-protos.h"
+	tm_defines="${tm_defines} TARGET_AMIGAOS TARGET_DEFAULT=0"
+	extra_objs="amigaos.o"
+	gnu_ld=yes
+	;;
 mcore-*-elf)
 	tm_file="dbxelf.h elfos.h svr4.h newlib-stdint.h ${tm_file} mcore/mcore-elf.h"
 	tmake_file=mcore/t-mcore
