Index: recipe/patches/binutils/ld.Makefile.am.p
===================================================================
--- recipe/patches/binutils/ld.Makefile.am.p	(revision 4957)
+++ recipe/patches/binutils/ld.Makefile.am.p	(working copy)
@@ -1,13 +1,13 @@
 --- ld/Makefile.am.orig	2010-11-03 04:22:01.000000000 +0100
 +++ ld/Makefile.am	2010-12-11 02:19:04.042493950 +0100
-@@ -147,6 +147,7 @@ ALL_EMULATION_SOURCES = \
- 	earmelfb_linux_eabi.c \
+@@ -144,6 +144,7 @@ ALL_EMULATION_SOURCES = \
+ 	earmelf_linux.c \
+ 	earmelf_linux_eabi.c \
  	earmelf_nbsd.c \
- 	earmelfb_nbsd.c \
 +	earmelf_riscos.c \
  	earmelf_vxworks.c \
- 	earmnto.c \
- 	earmnbsd.c \
+ 	earmelfb.c \
+ 	earmelfb_linux.c \
 @@ -653,6 +654,10 @@ earmelf_fbsd.c: $(srcdir)/emulparams/arm
    $(ELF_DEPS) $(srcdir)/emultempl/armelf.em \
    $(srcdir)/scripttempl/elf.sc ${GEN_DEPENDS}
