From 1678a95339b8893195b307a953a0053ceeca0133 Mon Sep 17 00:00:00 2001
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Sat, 14 Feb 2015 14:54:44 +0100
Subject: [PATCH 1/7] Changes for various Amiga targets.

---
 bfd/ChangeLog-9697                                |   64 +
 bfd/ChangeLog-9899                                |    5 +
 bfd/Makefile.am                                   |   18 +-
 bfd/Makefile.in                                   |   24 +-
 bfd/amigaos.c                                     | 3189 +++++++++
 bfd/amigaoslink.c                                 | 1032 +++
 bfd/aout-amiga.c                                  |  152 +
 bfd/aoutx.h                                       |   26 +-
 bfd/bfd-in2.h                                     |   12 +
 bfd/bfd.c                                         |    1 +
 bfd/bfdio.c                                       |   25 +
 bfd/config.bfd                                    |   28 +-
 bfd/configure                                     |    5 +
 bfd/configure.host                                |    1 +
 bfd/configure.in                                  |    5 +
 bfd/doc/Makefile.am                               |   15 +-
 bfd/doc/Makefile.in                               |   15 +-
 bfd/doc/bfd.texinfo                               |    9 +-
 bfd/elf32-amiga.c                                 | 3844 +++++++++++
 bfd/{elf32-ppc.c => elf32-amigaos.c}              |  341 +-
 bfd/elf32-i386-amithlon.c                         |  198 +
 bfd/elf32-i386.c                                  |   17 +-
 bfd/elf32-morphos.c                               | 7137 +++++++++++++++++++++
 bfd/elf32-ppc.c                                   |    4 +
 bfd/hosts/amigaos.h                               |    5 +
 bfd/hosts/morphos.h                               |    5 +
 bfd/libamiga.h                                    |  187 +
 bfd/libbfd.h                                      |    8 +
 bfd/linker.c                                      |   26 +-
 bfd/reloc.c                                       |   19 +
 bfd/targets.c                                     |   11 +
 binutils/objcopy.c                                |   50 +-
 binutils/readelf.c                                |    5 +
 binutils/rename.c                                 |    4 +-
 config.sub                                        |   11 +-
 config/mh-amigaos                                 |   13 +
 config/mh-morphos                                 |   13 +
 configure                                         |    6 +
 configure.ac                                      |    6 +
 gas/ChangeLog-9697                                |   12 +
 gas/ChangeLog-9899                                |    4 +
 gas/Makefile.am                                   |    5 +-
 gas/Makefile.in                                   |   20 +-
 gas/as.c                                          |   14 +
 gas/config/m68k-parse.h                           |    3 +
 gas/config/m68k-parse.y                           |   10 +-
 gas/config/obj-amigahunk.c                        |  212 +
 gas/config/obj-amigahunk.h                        |   54 +
 gas/config/obj-elf.c                              |    4 +-
 gas/config/tc-i386.h                              |   15 +-
 gas/config/tc-m68k.c                              |  312 +-
 gas/config/tc-m68k.h                              |   15 +
 gas/config/tc-ppc.c                               |   36 +-
 gas/config/tc-sh.c                                |   28 +-
 gas/config/te-amiga.h                             |   24 +
 gas/config/te-amigaos.h                           |   14 +
 gas/config/{te-nbsd.h => te-amithlon.h}           |   16 +-
 gas/config/te-morphos.h                           |   14 +
 gas/configure                                     |   20 +
 gas/configure.in                                  |   18 +
 gas/configure.tgt                                 |    8 +-
 gas/read.c                                        |   21 +-
 gas/read.h                                        |    4 +
 gas/write.c                                       |   31 +-
 gas/write.h                                       |    4 +-
 gprof/Makefile.am                                 |    2 +-
 gprof/Makefile.in                                 |    2 +-
 gprof/configure                                   |   13 +
 gprof/configure.in                                |   11 +
 gprof/gconfig.in                                  |    4 -
 include/elf/amigaos.h                             |   27 +
 include/elf/ppc.h                                 |   12 +
 include/libiberty.h                               |    2 +-
 ld/ChangeLog-9197                                 |   15 +
 ld/ChangeLog-9899                                 |    5 +
 ld/Makefile.am                                    |   38 +
 ld/Makefile.in                                    |   46 +
 ld/configure.host                                 |    4 +
 ld/configure.tgt                                  |    9 +
 ld/emulparams/amiga.sh                            |    6 +
 ld/emulparams/amiga_bss.sh                        |    6 +
 ld/emulparams/amigaos.sh                          |   26 +
 ld/emulparams/amithlon.sh                         |   11 +
 ld/emulparams/morphos.sh                          |    6 +
 ld/emulparams/morphos_baserel.sh                  |    6 +
 ld/emulparams/ppcamiga.sh                         |    8 +
 ld/emulparams/ppcamiga_bss.sh                     |    8 +
 ld/emultempl/amiga.em                             |  288 +
 ld/emultempl/{elf32.em => amigaos.em}             |    0
 ld/emultempl/amithlon.em                          | 1698 +++++
 ld/emultempl/morphos.em                           | 1104 ++++
 ld/emultempl/ppc32elf.em                          |   12 +
 ld/ldctor.c                                       |   18 +-
 ld/ldfile.c                                       |   54 +-
 ld/ldfile.h                                       |    5 +
 ld/ldlang.c                                       |    7 +
 ld/ldlang.h                                       |    2 +
 ld/ldlex.c                                        |  127 +-
 ld/ldmain.c                                       |    7 +
 ld/scripttempl/amiga.sc                           |   49 +
 ld/scripttempl/amiga_bss.sc                       |   41 +
 ld/scripttempl/{elf64hppa.sc => amigaos.sc}       |  132 +-
 ld/scripttempl/{mep.sc => amithlon.sc}            |  145 +-
 ld/scripttempl/{elfi370.sc => morphos.sc}         |   57 +-
 ld/scripttempl/{elfi370.sc => morphos_baserel.sc} |  108 +-
 libiberty/config/mh-amigaos                       |   12 +
 libiberty/config/mh-morphos                       |   12 +
 libiberty/lrealpath.c                             |    6 +
 opcodes/m68k-dis.c                                |    2 +-
 109 files changed, 20966 insertions(+), 641 deletions(-)
 create mode 100644 bfd/amigaos.c
 create mode 100644 bfd/amigaoslink.c
 create mode 100644 bfd/aout-amiga.c
 create mode 100644 bfd/elf32-amiga.c
 copy bfd/{elf32-ppc.c => elf32-amigaos.c} (97%)
 create mode 100644 bfd/elf32-i386-amithlon.c
 create mode 100644 bfd/elf32-morphos.c
 create mode 100644 bfd/hosts/amigaos.h
 create mode 100644 bfd/hosts/morphos.h
 create mode 100644 bfd/libamiga.h
 create mode 100644 config/mh-amigaos
 create mode 100644 config/mh-morphos
 create mode 100644 gas/config/obj-amigahunk.c
 create mode 100644 gas/config/obj-amigahunk.h
 create mode 100644 gas/config/te-amiga.h
 create mode 100644 gas/config/te-amigaos.h
 copy gas/config/{te-nbsd.h => te-amithlon.h} (65%)
 create mode 100644 gas/config/te-morphos.h
 create mode 100644 include/elf/amigaos.h
 create mode 100644 ld/emulparams/amiga.sh
 create mode 100644 ld/emulparams/amiga_bss.sh
 create mode 100644 ld/emulparams/amigaos.sh
 create mode 100644 ld/emulparams/amithlon.sh
 create mode 100644 ld/emulparams/morphos.sh
 create mode 100644 ld/emulparams/morphos_baserel.sh
 create mode 100644 ld/emulparams/ppcamiga.sh
 create mode 100644 ld/emulparams/ppcamiga_bss.sh
 create mode 100644 ld/emultempl/amiga.em
 copy ld/emultempl/{elf32.em => amigaos.em} (100%)
 create mode 100644 ld/emultempl/amithlon.em
 create mode 100644 ld/emultempl/morphos.em
 create mode 100644 ld/scripttempl/amiga.sc
 create mode 100644 ld/scripttempl/amiga_bss.sc
 copy ld/scripttempl/{elf64hppa.sc => amigaos.sc} (88%)
 copy ld/scripttempl/{mep.sc => amithlon.sc} (76%)
 copy ld/scripttempl/{elfi370.sc => morphos.sc} (88%)
 copy ld/scripttempl/{elfi370.sc => morphos_baserel.sc} (69%)
 create mode 100644 libiberty/config/mh-amigaos
 create mode 100644 libiberty/config/mh-morphos

diff --git a/bfd/ChangeLog-9697 b/bfd/ChangeLog-9697
index e9a5c1d60a313aaf09d1a8add619022cfdf575fa..1c2bb3f3c91d32e8b95f8b0cf16b98c58cde454b 100644
--- bfd/ChangeLog-9697
+++ bfd/ChangeLog-9697
@@ -46,12 +46,19 @@ Mon Dec 22 13:20:57 1997  Ian Lance Taylor  <ian@cygnus.com>
 
 Mon Dec 22 13:04:33 1997  Joel Sherrill  <joel@oarcorp.com>
 
         * config.bfd (i[3456]86*-go32-rtems*): Fix to be the same as
 	i[3456]86-go32.
 
+Fri Dec 19 14:25:58 1997  Daniel Verite  <daniel@brainstorm.fr>
+
+	* amigaos.c (amiga_bfd_copy_private_section_data): Add return
+	value.
+	* amigaoslink.c (amiga_final_link): Update linker_mark fields for
+	input sections involved in the output.
+
 Thu Dec 18 16:01:25 1997  Doug Evans  <devans@canuck.cygnus.com>
 
 	* configure: Regenerate to get @SHELL@ substituted.
 
 Wed Dec 17 09:45:09 1997  Nick Clifton  <nickc@cygnus.com>
 
@@ -594,12 +601,22 @@ Tue Sep 23 19:03:13 1997  Ian Lance Taylor  <ian@cygnus.com>
 
 	* elf.c (map_sections_to_segments): Even if we are not demand
 	paged, don't put a loadable section after a nonloadable section.
 	(assign_file_positions_for_segments): Increment the file offset
 	for a section with contents, even if it is not loadable.
 
+Tue Sep 23 09:46:10 1997  Fred Fish  <fnf@ninemoons.com>
+
+	* amigaos.c (alloca): Only declare if not defined as macro.
+
+Mon Sep 22 10:15:30 1997  Fred Fish  <fnf@ninemoons.com>
+
+	* amigaos.c (sysdep.h): Relocate include to provided needed
+	<sys/types.h> file.
+	* amigaoslink.c (sysdep.h): Ditto, and remove <sys/types.h>.
+
 Sun Sep 21 11:03:24 1997  Nick Clifton  <nickc@cygnus.com>
 
 	* elf32-v850.c (v850_elf_final_link_relocate): Add return code
 	indicating that __ctbp could not be found.
 
 Thu Sep 18 15:04:57 1997  Nick Clifton  <nickc@cygnus.com>
@@ -764,12 +781,18 @@ Tue Aug 26 17:26:51 1997  Ian Lance Taylor  <ian@cygnus.com>
 	* doc/Makefile.am (MKDOC): Use EXEEXT_FOR_BUILD, not EXEEXT.
 	* aclocal.m4: Rebuild.
 	* configure: Rebuild.
 	* Makefile.in: Rebuild.
 	* doc/Makefile.in: Rebuild.
 
+Mon Aug 25 16:32:00 1997  Steffen Opel  <opel@rumms.uni-mannheim.de>
+
+	* Makefile.in (guide, install-guide, clean-guide, bfd.guide):
+	New targets for AmigaGuide documentation.
+	(install): Add install-info and install-guide.
+
 Mon Aug 25 16:14:34 1997  Christopher Provenzano  <proven@cygnus.com>
 
 	* configure: Rebuild with latest devo autoconf for NT support
 
 Mon Aug 25 16:11:04 1997  Nick Clifton  <nickc@cygnus.com>
 
@@ -3764,12 +3787,18 @@ Fri Aug 30 11:49:19 1996  Ian Lance Taylor  <ian@cygnus.com>
 	page before checking D_PAGED.
 
 	* ihex.c (ihex_scan): Removed unnecessary extbase variable.
 	(ihex_write_object_contents): Remove extbase; always use segbase
 	instead.
 
+Thu Aug 29 17:53:51 1996  Daniel Verite <daniel@brainstorm.eu.org>
+
+	* amigaos.c (amiga_get_section_contents): Handle sections that
+	are larger than their disksize.
+	(amiga_make_unique_section): Remove infinite loop.
+
 Thu Aug 29 16:52:17 1996  Michael Meissner  <meissner@tiktok.cygnus.com>
 
 	* configure.in (i[345]86-*-*): Recognize i686 for pentium pro.
 	* configure.host (i[345]86-*-*): Ditto.
 	* config.bfd (i[345]86-*-*): Ditto.
 	* configure: Regenerate.
@@ -3989,12 +4018,19 @@ Mon Aug  5 13:42:41 1996  Ian Lance Taylor  <ian@cygnus.com>
 	* elf.c (map_sections_to_segments): Rewrite tests for starting a
 	new segment to make them more comprehensible.  If the relationship
 	between the LMA and the VMA changed, start a new segment.  Don't
 	check dynsec when deciding whether to start a new segment for a
 	writeable section; -N will now handle this.
 
+Sun Aug  4 22:15:56 1996  Fred Fish  <fnf@ninemoons.com>
+
+	* amigaoslink.c (sys/types.h): Include before genlink.h to get
+	definition for size_t which is used in genlink.h.  This was not
+	getting defined during a cross compilation on alpha-dec-osf2.0 for
+	some reason.
+
 Thu Aug  1 22:43:08 1996  Jeffrey A Law  (law@cygnus.com)
 
 	* libhppa.h: Remove "esel" changes.  Not the right approach.
 	* som.c: Corresponding changes.
 	(som_bfd_derive_misc_symbol_info): Use ST_DATA for symbols
 	which don't have a SOM symbol type associated with them.
@@ -4085,12 +4121,17 @@ Mon Jul 22 15:30:30 1996  Ian Lance Taylor  <ian@cygnus.com>
 
 Fri Jul 19 18:15:51 1996  Ian Lance Taylor  <ian@cygnus.com>
 
 	* configure.in: Fix test for whether a compiler has a 64 bit
 	type.  From Jim Wilson <wilson@cygnus.com>.
 
+Thu Jul 18 16:58:11 1996  Daniel Verite <daniel@brainstorm.eu.org>
+
+	* amigaoslink.c (aout_perform_reloc): Fix baserel 16 bits relocs.
+	(my_add_to): Fix sign bug in extraction of 16 bits values.
+
 Thu Jul 18 15:39:10 1996  Ian Lance Taylor  <ian@cygnus.com>
 
 	* configure.host (mips-sgi-irix6*): New host.
 
 	* configure.in: Set and substitute VERSION, BFD_HOST_64BIT_LONG
 	(replacing HOST_64BITLONG), BFD_HOST_64_BIT_DEFINED,
@@ -4214,12 +4255,17 @@ Mon Jul  8 16:18:03 1996  Ian Lance Taylor  <ian@cygnus.com>
 	(mips_relhi_addr, mips_relhi_addend): Remove.
 	(mips_relhi_reloc): Maintain a list of unmatched RELHI relocs.
 	(mips_rello_reloc): Process mips_relhi_list.
 	(mips_relocate_section): Permit an arbitrary number of REFHI or
 	RELHI relocs before the associated REFLO or RELLO reloc.
 
+Sun Jul  7 12:15:39 1996  Kamil Iskra <iskra@student.uci.agh.edu.pl>
+
+	* amigaos.c (amiga_write_symbols): Fix Daniel's workaround for
+	outputting long symbol names.
+
 Fri Jul  5 19:27:49 1996  Ian Lance Taylor  <ian@cygnus.com>
 
 	* aout-target.h (MY(callback)): Set reloc_count fields.
 
 Thu Jul  4 12:00:37 1996  Ian Lance Taylor  <ian@cygnus.com>
 
@@ -4293,12 +4339,17 @@ Fri Jun 28 11:17:00 1996  Richard Henderson  <rth@tamu.edu>
 	(elf64_alpha_link_hash_newfunc): Initialize flags field.
 	(elf64_alpha_check_relocs): Record types of LITUSE entries that
 	are found for LITERAL relocs.
 	(elf64_alpha_adjust_dynamic_symbol): If a symbol has its address
 	taken, we cannot generate a .plt entry for the symbol.
 
+Thu Jun 27 17:35:32 1996 Daniel Verite <daniel@brainstorm.eu.org>
+
+	* amigaos.c (amiga_write_object_contents): Don't output symbols
+	which are not attached to any section, such as indirect symbols.
+
 Thu Jun 27 11:24:29 1996  Ian Lance Taylor  <ian@cygnus.com>
 
 	* configure.in: Add AC_ISC_POSIX, and check for setitimer and
 	sysconf functions (for gprof).
 	* configure, config.in: Rebuild.
 
@@ -4522,12 +4573,25 @@ Wed Jun 12 11:16:37 1996  Ian Lance Taylor  <ian@cygnus.com>
 Tue Jun 11 15:24:48 1996  Ian Lance Taylor  <ian@cygnus.com>
 
 	* xcofflink.c (xcoff_build_ldsyms): Set XCOFF_DEF_REGULAR for a
 	common symbol defined by the linker.  Don't export function code
 	even if export_defineds is set.
 
+Tue Jun 11 12:52:10 1996 Daniel Verite <daniel@brainstorm.eu.org>
+
+	* amigaoslink.c (mygeta4): Function removed.
+	(amiga_final_link): Search for ___a4_init symbol in the global hash
+	table and cache its value in the backend data.
+
+	* amigaos.c (write_longs): Return a boolean instead of the
+	number of longs written.
+	(write_section_contents): Split reloc hunks at 0xffff entries.
+	(amiga_write_symbols): Cut the names in hunk symbols at 124 characters
+	(workaround for an amigaos bug).
+	(amiga_handle_rest): Added a sanity check in reloc hunks parsing.
+
 Mon Jun 10 11:57:27 1996  Jeffrey A Law  (law@cygnus.com)
 
 	* coff-h8300.c (howto_table): Add new entries for R_BCC_INV
 	and R_JMP_DEL.
 	(rtype2howto): Handle R_BCC_INV and R_JMP_DEL.
 	(h8300_symbol_address_p): New function.
diff --git a/bfd/ChangeLog-9899 b/bfd/ChangeLog-9899
index 6d7f5cd616db22097b8238d8686f60484c9e6ee6..6e25901995a73646a13037d32c14563df20f74b3 100644
--- bfd/ChangeLog-9899
+++ bfd/ChangeLog-9899
@@ -5570,12 +5570,17 @@ Wed Jan 21 21:16:06 1998  Manfred Hollstein  <manfred@s-direktnet.de>
 	(GET_SCNDHR_NLNNO): Likewise.
 
 Mon Jan 19 12:49:52 1998  Ian Lance Taylor  <ian@cygnus.com>
 
 	* cpu-sh.c (arch_info_struct): Correct next field of sh3e.
 
+Sun Jan 18 10:39:52 1998  Daniel Verite <daniel@brainstorm.fr>
+
+	* amigaos.c (CAN_WRITE_OUTSYM): New macro.
+	(amiga_write_object_contents): Use CAN_WRITE_OUTSYM
+
 Wed Jan 14 17:23:27 1998  Nick Clifton  <nickc@cygnus.com>
 
 	* elf32-m32r.c: Add macros to handle NOP insertion.
 
 Wed Jan 14 16:15:22 1998  Richard Henderson  <rth@cygnus.com>
 
diff --git a/bfd/Makefile.am b/bfd/Makefile.am
index 9ab2aa947a0a96ba5a469652c579a4d181793646..c224a3cecc392df96a6bc20c8dc73eb81c677269 100644
--- bfd/Makefile.am
+++ bfd/Makefile.am
@@ -232,13 +232,16 @@ ALL_MACHINES_CFILES = \
 	cpu-z80.c \
 	cpu-z8k.c
 
 # The .o files needed by all of the 32 bit vectors that are configured into
 # target_vector in targets.c if configured with --enable-targets=all.
 BFD32_BACKENDS = \
+	amigaos.lo \
+	amigaoslink.lo \
 	aout-adobe.lo \
+	aout-amiga.lo \
 	aout-arm.lo \
 	aout-cris.lo \
 	aout-ns32k.lo \
 	aout-sparcle.lo \
 	aout-tic30.lo \
 	aout0.lo \
@@ -287,12 +290,13 @@ BFD32_BACKENDS = \
 	elf-strtab.lo \
 	elf-vxworks.lo \
 	elf.lo \
 	elf32-am33lin.lo \
 	elf32-arc.lo \
 	elf32-arm.lo \
+	elf32-amigaos.lo \
 	elf32-avr.lo \
 	elf32-bfin.lo \
 	elf32-cr16.lo \
 	elf32-cr16c.lo \
 	elf32-cris.lo \
 	elf32-crx.lo \
@@ -320,12 +324,13 @@ BFD32_BACKENDS = \
 	elf32-m68k.lo \
 	elf32-m88k.lo \
 	elf32-mcore.lo \
 	elf32-mep.lo \
 	elf32-microblaze.lo \
 	elf32-mips.lo \
+	elf32-morphos.lo \
 	elf32-moxie.lo \
 	elf32-msp430.lo \
 	elf32-mt.lo \
 	elf32-openrisc.lo \
 	elf32-or32.lo \
 	elf32-pj.lo \
@@ -420,13 +425,16 @@ BFD32_BACKENDS = \
 	xcofflink.lo \
 	xsym.lo \
 	xtensa-isa.lo \
 	xtensa-modules.lo
 
 BFD32_BACKENDS_CFILES = \
+	amigaos.c \
+	amigaoslink.c \
 	aout-adobe.c \
+	aout-amiga.c \
 	aout-arm.c \
 	aout-cris.c \
 	aout-ns32k.c \
 	aout-sparcle.c \
 	aout-tic30.c \
 	aout0.c \
@@ -475,12 +483,13 @@ BFD32_BACKENDS_CFILES = \
 	elf-strtab.c \
 	elf-vxworks.c \
 	elf.c \
 	elf32-am33lin.c \
 	elf32-arc.c \
 	elf32-arm.c \
+	elf32-amigaos.c \
 	elf32-avr.c \
 	elf32-bfin.c \
 	elf32-cr16.c \
 	elf32-cr16c.c \
 	elf32-cris.c \
 	elf32-crx.c \
@@ -508,12 +517,13 @@ BFD32_BACKENDS_CFILES = \
 	elf32-m68k.c \
 	elf32-m88k.c \
 	elf32-mcore.c \
 	elf32-mep.c \
 	elf32-microblaze.c \
 	elf32-mips.c \
+	elf32-morphos.c \
 	elf32-moxie.c \
 	elf32-msp430.c \
 	elf32-mt.c \
 	elf32-openrisc.c \
 	elf32-or32.c \
 	elf32-pj.c \
@@ -745,13 +755,13 @@ CFILES = $(SOURCE_CFILES) $(BUILD_CFILES)
 
 ## This is a list of all .h files which are in the source tree.
 SOURCE_HFILES = \
 	aout-target.h aoutf1.h aoutx.h coffcode.h coffswap.h ecoffswap.h \
 	elf-bfd.h elf-hppa.h elf32-hppa.h \
 	elf64-hppa.h elfcode.h elfcore.h \
-	freebsd.h genlink.h go32stub.h \
+	freebsd.h genlink.h go32stub.h libamiga.h \
 	libaout.h libbfd.h libcoff.h libecoff.h libhppa.h libieee.h \
 	libnlm.h liboasys.h libpei.h libxcoff.h mach-o.h \
 	netbsd.h nlm-target.h nlmcode.h nlmswap.h ns32k.h \
 	pef.h pef-traceback.h peicode.h som.h version.h \
 	vms.h xsym.h
 
@@ -1013,12 +1023,6 @@ coff-tic4x.lo: coff-tic4x.c
 @am__fastdepCC_TRUE@	$(LTCOMPILE) -MT $@ -MD -MP -MF $(DEPDIR)/$*.Tpo -c -o $@ $< $(NO_WERROR)
 @am__fastdepCC_TRUE@	$(am__mv) $(DEPDIR)/$*.Tpo $(DEPDIR)/$*.Plo
 @AMDEP_TRUE@@am__fastdepCC_FALSE@	source='$<' object='$@' libtool=yes @AMDEPBACKSLASH@
 @AMDEP_TRUE@@am__fastdepCC_FALSE@	DEPDIR=$(DEPDIR) $(CCDEPMODE) $(depcomp) @AMDEPBACKSLASH@
 @am__fastdepCC_FALSE@	$(LTCOMPILE) -c -o $@ $< $(NO_WERROR)
 
-coff-tic54x.lo: coff-tic54x.c
-@am__fastdepCC_TRUE@	$(LTCOMPILE) -MT $@ -MD -MP -MF $(DEPDIR)/$*.Tpo -c -o $@ $< $(NO_WERROR)
-@am__fastdepCC_TRUE@	$(am__mv) $(DEPDIR)/$*.Tpo $(DEPDIR)/$*.Plo
-@AMDEP_TRUE@@am__fastdepCC_FALSE@	source='$<' object='$@' libtool=yes @AMDEPBACKSLASH@
-@AMDEP_TRUE@@am__fastdepCC_FALSE@	DEPDIR=$(DEPDIR) $(CCDEPMODE) $(depcomp) @AMDEPBACKSLASH@
-@am__fastdepCC_FALSE@	$(LTCOMPILE) -c -o $@ $< $(NO_WERROR)
diff --git a/bfd/Makefile.in b/bfd/Makefile.in
index 99902757111d8011447cde1dda030e5a9c817ff2..bcdf435a15eb144bca66d8bfe04122a45e647446 100644
--- bfd/Makefile.in
+++ bfd/Makefile.in
@@ -532,13 +532,16 @@ ALL_MACHINES_CFILES = \
 	cpu-z8k.c
 
 
 # The .o files needed by all of the 32 bit vectors that are configured into
 # target_vector in targets.c if configured with --enable-targets=all.
 BFD32_BACKENDS = \
+	amigaos.lo \
+	amigaoslink.lo \
 	aout-adobe.lo \
+	aout-amiga.lo \
 	aout-arm.lo \
 	aout-cris.lo \
 	aout-ns32k.lo \
 	aout-sparcle.lo \
 	aout-tic30.lo \
 	aout0.lo \
@@ -587,12 +590,13 @@ BFD32_BACKENDS = \
 	elf-strtab.lo \
 	elf-vxworks.lo \
 	elf.lo \
 	elf32-am33lin.lo \
 	elf32-arc.lo \
 	elf32-arm.lo \
+	elf32-amigaos.lo \
 	elf32-avr.lo \
 	elf32-bfin.lo \
 	elf32-cr16.lo \
 	elf32-cr16c.lo \
 	elf32-cris.lo \
 	elf32-crx.lo \
@@ -620,12 +624,13 @@ BFD32_BACKENDS = \
 	elf32-m68k.lo \
 	elf32-m88k.lo \
 	elf32-mcore.lo \
 	elf32-mep.lo \
 	elf32-microblaze.lo \
 	elf32-mips.lo \
+	elf32-morphos.lo \
 	elf32-moxie.lo \
 	elf32-msp430.lo \
 	elf32-mt.lo \
 	elf32-openrisc.lo \
 	elf32-or32.lo \
 	elf32-pj.lo \
@@ -720,13 +725,16 @@ BFD32_BACKENDS = \
 	xcofflink.lo \
 	xsym.lo \
 	xtensa-isa.lo \
 	xtensa-modules.lo
 
 BFD32_BACKENDS_CFILES = \
+	amigaos.c \
+	amigaoslink.c \
 	aout-adobe.c \
+	aout-amiga.c \
 	aout-arm.c \
 	aout-cris.c \
 	aout-ns32k.c \
 	aout-sparcle.c \
 	aout-tic30.c \
 	aout0.c \
@@ -775,12 +783,13 @@ BFD32_BACKENDS_CFILES = \
 	elf-strtab.c \
 	elf-vxworks.c \
 	elf.c \
 	elf32-am33lin.c \
 	elf32-arc.c \
 	elf32-arm.c \
+	elf32-amigaos.c \
 	elf32-avr.c \
 	elf32-bfin.c \
 	elf32-cr16.c \
 	elf32-cr16c.c \
 	elf32-cris.c \
 	elf32-crx.c \
@@ -808,12 +817,13 @@ BFD32_BACKENDS_CFILES = \
 	elf32-m68k.c \
 	elf32-m88k.c \
 	elf32-mcore.c \
 	elf32-mep.c \
 	elf32-microblaze.c \
 	elf32-mips.c \
+	elf32-morphos.c \
 	elf32-moxie.c \
 	elf32-msp430.c \
 	elf32-mt.c \
 	elf32-openrisc.c \
 	elf32-or32.c \
 	elf32-pj.c \
@@ -1046,13 +1056,13 @@ BUILD_CFILES = \
 
 CFILES = $(SOURCE_CFILES) $(BUILD_CFILES)
 SOURCE_HFILES = \
 	aout-target.h aoutf1.h aoutx.h coffcode.h coffswap.h ecoffswap.h \
 	elf-bfd.h elf-hppa.h elf32-hppa.h \
 	elf64-hppa.h elfcode.h elfcore.h \
-	freebsd.h genlink.h go32stub.h \
+	freebsd.h genlink.h go32stub.h libamiga.h \
 	libaout.h libbfd.h libcoff.h libecoff.h libhppa.h libieee.h \
 	libnlm.h liboasys.h libpei.h libxcoff.h mach-o.h \
 	netbsd.h nlm-target.h nlmcode.h nlmswap.h ns32k.h \
 	pef.h pef-traceback.h peicode.h som.h version.h \
 	vms.h xsym.h
 
@@ -1215,13 +1225,16 @@ mostlyclean-compile:
 
 distclean-compile:
 	-rm -f *.tab.c
 
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/aix386-core.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/aix5ppc-core.Plo@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/amigaos.Plo@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/amigaoslink.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/aout-adobe.Plo@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/aout-amiga.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/aout-arm.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/aout-cris.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/aout-ns32k.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/aout-sparcle.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/aout-tic30.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/aout0.Plo@am__quote@
@@ -1365,12 +1378,13 @@ distclean-compile:
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf-m10300.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf-nacl.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf-strtab.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf-vxworks.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-am33lin.Plo@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-amigaos.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-arc.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-arm.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-avr.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-bfin.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-cr16.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-cr16c.Plo@am__quote@
@@ -1401,12 +1415,13 @@ distclean-compile:
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-m68k.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-m88k.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-mcore.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-mep.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-microblaze.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-mips.Plo@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-morphos.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-moxie.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-msp430.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-mt.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-openrisc.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-or32.Plo@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/elf32-pj.Plo@am__quote@
@@ -2065,16 +2080,9 @@ coff-tic4x.lo: coff-tic4x.c
 @am__fastdepCC_TRUE@	$(LTCOMPILE) -MT $@ -MD -MP -MF $(DEPDIR)/$*.Tpo -c -o $@ $< $(NO_WERROR)
 @am__fastdepCC_TRUE@	$(am__mv) $(DEPDIR)/$*.Tpo $(DEPDIR)/$*.Plo
 @AMDEP_TRUE@@am__fastdepCC_FALSE@	source='$<' object='$@' libtool=yes @AMDEPBACKSLASH@
 @AMDEP_TRUE@@am__fastdepCC_FALSE@	DEPDIR=$(DEPDIR) $(CCDEPMODE) $(depcomp) @AMDEPBACKSLASH@
 @am__fastdepCC_FALSE@	$(LTCOMPILE) -c -o $@ $< $(NO_WERROR)
 
-coff-tic54x.lo: coff-tic54x.c
-@am__fastdepCC_TRUE@	$(LTCOMPILE) -MT $@ -MD -MP -MF $(DEPDIR)/$*.Tpo -c -o $@ $< $(NO_WERROR)
-@am__fastdepCC_TRUE@	$(am__mv) $(DEPDIR)/$*.Tpo $(DEPDIR)/$*.Plo
-@AMDEP_TRUE@@am__fastdepCC_FALSE@	source='$<' object='$@' libtool=yes @AMDEPBACKSLASH@
-@AMDEP_TRUE@@am__fastdepCC_FALSE@	DEPDIR=$(DEPDIR) $(CCDEPMODE) $(depcomp) @AMDEPBACKSLASH@
-@am__fastdepCC_FALSE@	$(LTCOMPILE) -c -o $@ $< $(NO_WERROR)
-
 # Tell versions [3.59,3.63) of GNU make to not export all variables.
 # Otherwise a system limit (for SysV at least) may be exceeded.
 .NOEXPORT:
diff --git a/bfd/amigaos.c b/bfd/amigaos.c
new file mode 100644
index 0000000000000000000000000000000000000000..9d715d64d458e6599c19ed65fbb61c253d2ab208
--- /dev/null
+++ bfd/amigaos.c
@@ -0,0 +1,3189 @@
+/* BFD back-end for Commodore-Amiga AmigaOS binaries.
+   Copyright (C) 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998
+   Free Software Foundation, Inc.
+   Contributed by Leonard Norrgard.  Partially based on the bout
+   and ieee BFD backends and Markus Wild's tool hunk2gcc.
+   Revised and updated by Stephan Thesing.
+
+This file is part of BFD, the Binary File Descriptor library.
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */
+
+/*
+SECTION
+	amiga back end
+
+This section describes the overall structure of the Amiga BFD back end.
+The linker stuff can be found in @xref{amigalink}.
+@menu
+@* implementation::
+@* amigalink::
+@end menu
+
+INODE
+implementation, amigalink, amiga, amiga
+
+SECTION
+	implementation
+
+The need for a port of the bfd library for Amiga style object (hunk) files
+arose by the desire to port the GNU debugger gdb to the Amiga.
+Also, the linker ld should be updated to the current version (2.5.2).
+@@*
+This port bases on the work done by Leonard Norrgard, who started porting
+gdb. Raphael Luebbert, who supports the ixemul.library, has also worked on
+implementing the needed @code{ptrace()} system call and gas2.5.
+
+@menu
+@* not supported::
+@* Does it work?::
+@* TODO::
+@end menu
+
+INODE
+not supported, Does it work?, implementation, implementation
+
+SUBSECTION
+	not supported
+
+Currently, the implementation does not support Amiga link library files, like
+e.g. amiga.lib. This may be added in a later version, if anyone starts work
+on it, or I find some time for it.
+
+The handling of the symbols in hunk files is a little bit broken:
+	  o The symbols in a load file are totally ignored at the moment, so gdb and gprof
+	    do not work.
+	  o The symbols of a object module (Hunk file, starting with HUNK_UNIT) are read in
+	    correctly, but HUNK_SYMBOL hunks are also ignored.
+
+The reason for this is the following:
+Amiga symbol hunks do not allow for much information. Only a name and a value are allowed.
+On the other hand, a.out format carries along much more information (see, e.g. the
+entry on set symbols in the ld manual). The old linker copied this information into
+a HUNK_DEBUG hunk. Now there is the choice:
+	o ignoring the debug hunk, read in only HUNK_SYMBOL definitions => extra info is lost.
+	o read in the debug hunk and use the information therein => How can clashs between the
+	  information in the debug hunk and HUNK_SYMBOL or HUNK_EXT hunks be avoided?
+I haven't decided yet, what to do about this.
+
+Although bfd allows to link together object modules of different flavours,
+producing a.out style executables does not work on Amiga :-)
+It should, however, be possible to create a.out files with the -r option of ld
+(incremental link).
+
+INODE
+Does it work?, TODO, not supported, implementation
+
+SUBSECTION
+	Does it work?
+
+Currently, the following utilities work:
+	o objdump
+	o objcopy
+	o strip
+	o nm
+	o ar
+	o gas
+
+INODE
+TODO, , Does it work?, implementation
+
+SUBSECTION
+	TODO
+
+	o fix FIXME:s
+
+@*
+BFD:
+	o add flag to say if the format allows multiple sections with the
+	  same name. Fix bfd_get_section_by_name() and bfd_make_section()
+	  accordingly.
+
+	o dumpobj.c: the disassembler: use relocation record data to find symbolic
+	  names of addresses, when available.  Needs new routine where one can
+	  specify the source section of the symbol to be printed as well as some
+	  rewrite of the disassemble functions.
+*/
+
+#include "bfd.h"
+#include "sysdep.h"
+#include "libbfd.h"
+#include "libamiga.h"
+
+#define BYTES_IN_WORD 4
+#include "aout/aout64.h" /* struct external_nlist */
+
+#ifndef alloca
+extern PTR alloca PARAMS ((size_t));
+#endif
+
+#define bfd_is_bfd_section(sec) \
+  (bfd_is_abs_section(sec)||bfd_is_com_section(sec)||bfd_is_und_section(sec)||bfd_is_ind_section(sec))
+
+struct arch_syms {
+  unsigned long offset;		/* disk offset in the archive */
+  unsigned long size;		/* size of the block of symbols */
+  unsigned long unit_offset;	/* start of unit on disk */
+  struct arch_syms *next;	/* linked list */
+};
+
+typedef struct amiga_ardata_struct {
+  /* generic stuff */
+  struct artdata generic;
+  /* amiga-specific stuff */
+  unsigned long filesize;
+  struct arch_syms *defsyms;
+  unsigned long defsym_count;
+  unsigned long outnum;
+} amiga_ardata_type;
+
+#define amiga_ardata(bfd) (*(amiga_ardata_type **)(void *)&(bfd)->tdata.aout_ar_data)
+
+#define bfd_msg (*_bfd_error_handler)
+
+#define GL(x) bfd_get_32 (abfd, (bfd_byte *) (x))
+#define GW(x) bfd_get_16 (abfd, (bfd_byte *) (x))
+#define LONGSIZE(l) (((l)+3) >> 2)
+
+/* AmigaOS doesn't like HUNK_SYMBOL with symbol names longer than 124 characters */
+#define MAX_NAME_SIZE 124
+
+static bfd_boolean get_long PARAMS ((bfd *, unsigned long *));
+static const struct bfd_target *amiga_object_p PARAMS ((bfd *));
+static sec_ptr amiga_get_section_by_hunk_number PARAMS ((bfd *, long));
+static bfd_boolean amiga_add_reloc PARAMS ((bfd *, sec_ptr, bfd_size_type,
+	amiga_symbol_type *, reloc_howto_type *, long));
+static sec_ptr amiga_make_unique_section PARAMS ((bfd *, const char *));
+static bfd_boolean parse_archive_units PARAMS ((bfd *, int *, unsigned long,
+	bfd_boolean, struct arch_syms **, symindex *));
+static bfd_boolean amiga_digest_file PARAMS ((bfd *));
+static bfd_boolean amiga_read_unit PARAMS ((bfd *, unsigned long));
+static bfd_boolean amiga_read_load PARAMS ((bfd *));
+static bfd_boolean amiga_handle_cdb_hunk PARAMS ((bfd *, unsigned long,
+	unsigned long, unsigned long, unsigned long));
+static bfd_boolean amiga_handle_rest PARAMS ((bfd *, sec_ptr, bfd_boolean));
+static bfd_boolean amiga_mkobject PARAMS ((bfd *));
+static bfd_boolean amiga_mkarchive PARAMS ((bfd *));
+static bfd_boolean write_longs PARAMS ((const unsigned long *, unsigned long,
+	bfd *));
+static long determine_datadata_relocs PARAMS ((bfd *, sec_ptr));
+static void remove_section_index PARAMS ((sec_ptr, int *));
+static bfd_boolean amiga_write_object_contents PARAMS ((bfd *));
+static bfd_boolean write_name PARAMS ((bfd *, const char *, unsigned long));
+static bfd_boolean amiga_write_archive_contents PARAMS ((bfd *));
+static bfd_boolean amiga_write_armap PARAMS ((bfd *, unsigned int,
+	struct orl *, unsigned int, int));
+static int determine_type PARAMS ((arelent *));
+static bfd_boolean amiga_write_section_contents PARAMS ((bfd *, sec_ptr,
+	sec_ptr, unsigned long, int *, int));
+static bfd_boolean amiga_write_symbols PARAMS ((bfd *, sec_ptr));
+static bfd_boolean amiga_get_section_contents PARAMS ((bfd *, sec_ptr, PTR,
+	file_ptr, bfd_size_type));
+static bfd_boolean amiga_new_section_hook PARAMS ((bfd *, sec_ptr));
+static bfd_boolean amiga_slurp_symbol_table PARAMS ((bfd *));
+static long amiga_get_symtab_upper_bound PARAMS ((bfd *));
+static long amiga_get_symtab PARAMS ((bfd *, asymbol **));
+static asymbol *amiga_make_empty_symbol PARAMS ((bfd *));
+static void amiga_get_symbol_info PARAMS ((bfd *, asymbol *, symbol_info *));
+static void amiga_print_symbol PARAMS ((bfd *, PTR,   asymbol *,
+	bfd_print_symbol_type));
+static long amiga_get_reloc_upper_bound PARAMS ((bfd *, sec_ptr));
+static bfd_boolean read_raw_relocs PARAMS ((bfd *, sec_ptr, unsigned long,
+	unsigned long));
+static bfd_boolean amiga_slurp_relocs PARAMS ((bfd *, sec_ptr, asymbol **));
+static long amiga_canonicalize_reloc PARAMS ((bfd *, sec_ptr, arelent **,
+	asymbol **));
+static bfd_boolean amiga_set_section_contents PARAMS ((bfd *, sec_ptr, PTR,
+	file_ptr, bfd_size_type));
+static bfd_boolean amiga_set_arch_mach PARAMS ((bfd *, enum bfd_architecture,
+	unsigned long));
+static int amiga_sizeof_headers PARAMS ((bfd *, bfd_boolean));
+static bfd_boolean amiga_find_nearest_line PARAMS ((bfd *, sec_ptr,
+	asymbol **, bfd_vma, const char **, const char **, unsigned int *));
+static reloc_howto_type *amiga_bfd_reloc_type_lookup PARAMS ((bfd *,
+	bfd_reloc_code_real_type));
+static bfd_boolean amiga_bfd_copy_private_bfd_data PARAMS ((bfd *, bfd *));
+static bfd_boolean amiga_bfd_copy_private_section_data PARAMS ((bfd *,
+	sec_ptr, bfd *, sec_ptr));
+static bfd_boolean amiga_slurp_armap PARAMS ((bfd *));
+static void amiga_truncate_arname PARAMS ((bfd *, const char *, char *));
+static const struct bfd_target *amiga_archive_p PARAMS ((bfd *));
+static bfd *amiga_openr_next_archived_file PARAMS ((bfd *, bfd *));
+static PTR amiga_read_ar_hdr PARAMS ((bfd *));
+static int amiga_generic_stat_arch_elt PARAMS ((bfd *, struct stat *));
+
+/*#define DEBUG_AMIGA 1*/
+#if DEBUG_AMIGA
+#include <stdarg.h>
+static void
+error_print (const char *fmt, ...)
+{
+  va_list args;
+  va_start (args, fmt);
+  vfprintf (stderr, fmt, args);
+  va_end (args);
+}
+#define DPRINT(L,x) if (L>=DEBUG_AMIGA) error_print x
+#else
+#define DPRINT(L,x)
+#endif
+
+enum {R_ABS32=0,R_PC16,R_PC8,R_SD32,R_SD16,R_SD8,R_ABS32SHORT,R_PC26,R_PC32,R__MAX};
+static reloc_howto_type howto_table[R__MAX] =
+{
+  {H_ABS32,   /* type */
+  0,          /* rightshift */
+  2,          /* size */
+  32,         /* bitsize */
+  FALSE,      /* pc_relative */
+  0,          /* bitpos */
+  complain_overflow_bitfield,/* complain_on_overflow */
+  0,          /* special_function */
+  "RELOC32",  /* textual name */
+  FALSE,      /* partial_inplace */
+  0xffffffff, /* src_mask */
+  0xffffffff, /* dst_mask */
+  FALSE},     /* pcrel_offset */
+  {H_PC16,       0, 1, 16, TRUE,  0, complain_overflow_signed,   0, "RELRELOC16",   FALSE, 0x0000ffff, 0x0000ffff, TRUE},
+  {H_PC8,        0, 0,  8, TRUE,  0, complain_overflow_signed,   0, "RELRELOC8",    FALSE, 0x000000ff, 0x000000ff, TRUE},
+  {H_SD32,       0, 2, 32, FALSE, 0, complain_overflow_bitfield, 0, "DREL32",       FALSE, 0xffffffff, 0xffffffff, FALSE},
+  {H_SD16,       0, 1, 16, FALSE, 0, complain_overflow_bitfield, 0, "DREL16",       FALSE, 0x0000ffff, 0x0000ffff, FALSE},
+  {H_SD8,        0, 0,  8, FALSE, 0, complain_overflow_bitfield, 0, "DREL8",        FALSE, 0x000000ff, 0x000000ff, FALSE},
+  {H_ABS32SHORT, 0, 1, 16, FALSE, 0, complain_overflow_bitfield, 0, "RELOC32SHORT", FALSE, 0x0000ffff, 0x0000ffff, FALSE},
+  {H_PC26,       0, 2, 26, TRUE,  0, complain_overflow_signed,   0, "RELRELOC26",   FALSE, 0x03fffffc, 0x03fffffc, TRUE},
+  {H_PC32,       0, 2, 32, TRUE,  0, complain_overflow_signed,   0, "RELRELOC32",   FALSE, 0xffffffff, 0xffffffff, TRUE}
+};
+
+/* The following are gross hacks that need to be fixed.  The problem is
+   that the linker unconditionally references these values without
+   going through any of bfd's standard interface.  Thus they need to
+   be defined in a bfd module that is included in *all* configurations,
+   and are currently in bfd.c, otherwise linking the linker will fail
+   on non-Amiga target configurations. */
+
+/* This one is used by the linker and tells us, if a debug hunk should
+   be written out. */
+extern int write_debug_hunk;
+
+/* This is also used by the linker to set the attribute of sections. */
+extern int amiga_attribute;
+
+/* used with base-relative linking */
+extern int amiga_base_relative;
+
+/* used with -resident linking */
+extern int amiga_resident;
+
+static bfd_boolean
+get_long (abfd, n)
+     bfd *abfd;
+     unsigned long *n;
+{
+  if (bfd_bread ((PTR)n, 4, abfd) != 4)
+    return FALSE;
+  *n = GL (n);
+  return TRUE;
+}
+
+static const struct bfd_target *
+amiga_object_p (abfd)
+     bfd *abfd;
+{
+  unsigned long x;
+  char buf[8];
+
+  /* An Amiga object file must be at least 8 bytes long.  */
+  if (bfd_bread (buf, sizeof(buf), abfd) != sizeof(buf))
+    {
+      bfd_set_error (bfd_error_wrong_format);
+      return NULL;
+    }
+
+  bfd_seek (abfd, 0, SEEK_SET);
+
+  /* Does it look like an Amiga object file?  */
+  x = GL (&buf[0]);
+  if ((x != HUNK_UNIT) && (x != HUNK_HEADER))
+    {
+      /* Not an Amiga file.  */
+      bfd_set_error (bfd_error_wrong_format);
+      return NULL;
+    }
+
+  /* Can't fail and return (but must be declared bfd_boolean to suit
+     other bfd requirements).  */
+  (void) amiga_mkobject (abfd);
+
+  AMIGA_DATA(abfd)->IsLoadFile = (x == HUNK_HEADER);
+
+  if (!amiga_digest_file (abfd))
+    {
+      /* Something went wrong.  */
+      DPRINT(20,("bfd parser stopped at offset 0x%lx\n",bfd_tell(abfd)));
+      return NULL;
+    }
+
+  /* Set default architecture to m68k:68000.  */
+  /* So we can link on 68000 AMIGAs... */
+  abfd->arch_info = bfd_scan_arch ("m68k:68000");
+
+  return abfd->xvec;
+}
+
+static sec_ptr
+amiga_get_section_by_hunk_number (abfd, hunk_number)
+     bfd *abfd;
+     long hunk_number;
+{
+  /* A cache, so we don't have to search the entire list every time.  */
+  static sec_ptr last_reference;
+  static bfd *last_bfd;
+  sec_ptr p;
+
+  if (last_reference)
+    if (last_bfd == abfd && last_reference->target_index == hunk_number)
+       return last_reference;
+  for (p = abfd->sections; p != NULL; p = p->next)
+    if (p->target_index == hunk_number)
+      {
+	last_reference = p;
+	last_bfd = abfd;
+	return p;
+      }
+  BFD_FAIL ();
+  return NULL;
+}
+
+static bfd_boolean
+amiga_add_reloc (abfd, section, offset, symbol, howto, target_hunk)
+     bfd *abfd;
+     sec_ptr section;
+     bfd_size_type offset;
+     amiga_symbol_type *symbol;
+     reloc_howto_type *howto;
+     long target_hunk;
+{
+  amiga_reloc_type *reloc;
+  sec_ptr target_sec;
+
+  reloc = (amiga_reloc_type *) bfd_alloc (abfd, sizeof (amiga_reloc_type));
+  if (reloc == NULL)
+    return FALSE;
+
+  abfd->flags |= HAS_RELOC;
+  section->flags |= SEC_RELOC;
+
+  if (amiga_per_section(section)->reloc_tail)
+    amiga_per_section(section)->reloc_tail->next = reloc;
+  else
+    section->relocation = &reloc->relent;
+  amiga_per_section(section)->reloc_tail = reloc;
+
+  reloc->relent.sym_ptr_ptr = &reloc->symbol;
+  reloc->relent.address = offset;
+  reloc->relent.addend = 0;
+  reloc->relent.howto = howto;
+
+  reloc->next = NULL;
+  if (symbol==NULL) {		/* relative to section */
+    target_sec = amiga_get_section_by_hunk_number (abfd, target_hunk);
+    if (target_sec)
+      reloc->symbol = target_sec->symbol;
+    else
+      return FALSE;
+  }
+  else
+    reloc->symbol = &symbol->symbol;
+
+  return TRUE;
+}
+
+/* BFD doesn't currently allow multiple sections with the same
+   name, so we try a little harder to get a unique name.  */
+static sec_ptr
+amiga_make_unique_section (abfd, name)
+     bfd *abfd;
+     const char *name;
+{
+  sec_ptr section;
+
+  bfd_set_error (bfd_error_no_error);
+  section = bfd_make_section (abfd, name);
+  if ((section == NULL) && (bfd_get_error() == bfd_error_no_error))
+    {
+#if 0
+      char *new_name = bfd_alloc (abfd, strlen(name) + 4);
+      int i = 1;
+
+      /* We try to come up with an original name (since BFD currently
+	 requires all sections to have different names).  */
+      while (!section && (i<=99))
+	{
+	  sprintf (new_name, "%s_%u", name, i++);
+	  section = bfd_make_section (abfd, new_name);
+	}
+#else
+      section = bfd_make_section_anyway (abfd, name);
+#endif
+    }
+  return section;
+}
+
+#if DEBUG_AMIGA
+#define DPRINTHUNK(x) fprintf(stderr,"Processing %s hunk (0x%x)...",\
+	(x) == HUNK_UNIT ? "HUNK_UNIT" :\
+	(x) == HUNK_NAME ? "HUNK_NAME" :\
+	(x) == HUNK_CODE ? "HUNK_CODE" :\
+	(x) == HUNK_DATA ? "HUNK_DATA" :\
+	(x) == HUNK_BSS ? "HUNK_BSS" :\
+	(x) == HUNK_ABSRELOC32 ? "HUNK_RELOC32" :\
+	(x) == HUNK_RELRELOC16 ? "HUNK_RELRELOC16" :\
+	(x) == HUNK_RELRELOC8 ? "HUNK_RELRELOC8" :\
+	(x) == HUNK_EXT ? "HUNK_EXT" :\
+	(x) == HUNK_SYMBOL ? "HUNK_SYMBOL" :\
+	(x) == HUNK_DEBUG ? "HUNK_DEBUG" :\
+	(x) == HUNK_END ? "HUNK_END" :\
+	(x) == HUNK_HEADER ? "HUNK_HEADER" :\
+	(x) == HUNK_OVERLAY ? "HUNK_OVERLAY" :\
+	(x) == HUNK_BREAK ? "HUNK_BREAK" :\
+	(x) == HUNK_DREL32 ? "HUNK_DREL32" :\
+	(x) == HUNK_DREL16 ? "HUNK_DREL16" :\
+	(x) == HUNK_DREL8 ? "HUNK_DREL8" :\
+	(x) == HUNK_LIB ? "HUNK_LIB" :\
+	(x) == HUNK_INDEX ? "HUNK_INDEX" :\
+	(x) == HUNK_RELOC32SHORT ? "HUNK_RELOC32SHORT" :\
+	(x) == HUNK_RELRELOC32 ? "HUNK_RELRELOC32" :\
+	(x) == HUNK_PPC_CODE ? "HUNK_PPC_CODE" :\
+	(x) == HUNK_RELRELOC26 ? "HUNK_RELRELOC26" :\
+	"*unknown*",(x))
+#define DPRINTHUNKEND fprintf(stderr,"done\n")
+#else
+#define DPRINTHUNK(x)
+#define DPRINTHUNKEND
+#endif
+
+static bfd_boolean
+parse_archive_units (abfd, n_units, filesize, one, syms, symcount)
+     bfd *abfd;
+     int *n_units;
+     unsigned long filesize;
+     bfd_boolean one;			/* parse only the first unit? */
+     struct arch_syms **syms;
+     symindex *symcount;
+{
+  struct arch_syms *nsyms,*syms_tail=NULL;
+  unsigned long unit_offset,defsym_pos=0;
+  unsigned long hunk_type,type,len,no,n;
+  symindex defsymcount=0;
+
+  *n_units = 0;
+  while (get_long (abfd, &hunk_type)) {
+    switch (hunk_type) {
+    case HUNK_END:
+      break;
+    case HUNK_UNIT:
+      unit_offset = bfd_tell (abfd) - 4;
+      (*n_units)++;
+      if (one && *n_units>1) {
+	bfd_seek (abfd, -4, SEEK_CUR);
+	return TRUE;
+      }
+      /* Fall through */
+    case HUNK_NAME:
+    case HUNK_CODE:
+    case HUNK_DATA:
+    case HUNK_DEBUG:
+    case HUNK_PPC_CODE:
+      if (!get_long (abfd, &len)
+	  || bfd_seek (abfd, HUNK_VALUE (len) << 2, SEEK_CUR))
+	return FALSE;
+      break;
+    case HUNK_BSS:
+      if (!get_long (abfd, &len))
+	return FALSE;
+      break;
+    case HUNK_ABSRELOC32:
+    case HUNK_RELRELOC16:
+    case HUNK_RELRELOC8:
+    case HUNK_SYMBOL:
+    case HUNK_DREL32:
+    case HUNK_DREL16:
+    case HUNK_DREL8:
+      for (;;) {
+	/* read offsets count */
+	if (!get_long (abfd, &no))
+	  return FALSE;
+	if (!no)
+	  break;
+	/* skip hunk+offsets */
+	if (bfd_seek (abfd, (no+1)<<2, SEEK_CUR))
+	  return FALSE;
+      }
+      break;
+    case HUNK_EXT:
+      defsym_pos = 0;
+      if (!get_long (abfd, &n))
+	return FALSE;
+      while (n) {
+	len = n & 0xffffff;
+	type = (n>>24) & 0xff;
+	switch (type) {
+	case EXT_SYMB:
+	case EXT_DEF:
+	case EXT_ABS:
+	  /* retain the positions of defined symbols for each object
+	     in the archive. They'll be used later to build a
+	     pseudo-armap, which _bfd_generic_link_add_archive_symbols
+	     needs */
+	  if (defsym_pos==0)
+	    defsym_pos = bfd_tell (abfd) - 4;
+	  /* skip name & value */
+	  if (bfd_seek (abfd, (len+1)<<2, SEEK_CUR))
+	    return FALSE;
+	  defsymcount++;
+	  break;
+
+	case EXT_ABSREF32:
+	case EXT_RELREF16:
+	case EXT_RELREF8:
+	case EXT_DEXT32:
+	case EXT_DEXT16:
+	case EXT_DEXT8:
+	case EXT_RELREF32:
+	case EXT_RELREF26:
+	  /* skip name */
+	  if (bfd_seek (abfd, len<<2, SEEK_CUR))
+	    return FALSE;
+	  /* skip references */
+	  if (!get_long (abfd, &no))
+	    return FALSE;
+	  if (no && bfd_seek (abfd, no<<2, SEEK_CUR))
+	    return FALSE;
+	  break;
+
+	case EXT_ABSCOMMON:
+	case EXT_DEXT32COMMON:
+	case EXT_DEXT16COMMON:
+	case EXT_DEXT8COMMON:
+	  /* skip name & value */
+	  if (bfd_seek (abfd, (len+1)<<2, SEEK_CUR))
+	    return FALSE;
+	  /* skip references */
+	  if (!get_long (abfd, &no))
+	    return FALSE;
+	  if (no && bfd_seek (abfd, no<<2, SEEK_CUR))
+	    return FALSE;
+	  break;
+
+	default: /* error */
+	  bfd_msg ("unexpected type %ld(0x%lx) in hunk_ext1 at offset 0x%lx",
+		   type, type, bfd_tell (abfd));
+	  return FALSE;
+	}
+
+	if (!get_long (abfd, &n))
+	  return FALSE;
+      }
+      if (defsym_pos != 0 && syms) {
+	/* there are some defined symbols, keep enough information on
+	   them to simulate an armap later on */
+	nsyms = (struct arch_syms *) bfd_alloc (abfd, sizeof (struct arch_syms));
+	nsyms->next = NULL;
+	if (syms_tail)
+	  syms_tail->next = nsyms;
+	else
+	  *syms = nsyms;
+	syms_tail = nsyms;
+	nsyms->offset = defsym_pos;
+	nsyms->size = bfd_tell (abfd) - defsym_pos;
+	nsyms->unit_offset = unit_offset;
+      }
+      break; /* of HUNK_EXT */
+
+    default:
+#if 0
+      bfd_msg ("unexpected hunk 0x%lx at offset 0x%lx",
+	       hunk_type, bfd_tell (abfd));
+#endif
+      return FALSE;
+    }
+  }
+  if (syms && symcount)
+    *symcount = defsymcount;
+  return (bfd_tell (abfd) == filesize);
+}
+
+static bfd_boolean
+amiga_digest_file (abfd)
+     bfd *abfd;
+{
+  struct stat stat_buffer;
+  unsigned long tmp;
+
+  if (!get_long (abfd, &tmp))
+    {
+      bfd_set_error (bfd_error_wrong_format);
+      return FALSE;
+    }
+
+  switch (HUNK_VALUE (tmp))
+    {
+    case HUNK_UNIT:
+      /* Read the unit(s) */
+      if (bfd_stat (abfd, &stat_buffer) < 0)
+	return FALSE;
+/*
+      while ((pos=bfd_tell (abfd)) < stat_buffer.st_size)
+	{*/
+      if (!amiga_read_unit (abfd, stat_buffer.st_size - abfd->origin))
+	return FALSE;
+      if (abfd->arelt_data)
+	arelt_size (abfd) = bfd_tell (abfd);
+/*	}*/
+      break;
+
+    case HUNK_HEADER:
+      /* This is a load file */
+      if (!amiga_read_load (abfd))
+	return FALSE;
+      break;
+    }
+
+  return TRUE;
+}/* of amiga_digest_file */
+
+
+/* Read in Unit file */
+/* file pointer is located after the HUNK_UNIT LW */
+static bfd_boolean
+amiga_read_unit (abfd, size)
+     bfd *abfd;
+     unsigned long size;
+{
+  unsigned long hunk_number=0,hunk_type,tmp;
+
+  /* read LW length of unit's name */
+  if (!get_long (abfd, &tmp))
+    return FALSE;
+
+  /* and skip it (FIXME maybe) */
+  if (bfd_seek (abfd, tmp<<2, SEEK_CUR))
+    return FALSE;
+
+  while (bfd_tell (abfd) < size)
+    {
+      if (!get_long (abfd, &tmp))
+	return FALSE;
+
+      /* Now there may be CODE, DATA, BSS, SYMBOL, DEBUG, RELOC Hunks */
+      hunk_type = HUNK_VALUE (tmp);
+      switch (hunk_type)
+	{
+	case HUNK_UNIT:
+	  /* next unit, seek back and return */
+	  return (bfd_seek (abfd, -4, SEEK_CUR) == 0);
+
+	case HUNK_DEBUG:
+	  /* we don't parse hunk_debug at the moment */
+	  if (!get_long (abfd, &tmp) || bfd_seek (abfd, tmp<<2, SEEK_CUR))
+	    return FALSE;
+	  break;
+
+	case HUNK_NAME:
+	case HUNK_CODE:
+	case HUNK_DATA:
+	case HUNK_BSS:
+	case HUNK_PPC_CODE:
+	  /* Handle this hunk, including relocs, etc.
+	     The finishing HUNK_END is consumed by the routine */
+	  if (!amiga_handle_cdb_hunk (abfd, hunk_type, hunk_number++, 0, -1))
+	    return FALSE;
+	  break;
+
+	default:
+	  /* Something very nasty happened: invalid hunk occured... */
+	  bfd_set_error (bfd_error_wrong_format);
+	  return FALSE;
+	  break;
+	}/* Of switch hunk_type */
+
+      /* Next hunk */
+    }
+  return TRUE;
+}
+
+
+/* Read a load file */
+static bfd_boolean
+amiga_read_load (abfd)
+     bfd *abfd;
+{
+  unsigned long max_hunk_number,hunk_type,tmp,i;
+  unsigned long *hunk_attributes,*hunk_sizes;
+  char buf[16];
+
+  /* Read hunk lengths (and memory attributes...) */
+  /* Read in each hunk */
+
+  if (bfd_bread (buf, sizeof(buf), abfd) != sizeof(buf))
+    return FALSE;
+
+  /* If there are resident libs: abort (obsolete feature) */
+  if (GL (&buf[0]) != 0)
+    return FALSE;
+
+  max_hunk_number = GL (&buf[4]);
+
+  /* Sanity */
+  if (max_hunk_number<1)
+    {
+      bfd_set_error (bfd_error_wrong_format);
+      return FALSE;
+    }
+
+  AMIGA_DATA(abfd)->nb_hunks = max_hunk_number;
+
+  /* Num of root hunk must be 0 */
+  if (GL (&buf[8]) != 0)
+    {
+      bfd_set_error (bfd_error_wrong_format);
+      return FALSE;
+    }
+
+  /* Num of last hunk must be mhn-1 */
+  if (GL (&buf[12]) != max_hunk_number-1)
+    {
+      bfd_msg ("Overlay loadfiles are not supported");
+      bfd_set_error (bfd_error_wrong_format);
+      return FALSE;
+    }
+
+  hunk_sizes = alloca (max_hunk_number * sizeof (unsigned long));
+  hunk_attributes = alloca (max_hunk_number * sizeof (unsigned long));
+  if (hunk_sizes == NULL || hunk_attributes == NULL)
+    {
+      bfd_set_error (bfd_error_no_memory);
+      return FALSE;
+    }
+
+  /* Now, read in sizes and memory attributes */
+  for (i=0; i<max_hunk_number; i++)
+    {
+      if (!get_long (abfd, &hunk_sizes[i]))
+	return FALSE;
+      switch (HUNK_ATTRIBUTE (hunk_sizes[i]))
+	{
+	case HUNK_ATTR_CHIP:
+	  hunk_attributes[i] = MEMF_CHIP;
+	  break;
+	case HUNK_ATTR_FAST:
+	  hunk_attributes[i] = MEMF_FAST;
+	  break;
+	case HUNK_ATTR_FOLLOWS:
+	  if (!get_long (abfd, &hunk_attributes[i]))
+	    return FALSE;
+	  break;
+	default:
+	  hunk_attributes[i] = 0;
+	  break;
+	}
+      hunk_sizes[i] = HUNK_VALUE (hunk_sizes[i]) << 2;
+    }
+
+  for (i=0; i<max_hunk_number; i++)
+    {
+      if (!get_long (abfd, &tmp))
+	return FALSE;
+
+      /* This may be HUNK_NAME, CODE, DATA, BSS, DEBUG */
+      hunk_type = HUNK_VALUE (tmp);
+      switch (hunk_type)
+	{
+	case HUNK_NAME:
+	case HUNK_CODE:
+	case HUNK_DATA:
+	case HUNK_BSS:
+	case HUNK_PPC_CODE:
+	  if (!amiga_handle_cdb_hunk (abfd, hunk_type, i,
+				      hunk_attributes[i], hunk_sizes[i]))
+	    {
+	      bfd_set_error (bfd_error_wrong_format);
+	      return FALSE;
+	    }
+	  break;
+
+	case HUNK_DEBUG:
+	  if (--i,!amiga_handle_cdb_hunk (abfd, hunk_type, -1, 0, 0))
+	    {
+	      bfd_set_error (bfd_error_wrong_format);
+	      return FALSE;
+	    }
+	  break;
+
+	default:
+	  /* invalid hunk */
+	  bfd_set_error (bfd_error_wrong_format);
+	  return FALSE;
+	  break;
+	}/* Of switch */
+    }
+
+  return TRUE;
+}/* Of amiga_read_load */
+
+
+/* Handle NAME, CODE, DATA, BSS, DEBUG Hunks */
+static bfd_boolean
+amiga_handle_cdb_hunk (abfd, hunk_type, hunk_number, hunk_attribute,
+		       hunk_size)
+     bfd *abfd;
+     unsigned long hunk_type;
+     unsigned long hunk_number;
+     unsigned long hunk_attribute;
+     unsigned long hunk_size;
+/* If hunk_size==-1, then we are digesting a HUNK_UNIT */
+{
+  sec_ptr current_section;
+  char *sec_name,*current_name=NULL;
+  unsigned long len,tmp;
+  int secflags,is_load=(hunk_size!=(unsigned long)-1);
+
+  if (hunk_type==HUNK_NAME) /* get name */
+    {
+      if (!get_long (abfd, &tmp))
+	return FALSE;
+
+      len = HUNK_VALUE (tmp) << 2;
+      if (len != 0)
+	{
+	  current_name = bfd_alloc (abfd, len+1);
+	  if (!current_name)
+	    return FALSE;
+
+	  if (bfd_bread (current_name, len, abfd) != len)
+	    return FALSE;
+
+	  current_name[len] = '\0';
+	  if (current_name[0] == '\0')
+	    {
+	       bfd_release (abfd, current_name);
+	       current_name = NULL;
+	    }
+	}
+
+      if (!get_long (abfd, &hunk_type))
+	return FALSE;
+    }
+
+  /* file_pointer is now after hunk_type */
+  secflags = 0;
+  switch (hunk_type)
+    {
+    case HUNK_CODE:
+    case HUNK_PPC_CODE:
+      secflags = SEC_ALLOC | SEC_LOAD | SEC_CODE | SEC_HAS_CONTENTS;
+      sec_name = ".text";
+      goto do_section;
+
+    case HUNK_DATA:
+      secflags = SEC_ALLOC | SEC_LOAD | SEC_DATA | SEC_HAS_CONTENTS;
+      sec_name = ".data";
+      goto do_section;
+
+    case HUNK_BSS:
+      secflags = SEC_ALLOC;
+      sec_name = ".bss";
+
+    do_section:
+      if (!current_name)
+	current_name = sec_name;
+      if (!get_long (abfd, &tmp))
+	return FALSE;
+      len = HUNK_VALUE (tmp) << 2; /* Length of section */
+      if (!is_load)
+	{
+	  hunk_attribute=HUNK_ATTRIBUTE (len);
+	  hunk_attribute=(hunk_attribute==HUNK_ATTR_CHIP)?MEMF_CHIP:
+			 (hunk_attribute==HUNK_ATTR_FAST)?MEMF_FAST:0;
+	}
+
+      /* Make new section */
+      current_section = amiga_make_unique_section (abfd, current_name);
+      if (!current_section)
+	return FALSE;
+
+      current_section->filepos = bfd_tell (abfd);
+      /* For a loadfile, the section size in memory comes from the
+	 hunk header. The size on disk may be smaller. */
+      current_section->_cooked_size = current_section->_raw_size =
+	((hunk_size==(unsigned long)-1) ? len : hunk_size);
+      current_section->target_index = hunk_number;
+      bfd_set_section_flags (abfd, current_section, secflags);
+
+      amiga_per_section(current_section)->disk_size = len; /* size on disk */
+      amiga_per_section(current_section)->attribute = hunk_attribute;
+
+      /* skip the contents */
+      if ((secflags & SEC_HAS_CONTENTS) && bfd_seek (abfd, len, SEEK_CUR))
+	return FALSE;
+
+      if (!amiga_handle_rest (abfd, current_section, is_load))
+	return FALSE;
+      break;
+
+      /* Currently, there is one debug hunk per executable, instead of one
+	 per unit as it would with a "standard" AmigaOS implementation. So
+	 the debug hunk is at the same level as code/data/bss.
+	 This will change in the future */
+    case HUNK_DEBUG:
+      /* format of gnu debug hunk is:
+	  HUNK_DEBUG
+	      N
+	    ZMAGIC
+	  symtabsize
+	  strtabsize
+	  symtabdata  [length=symtabsize]
+	  strtabdata  [length=strtabsize]
+	  [pad bytes]
+	  */
+
+      /* read LW length */
+      if (!get_long (abfd, &tmp))
+	return FALSE;
+      len = tmp << 2;
+      if (len > 12)
+	{
+	  char buf[12];
+	  if (bfd_bread (buf, sizeof(buf), abfd) != sizeof(buf))
+	    return FALSE;
+	  if (GL (&buf[0]) == ZMAGIC) /* GNU DEBUG HUNK */
+	    {
+	      amiga_data_type *amiga_data=AMIGA_DATA(abfd);
+	      /* FIXME: we should add the symbols in the debug hunk to symtab... */
+	      amiga_data->symtab_size = GL (&buf[4]);
+	      amiga_data->stringtab_size = GL (&buf[8]);
+	      adata(abfd).sym_filepos = bfd_tell (abfd);
+	      adata(abfd).str_filepos = adata(abfd).sym_filepos +
+		amiga_data->symtab_size;
+	    }
+	  len -= sizeof(buf);
+	}
+      if (bfd_seek (abfd, len, SEEK_CUR))
+	return FALSE;
+      break;
+
+    default:
+      bfd_set_error (bfd_error_wrong_format);
+      return FALSE;
+      break;
+    }/* switch (hunk_type) */
+
+  return TRUE;
+}/* Of amiga_handle_cdb_hunk */
+
+
+/* Handle rest of a hunk
+   I.e.: Relocs, EXT, SYMBOLS... */
+static bfd_boolean
+amiga_handle_rest (abfd, current_section, isload)
+     bfd *abfd;
+     sec_ptr current_section;
+     bfd_boolean isload;
+{
+  amiga_per_section_type *asect=amiga_per_section(current_section);
+  unsigned long hunk_type,relno,type,len,no;
+  raw_reloc_type *relp;
+
+  for (relno=0;;)
+    {
+      if (!get_long (abfd, &hunk_type))
+	return FALSE;
+      switch (hunk_type)
+	{
+	case HUNK_END:
+	  if (relno)
+	    {
+	      abfd->flags |= HAS_RELOC;
+	      current_section->flags |= SEC_RELOC;
+	      current_section->reloc_count = relno;
+	    }
+	  return TRUE;
+	  break;
+
+	case HUNK_DREL32:
+	  if (isload)
+	    hunk_type = HUNK_RELOC32SHORT;
+	case HUNK_ABSRELOC32:
+	case HUNK_RELRELOC16:
+	case HUNK_RELRELOC8:
+	case HUNK_DREL16:
+	case HUNK_DREL8:
+	case HUNK_RELOC32SHORT:
+	  /* count and skip relocs */
+	  relp = (raw_reloc_type *) bfd_alloc (abfd, sizeof (*relp));
+	  relp->next = asect->relocs;
+	  asect->relocs = relp;
+	  relp->pos = bfd_tell (abfd) - 4;
+	  relp->num = 0;
+	  if (hunk_type != HUNK_RELOC32SHORT) {
+	    for (;;) {
+	      if (!get_long (abfd, &no))
+		return FALSE;
+	      if (!no)
+		break;
+	      relp->num += no;
+	      if (bfd_seek (abfd, (no+1)<<2, SEEK_CUR))
+		return FALSE;
+	    }
+	  }
+	  else {
+	    for (;;) {
+	      char buf[2];
+	      if (bfd_bread (buf, 2, abfd) != 2)
+		return FALSE;
+	      if (no=GW(buf),!no)
+		break;
+	      relp->num += no;
+	      if (bfd_seek (abfd, (no+1)<<1, SEEK_CUR))
+		return FALSE;
+	    }
+	    if ((bfd_tell (abfd) & 2) && bfd_seek (abfd, 2, SEEK_CUR))
+	      return FALSE;
+	  }
+	  relno += relp->num;
+	  break;
+
+	case HUNK_SYMBOL:
+	  /* In a unit, we ignore these, since all symbol information
+	     comes with HUNK_EXT, in a load file, these are added */
+	  if (!isload)
+	    {
+	      asect->hunk_symbol_pos = bfd_tell (abfd);
+	      for (;;) {
+		/* size of symbol */
+		if (!get_long (abfd, &no))
+		  return FALSE;
+		if (!no)
+		  break;
+		/* skip the name */
+		if (bfd_seek (abfd, (no+1)<<2, SEEK_CUR))
+		  return FALSE;
+	      }
+	      break;
+	    }
+	  /* We add these, by falling through... */
+
+	case HUNK_EXT:
+	  /* We leave these alone, until they are requested by the user */
+	  asect->hunk_ext_pos = bfd_tell (abfd);
+	  for (;;)
+	    {
+	      if (!get_long (abfd, &no))
+	        return FALSE;
+	      if (!no)
+	        break;
+
+	      /* symbol type and length */
+	      type = (no>>24) & 0xff;
+	      len = no & 0xffffff;
+
+	      /* skip symbol name */
+	      if (bfd_seek (abfd, len<<2, SEEK_CUR))
+		return FALSE;
+
+	      /* We have symbols */
+	      abfd->flags |= HAS_SYMS;
+	      abfd->symcount++;
+
+	      switch (type)
+		{
+		case EXT_SYMB: /* Symbol hunks are relative to hunk start... */
+		case EXT_DEF: /* def relative to hunk */
+		case EXT_ABS: /* def absolute */
+		  /* skip the value */
+		  if (!get_long (abfd, &no))
+		    return FALSE;
+		  break;
+
+		case EXT_ABSCOMMON: /* Common ref/def */
+		case EXT_DEXT32COMMON:
+		case EXT_DEXT16COMMON:
+		case EXT_DEXT8COMMON:
+		  /* FIXME: skip the size of common block */
+		  if (!get_long (abfd, &no))
+		    return FALSE;
+
+		  /* Fall through */
+
+		case EXT_ABSREF32: /* 32 bit ref */
+		case EXT_RELREF16: /* 16 bit ref */
+		case EXT_RELREF8: /* 8 bit ref */
+		case EXT_DEXT32: /* 32 bit baserel */
+		case EXT_DEXT16: /* 16 bit baserel */
+		case EXT_DEXT8: /* 8 bit baserel */
+		case EXT_RELREF32:
+		case EXT_RELREF26:
+		  if (!get_long (abfd, &no))
+		    return FALSE;
+		  if (no)
+		    {
+		      relno += no;
+		      /* skip references */
+		      if (bfd_seek (abfd, no<<2, SEEK_CUR))
+			return FALSE;
+		    }
+		  break;
+
+		default: /* error */
+		  bfd_msg ("unexpected type %ld(0x%lx) in hunk_ext2 at offset 0x%lx",
+			   type, type, bfd_tell (abfd));
+		  bfd_set_error (bfd_error_wrong_format);
+		  return FALSE;
+		  break;
+		}/* of switch type */
+	    }
+	  break;
+
+	case HUNK_DEBUG:
+	  /* If a debug hunk is found at this position, the file has
+	     been generated by a third party tool and the debug info
+	     here are useless to us. Just skip the hunk, then. */
+	  if (!get_long (abfd, &no) || bfd_seek (abfd, no<<2, SEEK_CUR))
+	    return FALSE;
+	  break;
+
+	default: /* error */
+	  bfd_seek (abfd, -4, SEEK_CUR);
+	  bfd_msg ("missing HUNK_END: unexpected hunktype %ld(0x%lx) at offset 0x%lx",
+		   hunk_type, hunk_type, bfd_tell (abfd));
+	  hunk_type = HUNK_VALUE(hunk_type);
+	  if (hunk_type == HUNK_CODE || hunk_type == HUNK_DATA || hunk_type == HUNK_BSS)
+	    return TRUE;
+	  bfd_set_error (bfd_error_wrong_format);
+	  return FALSE;
+	  break;
+	}/* Of switch */
+    }/* Of for */
+  return TRUE;
+}/* of amiga_handle_rest */
+
+static bfd_boolean
+amiga_mkobject (abfd)
+     bfd *abfd;
+{
+  amiga_data_type *rawptr;
+  rawptr = (amiga_data_type *) bfd_zalloc (abfd, sizeof (*rawptr));
+  abfd->tdata.amiga_data = rawptr;
+  return (rawptr!=NULL);
+}
+
+static bfd_boolean
+amiga_mkarchive (abfd)
+     bfd *abfd;
+{
+  amiga_ardata_type *ar;
+  ar = (amiga_ardata_type *) bfd_zalloc (abfd, sizeof (*ar));
+  amiga_ardata (abfd) = ar;
+  return (ar!=NULL);
+}
+
+/* write nb long words (possibly swapped out) to the output file */
+static bfd_boolean
+write_longs (in, nb, abfd)
+     const unsigned long *in;
+     unsigned long nb;
+     bfd *abfd;
+{
+  unsigned char out[10*4];
+  unsigned long i;
+
+  while (nb)
+    {
+      for (i=0; i<nb && i<10; in++,i++)
+        bfd_putb32 (in[0], &out[i*4]);
+      if (bfd_bwrite ((PTR)out, 4*i, abfd) != 4*i)
+	return FALSE;
+      nb -= i;
+    }
+  return TRUE;
+}
+
+static long
+determine_datadata_relocs (abfd, section)
+     bfd *abfd ATTRIBUTE_UNUSED;
+     sec_ptr section;
+{
+  sec_ptr insection;
+  asymbol *sym_p;
+  unsigned int i;
+  long relocs=1;
+
+  for (i=0;i<section->reloc_count;i++)
+    {
+      arelent *r=section->orelocation[i];
+      if (r == NULL)
+	continue;
+      sym_p=*(r->sym_ptr_ptr); /* The symbol for this relocation */
+      insection=sym_p->section;
+
+      /* Is reloc relative to a special section? */
+      if (bfd_is_bfd_section(insection))
+	continue; /* Nothing to do, since this translates to HUNK_EXT */
+      if (insection->output_section == section)
+	relocs++;
+    }
+  return relocs;
+}
+
+/* Adjust the indices map when we decide not to output the section <sec> */
+static void
+remove_section_index (sec, index_map)
+     sec_ptr sec;
+     int *index_map;
+{
+  int i=sec->index;
+  for (sec=sec->next,index_map[i++]=-1; sec; sec=sec->next)
+    (index_map[i++])--;
+}
+
+/* Write out the contents of a bfd */
+static bfd_boolean
+amiga_write_object_contents (abfd)
+     bfd *abfd;
+{
+  long datadata_relocs=0,bss_size=0,idx;
+  int *index_map,max_hunk=-1;
+  sec_ptr data_sec,p;
+  unsigned long i,n[5];
+
+  /* Distinguish UNITS, LOAD Files
+    Write out hunks+relocs+HUNK_EXT+HUNK_DEBUG (GNU format) */
+  DPRINT(5,("Entering write_object_conts\n"));
+
+  abfd->output_has_begun=TRUE; /* Output has begun */
+
+  index_map = bfd_alloc (abfd, abfd->section_count * sizeof (int));
+  if (!index_map)
+    return FALSE;
+
+  for (idx=0, p=abfd->sections; p!=NULL; p=p->next)
+    index_map[idx++] = p->index;
+
+  /* Distinguish Load files and Unit files */
+  if (AMIGA_DATA(abfd)->IsLoadFile)
+    {
+      DPRINT(5,("Writing load file\n"));
+
+      if (amiga_base_relative)
+	BFD_ASSERT (abfd->section_count==3);
+
+      /* Write out load file header */
+      n[0] = HUNK_HEADER;
+      n[1] = n[2] = 0;
+      for (p=abfd->sections; p!=NULL; p=p->next) {
+	/* For baserel linking, don't remove empty sections, since they
+	   may get some contents later on */
+	if ((amiga_base_relative || p->_raw_size!=0 || p->_cooked_size!=0) &&
+	    !(amiga_base_relative && !strcmp (p->name, ".bss")))
+	  n[2]++;
+	else
+	  remove_section_index (p, index_map);
+      }
+      n[3] = 0;
+      n[4] = n[2]-1;
+      if (!write_longs (n, 5, abfd))
+	return FALSE;
+
+      /* Write out sizes and memory specifiers... */
+      /* We have to traverse the section list again, bad but no other way... */
+      if (amiga_base_relative) {
+	for (p=abfd->sections; p!=NULL; p=p->next)
+	  {
+	    if (amiga_resident && !strcmp(p->name,".data"))
+	      {
+		datadata_relocs = determine_datadata_relocs (abfd, p);
+		data_sec = p;
+	      }
+	    else if (!strcmp(p->name,".bss"))
+	      {
+		/* Get size for header */
+		bss_size = p->_raw_size;
+	      }
+	  }
+      }
+
+      for (p=abfd->sections; p!=NULL; p=p->next)
+	{
+	  long extra = 0, i;
+
+	  if (index_map[p->index] < 0)
+	    continue;
+
+	  if (datadata_relocs && !strcmp(p->name,".text"))
+	    extra = datadata_relocs * 4;
+	  else if (bss_size && !strcmp (p->name, ".data"))
+	    extra = bss_size;
+	  /* convert to a size in long words */
+	  n[0] = LONGSIZE (p->_raw_size + extra);
+
+	  i = amiga_per_section(p)->attribute;
+	  switch (i)
+	    {
+	    case MEMF_CHIP:
+	      n[0]|=HUNKF_CHIP;
+	      i=1;
+	      break;
+	    case MEMF_FAST:
+	      n[0]|=HUNKF_FAST;
+	      i=1;
+	      break;
+	    case 0: /* nothing */
+	      i=1;
+	      break;
+	    default: /* special one */
+	      n[0]|=0xc0000000;
+	      n[1]=i;
+	      i=2;
+	      break;
+	    }/* Of switch */
+
+	  if (!write_longs (n, i, abfd))
+	    return FALSE;
+	}/* Of for */
+    }
+  else
+    { /* Unit, no base-relative linking here.. */
+      DPRINT(5,("Writing unit\n"));
+
+      /* Write out unit header */
+      n[0]=HUNK_UNIT;
+      if (!write_longs (n, 1, abfd) || !write_name (abfd, abfd->filename, 0))
+	return FALSE;
+
+      for (i=0;i<bfd_get_symcount (abfd);i++) {
+	asymbol *sym_p=abfd->outsymbols[i];
+	sec_ptr osection=sym_p->section;
+	if (!osection || !bfd_is_com_section(osection->output_section))
+	  continue;
+	for (p=abfd->sections; p!=NULL; p=p->next) {
+	  if (!strcmp(p->name, ".bss")) {
+	    if (!p->_raw_size && !p->_cooked_size)
+	      p->_cooked_size = sym_p->value;
+	    break;
+	  }
+	}
+	break;
+      }
+
+      for (p=abfd->sections; p!=NULL; p=p->next) {
+	if (p->_raw_size==0 && p->_cooked_size==0)
+	  remove_section_index (p, index_map);
+      }
+    }
+
+  /* Compute the maximum hunk number of the ouput file */
+  for (p=abfd->sections; p!=NULL; p=p->next)
+    max_hunk++;
+
+  /* Write out every section */
+  for (p=abfd->sections; p!=NULL; p=p->next)
+    {
+      if (index_map[p->index] < 0)
+	continue;
+
+#define ddrels (datadata_relocs&&!strcmp(p->name,".text")?datadata_relocs:0)
+      if (!amiga_write_section_contents (abfd,p,data_sec,ddrels,index_map,
+					 max_hunk))
+	return FALSE;
+
+      if (!amiga_write_symbols (abfd,p)) /* Write out symbols + HUNK_END */
+	return FALSE;
+    }/* of for sections */
+
+  /* Write out debug hunk, if requested */
+  if (AMIGA_DATA(abfd)->IsLoadFile && write_debug_hunk)
+    {
+      extern bfd_boolean
+	translate_to_native_sym_flags (bfd*, asymbol*, struct external_nlist*);
+
+      unsigned int offset = 4, symbols = 0, i;
+      unsigned long str_size = 4; /* the first 4 bytes will be replaced with the length */
+      asymbol *sym;
+      sec_ptr s;
+
+      /* We have to convert all the symbols in abfd to a.out style... */
+      if (bfd_get_symcount (abfd))
+	{
+#define CAN_WRITE_OUTSYM(sym) (sym!=NULL && sym->section && \
+				((sym->section->owner && \
+				 bfd_get_flavour (sym->section->owner) == \
+				 bfd_target_aout_flavour) || \
+				 bfd_asymbol_flavour (sym) == \
+				 bfd_target_aout_flavour))
+
+	  for (i = 0; i < bfd_get_symcount (abfd); i++)
+	    {
+	      sym = abfd->outsymbols[i];
+	      /* NULL entries have been written already... */
+	      if (CAN_WRITE_OUTSYM (sym))
+	        {
+		  str_size += strlen(sym->name) + 1;
+		  symbols++;
+		}
+	    }
+
+	  if (!symbols)
+	    return TRUE;
+
+	  /* Now, set the .text, .data and .bss fields in the tdata struct
+	     because translate_to_native_sym_flags needs them... */
+	  for (i=0,s=abfd->sections;s!=NULL;s=s->next)
+	    if (!strcmp(s->name,".text"))
+	      {
+		i|=1;
+		adata(abfd).textsec=s;
+	      }
+	    else if (!strcmp(s->name,".data"))
+	      {
+	        i|=2;
+	        adata(abfd).datasec=s;
+	      }
+	    else if (!strcmp(s->name,".bss"))
+	      {
+	        i|=4;
+	        adata(abfd).bsssec=s;
+	      }
+
+	  if (i!=7) /* section(s) missing... */
+	    {
+	      bfd_msg ("Missing section, debughunk not written");
+	      return TRUE;
+	    }
+
+	  /* Write out HUNK_DEBUG, size, ZMAGIC, ... */
+	  n[0] = HUNK_DEBUG;
+	  n[1] = 3 + ((symbols * sizeof(struct internal_nlist) + str_size + 3) >> 2);
+	  n[2] = ZMAGIC; /* Magic number */
+	  n[3] = symbols * sizeof(struct internal_nlist);
+	  n[4] = str_size;
+	  if (!write_longs (n, 5, abfd))
+	    return FALSE;
+
+	  /* Write out symbols */
+	  for (i = 0; i < bfd_get_symcount (abfd); i++) /* Translate every symbol */
+	    {
+	      sym = abfd->outsymbols[i];
+	      if (CAN_WRITE_OUTSYM (sym))
+		{
+		  amiga_symbol_type *t = (amiga_symbol_type *) sym;
+		  struct external_nlist data;
+
+		  bfd_h_put_16(abfd, t->desc, data.e_desc);
+		  bfd_h_put_8(abfd, t->other, data.e_other);
+		  bfd_h_put_8(abfd, t->type, data.e_type);
+		  if (!translate_to_native_sym_flags(abfd,sym,&data))
+		    {
+		      bfd_msg ("Cannot translate flags for %s", sym->name);
+		    }
+		  bfd_h_put_32(abfd, offset, &data.e_strx[0]); /* Store index */
+		  offset += strlen(sym->name) + 1;
+		  if (bfd_bwrite ((PTR)&data, sizeof(data), abfd)
+		      != sizeof(data))
+		    return FALSE;
+		}
+	    }
+
+	  /* Write out strings */
+	  if (!write_longs (&str_size, 1, abfd))
+	    return FALSE;
+
+	  for (i = 0; i < bfd_get_symcount (abfd); i++)
+	    {
+	      sym = abfd->outsymbols[i];
+	      if (CAN_WRITE_OUTSYM (sym))
+		{
+		  size_t len = strlen(sym->name) + 1;
+
+	          /* Write string tab */
+	          if (bfd_bwrite (sym->name, len, abfd) != len)
+	            return FALSE;
+		}
+	    }
+
+	  /* Write padding */
+	  n[0] = 0;
+	  i = (4 - (str_size & 3)) & 3;
+	  if (i && bfd_bwrite ((PTR)n, i, abfd) != i)
+	    return FALSE;
+
+	  /* write a HUNK_END here to finish the loadfile, or AmigaOS
+	     will refuse to load it */
+	  n[0] = HUNK_END;
+	  if (!write_longs (n, 1, abfd))
+	    return FALSE;
+	}/* Of if bfd_get_symcount (abfd) */
+    }/* Of write out debug hunk */
+
+  bfd_release (abfd, index_map);
+  return TRUE;
+}
+
+/* Write a string padded to 4 bytes and preceded by it's length in
+   long words ORed with <value> */
+static bfd_boolean
+write_name (abfd, name, value)
+     bfd *abfd;
+     const char *name;
+     unsigned long value;
+{
+  unsigned long n[1];
+  size_t l;
+
+  l = strlen (name);
+  if (AMIGA_DATA(abfd)->IsLoadFile && l > MAX_NAME_SIZE)
+    l = MAX_NAME_SIZE;
+  n[0] = (LONGSIZE (l) | value);
+  if (!write_longs (n, 1, abfd))
+    return FALSE;
+  if (bfd_bwrite (name, l, abfd) != l)
+    return FALSE;
+  n[0] = 0;
+  l = (4 - (l & 3)) & 3;
+  return (l && bfd_bwrite ((PTR)n, l, abfd) != l ? FALSE : TRUE);
+}
+
+static bfd_boolean
+amiga_write_archive_contents (arch)
+     bfd *arch;
+{
+  struct stat status;
+  bfd *object;
+
+  for (object = arch->archive_head; object; object = object->next)
+    {
+      unsigned long remaining;
+
+      if (bfd_write_p (object))
+	{
+	  bfd_set_error (bfd_error_invalid_operation);
+	  return FALSE;
+	}
+
+      if (object->arelt_data != NULL)
+	{
+	  remaining = arelt_size (object);
+	}
+      else
+	{
+	  if (stat (object->filename, &status) != 0)
+	    {
+	      bfd_set_error (bfd_error_system_call);
+	      return FALSE;
+	    }
+	  remaining = status.st_size;
+	}
+
+      if (bfd_seek (object, 0, SEEK_SET))
+	return FALSE;
+
+      while (remaining)
+	{
+	  char buf[DEFAULT_BUFFERSIZE];
+	  unsigned long amt = sizeof(buf);
+	  if (amt > remaining)
+	    amt = remaining;
+	  errno = 0;
+	  if (bfd_bread (buf, amt, object) != amt)
+	    {
+	      if (bfd_get_error () != bfd_error_system_call)
+		bfd_set_error (bfd_error_malformed_archive);
+	      return FALSE;
+	    }
+	  if (bfd_bwrite (buf, amt, arch) != amt)
+	    return FALSE;
+	  remaining -= amt;
+	}
+    }
+  return TRUE;
+}
+
+static bfd_boolean
+amiga_write_armap (arch, elength, map, orl_count, stridx)
+     bfd *arch ATTRIBUTE_UNUSED;
+     unsigned int elength ATTRIBUTE_UNUSED;
+     struct orl *map ATTRIBUTE_UNUSED;
+     unsigned int orl_count ATTRIBUTE_UNUSED;
+     int stridx ATTRIBUTE_UNUSED;
+{
+  return TRUE;
+}
+
+static int
+determine_type (r)
+     arelent *r;
+{
+  switch (r->howto->type)
+    {
+      case H_ABS8: /* 8 bit absolute */
+      case H_PC8:  /* 8 bit pcrel */
+	return 2;
+
+      case H_ABS16: /* 16 bit absolute */
+      case H_PC16:  /* 16 bit pcrel */
+	return 1;
+
+      case H_ABS32: /* 32 bit absolute */
+    /*case H_PC32:*//* 32 bit pcrel */
+	return 0;
+
+      case H_SD8: /* 8 bit base rel */
+	return 5;
+
+      case H_SD16: /* 16 bit base rel */
+	return 4;
+
+      case H_SD32: /* 32 bit baserel */
+	return 3;
+
+      default: /* Error, can't represent this */
+	bfd_set_error (bfd_error_nonrepresentable_section);
+	return -1;
+    }/* Of switch */
+}
+
+#define NB_RELOC_TYPES 6
+static const unsigned long reloc_types[NB_RELOC_TYPES] = {
+  HUNK_ABSRELOC32, HUNK_RELRELOC16, HUNK_RELRELOC8,
+  HUNK_DREL32,     HUNK_DREL16,     HUNK_DREL8
+};
+
+/* Write out section contents, including relocs */
+static bfd_boolean
+amiga_write_section_contents (abfd, section, data_sec, datadata_relocs,
+			      index_map, max_hunk)
+     bfd *abfd;
+     sec_ptr section;
+     sec_ptr data_sec;
+     unsigned long datadata_relocs;
+     int *index_map;
+     int max_hunk;
+{
+  sec_ptr insection;
+  asymbol *sym_p;
+  arelent *r;
+  unsigned long zero=0,disksize,pad,n[2],k,l,s;
+  long *reloc_counts,reloc_count=0;
+  unsigned char *values;
+  int i,j,x,type;
+
+  DPRINT(5,("Entering write_section_contents\n"));
+
+  /* If we are base-relative linking and the section is .bss and abfd
+     is a load file, then return */
+  if (AMIGA_DATA(abfd)->IsLoadFile)
+    {
+      if (amiga_base_relative && !strcmp(section->name, ".bss"))
+	return TRUE; /* Nothing to do */
+    }
+  else
+    {
+      /* WRITE out HUNK_NAME + section name */
+      n[0] = HUNK_NAME;
+      if (!write_longs (n, 1, abfd) || !write_name (abfd, section->name, 0))
+	return FALSE;
+    }
+
+  /* Depending on the type of the section, write out HUNK_{CODE|DATA|BSS} */
+  if (section->flags & SEC_CODE) /* Code section */
+    n[0] = HUNK_CODE;
+  else if (section->flags & (SEC_DATA | SEC_LOAD)) /* data section */
+    n[0] = HUNK_DATA;
+  else if (section->flags & SEC_ALLOC) /* BSS */
+    n[0] = HUNK_BSS;
+  else if (section->flags & SEC_DEBUGGING) /* debug section */
+    n[0] = HUNK_DEBUG;
+  else /* Error */
+    {
+#if 0
+      bfd_set_error (bfd_error_nonrepresentable_section);
+      return FALSE;
+#else
+      /* FIXME: Just dump everything we don't currently recognize into
+	 a DEBUG hunk. */
+      n[0] = HUNK_DEBUG;
+#endif
+    }
+
+  DPRINT(10,("Section type is %lx\n",n[0]));
+
+  /* Get real size in n[1], this may be shorter than the size in the header */
+  if (amiga_per_section(section)->disk_size == 0)
+    amiga_per_section(section)->disk_size = section->_raw_size;
+  disksize = LONGSIZE (amiga_per_section(section)->disk_size) + datadata_relocs;
+  n[1] = disksize;
+
+  /* in a load file, we put section attributes only in the header */
+  if (!AMIGA_DATA(abfd)->IsLoadFile)
+    {
+      /* Get attribute for section */
+      switch (amiga_per_section(section)->attribute)
+	{
+	case MEMF_CHIP:
+	  n[1] |= HUNKF_CHIP;
+	  break;
+	case MEMF_FAST:
+	  n[1] |= HUNKF_FAST;
+	  break;
+	case 0:
+	  break;
+	default: /* error, can't represent this */
+	  bfd_set_error (bfd_error_nonrepresentable_section);
+	  return FALSE;
+	  break;
+	}
+    }/* Of switch */
+
+  if (!write_longs (n, 2, abfd))
+      return FALSE;
+
+  DPRINT(5,("Wrote code and size=%lx\n",n[1]));
+
+  /* If a BSS hunk, we're done, else write out section contents */
+  if (HUNK_VALUE (n[0]) == HUNK_BSS)
+    return TRUE;
+
+  DPRINT(5,("Non bss hunk...\n"));
+
+  /* Traverse through the relocs, sample them in reloc_data, adjust section
+     data to get 0 addend
+     Then compactify reloc_data
+     Set the entry in the section for the reloc to NULL */
+
+  if (disksize != 0)
+    BFD_ASSERT ((section->flags & SEC_IN_MEMORY) != 0);
+
+  reloc_counts = (long *) bfd_zalloc (abfd, NB_RELOC_TYPES * (max_hunk+1)
+				      * sizeof (long));
+  if (!reloc_counts)
+    return FALSE;
+
+  DPRINT(5,("Section has %d relocs\n",section->reloc_count));
+
+  for (l = 0; l < section->reloc_count; l++)
+    {
+      r = section->orelocation[l];
+      if (r == NULL)
+	continue;
+
+      sym_p = *(r->sym_ptr_ptr); /* The symbol for this relocation */
+      insection = sym_p->section;
+      DPRINT(5,("Sec for reloc is %lx(%s)\n",insection,insection->name));
+      DPRINT(5,("Symbol for this reloc is %lx(%s)\n",sym_p,sym_p->name));
+      /* Is reloc relative to a special section? */
+      if (bfd_is_bfd_section(insection))
+	continue; /* Nothing to do, since this translates to HUNK_EXT */
+
+      r->addend += sym_p->value; /* Add offset of symbol from section start */
+
+      /* Address of reloc has been unchanged since original reloc, or has
+	 been adjusted by get_relocated_section_contents. */
+      /* For relocs, the vma of the target section is in the data, the
+	 addend is -vma of that section =>No need to add vma */
+      /* Add in offset */
+      r->addend += insection->output_offset;
+
+      /* Determine which hunk to write, and index of target */
+      x = index_map[insection->output_section->index];
+      if (x<0 || x>max_hunk) {
+	bfd_msg ("erroneous relocation to hunk %d/%s from %s",
+		 x, insection->output_section->name, insection->name);
+	bfd_set_error (bfd_error_nonrepresentable_section);
+	return FALSE;
+      }
+
+      type = determine_type(r);
+      if (type == -1)
+	return FALSE;
+      if (type >= NB_RELOC_TYPES) {
+	bfd_set_error (bfd_error_nonrepresentable_section);
+	return FALSE;
+      }
+      reloc_counts[type+(x*NB_RELOC_TYPES)]++;
+      reloc_count++;
+
+      /* There is no error checking with these... */
+      DPRINT(5,("reloc address=%lx,addend=%lx\n",r->address,r->addend));
+      values = &section->contents[r->address];
+
+      switch (type)
+	{
+	case 2: case 5: /* adjust byte */
+	  x = ((char *)values)[0] + r->addend;
+	  values[0] = x & 0xff;
+	  break;
+	case 1: case 4: /* adjust word */
+	  k = values[1] | (values[0] << 8);
+	  x = (int)k + r->addend;
+	  values[0] = (x & 0xff00) >> 8;
+	  values[1] = x & 0xff;
+	  break;
+	case 0: case 3: /* adjust long */
+	  k = values[3] | (values[2] << 8) | (values[1] << 16) |
+	    (values[0] << 24);
+	  x = (int)k + r->addend;
+	  values[3] = x & 0xff;
+	  values[2] = (x & 0xff00) >> 8;
+	  values[1] = (x & 0xff0000) >> 16;
+	  values[0] = ((unsigned int)x & 0xff000000) >> 24;
+	  break;
+	}/* of switch */
+
+      r->addend = 0;
+      DPRINT(5,("Did adjusting\n"));
+    }/* of for l */
+
+  DPRINT(5,("Did all relocs\n"));
+
+  /* We applied all the relocs, as far as possible to obtain 0 addend fields */
+  /* Write the section contents */
+  if (amiga_per_section(section)->disk_size != 0)
+    {
+      if (bfd_bwrite ((PTR)section->contents,
+		      amiga_per_section(section)->disk_size, abfd) !=
+	  amiga_per_section(section)->disk_size)
+	return FALSE;
+
+      /* pad the section on disk if necessary (to a long boundary) */
+      pad = (4 - (amiga_per_section(section)->disk_size & 3)) & 3;
+      if (pad && (bfd_bwrite ((PTR)&zero, pad, abfd) != pad))
+	return FALSE;
+    }
+
+#if 0
+  /* write bss data in the data hunk if needed */
+  for (; bss_size--;)
+    if (!write_longs (&zero, 1, abfd))
+      return FALSE;
+#endif
+
+  if (datadata_relocs)
+    {
+      datadata_relocs--;
+      if (!write_longs (&datadata_relocs, 1, abfd))
+	return FALSE;
+      for (s = 0; s < data_sec->reloc_count; s++)
+	{
+	  r = data_sec->orelocation[s];
+	  if (r == NULL)
+	    continue;
+
+	  sym_p = *(r->sym_ptr_ptr); /* The symbol for this relocation */
+	  insection = sym_p->section;
+	  /* Is reloc relative to a special section? */
+	  if (bfd_is_bfd_section(insection))
+	    continue; /* Nothing to do, since this translates to HUNK_EXT */
+
+	  if (insection->output_section == data_sec)
+	    {
+	      if (determine_type(r) == 0)
+		if (!write_longs (&r->address, 1, abfd))
+		  return FALSE;
+	    }
+	}
+    }
+
+  DPRINT(10,("Wrote contents, writing relocs now\n"));
+
+  if (reloc_count > 0) {
+    /* Sample every reloc type */
+    for (i = 0; i < NB_RELOC_TYPES; i++) {
+      int written = FALSE;
+      for (j = 0; j <= max_hunk; j++) {
+	long relocs;
+	while ((relocs = reloc_counts[i+(j*NB_RELOC_TYPES)]) > 0) {
+
+	  if (!written) {
+	    if (!write_longs (&reloc_types[i], 1, abfd))
+	      return FALSE;
+	    written = TRUE;
+	  }
+
+	  if (relocs > 0xffff)
+	    relocs = 0xffff;
+
+	  n[0] = relocs;
+	  n[1] = j;
+	  if (!write_longs (n, 2, abfd))
+	    return FALSE;
+
+	  reloc_counts[i+(j*NB_RELOC_TYPES)] -= relocs;
+	  reloc_count -= relocs;
+
+	  for (k = 0; k < section->reloc_count; k++) {
+	    int jj;
+
+	    r = section->orelocation[k];
+	    if (r == NULL) /* already written */
+	      continue;
+
+	    sym_p = *(r->sym_ptr_ptr); /* The symbol for this relocation */
+	    insection = sym_p->section;
+	    /* Is reloc relative to a special section? */
+	    if (bfd_is_bfd_section(insection))
+	      continue; /* Nothing to do, since this translates to HUNK_EXT */
+#if 0
+	    /* Determine which hunk to write, and index of target */
+	    for (jj = 0, sec = abfd->sections; sec; sec = sec->next, jj++) {
+	      if (sec == insection->output_section)
+		break;
+	    }
+	    BFD_ASSERT (jj==index_map[insection->output_section->index]);
+#else
+	    jj=index_map[insection->output_section->index];
+#endif
+	    if (jj == j && i == determine_type(r)) {
+	      section->orelocation[k] = NULL;
+	      if (!write_longs (&r->address, 1, abfd))
+		return FALSE;
+	      if (--relocs == 0)
+		break;
+	    }
+	  }
+	}
+      }
+      /* write a zero to finish the relocs */
+      if (written && !write_longs (&zero, 1, abfd))
+	return FALSE;
+    }
+  }
+
+  bfd_release (abfd, reloc_counts);
+  DPRINT(5,("Leaving write_section...\n"));
+  if (reloc_count > 0) {
+    bfd_set_error (bfd_error_nonrepresentable_section);
+    return FALSE;
+  }
+  return TRUE;
+}
+
+
+/* Write out symbol information, including HUNK_EXT, DEFS, ABS.
+   In the case, we were linking base relative, the symbols of the .bss
+   hunk have been converted already to belong to the .data hunk */
+
+static bfd_boolean
+amiga_write_symbols (abfd, section)
+     bfd *abfd;
+     sec_ptr section;
+{
+  sec_ptr osection;
+  asymbol *sym_p;
+  arelent *r;
+  unsigned long n[3],symbol_header,type;
+  unsigned int i,j,idx,ncnt,symbol_count;
+
+  /* If base rel linking and section is .bss ==> exit */
+  if (amiga_base_relative && !strcmp(section->name,".bss"))
+    return TRUE;
+
+  if (section->reloc_count==0 && bfd_get_symcount (abfd)==0)
+    {/* Write HUNK_END */
+    alldone:
+      DPRINT(5,("Leaving write_symbols\n"));
+      n[0]=HUNK_END;
+      return write_longs (n, 1, abfd);
+    }
+
+  /* If this is Loadfile, then do not write HUNK_EXT, but rather HUNK_SYMBOL */
+  symbol_header = AMIGA_DATA(abfd)->IsLoadFile ? HUNK_SYMBOL : HUNK_EXT;
+
+  /* Write out all the symbol definitions, then HUNK_END
+
+     Now, first traverse the relocs, all entries that are non NULL
+     have to be taken into account */
+  symbol_count = 0;
+
+  DPRINT(10,("Traversing relocation table\n"));
+  for (i=0;i<section->reloc_count;i++)
+    {
+      r=section->orelocation[i];
+      if (r==NULL)
+	continue;
+
+      sym_p=*(r->sym_ptr_ptr); /* The symbol for this relocation */
+      osection=sym_p->section; /* The section the symbol belongs to */
+      /* this section MUST be a special section */
+
+      DPRINT(5,("Symbol is %s, section is %lx(%s)\n",sym_p->name,osection,osection->name));
+
+      /* group together relocations referring to the same symbol and howto */
+      for(idx=i,j=i+1;j<section->reloc_count;j++)
+	{
+	  arelent *rj=section->orelocation[j];
+	  if (rj==NULL || sym_p!=*(rj->sym_ptr_ptr) || r->howto!=rj->howto)
+	    continue; /* no match */
+	  if (++i == j)
+	    continue; /* adjacent */
+	  section->orelocation[j] = section->orelocation[i];
+	  section->orelocation[i] = rj;
+	}
+
+      if ((symbol_count++)==0) /* First write out the HUNK_EXT */
+	{
+	  if (!write_longs (&symbol_header, 1, abfd))
+	    return FALSE;
+	}
+
+      if (!bfd_is_com_section(osection)) /* Not common symbol */
+	{
+	  DPRINT(5,("Non common ref\n"));
+	  /* Determine type of ref */
+	  switch (r->howto->type)
+	    {
+	    case H_ABS8:
+	    case H_PC8:
+	      type=EXT_RELREF8;
+	      break;
+
+	    case H_ABS16:
+	    case H_PC16:
+	      type=EXT_RELREF16;
+	      break;
+
+	    case H_ABS32:
+	      type=EXT_ABSREF32;
+	      break;
+
+	    case H_PC32:
+	      type=EXT_RELREF32;
+	      break;
+
+	    case H_SD8:
+	      type=EXT_DEXT8;
+	      break;
+
+	    case H_SD16:
+	      type=EXT_DEXT16;
+	      break;
+
+	    case H_SD32:
+	      type=EXT_DEXT32;
+	      break;
+
+	    case H_PC26:
+	      type=EXT_RELREF26;
+	      break;
+
+	    default: /* Error, can't represent this */
+	      bfd_msg ("unexpected reloc %d(%s) at offset 0x%lx",
+		       r->howto->type, r->howto->name, bfd_tell (abfd));
+	      bfd_set_error (bfd_error_nonrepresentable_section);
+	      return FALSE;
+	      break;
+	    }/* Of switch */
+	  ncnt=0;
+	}/* Of is ref to undefined or abs symbol */
+      else /* ref to common symbol */
+	{
+	  DPRINT(5,("Common ref\n"));
+	  switch (r->howto->type)
+	    {
+	    default:
+	      bfd_msg ("Warning: bad reloc %s for common symbol %s",
+		       r->howto->name, sym_p->name);
+	    case H_ABS32:
+	      type=EXT_ABSCOMMON;
+	      break;
+
+	    case H_SD8:
+	      type=EXT_DEXT8COMMON;
+	      break;
+
+	    case H_SD16:
+	      type=EXT_DEXT16COMMON;
+	      break;
+
+	    case H_SD32:
+	      type=EXT_DEXT32COMMON;
+	      break;
+	    }/* Of switch */
+	  n[0]=sym_p->value; /* Size of common block */
+	  ncnt=1;
+	}/* Of is common section */
+
+	DPRINT(5,("Type is %lx\n",type));
+	if (!write_name (abfd, sym_p->name, type << 24))
+	  return FALSE;
+	n[ncnt]=i-idx+1; /* refs for symbol... */
+	if (!write_longs (n, ncnt+1, abfd))
+	  return FALSE;
+	for(;idx<=i;++idx)
+	  {
+	    n[0]=section->orelocation[idx]->address;
+	    if (!write_longs (n, 1, abfd))
+	      return FALSE;
+	  }
+    }/* Of traverse relocs */
+
+  /* Now traverse the symbol table and write out all definitions, that are relative
+     to this hunk.
+     Absolute defs are always only written out with the first hunk.
+     Don't write out:
+	local symbols
+	undefined symbols
+	indirect symbols
+	warning symbols
+	debugging symbols
+	warning symbols
+	constructor symbols
+     since they are unrepresentable in HUNK format.. */
+
+  DPRINT(10,("Traversing symbol table\n"));
+  for (i=0;i<bfd_get_symcount (abfd);i++)
+    {
+      sym_p=abfd->outsymbols[i];
+      osection=sym_p->section;
+
+      DPRINT(5,("%d: symbol(%s), osec=%lx(%s)\n",
+	i,sym_p->name,osection,osection?osection->name:"null"));
+
+      if (osection==NULL) /* FIXME: Happens with constructor functions. */
+	continue;
+
+      if (bfd_is_und_section(osection)
+	/*||bfd_is_com_section(osection)*/
+	  ||bfd_is_ind_section(osection))
+	continue; /* Don't write these */
+
+      /* Only write abs defs, if not writing a Loadfile */
+      if (bfd_is_abs_section(osection)&&(section->index==0)&&
+	  !AMIGA_DATA(abfd)->IsLoadFile)
+	{
+	  DPRINT(5,("Abs symbol\n"));
+	  /* don't write debug symbols, they will be written in a
+	     HUNK_DEBUG later on */
+	  if (sym_p->flags & BSF_DEBUGGING)
+	    continue;
+
+	  if ((symbol_count++)==0) /* First write out the HUNK_EXT */
+	    {
+	      if (!write_longs (&symbol_header, 1, abfd))
+		return FALSE;
+	    }
+
+	  if (!write_name (abfd, sym_p->name, EXT_ABS << 24))
+	    return FALSE;
+	  n[0]=sym_p->value;
+	  if (!write_longs (n, 1, abfd))
+	    return FALSE;
+	  continue;
+	}/* Of abs def */
+      if (bfd_is_abs_section(osection))
+	continue; /* Not first hunk, already written */
+
+      /* If it is a warning symbol, or a constructor symbol or a
+	 debugging or a local symbol, don't write it */
+      if (sym_p->flags & (BSF_WARNING|BSF_CONSTRUCTOR|BSF_DEBUGGING|BSF_LOCAL))
+	continue;
+      if ((sym_p->flags & BSF_GLOBAL) == 0)
+	continue;
+
+      /* Now, if osection==section, write it out */
+      if (osection->output_section==section)
+	{
+	  DPRINT(5,("Writing it out\n"));
+
+	  if ((symbol_count++)==0) /* First write out the header */
+	    {
+	      if (!write_longs (&symbol_header, 1, abfd))
+		return FALSE;
+	    }
+
+	  type = symbol_header == HUNK_EXT ? EXT_DEF << 24 : 0;
+	  if (!write_name (abfd, sym_p->name, type))
+	    return FALSE;
+	  n[0] = sym_p->value + sym_p->section->output_offset;
+	  if (!write_longs (n, 1, abfd))
+	    return FALSE;
+	}
+      else
+	{
+	  /* write common definitions as bss common references */
+	  if (bfd_is_com_section(osection->output_section) &&
+	      section->index == 2)
+	    {
+	      if ((symbol_count++)==0) /* First write out the header */
+		{
+		  if (!write_longs (&symbol_header, 1, abfd))
+		    return FALSE;
+		}
+
+	      if (!write_name (abfd, sym_p->name, EXT_ABSCOMMON << 24))
+		return FALSE;
+	      n[0]=sym_p->value;
+	      n[1]=0;
+	      if (!write_longs (n, 2, abfd))
+		return FALSE;
+	    }
+	}
+    }/* Of for */
+
+  DPRINT(10,("Did traversing\n"));
+  if (symbol_count) /* terminate HUNK_EXT, HUNK_SYMBOL */
+    {
+      n[0]=0;
+      if (!write_longs (n, 1, abfd))
+	return FALSE;
+    }
+  DPRINT(5,("Leaving\n"));
+  goto alldone; /* Write HUNK_END, return */
+}
+
+static bfd_boolean
+amiga_get_section_contents (abfd, section, location, offset, count)
+     bfd *abfd;
+     sec_ptr section;
+     PTR location;
+     file_ptr offset;
+     bfd_size_type count;
+{
+  unsigned long disk_size=amiga_per_section(section)->disk_size;
+
+  if (bfd_seek (abfd, section->filepos + offset, SEEK_SET))
+    return FALSE;
+
+  if (offset+count > disk_size) {
+    /* the section's size on disk may be smaller than in memory
+       in this case, pad the contents */
+    if (bfd_bread (location, disk_size-offset, abfd) != disk_size-offset)
+      return FALSE;
+    memset ((char *) location + disk_size - offset, 0, count-(disk_size-offset));
+  }
+  else {
+    if (bfd_bread (location, count, abfd) != count)
+      return FALSE;
+  }
+  return TRUE;
+}
+
+static bfd_boolean
+amiga_new_section_hook (abfd, newsect)
+     bfd *abfd;
+     sec_ptr newsect;
+{
+  newsect->used_by_bfd = (PTR) bfd_zalloc (abfd,
+					   sizeof (amiga_per_section_type));
+  newsect->alignment_power = 2;
+  if (!strcmp (newsect->name, ".data_chip")
+      || !strcmp (newsect->name, ".bss_chip"))
+    amiga_per_section(newsect)->attribute |= MEMF_CHIP;
+  return TRUE;
+}
+
+static bfd_boolean
+amiga_slurp_symbol_table (abfd)
+     bfd *abfd;
+{
+  amiga_data_type *amiga_data=AMIGA_DATA(abfd);
+  amiga_symbol_type *asp;
+  unsigned long l,len,type;
+  sec_ptr section;
+
+  if (amiga_data->symbols)
+    return TRUE; /* already read */
+
+  if (!bfd_get_symcount (abfd))
+    return TRUE;
+
+  asp = (amiga_symbol_type *) bfd_zalloc (abfd, sizeof (amiga_symbol_type) *
+					  bfd_get_symcount (abfd));
+  if ((amiga_data->symbols = asp) == NULL)
+    return FALSE;
+
+  /* Symbols are associated with every section */
+  for (section=abfd->sections; section!=NULL; section=section->next)
+    {
+      amiga_per_section_type *asect=amiga_per_section(section);
+
+      if (asect->hunk_ext_pos == 0)
+	continue;
+
+      if (bfd_seek (abfd, asect->hunk_ext_pos, SEEK_SET))
+	return FALSE;
+
+      for (asect->amiga_symbols=asp; get_long (abfd, &l) && l; asp++)
+	{
+	  type = l>>24;	/* type of entry */
+	  len = (l & 0xffffff) << 2; /* namelength */
+
+	  /* read the name */
+	  if ((asp->symbol.name = bfd_alloc (abfd, len+1))==NULL)
+	    return FALSE;
+	  if (bfd_bread ((PTR)asp->symbol.name, len, abfd) != len)
+	    return FALSE;
+	  ((char *)asp->symbol.name)[len] = '\0';
+
+	  asp->symbol.the_bfd = abfd;
+	  asp->symbol.flags = BSF_GLOBAL;
+	  /*asp->desc = 0;
+	  asp->other = 0;*/
+	  asp->type = type;
+	  asp->index = asp - amiga_data->symbols;
+
+	  switch (type) {
+	  case EXT_ABSCOMMON: /* Common reference/definition */
+	  case EXT_DEXT32COMMON:
+	  case EXT_DEXT16COMMON:
+	  case EXT_DEXT8COMMON:
+	    asp->symbol.section = bfd_com_section_ptr;
+	    /* size of common block -> symbol's value */
+	    if (!get_long (abfd, &l))
+	      return FALSE;
+	    asp->symbol.value = l;
+	    /* skip refs */
+	    if (!get_long (abfd, &l) || bfd_seek (abfd, l<<2, SEEK_CUR))
+	      return FALSE;
+	    asp->refnum = l;
+	    break;
+	  case EXT_ABS: /* Absolute */
+	    asp->symbol.section = bfd_abs_section_ptr;
+	    goto rval;
+	    break;
+	  case EXT_DEF: /* Relative Definition */
+	  case EXT_SYMB: /* Same as EXT_DEF for load files */
+	    asp->symbol.section = section;
+	  rval:
+	    /* read the value */
+	    if (!get_long (abfd, &l))
+	      return FALSE;
+	    asp->symbol.value = l;
+	    break;
+	  default: /* References to an undefined symbol */
+	    asp->symbol.section = bfd_und_section_ptr;
+	    asp->symbol.flags = 0;
+	    /* skip refs */
+	    if (!get_long (abfd, &l) || bfd_seek (abfd, l<<2, SEEK_CUR))
+	      return FALSE;
+	    asp->refnum = l;
+	    break;
+	  }
+	}
+    }
+  return TRUE;
+}
+
+
+/* Get size of symtab */
+static long
+amiga_get_symtab_upper_bound (abfd)
+     bfd *abfd;
+{
+  if (!amiga_slurp_symbol_table (abfd))
+    return -1;
+  return (bfd_get_symcount (abfd)+1) * (sizeof (amiga_symbol_type *));
+}
+
+
+static long
+amiga_get_symtab (abfd, location)
+     bfd *abfd;
+     asymbol **location;
+{
+  if(!amiga_slurp_symbol_table (abfd))
+    return -1;
+  if (bfd_get_symcount (abfd))
+    {
+      amiga_symbol_type *symp=AMIGA_DATA(abfd)->symbols;
+      unsigned int i;
+      for (i = 0; i < bfd_get_symcount (abfd); i++, symp++)
+	*location++ = &symp->symbol;
+      *location = 0;
+    }
+  return bfd_get_symcount (abfd);
+}
+
+
+static asymbol *
+amiga_make_empty_symbol (abfd)
+     bfd *abfd;
+{
+  amiga_symbol_type *new =
+    (amiga_symbol_type *) bfd_zalloc (abfd, sizeof (amiga_symbol_type));
+  new->symbol.the_bfd = abfd;
+  return &new->symbol;
+}
+
+
+static void
+amiga_get_symbol_info (ignore_abfd, symbol, ret)
+     bfd *ignore_abfd ATTRIBUTE_UNUSED;
+     asymbol *symbol;
+     symbol_info *ret;
+{
+  bfd_symbol_info (symbol, ret);
+  if (symbol->name[0] == ' ')
+    ret->name = "* empty table entry ";
+  if (bfd_is_abs_section(symbol->section))
+    ret->type = (symbol->flags & BSF_LOCAL) ? 'a' : 'A';
+}
+
+
+static void
+amiga_print_symbol (abfd, afile,  symbol, how)
+     bfd *abfd;
+     PTR afile;
+     asymbol *symbol;
+     bfd_print_symbol_type how;
+{
+  FILE *file = (FILE *)afile;
+
+  switch (how) {
+  case bfd_print_symbol_name:
+    fprintf (file, "%s", symbol->name);
+    break;
+  case bfd_print_symbol_more:
+    fprintf (file, "%4lx %2x",
+	     amiga_symbol(symbol)->refnum,
+	     (unsigned int)amiga_symbol(symbol)->type);
+    break;
+  case bfd_print_symbol_all:
+    if (symbol->name[0] == ' ')
+      {
+	fprintf (file, "* empty table entry ");
+      }
+    else
+      {
+	bfd_print_symbol_vandf (abfd, (PTR)file, symbol);
+	fprintf (file, " %-10s %04lx %02x %s",
+		 symbol->section->name,
+		 amiga_symbol(symbol)->refnum,
+		 (unsigned int)amiga_symbol(symbol)->type,
+		 symbol->name);
+      }
+    break;
+  }
+}
+
+
+static long
+amiga_get_reloc_upper_bound (abfd, asect)
+     bfd *abfd ATTRIBUTE_UNUSED;
+     sec_ptr asect;
+{
+  return (asect->reloc_count + 1) * sizeof (arelent *);
+}
+
+
+static bfd_boolean
+read_raw_relocs (abfd, section, d_offset, count)
+     bfd *abfd;
+     sec_ptr section;
+     unsigned long d_offset;	/* offset in the bfd */
+     unsigned long count;	/* number of relocs */
+{
+  unsigned long hunk_number,offset,type,no,j;
+  reloc_howto_type *howto;
+
+  if (bfd_seek (abfd, d_offset, SEEK_SET))
+    return FALSE;
+  while ((long)count > 0)
+    {
+      /* first determine type of reloc */
+      if (!get_long (abfd, &type))
+	return FALSE;
+
+      if (type==HUNK_DREL32 && AMIGA_DATA(abfd)->IsLoadFile)
+	type = HUNK_RELOC32SHORT;
+
+      switch (type)
+	{
+	case HUNK_RELOC32SHORT:
+	  /* read reloc count, hunk number and offsets */
+	  for (howto=&howto_table[R_ABS32SHORT];;) {
+	    char buf[2];
+	    if (bfd_bread (buf, 2, abfd) != 2)
+	      return FALSE;
+	    if (no=GW(buf),!no)
+	      break;
+	    count -= no;
+	    if (bfd_bread (buf, 2, abfd) != 2)
+	      return FALSE;
+	    hunk_number = GW (buf);
+	    /* add relocs */
+	    for (j=0; j<no; j++) {
+	      if (bfd_bread (buf, 2, abfd) != 2)
+		return FALSE;
+	      offset = GW (buf);
+	      if (!amiga_add_reloc (abfd, section, offset, NULL, howto,
+				    hunk_number))
+	        return FALSE;
+	    }
+	  }
+	  break;
+
+	case HUNK_DREL32: /* 32 bit baserel */
+	case HUNK_DREL16: /* 16 bit baserel */
+	case HUNK_DREL8: /* 8 bit baserel */
+	  type -= 8;
+	case HUNK_ABSRELOC32: /* 32 bit ref */
+	case HUNK_RELRELOC16: /* 16 bit ref */
+	case HUNK_RELRELOC8: /* 8 bit ref */
+	  for (howto=&howto_table[R_ABS32+type-HUNK_ABSRELOC32];;) {
+	    /* read offsets and hunk number */
+	    if (!get_long (abfd, &no))
+	      return FALSE;
+	    if (!no)
+	      break;
+	    count -= no;
+	    if (!get_long (abfd, &hunk_number))
+	      return FALSE;
+	    /* add relocs */
+	    for (j=0; j<no; j++) {
+	      if (!get_long (abfd, &offset) ||
+		  !amiga_add_reloc (abfd, section, offset, NULL, howto,
+				    hunk_number))
+		return FALSE;
+	    }
+	  }
+	  break;
+
+	default: /* error */
+	  bfd_set_error (bfd_error_wrong_format);
+	  return FALSE;
+	  break;
+	}
+    }
+
+  return TRUE;
+}
+
+
+/* slurp in relocs, amiga_digest_file left various pointers for us */
+static bfd_boolean
+amiga_slurp_relocs (abfd, section, symbols)
+     bfd *abfd;
+     sec_ptr section;
+     asymbol **symbols ATTRIBUTE_UNUSED;
+{
+  amiga_per_section_type *asect=amiga_per_section(section);
+  reloc_howto_type *howto;
+  amiga_symbol_type *asp;
+  raw_reloc_type *relp;
+  unsigned long offset,type,n,i;
+
+  if (section->relocation)
+    return TRUE;
+
+  for (relp=asect->relocs; relp!=NULL; relp=relp->next)
+    if (relp->num && !read_raw_relocs (abfd, section, relp->pos, relp->num))
+      return FALSE;
+
+  /* Now step through the raw_symbols and add all relocs in them */
+  if (!AMIGA_DATA(abfd)->symbols && !amiga_slurp_symbol_table (abfd))
+    return FALSE;
+
+  if (asect->hunk_ext_pos == 0)
+    return TRUE;
+
+  if (bfd_seek (abfd, asect->hunk_ext_pos, SEEK_SET))
+    return FALSE;
+
+  for (asp=asect->amiga_symbols; get_long (abfd, &n) && n; asp++)
+    {
+      type = (n>>24) & 0xff;
+      n &= 0xffffff;
+
+      /* skip the name */
+      if (bfd_seek (abfd, n<<2, SEEK_CUR))
+	return FALSE;
+
+      switch (type)
+	{
+	case EXT_SYMB:
+	case EXT_DEF:
+	case EXT_ABS: /* no relocs here */
+	  if (bfd_seek (abfd, 4, SEEK_CUR))
+	    return FALSE;
+	  break;
+
+	  /* same as below, but advance lp by one to skip common size */
+	case EXT_DEXT32COMMON:
+	case EXT_DEXT16COMMON:
+	case EXT_DEXT8COMMON:
+	  type -= 75; /* convert to EXT_DEXT */
+	case EXT_ABSCOMMON:
+	  if (bfd_seek (abfd, 4, SEEK_CUR))
+	    return FALSE;
+	  /* Fall through */
+	default: /* reference to something */
+	  /* points to num of refs to hunk */
+	  if (!get_long (abfd, &n))
+	    return FALSE;
+	  /* Add relocs to this section, relative to asp */
+	  /* determine howto first */
+	  if (type==EXT_ABSCOMMON) /* 32 bit ref */
+	    howto=&howto_table[R_ABS32];
+	  else if (type==EXT_RELREF32)
+	    howto=&howto_table[R_PC32];
+	  else if (type==EXT_RELREF26)
+	    howto=&howto_table[R_PC26];
+	  else
+	    {
+	      type -= EXT_ABSREF32;
+	      if (type)
+		type--; /* skip EXT_ABSCOMMON gap */
+	      howto=&howto_table[R_ABS32+type];
+	    }/* of else */
+	  for (i=0;i<n;i++) /* refs follow */
+	    {
+	      if (!get_long (abfd, &offset))
+		return FALSE;
+	      if (!amiga_add_reloc (abfd, section, offset, abfd->outsymbols ?
+				    (amiga_symbol_type *) abfd->outsymbols[asp->index] : asp,
+				    howto, -4))
+		return FALSE;
+	    }
+	  break;
+	}/* of switch */
+    }
+  return TRUE;
+}/* Of slurp_relocs */
+
+
+static long
+amiga_canonicalize_reloc (abfd, section, relptr, symbols)
+     bfd *abfd;
+     sec_ptr section;
+     arelent **relptr;
+     asymbol **symbols;
+{
+  amiga_reloc_type *src;
+
+  if (!section->relocation && !amiga_slurp_relocs (abfd, section, symbols))
+    return -1;
+
+  for (src = (amiga_reloc_type *)section->relocation; src; src = src->next)
+    *relptr++ = &src->relent;
+  *relptr = NULL;
+
+  return section->reloc_count;
+}
+
+
+/* Set section contents */
+/* We do it the following way:
+   If this is a bss section ==> error
+   Otherwise, we try to allocate space for this section,
+   if this has not already been done
+   Then we set the memory area to the contents */
+static bfd_boolean
+amiga_set_section_contents (abfd, section, location, offset, count)
+     bfd *abfd;
+     sec_ptr section;
+     PTR location;
+     file_ptr offset;
+     bfd_size_type count;
+{
+  if ((section->flags&SEC_HAS_CONTENTS)==0) /* BSS */
+    {
+      bfd_set_error (bfd_error_no_contents);
+      return FALSE;
+    }
+
+  if ((section->flags&SEC_IN_MEMORY)==0) /* Not in memory, so alloc space */
+    {
+      section->contents = (bfd_byte *) bfd_zalloc (abfd, section->_raw_size);
+      if (section->contents == NULL)
+	return FALSE;
+      section->flags |= SEC_IN_MEMORY;
+      DPRINT(5,("Allocated %lx bytes at %lx\n",section->_raw_size,section->contents));
+    }
+
+  /* Copy mem */
+  memmove(&section->contents[offset],location,count);
+
+  return TRUE;
+}/* Of set_section_contents */
+
+
+/* FIXME: Is this everything? */
+static bfd_boolean
+amiga_set_arch_mach (abfd, arch, machine)
+     bfd *abfd;
+     enum bfd_architecture arch;
+     unsigned long machine;
+{
+  bfd_default_set_arch_mach(abfd, arch, machine);
+  if (arch == bfd_arch_m68k)
+    {
+      switch (machine)
+	{
+	case bfd_mach_m68000:
+	case bfd_mach_m68008:
+	case bfd_mach_m68010:
+	case bfd_mach_m68020:
+	case bfd_mach_m68030:
+	case bfd_mach_m68040:
+	case bfd_mach_m68060:
+	case 0:
+	  return TRUE;
+	default:
+	  break;
+	}
+    }
+  return FALSE;
+}
+
+static int
+amiga_sizeof_headers (ignore_abfd, ignore)
+     bfd *ignore_abfd ATTRIBUTE_UNUSED;
+     bfd_boolean ignore ATTRIBUTE_UNUSED;
+{
+  /* The amiga hunk format doesn't have headers. */
+  return 0;
+}
+
+/* Provided a BFD, a section and an offset into the section, calculate
+   and return the name of the source file and the line nearest to the
+   wanted location.  */
+bfd_boolean
+amiga_find_nearest_line (abfd, section, symbols, offset, filename_ptr,
+			 functionname_ptr, line_ptr)
+     bfd *abfd ATTRIBUTE_UNUSED;
+     sec_ptr section ATTRIBUTE_UNUSED;
+     asymbol **symbols ATTRIBUTE_UNUSED;
+     bfd_vma offset ATTRIBUTE_UNUSED;
+     const char **filename_ptr ATTRIBUTE_UNUSED;
+     const char **functionname_ptr ATTRIBUTE_UNUSED;
+     unsigned int *line_ptr ATTRIBUTE_UNUSED;
+{
+  /* FIXME (see aoutx.h, for example) */
+  return FALSE;
+}
+
+static reloc_howto_type *
+amiga_bfd_reloc_type_lookup (abfd, code)
+     bfd *abfd ATTRIBUTE_UNUSED;
+     bfd_reloc_code_real_type code;
+{
+  DPRINT(5,("reloc: %s (%d)\n",bfd_get_reloc_code_name(code),code));
+  switch (code)
+    {
+    case BFD_RELOC_8_PCREL:    return &howto_table[R_PC8];
+    case BFD_RELOC_16_PCREL:   return &howto_table[R_PC16];
+    case BFD_RELOC_32_PCREL:   return &howto_table[R_PC32];
+    case BFD_RELOC_8:          return &howto_table[R_PC8];
+    case BFD_RELOC_16:         return &howto_table[R_PC16];
+    case BFD_RELOC_32:         return &howto_table[R_ABS32];
+    case BFD_RELOC_8_BASEREL:  return &howto_table[R_SD8];
+    case BFD_RELOC_16_BASEREL: return &howto_table[R_SD16];
+    case BFD_RELOC_32_BASEREL: return &howto_table[R_SD32];
+    case BFD_RELOC_CTOR:       return &howto_table[R_ABS32];
+      /* FIXME: everything handled? */
+    default:                   return NULL;
+    }
+}
+
+static bfd_boolean
+amiga_bfd_copy_private_bfd_data (ibfd, obfd)
+     bfd *ibfd;
+     bfd *obfd;
+{
+  if (bfd_get_flavour (ibfd) == bfd_target_amiga_flavour
+      && bfd_get_flavour (obfd) == bfd_target_amiga_flavour) {
+    AMIGA_DATA(obfd)->IsLoadFile = AMIGA_DATA(ibfd)->IsLoadFile;
+  }
+  return TRUE;
+}
+
+static bfd_boolean
+amiga_bfd_copy_private_section_data (ibfd, isec, obfd, osec)
+     bfd *ibfd ATTRIBUTE_UNUSED;
+     sec_ptr isec;
+     bfd *obfd ATTRIBUTE_UNUSED;
+     sec_ptr osec;
+{
+  if (bfd_get_flavour (osec->owner) == bfd_target_amiga_flavour
+      && bfd_get_flavour (isec->owner) == bfd_target_amiga_flavour) {
+    amiga_per_section(osec)->disk_size = amiga_per_section(isec)->disk_size;
+    amiga_per_section(osec)->attribute = amiga_per_section(isec)->attribute;
+  }
+  return TRUE;
+}
+
+/* There is no armap in the amiga libraries, so we fill carsym entries
+   one by one after having parsed the whole archive. */
+static bfd_boolean
+amiga_slurp_armap (abfd)
+     bfd *abfd;
+{
+  struct arch_syms *syms;
+  carsym *defsyms,*csym;
+  unsigned long symcount;
+
+  /* allocate the carsyms */
+  syms = amiga_ardata(abfd)->defsyms;
+  symcount = amiga_ardata(abfd)->defsym_count;
+
+  defsyms = (carsym *) bfd_alloc (abfd, sizeof (carsym) * symcount);
+  if (!defsyms)
+    return FALSE;
+
+  bfd_ardata(abfd)->symdefs = defsyms;
+  bfd_ardata(abfd)->symdef_count = symcount;
+
+  for (csym = defsyms; syms; syms = syms->next) {
+    unsigned long type, len, n;
+    char *symblock;
+    if (bfd_seek (abfd, syms->offset, SEEK_SET))
+      return FALSE;
+    symblock = (char *) bfd_alloc (abfd, syms->size);
+    if (!symblock)
+      return FALSE;
+    if (bfd_bread (symblock, syms->size, abfd) != syms->size)
+      return FALSE;
+    while (n=GL(symblock),n)
+      {
+	symblock += 4;
+	len = n & 0xffffff;
+	type = (n>>24) & 0xff;
+	switch (type) {
+	case EXT_SYMB:
+	case EXT_DEF:
+	case EXT_ABS:
+	  len <<= 2;
+	  csym->name = symblock;
+	  csym->name[len] = '\0';
+	  csym->file_offset = syms->unit_offset;
+	  csym++;
+	  symblock += len+4; /* name+value */
+	  break;
+	case EXT_ABSREF32:
+	case EXT_RELREF16:
+	case EXT_RELREF8:
+	case EXT_DEXT32:
+	case EXT_DEXT16:
+	case EXT_DEXT8:
+	case EXT_RELREF32:
+	case EXT_RELREF26:
+	  symblock += len<<2;
+	  symblock += (1+GL (symblock))<<2;
+	  break;
+	case EXT_ABSCOMMON:
+	case EXT_DEXT32COMMON:
+	case EXT_DEXT16COMMON:
+	case EXT_DEXT8COMMON:
+	  symblock += (len<<2)+4;
+	  symblock += (1+GL (symblock))<<2;
+	  break;
+	default: /* error */
+	  bfd_msg ("unexpected type %ld(0x%lx) in hunk_ext3 at offset 0x%lx",
+		   type, type, bfd_tell (abfd));
+	  return FALSE;
+	}
+      }
+  }
+  bfd_has_map (abfd) = TRUE;
+  return TRUE;
+}
+
+static void
+amiga_truncate_arname (abfd, pathname, arhdr)
+     bfd *abfd ATTRIBUTE_UNUSED;
+     const char *pathname ATTRIBUTE_UNUSED;
+     char *arhdr ATTRIBUTE_UNUSED;
+{
+}
+
+static const struct bfd_target *
+amiga_archive_p (abfd)
+     bfd *abfd;
+{
+  struct arch_syms *symbols=NULL;
+  struct stat stat_buffer;
+  symindex symcount=0;
+  int units;
+
+  if (bfd_stat (abfd, &stat_buffer) < 0)
+    {
+      bfd_set_error (bfd_error_wrong_format);
+      return NULL;
+    }
+
+  if (stat_buffer.st_size != 0)
+    {
+      /* scan the units */
+      if (!parse_archive_units (abfd, &units, stat_buffer.st_size, FALSE,
+				&symbols, &symcount))
+	{
+	  bfd_set_error (bfd_error_wrong_format);
+	  return NULL;
+	}
+
+      /* if there is only one unit, file suffix is not .a and .lib, we
+	 consider it an object, not an archive. Obviously it's not
+	 always true but taking objects for archives makes ld fail,
+	 so we don't have much of a choice */
+      if (units == 1)
+	{
+	  char *p = strrchr (abfd->filename, '.');
+	  if (p == NULL || (strcmp (p, ".a") && strcmp (p, ".lib")))
+	    {
+	      bfd_set_error (bfd_error_wrong_format);
+	      return NULL;
+	    }
+	}
+    }
+
+  if (abfd->arelt_data)
+    arelt_size (abfd) = bfd_tell (abfd);
+
+  bfd_seek (abfd, 0, SEEK_SET);
+  abfd->arch_info = bfd_scan_arch ("m68k:68000");
+
+  if (amiga_mkarchive (abfd))
+    {
+      bfd_ardata(abfd)->first_file_filepos = 0;
+      amiga_ardata(abfd)->filesize = stat_buffer.st_size;
+      amiga_ardata(abfd)->defsyms = symbols;
+      amiga_ardata(abfd)->defsym_count = symcount;
+      if (amiga_slurp_armap (abfd))
+	return abfd->xvec;
+    }
+
+  return NULL;
+}
+
+static bfd *
+amiga_openr_next_archived_file (archive, last_file)
+     bfd *archive;
+     bfd *last_file;
+{
+  file_ptr filestart;
+
+  if (!last_file)
+    filestart = bfd_ardata (archive)->first_file_filepos;
+  else
+    {
+      unsigned int size = arelt_size (last_file);
+      /* Pad to an even boundary... */
+      filestart = last_file->origin + size;
+      filestart += filestart % 2;
+    }
+
+  return _bfd_get_elt_at_filepos (archive, filestart);
+}
+
+static PTR
+amiga_read_ar_hdr (abfd)
+     bfd *abfd;
+{
+  struct areltdata *ared;
+  unsigned long start_pos,len;
+  char buf[8],*base,*name;
+
+  start_pos = bfd_tell (abfd);
+  if (start_pos >= amiga_ardata(abfd)->filesize) {
+    bfd_set_error (bfd_error_no_more_archived_files);
+    return NULL;
+  }
+
+  /* get unit type and name length in long words */
+  if (bfd_bread (buf, sizeof(buf), abfd) != sizeof(buf))
+    return NULL;
+
+  if (GL (&buf[0]) != HUNK_UNIT) {
+    bfd_set_error (bfd_error_malformed_archive);
+    return NULL;
+  }
+
+  ared = bfd_zalloc (abfd, sizeof (struct areltdata));
+  if (ared == NULL)
+    return NULL;
+
+  len = GL (&buf[4]) << 2;
+
+  ared->filename = bfd_alloc (abfd, len+1 > 16 ? len+1 : 16);
+  if (ared->filename == NULL)
+    return NULL;
+
+  switch (len) {
+    default:
+      if (bfd_bread (ared->filename, len, abfd) != len)
+	return NULL;
+      ared->filename[len] = '\0';
+      /* strip path part */
+      base = strchr (name = ared->filename, ':');
+      if (base != NULL)
+	name = base + 1;
+      for (base = name; *name; ++name)
+	if (*name == '/')
+	  base = name + 1;
+      if (*base != '\0') {
+	ared->filename = base;
+	break;
+      }
+      /* Fall through */
+    case 0: /* fake a name */
+      sprintf (ared->filename, "obj-%08lu.o", ++amiga_ardata(abfd)->outnum);
+      break;
+  }
+
+  if (bfd_seek (abfd, start_pos+4, SEEK_SET))
+    return NULL;
+
+  if (!amiga_read_unit (abfd, amiga_ardata(abfd)->filesize))
+    return NULL;
+
+  ared->parsed_size = bfd_tell (abfd) - start_pos;
+  if (bfd_seek (abfd, start_pos, SEEK_SET))
+    return NULL;
+
+  return (PTR) ared;
+}
+
+static int
+amiga_generic_stat_arch_elt (abfd, buf)
+     bfd *abfd;
+     struct stat *buf;
+{
+  if (abfd->arelt_data == NULL)
+    {
+      bfd_set_error (bfd_error_invalid_operation);
+      return -1;
+    }
+
+  /* No header in amiga archives. Let's set reasonable default values */
+  buf->st_mode = 0644;
+  buf->st_uid = 0;
+  buf->st_gid = 0;
+  buf->st_mtime = 2922*24*60*60;
+  buf->st_size = arelt_size (abfd);
+
+  return 0;
+}
+
+/* Entry points through BFD_JUMP_TABLE_GENERIC */
+#define amiga_close_and_cleanup		_bfd_generic_close_and_cleanup
+#define amiga_bfd_free_cached_info	_bfd_generic_bfd_free_cached_info
+/* amiga_new_section_hook defined above */
+/* amiga_get_section_contents defined above */
+#define amiga_get_section_contents_in_window _bfd_generic_get_section_contents_in_window
+
+/* Entry points through BFD_JUMP_TABLE_COPY */
+#define amiga_bfd_merge_private_bfd_data _bfd_generic_bfd_merge_private_bfd_data
+/*#define amiga_bfd_copy_private_section_data _bfd_generic_bfd_copy_private_section_data*/
+#define amiga_bfd_copy_private_symbol_data _bfd_generic_bfd_copy_private_symbol_data
+#define amiga_bfd_set_private_flags _bfd_generic_bfd_set_private_flags
+#define amiga_bfd_print_private_bfd_data _bfd_generic_bfd_print_private_bfd_data
+
+/* Entry points through BFD_JUMP_TABLE_ARCHIVE */
+/*#define amiga_slurp_armap		bfd_slurp_armap*/
+#define amiga_slurp_extended_name_table	_bfd_slurp_extended_name_table
+#define amiga_construct_extended_name_table _bfd_archive_bsd_construct_extended_name_table
+/*#define amiga_truncate_arname		bfd_gnu_truncate_arname*/
+/*#define amiga_write_armap		bsd_write_armap*/
+/*#define amiga_read_ar_hdr		_bfd_generic_read_ar_hdr*/
+/*#define amiga_openr_next_archived_file	bfd_generic_openr_next_archived_file*/
+#define amiga_get_elt_at_index		_bfd_generic_get_elt_at_index
+/*#define amiga_generic_stat_arch_elt	bfd_generic_stat_arch_elt*/
+#define amiga_update_armap_timestamp	_bfd_archive_bsd_update_armap_timestamp
+
+/* Entry points through BFD_JUMP_TABLE_SYMBOLS */
+/* amiga_get_symtab_upper_bound defined above */
+/* amiga_get_symtab defined above */
+/* amiga_make_empty_symbol defined above */
+/* amiga_print_symbol defined above */
+/* amiga_get_symbol_info defined above */
+#define amiga_bfd_is_local_label_name	bfd_generic_is_local_label_name
+#define amiga_get_lineno		(alent * (*)(bfd *, asymbol *)) bfd_nullvoidptr
+/* amiga_find_nearest_line defined above */
+#define amiga_bfd_make_debug_symbol	(asymbol * (*)(bfd *, PTR, unsigned long)) bfd_nullvoidptr
+#define amiga_read_minisymbols		_bfd_generic_read_minisymbols
+#define amiga_minisymbol_to_symbol	_bfd_generic_minisymbol_to_symbol
+
+/* Entry points through BFD_JUMP_TABLE_LINK
+   NOTE: We use a special get_relocated_section_contents both in amiga AND in a.out files.
+   In addition, we use an own final_link routine, which is nearly identical to _bfd_generic_final_link */
+bfd_byte *
+get_relocated_section_contents PARAMS ((bfd *, struct bfd_link_info *,
+	struct bfd_link_order *, bfd_byte *, bfd_boolean, asymbol **));
+#define amiga_bfd_get_relocated_section_contents get_relocated_section_contents
+#define amiga_bfd_relax_section		bfd_generic_relax_section
+#define amiga_bfd_link_hash_table_create _bfd_generic_link_hash_table_create
+#define amiga_bfd_link_hash_table_free	_bfd_generic_link_hash_table_free
+#define amiga_bfd_link_add_symbols	_bfd_generic_link_add_symbols
+#define amiga_bfd_link_just_syms	_bfd_generic_link_just_syms
+bfd_boolean amiga_final_link PARAMS ((bfd *, struct bfd_link_info *));
+#define amiga_bfd_final_link		amiga_final_link
+#define amiga_bfd_link_split_section	_bfd_generic_link_split_section
+#define amiga_bfd_gc_sections		bfd_generic_gc_sections
+#define amiga_bfd_merge_sections	bfd_generic_merge_sections
+#define amiga_bfd_discard_group		bfd_generic_discard_group
+
+#if defined (amiga)
+#undef amiga /* So that the JUMP_TABLE() macros below can work.  */
+#endif
+
+const bfd_target amiga_vec =
+{
+  "amiga",		/* name */
+  bfd_target_amiga_flavour,
+  BFD_ENDIAN_BIG,	/* data byte order */
+  BFD_ENDIAN_BIG,	/* header byte order */
+  HAS_RELOC | EXEC_P | HAS_LINENO | HAS_DEBUG | HAS_SYMS | HAS_LOCALS | WP_TEXT, /* object flags */
+  SEC_HAS_CONTENTS | SEC_ALLOC | SEC_LOAD | SEC_RELOC | SEC_CODE | SEC_DATA, /* section flags */
+  '_',			/* symbol leading char */
+  ' ',			/* ar_pad_char */
+  15,			/* ar_max_namelen (15 for UNIX compatibility) */
+  bfd_getb64, bfd_getb_signed_64, bfd_putb64,
+  bfd_getb32, bfd_getb_signed_32, bfd_putb32,
+  bfd_getb16, bfd_getb_signed_16, bfd_putb16, /* data */
+  bfd_getb64, bfd_getb_signed_64, bfd_putb64,
+  bfd_getb32, bfd_getb_signed_32, bfd_putb32,
+  bfd_getb16, bfd_getb_signed_16, bfd_putb16, /* hdrs */
+  {
+    /* bfd_check_format */
+    _bfd_dummy_target,
+    amiga_object_p,
+    amiga_archive_p,
+    _bfd_dummy_target
+  },
+  {
+    /* bfd_set_format */
+    bfd_false,
+    amiga_mkobject,
+    amiga_mkarchive,
+    bfd_false
+  },
+  {
+    /* bfd_write_contents */
+    bfd_false,
+    amiga_write_object_contents,
+    amiga_write_archive_contents,
+    bfd_false
+  },
+  BFD_JUMP_TABLE_GENERIC (amiga),
+  BFD_JUMP_TABLE_COPY (amiga),
+  BFD_JUMP_TABLE_CORE (_bfd_nocore),
+  BFD_JUMP_TABLE_ARCHIVE (amiga),
+  BFD_JUMP_TABLE_SYMBOLS (amiga),
+  BFD_JUMP_TABLE_RELOCS (amiga),
+  BFD_JUMP_TABLE_WRITE (amiga),
+  BFD_JUMP_TABLE_LINK (amiga),
+  BFD_JUMP_TABLE_DYNAMIC (_bfd_nodynamic),
+  NULL,
+  NULL
+};
diff --git a/bfd/amigaoslink.c b/bfd/amigaoslink.c
new file mode 100644
index 0000000000000000000000000000000000000000..9067a0a06b933c67bfd3542b299d1adb281182c3
--- /dev/null
+++ bfd/amigaoslink.c
@@ -0,0 +1,1032 @@
+/* BFD back-end for Commodore-Amiga AmigaOS binaries. Linker routines.
+   Copyright (C) 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998
+   Free Software Foundation, Inc.
+   Contributed by Stephan Thesing.
+
+This file is part of BFD, the Binary File Descriptor library.
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */
+
+/*
+INODE
+amigalink, , implementation, amiga
+SECTION
+	amigalink
+
+This is the description of the linker routines for the amiga.
+In fact, this includes a description of the changes made to the
+a.out code, in order to build a working linker for the Amiga.
+@menu
+@* alterations::
+@end menu
+
+INODE
+alterations, , , amigalink
+SUBSECTION
+	alterations
+
+The file @file{aout-amiga.c} defines the amiga a.out backend. It differs from
+the sun3 backend only in these details:
+	o The @code{final_link} routine is @code{amiga_final_link}.
+	o The routine to get the relocated section contents is
+	  @code{get_relocated_section_contents}.
+
+This ensures that the link is performed properly, but has the side effect of
+loosing performance.
+
+The amiga bfd code uses the same functions since they check for the used flavour.
+@@*
+
+The usage of a special linker code has one reason:
+The bfd library assumes that a program is always loaded at a known memory
+address. This is not a case on an Amiga. So the Amiga format has to take over
+some relocs to an executable output file.
+This is not the case with a.out formats, so there relocations can be applied at link time,
+not at run time, like on the Amiga.
+The special routines compensate this: instead of applying the relocations, they are
+copied to the output file, if neccessary.
+As as consequence, @code{final_link} and @code{get_relocated_section_contents} are nearly identical to
+the original routines from @file{linker.c} and @file{reloc.c}.
+*/
+
+#include "bfd.h"
+#include "sysdep.h"
+#include "libbfd.h"
+#include "bfdlink.h"
+#include "genlink.h"
+#include "libamiga.h"
+
+#define bfd_msg (*_bfd_error_handler)
+
+/*#define DEBUG_AMIGA 1*/
+#if DEBUG_AMIGA
+#include <stdarg.h>
+static void
+error_print (const char *fmt, ...)
+{
+  va_list args;
+  va_start (args, fmt);
+  vfprintf (stderr, fmt, args);
+  va_end (args);
+}
+#define DPRINT(L,x) if (L>=DEBUG_AMIGA) error_print x
+#else
+#define DPRINT(L,x)
+#endif
+
+/* This one is used by the linker and tells us, if a debug hunk should be
+   written out */
+int write_debug_hunk = 1;
+
+/* This is also used by the linker to set the attribute of sections */
+int amiga_attribute = 0;
+
+/* This one is used to indicate base-relative linking */
+int amiga_base_relative = 0;
+
+/* This one is used to indicate -resident linking */
+int amiga_resident = 0;
+
+bfd_boolean
+default_indirect_link_order PARAMS ((bfd *, struct bfd_link_info *,
+	 asection *, struct bfd_link_order *, bfd_boolean));
+bfd_byte *
+get_relocated_section_contents PARAMS ((bfd *, struct bfd_link_info *,
+	struct bfd_link_order *, bfd_byte *, bfd_boolean, asymbol **));
+bfd_boolean
+amiga_final_link PARAMS ((bfd *, struct bfd_link_info *));
+bfd_boolean
+aout_amiga_final_link PARAMS ((bfd *, struct bfd_link_info *));
+
+static bfd_reloc_status_type
+my_add_to PARAMS ((arelent *, PTR, int, int));
+static bfd_reloc_status_type
+amiga_perform_reloc PARAMS ((bfd *, arelent *, PTR, sec_ptr, bfd *, char **));
+static bfd_reloc_status_type
+aout_perform_reloc PARAMS ((bfd *, arelent *, PTR, sec_ptr, bfd *, char **));
+static bfd_boolean
+amiga_reloc_link_order PARAMS ((bfd *, struct bfd_link_info *, asection *,
+	struct bfd_link_order *));
+
+enum { ADDEND_UNSIGNED=0x01, RELOC_SIGNED=0x02 };
+
+
+/* This one is nearly identical to bfd_generic_get_relocated_section_contents
+   in reloc.c */
+bfd_byte *
+get_relocated_section_contents (abfd, link_info, link_order, data,
+				relocateable, symbols)
+     bfd *abfd;
+     struct bfd_link_info *link_info;
+     struct bfd_link_order *link_order;
+     bfd_byte *data;
+     bfd_boolean relocateable;
+     asymbol **symbols;
+{
+  /* Get enough memory to hold the stuff.  */
+  bfd *input_bfd = link_order->u.indirect.section->owner;
+  asection *input_section = link_order->u.indirect.section;
+
+  long reloc_size = bfd_get_reloc_upper_bound (input_bfd, input_section);
+  arelent **reloc_vector = NULL;
+  long reloc_count;
+  bfd_reloc_status_type (*reloc_func)(bfd *, arelent *, PTR, sec_ptr,
+				      bfd *, char **);
+
+  DPRINT(5,("Entering get_rel_sec_cont\n"));
+
+  if (reloc_size < 0)
+    goto error_return;
+
+  if (bfd_get_flavour (input_bfd) == bfd_target_amiga_flavour)
+    reloc_func = amiga_perform_reloc;
+  else if (bfd_get_flavour (input_bfd) == bfd_target_aout_flavour)
+    reloc_func = aout_perform_reloc;
+  else
+    {
+      bfd_set_error (bfd_error_bad_value);
+      goto error_return;
+    }
+
+  reloc_vector = (arelent **) bfd_malloc ((bfd_size_type) reloc_size);
+  if (reloc_vector == NULL && reloc_size != 0)
+    goto error_return;
+
+  DPRINT(5,("GRSC: GetSecCont()\n"));
+  /* Read in the section.  */
+  if (!bfd_get_section_contents (input_bfd,
+				 input_section,
+				 (PTR) data,
+				 (bfd_vma) 0,
+				 input_section->_raw_size))
+    goto error_return;
+
+  /* We're not relaxing the section, so just copy the size info.  */
+  input_section->_cooked_size = input_section->_raw_size;
+  input_section->reloc_done = TRUE;
+
+  DPRINT(5,("GRSC: CanReloc\n"));
+  reloc_count = bfd_canonicalize_reloc (input_bfd,
+					input_section,
+					reloc_vector,
+					symbols);
+  if (reloc_count < 0)
+    goto error_return;
+
+  if (reloc_count > 0)
+    {
+      arelent **parent;
+
+      DPRINT(5,("reloc_count=%ld\n",reloc_count));
+
+      for (parent = reloc_vector; *parent != (arelent *) NULL;
+	   parent++)
+	{
+	  char *error_message = (char *) NULL;
+	  bfd_reloc_status_type r;
+
+	  DPRINT(5,("Applying a reloc\nparent=%lx, reloc_vector=%lx, "
+		    "*parent=%lx\n",parent,reloc_vector,*parent));
+	  r=(*reloc_func) (input_bfd,
+			   *parent,
+			   (PTR) data,
+			   input_section,
+			   relocateable ? abfd : (bfd *) NULL,
+			   &error_message);
+	  if (relocateable)
+	    {
+	      asection *os = input_section->output_section;
+
+	      DPRINT(5,("Keeping reloc\n"));
+	      /* A partial link, so keep the relocs.  */
+	      os->orelocation[os->reloc_count] = *parent;
+	      os->reloc_count++;
+	    }
+
+	  if (r != bfd_reloc_ok)
+	    {
+	      switch (r)
+		{
+		case bfd_reloc_undefined:
+		  if (!((*link_info->callbacks->undefined_symbol)
+			(link_info, bfd_asymbol_name (*(*parent)->sym_ptr_ptr),
+			 input_bfd, input_section, (*parent)->address,
+			 TRUE)))
+		    goto error_return;
+		  break;
+		case bfd_reloc_dangerous:
+		  BFD_ASSERT (error_message != (char *) NULL);
+		  if (!((*link_info->callbacks->reloc_dangerous)
+			(link_info, error_message, input_bfd, input_section,
+			 (*parent)->address)))
+		    goto error_return;
+		  break;
+		case bfd_reloc_overflow:
+		  if (!((*link_info->callbacks->reloc_overflow)
+			(link_info, bfd_asymbol_name (*(*parent)->sym_ptr_ptr),
+			 (*parent)->howto->name, (*parent)->addend,
+			 input_bfd, input_section, (*parent)->address)))
+		    goto error_return;
+		  break;
+		case bfd_reloc_outofrange:
+		default:
+		  DPRINT(10,("get_rel_sec_cont fails, perform reloc "
+			     "returned $%x\n",r));
+		  abort ();
+		  break;
+		}
+
+	    }
+	}
+    }
+  if (reloc_vector != NULL)
+    free (reloc_vector);
+  DPRINT(5,("GRSC: Returning ok\n"));
+  return data;
+
+error_return:
+  DPRINT(5,("GRSC: Error_return\n"));
+  if (reloc_vector != NULL)
+    free (reloc_vector);
+  return NULL;
+}
+
+
+/* Add a value to a location */
+static bfd_reloc_status_type
+my_add_to (r, data, add, flags)
+     arelent *r;
+     PTR data;
+     int add, flags;
+{
+  bfd_reloc_status_type ret=bfd_reloc_ok;
+  bfd_byte *p=((bfd_byte *)data)+r->address;
+  int val;
+
+  DPRINT(5,("Entering add_value\n"));
+
+  switch (r->howto->size)
+    {
+    case 0: /* byte size */
+      if ((flags & ADDEND_UNSIGNED) == 0)
+	val = ((*p & 0xff) ^ 0x80) - 0x80 + add;
+      else
+	val = (*p & 0xff) + add;
+      /* check for overflow */
+      if ((flags & RELOC_SIGNED) != 0) {
+	if (val<-0x80 || val>0x7f)
+	  ret = bfd_reloc_overflow;
+      }
+      else {
+	if ((val&0xffffff00)!=0 && (val&0xffffff00)!=0xffffff00)
+	  ret=bfd_reloc_overflow;
+      }
+      /* set the value */
+      *p = val & 0xff;
+      break;
+
+    case 1: /* word size */
+      if ((flags & ADDEND_UNSIGNED) == 0)
+	val = bfd_getb_signed_16 (p) + add;
+      else
+	val = bfd_getb16 (p) + add;
+      /* check for overflow */
+      if ((flags & RELOC_SIGNED) != 0) {
+	if (val<-0x8000 || val>0x7fff)
+	  ret = bfd_reloc_overflow;
+      }
+      else {
+	if ((val&0xffff0000)!=0 && (val&0xffff0000)!=0xffff0000)
+	  ret=bfd_reloc_overflow;
+      }
+      /* set the value */
+      bfd_putb16 (val, p);
+      break;
+
+    case 2: /* long word */
+      val = bfd_getb_signed_32 (p) + add;
+      /* If we are linking a resident program, then we limit the reloc size
+	 to about +/- 1 GB.
+
+	 When linking a shared library all variables defined in other
+	 libraries are placed in memory >0x80000000, so if the library
+	 tries to use one of those variables an error is output.
+
+	 Without this it would be much more difficult to check for
+	 incorrect references. */
+      if (amiga_resident &&
+	  (val & 0xc0000000)!=0 && (val&0xc0000000)!=0xc0000000) /* Overflow */
+	{
+	  ret=bfd_reloc_overflow;
+	}
+      bfd_putb32 (val, p);
+      break;
+
+    default: /* Error */
+      ret=bfd_reloc_notsupported;
+      break;
+    }/* Of switch */
+
+  DPRINT(5,("Leaving add_value\n"));
+  return ret;
+}
+
+
+/* Perform an Amiga relocation */
+static bfd_reloc_status_type
+amiga_perform_reloc (abfd, r, data, sec, obfd, error_message)
+     bfd *abfd ATTRIBUTE_UNUSED;
+     arelent *r;
+     PTR data;
+     sec_ptr sec;
+     bfd *obfd;
+     char **error_message ATTRIBUTE_UNUSED;
+{
+  asymbol *sym; /* Reloc is relative to sym */
+  sec_ptr target_section; /* reloc is relative to this section */
+  bfd_reloc_status_type ret;
+  bfd_boolean copy;
+  int relocation,flags;
+
+  DPRINT(5,("Entering APR\nflavour is %d (amiga_flavour=%d, aout_flavour=%d)\n",
+	    bfd_get_flavour (sec->owner), bfd_target_amiga_flavour,
+	    bfd_target_aout_flavour));
+
+  /* If obfd==NULL: Apply the reloc, if possible. */
+  /* Else: Modify it and return */
+
+  if (obfd!=NULL) /* Only modify the reloc */
+    {
+      r->address+=sec->output_offset;
+      sec->output_section->flags|=SEC_RELOC;
+      DPRINT(5,("Leaving amiga_perf_reloc, modified\n"));
+      return bfd_reloc_ok;
+    }
+
+  /* Try to apply the reloc */
+
+  sym=*(r->sym_ptr_ptr);
+
+  /* FIXME: XXX */
+   if (0 && sym->udata.p)
+     sym = ((struct generic_link_hash_entry *) sym->udata.p)->sym;
+
+  target_section=sym->section;
+
+  if (bfd_is_und_section(target_section)) /* Error */
+    {
+      DPRINT(10,("amiga_perf_reloc: target_sec==UND\n"));
+      return bfd_reloc_undefined;
+    }
+
+  relocation=0; flags=RELOC_SIGNED; copy=FALSE; ret=bfd_reloc_ok;
+
+  DPRINT(5,("%s: size=%u\n",r->howto->name,bfd_get_reloc_size(r->howto)));
+  switch (r->howto->type)
+    {
+    case H_ABS32:
+      if (bfd_is_abs_section(target_section)) /* Ref to absolute hunk */
+	relocation=sym->value;
+      else if (bfd_is_com_section(target_section)) /* ref to common */
+	{
+	  relocation=0;
+	  copy=TRUE;
+	}
+      else
+	{
+	  /* If we access a symbol in the .bss section, we have to convert
+	     this to an access to .data section */
+	  /* This is done through a change to the output section of
+	     the symbol.. */
+	  if (amiga_base_relative
+	      && !strcmp(target_section->output_section->name,".bss"))
+	    {
+	      /* get value for .data section */
+	      bfd *ibfd;
+	      sec_ptr s;
+
+	      ibfd=target_section->output_section->owner;
+	      for (s=ibfd->sections;s!=NULL;s=s->next)
+		if (!strcmp(s->name,".data"))
+		  {
+		    target_section->output_offset=s->_raw_size;
+		    target_section->output_section=s;
+		  }
+	    }
+	  relocation=0;
+	  copy=TRUE;
+	}
+      break;
+
+    case H_PC8: /* pcrel */
+    case H_PC16:
+    case H_PC32:
+      if (bfd_is_abs_section(target_section)) /* Ref to absolute hunk */
+	relocation=sym->value;
+      else if (bfd_is_com_section(target_section)) /* Error.. */
+	{
+	  ret=bfd_reloc_undefined;
+	}
+      else if (sec->output_section!=target_section->output_section) /* Error */
+	{
+	  DPRINT(5,("pc relative, but out-of-range\n"));
+	  ret=bfd_reloc_outofrange;
+	}
+      else /* Same section */
+	{
+	  DPRINT(5,("PC relative\n"));
+	  relocation = sym->value + target_section->output_offset
+	    - (r->address + sec->output_offset);
+	}
+      break;
+
+    case H_SD8: /* baserel */
+    case H_SD16:
+    case H_SD32:
+      /* Relocs are always relative to the symbol ___a4_init */
+      /* Relocs to .bss section are converted to a reloc to .data section,
+	 since .bss section contains only COMMON sections...... and should
+	 be following .data section.. */
+      if (bfd_is_abs_section(target_section))
+	relocation=sym->value;
+      else if (!AMIGA_DATA(target_section->output_section->owner)->baserel)
+	{
+	  bfd_msg ("Base symbol for base relative reloc not defined: "
+		   "section %s, reloc to symbol %s",sec->name,sym->name);
+	  ret=bfd_reloc_notsupported;
+	}
+      else if ((target_section->flags&SEC_CODE)!=0)
+        {
+	  bfd_msg ("%s: baserelative text relocation to \"%s\"",
+		    abfd->filename, sym->name);
+	  ret=bfd_reloc_notsupported;
+        }
+      else
+	{
+	  /* If target->out is .bss, add the value of the .data section to
+	     sym->value and set new output_section */
+	  if (!strcmp(target_section->output_section->name,".bss"))
+	    {
+	      bfd *ibfd;
+	      sec_ptr s;
+
+	      ibfd=target_section->output_section->owner;
+	      for (s=ibfd->sections;s!=NULL;s=s->next)
+		if (!strcmp(s->name,".data"))
+		  {
+		    target_section->output_offset=s->_raw_size;
+		    target_section->output_section=s;
+		  }
+	    }
+
+	  relocation = sym->value + target_section->output_offset
+	    - (AMIGA_DATA(target_section->output_section->owner))->a4init
+	    + r->addend;
+	  flags|=ADDEND_UNSIGNED;
+	}
+      break;
+
+    default:
+      bfd_msg ("Error: unsupported reloc: %s(%d)",r->howto->name,r->howto->size);
+      ret=bfd_reloc_notsupported;
+      break;
+    }/* Of switch */
+
+  /* Add in relocation */
+  if (relocation!=0)
+    ret = my_add_to (r, data, relocation, flags);
+
+  if (copy) /* Copy reloc to output section */
+    {
+      DPRINT(5,("Copying reloc\n"));
+      target_section=sec->output_section;
+      r->address+=sec->output_offset;
+      target_section->orelocation[target_section->reloc_count++]=r;
+      target_section->flags|=SEC_RELOC;
+    }
+  DPRINT(5,("Leaving amiga_perf_reloc with %d (OK=%d)\n",ret,bfd_reloc_ok));
+  return ret;
+}
+
+
+/* Perform an a.out relocation */
+static bfd_reloc_status_type
+aout_perform_reloc (abfd, r, data, sec, obfd, error_message)
+     bfd *abfd;
+     arelent *r;
+     PTR data;
+     sec_ptr sec;
+     bfd *obfd;
+     char **error_message ATTRIBUTE_UNUSED;
+{
+  asymbol *sym; /* Reloc is relative to sym */
+  sec_ptr target_section; /* reloc is relative to this section */
+  bfd_reloc_status_type ret;
+  bfd_boolean copy;
+  int relocation,flags;
+
+  DPRINT(5,("Entering aout_perf_reloc\n"));
+
+  /* If obfd==NULL: Apply the reloc, if possible. */
+  /* Else: Modify it and return */
+
+  if (obfd!=NULL) /* Only modify the reloc */
+    {
+      r->address+=sec->output_offset;
+      DPRINT(5,("Leaving aout_perf_reloc, modified\n"));
+      return bfd_reloc_ok;
+    }
+
+  /* Try to apply the reloc */
+
+  sym=*(r->sym_ptr_ptr);
+  target_section=sym->section;
+
+  if (bfd_is_und_section(target_section)) /* Error */
+    {
+      if ((sym->flags & BSF_WEAK) == 0)
+        {
+	  DPRINT(10,("aout_perf_reloc: target_sec==UND\n"));
+	  return bfd_reloc_undefined;
+	}
+      target_section=bfd_abs_section_ptr;
+    }
+
+  relocation=0; flags=RELOC_SIGNED; copy=FALSE; ret=bfd_reloc_ok;
+
+  DPRINT(10,("RELOC: %s: size=%u\n",r->howto->name,bfd_get_reloc_size(r->howto)));
+  switch (r->howto->type)
+    {
+    case H_ABS8: /* 8/16 bit reloc, pc relative or absolute */
+    case H_ABS16:
+      if (bfd_is_abs_section(target_section)) /* Ref to absolute hunk */
+	relocation=sym->value;
+      else if (bfd_is_com_section(target_section)) /* Error.. */
+	{
+	  bfd_msg ("pc relative relocation to common symbol \"%s\" in "
+		   "section %s",sym->name,sec->name);
+	  DPRINT(10,("Ref to common symbol...aout_perf_reloc\n"));
+	  ret=bfd_reloc_undefined;
+	}
+      else if (sec->output_section!=target_section->output_section)
+	{
+	  if ((target_section->output_section->flags&SEC_DATA)!=0)
+	    goto baserel; /* Dirty, but no code duplication.. */
+	  bfd_msg ("pc relative relocation out-of-range in section %s. "
+		   "Relocation was to symbol %s",sec->name,sym->name);
+	  DPRINT(10,("Section %s, target %s: Reloc out-of-range...not same "
+		     "section, aout_perf\nsec->out=%s, target->out=%s, "
+		     "offset=%lx\n",sec->name,target_section->name,
+		     sec->output_section->name,
+		     target_section->output_section->name,r->address));
+	  ret=bfd_reloc_outofrange;
+	}
+      else
+	{
+	  /* Same section, this is a pc relative hunk... */
+	  DPRINT(5,("Reloc to same section...\n"));
+	  relocation=-(r->address+sec->output_offset);
+	}
+      break;
+
+    case H_ABS32: /* 32 bit reloc, pc relative or absolute */
+      if (bfd_is_abs_section(target_section)) /* Ref to absolute hunk */
+	relocation=sym->value;
+      else if (bfd_is_com_section(target_section)) /* ref to common */
+	{
+	  relocation=0;
+	  copy=TRUE;
+	}
+      else
+	{
+	  /* If we access a symbol in the .bss section, we have to convert
+	     this to an access to .data section */
+	  /* This is done through a change to the output section of
+	     the symbol.. */
+	  if (amiga_base_relative
+	      && !strcmp(target_section->output_section->name,".bss"))
+	    {
+	      /* get value for .data section */
+	      bfd *ibfd;
+	      sec_ptr s;
+
+	      ibfd=target_section->output_section->owner;
+	      for (s=ibfd->sections;s!=NULL;s=s->next)
+		if (!strcmp(s->name,".data"))
+		  {
+		    target_section->output_offset+=s->_raw_size;
+		    target_section->output_section=s;
+		  }
+	    }
+	  relocation=0;
+	  copy=TRUE;
+	}
+      DPRINT(10,("target->out=%s(%lx), sec->out=%s(%lx), symbol=%s\n",
+		 target_section->output_section->name,
+		 target_section->output_section,sec->output_section->name,
+		 sec->output_section,sym->name));
+      break;
+
+    case H_PC8: /* pcrel */
+    case H_PC16:
+    case H_PC32:
+      if (bfd_is_abs_section(target_section)) /* Ref to absolute hunk */
+	relocation=sym->value;
+      else
+	{
+	  relocation = sym->value + target_section->output_offset
+	    - sec->output_offset;
+	}
+      break;
+
+    case H_SD16: /* baserel */
+    case H_SD32:
+    baserel:
+      /* We use the symbol ___a4_init as base */
+      if (bfd_is_abs_section(target_section))
+	relocation=sym->value;
+      else if (bfd_is_com_section(target_section)) /* Error.. */
+	{
+	  bfd_msg ("baserelative relocation to common \"%s\"",sym->name);
+	  DPRINT(10,("Ref to common symbol...aout_perf_reloc\n"));
+	  ret=bfd_reloc_undefined;
+	}
+      else if (!AMIGA_DATA(target_section->output_section->owner)->baserel)
+	{
+	  bfd_msg ("Base symbol for base relative reloc not defined: "
+		   "section %s, reloc to symbol %s",sec->name,sym->name);
+	  ret=bfd_reloc_notsupported;
+	}
+      else if ((target_section->flags&SEC_CODE)!=0)
+        {
+	  bfd_msg ("%s: baserelative text relocation to \"%s\"",
+		    abfd->filename, sym->name);
+	  ret=bfd_reloc_notsupported;
+        }
+      else /* Target section and sec need not be the same.. */
+	{
+	  /* If target->out is .bss, add the value of the .data section to
+	     sym->value and set new output_section */
+	  if (!strcmp(target_section->output_section->name,".bss"))
+	    {
+	      bfd *ibfd;
+	      sec_ptr s;
+
+	      ibfd=target_section->output_section->owner;
+	      for (s=ibfd->sections;s!=NULL;s=s->next)
+		if (!strcmp(s->name,".data"))
+		  {
+		    target_section->output_offset+=s->_raw_size;
+		    target_section->output_section=s;
+		  }
+	    }
+
+	  relocation = sym->value + target_section->output_offset
+	    - (AMIGA_DATA(target_section->output_section->owner))->a4init;
+	  /* if the symbol is in .bss, subtract the offset that gas has put
+	     into the opcode */
+	  if (target_section->index == 2)
+	    relocation -= adata(abfd).datasec->_raw_size;
+	  DPRINT(20,("symbol=%s (0x%lx)\nsection %s (0x%lx; %s; output=0x%lx)"
+		     "\nrelocation @0x%lx\n", sym->name, sym->value,
+		     target_section->name, target_section,
+		     target_section->owner->filename, target_section->output_offset,
+		     r->address));
+	  flags|=ADDEND_UNSIGNED;
+	}
+      DPRINT(10,("target->out=%s(%lx), sec->out=%s(%lx), symbol=%s\n",
+		 target_section->output_section->name,
+		 target_section->output_section,sec->output_section->name,
+		 sec->output_section,sym->name));
+      break;
+
+    default:
+      bfd_msg ("Error: unsupported reloc: %s(%d)",r->howto->name,r->howto->size);
+      ret=bfd_reloc_notsupported;
+      break;
+    }/* Of switch */
+
+  /* Add in relocation */
+  if (relocation!=0)
+    ret = my_add_to (r, data, relocation, flags);
+
+  if (copy) /* Copy reloc to output section */
+    {
+      DPRINT(5,("Copying reloc\n"));
+      target_section=sec->output_section;
+      r->address+=sec->output_offset;
+      target_section->orelocation[target_section->reloc_count++]=r;
+    }
+  DPRINT(5,("Leaving aout_perf_reloc with %d (OK=%d)\n",ret,bfd_reloc_ok));
+  return ret;
+}
+
+
+/* The final link routine, used both by Amiga and a.out backend */
+/* This is nearly a copy of linker.c/_bfd_generic_final_link */
+bfd_boolean
+amiga_final_link (abfd, info)
+     bfd *abfd;
+     struct bfd_link_info *info;
+{
+  bfd *sub;
+  asection *o;
+  struct bfd_link_order *p;
+  size_t outsymalloc;
+  struct generic_write_global_symbol_info wginfo;
+  struct bfd_link_hash_entry *h =
+    bfd_link_hash_lookup (info->hash, "___a4_init", FALSE, FALSE, TRUE);
+
+  if (amiga_base_relative && h && h->type == bfd_link_hash_defined) {
+    AMIGA_DATA(abfd)->baserel = TRUE;
+    AMIGA_DATA(abfd)->a4init = h->u.def.value;
+  }
+  else
+    AMIGA_DATA(abfd)->baserel = FALSE;
+
+  DPRINT(5,("Entering final_link\n"));
+
+  if (bfd_get_flavour (abfd) == bfd_target_aout_flavour)
+    return aout_amiga_final_link (abfd, info);
+
+  bfd_get_outsymbols (abfd) = (asymbol **) NULL;
+  bfd_get_symcount (abfd) = 0;
+  outsymalloc = 0;
+
+  /* Mark all sections which will be included in the output file.  */
+  for (o = abfd->sections; o != NULL; o = o->next)
+    for (p = o->link_order_head; p != NULL; p = p->next)
+      if (p->type == bfd_indirect_link_order)
+	p->u.indirect.section->linker_mark = TRUE;
+
+  /* Build the output symbol table.  */
+  for (sub = info->input_bfds; sub != (bfd *) NULL; sub = sub->link_next)
+    if (! _bfd_generic_link_output_symbols (abfd, sub, info, &outsymalloc))
+      return FALSE;
+
+  DPRINT(10,("Did build output symbol table\n"));
+
+  /* Accumulate the global symbols.  */
+  wginfo.info = info;
+  wginfo.output_bfd = abfd;
+  wginfo.psymalloc = &outsymalloc;
+  _bfd_generic_link_hash_traverse (_bfd_generic_hash_table (info),
+				   _bfd_generic_link_write_global_symbol,
+				   (PTR) &wginfo);
+
+  DPRINT(10,("Accumulated global symbols\n"));
+
+  DPRINT(10,("Output bfd is %s(%lx)\n",abfd->filename,abfd));
+
+  if (1)
+    {
+      /* Allocate space for the output relocs for each section.  */
+      /* We also handle base-relative linking special, by setting the .data
+	 sections real length to it's length + .bss length */
+      /* This is different to bfd_generic_final_link: We ALWAYS alloc space
+	 for the relocs, because we may need it anyway */
+      for (o = abfd->sections;
+	   o != (asection *) NULL;
+	   o = o->next)
+	{
+	  /* If section is .data, find .bss and add that length */
+	  if (!info->relocateable && amiga_base_relative &&
+	      !strcmp(o->name,".data"))
+	    {
+	      if (bfd_get_flavour(abfd)!=bfd_target_amiga_flavour) /* oops */
+		{
+		  bfd_msg ("You can't use base relative linking with "
+			   "partial links.");
+		}
+	      else if (0) /* XXX */
+		{
+		  asection *act_sec;
+		  for (act_sec=abfd->sections; act_sec!=NULL;act_sec=act_sec->next)
+		    if (!strcmp(act_sec->name,".bss"))
+		      amiga_per_section(o)->disk_size = o->_raw_size +
+			act_sec->_raw_size;
+		}
+	    }/* Of base-relative linking */
+
+	  DPRINT(10,("Section in output bfd is %s (%lx)\n",o->name,o));
+
+	  o->reloc_count = 0;
+	  for (p = o->link_order_head;
+	       p != (struct bfd_link_order *) NULL;
+	       p = p->next)
+	    {
+	      if (p->type == bfd_section_reloc_link_order
+		  || p->type == bfd_symbol_reloc_link_order)
+		++o->reloc_count;
+	      else if (p->type == bfd_indirect_link_order)
+		{
+		  asection *input_section;
+		  bfd *input_bfd;
+		  long relsize;
+		  arelent **relocs;
+		  asymbol **symbols;
+		  long reloc_count;
+
+		  input_section = p->u.indirect.section;
+		  input_bfd = input_section->owner;
+
+		  DPRINT(10,("\tIndirect section from bfd %s, section is %s(%lx) "
+			     "(COM=%lx)\n",
+			     input_bfd->filename,input_section->name,input_section,
+			     bfd_com_section_ptr));
+
+		  relsize = bfd_get_reloc_upper_bound (input_bfd,
+						       input_section);
+		  if (relsize < 0)
+		    {
+		      DPRINT(10,("Relsize<0.I..in bfd %s, sec %s\n",
+				 input_bfd->filename, input_section->name));
+		      return FALSE;
+		    }
+		  relocs = (arelent **) bfd_malloc ((bfd_size_type) relsize);
+		  if (!relocs && relsize != 0)
+		    return FALSE;
+		  symbols = _bfd_generic_link_get_symbols (input_bfd);
+		  reloc_count = bfd_canonicalize_reloc (input_bfd,
+							input_section,
+							relocs,
+							symbols);
+		  free (relocs);
+		  if (reloc_count < 0)
+		    {
+		      DPRINT(10,("Relsize<0.II..in bfd %s, sec %s\n",
+				 input_bfd->filename, input_section->name));
+		      return FALSE;
+		    }
+		  BFD_ASSERT ((unsigned long) reloc_count
+			      == input_section->reloc_count);
+		  o->reloc_count += reloc_count;
+		}
+	    }
+	  if (o->reloc_count > 0)
+	    {
+	      bfd_size_type amt;
+
+	      amt = o->reloc_count;
+	      amt *= sizeof (arelent *);
+	      o->orelocation = (arelent **) bfd_alloc (abfd, amt);
+	      if (!o->orelocation)
+		return FALSE;
+	      /* o->flags |= SEC_RELOC; There may be no relocs. This can
+		 be determined later only */
+	      /* Reset the count so that it can be used as an index
+		 when putting in the output relocs.  */
+	      o->reloc_count = 0;
+	    }
+	}
+    }
+
+  DPRINT(10,("Got all relocs\n"));
+
+  /* Handle all the link order information for the sections.  */
+  for (o = abfd->sections;
+       o != (asection *) NULL;
+       o = o->next)
+    {
+      for (p = o->link_order_head;
+	   p != (struct bfd_link_order *) NULL;
+	   p = p->next)
+	{
+	  switch (p->type)
+	    {
+	    case bfd_section_reloc_link_order:
+	    case bfd_symbol_reloc_link_order:
+	      if (! amiga_reloc_link_order (abfd, info, o, p)) /* We use an own routine */
+		return FALSE;
+	      break;
+	    case bfd_indirect_link_order:
+	      if (! default_indirect_link_order (abfd, info, o, p, FALSE))
+		/* Calls our get_relocated_section_contents */
+		return FALSE;
+	      break;
+	    default:
+	      if (! _bfd_default_link_order (abfd, info, o, p))
+		return FALSE;
+	      break;
+	    }
+	}
+    }
+
+  if (bfd_get_flavour(abfd)==bfd_target_amiga_flavour&&!info->relocateable)
+    AMIGA_DATA(abfd)->IsLoadFile = TRUE;
+
+  DPRINT(10,("Leaving final_link\n"));
+  return TRUE;
+}
+
+
+/* Handle reloc link order.
+   This is nearly a copy of linker.c/_bfd_generic_reloc_link_order */
+static bfd_boolean
+amiga_reloc_link_order (abfd, info, sec, link_order)
+     bfd *abfd;
+     struct bfd_link_info *info;
+     asection *sec;
+     struct bfd_link_order *link_order;
+{
+  arelent *r;
+
+  DPRINT(5,("Entering amiga_reloc_link_order\n"));
+
+  if (sec->orelocation == (arelent **) NULL)
+    {
+      DPRINT(10,("aborting, since orelocation==NULL\n"));
+      abort ();
+    }
+
+  /* We generate a new ***AMIGA*** style reloc */
+  r = (arelent *) bfd_zalloc (abfd, (bfd_size_type) sizeof (amiga_reloc_type));
+  if (r == (arelent *) NULL)
+    {
+      DPRINT(5,("Leaving amiga_reloc_link, no mem\n"));
+      return FALSE;
+    }
+
+  r->address = link_order->offset;
+  r->howto = bfd_reloc_type_lookup (abfd, link_order->u.reloc.p->reloc);
+  if (r->howto == 0)
+    {
+      bfd_set_error (bfd_error_bad_value);
+      DPRINT(5,("Leaving amiga_reloc_link, bad value\n"));
+      return FALSE;
+    }
+
+  /* Get the symbol to use for the relocation.  */
+  if (link_order->type == bfd_section_reloc_link_order)
+    r->sym_ptr_ptr = link_order->u.reloc.p->u.section->symbol_ptr_ptr;
+  else
+    {
+      struct generic_link_hash_entry *h;
+
+      h = ((struct generic_link_hash_entry *)
+	   bfd_wrapped_link_hash_lookup (abfd, info,
+					 link_order->u.reloc.p->u.name,
+					 FALSE, FALSE, TRUE));
+      if (h == (struct generic_link_hash_entry *) NULL
+	  || ! h->written)
+	{
+	  if (! ((*info->callbacks->unattached_reloc)
+		 (info, link_order->u.reloc.p->u.name,
+		  (bfd *) NULL, (asection *) NULL, (bfd_vma) 0)))
+	    return FALSE;
+	  bfd_set_error (bfd_error_bad_value);
+	  DPRINT(5,("Leaving amiga_reloc_link, bad value in hash lookup\n"));
+	  return FALSE;
+	}
+      r->sym_ptr_ptr = &h->sym;
+    }
+  DPRINT(5,("Got symbol for relocation\n"));
+  /* Store the addend */
+  r->addend = link_order->u.reloc.p->addend;
+
+  /* If we are generating relocateable output, just add the reloc */
+  if (info->relocateable)
+    {
+      DPRINT(5,("Adding reloc\n"));
+      sec->orelocation[sec->reloc_count] = r;
+      ++sec->reloc_count;
+      sec->flags|=SEC_RELOC;
+    }
+  else /* Try to apply the reloc */
+    {
+      PTR data=(PTR)sec->contents;
+      bfd_reloc_status_type ret;
+      char *em=NULL;
+
+      DPRINT(5,("Apply link_order_reloc\n"));
+
+      /* FIXME: Maybe, we have to get the section contents, before we
+	  use them, if they have not been set by now.. */
+      BFD_ASSERT (data!=NULL);
+
+      if (bfd_get_flavour(abfd)==bfd_target_amiga_flavour)
+	ret=amiga_perform_reloc(abfd,r,data,sec,NULL,&em);
+      else
+	ret=aout_perform_reloc(abfd,r,data,sec,NULL,&em);
+
+      if (ret!=bfd_reloc_ok)
+	{
+	  DPRINT(5,("Leaving amiga_reloc_link, value FALSE\n"));
+	  return FALSE;
+	}
+    }
+  DPRINT(5,("Leaving amiga_reloc_link\n"));
+  return TRUE;
+}
diff --git a/bfd/aout-amiga.c b/bfd/aout-amiga.c
new file mode 100644
index 0000000000000000000000000000000000000000..ced7584521b89943b1636d2b4c9b884242cd81c6
--- /dev/null
+++ bfd/aout-amiga.c
@@ -0,0 +1,152 @@
+/* BFD back-end for Amiga style m68k a.out binaries.
+   Copyright (C) 1990, 1991, 1992, 1993, 1994 Free Software Foundation, Inc.
+   Contributed by Stephan Thesing.
+
+This file is part of BFD, the Binary File Descriptor library.
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */
+
+#define TARGETNAME "a.out-amiga"
+#define MACHTYPE_OK(m) ((m)==M_UNKNOWN || (m)==M_68010 || (m)==M_68020)
+#define TARGET_IS_BIG_ENDIAN_P
+#define TARGET_PAGE_SIZE 0x2000
+#define N_HEADER_IN_TEXT(x) 0
+#define N_SHARED_LIB(x) 0
+#define TEXT_START_ADDR 0
+
+/* Do not "beautify" the CONCAT* macro args.  Traditional C will not
+   remove whitespace added here, and thus will fail to concatenate
+   the tokens.  */
+#define MY(OP) CONCAT2 (aout_amiga_,OP)
+
+#include "bfd.h"
+#include "sysdep.h"
+#include "libbfd.h"
+#include "libaout.h"
+#include "aout/aout64.h"
+
+bfd_boolean
+MY(final_link) PARAMS ((bfd *, struct bfd_link_info *));
+
+bfd_boolean
+amiga_final_link PARAMS ((bfd *, struct bfd_link_info *));
+#define MY_bfd_final_link amiga_final_link
+
+bfd_byte *
+get_relocated_section_contents PARAMS ((bfd *, struct bfd_link_info *,
+	struct bfd_link_order *, bfd_byte *, bfd_boolean, asymbol **));
+#define MY_bfd_get_relocated_section_contents get_relocated_section_contents
+
+static unsigned long MY(get_mach) PARAMS ((enum machine_type));
+static bfd_boolean MY(write_object_contents) PARAMS ((bfd *));
+static bfd_boolean MY(set_sizes) PARAMS ((bfd *));
+static bfd_boolean MY(link_add_symbols) PARAMS ((bfd *, struct bfd_link_info *));
+#define MY_bfd_link_add_symbols aout_amiga_link_add_symbols
+
+static unsigned long
+MY(get_mach) (machtype)
+     enum machine_type machtype;
+{
+  unsigned long machine;
+  switch (machtype)
+    {
+    default:
+    case M_UNKNOWN:
+      /* Some Sun3s make magic numbers without cpu types in them, so
+	 we'll default to the 68000. */
+      machine = bfd_mach_m68000;
+      break;
+
+    case M_68010:
+      machine = bfd_mach_m68010;
+      break;
+
+    case M_68020:
+      machine = bfd_mach_m68020;
+      break;
+    }
+  return machine;
+}
+#define SET_ARCH_MACH(ABFD, EXEC) \
+  bfd_set_arch_mach (ABFD, bfd_arch_m68k, MY(get_mach) (N_MACHTYPE (EXEC)))
+
+static bfd_boolean
+MY(write_object_contents) (abfd)
+     bfd *abfd;
+{
+  struct external_exec exec_bytes;
+  struct internal_exec *execp = exec_hdr (abfd);
+
+  /* Magic number, maestro, please!  */
+  switch (bfd_get_arch (abfd))
+    {
+    case bfd_arch_m68k:
+      switch (bfd_get_mach (abfd))
+	{
+	case bfd_mach_m68000:
+	  N_SET_MACHTYPE (*execp, M_UNKNOWN);
+	  break;
+	case bfd_mach_m68010:
+	  N_SET_MACHTYPE (*execp, M_68010);
+	  break;
+	default:
+	case bfd_mach_m68020:
+	  N_SET_MACHTYPE (*execp, M_68020);
+	  break;
+	}
+      break;
+    default:
+      N_SET_MACHTYPE (*execp, M_UNKNOWN);
+    }
+
+  WRITE_HEADERS (abfd, execp);
+
+  return TRUE;
+}
+#define MY_write_object_contents MY(write_object_contents)
+
+static bfd_boolean
+MY(set_sizes) (abfd)
+     bfd *abfd;
+{
+  adata (abfd).page_size = TARGET_PAGE_SIZE;
+  adata (abfd).segment_size = TARGET_PAGE_SIZE;
+  adata (abfd).exec_bytes_size = EXEC_BYTES_SIZE;
+  return TRUE;
+}
+#define MY_set_sizes MY(set_sizes)
+
+/* Include the usual a.out support.  */
+#include "aout-target.h"
+
+/* Add symbols from an object file to the global hash table.  */
+static bfd_boolean
+MY(link_add_symbols) (abfd, info)
+     bfd *abfd;
+     struct bfd_link_info *info;
+{
+  if (info->hash->creator->flavour == bfd_target_amiga_flavour)
+    return _bfd_generic_link_add_symbols (abfd, info);
+  return NAME(aout,link_add_symbols) (abfd, info);
+}
+
+/* Public final_link routine.  */
+bfd_boolean
+MY(final_link) (abfd, info)
+     bfd *abfd;
+     struct bfd_link_info *info;
+{
+  return NAME(aout,final_link) (abfd, info, MY_final_link_callback);
+}
diff --git a/bfd/aoutx.h b/bfd/aoutx.h
index 1e0ad38f95bcf990a9ffd4cfb89eae3f6496740c..2641f975fd575d0a651540dc886eeee68cf4b173 100644
--- bfd/aoutx.h
+++ bfd/aoutx.h
@@ -127,12 +127,16 @@ DESCRIPTION
 #include "libaout.h"
 #include "libbfd.h"
 #include "aout/aout64.h"
 #include "aout/stab_gnu.h"
 #include "aout/ar.h"
 
+/*Amiga hack - used in amigaos.c, must be global */
+/*static*/ bfd_boolean translate_to_native_sym_flags
+  PARAMS ((bfd *, asymbol *, struct external_nlist *));
+
 /*
 SUBSECTION
 	Relocations
 
 DESCRIPTION
 	The file @file{aoutx.h} provides for both the @emph{standard}
@@ -1550,13 +1554,13 @@ translate_from_native_sym_flags (bfd *abfd, aout_symbol_type *cache_ptr)
 
   return TRUE;
 }
 
 /* Set the fields of SYM_POINTER according to CACHE_PTR.  */
 
-static bfd_boolean
+bfd_boolean
 translate_to_native_sym_flags (bfd *abfd,
 			       asymbol *cache_ptr,
 			       struct external_nlist *sym_pointer)
 {
   bfd_vma value = cache_ptr->value;
   asection *sec;
@@ -1946,16 +1950,32 @@ NAME (aout, swap_std_reloc_out) (bfd *abfd,
   asection *output_section = sym->section->output_section;
 
   PUT_WORD (abfd, g->address, natptr->r_address);
 
   r_length = g->howto->size ;	/* Size as a power of two.  */
   r_pcrel  = (int) g->howto->pc_relative; /* Relative to PC?  */
+#if 1
+  /* FIXME! "#if 1" is the wrong way to select this Amiga specific code.  */
+  switch (bfd_asymbol_flavour(sym))
+    {
+    case bfd_target_amiga_flavour:
+    case bfd_target_aout_flavour:
+      r_baserel = (g->howto->type & 8) != 0;
+      r_jmptable = (g->howto->type & 16) != 0;
+      r_relative = (g->howto->type & 32) != 0;
+      break;
+    default:
+      r_baserel=r_jmptable=r_relative=0;
+      break;
+    }
+#else
   /* XXX This relies on relocs coming from a.out files.  */
   r_baserel = (g->howto->type & 8) != 0;
   r_jmptable = (g->howto->type & 16) != 0;
   r_relative = (g->howto->type & 32) != 0;
+#endif
 
   /* Name was clobbered by aout_write_syms to be symbol index.  */
 
   /* If this relocation is relative to a symbol then set the
      r_index to the symbols index, and the r_extern bit.
 
@@ -2251,14 +2271,18 @@ NAME (aout, swap_std_reloc_in) (bfd *abfd,
   else
     cache_ptr->howto = NULL;
 
   /* Base relative relocs are always against the symbol table,
      regardless of the setting of r_extern.  r_extern just reflects
      whether the symbol the reloc is against is local or global.  */
+#if 0
+  /* FIXME! "#if 0" is the wrong way to disable this code.  See comment
+     earlier in file. */
   if (r_baserel)
     r_extern = 1;
+#endif
 
   if (r_extern && r_index > symcount)
     {
       /* We could arrange to return an error, but it might be useful
          to see the file even if it is bad.  */
       r_extern = 0;
diff --git a/bfd/bfd-in2.h b/bfd/bfd-in2.h
index e496083d6ebb0842cfe0a7777dc76cdbd18c7134..8a4d566298f86c56c4a2d21895a39e0d7c5002d7 100644
--- bfd/bfd-in2.h
+++ bfd/bfd-in2.h
@@ -3128,12 +3128,16 @@ instruction.  */
   BFD_RELOC_PPC_EMB_RELSEC16,
   BFD_RELOC_PPC_EMB_RELST_LO,
   BFD_RELOC_PPC_EMB_RELST_HI,
   BFD_RELOC_PPC_EMB_RELST_HA,
   BFD_RELOC_PPC_EMB_BIT_FLD,
   BFD_RELOC_PPC_EMB_RELSDA,
+  BFD_RELOC_PPC_MORPHOS_DREL,
+  BFD_RELOC_PPC_MORPHOS_DREL_LO,
+  BFD_RELOC_PPC_MORPHOS_DREL_HI,
+  BFD_RELOC_PPC_MORPHOS_DREL_HA,
   BFD_RELOC_PPC_VLE_REL8,
   BFD_RELOC_PPC_VLE_REL15,
   BFD_RELOC_PPC_VLE_REL24,
   BFD_RELOC_PPC_VLE_LO16A,
   BFD_RELOC_PPC_VLE_LO16D,
   BFD_RELOC_PPC_VLE_HI16A,
@@ -3213,12 +3217,18 @@ instruction.  */
   BFD_RELOC_PPC64_DTPREL16_LO_DS,
   BFD_RELOC_PPC64_DTPREL16_HIGHER,
   BFD_RELOC_PPC64_DTPREL16_HIGHERA,
   BFD_RELOC_PPC64_DTPREL16_HIGHEST,
   BFD_RELOC_PPC64_DTPREL16_HIGHESTA,
 
+/* AmigaOS4 specific relocations */
+  BFD_RELOC_PPC_AMIGAOS_BREL,
+  BFD_RELOC_PPC_AMIGAOS_BREL_LO,
+  BFD_RELOC_PPC_AMIGAOS_BREL_HI,
+  BFD_RELOC_PPC_AMIGAOS_BREL_HA,
+
 /* IBM 370/390 relocations  */
   BFD_RELOC_I370_D12,
 
 /* The type of reloc used to build a constructor table - at the moment
 probably a 32 bit wide absolute relocation, but the target can choose.
 It generally does map to one of the other relocation types.  */
@@ -5904,12 +5914,13 @@ struct bfd
       struct mach_o_data_struct *mach_o_data;
       struct mach_o_fat_data_struct *mach_o_fat_data;
       struct plugin_data_struct *plugin_data;
       struct bfd_pef_data_struct *pef_data;
       struct bfd_pef_xlib_data_struct *pef_xlib_data;
       struct bfd_sym_data_struct *sym_data;
+      struct amiga_data_struct *amiga_data;
       void *any;
     }
   tdata;
 
   /* Used by the application to hold private data.  */
   void *usrdata;
@@ -6215,12 +6226,13 @@ bfd_boolean generic_core_file_matches_executable_p
    (bfd_assert (__FILE__,__LINE__), NULL))
 #endif
 
 enum bfd_flavour
 {
   bfd_target_unknown_flavour,
+  bfd_target_amiga_flavour,
   bfd_target_aout_flavour,
   bfd_target_coff_flavour,
   bfd_target_ecoff_flavour,
   bfd_target_xcoff_flavour,
   bfd_target_elf_flavour,
   bfd_target_ieee_flavour,
diff --git a/bfd/bfd.c b/bfd/bfd.c
index eed18960855bdc51be8b57ddba27975afb6b02ef..3487694a541417ec20453ca9116bbb86c383f979 100644
--- bfd/bfd.c
+++ bfd/bfd.c
@@ -261,12 +261,13 @@ CODE_FRAGMENT
 .      struct mach_o_data_struct *mach_o_data;
 .      struct mach_o_fat_data_struct *mach_o_fat_data;
 .      struct plugin_data_struct *plugin_data;
 .      struct bfd_pef_data_struct *pef_data;
 .      struct bfd_pef_xlib_data_struct *pef_xlib_data;
 .      struct bfd_sym_data_struct *sym_data;
+.      struct amiga_data_struct *amiga_data;
 .      void *any;
 .    }
 .  tdata;
 .
 .  {* Used by the application to hold private data.  *}
 .  void *usrdata;
diff --git a/bfd/bfdio.c b/bfd/bfdio.c
index be05581aeb4026addd3f4caf2b185ae73d893a24..a15208b16635c7174592b6ccf26685c4b1d05bc8 100644
--- bfd/bfdio.c
+++ bfd/bfdio.c
@@ -325,12 +325,37 @@ bfd_seek (bfd *abfd, file_ptr position, int direction)
 
   if (abfd->iovec)
     result = abfd->iovec->bseek (abfd, file_position, direction);
   else
     result = -1;
 
+/* FIXME: The following code was previously used on AmigaOS. It pads the output file */
+#if 0
+  {
+    struct stat stat_buf;
+    if (direction == SEEK_CUR)
+      file_position += ftell (f);
+    fflush (f);
+    if (!(result = fstat (fileno (f), &stat_buf)) &&
+	file_position > stat_buf.st_size &&
+	!(result = fseek (f, stat_buf.st_size, SEEK_SET))) {
+      int zeroes = file_position - stat_buf.st_size;
+      char *buf = calloc (4096, 1);
+      if (buf) {
+	while (zeroes > 0) {
+	  int r, x = (zeroes > 4096? 4096 : zeroes);
+	  if ((r = write (fileno (f), buf, x))<=0)
+	    break;
+	  zeroes -= r;
+	}
+	free (buf);
+      }
+    }
+    result = fseek (f, file_position, SEEK_SET);
+  }
+#endif
   if (result != 0)
     {
       int hold_errno = errno;
 
       /* Force redetermination of `where' field.  */
       bfd_tell (abfd);
diff --git a/bfd/config.bfd b/bfd/config.bfd
index 6025f2641b47915c79a7d643963e9d9080e0ed5c..fcbbce847bc65a44ee68deedd93b2943aac9f77f 100644
--- bfd/config.bfd
+++ bfd/config.bfd
@@ -78,15 +78,17 @@ c30*)		 targ_archs=bfd_tic30_arch ;;
 c4x*)		 targ_archs=bfd_tic4x_arch ;;
 c54x*)		 targ_archs=bfd_tic54x_arch ;;
 cr16*)		 targ_archs=bfd_cr16_arch ;;
 crisv32)	 targ_archs=bfd_cris_arch ;;
 crx*)		 targ_archs=bfd_crx_arch ;;
 dlx*)		 targ_archs=bfd_dlx_arch ;;
+i[3456]86*)      targ_archs=bfd_i386_arch ;;
+i370)            targ_archs=bfd_i370_arch ;;
 fido*)		 targ_archs=bfd_m68k_arch ;;
 hppa*)		 targ_archs=bfd_hppa_arch ;;
-i[3-7]86)	 targ_archs=bfd_i386_arch ;;
+i[3-7]86*)	 targ_archs=bfd_i386_arch ;;
 i370)		 targ_archs=bfd_i370_arch ;;
 lm32)	         targ_archs=bfd_lm32_arch ;;
 m6811*|m68hc11*) targ_archs="bfd_m68hc11_arch bfd_m68hc12_arch bfd_m9s12x_arch bfd_m9s12xg_arch" ;;
 m6812*|m68hc12*) targ_archs="bfd_m68hc12_arch bfd_m68hc11_arch bfd_m9s12x_arch bfd_m9s12xg_arch" ;;
 m68*)		 targ_archs=bfd_m68k_arch ;;
 m88*)		 targ_archs=bfd_m88k_arch ;;
@@ -719,12 +721,17 @@ case "${targ}" in
     ;;
   i[3-7]86-*-chaos)
     targ_defvec=bfd_elf32_i386_vec
     targ_selfvecs=i386chaos_vec
     ;;
 
+  i[3456]86be-*-amithlon*)
+    targ_defvec=bfd_elf32_i386be_amithlon_vec
+    targ_selvecs="bfd_elf32_i386_vec bfd_elf32_i386be_amithlon_vec"
+    ;;
+
   i860-*-mach3* | i860-*-osf1* | i860-*-coff*)
     targ_defvec=i860coff_vec
     ;;
   i860-stardent-sysv4* | i860-stardent-elf*)
     targ_defvec=bfd_elf32_i860_little_vec
     targ_selvecs="bfd_elf32_i860_vec bfd_elf32_i860_little_vec"
@@ -800,12 +807,17 @@ case "${targ}" in
     targ_selvecs="bfd_elf32_m68hc11_vec bfd_elf32_m68hc12_vec"
     ;;
 
   m68*-motorola-sysv*)
     targ_defvec=m68ksysvcoff_vec
     ;;
+  m68*-*-amigaos*)
+    targ_defvec=amiga_vec
+    targ_selvecs="aout_amiga_vec amiga_vec"
+    targ_underscore=yes
+    ;;
   m68*-hp-bsd*)
     targ_defvec=hp300bsd_vec
     targ_underscore=yes
     ;;
   m68*-*-aout*)
     targ_defvec=aout0_big_vec
@@ -871,13 +883,13 @@ case "${targ}" in
     ;;
   m68*-ericsson-*)
     targ_defvec=sunos_big_vec
     targ_selvecs="m68kcoff_vec versados_vec tekhex_vec"
     targ_underscore=yes
     ;;
-  m68*-cbm-*)
+  m68*-cbm-amix)
     targ_defvec=bfd_elf32_m68k_vec
     targ_selvecs=m68kcoff_vec
     ;;
   m68*-*-psos*)
     targ_defvec=bfd_elf32_m68k_vec
     targ_selvecs=ieee_vec
@@ -1164,12 +1176,24 @@ case "${targ}" in
 	*-*-aix4.[3456789]* | *-*-aix[56789]*)
 	want64=true;;
 	*)
 	targ_cflags=-DSMALL_ARCHIVE;;
     esac
     ;;
+  powerpc-*-amigaoshunk*)
+    targ_defvec=amiga_vec
+    targ_selvecs="bfd_elf32_powerpc_vec bfd_elf32_powerpcle_vec aout_amiga_vec"
+    ;;
+  powerpc-*-amiga*)
+    targ_defvec=bfd_elf32_amigaos_vec
+    targ_selvecs="bfd_elf32_powerpc_vec bfd_elf32_powerpcle_vec"
+    ;;
+  powerpc-*-morphos*)
+    targ_defvec=bfd_elf32_morphos_vec
+    targ_selvecs="bfd_elf32_morphos_vec"
+    ;;
 #ifdef BFD64
   powerpc64-*-aix*)
     targ_defvec=rs6000coff64_vec
     targ_selvecs=rs6000coff_vec
     want64=true
     ;;
diff --git a/bfd/configure b/bfd/configure
index e965796ef43d9346cd917bf20243707633fc632e..018a5913f1d96081342c66a64f0167b11cdb1add 100755
--- bfd/configure
+++ bfd/configure
@@ -15172,13 +15172,15 @@ do
     case "$vec" in
     # This list is alphabetized to make it easy to compare
     # with the two vector lists in targets.c.  For the same reason,
     # use one entry per line, even though this leads to long lines.
     a_out_adobe_vec)		tb="$tb aout-adobe.lo aout32.lo" ;;
     aix5coff64_vec)		tb="$tb coff64-rs6000.lo xcofflink.lo aix5ppc-core.lo"; target_size=64 ;;
+    amiga_vec)			tb="$tb amigaos.lo amigaoslink.lo" ;;
     aout0_big_vec)		tb="$tb aout0.lo aout32.lo" ;;
+    aout_amiga_vec)		tb="$tb aout-amiga.lo aout32.lo";;
     aout_arm_big_vec)		tb="$tb aout-arm.lo aout32.lo" ;;
     aout_arm_little_vec)	tb="$tb aout-arm.lo aout32.lo" ;;
     apollocoff_vec)		tb="$tb coff-apollo.lo" ;;
     arm_epoc_pe_big_vec)	tb="$tb epoc-pe-arm.lo peigen.lo cofflink.lo " ;;
     arm_epoc_pe_little_vec)	tb="$tb epoc-pe-arm.lo peigen.lo cofflink.lo " ;;
     arm_epoc_pei_big_vec)	tb="$tb epoc-pei-arm.lo peigen.lo cofflink.lo " ;;
@@ -15195,12 +15197,13 @@ do
     armpei_big_vec)		tb="$tb pei-arm.lo peigen.lo cofflink.lo " ;;
     armpei_little_vec)		tb="$tb pei-arm.lo peigen.lo cofflink.lo " ;;
     b_out_vec_big_host)		tb="$tb bout.lo aout32.lo" ;;
     b_out_vec_little_host)	tb="$tb bout.lo aout32.lo" ;;
     bfd_pei_ia64_vec)		tb="$tb pei-ia64.lo pepigen.lo cofflink.lo"; target_size=64 ;;
     bfd_elf32_am33lin_vec)	tb="$tb elf32-am33lin.lo elf32.lo $elf" ;;
+    bfd_elf32_amigaos_vec)	tb="$tb elf32-amigaos.lo elf32.lo $elf" ;;
     bfd_elf32_avr_vec)		tb="$tb elf32-avr.lo elf32.lo $elf" ;;
     bfd_elf32_bfin_vec)		tb="$tb elf32-bfin.lo elf32.lo $elf" ;;
     bfd_elf32_bfinfdpic_vec)	tb="$tb elf32-bfin.lo elf32.lo $elf" ;;
     bfd_elf32_big_generic_vec) 	tb="$tb elf32-gen.lo elf32.lo $elf" ;;
     bfd_elf32_bigarc_vec)	tb="$tb elf32-arc.lo elf32.lo $elf" ;;
     bfd_elf32_bigarm_vec)	tb="$tb elf32-arm.lo elf32.lo elf-nacl.lo elf-vxworks.lo $elf" ;;
@@ -15231,12 +15234,13 @@ do
     bfd_elf32_i370_vec)		tb="$tb elf32-i370.lo elf32.lo $elf" ;;
     bfd_elf32_i386_sol2_vec)	tb="$tb elf32-i386.lo elf-ifunc.lo elf-nacl.lo elf-vxworks.lo elf32.lo $elf" ;;
     bfd_elf32_i386_freebsd_vec)	tb="$tb elf32-i386.lo elf-ifunc.lo elf-nacl.lo elf-vxworks.lo elf32.lo $elf" ;;
     bfd_elf32_i386_nacl_vec)	tb="$tb elf32-i386.lo elf-ifunc.lo elf-nacl.lo elf-vxworks.lo elf32.lo $elf" ;;
     bfd_elf32_i386_vxworks_vec)	tb="$tb elf32-i386.lo elf-ifunc.lo elf-nacl.lo elf-vxworks.lo elf32.lo $elf" ;;
     bfd_elf32_i386_vec)		tb="$tb elf32-i386.lo elf-ifunc.lo elf-nacl.lo elf-vxworks.lo elf32.lo $elf" ;;
+    bfd_elf32_i386be_amithlon_vec) tb="$tb elf32-i386-amithlon.lo elf32.lo $elf" ;;
     bfd_elf32_i860_little_vec)	tb="$tb elf32-i860.lo elf32.lo $elf" ;;
     bfd_elf32_i860_vec)		tb="$tb elf32-i860.lo elf32.lo $elf" ;;
     bfd_elf32_i960_vec)		tb="$tb elf32-i960.lo elf32.lo $elf" ;;
     bfd_elf32_ia64_big_vec)	tb="$tb elf32-ia64.lo elfxx-ia64.lo elf32.lo $elf" ;;
     bfd_elf32_ia64_hpux_big_vec) tb="$tb elf32-ia64.lo elfxx-ia64.lo elf32.lo $elf";;
     bfd_elf32_ip2k_vec)		tb="$tb elf32-ip2k.lo elf32.lo $elf" ;;
@@ -15267,12 +15271,13 @@ do
     bfd_elf32_mcore_little_vec)	tb="$tb elf32-mcore.lo elf32.lo $elf" ;;
     bfd_elf32_mep_vec)		tb="$tb elf32-mep.lo elf32.lo $elf" ;;
     bfd_elf32_mep_little_vec)	tb="$tb elf32-mep.lo elf32.lo $elf" ;;
     bfd_elf32_microblaze_vec)	tb="$tb elf32-microblaze.lo elf32.lo $elf" ;;
     bfd_elf32_mn10200_vec)	tb="$tb elf-m10200.lo elf32.lo $elf" ;;
     bfd_elf32_mn10300_vec)	tb="$tb elf-m10300.lo elf32.lo $elf" ;;
+    bfd_elf32_morphos_vec)      tb="$tb elf32-morphos.lo elf32.lo $elf";;
     bfd_elf32_mt_vec)           tb="$tb elf32-mt.lo elf32.lo $elf" ;;
     bfd_elf32_msp430_vec)	tb="$tb elf32-msp430.lo elf32.lo $elf" ;;
     bfd_elf32_nbigmips_vec)	tb="$tb elfn32-mips.lo elfxx-mips.lo elf-vxworks.lo elf32.lo $elf ecofflink.lo"; target_size=64 ;;
     bfd_elf32_nlittlemips_vec)	tb="$tb elfn32-mips.lo elfxx-mips.lo elf-vxworks.lo elf32.lo $elf ecofflink.lo"; target_size=64 ;;
     bfd_elf32_ntradbigmips_vec | bfd_elf32_ntradbigmips_freebsd_vec)
 				tb="$tb elfn32-mips.lo elfxx-mips.lo elf-vxworks.lo elf32.lo $elf ecofflink.lo"; target_size=64 ;;
diff --git a/bfd/configure.host b/bfd/configure.host
index 7c63de58397426d08501dd7a0fd527cb59a9809c..afa7c909a787d9121d01e4e99d8047cf7f11f0b7 100644
--- bfd/configure.host
+++ bfd/configure.host
@@ -53,12 +53,13 @@ mips64*-*-linux*)	host64=true;;
 mips64*-*-freebsd* | mips64*-*-kfreebsd*-gnu) host64=true;;
 mips*-*-sysv4*)		;;
 mips*-*-sysv*)		HDEFINES="-G 4" ;;
 mips*-*-riscos*)	HDEFINES="-G 4" ;;
 
 m68*-hp-hpux*)		HDEFINES=-DHOST_HP300HPUX ;;
+m68*-*-amigaos*)	HDEFINES=-mstackextend ;;
 
 # Some Solaris systems (osol0906 at least) have a libc that doesn't recognise
 # the "MS-ANSI" code page name, so we define an override for CP_ACP (sets the
 # default code page used by windres/windmc when not specified by a commandline
 # option) to select the "WINDOWS-1252" name instead.  See PR11280 for details.
 *-*-solaris2.11)	HDEFINES=-DCP_ACP=1 ;;
diff --git a/bfd/configure.in b/bfd/configure.in
index 4b4cb617ef74f5fb33e4de13856d685f5ffba025..5d882b3701b6e0d93f97be655123a2bb2728d63a 100644
--- bfd/configure.in
+++ bfd/configure.in
@@ -664,13 +664,15 @@ do
     case "$vec" in
     # This list is alphabetized to make it easy to compare
     # with the two vector lists in targets.c.  For the same reason,
     # use one entry per line, even though this leads to long lines.
     a_out_adobe_vec)		tb="$tb aout-adobe.lo aout32.lo" ;;
     aix5coff64_vec)		tb="$tb coff64-rs6000.lo xcofflink.lo aix5ppc-core.lo"; target_size=64 ;;
+    amiga_vec)			tb="$tb amigaos.lo amigaoslink.lo" ;;
     aout0_big_vec)		tb="$tb aout0.lo aout32.lo" ;;
+    aout_amiga_vec)		tb="$tb aout-amiga.lo aout32.lo";;
     aout_arm_big_vec)		tb="$tb aout-arm.lo aout32.lo" ;;
     aout_arm_little_vec)	tb="$tb aout-arm.lo aout32.lo" ;;
     apollocoff_vec)		tb="$tb coff-apollo.lo" ;;
     arm_epoc_pe_big_vec)	tb="$tb epoc-pe-arm.lo peigen.lo cofflink.lo " ;;
     arm_epoc_pe_little_vec)	tb="$tb epoc-pe-arm.lo peigen.lo cofflink.lo " ;;
     arm_epoc_pei_big_vec)	tb="$tb epoc-pei-arm.lo peigen.lo cofflink.lo " ;;
@@ -687,12 +689,13 @@ do
     armpei_big_vec)		tb="$tb pei-arm.lo peigen.lo cofflink.lo " ;;
     armpei_little_vec)		tb="$tb pei-arm.lo peigen.lo cofflink.lo " ;;
     b_out_vec_big_host)		tb="$tb bout.lo aout32.lo" ;;
     b_out_vec_little_host)	tb="$tb bout.lo aout32.lo" ;;
     bfd_pei_ia64_vec)		tb="$tb pei-ia64.lo pepigen.lo cofflink.lo"; target_size=64 ;;
     bfd_elf32_am33lin_vec)	tb="$tb elf32-am33lin.lo elf32.lo $elf" ;;
+    bfd_elf32_amigaos_vec)	tb="$tb elf32-amigaos.lo elf32.lo $elf" ;;
     bfd_elf32_avr_vec)		tb="$tb elf32-avr.lo elf32.lo $elf" ;;
     bfd_elf32_bfin_vec)		tb="$tb elf32-bfin.lo elf32.lo $elf" ;;
     bfd_elf32_bfinfdpic_vec)	tb="$tb elf32-bfin.lo elf32.lo $elf" ;;
     bfd_elf32_big_generic_vec) 	tb="$tb elf32-gen.lo elf32.lo $elf" ;;
     bfd_elf32_bigarc_vec)	tb="$tb elf32-arc.lo elf32.lo $elf" ;;
     bfd_elf32_bigarm_vec)	tb="$tb elf32-arm.lo elf32.lo elf-nacl.lo elf-vxworks.lo $elf" ;;
@@ -723,12 +726,13 @@ do
     bfd_elf32_i370_vec)		tb="$tb elf32-i370.lo elf32.lo $elf" ;;
     bfd_elf32_i386_sol2_vec)	tb="$tb elf32-i386.lo elf-ifunc.lo elf-nacl.lo elf-vxworks.lo elf32.lo $elf" ;;
     bfd_elf32_i386_freebsd_vec)	tb="$tb elf32-i386.lo elf-ifunc.lo elf-nacl.lo elf-vxworks.lo elf32.lo $elf" ;;
     bfd_elf32_i386_nacl_vec)	tb="$tb elf32-i386.lo elf-ifunc.lo elf-nacl.lo elf-vxworks.lo elf32.lo $elf" ;;
     bfd_elf32_i386_vxworks_vec)	tb="$tb elf32-i386.lo elf-ifunc.lo elf-nacl.lo elf-vxworks.lo elf32.lo $elf" ;;
     bfd_elf32_i386_vec)		tb="$tb elf32-i386.lo elf-ifunc.lo elf-nacl.lo elf-vxworks.lo elf32.lo $elf" ;;
+    bfd_elf32_i386be_amithlon_vec) tb="$tb elf32-i386-amithlon.lo elf32.lo $elf" ;;
     bfd_elf32_i860_little_vec)	tb="$tb elf32-i860.lo elf32.lo $elf" ;;
     bfd_elf32_i860_vec)		tb="$tb elf32-i860.lo elf32.lo $elf" ;;
     bfd_elf32_i960_vec)		tb="$tb elf32-i960.lo elf32.lo $elf" ;;
     bfd_elf32_ia64_big_vec)	tb="$tb elf32-ia64.lo elfxx-ia64.lo elf32.lo $elf" ;;
     bfd_elf32_ia64_hpux_big_vec) tb="$tb elf32-ia64.lo elfxx-ia64.lo elf32.lo $elf";;
     bfd_elf32_ip2k_vec)		tb="$tb elf32-ip2k.lo elf32.lo $elf" ;;
@@ -759,12 +763,13 @@ do
     bfd_elf32_mcore_little_vec)	tb="$tb elf32-mcore.lo elf32.lo $elf" ;;
     bfd_elf32_mep_vec)		tb="$tb elf32-mep.lo elf32.lo $elf" ;;
     bfd_elf32_mep_little_vec)	tb="$tb elf32-mep.lo elf32.lo $elf" ;;
     bfd_elf32_microblaze_vec)	tb="$tb elf32-microblaze.lo elf32.lo $elf" ;;
     bfd_elf32_mn10200_vec)	tb="$tb elf-m10200.lo elf32.lo $elf" ;;
     bfd_elf32_mn10300_vec)	tb="$tb elf-m10300.lo elf32.lo $elf" ;;
+    bfd_elf32_morphos_vec)      tb="$tb elf32-morphos.lo elf32.lo $elf";;
     bfd_elf32_mt_vec)           tb="$tb elf32-mt.lo elf32.lo $elf" ;;
     bfd_elf32_msp430_vec)	tb="$tb elf32-msp430.lo elf32.lo $elf" ;;
     bfd_elf32_nbigmips_vec)	tb="$tb elfn32-mips.lo elfxx-mips.lo elf-vxworks.lo elf32.lo $elf ecofflink.lo"; target_size=64 ;;
     bfd_elf32_nlittlemips_vec)	tb="$tb elfn32-mips.lo elfxx-mips.lo elf-vxworks.lo elf32.lo $elf ecofflink.lo"; target_size=64 ;;
     bfd_elf32_ntradbigmips_vec | bfd_elf32_ntradbigmips_freebsd_vec)
 				tb="$tb elfn32-mips.lo elfxx-mips.lo elf-vxworks.lo elf32.lo $elf ecofflink.lo"; target_size=64 ;;
diff --git a/bfd/doc/Makefile.am b/bfd/doc/Makefile.am
index 7476ee5bab710b6b418072124b473cf0d340b247..1ddc9e3d2153b55f6f26645e5fc584074bb369fd 100644
--- bfd/doc/Makefile.am
+++ bfd/doc/Makefile.am
@@ -1,11 +1,11 @@
 ## Process this file with automake to generate Makefile.in
 
 AUTOMAKE_OPTIONS = 1.9 cygnus
 
-DOCFILES = aoutx.texi  archive.texi archures.texi \
+DOCFILES = amiga.texi amigalink.texi aoutx.texi  archive.texi archures.texi \
 	bfdt.texi  cache.texi coffcode.texi \
 	core.texi elf.texi elfcode.texi  format.texi \
 	libbfd.texi bfdwin.texi bfdio.texi \
 	opncls.texi  reloc.texi  section.texi  \
 	syms.texi  targets.texi init.texi hash.texi linker.texi \
 	mmo.texi \
@@ -26,12 +26,13 @@ IPROTOS = cache.ip libbfd.ip reloc.ip init.ip archures.ip coffcode.ip
 SRCDOC = $(srcdir)/../aoutx.h  $(srcdir)/../archive.c \
 	$(srcdir)/../archures.c $(srcdir)/../bfd.c \
 	$(srcdir)/../bfdio.c $(srcdir)/../bfdwin.c \
 	$(srcdir)/../cache.c $(srcdir)/../coffcode.h \
 	$(srcdir)/../corefile.c $(srcdir)/../elf.c \
 	$(srcdir)/../elfcode.h  $(srcdir)/../format.c \
+	$(srcdir)/../amigaos.c $(srcdir)/../amigaoslink.c \
 	$(srcdir)/../libbfd.c $(srcdir)/../opncls.c \
 	$(srcdir)/../reloc.c  $(srcdir)/../section.c \
 	$(srcdir)/../syms.c  $(srcdir)/../targets.c \
 	$(srcdir)/../hash.c $(srcdir)/../linker.c \
 	$(srcdir)/../mmo.c
 
@@ -183,12 +184,24 @@ hash.texi: chew.c $(srcdir)/../hash.c $(srcdir)/doc.str
 
 linker.texi: chew.c $(srcdir)/../linker.c $(srcdir)/doc.str
 	$(MAKE) $(MKDOC)
 	./$(MKDOC) -f $(srcdir)/doc.str <$(srcdir)/../linker.c >linker.tmp
 	$(SHELL) $(srcdir)/../../move-if-change linker.tmp linker.texi
 
+s-amiga: $(MKDOC) $(srcdir)/../amigaos.c $(srcdir)/doc.str
+	./$(MKDOC) -f $(srcdir)/doc.str <$(srcdir)/../amigaos.c >amiga.tmp
+	$(srcdir)/../../move-if-change amiga.tmp amiga.texi
+	touch s-amiga
+amiga.texi: s-amiga
+
+s-amigalink: $(MKDOC) $(srcdir)/../amigaoslink.c $(srcdir)/doc.str
+	./$(MKDOC) -f $(srcdir)/doc.str <$(srcdir)/../amigaoslink.c >amigalink.tmp
+	$(srcdir)/../../move-if-change amigalink.tmp amigalink.texi
+	touch s-amigalink
+amigalink.texi: s-amigalink
+
 LIBBFD_H_DEP = \
 	$(srcdir)/../libbfd-in.h	\
 	$(srcdir)/../init.c		\
 	$(srcdir)/../libbfd.c		\
 	$(srcdir)/../bfdio.c		\
 	$(srcdir)/../bfdwin.c		\
diff --git a/bfd/doc/Makefile.in b/bfd/doc/Makefile.in
index 7ba351d742bf53f9e5f51ad7ef74150295519f1a..67db3caf9886839b8d8f52a2a1878de878bb2f6a 100644
--- bfd/doc/Makefile.in
+++ bfd/doc/Makefile.in
@@ -268,13 +268,13 @@ target_vendor = @target_vendor@
 tdefaults = @tdefaults@
 top_build_prefix = @top_build_prefix@
 top_builddir = @top_builddir@
 top_srcdir = @top_srcdir@
 wordsize = @wordsize@
 AUTOMAKE_OPTIONS = 1.9 cygnus
-DOCFILES = aoutx.texi  archive.texi archures.texi \
+DOCFILES = amiga.texi amigalink.texi aoutx.texi  archive.texi archures.texi \
 	bfdt.texi  cache.texi coffcode.texi \
 	core.texi elf.texi elfcode.texi  format.texi \
 	libbfd.texi bfdwin.texi bfdio.texi \
 	opncls.texi  reloc.texi  section.texi  \
 	syms.texi  targets.texi init.texi hash.texi linker.texi \
 	mmo.texi \
@@ -295,12 +295,13 @@ IPROTOS = cache.ip libbfd.ip reloc.ip init.ip archures.ip coffcode.ip
 SRCDOC = $(srcdir)/../aoutx.h  $(srcdir)/../archive.c \
 	$(srcdir)/../archures.c $(srcdir)/../bfd.c \
 	$(srcdir)/../bfdio.c $(srcdir)/../bfdwin.c \
 	$(srcdir)/../cache.c $(srcdir)/../coffcode.h \
 	$(srcdir)/../corefile.c $(srcdir)/../elf.c \
 	$(srcdir)/../elfcode.h  $(srcdir)/../format.c \
+	$(srcdir)/../amigaos.c $(srcdir)/../amigaoslink.c \
 	$(srcdir)/../libbfd.c $(srcdir)/../opncls.c \
 	$(srcdir)/../reloc.c  $(srcdir)/../section.c \
 	$(srcdir)/../syms.c  $(srcdir)/../targets.c \
 	$(srcdir)/../hash.c $(srcdir)/../linker.c \
 	$(srcdir)/../mmo.c
 
@@ -880,12 +881,24 @@ hash.texi: chew.c $(srcdir)/../hash.c $(srcdir)/doc.str
 
 linker.texi: chew.c $(srcdir)/../linker.c $(srcdir)/doc.str
 	$(MAKE) $(MKDOC)
 	./$(MKDOC) -f $(srcdir)/doc.str <$(srcdir)/../linker.c >linker.tmp
 	$(SHELL) $(srcdir)/../../move-if-change linker.tmp linker.texi
 
+s-amiga: $(MKDOC) $(srcdir)/../amigaos.c $(srcdir)/doc.str
+	./$(MKDOC) -f $(srcdir)/doc.str <$(srcdir)/../amigaos.c >amiga.tmp
+	$(srcdir)/../../move-if-change amiga.tmp amiga.texi
+	touch s-amiga
+amiga.texi: s-amiga
+
+s-amigalink: $(MKDOC) $(srcdir)/../amigaoslink.c $(srcdir)/doc.str
+	./$(MKDOC) -f $(srcdir)/doc.str <$(srcdir)/../amigaoslink.c >amigalink.tmp
+	$(srcdir)/../../move-if-change amigalink.tmp amigalink.texi
+	touch s-amigalink
+amigalink.texi: s-amigalink
+
 libbfd.h: $(LIBBFD_H_DEP)
 	echo "$(LIBBFD_H_DEP)" | sed -f $(srcdir)/header.sed > $@
 	for file in $(LIBBFD_H_DEP); do \
 	  case $$file in \
 	    *-in.h) cat $$file >> $@ ;; \
 	    */header.sed) break ;; \
diff --git a/bfd/doc/bfd.texinfo b/bfd/doc/bfd.texinfo
index 45ffa73240ea22a74debe916fcd7e068a947a7dc..7b9774b71a3cb9b3c154c8c75a41de29a6813146 100644
--- bfd/doc/bfd.texinfo
+++ bfd/doc/bfd.texinfo
@@ -286,12 +286,13 @@ structures.
 @chapter BFD back ends
 @menu
 * What to Put Where::
 * aout ::	a.out backends
 * coff ::	coff backends
 * elf  ::	elf backends
+* amiga ::      amigaos backend
 * mmo  ::	mmo backend
 @ignore
 * oasys ::	oasys backends
 * ieee ::	ieee backend
 * srecord ::	s-record backend
 @end ignore
@@ -303,18 +304,22 @@ All of BFD lives in one directory.
 @node aout, coff, What to Put Where, BFD back ends
 @include  aoutx.texi
 
 @node coff, elf, aout, BFD back ends
 @include  coffcode.texi
 
-@node elf, mmo, coff, BFD back ends
+@node elf, amiga, coff, BFD back ends
 @include  elf.texi
 @c Leave this out until the file has some actual contents...
 @c @include  elfcode.texi
 
-@node mmo,  , elf, BFD back ends
+@node amiga, mmo, elf, BFD back ends
+@include amiga.texi
+@include amigalink.texi
+
+@node mmo, , amiga, BFD back ends
 @include  mmo.texi
 
 @node GNU Free Documentation License, BFD Index, BFD back ends, Top
 @include fdl.texi
 
 @node BFD Index,  , GNU Free Documentation License, Top
diff --git a/bfd/elf32-amiga.c b/bfd/elf32-amiga.c
new file mode 100644
index 0000000000000000000000000000000000000000..cf6c6cb9efdd15c786932adedd2476ec3a4bc08d
--- /dev/null
+++ bfd/elf32-amiga.c
@@ -0,0 +1,3844 @@
+/* PowerPC-specific support for 32-bit ELF
+   Copyright 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002
+   Free Software Foundation, Inc.
+   Written by Ian Lance Taylor, Cygnus Support.
+
+This file is part of BFD, the Binary File Descriptor library.
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+
+/* This file is based on a preliminary PowerPC ELF ABI.  The
+   information may not match the final PowerPC ELF ABI.  It includes
+   suggestions from the in-progress Embedded PowerPC ABI, and that
+   information may also not match.  */
+
+#include "bfd.h"
+#include "sysdep.h"
+#include "bfdlink.h"
+#include "libbfd.h"
+#include "elf-bfd.h"
+#include "elf/ppc.h"
+
+#define USE_RELA		/* we want RELA relocations, not REL */
+
+static reloc_howto_type *ppc_elf_reloc_type_lookup
+  PARAMS ((bfd *abfd, bfd_reloc_code_real_type code));
+static void ppc_elf_info_to_howto
+  PARAMS ((bfd *abfd, arelent *cache_ptr, Elf32_Internal_Rela *dst));
+static void ppc_elf_howto_init PARAMS ((void));
+static int ppc_elf_sort_rela PARAMS ((const PTR, const PTR));
+static boolean ppc_elf_relax_section
+  PARAMS ((bfd *, asection *, struct bfd_link_info *, boolean *));
+static bfd_reloc_status_type ppc_elf_addr16_ha_reloc
+  PARAMS ((bfd *, arelent *, asymbol *, PTR, asection *, bfd *, char **));
+static boolean ppc_elf_object_p PARAMS ((bfd *));
+static boolean ppc_elf_set_private_flags PARAMS ((bfd *, flagword));
+static boolean ppc_elf_merge_private_bfd_data PARAMS ((bfd *, bfd *));
+
+static int ppc_elf_additional_program_headers PARAMS ((bfd *));
+static boolean ppc_elf_modify_segment_map PARAMS ((bfd *));
+
+static asection *ppc_elf_create_got
+  PARAMS ((bfd *, struct bfd_link_info *));
+static boolean ppc_elf_create_dynamic_sections
+  PARAMS ((bfd *, struct bfd_link_info *));
+
+static boolean ppc_elf_section_from_shdr PARAMS ((bfd *,
+						  Elf32_Internal_Shdr *,
+						  const char *));
+static boolean ppc_elf_fake_sections
+  PARAMS ((bfd *, Elf32_Internal_Shdr *, asection *));
+
+static elf_linker_section_t *ppc_elf_create_linker_section
+  PARAMS ((bfd *abfd,
+	   struct bfd_link_info *info,
+	   enum elf_linker_section_enum));
+
+static boolean ppc_elf_check_relocs PARAMS ((bfd *,
+					     struct bfd_link_info *,
+					     asection *,
+					     const Elf_Internal_Rela *));
+
+static asection * ppc_elf_gc_mark_hook PARAMS ((asection *sec,
+						struct bfd_link_info *info,
+						Elf_Internal_Rela *rel,
+						struct elf_link_hash_entry *h,
+						Elf_Internal_Sym *sym));
+
+static boolean ppc_elf_gc_sweep_hook PARAMS ((bfd *abfd,
+					      struct bfd_link_info *info,
+					      asection *sec,
+					      const Elf_Internal_Rela *relocs));
+
+static boolean ppc_elf_adjust_dynamic_symbol PARAMS ((struct bfd_link_info *,
+						      struct elf_link_hash_entry *));
+
+static boolean ppc_elf_size_dynamic_sections PARAMS ((bfd *, struct bfd_link_info *));
+
+static boolean ppc_elf_relocate_section PARAMS ((bfd *,
+						 struct bfd_link_info *info,
+						 bfd *,
+						 asection *,
+						 bfd_byte *,
+						 Elf_Internal_Rela *relocs,
+						 Elf_Internal_Sym *local_syms,
+						 asection **));
+
+static boolean ppc_elf_add_symbol_hook  PARAMS ((bfd *,
+						 struct bfd_link_info *,
+						 const Elf_Internal_Sym *,
+						 const char **,
+						 flagword *,
+						 asection **,
+						 bfd_vma *));
+
+static boolean ppc_elf_finish_dynamic_symbol PARAMS ((bfd *,
+						      struct bfd_link_info *,
+						      struct elf_link_hash_entry *,
+						      Elf_Internal_Sym *));
+
+static boolean ppc_elf_finish_dynamic_sections PARAMS ((bfd *, struct bfd_link_info *));
+static enum elf_reloc_type_class ppc_elf_reloc_type_class
+  PARAMS ((const Elf_Internal_Rela *));
+static boolean ppc_elf_grok_prstatus
+  PARAMS ((bfd *abfd, Elf_Internal_Note *note));
+static boolean ppc_elf_grok_psinfo
+  PARAMS ((bfd *abfd, Elf_Internal_Note *note));
+
+#define BRANCH_PREDICT_BIT 0x200000		/* branch prediction bit for branch taken relocs */
+#define RA_REGISTER_MASK 0x001f0000		/* mask to set RA in memory instructions */
+#define RA_REGISTER_SHIFT 16			/* value to shift register by to insert RA */
+
+/* The name of the dynamic interpreter.  This is put in the .interp
+   section.  */
+
+#define ELF_DYNAMIC_INTERPRETER "sys:libs/runtime-linker"
+
+/* The size in bytes of an entry in the procedure linkage table.  */
+#define PLT_ENTRY_SIZE 12
+/* The initial size of the plt reserved for the dynamic linker.  */
+#define PLT_INITIAL_ENTRY_SIZE 72
+/* The size of the gap between entries in the PLT.  */
+#define PLT_SLOT_SIZE 8
+/* The number of single-slot PLT entries (the rest use two slots).  */
+#define PLT_NUM_SINGLE_ENTRIES 8192
+
+/* Will references to this symbol always reference the symbol
+   in this object?  */
+#define SYMBOL_REFERENCES_LOCAL(INFO, H)				\
+  ((! INFO->shared							\
+    || INFO->symbolic							\
+    || H->dynindx == -1							\
+    || ELF_ST_VISIBILITY (H->other) == STV_INTERNAL			\
+    || ELF_ST_VISIBILITY (H->other) == STV_HIDDEN)			\
+   && (H->elf_link_hash_flags & ELF_LINK_HASH_DEF_REGULAR) != 0)
+
+/* Will _calls_ to this symbol always call the version in this object?  */
+#define SYMBOL_CALLS_LOCAL(INFO, H)				\
+  ((! INFO->shared							\
+    || INFO->symbolic							\
+    || H->dynindx == -1							\
+    || ELF_ST_VISIBILITY (H->other) != STV_DEFAULT)			\
+   && (H->elf_link_hash_flags & ELF_LINK_HASH_DEF_REGULAR) != 0)
+
+static reloc_howto_type *ppc_elf_howto_table[(int) R_PPC_max];
+
+static reloc_howto_type ppc_elf_howto_raw[] = {
+  /* This reloc does nothing.  */
+  HOWTO (R_PPC_NONE,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_NONE",		/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0,			/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* A standard 32 bit relocation.  */
+  HOWTO (R_PPC_ADDR32,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_ADDR32",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffffffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* An absolute 26 bit branch; the lower two bits must be zero.
+     FIXME: we don't check that, we just clear them.  */
+  HOWTO (R_PPC_ADDR24,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 26,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_ADDR24",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0x3fffffc,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* A standard 16 bit relocation.  */
+  HOWTO (R_PPC_ADDR16,		/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_ADDR16",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* A 16 bit relocation without overflow.  */
+  HOWTO (R_PPC_ADDR16_LO,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont,/* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_ADDR16_LO",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* The high order 16 bits of an address.  */
+  HOWTO (R_PPC_ADDR16_HI,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_ADDR16_HI",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* The high order 16 bits of an address, plus 1 if the contents of
+     the low 16 bits, treated as a signed number, is negative.  */
+  HOWTO (R_PPC_ADDR16_HA,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 ppc_elf_addr16_ha_reloc, /* special_function */
+	 "R_PPC_ADDR16_HA",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* An absolute 16 bit branch; the lower two bits must be zero.
+     FIXME: we don't check that, we just clear them.  */
+  HOWTO (R_PPC_ADDR14,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_ADDR14",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xfffc,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* An absolute 16 bit branch, for which bit 10 should be set to
+     indicate that the branch is expected to be taken.	The lower two
+     bits must be zero.  */
+  HOWTO (R_PPC_ADDR14_BRTAKEN,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_ADDR14_BRTAKEN",/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xfffc,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* An absolute 16 bit branch, for which bit 10 should be set to
+     indicate that the branch is not expected to be taken.  The lower
+     two bits must be zero.  */
+  HOWTO (R_PPC_ADDR14_BRNTAKEN, /* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_ADDR14_BRNTAKEN",/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xfffc,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* A relative 26 bit branch; the lower two bits must be zero.  */
+  HOWTO (R_PPC_REL24,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 26,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_REL24",		/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0x3fffffc,		/* dst_mask */
+	 true),			/* pcrel_offset */
+
+  /* A relative 16 bit branch; the lower two bits must be zero.  */
+  HOWTO (R_PPC_REL14,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_REL14",		/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xfffc,		/* dst_mask */
+	 true),			/* pcrel_offset */
+
+  /* A relative 16 bit branch.  Bit 10 should be set to indicate that
+     the branch is expected to be taken.  The lower two bits must be
+     zero.  */
+  HOWTO (R_PPC_REL14_BRTAKEN,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_REL14_BRTAKEN",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xfffc,		/* dst_mask */
+	 true),			/* pcrel_offset */
+
+  /* A relative 16 bit branch.  Bit 10 should be set to indicate that
+     the branch is not expected to be taken.  The lower two bits must
+     be zero.  */
+  HOWTO (R_PPC_REL14_BRNTAKEN,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_REL14_BRNTAKEN",/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xfffc,		/* dst_mask */
+	 true),			/* pcrel_offset */
+
+  /* Like R_PPC_ADDR16, but referring to the GOT table entry for the
+     symbol.  */
+  HOWTO (R_PPC_GOT16,		/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_GOT16",		/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Like R_PPC_ADDR16_LO, but referring to the GOT table entry for
+     the symbol.  */
+  HOWTO (R_PPC_GOT16_LO,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_GOT16_LO",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Like R_PPC_ADDR16_HI, but referring to the GOT table entry for
+     the symbol.  */
+  HOWTO (R_PPC_GOT16_HI,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_GOT16_HI",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		 /* pcrel_offset */
+
+  /* Like R_PPC_ADDR16_HA, but referring to the GOT table entry for
+     the symbol.  */
+  HOWTO (R_PPC_GOT16_HA,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 ppc_elf_addr16_ha_reloc, /* special_function */
+	 "R_PPC_GOT16_HA",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Like R_PPC_REL24, but referring to the procedure linkage table
+     entry for the symbol.  */
+  HOWTO (R_PPC_PLTREL24,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 26,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed,  /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_PLTREL24",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0x3fffffc,		/* dst_mask */
+	 true),			/* pcrel_offset */
+
+  /* This is used only by the dynamic linker.  The symbol should exist
+     both in the object being run and in some shared library.  The
+     dynamic linker copies the data addressed by the symbol from the
+     shared library into the object, because the object being
+     run has to have the data at some particular address.  */
+  HOWTO (R_PPC_COPY,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	 /* special_function */
+	 "R_PPC_COPY",		/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0,			/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Like R_PPC_ADDR32, but used when setting global offset table
+     entries.  */
+  HOWTO (R_PPC_GLOB_DAT,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	 /* special_function */
+	 "R_PPC_GLOB_DAT",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffffffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Marks a procedure linkage table entry for a symbol.  */
+  HOWTO (R_PPC_JMP_SLOT,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	 /* special_function */
+	 "R_PPC_JMP_SLOT",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0,			/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Used only by the dynamic linker.  When the object is run, this
+     longword is set to the load address of the object, plus the
+     addend.  */
+  HOWTO (R_PPC_RELATIVE,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	 /* special_function */
+	 "R_PPC_RELATIVE",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffffffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Like R_PPC_REL24, but uses the value of the symbol within the
+     object rather than the final value.  Normally used for
+     _GLOBAL_OFFSET_TABLE_.  */
+  HOWTO (R_PPC_LOCAL24PC,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 26,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_LOCAL24PC",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0x3fffffc,		/* dst_mask */
+	 true),			/* pcrel_offset */
+
+  /* Like R_PPC_ADDR32, but may be unaligned.  */
+  HOWTO (R_PPC_UADDR32,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_UADDR32",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffffffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Like R_PPC_ADDR16, but may be unaligned.  */
+  HOWTO (R_PPC_UADDR16,		/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_UADDR16",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 32-bit PC relative */
+  HOWTO (R_PPC_REL32,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_REL32",		/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffffffff,		/* dst_mask */
+	 true),			/* pcrel_offset */
+
+  /* 32-bit relocation to the symbol's procedure linkage table.
+     FIXME: not supported.  */
+  HOWTO (R_PPC_PLT32,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_PLT32",		/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0,			/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 32-bit PC relative relocation to the symbol's procedure linkage table.
+     FIXME: not supported.  */
+  HOWTO (R_PPC_PLTREL32,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_PLTREL32",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0,			/* dst_mask */
+	 true),			/* pcrel_offset */
+
+  /* Like R_PPC_ADDR16_LO, but referring to the PLT table entry for
+     the symbol.  */
+  HOWTO (R_PPC_PLT16_LO,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_PLT16_LO",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Like R_PPC_ADDR16_HI, but referring to the PLT table entry for
+     the symbol.  */
+  HOWTO (R_PPC_PLT16_HI,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_PLT16_HI",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		 /* pcrel_offset */
+
+  /* Like R_PPC_ADDR16_HA, but referring to the PLT table entry for
+     the symbol.  */
+  HOWTO (R_PPC_PLT16_HA,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 ppc_elf_addr16_ha_reloc, /* special_function */
+	 "R_PPC_PLT16_HA",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* A sign-extended 16 bit value relative to _SDA_BASE_, for use with
+     small data items.  */
+  HOWTO (R_PPC_SDAREL16,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_SDAREL16",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 16-bit section relative relocation.  */
+  HOWTO (R_PPC_SECTOFF,		/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_SECTOFF",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 16-bit lower half section relative relocation.  */
+  HOWTO (R_PPC_SECTOFF_LO,	  /* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_SECTOFF_LO",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 16-bit upper half section relative relocation.  */
+  HOWTO (R_PPC_SECTOFF_HI,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_SECTOFF_HI",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		 /* pcrel_offset */
+
+  /* 16-bit upper half adjusted section relative relocation.  */
+  HOWTO (R_PPC_SECTOFF_HA,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 ppc_elf_addr16_ha_reloc, /* special_function */
+	 "R_PPC_SECTOFF_HA",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* The remaining relocs are from the Embedded ELF ABI, and are not
+     in the SVR4 ELF ABI.  */
+
+  /* 32 bit value resulting from the addend minus the symbol */
+  HOWTO (R_PPC_EMB_NADDR32,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_NADDR32",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffffffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 16 bit value resulting from the addend minus the symbol */
+  HOWTO (R_PPC_EMB_NADDR16,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_NADDR16",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 16 bit value resulting from the addend minus the symbol */
+  HOWTO (R_PPC_EMB_NADDR16_LO,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont,/* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_ADDR16_LO",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* The high order 16 bits of the addend minus the symbol */
+  HOWTO (R_PPC_EMB_NADDR16_HI,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_NADDR16_HI", /* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* The high order 16 bits of the result of the addend minus the address,
+     plus 1 if the contents of the low 16 bits, treated as a signed number,
+     is negative.  */
+  HOWTO (R_PPC_EMB_NADDR16_HA,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 ppc_elf_addr16_ha_reloc, /* special_function */
+	 "R_PPC_EMB_NADDR16_HA", /* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 16 bit value resulting from allocating a 4 byte word to hold an
+     address in the .sdata section, and returning the offset from
+     _SDA_BASE_ for that relocation */
+  HOWTO (R_PPC_EMB_SDAI16,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_SDAI16",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 16 bit value resulting from allocating a 4 byte word to hold an
+     address in the .sdata2 section, and returning the offset from
+     _SDA2_BASE_ for that relocation */
+  HOWTO (R_PPC_EMB_SDA2I16,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_SDA2I16",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* A sign-extended 16 bit value relative to _SDA2_BASE_, for use with
+     small data items.	 */
+  HOWTO (R_PPC_EMB_SDA2REL,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_SDA2REL",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Relocate against either _SDA_BASE_ or _SDA2_BASE_, filling in the 16 bit
+     signed offset from the appropriate base, and filling in the register
+     field with the appropriate register (0, 2, or 13).  */
+  HOWTO (R_PPC_EMB_SDA21,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_SDA21",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Relocation not handled: R_PPC_EMB_MRKREF */
+  /* Relocation not handled: R_PPC_EMB_RELSEC16 */
+  /* Relocation not handled: R_PPC_EMB_RELST_LO */
+  /* Relocation not handled: R_PPC_EMB_RELST_HI */
+  /* Relocation not handled: R_PPC_EMB_RELST_HA */
+  /* Relocation not handled: R_PPC_EMB_BIT_FLD */
+
+  /* PC relative relocation against either _SDA_BASE_ or _SDA2_BASE_, filling
+     in the 16 bit signed offset from the appropriate base, and filling in the
+     register field with the appropriate register (0, 2, or 13).  */
+  HOWTO (R_PPC_EMB_RELSDA,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_RELSDA",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* GNU extension to record C++ vtable hierarchy */
+  HOWTO (R_PPC_GNU_VTINHERIT,	/* type */
+	 0,			/* rightshift */
+	 0,			/* size (0 = byte, 1 = short, 2 = long) */
+	 0,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 NULL,			/* special_function */
+	 "R_PPC_GNU_VTINHERIT",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0,			/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* GNU extension to record C++ vtable member usage */
+  HOWTO (R_PPC_GNU_VTENTRY,	/* type */
+	 0,			/* rightshift */
+	 0,			/* size (0 = byte, 1 = short, 2 = long) */
+	 0,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 NULL,			/* special_function */
+	 "R_PPC_GNU_VTENTRY",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0,			/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Phony reloc to handle AIX style TOC entries */
+  HOWTO (R_PPC_TOC16,		/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_TOC16",		/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+};
+
+/* Initialize the ppc_elf_howto_table, so that linear accesses can be done.  */
+
+static void
+ppc_elf_howto_init ()
+{
+  unsigned int i, type;
+
+  for (i = 0; i < sizeof (ppc_elf_howto_raw) / sizeof (ppc_elf_howto_raw[0]); i++)
+    {
+      type = ppc_elf_howto_raw[i].type;
+      BFD_ASSERT (type < sizeof (ppc_elf_howto_table) / sizeof (ppc_elf_howto_table[0]));
+      ppc_elf_howto_table[type] = &ppc_elf_howto_raw[i];
+    }
+}
+
+/* This function handles relaxing for the PPC with option --mpc860c0[=<n>].
+
+   The MPC860, revision C0 or earlier contains a bug in the die.
+   If all of the following conditions are true, the next instruction
+   to be executed *may* be treated as a no-op.
+   1/ A forward branch is executed.
+   2/ The branch is predicted as not taken.
+   3/ The branch is taken.
+   4/ The branch is located in the last 5 words of a page.
+      (The EOP limit is 5 by default but may be specified as any value from 1-10.)
+
+   Our software solution is to detect these problematic branches in a
+   linker pass and modify them as follows:
+   1/ Unconditional branches - Since these are always predicted taken,
+      there is no problem and no action is required.
+   2/ Conditional backward branches - No problem, no action required.
+   3/ Conditional forward branches - Ensure that the "inverse prediction
+      bit" is set (ensure it is predicted taken).
+   4/ Conditional register branches - Ensure that the "y bit" is set
+      (ensure it is predicted taken).
+*/
+
+/* Sort sections by address.  */
+
+static int
+ppc_elf_sort_rela (arg1, arg2)
+     const PTR arg1;
+     const PTR arg2;
+{
+  const Elf_Internal_Rela **rela1 = (const Elf_Internal_Rela**) arg1;
+  const Elf_Internal_Rela **rela2 = (const Elf_Internal_Rela**) arg2;
+
+  /* Sort by offset.  */
+  return ((*rela1)->r_offset - (*rela2)->r_offset);
+}
+
+static boolean
+ppc_elf_relax_section (abfd, isec, link_info, again)
+     bfd *abfd;
+     asection *isec;
+     struct bfd_link_info *link_info;
+     boolean *again;
+{
+#define PAGESIZE 0x1000
+
+  bfd_byte *contents = NULL;
+  bfd_byte *free_contents = NULL;
+  Elf_Internal_Rela *internal_relocs = NULL;
+  Elf_Internal_Rela *free_relocs = NULL;
+  Elf_Internal_Rela **rela_comb = NULL;
+  int comb_curr, comb_count;
+
+  /* We never have to do this more than once per input section.  */
+  *again = false;
+
+  /* If needed, initialize this section's cooked size.  */
+  if (isec->_cooked_size == 0)
+      isec->_cooked_size = isec->_raw_size;
+
+  /* We're only interested in text sections which overlap the
+     troublesome area at the end of a page.  */
+  if (link_info->mpc860c0 && (isec->flags & SEC_CODE) && isec->_cooked_size)
+    {
+      bfd_vma dot, end_page, end_section;
+      boolean section_modified;
+
+      /* Get the section contents.  */
+      /* Get cached copy if it exists.  */
+      if (elf_section_data (isec)->this_hdr.contents != NULL)
+	  contents = elf_section_data (isec)->this_hdr.contents;
+      else
+	{
+	  /* Go get them off disk.  */
+	  contents = (bfd_byte *) bfd_malloc (isec->_raw_size);
+	  if (contents == NULL)
+	    goto error_return;
+	  free_contents = contents;
+
+	  if (! bfd_get_section_contents (abfd, isec, contents,
+					  (file_ptr) 0, isec->_raw_size))
+	    goto error_return;
+	}
+
+      comb_curr = 0;
+      comb_count = 0;
+      if (isec->reloc_count)
+	{
+          unsigned n;
+	  bfd_size_type amt;
+
+          /* Get a copy of the native relocations.  */
+          internal_relocs = _bfd_elf32_link_read_relocs (
+    	    abfd, isec, (PTR) NULL, (Elf_Internal_Rela *) NULL,
+    	    link_info->keep_memory);
+          if (internal_relocs == NULL)
+    	      goto error_return;
+          if (! link_info->keep_memory)
+    	      free_relocs = internal_relocs;
+
+          /* Setup a faster access method for the reloc info we need.  */
+	  amt = isec->reloc_count;
+	  amt *= sizeof (Elf_Internal_Rela*);
+          rela_comb = (Elf_Internal_Rela**) bfd_malloc (amt);
+          if (rela_comb == NULL)
+              goto error_return;
+          for (n = 0; n < isec->reloc_count; ++n)
+            {
+              long r_type;
+
+              r_type = ELF32_R_TYPE (internal_relocs[n].r_info);
+              if (r_type < 0 || r_type >= (int) R_PPC_max)
+                  goto error_return;
+
+              /* Prologue constants are sometimes present in the ".text"
+              sections and they can be identified by their associated relocation.
+              We don't want to process those words and some others which
+              can also be identified by their relocations.  However, not all
+              conditional branches will have a relocation so we will
+              only ignore words that 1) have a reloc, and 2) the reloc
+              is not applicable to a conditional branch.
+              The array rela_comb is built here for use in the EOP scan loop.  */
+              switch (r_type)
+                {
+                case R_PPC_ADDR14_BRNTAKEN:     /* absolute, predicted not taken */
+                case R_PPC_REL14:               /* relative cond. br.  */
+                case R_PPC_REL14_BRNTAKEN:      /* rel. cond. br., predicted not taken */
+                  /* We should check the instruction.  */
+                  break;
+                default:
+                  /* The word is not a conditional branch - ignore it.  */
+                  rela_comb[comb_count++] = &internal_relocs[n];
+                  break;
+                }
+            }
+          if (comb_count > 1)
+	    qsort (rela_comb, (size_t) comb_count, sizeof (int), ppc_elf_sort_rela);
+	}
+
+      /* Enumerate each EOP region that overlaps this section.  */
+      end_section = isec->vma + isec->_cooked_size;
+      dot = end_page = (isec->vma | (PAGESIZE - 1)) + 1;
+      dot -= link_info->mpc860c0;
+      section_modified = false;
+      if (dot < isec->vma)      /* Increment the start position if this section */
+          dot = isec->vma;      /* begins in the middle of its first EOP region.  */
+      for (;
+           dot < end_section;
+           dot += PAGESIZE, end_page += PAGESIZE)
+        {
+
+          /* Check each word in this EOP region.  */
+          for (; dot < end_page; dot += 4)
+            {
+              bfd_vma isec_offset;
+              unsigned long insn;
+              boolean skip, modified;
+
+              /* Don't process this word if there is a relocation for it and
+              the relocation indicates the word is not a conditional branch.  */
+              skip = false;
+              isec_offset = dot - isec->vma;
+              for (; comb_curr<comb_count; ++comb_curr)
+                {
+                  bfd_vma r_offset;
+
+                  r_offset = rela_comb[comb_curr]->r_offset;
+                  if (r_offset >= isec_offset)
+                    {
+                      if (r_offset == isec_offset) skip = true;
+                      break;
+                    }
+                }
+              if (skip) continue;
+
+              /* Check the current word for a problematic conditional branch.  */
+#define BO0(insn) ((insn) & 0x02000000)
+#define BO2(insn) ((insn) & 0x00800000)
+#define BO4(insn) ((insn) & 0x00200000)
+              insn = (unsigned long) bfd_get_32 (abfd, contents + isec_offset);
+              modified = false;
+              if ((insn & 0xFc000000) == 0x40000000)
+                {
+                  /* Instruction is BCx */
+                  if ((!BO0(insn) || !BO2(insn)) && !BO4(insn))
+                    {
+                      bfd_vma target;
+                      /* This branch is predicted as "normal".
+                      If this is a forward branch, it is problematic.  */
+
+                      target = insn & 0x0000Fffc;               /*extract*/
+                      target = (target ^ 0x8000) - 0x8000;      /*sign extend*/
+                      if ((insn & 0x00000002) == 0)
+                          target += dot;                        /*convert to abs*/
+                      if (target > dot)
+                        {
+                          insn |= 0x00200000;   /* set the prediction bit */
+                          modified = true;
+                        }
+                    }
+                }
+              else if ((insn & 0xFc00Fffe) == 0x4c000420)
+                {
+                  /* Instruction is BCCTRx */
+                  if ((!BO0(insn) || !BO2(insn)) && !BO4(insn))
+		    {
+		      /* This branch is predicted as not-taken.
+		      If this is a forward branch, it is problematic.
+                      Since we can't tell statically if it will branch forward,
+                      always set the prediction bit.  */
+                      insn |= 0x00200000;   /* set the prediction bit */
+                      modified = true;
+		    }
+                }
+              else if ((insn & 0xFc00Fffe) == 0x4c000020)
+                {
+                  /* Instruction is BCLRx */
+                  if ((!BO0(insn) || !BO2(insn)) && !BO4(insn))
+		    {
+		      /* This branch is predicted as not-taken.
+		      If this is a forward branch, it is problematic.
+                      Since we can't tell statically if it will branch forward,
+                      always set the prediction bit.  */
+                      insn |= 0x00200000;   /* set the prediction bit */
+                      modified = true;
+		    }
+                }
+#undef BO0
+#undef BO2
+#undef BO4
+              if (modified)
+	        {
+                  bfd_put_32 (abfd, (bfd_vma) insn, contents + isec_offset);
+		  section_modified = true;
+	        }
+            }
+        }
+      if (section_modified)
+	{
+	  elf_section_data (isec)->this_hdr.contents = contents;
+	  free_contents = NULL;
+	}
+    }
+
+  if (rela_comb != NULL)
+    {
+      free (rela_comb);
+      rela_comb = NULL;
+    }
+
+  if (free_relocs != NULL)
+    {
+      free (free_relocs);
+      free_relocs = NULL;
+    }
+
+  if (free_contents != NULL)
+    {
+      if (! link_info->keep_memory)
+	free (free_contents);
+      else
+	{
+	  /* Cache the section contents for elf_link_input_bfd.  */
+	  elf_section_data (isec)->this_hdr.contents = contents;
+	}
+      free_contents = NULL;
+    }
+
+  return true;
+
+error_return:
+  if (rela_comb != NULL)
+    free (rela_comb);
+  if (free_relocs != NULL)
+    free (free_relocs);
+  if (free_contents != NULL)
+    free (free_contents);
+  return false;
+}
+
+static reloc_howto_type *
+ppc_elf_reloc_type_lookup (abfd, code)
+     bfd *abfd ATTRIBUTE_UNUSED;
+     bfd_reloc_code_real_type code;
+{
+  enum elf_ppc_reloc_type ppc_reloc = R_PPC_NONE;
+
+  if (!ppc_elf_howto_table[R_PPC_ADDR32])
+    /* Initialize howto table if needed.  */
+    ppc_elf_howto_init ();
+
+  switch ((int) code)
+    {
+    default:
+      return (reloc_howto_type *) NULL;
+
+    case BFD_RELOC_NONE:		ppc_reloc = R_PPC_NONE;			break;
+    case BFD_RELOC_32:			ppc_reloc = R_PPC_ADDR32;		break;
+    case BFD_RELOC_PPC_BA26:		ppc_reloc = R_PPC_ADDR24;		break;
+    case BFD_RELOC_16:			ppc_reloc = R_PPC_ADDR16;		break;
+    case BFD_RELOC_LO16:		ppc_reloc = R_PPC_ADDR16_LO;		break;
+    case BFD_RELOC_HI16:		ppc_reloc = R_PPC_ADDR16_HI;		break;
+    case BFD_RELOC_HI16_S:		ppc_reloc = R_PPC_ADDR16_HA;		break;
+    case BFD_RELOC_PPC_BA16:		ppc_reloc = R_PPC_ADDR14;		break;
+    case BFD_RELOC_PPC_BA16_BRTAKEN:	ppc_reloc = R_PPC_ADDR14_BRTAKEN;	break;
+    case BFD_RELOC_PPC_BA16_BRNTAKEN:	ppc_reloc = R_PPC_ADDR14_BRNTAKEN;	break;
+    case BFD_RELOC_PPC_B26:		ppc_reloc = R_PPC_REL24;		break;
+    case BFD_RELOC_PPC_B16:		ppc_reloc = R_PPC_REL14;		break;
+    case BFD_RELOC_PPC_B16_BRTAKEN:	ppc_reloc = R_PPC_REL14_BRTAKEN;	break;
+    case BFD_RELOC_PPC_B16_BRNTAKEN:	ppc_reloc = R_PPC_REL14_BRNTAKEN;	break;
+    case BFD_RELOC_16_GOTOFF:		ppc_reloc = R_PPC_GOT16;		break;
+    case BFD_RELOC_LO16_GOTOFF:		ppc_reloc = R_PPC_GOT16_LO;		break;
+    case BFD_RELOC_HI16_GOTOFF:		ppc_reloc = R_PPC_GOT16_HI;		break;
+    case BFD_RELOC_HI16_S_GOTOFF:	ppc_reloc = R_PPC_GOT16_HA;		break;
+    case BFD_RELOC_24_PLT_PCREL:	ppc_reloc = R_PPC_PLTREL24;		break;
+    case BFD_RELOC_PPC_COPY:		ppc_reloc = R_PPC_COPY;			break;
+    case BFD_RELOC_PPC_GLOB_DAT:	ppc_reloc = R_PPC_GLOB_DAT;		break;
+    case BFD_RELOC_PPC_LOCAL24PC:	ppc_reloc = R_PPC_LOCAL24PC;		break;
+    case BFD_RELOC_32_PCREL:		ppc_reloc = R_PPC_REL32;		break;
+    case BFD_RELOC_32_PLTOFF:		ppc_reloc = R_PPC_PLT32;		break;
+    case BFD_RELOC_32_PLT_PCREL:	ppc_reloc = R_PPC_PLTREL32;		break;
+    case BFD_RELOC_LO16_PLTOFF:		ppc_reloc = R_PPC_PLT16_LO;		break;
+    case BFD_RELOC_HI16_PLTOFF:		ppc_reloc = R_PPC_PLT16_HI;		break;
+    case BFD_RELOC_HI16_S_PLTOFF:	ppc_reloc = R_PPC_PLT16_HA;		break;
+    case BFD_RELOC_GPREL16:		ppc_reloc = R_PPC_SDAREL16;		break;
+    case BFD_RELOC_16_BASEREL:		ppc_reloc = R_PPC_SECTOFF;		break;
+    case BFD_RELOC_LO16_BASEREL:	ppc_reloc = R_PPC_SECTOFF_LO;		break;
+    case BFD_RELOC_HI16_BASEREL:	ppc_reloc = R_PPC_SECTOFF_HI;		break;
+    case BFD_RELOC_HI16_S_BASEREL:	ppc_reloc = R_PPC_SECTOFF_HA;		break;
+    case BFD_RELOC_CTOR:		ppc_reloc = R_PPC_ADDR32;		break;
+    case BFD_RELOC_PPC_TOC16:		ppc_reloc = R_PPC_TOC16;		break;
+    case BFD_RELOC_PPC_EMB_NADDR32:	ppc_reloc = R_PPC_EMB_NADDR32;		break;
+    case BFD_RELOC_PPC_EMB_NADDR16:	ppc_reloc = R_PPC_EMB_NADDR16;		break;
+    case BFD_RELOC_PPC_EMB_NADDR16_LO:	ppc_reloc = R_PPC_EMB_NADDR16_LO;	break;
+    case BFD_RELOC_PPC_EMB_NADDR16_HI:	ppc_reloc = R_PPC_EMB_NADDR16_HI;	break;
+    case BFD_RELOC_PPC_EMB_NADDR16_HA:	ppc_reloc = R_PPC_EMB_NADDR16_HA;	break;
+    case BFD_RELOC_PPC_EMB_SDAI16:	ppc_reloc = R_PPC_EMB_SDAI16;		break;
+    case BFD_RELOC_PPC_EMB_SDA2I16:	ppc_reloc = R_PPC_EMB_SDA2I16;		break;
+    case BFD_RELOC_PPC_EMB_SDA2REL:	ppc_reloc = R_PPC_EMB_SDA2REL;		break;
+    case BFD_RELOC_PPC_EMB_SDA21:	ppc_reloc = R_PPC_EMB_SDA21;		break;
+    case BFD_RELOC_PPC_EMB_MRKREF:	ppc_reloc = R_PPC_EMB_MRKREF;		break;
+    case BFD_RELOC_PPC_EMB_RELSEC16:	ppc_reloc = R_PPC_EMB_RELSEC16;		break;
+    case BFD_RELOC_PPC_EMB_RELST_LO:	ppc_reloc = R_PPC_EMB_RELST_LO;		break;
+    case BFD_RELOC_PPC_EMB_RELST_HI:	ppc_reloc = R_PPC_EMB_RELST_HI;		break;
+    case BFD_RELOC_PPC_EMB_RELST_HA:	ppc_reloc = R_PPC_EMB_RELST_HA;		break;
+    case BFD_RELOC_PPC_EMB_BIT_FLD:	ppc_reloc = R_PPC_EMB_BIT_FLD;		break;
+    case BFD_RELOC_PPC_EMB_RELSDA:	ppc_reloc = R_PPC_EMB_RELSDA;		break;
+    case BFD_RELOC_VTABLE_INHERIT:	ppc_reloc = R_PPC_GNU_VTINHERIT;	break;
+    case BFD_RELOC_VTABLE_ENTRY:	ppc_reloc = R_PPC_GNU_VTENTRY;		break;
+    }
+
+  return ppc_elf_howto_table[(int) ppc_reloc];
+};
+
+/* Set the howto pointer for a PowerPC ELF reloc.  */
+
+static void
+ppc_elf_info_to_howto (abfd, cache_ptr, dst)
+     bfd *abfd ATTRIBUTE_UNUSED;
+     arelent *cache_ptr;
+     Elf32_Internal_Rela *dst;
+{
+  if (!ppc_elf_howto_table[R_PPC_ADDR32])
+    /* Initialize howto table if needed.  */
+    ppc_elf_howto_init ();
+
+  BFD_ASSERT (ELF32_R_TYPE (dst->r_info) < (unsigned int) R_PPC_max);
+  cache_ptr->howto = ppc_elf_howto_table[ELF32_R_TYPE (dst->r_info)];
+}
+
+/* Handle the R_PPC_ADDR16_HA reloc.  */
+
+static bfd_reloc_status_type
+ppc_elf_addr16_ha_reloc (abfd, reloc_entry, symbol, data, input_section,
+			 output_bfd, error_message)
+     bfd *abfd ATTRIBUTE_UNUSED;
+     arelent *reloc_entry;
+     asymbol *symbol;
+     PTR data ATTRIBUTE_UNUSED;
+     asection *input_section;
+     bfd *output_bfd;
+     char **error_message ATTRIBUTE_UNUSED;
+{
+  bfd_vma relocation;
+
+  if (output_bfd != NULL)
+    {
+      reloc_entry->address += input_section->output_offset;
+      return bfd_reloc_ok;
+    }
+
+  if (reloc_entry->address > input_section->_cooked_size)
+    return bfd_reloc_outofrange;
+
+  if (bfd_is_com_section (symbol->section))
+    relocation = 0;
+  else
+    relocation = symbol->value;
+
+  relocation += symbol->section->output_section->vma;
+  relocation += symbol->section->output_offset;
+  relocation += reloc_entry->addend;
+
+  reloc_entry->addend += (relocation & 0x8000) << 1;
+
+  return bfd_reloc_continue;
+}
+
+/* Fix bad default arch selected for a 32 bit input bfd when the
+   default is 64 bit.  */
+
+static boolean
+ppc_elf_object_p (abfd)
+     bfd *abfd;
+{
+  if (abfd->arch_info->the_default && abfd->arch_info->bits_per_word == 64)
+    {
+      Elf_Internal_Ehdr *i_ehdr = elf_elfheader (abfd);
+
+      if (i_ehdr->e_ident[EI_CLASS] == ELFCLASS32)
+	{
+	  /* Relies on arch after 64 bit default being 32 bit default.  */
+	  abfd->arch_info = abfd->arch_info->next;
+	  BFD_ASSERT (abfd->arch_info->bits_per_word == 32);
+	}
+    }
+  return true;
+}
+
+/* Function to set whether a module needs the -mrelocatable bit set.  */
+
+static boolean
+ppc_elf_set_private_flags (abfd, flags)
+     bfd *abfd;
+     flagword flags;
+{
+  BFD_ASSERT (!elf_flags_init (abfd)
+	      || elf_elfheader (abfd)->e_flags == flags);
+
+  elf_elfheader (abfd)->e_flags = flags;
+  elf_flags_init (abfd) = true;
+  return true;
+}
+
+/* Merge backend specific data from an object file to the output
+   object file when linking */
+static boolean
+ppc_elf_merge_private_bfd_data (ibfd, obfd)
+     bfd *ibfd;
+     bfd *obfd;
+{
+  flagword old_flags;
+  flagword new_flags;
+  boolean error;
+
+  /* Check if we have the same endianess */
+  if (! _bfd_generic_verify_endian_match (ibfd, obfd))
+    return false;
+
+  if (bfd_get_flavour (ibfd) != bfd_target_elf_flavour
+      || bfd_get_flavour (obfd) != bfd_target_elf_flavour)
+    return true;
+
+  new_flags = elf_elfheader (ibfd)->e_flags;
+  old_flags = elf_elfheader (obfd)->e_flags;
+  if (!elf_flags_init (obfd))	/* First call, no flags set */
+    {
+      elf_flags_init (obfd) = true;
+      elf_elfheader (obfd)->e_flags = new_flags;
+    }
+
+  else if (new_flags == old_flags)	/* Compatible flags are ok */
+    ;
+
+  else					/* Incompatible flags */
+    {
+      /* Warn about -mrelocatable mismatch.  Allow -mrelocatable-lib to be linked
+         with either.  */
+      error = false;
+      if ((new_flags & EF_PPC_RELOCATABLE) != 0
+	  && (old_flags & (EF_PPC_RELOCATABLE | EF_PPC_RELOCATABLE_LIB)) == 0)
+	{
+	  error = true;
+	  (*_bfd_error_handler)
+	    (_("%s: compiled with -mrelocatable and linked with modules compiled normally"),
+	     bfd_archive_filename (ibfd));
+	}
+      else if ((new_flags & (EF_PPC_RELOCATABLE | EF_PPC_RELOCATABLE_LIB)) == 0
+	       && (old_flags & EF_PPC_RELOCATABLE) != 0)
+	{
+	  error = true;
+	  (*_bfd_error_handler)
+	    (_("%s: compiled normally and linked with modules compiled with -mrelocatable"),
+	     bfd_archive_filename (ibfd));
+	}
+
+      /* The output is -mrelocatable-lib iff both the input files are.  */
+      if (! (new_flags & EF_PPC_RELOCATABLE_LIB))
+	elf_elfheader (obfd)->e_flags &= ~EF_PPC_RELOCATABLE_LIB;
+
+      /* The output is -mrelocatable iff it can't be -mrelocatable-lib,
+         but each input file is either -mrelocatable or -mrelocatable-lib.  */
+      if (! (elf_elfheader (obfd)->e_flags & EF_PPC_RELOCATABLE_LIB)
+	  && (new_flags & (EF_PPC_RELOCATABLE_LIB | EF_PPC_RELOCATABLE))
+	  && (old_flags & (EF_PPC_RELOCATABLE_LIB | EF_PPC_RELOCATABLE)))
+	elf_elfheader (obfd)->e_flags |= EF_PPC_RELOCATABLE;
+
+      /* Do not warn about eabi vs. V.4 mismatch, just or in the bit if any module uses it */
+      elf_elfheader (obfd)->e_flags |= (new_flags & EF_PPC_EMB);
+
+      new_flags &= ~ (EF_PPC_RELOCATABLE | EF_PPC_RELOCATABLE_LIB | EF_PPC_EMB);
+      old_flags &= ~ (EF_PPC_RELOCATABLE | EF_PPC_RELOCATABLE_LIB | EF_PPC_EMB);
+
+      /* Warn about any other mismatches */
+      if (new_flags != old_flags)
+	{
+	  error = true;
+	  (*_bfd_error_handler)
+	    (_("%s: uses different e_flags (0x%lx) fields than previous modules (0x%lx)"),
+	     bfd_archive_filename (ibfd), (long) new_flags, (long) old_flags);
+	}
+
+      if (error)
+	{
+	  bfd_set_error (bfd_error_bad_value);
+	  return false;
+	}
+    }
+
+  return true;
+}
+
+/* Handle a PowerPC specific section when reading an object file.  This
+   is called when elfcode.h finds a section with an unknown type.  */
+
+static boolean
+ppc_elf_section_from_shdr (abfd, hdr, name)
+     bfd *abfd;
+     Elf32_Internal_Shdr *hdr;
+     const char *name;
+{
+  asection *newsect;
+  flagword flags;
+
+  if (! _bfd_elf_make_section_from_shdr (abfd, hdr, name))
+    return false;
+
+  newsect = hdr->bfd_section;
+  flags = bfd_get_section_flags (abfd, newsect);
+  if (hdr->sh_flags & SHF_EXCLUDE)
+    flags |= SEC_EXCLUDE;
+
+  if (hdr->sh_type == SHT_ORDERED)
+    flags |= SEC_SORT_ENTRIES;
+
+  bfd_set_section_flags (abfd, newsect, flags);
+  return true;
+}
+
+/* Set up any other section flags and such that may be necessary.  */
+
+static boolean
+ppc_elf_fake_sections (abfd, shdr, asect)
+     bfd *abfd ATTRIBUTE_UNUSED;
+     Elf32_Internal_Shdr *shdr;
+     asection *asect;
+{
+  if ((asect->flags & SEC_EXCLUDE) != 0)
+    shdr->sh_flags |= SHF_EXCLUDE;
+
+  if ((asect->flags & SEC_SORT_ENTRIES) != 0)
+    shdr->sh_type = SHT_ORDERED;
+
+  return true;
+}
+
+/* Create a special linker section */
+static elf_linker_section_t *
+ppc_elf_create_linker_section (abfd, info, which)
+     bfd *abfd;
+     struct bfd_link_info *info;
+     enum elf_linker_section_enum which;
+{
+  bfd *dynobj = elf_hash_table (info)->dynobj;
+  elf_linker_section_t *lsect;
+
+  /* Record the first bfd section that needs the special section */
+  if (!dynobj)
+    dynobj = elf_hash_table (info)->dynobj = abfd;
+
+  /* If this is the first time, create the section */
+  lsect = elf_linker_section (dynobj, which);
+  if (!lsect)
+    {
+      elf_linker_section_t defaults;
+      static elf_linker_section_t zero_section;
+
+      defaults = zero_section;
+      defaults.which = which;
+      defaults.hole_written_p = false;
+      defaults.alignment = 2;
+
+      /* Both of these sections are (technically) created by the user
+	 putting data in them, so they shouldn't be marked
+	 SEC_LINKER_CREATED.
+
+	 The linker creates them so it has somewhere to attach their
+	 respective symbols. In fact, if they were empty it would
+	 be OK to leave the symbol set to 0 (or any random number), because
+	 the appropriate register should never be used.  */
+      defaults.flags = (SEC_ALLOC | SEC_LOAD | SEC_HAS_CONTENTS
+			| SEC_IN_MEMORY);
+
+      switch (which)
+	{
+	default:
+	  (*_bfd_error_handler) (_("%s: Unknown special linker type %d"),
+				 bfd_get_filename (abfd),
+				 (int) which);
+
+	  bfd_set_error (bfd_error_bad_value);
+	  return (elf_linker_section_t *) 0;
+
+	case LINKER_SECTION_SDATA:	/* .sdata/.sbss section */
+	  defaults.name		  = ".sdata";
+	  defaults.rel_name	  = ".rela.sdata";
+	  defaults.bss_name	  = ".sbss";
+	  defaults.sym_name	  = "_SDA_BASE_";
+	  defaults.sym_offset	  = 32768;
+	  break;
+
+	case LINKER_SECTION_SDATA2:	/* .sdata2/.sbss2 section */
+	  defaults.name		  = ".sdata2";
+	  defaults.rel_name	  = ".rela.sdata2";
+	  defaults.bss_name	  = ".sbss2";
+	  defaults.sym_name	  = "_SDA2_BASE_";
+	  defaults.sym_offset	  = 32768;
+	  defaults.flags	 |= SEC_READONLY;
+	  break;
+	}
+
+      lsect = _bfd_elf_create_linker_section (abfd, info, which, &defaults);
+    }
+
+  return lsect;
+}
+
+/* If we have a non-zero sized .sbss2 or .PPC.EMB.sbss0 sections, we
+   need to bump up the number of section headers.  */
+
+static int
+ppc_elf_additional_program_headers (abfd)
+     bfd *abfd;
+{
+  asection *s;
+  int ret;
+
+  ret = 0;
+
+  s = bfd_get_section_by_name (abfd, ".interp");
+  if (s != NULL)
+    ++ret;
+
+  s = bfd_get_section_by_name (abfd, ".sbss2");
+  if (s != NULL && (s->flags & SEC_LOAD) != 0 && s->_raw_size > 0)
+    ++ret;
+
+  s = bfd_get_section_by_name (abfd, ".PPC.EMB.sbss0");
+  if (s != NULL && (s->flags & SEC_LOAD) != 0 && s->_raw_size > 0)
+    ++ret;
+
+  return ret;
+}
+
+/* Modify the segment map if needed.  */
+
+static boolean
+ppc_elf_modify_segment_map (abfd)
+     bfd *abfd ATTRIBUTE_UNUSED;
+{
+  return true;
+}
+
+/* The powerpc .got has a blrl instruction in it.  Mark it executable.  */
+
+static asection *
+ppc_elf_create_got (abfd, info)
+     bfd *abfd;
+     struct bfd_link_info *info;
+{
+  register asection *s;
+  flagword flags;
+
+  if (!_bfd_elf_create_got_section (abfd, info))
+    return NULL;
+
+  s = bfd_get_section_by_name (abfd, ".got");
+  if (s == NULL)
+    abort ();
+
+  flags = (SEC_ALLOC | SEC_LOAD | SEC_CODE | SEC_HAS_CONTENTS | SEC_IN_MEMORY
+	   | SEC_LINKER_CREATED);
+  if (!bfd_set_section_flags (abfd, s, flags))
+    return NULL;
+  return s;
+}
+
+/* We have to create .dynsbss and .rela.sbss here so that they get mapped
+   to output sections (just like _bfd_elf_create_dynamic_sections has
+   to create .dynbss and .rela.bss).  */
+
+static boolean
+ppc_elf_create_dynamic_sections (abfd, info)
+     bfd *abfd;
+     struct bfd_link_info *info;
+{
+  register asection *s;
+  flagword flags;
+
+  if (!ppc_elf_create_got (abfd, info))
+    return false;
+
+  if (!_bfd_elf_create_dynamic_sections (abfd, info))
+    return false;
+
+  flags = (SEC_ALLOC | SEC_LOAD | SEC_HAS_CONTENTS | SEC_IN_MEMORY
+	   | SEC_LINKER_CREATED);
+
+  s = bfd_make_section (abfd, ".dynsbss");
+  if (s == NULL
+      || ! bfd_set_section_flags (abfd, s, SEC_ALLOC))
+    return false;
+
+  if (! info->shared)
+    {
+      s = bfd_make_section (abfd, ".rela.sbss");
+      if (s == NULL
+	  || ! bfd_set_section_flags (abfd, s, flags | SEC_READONLY)
+	  || ! bfd_set_section_alignment (abfd, s, 2))
+	return false;
+    }
+
+  s = bfd_get_section_by_name (abfd, ".plt");
+  if (s == NULL)
+    abort ();
+
+  flags = SEC_ALLOC | SEC_CODE | SEC_IN_MEMORY | SEC_LINKER_CREATED;
+  return bfd_set_section_flags (abfd, s, flags);
+}
+
+/* Adjust a symbol defined by a dynamic object and referenced by a
+   regular object.  The current definition is in some section of the
+   dynamic object, but we're not including those sections.  We have to
+   change the definition to something the rest of the link can
+   understand.  */
+
+static boolean
+ppc_elf_adjust_dynamic_symbol (info, h)
+     struct bfd_link_info *info;
+     struct elf_link_hash_entry *h;
+{
+  bfd *dynobj = elf_hash_table (info)->dynobj;
+  asection *s;
+  unsigned int power_of_two;
+  bfd_vma plt_offset;
+
+#ifdef DEBUG
+  fprintf (stderr, "ppc_elf_adjust_dynamic_symbol called for %s\n", h->root.root.string);
+#endif
+
+  /* Make sure we know what is going on here.  */
+  BFD_ASSERT (dynobj != NULL
+	      && ((h->elf_link_hash_flags & ELF_LINK_HASH_NEEDS_PLT)
+		  || h->weakdef != NULL
+		  || ((h->elf_link_hash_flags
+		       & ELF_LINK_HASH_DEF_DYNAMIC) != 0
+		      && (h->elf_link_hash_flags
+			  & ELF_LINK_HASH_REF_REGULAR) != 0
+		      && (h->elf_link_hash_flags
+			  & ELF_LINK_HASH_DEF_REGULAR) == 0)));
+
+  /* If this is a function, put it in the procedure linkage table.  We
+     will fill in the contents of the procedure linkage table later,
+     when we know the address of the .got section.  */
+  if (h->type == STT_FUNC
+      || (h->elf_link_hash_flags & ELF_LINK_HASH_NEEDS_PLT) != 0)
+    {
+      if (! elf_hash_table (info)->dynamic_sections_created
+ 	  || SYMBOL_CALLS_LOCAL (info, h)
+	  || (info->shared && h->plt.refcount <= 0))
+	{
+	  /* A PLT entry is not required/allowed when:
+
+	     1. We are not using ld.so; because then the PLT entry
+	     can't be set up, so we can't use one.
+
+	     2. We know for certain that a call to this symbol
+	     will go to this object.
+
+	     3. GC has rendered the entry unused.
+	     Note, however, that in an executable all references to the
+	     symbol go to the PLT, so we can't turn it off in that case.
+	     ??? The correct thing to do here is to reference count
+	     all uses of the symbol, not just those to the GOT or PLT.  */
+	  h->plt.offset = (bfd_vma) -1;
+	  h->elf_link_hash_flags &= ~ELF_LINK_HASH_NEEDS_PLT;
+	  return true;
+	}
+
+      /* Make sure this symbol is output as a dynamic symbol.  */
+      if (h->dynindx == -1)
+	{
+	  if (! bfd_elf32_link_record_dynamic_symbol (info, h))
+	    return false;
+	}
+      BFD_ASSERT (h->dynindx != -1);
+
+      s = bfd_get_section_by_name (dynobj, ".plt");
+      BFD_ASSERT (s != NULL);
+
+      /* If this is the first .plt entry, make room for the special
+	 first entry.  */
+      if (s->_raw_size == 0)
+	s->_raw_size += PLT_INITIAL_ENTRY_SIZE;
+
+      /* The PowerPC PLT is actually composed of two parts, the first part
+	 is 2 words (for a load and a jump), and then there is a remaining
+	 word available at the end.  */
+      plt_offset = (PLT_INITIAL_ENTRY_SIZE
+		    + (PLT_SLOT_SIZE
+		       * ((s->_raw_size - PLT_INITIAL_ENTRY_SIZE)
+			  / PLT_ENTRY_SIZE)));
+
+      /* If this symbol is not defined in a regular file, and we are
+	 not generating a shared library, then set the symbol to this
+	 location in the .plt.  This is required to make function
+	 pointers compare as equal between the normal executable and
+	 the shared library.  */
+      if (! info->shared
+	  && (h->elf_link_hash_flags & ELF_LINK_HASH_DEF_REGULAR) == 0)
+	{
+	  h->root.u.def.section = s;
+	  h->root.u.def.value = plt_offset;
+	}
+
+      h->plt.offset = plt_offset;
+
+      /* Make room for this entry.  After the 8192nd entry, room
+         for two entries is allocated.  */
+      if ((s->_raw_size - PLT_INITIAL_ENTRY_SIZE) / PLT_ENTRY_SIZE
+	  >= PLT_NUM_SINGLE_ENTRIES)
+	s->_raw_size += 2 * PLT_ENTRY_SIZE;
+      else
+	s->_raw_size += PLT_ENTRY_SIZE;
+
+      /* We also need to make an entry in the .rela.plt section.  */
+      s = bfd_get_section_by_name (dynobj, ".rela.plt");
+      BFD_ASSERT (s != NULL);
+      s->_raw_size += sizeof (Elf32_External_Rela);
+
+      return true;
+    }
+  else
+    h->plt.offset = (bfd_vma) -1;
+
+  /* If this is a weak symbol, and there is a real definition, the
+     processor independent code will have arranged for us to see the
+     real definition first, and we can just use the same value.  */
+  if (h->weakdef != NULL)
+    {
+      BFD_ASSERT (h->weakdef->root.type == bfd_link_hash_defined
+		  || h->weakdef->root.type == bfd_link_hash_defweak);
+      h->root.u.def.section = h->weakdef->root.u.def.section;
+      h->root.u.def.value = h->weakdef->root.u.def.value;
+      return true;
+    }
+
+  /* This is a reference to a symbol defined by a dynamic object which
+     is not a function.  */
+
+  /* If we are creating a shared library, we must presume that the
+     only references to the symbol are via the global offset table.
+     For such cases we need not do anything here; the relocations will
+     be handled correctly by relocate_section.  */
+  if (info->shared)
+    return true;
+
+  /* We must allocate the symbol in our .dynbss section, which will
+     become part of the .bss section of the executable.  There will be
+     an entry for this symbol in the .dynsym section.  The dynamic
+     object will contain position independent code, so all references
+     from the dynamic object to this symbol will go through the global
+     offset table.  The dynamic linker will use the .dynsym entry to
+     determine the address it must put in the global offset table, so
+     both the dynamic object and the regular object will refer to the
+     same memory location for the variable.
+
+     Of course, if the symbol is sufficiently small, we must instead
+     allocate it in .sbss.  FIXME: It would be better to do this if and
+     only if there were actually SDAREL relocs for that symbol.  */
+
+  if (h->size <= elf_gp_size (dynobj))
+    s = bfd_get_section_by_name (dynobj, ".dynsbss");
+  else
+    s = bfd_get_section_by_name (dynobj, ".dynbss");
+  BFD_ASSERT (s != NULL);
+
+  /* We must generate a R_PPC_COPY reloc to tell the dynamic linker to
+     copy the initial value out of the dynamic object and into the
+     runtime process image.  We need to remember the offset into the
+     .rela.bss section we are going to use.  */
+  if ((h->root.u.def.section->flags & SEC_ALLOC) != 0)
+    {
+      asection *srel;
+
+      if (h->size <= elf_gp_size (dynobj))
+	srel = bfd_get_section_by_name (dynobj, ".rela.sbss");
+      else
+	srel = bfd_get_section_by_name (dynobj, ".rela.bss");
+      BFD_ASSERT (srel != NULL);
+      srel->_raw_size += sizeof (Elf32_External_Rela);
+      h->elf_link_hash_flags |= ELF_LINK_HASH_NEEDS_COPY;
+    }
+
+  /* We need to figure out the alignment required for this symbol.  I
+     have no idea how ELF linkers handle this.  */
+  power_of_two = bfd_log2 (h->size);
+  if (power_of_two > 4)
+    power_of_two = 4;
+
+  /* Apply the required alignment.  */
+  s->_raw_size = BFD_ALIGN (s->_raw_size,
+			    (bfd_size_type) (1 << power_of_two));
+  if (power_of_two > bfd_get_section_alignment (dynobj, s))
+    {
+      if (! bfd_set_section_alignment (dynobj, s, power_of_two))
+	return false;
+    }
+
+  /* Define the symbol as being at this point in the section.  */
+  h->root.u.def.section = s;
+  h->root.u.def.value = s->_raw_size;
+
+  /* Increment the section size to make room for the symbol.  */
+  s->_raw_size += h->size;
+
+  return true;
+}
+
+/* Set the sizes of the dynamic sections.  */
+
+static boolean
+ppc_elf_size_dynamic_sections (output_bfd, info)
+     bfd *output_bfd ATTRIBUTE_UNUSED;
+     struct bfd_link_info *info;
+{
+  bfd *dynobj;
+  asection *s;
+  boolean plt;
+  boolean relocs;
+
+#ifdef DEBUG
+  fprintf (stderr, "ppc_elf_size_dynamic_sections called\n");
+#endif
+
+  dynobj = elf_hash_table (info)->dynobj;
+  BFD_ASSERT (dynobj != NULL);
+
+  if (elf_hash_table (info)->dynamic_sections_created)
+    {
+      /* Set the contents of the .interp section to the interpreter.  */
+      if (! info->shared)
+	{
+	  s = bfd_get_section_by_name (dynobj, ".interp");
+	  BFD_ASSERT (s != NULL);
+	  s->_raw_size = sizeof ELF_DYNAMIC_INTERPRETER;
+	  s->contents = (unsigned char *) ELF_DYNAMIC_INTERPRETER;
+	}
+    }
+  else
+    {
+      /* We may have created entries in the .rela.got, .rela.sdata, and
+	 .rela.sdata2 sections.  However, if we are not creating the
+	 dynamic sections, we will not actually use these entries.  Reset
+	 the size of .rela.got, et al, which will cause it to get
+	 stripped from the output file below.  */
+      static char *rela_sections[] = { ".rela.got", ".rela.sdata",
+				       ".rela.sdata2", ".rela.sbss",
+				       (char *) 0 };
+      char **p;
+
+      for (p = rela_sections; *p != (char *) 0; p++)
+	{
+	  s = bfd_get_section_by_name (dynobj, *p);
+	  if (s != NULL)
+	    s->_raw_size = 0;
+	}
+    }
+
+  /* The check_relocs and adjust_dynamic_symbol entry points have
+     determined the sizes of the various dynamic sections.  Allocate
+     memory for them.  */
+  plt = false;
+  relocs = false;
+  for (s = dynobj->sections; s != NULL; s = s->next)
+    {
+      const char *name;
+      boolean strip;
+
+      if ((s->flags & SEC_LINKER_CREATED) == 0)
+	continue;
+
+      /* It's OK to base decisions on the section name, because none
+	 of the dynobj section names depend upon the input files.  */
+      name = bfd_get_section_name (dynobj, s);
+
+      strip = false;
+
+      if (strcmp (name, ".plt") == 0)
+	{
+	  if (s->_raw_size == 0)
+	    {
+	      /* Strip this section if we don't need it; see the
+                 comment below.  */
+	      strip = true;
+	    }
+	  else
+	    {
+	      /* Remember whether there is a PLT.  */
+	      plt = true;
+	    }
+	}
+      else if (strncmp (name, ".rela", 5) == 0)
+	{
+	  if (s->_raw_size == 0)
+	    {
+	      /* If we don't need this section, strip it from the
+		 output file.  This is mostly to handle .rela.bss and
+		 .rela.plt.  We must create both sections in
+		 create_dynamic_sections, because they must be created
+		 before the linker maps input sections to output
+		 sections.  The linker does that before
+		 adjust_dynamic_symbol is called, and it is that
+		 function which decides whether anything needs to go
+		 into these sections.  */
+	      strip = true;
+	    }
+	  else
+	    {
+	      /* Remember whether there are any relocation sections.  */
+	      relocs = true;
+
+	      /* We use the reloc_count field as a counter if we need
+		 to copy relocs into the output file.  */
+	      s->reloc_count = 0;
+	    }
+	}
+      else if (strcmp (name, ".got") != 0
+	       && strcmp (name, ".sdata") != 0
+	       && strcmp (name, ".sdata2") != 0)
+	{
+	  /* It's not one of our sections, so don't allocate space.  */
+	  continue;
+	}
+
+      if (strip)
+	{
+	  _bfd_strip_section_from_output (info, s);
+	  continue;
+	}
+
+      /* Allocate memory for the section contents.  */
+      s->contents = (bfd_byte *) bfd_zalloc (dynobj, s->_raw_size);
+      if (s->contents == NULL && s->_raw_size != 0)
+	return false;
+    }
+
+  if (elf_hash_table (info)->dynamic_sections_created)
+    {
+      /* Add some entries to the .dynamic section.  We fill in the
+	 values later, in ppc_elf_finish_dynamic_sections, but we
+	 must add the entries now so that we get the correct size for
+	 the .dynamic section.  The DT_DEBUG entry is filled in by the
+	 dynamic linker and used by the debugger.  */
+#define add_dynamic_entry(TAG, VAL) \
+  bfd_elf32_add_dynamic_entry (info, (bfd_vma) (TAG), (bfd_vma) (VAL))
+
+      if (!info->shared)
+	{
+	  if (!add_dynamic_entry (DT_DEBUG, 0))
+	    return false;
+	}
+
+      if (plt)
+	{
+	  if (!add_dynamic_entry (DT_PLTGOT, 0)
+	      || !add_dynamic_entry (DT_PLTRELSZ, 0)
+	      || !add_dynamic_entry (DT_PLTREL, DT_RELA)
+	      || !add_dynamic_entry (DT_JMPREL, 0))
+	    return false;
+	}
+
+      if (relocs)
+	{
+	  if (!add_dynamic_entry (DT_RELA, 0)
+	      || !add_dynamic_entry (DT_RELASZ, 0)
+	      || !add_dynamic_entry (DT_RELAENT, sizeof (Elf32_External_Rela)))
+	    return false;
+	}
+
+      if ((info->flags & DF_TEXTREL) != 0)
+	{
+	  if (!add_dynamic_entry (DT_TEXTREL, 0))
+	    return false;
+	  info->flags |= DF_TEXTREL;
+	}
+    }
+#undef add_dynamic_entry
+
+  return true;
+}
+
+/* Look through the relocs for a section during the first phase, and
+   allocate space in the global offset table or procedure linkage
+   table.  */
+
+static boolean
+ppc_elf_check_relocs (abfd, info, sec, relocs)
+     bfd *abfd;
+     struct bfd_link_info *info;
+     asection *sec;
+     const Elf_Internal_Rela *relocs;
+{
+  bfd *dynobj;
+  Elf_Internal_Shdr *symtab_hdr;
+  struct elf_link_hash_entry **sym_hashes, **sym_hashes_end;
+  const Elf_Internal_Rela *rel;
+  const Elf_Internal_Rela *rel_end;
+  bfd_signed_vma *local_got_refcounts;
+  elf_linker_section_t *sdata;
+  elf_linker_section_t *sdata2;
+  asection *sreloc;
+  asection *sgot = NULL;
+  asection *srelgot = NULL;
+
+  if (info->relocateable)
+    return true;
+
+#ifdef DEBUG
+  fprintf (stderr, "ppc_elf_check_relocs called for section %s in %s\n",
+	   bfd_get_section_name (abfd, sec),
+	   bfd_archive_filename (abfd));
+#endif
+
+  /* Create the linker generated sections all the time so that the
+     special symbols are created.  */
+
+  if ((sdata = elf_linker_section (abfd, LINKER_SECTION_SDATA)) == NULL)
+    {
+      sdata = ppc_elf_create_linker_section (abfd, info, LINKER_SECTION_SDATA);
+      if (!sdata)
+	return false;
+    }
+
+  if ((sdata2 = elf_linker_section (abfd, LINKER_SECTION_SDATA2)) == NULL)
+    {
+      sdata2 = ppc_elf_create_linker_section (abfd, info, LINKER_SECTION_SDATA2);
+      if (!sdata2)
+	return false;
+    }
+
+  dynobj = elf_hash_table (info)->dynobj;
+  symtab_hdr = &elf_tdata (abfd)->symtab_hdr;
+  local_got_refcounts = elf_local_got_refcounts (abfd);
+
+  sym_hashes = elf_sym_hashes (abfd);
+  sym_hashes_end = sym_hashes + symtab_hdr->sh_size/sizeof (Elf32_External_Sym);
+  if (!elf_bad_symtab (abfd))
+    sym_hashes_end -= symtab_hdr->sh_info;
+
+  sreloc = NULL;
+
+  rel_end = relocs + sec->reloc_count;
+  for (rel = relocs; rel < rel_end; rel++)
+    {
+      unsigned long r_symndx;
+      struct elf_link_hash_entry *h;
+
+      r_symndx = ELF32_R_SYM (rel->r_info);
+      if (r_symndx < symtab_hdr->sh_info)
+	h = NULL;
+      else
+	h = sym_hashes[r_symndx - symtab_hdr->sh_info];
+
+      /* If a relocation refers to _GLOBAL_OFFSET_TABLE_, create the .got.
+	 This shows up in particular in an R_PPC_ADDR32 in the eabi
+	 startup code.  */
+      if (h && strcmp (h->root.root.string, "_GLOBAL_OFFSET_TABLE_") == 0)
+	{
+	  if (sgot == NULL)
+	    {
+	      if (dynobj == NULL)
+		elf_hash_table (info)->dynobj = dynobj = abfd;
+	      sgot = ppc_elf_create_got (dynobj, info);
+	      if (sgot == NULL)
+		return false;
+	    }
+	}
+
+      switch (ELF32_R_TYPE (rel->r_info))
+	{
+	/* GOT16 relocations */
+	case R_PPC_GOT16:
+	case R_PPC_GOT16_LO:
+	case R_PPC_GOT16_HI:
+	case R_PPC_GOT16_HA:
+	  /* This symbol requires a global offset table entry.  */
+
+	  if (sgot == NULL)
+	    {
+	      if (dynobj == NULL)
+		elf_hash_table (info)->dynobj = dynobj = abfd;
+	      sgot = ppc_elf_create_got (dynobj, info);
+	      if (sgot == NULL)
+		return false;
+	    }
+
+	  if (srelgot == NULL
+	      && (h != NULL || info->shared))
+	    {
+	      srelgot = bfd_get_section_by_name (dynobj, ".rela.got");
+	      if (srelgot == NULL)
+		{
+		  srelgot = bfd_make_section (dynobj, ".rela.got");
+		  if (srelgot == NULL
+		      || ! bfd_set_section_flags (dynobj, srelgot,
+						  (SEC_ALLOC
+						   | SEC_LOAD
+						   | SEC_HAS_CONTENTS
+						   | SEC_IN_MEMORY
+						   | SEC_LINKER_CREATED
+						   | SEC_READONLY))
+		      || ! bfd_set_section_alignment (dynobj, srelgot, 2))
+		    return false;
+		}
+	    }
+
+	  if (h != NULL)
+	    {
+	      if (h->got.refcount == 0)
+		{
+		  /* Make sure this symbol is output as a dynamic symbol.  */
+		  if (h->dynindx == -1)
+		    if (!bfd_elf32_link_record_dynamic_symbol (info, h))
+		      return false;
+
+		  /* Allocate space in the .got.  */
+		  sgot->_raw_size += 4;
+		  /* Allocate relocation space.  */
+		  srelgot->_raw_size += sizeof (Elf32_External_Rela);
+		}
+	      h->got.refcount++;
+	    }
+	  else
+	    {
+	      /* This is a global offset table entry for a local symbol.  */
+	      if (local_got_refcounts == NULL)
+		{
+		  bfd_size_type size;
+
+		  size = symtab_hdr->sh_info;
+		  size *= sizeof (bfd_signed_vma);
+		  local_got_refcounts
+		    = (bfd_signed_vma *) bfd_zalloc (abfd, size);
+		  if (local_got_refcounts == NULL)
+		    return false;
+		  elf_local_got_refcounts (abfd) = local_got_refcounts;
+		}
+	      if (local_got_refcounts[r_symndx] == 0)
+		{
+		  sgot->_raw_size += 4;
+
+		  /* If we are generating a shared object, we need to
+                     output a R_PPC_RELATIVE reloc so that the
+                     dynamic linker can adjust this GOT entry.  */
+		  if (info->shared)
+		    srelgot->_raw_size += sizeof (Elf32_External_Rela);
+		}
+	      local_got_refcounts[r_symndx]++;
+	    }
+	  break;
+
+	/* Indirect .sdata relocation */
+	case R_PPC_EMB_SDAI16:
+	  if (info->shared)
+	    {
+	      ((*_bfd_error_handler)
+	       (_("%s: relocation %s cannot be used when making a shared object"),
+		bfd_archive_filename (abfd), "R_PPC_EMB_SDAI16"));
+	      return false;
+	    }
+
+	  if (srelgot == NULL && (h != NULL || info->shared))
+	    {
+	      srelgot = bfd_get_section_by_name (dynobj, ".rela.got");
+	      if (srelgot == NULL)
+		{
+		  srelgot = bfd_make_section (dynobj, ".rela.got");
+		  if (srelgot == NULL
+		      || ! bfd_set_section_flags (dynobj, srelgot,
+						  (SEC_ALLOC
+						   | SEC_LOAD
+						   | SEC_HAS_CONTENTS
+						   | SEC_IN_MEMORY
+						   | SEC_LINKER_CREATED
+						   | SEC_READONLY))
+		      || ! bfd_set_section_alignment (dynobj, srelgot, 2))
+		    return false;
+		}
+	    }
+
+	  if (!bfd_elf32_create_pointer_linker_section (abfd, info, sdata, h, rel))
+	    return false;
+
+	  break;
+
+	/* Indirect .sdata2 relocation */
+	case R_PPC_EMB_SDA2I16:
+	  if (info->shared)
+	    {
+	      ((*_bfd_error_handler)
+	       (_("%s: relocation %s cannot be used when making a shared object"),
+		bfd_archive_filename (abfd), "R_PPC_EMB_SDA2I16"));
+	      return false;
+	    }
+
+	  if (srelgot == NULL && (h != NULL || info->shared))
+	    {
+	      srelgot = bfd_get_section_by_name (dynobj, ".rela.got");
+	      if (srelgot == NULL)
+		{
+		  srelgot = bfd_make_section (dynobj, ".rela.got");
+		  if (srelgot == NULL
+		      || ! bfd_set_section_flags (dynobj, srelgot,
+						  (SEC_ALLOC
+						   | SEC_LOAD
+						   | SEC_HAS_CONTENTS
+						   | SEC_IN_MEMORY
+						   | SEC_LINKER_CREATED
+						   | SEC_READONLY))
+		      || ! bfd_set_section_alignment (dynobj, srelgot, 2))
+		    return false;
+		}
+	    }
+
+	  if (!bfd_elf32_create_pointer_linker_section (abfd, info, sdata2, h, rel))
+	    return false;
+
+	  break;
+
+	case R_PPC_SDAREL16:
+	case R_PPC_EMB_SDA2REL:
+	case R_PPC_EMB_SDA21:
+	  if (info->shared)
+	    {
+	      ((*_bfd_error_handler)
+	       (_("%s: relocation %s cannot be used when making a shared object"),
+		bfd_archive_filename (abfd),
+		ppc_elf_howto_table[(int) ELF32_R_TYPE (rel->r_info)]->name));
+	      return false;
+	    }
+	  break;
+
+	case R_PPC_PLT32:
+	case R_PPC_PLTREL24:
+	case R_PPC_PLT16_LO:
+	case R_PPC_PLT16_HI:
+	case R_PPC_PLT16_HA:
+#ifdef DEBUG
+	  fprintf (stderr, "Reloc requires a PLT entry\n");
+#endif
+	  /* This symbol requires a procedure linkage table entry.  We
+             actually build the entry in adjust_dynamic_symbol,
+             because this might be a case of linking PIC code without
+             linking in any dynamic objects, in which case we don't
+             need to generate a procedure linkage table after all.  */
+
+	  if (h == NULL)
+	    {
+	      /* It does not make sense to have a procedure linkage
+                 table entry for a local symbol.  */
+	      bfd_set_error (bfd_error_bad_value);
+	      return false;
+	    }
+
+	  /* Make sure this symbol is output as a dynamic symbol.  */
+	  if (h->dynindx == -1)
+	    {
+	      if (! bfd_elf32_link_record_dynamic_symbol (info, h))
+		return false;
+	    }
+	  h->elf_link_hash_flags |= ELF_LINK_HASH_NEEDS_PLT;
+	  h->plt.refcount++;
+	  break;
+
+	  /* The following relocations don't need to propagate the
+	     relocation if linking a shared object since they are
+	     section relative.  */
+	case R_PPC_SECTOFF:
+	case R_PPC_SECTOFF_LO:
+	case R_PPC_SECTOFF_HI:
+	case R_PPC_SECTOFF_HA:
+	  break;
+
+	  /* This refers only to functions defined in the shared library */
+	case R_PPC_LOCAL24PC:
+	  break;
+
+	  /* This relocation describes the C++ object vtable hierarchy.
+	     Reconstruct it for later use during GC.  */
+	case R_PPC_GNU_VTINHERIT:
+	  if (!_bfd_elf32_gc_record_vtinherit (abfd, sec, h, rel->r_offset))
+	    return false;
+	  break;
+
+	  /* This relocation describes which C++ vtable entries are actually
+	     used.  Record for later use during GC.  */
+	case R_PPC_GNU_VTENTRY:
+	  if (!_bfd_elf32_gc_record_vtentry (abfd, sec, h, rel->r_addend))
+	    return false;
+	  break;
+
+	  /* When creating a shared object, we must copy these
+	     relocs into the output file.  We create a reloc
+	     section in dynobj and make room for the reloc.  */
+	case R_PPC_REL24:
+	case R_PPC_REL14:
+	case R_PPC_REL14_BRTAKEN:
+	case R_PPC_REL14_BRNTAKEN:
+	case R_PPC_REL32:
+	  if (h == NULL
+	      || strcmp (h->root.root.string, "_GLOBAL_OFFSET_TABLE_") == 0
+	      || SYMBOL_REFERENCES_LOCAL (info, h))
+	    break;
+	  /* fall through */
+
+	default:
+	  if (info->shared)
+	    {
+#ifdef DEBUG
+	      fprintf (stderr, "ppc_elf_check_relocs need to create relocation for %s\n",
+		       (h && h->root.root.string) ? h->root.root.string : "<unknown>");
+#endif
+	      if (sreloc == NULL)
+		{
+		  const char *name;
+
+		  name = (bfd_elf_string_from_elf_section
+			  (abfd,
+			   elf_elfheader (abfd)->e_shstrndx,
+			   elf_section_data (sec)->rel_hdr.sh_name));
+		  if (name == NULL)
+		    return false;
+
+		  BFD_ASSERT (strncmp (name, ".rela", 5) == 0
+			      && strcmp (bfd_get_section_name (abfd, sec),
+					 name + 5) == 0);
+
+		  sreloc = bfd_get_section_by_name (dynobj, name);
+		  if (sreloc == NULL)
+		    {
+		      flagword flags;
+
+		      sreloc = bfd_make_section (dynobj, name);
+		      flags = (SEC_HAS_CONTENTS | SEC_READONLY
+			       | SEC_IN_MEMORY | SEC_LINKER_CREATED);
+		      if ((sec->flags & SEC_ALLOC) != 0)
+			flags |= SEC_ALLOC | SEC_LOAD;
+		      if (sreloc == NULL
+			  || ! bfd_set_section_flags (dynobj, sreloc, flags)
+			  || ! bfd_set_section_alignment (dynobj, sreloc, 2))
+			return false;
+		    }
+		  if (sec->flags & SEC_READONLY)
+		    info->flags |= DF_TEXTREL;
+		}
+
+	      sreloc->_raw_size += sizeof (Elf32_External_Rela);
+
+	      /* FIXME: We should here do what the m68k and i386
+		 backends do: if the reloc is pc-relative, record it
+		 in case it turns out that the reloc is unnecessary
+		 because the symbol is forced local by versioning or
+		 we are linking with -Bdynamic.  Fortunately this
+		 case is not frequent.  */
+	    }
+
+	  break;
+	}
+    }
+
+  return true;
+}
+
+/* Return the section that should be marked against GC for a given
+   relocation.  */
+
+static asection *
+ppc_elf_gc_mark_hook (sec, info, rel, h, sym)
+     asection *sec;
+     struct bfd_link_info *info ATTRIBUTE_UNUSED;
+     Elf_Internal_Rela *rel;
+     struct elf_link_hash_entry *h;
+     Elf_Internal_Sym *sym;
+{
+  if (h != NULL)
+    {
+      switch (ELF32_R_TYPE (rel->r_info))
+	{
+	case R_PPC_GNU_VTINHERIT:
+	case R_PPC_GNU_VTENTRY:
+	  break;
+
+	default:
+	  switch (h->root.type)
+	    {
+	    case bfd_link_hash_defined:
+	    case bfd_link_hash_defweak:
+	      return h->root.u.def.section;
+
+	    case bfd_link_hash_common:
+	      return h->root.u.c.p->section;
+
+	    default:
+	      break;
+	    }
+	}
+    }
+  else
+    return bfd_section_from_elf_index (sec->owner, sym->st_shndx);
+
+  return NULL;
+}
+
+/* Update the got entry reference counts for the section being removed.  */
+
+static boolean
+ppc_elf_gc_sweep_hook (abfd, info, sec, relocs)
+     bfd *abfd;
+     struct bfd_link_info *info ATTRIBUTE_UNUSED;
+     asection *sec;
+     const Elf_Internal_Rela *relocs;
+{
+  Elf_Internal_Shdr *symtab_hdr;
+  struct elf_link_hash_entry **sym_hashes;
+  bfd_signed_vma *local_got_refcounts;
+  const Elf_Internal_Rela *rel, *relend;
+  unsigned long r_symndx;
+  struct elf_link_hash_entry *h;
+
+  symtab_hdr = &elf_tdata (abfd)->symtab_hdr;
+  sym_hashes = elf_sym_hashes (abfd);
+  local_got_refcounts = elf_local_got_refcounts (abfd);
+
+  relend = relocs + sec->reloc_count;
+  for (rel = relocs; rel < relend; rel++)
+    switch (ELF32_R_TYPE (rel->r_info))
+      {
+      case R_PPC_GOT16:
+      case R_PPC_GOT16_LO:
+      case R_PPC_GOT16_HI:
+      case R_PPC_GOT16_HA:
+	r_symndx = ELF32_R_SYM (rel->r_info);
+	if (r_symndx >= symtab_hdr->sh_info)
+	  {
+	    h = sym_hashes[r_symndx - symtab_hdr->sh_info];
+	    if (h->got.refcount > 0)
+	      h->got.refcount--;
+	  }
+	else if (local_got_refcounts != NULL)
+	  {
+	    if (local_got_refcounts[r_symndx] > 0)
+	      local_got_refcounts[r_symndx]--;
+	  }
+        break;
+
+      case R_PPC_PLT32:
+      case R_PPC_PLTREL24:
+      case R_PPC_PLT16_LO:
+      case R_PPC_PLT16_HI:
+      case R_PPC_PLT16_HA:
+	r_symndx = ELF32_R_SYM (rel->r_info);
+	if (r_symndx >= symtab_hdr->sh_info)
+	  {
+	    h = sym_hashes[r_symndx - symtab_hdr->sh_info];
+	    if (h->plt.refcount > 0)
+	      h->plt.refcount--;
+	  }
+	break;
+
+      default:
+	break;
+      }
+
+  return true;
+}
+
+/* Hook called by the linker routine which adds symbols from an object
+   file.  We use it to put .comm items in .sbss, and not .bss.  */
+
+static boolean
+ppc_elf_add_symbol_hook (abfd, info, sym, namep, flagsp, secp, valp)
+     bfd *abfd;
+     struct bfd_link_info *info;
+     const Elf_Internal_Sym *sym;
+     const char **namep ATTRIBUTE_UNUSED;
+     flagword *flagsp ATTRIBUTE_UNUSED;
+     asection **secp;
+     bfd_vma *valp;
+{
+  if (sym->st_shndx == SHN_COMMON
+      && !info->relocateable
+      && sym->st_size <= elf_gp_size (abfd)
+      && info->hash->creator->flavour == bfd_target_elf_flavour)
+    {
+      /* Common symbols less than or equal to -G nn bytes are automatically
+	 put into .sdata.  */
+      elf_linker_section_t *sdata
+	= ppc_elf_create_linker_section (abfd, info, LINKER_SECTION_SDATA);
+
+      if (!sdata->bss_section)
+	{
+	  bfd_size_type amt;
+
+	  /* We don't go through bfd_make_section, because we don't
+             want to attach this common section to DYNOBJ.  The linker
+             will move the symbols to the appropriate output section
+             when it defines common symbols.  */
+	  amt = sizeof (asection);
+	  sdata->bss_section = (asection *) bfd_zalloc (abfd, amt);
+	  if (sdata->bss_section == NULL)
+	    return false;
+	  sdata->bss_section->name = sdata->bss_name;
+	  sdata->bss_section->flags = SEC_IS_COMMON;
+	  sdata->bss_section->output_section = sdata->bss_section;
+	  amt = sizeof (asymbol);
+	  sdata->bss_section->symbol = (asymbol *) bfd_zalloc (abfd, amt);
+	  amt = sizeof (asymbol *);
+	  sdata->bss_section->symbol_ptr_ptr =
+	    (asymbol **) bfd_zalloc (abfd, amt);
+	  if (sdata->bss_section->symbol == NULL
+	      || sdata->bss_section->symbol_ptr_ptr == NULL)
+	    return false;
+	  sdata->bss_section->symbol->name = sdata->bss_name;
+	  sdata->bss_section->symbol->flags = BSF_SECTION_SYM;
+	  sdata->bss_section->symbol->section = sdata->bss_section;
+	  *sdata->bss_section->symbol_ptr_ptr = sdata->bss_section->symbol;
+	}
+
+      *secp = sdata->bss_section;
+      *valp = sym->st_size;
+    }
+
+  return true;
+}
+
+/* Finish up dynamic symbol handling.  We set the contents of various
+   dynamic sections here.  */
+
+static boolean
+ppc_elf_finish_dynamic_symbol (output_bfd, info, h, sym)
+     bfd *output_bfd;
+     struct bfd_link_info *info;
+     struct elf_link_hash_entry *h;
+     Elf_Internal_Sym *sym;
+{
+  bfd *dynobj;
+
+#ifdef DEBUG
+  fprintf (stderr, "ppc_elf_finish_dynamic_symbol called for %s",
+	   h->root.root.string);
+#endif
+
+  dynobj = elf_hash_table (info)->dynobj;
+  BFD_ASSERT (dynobj != NULL);
+
+  if (h->plt.offset != (bfd_vma) -1)
+    {
+      asection *splt;
+      asection *srela;
+      Elf_Internal_Rela rela;
+      bfd_vma reloc_index;
+
+#ifdef DEBUG
+      fprintf (stderr, ", plt_offset = %d", h->plt.offset);
+#endif
+
+      /* This symbol has an entry in the procedure linkage table.  Set
+         it up.  */
+
+      BFD_ASSERT (h->dynindx != -1);
+
+      splt = bfd_get_section_by_name (dynobj, ".plt");
+      srela = bfd_get_section_by_name (dynobj, ".rela.plt");
+      BFD_ASSERT (splt != NULL && srela != NULL);
+
+      /* We don't need to fill in the .plt.  The ppc dynamic linker
+	 will fill it in.  */
+
+      /* Fill in the entry in the .rela.plt section.  */
+      rela.r_offset = (splt->output_section->vma
+		       + splt->output_offset
+		       + h->plt.offset);
+      rela.r_info = ELF32_R_INFO (h->dynindx, R_PPC_JMP_SLOT);
+      rela.r_addend = 0;
+
+      reloc_index = (h->plt.offset - PLT_INITIAL_ENTRY_SIZE) / PLT_SLOT_SIZE;
+      if (reloc_index > PLT_NUM_SINGLE_ENTRIES)
+	reloc_index -= (reloc_index - PLT_NUM_SINGLE_ENTRIES) / 2;
+      bfd_elf32_swap_reloca_out (output_bfd, &rela,
+				 ((Elf32_External_Rela *) srela->contents
+				  + reloc_index));
+
+      if ((h->elf_link_hash_flags & ELF_LINK_HASH_DEF_REGULAR) == 0)
+	{
+	  /* Mark the symbol as undefined, rather than as defined in
+	     the .plt section.  Leave the value alone.  */
+	  sym->st_shndx = SHN_UNDEF;
+	  /* If the symbol is weak, we do need to clear the value.
+	     Otherwise, the PLT entry would provide a definition for
+	     the symbol even if the symbol wasn't defined anywhere,
+	     and so the symbol would never be NULL.  */
+	  if ((h->elf_link_hash_flags & ELF_LINK_HASH_REF_REGULAR_NONWEAK)
+	      == 0)
+	    sym->st_value = 0;
+	}
+    }
+
+  if (h->got.offset != (bfd_vma) -1)
+    {
+      asection *sgot;
+      asection *srela;
+      Elf_Internal_Rela rela;
+
+      /* This symbol has an entry in the global offset table.  Set it
+         up.  */
+
+      sgot = bfd_get_section_by_name (dynobj, ".got");
+      srela = bfd_get_section_by_name (dynobj, ".rela.got");
+      BFD_ASSERT (sgot != NULL && srela != NULL);
+
+      rela.r_offset = (sgot->output_section->vma
+		       + sgot->output_offset
+		       + (h->got.offset &~ (bfd_vma) 1));
+
+      /* If this is a -Bsymbolic link, and the symbol is defined
+	 locally, we just want to emit a RELATIVE reloc.  The entry in
+	 the global offset table will already have been initialized in
+	 the relocate_section function.  */
+      if (info->shared
+	  && SYMBOL_REFERENCES_LOCAL (info, h))
+	{
+	  rela.r_info = ELF32_R_INFO (0, R_PPC_RELATIVE);
+	  rela.r_addend = (h->root.u.def.value
+			   + h->root.u.def.section->output_section->vma
+			   + h->root.u.def.section->output_offset);
+	}
+      else
+	{
+	  BFD_ASSERT ((h->got.offset & 1) == 0);
+	  rela.r_info = ELF32_R_INFO (h->dynindx, R_PPC_GLOB_DAT);
+	  rela.r_addend = 0;
+	}
+
+      bfd_put_32 (output_bfd, (bfd_vma) 0, sgot->contents + h->got.offset);
+      bfd_elf32_swap_reloca_out (output_bfd, &rela,
+				 ((Elf32_External_Rela *) srela->contents
+				  + srela->reloc_count));
+      ++srela->reloc_count;
+    }
+
+  if ((h->elf_link_hash_flags & ELF_LINK_HASH_NEEDS_COPY) != 0)
+    {
+      asection *s;
+      Elf_Internal_Rela rela;
+
+      /* This symbols needs a copy reloc.  Set it up.  */
+
+#ifdef DEBUG
+      fprintf (stderr, ", copy");
+#endif
+
+      BFD_ASSERT (h->dynindx != -1);
+
+      if (h->size <= elf_gp_size (dynobj))
+	s = bfd_get_section_by_name (h->root.u.def.section->owner,
+				     ".rela.sbss");
+      else
+	s = bfd_get_section_by_name (h->root.u.def.section->owner,
+				     ".rela.bss");
+      BFD_ASSERT (s != NULL);
+
+      rela.r_offset = (h->root.u.def.value
+		       + h->root.u.def.section->output_section->vma
+		       + h->root.u.def.section->output_offset);
+      rela.r_info = ELF32_R_INFO (h->dynindx, R_PPC_COPY);
+      rela.r_addend = 0;
+      bfd_elf32_swap_reloca_out (output_bfd, &rela,
+				 ((Elf32_External_Rela *) s->contents
+				  + s->reloc_count));
+      ++s->reloc_count;
+    }
+
+#ifdef DEBUG
+  fprintf (stderr, "\n");
+#endif
+
+  /* Mark some specially defined symbols as absolute.  */
+  if (strcmp (h->root.root.string, "_DYNAMIC") == 0
+      || strcmp (h->root.root.string, "_GLOBAL_OFFSET_TABLE_") == 0
+      || strcmp (h->root.root.string, "_PROCEDURE_LINKAGE_TABLE_") == 0)
+    sym->st_shndx = SHN_ABS;
+
+  return true;
+}
+
+/* Finish up the dynamic sections.  */
+
+static boolean
+ppc_elf_finish_dynamic_sections (output_bfd, info)
+     bfd *output_bfd;
+     struct bfd_link_info *info;
+{
+  asection *sdyn;
+  bfd *dynobj = elf_hash_table (info)->dynobj;
+  asection *sgot = bfd_get_section_by_name (dynobj, ".got");
+
+#ifdef DEBUG
+  fprintf (stderr, "ppc_elf_finish_dynamic_sections called\n");
+#endif
+
+  sdyn = bfd_get_section_by_name (dynobj, ".dynamic");
+
+  if (elf_hash_table (info)->dynamic_sections_created)
+    {
+      asection *splt;
+      Elf32_External_Dyn *dyncon, *dynconend;
+
+      splt = bfd_get_section_by_name (dynobj, ".plt");
+      BFD_ASSERT (splt != NULL && sdyn != NULL);
+
+      dyncon = (Elf32_External_Dyn *) sdyn->contents;
+      dynconend = (Elf32_External_Dyn *) (sdyn->contents + sdyn->_raw_size);
+      for (; dyncon < dynconend; dyncon++)
+	{
+	  Elf_Internal_Dyn dyn;
+	  const char *name;
+	  boolean size;
+
+	  bfd_elf32_swap_dyn_in (dynobj, dyncon, &dyn);
+
+	  switch (dyn.d_tag)
+	    {
+	    case DT_PLTGOT:   name = ".plt";	  size = false; break;
+	    case DT_PLTRELSZ: name = ".rela.plt"; size = true;  break;
+	    case DT_JMPREL:   name = ".rela.plt"; size = false; break;
+	    default:	      name = NULL;	  size = false; break;
+	    }
+
+	  if (name != NULL)
+	    {
+	      asection *s;
+
+	      s = bfd_get_section_by_name (output_bfd, name);
+	      if (s == NULL)
+		dyn.d_un.d_val = 0;
+	      else
+		{
+		  if (! size)
+		    dyn.d_un.d_ptr = s->vma;
+		  else
+		    {
+		      if (s->_cooked_size != 0)
+			dyn.d_un.d_val = s->_cooked_size;
+		      else
+			dyn.d_un.d_val = s->_raw_size;
+		    }
+		}
+	      bfd_elf32_swap_dyn_out (output_bfd, &dyn, dyncon);
+	    }
+	}
+    }
+
+  /* Add a blrl instruction at _GLOBAL_OFFSET_TABLE_-4 so that a function can
+     easily find the address of the _GLOBAL_OFFSET_TABLE_.  */
+  if (sgot)
+    {
+      unsigned char *contents = sgot->contents;
+      bfd_put_32 (output_bfd, (bfd_vma) 0x4e800021 /* blrl */, contents);
+
+      if (sdyn == NULL)
+	bfd_put_32 (output_bfd, (bfd_vma) 0, contents+4);
+      else
+	bfd_put_32 (output_bfd,
+		    sdyn->output_section->vma + sdyn->output_offset,
+		    contents+4);
+
+      elf_section_data (sgot->output_section)->this_hdr.sh_entsize = 4;
+    }
+
+  return true;
+}
+
+/* The RELOCATE_SECTION function is called by the ELF backend linker
+   to handle the relocations for a section.
+
+   The relocs are always passed as Rela structures; if the section
+   actually uses Rel structures, the r_addend field will always be
+   zero.
+
+   This function is responsible for adjust the section contents as
+   necessary, and (if using Rela relocs and generating a
+   relocateable output file) adjusting the reloc addend as
+   necessary.
+
+   This function does not have to worry about setting the reloc
+   address or the reloc symbol index.
+
+   LOCAL_SYMS is a pointer to the swapped in local symbols.
+
+   LOCAL_SECTIONS is an array giving the section in the input file
+   corresponding to the st_shndx field of each local symbol.
+
+   The global hash table entry for the global symbols can be found
+   via elf_sym_hashes (input_bfd).
+
+   When generating relocateable output, this function must handle
+   STB_LOCAL/STT_SECTION symbols specially.  The output symbol is
+   going to be the section symbol corresponding to the output
+   section, which means that the addend must be adjusted
+   accordingly.  */
+
+static boolean
+ppc_elf_relocate_section (output_bfd, info, input_bfd, input_section,
+			  contents, relocs, local_syms, local_sections)
+     bfd *output_bfd;
+     struct bfd_link_info *info;
+     bfd *input_bfd;
+     asection *input_section;
+     bfd_byte *contents;
+     Elf_Internal_Rela *relocs;
+     Elf_Internal_Sym *local_syms;
+     asection **local_sections;
+{
+  Elf_Internal_Shdr *symtab_hdr		  = &elf_tdata (input_bfd)->symtab_hdr;
+  struct elf_link_hash_entry **sym_hashes = elf_sym_hashes (input_bfd);
+  bfd *dynobj				  = elf_hash_table (info)->dynobj;
+  elf_linker_section_t *sdata		  = (dynobj) ? elf_linker_section (dynobj, LINKER_SECTION_SDATA)  : NULL;
+  elf_linker_section_t *sdata2		  = (dynobj) ? elf_linker_section (dynobj, LINKER_SECTION_SDATA2) : NULL;
+  Elf_Internal_Rela *rel		  = relocs;
+  Elf_Internal_Rela *relend		  = relocs + input_section->reloc_count;
+  asection *sreloc			  = NULL;
+  asection *splt;
+  asection *sgot;
+  bfd_vma *local_got_offsets;
+  boolean ret				  = true;
+  long insn;
+
+#ifdef DEBUG
+  fprintf (stderr, "ppc_elf_relocate_section called for %s section %s, %ld relocations%s\n",
+	   bfd_archive_filename (input_bfd),
+	   bfd_section_name(input_bfd, input_section),
+	   (long) input_section->reloc_count,
+	   (info->relocateable) ? " (relocatable)" : "");
+#endif
+
+  if (info->relocateable)
+    return true;
+
+  if (!ppc_elf_howto_table[R_PPC_ADDR32])
+    /* Initialize howto table if needed.  */
+    ppc_elf_howto_init ();
+
+  local_got_offsets = elf_local_got_offsets (input_bfd);
+
+  splt = sgot = NULL;
+  if (dynobj != NULL)
+    {
+      splt = bfd_get_section_by_name (dynobj, ".plt");
+      sgot = bfd_get_section_by_name (dynobj, ".got");
+    }
+
+  for (; rel < relend; rel++)
+    {
+      enum elf_ppc_reloc_type r_type	= (enum elf_ppc_reloc_type)ELF32_R_TYPE (rel->r_info);
+      bfd_vma offset			= rel->r_offset;
+      bfd_vma addend			= rel->r_addend;
+      bfd_reloc_status_type r		= bfd_reloc_other;
+      Elf_Internal_Sym *sym		= (Elf_Internal_Sym *) 0;
+      asection *sec			= (asection *) 0;
+      struct elf_link_hash_entry *h	= (struct elf_link_hash_entry *) 0;
+      const char *sym_name		= (const char *) 0;
+      reloc_howto_type *howto;
+      unsigned long r_symndx;
+      bfd_vma relocation;
+      int will_become_local;
+
+      /* Unknown relocation handling */
+      if ((unsigned) r_type >= (unsigned) R_PPC_max
+	  || !ppc_elf_howto_table[(int) r_type])
+	{
+	  (*_bfd_error_handler) (_("%s: unknown relocation type %d"),
+				 bfd_archive_filename (input_bfd),
+				 (int) r_type);
+
+	  bfd_set_error (bfd_error_bad_value);
+	  ret = false;
+	  continue;
+	}
+
+      howto = ppc_elf_howto_table[(int) r_type];
+      r_symndx = ELF32_R_SYM (rel->r_info);
+
+      if (r_symndx < symtab_hdr->sh_info)
+	{
+	  sym = local_syms + r_symndx;
+	  sec = local_sections[r_symndx];
+	  sym_name = "<local symbol>";
+
+	  relocation = _bfd_elf_rela_local_sym (output_bfd, sym, sec, rel);
+	  addend = rel->r_addend;
+	  /* Relocs to local symbols are always resolved.  */
+	  will_become_local = 1;
+	}
+      else
+	{
+	  h = sym_hashes[r_symndx - symtab_hdr->sh_info];
+	  while (h->root.type == bfd_link_hash_indirect
+		 || h->root.type == bfd_link_hash_warning)
+	    h = (struct elf_link_hash_entry *) h->root.u.i.link;
+	  sym_name = h->root.root.string;
+
+	  /* Can this relocation be resolved immediately?  */
+	  will_become_local = SYMBOL_REFERENCES_LOCAL (info, h);
+
+	  if (h->root.type == bfd_link_hash_defined
+	      || h->root.type == bfd_link_hash_defweak)
+	    {
+	      sec = h->root.u.def.section;
+	      if (((r_type == R_PPC_PLT32
+		    || r_type == R_PPC_PLTREL24)
+		   && splt != NULL
+		   && h->plt.offset != (bfd_vma) -1)
+		  || (r_type == R_PPC_LOCAL24PC
+		      && sec->output_section == NULL)
+		  || ((r_type == R_PPC_GOT16
+		       || r_type == R_PPC_GOT16_LO
+		       || r_type == R_PPC_GOT16_HI
+		       || r_type == R_PPC_GOT16_HA)
+		      && elf_hash_table (info)->dynamic_sections_created
+		      && (! info->shared || ! will_become_local))
+		  || (info->shared
+ 		      && ! will_become_local
+		      && ((input_section->flags & SEC_ALLOC) != 0
+			  /* Testing SEC_DEBUGGING here may be wrong.
+                             It's here to avoid a crash when
+                             generating a shared library with DWARF
+                             debugging information.  */
+			  || ((input_section->flags & SEC_DEBUGGING) != 0
+			      && (h->elf_link_hash_flags
+				  & ELF_LINK_HASH_DEF_DYNAMIC) != 0))
+		      && (r_type == R_PPC_ADDR32
+			  || r_type == R_PPC_ADDR24
+			  || r_type == R_PPC_ADDR16
+			  || r_type == R_PPC_ADDR16_LO
+			  || r_type == R_PPC_ADDR16_HI
+			  || r_type == R_PPC_ADDR16_HA
+			  || r_type == R_PPC_ADDR14
+			  || r_type == R_PPC_ADDR14_BRTAKEN
+			  || r_type == R_PPC_ADDR14_BRNTAKEN
+			  || r_type == R_PPC_COPY
+			  || r_type == R_PPC_GLOB_DAT
+			  || r_type == R_PPC_JMP_SLOT
+			  || r_type == R_PPC_UADDR32
+			  || r_type == R_PPC_UADDR16
+			  || r_type == R_PPC_SDAREL16
+			  || r_type == R_PPC_EMB_NADDR32
+			  || r_type == R_PPC_EMB_NADDR16
+			  || r_type == R_PPC_EMB_NADDR16_LO
+			  || r_type == R_PPC_EMB_NADDR16_HI
+			  || r_type == R_PPC_EMB_NADDR16_HA
+			  || r_type == R_PPC_EMB_SDAI16
+			  || r_type == R_PPC_EMB_SDA2I16
+			  || r_type == R_PPC_EMB_SDA2REL
+			  || r_type == R_PPC_EMB_SDA21
+			  || r_type == R_PPC_EMB_MRKREF
+			  || r_type == R_PPC_EMB_BIT_FLD
+			  || r_type == R_PPC_EMB_RELSDA
+			  || ((r_type == R_PPC_REL24
+			       || r_type == R_PPC_REL32
+			       || r_type == R_PPC_REL14
+			       || r_type == R_PPC_REL14_BRTAKEN
+			       || r_type == R_PPC_REL14_BRNTAKEN
+			       || r_type == R_PPC_RELATIVE)
+			      && strcmp (h->root.root.string,
+					 "_GLOBAL_OFFSET_TABLE_") != 0))))
+		{
+		  /* In these cases, we don't need the relocation
+                     value.  We check specially because in some
+                     obscure cases sec->output_section will be NULL.  */
+		  relocation = 0;
+		}
+	      else if (sec->output_section == NULL)
+		{
+                  (*_bfd_error_handler)
+                    (_("%s: warning: unresolvable relocation against symbol `%s' from %s section"),
+                     bfd_archive_filename (input_bfd), h->root.root.string,
+                     bfd_get_section_name (input_bfd, input_section));
+		  relocation = 0;
+		}
+	      else
+		relocation = (h->root.u.def.value
+			      + sec->output_section->vma
+			      + sec->output_offset);
+	    }
+	  else if (h->root.type == bfd_link_hash_undefweak)
+	    relocation = 0;
+	  else if (info->shared
+		   && (!info->symbolic || info->allow_shlib_undefined)
+		   && !info->no_undefined
+		   && ELF_ST_VISIBILITY (h->other) == STV_DEFAULT)
+	    relocation = 0;
+	  else
+	    {
+	      if (! (*info->callbacks->undefined_symbol) (info,
+							 h->root.root.string,
+							 input_bfd,
+							 input_section,
+							 rel->r_offset,
+							 (!info->shared
+							  || info->no_undefined
+							  || ELF_ST_VISIBILITY (h->other))))
+		return false;
+	      relocation = 0;
+	    }
+	}
+
+      switch ((int) r_type)
+	{
+	default:
+	  (*_bfd_error_handler) (_("%s: unknown relocation type %d for symbol %s"),
+				 bfd_archive_filename (input_bfd),
+				 (int) r_type, sym_name);
+
+	  bfd_set_error (bfd_error_bad_value);
+	  ret = false;
+	  continue;
+
+	case (int) R_PPC_NONE:
+	  continue;
+
+	/* Relocations that need no special processing.  */
+	case (int) R_PPC_LOCAL24PC:
+	  /* It makes no sense to point a local relocation
+	     at a symbol not in this object.  */
+	  if (h != NULL
+	      && (h->root.type == bfd_link_hash_defined
+		  || h->root.type == bfd_link_hash_defweak)
+	      && sec->output_section == NULL)
+	    {
+	      if (! (*info->callbacks->undefined_symbol) (info,
+							  h->root.root.string,
+							  input_bfd,
+							  input_section,
+							  rel->r_offset,
+							  true))
+		return false;
+	      continue;
+	    }
+	  break;
+
+	/* Relocations that may need to be propagated if this is a shared
+           object.  */
+	case (int) R_PPC_REL24:
+	case (int) R_PPC_REL32:
+	case (int) R_PPC_REL14:
+	  /* If these relocations are not to a named symbol, they can be
+	     handled right here, no need to bother the dynamic linker.  */
+	  if (h == NULL
+	      || strcmp (h->root.root.string, "_GLOBAL_OFFSET_TABLE_") == 0
+	      || SYMBOL_REFERENCES_LOCAL (info, h))
+	    break;
+	/* fall through */
+
+	/* Relocations that always need to be propagated if this is a shared
+           object.  */
+	case (int) R_PPC_ADDR32:
+	case (int) R_PPC_ADDR24:
+	case (int) R_PPC_ADDR16:
+	case (int) R_PPC_ADDR16_LO:
+	case (int) R_PPC_ADDR16_HI:
+	case (int) R_PPC_ADDR16_HA:
+	case (int) R_PPC_ADDR14:
+	case (int) R_PPC_UADDR32:
+	case (int) R_PPC_UADDR16:
+	  if (info->shared && r_symndx != 0)
+	    {
+	      Elf_Internal_Rela outrel;
+	      int skip;
+
+#ifdef DEBUG
+	      fprintf (stderr, "ppc_elf_relocate_section need to create relocation for %s\n",
+		       (h && h->root.root.string) ? h->root.root.string : "<unknown>");
+#endif
+
+	      /* When generating a shared object, these relocations
+                 are copied into the output file to be resolved at run
+                 time.  */
+
+	      if (sreloc == NULL)
+		{
+		  const char *name;
+
+		  name = (bfd_elf_string_from_elf_section
+			  (input_bfd,
+			   elf_elfheader (input_bfd)->e_shstrndx,
+			   elf_section_data (input_section)->rel_hdr.sh_name));
+		  if (name == NULL)
+		    return false;
+
+		  BFD_ASSERT (strncmp (name, ".rela", 5) == 0
+			      && strcmp (bfd_get_section_name (input_bfd,
+							       input_section),
+					 name + 5) == 0);
+
+		  sreloc = bfd_get_section_by_name (dynobj, name);
+		  BFD_ASSERT (sreloc != NULL);
+		}
+
+	      skip = 0;
+
+	      outrel.r_offset =
+		_bfd_elf_section_offset (output_bfd, info, input_section,
+					 rel->r_offset);
+	      if (outrel.r_offset == (bfd_vma) -1
+		  || outrel.r_offset == (bfd_vma) -2)
+		skip = (int) outrel.r_offset;
+	      outrel.r_offset += (input_section->output_section->vma
+				  + input_section->output_offset);
+
+	      if (skip)
+		memset (&outrel, 0, sizeof outrel);
+	      /* h->dynindx may be -1 if this symbol was marked to
+                 become local.  */
+	      else if (! will_become_local)
+		{
+		  outrel.r_info = ELF32_R_INFO (h->dynindx, r_type);
+		  outrel.r_addend = rel->r_addend;
+		}
+	      else
+		{
+		  if (r_type == R_PPC_ADDR32)
+		    {
+		      outrel.r_info = ELF32_R_INFO (0, R_PPC_RELATIVE);
+		      outrel.r_addend = relocation + rel->r_addend;
+		    }
+		  else
+		    {
+		      long indx;
+
+		      if (h == NULL)
+			sec = local_sections[r_symndx];
+		      else
+			{
+			  BFD_ASSERT (h->root.type == bfd_link_hash_defined
+				      || (h->root.type
+					  == bfd_link_hash_defweak));
+			  sec = h->root.u.def.section;
+			}
+		      if (sec != NULL && bfd_is_abs_section (sec))
+			indx = 0;
+		      else if (sec == NULL || sec->owner == NULL)
+			{
+			  bfd_set_error (bfd_error_bad_value);
+			  return false;
+			}
+		      else
+			{
+			  asection *osec;
+
+			  osec = sec->output_section;
+			  indx = elf_section_data (osec)->dynindx;
+			  BFD_ASSERT (indx > 0);
+#ifdef DEBUG
+			  if (indx <= 0)
+			    {
+			      printf ("indx=%d section=%s flags=%08x name=%s\n",
+				     indx, osec->name, osec->flags,
+				     h->root.root.string);
+			    }
+#endif
+			}
+
+		      outrel.r_info = ELF32_R_INFO (indx, r_type);
+		      outrel.r_addend = relocation + rel->r_addend;
+		    }
+		}
+
+	      bfd_elf32_swap_reloca_out (output_bfd, &outrel,
+					 (((Elf32_External_Rela *)
+					   sreloc->contents)
+					  + sreloc->reloc_count));
+	      ++sreloc->reloc_count;
+
+	      if (skip == -1)
+		continue;
+
+	      /* This reloc will be computed at runtime.  We clear the memory
+		 so that it contains predictable value.  */
+	      if (! skip
+		  && ((input_section->flags & SEC_ALLOC) != 0
+		      || ELF32_R_TYPE (outrel.r_info) != R_PPC_RELATIVE))
+		{
+		  relocation = howto->pc_relative ? outrel.r_offset : 0;
+		  addend = 0;
+		  break;
+		}
+	    }
+
+	  /* Arithmetic adjust relocations that aren't going into a
+	     shared object.  */
+	  if (r_type == R_PPC_ADDR16_HA
+	      /* It's just possible that this symbol is a weak symbol
+		 that's not actually defined anywhere. In that case,
+		 'sec' would be NULL, and we should leave the symbol
+		 alone (it will be set to zero elsewhere in the link).  */
+	      && sec != NULL)
+	    {
+	      addend += ((relocation + addend) & 0x8000) << 1;
+	    }
+	  break;
+
+	/* branch taken prediction relocations */
+	case (int) R_PPC_ADDR14_BRTAKEN:
+	case (int) R_PPC_REL14_BRTAKEN:
+	  insn = bfd_get_32 (output_bfd, contents + offset);
+	  if ((relocation - offset) & 0x8000)
+	    insn &= ~BRANCH_PREDICT_BIT;
+	  else
+	    insn |= BRANCH_PREDICT_BIT;
+	  bfd_put_32 (output_bfd, (bfd_vma) insn, contents + offset);
+	  break;
+
+	/* branch not taken predicition relocations */
+	case (int) R_PPC_ADDR14_BRNTAKEN:
+	case (int) R_PPC_REL14_BRNTAKEN:
+	  insn = bfd_get_32 (output_bfd, contents + offset);
+	  if ((relocation - offset) & 0x8000)
+	    insn |= BRANCH_PREDICT_BIT;
+	  else
+	    insn &= ~BRANCH_PREDICT_BIT;
+	  bfd_put_32 (output_bfd, (bfd_vma) insn, contents + offset);
+	  break;
+
+	/* GOT16 relocations */
+	case (int) R_PPC_GOT16:
+	case (int) R_PPC_GOT16_LO:
+	case (int) R_PPC_GOT16_HI:
+	case (int) R_PPC_GOT16_HA:
+	  /* Relocation is to the entry for this symbol in the global
+             offset table.  */
+	  BFD_ASSERT (sgot != NULL);
+
+	  if (h != NULL)
+	    {
+	      bfd_vma off;
+
+	      off = h->got.offset;
+	      BFD_ASSERT (off != (bfd_vma) -1);
+
+	      if (! elf_hash_table (info)->dynamic_sections_created
+		  || (info->shared
+		      && SYMBOL_REFERENCES_LOCAL (info, h)))
+		{
+		  /* This is actually a static link, or it is a
+                     -Bsymbolic link and the symbol is defined
+                     locally.  We must initialize this entry in the
+                     global offset table.  Since the offset must
+                     always be a multiple of 4, we use the least
+                     significant bit to record whether we have
+                     initialized it already.
+
+		     When doing a dynamic link, we create a .rela.got
+		     relocation entry to initialize the value.  This
+		     is done in the finish_dynamic_symbol routine.  */
+		  if ((off & 1) != 0)
+		    off &= ~1;
+		  else
+		    {
+		      bfd_put_32 (output_bfd, relocation,
+				  sgot->contents + off);
+		      h->got.offset |= 1;
+		    }
+		}
+
+	      relocation = sgot->output_offset + off - 4;
+	    }
+	  else
+	    {
+	      bfd_vma off;
+
+	      BFD_ASSERT (local_got_offsets != NULL
+			  && local_got_offsets[r_symndx] != (bfd_vma) -1);
+
+	      off = local_got_offsets[r_symndx];
+
+	      /* The offset must always be a multiple of 4.  We use
+		 the least significant bit to record whether we have
+		 already processed this entry.  */
+	      if ((off & 1) != 0)
+		off &= ~1;
+	      else
+		{
+
+		  if (info->shared)
+		    {
+		      asection *srelgot;
+		      Elf_Internal_Rela outrel;
+
+		      /* We need to generate a R_PPC_RELATIVE reloc
+			 for the dynamic linker.  */
+		      srelgot = bfd_get_section_by_name (dynobj, ".rela.got");
+		      BFD_ASSERT (srelgot != NULL);
+
+		      outrel.r_offset = (sgot->output_section->vma
+					 + sgot->output_offset
+					 + off);
+		      outrel.r_info = ELF32_R_INFO (0, R_PPC_RELATIVE);
+		      outrel.r_addend = relocation;
+		      bfd_elf32_swap_reloca_out (output_bfd, &outrel,
+						 (((Elf32_External_Rela *)
+						   srelgot->contents)
+						  + srelgot->reloc_count));
+		      ++srelgot->reloc_count;
+		      relocation = 0;
+		    }
+
+		  bfd_put_32 (output_bfd, relocation, sgot->contents + off);
+		  local_got_offsets[r_symndx] |= 1;
+		}
+
+	      relocation = sgot->output_offset + off - 4;
+	    }
+	  break;
+
+	/* Indirect .sdata relocation */
+	case (int) R_PPC_EMB_SDAI16:
+	  BFD_ASSERT (sdata != NULL);
+	  relocation = bfd_elf32_finish_pointer_linker_section (output_bfd, input_bfd, info,
+								sdata, h, relocation, rel,
+								R_PPC_RELATIVE);
+	  break;
+
+	/* Indirect .sdata2 relocation */
+	case (int) R_PPC_EMB_SDA2I16:
+	  BFD_ASSERT (sdata2 != NULL);
+	  relocation = bfd_elf32_finish_pointer_linker_section (output_bfd, input_bfd, info,
+								sdata2, h, relocation, rel,
+								R_PPC_RELATIVE);
+	  break;
+
+	/* Handle the TOC16 reloc.  We want to use the offset within the .got
+	   section, not the actual VMA.  This is appropriate when generating
+	   an embedded ELF object, for which the .got section acts like the
+	   AIX .toc section.  */
+	case (int) R_PPC_TOC16:			/* phony GOT16 relocations */
+	  BFD_ASSERT (sec != (asection *) 0);
+	  BFD_ASSERT (bfd_is_und_section (sec)
+		      || strcmp (bfd_get_section_name (abfd, sec), ".got") == 0
+		      || strcmp (bfd_get_section_name (abfd, sec), ".cgot") == 0)
+
+	  addend -= sec->output_section->vma + sec->output_offset + 0x8000;
+	  break;
+
+	case (int) R_PPC_PLTREL24:
+	  /* Relocation is to the entry for this symbol in the
+             procedure linkage table.  */
+	  BFD_ASSERT (h != NULL);
+
+	  if (h->plt.offset == (bfd_vma) -1
+	      || splt == NULL)
+	    {
+	      /* We didn't make a PLT entry for this symbol.  This
+                 happens when statically linking PIC code, or when
+                 using -Bsymbolic.  */
+	      break;
+	    }
+
+	  relocation = (splt->output_section->vma
+			+ splt->output_offset
+			+ h->plt.offset);
+	  break;
+
+	/* relocate against _SDA_BASE_ */
+	case (int) R_PPC_SDAREL16:
+	  {
+	    const char *name;
+
+	    BFD_ASSERT (sec != (asection *) 0);
+	    name = bfd_get_section_name (abfd, sec->output_section);
+	    if (strcmp (name, ".sdata") != 0
+		&& strcmp (name, ".sbss") != 0)
+	      {
+		(*_bfd_error_handler) (_("%s: The target (%s) of a %s relocation is in the wrong output section (%s)"),
+				       bfd_archive_filename (input_bfd),
+				       sym_name,
+				       ppc_elf_howto_table[(int) r_type]->name,
+				       name);
+	      }
+	    addend -= (sdata->sym_hash->root.u.def.value
+		       + sdata->sym_hash->root.u.def.section->output_section->vma
+		       + sdata->sym_hash->root.u.def.section->output_offset);
+	  }
+	  break;
+
+	/* relocate against _SDA2_BASE_ */
+	case (int) R_PPC_EMB_SDA2REL:
+	  {
+	    const char *name;
+
+	    BFD_ASSERT (sec != (asection *) 0);
+	    name = bfd_get_section_name (abfd, sec->output_section);
+	    if (strcmp (name, ".sdata2") != 0 && strcmp (name, ".sbss2") != 0)
+	      {
+		(*_bfd_error_handler) (_("%s: The target (%s) of a %s relocation is in the wrong output section (%s)"),
+				       bfd_archive_filename (input_bfd),
+				       sym_name,
+				       ppc_elf_howto_table[(int) r_type]->name,
+				       name);
+
+		bfd_set_error (bfd_error_bad_value);
+		ret = false;
+		continue;
+	      }
+	    addend -= (sdata2->sym_hash->root.u.def.value
+		       + sdata2->sym_hash->root.u.def.section->output_section->vma
+		       + sdata2->sym_hash->root.u.def.section->output_offset);
+	  }
+	  break;
+
+	/* relocate against either _SDA_BASE_, _SDA2_BASE_, or 0 */
+	case (int) R_PPC_EMB_SDA21:
+	case (int) R_PPC_EMB_RELSDA:
+	  {
+	    const char *name;
+	    int reg;
+
+	    BFD_ASSERT (sec != (asection *) 0);
+	    name = bfd_get_section_name (abfd, sec->output_section);
+	    if (strcmp (name, ".sdata") == 0 || strcmp (name, ".sbss") == 0)
+	      {
+		reg = 13;
+		addend -= (sdata->sym_hash->root.u.def.value
+			   + sdata->sym_hash->root.u.def.section->output_section->vma
+			   + sdata->sym_hash->root.u.def.section->output_offset);
+	      }
+
+	    else if (strcmp (name, ".sdata2") == 0
+		     || strcmp (name, ".sbss2") == 0)
+	      {
+		reg = 2;
+		addend -= (sdata2->sym_hash->root.u.def.value
+			   + sdata2->sym_hash->root.u.def.section->output_section->vma
+			   + sdata2->sym_hash->root.u.def.section->output_offset);
+	      }
+
+	    else if (strcmp (name, ".PPC.EMB.sdata0") == 0
+		     || strcmp (name, ".PPC.EMB.sbss0") == 0)
+	      {
+		reg = 0;
+	      }
+
+	    else
+	      {
+		(*_bfd_error_handler) (_("%s: The target (%s) of a %s relocation is in the wrong output section (%s)"),
+				       bfd_archive_filename (input_bfd),
+				       sym_name,
+				       ppc_elf_howto_table[(int) r_type]->name,
+				       name);
+
+		bfd_set_error (bfd_error_bad_value);
+		ret = false;
+		continue;
+	      }
+
+	    if (r_type == R_PPC_EMB_SDA21)
+	      {			/* fill in register field */
+		insn = bfd_get_32 (output_bfd, contents + offset);
+		insn = (insn & ~RA_REGISTER_MASK) | (reg << RA_REGISTER_SHIFT);
+		bfd_put_32 (output_bfd, (bfd_vma) insn, contents + offset);
+	      }
+	  }
+	  break;
+
+	/* Relocate against the beginning of the section */
+	case (int) R_PPC_SECTOFF:
+	case (int) R_PPC_SECTOFF_LO:
+	case (int) R_PPC_SECTOFF_HI:
+	  BFD_ASSERT (sec != (asection *) 0);
+	  addend -= sec->output_section->vma;
+	  break;
+
+	case (int) R_PPC_SECTOFF_HA:
+	  BFD_ASSERT (sec != (asection *) 0);
+	  addend -= sec->output_section->vma;
+	  addend += ((relocation + addend) & 0x8000) << 1;
+	  break;
+
+	/* Negative relocations */
+	case (int) R_PPC_EMB_NADDR32:
+	case (int) R_PPC_EMB_NADDR16:
+	case (int) R_PPC_EMB_NADDR16_LO:
+	case (int) R_PPC_EMB_NADDR16_HI:
+	  addend -= 2 * relocation;
+	  break;
+
+	case (int) R_PPC_EMB_NADDR16_HA:
+	  addend -= 2 * relocation;
+	  addend += ((relocation + addend) & 0x8000) << 1;
+	  break;
+
+	/* NOP relocation that prevents garbage collecting linkers from omitting a
+	   reference.  */
+	case (int) R_PPC_EMB_MRKREF:
+	  continue;
+
+	case (int) R_PPC_COPY:
+	case (int) R_PPC_GLOB_DAT:
+	case (int) R_PPC_JMP_SLOT:
+	case (int) R_PPC_RELATIVE:
+	case (int) R_PPC_PLT32:
+	case (int) R_PPC_PLTREL32:
+	case (int) R_PPC_PLT16_LO:
+	case (int) R_PPC_PLT16_HI:
+	case (int) R_PPC_PLT16_HA:
+	case (int) R_PPC_EMB_RELSEC16:
+	case (int) R_PPC_EMB_RELST_LO:
+	case (int) R_PPC_EMB_RELST_HI:
+	case (int) R_PPC_EMB_RELST_HA:
+	case (int) R_PPC_EMB_BIT_FLD:
+	  (*_bfd_error_handler) (_("%s: Relocation %s is not yet supported for symbol %s."),
+				 bfd_archive_filename (input_bfd),
+				 ppc_elf_howto_table[(int) r_type]->name,
+				 sym_name);
+
+	  bfd_set_error (bfd_error_invalid_operation);
+	  ret = false;
+	  continue;
+
+	case (int) R_PPC_GNU_VTINHERIT:
+	case (int) R_PPC_GNU_VTENTRY:
+	  /* These are no-ops in the end.  */
+	  continue;
+	}
+
+#ifdef DEBUG
+      fprintf (stderr, "\ttype = %s (%d), name = %s, symbol index = %ld, offset = %ld, addend = %ld\n",
+	       howto->name,
+	       (int) r_type,
+	       sym_name,
+	       r_symndx,
+	       (long) offset,
+	       (long) addend);
+#endif
+
+      r = _bfd_final_link_relocate (howto,
+				    input_bfd,
+				    input_section,
+				    contents,
+				    offset,
+				    relocation,
+				    addend);
+
+      if (r == bfd_reloc_ok)
+	;
+      else if (r == bfd_reloc_overflow)
+	{
+	  const char *name;
+
+	  if (h != NULL)
+	    {
+	      if (h->root.type == bfd_link_hash_undefweak
+		  && howto->pc_relative)
+		{
+		  /* Assume this is a call protected by other code that
+		     detect the symbol is undefined.  If this is the case,
+		     we can safely ignore the overflow.  If not, the
+		     program is hosed anyway, and a little warning isn't
+		     going to help.  */
+
+		  continue;
+		}
+
+	      name = h->root.root.string;
+	    }
+	  else
+	    {
+	      name = bfd_elf_string_from_elf_section (input_bfd,
+						      symtab_hdr->sh_link,
+						      sym->st_name);
+	      if (name == NULL)
+		continue;
+	      if (*name == '\0')
+		name = bfd_section_name (input_bfd, sec);
+	    }
+
+	  if (! (*info->callbacks->reloc_overflow) (info,
+						   name,
+						   howto->name,
+						   (bfd_vma) 0,
+						   input_bfd,
+						   input_section,
+						   offset))
+	    return false;
+	}
+      else
+	ret = false;
+    }
+
+#ifdef DEBUG
+  fprintf (stderr, "\n");
+#endif
+
+  return ret;
+}
+
+static enum elf_reloc_type_class
+ppc_elf_reloc_type_class (rela)
+     const Elf_Internal_Rela *rela;
+{
+  switch ((int) ELF32_R_TYPE (rela->r_info))
+    {
+    case R_PPC_RELATIVE:
+      return reloc_class_relative;
+    case R_PPC_REL24:
+    case R_PPC_ADDR24:
+    case R_PPC_JMP_SLOT:
+      return reloc_class_plt;
+    case R_PPC_COPY:
+      return reloc_class_copy;
+    default:
+      return reloc_class_normal;
+    }
+}
+
+/* Support for core dump NOTE sections */
+static boolean
+ppc_elf_grok_prstatus (abfd, note)
+     bfd *abfd;
+     Elf_Internal_Note *note;
+{
+  int offset;
+  unsigned int raw_size;
+
+  switch (note->descsz)
+    {
+      default:
+	return false;
+
+      case 268:		/* Linux/PPC */
+	/* pr_cursig */
+	elf_tdata (abfd)->core_signal = bfd_get_16 (abfd, note->descdata + 12);
+
+	/* pr_pid */
+	elf_tdata (abfd)->core_pid = bfd_get_32 (abfd, note->descdata + 24);
+
+	/* pr_reg */
+	offset = 72;
+	raw_size = 192;
+
+	break;
+    }
+
+  /* Make a ".reg/999" section.  */
+  return _bfd_elfcore_make_pseudosection (abfd, ".reg",
+					  raw_size, note->descpos + offset);
+}
+
+static boolean
+ppc_elf_grok_psinfo (abfd, note)
+     bfd *abfd;
+     Elf_Internal_Note *note;
+{
+  switch (note->descsz)
+    {
+      default:
+	return false;
+
+      case 128:		/* Linux/PPC elf_prpsinfo */
+	elf_tdata (abfd)->core_program
+	 = _bfd_elfcore_strndup (abfd, note->descdata + 32, 16);
+	elf_tdata (abfd)->core_command
+	 = _bfd_elfcore_strndup (abfd, note->descdata + 48, 80);
+    }
+
+  /* Note that for some reason, a spurious space is tacked
+     onto the end of the args in some (at least one anyway)
+     implementations, so strip it off if it exists.  */
+
+  {
+    char *command = elf_tdata (abfd)->core_command;
+    int n = strlen (command);
+
+    if (0 < n && command[n - 1] == ' ')
+      command[n - 1] = '\0';
+  }
+
+  return true;
+}
+
+#define TARGET_BIG_SYM		bfd_elf32_amiga_vec
+#define TARGET_BIG_NAME		"elf32-amiga"
+#define ELF_ARCH		bfd_arch_powerpc
+#define ELF_MACHINE_CODE	EM_PPC
+#define ELF_MAXPAGESIZE		0x10000
+#define elf_info_to_howto	ppc_elf_info_to_howto
+
+#ifdef  EM_CYGNUS_POWERPC
+#define ELF_MACHINE_ALT1	EM_CYGNUS_POWERPC
+#endif
+
+#ifdef EM_PPC_OLD
+#define ELF_MACHINE_ALT2	EM_PPC_OLD
+#endif
+
+#define elf_backend_plt_not_loaded	1
+#define elf_backend_got_symbol_offset	4
+#define elf_backend_can_gc_sections	1
+#define elf_backend_can_refcount	1
+#define elf_backend_got_header_size	12
+#define elf_backend_plt_header_size	PLT_INITIAL_ENTRY_SIZE
+#define elf_backend_rela_normal		1
+
+#define bfd_elf32_bfd_merge_private_bfd_data	ppc_elf_merge_private_bfd_data
+#define bfd_elf32_bfd_relax_section             ppc_elf_relax_section
+#define bfd_elf32_bfd_reloc_type_lookup		ppc_elf_reloc_type_lookup
+#define bfd_elf32_bfd_set_private_flags		ppc_elf_set_private_flags
+#define bfd_elf32_bfd_final_link		_bfd_elf32_gc_common_final_link
+
+#define elf_backend_object_p			ppc_elf_object_p
+#define elf_backend_gc_mark_hook		ppc_elf_gc_mark_hook
+#define elf_backend_gc_sweep_hook		ppc_elf_gc_sweep_hook
+#define elf_backend_section_from_shdr		ppc_elf_section_from_shdr
+#define elf_backend_relocate_section		ppc_elf_relocate_section
+#define elf_backend_create_dynamic_sections	ppc_elf_create_dynamic_sections
+#define elf_backend_check_relocs		ppc_elf_check_relocs
+#define elf_backend_adjust_dynamic_symbol	ppc_elf_adjust_dynamic_symbol
+#define elf_backend_add_symbol_hook		ppc_elf_add_symbol_hook
+#define elf_backend_size_dynamic_sections	ppc_elf_size_dynamic_sections
+#define elf_backend_finish_dynamic_symbol	ppc_elf_finish_dynamic_symbol
+#define elf_backend_finish_dynamic_sections	ppc_elf_finish_dynamic_sections
+#define elf_backend_fake_sections		ppc_elf_fake_sections
+#define elf_backend_additional_program_headers	ppc_elf_additional_program_headers
+#define elf_backend_modify_segment_map		ppc_elf_modify_segment_map
+#define elf_backend_grok_prstatus		ppc_elf_grok_prstatus
+#define elf_backend_grok_psinfo			ppc_elf_grok_psinfo
+#define elf_backend_reloc_type_class		ppc_elf_reloc_type_class
+
+#include "elf32-target.h"
diff --git a/bfd/elf32-i386-amithlon.c b/bfd/elf32-i386-amithlon.c
new file mode 100644
index 0000000000000000000000000000000000000000..4e029a5e90187a96013ed97e078fba920d95db28
--- /dev/null
+++ bfd/elf32-i386-amithlon.c
@@ -0,0 +1,198 @@
+/* Intel IA-32 specific support for 32-bit big endian ELF on Amithlon.
+   Copyright 2002 Free Software Foundation, Inc.
+   Written by Martin Blom.
+
+This file is part of BFD, the Binary File Descriptor library.
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+
+#define TARGET_LITTLE_SYM		bfd_elf32_i386_amithlon_vec
+#define TARGET_LITTLE_NAME		"elf32-i386-amithlon"
+#define TARGET_BIG_SYM			bfd_elf32_i386be_amithlon_vec
+#define TARGET_BIG_NAME			"elf32-i386be-amithlon"
+#define ELF_ARCH			bfd_arch_i386
+#define ELF_MACHINE_CODE		EM_386
+#define ELF_MAXPAGESIZE			32  //0x1000
+
+#include "bfd.h"
+#include "sysdep.h"
+#include "elf-bfd.h"
+
+/* Forward declarations */
+extern const bfd_target bfd_elf32_i386_amithlon_vec;
+extern const bfd_target bfd_elf32_i386be_amithlon_vec;
+
+static boolean elf_i386_relocate_section
+  PARAMS ((bfd *, struct bfd_link_info *, bfd *, asection *, bfd_byte *,
+	   Elf_Internal_Rela *, Elf_Internal_Sym *, asection **));
+
+static boolean elf_i386_finish_dynamic_sections
+  PARAMS ((bfd *, struct bfd_link_info *));
+
+static boolean elf_i386_finish_dynamic_symbol
+  PARAMS ((bfd *, struct bfd_link_info *, struct elf_link_hash_entry *,
+	   Elf_Internal_Sym *));
+
+boolean elf_link_output_relocs
+  PARAMS ((bfd *, asection *, Elf_Internal_Shdr *, Elf_Internal_Rela *));
+
+#define swap_xvec(xvec,c)                                   \
+do {                                                        \
+  xvec->bfd_getx64         = bfd_get ## c ## 64;            \
+  xvec->bfd_getx_signed_64 = bfd_get ## c ## _signed_64;    \
+  xvec->bfd_putx64         = bfd_put ## c ## 64;            \
+  xvec->bfd_getx32         = bfd_get ## c ## 32;            \
+  xvec->bfd_getx_signed_32 = bfd_get ## c ## _signed_32;    \
+  xvec->bfd_putx32         = bfd_put ## c ## 32;            \
+  xvec->bfd_getx16         = bfd_get ## c ## 16;            \
+  xvec->bfd_getx_signed_16 = bfd_get ## c ## _signed_16;    \
+  xvec->bfd_putx16         = bfd_put ## c ## 16;            \
+} while(0)
+
+/* Relocate a big endian i386 ELF section.  */
+
+static boolean
+amithlon_relocate_section (output_bfd, info, input_bfd, input_section,
+			   contents, relocs, local_syms, local_sections)
+     bfd *output_bfd;
+     struct bfd_link_info *info;
+     bfd *input_bfd;
+     asection *input_section;
+     bfd_byte *contents;
+     Elf_Internal_Rela *relocs;
+     Elf_Internal_Sym *local_syms;
+     asection **local_sections;
+{
+  boolean switched_input  = false;
+  boolean switched_output = false;
+  boolean rc;
+
+  /* Since code sections are actually little endian, no matter what
+     endian mode we're operating in, this rather dirty hack is used to
+     make sure the correct data access routines are used. */
+
+  if ((bfd_get_section_flags (input_bfd, input_section) & SEC_CODE))
+  {
+    if (input_bfd->xvec == &bfd_elf32_i386be_amithlon_vec)
+    {
+      switched_input = true;
+
+      swap_xvec(input_bfd->xvec,l);
+    }
+    
+    if (output_bfd->xvec == &bfd_elf32_i386be_amithlon_vec)
+    {
+      switched_output = true;
+
+      swap_xvec(output_bfd->xvec,l);
+    }
+  }
+
+  rc = elf_i386_relocate_section (output_bfd, info, input_bfd, input_section,
+				  contents, relocs,
+				  local_syms, local_sections);
+  
+  if (switched_input)
+  {
+    swap_xvec(input_bfd->xvec,b);
+  }
+
+  if (switched_output)
+  {
+    swap_xvec(output_bfd->xvec,b);
+  }
+  
+  return rc;
+}  
+
+static boolean
+amithlon_finish_dynamic_sections (output_bfd, info)
+     bfd *output_bfd;
+     struct bfd_link_info *info;
+{
+  boolean switched_output = false;
+  boolean rc;
+
+  /* Since code sections are actually little endian, no matter what
+     endian mode we're operating in, this rather dirty hack is used to
+     make sure the correct data access routines are used. */
+
+  if (output_bfd->xvec == &bfd_elf32_i386be_amithlon_vec)
+  {
+    switched_output = true;
+
+    swap_xvec(output_bfd->xvec,l);
+  }
+
+  rc = elf_i386_finish_dynamic_sections (output_bfd, info);
+
+  if (switched_output)
+  {
+    swap_xvec(output_bfd->xvec,b);
+  }
+  
+  return rc;
+}
+
+static boolean
+amithlon_finish_dynamic_symbol (output_bfd, info, h, sym)
+     bfd *output_bfd;
+     struct bfd_link_info *info;
+     struct elf_link_hash_entry *h;
+     Elf_Internal_Sym *sym;
+{
+  boolean switched_output = false;
+  boolean rc;
+
+  /* Since code sections are actually little endian, no matter what
+     endian mode we're operating in, this rather dirty hack is used to
+     make sure the correct data access routines are used. */
+
+  if (output_bfd->xvec == &bfd_elf32_i386be_amithlon_vec)
+  {
+    switched_output = true;
+
+    swap_xvec(output_bfd->xvec,l);
+  }
+
+  rc = elf_i386_finish_dynamic_symbol (output_bfd, info, h, sym);
+
+  if (switched_output)
+  {
+    swap_xvec(output_bfd->xvec,b);
+  }
+  
+  return rc;
+}
+
+static bfd_size_type
+amithlon_additional_program_headers (abfd)
+     bfd *abfd;
+{
+//  printf("big: %x little: %x\n",
+//	 &bfd_elf32_i386be_amithlon_vec,
+//	 &bfd_elf32_i386_amithlon_vec);
+  // headers, text, rodata, data+bss
+  return -2+4;
+}
+
+#define elf_backend_relocate_section	        amithlon_relocate_section
+#define elf_backend_finish_dynamic_sections     amithlon_finish_dynamic_sections
+#define elf_backend_finish_dynamic_symbol       amithlon_finish_dynamic_symbol
+#define elf_backend_additional_program_headers  amithlon_additional_program_headers
+
+#define ELF32_I386_RELOCATABLE_EXECUTABLES 1
+
+#include "elf32-i386.c"
diff --git a/bfd/elf32-i386.c b/bfd/elf32-i386.c
index 0a6b22ec19ec9daee29e49c64c5d3ba2299e99c1..46396c83d45bab97de1470ee44ffa21f9d03e4b4 100644
--- bfd/elf32-i386.c
+++ bfd/elf32-i386.c
@@ -29,12 +29,16 @@
 #include "elf-vxworks.h"
 #include "bfd_stdint.h"
 #include "objalloc.h"
 #include "hashtab.h"
 #include "dwarf2.h"
 
+#ifndef ELF32_I386_RELOCATABLE_EXECUTABLES
+#define ELF32_I386_RELOCATABLE_EXECUTABLES 0
+#endif
+
 /* 386 uses REL relocations instead of RELA.  */
 #define USE_REL	1
 
 #include "elf/i386.h"
 
 static reloc_howto_type elf_howto_table[]=
@@ -1779,13 +1783,13 @@ elf_i386_check_relocs (bfd *abfd,
 	     symbol local.
 
 	     If on the other hand, we are creating an executable, we
 	     may need to keep relocations for symbols satisfied by a
 	     dynamic library if we manage to avoid copy relocs for the
 	     symbol.  */
-	  if ((info->shared
+	  if (((ELF32_I386_RELOCATABLE_EXECUTABLES || info->shared)
 	       && (sec->flags & SEC_ALLOC) != 0
 	       && (r_type != R_386_PC32
 		   || (h != NULL
 		       && (! SYMBOLIC_BIND (info, h)
 			   || h->root.type == bfd_link_hash_defweak
 			   || !h->def_regular))))
@@ -2410,13 +2414,13 @@ elf_i386_allocate_dynrelocs (struct elf_link_hash_entry *h, void *inf)
   /* In the shared -Bsymbolic case, discard space allocated for
      dynamic pc-relative relocs against symbols which turn out to be
      defined in regular objects.  For the normal shared case, discard
      space for pc-relative relocs that have become local due to symbol
      visibility changes.  */
 
-  if (info->shared)
+  if (ELF32_I386_RELOCATABLE_EXECUTABLES || info->shared)
     {
       /* The only reloc that uses pc_count is R_386_PC32, which will
 	 appear on a call or on something like ".long foo - .".  We
 	 want calls to protected symbols to resolve directly to the
 	 function rather than going via the plt.  If people want
 	 function pointer comparisons to work as expected then they
@@ -3592,13 +3596,13 @@ elf_i386_relocate_section (bfd *output_bfd,
 	case R_386_32:
 	case R_386_PC32:
 	  if ((input_section->flags & SEC_ALLOC) == 0
 	      || is_vxworks_tls)
 	    break;
 
-	  if ((info->shared
+	  if (((ELF32_I386_RELOCATABLE_EXECUTABLES || info->shared)
 	       && (h == NULL
 		   || ELF_ST_VISIBILITY (h->other) == STV_DEFAULT
 		   || h->root.type != bfd_link_hash_undefweak)
 	       && (r_type != R_386_PC32
 		   || !SYMBOL_CALLS_LOCAL (info, h)))
 	      || (ELIMINATE_COPY_RELOCS
@@ -3633,12 +3637,13 @@ elf_i386_relocate_section (bfd *output_bfd,
 				  + input_section->output_offset);
 
 	      if (skip)
 		memset (&outrel, 0, sizeof outrel);
 	      else if (h != NULL
 		       && h->dynindx != -1
+		       && !(ELF32_I386_RELOCATABLE_EXECUTABLES && !info->shared)
 		       && (r_type == R_386_PC32
 			   || !info->shared
 			   || !SYMBOLIC_BIND (info, h)
 			   || !h->def_regular))
 		outrel.r_info = ELF32_R_INFO (h->dynindx, r_type);
 	      else
@@ -4953,20 +4958,26 @@ elf_i386_add_symbol_hook (bfd * abfd,
 #define elf_backend_adjust_dynamic_symbol     elf_i386_adjust_dynamic_symbol
 #define elf_backend_relocs_compatible	      _bfd_elf_relocs_compatible
 #define elf_backend_check_relocs	      elf_i386_check_relocs
 #define elf_backend_copy_indirect_symbol      elf_i386_copy_indirect_symbol
 #define elf_backend_create_dynamic_sections   elf_i386_create_dynamic_sections
 #define elf_backend_fake_sections	      elf_i386_fake_sections
+#ifndef elf_backend_finish_dynamic_sections
 #define elf_backend_finish_dynamic_sections   elf_i386_finish_dynamic_sections
+#endif
+#ifndef elf_backend_finish_dynamic_symbol
 #define elf_backend_finish_dynamic_symbol     elf_i386_finish_dynamic_symbol
+#endif
 #define elf_backend_gc_mark_hook	      elf_i386_gc_mark_hook
 #define elf_backend_gc_sweep_hook	      elf_i386_gc_sweep_hook
 #define elf_backend_grok_prstatus	      elf_i386_grok_prstatus
 #define elf_backend_grok_psinfo		      elf_i386_grok_psinfo
 #define elf_backend_reloc_type_class	      elf_i386_reloc_type_class
+#ifndef elf_backend_relocate_section
 #define elf_backend_relocate_section	      elf_i386_relocate_section
+#endif
 #define elf_backend_size_dynamic_sections     elf_i386_size_dynamic_sections
 #define elf_backend_always_size_sections      elf_i386_always_size_sections
 #define elf_backend_omit_section_dynsym \
   ((bfd_boolean (*) (bfd *, struct bfd_link_info *, asection *)) bfd_true)
 #define elf_backend_plt_sym_val		      elf_i386_plt_sym_val
 #define elf_backend_hash_symbol		      elf_i386_hash_symbol
diff --git a/bfd/elf32-morphos.c b/bfd/elf32-morphos.c
new file mode 100644
index 0000000000000000000000000000000000000000..accc2d426bede6c9441313115fcd5ab5f99630f9
--- /dev/null
+++ bfd/elf32-morphos.c
@@ -0,0 +1,7137 @@
+/* PowerPC-specific support for 32-bit ELF
+   Copyright 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002
+   Free Software Foundation, Inc.
+   Written by Ian Lance Taylor, Cygnus Support.
+
+This file is part of BFD, the Binary File Descriptor library.
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+
+/* This file is based on a preliminary PowerPC ELF ABI.  The
+   information may not match the final PowerPC ELF ABI.  It includes
+   suggestions from the in-progress Embedded PowerPC ABI, and that
+   information may also not match.  */
+
+#define ARCH_SIZE		32
+
+#include "bfd.h"
+#include "sysdep.h"
+#include "bfdlink.h"
+#include "genlink.h"
+#include "libbfd.h"
+#include "elf-bfd.h"
+#include "elf/ppc.h"
+
+#define USE_RELA		/* we want RELA relocations, not REL */
+
+/* Renaming structures, typedefs, macros and functions to be size-specific.  */
+#define Elf_External_Ehdr	NAME(Elf,External_Ehdr)
+#define Elf_External_Sym	NAME(Elf,External_Sym)
+#define Elf_External_Shdr	NAME(Elf,External_Shdr)
+#define Elf_External_Phdr	NAME(Elf,External_Phdr)
+#define Elf_External_Rel	NAME(Elf,External_Rel)
+#define Elf_External_Rela	NAME(Elf,External_Rela)
+#define Elf_External_Dyn	NAME(Elf,External_Dyn)
+
+#define elf_core_file_failing_command	NAME(bfd_elf,core_file_failing_command)
+#define elf_core_file_failing_signal	NAME(bfd_elf,core_file_failing_signal)
+#define elf_core_file_matches_executable_p \
+  NAME(bfd_elf,core_file_matches_executable_p)
+#define elf_object_p			NAME(bfd_elf,object_p)
+#define elf_core_file_p			NAME(bfd_elf,core_file_p)
+#define elf_get_symtab_upper_bound	NAME(bfd_elf,get_symtab_upper_bound)
+#define elf_get_dynamic_symtab_upper_bound \
+  NAME(bfd_elf,get_dynamic_symtab_upper_bound)
+#define elf_swap_reloc_in		NAME(bfd_elf,swap_reloc_in)
+#define elf_swap_reloca_in		NAME(bfd_elf,swap_reloca_in)
+#define elf_swap_reloc_out		NAME(bfd_elf,swap_reloc_out)
+#define elf_swap_reloca_out		NAME(bfd_elf,swap_reloca_out)
+#define elf_swap_symbol_in		NAME(bfd_elf,swap_symbol_in)
+#define elf_swap_symbol_out		NAME(bfd_elf,swap_symbol_out)
+#define elf_swap_phdr_in		NAME(bfd_elf,swap_phdr_in)
+#define elf_swap_phdr_out		NAME(bfd_elf,swap_phdr_out)
+#define elf_swap_dyn_in			NAME(bfd_elf,swap_dyn_in)
+#define elf_swap_dyn_out		NAME(bfd_elf,swap_dyn_out)
+#define elf_get_reloc_upper_bound	NAME(bfd_elf,get_reloc_upper_bound)
+#define elf_canonicalize_reloc		NAME(bfd_elf,canonicalize_reloc)
+#define elf_slurp_symbol_table		NAME(bfd_elf,slurp_symbol_table)
+#define elf_get_symtab			NAME(bfd_elf,get_symtab)
+#define elf_canonicalize_dynamic_symtab \
+  NAME(bfd_elf,canonicalize_dynamic_symtab)
+#define elf_make_empty_symbol		NAME(bfd_elf,make_empty_symbol)
+#define elf_get_symbol_info		NAME(bfd_elf,get_symbol_info)
+#define elf_get_lineno			NAME(bfd_elf,get_lineno)
+#define elf_set_arch_mach		NAME(bfd_elf,set_arch_mach)
+#define elf_find_nearest_line		NAME(bfd_elf,find_nearest_line)
+#define elf_sizeof_headers		NAME(bfd_elf,sizeof_headers)
+#define elf_set_section_contents	NAME(bfd_elf,set_section_contents)
+#define elf_no_info_to_howto		NAME(bfd_elf,no_info_to_howto)
+#define elf_no_info_to_howto_rel	NAME(bfd_elf,no_info_to_howto_rel)
+#define elf_find_section		NAME(bfd_elf,find_section)
+#define elf_bfd_link_add_symbols	NAME(bfd_elf,bfd_link_add_symbols)
+#define elf_add_dynamic_entry		NAME(bfd_elf,add_dynamic_entry)
+#define elf_write_shdrs_and_ehdr	NAME(bfd_elf,write_shdrs_and_ehdr)
+#define elf_write_out_phdrs		NAME(bfd_elf,write_out_phdrs)
+#define elf_write_relocs		NAME(bfd_elf,write_relocs)
+#define elf_slurp_reloc_table		NAME(bfd_elf,slurp_reloc_table)
+#define elf_link_create_dynamic_sections \
+  NAME(bfd_elf,link_create_dynamic_sections)
+#define elf_bfd_discard_info		NAME(bfd_elf,discard_info)
+#define elf_reloc_symbol_deleted_p	NAME(_bfd_elf,reloc_symbol_deleted_p)
+#define elf_link_record_dynamic_symbol  _bfd_elf_link_record_dynamic_symbol
+#define elf_bfd_final_link		NAME(bfd_elf,bfd_final_link)
+#define elf_create_pointer_linker_section NAME(bfd_elf,create_pointer_linker_section)
+#define elf_finish_pointer_linker_section NAME(bfd_elf,finish_pointer_linker_section)
+#define elf_gc_sections			NAME(_bfd_elf,gc_sections)
+#define elf_gc_common_finalize_got_offsets \
+  NAME(_bfd_elf,gc_common_finalize_got_offsets)
+#define elf_gc_common_final_link	NAME(_bfd_elf,gc_common_final_link)
+#define elf_gc_record_vtinherit		NAME(_bfd_elf,gc_record_vtinherit)
+#define elf_gc_record_vtentry		NAME(_bfd_elf,gc_record_vtentry)
+#define elf_link_record_local_dynamic_symbol \
+  NAME(_bfd_elf,link_record_local_dynamic_symbol)
+
+#define ELF_R_INFO(X,Y)	ELF32_R_INFO(X,Y)
+#define ELF_R_SYM(X)	ELF32_R_SYM(X)
+#define ELF_R_TYPE(X)	ELF32_R_TYPE(X)
+#define ELFCLASS	ELFCLASS32
+#define FILE_ALIGN	4
+#define LOG_FILE_ALIGN	2
+
+#define H_PUT_WORD		H_PUT_32
+#define H_PUT_SIGNED_WORD	H_PUT_S32
+#define H_GET_WORD		H_GET_32
+#define H_GET_SIGNED_WORD	H_GET_S32
+
+#define elf_stringtab_init _bfd_elf_stringtab_init
+
+#define section_from_elf_index bfd_section_from_elf_index
+
+static int ddr_count;
+static unsigned *ddr_ptr;
+
+static reloc_howto_type *ppc_elf_reloc_type_lookup
+  PARAMS ((bfd *abfd, bfd_reloc_code_real_type code));
+static void ppc_elf_info_to_howto
+  PARAMS ((bfd *abfd, arelent *cache_ptr, Elf32_Internal_Rela *dst));
+static void ppc_elf_howto_init PARAMS ((void));
+static int ppc_elf_sort_rela PARAMS ((const PTR, const PTR));
+static boolean ppc_elf_relax_section
+  PARAMS ((bfd *, asection *, struct bfd_link_info *, boolean *));
+static bfd_reloc_status_type ppc_elf_addr16_ha_reloc
+  PARAMS ((bfd *, arelent *, asymbol *, PTR, asection *, bfd *, char **));
+static boolean ppc_elf_object_p PARAMS ((bfd *));
+static boolean ppc_elf_set_private_flags PARAMS ((bfd *, flagword));
+static boolean ppc_elf_merge_private_bfd_data PARAMS ((bfd *, bfd *));
+
+static int ppc_elf_additional_program_headers PARAMS ((bfd *));
+static boolean ppc_elf_modify_segment_map PARAMS ((bfd *));
+
+static asection *ppc_elf_create_got
+  PARAMS ((bfd *, struct bfd_link_info *));
+static boolean ppc_elf_create_dynamic_sections
+  PARAMS ((bfd *, struct bfd_link_info *));
+
+static boolean ppc_elf_section_from_shdr PARAMS ((bfd *,
+						  Elf32_Internal_Shdr *,
+						  const char *));
+static boolean ppc_elf_fake_sections
+  PARAMS ((bfd *, Elf32_Internal_Shdr *, asection *));
+
+static elf_linker_section_t *ppc_elf_create_linker_section
+  PARAMS ((bfd *abfd,
+	   struct bfd_link_info *info,
+	   enum elf_linker_section_enum));
+
+static boolean ppc_elf_check_relocs PARAMS ((bfd *,
+					     struct bfd_link_info *,
+					     asection *,
+					     const Elf_Internal_Rela *));
+
+static asection * ppc_elf_gc_mark_hook PARAMS ((asection *sec,
+						struct bfd_link_info *info,
+						Elf_Internal_Rela *rel,
+						struct elf_link_hash_entry *h,
+						Elf_Internal_Sym *sym));
+
+static boolean ppc_elf_gc_sweep_hook PARAMS ((bfd *abfd,
+					      struct bfd_link_info *info,
+					      asection *sec,
+					      const Elf_Internal_Rela *relocs));
+
+static boolean ppc_elf_adjust_dynamic_symbol PARAMS ((struct bfd_link_info *,
+						      struct elf_link_hash_entry *));
+
+static boolean ppc_elf_size_dynamic_sections PARAMS ((bfd *, struct bfd_link_info *));
+
+static boolean ppc_elf_relocate_section PARAMS ((bfd *,
+						 struct bfd_link_info *info,
+						 bfd *,
+						 asection *,
+						 bfd_byte *,
+						 Elf_Internal_Rela *relocs,
+						 Elf_Internal_Sym *local_syms,
+						 asection **));
+
+static boolean ppc_elf_add_symbol_hook  PARAMS ((bfd *,
+						 struct bfd_link_info *,
+						 const Elf_Internal_Sym *,
+						 const char **,
+						 flagword *,
+						 asection **,
+						 bfd_vma *));
+
+static boolean ppc_elf_finish_dynamic_symbol PARAMS ((bfd *,
+						      struct bfd_link_info *,
+						      struct elf_link_hash_entry *,
+						      Elf_Internal_Sym *));
+
+static boolean ppc_elf_finish_dynamic_sections PARAMS ((bfd *, struct bfd_link_info *));
+static enum elf_reloc_type_class ppc_elf_reloc_type_class
+  PARAMS ((const Elf_Internal_Rela *));
+static boolean ppc_elf_grok_prstatus
+  PARAMS ((bfd *abfd, Elf_Internal_Note *note));
+static boolean ppc_elf_grok_psinfo
+  PARAMS ((bfd *abfd, Elf_Internal_Note *note));
+
+#define BRANCH_PREDICT_BIT 0x200000		/* branch prediction bit for branch taken relocs */
+#define RA_REGISTER_MASK 0x001f0000		/* mask to set RA in memory instructions */
+#define RA_REGISTER_SHIFT 16			/* value to shift register by to insert RA */
+
+/* The name of the dynamic interpreter.  This is put in the .interp
+   section.  */
+
+#define ELF_DYNAMIC_INTERPRETER "/usr/lib/ld.so.1"
+
+/* The size in bytes of an entry in the procedure linkage table.  */
+#define PLT_ENTRY_SIZE 12
+/* The initial size of the plt reserved for the dynamic linker.  */
+#define PLT_INITIAL_ENTRY_SIZE 72
+/* The size of the gap between entries in the PLT.  */
+#define PLT_SLOT_SIZE 8
+/* The number of single-slot PLT entries (the rest use two slots).  */
+#define PLT_NUM_SINGLE_ENTRIES 8192
+
+/* Will references to this symbol always reference the symbol
+   in this object?  */
+#define SYMBOL_REFERENCES_LOCAL(INFO, H)				\
+  ((! INFO->shared							\
+    || INFO->symbolic							\
+    || H->dynindx == -1							\
+    || ELF_ST_VISIBILITY (H->other) == STV_INTERNAL			\
+    || ELF_ST_VISIBILITY (H->other) == STV_HIDDEN)			\
+   && (H->elf_link_hash_flags & ELF_LINK_HASH_DEF_REGULAR) != 0)
+
+/* Will _calls_ to this symbol always call the version in this object?  */
+#define SYMBOL_CALLS_LOCAL(INFO, H)				\
+  ((! INFO->shared							\
+    || INFO->symbolic							\
+    || H->dynindx == -1							\
+    || ELF_ST_VISIBILITY (H->other) != STV_DEFAULT)			\
+   && (H->elf_link_hash_flags & ELF_LINK_HASH_DEF_REGULAR) != 0)
+
+static reloc_howto_type *ppc_elf_howto_table[(int) R_PPC_max];
+
+static reloc_howto_type ppc_elf_howto_raw[] = {
+  /* This reloc does nothing.  */
+  HOWTO (R_PPC_NONE,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_NONE",		/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0,			/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* A standard 32 bit relocation.  */
+  HOWTO (R_PPC_ADDR32,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_ADDR32",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffffffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* An absolute 26 bit branch; the lower two bits must be zero.
+     FIXME: we don't check that, we just clear them.  */
+  HOWTO (R_PPC_ADDR24,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 26,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_ADDR24",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0x3fffffc,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* A standard 16 bit relocation.  */
+  HOWTO (R_PPC_ADDR16,		/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_ADDR16",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* A 16 bit relocation without overflow.  */
+  HOWTO (R_PPC_ADDR16_LO,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont,/* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_ADDR16_LO",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* The high order 16 bits of an address.  */
+  HOWTO (R_PPC_ADDR16_HI,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_ADDR16_HI",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* The high order 16 bits of an address, plus 1 if the contents of
+     the low 16 bits, treated as a signed number, is negative.  */
+  HOWTO (R_PPC_ADDR16_HA,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 ppc_elf_addr16_ha_reloc, /* special_function */
+	 "R_PPC_ADDR16_HA",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* An absolute 16 bit branch; the lower two bits must be zero.
+     FIXME: we don't check that, we just clear them.  */
+  HOWTO (R_PPC_ADDR14,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_ADDR14",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xfffc,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* An absolute 16 bit branch, for which bit 10 should be set to
+     indicate that the branch is expected to be taken.	The lower two
+     bits must be zero.  */
+  HOWTO (R_PPC_ADDR14_BRTAKEN,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_ADDR14_BRTAKEN",/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xfffc,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* An absolute 16 bit branch, for which bit 10 should be set to
+     indicate that the branch is not expected to be taken.  The lower
+     two bits must be zero.  */
+  HOWTO (R_PPC_ADDR14_BRNTAKEN, /* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_ADDR14_BRNTAKEN",/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xfffc,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* A relative 26 bit branch; the lower two bits must be zero.  */
+  HOWTO (R_PPC_REL24,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 26,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_REL24",		/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0x3fffffc,		/* dst_mask */
+	 true),			/* pcrel_offset */
+
+  /* A relative 16 bit branch; the lower two bits must be zero.  */
+  HOWTO (R_PPC_REL14,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_REL14",		/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xfffc,		/* dst_mask */
+	 true),			/* pcrel_offset */
+
+  /* A relative 16 bit branch.  Bit 10 should be set to indicate that
+     the branch is expected to be taken.  The lower two bits must be
+     zero.  */
+  HOWTO (R_PPC_REL14_BRTAKEN,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_REL14_BRTAKEN",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xfffc,		/* dst_mask */
+	 true),			/* pcrel_offset */
+
+  /* A relative 16 bit branch.  Bit 10 should be set to indicate that
+     the branch is not expected to be taken.  The lower two bits must
+     be zero.  */
+  HOWTO (R_PPC_REL14_BRNTAKEN,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_REL14_BRNTAKEN",/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xfffc,		/* dst_mask */
+	 true),			/* pcrel_offset */
+
+  /* Like R_PPC_ADDR16, but referring to the GOT table entry for the
+     symbol.  */
+  HOWTO (R_PPC_GOT16,		/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_GOT16",		/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Like R_PPC_ADDR16_LO, but referring to the GOT table entry for
+     the symbol.  */
+  HOWTO (R_PPC_GOT16_LO,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_GOT16_LO",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Like R_PPC_ADDR16_HI, but referring to the GOT table entry for
+     the symbol.  */
+  HOWTO (R_PPC_GOT16_HI,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_GOT16_HI",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		 /* pcrel_offset */
+
+  /* Like R_PPC_ADDR16_HA, but referring to the GOT table entry for
+     the symbol.  */
+  HOWTO (R_PPC_GOT16_HA,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 ppc_elf_addr16_ha_reloc, /* special_function */
+	 "R_PPC_GOT16_HA",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Like R_PPC_REL24, but referring to the procedure linkage table
+     entry for the symbol.  */
+  HOWTO (R_PPC_PLTREL24,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 26,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed,  /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_PLTREL24",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0x3fffffc,		/* dst_mask */
+	 true),			/* pcrel_offset */
+
+  /* This is used only by the dynamic linker.  The symbol should exist
+     both in the object being run and in some shared library.  The
+     dynamic linker copies the data addressed by the symbol from the
+     shared library into the object, because the object being
+     run has to have the data at some particular address.  */
+  HOWTO (R_PPC_COPY,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	 /* special_function */
+	 "R_PPC_COPY",		/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0,			/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Like R_PPC_ADDR32, but used when setting global offset table
+     entries.  */
+  HOWTO (R_PPC_GLOB_DAT,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	 /* special_function */
+	 "R_PPC_GLOB_DAT",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffffffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Marks a procedure linkage table entry for a symbol.  */
+  HOWTO (R_PPC_JMP_SLOT,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	 /* special_function */
+	 "R_PPC_JMP_SLOT",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0,			/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Used only by the dynamic linker.  When the object is run, this
+     longword is set to the load address of the object, plus the
+     addend.  */
+  HOWTO (R_PPC_RELATIVE,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	 /* special_function */
+	 "R_PPC_RELATIVE",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffffffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Like R_PPC_REL24, but uses the value of the symbol within the
+     object rather than the final value.  Normally used for
+     _GLOBAL_OFFSET_TABLE_.  */
+  HOWTO (R_PPC_LOCAL24PC,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 26,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_LOCAL24PC",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0x3fffffc,		/* dst_mask */
+	 true),			/* pcrel_offset */
+
+  /* Like R_PPC_ADDR32, but may be unaligned.  */
+  HOWTO (R_PPC_UADDR32,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_UADDR32",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffffffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Like R_PPC_ADDR16, but may be unaligned.  */
+  HOWTO (R_PPC_UADDR16,		/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_UADDR16",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 32-bit PC relative */
+  HOWTO (R_PPC_REL32,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_REL32",		/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffffffff,		/* dst_mask */
+	 true),			/* pcrel_offset */
+
+  /* 32-bit relocation to the symbol's procedure linkage table.
+     FIXME: not supported.  */
+  HOWTO (R_PPC_PLT32,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_PLT32",		/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0,			/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 32-bit PC relative relocation to the symbol's procedure linkage table.
+     FIXME: not supported.  */
+  HOWTO (R_PPC_PLTREL32,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_PLTREL32",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0,			/* dst_mask */
+	 true),			/* pcrel_offset */
+
+  /* Like R_PPC_ADDR16_LO, but referring to the PLT table entry for
+     the symbol.  */
+  HOWTO (R_PPC_PLT16_LO,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_PLT16_LO",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Like R_PPC_ADDR16_HI, but referring to the PLT table entry for
+     the symbol.  */
+  HOWTO (R_PPC_PLT16_HI,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_PLT16_HI",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		 /* pcrel_offset */
+
+  /* Like R_PPC_ADDR16_HA, but referring to the PLT table entry for
+     the symbol.  */
+  HOWTO (R_PPC_PLT16_HA,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 ppc_elf_addr16_ha_reloc, /* special_function */
+	 "R_PPC_PLT16_HA",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* A sign-extended 16 bit value relative to _SDA_BASE_, for use with
+     small data items.  */
+  HOWTO (R_PPC_SDAREL16,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_SDAREL16",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 16-bit section relative relocation.  */
+  HOWTO (R_PPC_SECTOFF,		/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_SECTOFF",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 16-bit lower half section relative relocation.  */
+  HOWTO (R_PPC_SECTOFF_LO,	  /* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_SECTOFF_LO",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 16-bit upper half section relative relocation.  */
+  HOWTO (R_PPC_SECTOFF_HI,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_SECTOFF_HI",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		 /* pcrel_offset */
+
+  /* 16-bit upper half adjusted section relative relocation.  */
+  HOWTO (R_PPC_SECTOFF_HA,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 ppc_elf_addr16_ha_reloc, /* special_function */
+	 "R_PPC_SECTOFF_HA",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* The remaining relocs are from the Embedded ELF ABI, and are not
+     in the SVR4 ELF ABI.  */
+
+  /* 32 bit value resulting from the addend minus the symbol */
+  HOWTO (R_PPC_EMB_NADDR32,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_NADDR32",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffffffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 16 bit value resulting from the addend minus the symbol */
+  HOWTO (R_PPC_EMB_NADDR16,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_NADDR16",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 16 bit value resulting from the addend minus the symbol */
+  HOWTO (R_PPC_EMB_NADDR16_LO,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont,/* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_ADDR16_LO",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* The high order 16 bits of the addend minus the symbol */
+  HOWTO (R_PPC_EMB_NADDR16_HI,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_NADDR16_HI", /* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* The high order 16 bits of the result of the addend minus the address,
+     plus 1 if the contents of the low 16 bits, treated as a signed number,
+     is negative.  */
+  HOWTO (R_PPC_EMB_NADDR16_HA,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 ppc_elf_addr16_ha_reloc, /* special_function */
+	 "R_PPC_EMB_NADDR16_HA", /* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 16 bit value resulting from allocating a 4 byte word to hold an
+     address in the .sdata section, and returning the offset from
+     _SDA_BASE_ for that relocation */
+  HOWTO (R_PPC_EMB_SDAI16,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_SDAI16",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 16 bit value resulting from allocating a 4 byte word to hold an
+     address in the .sdata2 section, and returning the offset from
+     _SDA2_BASE_ for that relocation */
+  HOWTO (R_PPC_EMB_SDA2I16,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_SDA2I16",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* A sign-extended 16 bit value relative to _SDA2_BASE_, for use with
+     small data items.	 */
+  HOWTO (R_PPC_EMB_SDA2REL,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_SDA2REL",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Relocate against either _SDA_BASE_ or _SDA2_BASE_, filling in the 16 bit
+     signed offset from the appropriate base, and filling in the register
+     field with the appropriate register (0, 2, or 13).  */
+  HOWTO (R_PPC_EMB_SDA21,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_SDA21",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Relocation not handled: R_PPC_EMB_MRKREF */
+  /* Relocation not handled: R_PPC_EMB_RELSEC16 */
+  /* Relocation not handled: R_PPC_EMB_RELST_LO */
+  /* Relocation not handled: R_PPC_EMB_RELST_HI */
+  /* Relocation not handled: R_PPC_EMB_RELST_HA */
+  /* Relocation not handled: R_PPC_EMB_BIT_FLD */
+
+  /* PC relative relocation against either _SDA_BASE_ or _SDA2_BASE_, filling
+     in the 16 bit signed offset from the appropriate base, and filling in the
+     register field with the appropriate register (0, 2, or 13).  */
+  HOWTO (R_PPC_EMB_RELSDA,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 true,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_EMB_RELSDA",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* GNU extension to record C++ vtable hierarchy */
+  HOWTO (R_PPC_GNU_VTINHERIT,	/* type */
+	 0,			/* rightshift */
+	 0,			/* size (0 = byte, 1 = short, 2 = long) */
+	 0,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 NULL,			/* special_function */
+	 "R_PPC_GNU_VTINHERIT",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0,			/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* GNU extension to record C++ vtable member usage */
+  HOWTO (R_PPC_GNU_VTENTRY,	/* type */
+	 0,			/* rightshift */
+	 0,			/* size (0 = byte, 1 = short, 2 = long) */
+	 0,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont, /* complain_on_overflow */
+	 NULL,			/* special_function */
+	 "R_PPC_GNU_VTENTRY",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0,			/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Phony reloc to handle AIX style TOC entries */
+  HOWTO (R_PPC_TOC16,		/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_signed, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_TOC16",		/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* 32-bit relocation relative to _SDA_BASE_ */
+  HOWTO (R_PPC_MORPHOS_DREL,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_MORPHOS_DREL",	/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0,			/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Lower 16 bits of a relocation relative to _SDA_BASE */
+  HOWTO (R_PPC_MORPHOS_DREL_LO,	/* type */
+	 0,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont,/* complain_on_overflow */
+	 /*complain_overflow_bitfield,*/ /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_MORPHOS_DREL_LO",/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+
+  /* Upper 16 bits of a relocation relative to _SDA_BASE */
+  HOWTO (R_PPC_MORPHOS_DREL_HI,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont,/* complain_on_overflow */
+	 /*complain_overflow_bitfield,*/ /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_MORPHOS_DREL_HI",/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		 /* pcrel_offset */
+
+  /* Upper 16 bits of a relocation relative to _SDA_BASE */
+  HOWTO (R_PPC_MORPHOS_DREL_HA,	/* type */
+	 16,			/* rightshift */
+	 1,			/* size (0 = byte, 1 = short, 2 = long) */
+	 16,			/* bitsize */
+	 false,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_dont,/* complain_on_overflow */
+	 /*complain_overflow_bitfield,*/ /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_PPC_MORPHOS_DREL_HA",/* name */
+	 false,			/* partial_inplace */
+	 0,			/* src_mask */
+	 0xffff,		/* dst_mask */
+	 false),		/* pcrel_offset */
+};
+
+/* Initialize the ppc_elf_howto_table, so that linear accesses can be done.  */
+
+static void
+ppc_elf_howto_init ()
+{
+  unsigned int i, type;
+
+  for (i = 0; i < sizeof (ppc_elf_howto_raw) / sizeof (ppc_elf_howto_raw[0]); i++)
+    {
+      type = ppc_elf_howto_raw[i].type;
+      BFD_ASSERT (type < sizeof (ppc_elf_howto_table) / sizeof (ppc_elf_howto_table[0]));
+      ppc_elf_howto_table[type] = &ppc_elf_howto_raw[i];
+    }
+}
+
+/* This function handles relaxing for the PPC with option --mpc860c0[=<n>].
+
+   The MPC860, revision C0 or earlier contains a bug in the die.
+   If all of the following conditions are true, the next instruction
+   to be executed *may* be treated as a no-op.
+   1/ A forward branch is executed.
+   2/ The branch is predicted as not taken.
+   3/ The branch is taken.
+   4/ The branch is located in the last 5 words of a page.
+      (The EOP limit is 5 by default but may be specified as any value from 1-10.)
+
+   Our software solution is to detect these problematic branches in a
+   linker pass and modify them as follows:
+   1/ Unconditional branches - Since these are always predicted taken,
+      there is no problem and no action is required.
+   2/ Conditional backward branches - No problem, no action required.
+   3/ Conditional forward branches - Ensure that the "inverse prediction
+      bit" is set (ensure it is predicted taken).
+   4/ Conditional register branches - Ensure that the "y bit" is set
+      (ensure it is predicted taken).
+*/
+
+/* Sort sections by address.  */
+
+static int
+ppc_elf_sort_rela (arg1, arg2)
+     const PTR arg1;
+     const PTR arg2;
+{
+  const Elf_Internal_Rela **rela1 = (const Elf_Internal_Rela**) arg1;
+  const Elf_Internal_Rela **rela2 = (const Elf_Internal_Rela**) arg2;
+
+  /* Sort by offset.  */
+  return ((*rela1)->r_offset - (*rela2)->r_offset);
+}
+
+static boolean
+ppc_elf_relax_section (abfd, isec, link_info, again)
+     bfd *abfd;
+     asection *isec;
+     struct bfd_link_info *link_info;
+     boolean *again;
+{
+#define PAGESIZE 0x1000
+
+  bfd_byte *contents = NULL;
+  bfd_byte *free_contents = NULL;
+  Elf_Internal_Rela *internal_relocs = NULL;
+  Elf_Internal_Rela *free_relocs = NULL;
+  Elf_Internal_Rela **rela_comb = NULL;
+  int comb_curr, comb_count;
+
+  /* We never have to do this more than once per input section.  */
+  *again = false;
+
+  /* If needed, initialize this section's cooked size.  */
+  if (isec->_cooked_size == 0)
+      isec->_cooked_size = isec->_raw_size;
+
+  /* We're only interested in text sections which overlap the
+     troublesome area at the end of a page.  */
+  if (link_info->mpc860c0 && (isec->flags & SEC_CODE) && isec->_cooked_size)
+    {
+      bfd_vma dot, end_page, end_section;
+      boolean section_modified;
+
+      /* Get the section contents.  */
+      /* Get cached copy if it exists.  */
+      if (elf_section_data (isec)->this_hdr.contents != NULL)
+	  contents = elf_section_data (isec)->this_hdr.contents;
+      else
+	{
+	  /* Go get them off disk.  */
+	  contents = (bfd_byte *) bfd_malloc (isec->_raw_size);
+	  if (contents == NULL)
+	    goto error_return;
+	  free_contents = contents;
+
+	  if (! bfd_get_section_contents (abfd, isec, contents,
+					  (file_ptr) 0, isec->_raw_size))
+	    goto error_return;
+	}
+
+      comb_curr = 0;
+      comb_count = 0;
+      if (isec->reloc_count)
+	{
+          unsigned n;
+	  bfd_size_type amt;
+
+          /* Get a copy of the native relocations.  */
+          internal_relocs = _bfd_elf32_link_read_relocs (
+    	    abfd, isec, (PTR) NULL, (Elf_Internal_Rela *) NULL,
+    	    link_info->keep_memory);
+          if (internal_relocs == NULL)
+    	      goto error_return;
+          if (! link_info->keep_memory)
+    	      free_relocs = internal_relocs;
+
+          /* Setup a faster access method for the reloc info we need.  */
+	  amt = isec->reloc_count;
+	  amt *= sizeof (Elf_Internal_Rela*);
+          rela_comb = (Elf_Internal_Rela**) bfd_malloc (amt);
+          if (rela_comb == NULL)
+              goto error_return;
+          for (n = 0; n < isec->reloc_count; ++n)
+            {
+              long r_type;
+
+              r_type = ELF32_R_TYPE (internal_relocs[n].r_info);
+              if (r_type < 0 || r_type >= (int) R_PPC_max)
+                  goto error_return;
+
+              /* Prologue constants are sometimes present in the ".text"
+              sections and they can be identified by their associated relocation.
+              We don't want to process those words and some others which
+              can also be identified by their relocations.  However, not all
+              conditional branches will have a relocation so we will
+              only ignore words that 1) have a reloc, and 2) the reloc
+              is not applicable to a conditional branch.
+              The array rela_comb is built here for use in the EOP scan loop.  */
+              switch (r_type)
+                {
+                case R_PPC_ADDR14_BRNTAKEN:     /* absolute, predicted not taken */
+                case R_PPC_REL14:               /* relative cond. br.  */
+                case R_PPC_REL14_BRNTAKEN:      /* rel. cond. br., predicted not taken */
+                  /* We should check the instruction.  */
+                  break;
+                default:
+                  /* The word is not a conditional branch - ignore it.  */
+                  rela_comb[comb_count++] = &internal_relocs[n];
+                  break;
+                }
+            }
+          if (comb_count > 1)
+	    qsort (rela_comb, (size_t) comb_count, sizeof (int), ppc_elf_sort_rela);
+	}
+
+      /* Enumerate each EOP region that overlaps this section.  */
+      end_section = isec->vma + isec->_cooked_size;
+      dot = end_page = (isec->vma | (PAGESIZE - 1)) + 1;
+      dot -= link_info->mpc860c0;
+      section_modified = false;
+      if (dot < isec->vma)      /* Increment the start position if this section */
+          dot = isec->vma;      /* begins in the middle of its first EOP region.  */
+      for (;
+           dot < end_section;
+           dot += PAGESIZE, end_page += PAGESIZE)
+        {
+
+          /* Check each word in this EOP region.  */
+          for (; dot < end_page; dot += 4)
+            {
+              bfd_vma isec_offset;
+              unsigned long insn;
+              boolean skip, modified;
+
+              /* Don't process this word if there is a relocation for it and
+              the relocation indicates the word is not a conditional branch.  */
+              skip = false;
+              isec_offset = dot - isec->vma;
+              for (; comb_curr<comb_count; ++comb_curr)
+                {
+                  bfd_vma r_offset;
+
+                  r_offset = rela_comb[comb_curr]->r_offset;
+                  if (r_offset >= isec_offset)
+                    {
+                      if (r_offset == isec_offset) skip = true;
+                      break;
+                    }
+                }
+              if (skip) continue;
+
+              /* Check the current word for a problematic conditional branch.  */
+#define BO0(insn) ((insn) & 0x02000000)
+#define BO2(insn) ((insn) & 0x00800000)
+#define BO4(insn) ((insn) & 0x00200000)
+              insn = (unsigned long) bfd_get_32 (abfd, contents + isec_offset);
+              modified = false;
+              if ((insn & 0xFc000000) == 0x40000000)
+                {
+                  /* Instruction is BCx */
+                  if ((!BO0(insn) || !BO2(insn)) && !BO4(insn))
+                    {
+                      bfd_vma target;
+                      /* This branch is predicted as "normal".
+                      If this is a forward branch, it is problematic.  */
+
+                      target = insn & 0x0000Fffc;               /*extract*/
+                      target = (target ^ 0x8000) - 0x8000;      /*sign extend*/
+                      if ((insn & 0x00000002) == 0)
+                          target += dot;                        /*convert to abs*/
+                      if (target > dot)
+                        {
+                          insn |= 0x00200000;   /* set the prediction bit */
+                          modified = true;
+                        }
+                    }
+                }
+              else if ((insn & 0xFc00Fffe) == 0x4c000420)
+                {
+                  /* Instruction is BCCTRx */
+                  if ((!BO0(insn) || !BO2(insn)) && !BO4(insn))
+		    {
+		      /* This branch is predicted as not-taken.
+		      If this is a forward branch, it is problematic.
+                      Since we can't tell statically if it will branch forward,
+                      always set the prediction bit.  */
+                      insn |= 0x00200000;   /* set the prediction bit */
+                      modified = true;
+		    }
+                }
+              else if ((insn & 0xFc00Fffe) == 0x4c000020)
+                {
+                  /* Instruction is BCLRx */
+                  if ((!BO0(insn) || !BO2(insn)) && !BO4(insn))
+		    {
+		      /* This branch is predicted as not-taken.
+		      If this is a forward branch, it is problematic.
+                      Since we can't tell statically if it will branch forward,
+                      always set the prediction bit.  */
+                      insn |= 0x00200000;   /* set the prediction bit */
+                      modified = true;
+		    }
+                }
+#undef BO0
+#undef BO2
+#undef BO4
+              if (modified)
+	        {
+                  bfd_put_32 (abfd, (bfd_vma) insn, contents + isec_offset);
+		  section_modified = true;
+	        }
+            }
+        }
+      if (section_modified)
+	{
+	  elf_section_data (isec)->this_hdr.contents = contents;
+	  free_contents = NULL;
+	}
+    }
+
+  if (rela_comb != NULL)
+    {
+      free (rela_comb);
+      rela_comb = NULL;
+    }
+
+  if (free_relocs != NULL)
+    {
+      free (free_relocs);
+      free_relocs = NULL;
+    }
+
+  if (free_contents != NULL)
+    {
+      if (! link_info->keep_memory)
+	free (free_contents);
+      else
+	{
+	  /* Cache the section contents for elf_link_input_bfd.  */
+	  elf_section_data (isec)->this_hdr.contents = contents;
+	}
+      free_contents = NULL;
+    }
+
+  return true;
+
+error_return:
+  if (rela_comb != NULL)
+    free (rela_comb);
+  if (free_relocs != NULL)
+    free (free_relocs);
+  if (free_contents != NULL)
+    free (free_contents);
+  return false;
+}
+
+static reloc_howto_type *
+ppc_elf_reloc_type_lookup (abfd, code)
+     bfd *abfd ATTRIBUTE_UNUSED;
+     bfd_reloc_code_real_type code;
+{
+  enum elf_ppc_reloc_type ppc_reloc = R_PPC_NONE;
+
+  if (!ppc_elf_howto_table[R_PPC_ADDR32])
+    /* Initialize howto table if needed.  */
+    ppc_elf_howto_init ();
+
+  switch ((int) code)
+    {
+    default:
+      return (reloc_howto_type *) NULL;
+
+    case BFD_RELOC_NONE:		ppc_reloc = R_PPC_NONE;			break;
+    case BFD_RELOC_32:			ppc_reloc = R_PPC_ADDR32;		break;
+    case BFD_RELOC_PPC_BA26:		ppc_reloc = R_PPC_ADDR24;		break;
+    case BFD_RELOC_16:			ppc_reloc = R_PPC_ADDR16;		break;
+    case BFD_RELOC_LO16:		ppc_reloc = R_PPC_ADDR16_LO;		break;
+    case BFD_RELOC_HI16:		ppc_reloc = R_PPC_ADDR16_HI;		break;
+    case BFD_RELOC_HI16_S:		ppc_reloc = R_PPC_ADDR16_HA;		break;
+    case BFD_RELOC_PPC_BA16:		ppc_reloc = R_PPC_ADDR14;		break;
+    case BFD_RELOC_PPC_BA16_BRTAKEN:	ppc_reloc = R_PPC_ADDR14_BRTAKEN;	break;
+    case BFD_RELOC_PPC_BA16_BRNTAKEN:	ppc_reloc = R_PPC_ADDR14_BRNTAKEN;	break;
+    case BFD_RELOC_PPC_B26:		ppc_reloc = R_PPC_REL24;		break;
+    case BFD_RELOC_PPC_B16:		ppc_reloc = R_PPC_REL14;		break;
+    case BFD_RELOC_PPC_B16_BRTAKEN:	ppc_reloc = R_PPC_REL14_BRTAKEN;	break;
+    case BFD_RELOC_PPC_B16_BRNTAKEN:	ppc_reloc = R_PPC_REL14_BRNTAKEN;	break;
+    case BFD_RELOC_16_GOTOFF:		ppc_reloc = R_PPC_GOT16;		break;
+    case BFD_RELOC_LO16_GOTOFF:		ppc_reloc = R_PPC_GOT16_LO;		break;
+    case BFD_RELOC_HI16_GOTOFF:		ppc_reloc = R_PPC_GOT16_HI;		break;
+    case BFD_RELOC_HI16_S_GOTOFF:	ppc_reloc = R_PPC_GOT16_HA;		break;
+    case BFD_RELOC_24_PLT_PCREL:	ppc_reloc = R_PPC_PLTREL24;		break;
+    case BFD_RELOC_PPC_COPY:		ppc_reloc = R_PPC_COPY;			break;
+    case BFD_RELOC_PPC_GLOB_DAT:	ppc_reloc = R_PPC_GLOB_DAT;		break;
+    case BFD_RELOC_PPC_LOCAL24PC:	ppc_reloc = R_PPC_LOCAL24PC;		break;
+    case BFD_RELOC_32_PCREL:		ppc_reloc = R_PPC_REL32;		break;
+    case BFD_RELOC_32_PLTOFF:		ppc_reloc = R_PPC_PLT32;		break;
+    case BFD_RELOC_32_PLT_PCREL:	ppc_reloc = R_PPC_PLTREL32;		break;
+    case BFD_RELOC_LO16_PLTOFF:		ppc_reloc = R_PPC_PLT16_LO;		break;
+    case BFD_RELOC_HI16_PLTOFF:		ppc_reloc = R_PPC_PLT16_HI;		break;
+    case BFD_RELOC_HI16_S_PLTOFF:	ppc_reloc = R_PPC_PLT16_HA;		break;
+    case BFD_RELOC_GPREL16:		ppc_reloc = R_PPC_SDAREL16;		break;
+    case BFD_RELOC_16_BASEREL:		ppc_reloc = R_PPC_SECTOFF;		break;
+    case BFD_RELOC_LO16_BASEREL:	ppc_reloc = R_PPC_SECTOFF_LO;		break;
+    case BFD_RELOC_HI16_BASEREL:	ppc_reloc = R_PPC_SECTOFF_HI;		break;
+    case BFD_RELOC_HI16_S_BASEREL:	ppc_reloc = R_PPC_SECTOFF_HA;		break;
+    case BFD_RELOC_CTOR:		ppc_reloc = R_PPC_ADDR32;		break;
+    case BFD_RELOC_PPC_TOC16:		ppc_reloc = R_PPC_TOC16;		break;
+    case BFD_RELOC_PPC_EMB_NADDR32:	ppc_reloc = R_PPC_EMB_NADDR32;		break;
+    case BFD_RELOC_PPC_EMB_NADDR16:	ppc_reloc = R_PPC_EMB_NADDR16;		break;
+    case BFD_RELOC_PPC_EMB_NADDR16_LO:	ppc_reloc = R_PPC_EMB_NADDR16_LO;	break;
+    case BFD_RELOC_PPC_EMB_NADDR16_HI:	ppc_reloc = R_PPC_EMB_NADDR16_HI;	break;
+    case BFD_RELOC_PPC_EMB_NADDR16_HA:	ppc_reloc = R_PPC_EMB_NADDR16_HA;	break;
+    case BFD_RELOC_PPC_EMB_SDAI16:	ppc_reloc = R_PPC_EMB_SDAI16;		break;
+    case BFD_RELOC_PPC_EMB_SDA2I16:	ppc_reloc = R_PPC_EMB_SDA2I16;		break;
+    case BFD_RELOC_PPC_EMB_SDA2REL:	ppc_reloc = R_PPC_EMB_SDA2REL;		break;
+    case BFD_RELOC_PPC_EMB_SDA21:	ppc_reloc = R_PPC_EMB_SDA21;		break;
+    case BFD_RELOC_PPC_EMB_MRKREF:	ppc_reloc = R_PPC_EMB_MRKREF;		break;
+    case BFD_RELOC_PPC_EMB_RELSEC16:	ppc_reloc = R_PPC_EMB_RELSEC16;		break;
+    case BFD_RELOC_PPC_EMB_RELST_LO:	ppc_reloc = R_PPC_EMB_RELST_LO;		break;
+    case BFD_RELOC_PPC_EMB_RELST_HI:	ppc_reloc = R_PPC_EMB_RELST_HI;		break;
+    case BFD_RELOC_PPC_EMB_RELST_HA:	ppc_reloc = R_PPC_EMB_RELST_HA;		break;
+    case BFD_RELOC_PPC_EMB_BIT_FLD:	ppc_reloc = R_PPC_EMB_BIT_FLD;		break;
+    case BFD_RELOC_PPC_EMB_RELSDA:	ppc_reloc = R_PPC_EMB_RELSDA;		break;
+    case BFD_RELOC_PPC_MORPHOS_DREL:	ppc_reloc = R_PPC_MORPHOS_DREL;		break;
+    case BFD_RELOC_PPC_MORPHOS_DREL_LO:	ppc_reloc = R_PPC_MORPHOS_DREL_LO;	break;
+    case BFD_RELOC_PPC_MORPHOS_DREL_HI:	ppc_reloc = R_PPC_MORPHOS_DREL_HI;	break;
+    case BFD_RELOC_PPC_MORPHOS_DREL_HA:	ppc_reloc = R_PPC_MORPHOS_DREL_HA;	break;
+    case BFD_RELOC_VTABLE_INHERIT:	ppc_reloc = R_PPC_GNU_VTINHERIT;	break;
+    case BFD_RELOC_VTABLE_ENTRY:	ppc_reloc = R_PPC_GNU_VTENTRY;		break;
+    }
+
+  return ppc_elf_howto_table[(int) ppc_reloc];
+};
+
+/* Set the howto pointer for a PowerPC ELF reloc.  */
+
+static void
+ppc_elf_info_to_howto (abfd, cache_ptr, dst)
+     bfd *abfd ATTRIBUTE_UNUSED;
+     arelent *cache_ptr;
+     Elf32_Internal_Rela *dst;
+{
+  if (!ppc_elf_howto_table[R_PPC_ADDR32])
+    /* Initialize howto table if needed.  */
+    ppc_elf_howto_init ();
+
+  BFD_ASSERT (ELF32_R_TYPE (dst->r_info) < (unsigned int) R_PPC_max);
+  cache_ptr->howto = ppc_elf_howto_table[ELF32_R_TYPE (dst->r_info)];
+}
+
+/* Handle the R_PPC_ADDR16_HA reloc.  */
+
+static bfd_reloc_status_type
+ppc_elf_addr16_ha_reloc (abfd, reloc_entry, symbol, data, input_section,
+			 output_bfd, error_message)
+     bfd *abfd ATTRIBUTE_UNUSED;
+     arelent *reloc_entry;
+     asymbol *symbol;
+     PTR data ATTRIBUTE_UNUSED;
+     asection *input_section;
+     bfd *output_bfd;
+     char **error_message ATTRIBUTE_UNUSED;
+{
+  /*bfd_vma relocation;*/
+
+  if (output_bfd != NULL)
+    {
+      reloc_entry->address += input_section->output_offset;
+      return bfd_reloc_ok;
+    }
+  else
+    {
+      reloc_entry->address += input_section->output_offset;
+      input_section->output_section->orelocation[input_section->output_section->reloc_count++]=reloc_entry;
+      return bfd_reloc_ok;
+    }
+
+  /*if (reloc_entry->address > input_section->_cooked_size)
+    return bfd_reloc_outofrange;
+
+  if (bfd_is_com_section (symbol->section))
+    relocation = 0;
+  else
+    relocation = symbol->value;
+
+  relocation += symbol->section->output_section->vma;
+  relocation += symbol->section->output_offset;
+  relocation += reloc_entry->addend;
+
+  reloc_entry->addend += (relocation & 0x8000) << 1;
+
+  return bfd_reloc_continue;*/
+}
+
+/* Fix bad default arch selected for a 32 bit input bfd when the
+   default is 64 bit.  */
+
+static boolean
+ppc_elf_object_p (abfd)
+     bfd *abfd;
+{
+  if (abfd->arch_info->the_default && abfd->arch_info->bits_per_word == 64)
+    {
+      Elf_Internal_Ehdr *i_ehdr = elf_elfheader (abfd);
+
+      if (i_ehdr->e_ident[EI_CLASS] == ELFCLASS32)
+	{
+	  /* Relies on arch after 64 bit default being 32 bit default.  */
+	  abfd->arch_info = abfd->arch_info->next;
+	  BFD_ASSERT (abfd->arch_info->bits_per_word == 32);
+	}
+    }
+  return true;
+}
+
+/* Function to set whether a module needs the -mrelocatable bit set.  */
+
+static boolean
+ppc_elf_set_private_flags (abfd, flags)
+     bfd *abfd;
+     flagword flags;
+{
+  BFD_ASSERT (!elf_flags_init (abfd)
+	      || elf_elfheader (abfd)->e_flags == flags);
+
+  elf_elfheader (abfd)->e_flags = flags;
+  elf_flags_init (abfd) = true;
+  return true;
+}
+
+/* Merge backend specific data from an object file to the output
+   object file when linking */
+static boolean
+ppc_elf_merge_private_bfd_data (ibfd, obfd)
+     bfd *ibfd;
+     bfd *obfd;
+{
+  flagword old_flags;
+  flagword new_flags;
+  boolean error;
+
+  /* Check if we have the same endianess */
+  if (! _bfd_generic_verify_endian_match (ibfd, obfd))
+    return false;
+
+  if (bfd_get_flavour (ibfd) != bfd_target_elf_flavour
+      || bfd_get_flavour (obfd) != bfd_target_elf_flavour)
+    return true;
+
+  new_flags = elf_elfheader (ibfd)->e_flags;
+  old_flags = elf_elfheader (obfd)->e_flags;
+  if (!elf_flags_init (obfd))	/* First call, no flags set */
+    {
+      elf_flags_init (obfd) = true;
+      elf_elfheader (obfd)->e_flags = new_flags;
+    }
+
+  else if (new_flags == old_flags)	/* Compatible flags are ok */
+    ;
+
+  else					/* Incompatible flags */
+    {
+      /* Warn about -mrelocatable mismatch.  Allow -mrelocatable-lib to be linked
+         with either.  */
+      error = false;
+      if ((new_flags & EF_PPC_RELOCATABLE) != 0
+	  && (old_flags & (EF_PPC_RELOCATABLE | EF_PPC_RELOCATABLE_LIB)) == 0)
+	{
+	  error = true;
+	  (*_bfd_error_handler)
+	    (_("%s: compiled with -mrelocatable and linked with modules compiled normally"),
+	     bfd_archive_filename (ibfd));
+	}
+      else if ((new_flags & (EF_PPC_RELOCATABLE | EF_PPC_RELOCATABLE_LIB)) == 0
+	       && (old_flags & EF_PPC_RELOCATABLE) != 0)
+	{
+	  error = true;
+	  (*_bfd_error_handler)
+	    (_("%s: compiled normally and linked with modules compiled with -mrelocatable"),
+	     bfd_archive_filename (ibfd));
+	}
+
+      /* The output is -mrelocatable-lib iff both the input files are.  */
+      if (! (new_flags & EF_PPC_RELOCATABLE_LIB))
+	elf_elfheader (obfd)->e_flags &= ~EF_PPC_RELOCATABLE_LIB;
+
+      /* The output is -mrelocatable iff it can't be -mrelocatable-lib,
+         but each input file is either -mrelocatable or -mrelocatable-lib.  */
+      if (! (elf_elfheader (obfd)->e_flags & EF_PPC_RELOCATABLE_LIB)
+	  && (new_flags & (EF_PPC_RELOCATABLE_LIB | EF_PPC_RELOCATABLE))
+	  && (old_flags & (EF_PPC_RELOCATABLE_LIB | EF_PPC_RELOCATABLE)))
+	elf_elfheader (obfd)->e_flags |= EF_PPC_RELOCATABLE;
+
+      /* Do not warn about eabi vs. V.4 mismatch, just or in the bit if any module uses it */
+      elf_elfheader (obfd)->e_flags |= (new_flags & EF_PPC_EMB);
+
+      new_flags &= ~ (EF_PPC_RELOCATABLE | EF_PPC_RELOCATABLE_LIB | EF_PPC_EMB);
+      old_flags &= ~ (EF_PPC_RELOCATABLE | EF_PPC_RELOCATABLE_LIB | EF_PPC_EMB);
+
+      /* Warn about any other mismatches */
+      if (new_flags != old_flags)
+	{
+	  error = true;
+	  (*_bfd_error_handler)
+	    (_("%s: uses different e_flags (0x%lx) fields than previous modules (0x%lx)"),
+	     bfd_archive_filename (ibfd), (long) new_flags, (long) old_flags);
+	}
+
+      if (error)
+	{
+	  bfd_set_error (bfd_error_bad_value);
+	  return false;
+	}
+    }
+
+  return true;
+}
+
+/* Handle a PowerPC specific section when reading an object file.  This
+   is called when elfcode.h finds a section with an unknown type.  */
+
+static boolean
+ppc_elf_section_from_shdr (abfd, hdr, name)
+     bfd *abfd;
+     Elf32_Internal_Shdr *hdr;
+     const char *name;
+{
+  asection *newsect;
+  flagword flags;
+
+  if (! _bfd_elf_make_section_from_shdr (abfd, hdr, name))
+    return false;
+
+  newsect = hdr->bfd_section;
+  flags = bfd_get_section_flags (abfd, newsect);
+  if (hdr->sh_flags & SHF_EXCLUDE)
+    flags |= SEC_EXCLUDE;
+
+  if (hdr->sh_type == SHT_ORDERED)
+    flags |= SEC_SORT_ENTRIES;
+
+  bfd_set_section_flags (abfd, newsect, flags);
+  return true;
+}
+
+/* Set up any other section flags and such that may be necessary.  */
+
+static boolean
+ppc_elf_fake_sections (abfd, shdr, asect)
+     bfd *abfd ATTRIBUTE_UNUSED;
+     Elf32_Internal_Shdr *shdr;
+     asection *asect;
+{
+  if ((asect->flags & SEC_EXCLUDE) != 0)
+    shdr->sh_flags |= SHF_EXCLUDE;
+
+  if ((asect->flags & SEC_SORT_ENTRIES) != 0)
+    shdr->sh_type = SHT_ORDERED;
+
+  return true;
+}
+
+/* Create a special linker section */
+static elf_linker_section_t *
+ppc_elf_create_linker_section (abfd, info, which)
+     bfd *abfd;
+     struct bfd_link_info *info;
+     enum elf_linker_section_enum which;
+{
+  bfd *dynobj = elf_hash_table (info)->dynobj;
+  elf_linker_section_t *lsect;
+
+  /* Record the first bfd section that needs the special section */
+  if (!dynobj)
+    dynobj = elf_hash_table (info)->dynobj = abfd;
+
+  /* If this is the first time, create the section */
+  lsect = elf_linker_section (dynobj, which);
+  if (!lsect)
+    {
+      elf_linker_section_t defaults;
+      static elf_linker_section_t zero_section;
+
+      defaults = zero_section;
+      defaults.which = which;
+      defaults.hole_written_p = false;
+      defaults.alignment = 2;
+
+      /* Both of these sections are (technically) created by the user
+	 putting data in them, so they shouldn't be marked
+	 SEC_LINKER_CREATED.
+
+	 The linker creates them so it has somewhere to attach their
+	 respective symbols. In fact, if they were empty it would
+	 be OK to leave the symbol set to 0 (or any random number), because
+	 the appropriate register should never be used.  */
+      defaults.flags = (SEC_ALLOC | SEC_LOAD | SEC_HAS_CONTENTS
+			| SEC_IN_MEMORY);
+
+      switch (which)
+	{
+	default:
+	  (*_bfd_error_handler) (_("%s: Unknown special linker type %d"),
+				 bfd_get_filename (abfd),
+				 (int) which);
+
+	  bfd_set_error (bfd_error_bad_value);
+	  return (elf_linker_section_t *) 0;
+
+	case LINKER_SECTION_SDATA:	/* .sdata/.sbss section */
+	  defaults.name		  = ".sdata";
+	  defaults.rel_name	  = ".rela.sdata";
+	  defaults.bss_name	  = ".sbss";
+	  defaults.sym_name	  = "_SDA_BASE_";
+	  defaults.sym_offset	  = 32768;
+	  break;
+
+	case LINKER_SECTION_SDATA2:	/* .sdata2/.sbss2 section */
+	  defaults.name		  = ".sdata2";
+	  defaults.rel_name	  = ".rela.sdata2";
+	  defaults.bss_name	  = ".sbss2";
+	  defaults.sym_name	  = "_SDA2_BASE_";
+	  defaults.sym_offset	  = 32768;
+	  defaults.flags	 |= SEC_READONLY;
+	  break;
+	}
+
+      lsect = _bfd_elf_create_linker_section (abfd, info, which, &defaults);
+    }
+
+  return lsect;
+}
+
+/* If we have a non-zero sized .sbss2 or .PPC.EMB.sbss0 sections, we
+   need to bump up the number of section headers.  */
+
+static int
+ppc_elf_additional_program_headers (abfd)
+     bfd *abfd;
+{
+  asection *s;
+  int ret;
+
+  ret = 0;
+
+  s = bfd_get_section_by_name (abfd, ".interp");
+  if (s != NULL)
+    ++ret;
+
+  s = bfd_get_section_by_name (abfd, ".sbss2");
+  if (s != NULL && (s->flags & SEC_LOAD) != 0 && s->_raw_size > 0)
+    ++ret;
+
+  s = bfd_get_section_by_name (abfd, ".PPC.EMB.sbss0");
+  if (s != NULL && (s->flags & SEC_LOAD) != 0 && s->_raw_size > 0)
+    ++ret;
+
+  return ret;
+}
+
+/* Modify the segment map if needed.  */
+
+static boolean
+ppc_elf_modify_segment_map (abfd)
+     bfd *abfd ATTRIBUTE_UNUSED;
+{
+  return true;
+}
+
+/* The powerpc .got has a blrl instruction in it.  Mark it executable.  */
+
+static asection *
+ppc_elf_create_got (abfd, info)
+     bfd *abfd;
+     struct bfd_link_info *info;
+{
+  register asection *s;
+  flagword flags;
+
+  if (!_bfd_elf_create_got_section (abfd, info))
+    return NULL;
+
+  s = bfd_get_section_by_name (abfd, ".got");
+  if (s == NULL)
+    abort ();
+
+  flags = (SEC_ALLOC | SEC_LOAD | SEC_CODE | SEC_HAS_CONTENTS | SEC_IN_MEMORY
+	   | SEC_LINKER_CREATED);
+  if (!bfd_set_section_flags (abfd, s, flags))
+    return NULL;
+  return s;
+}
+
+/* We have to create .dynsbss and .rela.sbss here so that they get mapped
+   to output sections (just like _bfd_elf_create_dynamic_sections has
+   to create .dynbss and .rela.bss).  */
+
+static boolean
+ppc_elf_create_dynamic_sections (abfd, info)
+     bfd *abfd;
+     struct bfd_link_info *info;
+{
+  register asection *s;
+  flagword flags;
+
+  if (!ppc_elf_create_got (abfd, info))
+    return false;
+
+  if (!_bfd_elf_create_dynamic_sections (abfd, info))
+    return false;
+
+  flags = (SEC_ALLOC | SEC_LOAD | SEC_HAS_CONTENTS | SEC_IN_MEMORY
+	   | SEC_LINKER_CREATED);
+
+  s = bfd_make_section (abfd, ".dynsbss");
+  if (s == NULL
+      || ! bfd_set_section_flags (abfd, s, SEC_ALLOC))
+    return false;
+
+  if (! info->shared)
+    {
+      s = bfd_make_section (abfd, ".rela.sbss");
+      if (s == NULL
+	  || ! bfd_set_section_flags (abfd, s, flags | SEC_READONLY)
+	  || ! bfd_set_section_alignment (abfd, s, 2))
+	return false;
+    }
+
+  s = bfd_get_section_by_name (abfd, ".plt");
+  if (s == NULL)
+    abort ();
+
+  flags = SEC_ALLOC | SEC_CODE | SEC_IN_MEMORY | SEC_LINKER_CREATED;
+  return bfd_set_section_flags (abfd, s, flags);
+}
+
+/* Adjust a symbol defined by a dynamic object and referenced by a
+   regular object.  The current definition is in some section of the
+   dynamic object, but we're not including those sections.  We have to
+   change the definition to something the rest of the link can
+   understand.  */
+
+static boolean
+ppc_elf_adjust_dynamic_symbol (info, h)
+     struct bfd_link_info *info;
+     struct elf_link_hash_entry *h;
+{
+  bfd *dynobj = elf_hash_table (info)->dynobj;
+  asection *s;
+  unsigned int power_of_two;
+  bfd_vma plt_offset;
+
+#ifdef DEBUG
+  fprintf (stderr, "ppc_elf_adjust_dynamic_symbol called for %s\n", h->root.root.string);
+#endif
+
+  /* Make sure we know what is going on here.  */
+  BFD_ASSERT (dynobj != NULL
+	      && ((h->elf_link_hash_flags & ELF_LINK_HASH_NEEDS_PLT)
+		  || h->weakdef != NULL
+		  || ((h->elf_link_hash_flags
+		       & ELF_LINK_HASH_DEF_DYNAMIC) != 0
+		      && (h->elf_link_hash_flags
+			  & ELF_LINK_HASH_REF_REGULAR) != 0
+		      && (h->elf_link_hash_flags
+			  & ELF_LINK_HASH_DEF_REGULAR) == 0)));
+
+  /* If this is a function, put it in the procedure linkage table.  We
+     will fill in the contents of the procedure linkage table later,
+     when we know the address of the .got section.  */
+  if (h->type == STT_FUNC
+      || (h->elf_link_hash_flags & ELF_LINK_HASH_NEEDS_PLT) != 0)
+    {
+      if (! elf_hash_table (info)->dynamic_sections_created
+ 	  || SYMBOL_CALLS_LOCAL (info, h)
+	  || (info->shared && h->plt.refcount <= 0))
+	{
+	  /* A PLT entry is not required/allowed when:
+
+	     1. We are not using ld.so; because then the PLT entry
+	     can't be set up, so we can't use one.
+
+	     2. We know for certain that a call to this symbol
+	     will go to this object.
+
+	     3. GC has rendered the entry unused.
+	     Note, however, that in an executable all references to the
+	     symbol go to the PLT, so we can't turn it off in that case.
+	     ??? The correct thing to do here is to reference count
+	     all uses of the symbol, not just those to the GOT or PLT.  */
+	  h->plt.offset = (bfd_vma) -1;
+	  h->elf_link_hash_flags &= ~ELF_LINK_HASH_NEEDS_PLT;
+	  return true;
+	}
+
+      /* Make sure this symbol is output as a dynamic symbol.  */
+      if (h->dynindx == -1)
+	{
+	  if (! bfd_elf32_link_record_dynamic_symbol (info, h))
+	    return false;
+	}
+      BFD_ASSERT (h->dynindx != -1);
+
+      s = bfd_get_section_by_name (dynobj, ".plt");
+      BFD_ASSERT (s != NULL);
+
+      /* If this is the first .plt entry, make room for the special
+	 first entry.  */
+      if (s->_raw_size == 0)
+	s->_raw_size += PLT_INITIAL_ENTRY_SIZE;
+
+      /* The PowerPC PLT is actually composed of two parts, the first part
+	 is 2 words (for a load and a jump), and then there is a remaining
+	 word available at the end.  */
+      plt_offset = (PLT_INITIAL_ENTRY_SIZE
+		    + (PLT_SLOT_SIZE
+		       * ((s->_raw_size - PLT_INITIAL_ENTRY_SIZE)
+			  / PLT_ENTRY_SIZE)));
+
+      /* If this symbol is not defined in a regular file, and we are
+	 not generating a shared library, then set the symbol to this
+	 location in the .plt.  This is required to make function
+	 pointers compare as equal between the normal executable and
+	 the shared library.  */
+      if (! info->shared
+	  && (h->elf_link_hash_flags & ELF_LINK_HASH_DEF_REGULAR) == 0)
+	{
+	  h->root.u.def.section = s;
+	  h->root.u.def.value = plt_offset;
+	}
+
+      h->plt.offset = plt_offset;
+
+      /* Make room for this entry.  After the 8192nd entry, room
+         for two entries is allocated.  */
+      if ((s->_raw_size - PLT_INITIAL_ENTRY_SIZE) / PLT_ENTRY_SIZE
+	  >= PLT_NUM_SINGLE_ENTRIES)
+	s->_raw_size += 2 * PLT_ENTRY_SIZE;
+      else
+	s->_raw_size += PLT_ENTRY_SIZE;
+
+      /* We also need to make an entry in the .rela.plt section.  */
+      s = bfd_get_section_by_name (dynobj, ".rela.plt");
+      BFD_ASSERT (s != NULL);
+      s->_raw_size += sizeof (Elf32_External_Rela);
+
+      return true;
+    }
+  else
+    h->plt.offset = (bfd_vma) -1;
+
+  /* If this is a weak symbol, and there is a real definition, the
+     processor independent code will have arranged for us to see the
+     real definition first, and we can just use the same value.  */
+  if (h->weakdef != NULL)
+    {
+      BFD_ASSERT (h->weakdef->root.type == bfd_link_hash_defined
+		  || h->weakdef->root.type == bfd_link_hash_defweak);
+      h->root.u.def.section = h->weakdef->root.u.def.section;
+      h->root.u.def.value = h->weakdef->root.u.def.value;
+      return true;
+    }
+
+  /* This is a reference to a symbol defined by a dynamic object which
+     is not a function.  */
+
+  /* If we are creating a shared library, we must presume that the
+     only references to the symbol are via the global offset table.
+     For such cases we need not do anything here; the relocations will
+     be handled correctly by relocate_section.  */
+  if (info->shared)
+    return true;
+
+  /* We must allocate the symbol in our .dynbss section, which will
+     become part of the .bss section of the executable.  There will be
+     an entry for this symbol in the .dynsym section.  The dynamic
+     object will contain position independent code, so all references
+     from the dynamic object to this symbol will go through the global
+     offset table.  The dynamic linker will use the .dynsym entry to
+     determine the address it must put in the global offset table, so
+     both the dynamic object and the regular object will refer to the
+     same memory location for the variable.
+
+     Of course, if the symbol is sufficiently small, we must instead
+     allocate it in .sbss.  FIXME: It would be better to do this if and
+     only if there were actually SDAREL relocs for that symbol.  */
+
+  if (h->size <= elf_gp_size (dynobj))
+    s = bfd_get_section_by_name (dynobj, ".dynsbss");
+  else
+    s = bfd_get_section_by_name (dynobj, ".dynbss");
+  BFD_ASSERT (s != NULL);
+
+  /* We must generate a R_PPC_COPY reloc to tell the dynamic linker to
+     copy the initial value out of the dynamic object and into the
+     runtime process image.  We need to remember the offset into the
+     .rela.bss section we are going to use.  */
+  if ((h->root.u.def.section->flags & SEC_ALLOC) != 0)
+    {
+      asection *srel;
+
+      if (h->size <= elf_gp_size (dynobj))
+	srel = bfd_get_section_by_name (dynobj, ".rela.sbss");
+      else
+	srel = bfd_get_section_by_name (dynobj, ".rela.bss");
+      BFD_ASSERT (srel != NULL);
+      srel->_raw_size += sizeof (Elf32_External_Rela);
+      h->elf_link_hash_flags |= ELF_LINK_HASH_NEEDS_COPY;
+    }
+
+  /* We need to figure out the alignment required for this symbol.  I
+     have no idea how ELF linkers handle this.  */
+  power_of_two = bfd_log2 (h->size);
+  if (power_of_two > 4)
+    power_of_two = 4;
+
+  /* Apply the required alignment.  */
+  s->_raw_size = BFD_ALIGN (s->_raw_size,
+			    (bfd_size_type) (1 << power_of_two));
+  if (power_of_two > bfd_get_section_alignment (dynobj, s))
+    {
+      if (! bfd_set_section_alignment (dynobj, s, power_of_two))
+	return false;
+    }
+
+  /* Define the symbol as being at this point in the section.  */
+  h->root.u.def.section = s;
+  h->root.u.def.value = s->_raw_size;
+
+  /* Increment the section size to make room for the symbol.  */
+  s->_raw_size += h->size;
+
+  return true;
+}
+
+/* Set the sizes of the dynamic sections.  */
+
+static boolean
+ppc_elf_size_dynamic_sections (output_bfd, info)
+     bfd *output_bfd ATTRIBUTE_UNUSED;
+     struct bfd_link_info *info;
+{
+  bfd *dynobj;
+  asection *s;
+  boolean plt;
+  boolean relocs;
+
+#ifdef DEBUG
+  fprintf (stderr, "ppc_elf_size_dynamic_sections called\n");
+#endif
+
+  dynobj = elf_hash_table (info)->dynobj;
+  BFD_ASSERT (dynobj != NULL);
+
+  if (elf_hash_table (info)->dynamic_sections_created)
+    {
+      /* Set the contents of the .interp section to the interpreter.  */
+      if (! info->shared)
+	{
+	  s = bfd_get_section_by_name (dynobj, ".interp");
+	  BFD_ASSERT (s != NULL);
+	  s->_raw_size = sizeof ELF_DYNAMIC_INTERPRETER;
+	  s->contents = (unsigned char *) ELF_DYNAMIC_INTERPRETER;
+	}
+    }
+  else
+    {
+      /* We may have created entries in the .rela.got, .rela.sdata, and
+	 .rela.sdata2 sections.  However, if we are not creating the
+	 dynamic sections, we will not actually use these entries.  Reset
+	 the size of .rela.got, et al, which will cause it to get
+	 stripped from the output file below.  */
+      static char *rela_sections[] = { ".rela.got", ".rela.sdata",
+				       ".rela.sdata2", ".rela.sbss",
+				       (char *) 0 };
+      char **p;
+
+      for (p = rela_sections; *p != (char *) 0; p++)
+	{
+	  s = bfd_get_section_by_name (dynobj, *p);
+	  if (s != NULL)
+	    s->_raw_size = 0;
+	}
+    }
+
+  /* The check_relocs and adjust_dynamic_symbol entry points have
+     determined the sizes of the various dynamic sections.  Allocate
+     memory for them.  */
+  plt = false;
+  relocs = false;
+  for (s = dynobj->sections; s != NULL; s = s->next)
+    {
+      const char *name;
+      boolean strip;
+
+      if ((s->flags & SEC_LINKER_CREATED) == 0)
+	continue;
+
+      /* It's OK to base decisions on the section name, because none
+	 of the dynobj section names depend upon the input files.  */
+      name = bfd_get_section_name (dynobj, s);
+
+      strip = false;
+
+      if (strcmp (name, ".plt") == 0)
+	{
+	  if (s->_raw_size == 0)
+	    {
+	      /* Strip this section if we don't need it; see the
+                 comment below.  */
+	      strip = true;
+	    }
+	  else
+	    {
+	      /* Remember whether there is a PLT.  */
+	      plt = true;
+	    }
+	}
+      else if (strncmp (name, ".rela", 5) == 0)
+	{
+	  if (s->_raw_size == 0)
+	    {
+	      /* If we don't need this section, strip it from the
+		 output file.  This is mostly to handle .rela.bss and
+		 .rela.plt.  We must create both sections in
+		 create_dynamic_sections, because they must be created
+		 before the linker maps input sections to output
+		 sections.  The linker does that before
+		 adjust_dynamic_symbol is called, and it is that
+		 function which decides whether anything needs to go
+		 into these sections.  */
+	      strip = true;
+	    }
+	  else
+	    {
+	      /* Remember whether there are any relocation sections.  */
+	      relocs = true;
+
+	      /* We use the reloc_count field as a counter if we need
+		 to copy relocs into the output file.  */
+	      s->reloc_count = 0;
+	    }
+	}
+      else if (strcmp (name, ".got") != 0
+	       && strcmp (name, ".sdata") != 0
+	       && strcmp (name, ".sdata2") != 0)
+	{
+	  /* It's not one of our sections, so don't allocate space.  */
+	  continue;
+	}
+
+      if (strip)
+	{
+	  _bfd_strip_section_from_output (info, s);
+	  continue;
+	}
+
+      /* Allocate memory for the section contents.  */
+      s->contents = (bfd_byte *) bfd_zalloc (dynobj, s->_raw_size);
+      if (s->contents == NULL && s->_raw_size != 0)
+	return false;
+    }
+
+  if (elf_hash_table (info)->dynamic_sections_created)
+    {
+      /* Add some entries to the .dynamic section.  We fill in the
+	 values later, in ppc_elf_finish_dynamic_sections, but we
+	 must add the entries now so that we get the correct size for
+	 the .dynamic section.  The DT_DEBUG entry is filled in by the
+	 dynamic linker and used by the debugger.  */
+#define add_dynamic_entry(TAG, VAL) \
+  bfd_elf32_add_dynamic_entry (info, (bfd_vma) (TAG), (bfd_vma) (VAL))
+
+      if (!info->shared)
+	{
+	  if (!add_dynamic_entry (DT_DEBUG, 0))
+	    return false;
+	}
+
+      if (plt)
+	{
+	  if (!add_dynamic_entry (DT_PLTGOT, 0)
+	      || !add_dynamic_entry (DT_PLTRELSZ, 0)
+	      || !add_dynamic_entry (DT_PLTREL, DT_RELA)
+	      || !add_dynamic_entry (DT_JMPREL, 0))
+	    return false;
+	}
+
+      if (relocs)
+	{
+	  if (!add_dynamic_entry (DT_RELA, 0)
+	      || !add_dynamic_entry (DT_RELASZ, 0)
+	      || !add_dynamic_entry (DT_RELAENT, sizeof (Elf32_External_Rela)))
+	    return false;
+	}
+
+      if ((info->flags & DF_TEXTREL) != 0)
+	{
+	  if (!add_dynamic_entry (DT_TEXTREL, 0))
+	    return false;
+	  info->flags |= DF_TEXTREL;
+	}
+    }
+#undef add_dynamic_entry
+
+  return true;
+}
+
+/* Look through the relocs for a section during the first phase, and
+   allocate space in the global offset table or procedure linkage
+   table.  */
+
+static boolean
+ppc_elf_check_relocs (abfd, info, sec, relocs)
+     bfd *abfd;
+     struct bfd_link_info *info;
+     asection *sec;
+     const Elf_Internal_Rela *relocs;
+{
+  bfd *dynobj;
+  Elf_Internal_Shdr *symtab_hdr;
+  struct elf_link_hash_entry **sym_hashes, **sym_hashes_end;
+  const Elf_Internal_Rela *rel;
+  const Elf_Internal_Rela *rel_end;
+  bfd_signed_vma *local_got_refcounts;
+  elf_linker_section_t *sdata;
+  elf_linker_section_t *sdata2;
+  asection *sreloc;
+  asection *sgot = NULL;
+  asection *srelgot = NULL;
+
+  if (info->relocateable)
+    return true;
+
+#ifdef DEBUG
+  fprintf (stderr, "ppc_elf_check_relocs called for section %s in %s\n",
+	   bfd_get_section_name (abfd, sec),
+	   bfd_archive_filename (abfd));
+#endif
+
+  /* Create the linker generated sections all the time so that the
+     special symbols are created.  */
+
+  if ((sdata = elf_linker_section (abfd, LINKER_SECTION_SDATA)) == NULL)
+    {
+      sdata = ppc_elf_create_linker_section (abfd, info, LINKER_SECTION_SDATA);
+      if (!sdata)
+	return false;
+    }
+
+  if ((sdata2 = elf_linker_section (abfd, LINKER_SECTION_SDATA2)) == NULL)
+    {
+      sdata2 = ppc_elf_create_linker_section (abfd, info, LINKER_SECTION_SDATA2);
+      if (!sdata2)
+	return false;
+    }
+
+  dynobj = elf_hash_table (info)->dynobj;
+  symtab_hdr = &elf_tdata (abfd)->symtab_hdr;
+  local_got_refcounts = elf_local_got_refcounts (abfd);
+
+  sym_hashes = elf_sym_hashes (abfd);
+  sym_hashes_end = sym_hashes + symtab_hdr->sh_size/sizeof (Elf32_External_Sym);
+  if (!elf_bad_symtab (abfd))
+    sym_hashes_end -= symtab_hdr->sh_info;
+
+  sreloc = NULL;
+
+  rel_end = relocs + sec->reloc_count;
+  for (rel = relocs; rel < rel_end; rel++)
+    {
+      unsigned long r_symndx;
+      struct elf_link_hash_entry *h;
+
+      r_symndx = ELF32_R_SYM (rel->r_info);
+      if (r_symndx < symtab_hdr->sh_info)
+	h = NULL;
+      else
+	h = sym_hashes[r_symndx - symtab_hdr->sh_info];
+
+      /* If a relocation refers to _GLOBAL_OFFSET_TABLE_, create the .got.
+	 This shows up in particular in an R_PPC_ADDR32 in the eabi
+	 startup code.  */
+      if (h && strcmp (h->root.root.string, "_GLOBAL_OFFSET_TABLE_") == 0)
+	{
+	  if (sgot == NULL)
+	    {
+	      if (dynobj == NULL)
+		elf_hash_table (info)->dynobj = dynobj = abfd;
+	      sgot = ppc_elf_create_got (dynobj, info);
+	      if (sgot == NULL)
+		return false;
+	    }
+	}
+
+      switch (ELF32_R_TYPE (rel->r_info))
+	{
+	/* GOT16 relocations */
+	case R_PPC_GOT16:
+	case R_PPC_GOT16_LO:
+	case R_PPC_GOT16_HI:
+	case R_PPC_GOT16_HA:
+	  /* This symbol requires a global offset table entry.  */
+
+	  if (sgot == NULL)
+	    {
+	      if (dynobj == NULL)
+		elf_hash_table (info)->dynobj = dynobj = abfd;
+	      sgot = ppc_elf_create_got (dynobj, info);
+	      if (sgot == NULL)
+		return false;
+	    }
+
+	  if (srelgot == NULL
+	      && (h != NULL || info->shared))
+	    {
+	      srelgot = bfd_get_section_by_name (dynobj, ".rela.got");
+	      if (srelgot == NULL)
+		{
+		  srelgot = bfd_make_section (dynobj, ".rela.got");
+		  if (srelgot == NULL
+		      || ! bfd_set_section_flags (dynobj, srelgot,
+						  (SEC_ALLOC
+						   | SEC_LOAD
+						   | SEC_HAS_CONTENTS
+						   | SEC_IN_MEMORY
+						   | SEC_LINKER_CREATED
+						   | SEC_READONLY))
+		      || ! bfd_set_section_alignment (dynobj, srelgot, 2))
+		    return false;
+		}
+	    }
+
+	  if (h != NULL)
+	    {
+	      if (h->got.refcount == 0)
+		{
+		  /* Make sure this symbol is output as a dynamic symbol.  */
+		  if (h->dynindx == -1)
+		    if (!bfd_elf32_link_record_dynamic_symbol (info, h))
+		      return false;
+
+		  /* Allocate space in the .got.  */
+		  sgot->_raw_size += 4;
+		  /* Allocate relocation space.  */
+		  srelgot->_raw_size += sizeof (Elf32_External_Rela);
+		}
+	      h->got.refcount++;
+	    }
+	  else
+	    {
+	      /* This is a global offset table entry for a local symbol.  */
+	      if (local_got_refcounts == NULL)
+		{
+		  bfd_size_type size;
+
+		  size = symtab_hdr->sh_info;
+		  size *= sizeof (bfd_signed_vma);
+		  local_got_refcounts
+		    = (bfd_signed_vma *) bfd_zalloc (abfd, size);
+		  if (local_got_refcounts == NULL)
+		    return false;
+		  elf_local_got_refcounts (abfd) = local_got_refcounts;
+		}
+	      if (local_got_refcounts[r_symndx] == 0)
+		{
+		  sgot->_raw_size += 4;
+
+		  /* If we are generating a shared object, we need to
+                     output a R_PPC_RELATIVE reloc so that the
+                     dynamic linker can adjust this GOT entry.  */
+		  if (info->shared)
+		    srelgot->_raw_size += sizeof (Elf32_External_Rela);
+		}
+	      local_got_refcounts[r_symndx]++;
+	    }
+	  break;
+
+	/* Indirect .sdata relocation */
+	case R_PPC_EMB_SDAI16:
+	  if (info->shared)
+	    {
+	      ((*_bfd_error_handler)
+	       (_("%s: relocation %s cannot be used when making a shared object"),
+		bfd_archive_filename (abfd), "R_PPC_EMB_SDAI16"));
+	      return false;
+	    }
+
+	  if (srelgot == NULL && (h != NULL || info->shared))
+	    {
+	      srelgot = bfd_get_section_by_name (dynobj, ".rela.got");
+	      if (srelgot == NULL)
+		{
+		  srelgot = bfd_make_section (dynobj, ".rela.got");
+		  if (srelgot == NULL
+		      || ! bfd_set_section_flags (dynobj, srelgot,
+						  (SEC_ALLOC
+						   | SEC_LOAD
+						   | SEC_HAS_CONTENTS
+						   | SEC_IN_MEMORY
+						   | SEC_LINKER_CREATED
+						   | SEC_READONLY))
+		      || ! bfd_set_section_alignment (dynobj, srelgot, 2))
+		    return false;
+		}
+	    }
+
+	  if (!bfd_elf32_create_pointer_linker_section (abfd, info, sdata, h, rel))
+	    return false;
+
+	  break;
+
+	/* Indirect .sdata2 relocation */
+	case R_PPC_EMB_SDA2I16:
+	  if (info->shared)
+	    {
+	      ((*_bfd_error_handler)
+	       (_("%s: relocation %s cannot be used when making a shared object"),
+		bfd_archive_filename (abfd), "R_PPC_EMB_SDA2I16"));
+	      return false;
+	    }
+
+	  if (srelgot == NULL && (h != NULL || info->shared))
+	    {
+	      srelgot = bfd_get_section_by_name (dynobj, ".rela.got");
+	      if (srelgot == NULL)
+		{
+		  srelgot = bfd_make_section (dynobj, ".rela.got");
+		  if (srelgot == NULL
+		      || ! bfd_set_section_flags (dynobj, srelgot,
+						  (SEC_ALLOC
+						   | SEC_LOAD
+						   | SEC_HAS_CONTENTS
+						   | SEC_IN_MEMORY
+						   | SEC_LINKER_CREATED
+						   | SEC_READONLY))
+		      || ! bfd_set_section_alignment (dynobj, srelgot, 2))
+		    return false;
+		}
+	    }
+
+	  if (!bfd_elf32_create_pointer_linker_section (abfd, info, sdata2, h, rel))
+	    return false;
+
+	  break;
+
+	case R_PPC_SDAREL16:
+	case R_PPC_EMB_SDA2REL:
+	case R_PPC_EMB_SDA21:
+	  if (info->shared)
+	    {
+	      ((*_bfd_error_handler)
+	       (_("%s: relocation %s cannot be used when making a shared object"),
+		bfd_archive_filename (abfd),
+		ppc_elf_howto_table[(int) ELF32_R_TYPE (rel->r_info)]->name));
+	      return false;
+	    }
+	  break;
+
+	case R_PPC_PLT32:
+	case R_PPC_PLTREL24:
+	case R_PPC_PLT16_LO:
+	case R_PPC_PLT16_HI:
+	case R_PPC_PLT16_HA:
+#ifdef DEBUG
+	  fprintf (stderr, "Reloc requires a PLT entry\n");
+#endif
+	  /* This symbol requires a procedure linkage table entry.  We
+             actually build the entry in adjust_dynamic_symbol,
+             because this might be a case of linking PIC code without
+             linking in any dynamic objects, in which case we don't
+             need to generate a procedure linkage table after all.  */
+
+	  if (h == NULL)
+	    {
+	      /* It does not make sense to have a procedure linkage
+                 table entry for a local symbol.  */
+	      bfd_set_error (bfd_error_bad_value);
+	      return false;
+	    }
+
+	  /* Make sure this symbol is output as a dynamic symbol.  */
+	  if (h->dynindx == -1)
+	    {
+	      if (! bfd_elf32_link_record_dynamic_symbol (info, h))
+		return false;
+	    }
+	  h->elf_link_hash_flags |= ELF_LINK_HASH_NEEDS_PLT;
+	  h->plt.refcount++;
+	  break;
+
+	  /* The following relocations don't need to propagate the
+	     relocation if linking a shared object since they are
+	     section relative.  */
+	case R_PPC_SECTOFF:
+	case R_PPC_SECTOFF_LO:
+	case R_PPC_SECTOFF_HI:
+	case R_PPC_SECTOFF_HA:
+	  break;
+
+	  /* This refers only to functions defined in the shared library */
+	case R_PPC_LOCAL24PC:
+	  break;
+
+	  /* This relocation describes the C++ object vtable hierarchy.
+	     Reconstruct it for later use during GC.  */
+	case R_PPC_GNU_VTINHERIT:
+	  if (!_bfd_elf32_gc_record_vtinherit (abfd, sec, h, rel->r_offset))
+	    return false;
+	  break;
+
+	  /* This relocation describes which C++ vtable entries are actually
+	     used.  Record for later use during GC.  */
+	case R_PPC_GNU_VTENTRY:
+	  if (!_bfd_elf32_gc_record_vtentry (abfd, sec, h, rel->r_addend))
+	    return false;
+	  break;
+
+	  /* When creating a shared object, we must copy these
+	     relocs into the output file.  We create a reloc
+	     section in dynobj and make room for the reloc.  */
+	case R_PPC_REL24:
+	case R_PPC_REL14:
+	case R_PPC_REL14_BRTAKEN:
+	case R_PPC_REL14_BRNTAKEN:
+	case R_PPC_REL32:
+	  if (h == NULL
+	      || strcmp (h->root.root.string, "_GLOBAL_OFFSET_TABLE_") == 0
+	      || SYMBOL_REFERENCES_LOCAL (info, h))
+	    break;
+	  /* fall through */
+
+	default:
+	  if (info->shared)
+	    {
+#ifdef DEBUG
+	      fprintf (stderr, "ppc_elf_check_relocs need to create relocation for %s\n",
+		       (h && h->root.root.string) ? h->root.root.string : "<unknown>");
+#endif
+	      if (sreloc == NULL)
+		{
+		  const char *name;
+
+		  name = (bfd_elf_string_from_elf_section
+			  (abfd,
+			   elf_elfheader (abfd)->e_shstrndx,
+			   elf_section_data (sec)->rel_hdr.sh_name));
+		  if (name == NULL)
+		    return false;
+
+		  BFD_ASSERT (strncmp (name, ".rela", 5) == 0
+			      && strcmp (bfd_get_section_name (abfd, sec),
+					 name + 5) == 0);
+
+		  sreloc = bfd_get_section_by_name (dynobj, name);
+		  if (sreloc == NULL)
+		    {
+		      flagword flags;
+
+		      sreloc = bfd_make_section (dynobj, name);
+		      flags = (SEC_HAS_CONTENTS | SEC_READONLY
+			       | SEC_IN_MEMORY | SEC_LINKER_CREATED);
+		      if ((sec->flags & SEC_ALLOC) != 0)
+			flags |= SEC_ALLOC | SEC_LOAD;
+		      if (sreloc == NULL
+			  || ! bfd_set_section_flags (dynobj, sreloc, flags)
+			  || ! bfd_set_section_alignment (dynobj, sreloc, 2))
+			return false;
+		    }
+		  if (sec->flags & SEC_READONLY)
+		    info->flags |= DF_TEXTREL;
+		}
+
+	      sreloc->_raw_size += sizeof (Elf32_External_Rela);
+
+	      /* FIXME: We should here do what the m68k and i386
+		 backends do: if the reloc is pc-relative, record it
+		 in case it turns out that the reloc is unnecessary
+		 because the symbol is forced local by versioning or
+		 we are linking with -Bdynamic.  Fortunately this
+		 case is not frequent.  */
+	    }
+
+	  break;
+	}
+    }
+
+  return true;
+}
+
+/* Return the section that should be marked against GC for a given
+   relocation.  */
+
+static asection *
+ppc_elf_gc_mark_hook (sec, info, rel, h, sym)
+     asection *sec;
+     struct bfd_link_info *info ATTRIBUTE_UNUSED;
+     Elf_Internal_Rela *rel;
+     struct elf_link_hash_entry *h;
+     Elf_Internal_Sym *sym;
+{
+  if (h != NULL)
+    {
+      switch (ELF32_R_TYPE (rel->r_info))
+	{
+	case R_PPC_GNU_VTINHERIT:
+	case R_PPC_GNU_VTENTRY:
+	  break;
+
+	default:
+	  switch (h->root.type)
+	    {
+	    case bfd_link_hash_defined:
+	    case bfd_link_hash_defweak:
+	      return h->root.u.def.section;
+
+	    case bfd_link_hash_common:
+	      return h->root.u.c.p->section;
+
+	    default:
+	      break;
+	    }
+	}
+    }
+  else
+    return bfd_section_from_elf_index (sec->owner, sym->st_shndx);
+
+  return NULL;
+}
+
+/* Update the got entry reference counts for the section being removed.  */
+
+static boolean
+ppc_elf_gc_sweep_hook (abfd, info, sec, relocs)
+     bfd *abfd;
+     struct bfd_link_info *info ATTRIBUTE_UNUSED;
+     asection *sec;
+     const Elf_Internal_Rela *relocs;
+{
+  Elf_Internal_Shdr *symtab_hdr;
+  struct elf_link_hash_entry **sym_hashes;
+  bfd_signed_vma *local_got_refcounts;
+  const Elf_Internal_Rela *rel, *relend;
+  unsigned long r_symndx;
+  struct elf_link_hash_entry *h;
+
+  symtab_hdr = &elf_tdata (abfd)->symtab_hdr;
+  sym_hashes = elf_sym_hashes (abfd);
+  local_got_refcounts = elf_local_got_refcounts (abfd);
+
+  relend = relocs + sec->reloc_count;
+  for (rel = relocs; rel < relend; rel++)
+    switch (ELF32_R_TYPE (rel->r_info))
+      {
+      case R_PPC_GOT16:
+      case R_PPC_GOT16_LO:
+      case R_PPC_GOT16_HI:
+      case R_PPC_GOT16_HA:
+	r_symndx = ELF32_R_SYM (rel->r_info);
+	if (r_symndx >= symtab_hdr->sh_info)
+	  {
+	    h = sym_hashes[r_symndx - symtab_hdr->sh_info];
+	    if (h->got.refcount > 0)
+	      h->got.refcount--;
+	  }
+	else if (local_got_refcounts != NULL)
+	  {
+	    if (local_got_refcounts[r_symndx] > 0)
+	      local_got_refcounts[r_symndx]--;
+	  }
+        break;
+
+      case R_PPC_PLT32:
+      case R_PPC_PLTREL24:
+      case R_PPC_PLT16_LO:
+      case R_PPC_PLT16_HI:
+      case R_PPC_PLT16_HA:
+	r_symndx = ELF32_R_SYM (rel->r_info);
+	if (r_symndx >= symtab_hdr->sh_info)
+	  {
+	    h = sym_hashes[r_symndx - symtab_hdr->sh_info];
+	    if (h->plt.refcount > 0)
+	      h->plt.refcount--;
+	  }
+	break;
+
+      default:
+	break;
+      }
+
+  return true;
+}
+
+/* Hook called by the linker routine which adds symbols from an object
+   file.  We use it to put .comm items in .sbss, and not .bss.  */
+
+static boolean
+ppc_elf_add_symbol_hook (abfd, info, sym, namep, flagsp, secp, valp)
+     bfd *abfd;
+     struct bfd_link_info *info;
+     const Elf_Internal_Sym *sym;
+     const char **namep ATTRIBUTE_UNUSED;
+     flagword *flagsp ATTRIBUTE_UNUSED;
+     asection **secp;
+     bfd_vma *valp;
+{
+  if (sym->st_shndx == SHN_COMMON
+      && !info->relocateable
+      && sym->st_size <= elf_gp_size (abfd)
+      && info->hash->creator->flavour == bfd_target_elf_flavour)
+    {
+      /* Common symbols less than or equal to -G nn bytes are automatically
+	 put into .sdata.  */
+      elf_linker_section_t *sdata
+	= ppc_elf_create_linker_section (abfd, info, LINKER_SECTION_SDATA);
+
+      if (!sdata->bss_section)
+	{
+	  bfd_size_type amt;
+
+	  /* We don't go through bfd_make_section, because we don't
+             want to attach this common section to DYNOBJ.  The linker
+             will move the symbols to the appropriate output section
+             when it defines common symbols.  */
+	  amt = sizeof (asection);
+	  sdata->bss_section = (asection *) bfd_zalloc (abfd, amt);
+	  if (sdata->bss_section == NULL)
+	    return false;
+	  sdata->bss_section->name = sdata->bss_name;
+	  sdata->bss_section->flags = SEC_IS_COMMON;
+	  sdata->bss_section->output_section = sdata->bss_section;
+	  amt = sizeof (asymbol);
+	  sdata->bss_section->symbol = (asymbol *) bfd_zalloc (abfd, amt);
+	  amt = sizeof (asymbol *);
+	  sdata->bss_section->symbol_ptr_ptr =
+	    (asymbol **) bfd_zalloc (abfd, amt);
+	  if (sdata->bss_section->symbol == NULL
+	      || sdata->bss_section->symbol_ptr_ptr == NULL)
+	    return false;
+	  sdata->bss_section->symbol->name = sdata->bss_name;
+	  sdata->bss_section->symbol->flags = BSF_SECTION_SYM;
+	  sdata->bss_section->symbol->section = sdata->bss_section;
+	  *sdata->bss_section->symbol_ptr_ptr = sdata->bss_section->symbol;
+	}
+
+      *secp = sdata->bss_section;
+      *valp = sym->st_size;
+    }
+
+  return true;
+}
+
+/* Finish up dynamic symbol handling.  We set the contents of various
+   dynamic sections here.  */
+
+static boolean
+ppc_elf_finish_dynamic_symbol (output_bfd, info, h, sym)
+     bfd *output_bfd;
+     struct bfd_link_info *info;
+     struct elf_link_hash_entry *h;
+     Elf_Internal_Sym *sym;
+{
+  bfd *dynobj;
+
+#ifdef DEBUG
+  fprintf (stderr, "ppc_elf_finish_dynamic_symbol called for %s",
+	   h->root.root.string);
+#endif
+
+  dynobj = elf_hash_table (info)->dynobj;
+  BFD_ASSERT (dynobj != NULL);
+
+  if (h->plt.offset != (bfd_vma) -1)
+    {
+      asection *splt;
+      asection *srela;
+      Elf_Internal_Rela rela;
+      bfd_vma reloc_index;
+
+#ifdef DEBUG
+      fprintf (stderr, ", plt_offset = %d", h->plt.offset);
+#endif
+
+      /* This symbol has an entry in the procedure linkage table.  Set
+         it up.  */
+
+      BFD_ASSERT (h->dynindx != -1);
+
+      splt = bfd_get_section_by_name (dynobj, ".plt");
+      srela = bfd_get_section_by_name (dynobj, ".rela.plt");
+      BFD_ASSERT (splt != NULL && srela != NULL);
+
+      /* We don't need to fill in the .plt.  The ppc dynamic linker
+	 will fill it in.  */
+
+      /* Fill in the entry in the .rela.plt section.  */
+      rela.r_offset = (splt->output_section->vma
+		       + splt->output_offset
+		       + h->plt.offset);
+      rela.r_info = ELF32_R_INFO (h->dynindx, R_PPC_JMP_SLOT);
+      rela.r_addend = 0;
+
+      reloc_index = (h->plt.offset - PLT_INITIAL_ENTRY_SIZE) / PLT_SLOT_SIZE;
+      if (reloc_index > PLT_NUM_SINGLE_ENTRIES)
+	reloc_index -= (reloc_index - PLT_NUM_SINGLE_ENTRIES) / 2;
+      bfd_elf32_swap_reloca_out (output_bfd, &rela,
+				 ((Elf32_External_Rela *) srela->contents
+				  + reloc_index));
+
+      if ((h->elf_link_hash_flags & ELF_LINK_HASH_DEF_REGULAR) == 0)
+	{
+	  /* Mark the symbol as undefined, rather than as defined in
+	     the .plt section.  Leave the value alone.  */
+	  sym->st_shndx = SHN_UNDEF;
+	  /* If the symbol is weak, we do need to clear the value.
+	     Otherwise, the PLT entry would provide a definition for
+	     the symbol even if the symbol wasn't defined anywhere,
+	     and so the symbol would never be NULL.  */
+	  if ((h->elf_link_hash_flags & ELF_LINK_HASH_REF_REGULAR_NONWEAK)
+	      == 0)
+	    sym->st_value = 0;
+	}
+    }
+
+  if (h->got.offset != (bfd_vma) -1)
+    {
+      asection *sgot;
+      asection *srela;
+      Elf_Internal_Rela rela;
+
+      /* This symbol has an entry in the global offset table.  Set it
+         up.  */
+
+      sgot = bfd_get_section_by_name (dynobj, ".got");
+      srela = bfd_get_section_by_name (dynobj, ".rela.got");
+      BFD_ASSERT (sgot != NULL && srela != NULL);
+
+      rela.r_offset = (sgot->output_section->vma
+		       + sgot->output_offset
+		       + (h->got.offset &~ (bfd_vma) 1));
+
+      /* If this is a -Bsymbolic link, and the symbol is defined
+	 locally, we just want to emit a RELATIVE reloc.  The entry in
+	 the global offset table will already have been initialized in
+	 the relocate_section function.  */
+      if (info->shared
+	  && SYMBOL_REFERENCES_LOCAL (info, h))
+	{
+	  rela.r_info = ELF32_R_INFO (0, R_PPC_RELATIVE);
+	  rela.r_addend = (h->root.u.def.value
+			   + h->root.u.def.section->output_section->vma
+			   + h->root.u.def.section->output_offset);
+	}
+      else
+	{
+	  BFD_ASSERT ((h->got.offset & 1) == 0);
+	  rela.r_info = ELF32_R_INFO (h->dynindx, R_PPC_GLOB_DAT);
+	  rela.r_addend = 0;
+	}
+
+      bfd_put_32 (output_bfd, (bfd_vma) 0, sgot->contents + h->got.offset);
+      bfd_elf32_swap_reloca_out (output_bfd, &rela,
+				 ((Elf32_External_Rela *) srela->contents
+				  + srela->reloc_count));
+      ++srela->reloc_count;
+    }
+
+  if ((h->elf_link_hash_flags & ELF_LINK_HASH_NEEDS_COPY) != 0)
+    {
+      asection *s;
+      Elf_Internal_Rela rela;
+
+      /* This symbols needs a copy reloc.  Set it up.  */
+
+#ifdef DEBUG
+      fprintf (stderr, ", copy");
+#endif
+
+      BFD_ASSERT (h->dynindx != -1);
+
+      if (h->size <= elf_gp_size (dynobj))
+	s = bfd_get_section_by_name (h->root.u.def.section->owner,
+				     ".rela.sbss");
+      else
+	s = bfd_get_section_by_name (h->root.u.def.section->owner,
+				     ".rela.bss");
+      BFD_ASSERT (s != NULL);
+
+      rela.r_offset = (h->root.u.def.value
+		       + h->root.u.def.section->output_section->vma
+		       + h->root.u.def.section->output_offset);
+      rela.r_info = ELF32_R_INFO (h->dynindx, R_PPC_COPY);
+      rela.r_addend = 0;
+      bfd_elf32_swap_reloca_out (output_bfd, &rela,
+				 ((Elf32_External_Rela *) s->contents
+				  + s->reloc_count));
+      ++s->reloc_count;
+    }
+
+#ifdef DEBUG
+  fprintf (stderr, "\n");
+#endif
+
+  /* Mark some specially defined symbols as absolute.  */
+  if (strcmp (h->root.root.string, "_DYNAMIC") == 0
+      || strcmp (h->root.root.string, "_GLOBAL_OFFSET_TABLE_") == 0
+      || strcmp (h->root.root.string, "_PROCEDURE_LINKAGE_TABLE_") == 0)
+    sym->st_shndx = SHN_ABS;
+
+  return true;
+}
+
+/* Finish up the dynamic sections.  */
+
+static boolean
+ppc_elf_finish_dynamic_sections (output_bfd, info)
+     bfd *output_bfd;
+     struct bfd_link_info *info;
+{
+  asection *sdyn;
+  bfd *dynobj = elf_hash_table (info)->dynobj;
+  asection *sgot = bfd_get_section_by_name (dynobj, ".got");
+
+#ifdef DEBUG
+  fprintf (stderr, "ppc_elf_finish_dynamic_sections called\n");
+#endif
+
+  sdyn = bfd_get_section_by_name (dynobj, ".dynamic");
+
+  if (elf_hash_table (info)->dynamic_sections_created)
+    {
+      asection *splt;
+      Elf32_External_Dyn *dyncon, *dynconend;
+
+      splt = bfd_get_section_by_name (dynobj, ".plt");
+      BFD_ASSERT (splt != NULL && sdyn != NULL);
+
+      dyncon = (Elf32_External_Dyn *) sdyn->contents;
+      dynconend = (Elf32_External_Dyn *) (sdyn->contents + sdyn->_raw_size);
+      for (; dyncon < dynconend; dyncon++)
+	{
+	  Elf_Internal_Dyn dyn;
+	  const char *name;
+	  boolean size;
+
+	  bfd_elf32_swap_dyn_in (dynobj, dyncon, &dyn);
+
+	  switch (dyn.d_tag)
+	    {
+	    case DT_PLTGOT:   name = ".plt";	  size = false; break;
+	    case DT_PLTRELSZ: name = ".rela.plt"; size = true;  break;
+	    case DT_JMPREL:   name = ".rela.plt"; size = false; break;
+	    default:	      name = NULL;	  size = false; break;
+	    }
+
+	  if (name != NULL)
+	    {
+	      asection *s;
+
+	      s = bfd_get_section_by_name (output_bfd, name);
+	      if (s == NULL)
+		dyn.d_un.d_val = 0;
+	      else
+		{
+		  if (! size)
+		    dyn.d_un.d_ptr = s->vma;
+		  else
+		    {
+		      if (s->_cooked_size != 0)
+			dyn.d_un.d_val = s->_cooked_size;
+		      else
+			dyn.d_un.d_val = s->_raw_size;
+		    }
+		}
+	      bfd_elf32_swap_dyn_out (output_bfd, &dyn, dyncon);
+	    }
+	}
+    }
+
+  /* Add a blrl instruction at _GLOBAL_OFFSET_TABLE_-4 so that a function can
+     easily find the address of the _GLOBAL_OFFSET_TABLE_.  */
+  if (sgot)
+    {
+      unsigned char *contents = sgot->contents;
+      bfd_put_32 (output_bfd, (bfd_vma) 0x4e800021 /* blrl */, contents);
+
+      if (sdyn == NULL)
+	bfd_put_32 (output_bfd, (bfd_vma) 0, contents+4);
+      else
+	bfd_put_32 (output_bfd,
+		    sdyn->output_section->vma + sdyn->output_offset,
+		    contents+4);
+
+      elf_section_data (sgot->output_section)->this_hdr.sh_entsize = 4;
+    }
+
+  return true;
+}
+
+/* The RELOCATE_SECTION function is called by the ELF backend linker
+   to handle the relocations for a section.
+
+   The relocs are always passed as Rela structures; if the section
+   actually uses Rel structures, the r_addend field will always be
+   zero.
+
+   This function is responsible for adjust the section contents as
+   necessary, and (if using Rela relocs and generating a
+   relocateable output file) adjusting the reloc addend as
+   necessary.
+
+   This function does not have to worry about setting the reloc
+   address or the reloc symbol index.
+
+   LOCAL_SYMS is a pointer to the swapped in local symbols.
+
+   LOCAL_SECTIONS is an array giving the section in the input file
+   corresponding to the st_shndx field of each local symbol.
+
+   The global hash table entry for the global symbols can be found
+   via elf_sym_hashes (input_bfd).
+
+   When generating relocateable output, this function must handle
+   STB_LOCAL/STT_SECTION symbols specially.  The output symbol is
+   going to be the section symbol corresponding to the output
+   section, which means that the addend must be adjusted
+   accordingly.  */
+
+static boolean
+ppc_elf_relocate_section (output_bfd, info, input_bfd, input_section,
+			  contents, relocs, local_syms, local_sections)
+     bfd *output_bfd;
+     struct bfd_link_info *info;
+     bfd *input_bfd;
+     asection *input_section;
+     bfd_byte *contents;
+     Elf_Internal_Rela *relocs;
+     Elf_Internal_Sym *local_syms;
+     asection **local_sections;
+{
+  Elf_Internal_Shdr *symtab_hdr		  = &elf_tdata (input_bfd)->symtab_hdr;
+  struct elf_link_hash_entry **sym_hashes = elf_sym_hashes (input_bfd);
+  bfd *dynobj				  = elf_hash_table (info)->dynobj;
+  elf_linker_section_t *sdata		  = (dynobj) ? elf_linker_section (dynobj, LINKER_SECTION_SDATA)  : NULL;
+  elf_linker_section_t *sdata2		  = (dynobj) ? elf_linker_section (dynobj, LINKER_SECTION_SDATA2) : NULL;
+  Elf_Internal_Rela *rel		  = relocs;
+  Elf_Internal_Rela *relend		  = relocs + input_section->reloc_count;
+  asection *sreloc			  = NULL;
+  asection *splt;
+  asection *sgot;
+  bfd_vma *local_got_offsets;
+  boolean ret				  = true;
+  long insn;
+  asection *sdata_sec                     = NULL;
+  asection *sbss_sec                     = NULL;
+
+#ifdef DEBUG
+  fprintf (stderr, "ppc_elf_relocate_section called for %s section %s, %ld relocations%s\n",
+	   bfd_archive_filename (input_bfd),
+	   bfd_section_name(input_bfd, input_section),
+	   (long) input_section->reloc_count,
+	   (info->relocateable) ? " (relocatable)" : "");
+#endif
+
+  if (info->relocateable)
+    return true;
+
+  if (!ppc_elf_howto_table[R_PPC_ADDR32])
+    /* Initialize howto table if needed.  */
+    ppc_elf_howto_init ();
+
+  if (!strcmp(bfd_section_name(output_bfd, input_section), ".sdata") ||
+      !strcmp(bfd_section_name(output_bfd, input_section), ".sbss"))
+  {
+    sdata_sec = bfd_get_section_by_name(output_bfd, ".sdata");
+    if (sdata_sec)
+      sdata_sec = sdata_sec->output_section;
+    sbss_sec = bfd_get_section_by_name(output_bfd, ".sbss");
+    if (sbss_sec)
+      sbss_sec = sbss_sec->output_section;
+  }
+ 
+  local_got_offsets = elf_local_got_offsets (input_bfd);
+
+  splt = sgot = NULL;
+  if (dynobj != NULL)
+    {
+      splt = bfd_get_section_by_name (dynobj, ".plt");
+      sgot = bfd_get_section_by_name (dynobj, ".got");
+    }
+
+  for (; rel < relend; rel++)
+    {
+      enum elf_ppc_reloc_type r_type	= (enum elf_ppc_reloc_type)ELF32_R_TYPE (rel->r_info);
+      bfd_vma offset			= rel->r_offset;
+      bfd_vma addend			= rel->r_addend;
+      bfd_reloc_status_type r		= bfd_reloc_other;
+      Elf_Internal_Sym *sym		= (Elf_Internal_Sym *) 0;
+      asection *sec			= (asection *) 0;
+      struct elf_link_hash_entry *h	= (struct elf_link_hash_entry *) 0;
+      const char *sym_name		= (const char *) 0;
+      boolean copy                      = false;
+      reloc_howto_type *howto;
+      unsigned long r_symndx;
+      bfd_vma relocation;
+      int will_become_local;
+
+      /* Unknown relocation handling */
+      if ((unsigned) r_type >= (unsigned) R_PPC_max
+	  || !ppc_elf_howto_table[(int) r_type])
+	{
+	  (*_bfd_error_handler) (_("%s: unknown relocation type %d"),
+				 bfd_archive_filename (input_bfd),
+				 (int) r_type);
+
+	  bfd_set_error (bfd_error_bad_value);
+	  ret = false;
+	  continue;
+	}
+
+      howto = ppc_elf_howto_table[(int) r_type];
+      r_symndx = ELF32_R_SYM (rel->r_info);
+
+      if (r_symndx < symtab_hdr->sh_info)
+	{
+	  sym = local_syms + r_symndx;
+	  sec = local_sections[r_symndx];
+	  sym_name = "<local symbol>";
+
+	  relocation = _bfd_elf_rela_local_sym (output_bfd, sym, sec, rel);
+	  addend = rel->r_addend;
+	  /* Relocs to local symbols are always resolved.  */
+	  will_become_local = 1;
+	}
+      else
+	{
+	  h = sym_hashes[r_symndx - symtab_hdr->sh_info];
+	  while (h->root.type == bfd_link_hash_indirect
+		 || h->root.type == bfd_link_hash_warning)
+	    h = (struct elf_link_hash_entry *) h->root.u.i.link;
+	  sym_name = h->root.root.string;
+
+	  /* Can this relocation be resolved immediately?  */
+	  will_become_local = SYMBOL_REFERENCES_LOCAL (info, h);
+
+	  if (h->root.type == bfd_link_hash_defined
+	      || h->root.type == bfd_link_hash_defweak)
+	    {
+	      sec = h->root.u.def.section;
+	      if (((r_type == R_PPC_PLT32
+		    || r_type == R_PPC_PLTREL24)
+		   && splt != NULL
+		   && h->plt.offset != (bfd_vma) -1)
+		  || (r_type == R_PPC_LOCAL24PC
+		      && sec->output_section == NULL)
+		  || ((r_type == R_PPC_GOT16
+		       || r_type == R_PPC_GOT16_LO
+		       || r_type == R_PPC_GOT16_HI
+		       || r_type == R_PPC_GOT16_HA)
+		      && elf_hash_table (info)->dynamic_sections_created
+		      && (! info->shared || ! will_become_local))
+		  || (info->shared
+ 		      && ! will_become_local
+		      && ((input_section->flags & SEC_ALLOC) != 0
+			  /* Testing SEC_DEBUGGING here may be wrong.
+                             It's here to avoid a crash when
+                             generating a shared library with DWARF
+                             debugging information.  */
+			  || ((input_section->flags & SEC_DEBUGGING) != 0
+			      && (h->elf_link_hash_flags
+				  & ELF_LINK_HASH_DEF_DYNAMIC) != 0))
+		      && (r_type == R_PPC_ADDR32
+			  || r_type == R_PPC_ADDR24
+			  || r_type == R_PPC_ADDR16
+			  || r_type == R_PPC_ADDR16_LO
+			  || r_type == R_PPC_ADDR16_HI
+			  || r_type == R_PPC_ADDR16_HA
+			  || r_type == R_PPC_ADDR14
+			  || r_type == R_PPC_ADDR14_BRTAKEN
+			  || r_type == R_PPC_ADDR14_BRNTAKEN
+			  || r_type == R_PPC_COPY
+			  || r_type == R_PPC_GLOB_DAT
+			  || r_type == R_PPC_JMP_SLOT
+			  || r_type == R_PPC_UADDR32
+			  || r_type == R_PPC_UADDR16
+			  || r_type == R_PPC_SDAREL16
+			  || r_type == R_PPC_EMB_NADDR32
+			  || r_type == R_PPC_EMB_NADDR16
+			  || r_type == R_PPC_EMB_NADDR16_LO
+			  || r_type == R_PPC_EMB_NADDR16_HI
+			  || r_type == R_PPC_EMB_NADDR16_HA
+			  || r_type == R_PPC_EMB_SDAI16
+			  || r_type == R_PPC_EMB_SDA2I16
+			  || r_type == R_PPC_EMB_SDA2REL
+			  || r_type == R_PPC_EMB_SDA21
+			  || r_type == R_PPC_EMB_MRKREF
+			  || r_type == R_PPC_EMB_BIT_FLD
+			  || r_type == R_PPC_EMB_RELSDA
+			  || ((r_type == R_PPC_REL24
+			       || r_type == R_PPC_REL32
+			       || r_type == R_PPC_REL14
+			       || r_type == R_PPC_REL14_BRTAKEN
+			       || r_type == R_PPC_REL14_BRNTAKEN
+			       || r_type == R_PPC_RELATIVE)
+			      && strcmp (h->root.root.string,
+					 "_GLOBAL_OFFSET_TABLE_") != 0))))
+		{
+		  /* In these cases, we don't need the relocation
+                     value.  We check specially because in some
+                     obscure cases sec->output_section will be NULL.  */
+		  relocation = 0;
+		}
+	      else if (sec->output_section == NULL)
+		{
+                  (*_bfd_error_handler)
+                    (_("%s: warning: unresolvable relocation against symbol `%s' from %s section"),
+                     bfd_archive_filename (input_bfd), h->root.root.string,
+                     bfd_get_section_name (input_bfd, input_section));
+		  relocation = 0;
+		}
+	      else
+		relocation = (h->root.u.def.value
+			      + sec->output_section->vma
+			      + sec->output_offset);
+	    }
+	  else if (h->root.type == bfd_link_hash_undefweak)
+	    relocation = 0;
+	  else if (info->shared
+		   && (!info->symbolic || info->allow_shlib_undefined)
+		   && !info->no_undefined
+		   && ELF_ST_VISIBILITY (h->other) == STV_DEFAULT)
+	    relocation = 0;
+	  else
+	    {
+	      if (! (*info->callbacks->undefined_symbol) (info,
+							 h->root.root.string,
+							 input_bfd,
+							 input_section,
+							 rel->r_offset,
+							 (!info->shared
+							  || info->no_undefined
+							  || ELF_ST_VISIBILITY (h->other))))
+		return false;
+	      relocation = 0;
+	    }
+	}
+
+      switch ((int) r_type)
+	{
+	default:
+	  (*_bfd_error_handler) (_("%s: unknown relocation type %d for symbol %s"),
+				 bfd_archive_filename (input_bfd),
+				 (int) r_type, sym_name);
+
+	  bfd_set_error (bfd_error_bad_value);
+	  ret = false;
+	  continue;
+
+	case (int) R_PPC_NONE:
+	  continue;
+
+	/* Relocations that need no special processing.  */
+	case (int) R_PPC_LOCAL24PC:
+	  /* It makes no sense to point a local relocation
+	     at a symbol not in this object.  */
+	  if (h != NULL
+	      && (h->root.type == bfd_link_hash_defined
+		  || h->root.type == bfd_link_hash_defweak)
+	      && sec->output_section == NULL)
+	    {
+	      if (! (*info->callbacks->undefined_symbol) (info,
+							  h->root.root.string,
+							  input_bfd,
+							  input_section,
+							  rel->r_offset,
+							  true))
+		return false;
+	      continue;
+	    }
+	  break;
+
+	/* Relocations that may need to be propagated if this is a shared
+           object.  */
+	case (int) R_PPC_REL24:
+	case (int) R_PPC_REL32:
+	case (int) R_PPC_REL14:
+	  /* If these relocations are not to a named symbol, they can be
+	     handled right here, no need to bother the dynamic linker.  */
+	  if (info->shared && (h == NULL
+	      || strcmp (h->root.root.string, "_GLOBAL_OFFSET_TABLE_") == 0
+              || SYMBOL_REFERENCES_LOCAL (info, h)))
+	    break;
+	/* fall through */
+
+	/* Relocations that always need to be propagated if this is a shared
+           object.  */
+	case (int) R_PPC_ADDR32:
+	case (int) R_PPC_ADDR24:
+	case (int) R_PPC_ADDR16:
+	case (int) R_PPC_ADDR16_LO:
+	case (int) R_PPC_ADDR16_HI:
+	case (int) R_PPC_ADDR16_HA:
+	case (int) R_PPC_ADDR14:
+	case (int) R_PPC_UADDR32:
+	case (int) R_PPC_UADDR16:
+	  if (info->shared && r_symndx != 0)
+	    {
+	      Elf_Internal_Rela outrel;
+	      int skip;
+
+#ifdef DEBUG
+	      fprintf (stderr, "ppc_elf_relocate_section need to create relocation for %s\n",
+		       (h && h->root.root.string) ? h->root.root.string : "<unknown>");
+#endif
+
+	      /* When generating a shared object, these relocations
+                 are copied into the output file to be resolved at run
+                 time.  */
+
+	      if (sreloc == NULL)
+		{
+		  const char *name;
+
+		  name = (bfd_elf_string_from_elf_section
+			  (input_bfd,
+			   elf_elfheader (input_bfd)->e_shstrndx,
+			   elf_section_data (input_section)->rel_hdr.sh_name));
+		  if (name == NULL)
+		    return false;
+
+		  BFD_ASSERT (strncmp (name, ".rela", 5) == 0
+			      && strcmp (bfd_get_section_name (input_bfd,
+							       input_section),
+					 name + 5) == 0);
+
+		  sreloc = bfd_get_section_by_name (dynobj, name);
+		  BFD_ASSERT (sreloc != NULL);
+		}
+
+	      skip = 0;
+
+	      outrel.r_offset =
+		_bfd_elf_section_offset (output_bfd, info, input_section,
+					 rel->r_offset);
+	      if (outrel.r_offset == (bfd_vma) -1
+		  || outrel.r_offset == (bfd_vma) -2)
+		skip = (int) outrel.r_offset;
+	      outrel.r_offset += (input_section->output_section->vma
+				  + input_section->output_offset);
+
+	      if (skip)
+		memset (&outrel, 0, sizeof outrel);
+	      /* h->dynindx may be -1 if this symbol was marked to
+                 become local.  */
+	      else if (! will_become_local)
+		{
+		  outrel.r_info = ELF32_R_INFO (h->dynindx, r_type);
+		  outrel.r_addend = rel->r_addend;
+		}
+	      else
+		{
+		  if (r_type == R_PPC_ADDR32)
+		    {
+		      outrel.r_info = ELF32_R_INFO (0, R_PPC_RELATIVE);
+		      outrel.r_addend = relocation + rel->r_addend;
+		    }
+		  else
+		    {
+		      long indx;
+
+		      if (h == NULL)
+			sec = local_sections[r_symndx];
+		      else
+			{
+			  BFD_ASSERT (h->root.type == bfd_link_hash_defined
+				      || (h->root.type
+					  == bfd_link_hash_defweak));
+			  sec = h->root.u.def.section;
+			}
+		      if (sec != NULL && bfd_is_abs_section (sec))
+			indx = 0;
+		      else if (sec == NULL || sec->owner == NULL)
+			{
+			  bfd_set_error (bfd_error_bad_value);
+			  return false;
+			}
+		      else
+			{
+			  asection *osec;
+
+			  osec = sec->output_section;
+			  indx = elf_section_data (osec)->dynindx;
+			  BFD_ASSERT (indx > 0);
+#ifdef DEBUG
+			  if (indx <= 0)
+			    {
+			      printf ("indx=%d section=%s flags=%08x name=%s\n",
+				     indx, osec->name, osec->flags,
+				     h->root.root.string);
+			    }
+#endif
+			}
+
+		      outrel.r_info = ELF32_R_INFO (indx, r_type);
+		      outrel.r_addend = relocation + rel->r_addend;
+		    }
+		}
+
+	      bfd_elf32_swap_reloca_out (output_bfd, &outrel,
+					 (((Elf32_External_Rela *)
+					   sreloc->contents)
+					  + sreloc->reloc_count));
+	      ++sreloc->reloc_count;
+
+	      if (skip == -1)
+		continue;
+
+	      /* This reloc will be computed at runtime.  We clear the memory
+		 so that it contains predictable value.  */
+	      if (! skip
+		  && ((input_section->flags & SEC_ALLOC) != 0
+		      || ELF32_R_TYPE (outrel.r_info) != R_PPC_RELATIVE))
+		{
+		  relocation = howto->pc_relative ? outrel.r_offset : 0;
+		  addend = 0;
+		  break;
+		}
+	    }
+	  else if (r_type == R_PPC_REL24 || r_type == R_PPC_REL14)
+	    {
+	      if (sec->output_section != input_section->output_section)
+		{
+		  (*_bfd_error_handler) ("%s: The target (%s) of a %s relocation is in the wrong section (%s)",
+					 bfd_get_filename (input_bfd),
+					 sym_name,
+					 ppc_elf_howto_table[ (int)r_type ]->name,
+					 bfd_get_section_name (abfd, sec));
+		  bfd_set_error (bfd_error_bad_value);
+		  ret = false;
+		  continue;	 
+		}
+	      break;
+	    }
+	  else if (r_type == R_PPC_REL32)
+	    {
+	      if (sec->output_section != input_section->output_section)
+		copy = true;
+	      else
+		break;
+	    }
+	  else if (ddr_ptr && sec && r_type == R_PPC_ADDR32 && 
+		   (sec->output_section == sdata_sec ||
+		    sec->output_section == sbss_sec ||
+		    !strcmp(bfd_get_section_name(abfd, sec), "COMMON") ||
+		    !strcmp(bfd_get_section_name(abfd, sec), ".data") ||
+		    !strcmp(bfd_get_section_name(abfd, sec), ".bss")) &&
+		   (input_section->output_section == sdata_sec ||
+		    input_section->output_section == sbss_sec ||
+		    !strcmp(bfd_get_section_name(abfd, input_section), "COMMON") ||
+		    !strcmp(bfd_get_section_name(abfd, input_section), ".data") ||
+		    !strcmp(bfd_get_section_name(abfd, input_section), ".bss")))
+	    {
+	      ++ddr_count;
+	      *ddr_ptr++ = input_section->output_offset + offset;
+	      copy = true;
+	      break;
+	    }
+	  else if (sec && !bfd_is_abs_section(sec))
+	    {
+	      copy = true;
+	      break;
+	    }
+
+	  if (copy && ddr_ptr && sec &&
+	      (sec->output_section == sdata_sec ||
+	       sec->output_section == sbss_sec ||
+	       !strcmp(bfd_get_section_name(abfd, sec), "COMMON") ||
+	       !strcmp(bfd_get_section_name(abfd, sec), ".data") ||
+	       !strcmp(bfd_get_section_name(abfd, sec), ".bss")) /*&&
+	      (r_type != R_PPC_ADDR32 ||
+	       !(input_section->output_section == sdata_sec->output_section ||
+		 input_section->output_section == sbss_sec->output_section ||
+		 !strcmp(bfd_get_section_name(abfd, input_section), "COMMON") ||
+		 !strcmp(bfd_get_section_name(abfd, input_section), ".data") ||
+		 !strcmp(bfd_get_section_name(abfd, input_section), ".bss")))*/)
+	    {
+	      (*_bfd_error_handler) ("%s: The target (%s) of a %s relocation is in the wrong section (%s)",
+				     bfd_get_filename (input_bfd),
+				     sym_name,
+				     ppc_elf_howto_table[ (int)r_type ]->name,
+				     bfd_get_section_name (abfd, sec));
+	      bfd_set_error (bfd_error_bad_value);
+	      ret = false;
+	      continue;	    
+	    }
+
+	  /* Arithmetic adjust relocations that aren't going into a
+	     shared object.  */
+	  if (r_type == R_PPC_ADDR16_HA
+	      /* It's just possible that this symbol is a weak symbol
+		 that's not actually defined anywhere. In that case,
+		 'sec' would be NULL, and we should leave the symbol
+		 alone (it will be set to zero elsewhere in the link).  */
+	      && sec != NULL)
+	    {
+	      addend += ((relocation + addend) & 0x8000) << 1;
+	    }
+	  break;
+
+	/* branch taken prediction relocations */
+	case (int) R_PPC_ADDR14_BRTAKEN:
+	case (int) R_PPC_REL14_BRTAKEN:
+	  insn = bfd_get_32 (output_bfd, contents + offset);
+	  if ((relocation - offset) & 0x8000)
+	    insn &= ~BRANCH_PREDICT_BIT;
+	  else
+	    insn |= BRANCH_PREDICT_BIT;
+	  bfd_put_32 (output_bfd, (bfd_vma) insn, contents + offset);
+	  break;
+
+	/* branch not taken predicition relocations */
+	case (int) R_PPC_ADDR14_BRNTAKEN:
+	case (int) R_PPC_REL14_BRNTAKEN:
+	  insn = bfd_get_32 (output_bfd, contents + offset);
+	  if ((relocation - offset) & 0x8000)
+	    insn |= BRANCH_PREDICT_BIT;
+	  else
+	    insn &= ~BRANCH_PREDICT_BIT;
+	  bfd_put_32 (output_bfd, (bfd_vma) insn, contents + offset);
+	  break;
+
+	/* GOT16 relocations */
+	case (int) R_PPC_GOT16:
+	case (int) R_PPC_GOT16_LO:
+	case (int) R_PPC_GOT16_HI:
+	case (int) R_PPC_GOT16_HA:
+	  /* Relocation is to the entry for this symbol in the global
+             offset table.  */
+	  BFD_ASSERT (sgot != NULL);
+
+	  if (h != NULL)
+	    {
+	      bfd_vma off;
+
+	      off = h->got.offset;
+	      BFD_ASSERT (off != (bfd_vma) -1);
+
+	      if (! elf_hash_table (info)->dynamic_sections_created
+		  || (info->shared
+		      && SYMBOL_REFERENCES_LOCAL (info, h)))
+		{
+		  /* This is actually a static link, or it is a
+                     -Bsymbolic link and the symbol is defined
+                     locally.  We must initialize this entry in the
+                     global offset table.  Since the offset must
+                     always be a multiple of 4, we use the least
+                     significant bit to record whether we have
+                     initialized it already.
+
+		     When doing a dynamic link, we create a .rela.got
+		     relocation entry to initialize the value.  This
+		     is done in the finish_dynamic_symbol routine.  */
+		  if ((off & 1) != 0)
+		    off &= ~1;
+		  else
+		    {
+		      bfd_put_32 (output_bfd, relocation,
+				  sgot->contents + off);
+		      h->got.offset |= 1;
+		    }
+		}
+
+	      relocation = sgot->output_offset + off - 4;
+	    }
+	  else
+	    {
+	      bfd_vma off;
+
+	      BFD_ASSERT (local_got_offsets != NULL
+			  && local_got_offsets[r_symndx] != (bfd_vma) -1);
+
+	      off = local_got_offsets[r_symndx];
+
+	      /* The offset must always be a multiple of 4.  We use
+		 the least significant bit to record whether we have
+		 already processed this entry.  */
+	      if ((off & 1) != 0)
+		off &= ~1;
+	      else
+		{
+
+		  if (info->shared)
+		    {
+		      asection *srelgot;
+		      Elf_Internal_Rela outrel;
+
+		      /* We need to generate a R_PPC_RELATIVE reloc
+			 for the dynamic linker.  */
+		      srelgot = bfd_get_section_by_name (dynobj, ".rela.got");
+		      BFD_ASSERT (srelgot != NULL);
+
+		      outrel.r_offset = (sgot->output_section->vma
+					 + sgot->output_offset
+					 + off);
+		      outrel.r_info = ELF32_R_INFO (0, R_PPC_RELATIVE);
+		      outrel.r_addend = relocation;
+		      bfd_elf32_swap_reloca_out (output_bfd, &outrel,
+						 (((Elf32_External_Rela *)
+						   srelgot->contents)
+						  + srelgot->reloc_count));
+		      ++srelgot->reloc_count;
+		      relocation = 0;
+		    }
+
+		  bfd_put_32 (output_bfd, relocation, sgot->contents + off);
+		  local_got_offsets[r_symndx] |= 1;
+		}
+
+	      relocation = sgot->output_offset + off - 4;
+	    }
+	  break;
+
+	/* Indirect .sdata relocation */
+	case (int) R_PPC_EMB_SDAI16:
+	  BFD_ASSERT (sdata != NULL);
+	  relocation = bfd_elf32_finish_pointer_linker_section (output_bfd, input_bfd, info,
+								sdata, h, relocation, rel,
+								R_PPC_RELATIVE);
+	  break;
+
+	/* Indirect .sdata2 relocation */
+	case (int) R_PPC_EMB_SDA2I16:
+	  BFD_ASSERT (sdata2 != NULL);
+	  relocation = bfd_elf32_finish_pointer_linker_section (output_bfd, input_bfd, info,
+								sdata2, h, relocation, rel,
+								R_PPC_RELATIVE);
+	  break;
+
+	/* Handle the TOC16 reloc.  We want to use the offset within the .got
+	   section, not the actual VMA.  This is appropriate when generating
+	   an embedded ELF object, for which the .got section acts like the
+	   AIX .toc section.  */
+	case (int) R_PPC_TOC16:			/* phony GOT16 relocations */
+	  BFD_ASSERT (sec != (asection *) 0);
+	  BFD_ASSERT (bfd_is_und_section (sec)
+		      || strcmp (bfd_get_section_name (abfd, sec), ".got") == 0
+		      || strcmp (bfd_get_section_name (abfd, sec), ".cgot") == 0)
+
+	  addend -= sec->output_section->vma + sec->output_offset + 0x8000;
+	  break;
+
+	case (int) R_PPC_PLTREL24:
+	  /* Relocation is to the entry for this symbol in the
+             procedure linkage table.  */
+	  BFD_ASSERT (h != NULL);
+
+	  if (h->plt.offset == (bfd_vma) -1
+	      || splt == NULL)
+	    {
+	      /* We didn't make a PLT entry for this symbol.  This
+                 happens when statically linking PIC code, or when
+                 using -Bsymbolic.  */
+	      break;
+	    }
+
+	  relocation = (splt->output_section->vma
+			+ splt->output_offset
+			+ h->plt.offset);
+	  break;
+
+	/* relocate against _SDA_BASE_ */
+	case (int) R_PPC_SDAREL16:
+	  {
+	    const char *name;
+
+	    BFD_ASSERT (sec != (asection *) 0);
+	    name = bfd_get_section_name (abfd, sec->output_section);
+	    if (strcmp (name, ".sdata") != 0
+		&& strcmp (name, ".sbss") != 0)
+	      {
+		(*_bfd_error_handler) (_("%s: The target (%s) of a %s relocation is in the wrong output section (%s)"),
+				       bfd_archive_filename (input_bfd),
+				       sym_name,
+				       ppc_elf_howto_table[(int) r_type]->name,
+				       name);
+	      }
+	    addend -= (sdata->sym_hash->root.u.def.value
+		       + sdata->sym_hash->root.u.def.section->output_section->vma
+		       /*+ sdata->sym_hash->root.u.def.section->output_offset*/);
+	  }
+	  break;
+
+	/* relocate against _SDA_BASE_, in large data mode */
+	case (int)R_PPC_MORPHOS_DREL:
+	case (int)R_PPC_MORPHOS_DREL_LO:
+	case (int)R_PPC_MORPHOS_DREL_HI:
+	case (int)R_PPC_MORPHOS_DREL_HA:
+	  BFD_ASSERT (sec != (asection *)0);
+	  if (strcmp (bfd_get_section_name (abfd, sec), ".sdata") != 0
+	      && strcmp (bfd_get_section_name (abfd, sec), ".data") != 0
+	      && strcmp (bfd_get_section_name (abfd, sec), ".bss") != 0
+	      && strcmp (bfd_get_section_name (abfd, sec), ".sbss") != 0
+	      && strcmp (bfd_get_section_name (abfd, sec), "COMMON") != 0)
+	    {
+	      (*_bfd_error_handler) ("%s: The target (%s) of a %s relocation is in the wrong section (%s)",
+				     bfd_get_filename (input_bfd),
+				     sym_name,
+				     ppc_elf_howto_table[ (int)r_type ]->name,
+				     bfd_get_section_name (abfd, sec));
+
+	      bfd_set_error (bfd_error_bad_value);
+	      ret = false;
+	      continue;
+	    }
+	  /*printf("DREL: addend = %x, sdata->val = %x, vma = %x, output_offset = %x\n",
+		 addend, sdata->sym_hash->root.u.def.value,
+		 sdata->sym_hash->root.u.def.section->output_section->vma,
+		 sdata->sym_hash->root.u.def.section->output_offset);*/
+	  addend -= (sdata->sym_hash->root.u.def.value
+		     + sdata->sym_hash->root.u.def.section->output_section->vma
+		     /*+ sdata->sym_hash->root.u.def.section->output_offset*/);
+	  if (r_type == R_PPC_MORPHOS_DREL_HA)
+	    addend += ((relocation + addend) & 0x8000) << 1;
+	  break;
+	  
+	/* relocate against _SDA2_BASE_ */
+	case (int) R_PPC_EMB_SDA2REL:
+	  {
+	    const char *name;
+
+	    BFD_ASSERT (sec != (asection *) 0);
+	    name = bfd_get_section_name (abfd, sec->output_section);
+	    if (strcmp (name, ".sdata2") != 0 && strcmp (name, ".sbss2") != 0)
+	      {
+		(*_bfd_error_handler) (_("%s: The target (%s) of a %s relocation is in the wrong output section (%s)"),
+				       bfd_archive_filename (input_bfd),
+				       sym_name,
+				       ppc_elf_howto_table[(int) r_type]->name,
+				       name);
+
+		bfd_set_error (bfd_error_bad_value);
+		ret = false;
+		continue;
+	      }
+	    addend -= (sdata2->sym_hash->root.u.def.value
+		       + sdata2->sym_hash->root.u.def.section->output_section->vma
+		       + sdata2->sym_hash->root.u.def.section->output_offset);
+	  }
+	  break;
+
+	/* relocate against either _SDA_BASE_, _SDA2_BASE_, or 0 */
+	case (int) R_PPC_EMB_SDA21:
+	case (int) R_PPC_EMB_RELSDA:
+	  {
+	    const char *name;
+	    int reg;
+
+	    BFD_ASSERT (sec != (asection *) 0);
+	    name = bfd_get_section_name (abfd, sec->output_section);
+	    if (strcmp (name, ".sdata") == 0 || strcmp (name, ".sbss") == 0)
+	      {
+		reg = 13;
+		addend -= (sdata->sym_hash->root.u.def.value
+			   + sdata->sym_hash->root.u.def.section->output_section->vma
+			   + sdata->sym_hash->root.u.def.section->output_offset);
+	      }
+
+	    else if (strcmp (name, ".sdata2") == 0
+		     || strcmp (name, ".sbss2") == 0)
+	      {
+		reg = 2;
+		addend -= (sdata2->sym_hash->root.u.def.value
+			   + sdata2->sym_hash->root.u.def.section->output_section->vma
+			   + sdata2->sym_hash->root.u.def.section->output_offset);
+	      }
+
+	    else if (strcmp (name, ".PPC.EMB.sdata0") == 0
+		     || strcmp (name, ".PPC.EMB.sbss0") == 0)
+	      {
+		reg = 0;
+	      }
+
+	    else
+	      {
+		(*_bfd_error_handler) (_("%s: The target (%s) of a %s relocation is in the wrong output section (%s)"),
+				       bfd_archive_filename (input_bfd),
+				       sym_name,
+				       ppc_elf_howto_table[(int) r_type]->name,
+				       name);
+
+		bfd_set_error (bfd_error_bad_value);
+		ret = false;
+		continue;
+	      }
+
+	    if (r_type == R_PPC_EMB_SDA21)
+	      {			/* fill in register field */
+		insn = bfd_get_32 (output_bfd, contents + offset);
+		insn = (insn & ~RA_REGISTER_MASK) | (reg << RA_REGISTER_SHIFT);
+		bfd_put_32 (output_bfd, (bfd_vma) insn, contents + offset);
+	      }
+	  }
+	  break;
+
+	/* Relocate against the beginning of the section */
+	case (int) R_PPC_SECTOFF:
+	case (int) R_PPC_SECTOFF_LO:
+	case (int) R_PPC_SECTOFF_HI:
+	  BFD_ASSERT (sec != (asection *) 0);
+	  addend -= sec->output_section->vma;
+	  break;
+
+	case (int) R_PPC_SECTOFF_HA:
+	  BFD_ASSERT (sec != (asection *) 0);
+	  addend -= sec->output_section->vma;
+	  addend += ((relocation + addend) & 0x8000) << 1;
+	  break;
+
+	/* Negative relocations */
+	case (int) R_PPC_EMB_NADDR32:
+	case (int) R_PPC_EMB_NADDR16:
+	case (int) R_PPC_EMB_NADDR16_LO:
+	case (int) R_PPC_EMB_NADDR16_HI:
+	  addend -= 2 * relocation;
+	  break;
+
+	case (int) R_PPC_EMB_NADDR16_HA:
+	  addend -= 2 * relocation;
+	  addend += ((relocation + addend) & 0x8000) << 1;
+	  break;
+
+	/* NOP relocation that prevents garbage collecting linkers from omitting a
+	   reference.  */
+	case (int) R_PPC_EMB_MRKREF:
+	  continue;
+
+	case (int) R_PPC_COPY:
+	case (int) R_PPC_GLOB_DAT:
+	case (int) R_PPC_JMP_SLOT:
+	case (int) R_PPC_RELATIVE:
+	case (int) R_PPC_PLT32:
+	case (int) R_PPC_PLTREL32:
+	case (int) R_PPC_PLT16_LO:
+	case (int) R_PPC_PLT16_HI:
+	case (int) R_PPC_PLT16_HA:
+	case (int) R_PPC_EMB_RELSEC16:
+	case (int) R_PPC_EMB_RELST_LO:
+	case (int) R_PPC_EMB_RELST_HI:
+	case (int) R_PPC_EMB_RELST_HA:
+	case (int) R_PPC_EMB_BIT_FLD:
+	  (*_bfd_error_handler) (_("%s: Relocation %s is not yet supported for symbol %s."),
+				 bfd_archive_filename (input_bfd),
+				 ppc_elf_howto_table[(int) r_type]->name,
+				 sym_name);
+
+	  bfd_set_error (bfd_error_invalid_operation);
+	  ret = false;
+	  continue;
+
+	case (int) R_PPC_GNU_VTINHERIT:
+	case (int) R_PPC_GNU_VTENTRY:
+	  /* These are no-ops in the end.  */
+	  continue;
+	}
+
+#ifdef DEBUG
+      fprintf (stderr, "\ttype = %s (%d), name = %s, symbol index = %ld, offset = %ld, addend = %ld\n",
+	       howto->name,
+	       (int) r_type,
+	       sym_name,
+	       r_symndx,
+	       (long) offset,
+	       (long) addend);
+#endif
+      if (copy) 
+	{
+	  Elf_Internal_Rela outrel;
+
+	  if (sec == NULL) /* Don't know if it is possible... */ 
+	    abort(); 
+
+	  /*printf("copying reloc %d, addend=%x, rel=%x, indx=%d, offset=%x, sec_vma=%x\n",
+		 r_type,addend,relocation,sec->output_section->target_index,
+		 sec->output_offset,sec->output_section->vma);*/
+
+	  outrel.r_info = ELF32_R_INFO(sec->output_section->target_index, r_type);
+	  outrel.r_addend = relocation + addend - sec->output_section->vma;
+	  outrel.r_offset = input_section->output_offset + offset;
+
+ 	  bfd_elf32_swap_reloca_out (output_bfd, &outrel,
+				     (((Elf32_External_Rela *)
+				       elf_section_data(input_section->output_section)->
+				       rel_hdr.contents)
+				      + input_section->output_section->reloc_count));
+	  ++input_section->output_section->reloc_count;
+	}
+      else
+	{
+	  /*printf("applying reloc %d, sym=%s addend=%x, rel=%x, indx=%d, offset=%x, sec_vma=%x\n",
+		 r_type,sym_name,addend,relocation,sec->output_section->target_index,
+		 sec->output_offset,sec->output_section->vma);*/
+
+      r = _bfd_final_link_relocate (howto,
+				    input_bfd,
+				    input_section,
+				    contents,
+				    offset,
+				    relocation,
+				    addend);
+
+      if (r == bfd_reloc_ok)
+	;
+      else if (r == bfd_reloc_overflow)
+	{
+	  const char *name;
+
+	  if (h != NULL)
+	    {
+	      if (h->root.type == bfd_link_hash_undefweak
+		  && howto->pc_relative)
+		{
+		  /* Assume this is a call protected by other code that
+		     detect the symbol is undefined.  If this is the case,
+		     we can safely ignore the overflow.  If not, the
+		     program is hosed anyway, and a little warning isn't
+		     going to help.  */
+
+		  continue;
+		}
+
+	      name = h->root.root.string;
+	    }
+	  else
+	    {
+	      name = bfd_elf_string_from_elf_section (input_bfd,
+						      symtab_hdr->sh_link,
+						      sym->st_name);
+	      if (name == NULL)
+		continue;
+	      if (*name == '\0')
+		name = bfd_section_name (input_bfd, sec);
+	    }
+
+	  if (! (*info->callbacks->reloc_overflow) (info,
+						   name,
+						   howto->name,
+						   (bfd_vma) 0,
+						   input_bfd,
+						   input_section,
+						   offset))
+	    return false;
+	}
+      else
+	ret = false;
+    }
+    }
+
+#ifdef DEBUG
+  fprintf (stderr, "\n");
+#endif
+
+  return ret;
+}
+
+static enum elf_reloc_type_class
+ppc_elf_reloc_type_class (rela)
+     const Elf_Internal_Rela *rela;
+{
+  switch ((int) ELF32_R_TYPE (rela->r_info))
+    {
+    case R_PPC_RELATIVE:
+      return reloc_class_relative;
+    case R_PPC_REL24:
+    case R_PPC_ADDR24:
+    case R_PPC_JMP_SLOT:
+      return reloc_class_plt;
+    case R_PPC_COPY:
+      return reloc_class_copy;
+    default:
+      return reloc_class_normal;
+    }
+}
+
+/* Support for core dump NOTE sections */
+static boolean
+ppc_elf_grok_prstatus (abfd, note)
+     bfd *abfd;
+     Elf_Internal_Note *note;
+{
+  int offset;
+  unsigned int raw_size;
+
+  switch (note->descsz)
+    {
+      default:
+	return false;
+
+      case 268:		/* Linux/PPC */
+	/* pr_cursig */
+	elf_tdata (abfd)->core_signal = bfd_get_16 (abfd, note->descdata + 12);
+
+	/* pr_pid */
+	elf_tdata (abfd)->core_pid = bfd_get_32 (abfd, note->descdata + 24);
+
+	/* pr_reg */
+	offset = 72;
+	raw_size = 192;
+
+	break;
+    }
+
+  /* Make a ".reg/999" section.  */
+  return _bfd_elfcore_make_pseudosection (abfd, ".reg",
+					  raw_size, note->descpos + offset);
+}
+
+static boolean
+ppc_elf_grok_psinfo (abfd, note)
+     bfd *abfd;
+     Elf_Internal_Note *note;
+{
+  switch (note->descsz)
+    {
+      default:
+	return false;
+
+      case 128:		/* Linux/PPC elf_prpsinfo */
+	elf_tdata (abfd)->core_program
+	 = _bfd_elfcore_strndup (abfd, note->descdata + 32, 16);
+	elf_tdata (abfd)->core_command
+	 = _bfd_elfcore_strndup (abfd, note->descdata + 48, 80);
+    }
+
+  /* Note that for some reason, a spurious space is tacked
+     onto the end of the args in some (at least one anyway)
+     implementations, so strip it off if it exists.  */
+
+  {
+    char *command = elf_tdata (abfd)->core_command;
+    int n = strlen (command);
+
+    if (0 < n && command[n - 1] == ' ')
+      command[n - 1] = '\0';
+  }
+
+  return true;
+}
+
+/* Special MorphOS final link routine.  */
+/* This is almost the same as the elf one, except for the hanling of relocations */
+
+/* A structure we use to avoid passing large numbers of arguments.  */
+
+struct elf_final_link_info
+{
+  /* General link information.  */
+  struct bfd_link_info *info;
+  /* Output BFD.  */
+  bfd *output_bfd;
+  /* Symbol string table.  */
+  struct bfd_strtab_hash *symstrtab;
+  /* .dynsym section.  */
+  asection *dynsym_sec;
+  /* .hash section.  */
+  asection *hash_sec;
+  /* symbol version section (.gnu.version).  */
+  asection *symver_sec;
+  /* first SHF_TLS section (if any).  */
+  asection *first_tls_sec;
+  /* Buffer large enough to hold contents of any section.  */
+  bfd_byte *contents;
+  /* Buffer large enough to hold external relocs of any section.  */
+  PTR external_relocs;
+  /* Buffer large enough to hold internal relocs of any section.  */
+  Elf_Internal_Rela *internal_relocs;
+  /* Buffer large enough to hold external local symbols of any input
+     BFD.  */
+  Elf_External_Sym *external_syms;
+  /* And a buffer for symbol section indices.  */
+  Elf_External_Sym_Shndx *locsym_shndx;
+  /* Buffer large enough to hold internal local symbols of any input
+     BFD.  */
+  Elf_Internal_Sym *internal_syms;
+  /* Array large enough to hold a symbol index for each local symbol
+     of any input BFD.  */
+  long *indices;
+  /* Array large enough to hold a section pointer for each local
+     symbol of any input BFD.  */
+  asection **sections;
+  /* Buffer to hold swapped out symbols.  */
+  Elf_External_Sym *symbuf;
+  /* And one for symbol section indices.  */
+  Elf_External_Sym_Shndx *symshndxbuf;
+  /* Number of swapped out symbols in buffer.  */
+  size_t symbuf_count;
+  /* Number of symbols which fit in symbuf.  */
+  size_t symbuf_size;
+};
+
+static boolean elf_link_output_sym
+  PARAMS ((struct elf_final_link_info *, const char *,
+	   Elf_Internal_Sym *, asection *));
+static boolean elf_link_flush_output_syms
+  PARAMS ((struct elf_final_link_info *));
+static boolean elf_link_output_extsym
+  PARAMS ((struct elf_link_hash_entry *, PTR));
+static boolean elf_link_sec_merge_syms
+  PARAMS ((struct elf_link_hash_entry *, PTR));
+static boolean elf_link_check_versioned_symbol
+  PARAMS ((struct bfd_link_info *, struct elf_link_hash_entry *));
+static boolean elf_link_input_bfd
+  PARAMS ((struct elf_final_link_info *, bfd *));
+static boolean elf_reloc_link_order
+  PARAMS ((bfd *, struct bfd_link_info *, asection *,
+	   struct bfd_link_order *));
+
+static boolean elf_section_ignore_discarded_relocs
+  PARAMS ((asection *));
+
+/* This struct is used to pass information to elf_link_output_extsym.  */
+
+struct elf_outext_info
+{
+  boolean failed;
+  boolean localsyms;
+  struct elf_final_link_info *finfo;
+};
+
+/* Compute the size of, and allocate space for, REL_HDR which is the
+   section header for a section containing relocations for O.  */
+
+static boolean
+elf_link_size_reloc_section (abfd, rel_hdr, o)
+     bfd *abfd;
+     Elf_Internal_Shdr *rel_hdr;
+     asection *o;
+{
+  bfd_size_type reloc_count;
+  bfd_size_type num_rel_hashes;
+
+  /* Figure out how many relocations there will be.  */
+  if (rel_hdr == &elf_section_data (o)->rel_hdr)
+    reloc_count = elf_section_data (o)->rel_count;
+  else
+    reloc_count = elf_section_data (o)->rel_count2;
+
+  num_rel_hashes = o->reloc_count;
+  if (num_rel_hashes < reloc_count)
+    num_rel_hashes = reloc_count;
+
+  /* That allows us to calculate the size of the section.  */
+  rel_hdr->sh_size = rel_hdr->sh_entsize * reloc_count;
+
+  /* The contents field must last into write_object_contents, so we
+     allocate it with bfd_alloc rather than malloc.  Also since we
+     cannot be sure that the contents will actually be filled in,
+     we zero the allocated space.  */
+  rel_hdr->contents = (PTR) bfd_zalloc (abfd, rel_hdr->sh_size);
+  if (rel_hdr->contents == NULL && rel_hdr->sh_size != 0)
+    return false;
+
+  /* We only allocate one set of hash entries, so we only do it the
+     first time we are called.  */
+  if (elf_section_data (o)->rel_hashes == NULL
+      && num_rel_hashes)
+    {
+      struct elf_link_hash_entry **p;
+
+      p = ((struct elf_link_hash_entry **)
+	   bfd_zmalloc (num_rel_hashes
+			* sizeof (struct elf_link_hash_entry *)));
+      if (p == NULL)
+	return false;
+
+      elf_section_data (o)->rel_hashes = p;
+    }
+
+  return true;
+}
+
+/* When performing a relocateable link, the input relocations are
+   preserved.  But, if they reference global symbols, the indices
+   referenced must be updated.  Update all the relocations in
+   REL_HDR (there are COUNT of them), using the data in REL_HASH.  */
+
+static void
+elf_link_adjust_relocs (abfd, rel_hdr, count, rel_hash)
+     bfd *abfd;
+     Elf_Internal_Shdr *rel_hdr;
+     unsigned int count;
+     struct elf_link_hash_entry **rel_hash;
+{
+  unsigned int i;
+  struct elf_backend_data *bed = get_elf_backend_data (abfd);
+  Elf_Internal_Rel *irel;
+  Elf_Internal_Rela *irela;
+  bfd_size_type amt = sizeof (Elf_Internal_Rel) * bed->s->int_rels_per_ext_rel;
+
+  irel = (Elf_Internal_Rel *) bfd_zmalloc (amt);
+  if (irel == NULL)
+    {
+      (*_bfd_error_handler) (_("Error: out of memory"));
+      abort ();
+    }
+
+  amt = sizeof (Elf_Internal_Rela) * bed->s->int_rels_per_ext_rel;
+  irela = (Elf_Internal_Rela *) bfd_zmalloc (amt);
+  if (irela == NULL)
+    {
+      (*_bfd_error_handler) (_("Error: out of memory"));
+      abort ();
+    }
+
+  for (i = 0; i < count; i++, rel_hash++)
+    {
+      if (*rel_hash == NULL)
+	continue;
+
+      BFD_ASSERT ((*rel_hash)->indx >= 0);
+
+      if (rel_hdr->sh_entsize == sizeof (Elf_External_Rel))
+	{
+	  Elf_External_Rel *erel;
+	  unsigned int j;
+
+	  erel = (Elf_External_Rel *) rel_hdr->contents + i;
+	  if (bed->s->swap_reloc_in)
+	    (*bed->s->swap_reloc_in) (abfd, (bfd_byte *) erel, irel);
+	  else
+	    elf_swap_reloc_in (abfd, erel, irel);
+
+	  for (j = 0; j < bed->s->int_rels_per_ext_rel; j++)
+	    irel[j].r_info = ELF_R_INFO ((*rel_hash)->indx,
+					 ELF_R_TYPE (irel[j].r_info));
+
+	  if (bed->s->swap_reloc_out)
+	    (*bed->s->swap_reloc_out) (abfd, irel, (bfd_byte *) erel);
+	  else
+	    elf_swap_reloc_out (abfd, irel, erel);
+	}
+      else
+	{
+	  Elf_External_Rela *erela;
+	  unsigned int j;
+
+	  BFD_ASSERT (rel_hdr->sh_entsize
+		      == sizeof (Elf_External_Rela));
+
+	  erela = (Elf_External_Rela *) rel_hdr->contents + i;
+	  if (bed->s->swap_reloca_in)
+	    (*bed->s->swap_reloca_in) (abfd, (bfd_byte *) erela, irela);
+	  else
+	    elf_swap_reloca_in (abfd, erela, irela);
+
+	  for (j = 0; j < bed->s->int_rels_per_ext_rel; j++)
+	    irela[j].r_info = ELF_R_INFO ((*rel_hash)->indx,
+					  ELF_R_TYPE (irela[j].r_info));
+
+	  if (bed->s->swap_reloca_out)
+	    (*bed->s->swap_reloca_out) (abfd, irela, (bfd_byte *) erela);
+	  else
+	    elf_swap_reloca_out (abfd, irela, erela);
+	}
+    }
+
+  free (irel);
+  free (irela);
+}
+
+struct elf_link_sort_rela
+{
+  bfd_vma offset;
+  enum elf_reloc_type_class type;
+  union
+  {
+    Elf_Internal_Rel rel;
+    Elf_Internal_Rela rela;
+  } u;
+};
+
+static int
+elf_link_sort_cmp1 (A, B)
+     const PTR A;
+     const PTR B;
+{
+  struct elf_link_sort_rela *a = (struct elf_link_sort_rela *) A;
+  struct elf_link_sort_rela *b = (struct elf_link_sort_rela *) B;
+  int relativea, relativeb;
+
+  relativea = a->type == reloc_class_relative;
+  relativeb = b->type == reloc_class_relative;
+
+  if (relativea < relativeb)
+    return 1;
+  if (relativea > relativeb)
+    return -1;
+  if (ELF_R_SYM (a->u.rel.r_info) < ELF_R_SYM (b->u.rel.r_info))
+    return -1;
+  if (ELF_R_SYM (a->u.rel.r_info) > ELF_R_SYM (b->u.rel.r_info))
+    return 1;
+  if (a->u.rel.r_offset < b->u.rel.r_offset)
+    return -1;
+  if (a->u.rel.r_offset > b->u.rel.r_offset)
+    return 1;
+  return 0;
+}
+
+static int
+elf_link_sort_cmp2 (A, B)
+     const PTR A;
+     const PTR B;
+{
+  struct elf_link_sort_rela *a = (struct elf_link_sort_rela *) A;
+  struct elf_link_sort_rela *b = (struct elf_link_sort_rela *) B;
+  int copya, copyb;
+
+  if (a->offset < b->offset)
+    return -1;
+  if (a->offset > b->offset)
+    return 1;
+  copya = (a->type == reloc_class_copy) * 2 + (a->type == reloc_class_plt);
+  copyb = (b->type == reloc_class_copy) * 2 + (b->type == reloc_class_plt);
+  if (copya < copyb)
+    return -1;
+  if (copya > copyb)
+    return 1;
+  if (a->u.rel.r_offset < b->u.rel.r_offset)
+    return -1;
+  if (a->u.rel.r_offset > b->u.rel.r_offset)
+    return 1;
+  return 0;
+}
+
+static size_t
+elf_link_sort_relocs (abfd, info, psec)
+     bfd *abfd;
+     struct bfd_link_info *info;
+     asection **psec;
+{
+  bfd *dynobj = elf_hash_table (info)->dynobj;
+  asection *reldyn, *o;
+  boolean rel = false;
+  bfd_size_type count, size;
+  size_t i, j, ret;
+  struct elf_link_sort_rela *rela;
+  struct elf_backend_data *bed = get_elf_backend_data (abfd);
+
+  reldyn = bfd_get_section_by_name (abfd, ".rela.dyn");
+  if (reldyn == NULL || reldyn->_raw_size == 0)
+    {
+      reldyn = bfd_get_section_by_name (abfd, ".rel.dyn");
+      if (reldyn == NULL || reldyn->_raw_size == 0)
+	return 0;
+      rel = true;
+      count = reldyn->_raw_size / sizeof (Elf_External_Rel);
+    }
+  else
+    count = reldyn->_raw_size / sizeof (Elf_External_Rela);
+
+  size = 0;
+  for (o = dynobj->sections; o != NULL; o = o->next)
+    if ((o->flags & (SEC_HAS_CONTENTS|SEC_LINKER_CREATED))
+	== (SEC_HAS_CONTENTS|SEC_LINKER_CREATED)
+	&& o->output_section == reldyn)
+      size += o->_raw_size;
+
+  if (size != reldyn->_raw_size)
+    return 0;
+
+  rela = (struct elf_link_sort_rela *) bfd_zmalloc (sizeof (*rela) * count);
+  if (rela == NULL)
+    {
+      (*info->callbacks->warning)
+	(info, _("Not enough memory to sort relocations"), 0, abfd, 0,
+	 (bfd_vma) 0);
+      return 0;
+    }
+
+  for (o = dynobj->sections; o != NULL; o = o->next)
+    if ((o->flags & (SEC_HAS_CONTENTS|SEC_LINKER_CREATED))
+	== (SEC_HAS_CONTENTS|SEC_LINKER_CREATED)
+	&& o->output_section == reldyn)
+      {
+	if (rel)
+	  {
+	    Elf_External_Rel *erel, *erelend;
+	    struct elf_link_sort_rela *s;
+
+	    erel = (Elf_External_Rel *) o->contents;
+	    erelend = (Elf_External_Rel *) (o->contents + o->_raw_size);
+	    s = rela + o->output_offset / sizeof (Elf_External_Rel);
+	    for (; erel < erelend; erel++, s++)
+	      {
+		if (bed->s->swap_reloc_in)
+		  (*bed->s->swap_reloc_in) (abfd, (bfd_byte *) erel, &s->u.rel);
+		else
+		  elf_swap_reloc_in (abfd, erel, &s->u.rel);
+
+		s->type = (*bed->elf_backend_reloc_type_class) (&s->u.rela);
+	      }
+	  }
+	else
+	  {
+	    Elf_External_Rela *erela, *erelaend;
+	    struct elf_link_sort_rela *s;
+
+	    erela = (Elf_External_Rela *) o->contents;
+	    erelaend = (Elf_External_Rela *) (o->contents + o->_raw_size);
+	    s = rela + o->output_offset / sizeof (Elf_External_Rela);
+	    for (; erela < erelaend; erela++, s++)
+	      {
+		if (bed->s->swap_reloca_in)
+		  (*bed->s->swap_reloca_in) (dynobj, (bfd_byte *) erela,
+					     &s->u.rela);
+		else
+		  elf_swap_reloca_in (dynobj, erela, &s->u.rela);
+
+		s->type = (*bed->elf_backend_reloc_type_class) (&s->u.rela);
+	      }
+	  }
+      }
+
+  qsort (rela, (size_t) count, sizeof (*rela), elf_link_sort_cmp1);
+  for (ret = 0; ret < count && rela[ret].type == reloc_class_relative; ret++)
+    ;
+  for (i = ret, j = ret; i < count; i++)
+    {
+      if (ELF_R_SYM (rela[i].u.rel.r_info) != ELF_R_SYM (rela[j].u.rel.r_info))
+	j = i;
+      rela[i].offset = rela[j].u.rel.r_offset;
+    }
+  qsort (rela + ret, (size_t) count - ret, sizeof (*rela), elf_link_sort_cmp2);
+
+  for (o = dynobj->sections; o != NULL; o = o->next)
+    if ((o->flags & (SEC_HAS_CONTENTS|SEC_LINKER_CREATED))
+	== (SEC_HAS_CONTENTS|SEC_LINKER_CREATED)
+	&& o->output_section == reldyn)
+      {
+	if (rel)
+	  {
+	    Elf_External_Rel *erel, *erelend;
+	    struct elf_link_sort_rela *s;
+
+	    erel = (Elf_External_Rel *) o->contents;
+	    erelend = (Elf_External_Rel *) (o->contents + o->_raw_size);
+	    s = rela + o->output_offset / sizeof (Elf_External_Rel);
+	    for (; erel < erelend; erel++, s++)
+	      {
+		if (bed->s->swap_reloc_out)
+		  (*bed->s->swap_reloc_out) (abfd, &s->u.rel,
+					     (bfd_byte *) erel);
+		else
+		  elf_swap_reloc_out (abfd, &s->u.rel, erel);
+	      }
+	  }
+	else
+	  {
+	    Elf_External_Rela *erela, *erelaend;
+	    struct elf_link_sort_rela *s;
+
+	    erela = (Elf_External_Rela *) o->contents;
+	    erelaend = (Elf_External_Rela *) (o->contents + o->_raw_size);
+	    s = rela + o->output_offset / sizeof (Elf_External_Rela);
+	    for (; erela < erelaend; erela++, s++)
+	      {
+		if (bed->s->swap_reloca_out)
+		  (*bed->s->swap_reloca_out) (dynobj, &s->u.rela,
+					      (bfd_byte *) erela);
+		else
+		  elf_swap_reloca_out (dynobj, &s->u.rela, erela);
+	      }
+	  }
+      }
+
+  free (rela);
+  *psec = reldyn;
+  return ret;
+}
+
+/* Do the final step of an ELF link.  */
+
+boolean
+ppc_elf_final_link (abfd, info)
+     bfd *abfd;
+     struct bfd_link_info *info;
+{
+  boolean dynamic;
+  boolean emit_relocs;
+  bfd *dynobj;
+  struct elf_final_link_info finfo;
+  register asection *o;
+  register struct bfd_link_order *p;
+  register bfd *sub;
+  bfd_size_type max_contents_size;
+  bfd_size_type max_external_reloc_size;
+  bfd_size_type max_internal_reloc_count;
+  bfd_size_type max_sym_count;
+  bfd_size_type max_sym_shndx_count;
+  bfd_size_type max_datadata_reloc_count;
+  file_ptr off;
+  Elf_Internal_Sym elfsym;
+  unsigned int i;
+  Elf_Internal_Shdr *symtab_hdr;
+  Elf_Internal_Shdr *symstrtab_hdr;
+  struct elf_backend_data *bed = get_elf_backend_data (abfd);
+  struct elf_outext_info eoinfo;
+  boolean merged;
+  size_t relativecount = 0;
+  asection *reldyn = 0;
+  bfd_size_type amt;
+  asection *ddr_sec;
+  asection *sdata_sec = NULL;
+  asection *sbss_sec = NULL;
+
+  if (! is_elf_hash_table (info))
+    return false;
+
+  if (info->shared)
+    abfd->flags |= DYNAMIC;
+
+  bfd_set_start_address(abfd, 0);
+
+  dynamic = elf_hash_table (info)->dynamic_sections_created;
+  dynobj = elf_hash_table (info)->dynobj;
+
+  emit_relocs = (info->relocateable
+		 || info->emitrelocations
+		 || bed->elf_backend_emit_relocs);
+
+  finfo.info = info;
+  finfo.output_bfd = abfd;
+  finfo.symstrtab = elf_stringtab_init ();
+  if (finfo.symstrtab == NULL)
+    return false;
+
+  if (! dynamic)
+    {
+      finfo.dynsym_sec = NULL;
+      finfo.hash_sec = NULL;
+      finfo.symver_sec = NULL;
+    }
+  else
+    {
+      finfo.dynsym_sec = bfd_get_section_by_name (dynobj, ".dynsym");
+      finfo.hash_sec = bfd_get_section_by_name (dynobj, ".hash");
+      BFD_ASSERT (finfo.dynsym_sec != NULL && finfo.hash_sec != NULL);
+      finfo.symver_sec = bfd_get_section_by_name (dynobj, ".gnu.version");
+      /* Note that it is OK if symver_sec is NULL.  */
+    }
+
+  finfo.contents = NULL;
+  finfo.external_relocs = NULL;
+  finfo.internal_relocs = NULL;
+  finfo.external_syms = NULL;
+  finfo.locsym_shndx = NULL;
+  finfo.internal_syms = NULL;
+  finfo.indices = NULL;
+  finfo.sections = NULL;
+  finfo.symbuf = NULL;
+  finfo.symshndxbuf = NULL;
+  finfo.symbuf_count = 0;
+  finfo.first_tls_sec = NULL;
+  for (o = abfd->sections; o != (asection *) NULL; o = o->next)
+    if ((o->flags & SEC_THREAD_LOCAL) != 0
+	&& (o->flags & SEC_LOAD) != 0)
+      {
+	finfo.first_tls_sec = o;
+	break;
+      }
+
+  ddr_sec = bfd_get_section_by_name(abfd, "ddrelocs");
+  
+  /* Count up the number of relocations we will output for each output
+     section, so that we know the sizes of the reloc sections.  We
+     also figure out some maximum sizes.  */
+  max_contents_size = 0;
+  max_external_reloc_size = 0;
+  max_internal_reloc_count = 0;
+  max_sym_count = 0;
+  max_sym_shndx_count = 0;
+  max_datadata_reloc_count = 0;
+  merged = false;
+  for (o = abfd->sections; o != (asection *) NULL; o = o->next)
+    {
+      o->reloc_count = 0;
+
+      for (p = o->link_order_head; p != NULL; p = p->next)
+	{
+	  if (p->type == bfd_section_reloc_link_order
+	      || p->type == bfd_symbol_reloc_link_order)
+	    ++o->reloc_count;
+	  else if (p->type == bfd_indirect_link_order)
+	    {
+	      asection *sec;
+
+	      sec = p->u.indirect.section;
+
+	      /* Mark all sections which are to be included in the
+		 link.  This will normally be every section.  We need
+		 to do this so that we can identify any sections which
+		 the linker has decided to not include.  */
+	      sec->linker_mark = true;
+
+	      if (sec->flags & SEC_MERGE)
+		merged = true;
+
+	      /* Maximum number of relocations */
+	      if (1 || info->relocateable || info->emitrelocations)
+		o->reloc_count += sec->reloc_count;
+	      else if (bed->elf_backend_count_relocs)
+		{
+		  Elf_Internal_Rela * relocs;
+
+		  relocs = (NAME(_bfd_elf,link_read_relocs)
+			    (abfd, sec, (PTR) NULL,
+			     (Elf_Internal_Rela *) NULL, info->keep_memory));
+
+		  o->reloc_count
+		    += (*bed->elf_backend_count_relocs) (sec, relocs);
+
+		  if (elf_section_data (o)->relocs != relocs)
+		    free (relocs);
+		}
+
+	      if (sec->_raw_size > max_contents_size)
+		max_contents_size = sec->_raw_size;
+	      if (sec->_cooked_size > max_contents_size)
+		max_contents_size = sec->_cooked_size;
+
+	      /* We are interested in just local symbols, not all
+		 symbols.  */
+	      if (bfd_get_flavour (sec->owner) == bfd_target_elf_flavour
+		  && (sec->owner->flags & DYNAMIC) == 0)
+		{
+		  size_t sym_count;
+
+		  if (elf_bad_symtab (sec->owner))
+		    sym_count = (elf_tdata (sec->owner)->symtab_hdr.sh_size
+				 / sizeof (Elf_External_Sym));
+		  else
+		    sym_count = elf_tdata (sec->owner)->symtab_hdr.sh_info;
+
+		  if (sym_count > max_sym_count)
+		    max_sym_count = sym_count;
+
+		  if (sym_count > max_sym_shndx_count
+		      && elf_symtab_shndx (sec->owner) != 0)
+		    max_sym_shndx_count = sym_count;
+
+		  if ((sec->flags & SEC_RELOC) != 0)
+		    {
+		      size_t ext_size;
+
+		      ext_size = elf_section_data (sec)->rel_hdr.sh_size;
+		      if (ext_size > max_external_reloc_size)
+			max_external_reloc_size = ext_size;
+		      if (sec->reloc_count > max_internal_reloc_count)
+			max_internal_reloc_count = sec->reloc_count;
+		    }
+		}
+	    }
+	}
+
+      if (!strcmp(bfd_section_name(abfd, o), ".sdata"))
+	sdata_sec = o;
+      else if(!strcmp(bfd_section_name(abfd, o), ".sbss"))
+	sbss_sec = o;
+      else
+	bfd_set_section_vma(abfd, o, 0);
+
+      if (o->reloc_count > 0)
+        {
+	  o->flags |= SEC_RELOC;
+	  if (o == sdata_sec || o == sbss_sec)
+	    max_datadata_reloc_count += o->reloc_count;
+	}
+      else
+	{
+	  /* Explicitly clear the SEC_RELOC flag.  The linker tends to
+	     set it (this is probably a bug) and if it is set
+	     assign_section_numbers will create a reloc section.  */
+	  o->flags &=~ SEC_RELOC;
+	}
+
+      /* If the SEC_ALLOC flag is not set, force the section VMA to
+	 zero.  This is done in elf_fake_sections as well, but forcing
+	 the VMA to 0 here will ensure that relocs against these
+	 sections are handled correctly.  */
+      if ((o->flags & SEC_ALLOC) == 0
+	  && ! o->user_set_vma)
+	o->vma = 0;
+    }
+
+  if (sdata_sec)
+    {
+      if (sbss_sec)
+	bfd_set_section_vma(abfd, sbss_sec, sbss_sec->vma - sdata_sec->vma);
+      bfd_set_section_vma(abfd, sdata_sec, 0);
+    }
+  
+  if (! info->relocateable && merged)
+    elf_link_hash_traverse (elf_hash_table (info),
+			    elf_link_sec_merge_syms, (PTR) abfd);
+
+  /* Figure out the file positions for everything but the symbol table
+     and the relocs.  We set symcount to force assign_section_numbers
+     to create a symbol table.  */
+  bfd_get_symcount (abfd) = 1;
+  BFD_ASSERT (! abfd->output_has_begun);
+  if (! _bfd_elf_compute_section_file_positions (abfd, info))
+    goto error_return;
+
+  /* Figure out how many relocations we will have in each section.
+     Just using RELOC_COUNT isn't good enough since that doesn't
+     maintain a separate value for REL vs. RELA relocations.  */
+  if (emit_relocs)
+    for (sub = info->input_bfds; sub != NULL; sub = sub->link_next)
+      for (o = sub->sections; o != NULL; o = o->next)
+	{
+	  asection *output_section;
+
+	  if (! o->linker_mark)
+	    {
+	      /* This section was omitted from the link.  */
+	      continue;
+	    }
+
+	  output_section = o->output_section;
+
+	  if (output_section != NULL
+	      && (o->flags & SEC_RELOC) != 0)
+	    {
+	      struct bfd_elf_section_data *esdi
+		= elf_section_data (o);
+	      struct bfd_elf_section_data *esdo
+		= elf_section_data (output_section);
+	      unsigned int *rel_count;
+	      unsigned int *rel_count2;
+	      bfd_size_type entsize;
+	      bfd_size_type entsize2;
+
+	      /* We must be careful to add the relocations from the
+		 input section to the right output count.  */
+	      entsize = esdi->rel_hdr.sh_entsize;
+	      entsize2 = esdi->rel_hdr2 ? esdi->rel_hdr2->sh_entsize : 0;
+	      BFD_ASSERT ((entsize == sizeof (Elf_External_Rel)
+			   || entsize == sizeof (Elf_External_Rela))
+			  && entsize2 != entsize
+			  && (entsize2 == 0
+			      || entsize2 == sizeof (Elf_External_Rel)
+			      || entsize2 == sizeof (Elf_External_Rela)));
+	      if (entsize == esdo->rel_hdr.sh_entsize)
+		{
+		  rel_count = &esdo->rel_count;
+		  rel_count2 = &esdo->rel_count2;
+		}
+	      else
+		{
+		  rel_count = &esdo->rel_count2;
+		  rel_count2 = &esdo->rel_count;
+		}
+
+	      *rel_count += NUM_SHDR_ENTRIES (& esdi->rel_hdr);
+	      if (esdi->rel_hdr2)
+		*rel_count2 += NUM_SHDR_ENTRIES (esdi->rel_hdr2);
+	      output_section->flags |= SEC_RELOC;
+	    }
+	}
+
+  /* That created the reloc sections.  Set their sizes, and assign
+     them file positions, and allocate some buffers.  */
+  for (o = abfd->sections; o != NULL; o = o->next)
+    {
+      if ((o->flags & SEC_RELOC) != 0)
+	{
+	  if (!elf_link_size_reloc_section (abfd,
+					    &elf_section_data (o)->rel_hdr,
+					    o))
+	    goto error_return;
+
+	  if (elf_section_data (o)->rel_hdr2
+	      && !elf_link_size_reloc_section (abfd,
+					       elf_section_data (o)->rel_hdr2,
+					       o))
+	    goto error_return;
+	}
+
+      /* Now, reset REL_COUNT and REL_COUNT2 so that we can use them
+	 to count upwards while actually outputting the relocations.  */
+      elf_section_data (o)->rel_count = 0;
+      elf_section_data (o)->rel_count2 = 0;
+    }
+
+  /* We have now assigned file positions for all the sections except
+     relocations, .symtab, and .strtab.  We start the .symtab section
+     at the current file position, and write directly to it.  We build
+     the .strtab section in memory.  */
+  bfd_get_symcount (abfd) = 0;
+  symtab_hdr = &elf_tdata (abfd)->symtab_hdr;
+  /* sh_name is set in prep_headers.  */
+  symtab_hdr->sh_type = SHT_SYMTAB;
+  symtab_hdr->sh_flags = 0;
+  symtab_hdr->sh_addr = 0;
+  symtab_hdr->sh_size = 0;
+  symtab_hdr->sh_entsize = sizeof (Elf_External_Sym);
+  /* sh_link is set in assign_section_numbers.  */
+  /* sh_info is set below.  */
+  /* sh_offset is set just below.  */
+  symtab_hdr->sh_addralign = bed->s->file_align;
+
+  off = elf_tdata (abfd)->next_file_pos;
+  off = _bfd_elf_assign_file_position_for_section (symtab_hdr, off, true);
+
+  /* Note that at this point elf_tdata (abfd)->next_file_pos is
+     incorrect.  We do not yet know the size of the .symtab section.
+     We correct next_file_pos below, after we do know the size.  */
+
+  /* Allocate a buffer to hold swapped out symbols.  This is to avoid
+     continuously seeking to the right position in the file.  */
+  if (! info->keep_memory || max_sym_count < 20)
+    finfo.symbuf_size = 20;
+  else
+    finfo.symbuf_size = max_sym_count;
+  amt = finfo.symbuf_size;
+  amt *= sizeof (Elf_External_Sym);
+  finfo.symbuf = (Elf_External_Sym *) bfd_malloc (amt);
+  if (finfo.symbuf == NULL)
+    goto error_return;
+  if (elf_numsections (abfd) > SHN_LORESERVE)
+    {
+      amt = finfo.symbuf_size;
+      amt *= sizeof (Elf_External_Sym_Shndx);
+      finfo.symshndxbuf = (Elf_External_Sym_Shndx *) bfd_malloc (amt);
+      if (finfo.symshndxbuf == NULL)
+	goto error_return;
+    }
+
+  /* Start writing out the symbol table.  The first symbol is always a
+     dummy symbol.  */
+  elfsym.st_value = 0;
+  elfsym.st_size = 0;
+  elfsym.st_info = 0;
+  elfsym.st_other = 0;
+  elfsym.st_shndx = SHN_UNDEF;
+  if (! elf_link_output_sym (&finfo, (const char *) NULL,
+			     &elfsym, bfd_und_section_ptr))
+    goto error_return;
+
+#if 0
+  /* Some standard ELF linkers do this, but we don't because it causes
+     bootstrap comparison failures.  */
+  /* Output a file symbol for the output file as the second symbol.
+     We output this even if we are discarding local symbols, although
+     I'm not sure if this is correct.  */
+  elfsym.st_value = 0;
+  elfsym.st_size = 0;
+  elfsym.st_info = ELF_ST_INFO (STB_LOCAL, STT_FILE);
+  elfsym.st_other = 0;
+  elfsym.st_shndx = SHN_ABS;
+  if (! elf_link_output_sym (&finfo, bfd_get_filename (abfd),
+			     &elfsym, bfd_abs_section_ptr))
+    goto error_return;
+#endif
+
+  /* Output a symbol for each section.  We output these even if we are
+     discarding local symbols, since they are used for relocs.  These
+     symbols have no names.  We store the index of each one in the
+     index field of the section, so that we can find it again when
+     outputting relocs.  */
+  elfsym.st_size = 0;
+  elfsym.st_info = ELF_ST_INFO (STB_LOCAL, STT_SECTION);
+  elfsym.st_other = 0;
+  for (i = 1; i < elf_numsections (abfd); i++)
+    {
+      o = section_from_elf_index (abfd, i);
+      if (o != NULL)
+	o->target_index = bfd_get_symcount (abfd);
+      elfsym.st_shndx = i;
+      elfsym.st_value = 0;
+      if (! elf_link_output_sym (&finfo, (const char *) NULL,
+				 &elfsym, o))
+	goto error_return;
+      if (i == SHN_LORESERVE)
+	i += SHN_HIRESERVE + 1 - SHN_LORESERVE;
+    }
+
+  /* Allocate some memory to hold information read in from the input
+     files.  */
+  if (max_contents_size != 0)
+    {
+      finfo.contents = (bfd_byte *) bfd_malloc (max_contents_size);
+      if (finfo.contents == NULL)
+	goto error_return;
+    }
+
+  if (max_external_reloc_size != 0)
+    {
+      finfo.external_relocs = (PTR) bfd_malloc (max_external_reloc_size);
+      if (finfo.external_relocs == NULL)
+	goto error_return;
+    }
+
+  if (max_internal_reloc_count != 0)
+    {
+      amt = max_internal_reloc_count * bed->s->int_rels_per_ext_rel;
+      amt *= sizeof (Elf_Internal_Rela);
+      finfo.internal_relocs = (Elf_Internal_Rela *) bfd_malloc (amt);
+      if (finfo.internal_relocs == NULL)
+	goto error_return;
+    }
+
+  if (max_sym_count != 0)
+    {
+      amt = max_sym_count * sizeof (Elf_External_Sym);
+      finfo.external_syms = (Elf_External_Sym *) bfd_malloc (amt);
+      if (finfo.external_syms == NULL)
+	goto error_return;
+
+      amt = max_sym_count * sizeof (Elf_Internal_Sym);
+      finfo.internal_syms = (Elf_Internal_Sym *) bfd_malloc (amt);
+      if (finfo.internal_syms == NULL)
+	goto error_return;
+
+      amt = max_sym_count * sizeof (long);
+      finfo.indices = (long *) bfd_malloc (amt);
+      if (finfo.indices == NULL)
+	goto error_return;
+
+      amt = max_sym_count * sizeof (asection *);
+      finfo.sections = (asection **) bfd_malloc (amt);
+      if (finfo.sections == NULL)
+	goto error_return;
+    }
+
+  if (max_sym_shndx_count != 0)
+    {
+      amt = max_sym_shndx_count * sizeof (Elf_External_Sym_Shndx);
+      finfo.locsym_shndx = (Elf_External_Sym_Shndx *) bfd_malloc (amt);
+      if (finfo.locsym_shndx == NULL)
+	goto error_return;
+    }
+
+  if (finfo.first_tls_sec)
+    {
+      unsigned int align = 0;
+      bfd_vma base = finfo.first_tls_sec->vma, end = 0;
+      asection *sec;
+
+      for (sec = finfo.first_tls_sec;
+	   sec && (sec->flags & SEC_THREAD_LOCAL);
+	   sec = sec->next)
+	{
+	  bfd_vma size = sec->_raw_size;
+
+	  if (bfd_get_section_alignment (abfd, sec) > align)
+	    align = bfd_get_section_alignment (abfd, sec);
+	  if (sec->_raw_size == 0 && (sec->flags & SEC_HAS_CONTENTS) == 0)
+	    {
+	      struct bfd_link_order *o;
+
+	      size = 0;
+	      for (o = sec->link_order_head; o != NULL; o = o->next)
+		if (size < o->offset + o->size)
+		  size = o->offset + o->size;
+	    }
+	  end = sec->vma + size;
+	}
+      elf_hash_table (info)->tls_segment
+	= bfd_zalloc (abfd, sizeof (struct elf_link_tls_segment));
+      if (elf_hash_table (info)->tls_segment == NULL)
+	goto error_return;
+      elf_hash_table (info)->tls_segment->start = base;
+      elf_hash_table (info)->tls_segment->size = end - base;
+      elf_hash_table (info)->tls_segment->align = align;
+    }
+
+  if (ddr_sec)
+    {
+      ddr_count = 0;
+      ddr_ptr = (unsigned *)bfd_alloc(abfd, 4 * max_datadata_reloc_count + 4);
+      if (ddr_ptr)
+	++ddr_ptr;
+      else
+	goto error_return;
+    }
+  else
+    ddr_ptr = NULL;
+
+  /* Since ELF permits relocations to be against local symbols, we
+     must have the local symbols available when we do the relocations.
+     Since we would rather only read the local symbols once, and we
+     would rather not keep them in memory, we handle all the
+     relocations for a single input file at the same time.
+
+     Unfortunately, there is no way to know the total number of local
+     symbols until we have seen all of them, and the local symbol
+     indices precede the global symbol indices.  This means that when
+     we are generating relocateable output, and we see a reloc against
+     a global symbol, we can not know the symbol index until we have
+     finished examining all the local symbols to see which ones we are
+     going to output.  To deal with this, we keep the relocations in
+     memory, and don't output them until the end of the link.  This is
+     an unfortunate waste of memory, but I don't see a good way around
+     it.  Fortunately, it only happens when performing a relocateable
+     link, which is not the common case.  FIXME: If keep_memory is set
+     we could write the relocs out and then read them again; I don't
+     know how bad the memory loss will be.  */
+
+  for (sub = info->input_bfds; sub != NULL; sub = sub->link_next)
+    sub->output_has_begun = false;
+  for (o = abfd->sections; o != NULL; o = o->next)
+    {
+      for (p = o->link_order_head; p != NULL; p = p->next)
+	{
+	  if (p->type == bfd_indirect_link_order
+	      && (bfd_get_flavour ((sub = p->u.indirect.section->owner))
+		  == bfd_target_elf_flavour)
+	      && elf_elfheader (sub)->e_ident[EI_CLASS] == bed->s->elfclass)
+	    {
+	      if (! sub->output_has_begun)
+		{
+		  if (! elf_link_input_bfd (&finfo, sub))
+		    goto error_return;
+		  sub->output_has_begun = true;
+		}
+	    }
+	  else if (p->type == bfd_section_reloc_link_order
+		   || p->type == bfd_symbol_reloc_link_order)
+	    {
+	      if (! elf_reloc_link_order (abfd, info, o, p))
+		goto error_return;
+	    }
+	  else
+	    {
+	      if (! _bfd_default_link_order (abfd, info, o, p))
+		goto error_return;
+	    }
+	}
+    }
+
+  /* Output any global symbols that got converted to local in a
+     version script or due to symbol visibility.  We do this in a
+     separate step since ELF requires all local symbols to appear
+     prior to any global symbols.  FIXME: We should only do this if
+     some global symbols were, in fact, converted to become local.
+     FIXME: Will this work correctly with the Irix 5 linker?  */
+  eoinfo.failed = false;
+  eoinfo.finfo = &finfo;
+  eoinfo.localsyms = true;
+  elf_link_hash_traverse (elf_hash_table (info), elf_link_output_extsym,
+			  (PTR) &eoinfo);
+  if (eoinfo.failed)
+    return false;
+
+  /* Set the vma of the sections to 0. We can't do that before, otherwise the
+     relocation doesn't work properly for .sbss. */
+  {
+    int n = elf_elfheader(abfd)->e_shnum;
+    Elf_Internal_Shdr **hdr = elf_elfsections(abfd);
+    for (i = 1; i < n; ++i, ++hdr)
+      (*hdr)->sh_addr = 0;
+  }
+  
+  /* That wrote out all the local symbols.  Finish up the symbol table
+     with the global symbols. Even if we want to strip everything we
+     can, we still need to deal with those global symbols that got
+     converted to local in a version script.  */
+
+  /* The sh_info field records the index of the first non local symbol.  */
+  symtab_hdr->sh_info = bfd_get_symcount (abfd);
+
+  if (dynamic
+      && finfo.dynsym_sec->output_section != bfd_abs_section_ptr)
+    {
+      Elf_Internal_Sym sym;
+      Elf_External_Sym *dynsym =
+	(Elf_External_Sym *) finfo.dynsym_sec->contents;
+      long last_local = 0;
+
+      /* Write out the section symbols for the output sections.  */
+      if (info->shared)
+	{
+	  asection *s;
+
+	  sym.st_size = 0;
+	  sym.st_name = 0;
+	  sym.st_info = ELF_ST_INFO (STB_LOCAL, STT_SECTION);
+	  sym.st_other = 0;
+
+	  for (s = abfd->sections; s != NULL; s = s->next)
+	    {
+	      int indx;
+	      Elf_External_Sym *dest;
+
+	      indx = elf_section_data (s)->this_idx;
+	      BFD_ASSERT (indx > 0);
+	      sym.st_shndx = indx;
+	      sym.st_value = s->vma;
+	      dest = dynsym + elf_section_data (s)->dynindx;
+	      elf_swap_symbol_out (abfd, &sym, (PTR) dest, (PTR) 0);
+	    }
+
+	  last_local = bfd_count_sections (abfd);
+	}
+
+      /* Write out the local dynsyms.  */
+      if (elf_hash_table (info)->dynlocal)
+	{
+	  struct elf_link_local_dynamic_entry *e;
+	  for (e = elf_hash_table (info)->dynlocal; e ; e = e->next)
+	    {
+	      asection *s;
+	      Elf_External_Sym *dest;
+
+	      sym.st_size = e->isym.st_size;
+	      sym.st_other = e->isym.st_other;
+
+	      /* Copy the internal symbol as is.
+		 Note that we saved a word of storage and overwrote
+		 the original st_name with the dynstr_index.  */
+	      sym = e->isym;
+
+	      if (e->isym.st_shndx != SHN_UNDEF
+		  && (e->isym.st_shndx < SHN_LORESERVE
+		      || e->isym.st_shndx > SHN_HIRESERVE))
+		{
+		  s = bfd_section_from_elf_index (e->input_bfd,
+						  e->isym.st_shndx);
+
+		  sym.st_shndx =
+		    elf_section_data (s->output_section)->this_idx;
+		  sym.st_value = (s->output_section->vma
+				  + s->output_offset
+				  + e->isym.st_value);
+		}
+
+	      if (last_local < e->dynindx)
+		last_local = e->dynindx;
+
+	      dest = dynsym + e->dynindx;
+	      elf_swap_symbol_out (abfd, &sym, (PTR) dest, (PTR) 0);
+	    }
+	}
+
+      elf_section_data (finfo.dynsym_sec->output_section)->this_hdr.sh_info =
+	last_local + 1;
+    }
+
+  /* We get the global symbols from the hash table.  */
+  eoinfo.failed = false;
+  eoinfo.localsyms = false;
+  eoinfo.finfo = &finfo;
+  elf_link_hash_traverse (elf_hash_table (info), elf_link_output_extsym,
+			  (PTR) &eoinfo);
+  if (eoinfo.failed)
+    return false;
+
+  /* If backend needs to output some symbols not present in the hash
+     table, do it now.  */
+  if (bed->elf_backend_output_arch_syms)
+    {
+      typedef boolean (*out_sym_func) PARAMS ((PTR, const char *,
+					       Elf_Internal_Sym *,
+					       asection *));
+
+      if (! ((*bed->elf_backend_output_arch_syms)
+	     (abfd, info, (PTR) &finfo, (out_sym_func) elf_link_output_sym)))
+	return false;
+    }
+
+  /* Flush all symbols to the file.  */
+  if (! elf_link_flush_output_syms (&finfo))
+    return false;
+
+  /* Now we know the size of the symtab section.  */
+  off += symtab_hdr->sh_size;
+
+  /* Add the __datadata_relocs table. */
+  if (ddr_sec)
+    {
+      Elf_Internal_Shdr *hdr = elf_elfsections(abfd)[_bfd_elf_section_from_bfd_section(abfd, ddr_sec)];
+      ddr_sec->_cooked_size = ddr_sec->_raw_size = hdr->sh_size = 4 * ddr_count + 4;
+      hdr->sh_addralign = 2;
+      off = _bfd_elf_assign_file_position_for_section (hdr, off, true);
+      ddr_ptr -= ddr_count + 1;
+      *ddr_ptr = ddr_count ? ddr_count : -1;
+      bfd_set_section_contents(abfd, ddr_sec, ddr_ptr, 0, hdr->sh_size);
+    }
+  
+  /* Finish up and write out the symbol string table (.strtab)
+     section.  */
+  symstrtab_hdr = &elf_tdata (abfd)->strtab_hdr;
+  /* sh_name was set in prep_headers.  */
+  symstrtab_hdr->sh_type = SHT_STRTAB;
+  symstrtab_hdr->sh_flags = 0;
+  symstrtab_hdr->sh_addr = 0;
+  symstrtab_hdr->sh_size = _bfd_stringtab_size (finfo.symstrtab);
+  symstrtab_hdr->sh_entsize = 0;
+  symstrtab_hdr->sh_link = 0;
+  symstrtab_hdr->sh_info = 0;
+  /* sh_offset is set just below.  */
+  symstrtab_hdr->sh_addralign = 1;
+
+  off = _bfd_elf_assign_file_position_for_section (symstrtab_hdr, off, true);
+  elf_tdata (abfd)->next_file_pos = off;
+
+  if (bfd_get_symcount (abfd) > 0)
+    {
+      if (bfd_seek (abfd, symstrtab_hdr->sh_offset, SEEK_SET) != 0
+	  || ! _bfd_stringtab_emit (abfd, finfo.symstrtab))
+	return false;
+    }
+
+  /* Adjust the relocs to have the correct symbol indices.  */
+  for (o = abfd->sections; o != NULL; o = o->next)
+    {
+      if ((o->flags & SEC_RELOC) == 0)
+	continue;
+
+      elf_link_adjust_relocs (abfd, &elf_section_data (o)->rel_hdr,
+			      elf_section_data (o)->rel_count,
+			      elf_section_data (o)->rel_hashes);
+      if (elf_section_data (o)->rel_hdr2 != NULL)
+	elf_link_adjust_relocs (abfd, elf_section_data (o)->rel_hdr2,
+				elf_section_data (o)->rel_count2,
+				(elf_section_data (o)->rel_hashes
+				 + elf_section_data (o)->rel_count));
+
+      elf_section_data (o)->rel_hdr.sh_size =
+	o->reloc_count * elf_section_data (o)->rel_hdr.sh_entsize;
+      
+      /* Set the reloc_count field to 0 to prevent write_relocs from
+	 trying to swap the relocs out itself.  */
+      o->reloc_count = 0;
+    }
+
+  _bfd_elf_assign_file_positions_for_relocs (abfd);
+
+  if (dynamic && info->combreloc && dynobj != NULL)
+    relativecount = elf_link_sort_relocs (abfd, info, &reldyn);
+
+  /* If we are linking against a dynamic object, or generating a
+     shared library, finish up the dynamic linking information.  */
+  if (dynamic)
+    {
+      Elf_External_Dyn *dyncon, *dynconend;
+
+      /* Fix up .dynamic entries.  */
+      o = bfd_get_section_by_name (dynobj, ".dynamic");
+      BFD_ASSERT (o != NULL);
+
+      dyncon = (Elf_External_Dyn *) o->contents;
+      dynconend = (Elf_External_Dyn *) (o->contents + o->_raw_size);
+      for (; dyncon < dynconend; dyncon++)
+	{
+	  Elf_Internal_Dyn dyn;
+	  const char *name;
+	  unsigned int type;
+
+	  elf_swap_dyn_in (dynobj, dyncon, &dyn);
+
+	  switch (dyn.d_tag)
+	    {
+	    default:
+	      break;
+	    case DT_NULL:
+	      if (relativecount > 0 && dyncon + 1 < dynconend)
+		{
+		  switch (elf_section_data (reldyn)->this_hdr.sh_type)
+		    {
+		    case SHT_REL: dyn.d_tag = DT_RELCOUNT; break;
+		    case SHT_RELA: dyn.d_tag = DT_RELACOUNT; break;
+		    default: break;
+		    }
+		  if (dyn.d_tag != DT_NULL)
+		    {
+		      dyn.d_un.d_val = relativecount;
+		      elf_swap_dyn_out (dynobj, &dyn, dyncon);
+		      relativecount = 0;
+		    }
+		}
+	      break;
+	    case DT_INIT:
+	      name = info->init_function;
+	      goto get_sym;
+	    case DT_FINI:
+	      name = info->fini_function;
+	    get_sym:
+	      {
+		struct elf_link_hash_entry *h;
+
+		h = elf_link_hash_lookup (elf_hash_table (info), name,
+					  false, false, true);
+		if (h != NULL
+		    && (h->root.type == bfd_link_hash_defined
+			|| h->root.type == bfd_link_hash_defweak))
+		  {
+		    dyn.d_un.d_val = h->root.u.def.value;
+		    o = h->root.u.def.section;
+		    if (o->output_section != NULL)
+		      dyn.d_un.d_val += (o->output_section->vma
+					 + o->output_offset);
+		    else
+		      {
+			/* The symbol is imported from another shared
+			   library and does not apply to this one.  */
+			dyn.d_un.d_val = 0;
+		      }
+
+		    elf_swap_dyn_out (dynobj, &dyn, dyncon);
+		  }
+	      }
+	      break;
+
+	    case DT_PREINIT_ARRAYSZ:
+	      name = ".preinit_array";
+	      goto get_size;
+	    case DT_INIT_ARRAYSZ:
+	      name = ".init_array";
+	      goto get_size;
+	    case DT_FINI_ARRAYSZ:
+	      name = ".fini_array";
+	    get_size:
+	      o = bfd_get_section_by_name (abfd, name);
+	      if (o == NULL)
+		{
+		  (*_bfd_error_handler)
+		    (_("%s: could not find output section %s"),
+		     bfd_get_filename (abfd), name);
+		  goto error_return;
+		}
+	      if (o->_raw_size == 0)
+		(*_bfd_error_handler)
+		  (_("warning: %s section has zero size"), name);
+	      dyn.d_un.d_val = o->_raw_size;
+	      elf_swap_dyn_out (dynobj, &dyn, dyncon);
+	      break;
+
+	    case DT_PREINIT_ARRAY:
+	      name = ".preinit_array";
+	      goto get_vma;
+	    case DT_INIT_ARRAY:
+	      name = ".init_array";
+	      goto get_vma;
+	    case DT_FINI_ARRAY:
+	      name = ".fini_array";
+	      goto get_vma;
+
+	    case DT_HASH:
+	      name = ".hash";
+	      goto get_vma;
+	    case DT_STRTAB:
+	      name = ".dynstr";
+	      goto get_vma;
+	    case DT_SYMTAB:
+	      name = ".dynsym";
+	      goto get_vma;
+	    case DT_VERDEF:
+	      name = ".gnu.version_d";
+	      goto get_vma;
+	    case DT_VERNEED:
+	      name = ".gnu.version_r";
+	      goto get_vma;
+	    case DT_VERSYM:
+	      name = ".gnu.version";
+	    get_vma:
+	      o = bfd_get_section_by_name (abfd, name);
+	      if (o == NULL)
+		{
+		  (*_bfd_error_handler)
+		    (_("%s: could not find output section %s"),
+		     bfd_get_filename (abfd), name);
+		  goto error_return;
+		}
+	      dyn.d_un.d_ptr = o->vma;
+	      elf_swap_dyn_out (dynobj, &dyn, dyncon);
+	      break;
+
+	    case DT_REL:
+	    case DT_RELA:
+	    case DT_RELSZ:
+	    case DT_RELASZ:
+	      if (dyn.d_tag == DT_REL || dyn.d_tag == DT_RELSZ)
+		type = SHT_REL;
+	      else
+		type = SHT_RELA;
+	      dyn.d_un.d_val = 0;
+	      for (i = 1; i < elf_numsections (abfd); i++)
+		{
+		  Elf_Internal_Shdr *hdr;
+
+		  hdr = elf_elfsections (abfd)[i];
+		  if (hdr->sh_type == type
+		      && (hdr->sh_flags & SHF_ALLOC) != 0)
+		    {
+		      if (dyn.d_tag == DT_RELSZ || dyn.d_tag == DT_RELASZ)
+			dyn.d_un.d_val += hdr->sh_size;
+		      else
+			{
+			  if (dyn.d_un.d_val == 0
+			      || hdr->sh_addr < dyn.d_un.d_val)
+			    dyn.d_un.d_val = hdr->sh_addr;
+			}
+		    }
+		}
+	      elf_swap_dyn_out (dynobj, &dyn, dyncon);
+	      break;
+	    }
+	}
+    }
+
+  /* If we have created any dynamic sections, then output them.  */
+  if (dynobj != NULL)
+    {
+      if (! (*bed->elf_backend_finish_dynamic_sections) (abfd, info))
+	goto error_return;
+
+      for (o = dynobj->sections; o != NULL; o = o->next)
+	{
+	  if ((o->flags & SEC_HAS_CONTENTS) == 0
+	      || o->_raw_size == 0
+	      || o->output_section == bfd_abs_section_ptr)
+	    continue;
+	  if ((o->flags & SEC_LINKER_CREATED) == 0)
+	    {
+	      /* At this point, we are only interested in sections
+		 created by elf_link_create_dynamic_sections.  */
+	      continue;
+	    }
+	  if ((elf_section_data (o->output_section)->this_hdr.sh_type
+	       != SHT_STRTAB)
+	      || strcmp (bfd_get_section_name (abfd, o), ".dynstr") != 0)
+	    {
+	      if (! bfd_set_section_contents (abfd, o->output_section,
+					      o->contents,
+					      (file_ptr) o->output_offset,
+					      o->_raw_size))
+		goto error_return;
+	    }
+	  else
+	    {
+	      /* The contents of the .dynstr section are actually in a
+		 stringtab.  */
+	      off = elf_section_data (o->output_section)->this_hdr.sh_offset;
+	      if (bfd_seek (abfd, off, SEEK_SET) != 0
+		  || ! _bfd_elf_strtab_emit (abfd,
+					     elf_hash_table (info)->dynstr))
+		goto error_return;
+	    }
+	}
+    }
+
+  if (info->relocateable)
+    {
+      boolean failed = false;
+
+      bfd_map_over_sections (abfd, bfd_elf_set_group_contents, &failed);
+      if (failed)
+	goto error_return;
+    }
+
+  /* If we have optimized stabs strings, output them.  */
+  if (elf_hash_table (info)->stab_info != NULL)
+    {
+      if (! _bfd_write_stab_strings (abfd, &elf_hash_table (info)->stab_info))
+	goto error_return;
+    }
+
+  if (info->eh_frame_hdr && elf_hash_table (info)->dynobj)
+    {
+      o = bfd_get_section_by_name (elf_hash_table (info)->dynobj,
+				   ".eh_frame_hdr");
+      if (o
+	  && (elf_section_data (o)->sec_info_type
+	      == ELF_INFO_TYPE_EH_FRAME_HDR))
+	{
+	  if (! _bfd_elf_write_section_eh_frame_hdr (abfd, o))
+	    goto error_return;
+	}
+    }
+
+  if (finfo.symstrtab != NULL)
+    _bfd_stringtab_free (finfo.symstrtab);
+  if (finfo.contents != NULL)
+    free (finfo.contents);
+  if (finfo.external_relocs != NULL)
+    free (finfo.external_relocs);
+  if (finfo.internal_relocs != NULL)
+    free (finfo.internal_relocs);
+  if (finfo.external_syms != NULL)
+    free (finfo.external_syms);
+  if (finfo.locsym_shndx != NULL)
+    free (finfo.locsym_shndx);
+  if (finfo.internal_syms != NULL)
+    free (finfo.internal_syms);
+  if (finfo.indices != NULL)
+    free (finfo.indices);
+  if (finfo.sections != NULL)
+    free (finfo.sections);
+  if (finfo.symbuf != NULL)
+    free (finfo.symbuf);
+  if (finfo.symshndxbuf != NULL)
+    free (finfo.symbuf);
+  for (o = abfd->sections; o != NULL; o = o->next)
+    {
+      if ((o->flags & SEC_RELOC) != 0
+	  && elf_section_data (o)->rel_hashes != NULL)
+	free (elf_section_data (o)->rel_hashes);
+    }
+
+  elf_tdata (abfd)->linker = true;
+
+  return true;
+
+ error_return:
+  if (finfo.symstrtab != NULL)
+    _bfd_stringtab_free (finfo.symstrtab);
+  if (finfo.contents != NULL)
+    free (finfo.contents);
+  if (finfo.external_relocs != NULL)
+    free (finfo.external_relocs);
+  if (finfo.internal_relocs != NULL)
+    free (finfo.internal_relocs);
+  if (finfo.external_syms != NULL)
+    free (finfo.external_syms);
+  if (finfo.locsym_shndx != NULL)
+    free (finfo.locsym_shndx);
+  if (finfo.internal_syms != NULL)
+    free (finfo.internal_syms);
+  if (finfo.indices != NULL)
+    free (finfo.indices);
+  if (finfo.sections != NULL)
+    free (finfo.sections);
+  if (finfo.symbuf != NULL)
+    free (finfo.symbuf);
+  if (finfo.symshndxbuf != NULL)
+    free (finfo.symbuf);
+  for (o = abfd->sections; o != NULL; o = o->next)
+    {
+      if ((o->flags & SEC_RELOC) != 0
+	  && elf_section_data (o)->rel_hashes != NULL)
+	free (elf_section_data (o)->rel_hashes);
+    }
+
+  return false;
+}
+
+/* Add a symbol to the output symbol table.  */
+
+static boolean
+elf_link_output_sym (finfo, name, elfsym, input_sec)
+     struct elf_final_link_info *finfo;
+     const char *name;
+     Elf_Internal_Sym *elfsym;
+     asection *input_sec;
+{
+  Elf_External_Sym *dest;
+  Elf_External_Sym_Shndx *destshndx;
+
+  boolean (*output_symbol_hook) PARAMS ((bfd *,
+					 struct bfd_link_info *info,
+					 const char *,
+					 Elf_Internal_Sym *,
+					 asection *));
+
+  output_symbol_hook = get_elf_backend_data (finfo->output_bfd)->
+    elf_backend_link_output_symbol_hook;
+  if (output_symbol_hook != NULL)
+    {
+      if (! ((*output_symbol_hook)
+	     (finfo->output_bfd, finfo->info, name, elfsym, input_sec)))
+	return false;
+    }
+
+  if (name == (const char *) NULL || *name == '\0')
+    elfsym->st_name = 0;
+  else if (input_sec->flags & SEC_EXCLUDE)
+    elfsym->st_name = 0;
+  else
+    {
+      elfsym->st_name = (unsigned long) _bfd_stringtab_add (finfo->symstrtab,
+							    name, true, false);
+      if (elfsym->st_name == (unsigned long) -1)
+	return false;
+    }
+
+  if (finfo->symbuf_count >= finfo->symbuf_size)
+    {
+      if (! elf_link_flush_output_syms (finfo))
+	return false;
+    }
+
+  dest = finfo->symbuf + finfo->symbuf_count;
+  destshndx = finfo->symshndxbuf;
+  if (destshndx != NULL)
+    destshndx += finfo->symbuf_count;
+  elf_swap_symbol_out (finfo->output_bfd, elfsym, (PTR) dest, (PTR) destshndx);
+  ++finfo->symbuf_count;
+
+  ++ bfd_get_symcount (finfo->output_bfd);
+
+  return true;
+}
+
+/* Flush the output symbols to the file.  */
+
+static boolean
+elf_link_flush_output_syms (finfo)
+     struct elf_final_link_info *finfo;
+{
+  if (finfo->symbuf_count > 0)
+    {
+      Elf_Internal_Shdr *hdr;
+      file_ptr pos;
+      bfd_size_type amt;
+
+      hdr = &elf_tdata (finfo->output_bfd)->symtab_hdr;
+      pos = hdr->sh_offset + hdr->sh_size;
+      amt = finfo->symbuf_count * sizeof (Elf_External_Sym);
+      if (bfd_seek (finfo->output_bfd, pos, SEEK_SET) != 0
+	  || bfd_bwrite ((PTR) finfo->symbuf, amt, finfo->output_bfd) != amt)
+	return false;
+
+      hdr->sh_size += amt;
+
+      if (finfo->symshndxbuf != NULL)
+	{
+	  hdr = &elf_tdata (finfo->output_bfd)->symtab_shndx_hdr;
+	  pos = hdr->sh_offset + hdr->sh_size;
+	  amt = finfo->symbuf_count * sizeof (Elf_External_Sym_Shndx);
+	  if (bfd_seek (finfo->output_bfd, pos, SEEK_SET) != 0
+	      || (bfd_bwrite ((PTR) finfo->symshndxbuf, amt, finfo->output_bfd)
+		  != amt))
+	    return false;
+
+	  hdr->sh_size += amt;
+	}
+
+      finfo->symbuf_count = 0;
+    }
+
+  return true;
+}
+
+/* Adjust all external symbols pointing into SEC_MERGE sections
+   to reflect the object merging within the sections.  */
+
+static boolean
+elf_link_sec_merge_syms (h, data)
+     struct elf_link_hash_entry *h;
+     PTR data;
+{
+  asection *sec;
+
+  if (h->root.type == bfd_link_hash_warning)
+    h = (struct elf_link_hash_entry *) h->root.u.i.link;
+
+  if ((h->root.type == bfd_link_hash_defined
+       || h->root.type == bfd_link_hash_defweak)
+      && ((sec = h->root.u.def.section)->flags & SEC_MERGE)
+      && elf_section_data (sec)->sec_info_type == ELF_INFO_TYPE_MERGE)
+    {
+      bfd *output_bfd = (bfd *) data;
+
+      h->root.u.def.value =
+	_bfd_merged_section_offset (output_bfd,
+				    &h->root.u.def.section,
+				    elf_section_data (sec)->sec_info,
+				    h->root.u.def.value, (bfd_vma) 0);
+    }
+
+  return true;
+}
+
+/* For DSOs loaded in via a DT_NEEDED entry, emulate ld.so in
+   allowing an unsatisfied unversioned symbol in the DSO to match a
+   versioned symbol that would normally require an explicit version.  */
+
+static boolean
+elf_link_check_versioned_symbol (info, h)
+     struct bfd_link_info *info;
+     struct elf_link_hash_entry *h;
+{
+  bfd *undef_bfd = h->root.u.undef.abfd;
+  struct elf_link_loaded_list *loaded;
+
+  if ((undef_bfd->flags & DYNAMIC) == 0
+      || info->hash->creator->flavour != bfd_target_elf_flavour
+      || elf_dt_soname (h->root.u.undef.abfd) == NULL)
+    return false;
+
+  for (loaded = elf_hash_table (info)->loaded;
+       loaded != NULL;
+       loaded = loaded->next)
+    {
+      bfd *input;
+      Elf_Internal_Shdr *hdr;
+      bfd_size_type symcount;
+      bfd_size_type extsymcount;
+      bfd_size_type extsymoff;
+      Elf_Internal_Shdr *versymhdr;
+      Elf_Internal_Sym *isym;
+      Elf_Internal_Sym *isymend;
+      Elf_Internal_Sym *isymbuf;
+      Elf_External_Versym *ever;
+      Elf_External_Versym *extversym;
+
+      input = loaded->abfd;
+
+      /* We check each DSO for a possible hidden versioned definition.  */
+      if (input == undef_bfd
+	  || (input->flags & DYNAMIC) == 0
+	  || elf_dynversym (input) == 0)
+	continue;
+
+      hdr = &elf_tdata (input)->dynsymtab_hdr;
+
+      symcount = hdr->sh_size / sizeof (Elf_External_Sym);
+      if (elf_bad_symtab (input))
+	{
+	  extsymcount = symcount;
+	  extsymoff = 0;
+	}
+      else
+	{
+	  extsymcount = symcount - hdr->sh_info;
+	  extsymoff = hdr->sh_info;
+	}
+
+      if (extsymcount == 0)
+	continue;
+
+      isymbuf = bfd_elf_get_elf_syms (input, hdr, extsymcount, extsymoff,
+				      NULL, NULL, NULL);
+      if (isymbuf == NULL)
+	return false;
+
+      /* Read in any version definitions.  */
+      versymhdr = &elf_tdata (input)->dynversym_hdr;
+      extversym = (Elf_External_Versym *) bfd_malloc (versymhdr->sh_size);
+      if (extversym == NULL)
+	goto error_ret;
+
+      if (bfd_seek (input, versymhdr->sh_offset, SEEK_SET) != 0
+	  || (bfd_bread ((PTR) extversym, versymhdr->sh_size, input)
+	      != versymhdr->sh_size))
+	{
+	  free (extversym);
+	error_ret:
+	  free (isymbuf);
+	  return false;
+	}
+
+      ever = extversym + extsymoff;
+      isymend = isymbuf + extsymcount;
+      for (isym = isymbuf; isym < isymend; isym++, ever++)
+	{
+	  const char *name;
+	  Elf_Internal_Versym iver;
+
+	  if (ELF_ST_BIND (isym->st_info) == STB_LOCAL
+	      || isym->st_shndx == SHN_UNDEF)
+	    continue;
+
+	  name = bfd_elf_string_from_elf_section (input,
+						  hdr->sh_link,
+						  isym->st_name);
+	  if (strcmp (name, h->root.root.string) != 0)
+	    continue;
+
+	  _bfd_elf_swap_versym_in (input, ever, &iver);
+
+	  if ((iver.vs_vers & VERSYM_HIDDEN) == 0)
+	    {
+	      /* If we have a non-hidden versioned sym, then it should
+		 have provided a definition for the undefined sym.  */
+	      abort ();
+	    }
+
+	  if ((iver.vs_vers & VERSYM_VERSION) == 2)
+	    {
+	      /* This is the oldest (default) sym.  We can use it.  */
+	      free (extversym);
+	      free (isymbuf);
+	      return true;
+	    }
+	}
+
+      free (extversym);
+      free (isymbuf);
+    }
+
+  return false;
+}
+
+/* Add an external symbol to the symbol table.  This is called from
+   the hash table traversal routine.  When generating a shared object,
+   we go through the symbol table twice.  The first time we output
+   anything that might have been forced to local scope in a version
+   script.  The second time we output the symbols that are still
+   global symbols.  */
+
+static boolean
+elf_link_output_extsym (h, data)
+     struct elf_link_hash_entry *h;
+     PTR data;
+{
+  struct elf_outext_info *eoinfo = (struct elf_outext_info *) data;
+  struct elf_final_link_info *finfo = eoinfo->finfo;
+  boolean strip;
+  Elf_Internal_Sym sym;
+  asection *input_sec;
+
+  if (h->root.type == bfd_link_hash_warning)
+    {
+      h = (struct elf_link_hash_entry *) h->root.u.i.link;
+      if (h->root.type == bfd_link_hash_new)
+	return true;
+    }
+
+  /* Decide whether to output this symbol in this pass.  */
+  if (eoinfo->localsyms)
+    {
+      if ((h->elf_link_hash_flags & ELF_LINK_FORCED_LOCAL) == 0)
+	return true;
+    }
+  else
+    {
+      if ((h->elf_link_hash_flags & ELF_LINK_FORCED_LOCAL) != 0)
+	return true;
+    }
+
+  /* If we are not creating a shared library, and this symbol is
+     referenced by a shared library but is not defined anywhere, then
+     warn that it is undefined.  If we do not do this, the runtime
+     linker will complain that the symbol is undefined when the
+     program is run.  We don't have to worry about symbols that are
+     referenced by regular files, because we will already have issued
+     warnings for them.  */
+  if (! finfo->info->relocateable
+      && ! finfo->info->allow_shlib_undefined
+      && ! finfo->info->shared
+      && h->root.type == bfd_link_hash_undefined
+      && (h->elf_link_hash_flags & ELF_LINK_HASH_REF_DYNAMIC) != 0
+      && (h->elf_link_hash_flags & ELF_LINK_HASH_REF_REGULAR) == 0
+      && ! elf_link_check_versioned_symbol (finfo->info, h))
+    {
+      if (! ((*finfo->info->callbacks->undefined_symbol)
+	     (finfo->info, h->root.root.string, h->root.u.undef.abfd,
+	      (asection *) NULL, (bfd_vma) 0, true)))
+	{
+	  eoinfo->failed = true;
+	  return false;
+	}
+    }
+
+  /* We don't want to output symbols that have never been mentioned by
+     a regular file, or that we have been told to strip.  However, if
+     h->indx is set to -2, the symbol is used by a reloc and we must
+     output it.  */
+  if (h->indx == -2)
+    strip = false;
+  else if (((h->elf_link_hash_flags & ELF_LINK_HASH_DEF_DYNAMIC) != 0
+	    || (h->elf_link_hash_flags & ELF_LINK_HASH_REF_DYNAMIC) != 0)
+	   && (h->elf_link_hash_flags & ELF_LINK_HASH_DEF_REGULAR) == 0
+	   && (h->elf_link_hash_flags & ELF_LINK_HASH_REF_REGULAR) == 0)
+    strip = true;
+  else if (finfo->info->strip == strip_all
+	   || (finfo->info->strip == strip_some
+	       && bfd_hash_lookup (finfo->info->keep_hash,
+				   h->root.root.string,
+				   false, false) == NULL))
+    strip = true;
+  else
+    strip = false;
+
+  /* If we're stripping it, and it's not a dynamic symbol, there's
+     nothing else to do unless it is a forced local symbol.  */
+  if (strip
+      && h->dynindx == -1
+      && (h->elf_link_hash_flags & ELF_LINK_FORCED_LOCAL) == 0)
+    return true;
+
+  sym.st_value = 0;
+  sym.st_size = h->size;
+  sym.st_other = h->other;
+  if ((h->elf_link_hash_flags & ELF_LINK_FORCED_LOCAL) != 0)
+    sym.st_info = ELF_ST_INFO (STB_LOCAL, h->type);
+  else if (h->root.type == bfd_link_hash_undefweak
+	   || h->root.type == bfd_link_hash_defweak)
+    sym.st_info = ELF_ST_INFO (STB_WEAK, h->type);
+  else
+    sym.st_info = ELF_ST_INFO (STB_GLOBAL, h->type);
+
+  switch (h->root.type)
+    {
+    default:
+    case bfd_link_hash_new:
+    case bfd_link_hash_warning:
+      abort ();
+      return false;
+
+    case bfd_link_hash_undefined:
+    case bfd_link_hash_undefweak:
+      input_sec = bfd_und_section_ptr;
+      sym.st_shndx = SHN_UNDEF;
+      break;
+
+    case bfd_link_hash_defined:
+    case bfd_link_hash_defweak:
+      {
+	input_sec = h->root.u.def.section;
+	if (input_sec->output_section != NULL)
+	  {
+	    sym.st_shndx =
+	      _bfd_elf_section_from_bfd_section (finfo->output_bfd,
+						 input_sec->output_section);
+	    if (sym.st_shndx == SHN_BAD)
+	      {
+		(*_bfd_error_handler)
+		  (_("%s: could not find output section %s for input section %s"),
+		   bfd_get_filename (finfo->output_bfd),
+		   input_sec->output_section->name,
+		   input_sec->name);
+		eoinfo->failed = true;
+		return false;
+	      }
+
+	    /* ELF symbols in relocateable files are section relative,
+	       but in nonrelocateable files they are virtual
+	       addresses.  */
+	    sym.st_value = h->root.u.def.value + input_sec->output_offset;
+#if 0
+	    if (! finfo->info->relocateable)
+	      {
+		sym.st_value += input_sec->output_section->vma;
+		if (h->type == STT_TLS)
+		  {
+		    /* STT_TLS symbols are relative to PT_TLS segment
+		       base.  */
+		    BFD_ASSERT (finfo->first_tls_sec != NULL);
+		    sym.st_value -= finfo->first_tls_sec->vma;
+		  }
+	      }
+#endif
+	  }
+	else
+	  {
+	    BFD_ASSERT (input_sec->owner == NULL
+			|| (input_sec->owner->flags & DYNAMIC) != 0);
+	    sym.st_shndx = SHN_UNDEF;
+	    input_sec = bfd_und_section_ptr;
+	  }
+      }
+      break;
+
+    case bfd_link_hash_common:
+      input_sec = h->root.u.c.p->section;
+      sym.st_shndx = SHN_COMMON;
+      sym.st_value = 1 << h->root.u.c.p->alignment_power;
+      break;
+
+    case bfd_link_hash_indirect:
+      /* These symbols are created by symbol versioning.  They point
+	 to the decorated version of the name.  For example, if the
+	 symbol foo@@GNU_1.2 is the default, which should be used when
+	 foo is used with no version, then we add an indirect symbol
+	 foo which points to foo@@GNU_1.2.  We ignore these symbols,
+	 since the indirected symbol is already in the hash table.  */
+      return true;
+    }
+
+  /* Give the processor backend a chance to tweak the symbol value,
+     and also to finish up anything that needs to be done for this
+     symbol.  FIXME: Not calling elf_backend_finish_dynamic_symbol for
+     forced local syms when non-shared is due to a historical quirk.  */
+  if ((h->dynindx != -1
+       || (h->elf_link_hash_flags & ELF_LINK_FORCED_LOCAL) != 0)
+      && (finfo->info->shared
+	  || (h->elf_link_hash_flags & ELF_LINK_FORCED_LOCAL) == 0)
+      && elf_hash_table (finfo->info)->dynamic_sections_created)
+    {
+      struct elf_backend_data *bed;
+
+      bed = get_elf_backend_data (finfo->output_bfd);
+      if (! ((*bed->elf_backend_finish_dynamic_symbol)
+	     (finfo->output_bfd, finfo->info, h, &sym)))
+	{
+	  eoinfo->failed = true;
+	  return false;
+	}
+    }
+
+  /* If we are marking the symbol as undefined, and there are no
+     non-weak references to this symbol from a regular object, then
+     mark the symbol as weak undefined; if there are non-weak
+     references, mark the symbol as strong.  We can't do this earlier,
+     because it might not be marked as undefined until the
+     finish_dynamic_symbol routine gets through with it.  */
+  if (sym.st_shndx == SHN_UNDEF
+      && (h->elf_link_hash_flags & ELF_LINK_HASH_REF_REGULAR) != 0
+      && (ELF_ST_BIND (sym.st_info) == STB_GLOBAL
+	  || ELF_ST_BIND (sym.st_info) == STB_WEAK))
+    {
+      int bindtype;
+
+      if ((h->elf_link_hash_flags & ELF_LINK_HASH_REF_REGULAR_NONWEAK) != 0)
+	bindtype = STB_GLOBAL;
+      else
+	bindtype = STB_WEAK;
+      sym.st_info = ELF_ST_INFO (bindtype, ELF_ST_TYPE (sym.st_info));
+    }
+
+  /* If a symbol is not defined locally, we clear the visibility
+     field.  */
+  if (! finfo->info->relocateable
+      && (h->elf_link_hash_flags & ELF_LINK_HASH_DEF_REGULAR) == 0)
+    sym.st_other ^= ELF_ST_VISIBILITY (sym.st_other);
+
+  /* If this symbol should be put in the .dynsym section, then put it
+     there now.  We already know the symbol index.  We also fill in
+     the entry in the .hash section.  */
+  if (h->dynindx != -1
+      && elf_hash_table (finfo->info)->dynamic_sections_created)
+    {
+      size_t bucketcount;
+      size_t bucket;
+      size_t hash_entry_size;
+      bfd_byte *bucketpos;
+      bfd_vma chain;
+      Elf_External_Sym *esym;
+
+      sym.st_name = h->dynstr_index;
+      esym = (Elf_External_Sym *) finfo->dynsym_sec->contents + h->dynindx;
+      elf_swap_symbol_out (finfo->output_bfd, &sym, (PTR) esym, (PTR) 0);
+
+      bucketcount = elf_hash_table (finfo->info)->bucketcount;
+      bucket = h->elf_hash_value % bucketcount;
+      hash_entry_size
+	= elf_section_data (finfo->hash_sec)->this_hdr.sh_entsize;
+      bucketpos = ((bfd_byte *) finfo->hash_sec->contents
+		   + (bucket + 2) * hash_entry_size);
+      chain = bfd_get (8 * hash_entry_size, finfo->output_bfd, bucketpos);
+      bfd_put (8 * hash_entry_size, finfo->output_bfd, (bfd_vma) h->dynindx,
+	       bucketpos);
+      bfd_put (8 * hash_entry_size, finfo->output_bfd, chain,
+	       ((bfd_byte *) finfo->hash_sec->contents
+		+ (bucketcount + 2 + h->dynindx) * hash_entry_size));
+
+      if (finfo->symver_sec != NULL && finfo->symver_sec->contents != NULL)
+	{
+	  Elf_Internal_Versym iversym;
+	  Elf_External_Versym *eversym;
+
+	  if ((h->elf_link_hash_flags & ELF_LINK_HASH_DEF_REGULAR) == 0)
+	    {
+	      if (h->verinfo.verdef == NULL)
+		iversym.vs_vers = 0;
+	      else
+		iversym.vs_vers = h->verinfo.verdef->vd_exp_refno + 1;
+	    }
+	  else
+	    {
+	      if (h->verinfo.vertree == NULL)
+		iversym.vs_vers = 1;
+	      else
+		iversym.vs_vers = h->verinfo.vertree->vernum + 1;
+	    }
+
+	  if ((h->elf_link_hash_flags & ELF_LINK_HIDDEN) != 0)
+	    iversym.vs_vers |= VERSYM_HIDDEN;
+
+	  eversym = (Elf_External_Versym *) finfo->symver_sec->contents;
+	  eversym += h->dynindx;
+	  _bfd_elf_swap_versym_out (finfo->output_bfd, &iversym, eversym);
+	}
+    }
+
+  /* If we're stripping it, then it was just a dynamic symbol, and
+     there's nothing else to do.  */
+  if (strip || (input_sec->flags & SEC_EXCLUDE) != 0)
+    return true;
+
+  h->indx = bfd_get_symcount (finfo->output_bfd);
+
+  if (! elf_link_output_sym (finfo, h->root.root.string, &sym, input_sec))
+    {
+      eoinfo->failed = true;
+      return false;
+    }
+
+  return true;
+}
+
+/* Copy the relocations indicated by the INTERNAL_RELOCS (which
+   originated from the section given by INPUT_REL_HDR) to the
+   OUTPUT_BFD.  */
+
+static boolean
+elf_link_output_relocs (output_bfd, input_section, input_rel_hdr,
+			internal_relocs)
+     bfd *output_bfd;
+     asection *input_section;
+     Elf_Internal_Shdr *input_rel_hdr;
+     Elf_Internal_Rela *internal_relocs;
+{
+  Elf_Internal_Rela *irela;
+  Elf_Internal_Rela *irelaend;
+  Elf_Internal_Shdr *output_rel_hdr;
+  asection *output_section;
+  unsigned int *rel_countp = NULL;
+  struct elf_backend_data *bed;
+  bfd_size_type amt;
+
+  output_section = input_section->output_section;
+  output_rel_hdr = NULL;
+
+  if (elf_section_data (output_section)->rel_hdr.sh_entsize
+      == input_rel_hdr->sh_entsize)
+    {
+      output_rel_hdr = &elf_section_data (output_section)->rel_hdr;
+      rel_countp = &elf_section_data (output_section)->rel_count;
+    }
+  else if (elf_section_data (output_section)->rel_hdr2
+	   && (elf_section_data (output_section)->rel_hdr2->sh_entsize
+	       == input_rel_hdr->sh_entsize))
+    {
+      output_rel_hdr = elf_section_data (output_section)->rel_hdr2;
+      rel_countp = &elf_section_data (output_section)->rel_count2;
+    }
+  else
+    {
+      (*_bfd_error_handler)
+	(_("%s: relocation size mismatch in %s section %s"),
+	 bfd_get_filename (output_bfd),
+	 bfd_archive_filename (input_section->owner),
+	 input_section->name);
+      bfd_set_error (bfd_error_wrong_object_format);
+      return false;
+    }
+
+  bed = get_elf_backend_data (output_bfd);
+  irela = internal_relocs;
+  irelaend = irela + (NUM_SHDR_ENTRIES (input_rel_hdr)
+		      * bed->s->int_rels_per_ext_rel);
+
+  if (input_rel_hdr->sh_entsize == sizeof (Elf_External_Rel))
+    {
+      Elf_External_Rel *erel;
+      Elf_Internal_Rel *irel;
+
+      amt = bed->s->int_rels_per_ext_rel * sizeof (Elf_Internal_Rel);
+      irel = (Elf_Internal_Rel *) bfd_zmalloc (amt);
+      if (irel == NULL)
+	{
+	  (*_bfd_error_handler) (_("Error: out of memory"));
+	  abort ();
+	}
+
+      erel = ((Elf_External_Rel *) output_rel_hdr->contents + *rel_countp);
+      for (; irela < irelaend; irela += bed->s->int_rels_per_ext_rel, erel++)
+	{
+	  unsigned int i;
+
+	  for (i = 0; i < bed->s->int_rels_per_ext_rel; i++)
+	    {
+	      irel[i].r_offset = irela[i].r_offset;
+	      irel[i].r_info = irela[i].r_info;
+	      BFD_ASSERT (irela[i].r_addend == 0);
+	    }
+
+	  if (bed->s->swap_reloc_out)
+	    (*bed->s->swap_reloc_out) (output_bfd, irel, (PTR) erel);
+	  else
+	    elf_swap_reloc_out (output_bfd, irel, erel);
+	}
+
+      free (irel);
+    }
+  else
+    {
+      Elf_External_Rela *erela;
+
+      BFD_ASSERT (input_rel_hdr->sh_entsize == sizeof (Elf_External_Rela));
+
+      erela = ((Elf_External_Rela *) output_rel_hdr->contents + *rel_countp);
+      for (; irela < irelaend; irela += bed->s->int_rels_per_ext_rel, erela++)
+	if (bed->s->swap_reloca_out)
+	  (*bed->s->swap_reloca_out) (output_bfd, irela, (PTR) erela);
+	else
+	  elf_swap_reloca_out (output_bfd, irela, erela);
+    }
+
+  /* Bump the counter, so that we know where to add the next set of
+     relocations.  */
+  *rel_countp += NUM_SHDR_ENTRIES (input_rel_hdr);
+
+  return true;
+}
+
+/* Link an input file into the linker output file.  This function
+   handles all the sections and relocations of the input file at once.
+   This is so that we only have to read the local symbols once, and
+   don't have to keep them in memory.  */
+
+static boolean
+elf_link_input_bfd (finfo, input_bfd)
+     struct elf_final_link_info *finfo;
+     bfd *input_bfd;
+{
+  boolean (*relocate_section) PARAMS ((bfd *, struct bfd_link_info *,
+				       bfd *, asection *, bfd_byte *,
+				       Elf_Internal_Rela *,
+				       Elf_Internal_Sym *, asection **));
+  bfd *output_bfd;
+  Elf_Internal_Shdr *symtab_hdr;
+  size_t locsymcount;
+  size_t extsymoff;
+  Elf_Internal_Sym *isymbuf;
+  Elf_Internal_Sym *isym;
+  Elf_Internal_Sym *isymend;
+  long *pindex;
+  asection **ppsection;
+  asection *o;
+  struct elf_backend_data *bed;
+  boolean emit_relocs;
+  struct elf_link_hash_entry **sym_hashes;
+
+  output_bfd = finfo->output_bfd;
+  bed = get_elf_backend_data (output_bfd);
+  relocate_section = bed->elf_backend_relocate_section;
+
+  /* If this is a dynamic object, we don't want to do anything here:
+     we don't want the local symbols, and we don't want the section
+     contents.  */
+  if ((input_bfd->flags & DYNAMIC) != 0)
+    return true;
+
+  emit_relocs = (finfo->info->relocateable
+		 || finfo->info->emitrelocations
+		 || bed->elf_backend_emit_relocs);
+
+  symtab_hdr = &elf_tdata (input_bfd)->symtab_hdr;
+  if (elf_bad_symtab (input_bfd))
+    {
+      locsymcount = symtab_hdr->sh_size / sizeof (Elf_External_Sym);
+      extsymoff = 0;
+    }
+  else
+    {
+      locsymcount = symtab_hdr->sh_info;
+      extsymoff = symtab_hdr->sh_info;
+    }
+
+  /* Read the local symbols.  */
+  isymbuf = (Elf_Internal_Sym *) symtab_hdr->contents;
+  if (isymbuf == NULL && locsymcount != 0)
+    {
+      isymbuf = bfd_elf_get_elf_syms (input_bfd, symtab_hdr, locsymcount, 0,
+				      finfo->internal_syms,
+				      finfo->external_syms,
+				      finfo->locsym_shndx);
+      if (isymbuf == NULL)
+	return false;
+    }
+
+  /* Find local symbol sections and adjust values of symbols in
+     SEC_MERGE sections.  Write out those local symbols we know are
+     going into the output file.  */
+  isymend = isymbuf + locsymcount;
+  for (isym = isymbuf, pindex = finfo->indices, ppsection = finfo->sections;
+       isym < isymend;
+       isym++, pindex++, ppsection++)
+    {
+      asection *isec;
+      const char *name;
+      Elf_Internal_Sym osym;
+
+      *pindex = -1;
+
+      if (elf_bad_symtab (input_bfd))
+	{
+	  if (ELF_ST_BIND (isym->st_info) != STB_LOCAL)
+	    {
+	      *ppsection = NULL;
+	      continue;
+	    }
+	}
+
+      if (isym->st_shndx == SHN_UNDEF)
+	isec = bfd_und_section_ptr;
+      else if (isym->st_shndx < SHN_LORESERVE
+	       || isym->st_shndx > SHN_HIRESERVE)
+	{
+	  isec = section_from_elf_index (input_bfd, isym->st_shndx);
+	  if (isec
+	      && elf_section_data (isec)->sec_info_type == ELF_INFO_TYPE_MERGE
+	      && ELF_ST_TYPE (isym->st_info) != STT_SECTION)
+	    isym->st_value =
+	      _bfd_merged_section_offset (output_bfd, &isec,
+					  elf_section_data (isec)->sec_info,
+					  isym->st_value, (bfd_vma) 0);
+	}
+      else if (isym->st_shndx == SHN_ABS)
+	isec = bfd_abs_section_ptr;
+      else if (isym->st_shndx == SHN_COMMON)
+	isec = bfd_com_section_ptr;
+      else
+	{
+	  /* Who knows?  */
+	  isec = NULL;
+	}
+
+      *ppsection = isec;
+
+      /* Don't output the first, undefined, symbol.  */
+      if (ppsection == finfo->sections)
+	continue;
+
+      if (ELF_ST_TYPE (isym->st_info) == STT_SECTION)
+	{
+	  /* We never output section symbols.  Instead, we use the
+	     section symbol of the corresponding section in the output
+	     file.  */
+	  continue;
+	}
+
+      /* If we are stripping all symbols, we don't want to output this
+	 one.  */
+      if (finfo->info->strip == strip_all)
+	continue;
+
+      /* If we are discarding all local symbols, we don't want to
+	 output this one.  If we are generating a relocateable output
+	 file, then some of the local symbols may be required by
+	 relocs; we output them below as we discover that they are
+	 needed.  */
+      if (finfo->info->discard == discard_all)
+	continue;
+
+      /* If this symbol is defined in a section which we are
+	 discarding, we don't need to keep it, but note that
+	 linker_mark is only reliable for sections that have contents.
+	 For the benefit of the MIPS ELF linker, we check SEC_EXCLUDE
+	 as well as linker_mark.  */
+      if ((isym->st_shndx < SHN_LORESERVE || isym->st_shndx > SHN_HIRESERVE)
+	  && isec != NULL
+	  && ((! isec->linker_mark && (isec->flags & SEC_HAS_CONTENTS) != 0)
+	      || (! finfo->info->relocateable
+		  && (isec->flags & SEC_EXCLUDE) != 0)))
+	continue;
+
+      /* Get the name of the symbol.  */
+      name = bfd_elf_string_from_elf_section (input_bfd, symtab_hdr->sh_link,
+					      isym->st_name);
+      if (name == NULL)
+	return false;
+
+      /* See if we are discarding symbols with this name.  */
+      if ((finfo->info->strip == strip_some
+	   && (bfd_hash_lookup (finfo->info->keep_hash, name, false, false)
+	       == NULL))
+	  || (((finfo->info->discard == discard_sec_merge
+		&& (isec->flags & SEC_MERGE) && ! finfo->info->relocateable)
+	       || finfo->info->discard == discard_l)
+	      && bfd_is_local_label_name (input_bfd, name)))
+	continue;
+
+      /* If we get here, we are going to output this symbol.  */
+
+      osym = *isym;
+
+      /* Adjust the section index for the output file.  */
+      osym.st_shndx = _bfd_elf_section_from_bfd_section (output_bfd,
+							 isec->output_section);
+      if (osym.st_shndx == SHN_BAD)
+	return false;
+
+      *pindex = bfd_get_symcount (output_bfd);
+
+      /* ELF symbols in relocateable files are section relative, but
+	 in executable files they are virtual addresses.  Note that
+	 this code assumes that all ELF sections have an associated
+	 BFD section with a reasonable value for output_offset; below
+	 we assume that they also have a reasonable value for
+	 output_section.  Any special sections must be set up to meet
+	 these requirements.  */
+      osym.st_value += isec->output_offset;
+      if (! finfo->info->relocateable)
+	{
+	  osym.st_value += isec->output_section->vma;
+	  if (ELF_ST_TYPE (osym.st_info) == STT_TLS)
+	    {
+	      /* STT_TLS symbols are relative to PT_TLS segment base.  */
+	      BFD_ASSERT (finfo->first_tls_sec != NULL);
+	      osym.st_value -= finfo->first_tls_sec->vma;
+	    }
+	}
+
+      if (! elf_link_output_sym (finfo, name, &osym, isec))
+	return false;
+    }
+
+  /* Relocate the contents of each section.  */
+  sym_hashes = elf_sym_hashes (input_bfd);
+  for (o = input_bfd->sections; o != NULL; o = o->next)
+    {
+      bfd_byte *contents;
+
+      if (! o->linker_mark)
+	{
+	  /* This section was omitted from the link.  */
+	  continue;
+	}
+
+      if ((o->flags & SEC_HAS_CONTENTS) == 0
+	  || (o->_raw_size == 0 && (o->flags & SEC_RELOC) == 0))
+	continue;
+
+      if ((o->flags & SEC_LINKER_CREATED) != 0)
+	{
+	  /* Section was created by elf_link_create_dynamic_sections
+	     or somesuch.  */
+	  continue;
+	}
+
+      /* Get the contents of the section.  They have been cached by a
+	 relaxation routine.  Note that o is a section in an input
+	 file, so the contents field will not have been set by any of
+	 the routines which work on output files.  */
+      if (elf_section_data (o)->this_hdr.contents != NULL)
+	contents = elf_section_data (o)->this_hdr.contents;
+      else
+	{
+	  contents = finfo->contents;
+	  if (! bfd_get_section_contents (input_bfd, o, contents,
+					  (file_ptr) 0, o->_raw_size))
+	    return false;
+	}
+
+      if ((o->flags & SEC_RELOC) != 0)
+	{
+	  Elf_Internal_Rela *internal_relocs;
+
+	  /* Get the swapped relocs.  */
+	  internal_relocs = (NAME(_bfd_elf,link_read_relocs)
+			     (input_bfd, o, finfo->external_relocs,
+			      finfo->internal_relocs, false));
+	  if (internal_relocs == NULL
+	      && o->reloc_count > 0)
+	    return false;
+
+	  /* Run through the relocs looking for any against symbols
+	     from discarded sections and section symbols from
+	     removed link-once sections.  Complain about relocs
+	     against discarded sections.  Zero relocs against removed
+	     link-once sections.  We should really complain if
+	     anything in the final link tries to use it, but
+	     DWARF-based exception handling might have an entry in
+	     .eh_frame to describe a routine in the linkonce section,
+	     and it turns out to be hard to remove the .eh_frame
+	     entry too.  FIXME.  */
+	  if (!finfo->info->relocateable
+	      && !elf_section_ignore_discarded_relocs (o))
+	    {
+	      Elf_Internal_Rela *rel, *relend;
+
+	      rel = internal_relocs;
+	      relend = rel + o->reloc_count * bed->s->int_rels_per_ext_rel;
+	      for ( ; rel < relend; rel++)
+		{
+		  unsigned long r_symndx = ELF_R_SYM (rel->r_info);
+
+		  if (r_symndx >= locsymcount
+		      || (elf_bad_symtab (input_bfd)
+			  && finfo->sections[r_symndx] == NULL))
+		    {
+		      struct elf_link_hash_entry *h;
+
+		      h = sym_hashes[r_symndx - extsymoff];
+		      while (h->root.type == bfd_link_hash_indirect
+			     || h->root.type == bfd_link_hash_warning)
+			h = (struct elf_link_hash_entry *) h->root.u.i.link;
+
+		      /* Complain if the definition comes from a
+			 discarded section.  */
+		      if ((h->root.type == bfd_link_hash_defined
+			   || h->root.type == bfd_link_hash_defweak)
+			  && elf_discarded_section (h->root.u.def.section))
+			{
+			  if ((o->flags & SEC_DEBUGGING) != 0)
+			    {
+			      BFD_ASSERT (r_symndx != 0);
+			      memset (rel, 0, sizeof (*rel));
+			    }
+			  else
+			    {
+			      if (! ((*finfo->info->callbacks->undefined_symbol)
+				     (finfo->info, h->root.root.string,
+				      input_bfd, o, rel->r_offset,
+				      true)))
+				return false;
+			    }
+			}
+		    }
+		  else
+		    {
+		      asection *sec = finfo->sections[r_symndx];
+
+		      if (sec != NULL && elf_discarded_section (sec))
+			{
+			  if ((o->flags & SEC_DEBUGGING) != 0
+			      || (sec->flags & SEC_LINK_ONCE) != 0)
+			    {
+			      BFD_ASSERT (r_symndx != 0);
+			      rel->r_info
+				= ELF_R_INFO (0, ELF_R_TYPE (rel->r_info));
+			      rel->r_addend = 0;
+			    }
+			  else
+			    {
+			      boolean ok;
+			      const char *msg
+				= _("local symbols in discarded section %s");
+			      bfd_size_type amt
+				= strlen (sec->name) + strlen (msg) - 1;
+			      char *buf = (char *) bfd_malloc (amt);
+
+			      if (buf != NULL)
+				sprintf (buf, msg, sec->name);
+			      else
+				buf = (char *) sec->name;
+			      ok = (*finfo->info->callbacks
+				    ->undefined_symbol) (finfo->info, buf,
+							 input_bfd, o,
+							 rel->r_offset,
+							 true);
+			      if (buf != sec->name)
+				free (buf);
+			      if (!ok)
+				return false;
+			    }
+			}
+		    }
+		}
+	    }
+
+	  /* Relocate the section by invoking a back end routine.
+
+	     The back end routine is responsible for adjusting the
+	     section contents as necessary, and (if using Rela relocs
+	     and generating a relocateable output file) adjusting the
+	     reloc addend as necessary.
+
+	     The back end routine does not have to worry about setting
+	     the reloc address or the reloc symbol index.
+
+	     The back end routine is given a pointer to the swapped in
+	     internal symbols, and can access the hash table entries
+	     for the external symbols via elf_sym_hashes (input_bfd).
+
+	     When generating relocateable output, the back end routine
+	     must handle STB_LOCAL/STT_SECTION symbols specially.  The
+	     output symbol is going to be a section symbol
+	     corresponding to the output section, which will require
+	     the addend to be adjusted.  */
+
+	  if (! (*relocate_section) (output_bfd, finfo->info,
+				     input_bfd, o, contents,
+				     internal_relocs,
+				     isymbuf,
+				     finfo->sections))
+	    return false;
+
+	  if (emit_relocs)
+	    {
+	      Elf_Internal_Rela *irela;
+	      Elf_Internal_Rela *irelaend;
+	      struct elf_link_hash_entry **rel_hash;
+	      Elf_Internal_Shdr *input_rel_hdr, *input_rel_hdr2;
+	      unsigned int next_erel;
+	      boolean (*reloc_emitter) PARAMS ((bfd *, asection *,
+						Elf_Internal_Shdr *,
+						Elf_Internal_Rela *));
+	      boolean rela_normal;
+
+	      input_rel_hdr = &elf_section_data (o)->rel_hdr;
+	      rela_normal = (bed->rela_normal
+			     && (input_rel_hdr->sh_entsize
+				 == sizeof (Elf_External_Rela)));
+
+	      /* Adjust the reloc addresses and symbol indices.  */
+
+	      irela = internal_relocs;
+	      irelaend = irela + o->reloc_count * bed->s->int_rels_per_ext_rel;
+	      rel_hash = (elf_section_data (o->output_section)->rel_hashes
+			  + elf_section_data (o->output_section)->rel_count
+			  + elf_section_data (o->output_section)->rel_count2);
+	      for (next_erel = 0; irela < irelaend; irela++, next_erel++)
+		{
+		  unsigned long r_symndx;
+		  asection *sec;
+		  Elf_Internal_Sym sym;
+
+		  if (next_erel == bed->s->int_rels_per_ext_rel)
+		    {
+		      rel_hash++;
+		      next_erel = 0;
+		    }
+
+		  irela->r_offset += o->output_offset;
+
+		  /* Relocs in an executable have to be virtual addresses.  */
+		  if (!finfo->info->relocateable)
+		    irela->r_offset += o->output_section->vma;
+
+		  r_symndx = ELF_R_SYM (irela->r_info);
+
+		  if (r_symndx == 0)
+		    continue;
+
+		  if (r_symndx >= locsymcount
+		      || (elf_bad_symtab (input_bfd)
+			  && finfo->sections[r_symndx] == NULL))
+		    {
+		      struct elf_link_hash_entry *rh;
+		      unsigned long indx;
+
+		      /* This is a reloc against a global symbol.  We
+			 have not yet output all the local symbols, so
+			 we do not know the symbol index of any global
+			 symbol.  We set the rel_hash entry for this
+			 reloc to point to the global hash table entry
+			 for this symbol.  The symbol index is then
+			 set at the end of elf_bfd_final_link.  */
+		      indx = r_symndx - extsymoff;
+		      rh = elf_sym_hashes (input_bfd)[indx];
+		      while (rh->root.type == bfd_link_hash_indirect
+			     || rh->root.type == bfd_link_hash_warning)
+			rh = (struct elf_link_hash_entry *) rh->root.u.i.link;
+
+		      /* Setting the index to -2 tells
+			 elf_link_output_extsym that this symbol is
+			 used by a reloc.  */
+		      BFD_ASSERT (rh->indx < 0);
+		      rh->indx = -2;
+
+		      *rel_hash = rh;
+
+		      continue;
+		    }
+
+		  /* This is a reloc against a local symbol.  */
+
+		  *rel_hash = NULL;
+		  sym = isymbuf[r_symndx];
+		  sec = finfo->sections[r_symndx];
+		  if (ELF_ST_TYPE (sym.st_info) == STT_SECTION)
+		    {
+		      /* I suppose the backend ought to fill in the
+			 section of any STT_SECTION symbol against a
+			 processor specific section.  If we have
+			 discarded a section, the output_section will
+			 be the absolute section.  */
+		      if (bfd_is_abs_section (sec)
+			  || (sec != NULL
+			      && bfd_is_abs_section (sec->output_section)))
+			r_symndx = 0;
+		      else if (sec == NULL || sec->owner == NULL)
+			{
+			  bfd_set_error (bfd_error_bad_value);
+			  return false;
+			}
+		      else
+			{
+			  r_symndx = sec->output_section->target_index;
+			  BFD_ASSERT (r_symndx != 0);
+			}
+
+		      /* Adjust the addend according to where the
+			 section winds up in the output section.  */
+		      if (rela_normal)
+			irela->r_addend += sec->output_offset;
+		    }
+		  else
+		    {
+		      if (finfo->indices[r_symndx] == -1)
+			{
+			  unsigned long shlink;
+			  const char *name;
+			  asection *osec;
+
+			  if (finfo->info->strip == strip_all)
+			    {
+			      /* You can't do ld -r -s.  */
+			      bfd_set_error (bfd_error_invalid_operation);
+			      return false;
+			    }
+
+			  /* This symbol was skipped earlier, but
+			     since it is needed by a reloc, we
+			     must output it now.  */
+			  shlink = symtab_hdr->sh_link;
+			  name = (bfd_elf_string_from_elf_section
+				  (input_bfd, shlink, sym.st_name));
+			  if (name == NULL)
+			    return false;
+
+			  osec = sec->output_section;
+			  sym.st_shndx =
+			    _bfd_elf_section_from_bfd_section (output_bfd,
+							       osec);
+			  if (sym.st_shndx == SHN_BAD)
+			    return false;
+
+			  sym.st_value += sec->output_offset;
+#if 0
+			  if (! finfo->info->relocateable)
+			    {
+			      sym.st_value += osec->vma;
+			      if (ELF_ST_TYPE (sym.st_info) == STT_TLS)
+				{
+				  /* STT_TLS symbols are relative to PT_TLS
+				     segment base.  */
+				  BFD_ASSERT (finfo->first_tls_sec != NULL);
+				  sym.st_value -= finfo->first_tls_sec->vma;
+				}
+			    }
+#endif
+
+			  finfo->indices[r_symndx]
+			    = bfd_get_symcount (output_bfd);
+
+			  if (! elf_link_output_sym (finfo, name, &sym, sec))
+			    return false;
+			}
+
+		      r_symndx = finfo->indices[r_symndx];
+		    }
+
+		  irela->r_info = ELF_R_INFO (r_symndx,
+					      ELF_R_TYPE (irela->r_info));
+		}
+
+	      /* Swap out the relocs.  */
+	      if (bed->elf_backend_emit_relocs
+		  && !(finfo->info->relocateable
+		       || finfo->info->emitrelocations))
+		reloc_emitter = bed->elf_backend_emit_relocs;
+	      else
+		reloc_emitter = elf_link_output_relocs;
+
+	      if (input_rel_hdr->sh_size != 0
+		  && ! (*reloc_emitter) (output_bfd, o, input_rel_hdr,
+					 internal_relocs))
+		return false;
+
+	      input_rel_hdr2 = elf_section_data (o)->rel_hdr2;
+	      if (input_rel_hdr2 && input_rel_hdr2->sh_size != 0)
+		{
+		  internal_relocs += (NUM_SHDR_ENTRIES (input_rel_hdr)
+				      * bed->s->int_rels_per_ext_rel);
+		  if (! (*reloc_emitter) (output_bfd, o, input_rel_hdr2,
+					  internal_relocs))
+		    return false;
+		}
+	    }
+	}
+
+      /* Write out the modified section contents.  */
+      if (bed->elf_backend_write_section
+	  && (*bed->elf_backend_write_section) (output_bfd, o, contents))
+	{
+	  /* Section written out.  */
+	}
+      else switch (elf_section_data (o)->sec_info_type)
+	{
+	case ELF_INFO_TYPE_STABS:
+	  if (! (_bfd_write_section_stabs
+		 (output_bfd,
+		  &elf_hash_table (finfo->info)->stab_info,
+		  o, &elf_section_data (o)->sec_info, contents)))
+	    return false;
+	  break;
+	case ELF_INFO_TYPE_MERGE:
+	  if (! (_bfd_write_merged_section
+		 (output_bfd, o, elf_section_data (o)->sec_info)))
+	    return false;
+	  break;
+	case ELF_INFO_TYPE_EH_FRAME:
+	  {
+	    asection *ehdrsec;
+
+	    ehdrsec
+	      = bfd_get_section_by_name (elf_hash_table (finfo->info)->dynobj,
+					 ".eh_frame_hdr");
+	    if (! (_bfd_elf_write_section_eh_frame (output_bfd, o, ehdrsec,
+						    contents)))
+	      return false;
+	  }
+	  break;
+	default:
+	  {
+	    bfd_size_type sec_size;
+
+	    sec_size = (o->_cooked_size != 0 ? o->_cooked_size : o->_raw_size);
+	    if (! (o->flags & SEC_EXCLUDE)
+		&& ! bfd_set_section_contents (output_bfd, o->output_section,
+					       contents,
+					       (file_ptr) o->output_offset,
+					       sec_size))
+	      return false;
+	  }
+	  break;
+	}
+    }
+
+  return true;
+}
+
+/* Generate a reloc when linking an ELF file.  This is a reloc
+   requested by the linker, and does come from any input file.  This
+   is used to build constructor and destructor tables when linking
+   with -Ur.  */
+
+static boolean
+elf_reloc_link_order (output_bfd, info, output_section, link_order)
+     bfd *output_bfd;
+     struct bfd_link_info *info;
+     asection *output_section;
+     struct bfd_link_order *link_order;
+{
+  reloc_howto_type *howto;
+  long indx;
+  bfd_vma offset;
+  bfd_vma addend;
+  struct elf_link_hash_entry **rel_hash_ptr;
+  Elf_Internal_Shdr *rel_hdr;
+  struct elf_backend_data *bed = get_elf_backend_data (output_bfd);
+
+  howto = bfd_reloc_type_lookup (output_bfd, link_order->u.reloc.p->reloc);
+  if (howto == NULL)
+    {
+      bfd_set_error (bfd_error_bad_value);
+      return false;
+    }
+
+  addend = link_order->u.reloc.p->addend;
+
+  /* Figure out the symbol index.  */
+  rel_hash_ptr = (elf_section_data (output_section)->rel_hashes
+		  + elf_section_data (output_section)->rel_count
+		  + elf_section_data (output_section)->rel_count2);
+  if (link_order->type == bfd_section_reloc_link_order)
+    {
+      indx = link_order->u.reloc.p->u.section->target_index;
+      BFD_ASSERT (indx != 0);
+      *rel_hash_ptr = NULL;
+    }
+  else
+    {
+      struct elf_link_hash_entry *h;
+
+      /* Treat a reloc against a defined symbol as though it were
+	 actually against the section.  */
+      h = ((struct elf_link_hash_entry *)
+	   bfd_wrapped_link_hash_lookup (output_bfd, info,
+					 link_order->u.reloc.p->u.name,
+					 false, false, true));
+      if (h != NULL
+	  && (h->root.type == bfd_link_hash_defined
+	      || h->root.type == bfd_link_hash_defweak))
+	{
+	  asection *section;
+
+	  section = h->root.u.def.section;
+	  indx = section->output_section->target_index;
+	  *rel_hash_ptr = NULL;
+	  /* It seems that we ought to add the symbol value to the
+	     addend here, but in practice it has already been added
+	     because it was passed to constructor_callback.  */
+	  addend += section->output_section->vma + section->output_offset;
+	}
+      else if (h != NULL)
+	{
+	  /* Setting the index to -2 tells elf_link_output_extsym that
+	     this symbol is used by a reloc.  */
+	  h->indx = -2;
+	  *rel_hash_ptr = h;
+	  indx = 0;
+	}
+      else
+	{
+	  if (! ((*info->callbacks->unattached_reloc)
+		 (info, link_order->u.reloc.p->u.name, (bfd *) NULL,
+		  (asection *) NULL, (bfd_vma) 0)))
+	    return false;
+	  indx = 0;
+	}
+    }
+
+  /* If this is an inplace reloc, we must write the addend into the
+     object file.  */
+  if (howto->partial_inplace && addend != 0)
+    {
+      bfd_size_type size;
+      bfd_reloc_status_type rstat;
+      bfd_byte *buf;
+      boolean ok;
+      const char *sym_name;
+
+      size = bfd_get_reloc_size (howto);
+      buf = (bfd_byte *) bfd_zmalloc (size);
+      if (buf == (bfd_byte *) NULL)
+	return false;
+      rstat = _bfd_relocate_contents (howto, output_bfd, (bfd_vma) addend, buf);
+      switch (rstat)
+	{
+	case bfd_reloc_ok:
+	  break;
+
+	default:
+	case bfd_reloc_outofrange:
+	  abort ();
+
+	case bfd_reloc_overflow:
+	  if (link_order->type == bfd_section_reloc_link_order)
+	    sym_name = bfd_section_name (output_bfd,
+					 link_order->u.reloc.p->u.section);
+	  else
+	    sym_name = link_order->u.reloc.p->u.name;
+	  if (! ((*info->callbacks->reloc_overflow)
+		 (info, sym_name, howto->name, addend,
+		  (bfd *) NULL, (asection *) NULL, (bfd_vma) 0)))
+	    {
+	      free (buf);
+	      return false;
+	    }
+	  break;
+	}
+      ok = bfd_set_section_contents (output_bfd, output_section, (PTR) buf,
+				     (file_ptr) link_order->offset, size);
+      free (buf);
+      if (! ok)
+	return false;
+    }
+
+  /* The address of a reloc is relative to the section in a
+     relocateable file, and is a virtual address in an executable
+     file.  */
+  offset = link_order->offset;
+  if (! info->relocateable)
+    offset += output_section->vma;
+
+  rel_hdr = &elf_section_data (output_section)->rel_hdr;
+
+  if (rel_hdr->sh_type == SHT_REL)
+    {
+      bfd_size_type size;
+      Elf_Internal_Rel *irel;
+      Elf_External_Rel *erel;
+      unsigned int i;
+
+      size = bed->s->int_rels_per_ext_rel * sizeof (Elf_Internal_Rel);
+      irel = (Elf_Internal_Rel *) bfd_zmalloc (size);
+      if (irel == NULL)
+	return false;
+
+      for (i = 0; i < bed->s->int_rels_per_ext_rel; i++)
+	irel[i].r_offset = offset;
+      irel[0].r_info = ELF_R_INFO (indx, howto->type);
+
+      erel = ((Elf_External_Rel *) rel_hdr->contents
+	      + elf_section_data (output_section)->rel_count);
+
+      if (bed->s->swap_reloc_out)
+	(*bed->s->swap_reloc_out) (output_bfd, irel, (bfd_byte *) erel);
+      else
+	elf_swap_reloc_out (output_bfd, irel, erel);
+
+      free (irel);
+    }
+  else
+    {
+      bfd_size_type size;
+      Elf_Internal_Rela *irela;
+      Elf_External_Rela *erela;
+      unsigned int i;
+
+      size = bed->s->int_rels_per_ext_rel * sizeof (Elf_Internal_Rela);
+      irela = (Elf_Internal_Rela *) bfd_zmalloc (size);
+      if (irela == NULL)
+	return false;
+
+      for (i = 0; i < bed->s->int_rels_per_ext_rel; i++)
+	irela[i].r_offset = offset;
+      irela[0].r_info = ELF_R_INFO (indx, howto->type);
+      irela[0].r_addend = addend;
+
+      erela = ((Elf_External_Rela *) rel_hdr->contents
+	       + elf_section_data (output_section)->rel_count);
+
+      if (bed->s->swap_reloca_out)
+	(*bed->s->swap_reloca_out) (output_bfd, irela, (bfd_byte *) erela);
+      else
+	elf_swap_reloca_out (output_bfd, irela, erela);
+    }
+
+  ++elf_section_data (output_section)->rel_count;
+
+  return true;
+}
+
+static boolean
+elf_section_ignore_discarded_relocs (sec)
+     asection *sec;
+{
+  struct elf_backend_data *bed;
+
+  switch (elf_section_data (sec)->sec_info_type)
+    {
+    case ELF_INFO_TYPE_STABS:
+    case ELF_INFO_TYPE_EH_FRAME:
+      return true;
+    default:
+      break;
+    }
+
+  bed = get_elf_backend_data (sec->owner);
+  if (bed->elf_backend_ignore_discarded_relocs != NULL
+      && (*bed->elf_backend_ignore_discarded_relocs) (sec))
+    return true;
+
+  return false;
+}
+
+#define TARGET_BIG_SYM		bfd_elf32_morphos_vec
+#define TARGET_BIG_NAME		"elf32-morphos"
+#define ELF_ARCH		bfd_arch_powerpc
+#define ELF_MACHINE_CODE	EM_PPC
+#define ELF_MAXPAGESIZE		0x10000
+#define elf_info_to_howto	ppc_elf_info_to_howto
+
+#ifdef  EM_CYGNUS_POWERPC
+#define ELF_MACHINE_ALT1	EM_CYGNUS_POWERPC
+#endif
+
+#ifdef EM_PPC_OLD
+#define ELF_MACHINE_ALT2	EM_PPC_OLD
+#endif
+
+#define elf_backend_plt_not_loaded	1
+#define elf_backend_got_symbol_offset	4
+#define elf_backend_can_gc_sections	1
+#define elf_backend_can_refcount	1
+#define elf_backend_got_header_size	12
+#define elf_backend_plt_header_size	PLT_INITIAL_ENTRY_SIZE
+#define elf_backend_rela_normal		1
+
+#define bfd_elf32_bfd_merge_private_bfd_data	ppc_elf_merge_private_bfd_data
+#define bfd_elf32_bfd_relax_section             ppc_elf_relax_section
+#define bfd_elf32_bfd_reloc_type_lookup		ppc_elf_reloc_type_lookup
+#define bfd_elf32_bfd_set_private_flags		ppc_elf_set_private_flags
+/*#define bfd_elf32_bfd_final_link		_bfd_elf32_gc_common_final_link*/
+#define bfd_elf32_bfd_final_link                ppc_elf_final_link
+
+#define elf_backend_object_p			ppc_elf_object_p
+#define elf_backend_gc_mark_hook		ppc_elf_gc_mark_hook
+#define elf_backend_gc_sweep_hook		ppc_elf_gc_sweep_hook
+#define elf_backend_section_from_shdr		ppc_elf_section_from_shdr
+#define elf_backend_relocate_section		ppc_elf_relocate_section
+#define elf_backend_create_dynamic_sections	ppc_elf_create_dynamic_sections
+#define elf_backend_check_relocs		ppc_elf_check_relocs
+#define elf_backend_adjust_dynamic_symbol	ppc_elf_adjust_dynamic_symbol
+/*#define elf_backend_add_symbol_hook		ppc_elf_add_symbol_hook*/
+#define elf_backend_size_dynamic_sections	ppc_elf_size_dynamic_sections
+#define elf_backend_finish_dynamic_symbol	ppc_elf_finish_dynamic_symbol
+#define elf_backend_finish_dynamic_sections	ppc_elf_finish_dynamic_sections
+#define elf_backend_fake_sections		ppc_elf_fake_sections
+#define elf_backend_additional_program_headers	ppc_elf_additional_program_headers
+#define elf_backend_modify_segment_map		ppc_elf_modify_segment_map
+#define elf_backend_grok_prstatus		ppc_elf_grok_prstatus
+#define elf_backend_grok_psinfo			ppc_elf_grok_psinfo
+#define elf_backend_reloc_type_class		ppc_elf_reloc_type_class
+
+#include "elf32-target.h"
diff --git a/bfd/elf32-ppc.c b/bfd/elf32-ppc.c
index 6454a8350da35adf6ed1e2209d9e4774ab7c50e3..5c92c53da7b3dec8f85a0a0b930190635f89dcfb 100644
--- bfd/elf32-ppc.c
+++ bfd/elf32-ppc.c
@@ -4412,12 +4412,16 @@ ppc_elf_check_relocs (bfd *abfd,
 	      p->count += 1;
 	      if (!must_be_dyn_reloc (info, r_type))
 		p->pc_count += 1;
 	    }
 
 	  break;
+
+	default:
+		fprintf(stderr,"Switch case not handled!\n");
+		break;
 	}
     }
 
   return TRUE;
 }
 
diff --git a/bfd/hosts/amigaos.h b/bfd/hosts/amigaos.h
new file mode 100644
index 0000000000000000000000000000000000000000..dc62d7f837f333ae8d2c5b47d01144cb0d3625f2
--- /dev/null
+++ bfd/hosts/amigaos.h
@@ -0,0 +1,5 @@
+/* Host configuration for AmigaOS */
+#ifndef hosts_amigaos_h
+#define hosts_amigaos_h
+#include "hosts/std-host.h"
+#endif /* hosts_amigaos_h */
diff --git a/bfd/hosts/morphos.h b/bfd/hosts/morphos.h
new file mode 100644
index 0000000000000000000000000000000000000000..d3c60ea9f5767ad0bfa22ba2c8c1e5ed9d94d481
--- /dev/null
+++ bfd/hosts/morphos.h
@@ -0,0 +1,5 @@
+/* Host configuration for MorphOS */
+#ifndef hosts_morphos_h
+#define hosts_morphos_h
+#include "hosts/std-host.h"
+#endif /* hosts_morphos_h */
diff --git a/bfd/libamiga.h b/bfd/libamiga.h
new file mode 100644
index 0000000000000000000000000000000000000000..351f0fa16a45680982f5b5807c8ba756defe1764
--- /dev/null
+++ bfd/libamiga.h
@@ -0,0 +1,187 @@
+/* BFD back-end for Commodore-Amiga AmigaOS binaries. Data structures.
+   Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 1998
+   Free Software Foundation, Inc.
+   Contributed by Leonard Norrgard.
+   Extended by Stephan Thesing 11/1994.
+
+This file is part of BFD, the Binary File Descriptor library.
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */
+
+/* Hunk ID numbers.  */
+
+#define HUNK_UNIT		999
+#define HUNK_NAME		1000
+#define HUNK_CODE		1001
+#define HUNK_DATA		1002
+#define HUNK_BSS		1003
+#define HUNK_RELOC32		1004
+#define HUNK_ABSRELOC32		HUNK_RELOC32
+#define HUNK_RELOC16		1005
+#define HUNK_RELRELOC16		HUNK_RELOC16
+#define HUNK_RELOC8		1006
+#define HUNK_RELRELOC8		HUNK_RELOC8
+#define HUNK_EXT		1007
+#define HUNK_SYMBOL		1008
+#define HUNK_DEBUG		1009
+#define HUNK_END		1010
+#define HUNK_HEADER		1011
+#define HUNK_OVERLAY		1013
+#define HUNK_BREAK		1014
+#define HUNK_DREL32		1015
+#define HUNK_DREL16		1016
+#define HUNK_DREL8		1017
+#define HUNK_LIB		1018
+#define HUNK_INDEX		1019
+#define HUNK_RELOC32SHORT	1020
+#define HUNK_RELRELOC32		1021
+#define HUNK_ABSRELOC16		1022
+/* EHF extensions */
+#define HUNK_PPC_CODE		1257
+#define HUNK_RELRELOC26		1260
+
+/* The hunk ID part.  */
+
+#define HUNK_VALUE(hunk_id)	((hunk_id) & 0x3fffffff)
+
+/* Attributes of a hunk.  */
+
+#define HUNK_ATTRIBUTE(hunk_id)	((hunk_id) >> 30)
+#define HUNK_ATTR_CHIP 		0x01	/* hunk content must go into chip ram */
+#define HUNK_ATTR_FAST		0x02	/* fast */
+#define HUNK_ATTR_FOLLOWS	0x03	/* mem id follows */
+
+/* HUNK_EXT subtypes.  */
+
+#define EXT_SYMB		0
+#define EXT_DEF			1
+#define EXT_ABS			2
+#define EXT_RES			3
+#define EXT_REF32		129
+#define EXT_ABSREF32		EXT_REF32
+#define EXT_COMMON		130
+#define EXT_ABSCOMMON		EXT_COMMON
+#define EXT_REF16		131
+#define EXT_RELREF16		EXT_REF16
+#define EXT_REF8		132
+#define EXT_RELREF8		EXT_REF8
+#define EXT_DEXT32		133
+#define EXT_DEXT16		134
+#define EXT_DEXT8		135
+#define EXT_RELREF32		136
+#define EXT_RELCOMMON		137
+#define EXT_ABSREF16		138
+#define EXT_ABSREF8		139
+/* VBCC extensions */
+#define EXT_DEXT32COMMON	208
+#define EXT_DEXT16COMMON	209
+#define EXT_DEXT8COMMON		210
+/* EHF extensions */
+#define EXT_RELREF26		229
+
+/* HOWTO types almost matching aoutx.h/howto_table_std.  */
+
+enum {
+  H_ABS8=0,H_ABS16,H_ABS32,H_ABS32SHORT,H_PC8,H_PC16,H_PC32,H_PC26,H_SD8,H_SD16,H_SD32
+};
+
+/* Various structures.  */
+
+typedef struct amiga_reloc {
+  arelent relent;
+  struct amiga_reloc *next;
+  asymbol *symbol;
+} amiga_reloc_type;
+
+/* Structure layout *must* match libaout.h/struct aout_symbol.  */
+
+typedef struct amiga_symbol {
+  asymbol symbol;
+  short desc;
+  char other;
+  unsigned char type;
+  /* amiga data */
+  unsigned long index,refnum;
+} amiga_symbol_type;
+
+/* We take the address of the first element of an asymbol to ensure that the
+   macro is only ever applied to an asymbol.  */
+#define amiga_symbol(asymbol) ((amiga_symbol_type *)(&(asymbol)->the_bfd))
+
+typedef struct raw_reloc {
+  unsigned long num,pos;
+  struct raw_reloc *next;
+} raw_reloc_type;
+
+typedef struct amiga_per_section {
+  amiga_reloc_type *reloc_tail; /* last reloc, first is in section->relocation */
+  int attribute; /* Memory type required by this section */
+  unsigned long disk_size; /* Section size on disk, _raw_size may be larger than this */
+  amiga_symbol_type *amiga_symbols; /* the symbols for this section */
+  unsigned long hunk_ext_pos; /* offset of hunk_ext in the bfd file */
+  unsigned long hunk_symbol_pos; /* offset of hunk_symbol in the bfd file */
+  raw_reloc_type *relocs;
+} amiga_per_section_type;
+
+#define amiga_per_section(x) ((amiga_per_section_type *)((x)->used_by_bfd))
+
+/* Structure layout *must* match libaout.h/struct aoutdata.  */
+
+struct amiga_data {
+  char *dummy[2];
+  sec_ptr textsec;
+  sec_ptr datasec;
+  sec_ptr bsssec;
+  file_ptr sym_filepos;
+  file_ptr str_filepos;
+  /* rest intentionally omitted */
+};
+
+typedef struct amiga_data_struct {
+  struct amiga_data a;
+  unsigned long symtab_size;
+  unsigned long stringtab_size;
+  amiga_symbol_type *symbols;
+  bfd_boolean IsLoadFile; /* If true, this is a load file (for output bfd only) */
+  unsigned int nb_hunks;
+  /* The next two fields are set at final_link time (for the output bfd only) */
+  bfd_boolean baserel;/* true if there is ___init_a4 in the global hash table */
+  bfd_vma a4init;     /* cache the value for efficiency */
+} amiga_data_type;
+
+#define adata(bfd)	((bfd)->tdata.amiga_data->a)
+#define AMIGA_DATA(bfd)	((bfd)->tdata.amiga_data)
+
+#define HUNKB_ADVISORY	29
+#define HUNKB_CHIP	30
+#define HUNKB_FAST	31
+#define HUNKF_ADVISORY	(1L << HUNKB_ADVISORY)
+#define HUNKF_CHIP	(1L << HUNKB_CHIP)
+#define HUNKF_FAST	(1L << HUNKB_FAST)
+
+#ifndef MEMF_ANY
+#define MEMF_ANY	(0L)
+#define MEMF_PUBLIC	(1L << 0)
+#define MEMF_CHIP	(1L << 1)
+#define MEMF_FAST	(1L << 2)
+#define MEMF_LOCAL	(1L << 8)
+#define MEMF_24BITDMA	(1L << 9)
+#define MEMF_KICK	(1L << 10)
+#define MEMF_CLEAR	(1L << 16)
+#define MEMF_LARGEST	(1L << 17)
+#define MEMF_REVERSE	(1L << 18)
+#define MEMF_TOTAL	(1L << 19)
+#define MEMF_NO_EXPUNGE	(1L << 31)
+#endif /* MEMF_ANY */
diff --git a/bfd/libbfd.h b/bfd/libbfd.h
index 6c48d641f606b9ed6158b4567021769bacfbd54a..3cb9b36fe2379a5d7f118472e106c151d6153aea 100644
--- bfd/libbfd.h
+++ bfd/libbfd.h
@@ -1345,12 +1345,16 @@ static const char *const bfd_reloc_code_real_names[] = { "@@uninitialized@@",
   "BFD_RELOC_PPC_EMB_RELSEC16",
   "BFD_RELOC_PPC_EMB_RELST_LO",
   "BFD_RELOC_PPC_EMB_RELST_HI",
   "BFD_RELOC_PPC_EMB_RELST_HA",
   "BFD_RELOC_PPC_EMB_BIT_FLD",
   "BFD_RELOC_PPC_EMB_RELSDA",
+  "BFD_RELOC_PPC_MORPHOS_DREL",
+  "BFD_RELOC_PPC_MORPHOS_DREL_LO",
+  "BFD_RELOC_PPC_MORPHOS_DREL_HI",
+  "BFD_RELOC_PPC_MORPHOS_DREL_HA",
   "BFD_RELOC_PPC_VLE_REL8",
   "BFD_RELOC_PPC_VLE_REL15",
   "BFD_RELOC_PPC_VLE_REL24",
   "BFD_RELOC_PPC_VLE_LO16A",
   "BFD_RELOC_PPC_VLE_LO16D",
   "BFD_RELOC_PPC_VLE_HI16A",
@@ -1427,12 +1431,16 @@ static const char *const bfd_reloc_code_real_names[] = { "@@uninitialized@@",
   "BFD_RELOC_PPC64_DTPREL16_DS",
   "BFD_RELOC_PPC64_DTPREL16_LO_DS",
   "BFD_RELOC_PPC64_DTPREL16_HIGHER",
   "BFD_RELOC_PPC64_DTPREL16_HIGHERA",
   "BFD_RELOC_PPC64_DTPREL16_HIGHEST",
   "BFD_RELOC_PPC64_DTPREL16_HIGHESTA",
+  "BFD_RELOC_PPC_AMIGAOS_BREL",
+  "BFD_RELOC_PPC_AMIGAOS_BREL_LO",
+  "BFD_RELOC_PPC_AMIGAOS_BREL_HI",
+  "BFD_RELOC_PPC_AMIGAOS_BREL_HA",
   "BFD_RELOC_I370_D12",
   "BFD_RELOC_CTOR",
   "BFD_RELOC_ARM_PCREL_BRANCH",
   "BFD_RELOC_ARM_PCREL_BLX",
   "BFD_RELOC_THUMB_PCREL_BLX",
   "BFD_RELOC_ARM_PCREL_CALL",
diff --git a/bfd/linker.c b/bfd/linker.c
index d3ef9a43a5bca8096221870248daf58007c6ef78..4f0aa188f5017ea68023530f6ae9eaa6b98b5b11 100644
--- bfd/linker.c
+++ bfd/linker.c
@@ -430,13 +430,14 @@ static bfd_boolean generic_link_add_symbol_list
   (bfd *, struct bfd_link_info *, bfd_size_type count, asymbol **,
    bfd_boolean);
 static bfd_boolean generic_add_output_symbol
   (bfd *, size_t *psymalloc, asymbol *);
 static bfd_boolean default_data_link_order
   (bfd *, struct bfd_link_info *, asection *, struct bfd_link_order *);
-static bfd_boolean default_indirect_link_order
+/*Amiga hack - used in amigaoslink.c so must be global */
+/*static*/ bfd_boolean default_indirect_link_order
   (bfd *, struct bfd_link_info *, asection *, struct bfd_link_order *,
    bfd_boolean);
 
 /* The link hash table structure is defined in bfdlink.h.  It provides
    a base hash table which the backend specific hash tables are built
    upon.  */
@@ -1294,12 +1295,19 @@ generic_link_check_archive_element (bfd *abfd,
 	    return FALSE;
 
 	  size = bfd_asymbol_value (p);
 	  h->u.c.size = size;
 
 	  power = bfd_log2 (size);
+	  /* For the amiga, we don't want an alignment bigger than 2**2.
+	     Doing this here is horrible kludgy, but IMHO the maximal
+	     power alignment really should be target-dependant so that
+	     we wouldn't have to do this -- daniel */
+	  if (info->output_bfd->xvec->flavour == bfd_target_amiga_flavour
+	      && power > 2)
+	    power = 2;
 	  if (power > 4)
 	    power = 4;
 	  h->u.c.p->alignment_power = power;
 
 	  if (p->section == bfd_com_section_ptr)
 	    h->u.c.p->section = bfd_make_section_old_way (symbfd, "COMMON");
@@ -1746,12 +1754,19 @@ _bfd_generic_link_add_one_symbol (struct bfd_link_info *info,
 	  /* Select a default alignment based on the size.  This may
              be overridden by the caller.  */
 	  {
 	    unsigned int power;
 
 	    power = bfd_log2 (value);
+	    /* For the amiga, we don't want an alignment bigger than 2**2.
+	       Doing this here is horrible kludgy, but IMHO the maximal
+	       power alignment really should be target-dependant so that
+	       we wouldn't have to do this -- daniel */
+	    if (info->output_bfd->xvec->flavour == bfd_target_amiga_flavour
+		&& power > 2)
+	      power = 2;
 	    if (power > 4)
 	      power = 4;
 	    h->u.c.p->alignment_power = power;
 	  }
 
 	  /* The section of a common symbol is only used if the common
@@ -1799,12 +1814,19 @@ _bfd_generic_link_add_one_symbol (struct bfd_link_info *info,
 
 	      h->u.c.size = value;
 
 	      /* Select a default alignment based on the size.  This may
 		 be overridden by the caller.  */
 	      power = bfd_log2 (value);
+	      /* For the amiga, we don't want an alignment bigger than 2**2.
+		 Doing this here is horrible kludgy, but IMHO the maximal
+		 power alignment really should be target-dependant so that
+		 we wouldn't have to do this -- daniel */
+	      if (info->output_bfd->xvec->flavour == bfd_target_amiga_flavour
+		  && power > 2)
+		power = 2;
 	      if (power > 4)
 		power = 4;
 	      h->u.c.p->alignment_power = power;
 
 	      /* Some systems have special treatment for small commons,
 		 hence we want to select the section used by the larger
@@ -2709,13 +2731,13 @@ default_data_link_order (bfd *abfd,
     free (fill);
   return result;
 }
 
 /* Default routine to handle a bfd_indirect_link_order.  */
 
-static bfd_boolean
+/*static*/ bfd_boolean
 default_indirect_link_order (bfd *output_bfd,
 			     struct bfd_link_info *info,
 			     asection *output_section,
 			     struct bfd_link_order *link_order,
 			     bfd_boolean generic_linker)
 {
diff --git a/bfd/reloc.c b/bfd/reloc.c
index 47d052d1345847a7178f4c7ebe4f529396ae0a4f..6c3bb68f2da65b201b6288b8709fd60d9b0d5b2c 100644
--- bfd/reloc.c
+++ bfd/reloc.c
@@ -2803,12 +2803,20 @@ ENUMX
   BFD_RELOC_PPC_EMB_RELST_HA
 ENUMX
   BFD_RELOC_PPC_EMB_BIT_FLD
 ENUMX
   BFD_RELOC_PPC_EMB_RELSDA
 ENUMX
+  BFD_RELOC_PPC_MORPHOS_DREL
+ENUMX
+  BFD_RELOC_PPC_MORPHOS_DREL_LO
+ENUMX
+  BFD_RELOC_PPC_MORPHOS_DREL_HI
+ENUMX
+  BFD_RELOC_PPC_MORPHOS_DREL_HA
+ENUMX
   BFD_RELOC_PPC_VLE_REL8
 ENUMX
   BFD_RELOC_PPC_VLE_REL15
 ENUMX
   BFD_RELOC_PPC_VLE_REL24
 ENUMX
@@ -2973,12 +2981,23 @@ ENUMX
 ENUMX
   BFD_RELOC_PPC64_DTPREL16_HIGHESTA
 ENUMDOC
   PowerPC and PowerPC64 thread-local storage relocations.
 
 ENUM
+  BFD_RELOC_PPC_AMIGAOS_BREL
+ENUMX
+  BFD_RELOC_PPC_AMIGAOS_BREL_LO
+ENUMX
+  BFD_RELOC_PPC_AMIGAOS_BREL_HI
+ENUMX
+  BFD_RELOC_PPC_AMIGAOS_BREL_HA
+ENUMDOC
+  AmigaOS4 PowerPC specific base-relative relocations.
+
+ENUM
   BFD_RELOC_I370_D12
 ENUMDOC
   IBM 370/390 relocations
 
 ENUM
   BFD_RELOC_CTOR
diff --git a/bfd/targets.c b/bfd/targets.c
index fa206d24bef3a22255f6be42221647db3142eb06..9df24504bab564048f724fbbb641ca13c5805602 100644
--- bfd/targets.c
+++ bfd/targets.c
@@ -144,12 +144,13 @@ DESCRIPTION
 	the entry points which call them. Too bad we can't have one
 	macro to define them both!
 
 .enum bfd_flavour
 .{
 .  bfd_target_unknown_flavour,
+.  bfd_target_amiga_flavour,
 .  bfd_target_aout_flavour,
 .  bfd_target_coff_flavour,
 .  bfd_target_ecoff_flavour,
 .  bfd_target_xcoff_flavour,
 .  bfd_target_elf_flavour,
 .  bfd_target_ieee_flavour,
@@ -568,12 +569,14 @@ to find an alternative output format that is suitable.
 /* All known xvecs (even those that don't compile on all systems).
    Alphabetized for easy reference.
    They are listed a second time below, since
    we can't intermix extern's and initializers.  */
 extern const bfd_target a_out_adobe_vec;
 extern const bfd_target aix5coff64_vec;
+extern const bfd_target amiga_vec;
+extern const bfd_target aout_amiga_vec;
 extern const bfd_target aout0_big_vec;
 extern const bfd_target aout_arm_big_vec;
 extern const bfd_target aout_arm_little_vec;
 extern const bfd_target aout_mips_big_vec;
 extern const bfd_target aout_mips_little_vec;
 extern const bfd_target apollocoff_vec;
@@ -592,12 +595,13 @@ extern const bfd_target armpe_big_vec;
 extern const bfd_target armpe_little_vec;
 extern const bfd_target armpei_big_vec;
 extern const bfd_target armpei_little_vec;
 extern const bfd_target b_out_vec_big_host;
 extern const bfd_target b_out_vec_little_host;
 extern const bfd_target bfd_pei_ia64_vec;
+extern const bfd_target bfd_elf32_amigaos_vec;
 extern const bfd_target bfd_elf32_avr_vec;
 extern const bfd_target bfd_elf32_bfin_vec;
 extern const bfd_target bfd_elf32_bfinfdpic_vec;
 extern const bfd_target bfd_elf32_big_generic_vec;
 extern const bfd_target bfd_elf32_bigarc_vec;
 extern const bfd_target bfd_elf32_bigarm_vec;
@@ -625,12 +629,13 @@ extern const bfd_target bfd_elf32_hppa_vec;
 extern const bfd_target bfd_elf32_i370_vec;
 extern const bfd_target bfd_elf32_i386_freebsd_vec;
 extern const bfd_target bfd_elf32_i386_nacl_vec;
 extern const bfd_target bfd_elf32_i386_sol2_vec;
 extern const bfd_target bfd_elf32_i386_vxworks_vec;
 extern const bfd_target bfd_elf32_i386_vec;
+extern const bfd_target bfd_elf32_i386be_amithlon_vec;
 extern const bfd_target bfd_elf32_i860_little_vec;
 extern const bfd_target bfd_elf32_i860_vec;
 extern const bfd_target bfd_elf32_i960_vec;
 extern const bfd_target bfd_elf32_ia64_big_vec;
 extern const bfd_target bfd_elf32_ia64_hpux_big_vec;
 extern const bfd_target bfd_elf32_ip2k_vec;
@@ -658,12 +663,13 @@ extern const bfd_target bfd_elf32_mcore_big_vec;
 extern const bfd_target bfd_elf32_mcore_little_vec;
 extern const bfd_target bfd_elf32_mep_vec;
 extern const bfd_target bfd_elf32_mep_little_vec;
 extern const bfd_target bfd_elf32_microblaze_vec;
 extern const bfd_target bfd_elf32_mn10200_vec;
 extern const bfd_target bfd_elf32_mn10300_vec;
+extern const bfd_target bfd_elf32_morphos_vec;
 extern const bfd_target bfd_elf32_mt_vec;
 extern const bfd_target bfd_elf32_msp430_vec;
 extern const bfd_target bfd_elf32_nbigmips_vec;
 extern const bfd_target bfd_elf32_nlittlemips_vec;
 extern const bfd_target bfd_elf32_ntradbigmips_vec;
 extern const bfd_target bfd_elf32_ntradlittlemips_vec;
@@ -929,12 +935,14 @@ static const bfd_target * const _bfd_target_vector[] =
 	   should have an entry here with #if 0 around it, to show that
 	   it wasn't omitted by mistake.  */
 	&a_out_adobe_vec,
 #ifdef BFD64
 	&aix5coff64_vec,
 #endif
+	&amiga_vec,
+	&aout_amiga_vec,
 	&aout0_big_vec,
 #if 0
 	/* We have no way of distinguishing these from other a.out variants.  */
 	&aout_arm_big_vec,
 	&aout_arm_little_vec,
 	/* No one seems to use this.  */
@@ -961,12 +969,13 @@ static const bfd_target * const _bfd_target_vector[] =
 	&armpei_little_vec,
 	&b_out_vec_big_host,
 	&b_out_vec_little_host,
 #ifdef BFD64
 	&bfd_pei_ia64_vec,
 #endif
+	&bfd_elf32_amigaos_vec,
 	&bfd_elf32_avr_vec,
 	&bfd_elf32_bfin_vec,
 	&bfd_elf32_bfinfdpic_vec,
 
 	/* This, and other vectors, may not be used in any *.mt configuration.
 	   But that does not mean they are unnecessary.  If configured with
@@ -998,12 +1007,13 @@ static const bfd_target * const _bfd_target_vector[] =
 	&bfd_elf32_i370_vec,
 	&bfd_elf32_i386_freebsd_vec,
 	&bfd_elf32_i386_nacl_vec,
 	&bfd_elf32_i386_sol2_vec,
 	&bfd_elf32_i386_vxworks_vec,
 	&bfd_elf32_i386_vec,
+	&bfd_elf32_i386be_amithlon_vec,
 	&bfd_elf32_i860_little_vec,
 	&bfd_elf32_i860_vec,
 	&bfd_elf32_i960_vec,
 #if 0
 	&bfd_elf32_ia64_big_vec,
 #endif
@@ -1032,12 +1042,13 @@ static const bfd_target * const _bfd_target_vector[] =
 	&bfd_elf32_mcore_big_vec,
 	&bfd_elf32_mcore_little_vec,
 	&bfd_elf32_mep_vec,
 	&bfd_elf32_microblaze_vec,
 	&bfd_elf32_mn10200_vec,
 	&bfd_elf32_mn10300_vec,
+	&bfd_elf32_morphos_vec,
 	&bfd_elf32_mt_vec,
 	&bfd_elf32_msp430_vec,
 #ifdef BFD64
 	&bfd_elf32_nbigmips_vec,
 	&bfd_elf32_nlittlemips_vec,
 	&bfd_elf32_ntradbigmips_vec,
diff --git a/binutils/objcopy.c b/binutils/objcopy.c
index 020d54d6fbe27a5c90600e1d034a93e8fade0ff6..88bd071eefa8b5426eaadfd6431e9de5d4a4591b 100644
--- binutils/objcopy.c
+++ binutils/objcopy.c
@@ -1101,12 +1101,17 @@ filter_symbols (bfd *abfd, bfd *obfd, asymbol **osyms,
       bfd_boolean undefined;
       bfd_boolean rem_leading_char;
       bfd_boolean add_leading_char;
 
       undefined = bfd_is_und_section (bfd_get_section (sym));
 
+      if (strip_symbols == STRIP_ALL && undefined)
+        {
+          add_specific_symbol(name, keep_specific_htab);
+        }
+
       if (redefine_sym_list)
 	{
 	  char *old_name, *new_name;
 
 	  old_name = (char *) bfd_asymbol_name (sym);
 	  new_name = (char *) lookup_sym_redefinition (old_name);
@@ -1162,13 +1167,18 @@ filter_symbols (bfd *abfd, bfd *obfd, asymbol **osyms,
           strcpy (ptr, name);
           bfd_asymbol_name (sym) = n;
           name = n;
 	}
 
       if (strip_symbols == STRIP_ALL)
-	keep = FALSE;
+      {
+        if (strcmp(name, "_start") == 0 || strcmp(name, "__amigaos4__") == 0 || strcmp(name, "_SDA_BASE_") == 0)
+          keep = TRUE;
+        else
+          keep = FALSE;
+      }
       else if ((flags & BSF_KEEP) != 0		/* Used in relocation.  */
 	       || ((flags & BSF_SECTION_SYM) != 0
 		   && ((*bfd_get_section (sym)->symbol_ptr_ptr)->flags
 		       & BSF_KEEP) != 0))
 	{
 	  keep = TRUE;
@@ -1925,13 +1935,13 @@ copy_object (bfd *ibfd, bfd *obfd, const bfd_arch_info_type *input_arch)
 
 	 Note we iterate over the input sections examining their
 	 relocations since the relocations for the output sections
 	 haven't been set yet.  mark_symbols_used_in_relocations will
 	 ignore input sections which have no corresponding output
 	 section.  */
-      if (strip_symbols != STRIP_ALL)
+//      if (strip_symbols != STRIP_ALL)
 	bfd_map_over_sections (ibfd,
 			       mark_symbols_used_in_relocations,
 			       isympp);
       osympp = (asymbol **) xmalloc ((symcount + 1) * sizeof (asymbol *));
       symcount = filter_symbols (ibfd, obfd, osympp, isympp, symcount);
     }
@@ -2745,25 +2755,48 @@ copy_relocations_in_section (bfd *ibfd, sec_ptr isection, void *obfdarg)
 	  status = 1;
 	  bfd_nonfatal_message (NULL, ibfd, isection,
 				_("relocation count is negative"));
 	  return;
 	}
 
-      if (strip_symbols == STRIP_ALL)
+      /* Never, ever, strip reloc data on the Amiga! */
+      if (strip_symbols == STRIP_ALL &&
+	  bfd_get_flavour(obfd) != bfd_target_amiga_flavour)
 	{
 	  /* Remove relocations which are not in
 	     keep_strip_specific_list.  */
 	  arelent **temp_relpp;
 	  long temp_relcount = 0;
 	  long i;
 
 	  temp_relpp = (arelent **) xmalloc (relsize);
 	  for (i = 0; i < relcount; i++)
+	  {
+	    asection *sec;
+	    sec = bfd_get_section(*relpp[i]->sym_ptr_ptr);
+
+//	    printf("%d: %s (0x%lx + 0x%lx) value 0x%lx (in section %s)\n",
+//	    	i, bfd_asymbol_name (*relpp [i]->sym_ptr_ptr), relpp [i]->address, relpp [i]->addend,
+//		bfd_asymbol_value(*relpp [i]->sym_ptr_ptr),
+//		bfd_section_name(ibfd, sec));
+
+	    /* Keep the symbol */
 	    if (is_specified_symbol (bfd_asymbol_name (*relpp[i]->sym_ptr_ptr),
 				     keep_specific_htab))
 	      temp_relpp [temp_relcount++] = relpp [i];
+	    else
+	    {
+		/* Don't keep the symbol, but keep the reloc */
+		temp_relpp [temp_relcount] = relpp[i];
+		temp_relpp [temp_relcount]->addend = bfd_asymbol_value(*relpp [i]->sym_ptr_ptr)
+							 - sec->vma
+							 + relpp[i]->addend;
+		temp_relpp [temp_relcount]->sym_ptr_ptr = sec->symbol_ptr_ptr;
+		temp_relcount++;
+	    }
+	  }
 	  relcount = temp_relcount;
 	  free (relpp);
 	  relpp = temp_relpp;
 	}
 
       bfd_set_reloc (obfd, osection, relcount == 0 ? NULL : relpp, relcount);
@@ -3155,13 +3188,17 @@ strip_main (int argc, char *argv[])
 
   if (show_version)
     print_version ("strip");
 
   default_deterministic ();
 
-  /* Default is to strip all symbols.  */
+  add_specific_symbol("__amigaos4__", keep_specific_htab);
+  add_specific_symbol("_start", keep_specific_htab);
+  add_specific_symbol("_SDA_BASE_", keep_specific_htab);
+
+  /* Default is to strip all unnecessary symbols.  */
   if (strip_symbols == STRIP_UNDEF
       && discard_locals == LOCALS_UNDEF
       && htab_elements (strip_specific_htab) == 0)
     strip_symbols = STRIP_ALL;
 
   if (output_target == NULL)
@@ -3992,12 +4029,17 @@ copy_main (int argc, char *argv[])
   if (show_version)
     print_version ("objcopy");
 
   if (interleave && copy_byte == -1)
     fatal (_("interleave start byte must be set with --byte"));
 
+  add_specific_symbol("__amigappc__", keep_specific_htab);
+  add_specific_symbol("__amigaos4__", keep_specific_htab);
+  add_specific_symbol("_start", keep_specific_htab);
+  add_specific_symbol("_SDA_BASE_", keep_specific_htab);
+
   if (copy_byte >= interleave)
     fatal (_("byte number must be less than interleave"));
 
   if (copy_width > interleave - copy_byte)
     fatal (_("interleave width must be less than or equal to interleave - byte`"));
 
diff --git a/binutils/readelf.c b/binutils/readelf.c
index d9ec436af6fbea0bbc3dfa8e9cd40fcf9be140cf..f52d7168af3bc6559bd2483ff1fc126da385b38d 100644
--- binutils/readelf.c
+++ binutils/readelf.c
@@ -150,12 +150,13 @@
 #include "elf/vax.h"
 #include "elf/x86-64.h"
 #include "elf/xc16x.h"
 #include "elf/xgate.h"
 #include "elf/xstormy16.h"
 #include "elf/xtensa.h"
+#include "elf/amigaos.h"
 
 #include "getopt.h"
 #include "libiberty.h"
 #include "safe-ctype.h"
 #include "filenames.h"
 
@@ -1520,12 +1521,13 @@ static const char *
 get_ppc_dynamic_type (unsigned long type)
 {
   switch (type)
     {
     case DT_PPC_GOT:    return "PPC_GOT";
     case DT_PPC_TLSOPT: return "PPC_TLSOPT";
+    case DT_AMIGAOS_DYNVERSION: return "AMIGAOS_DYNVERSION";
     default:
       return NULL;
     }
 }
 
 static const char *
@@ -1789,12 +1791,15 @@ get_dynamic_type (unsigned long type)
 		   && (type >= OLD_DT_LOOS) && (type <= OLD_DT_HIOS)))
 	{
 	  const char * result;
 
 	  switch (elf_header.e_machine)
 	    {
+	    case EM_PPC:
+          result = get_ppc_dynamic_type (type);
+          break;
 	    case EM_PARISC:
 	      result = get_parisc_dynamic_type (type);
 	      break;
 	    case EM_IA_64:
 	      result = get_ia64_dynamic_type (type);
 	      break;
diff --git a/binutils/rename.c b/binutils/rename.c
index 5923a3f4ce2b2b5b0da96ff8225bf3c7750563bc..354b6fd1eab7f632995fed27698c76826ee8e753 100644
--- binutils/rename.c
+++ binutils/rename.c
@@ -27,13 +27,13 @@
 #else /* ! HAVE_GOOD_UTIME_H */
 #ifdef HAVE_UTIMES
 #include <sys/time.h>
 #endif /* HAVE_UTIMES */
 #endif /* ! HAVE_GOOD_UTIME_H */
 
-#if ! defined (_WIN32) || defined (__CYGWIN32__)
+#if ! defined (_WIN32) && !defined(__amigaos4__) || defined (__CYGWIN32__)
 static int simple_copy (const char *, const char *);
 
 /* The number of bytes to copy at once.  */
 #define COPY_BUF 8192
 
 /* Copy file FROM to file TO, performing no translations.
@@ -140,13 +140,13 @@ smart_rename (const char *from, const char *to, int preserve_dates ATTRIBUTE_UNU
   bfd_boolean exists;
   struct stat s;
   int ret = 0;
 
   exists = lstat (to, &s) == 0;
 
-#if defined (_WIN32) && !defined (__CYGWIN32__)
+#if defined (_WIN32) && !defined (__CYGWIN32__) || defined (__amigaos4__)
   /* Win32, unlike unix, will not erase `to' in `rename(from, to)' but
      fail instead.  Also, chown is not present.  */
 
   if (exists)
     remove (to);
 
diff --git a/config.sub b/config.sub
index 59bb593f109c8d795df4cbb96b015222eed91c07..88ccfd90050ad0d8d341c091b9920f62fc5996f8 100755
--- config.sub
+++ config.sub
@@ -353,13 +353,13 @@ case $basic_machine in
 		basic_machine=armel-unknown
 		;;
 
 	# We use `pc' rather than `unknown'
 	# because (1) that's what they normally are, and
 	# (2) the word "unknown" tends to confuse beginning users.
-	i*86 | x86_64)
+	i*86 | i*86be | x86_64)
 	  basic_machine=$basic_machine-pc
 	  ;;
 	# Object if more than one company name word.
 	*-*-*)
 		echo Invalid configuration \`$1\': machine \`$basic_machine\' not recognized 1>&2
 		exit 1
@@ -482,17 +482,14 @@ case $basic_machine in
 		basic_machine=x86_64-`echo $basic_machine | sed 's/^[^-]*-//'`
 		;;
 	amdahl)
 		basic_machine=580-amdahl
 		os=-sysv
 		;;
-	amiga | amiga-*)
-		basic_machine=m68k-unknown
-		;;
-	amigaos | amigados)
-		basic_machine=m68k-unknown
+	amigaos | amigados | amiga)
+		basic_machine=powerpc-unknown
 		os=-amigaos
 		;;
 	amigaunix | amix)
 		basic_machine=m68k-unknown
 		os=-sysv4
 		;;
@@ -1345,13 +1342,13 @@ case $os in
 	# -sysv* is not here because it comes later, after sysvr4.
 	-gnu* | -bsd* | -mach* | -minix* | -genix* | -ultrix* | -irix* \
 	      | -*vms* | -sco* | -esix* | -isc* | -aix* | -cnk* | -sunos | -sunos[34]*\
 	      | -hpux* | -unos* | -osf* | -luna* | -dgux* | -auroraux* | -solaris* \
 	      | -sym* | -kopensolaris* \
 	      | -amigaos* | -amigados* | -msdos* | -newsos* | -unicos* | -aof* \
-	      | -aos* | -aros* \
+	      | -aos* | -amithlon* | -aros* \
 	      | -nindy* | -vxsim* | -vxworks* | -ebmon* | -hms* | -mvs* \
 	      | -clix* | -riscos* | -uniplus* | -iris* | -rtu* | -xenix* \
 	      | -hiux* | -386bsd* | -knetbsd* | -mirbsd* | -netbsd* \
 	      | -openbsd* | -solidbsd* \
 	      | -ekkobsd* | -kfreebsd* | -freebsd* | -riscix* | -lynxos* \
 	      | -bosx* | -nextstep* | -cxux* | -aout* | -elf* | -oabi* \
diff --git a/config/mh-amigaos b/config/mh-amigaos
new file mode 100644
index 0000000000000000000000000000000000000000..4889ea41c6889e2e15c06c8f355c30b5eb2aa5f4
--- /dev/null
+++ config/mh-amigaos
@@ -0,0 +1,13 @@
+# Host makefile fragment for Commodore Amiga running AmigaOS.
+
+# There is no standard system compiler.  Assume using GNU C.
+CC = gcc
+CFLAGS = -g -O2 -mstackextend
+
+# We have both types of links under AmigaOS with GNU
+# utils, however the links need to be made in canonical
+# AmigaOS format (foo:bar/bell/file) rather than UNIX
+# format (/foo/bar/bell/file).  When this is fixed, then
+# these can go away.
+SYMLINK = cp
+HARDLINK = cp
diff --git a/config/mh-morphos b/config/mh-morphos
new file mode 100644
index 0000000000000000000000000000000000000000..c00202aec0389eaa067ea48818a7d8fa4fd5fc6b
--- /dev/null
+++ config/mh-morphos
@@ -0,0 +1,13 @@
+# Host makefile fragment for Commodore Amiga running AmigaOS.
+
+# There is no standard system compiler.  Assume using GNU C.
+CC = gcc
+CFLAGS = -g -O2
+
+# We have both types of links under AmigaOS with GNU
+# utils, however the links need to be made in canonical
+# AmigaOS format (foo:bar/bell/file) rather than UNIX
+# format (/foo/bar/bell/file).  When this is fixed, then
+# these can go away.
+SYMLINK = cp
+HARDLINK = cp
diff --git a/configure b/configure
index 6079e6c07511e12bb51ae5197e7110d79c36b098..9667d72a79baf032fa22e054b88fb03e64673b63 100755
--- configure
+++ configure
@@ -3630,12 +3630,15 @@ case "${noconfigdirs}" in
 esac
 
 # Work in distributions that contain no compiler tools, like Autoconf.
 host_makefile_frag=/dev/null
 if test -d ${srcdir}/config ; then
 case "${host}" in
+  m68k-*-amigaos*)
+    host_makefile_frag="config/mh-amigaos"
+    ;;
   i[3456789]86-*-msdosdjgpp*)
     host_makefile_frag="config/mh-djgpp"
     ;;
   *-cygwin*)
 
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking to see if cat works as expected" >&5
@@ -3674,12 +3677,15 @@ fi
   hppa*-*)
     host_makefile_frag="config/mh-pa"
     ;;
   *-*-darwin*)
     host_makefile_frag="config/mh-darwin"
     ;;
+  *-morphos*)
+    host_makefile_frag="config/mh-morphos"
+    ;;
   powerpc-*-aix*)
     host_makefile_frag="config/mh-ppc-aix"
     ;;
   rs6000-*-aix*)
     host_makefile_frag="config/mh-ppc-aix"
     ;;
diff --git a/configure.ac b/configure.ac
index 5efb4a32f114f23b90f838a5108f5016dc01bf43..fea7239acf315d982587796d8b93de4c894a14d8 100644
--- configure.ac
+++ configure.ac
@@ -1056,12 +1056,15 @@ case "${noconfigdirs}" in
 esac
 
 # Work in distributions that contain no compiler tools, like Autoconf.
 host_makefile_frag=/dev/null
 if test -d ${srcdir}/config ; then
 case "${host}" in
+  m68k-*-amigaos*)
+    host_makefile_frag="config/mh-amigaos"
+    ;;
   i[[3456789]]86-*-msdosdjgpp*)
     host_makefile_frag="config/mh-djgpp"
     ;;
   *-cygwin*)
     ACX_CHECK_CYGWIN_CAT_WORKS
     host_makefile_frag="config/mh-cygwin"
@@ -1081,12 +1084,15 @@ case "${host}" in
   hppa*-*)
     host_makefile_frag="config/mh-pa"
     ;;
   *-*-darwin*)
     host_makefile_frag="config/mh-darwin"
     ;;
+  *-morphos*)
+    host_makefile_frag="config/mh-morphos"
+    ;;
   powerpc-*-aix*)
     host_makefile_frag="config/mh-ppc-aix"
     ;;
   rs6000-*-aix*)
     host_makefile_frag="config/mh-ppc-aix"
     ;;
diff --git a/gas/ChangeLog-9697 b/gas/ChangeLog-9697
index f39e99554e87446d7eb8f0869701984c5df2137d..08dbfbc1d36608ec8e553593d445431cb1792cc5 100644
--- gas/ChangeLog-9697
+++ gas/ChangeLog-9697
@@ -874,12 +874,18 @@ Tue Aug 26 12:23:25 1997  Ian Lance Taylor  <ian@cygnus.com>
 	Gabriel Paubert <paubert@iram.es>.
 
 	* config/tc-i386.c (md_assemble): In JumpByte case, when looking
 	for a WORD_PREFIX_OPCODE, change it to ADDR_PREFIX_OPCODE if this
 	is jcxz or a loop instruction.
 
+Mon Aug 25 16:32:00 1997  Steffen Opel  <opel@rumms.uni-mannheim.de>
+
+	* Makefile.in (guide, install-guide, clean-guide): New targets
+	for AmigaGuide documentation.
+	(install): Add install-info and install-guide.
+
 Mon Aug 25 16:04:14 1997  Nick Clifton  <nickc@cygnus.com>
 
 	* config/tc-v850.c (pre_defined_registers): Add 'hp' as alias for
 	r2.
 	(md_begin): Set up machine architecture and type.
 
@@ -3386,12 +3392,18 @@ Mon Nov 18 15:22:28 1996  Michael Meissner  <meissner@tiktok.cygnus.com>
 	* config/tc-d10v.c (parallel_ok): Branch and link instructions
 	modify r13.
 	(write_2_short): Call parallel_ok to check whether two short
 	instructions the user requested execute in parallel, can be
 	executed that way.
 
+Sun Nov 17 21:09:55 1996  Kamil Iskra  <iskra@student.uci.agh.edu.pl>
+
+	* config/tc-m68k.c (md_estimate_size_before_relax): Do not
+	output 'bsrl' instructions for external function calls when
+	compiling with '-m68020' or higher.
+
 Thu Nov 14 11:17:49 1996  Martin M. Hunt  <hunt@pizza.cygnus.com>
 
 	* config/tc-d10v.c (write_2_short): Fix bug that wouldn't
 	allow a branch and link in parallel with an exe instruction.
 
 Fri Nov  8 13:55:03 1996  Martin M. Hunt  <hunt@pizza.cygnus.com>
diff --git a/gas/ChangeLog-9899 b/gas/ChangeLog-9899
index ae38e5dd9223cf4e26355263197ea9f2cd0296c0..76861df24938b7ec7a3051da5cf20c44465b145e 100644
--- gas/ChangeLog-9899
+++ gas/ChangeLog-9899
@@ -3574,12 +3574,16 @@ Wed Jun  3 14:10:36 1998  Ian Lance Taylor  <ian@cygnus.com>
 
 Wed Jun  3 09:16:00 1998  Catherine Moore  <clm@cygnus.com>
 
 	* config/tc-v850.c (md_begin):  Don't create special
 	sections by default.
 
+1998-06-02  David Zaroski  <zaroski@firewall.ninemoons.com>
+
+	* config/tc-m68k.c: Add missing param to add_fix in "case '_'"
+
 Tue Jun  2 14:52:56 1998  Jeffrey A Law  (law@cygnus.com)
 
 	* config/tc-mips.c (macro): For div and udiv, close the
 	reorder block as soon as possible.
 
 Tue Jun  2 15:36:13 1998  Ian Lance Taylor  <ian@cygnus.com>
diff --git a/gas/Makefile.am b/gas/Makefile.am
index 256e2322fd80f84d8fa8fab735c85446dff4f506..851de3dc36be1138ad52026f7ace0ebd49da94b6 100644
--- gas/Makefile.am
+++ gas/Makefile.am
@@ -245,23 +245,25 @@ TARGET_CPU_HFILES = \
 	config/tc-z8k.h \
 	config/xtensa-relax.h
 
 # OBJ files in config
 
 OBJ_FORMAT_CFILES = \
+	config/obj-amigahunk.c \
 	config/obj-aout.c \
 	config/obj-coff.c \
 	config/obj-ecoff.c \
 	config/obj-elf.c \
 	config/obj-evax.c \
 	config/obj-fdpicelf.c \
 	config/obj-macho.c \
 	config/obj-multi.c \
 	config/obj-som.c
 
 OBJ_FORMAT_HFILES = \
+	config/obj-amigahunk.h \
 	config/obj-aout.h \
 	config/obj-coff.h \
 	config/obj-ecoff.h \
 	config/obj-elf.h \
 	config/obj-evax.h \
 	config/obj-fdpicelf.h \
@@ -271,12 +273,13 @@ OBJ_FORMAT_HFILES = \
 
 # Emulation header files in config
 
 TARG_ENV_HFILES = \
 	config/te-386bsd.h \
 	config/te-aix5.h \
+	config/te-amiga.h \
 	config/te-armeabi.h \
 	config/te-armlinuxeabi.h \
 	config/te-dynix.h \
 	config/te-epoc-pe.h \
 	config/te-freebsd.h \
 	config/te-generic.h \
@@ -342,13 +345,13 @@ EXTRA_SCRIPTS = .gdbinit
 
 EXTRA_DIST = m68k-parse.c itbl-parse.c itbl-parse.h itbl-lex.c \
 	bfin-parse.c bfin-parse.h bfin-lex.c \
 	rl78-parse.c rl78-parse.h \
 	rx-parse.c rx-parse.h
 
-diststuff: $(EXTRA_DIST) info
+diststuff: $(EXTRA_DIST) info guide
 
 DISTCLEANFILES = targ-cpu.h obj-format.h targ-env.h itbl-cpu.h cgen-desc.h
 
 # Now figure out from those variables how to compile and link.
 
 BASEDIR = $(srcdir)/..
diff --git a/gas/Makefile.in b/gas/Makefile.in
index 94812d96db9cb13bdbdd0243a6b9a021e95e0a0b..c04f7d53feacb96ac3a82109375c3c94bcb15d56 100644
--- gas/Makefile.in
+++ gas/Makefile.in
@@ -513,23 +513,25 @@ TARGET_CPU_HFILES = \
 	config/tc-z8k.h \
 	config/xtensa-relax.h
 
 
 # OBJ files in config
 OBJ_FORMAT_CFILES = \
+	config/obj-amigahunk.c \
 	config/obj-aout.c \
 	config/obj-coff.c \
 	config/obj-ecoff.c \
 	config/obj-elf.c \
 	config/obj-evax.c \
 	config/obj-fdpicelf.c \
 	config/obj-macho.c \
 	config/obj-multi.c \
 	config/obj-som.c
 
 OBJ_FORMAT_HFILES = \
+	config/obj-amigahunk.h \
 	config/obj-aout.h \
 	config/obj-coff.h \
 	config/obj-ecoff.h \
 	config/obj-elf.h \
 	config/obj-evax.h \
 	config/obj-fdpicelf.h \
@@ -539,12 +541,13 @@ OBJ_FORMAT_HFILES = \
 
 
 # Emulation header files in config
 TARG_ENV_HFILES = \
 	config/te-386bsd.h \
 	config/te-aix5.h \
+	config/te-amiga.h \
 	config/te-armeabi.h \
 	config/te-armlinuxeabi.h \
 	config/te-dynix.h \
 	config/te-epoc-pe.h \
 	config/te-freebsd.h \
 	config/te-generic.h \
@@ -776,12 +779,13 @@ distclean-compile:
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/itbl-parse.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/listing.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/literal.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/m68k-parse.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/macro.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/messages.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/obj-amigahunk.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/obj-aout.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/obj-coff.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/obj-ecoff.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/obj-elf.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/obj-evax.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/obj-fdpicelf.Po@am__quote@
@@ -1836,12 +1840,26 @@ xtensa-relax.obj: config/xtensa-relax.c
 @am__fastdepCC_TRUE@	$(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS) -MT xtensa-relax.obj -MD -MP -MF $(DEPDIR)/xtensa-relax.Tpo -c -o xtensa-relax.obj `if test -f 'config/xtensa-relax.c'; then $(CYGPATH_W) 'config/xtensa-relax.c'; else $(CYGPATH_W) '$(srcdir)/config/xtensa-relax.c'; fi`
 @am__fastdepCC_TRUE@	$(am__mv) $(DEPDIR)/xtensa-relax.Tpo $(DEPDIR)/xtensa-relax.Po
 @AMDEP_TRUE@@am__fastdepCC_FALSE@	source='config/xtensa-relax.c' object='xtensa-relax.obj' libtool=no @AMDEPBACKSLASH@
 @AMDEP_TRUE@@am__fastdepCC_FALSE@	DEPDIR=$(DEPDIR) $(CCDEPMODE) $(depcomp) @AMDEPBACKSLASH@
 @am__fastdepCC_FALSE@	$(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS) -c -o xtensa-relax.obj `if test -f 'config/xtensa-relax.c'; then $(CYGPATH_W) 'config/xtensa-relax.c'; else $(CYGPATH_W) '$(srcdir)/config/xtensa-relax.c'; fi`
 
+obj-amigahunk.o: config/obj-amigahunk.c
+@am__fastdepCC_TRUE@	$(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS) -MT obj-amigahunk.o -MD -MP -MF $(DEPDIR)/obj-amigahunk.Tpo -c -o obj-amigahunk.o `test -f 'config/obj-amigahunk.c' || echo '$(srcdir)/'`config/obj-amigahunk.c
+@am__fastdepCC_TRUE@	$(am__mv) $(DEPDIR)/obj-amigahunk.Tpo $(DEPDIR)/obj-amigahunk.Po
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	source='config/obj-amigahunk.c' object='obj-amigahunk.o' libtool=no @AMDEPBACKSLASH@
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	DEPDIR=$(DEPDIR) $(CCDEPMODE) $(depcomp) @AMDEPBACKSLASH@
+@am__fastdepCC_FALSE@	$(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS) -c -o obj-amigahunk.o `test -f 'config/obj-amigahunk.c' || echo '$(srcdir)/'`config/obj-amigahunk.c
+
+obj-amigahunk.obj: config/obj-amigahunk.c
+@am__fastdepCC_TRUE@	$(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS) -MT obj-amigahunk.obj -MD -MP -MF $(DEPDIR)/obj-amigahunk.Tpo -c -o obj-amigahunk.obj `if test -f 'config/obj-amigahunk.c'; then $(CYGPATH_W) 'config/obj-amigahunk.c'; else $(CYGPATH_W) '$(srcdir)/config/obj-amigahunk.c'; fi`
+@am__fastdepCC_TRUE@	$(am__mv) $(DEPDIR)/obj-amigahunk.Tpo $(DEPDIR)/obj-amigahunk.Po
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	source='config/obj-amigahunk.c' object='obj-amigahunk.obj' libtool=no @AMDEPBACKSLASH@
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	DEPDIR=$(DEPDIR) $(CCDEPMODE) $(depcomp) @AMDEPBACKSLASH@
+@am__fastdepCC_FALSE@	$(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS) -c -o obj-amigahunk.obj `if test -f 'config/obj-amigahunk.c'; then $(CYGPATH_W) 'config/obj-amigahunk.c'; else $(CYGPATH_W) '$(srcdir)/config/obj-amigahunk.c'; fi`
+
 obj-aout.o: config/obj-aout.c
 @am__fastdepCC_TRUE@	$(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS) -MT obj-aout.o -MD -MP -MF $(DEPDIR)/obj-aout.Tpo -c -o obj-aout.o `test -f 'config/obj-aout.c' || echo '$(srcdir)/'`config/obj-aout.c
 @am__fastdepCC_TRUE@	$(am__mv) $(DEPDIR)/obj-aout.Tpo $(DEPDIR)/obj-aout.Po
 @AMDEP_TRUE@@am__fastdepCC_FALSE@	source='config/obj-aout.c' object='obj-aout.o' libtool=no @AMDEPBACKSLASH@
 @AMDEP_TRUE@@am__fastdepCC_FALSE@	DEPDIR=$(DEPDIR) $(CCDEPMODE) $(depcomp) @AMDEPBACKSLASH@
 @am__fastdepCC_FALSE@	$(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS) -c -o obj-aout.o `test -f 'config/obj-aout.c' || echo '$(srcdir)/'`config/obj-aout.c
@@ -2411,13 +2429,13 @@ uninstall-am:
 	tags tags-recursive uninstall uninstall-am
 
 po/POTFILES.in: @MAINT@ Makefile
 	for f in $(POTFILES); do echo $$f; done | LC_ALL=C sort > tmp \
 	  && mv tmp $(srcdir)/po/POTFILES.in
 
-diststuff: $(EXTRA_DIST) info
+diststuff: $(EXTRA_DIST) info guide
 
 check-DEJAGNU: site.exp
 	if [ -d testsuite ]; then \
 	  true; \
 	else \
 	  mkdir testsuite; \
diff --git a/gas/as.c b/gas/as.c
index fa4141f92bc887cfd403ec3eb93a7a20f26b642a..7b35f0e3f23662e09e8ce56c525239cf68b5dd3a 100644
--- gas/as.c
+++ gas/as.c
@@ -105,12 +105,17 @@ int keep_it = 0;
 segT reg_section;
 segT expr_section;
 segT text_section;
 segT data_section;
 segT bss_section;
 
+#ifdef OBJ_AMIGAHUNK
+segT data_chip_section;
+segT bss_chip_section;
+#endif
+
 /* Name of listing file.  */
 static char *listing_filename = NULL;
 
 static struct defsym_list *defsyms;
 
 #ifdef HAVE_ITBL_CPU
@@ -1046,22 +1051,31 @@ perform_an_assembly_pass (int argc, char ** argv)
 #ifndef OBJ_MACH_O
   /* Create the standard sections, and those the assembler uses
      internally.  */
   text_section = subseg_new (TEXT_SECTION_NAME, 0);
   data_section = subseg_new (DATA_SECTION_NAME, 0);
   bss_section = subseg_new (BSS_SECTION_NAME, 0);
+#ifdef OBJ_AMIGAHUNK
+  data_chip_section = subseg_new (".data_chip", 0);
+  bss_chip_section = subseg_new (".bss_chip", 0);
+#endif
   /* @@ FIXME -- we're setting the RELOC flag so that sections are assumed
      to have relocs, otherwise we don't find out in time.  */
   applicable = bfd_applicable_section_flags (stdoutput);
   bfd_set_section_flags (stdoutput, text_section,
 			 applicable & (SEC_ALLOC | SEC_LOAD | SEC_RELOC
 				       | SEC_CODE | SEC_READONLY));
   bfd_set_section_flags (stdoutput, data_section,
 			 applicable & (SEC_ALLOC | SEC_LOAD | SEC_RELOC
 				       | SEC_DATA));
   bfd_set_section_flags (stdoutput, bss_section, applicable & SEC_ALLOC);
+#ifdef OBJ_AMIGAHUNK
+  bfd_set_section_flags (stdoutput, data_chip_section,
+			 applicable & (SEC_ALLOC | SEC_LOAD | SEC_RELOC));
+  bfd_set_section_flags (stdoutput, bss_chip_section, applicable & SEC_ALLOC);
+#endif
   seg_info (bss_section)->bss = 1;
 #endif
   subseg_new (BFD_ABS_SECTION_NAME, 0);
   subseg_new (BFD_UND_SECTION_NAME, 0);
   reg_section = subseg_new ("*GAS `reg' section*", 0);
   expr_section = subseg_new ("*GAS `expr' section*", 0);
diff --git a/gas/config/m68k-parse.h b/gas/config/m68k-parse.h
index 4f91385f9222dc52c8cc9f490860729c2183e445..08e766c5523b90ac3cd2d685b239c0a7ed4d8230 100644
--- gas/config/m68k-parse.h
+++ gas/config/m68k-parse.h
@@ -293,12 +293,15 @@ struct m68k_exp
   /* The type of pic relocation if any.  */
   enum pic_relocation pic_reloc;
 #endif
 
   /* The expression itself.  */
   expressionS exp;
+
+  /* base-relative? */
+  short baserel;
 };
 
 /* The operand modes.  */
 
 enum m68k_operand_type
 {
diff --git a/gas/config/m68k-parse.y b/gas/config/m68k-parse.y
index 2c58266fb8e6bd8d57515fe5200daaf9a1e450a2..742cbf2eeaaa15766a4d44de76a9d58d56993367 100644
--- gas/config/m68k-parse.y
+++ gas/config/m68k-parse.y
@@ -972,31 +972,35 @@ yylex ()
       else if (parens == 0
 	       && (*s == ',' || *s == ']'))
 	break;
     }
 
   yylval.exp.size = SIZE_UNSPEC;
+  yylval.exp.baserel = 0;
   if (s <= str + 2
       || (s[-2] != '.' && s[-2] != ':'))
     tail = 0;
   else
     {
       switch (s[-1])
 	{
+	case 'B':
+          yylval.exp.baserel = 1;
 	case 's':
 	case 'S':
 	case 'b':
-	case 'B':
 	  yylval.exp.size = SIZE_BYTE;
 	  break;
-	case 'w':
 	case 'W':
+          yylval.exp.baserel = 1;
+	case 'w':
 	  yylval.exp.size = SIZE_WORD;
 	  break;
-	case 'l':
 	case 'L':
+          yylval.exp.baserel = 1;
+	case 'l':
 	  yylval.exp.size = SIZE_LONG;
 	  break;
 	default:
 	  break;
 	}
       if (yylval.exp.size != SIZE_UNSPEC)
diff --git a/gas/config/obj-amigahunk.c b/gas/config/obj-amigahunk.c
new file mode 100644
index 0000000000000000000000000000000000000000..8755475ecfdfd5aafbf876ed1f87c9d343b560e9
--- /dev/null
+++ gas/config/obj-amigahunk.c
@@ -0,0 +1,212 @@
+/* AmigaOS object file format
+   Copyright (C) 1992, 1993, 1994, 1995 Free Software Foundation, Inc.
+
+This file is part of GAS, the GNU Assembler.
+
+GAS is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as
+published by the Free Software Foundation; either version 2,
+or (at your option) any later version.
+
+GAS is distributed in the hope that it will be useful, but
+WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+the GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with GAS; see the file COPYING.  If not, write to the Free
+Software Foundation, 59 Temple Place - Suite 330, Boston, MA
+02111-1307, USA.  */
+
+#include "as.h"
+
+enum {
+  N_UNDF=0,
+/*N_ABS=2,*/
+/*N_TEXT=4,*/
+/*N_DATA=6,*/
+/*N_BSS=8,*/
+  N_INDR=0xa,
+/*N_COMM=0x12,*/
+  N_SETA=0x14,
+  N_SETT=0x16,
+  N_SETD=0x18,
+  N_SETB=0x1a,
+/*N_SETV=0x1c,*/
+  N_WARNING=0x1e,
+/*N_FN=0x1f*/
+  N_EXT=1,
+  N_TYPE=0x1e,
+/*N_STAB=0xe0,*/
+};
+
+static void obj_amiga_line PARAMS ((int));
+static void obj_amiga_weak PARAMS ((int));
+
+const pseudo_typeS obj_pseudo_table[] =
+{
+  {"line", obj_amiga_line, 0},	/* source code line number */
+  {"weak", obj_amiga_weak, 0},	/* mark symbol as weak.  */
+
+  /* other stuff */
+  {"ABORT", s_abort, 0},
+
+  {NULL, NULL, 0}		/* end sentinel */
+};
+
+#ifdef BFD_ASSEMBLER
+
+void
+obj_amiga_frob_symbol (sym, punt)
+     symbolS *sym;
+     int *punt ATTRIBUTE_UNUSED;
+{
+  sec_ptr sec = S_GET_SEGMENT (sym);
+  unsigned int type = amiga_symbol (symbol_get_bfdsym (sym))->type;
+
+  /* Only frob simple symbols this way right now.  */
+  if (! (type & ~ (N_TYPE | N_EXT)))
+    {
+      if (type == (N_UNDF | N_EXT)
+	  && sec == &bfd_abs_section)
+	{
+	  sec = bfd_und_section_ptr;
+	  S_SET_SEGMENT (sym, sec);
+	}
+
+      if ((type & N_TYPE) != N_INDR
+	  && (type & N_TYPE) != N_SETA
+	  && (type & N_TYPE) != N_SETT
+	  && (type & N_TYPE) != N_SETD
+	  && (type & N_TYPE) != N_SETB
+	  && type != N_WARNING
+	  && (sec == &bfd_abs_section
+	      || sec == &bfd_und_section))
+	return;
+      if (symbol_get_bfdsym (sym)->flags & BSF_EXPORT)
+	type |= N_EXT;
+
+      switch (type & N_TYPE)
+	{
+	case N_SETA:
+	case N_SETT:
+	case N_SETD:
+	case N_SETB:
+	  /* Set the debugging flag for constructor symbols so that
+	     BFD leaves them alone.  */
+	  symbol_get_bfdsym (sym)->flags |= BSF_DEBUGGING;
+
+	  /* You can't put a common symbol in a set.  The way a set
+	     element works is that the symbol has a definition and a
+	     name, and the linker adds the definition to the set of
+	     that name.  That does not work for a common symbol,
+	     because the linker can't tell which common symbol the
+	     user means.  FIXME: Using as_bad here may be
+	     inappropriate, since the user may want to force a
+	     particular type without regard to the semantics of sets;
+	     on the other hand, we certainly don't want anybody to be
+	     mislead into thinking that their code will work.  */
+	  if (S_IS_COMMON (sym))
+	    as_bad (_("Attempt to put a common symbol into set %s"),
+		    S_GET_NAME (sym));
+	  /* Similarly, you can't put an undefined symbol in a set.  */
+	  else if (! S_IS_DEFINED (sym))
+	    as_bad (_("Attempt to put an undefined symbol into set %s"),
+		    S_GET_NAME (sym));
+
+	  break;
+	case N_INDR:
+	  /* Put indirect symbols in the indirect section.  */
+	  S_SET_SEGMENT (sym, bfd_ind_section_ptr);
+	  symbol_get_bfdsym (sym)->flags |= BSF_INDIRECT;
+	  if (type & N_EXT)
+	    {
+	      symbol_get_bfdsym (sym)->flags |= BSF_EXPORT;
+	      symbol_get_bfdsym (sym)->flags &=~ BSF_LOCAL;
+	    }
+	  break;
+	case N_WARNING:
+	  /* Mark warning symbols.  */
+	  symbol_get_bfdsym (sym)->flags |= BSF_WARNING;
+	  break;
+	}
+    }
+  else
+    {
+      symbol_get_bfdsym (sym)->flags |= BSF_DEBUGGING;
+    }
+
+  amiga_symbol (symbol_get_bfdsym (sym))->type = type;
+
+  /* Double check weak symbols.  */
+  if (S_IS_WEAK (sym))
+    {
+      if (S_IS_COMMON (sym))
+	as_bad (_("Symbol `%s' can not be both weak and common"),
+		S_GET_NAME (sym));
+    }
+}
+
+void
+obj_amiga_frob_file_before_fix ()
+{
+  /* Relocation processing may require knowing the VMAs of the sections.
+     Since writing to a section will cause the BFD back end to compute the
+     VMAs, fake it out here....  */
+  bfd_byte b = 0;
+  bfd_boolean x = TRUE;
+  if (bfd_section_size (stdoutput, text_section) != 0)
+    {
+      x = bfd_set_section_contents (stdoutput, text_section, &b, (file_ptr) 0,
+				    (bfd_size_type) 1);
+    }
+  else if (bfd_section_size (stdoutput, data_section) != 0)
+    {
+      x = bfd_set_section_contents (stdoutput, data_section, &b, (file_ptr) 0,
+				    (bfd_size_type) 1);
+    }
+  assert (x);
+}
+
+#endif /* BFD_ASSEMBLER */
+
+static void
+obj_amiga_line (ignore)
+     int ignore ATTRIBUTE_UNUSED;
+{
+  /* Assume delimiter is part of expression.
+     BSD4.2 as fails with delightful bug, so we
+     are not being incompatible here.  */
+  new_logical_line ((char *) NULL, (int) (get_absolute_expression ()));
+  demand_empty_rest_of_line ();
+}				/* obj_amiga_line() */
+
+/* Handle .weak.  This is a GNU extension.  */
+
+static void
+obj_amiga_weak (ignore)
+     int ignore ATTRIBUTE_UNUSED;
+{
+  char *name;
+  int c;
+  symbolS *symbolP;
+
+  do
+    {
+      name = input_line_pointer;
+      c = get_symbol_end ();
+      symbolP = symbol_find_or_make (name);
+      *input_line_pointer = c;
+      SKIP_WHITESPACE ();
+      S_SET_WEAK (symbolP);
+      if (c == ',')
+	{
+	  input_line_pointer++;
+	  SKIP_WHITESPACE ();
+	  if (*input_line_pointer == '\n')
+	    c = '\n';
+	}
+    }
+  while (c == ',');
+  demand_empty_rest_of_line ();
+}
diff --git a/gas/config/obj-amigahunk.h b/gas/config/obj-amigahunk.h
new file mode 100644
index 0000000000000000000000000000000000000000..0b7d80eeb291878dc871ce0591b2223bf6cb1de2
--- /dev/null
+++ gas/config/obj-amigahunk.h
@@ -0,0 +1,54 @@
+/* obj-amigahunk.h, AmigaOS object file format for gas, the assembler.
+   Copyright (C) 1992, 1993, 1994, 1995 Free Software Foundation, Inc.
+
+   This file is part of GAS, the GNU Assembler.
+
+   GAS is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as
+   published by the Free Software Foundation; either version 2,
+   or (at your option) any later version.
+
+   GAS is distributed in the hope that it will be useful, but
+   WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+   the GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with GAS; see the file COPYING.  If not, write to the Free
+   Software Foundation, 59 Temple Place - Suite 330, Boston, MA
+   02111-1307, USA. */
+
+/* Tag to validate an amiga object file format processing */
+#define OBJ_AMIGAHUNK 1
+
+#include "targ-cpu.h"
+
+#ifdef BFD_ASSEMBLER
+
+#include "bfd/libamiga.h"
+
+#define OUTPUT_FLAVOR bfd_target_amiga_flavour
+
+/* SYMBOL TABLE */
+/* Symbol table macros and constants */
+
+#define S_SET_OTHER(S,V) (amiga_symbol (symbol_get_bfdsym (S))->other = (V))
+#define S_SET_TYPE(S,T)	 (amiga_symbol (symbol_get_bfdsym (S))->type = (T))
+#define S_SET_DESC(S,D)	 (amiga_symbol (symbol_get_bfdsym (S))->desc = (D))
+#define S_GET_TYPE(S)	 (amiga_symbol (symbol_get_bfdsym (S))->type)
+
+#define obj_frob_symbol(S,PUNT) obj_amiga_frob_symbol (S, &PUNT)
+extern void obj_amiga_frob_symbol PARAMS ((symbolS *, int *));
+
+#define obj_frob_file_before_fix() obj_amiga_frob_file_before_fix ()
+extern void obj_amiga_frob_file_before_fix PARAMS ((void));
+
+#define obj_sec_sym_ok_for_reloc(SEC)	(1)
+
+#endif /* BFD_ASSEMBLER */
+
+#define obj_read_begin_hook()		{;}
+#define obj_symbol_new_hook(s)		{;}
+#define EMIT_SECTION_SYMBOLS		(0)
+
+#define AOUT_STABS
diff --git a/gas/config/obj-elf.c b/gas/config/obj-elf.c
index d7c766513ccc4111f51904a7e01904b7ebe96a03..bb8d9d1ebee6b76deee86848202fd06d5b1a4dfa 100644
--- gas/config/obj-elf.c
+++ gas/config/obj-elf.c
@@ -1390,13 +1390,13 @@ obj_elf_vtable_inherit (int ignore ATTRIBUTE_UNUSED)
   if (bad)
     return NULL;
 
   gas_assert (symbol_get_value_expression (csym)->X_op == O_constant);
   return fix_new (symbol_get_frag (csym),
 		  symbol_get_value_expression (csym)->X_add_number,
-		  0, psym, 0, 0, BFD_RELOC_VTABLE_INHERIT);
+		  0, psym, 0, 0, BFD_RELOC_VTABLE_INHERIT, 0);
 }
 
 /* This handles the .vtable_entry pseudo-op, which is used to indicate
    to the linker that a vtable slot was used.  The syntax is
    ".vtable_entry tablename, offset".  */
 
@@ -1423,13 +1423,13 @@ obj_elf_vtable_entry (int ignore ATTRIBUTE_UNUSED)
 
   offset = get_absolute_expression ();
 
   demand_empty_rest_of_line ();
 
   return fix_new (frag_now, frag_now_fix (), 0, sym, offset, 0,
-		  BFD_RELOC_VTABLE_ENTRY);
+		  BFD_RELOC_VTABLE_ENTRY, 0);
 }
 
 void
 elf_obj_read_begin_hook (void)
 {
 #ifdef NEED_ECOFF_DEBUG
diff --git a/gas/config/tc-i386.h b/gas/config/tc-i386.h
index de132d69d7ac3f854ea517a15267e8c75365714d..14b67f0506eacf6d3dbb11dbd08689fa69354678 100644
--- gas/config/tc-i386.h
+++ gas/config/tc-i386.h
@@ -24,13 +24,20 @@
 #define TC_I386 1
 
 #include "opcodes/i386-opc.h"
 
 struct fix;
 
+/* Set the endianness we are using.  Default to little endian.  */
+#ifndef TARGET_BYTES_BIG_ENDIAN
 #define TARGET_BYTES_BIG_ENDIAN	0
+#endif
+
+#if !defined(OBJ_ELF) && TARGET_BYTES_BIG_ENDIAN == 1
+ #error Big endian i386 tested only for ELF!
+#endif
 
 #define TARGET_ARCH		(i386_arch ())
 #define TARGET_MACH		(i386_mach ())
 extern enum bfd_architecture i386_arch (void);
 extern unsigned long i386_mach (void);
 
@@ -64,12 +71,16 @@ extern unsigned long i386_mach (void);
 #elif defined (TE_NACL)
 #define ELF_TARGET_FORMAT	"elf32-i386-nacl"
 #define ELF_TARGET_FORMAT32	"elf32-x86-64-nacl"
 #define ELF_TARGET_FORMAT64	"elf64-x86-64-nacl"
 #endif
 
+#ifdef TE_Amithlon
+#define ELF_TARGET_FORMAT	"elf32-i386be-amithlon"
+#endif
+
 #ifdef TE_SOLARIS
 #define ELF_TARGET_FORMAT	"elf32-i386-sol2"
 #define ELF_TARGET_FORMAT64	"elf64-x86-64-sol2"
 #endif
 
 #ifndef ELF_TARGET_FORMAT
@@ -133,13 +144,13 @@ extern const char *i386_comment_chars;
 
 #if (defined (OBJ_ELF) || defined (OBJ_MAYBE_ELF)) && !defined (LEX_AT)
 #define TC_PARSE_CONS_EXPRESSION(EXP, NBYTES) x86_cons (EXP, NBYTES)
 #endif
 extern void x86_cons (expressionS *, int);
 
-#define TC_CONS_FIX_NEW(FRAG,OFF,LEN,EXP) x86_cons_fix_new(FRAG, OFF, LEN, EXP)
+#define TC_CONS_FIX_NEW(FRAG,OFF,LEN,EXP,BASEREL) x86_cons_fix_new(FRAG, OFF, LEN, EXP)
 extern void x86_cons_fix_new
   (fragS *, unsigned int, unsigned int, expressionS *);
 
 #define TC_ADDRESS_BYTES x86_address_bytes
 extern int x86_address_bytes (void);
 
@@ -220,13 +231,13 @@ if (fragP->fr_type == rs_align_code) 					\
 void i386_print_statistics (FILE *);
 #define tc_print_statistics i386_print_statistics
 
 extern unsigned int i386_frag_max_var (fragS *);
 #define md_frag_max_var i386_frag_max_var
 
-#define md_number_to_chars number_to_chars_littleendian
+/* #define md_number_to_chars number_to_chars_littleendian */
 
 enum processor_type
 {
   PROCESSOR_UNKNOWN,
   PROCESSOR_I386,
   PROCESSOR_I486,
diff --git a/gas/config/tc-m68k.c b/gas/config/tc-m68k.c
index 21accf605b22ebc5af491e173faeef93888b6667..8b5f6c60f2141ee91d6e9d1d639815abdf4e5042 100644
--- gas/config/tc-m68k.c
+++ gas/config/tc-m68k.c
@@ -35,12 +35,22 @@
 #endif
 
 #ifdef M68KCOFF
 #include "obj-coff.h"
 #endif
 
+/* FIXME: delete this #define as soon as the code that references
+   N_TEXT is changed */
+#ifdef BFD_ASSEMBLER
+#define N_TEXT 4
+#endif
+
+#ifndef OBJ_AMIGAHUNK
+#define OBJ_AMIGAHUNK 0
+#endif
+
 #ifdef OBJ_ELF
 static void m68k_elf_cons (int);
 #endif
 
 /* This string holds the chars that always start a comment.  If the
    pre-processor is disabled, these aren't very useful.  The macro
@@ -81,12 +91,13 @@ const char FLT_CHARS[] = "rRsSfFdDxXeEpP";
    to denote pic relocations.  */
 int flag_want_pic;
 
 static int flag_short_refs;	/* -l option.  */
 static int flag_long_jumps;	/* -S option.  */
 static int flag_keep_pcrel;	/* --pcrel option.  */
+static int flag_small_code;	/* -sc option */
 
 #ifdef REGISTER_PREFIX_OPTIONAL
 int flag_reg_prefix_optional = REGISTER_PREFIX_OPTIONAL;
 #else
 int flag_reg_prefix_optional;
 #endif
@@ -388,12 +399,13 @@ struct m68k_it
       int pcrel_fix;
 #ifdef OBJ_ELF
       /* Whether this expression needs special pic relocation, and if
 	 so, which.  */
       enum pic_relocation pic_reloc;
 #endif
+      char baserel;
     }
   reloc[5];			/* Five is enough???  */
 };
 
 #define cpu_of_arch(x)		((x) & (m68000up | mcfisa_a | fido_a))
 #define float_of_arch(x)	((x) & mfloat)
@@ -438,26 +450,27 @@ insop (int w, const struct m68k_incant *opcode)
   the_ins.numo++;
 }
 
 /* The numo+1 kludge is so we can hit the low order byte of the prev word.
    Blecch.  */
 static void
-add_fix (int width, struct m68k_exp *exp, int pc_rel, int pc_fix)
+add_fix (int width, struct m68k_exp *exp, int pc_rel, int pc_fix, int base_rel)
 {
   the_ins.reloc[the_ins.nrel].n = (width == 'B' || width == '3'
 				   ? the_ins.numo * 2 - 1
 				   : (width == 'b'
 				      ? the_ins.numo * 2 + 1
 				      : the_ins.numo * 2));
   the_ins.reloc[the_ins.nrel].exp = exp->exp;
   the_ins.reloc[the_ins.nrel].wid = width;
   the_ins.reloc[the_ins.nrel].pcrel_fix = pc_fix;
 #ifdef OBJ_ELF
   the_ins.reloc[the_ins.nrel].pic_reloc = exp->pic_reloc;
 #endif
-  the_ins.reloc[the_ins.nrel++].pcrel = pc_rel;
+  the_ins.reloc[the_ins.nrel].pcrel = pc_rel;
+  the_ins.reloc[the_ins.nrel++].baserel = base_rel;
 }
 
 /* Cause an extra frag to be generated here, inserting up to 10 bytes
    (that value is chosen in the frag_var call in md_assemble).  TYPE
    is the subtype of the frag to be generated; its primary type is
    rs_machine_dependent.
@@ -807,12 +820,24 @@ static void m68k_init_arch (void);
 
 /* This relaxation is required for branches where there is no long
    branch and we are in pcrel mode.  We generate a bne/beq pair.  */
 #define BRANCHBWPL	10      /* Branch byte, word or pair of longs
 				   */
 
+/* ABSREL (nice name;-)) is used in small-code, it might be implemented
+ * base-relative (a4), pc-relative, or base-relative with an extra add
+ * instruction to add the base-register.
+ *
+ * IMMREL is the analogous mode for immediate addressing of variables. This
+ * one can lead into situations, where a replacement is not possible:
+ *   addl #foo,a0
+ * can't be made pc-relative, if foo is in the text segment.  */
+
+#define ABSREL		11
+#define IMMREL		12
+
 /* Note that calls to frag_var need to specify the maximum expansion
    needed; this is currently 12 bytes for bne/beq pair.  */
 #define FRAG_VAR_SIZE 12
 
 /* The fields are:
    How far Forward this mode will reach:
@@ -869,17 +894,27 @@ relax_typeS md_relax_table[] =
   {	1,	1,  0, 0 },
 
   {	1,	1,  0, 0 },		/* ABSTOPCREL doesn't come BYTE.  */
   { 32767, -32768,  2, TAB (ABSTOPCREL, LONG) },
   {	0,	0,  4, 0 },
   {	1,	1,  0, 0 },
-  
+
   {   127,   -128,  0, TAB (BRANCHBWPL, SHORT) },
   { 32767, -32768,  2, TAB (BRANCHBWPL, LONG) },
   {     0,	0,  10, 0 },
   {     1,	1,  0, 0 },
+
+  {   127,   -128,  0, 0 },
+  { 32767, -32768,  2, TAB (ABSREL, LONG) },
+  {     0,      0,  6, 0 },
+  {     1,      1,  0, 0 },
+
+  {   127,   -128,  0, 0 },
+  { 32767, -32768,  2, TAB (IMMREL, LONG) },
+  {     0,      0,  6, 0 },
+  {     1,      1,  0, 0 },
 };
 
 /* These are the machine dependent pseudo-ops.  These are included so
    the assembler can work on the output from the SUN C compiler, which
    generates these.  */
 
@@ -1314,12 +1349,23 @@ tc_gen_reloc (asection *section ATTRIBUTE_UNUSED, fixS *fixp)
 	      as_bad_where (fixp->fx_file, fixp->fx_line,
 			    _("Cannot make %s relocation PC relative"),
 			    bfd_get_reloc_code_name (code));
 	    }
 	}
     }
+  else if (fixp->tc_fix_data)
+    {
+      switch (fixp->fx_size)
+	{
+	case 1: code = BFD_RELOC_8_BASEREL; break;
+	case 2: code = BFD_RELOC_16_BASEREL; break;
+	case 4: code = BFD_RELOC_32_BASEREL; break;
+	default:
+	  abort ();
+	}
+    }
   else
     {
 #define F(SZ,PCREL)		(((SZ) << 1) + (PCREL))
       switch (F (fixp->fx_size, fixp->fx_pcrel))
 	{
 #define MAP(SZ,PCREL,TYPE)	case F(SZ,PCREL): code = (TYPE); break
@@ -2510,13 +2556,24 @@ m68k_ip (char *instring)
 	      tmpreg = 0x3c;	/* 7.4 */
 	      if (strchr ("bwl", s[1]))
 		nextword = get_num (&opP->disp, 90);
 	      else
 		nextword = get_num (&opP->disp, 0);
 	      if (isvar (&opP->disp))
-		add_fix (s[1], &opP->disp, 0, 0);
+		{
+/* This doesn't work when the symbol is N_UNDF! We ignore this for now. */
+		  if (0 && flag_small_code)
+		    {
+		      add_frag (adds (&opP->disp),
+				offs (&opP->disp),
+				TAB (IMMREL, SZ_UNDEF));
+		       break;
+		    }
+		  else
+		    add_fix(s[1], &opP->disp, 0, 0, opP->disp.baserel);
+	        }
 	      switch (s[1])
 		{
 		case 'b':
 		  if (!isbyte (nextword))
 		    opP->error = _("operand out of range");
 		  addword (nextword);
@@ -2679,26 +2736,26 @@ m68k_ip (char *instring)
 				 relocation it cannot be relaxed.  */
 			      || opP->disp.pic_reloc != pic_none
 #endif
 			      )
 			    {
 			      addword (0x0170);
-			      add_fix ('l', &opP->disp, 1, 2);
+			      add_fix ('l', &opP->disp, 1, 2, opP->disp.baserel);
 			    }
 			  else
 			    {
 			      add_frag (adds (&opP->disp),
 					SEXT (offs (&opP->disp)),
 					TAB (PCREL1632, SZ_UNDEF));
 			      break;
 			    }
 			}
 		      else
 			{
 			  addword (0x0170);
-			  add_fix ('l', &opP->disp, 0, 0);
+			  add_fix ('l', &opP->disp, 0, 0, opP->disp.baserel);
 			}
 		    }
 		  else
 		    addword (0x0170);
 		  addword (nextword >> 16);
 		}
@@ -2710,16 +2767,16 @@ m68k_ip (char *instring)
 		    tmpreg = 0x28 + opP->reg - ADDR;	/* 5.areg */
 
 		  if (isvar (&opP->disp))
 		    {
 		      if (opP->reg == PC)
 			{
-			  add_fix ('w', &opP->disp, 1, 0);
+			  add_fix ('w', &opP->disp, 1, 0, opP->disp.baserel);
 			}
 		      else
-			add_fix ('w', &opP->disp, 0, 0);
+			add_fix ('w', &opP->disp, 0, 0, opP->disp.baserel);
 		    }
 		}
 	      addword (nextword);
 	      break;
 
 	    case POST:
@@ -2823,15 +2880,15 @@ m68k_ip (char *instring)
  			  if (isvar (&opP->disp))
 			    {
 			      /* Do a byte relocation.  If it doesn't
 				 fit (possible on m68000) let the
 				 fixup processing complain later.  */
 			      if (opP->reg == PC)
-				add_fix ('B', &opP->disp, 1, 1);
+				add_fix ('B', &opP->disp, 1, 1, 0);	/* FIXME? -fnf */
 			      else
-				add_fix ('B', &opP->disp, 0, 0);
+				add_fix ('B', &opP->disp, 0, 0, 0);	/* FIXME? -fnf */
 			    }
 			  else if (siz1 != SIZE_BYTE)
 			    {
 			      if (siz1 != SIZE_UNSPEC)
 				as_warn (_("Forcing byte displacement"));
 			      if (! issbyte (baseo))
@@ -2956,23 +3013,23 @@ m68k_ip (char *instring)
 		}
 	      addword (nextword);
 
 	      if (siz1 != SIZE_UNSPEC && isvar (&opP->disp))
 		{
 		  if (opP->reg == PC || opP->reg == ZPC)
-		    add_fix (siz1 == SIZE_LONG ? 'l' : 'w', &opP->disp, 1, 2);
+		    add_fix (siz1 == SIZE_LONG ? 'l' : 'w', &opP->disp, 1, 2, opP->disp.baserel);
 		  else
-		    add_fix (siz1 == SIZE_LONG ? 'l' : 'w', &opP->disp, 0, 0);
+		    add_fix (siz1 == SIZE_LONG ? 'l' : 'w', &opP->disp, 0, 0, opP->disp.baserel);
 		}
 	      if (siz1 == SIZE_LONG)
 		addword (baseo >> 16);
 	      if (siz1 != SIZE_UNSPEC)
 		addword (baseo);
 
 	      if (siz2 != SIZE_UNSPEC && isvar (&opP->odisp))
-		add_fix (siz2 == SIZE_LONG ? 'l' : 'w', &opP->odisp, 0, 0);
+		add_fix (siz2 == SIZE_LONG ? 'l' : 'w', &opP->odisp, 0, 0, opP->disp.baserel);
 	      if (siz2 == SIZE_LONG)
 		addword (outro >> 16);
 	      if (siz2 != SIZE_UNSPEC)
 		addword (outro);
 
 	      break;
@@ -3006,27 +3063,36 @@ m68k_ip (char *instring)
 				SEXT (offs (&opP->disp)),
 				TAB (ABSTOPCREL, SZ_UNDEF));
 		      break;
 		    }
 		  /* Fall through into long.  */
 		case SIZE_LONG:
+/* This doesn't work when the symbol is N_UNDF! We ignore this for now. */
+		  if (0 && flag_small_code)
+		    {
+		      tmpreg=0x3A; /* 7.2 */
+		      add_frag (adds (&opP->disp),
+			        offs (&opP->disp),
+				TAB (ABSREL, SZ_UNDEF));
+		      break;
+		    }
 		  if (isvar (&opP->disp))
-		    add_fix ('l', &opP->disp, 0, 0);
+		    add_fix ('l', &opP->disp, 0, 0, opP->disp.baserel);
 
 		  tmpreg = 0x39;/* 7.1 mode */
 		  addword (nextword >> 16);
 		  addword (nextword);
 		  break;
 
 		case SIZE_BYTE:
 		  as_bad (_("unsupported byte value; use a different suffix"));
 		  /* Fall through.  */
 
 		case SIZE_WORD:
 		  if (isvar (&opP->disp))
-		    add_fix ('w', &opP->disp, 0, 0);
+		    add_fix ('w', &opP->disp, 0, 0, opP->disp.baserel);
 
 		  tmpreg = 0x38;/* 7.0 mode */
 		  addword (nextword);
 		  break;
 		}
 	      break;
@@ -3066,13 +3132,13 @@ m68k_ip (char *instring)
 	    default:
 	      tmpreg = 90;
 	      break;
 	    }
 	  tmpreg = get_num (&opP->disp, tmpreg);
 	  if (isvar (&opP->disp))
-	    add_fix (s[1], &opP->disp, 0, 0);
+	    add_fix (s[1], &opP->disp, 0, 0, opP->disp.baserel);
 	  switch (s[1])
 	    {
 	    case 'b':		/* Danger:  These do no check for
 				   certain types of overflow.
 				   user beware! */
 	      if (!isbyte (tmpreg))
@@ -3133,22 +3199,22 @@ m68k_ip (char *instring)
 	case 'B':
 	  tmpreg = get_num (&opP->disp, 90);
 	  
 	  switch (s[1])
 	    {
 	    case 'B':
-	      add_fix ('B', &opP->disp, 1, -1);
+	      add_fix ('B', &opP->disp, 1, -1, opP->disp.baserel);
 	      break;
 	    case 'W':
-	      add_fix ('w', &opP->disp, 1, 0);
+	      add_fix ('w', &opP->disp, 1, 0, opP->disp.baserel);
 	      addword (0);
 	      break;
 	    case 'L':
 	    long_branch:
 	      the_ins.opcode[0] |= 0xff;
-	      add_fix ('l', &opP->disp, 1, 0);
+	      add_fix ('l', &opP->disp, 1, 0, opP->disp.baserel);
 	      addword (0);
 	      addword (0);
 	      break;
 	    case 'g': /* Conditional branch */
 	      have_disp = HAVE_LONG_CALL (current_architecture);
 	      goto var_branch;
@@ -3188,13 +3254,13 @@ m68k_ip (char *instring)
 		  else					/* jCC */
 		    {
 		      the_ins.opcode[0] ^= 0x0100;
 		      the_ins.opcode[0] |= 0x0006;
 		      addword (0x4EF9);
 		    }
-		  add_fix ('l', &opP->disp, 0, 0);
+		  add_fix ('l', &opP->disp, 0, 0, opP->disp.baserel);
 		  addword (0);
 		  addword (0);
 		  break;
 		}
 
 	      /* Now we know it's going into the relaxer.  Now figure
@@ -3239,26 +3305,26 @@ m68k_ip (char *instring)
 		      else
 			add_frag (adds (&opP->disp),
 				  SEXT (offs (&opP->disp)),
 				  TAB (DBCCABSJ, SZ_UNDEF));
 		      break;
 		    }
-		  add_fix ('w', &opP->disp, 1, 0);
+		  add_fix ('w', &opP->disp, 1, 0, opP->disp.baserel);
 		}
 	      addword (0);
 	      break;
 	    case 'C':		/* Fixed size LONG coproc branches.  */
-	      add_fix ('l', &opP->disp, 1, 0);
+	      add_fix ('l', &opP->disp, 1, 0, opP->disp.baserel);
 	      addword (0);
 	      addword (0);
 	      break;
 	    case 'c':		/* Var size Coprocesssor branches.  */
 	      if (subs (&opP->disp) || (adds (&opP->disp) == 0))
 		{
 		  the_ins.opcode[the_ins.numo - 1] |= 0x40;
-		  add_fix ('l', &opP->disp, 1, 0);
+		  add_fix ('l', &opP->disp, 1, 0, opP->disp.baserel);
 		  addword (0);
 		  addword (0);
 		}
 	      else
 		add_frag (adds (&opP->disp),
 			  SEXT (offs (&opP->disp)),
@@ -3706,13 +3772,13 @@ m68k_ip (char *instring)
 	case 't':
 	  tmpreg = get_num (&opP->disp, 20);
 	  install_operand (s[1], tmpreg);
 	  break;
 	case '_':	/* used only for move16 absolute 32-bit address.  */
 	  if (isvar (&opP->disp))
-	    add_fix ('l', &opP->disp, 0, 0);
+	    add_fix ('l', &opP->disp, 0, 0, opP->disp.baserel);
 	  tmpreg = get_num (&opP->disp, 90);
 	  addword (tmpreg >> 16);
 	  addword (tmpreg & 0xFFFF);
 	  break;
 	case 'u':
 	  install_operand (s[1], opP->reg - DATA0L);
@@ -4055,12 +4121,18 @@ insert_reg (const char *regname, int regnum)
 struct init_entry
   {
     const char *name;
     int number;
   };
 
+#if defined(TE_AMIGA)
+  #define FRAME ADDR5
+#else
+  #define FRAME ADDR6
+#endif
+
 static const struct init_entry init_table[] =
 {
   { "d0", DATA0 },
   { "d1", DATA1 },
   { "d2", DATA2 },
   { "d3", DATA3 },
@@ -4072,13 +4144,13 @@ static const struct init_entry init_table[] =
   { "a1", ADDR1 },
   { "a2", ADDR2 },
   { "a3", ADDR3 },
   { "a4", ADDR4 },
   { "a5", ADDR5 },
   { "a6", ADDR6 },
-  { "fp", ADDR6 },
+  { "fp", FRAME },
   { "a7", ADDR7 },
   { "sp", ADDR7 },
   { "ssp", ADDR7 },
   { "fp0", FP0 },
   { "fp1", FP1 },
   { "fp2", FP2 },
@@ -4443,13 +4515,14 @@ md_assemble (char *str)
 			      ((toP - frag_now->fr_literal)
 			       - the_ins.numo * 2 + the_ins.reloc[m].n),
 			      n,
 			      &the_ins.reloc[m].exp,
 			      the_ins.reloc[m].pcrel,
 			      get_reloc_code (n, the_ins.reloc[m].pcrel,
-					      the_ins.reloc[m].pic_reloc));
+					      the_ins.reloc[m].pic_reloc),
+			      the_ins.reloc[m].baserel);
 	  fixP->fx_pcrel_adjust = the_ins.reloc[m].pcrel_fix;
 	  if (the_ins.reloc[m].wid == 'B')
 	    fixP->fx_signed = 1;
 	}
       return;
     }
@@ -4505,13 +4578,14 @@ md_assemble (char *str)
 			      ((toP - frag_now->fr_literal)
 			       - the_ins.numo * 2 + the_ins.reloc[m].n),
 			      wid,
 			      &the_ins.reloc[m].exp,
 			      the_ins.reloc[m].pcrel,
 			      get_reloc_code (wid, the_ins.reloc[m].pcrel,
-					      the_ins.reloc[m].pic_reloc));
+					      the_ins.reloc[m].pic_reloc),
+			      the_ins.reloc[m].baserel);
 	  fixP->fx_pcrel_adjust = the_ins.reloc[m].pcrel_fix;
 	}
       (void) frag_var (rs_machine_dependent, FRAG_VAR_SIZE, 0,
 		       (relax_substateT) (the_ins.fragb[n].fragty),
 		       the_ins.fragb[n].fadd, the_ins.fragb[n].foff, to_beg_P);
     }
@@ -4542,13 +4616,14 @@ md_assemble (char *str)
 			  ((the_ins.reloc[m].n + toP - frag_now->fr_literal)
 			   - shorts_this_frag * 2),
 			  wid,
 			  &the_ins.reloc[m].exp,
 			  the_ins.reloc[m].pcrel,
 			  get_reloc_code (wid, the_ins.reloc[m].pcrel,
-					  the_ins.reloc[m].pic_reloc));
+					  the_ins.reloc[m].pic_reloc),
+			  the_ins.reloc[m].baserel);
       fixP->fx_pcrel_adjust = the_ins.reloc[m].pcrel_fix;
     }
 }
 
 /* Comparison function used by qsort to rank the opcode entries by name.  */
 
@@ -5058,29 +5133,29 @@ md_convert_frag_1 (fragS *fragP)
     case TAB (BRANCHBWPL, BYTE):
       know (issbyte (disp));
       if (disp == 0)
 	as_bad_where (fragP->fr_file, fragP->fr_line,
 		      _("short branch with zero offset: use :w"));
       fixP = fix_new (fragP, fragP->fr_fix - 1, 1, fragP->fr_symbol,
-		      fragP->fr_offset, 1, RELAX_RELOC_PC8);
+		      fragP->fr_offset, 1, RELAX_RELOC_PC8, 0);
       fixP->fx_pcrel_adjust = -1;
       break;
     case TAB (BRANCHBWL, SHORT):
     case TAB (BRABSJUNC, SHORT):
     case TAB (BRABSJCOND, SHORT):
     case TAB (BRANCHBW, SHORT):
     case TAB (BRANCHBWPL, SHORT):
       fragP->fr_opcode[1] = 0x00;
       fixP = fix_new (fragP, fragP->fr_fix, 2, fragP->fr_symbol,
-		      fragP->fr_offset, 1, RELAX_RELOC_PC16);
+		      fragP->fr_offset, 1, RELAX_RELOC_PC16, 0);
       fragP->fr_fix += 2;
       break;
     case TAB (BRANCHBWL, LONG):
       fragP->fr_opcode[1] = (char) 0xFF;
       fixP = fix_new (fragP, fragP->fr_fix, 4, fragP->fr_symbol,
-		      fragP->fr_offset, 1, RELAX_RELOC_PC32);
+		      fragP->fr_offset, 1, RELAX_RELOC_PC32, 0);
       fragP->fr_fix += 4;
       break;
     case TAB (BRANCHBWPL, LONG):
       /* Here we are converting an unconditional branch into a pair of
 	 conditional branches, in order to get the range.  */
       fragP->fr_opcode[0] = 0x66; /* bne */
@@ -5096,32 +5171,36 @@ md_convert_frag_1 (fragS *fragP)
       fragP->fr_fix += 2;  /* Skip second branch opcode */
       fixP = fix_new (fragP, fragP->fr_fix, 4, fragP->fr_symbol,
 		      fragP->fr_offset, 1, RELAX_RELOC_PC32);
       fragP->fr_fix += 4;
       break;
     case TAB (BRABSJUNC, LONG):
+      if (flag_small_code)
+	{
+	  as_bad (_("Long branch in small code model, not supported."));
+	} else
       if (fragP->fr_opcode[0] == 0x61)		/* jbsr */
 	{
 	  if (flag_keep_pcrel)
     	    as_bad_where (fragP->fr_file, fragP->fr_line,
 			  _("Conversion of PC relative BSR to absolute JSR"));
 	  fragP->fr_opcode[0] = 0x4E;
 	  fragP->fr_opcode[1] = (char) 0xB9; /* JSR with ABSL LONG operand.  */
 	  fixP = fix_new (fragP, fragP->fr_fix, 4, fragP->fr_symbol,
-			  fragP->fr_offset, 0, RELAX_RELOC_ABS32);
+			  fragP->fr_offset, 0, RELAX_RELOC_ABS32,0);
 	  fragP->fr_fix += 4;
 	}
       else if (fragP->fr_opcode[0] == 0x60)	/* jbra */
 	{
 	  if (flag_keep_pcrel)
 	    as_bad_where (fragP->fr_file, fragP->fr_line,
 		      _("Conversion of PC relative branch to absolute jump"));
 	  fragP->fr_opcode[0] = 0x4E;
 	  fragP->fr_opcode[1] = (char) 0xF9; /* JMP with ABSL LONG operand.  */
 	  fixP = fix_new (fragP, fragP->fr_fix, 4, fragP->fr_symbol,
-			  fragP->fr_offset, 0, RELAX_RELOC_ABS32);
+			  fragP->fr_offset, 0, RELAX_RELOC_ABS32, 0);
 	  fragP->fr_fix += 4;
 	}
       else
 	{
 	  /* This cannot happen, because jbsr and jbra are the only two
 	     unconditional branches.  */
@@ -5142,31 +5221,31 @@ md_convert_frag_1 (fragS *fragP)
 	   different frag, in which case referring to them is a no-no.
 	   Only fr_opcode[0,1] are guaranteed to work.  */
       *buffer_address++ = 0x4e;	/* put in jmp long (0x4ef9) */
       *buffer_address++ = (char) 0xf9;
       fragP->fr_fix += 2;	/* Account for jmp instruction.  */
       fixP = fix_new (fragP, fragP->fr_fix, 4, fragP->fr_symbol,
-		      fragP->fr_offset, 0, RELAX_RELOC_ABS32);
+		      fragP->fr_offset, 0, RELAX_RELOC_ABS32,0);
       fragP->fr_fix += 4;
       break;
     case TAB (FBRANCH, SHORT):
       know ((fragP->fr_opcode[1] & 0x40) == 0);
       fixP = fix_new (fragP, fragP->fr_fix, 2, fragP->fr_symbol,
-		      fragP->fr_offset, 1, RELAX_RELOC_PC16);
+		      fragP->fr_offset, 1, RELAX_RELOC_PC16, 0);
       fragP->fr_fix += 2;
       break;
     case TAB (FBRANCH, LONG):
       fragP->fr_opcode[1] |= 0x40;	/* Turn on LONG bit.  */
       fixP = fix_new (fragP, fragP->fr_fix, 4, fragP->fr_symbol,
-		      fragP->fr_offset, 1, RELAX_RELOC_PC32);
+		      fragP->fr_offset, 1, RELAX_RELOC_PC32, 0);
       fragP->fr_fix += 4;
       break;
     case TAB (DBCCLBR, SHORT):
     case TAB (DBCCABSJ, SHORT):
       fixP = fix_new (fragP, fragP->fr_fix, 2, fragP->fr_symbol,
-		      fragP->fr_offset, 1, RELAX_RELOC_PC16);
+		      fragP->fr_offset, 1, RELAX_RELOC_PC16,0);
       fragP->fr_fix += 2;
       break;
     case TAB (DBCCLBR, LONG):
       /* Only DBcc instructions can come here.
 	 Change dbcc into dbcc/bral.
 	 JF: these used to be fr_opcode[2-7], but that's wrong.  */
@@ -5180,13 +5259,13 @@ md_convert_frag_1 (fragS *fragP)
       *buffer_address++ = 0x06;
       *buffer_address++ = 0x60;     /* Put in bral (0x60ff).  */
       *buffer_address++ = (char) 0xff;
 
       fragP->fr_fix += 6;	/* Account for bra/jmp instructions.  */
       fixP = fix_new (fragP, fragP->fr_fix, 4, fragP->fr_symbol,
-		      fragP->fr_offset, 1, RELAX_RELOC_PC32);
+		      fragP->fr_offset, 1, RELAX_RELOC_PC32,0);
       fragP->fr_fix += 4;
       break;
     case TAB (DBCCABSJ, LONG):
       /* Only DBcc instructions can come here.
 	 Change dbcc into dbcc/jmp.
 	 JF: these used to be fr_opcode[2-7], but that's wrong.  */
@@ -5200,61 +5279,61 @@ md_convert_frag_1 (fragS *fragP)
       *buffer_address++ = 0x06;
       *buffer_address++ = 0x4e;		/* Put in jmp long (0x4ef9).  */
       *buffer_address++ = (char) 0xf9;
 
       fragP->fr_fix += 6;		/* Account for bra/jmp instructions.  */
       fixP = fix_new (fragP, fragP->fr_fix, 4, fragP->fr_symbol,
-		      fragP->fr_offset, 0, RELAX_RELOC_ABS32);
+		      fragP->fr_offset, 0, RELAX_RELOC_ABS32, 0);
       fragP->fr_fix += 4;
       break;
     case TAB (PCREL1632, SHORT):
       fragP->fr_opcode[1] &= ~0x3F;
       fragP->fr_opcode[1] |= 0x3A; /* 072 - mode 7.2 */
       fixP = fix_new (fragP, (int) (fragP->fr_fix), 2, fragP->fr_symbol,
-		      fragP->fr_offset, 1, RELAX_RELOC_PC16);
+		      fragP->fr_offset, 1, RELAX_RELOC_PC16, 0);
       fragP->fr_fix += 2;
       break;
     case TAB (PCREL1632, LONG):
       /* Already set to mode 7.3; this indicates: PC indirect with
 	 suppressed index, 32-bit displacement.  */
       *buffer_address++ = 0x01;
       *buffer_address++ = 0x70;
       fragP->fr_fix += 2;
       fixP = fix_new (fragP, (int) (fragP->fr_fix), 4, fragP->fr_symbol,
-		      fragP->fr_offset, 1, RELAX_RELOC_PC32);
+		      fragP->fr_offset, 1, RELAX_RELOC_PC32, 0);
       fixP->fx_pcrel_adjust = 2;
       fragP->fr_fix += 4;
       break;
     case TAB (PCINDEX, BYTE):
       gas_assert (fragP->fr_fix >= 2);
       buffer_address[-2] &= ~1;
       fixP = fix_new (fragP, fragP->fr_fix - 1, 1, fragP->fr_symbol,
-		      fragP->fr_offset, 1, RELAX_RELOC_PC8);
+		      fragP->fr_offset, 1, RELAX_RELOC_PC8, 0);
       fixP->fx_pcrel_adjust = 1;
       break;
     case TAB (PCINDEX, SHORT):
       gas_assert (fragP->fr_fix >= 2);
       buffer_address[-2] |= 0x1;
       buffer_address[-1] = 0x20;
       fixP = fix_new (fragP, (int) (fragP->fr_fix), 2, fragP->fr_symbol,
-		      fragP->fr_offset, 1, RELAX_RELOC_PC16);
+		      fragP->fr_offset, 1, RELAX_RELOC_PC16, 0);
       fixP->fx_pcrel_adjust = 2;
       fragP->fr_fix += 2;
       break;
     case TAB (PCINDEX, LONG):
       gas_assert (fragP->fr_fix >= 2);
       buffer_address[-2] |= 0x1;
       buffer_address[-1] = 0x30;
       fixP = fix_new (fragP, (int) (fragP->fr_fix), 4, fragP->fr_symbol,
-		      fragP->fr_offset, 1, RELAX_RELOC_PC32);
+		      fragP->fr_offset, 1, RELAX_RELOC_PC32, 0);
       fixP->fx_pcrel_adjust = 2;
       fragP->fr_fix += 4;
       break;
     case TAB (ABSTOPCREL, SHORT):
       fixP = fix_new (fragP, fragP->fr_fix, 2, fragP->fr_symbol,
-		      fragP->fr_offset, 1, RELAX_RELOC_PC16);
+		      fragP->fr_offset, 1, RELAX_RELOC_PC16,0);
       fragP->fr_fix += 2;
       break;
     case TAB (ABSTOPCREL, LONG):
       if (flag_keep_pcrel)
 	as_bad_where (fragP->fr_file, fragP->fr_line,
 		      _("Conversion of PC relative displacement to absolute"));
@@ -5262,15 +5341,87 @@ md_convert_frag_1 (fragS *fragP)
 	 ABSTOPCREL is really trying to shorten an ABSOLUTE address anyway.  */
       if ((fragP->fr_opcode[1] & 0x3F) != 0x3A)
 	abort ();
       fragP->fr_opcode[1] &= ~0x3F;
       fragP->fr_opcode[1] |= 0x39;	/* Mode 7.1 */
       fixP = fix_new (fragP, fragP->fr_fix, 4, fragP->fr_symbol,
-		      fragP->fr_offset, 0, RELAX_RELOC_ABS32);
+		      fragP->fr_offset, 0, RELAX_RELOC_ABS32, 0);
       fragP->fr_fix += 4;
       break;
+    case TAB (ABSREL, BYTE):
+      as_bad (_("ABSREL_BYTE: how the ** does this look??"));
+      break;
+    case TAB (ABSREL, SHORT):
+      fragP->fr_opcode[1] &= ~0x3f;
+      fragP->fr_fix += 2;
+      if (S_GET_TYPE (fragP->fr_symbol) == N_TEXT)
+	{
+	  /* so this is really a pc-relative address */
+	  fragP->fr_opcode[1] |= 0x3a;
+	  fix_new (fragP, fragP->fr_fix, 2, fragP->fr_symbol, fragP->fr_offset, 1, NO_RELOC, 0);
+	  break;
+	}
+      /* in that case we have to generate base-relative code
+       * (note: if we're in N_UNDF, this could as well be pc-relative, but the linker
+       *        will have to do the final patch in that case) */
+      fragP->fr_opcode[1] |= 0x2c;  /* (a4) */
+      fix_new (fragP, fragP->fr_fix, 2, fragP->fr_symbol, fragP->fr_offset, 0, NO_RELOC, 1);
+      break;
+    case TAB (ABSREL, LONG):
+      as_bad (_("ABSREL_LONG: sorry, not supported."));
+      break;
+    case TAB (IMMREL, BYTE):
+      as_bad (_("IMMREL_BYTE: how the ** does this look??"));
+      break;
+    case TAB (IMMREL, SHORT):
+      if (S_GET_TYPE (fragP->fr_symbol) == N_TEXT)
+	{
+	/* we can only fix operations on data registers, not on <ea> */
+	if ((fragP->fr_opcode[1] & 0x38) != 0)
+	  {
+	    /* use the normal reloc32, sigh... */
+	    fix_new (fragP, fragP->fr_fix, 4, fragP->fr_symbol, fragP->fr_offset, 0, NO_RELOC, 0);
+	    fragP->fr_fix += 4;
+	    break;
+	  }
+
+	  /* so this is really a pc-relative address
+	   * What we have to do now is a VERY UGLY AND BIG KLUDGE. Basically do the
+	   * following thing:
+	   *   turn
+	   *     addl #foo,d0      (foo is N_TEXT)
+	   *   into
+	   *     pea  foo(pc)
+	   *     addl (sp)+,d0
+	   */
+	  *buffer_address++ = fragP->fr_opcode[0]; /* save the original command */
+	  *buffer_address++ = fragP->fr_opcode[1];
+	  fragP->fr_opcode[0] = 0x48; 	/* PEA */
+	  fragP->fr_opcode[1] = 0x7a;
+	  fix_new (fragP, fragP->fr_fix, 2, fragP->fr_symbol, fragP->fr_offset, 1, NO_RELOC, 0);
+
+	  *buffer_address++ = 0x9f;	/* sp@+ */
+	  fragP->fr_fix += 4;	/* two byte fix, two byte code extension */
+	  break;
+	}
+      /* in that case we have to generate base-relative code
+       * (note: if we're in N_UNDF, this could as well be pc-relative, but the linker
+       *        will have to do the final patch in that case) */
+
+      /* analogous (more or less;-)) to above, the following conversion is done
+       *   turn
+       *     addl #bar,d0		(bar is N_DATA)
+       *   into
+       *	   addl #<bar>,d0	where <bar> is a baserel-reloc
+       *     addl a4,d0
+       */
+
+      fix_new (fragP, fragP->fr_fix, 4, fragP->fr_symbol, fragP->fr_offset, 0, NO_RELOC, 1);
+      *buffer_address++ = 0xd0;
+      *buffer_address++ = 0x8c;
+      break;
     }
   if (fixP)
     {
       fixP->fx_file = fragP->fr_file;
       fixP->fx_line = fragP->fr_line;
     }
@@ -5300,13 +5451,13 @@ md_estimate_size_before_relax (fragS *fragP, segT segment)
       {
 	if (S_GET_SEGMENT (fragP->fr_symbol) == segment
 	    && relaxable_symbol (fragP->fr_symbol))
 	  {
 	    fragP->fr_subtype = TAB (TABTYPE (fragP->fr_subtype), BYTE);
 	  }
-	else if (flag_short_refs)
+	else if (flag_short_refs || (0 && flag_small_code))
 	  {
 	    /* Symbol is undefined and we want short ref.  */
 	    fragP->fr_subtype = TAB (TABTYPE (fragP->fr_subtype), SHORT);
 	  }
 	else
 	  {
@@ -5372,12 +5523,27 @@ md_estimate_size_before_relax (fragS *fragP, segT segment)
 	  {
 	    fragP->fr_subtype = TAB (ABSTOPCREL, LONG);
 	  }
 	break;
       }
 
+    case TAB (ABSREL, SZ_UNDEF):
+      {
+	if ((S_GET_SEGMENT (fragP->fr_symbol) == segment
+	     && relaxable_symbol (fragP->fr_symbol))
+	    || flag_short_refs || (0 && flag_small_code))
+	  {
+	    fragP->fr_subtype = TAB (ABSREL, SHORT);
+	  }
+	else
+	  {
+	    fragP->fr_subtype = TAB (ABSREL, LONG);
+	  }
+	break;
+      }
+
     default:
       break;
     }
 
   /* Now that SZ_UNDEF are taken care of, check others.  */
   switch (fragP->fr_subtype)
@@ -5434,16 +5600,52 @@ md_ri_to_chars (char *the_bytes, struct reloc_info_generic *ri)
   /* Now the fun stuff.  */
   the_bytes[4] = (ri->r_symbolnum >> 16) & 0x0ff;
   the_bytes[5] = (ri->r_symbolnum >>  8) & 0x0ff;
   the_bytes[6] =  ri->r_symbolnum        & 0x0ff;
   the_bytes[7] = (((ri->r_pcrel << 7) & 0x80)
 		  | ((ri->r_length << 5) & 0x60)
-		  | ((ri->r_extern << 4) & 0x10));
+		  | ((ri->r_extern << 4) & 0x10)
+		  | ((ri->r_baserel << 3) & 0x08));
 }
 
+#endif /* comment */
+
+#if 0 /* FIXME: sba */
+#ifndef BFD_ASSEMBLER
+void
+tc_aout_fix_to_chars (where, fixP, segment_address_in_file)
+     char *where;
+     fixS *fixP;
+     relax_addressT segment_address_in_file;
+{
+  /*
+   * In: length of relocation (or of address) in chars: 1, 2 or 4.
+   * Out: GNU LD relocation length code: 0, 1, or 2.
+   */
+
+  static const unsigned char nbytes_r_length[] = {42, 0, 1, 42, 2};
+  long r_symbolnum;
+
+  know (fixP->fx_addsy != NULL);
+
+  md_number_to_chars (where,
+       fixP->fx_frag->fr_address + fixP->fx_where - segment_address_in_file,
+		      4);
+
+  r_symbolnum = (S_IS_DEFINED (fixP->fx_addsy)
+		 ? S_GET_TYPE (fixP->fx_addsy)
+		 : fixP->fx_addsy->sy_number);
+
+  where[4] = (r_symbolnum >> 16) & 0x0ff;
+  where[5] = (r_symbolnum >> 8) & 0x0ff;
+  where[6] = r_symbolnum & 0x0ff;
+  where[7] = (((fixP->fx_pcrel << 7) & 0x80) | ((nbytes_r_length[fixP->fx_size] << 5) & 0x60) |
+	      (((!S_IS_DEFINED (fixP->fx_addsy)) << 4) & 0x10) | ((fixP->tc_fix_data << 3) & 0x08));
+}
 #endif
+#endif /* 0 */
 
 #endif /* OBJ_AOUT or OBJ_BOUT */
 
 #ifndef WORKING_DOT_WORD
 int md_short_jump_size = 4;
 int md_long_jump_size = 6;
@@ -5472,13 +5674,13 @@ md_create_long_jump (char *ptr, addressT from_addr, addressT to_addr,
       if (flag_keep_pcrel)
     	as_fatal (_("Tried to convert PC relative branch to absolute jump"));
       offset = to_addr - S_GET_VALUE (to_symbol);
       md_number_to_chars (ptr, (valueT) 0x4EF9, 2);
       md_number_to_chars (ptr + 2, (valueT) offset, 4);
       fix_new (frag, (ptr + 2) - frag->fr_literal, 4, to_symbol, (offsetT) 0,
-	       0, NO_RELOC);
+	       0, NO_RELOC, 0);
     }
   else
     {
       offset = to_addr - (from_addr + 2);
       md_number_to_chars (ptr, (valueT) 0x60ff, 2);
       md_number_to_chars (ptr + 2, (valueT) offset, 4);
@@ -7519,13 +7721,13 @@ m68k_set_extension (char const *name, int allow_m, int silent)
    Invocation line includes a switch not recognized by the base assembler.
  */
 
 #ifdef OBJ_ELF
 const char *md_shortopts = "lSA:m:kQ:V";
 #else
-const char *md_shortopts = "lSA:m:k";
+const char *md_shortopts = "lSA:m:s:k";
 #endif
 
 struct option md_longopts[] = {
 #define OPTION_PIC (OPTION_MD_BASE)
   {"pic", no_argument, NULL, OPTION_PIC},
 #define OPTION_REGISTER_PREFIX_OPTIONAL (OPTION_MD_BASE + 1)
@@ -7564,12 +7766,19 @@ md_parse_option (int c, char *arg)
 
     case OPTION_PCREL:		/* --pcrel means never turn PC-relative
 				   branches into absolute jumps.  */
       flag_keep_pcrel = 1;
       break;
 
+    case 's':
+      if (!strcmp(arg, "c") || !strcmp(arg, "mallcode"))
+	flag_small_code = 1;
+      else
+	return 0;
+      break;
+
     case OPTION_PIC:
     case 'k':
       flag_want_pic = 1;
       break;			/* -pic, Position Independent Code.  */
 
     case OPTION_REGISTER_PREFIX_OPTIONAL:
@@ -7747,12 +7956,13 @@ md_show_usage (FILE *stream)
 	     : m68k_extensions[i].alias < 0 ? " m68k" : "");
   
   fprintf (stream, _("\
 -l			use 1 word for refs to undefined symbols [default 2]\n\
 -pic, -k		generate position independent code\n\
 -S			turn jbsr into jsr\n\
+-smallcode, -sc		small code model\n\
 --pcrel                 never turn PC-relative branches into absolute jumps\n\
 --register-prefix-optional\n\
 			recognize register names without prefix character\n\
 --bitwise-or		do not treat `|' as a comment character\n\
 --base-size-default-16	base reg without size is 16 bits\n\
 --base-size-default-32	base reg without size is 32 bits (default)\n\
@@ -7913,12 +8123,14 @@ md_pcrel_from (fixS *fixP)
 
   /* Because fx_pcrel_adjust is a char, and may be unsigned, we explicitly
      sign extend the value here.  */
   adjust = ((fixP->fx_pcrel_adjust & 0xff) ^ 0x80) - 0x80;
   if (adjust == 64)
     adjust = -1;
+  if (OBJ_AMIGAHUNK)
+    return -adjust;
   return fixP->fx_where + fixP->fx_frag->fr_address - adjust;
 }
 
 #ifdef OBJ_ELF
 void
 m68k_elf_final_processing (void)
diff --git a/gas/config/tc-m68k.h b/gas/config/tc-m68k.h
index bcf4607ebebe16d575166d666a536fb1fbdfeaee..144b7c7d783bab80bd84fa0e57cfce9f349a528f 100644
--- gas/config/tc-m68k.h
+++ gas/config/tc-m68k.h
@@ -30,20 +30,27 @@ struct fix;
 #ifdef TE_SUN3
 #define TARGET_FORMAT "a.out-sunos-big"
 #endif
 #ifdef TE_NetBSD
 #define TARGET_FORMAT "a.out-m68k-netbsd"
 #endif
+#ifdef TE_AMIGA
+#define TARGET_FORMAT "a.out-amiga"
+#endif
 #ifdef TE_LINUX
 #define TARGET_FORMAT "a.out-m68k-linux"
 #endif
 #ifndef TARGET_FORMAT
 #define TARGET_FORMAT "a.out-zero-big"
 #endif
 #endif
 
+#ifdef OBJ_AMIGAHUNK
+#define TARGET_FORMAT "amiga"
+#endif
+
 #ifdef OBJ_ELF
 #define TARGET_FORMAT "elf32-m68k"
 #endif
 
 #ifdef TE_APOLLO
 #define COFF_MAGIC		APOLLOM68KMAGIC
@@ -60,12 +67,17 @@ struct fix;
 
 #ifndef COFF_MAGIC
 #define COFF_MAGIC MC68MAGIC
 #endif
 #define TARGET_ARCH bfd_arch_m68k
 
+// FIXME: This was in binutils 2.14
+//#ifdef TE_AMIGA
+//#define DEFAULT_MAGIC_NUMBER_FOR_OBJECT_FILE (OMAGIC);	/* Magic byte for file header */
+//#endif
+
 #define tc_comment_chars m68k_comment_chars
 extern const char *m68k_comment_chars;
 
 #define LISTING_WORD_SIZE 2	/* A word is 2 bytes */
 #define LISTING_LHS_WIDTH 2	/* One word on the first line */
 #define LISTING_LHS_WIDTH_SECOND 2	/* One word on the second line */
@@ -152,12 +164,15 @@ extern int m68k_parse_long_option (char *);
 
 #define TARGET_ARCH bfd_arch_m68k
 
 extern struct relax_type md_relax_table[];
 #define TC_GENERIC_RELAX_TABLE md_relax_table
 
+#define TC_FIX_TYPE char
+#define TC_INIT_FIX_DATA(p)
+
 /* We can't do a byte jump to the next instruction, so in that case
    force word mode by faking AIM.  */
 #define md_prepare_relax_scan(fragP, address, aim, this_state, this_type) \
   do									  \
     {								 	  \
       if (aim == 0 && this_type->rlx_forward == 127)			  \
diff --git a/gas/config/tc-ppc.c b/gas/config/tc-ppc.c
index 208d76d847128c833f73713eff2b78deb610a764..11949323d80802138ec23fb8174727c0a7c4fd45 100644
--- gas/config/tc-ppc.c
+++ gas/config/tc-ppc.c
@@ -1421,22 +1421,28 @@ ppc_target_format (void)
 #  else
   return (ppc_obj64 ? "aixcoff64-rs6000" : "aixcoff-rs6000");
 #  endif
 #endif
 #endif
 #ifdef OBJ_ELF
+#ifdef TE_MORPHOS
+  return "elf32-morphos";
+#elif TE_AMIGAOS
+  return "elf32-amigaos";
+#else
 # ifdef TE_FreeBSD
   return (ppc_obj64 ? "elf64-powerpc-freebsd" : "elf32-powerpc-freebsd");
 # elif defined (TE_VXWORKS)
   return "elf32-powerpc-vxworks";
 # else
   return (target_big_endian
 	  ? (ppc_obj64 ? "elf64-powerpc" : "elf32-powerpc")
 	  : (ppc_obj64 ? "elf64-powerpcle" : "elf32-powerpcle"));
 # endif
 #endif
+#endif
 }
 
 /* Validate one entry in powerpc_opcodes[] or vle_opcodes[].
    Return TRUE if there's a problem, otherwise FALSE.  */
 
 static bfd_boolean
@@ -1872,12 +1878,24 @@ ppc_elf_suffix (char **str_p, expressionS *exp_p)
 
 #define MAP(str, reloc)   { str, sizeof (str) - 1, 1, 1, reloc }
 #define MAP32(str, reloc) { str, sizeof (str) - 1, 1, 0, reloc }
 #define MAP64(str, reloc) { str, sizeof (str) - 1, 0, 1, reloc }
 
   static const struct map_bfd mapping[] = {
+    /* MorphOS specifc relocs */
+	MAP ("drel",        	BFD_RELOC_PPC_MORPHOS_DREL),
+	MAP ("drell",       	BFD_RELOC_PPC_MORPHOS_DREL_LO),
+	MAP ("drelh",       	BFD_RELOC_PPC_MORPHOS_DREL_HI),
+	MAP ("drelha",      	BFD_RELOC_PPC_MORPHOS_DREL_HA),
+
+    /* AmigaOS4 specific relocs */
+    MAP ("brel",		BFD_RELOC_PPC_AMIGAOS_BREL),
+    MAP ("brel@l",		BFD_RELOC_PPC_AMIGAOS_BREL_LO),
+    MAP ("brel@h",		BFD_RELOC_PPC_AMIGAOS_BREL_HI),
+    MAP ("brel@ha",		BFD_RELOC_PPC_AMIGAOS_BREL_HA),
+
     MAP ("l",			BFD_RELOC_LO16),
     MAP ("h",			BFD_RELOC_HI16),
     MAP ("ha",			BFD_RELOC_HI16_S),
     MAP ("brtaken",		BFD_RELOC_PPC_B16_BRTAKEN),
     MAP ("brntaken",		BFD_RELOC_PPC_B16_BRNTAKEN),
     MAP ("got",			BFD_RELOC_16_GOTOFF),
@@ -2098,13 +2116,13 @@ ppc_elf_cons (int nbytes /* 1=.byte, 2=.word, 4=.long, 8=.llong */)
 	      p = frag_more (nbytes);
 	      memset (p, 0, nbytes);
 	      offset = 0;
 	      if (target_big_endian)
 		offset = nbytes - size;
 	      fix_new_exp (frag_now, p - frag_now->fr_literal + offset, size,
-			   &exp, 0, reloc);
+			   &exp, 0, reloc, 0);
 	    }
 	}
       else
 	emit_expr (&exp, (unsigned int) nbytes);
     }
   while (*input_line_pointer++ == ',');
@@ -3307,25 +3325,25 @@ md_assemble (char *str)
 
 	  fixP = fix_new_exp (frag_now,
 			      f - frag_now->fr_literal + offset,
 			      size,
 			      &fixups[i].exp,
 			      reloc_howto->pc_relative,
-			      fixups[i].reloc);
+			      fixups[i].reloc, 0);
 	}
       else
 	{
 	  const struct powerpc_operand *operand;
 
 	  operand = &powerpc_operands[fixups[i].opindex];
 	  fixP = fix_new_exp (frag_now,
 			      f - frag_now->fr_literal,
 			      insn_length,
 			      &fixups[i].exp,
 			      (operand->flags & PPC_OPERAND_RELATIVE) != 0,
-			      BFD_RELOC_UNUSED);
+			      BFD_RELOC_UNUSED, 0);
 	}
       fixP->fx_pcrel_adjust = fixups[i].opindex;
     }
 }
 
 /* Handle a macro.  Gather all the operands, transform them as
@@ -6650,12 +6668,16 @@ md_apply_fix (fixS *fixP, valueT *valP, segT seg ATTRIBUTE_UNUSED)
 	  size = 2;
 	  break;
 
 	case BFD_RELOC_8:
 	  if (fixP->fx_pcrel)
 	    {
+	case BFD_RELOC_PPC_MORPHOS_DREL:
+	case BFD_RELOC_PPC_MORPHOS_DREL_LO:
+	case BFD_RELOC_PPC_MORPHOS_DREL_HI:
+	case BFD_RELOC_PPC_MORPHOS_DREL_HA:
 #ifdef OBJ_ELF
 	    bad_pcrel:
 #endif
 	      if (fixP->fx_addsy)
 		{
 		  char *sfile;
@@ -6692,12 +6714,20 @@ md_apply_fix (fixS *fixP, valueT *valP, segT seg ATTRIBUTE_UNUSED)
 
 	case BFD_RELOC_VTABLE_ENTRY:
 	  fixP->fx_done = 0;
 	  break;
 
 #ifdef OBJ_ELF
+	case BFD_RELOC_PPC_AMIGAOS_BREL:
+	case BFD_RELOC_PPC_AMIGAOS_BREL_HI:
+	case BFD_RELOC_PPC_AMIGAOS_BREL_LO:
+	case BFD_RELOC_PPC_AMIGAOS_BREL_HA:
+	  md_number_to_chars (fixP->fx_frag->fr_literal + fixP->fx_where,
+			      value, 2);
+	  break;
+
 	  /* These can appear with @l etc. in data.  */
 	case BFD_RELOC_LO16:
 	  if (fixP->fx_pcrel)
 	    fixP->fx_r_type = BFD_RELOC_LO16_PCREL;
 	case BFD_RELOC_LO16_PCREL:
 	  size = 2;
diff --git a/gas/config/tc-sh.c b/gas/config/tc-sh.c
index 4db1a0913602aaf18d1390cc315f6db0fbdef649..ba0ed8e89e44a9ab8411662047e6f85b4f28d5d9 100644
--- gas/config/tc-sh.c
+++ gas/config/tc-sh.c
@@ -800,13 +800,13 @@ sh_cons_fix_new (fragS *frag, int off, int size, expressionS *exp)
     {
     error:
       as_bad (_("unsupported BFD relocation size %u"), size);
       r_type = BFD_RELOC_UNUSED;
     }
 
-  fix_new_exp (frag, off, size, exp, 0, r_type);
+  fix_new_exp (frag, off, size, exp, 0, r_type, 0);
 }
 
 /* The regular cons() function, that reads constants, doesn't support
    suffixes such as @GOT, @GOTOFF and @PLT, that generate
    machine-specific relocation types.  So we must define it here.  */
 /* Clobbers input_line_pointer, checks end-of-line.  */
@@ -2239,24 +2239,24 @@ insert (char *where, int how, int pcrel, sh_operand_info *op)
 {
   fix_new_exp (frag_now,
 	       where - frag_now->fr_literal,
 	       2,
 	       &op->immediate,
 	       pcrel,
-	       how);
+	       how, 0);
 }
 
 static void
 insert4 (char * where, int how, int pcrel, sh_operand_info * op)
 {
   fix_new_exp (frag_now,
 	       where - frag_now->fr_literal,
 	       4,
 	       & op->immediate,
 	       pcrel,
-	       how);
+	       how, 0);
 }
 static void
 build_relax (sh_opcode_info *opcode, sh_operand_info *op)
 {
   int high_byte = target_big_endian ? 0 : 1;
   char *p;
@@ -2320,13 +2320,13 @@ insert_loop_bounds (char *output, sh_operand_info *operand)
 #ifdef OBJ_COFF
       SF_SET_LOCAL (end_sym);
 #endif /* OBJ_COFF */
       symbol_table_insert (end_sym);
       end_sym->sy_value = operand[1].immediate;
       end_sym->sy_value.X_add_number += 2;
-      fix_new (frag_now, frag_now_fix (), 2, end_sym, 0, 1, BFD_RELOC_SH_LABEL);
+      fix_new (frag_now, frag_now_fix (), 2, end_sym, 0, 1, BFD_RELOC_SH_LABEL, 0);
     }
 
   output = frag_more (2);
   output[0] = 0x8e;
   output[1] = 0x8e;
   insert (output, BFD_RELOC_SH_LOOP_START, 1, operand);
@@ -2974,13 +2974,13 @@ md_assemble (char *str)
   if (sh_relax
       && ! seg_info (now_seg)->tc_segment_info_data.in_code)
     {
       /* Output a CODE reloc to tell the linker that the following
          bytes are instructions, not data.  */
       fix_new (frag_now, frag_now_fix (), 2, &abs_symbol, 0, 0,
-	       BFD_RELOC_SH_CODE);
+	       BFD_RELOC_SH_CODE, 0);
       seg_info (now_seg)->tc_segment_info_data.in_code = 1;
     }
 
   if (opcode->nibbles[0] == PPI)
     {
       size = assemble_ppi (op_end, opcode);
@@ -3055,13 +3055,13 @@ sh_frob_label (symbolS *sym)
       int offset;
 
       offset = frag_now_fix ();
       if (frag_now != last_label_frag
 	  || offset != last_label_offset)
 	{
-	  fix_new (frag_now, offset, 2, &abs_symbol, 0, 0, BFD_RELOC_SH_LABEL);
+	  fix_new (frag_now, offset, 2, &abs_symbol, 0, 0, BFD_RELOC_SH_LABEL, 0);
 	  last_label_frag = frag_now;
 	  last_label_offset = offset;
 	}
     }
 
   dwarf2_emit_label (sym);
@@ -3074,13 +3074,13 @@ void
 sh_flush_pending_output (void)
 {
   if (sh_relax
       && seg_info (now_seg)->tc_segment_info_data.in_code)
     {
       fix_new (frag_now, frag_now_fix (), 2, &abs_symbol, 0, 0,
-	       BFD_RELOC_SH_DATA);
+	       BFD_RELOC_SH_DATA, 0);
       seg_info (now_seg)->tc_segment_info_data.in_code = 0;
     }
 }
 
 symbolS *
 md_undefined_symbol (char *name ATTRIBUTE_UNUSED)
@@ -3115,13 +3115,13 @@ s_uses (int ignore ATTRIBUTE_UNUSED)
     {
       as_bad (_("bad .uses format"));
       ignore_rest_of_line ();
       return;
     }
 
-  fix_new_exp (frag_now, frag_now_fix (), 2, &ex, 1, BFD_RELOC_SH_USES);
+  fix_new_exp (frag_now, frag_now_fix (), 2, &ex, 1, BFD_RELOC_SH_USES, 0);
 
   demand_empty_rest_of_line ();
 }
 
 enum options
 {
@@ -3514,13 +3514,13 @@ sh_frob_section (bfd *abfd ATTRIBUTE_UNUSED, segT sec,
       /* Generate a BFD_RELOC_SH_COUNT fixup at the location of sym.
 	 We have already adjusted the value of sym to include the
 	 fragment address, so we undo that adjustment here.  */
       subseg_change (sec, 0);
       fix_new (fscan->fx_frag,
 	       S_GET_VALUE (sym) - fscan->fx_frag->fr_address,
-	       4, &abs_symbol, info.count, 0, BFD_RELOC_SH_COUNT);
+	       4, &abs_symbol, info.count, 0, BFD_RELOC_SH_COUNT, 0);
     }
 }
 
 /* This function is called after the symbol table has been completed,
    but before the relocs or section contents have been written out.
    If we have seen any .uses pseudo-ops, they point to an instruction
@@ -3555,21 +3555,21 @@ md_convert_frag (bfd *headers ATTRIBUTE_UNUSED, segT seg, fragS *fragP)
   switch (fragP->fr_subtype)
     {
     case C (COND_JUMP, COND8):
     case C (COND_JUMP_DELAY, COND8):
       subseg_change (seg, 0);
       fix_new (fragP, fragP->fr_fix, 2, fragP->fr_symbol, fragP->fr_offset,
-	       1, BFD_RELOC_SH_PCDISP8BY2);
+	       1, BFD_RELOC_SH_PCDISP8BY2, 0);
       fragP->fr_fix += 2;
       fragP->fr_var = 0;
       break;
 
     case C (UNCOND_JUMP, UNCOND12):
       subseg_change (seg, 0);
       fix_new (fragP, fragP->fr_fix, 2, fragP->fr_symbol, fragP->fr_offset,
-	       1, BFD_RELOC_SH_PCDISP12BY2);
+	       1, BFD_RELOC_SH_PCDISP12BY2, 0);
       fragP->fr_fix += 2;
       fragP->fr_var = 0;
       break;
 
     case C (UNCOND_JUMP, UNCOND32):
     case C (UNCOND_JUMP, UNDEF_WORD_DISP):
@@ -3620,19 +3620,19 @@ md_convert_frag (bfd *headers ATTRIBUTE_UNUSED, segT seg, fragS *fragP)
 	   its delay-slot insn already makes the branch reach.  */
 
 	/* Build a relocation to six / four bytes farther on.  */
 	subseg_change (seg, 0);
 	fix_new (fragP, fragP->fr_fix, 2, section_symbol (seg),
 		 fragP->fr_address + fragP->fr_fix + (delay ? 4 : 6),
-		 1, BFD_RELOC_SH_PCDISP8BY2);
+		 1, BFD_RELOC_SH_PCDISP8BY2, 0);
 
 	/* Set up a jump instruction.  */
 	buffer[highbyte + 2] = 0xa0;
 	buffer[lowbyte + 2] = 0;
 	fix_new (fragP, fragP->fr_fix + 2, 2, fragP->fr_symbol,
-		 fragP->fr_offset, 1, BFD_RELOC_SH_PCDISP12BY2);
+		 fragP->fr_offset, 1, BFD_RELOC_SH_PCDISP12BY2, 0);
 
 	if (delay)
 	  {
 	    buffer[highbyte] &= ~0x4; /* Removes delay slot from branch.  */
 	    fragP->fr_fix += 4;
 	  }
@@ -3798,13 +3798,13 @@ sh_handle_align (fragS *frag)
       && (frag->fr_type == rs_align
 	  || frag->fr_type == rs_align_code)
       && frag->fr_address + frag->fr_fix > 0
       && frag->fr_offset > 1
       && now_seg != bss_section)
     fix_new (frag, frag->fr_fix, 2, &abs_symbol, frag->fr_offset, 0,
-	     BFD_RELOC_SH_ALIGN);
+	     BFD_RELOC_SH_ALIGN, 0);
 }
 
 /* See whether the relocation should be resolved locally.  */
 
 static bfd_boolean
 sh_local_pcrel (fixS *fix)
diff --git a/gas/config/te-amiga.h b/gas/config/te-amiga.h
new file mode 100644
index 0000000000000000000000000000000000000000..a7b93727031092cdeb4bf66e3813663d66d79c3b
--- /dev/null
+++ gas/config/te-amiga.h
@@ -0,0 +1,24 @@
+/*
+ * te-amiga.h -- Amiga target environment declarations.
+ */
+
+#define TE_AMIGA 1
+
+#define LOCAL_LABELS_DOLLAR 1
+#define LOCAL_LABELS_FB 1
+
+#ifdef OBJ_HEADER
+#include OBJ_HEADER
+#else
+#include "obj-format.h"
+#endif
+
+#define TC_IMPLICIT_LCOMM_ALIGNMENT(SIZE, P2VAR)	\
+  do {							\
+    if ((SIZE) >= 4)                                 	\
+      (P2VAR) = 2;					\
+    else if ((SIZE) >= 2)				\
+      (P2VAR) = 1;					\
+    else						\
+      (P2VAR) = 0;					\
+  } while (0)
diff --git a/gas/config/te-amigaos.h b/gas/config/te-amigaos.h
new file mode 100644
index 0000000000000000000000000000000000000000..8bd15a3d19b3f383e6756d6e307bd10dc4dcfb6f
--- /dev/null
+++ gas/config/te-amigaos.h
@@ -0,0 +1,14 @@
+/*
+ * te-amigaos.h -- Amiga target environment declarations.
+ */
+
+#define TE_AMIGAOS 1
+
+#define LOCAL_LABELS_DOLLAR 1
+#define LOCAL_LABELS_FB 1
+
+#ifdef OBJ_HEADER
+#include OBJ_HEADER
+#else
+#include "obj-format.h"
+#endif
diff --git a/gas/config/te-nbsd.h b/gas/config/te-amithlon.h
similarity index 65%
copy from gas/config/te-nbsd.h
copy to gas/config/te-amithlon.h
index ce291014824771b2081438766002c479eeb60d9b..2fbd88551330d46e5cd585d142d67e6b7efe1624 100644
--- gas/config/te-nbsd.h
+++ gas/config/te-amithlon.h
@@ -1,24 +1,26 @@
-/* te-nbsd.h -- NetBSD target environment declarations.
-   Copyright 1987, 1990, 1991, 1992, 1994, 1998, 2000, 2005, 2007
-   Free Software Foundation, Inc.
+/* te-amithlon.h -- Amithlon target environment declarations.
+   Copyright 2000 Free Software Foundation, Inc.
 
    This file is part of GAS, the GNU Assembler.
 
    GAS is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 3, or (at your option)
+   the Free Software Foundation; either version 2, or (at your option)
    any later version.
 
    GAS is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
 
    You should have received a copy of the GNU General Public License
    along with GAS; see the file COPYING.  If not, write to the Free
-   Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA
-   02110-1301, USA.  */
+   Software Foundation, 59 Temple Place - Suite 330, Boston, MA
+   02111-1307, USA.  */
 
-#define TE_NetBSD	1
+#define TE_Amithlon 1
+
+#define LOCAL_LABELS_DOLLAR 1
 #define LOCAL_LABELS_FB 1
+
 #include "obj-format.h"
diff --git a/gas/config/te-morphos.h b/gas/config/te-morphos.h
new file mode 100644
index 0000000000000000000000000000000000000000..43b0826fa79d9e9c97485cc6dd7d919771defbf9
--- /dev/null
+++ gas/config/te-morphos.h
@@ -0,0 +1,14 @@
+/*
+ * te-amiga.h -- Amiga target environment declarations.
+ */
+
+#define TE_MORPHOS 1
+
+#define LOCAL_LABELS_DOLLAR 1
+#define LOCAL_LABELS_FB 1
+
+#ifdef OBJ_HEADER
+#include OBJ_HEADER
+#else
+#include "obj-format.h"
+#endif
diff --git a/gas/configure b/gas/configure
index 2e674491f392b756186c52f7b0d28de8a20398c5..6eabef030df837c80ab009e12ad99a3086df5e43 100755
--- gas/configure
+++ gas/configure
@@ -12500,12 +12500,19 @@ _ACEOF
 
 cat >>confdefs.h <<_ACEOF
 #define DEFAULT_EMULATION "$DEFAULT_EMULATION"
 _ACEOF
 
 
+# FIXME: As of version 2.18 of binutils, MANY_SEGMENTS no longer exists
+#case ${primary_bfd_gas}-${target_cpu_type}-${obj_format} in
+#  yes-*-coff)	need_bfd=yes ;;
+#  no-*-coff | yes-m68k-amigahunk | no-m68k-amigahunk)	need_bfd=yes
+#		AC_DEFINE(MANY_SEGMENTS, 1, [old COFF support?]) ;;
+#esac
+
 reject_dev_configs=yes
 
 case ${reject_dev_configs}-${dev} in
   yes-yes) # Oops.
     as_fn_error "GAS does not support the ${generic_target} configuration." "$LINENO" 5
     ;;
@@ -12549,12 +12556,25 @@ _ACEOF
 
 cat >>confdefs.h <<_ACEOF
 #define TARGET_OS "${target_os}"
 _ACEOF
 
 
+### begin-GG-local
+# Check for additional host specific CFLAGS.
+echo "$as_me:$LINENO: checking for host dependent CFLAGS" >&5
+echo $ECHO_N "checking for host dependent CFLAGS... $ECHO_C" >&6
+other_host_cflags=""
+case "${host}" in
+	m68k-*-amigaos*)	other_host_cflags="-mstackextend" ;;
+esac
+test -n "$other_host_cflags" && CFLAGS="$CFLAGS $other_host_cflags"
+echo "$as_me:$LINENO: result: $other_host_cflags" >&5
+echo "${ECHO_T}$other_host_cflags" >&6
+### end-GG-local
+
 for ac_prog in 'bison -y' byacc
 do
   # Extract the first word of "$ac_prog", so it can be a program name with args.
 set dummy $ac_prog; ac_word=$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
diff --git a/gas/configure.in b/gas/configure.in
index 14f6edfe5deb041e968454931c451e1da226e0d1..183d98e8a4ac56e2e8a7a87f7b824f302bbb04f4 100644
--- gas/configure.in
+++ gas/configure.in
@@ -598,12 +598,19 @@ if test `set . $emfiles ; shift ; echo $#` -gt 0 ; then
 fi
 AC_SUBST(extra_objects)
 AC_DEFINE_UNQUOTED(EMULATIONS, $EMULATIONS, [Supported emulations.])
 AC_DEFINE_UNQUOTED(DEFAULT_EMULATION, "$DEFAULT_EMULATION",
 		   [Default emulation.])
 
+# FIXME: As of version 2.18 of binutils, MANY_SEGMENTS no longer exists
+#case ${primary_bfd_gas}-${target_cpu_type}-${obj_format} in
+#  yes-*-coff)	need_bfd=yes ;;
+#  no-*-coff | yes-m68k-amigahunk | no-m68k-amigahunk)	need_bfd=yes
+#		AC_DEFINE(MANY_SEGMENTS, 1, [old COFF support?]) ;;
+#esac
+
 reject_dev_configs=yes
 
 case ${reject_dev_configs}-${dev} in
   yes-yes) # Oops.
     AC_MSG_ERROR(GAS does not support the ${generic_target} configuration.)
     ;;
@@ -628,12 +635,23 @@ AC_SUBST(OPCODES_LIB)
 AC_DEFINE_UNQUOTED(TARGET_ALIAS,	"${target_alias}", [Target alias.])
 AC_DEFINE_UNQUOTED(TARGET_CANONICAL,	"${target}",       [Canonical target.])
 AC_DEFINE_UNQUOTED(TARGET_CPU,		"${target_cpu}",   [Target CPU.])
 AC_DEFINE_UNQUOTED(TARGET_VENDOR,	"${target_vendor}", [Target vendor.])
 AC_DEFINE_UNQUOTED(TARGET_OS,		"${target_os}",    [Target OS.])
 
+### begin-GG-local
+# Check for additional host specific CFLAGS.
+AC_MSG_CHECKING(for host dependent CFLAGS)
+other_host_cflags=""
+case "${host}" in
+	m68k-*-amigaos*)	other_host_cflags="-mstackextend" ;;
+esac
+test -n "$other_host_cflags" && CFLAGS="$CFLAGS $other_host_cflags"
+AC_MSG_RESULT($other_host_cflags)
+### end-GG-local
+
 AC_PROG_YACC
 AM_PROG_LEX
 
 ALL_LINGUAS="fr tr es rw id ru fi ja"
 ZW_GNU_GETTEXT_SISTER_DIR
 AM_PO_SUBDIRS
diff --git a/gas/configure.tgt b/gas/configure.tgt
index 9e44de000145c39abfd3ea325656a4d4bc066198..61f24acdb98484f43ac0c08d3cacfd38b1c1fb8b 100644
--- gas/configure.tgt
+++ gas/configure.tgt
@@ -40,13 +40,14 @@ case ${cpu} in
   cr16*)		cpu_type=cr16 endian=little ;;
   crisv32)		cpu_type=cris arch=crisv32 ;;
   crx*)			cpu_type=crx endian=little ;;
   epiphany*)		cpu_type=epiphany endian=little ;;
   fido)			cpu_type=m68k ;;
   hppa*)		cpu_type=hppa ;;
-  i[3-7]86)		cpu_type=i386 arch=i386;;
+  i[3-7]86)		cpu_type=i386 arch=i386 endian=little ;;
+  i[3-7]86)		cpu_type=i386 arch=i386 endian=big ;;
   ia64)			cpu_type=ia64 ;;
   ip2k)			cpu_type=ip2k endian=big ;;
   iq2000)		cpu_type=iq2000 endian=big ;;
   lm32)			cpu_type=lm32 ;;
   m32c)			cpu_type=m32c endian=little ;;
   m32r)			cpu_type=m32r endian=big ;;
@@ -181,12 +182,13 @@ case ${generic_target} in
   h8300-*-elf | h8300-*-rtems*)		fmt=elf ;;
 
   i370-*-elf* | i370-*-linux*)		fmt=elf ;;
 
   i386-ibm-aix*)			fmt=coff em=i386aix ;;
   i386-sequent-bsd*)			fmt=aout em=dynix ;;
+  i386-*-amithlon*)	    		fmt=elf em=amithlon ;;
   i386-*-beospe*)			fmt=coff em=pe ;;
   i386-*-beos*)				fmt=elf ;;
   i386-*-coff)				fmt=coff ;;
   i386-*-elf)				fmt=elf ;;
   i386-*-kaos*)				fmt=elf ;;
   i386-*-bsd*)				fmt=aout em=386bsd ;;
@@ -271,12 +273,14 @@ case ${generic_target} in
   m32r-*-elf* | m32r-*-rtems*)		fmt=elf ;;
   m32r-*-linux*)			fmt=elf em=linux;;
 
   m68hc11-*-* | m6811-*-*)		fmt=elf ;;
   m68hc12-*-* | m6812-*-*)		fmt=elf ;;
 
+  m68k-*-amigaoshunk)		fmt=amigahunk em=amiga bfd_gas=yes ;;
+  m68k-*-amigaos*)			fmt=aout em=amiga ;;
   m68k-*-aout)				fmt=aout bfd_gas=yes ;;
   m68k-*-elf*)				fmt=elf ;;
   m68k-*-sysv4*)			fmt=elf em=svr4 ;;
   m68k-*-rtems*)			fmt=elf ;;
   m68k-*-linux-*)			fmt=elf em=linux ;;
   m68k-*-uclinux*)			fmt=elf em=uclinux ;;
@@ -338,12 +342,14 @@ case ${generic_target} in
 
   or32-*-rtems*)			fmt=elf ;;
   or32-*-elf)				fmt=elf ;;
 
   pj*)					fmt=elf ;;
 
+  ppc-*-amigaos*)         		fmt=elf em=amigaos ;;
+  ppc-*-morphos*)			fmt=elf em=morphos ;;
   ppc-*-pe | ppc-*-cygwin*)		fmt=coff em=pe ;;
   ppc-*-winnt*)				fmt=coff em=pe ;;
   ppc-*-aix5.[01])			fmt=coff em=aix5 ;;
   ppc-*-aix[5-9].*)			fmt=coff em=aix5 ;;
   ppc-*-aix*)				fmt=coff ;;
   ppc-*-beos*)				fmt=coff ;;
diff --git a/gas/read.c b/gas/read.c
index 21c42b27342fb8e2c687417bcdacc4c16e3905b7..9de62b9c512025212d52a19833ffe28004944dd1 100644
--- gas/read.c
+++ gas/read.c
@@ -43,12 +43,16 @@
 #include "wchar.h"
 
 #ifndef TC_START_LABEL
 #define TC_START_LABEL(x,y,z) (x == ':')
 #endif
 
+#ifdef OBJ_AMIGAHUNK
+extern segT data_chip_section, bss_chip_section;
+#endif
+
 /* Set by the object-format or the target.  */
 #ifndef TC_IMPLICIT_LCOMM_ALIGNMENT
 #define TC_IMPLICIT_LCOMM_ALIGNMENT(SIZE, P2VAR)		\
   do								\
     {								\
       if ((SIZE) >= 8)						\
@@ -314,12 +318,15 @@ static const pseudo_typeS potable[] = {
 #endif
   {"byte", cons, 1},
   {"comm", s_comm, 0},
   {"common", s_mri_common, 0},
   {"common.s", s_mri_common, 1},
   {"data", s_data, 0},
+#ifdef OBJ_AMIGAHUNK
+  {"datachip", s_data_chip, 0},
+#endif
   {"dc", cons, 2},
 #ifdef TC_ADDRESS_BYTES
   {"dc.a", cons, 0},
 #endif
   {"dc.b", cons, 1},
   {"dc.d", float_cons, 'd'},
@@ -1895,12 +1902,22 @@ s_data (int ignore ATTRIBUTE_UNUSED)
 
   subseg_set (section, (subsegT) temp);
 
   demand_empty_rest_of_line ();
 }
 
+#ifdef OBJ_AMIGAHUNK
+void
+s_data_chip (int ignore ATTRIBUTE_UNUSED)
+{
+  int temp = get_absolute_expression ();
+  subseg_set (data_chip_section, (subsegT) temp);
+  demand_empty_rest_of_line ();
+}
+#endif
+
 /* Handle the .appfile pseudo-op.  This is automatically generated by
    do_scrub_chars when a preprocessor # line comment is seen with a
    file name.  This default definition may be overridden by the object
    or CPU specific pseudo-ops.  This function is also the default
    definition for .file; the APPFILE argument is 1 for .appfile, 0 for
    .file.  */
@@ -4526,13 +4543,13 @@ emit_expr_fix (expressionS *exp, unsigned int nbytes, fragS *frag, char *p)
 {
   memset (p, 0, nbytes);
 
   /* Generate a fixS to record the symbol value.  */
 
 #ifdef TC_CONS_FIX_NEW
-  TC_CONS_FIX_NEW (frag, p - frag->fr_literal, nbytes, exp);
+  TC_CONS_FIX_NEW (frag, p - frag->fr_literal, nbytes, exp, 0);
 #else
   {
     bfd_reloc_code_real_type r;
 
     switch (nbytes)
       {
@@ -4554,13 +4571,13 @@ emit_expr_fix (expressionS *exp, unsigned int nbytes, fragS *frag, char *p)
       default:
 	as_bad (_("unsupported BFD relocation size %u"), nbytes);
 	r = BFD_RELOC_32;
 	break;
       }
     fix_new_exp (frag, p - frag->fr_literal, (int) nbytes, exp,
-		 0, r);
+		 0, r, 0);
   }
 #endif
 }
 
 #ifdef BITFIELD_CONS_EXPRESSIONS
 
diff --git a/gas/read.h b/gas/read.h
index 4e5d1bbd2dc7b0724a2fc047db01f97aec8a4bac..59e787e754a14e11195607d382f81992423584cb 100644
--- gas/read.h
+++ gas/read.h
@@ -130,12 +130,16 @@ extern void do_repeat (int,const char *,const char *);
 extern void do_repeat_with_expander (int, const char *, const char *, const char *);
 extern void end_repeat (int);
 extern void do_parse_cons_expression (expressionS *, int);
 
 extern void generate_lineno_debug (void);
 
+#ifdef OBJ_AMIGAHUNK
+extern void s_data_chip (int);
+#endif
+
 extern void s_abort (int) ATTRIBUTE_NORETURN;
 extern void s_align_bytes (int arg);
 extern void s_align_ptwo (int);
 extern void bss_alloc (symbolS *, addressT, int);
 extern offsetT parse_align (int);
 extern symbolS *s_comm_internal (int, symbolS *(*) (int, symbolS *, addressT));
diff --git a/gas/write.c b/gas/write.c
index 56ebb6c565bea35df43565b53206156270a41b66..8a9746c927a3e8b7007cdec9c7f16e47509b5f45 100644
--- gas/write.c
+++ gas/write.c
@@ -149,13 +149,14 @@ fix_new_internal (fragS *frag,		/* Which frag?  */
 		  int size,		/* 1, 2, or 4 usually.  */
 		  symbolS *add_symbol,	/* X_add_symbol.  */
 		  symbolS *sub_symbol,	/* X_op_symbol.  */
 		  offsetT offset,	/* X_add_number.  */
 		  int pcrel,		/* TRUE if PC-relative relocation.  */
 		  RELOC_ENUM r_type	/* Relocation type.  */,
-		  int at_beginning)	/* Add to the start of the list?  */
+		  int at_beginning,	/* Add to the start of the list?  */
+		  int baserel ATTRIBUTE_UNUSED) /* TRUE if base-relative data */
 {
   fixS *fixP;
 
   n_fixups++;
 
   fixP = (fixS *) obstack_alloc (&notes, sizeof (fixS));
@@ -188,14 +189,17 @@ fix_new_internal (fragS *frag,		/* Which frag?  */
 #ifdef USING_CGEN
   fixP->fx_cgen.insn = NULL;
   fixP->fx_cgen.opinfo = 0;
 #endif
 
 #ifdef TC_FIX_TYPE
+#ifndef TC_PPC
+  fixP->tc_fix_data = baserel;
   TC_INIT_FIX_DATA (fixP);
 #endif
+#endif
 
   as_where (&fixP->fx_file, &fixP->fx_line);
 
   {
 
     fixS **seg_fix_rootP = (frags_chained
@@ -232,29 +236,31 @@ fixS *
 fix_new (fragS *frag,		/* Which frag?  */
 	 int where,			/* Where in that frag?  */
 	 int size,			/* 1, 2, or 4 usually.  */
 	 symbolS *add_symbol,	/* X_add_symbol.  */
 	 offsetT offset,		/* X_add_number.  */
 	 int pcrel,			/* TRUE if PC-relative relocation.  */
-	 RELOC_ENUM r_type		/* Relocation type.  */)
+	 RELOC_ENUM r_type,		/* Relocation type.  */
+     int baserel)		/* TRUE if base-relative data */
 {
   return fix_new_internal (frag, where, size, add_symbol,
-			   (symbolS *) NULL, offset, pcrel, r_type, FALSE);
+			   (symbolS *) NULL, offset, pcrel, r_type, FALSE, baserel);
 }
 
 /* Create a fixup for an expression.  Currently we only support fixups
    for difference expressions.  That is itself more than most object
    file formats support anyhow.  */
 
 fixS *
 fix_new_exp (fragS *frag,		/* Which frag?  */
 	     int where,			/* Where in that frag?  */
 	     int size,			/* 1, 2, or 4 usually.  */
 	     expressionS *exp,		/* Expression.  */
 	     int pcrel,			/* TRUE if PC-relative relocation.  */
-	     RELOC_ENUM r_type		/* Relocation type.  */)
+	     RELOC_ENUM r_type,		/* Relocation type.  */
+	     int baserel)		/* TRUE if base-relative data */
 {
   symbolS *add = NULL;
   symbolS *sub = NULL;
   offsetT off = 0;
 
   switch (exp->X_op)
@@ -274,13 +280,13 @@ fix_new_exp (fragS *frag,		/* Which frag?  */
 
 	exp->X_op = O_symbol;
 	exp->X_op_symbol = 0;
 	exp->X_add_symbol = stmp;
 	exp->X_add_number = 0;
 
-	return fix_new_exp (frag, where, size, exp, pcrel, r_type);
+	return fix_new_exp (frag, where, size, exp, pcrel, r_type, baserel);
       }
 
     case O_symbol_rva:
       add = exp->X_add_symbol;
       off = exp->X_add_number;
       r_type = BFD_RELOC_RVA;
@@ -304,24 +310,24 @@ fix_new_exp (fragS *frag,		/* Which frag?  */
     default:
       add = make_expr_symbol (exp);
       break;
     }
 
   return fix_new_internal (frag, where, size, add, sub, off, pcrel,
-			   r_type, FALSE);
+			   r_type, FALSE, baserel);
 }
 
 /* Create a fixup at the beginning of FRAG.  The arguments are the same
    as for fix_new, except that WHERE is implicitly 0.  */
 
 fixS *
 fix_at_start (fragS *frag, int size, symbolS *add_symbol,
 	      offsetT offset, int pcrel, RELOC_ENUM r_type)
 {
   return fix_new_internal (frag, 0, size, add_symbol,
-			   (symbolS *) NULL, offset, pcrel, r_type, TRUE);
+			   (symbolS *) NULL, offset, pcrel, r_type, TRUE, 0);
 }
 
 /* Generic function to determine whether a fixup requires a relocation.  */
 int
 generic_force_reloc (fixS *fix)
 {
@@ -892,12 +898,19 @@ adjust_reloc_syms (bfd *abfd ATTRIBUTE_UNUSED,
    For each one, call md_apply_fix to put the fix into the frag data.
 
    Result is a count of how many relocation structs will be needed to
    handle the remaining fixS's that we couldn't completely handle here.
    These will be output later by emit_relocations().  */
 
+/* FIXME: There was following code here
+#if !defined(BFD_ASSEMBLER) && !defined(MANY_SEGMENTS)
+      if (fixP->tc_fix_data && add_number != fixP->fx_offset)
+        add_number -= text_last_frag->fr_address;
+#endif
+*/
+
 static long
 fixup_segment (fixS *fixP, segT this_segment)
 {
   long seg_reloc_count = 0;
   valueT add_number;
   fragS *fragP;
@@ -1890,17 +1903,17 @@ write_object_file (void)
 	  exp.X_add_symbol = lie->add;
 	  exp.X_op_symbol = lie->sub;
 	  exp.X_add_number = lie->addnum;
 #ifdef TC_CONS_FIX_NEW
 	  TC_CONS_FIX_NEW (lie->frag,
 			   lie->word_goes_here - lie->frag->fr_literal,
-			   2, &exp);
+			   2, &exp, 0);
 #else
 	  fix_new_exp (lie->frag,
 		       lie->word_goes_here - lie->frag->fr_literal,
-		       2, &exp, 0, BFD_RELOC_16);
+		       2, &exp, 0, BFD_RELOC_16, 0);
 #endif
 	  *prevP = lie->next_broken_word;
 	}
       else
 	prevP = &(lie->next_broken_word);
 
diff --git a/gas/write.h b/gas/write.h
index 8303f1be98b6548e4e30a326f042f78e07aed7f5..5f3598655b2665fa86d7b5291643f563536e2f31 100644
--- gas/write.h
+++ gas/write.h
@@ -172,16 +172,16 @@ extern void write_object_file (void);
 extern long relax_frag (segT, fragS *, long);
 extern int relax_segment (struct frag *, segT, int);
 extern void number_to_chars_littleendian (char *, valueT, int);
 extern void number_to_chars_bigendian (char *, valueT, int);
 extern fixS *fix_new
   (fragS * frag, int where, int size, symbolS * add_symbol,
-   offsetT offset, int pcrel, bfd_reloc_code_real_type r_type);
+   offsetT offset, int pcrel, bfd_reloc_code_real_type r_type, int baserel);
 extern fixS *fix_at_start
   (fragS * frag, int size, symbolS * add_symbol,
    offsetT offset, int pcrel, bfd_reloc_code_real_type r_type);
 extern fixS *fix_new_exp
   (fragS * frag, int where, int size, expressionS *exp, int pcrel,
-   bfd_reloc_code_real_type r_type);
+   bfd_reloc_code_real_type r_type, int baserel);
 extern void write_print_statistics (FILE *);
 
 #endif /* __write_h__ */
diff --git a/gprof/Makefile.am b/gprof/Makefile.am
index edd100ac924458a1e69da65cab55ddb6a3b61555..286d29546ecdfa6cfafbfc7f7fb83a0fdeadfb83 100644
--- gprof/Makefile.am
+++ gprof/Makefile.am
@@ -36,13 +36,13 @@ noinst_HEADERS = \
 	corefile.h gmon.h gmon_io.h gmon_out.h gprof.h hertz.h hist.h \
 	search_list.h source.h sym_ids.h symtab.h utils.h
 
 BUILT_SOURCES = flat_bl.c bsd_callg_bl.c fsf_callg_bl.c
 EXTRA_DIST    = $(BUILT_SOURCES) bbconv.pl $(man_MANS)
 
-diststuff: $(BUILT_SOURCES) info $(man_MANS)
+diststuff: $(BUILT_SOURCES) info guide $(man_MANS)
 
 # We extract version from bfd/configure.in, make sure to rerun configure
 # when BFD's version changes.
 CONFIG_STATUS_DEPENDENCIES = $(BFDDIR)/configure.in
 
 # This empty rule is a hack against gmake patched by Apple.
diff --git a/gprof/Makefile.in b/gprof/Makefile.in
index a9d7073c799863dc3b39124f83dbcba73bf8bf85..4d487c22a56406d567643a6bd53310e501fa99aa 100644
--- gprof/Makefile.in
+++ gprof/Makefile.in
@@ -1013,13 +1013,13 @@ uninstall-man: uninstall-man1
 	mostlyclean-libtool pdf pdf-am ps ps-am tags tags-recursive \
 	uninstall uninstall-am uninstall-binPROGRAMS uninstall-dvi-am \
 	uninstall-html-am uninstall-info-am uninstall-man \
 	uninstall-man1 uninstall-pdf-am uninstall-ps-am
 
 
-diststuff: $(BUILT_SOURCES) info $(man_MANS)
+diststuff: $(BUILT_SOURCES) info guide $(man_MANS)
 
 # This empty rule is a hack against gmake patched by Apple.
 %.o:%.m
 
 .m.c:
 	awk -f $(srcdir)/gen-c-prog.awk > ./$*.c \
diff --git a/gprof/configure b/gprof/configure
index 6ffdbe30cef942eb7e28f26674b03c8ff5907711..665d5009457e7e17d7acc0c8bfb81301cd546b32 100755
--- gprof/configure
+++ gprof/configure
@@ -11850,12 +11850,25 @@ $as_echo "found xgettext program is not GNU xgettext; ignore it" >&6; }
   fi
 
   ac_config_commands="$ac_config_commands default-1"
 
 
 
+### begin-GG-local
+# Check for additional host specific CFLAGS.
+{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for host dependent CFLAGS" >&5
+$as_echo_n "checking for host dependent CFLAGS... " >&6; }
+other_host_cflags=""
+case "${host}" in
+	m68*-*-amigaos*)	other_host_cflags="-mstackextend" ;;
+esac
+test -n "$other_host_cflags" && CFLAGS="$CFLAGS $other_host_cflags"
+{ $as_echo "$as_me:${as_lineno-$LINENO}: result: $other_host_cflags" >&5
+$as_echo "$other_host_cflags" >&6; }
+### end-GG-local
+
 
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking whether to enable maintainer-specific portions of Makefiles" >&5
 $as_echo_n "checking whether to enable maintainer-specific portions of Makefiles... " >&6; }
     # Check whether --enable-maintainer-mode was given.
 if test "${enable_maintainer_mode+set}" = set; then :
   enableval=$enable_maintainer_mode; USE_MAINTAINER_MODE=$enableval
diff --git a/gprof/configure.in b/gprof/configure.in
index 631e3e467314f3740c737f1534537c7532a00d08..7b4586b0aeee56169f321af15214054feec0c349 100644
--- gprof/configure.in
+++ gprof/configure.in
@@ -28,12 +28,23 @@ LT_INIT
 AC_CHECK_FUNCS(setmode)
 
 ALL_LINGUAS="fr tr sv es id da pt_BR de vi rw ga ms fi nl bg eo ja sr"
 ZW_GNU_GETTEXT_SISTER_DIR
 AM_PO_SUBDIRS
 
+### begin-GG-local
+# Check for additional host specific CFLAGS.
+AC_MSG_CHECKING(for host dependent CFLAGS)
+other_host_cflags=""
+case "${host}" in
+	m68*-*-amigaos*)	other_host_cflags="-mstackextend" ;;
+esac
+test -n "$other_host_cflags" && CFLAGS="$CFLAGS $other_host_cflags"
+AC_MSG_RESULT($other_host_cflags)
+### end-GG-local
+
 AM_MAINTAINER_MODE
 AM_CONDITIONAL(GENINSRC_NEVER, false)
 AC_EXEEXT
 
 AC_CHECK_HEADERS(sys/gmon_out.h)
 
diff --git a/gprof/gconfig.in b/gprof/gconfig.in
index 25679910ee73fb2ae8f1c3f7b1cb2951166da71f..4ad8775fd559a1c06b6f572b4af24ca46f7f7f3e 100644
--- gprof/gconfig.in
+++ gprof/gconfig.in
@@ -1,12 +1,8 @@
 /* gconfig.in.  Generated from configure.in by autoheader.  */
 
-/* Define to 1 if translation of program messages to the user's native
-   language is requested. */
-#undef ENABLE_NLS
-
 /* Is the prototype for getopt in <unistd.h> in the expected format? */
 #undef HAVE_DECL_GETOPT
 
 /* Define to 1 if you have the <dlfcn.h> header file. */
 #undef HAVE_DLFCN_H
 
diff --git a/include/elf/amigaos.h b/include/elf/amigaos.h
new file mode 100644
index 0000000000000000000000000000000000000000..2cbcd490a300f0248aecf2ca6d50865181a3c1f0
--- /dev/null
+++ include/elf/amigaos.h
@@ -0,0 +1,27 @@
+/* AmigaOS ELF support for BFD.
+   Copyright 2001 Free Software Foundation, Inc.
+
+This file is part of BFD, the Binary File Descriptor library.
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software Foundation, Inc.,
+51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.  */
+
+#ifndef _ELF_AMIGAOS_H
+#define _ELF_AMIGAOS_H
+
+#include "elf/common.h"
+
+#define DT_AMIGAOS_DYNVERSION	(DT_LOOS + 1)
+
+#endif /* _ELF_AMIGAOS_H */
diff --git a/include/elf/ppc.h b/include/elf/ppc.h
index f80a1e8a3e9c5852902beaafbb6a2a9e36d815c3..9893a88d96a77d730d91ef2bfe89a18d75029dd1 100644
--- include/elf/ppc.h
+++ include/elf/ppc.h
@@ -128,12 +128,18 @@ START_RELOC_NUMBERS (elf_ppc_reloc_type)
   RELOC_NUMBER (R_PPC_EMB_RELST_LO,	112)
   RELOC_NUMBER (R_PPC_EMB_RELST_HI,	113)
   RELOC_NUMBER (R_PPC_EMB_RELST_HA,	114)
   RELOC_NUMBER (R_PPC_EMB_BIT_FLD,	115)
   RELOC_NUMBER (R_PPC_EMB_RELSDA,	116)
 
+/* AmigaOS4 relocs */
+  RELOC_NUMBER (R_PPC_AMIGAOS_BREL,	210)
+  RELOC_NUMBER (R_PPC_AMIGAOS_BREL_LO,	211)
+  RELOC_NUMBER (R_PPC_AMIGAOS_BREL_HI,  212)
+  RELOC_NUMBER (R_PPC_AMIGAOS_BREL_HA,  213)
+
 /* PowerPC VLE relocations.  */
   RELOC_NUMBER (R_PPC_VLE_REL8,		216)
   RELOC_NUMBER (R_PPC_VLE_REL15,	217)
   RELOC_NUMBER (R_PPC_VLE_REL24,	218)
   RELOC_NUMBER (R_PPC_VLE_LO16A,	219)
   RELOC_NUMBER (R_PPC_VLE_LO16D,	220)
diff --git a/include/libiberty.h b/include/libiberty.h
index cacde800ea3dda438ea8292ab4b9354a63ad048b..595ecf48242a2067dd71c4dda07a57994bdb4981 100644
--- include/libiberty.h
+++ include/libiberty.h
@@ -103,13 +103,13 @@ extern int countargv (char**);
 /* HAVE_DECL_* is a three-state macro: undefined, 0 or 1.  If it is
    undefined, we haven't run the autoconf check so provide the
    declaration without arguments.  If it is 0, we checked and failed
    to find the declaration so provide a fully prototyped one.  If it
    is 1, we found it so don't provide any declaration at all.  */
 #if !HAVE_DECL_BASENAME
-#if defined (__GNU_LIBRARY__ ) || defined (__linux__) || defined (__FreeBSD__) || defined (__OpenBSD__) || defined(__NetBSD__) || defined (__CYGWIN__) || defined (__CYGWIN32__) || defined (__MINGW32__) || defined (HAVE_DECL_BASENAME)
+#if defined (__GNU_LIBRARY__ ) || defined (__linux__) || defined (__FreeBSD__) || defined (__OpenBSD__) || defined(__NetBSD__) || defined (__CYGWIN__) || defined (__CYGWIN32__) || defined (__MINGW32__) || defined(AMIGA) || defined (HAVE_DECL_BASENAME)
 extern char *basename (const char *);
 #else
 /* Do not allow basename to be used if there is no prototype seen.  We
    either need to use the above prototype or have one from
    autoconf which would result in HAVE_DECL_BASENAME being set.  */
 #define basename basename_cannot_be_used_without_a_prototype
diff --git a/ld/ChangeLog-9197 b/ld/ChangeLog-9197
index 9307f333e3b156758598c19ff0873c21fc1dad29..0f0e189765f0438cd3bbd7a04f36c8e006cef91c 100644
--- ld/ChangeLog-9197
+++ ld/ChangeLog-9197
@@ -144,12 +144,17 @@ Wed Oct 22 11:29:25 1997  Ian Lance Taylor  <ian@cygnus.com>
 Fri Oct 17 00:00:13 1997  Richard Henderson  <rth@cygnus.com>
 
 	* ldlang.c (lang_register_vers_node): Only check globals<=>locals,
 	since we need to be able to export different versions of the same
 	symbol.
 
+Thu Oct 16 13:21:14 1997  Fred Fish  <fnf@ninemoons.com>
+
+	* ldlang.c (new_afile): Only reference amiga_attribute when
+	the target is AmigaOS.
+
 Wed Oct 15 14:52:36 1997  Ian Lance Taylor  <ian@cygnus.com>
 
 	* scripttempl/pe.sc: Put .stab and .stabstr sections at end.
 
 Wed Oct  8 12:37:05 1997  Richard Henderson  <rth@cygnus.com>
 
@@ -1280,12 +1285,18 @@ Mon Aug  5 16:26:14 1996  Ian Lance Taylor  <ian@cygnus.com>
 
 	* ldgram.y (SIZEOF, ADDR): Do not specify type.
 
 	* ldcref.c (check_nocrossref): Skip symbols with no output
 	sections.
 
+Sun Aug  4 22:15:56 1996  Fred Fish  <fnf@ninemoons.com>
+
+	* ldfile.c (ldfile_open_file_search): Use alloca to allocate
+	dynamically sized array, rather than using a GNU C extension that
+	is not portable.
+
 Fri Aug  2 14:57:49 1996  Ian Lance Taylor  <ian@cygnus.com>
 
 	* ldgram.y (LOADADDR): New terminal.
 	(exp): Handle LOADADDR.
 	* ldlex.l: Recognize LOADADDR.
 	* ldexp.c (exp_print_token): Add LOADADDR.
@@ -1506,12 +1517,16 @@ Mon Jun 24 12:00:32 1996  Ian Lance Taylor  <ian@cygnus.com>
 	at 0.
 
 	* configure.in: On alpha*-*-osf*, link against libbfd.a if not
 	using shared libraries.
 	* configure: Rebuild with autoconf 2.10.
 
+Sat Jun 22 21:41:37 1996 Daniel Verite <daniel@brainstorm.eu.org>
+
+	* ldfile.c, lexsup.c: Sort the flavors.
+
 Fri Jun 21 17:40:56 1996  Joel Sherrill  <joel@merlin.gcs.redstone.army.mil>
 
 	* configure.tgt: Add support for *-*-rtems* configurations.
 
 Fri Jun 21 13:05:51 1996  Richard Henderson  <rth@tamu.edu>
 
diff --git a/ld/ChangeLog-9899 b/ld/ChangeLog-9899
index 866e4a0cfbb8a086ae01716e4a806e3386914cab..de288123cb7b80422bfc2973640bbdd16c6af900 100644
--- ld/ChangeLog-9899
+++ ld/ChangeLog-9899
@@ -1881,12 +1881,17 @@ Wed Mar 18 09:42:24 1998  Nick Clifton  <nickc@cygnus.com>
 	* configure.tgt (targ_extra_emuls): Add thumb-pe target.
 
 Sun Mar  8 23:34:14 1998  Stan Cox  <scox@equinox.cygnus.com>
 
 	* configure.tgt (sparclite*-*-elf): Added.
 
+Sun Mar  8 20:25:09 1998  Daniel Verite  <daniel@brainstorm.fr>
+
+	* ldlang.c (new_afile): Remove obsolete references to
+	amiga_attribute.
+
 Mon Mar  2 19:24:08 1998  Michael Meissner  <meissner@cygnus.com>
 
 	* ldlang.c (lang_size_sections): If the default memory region is
 	*default*, see if there is a memory region that could be used.
 
 Thu Feb 26 17:09:53 1998  Michael Meissner  <meissner@cygnus.com>
diff --git a/ld/Makefile.am b/ld/Makefile.am
index e343ab06531054392ae09d67ecb2dc3022053c07..cbaa4c736f8e87f05a60d8580174e207069872fd 100644
--- ld/Makefile.am
+++ ld/Makefile.am
@@ -128,12 +128,16 @@ LIBIBERTY = ../libiberty/libiberty.a
 
 ALL_EMULATION_SOURCES = \
 	eaix5ppc.c \
 	eaix5rs6.c \
 	eaixppc.c \
 	eaixrs6.c \
+	eamiga.c \
+	eamiga_bss.c \
+	eamigaos.c \
+	eamithlon.c \
 	ealpha.c \
 	ealphavms.c \
 	earcelf.c \
 	earm_epoc_pe.c \
 	earm_wince_pe.c \
 	earmaoutb.c \
@@ -336,12 +340,14 @@ ALL_EMULATION_SOURCES = \
 	emipsbsd.c \
 	emipsidt.c \
 	emipsidtl.c \
 	emipslit.c \
 	emipslnews.c \
 	emipspe.c \
+	emorphos.c \
+	emorphos_baserel.c \
 	emn10200.c \
 	emn10300.c \
 	emsp430x110.c \
 	emsp430x1101.c \
 	emsp430x1111.c \
 	emsp430x112.c \
@@ -403,12 +409,14 @@ ALL_EMULATION_SOURCES = \
 	enews.c \
 	ens32knbsd.c \
 	eor32.c \
 	eor32elf.c \
 	epc532macha.c \
 	epdp11.c \
+	eppcamiga.c \
+	eppcamiga_bss.c \
 	epjelf.c \
 	epjlelf.c \
 	eppclynx.c \
 	eppcmacos.c \
 	eppcnw.c \
 	eppcpe.c \
@@ -661,12 +669,26 @@ GENSCRIPTS = LIB_PATH='${LIB_PATH}' $(SHELL) $(srcdir)/genscripts.sh "${srcdir}"
 GEN_DEPENDS = $(srcdir)/genscripts.sh stringify.sed
 ELF_DEPS = $(srcdir)/emultempl/elf32.em $(srcdir)/emultempl/elf-generic.em
 ELF_GEN_DEPS = $(srcdir)/emultempl/generic.em $(srcdir)/emultempl/elf-generic.em $(srcdir)/emultempl/genelf.em
 
 @TDIRS@
 
+eamiga.c: $(srcdir)/emulparams/amiga.sh\
+   $(srcdir)/emultempl/amiga.em $(srcdir)/scripttempl/amiga.sc ${GEN_DEPENDS} 
+	${GENSCRIPTS} amiga "$(tdir_amiga)"
+eamiga_bss.c: $(srcdir)/emulparams/amiga_bss.sh\
+   $(srcdir)/emultempl/amiga.em $(srcdir)/scripttempl/amiga_bss.sc ${GEN_DEPENDS}
+	${GENSCRIPTS} amiga_bss "$(tdir_amiga_bss)"
+eamigaos.c: $(srcdir)/emulparams/amigaos.sh \
+  $(srcdir)/emulparams/amigaos.sh $(srcdir)/emultempl/amigaos.em \
+  ldemul-list.h \
+  $(ELF_DEPS) $(srcdir)/scripttempl/amigaos.sc ${GEN_DEPENDS}
+	${GENSCRIPTS} amigaos "$(tdir_amigaos)"
+eamithlon.c: $(srcdir)/emulparams/amithlon.sh \
+  $(srcdir)/emultempl/amithlon.em $(srcdir)/scripttempl/amithlon.sc ${GEN_DEPENDS}
+	${GENSCRIPTS} amithlon "$(tdir_amithlon)"
 eaix5ppc.c: $(srcdir)/emulparams/aix5ppc.sh \
   $(srcdir)/emultempl/aix.em $(srcdir)/scripttempl/aix.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} aix5ppc "$(tdir_aixppc)"
 eaix5rs6.c: $(srcdir)/emulparams/aix5rs6.sh \
   $(srcdir)/emultempl/aix.em $(srcdir)/scripttempl/aix.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} aix5rs6 "$(tdir_aixrs6)"
@@ -1472,12 +1494,18 @@ emipslit.c: $(srcdir)/emulparams/mipslit.sh $(srcdir)/emultempl/generic.em \
 emipslnews.c: $(srcdir)/emulparams/mipslnews.sh \
   $(srcdir)/emultempl/generic.em $(srcdir)/scripttempl/mips.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} mipslnews "$(tdir_mipslnews)"
 emipspe.c: $(srcdir)/emulparams/mipspe.sh $(srcdir)/emultempl/pe.em \
   $(srcdir)/scripttempl/pe.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} mipspe "$(tdir_mipspe)"
+emorphos.c: $(srcdir)/emulparams/morphos.sh \
+  $(srcdir)/emultempl/morphos.em $(srcdir)/scripttempl/morphos.sc ${GEN_DEPENDS}
+	${GENSCRIPTS} morphos "$(tdir_morphos)"
+emorphos_baserel.c: $(srcdir)/emulparams/morphos_baserel.sh \
+  $(srcdir)/emultempl/morphos.em $(srcdir)/scripttempl/morphos_baserel.sc ${GEN_DEPENDS}
+	${GENSCRIPTS} morphos_baserel "$(tdir_morphos)"
 emn10200.c: $(srcdir)/emulparams/mn10200.sh \
   $(ELF_GEN_DEPS) $(srcdir)/scripttempl/elf.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} mn10200 "$(tdir_mn10200)"
 emn10300.c: $(srcdir)/emulparams/mn10300.sh \
   $(srcdir)/emulparams/mn10200.sh \
   $(ELF_DEPS) $(srcdir)/scripttempl/elf.sc ${GEN_DEPENDS}
@@ -1756,12 +1784,22 @@ epdp11.c: $(srcdir)/emulparams/pdp11.sh \
 epjelf.c: $(srcdir)/emulparams/pjelf.sh \
   $(ELF_GEN_DEPS) $(srcdir)/scripttempl/elf.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} pjelf "$(tdir_pjelf)"
 epjlelf.c: $(srcdir)/emulparams/pjlelf.sh $(srcdir)/emulparams/pjelf.sh \
   $(ELF_GEN_DEPS) $(srcdir)/scripttempl/elf.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} pjlelf "$(tdir_pjlelf)"
+eppcamiga.c: $(srcdir)/emulparams/ppcamiga.sh \
+  $(srcdir)/emulparams/ppcamiga.sh $(srcdir)/emultempl/ppcamiga.em \
+  ldemul-list.h \
+  $(ELF_DEPS) $(srcdir)/scripttempl/ppcamiga.sc ${GEN_DEPENDS}
+	${GENSCRIPTS} ppcamiga "$(tdir_ppcamiga)"
+eppcamiga_bss.c: $(srcdir)/emulparams/ppcamiga_bss.sh \
+  $(srcdir)/emulparams/ppcamiga_bss.sh $(srcdir)/emultempl/ppcamiga_bss.em \
+  ldemul-list.h \
+  $(ELF_DEPS) $(srcdir)/scripttempl/ppcamiga_bss.sc ${GEN_DEPENDS}
+	${GENSCRIPTS} ppcamiga_bss "$(tdir_ppcamiga_bss)"
 eppclynx.c: $(srcdir)/emulparams/ppclynx.sh \
   $(ELF_DEPS) $(srcdir)/scripttempl/elf.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} ppclynx "$(tdir_ppclynx)"
 eppcmacos.c:	$(srcdir)/emulparams/ppcmacos.sh \
   $(srcdir)/emultempl/aix.em $(srcdir)/scripttempl/aix.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} ppcmacos "$(tdir_ppcmacos)"
diff --git a/ld/Makefile.in b/ld/Makefile.in
index 7da93b46501b8f8aa076134b903e1cdf34025941..43947832717c60ff3a89a8fcea838f5151afd56e 100644
--- ld/Makefile.in
+++ ld/Makefile.in
@@ -435,12 +435,16 @@ BFDLIB = ../bfd/libbfd.la
 LIBIBERTY = ../libiberty/libiberty.a
 ALL_EMULATION_SOURCES = \
 	eaix5ppc.c \
 	eaix5rs6.c \
 	eaixppc.c \
 	eaixrs6.c \
+	eamiga.c \
+	eamiga_bss.c \
+	eamigaos.c \
+	eamithlon.c \
 	ealpha.c \
 	ealphavms.c \
 	earcelf.c \
 	earm_epoc_pe.c \
 	earm_wince_pe.c \
 	earmaoutb.c \
@@ -643,12 +647,14 @@ ALL_EMULATION_SOURCES = \
 	emipsbsd.c \
 	emipsidt.c \
 	emipsidtl.c \
 	emipslit.c \
 	emipslnews.c \
 	emipspe.c \
+	emorphos.c \
+	emorphos_baserel.c \
 	emn10200.c \
 	emn10300.c \
 	emsp430x110.c \
 	emsp430x1101.c \
 	emsp430x1111.c \
 	emsp430x112.c \
@@ -710,12 +716,14 @@ ALL_EMULATION_SOURCES = \
 	enews.c \
 	ens32knbsd.c \
 	eor32.c \
 	eor32elf.c \
 	epc532macha.c \
 	epdp11.c \
+	eppcamiga.c \
+	eppcamiga_bss.c \
 	epjelf.c \
 	epjlelf.c \
 	eppclynx.c \
 	eppcmacos.c \
 	eppcnw.c \
 	eppcpe.c \
@@ -1063,12 +1071,16 @@ distclean-compile:
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/eaix5ppc.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/eaix5rs6.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/eaixppc.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/eaixrs6.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/ealpha.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/ealphavms.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/eamiga.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/eamiga_bss.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/eamigaos.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/eamithlon.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/earcelf.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/earm_epoc_pe.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/earm_wince_pe.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/earmaoutb.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/earmaoutl.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/earmcoff.Po@am__quote@
@@ -1299,12 +1311,14 @@ distclean-compile:
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/emipslit.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/emipslnews.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/emipspe.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/emmo.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/emn10200.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/emn10300.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/emorphos.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/emorphos_baserel.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/emsp430x110.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/emsp430x1101.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/emsp430x1111.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/emsp430x112.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/emsp430x1121.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/emsp430x1122.Po@am__quote@
@@ -1366,12 +1380,14 @@ distclean-compile:
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/eor32.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/eor32elf.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/epc532macha.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/epdp11.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/epjelf.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/epjlelf.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/eppcamiga.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/eppcamiga_bss.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/eppclynx.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/eppcmacos.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/eppcnw.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/eppcpe.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/eriscix.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/escore3_elf.Po@am__quote@
@@ -2131,12 +2147,26 @@ ldemul-list.h: Makefile
 
 stringify.sed: ${srcdir}/emultempl/$(STRINGIFY)
 	  cp ${srcdir}/emultempl/$(STRINGIFY) stringify.sed
 
 @TDIRS@
 
+eamiga.c: $(srcdir)/emulparams/amiga.sh\
+   $(srcdir)/emultempl/amiga.em $(srcdir)/scripttempl/amiga.sc ${GEN_DEPENDS} 
+	${GENSCRIPTS} amiga "$(tdir_amiga)"
+eamiga_bss.c: $(srcdir)/emulparams/amiga_bss.sh\
+   $(srcdir)/emultempl/amiga.em $(srcdir)/scripttempl/amiga_bss.sc ${GEN_DEPENDS}
+	${GENSCRIPTS} amiga_bss "$(tdir_amiga_bss)"
+eamigaos.c: $(srcdir)/emulparams/amigaos.sh \
+  $(srcdir)/emulparams/amigaos.sh $(srcdir)/emultempl/amigaos.em \
+  ldemul-list.h \
+  $(ELF_DEPS) $(srcdir)/scripttempl/amigaos.sc ${GEN_DEPENDS}
+	${GENSCRIPTS} amigaos "$(tdir_amigaos)"
+eamithlon.c: $(srcdir)/emulparams/amithlon.sh \
+  $(srcdir)/emultempl/amithlon.em $(srcdir)/scripttempl/amithlon.sc ${GEN_DEPENDS}
+	${GENSCRIPTS} amithlon "$(tdir_amithlon)"
 eaix5ppc.c: $(srcdir)/emulparams/aix5ppc.sh \
   $(srcdir)/emultempl/aix.em $(srcdir)/scripttempl/aix.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} aix5ppc "$(tdir_aixppc)"
 eaix5rs6.c: $(srcdir)/emulparams/aix5rs6.sh \
   $(srcdir)/emultempl/aix.em $(srcdir)/scripttempl/aix.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} aix5rs6 "$(tdir_aixrs6)"
@@ -2942,12 +2972,18 @@ emipslit.c: $(srcdir)/emulparams/mipslit.sh $(srcdir)/emultempl/generic.em \
 emipslnews.c: $(srcdir)/emulparams/mipslnews.sh \
   $(srcdir)/emultempl/generic.em $(srcdir)/scripttempl/mips.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} mipslnews "$(tdir_mipslnews)"
 emipspe.c: $(srcdir)/emulparams/mipspe.sh $(srcdir)/emultempl/pe.em \
   $(srcdir)/scripttempl/pe.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} mipspe "$(tdir_mipspe)"
+emorphos.c: $(srcdir)/emulparams/morphos.sh \
+  $(srcdir)/emultempl/morphos.em $(srcdir)/scripttempl/morphos.sc ${GEN_DEPENDS}
+	${GENSCRIPTS} morphos "$(tdir_morphos)"
+emorphos_baserel.c: $(srcdir)/emulparams/morphos_baserel.sh \
+  $(srcdir)/emultempl/morphos.em $(srcdir)/scripttempl/morphos_baserel.sc ${GEN_DEPENDS}
+	${GENSCRIPTS} morphos_baserel "$(tdir_morphos)"
 emn10200.c: $(srcdir)/emulparams/mn10200.sh \
   $(ELF_GEN_DEPS) $(srcdir)/scripttempl/elf.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} mn10200 "$(tdir_mn10200)"
 emn10300.c: $(srcdir)/emulparams/mn10300.sh \
   $(srcdir)/emulparams/mn10200.sh \
   $(ELF_DEPS) $(srcdir)/scripttempl/elf.sc ${GEN_DEPENDS}
@@ -3226,12 +3262,22 @@ epdp11.c: $(srcdir)/emulparams/pdp11.sh \
 epjelf.c: $(srcdir)/emulparams/pjelf.sh \
   $(ELF_GEN_DEPS) $(srcdir)/scripttempl/elf.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} pjelf "$(tdir_pjelf)"
 epjlelf.c: $(srcdir)/emulparams/pjlelf.sh $(srcdir)/emulparams/pjelf.sh \
   $(ELF_GEN_DEPS) $(srcdir)/scripttempl/elf.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} pjlelf "$(tdir_pjlelf)"
+eppcamiga.c: $(srcdir)/emulparams/ppcamiga.sh \
+  $(srcdir)/emulparams/ppcamiga.sh $(srcdir)/emultempl/ppcamiga.em \
+  ldemul-list.h \
+  $(ELF_DEPS) $(srcdir)/scripttempl/ppcamiga.sc ${GEN_DEPENDS}
+	${GENSCRIPTS} ppcamiga "$(tdir_ppcamiga)"
+eppcamiga_bss.c: $(srcdir)/emulparams/ppcamiga_bss.sh \
+  $(srcdir)/emulparams/ppcamiga_bss.sh $(srcdir)/emultempl/ppcamiga_bss.em \
+  ldemul-list.h \
+  $(ELF_DEPS) $(srcdir)/scripttempl/ppcamiga_bss.sc ${GEN_DEPENDS}
+	${GENSCRIPTS} ppcamiga_bss "$(tdir_ppcamiga_bss)"
 eppclynx.c: $(srcdir)/emulparams/ppclynx.sh \
   $(ELF_DEPS) $(srcdir)/scripttempl/elf.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} ppclynx "$(tdir_ppclynx)"
 eppcmacos.c:	$(srcdir)/emulparams/ppcmacos.sh \
   $(srcdir)/emultempl/aix.em $(srcdir)/scripttempl/aix.sc ${GEN_DEPENDS}
 	${GENSCRIPTS} ppcmacos "$(tdir_ppcmacos)"
diff --git a/ld/configure.host b/ld/configure.host
index f47b961176fa37c2786aa9ff322b21b06081cdfd..c7e1e700c24e48e783d07023b678dbd59bee0b11 100644
--- ld/configure.host
+++ ld/configure.host
@@ -170,12 +170,16 @@ mips*-sgi-irix4* | mips*-sgi-irix5*)
 
 mips*-sgi-irix6*)
   HOSTING_CRT0='/usr/lib32/crt1.o `if [ -f ../gcc/crtbegin.o ]; then echo ../gcc/crtbegin.o ; else ${CC} -print-file-name=crtbegin.o; fi`'
   HOSTING_LIBS='-L/usr/lib32 '"$HOSTING_LIBS"' `if [ -f ../gcc/crtend.o ]; then echo ../gcc/crtend.o ; else ${CC} -print-file-name=crtend.o; fi` /usr/lib32/crtn.o -init __do_global_ctors -fini __do_global_dtors'
   ;;
 
+m68*-*-amigaos*)
+  HDEFINES=-mstackextend
+  ;;
+
 m68*-motorola-sysv)
   HOSTING_CRT0='`if [ -f ../gcc/crt0.o ]; then echo ../gcc/crt0.o; elif [ -f \`${CC} -print-file-name=\`crt0.o ]; then echo \`${CC} -print-file-name=\`crt0.o; else echo /lib/crt0.o; fi`'
   HOSTING_LIBS=`sed -e 's,-lc,-lc881,' <<EOF
 $HOSTING_LIBS
 EOF`
   ;;
diff --git a/ld/configure.tgt b/ld/configure.tgt
index 72bc5bca48d7c93f838de826a0685c13ef1db3c2..ddba96d6da87eb2f033eae77509639b6a630ec2a 100644
--- ld/configure.tgt
+++ ld/configure.tgt
@@ -298,12 +298,13 @@ x86_64-*-pe | x86_64-*-pep) targ_emul=i386pep ;
 			targ_extra_ofiles="deffilep.o pep-dll.o pe-dll.o" ;;
 x86_64-*-mingw*)	targ_emul=i386pep ;
 			targ_extra_emuls=i386pe
 			targ_extra_ofiles="deffilep.o pep-dll.o pe-dll.o" ;;
 i[3-7]86-*-interix*)	targ_emul=i386pe_posix;
  			targ_extra_ofiles="deffilep.o pe-dll.o" ;;
+i[3-7]86be-*-amithlon*) targ_emul=amithlon;;
 i[3-7]86-*-beospe*)	targ_emul=i386beos ;;
 i[3-7]86-*-beos*)	targ_emul=elf_i386_be ;;
 i[3-7]86-*-vxworks*)	targ_emul=elf_i386_vxworks ;;
 i[3-7]86-*-chaos)	targ_emul=elf_i386_chaos
 			;;
 i[3-7]86-*-nacl*)	targ_emul=elf_i386_nacl
@@ -362,12 +363,13 @@ m68*-sun-sunos[34]*)	targ_emul=sun3 ;;
 m68*-wrs-vxworks*)	targ_emul=sun3 ;;
 m68*-ericsson-ose)	targ_emul=sun3 ;;
 m68*-apple-aux*)	targ_emul=m68kaux ;;
 m68k-sony-*)		targ_emul=news ;;
 m68k-hp-bsd*)		targ_emul=hp300bsd ;;
 m68*-motorola-sysv*)	targ_emul=delta68 ;;
+m68*-*-amigaos*)	targ_emul=amiga ; targ_extra_emuls=amiga_bss;;
 m68*-*-aout)		targ_emul=m68kaout ;;
 m68*-*-coff)		targ_emul=m68kcoff ;;
 m68*-*-elf)		targ_emul=m68kelf ;;
 m68*-*-hpux*)		targ_emul=hp3hpux ;;
 m68k-*-linux*aout*)	targ_emul=m68klinux
 			targ_extra_emuls=m68kelf
@@ -488,12 +490,15 @@ or32-*-rtems*)          targ_emul=or32elf
 			;;
 pdp11-*-*)		targ_emul=pdp11
 			;;
 pjl*-*-*)	        targ_emul=pjlelf ; targ_extra_emuls="elf_i386" ;;
 pj*-*-*)	        targ_emul=pjelf
 			;;
+powerpc-*-amigaos*)	targ_emul=amigaos; targ_extra_emuls=elf32ppc ;;
+powerpc-*-amigaoshunk*)	targ_emul=ppcamiga ; targ_extra_emuls=ppcamiga_bss;;
+powerpc-*-morphos*)	targ_emul=morphos ; targ_extra_emuls=morphos_baserel;;
 powerpc-*-freebsd* | powerpc-*-kfreebsd*-gnu)
 			targ_emul=elf32ppc_fbsd
 			targ_extra_emuls="elf32ppc elf32ppcsim"
 			targ_extra_libpath=elf32ppc;
 			tdir_elf32ppcsim=`echo ${targ_alias} | sed -e 's/ppc/ppcsim/'` ;;
 powerpc64-*-freebsd*)
@@ -780,11 +785,15 @@ i[03-9x]86-*-cygwin*)
 *-*-linux*)
   ;;
 
 *-*-netbsd*)
   ;;
 
+powerpc-*-amigaos*)
+  NATIVE_LIB_DIRS='/gcc/local/lib /gcc/lib'
+  ;;
+
 alpha*-*-*)
   NATIVE_LIB_DIRS='/usr/local/lib /usr/ccs/lib /lib /usr/lib'
   ;;
 
 esac
diff --git a/ld/emulparams/amiga.sh b/ld/emulparams/amiga.sh
new file mode 100644
index 0000000000000000000000000000000000000000..c2915d47d7964c6406eae9079ce90d695ecdbfda
--- /dev/null
+++ ld/emulparams/amiga.sh
@@ -0,0 +1,6 @@
+SCRIPT_NAME=amiga
+OUTPUT_FORMAT="amiga"
+TEXT_START_ADDR=0x0
+SEGMENT_SIZE=0x0
+TEMPLATE_NAME=amiga
+ARCH=m68k
diff --git a/ld/emulparams/amiga_bss.sh b/ld/emulparams/amiga_bss.sh
new file mode 100644
index 0000000000000000000000000000000000000000..5405d737448875ea39e5d9c4edfd59ee32c8a7b4
--- /dev/null
+++ ld/emulparams/amiga_bss.sh
@@ -0,0 +1,6 @@
+SCRIPT_NAME=amiga_bss
+OUTPUT_FORMAT="amiga"
+TEXT_START_ADDR=0x0
+SEGMENT_SIZE=0x0
+TEMPLATE_NAME=amiga
+ARCH=m68k
diff --git a/ld/emulparams/amigaos.sh b/ld/emulparams/amigaos.sh
new file mode 100644
index 0000000000000000000000000000000000000000..605b81e76bcbbd2322561d7d9502190dc7c00674
--- /dev/null
+++ ld/emulparams/amigaos.sh
@@ -0,0 +1,26 @@
+#. ${srcdir}/emulparams/elf32ppccommon.sh
+TEMPLATE_NAME=amigaos
+SCRIPT_NAME=amigaos
+OUTPUT_FORMAT="elf32-amigaos"
+MAXPAGESIZE="CONSTANT (MAXPAGESIZE)"
+COMMONPAGESIZE="CONSTANT (COMMONPAGESIZE)"
+ALIGNMENT=16
+ARCH=powerpc
+MACHINE=
+GENERATE_SHLIB_SCRIPT=yes
+TEXT_START_ADDR=0x01000000
+SHLIB_TEXT_START_ADDR=0x10000000
+unset WRITABLE_RODATA
+DATA_START_SYMBOLS="_DATA_BASE_ = .;"
+SDATA_START_SYMBOLS="_SDA_BASE_ = . + 0x8000;"
+DATA_GOT=
+SDATA_GOT=
+TEXT_PLT=yes
+SEPARATE_GOTPLT=0
+unset BSS_PLT
+unset DATA_PLT
+GOT=".got          ${RELOCATING-0} : SPECIAL { *(.got) }"
+PLT=".plt          ${RELOCATING-0} :  { *(.plt) }"
+# GOTPLT="${PLT}"
+OTHER_TEXT_SECTIONS="*(.glink)"
+EXTRA_EM_FILE=ppc32elf
diff --git a/ld/emulparams/amithlon.sh b/ld/emulparams/amithlon.sh
new file mode 100644
index 0000000000000000000000000000000000000000..14b1c776396e2424af51c9b409e2d05f2881a84d
--- /dev/null
+++ ld/emulparams/amithlon.sh
@@ -0,0 +1,11 @@
+SCRIPT_NAME=amithlon
+OUTPUT_FORMAT="elf32-i386be-amithlon"
+#TEXT_START_ADDR=0x08048000
+#MAXPAGESIZE=0x1000
+MAXPAGESIZE=32
+#NONPAGED_TEXT_START_ADDR=0x08048000
+ARCH=i386
+MACHINE=
+NOP=0x9090
+TEMPLATE_NAME=amithlon
+GENERATE_SHLIB_SCRIPT=yes
diff --git a/ld/emulparams/morphos.sh b/ld/emulparams/morphos.sh
new file mode 100644
index 0000000000000000000000000000000000000000..45908c662f9b6085877dd39621e813da45a9f5f7
--- /dev/null
+++ ld/emulparams/morphos.sh
@@ -0,0 +1,6 @@
+TEMPLATE_NAME=morphos
+SCRIPT_NAME=morphos
+OUTPUT_FORMAT="elf32-morphos"
+MAXPAGESIZE=0x40000
+ARCH=powerpc
+MACHINE=
diff --git a/ld/emulparams/morphos_baserel.sh b/ld/emulparams/morphos_baserel.sh
new file mode 100644
index 0000000000000000000000000000000000000000..46c483484813395904772673d1ae1eed0bc9109f
--- /dev/null
+++ ld/emulparams/morphos_baserel.sh
@@ -0,0 +1,6 @@
+TEMPLATE_NAME=morphos
+SCRIPT_NAME=morphos_baserel
+OUTPUT_FORMAT="elf32-morphos"
+MAXPAGESIZE=0x40000
+ARCH=powerpc
+MACHINE=
diff --git a/ld/emulparams/ppcamiga.sh b/ld/emulparams/ppcamiga.sh
new file mode 100644
index 0000000000000000000000000000000000000000..3f266cf5265f13748eeb78f67dd93227ade92de5
--- /dev/null
+++ ld/emulparams/ppcamiga.sh
@@ -0,0 +1,8 @@
+SCRIPT_NAME=amiga
+OUTPUT_FORMAT="amiga"
+TEXT_START_ADDR=0x400
+PAGE_SIZE=0x400
+SEGMENT_SIZE=0x400
+NONPAGED_TEXT_START_ADDR=0x400
+TEMPLATE_NAME=amiga
+ARCH=powerpc
diff --git a/ld/emulparams/ppcamiga_bss.sh b/ld/emulparams/ppcamiga_bss.sh
new file mode 100644
index 0000000000000000000000000000000000000000..8d1720fb17c876d55b75f0885eb9f6eb0c7e9f1e
--- /dev/null
+++ ld/emulparams/ppcamiga_bss.sh
@@ -0,0 +1,8 @@
+SCRIPT_NAME=amiga_bss
+OUTPUT_FORMAT="amiga"
+TEXT_START_ADDR=0x400
+PAGE_SIZE=0x400
+SEGMENT_SIZE=0x400
+NONPAGED_TEXT_START_ADDR=0x400
+TEMPLATE_NAME=amiga
+ARCH=powerpc
diff --git a/ld/emultempl/amiga.em b/ld/emultempl/amiga.em
new file mode 100644
index 0000000000000000000000000000000000000000..c6abc5c644d3d93609d66972752e6cd3d474d70e
--- /dev/null
+++ ld/emultempl/amiga.em
@@ -0,0 +1,288 @@
+# This shell script emits a C file. -*- C -*-
+# It does some substitutions.
+cat >e${EMULATION_NAME}.c <<EOF
+/* This file is is generated by a shell script.  DO NOT EDIT! */
+
+/* emulate the original gld for the given ${EMULATION_NAME}
+   Copyright (C) 1991, 1993 Free Software Foundation, Inc.
+   Written by Steve Chamberlain steve@cygnus.com
+
+This file is part of GLD, the Gnu Linker.
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */
+
+#define TARGET_IS_${EMULATION_NAME}
+
+#include "bfd.h"
+#include "sysdep.h"
+#include "bfdlink.h"
+#include "getopt.h"
+
+#include "ld.h"
+#include "ldmain.h"
+#include "ldmisc.h"
+#include "ldexp.h"
+#include "ldlang.h"
+#include "ldfile.h"
+#include "ldemul.h"
+#include "ldctor.h"
+
+#include "libamiga.h"
+
+/* shared functions */
+void amiga_add_options PARAMS ((int, char **, int, struct option **, int, struct option **));
+bfd_boolean amiga_handle_option PARAMS ((int));
+void amiga_after_parse PARAMS ((void));
+void amiga_after_open PARAMS ((void));
+void amiga_after_allocation PARAMS ((void));
+
+/* amigaoslink.c variables */
+
+/* 1 means, write out debug hunk, when producing a load file */
+extern int write_debug_hunk;
+
+/* This is the attribute to use for the next file */
+extern int amiga_attribute;
+
+/* generate a combined data+bss hunk */
+extern int amiga_base_relative;
+
+/* generate a resident executable */
+extern int amiga_resident;
+
+static void gld${EMULATION_NAME}_before_parse PARAMS ((void));
+static char *gld${EMULATION_NAME}_get_script PARAMS ((int *isfile));
+
+#if defined(TARGET_IS_amiga)
+
+/* Handle amiga specific options */
+
+enum {
+  OPTION_IGNORE = 300,
+  OPTION_AMIGA_CHIP,
+  OPTION_AMIGA_FAST,
+  OPTION_AMIGA_ATTRIBUTE,
+  OPTION_AMIGA_DEBUG,
+  OPTION_AMIGA_DATABSS_TOGETHER,
+  OPTION_AMIGA_DATADATA_RELOC,
+  OPTION_FLAVOR
+};
+
+void
+amiga_add_options (ns, shortopts, nl, longopts, nrl, really_longopts)
+     int ns ATTRIBUTE_UNUSED;
+     char **shortopts ATTRIBUTE_UNUSED;
+     int nl;
+     struct option **longopts;
+     int nrl ATTRIBUTE_UNUSED;
+     struct option **really_longopts ATTRIBUTE_UNUSED;
+{
+  static const struct option xtra_long[] = {
+    {"flavor", required_argument, NULL, OPTION_FLAVOR},
+    {"amiga-datadata-reloc", no_argument, NULL, OPTION_AMIGA_DATADATA_RELOC},
+    {"amiga-databss-together", no_argument, NULL, OPTION_AMIGA_DATABSS_TOGETHER},
+    {"amiga-debug-hunk", no_argument, NULL, OPTION_AMIGA_DEBUG},
+    {"attribute", required_argument, NULL, OPTION_AMIGA_ATTRIBUTE},
+    {"fast", no_argument, NULL, OPTION_AMIGA_FAST},
+    {"chip", no_argument, NULL, OPTION_AMIGA_CHIP},
+    {NULL, no_argument, NULL, 0}
+  };
+
+  *longopts = (struct option *)
+    xrealloc (*longopts, nl * sizeof (struct option) + sizeof (xtra_long));
+  memcpy (*longopts + nl, &xtra_long, sizeof (xtra_long));
+}
+
+bfd_boolean
+amiga_handle_option (optc)
+     int optc;
+{
+  switch (optc)
+    {
+    default:
+      return FALSE;
+
+    case 0:
+      /* Long option which just sets a flag.  */
+      break;
+
+    case OPTION_AMIGA_CHIP:
+      amiga_attribute = MEMF_CHIP;
+      break;
+
+    case OPTION_AMIGA_FAST:
+      amiga_attribute = MEMF_FAST;
+      break;
+
+    case OPTION_AMIGA_ATTRIBUTE:
+      {
+	char *end;
+	amiga_attribute = strtoul (optarg, &end, 0);
+	if (*end)
+	  einfo ("%P%F: invalid number \`%s\'\n", optarg);
+      }
+      break;
+
+    case OPTION_AMIGA_DEBUG:
+      write_debug_hunk = 1; /* Write out debug hunk */
+      break;
+
+    case OPTION_AMIGA_DATABSS_TOGETHER:
+      amiga_base_relative = 1; /* Combine data and bss */
+      break;
+
+    case OPTION_AMIGA_DATADATA_RELOC:
+      amiga_resident = 1; /* Write out datadata_reloc array */
+      break;
+
+    case OPTION_FLAVOR:
+      ldfile_add_flavor (optarg);
+      break;
+    }
+
+  return TRUE;
+}
+
+void
+amiga_after_parse ()
+{
+  ldfile_sort_flavors();
+}
+
+void
+amiga_after_open ()
+{
+  ldctor_build_sets ();
+}
+
+static void
+amiga_assign_attribute (inp)
+     lang_input_statement_type *inp;
+{
+  asection *s;
+
+  if (bfd_get_flavour(inp->the_bfd)==bfd_target_amiga_flavour)
+    {
+      for (s=inp->the_bfd->sections;s!=NULL;s=s->next)
+	amiga_per_section(s)->attribute=inp->amiga_attribute;
+    }
+}
+
+void
+amiga_after_allocation ()
+{
+  if (0) /* Does not work at the moment */
+    lang_for_each_input_file (amiga_assign_attribute);
+}
+
+#endif
+
+static void
+gld${EMULATION_NAME}_before_parse ()
+{
+  write_debug_hunk = 0;
+
+#if defined(TARGET_IS_amiga_bss)
+  amiga_base_relative = 1;
+#endif
+
+#ifndef TARGET_ /* I.e., if not generic.  */
+  ldfile_output_architecture = bfd_arch_${ARCH};
+#endif /* not TARGET_ */
+}
+
+static char *
+gld${EMULATION_NAME}_get_script (isfile)
+     int *isfile;
+EOF
+
+if test -n "$COMPILE_IN"
+then
+# Scripts compiled in.
+
+# sed commands to quote an ld script as a C string.
+sc="-f stringify.sed"
+
+cat >>e${EMULATION_NAME}.c <<EOF
+{
+  *isfile = 0;
+
+  if (link_info.relocateable == TRUE && config.build_constructors == TRUE)
+    return
+EOF
+sed $sc ldscripts/${EMULATION_NAME}.xu                     >> e${EMULATION_NAME}.c
+echo '  ; else if (link_info.relocateable == TRUE) return' >> e${EMULATION_NAME}.c
+sed $sc ldscripts/${EMULATION_NAME}.xr                     >> e${EMULATION_NAME}.c
+echo '  ; else if (!config.text_read_only) return'         >> e${EMULATION_NAME}.c
+sed $sc ldscripts/${EMULATION_NAME}.xbn                    >> e${EMULATION_NAME}.c
+echo '  ; else if (!config.magic_demand_paged) return'     >> e${EMULATION_NAME}.c
+sed $sc ldscripts/${EMULATION_NAME}.xn                     >> e${EMULATION_NAME}.c
+echo '  ; else return'                                     >> e${EMULATION_NAME}.c
+sed $sc ldscripts/${EMULATION_NAME}.x                      >> e${EMULATION_NAME}.c
+echo '; }'                                                 >> e${EMULATION_NAME}.c
+
+else
+# Scripts read from the filesystem.
+
+cat >>e${EMULATION_NAME}.c <<EOF
+{
+  *isfile = 1;
+
+  if (link_info.relocateable == TRUE && config.build_constructors == TRUE)
+    return "ldscripts/${EMULATION_NAME}.xu";
+  else if (link_info.relocateable == TRUE)
+    return "ldscripts/${EMULATION_NAME}.xr";
+  else if (!config.text_read_only)
+    return "ldscripts/${EMULATION_NAME}.xbn";
+  else if (!config.magic_demand_paged)
+    return "ldscripts/${EMULATION_NAME}.xn";
+  else
+    return "ldscripts/${EMULATION_NAME}.x";
+}
+EOF
+
+fi
+
+cat >>e${EMULATION_NAME}.c <<EOF
+
+struct ld_emulation_xfer_struct ld_${EMULATION_NAME}_emulation = 
+{
+  gld${EMULATION_NAME}_before_parse,	/* before_parse */
+  syslib_default,			/* syslib */
+  hll_default,				/* hll */
+  amiga_after_parse,			/* after_parse */
+  amiga_after_open,			/* after_open */
+  amiga_after_allocation,		/* after_allocation */
+  set_output_arch_default,		/* set_output_arch */
+  ldemul_default_target,		/* choose_target */
+  before_allocation_default,		/* before_allocation */
+  gld${EMULATION_NAME}_get_script,	/* get_script */
+  "${EMULATION_NAME}",			/* emulation_name */
+  "${OUTPUT_FORMAT}",			/* target_name */
+  NULL,					/* finish */
+  NULL,					/* create_output_section_statements */
+  NULL,					/* open_dynamic_library */
+  NULL,					/* place_orphan */
+  NULL,					/* set_symbols */
+  NULL,					/* parse_args */
+  amiga_add_options,			/* add_options */
+  amiga_handle_option,			/* handle_option */
+  NULL,					/* unrecognized file */
+  NULL,					/* list_options */
+  NULL,					/* recognized_file */
+  NULL,					/* find potential_libraries */
+  NULL					/* new_vers_pattern */
+};
+EOF
diff --git a/ld/emultempl/elf32.em b/ld/emultempl/amigaos.em
similarity index 100%
copy from ld/emultempl/elf32.em
copy to ld/emultempl/amigaos.em
diff --git a/ld/emultempl/amithlon.em b/ld/emultempl/amithlon.em
new file mode 100644
index 0000000000000000000000000000000000000000..5e453a72f8c01e621d110d505b83d1abbcd19831
--- /dev/null
+++ ld/emultempl/amithlon.em
@@ -0,0 +1,1698 @@
+# This shell script emits a C file. -*- C -*-
+# It does some substitutions.
+# This file is now misnamed, because it supports both 32 bit and 64 bit
+# ELF emulations.
+test -z "${ELFSIZE}" && ELFSIZE=32
+if [ -z "$MACHINE" ]; then
+  OUTPUT_ARCH=${ARCH}
+else
+  OUTPUT_ARCH=${ARCH}:${MACHINE}
+fi
+cat >e${EMULATION_NAME}.c <<EOF
+/* This file is is generated by a shell script.  DO NOT EDIT! */
+
+/* ${ELFSIZE} bit ELF emulation code for ${EMULATION_NAME}
+   Copyright 1991, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001,
+   2002 Free Software Foundation, Inc.
+   Written by Steve Chamberlain <sac@cygnus.com>
+   ELF support by Ian Lance Taylor <ian@cygnus.com>
+
+This file is part of GLD, the Gnu Linker.
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+
+#define TARGET_IS_${EMULATION_NAME}
+
+#include "bfd.h"
+#include "sysdep.h"
+#include "libiberty.h"
+#include "safe-ctype.h"
+
+#include "bfdlink.h"
+
+#include "ld.h"
+#include "ldmain.h"
+#include "ldmisc.h"
+#include "ldexp.h"
+#include "ldlang.h"
+#include "ldfile.h"
+#include "ldemul.h"
+#include <ldgram.h>
+#include "elf/common.h"
+
+static void gld${EMULATION_NAME}_before_parse
+  PARAMS ((void));
+static void gld${EMULATION_NAME}_vercheck
+  PARAMS ((lang_input_statement_type *));
+static void gld${EMULATION_NAME}_stat_needed
+  PARAMS ((lang_input_statement_type *));
+static boolean gld${EMULATION_NAME}_try_needed
+  PARAMS ((const char *, int));
+static boolean gld${EMULATION_NAME}_search_needed
+  PARAMS ((const char *, const char *, int));
+static void gld${EMULATION_NAME}_check_needed
+  PARAMS ((lang_input_statement_type *));
+static void gld${EMULATION_NAME}_after_open
+  PARAMS ((void));
+static void gld${EMULATION_NAME}_find_exp_assignment
+  PARAMS ((etree_type *));
+static void gld${EMULATION_NAME}_find_statement_assignment
+  PARAMS ((lang_statement_union_type *));
+static void gld${EMULATION_NAME}_before_allocation
+  PARAMS ((void));
+static boolean gld${EMULATION_NAME}_open_dynamic_archive
+  PARAMS ((const char *, search_dirs_type *, lang_input_statement_type *));
+static lang_output_section_statement_type *output_rel_find
+  PARAMS ((asection *));
+static asection *output_prev_sec_find
+  PARAMS ((lang_output_section_statement_type *));
+static boolean gld${EMULATION_NAME}_place_orphan
+  PARAMS ((lang_input_statement_type *, asection *));
+static void gld${EMULATION_NAME}_finish
+  PARAMS ((void));
+static char *gld${EMULATION_NAME}_get_script
+  PARAMS ((int *isfile));
+
+extern void ldfile_add_flavor (char*);
+
+EOF
+
+# Import any needed special functions and/or overrides.
+#
+if test -n "$EXTRA_EM_FILE" ; then
+. ${srcdir}/emultempl/${EXTRA_EM_FILE}.em
+fi
+
+# Functions in this file can be overridden by setting the LDEMUL_* shell
+# variables.  If the name of the overriding function is the same as is
+# defined in this file, then don't output this file's version.
+# If a different overriding name is given then output the standard function
+# as presumably it is called from the overriding function.
+#
+if test x"$LDEMUL_BEFORE_PARSE" != xgld"$EMULATION_NAME"_before_parse; then
+cat >>e${EMULATION_NAME}.c <<EOF
+
+static void
+gld${EMULATION_NAME}_before_parse ()
+{
+  const bfd_arch_info_type *arch = bfd_scan_arch ("${OUTPUT_ARCH}");
+  if (arch)
+    {
+      ldfile_output_architecture = arch->arch;
+      ldfile_output_machine = arch->mach;
+      ldfile_output_machine_name = arch->printable_name;
+    }
+  else
+    ldfile_output_architecture = bfd_arch_`echo ${ARCH} | sed -e 's/:.*//'`;
+  config.dynamic_link = ${DYNAMIC_LINK-true};
+  config.has_shared = `if test -n "$GENERATE_SHLIB_SCRIPT" ; then echo true ; else echo false ; fi`;
+  sort_flavors();
+}
+
+EOF
+fi
+
+cat >>e${EMULATION_NAME}.c <<EOF
+
+/* These variables are required to pass information back and forth
+   between after_open and check_needed and stat_needed and vercheck.  */
+
+static struct bfd_link_needed_list *global_needed;
+static struct stat global_stat;
+static boolean global_found;
+static struct bfd_link_needed_list *global_vercheck_needed;
+static boolean global_vercheck_failed;
+
+
+/* On Linux, it's possible to have different versions of the same
+   shared library linked against different versions of libc.  The
+   dynamic linker somehow tags which libc version to use in
+   /etc/ld.so.cache, and, based on the libc that it sees in the
+   executable, chooses which version of the shared library to use.
+
+   We try to do a similar check here by checking whether this shared
+   library needs any other shared libraries which may conflict with
+   libraries we have already included in the link.  If it does, we
+   skip it, and try to find another shared library farther on down the
+   link path.
+
+   This is called via lang_for_each_input_file.
+   GLOBAL_VERCHECK_NEEDED is the list of objects needed by the object
+   which we are checking.  This sets GLOBAL_VERCHECK_FAILED if we find
+   a conflicting version.  */
+
+static void
+gld${EMULATION_NAME}_vercheck (s)
+     lang_input_statement_type *s;
+{
+  const char *soname;
+  struct bfd_link_needed_list *l;
+
+  if (global_vercheck_failed)
+    return;
+  if (s->the_bfd == NULL
+      || (bfd_get_file_flags (s->the_bfd) & DYNAMIC) == 0)
+    return;
+
+  soname = bfd_elf_get_dt_soname (s->the_bfd);
+  if (soname == NULL)
+    soname = lbasename (bfd_get_filename (s->the_bfd));
+
+  for (l = global_vercheck_needed; l != NULL; l = l->next)
+    {
+      const char *suffix;
+
+      if (strcmp (soname, l->name) == 0)
+	{
+	  /* Probably can't happen, but it's an easy check.  */
+	  continue;
+	}
+
+      if (strchr (l->name, '/') != NULL)
+	continue;
+
+      suffix = strstr (l->name, ".so.");
+      if (suffix == NULL)
+	continue;
+
+      suffix += sizeof ".so." - 1;
+
+      if (strncmp (soname, l->name, suffix - l->name) == 0)
+	{
+	  /* Here we know that S is a dynamic object FOO.SO.VER1, and
+             the object we are considering needs a dynamic object
+             FOO.SO.VER2, and VER1 and VER2 are different.  This
+             appears to be a version mismatch, so we tell the caller
+             to try a different version of this library.  */
+	  global_vercheck_failed = true;
+	  return;
+	}
+    }
+}
+
+
+/* See if an input file matches a DT_NEEDED entry by running stat on
+   the file.  */
+
+static void
+gld${EMULATION_NAME}_stat_needed (s)
+     lang_input_statement_type *s;
+{
+  struct stat st;
+  const char *suffix;
+  const char *soname;
+
+  if (global_found)
+    return;
+  if (s->the_bfd == NULL)
+    return;
+
+  if (bfd_stat (s->the_bfd, &st) != 0)
+    {
+      einfo ("%P:%B: bfd_stat failed: %E\n", s->the_bfd);
+      return;
+    }
+
+  if (st.st_dev == global_stat.st_dev
+      && st.st_ino == global_stat.st_ino)
+    {
+      global_found = true;
+      return;
+    }
+
+  /* We issue a warning if it looks like we are including two
+     different versions of the same shared library.  For example,
+     there may be a problem if -lc picks up libc.so.6 but some other
+     shared library has a DT_NEEDED entry of libc.so.5.  This is a
+     heuristic test, and it will only work if the name looks like
+     NAME.so.VERSION.  FIXME: Depending on file names is error-prone.
+     If we really want to issue warnings about mixing version numbers
+     of shared libraries, we need to find a better way.  */
+
+  if (strchr (global_needed->name, '/') != NULL)
+    return;
+  suffix = strstr (global_needed->name, ".so.");
+  if (suffix == NULL)
+    return;
+  suffix += sizeof ".so." - 1;
+
+  soname = bfd_elf_get_dt_soname (s->the_bfd);
+  if (soname == NULL)
+    soname = lbasename (s->filename);
+
+  if (strncmp (soname, global_needed->name, suffix - global_needed->name) == 0)
+    einfo ("%P: warning: %s, needed by %B, may conflict with %s\n",
+	   global_needed->name, global_needed->by, soname);
+}
+
+
+/* This function is called for each possible name for a dynamic object
+   named by a DT_NEEDED entry.  The FORCE parameter indicates whether
+   to skip the check for a conflicting version.  */
+
+static boolean
+gld${EMULATION_NAME}_try_needed (name, force)
+     const char *name;
+     int force;
+{
+  bfd *abfd;
+  const char *soname;
+
+  abfd = bfd_openr (name, bfd_get_target (output_bfd));
+  if (abfd == NULL)
+    return false;
+  if (! bfd_check_format (abfd, bfd_object))
+    {
+      bfd_close (abfd);
+      return false;
+    }
+  if ((bfd_get_file_flags (abfd) & DYNAMIC) == 0)
+    {
+      bfd_close (abfd);
+      return false;
+    }
+
+  /* For DT_NEEDED, they have to match.  */
+  if (abfd->xvec != output_bfd->xvec)
+    {
+      bfd_close (abfd);
+      return false;
+    }
+
+  /* Check whether this object would include any conflicting library
+     versions.  If FORCE is set, then we skip this check; we use this
+     the second time around, if we couldn't find any compatible
+     instance of the shared library.  */
+
+  if (! force)
+    {
+      struct bfd_link_needed_list *needed;
+
+      if (! bfd_elf_get_bfd_needed_list (abfd, &needed))
+	einfo ("%F%P:%B: bfd_elf_get_bfd_needed_list failed: %E\n", abfd);
+
+      if (needed != NULL)
+	{
+	  global_vercheck_needed = needed;
+	  global_vercheck_failed = false;
+	  lang_for_each_input_file (gld${EMULATION_NAME}_vercheck);
+	  if (global_vercheck_failed)
+	    {
+	      bfd_close (abfd);
+	      /* Return false to force the caller to move on to try
+                 another file on the search path.  */
+	      return false;
+	    }
+
+	  /* But wait!  It gets much worse.  On Linux, if a shared
+             library does not use libc at all, we are supposed to skip
+             it the first time around in case we encounter a shared
+             library later on with the same name which does use the
+             version of libc that we want.  This is much too horrible
+             to use on any system other than Linux.  */
+
+EOF
+case ${target} in
+  *-*-linux-gnu*)
+    cat >>e${EMULATION_NAME}.c <<EOF
+	  {
+	    struct bfd_link_needed_list *l;
+
+	    for (l = needed; l != NULL; l = l->next)
+	      if (strncmp (l->name, "libc.so", 7) == 0)
+		break;
+	    if (l == NULL)
+	      {
+		bfd_close (abfd);
+		return false;
+	      }
+	  }
+
+EOF
+    ;;
+esac
+cat >>e${EMULATION_NAME}.c <<EOF
+	}
+    }
+
+  /* We've found a dynamic object matching the DT_NEEDED entry.  */
+
+  /* We have already checked that there is no other input file of the
+     same name.  We must now check again that we are not including the
+     same file twice.  We need to do this because on many systems
+     libc.so is a symlink to, e.g., libc.so.1.  The SONAME entry will
+     reference libc.so.1.  If we have already included libc.so, we
+     don't want to include libc.so.1 if they are the same file, and we
+     can only check that using stat.  */
+
+  if (bfd_stat (abfd, &global_stat) != 0)
+    einfo ("%F%P:%B: bfd_stat failed: %E\n", abfd);
+
+  /* First strip off everything before the last '/'.  */
+  soname = lbasename (abfd->filename);
+
+  if (trace_file_tries)
+    info_msg (_("found %s at %s\n"), soname, name);
+
+  global_found = false;
+  lang_for_each_input_file (gld${EMULATION_NAME}_stat_needed);
+  if (global_found)
+    {
+      /* Return true to indicate that we found the file, even though
+         we aren't going to do anything with it.  */
+      return true;
+    }
+
+  /* Tell the ELF backend that we don't want the output file to have a
+     DT_NEEDED entry for this file.  */
+  bfd_elf_set_dt_needed_name (abfd, "");
+
+  /* Tell the ELF backend that the output file needs a DT_NEEDED
+     entry for this file if it is used to resolve the reference in
+     a regular object.  */
+  bfd_elf_set_dt_needed_soname (abfd, soname);
+
+  /* Add this file into the symbol table.  */
+  if (! bfd_link_add_symbols (abfd, &link_info))
+    einfo ("%F%B: could not read symbols: %E\n", abfd);
+
+  return true;
+}
+
+
+/* Search for a needed file in a path.  */
+
+static boolean
+gld${EMULATION_NAME}_search_needed (path, name, force)
+     const char *path;
+     const char *name;
+     int force;
+{
+  const char *s;
+  size_t len;
+
+  if (name[0] == '/')
+    return gld${EMULATION_NAME}_try_needed (name, force);
+
+  if (path == NULL || *path == '\0')
+    return false;
+  len = strlen (name);
+  while (1)
+    {
+      char *filename, *sset;
+
+      s = strchr (path, ':');
+      if (s == NULL)
+	s = path + strlen (path);
+
+      filename = (char *) xmalloc (s - path + len + 2);
+      if (s == path)
+	sset = filename;
+      else
+	{
+	  memcpy (filename, path, s - path);
+	  filename[s - path] = '/';
+	  sset = filename + (s - path) + 1;
+	}
+      strcpy (sset, name);
+
+      if (gld${EMULATION_NAME}_try_needed (filename, force))
+	return true;
+
+      free (filename);
+
+      if (*s == '\0')
+	break;
+      path = s + 1;
+    }
+
+  return false;
+}
+
+EOF
+if [ "x${host}" = "x${target}" ] ; then
+  case " ${EMULATION_LIBPATH} " in
+  *" ${EMULATION_NAME} "*)
+    case ${target} in
+      *-*-linux-gnu*)
+	cat >>e${EMULATION_NAME}.c <<EOF
+
+/* For a native linker, check the file /etc/ld.so.conf for directories
+   in which we may find shared libraries.  /etc/ld.so.conf is really
+   only meaningful on Linux.  */
+
+static boolean gld${EMULATION_NAME}_check_ld_so_conf
+  PARAMS ((const char *, int));
+
+static boolean
+gld${EMULATION_NAME}_check_ld_so_conf (name, force)
+     const char *name;
+     int force;
+{
+  static boolean initialized;
+  static char *ld_so_conf;
+
+  if (! initialized)
+    {
+      FILE *f;
+
+      f = fopen ("/etc/ld.so.conf", FOPEN_RT);
+      if (f != NULL)
+	{
+	  char *b;
+	  size_t len, alloc;
+	  int c;
+
+	  len = 0;
+	  alloc = 100;
+	  b = (char *) xmalloc (alloc);
+
+	  while ((c = getc (f)) != EOF)
+	    {
+	      if (len + 1 >= alloc)
+		{
+		  alloc *= 2;
+		  b = (char *) xrealloc (b, alloc);
+		}
+	      if (c != ':'
+		  && c != ' '
+		  && c != '\t'
+		  && c != '\n'
+		  && c != ',')
+		{
+		  b[len] = c;
+		  ++len;
+		}
+	      else
+		{
+		  if (len > 0 && b[len - 1] != ':')
+		    {
+		      b[len] = ':';
+		      ++len;
+		    }
+		}
+	    }
+
+	  if (len > 0 && b[len - 1] == ':')
+	    --len;
+
+	  if (len > 0)
+	    b[len] = '\0';
+	  else
+	    {
+	      free (b);
+	      b = NULL;
+	    }
+
+	  fclose (f);
+
+	  ld_so_conf = b;
+	}
+
+      initialized = true;
+    }
+
+  if (ld_so_conf == NULL)
+    return false;
+
+  return gld${EMULATION_NAME}_search_needed (ld_so_conf, name, force);
+}
+
+EOF
+	# Linux
+	;;
+    esac
+  esac
+fi
+cat >>e${EMULATION_NAME}.c <<EOF
+
+/* See if an input file matches a DT_NEEDED entry by name.  */
+
+static void
+gld${EMULATION_NAME}_check_needed (s)
+     lang_input_statement_type *s;
+{
+  if (global_found)
+    return;
+
+  if (s->filename != NULL)
+    {
+      const char *f;
+
+      if (strcmp (s->filename, global_needed->name) == 0)
+	{
+	  global_found = true;
+	  return;
+	}
+
+      if (s->search_dirs_flag)
+	{
+	  f = strrchr (s->filename, '/');
+	  if (f != NULL
+	      && strcmp (f + 1, global_needed->name) == 0)
+	    {
+	      global_found = true;
+	      return;
+	    }
+	}
+    }
+
+  if (s->the_bfd != NULL)
+    {
+      const char *soname;
+
+      soname = bfd_elf_get_dt_soname (s->the_bfd);
+      if (soname != NULL
+	  && strcmp (soname, global_needed->name) == 0)
+	{
+	  global_found = true;
+	  return;
+	}
+    }
+}
+
+EOF
+
+if test x"$LDEMUL_AFTER_OPEN" != xgld"$EMULATION_NAME"_after_open; then
+cat >>e${EMULATION_NAME}.c <<EOF
+
+/* This is called after all the input files have been opened.  */
+
+static void
+gld${EMULATION_NAME}_after_open ()
+{
+  struct bfd_link_needed_list *needed, *l;
+
+  /* We only need to worry about this when doing a final link.  */
+  if (link_info.relocateable || link_info.shared)
+    return;
+
+  /* Get the list of files which appear in DT_NEEDED entries in
+     dynamic objects included in the link (often there will be none).
+     For each such file, we want to track down the corresponding
+     library, and include the symbol table in the link.  This is what
+     the runtime dynamic linker will do.  Tracking the files down here
+     permits one dynamic object to include another without requiring
+     special action by the person doing the link.  Note that the
+     needed list can actually grow while we are stepping through this
+     loop.  */
+  needed = bfd_elf_get_needed_list (output_bfd, &link_info);
+  for (l = needed; l != NULL; l = l->next)
+    {
+      struct bfd_link_needed_list *ll;
+      int force;
+
+      /* If we've already seen this file, skip it.  */
+      for (ll = needed; ll != l; ll = ll->next)
+	if (strcmp (ll->name, l->name) == 0)
+	  break;
+      if (ll != l)
+	continue;
+
+      /* See if this file was included in the link explicitly.  */
+      global_needed = l;
+      global_found = false;
+      lang_for_each_input_file (gld${EMULATION_NAME}_check_needed);
+      if (global_found)
+	continue;
+
+      if (trace_file_tries)
+	info_msg (_("%s needed by %B\n"), l->name, l->by);
+
+      /* We need to find this file and include the symbol table.  We
+	 want to search for the file in the same way that the dynamic
+	 linker will search.  That means that we want to use
+	 rpath_link, rpath, then the environment variable
+	 LD_LIBRARY_PATH (native only), then the DT_RPATH/DT_RUNPATH
+	 entries (native only), then the linker script LIB_SEARCH_DIRS.
+	 We do not search using the -L arguments.
+
+	 We search twice.  The first time, we skip objects which may
+	 introduce version mismatches.  The second time, we force
+	 their use.  See gld${EMULATION_NAME}_vercheck comment.  */
+      for (force = 0; force < 2; force++)
+	{
+	  size_t len;
+	  search_dirs_type *search;
+EOF
+if [ "x${host}" = "x${target}" ] ; then
+  case " ${EMULATION_LIBPATH} " in
+  *" ${EMULATION_NAME} "*)
+cat >>e${EMULATION_NAME}.c <<EOF
+	  const char *lib_path;
+	  struct bfd_link_needed_list *rp;
+	  int found;
+EOF
+  ;;
+  esac
+fi
+cat >>e${EMULATION_NAME}.c <<EOF
+
+	  if (gld${EMULATION_NAME}_search_needed (command_line.rpath_link,
+						  l->name, force))
+	    break;
+EOF
+if [ "x${host}" = "x${target}" ] ; then
+  case " ${EMULATION_LIBPATH} " in
+  *" ${EMULATION_NAME} "*)
+cat >>e${EMULATION_NAME}.c <<EOF
+	  if (gld${EMULATION_NAME}_search_needed (command_line.rpath,
+						  l->name, force))
+	    break;
+	  if (command_line.rpath_link == NULL
+	      && command_line.rpath == NULL)
+	    {
+	      lib_path = (const char *) getenv ("LD_RUN_PATH");
+	      if (gld${EMULATION_NAME}_search_needed (lib_path, l->name,
+						      force))
+		break;
+	    }
+	  lib_path = (const char *) getenv ("LD_LIBRARY_PATH");
+	  if (gld${EMULATION_NAME}_search_needed (lib_path, l->name, force))
+	    break;
+
+	  found = 0;
+	  rp = bfd_elf_get_runpath_list (output_bfd, &link_info);
+	  for (; !found && rp != NULL; rp = rp->next)
+	    {
+	      found = (rp->by == l->by
+		       && gld${EMULATION_NAME}_search_needed (rp->name,
+							      l->name,
+							      force));
+	    }
+	  if (found)
+	    break;
+
+EOF
+  ;;
+  esac
+fi
+cat >>e${EMULATION_NAME}.c <<EOF
+	  len = strlen (l->name);
+	  for (search = search_head; search != NULL; search = search->next)
+	    {
+	      char *filename;
+
+	      if (search->cmdline)
+		continue;
+	      filename = (char *) xmalloc (strlen (search->name) + len + 2);
+	      sprintf (filename, "%s/%s", search->name, l->name);
+	      if (gld${EMULATION_NAME}_try_needed (filename, force))
+		break;
+	      free (filename);
+	    }
+	  if (search != NULL)
+	    break;
+EOF
+if [ "x${host}" = "x${target}" ] ; then
+  case " ${EMULATION_LIBPATH} " in
+  *" ${EMULATION_NAME} "*)
+    case ${target} in
+      *-*-linux-gnu*)
+	cat >>e${EMULATION_NAME}.c <<EOF
+	  if (gld${EMULATION_NAME}_check_ld_so_conf (l->name, force))
+	    break;
+EOF
+	# Linux
+        ;;
+    esac
+  ;;
+  esac
+fi
+cat >>e${EMULATION_NAME}.c <<EOF
+	}
+
+      if (force < 2)
+	continue;
+
+      einfo ("%P: warning: %s, needed by %B, not found (try using -rpath or -rpath-link)\n",
+	     l->name, l->by);
+    }
+}
+
+EOF
+fi
+
+cat >>e${EMULATION_NAME}.c <<EOF
+
+/* Look through an expression for an assignment statement.  */
+
+static void
+gld${EMULATION_NAME}_find_exp_assignment (exp)
+     etree_type *exp;
+{
+  struct bfd_link_hash_entry *h;
+
+  switch (exp->type.node_class)
+    {
+    case etree_provide:
+      h = bfd_link_hash_lookup (link_info.hash, exp->assign.dst,
+				false, false, false);
+      if (h == NULL)
+	break;
+
+      /* We call record_link_assignment even if the symbol is defined.
+	 This is because if it is defined by a dynamic object, we
+	 actually want to use the value defined by the linker script,
+	 not the value from the dynamic object (because we are setting
+	 symbols like etext).  If the symbol is defined by a regular
+	 object, then, as it happens, calling record_link_assignment
+	 will do no harm.  */
+
+      /* Fall through.  */
+    case etree_assign:
+      if (strcmp (exp->assign.dst, ".") != 0)
+	{
+	  if (! (bfd_elf${ELFSIZE}_record_link_assignment
+		 (output_bfd, &link_info, exp->assign.dst,
+		  exp->type.node_class == etree_provide ? true : false)))
+	    einfo ("%P%F: failed to record assignment to %s: %E\n",
+		   exp->assign.dst);
+	}
+      gld${EMULATION_NAME}_find_exp_assignment (exp->assign.src);
+      break;
+
+    case etree_binary:
+      gld${EMULATION_NAME}_find_exp_assignment (exp->binary.lhs);
+      gld${EMULATION_NAME}_find_exp_assignment (exp->binary.rhs);
+      break;
+
+    case etree_trinary:
+      gld${EMULATION_NAME}_find_exp_assignment (exp->trinary.cond);
+      gld${EMULATION_NAME}_find_exp_assignment (exp->trinary.lhs);
+      gld${EMULATION_NAME}_find_exp_assignment (exp->trinary.rhs);
+      break;
+
+    case etree_unary:
+      gld${EMULATION_NAME}_find_exp_assignment (exp->unary.child);
+      break;
+
+    default:
+      break;
+    }
+}
+
+
+/* This is called by the before_allocation routine via
+   lang_for_each_statement.  It locates any assignment statements, and
+   tells the ELF backend about them, in case they are assignments to
+   symbols which are referred to by dynamic objects.  */
+
+static void
+gld${EMULATION_NAME}_find_statement_assignment (s)
+     lang_statement_union_type *s;
+{
+  if (s->header.type == lang_assignment_statement_enum)
+    gld${EMULATION_NAME}_find_exp_assignment (s->assignment_statement.exp);
+}
+
+EOF
+
+if test x"$LDEMUL_BEFORE_ALLOCATION" != xgld"$EMULATION_NAME"_before_allocation; then
+  if test x"${ELF_INTERPRETER_NAME+set}" = xset; then
+    ELF_INTERPRETER_SET_DEFAULT="
+  if (sinterp != NULL)
+    {
+      sinterp->contents = ${ELF_INTERPRETER_NAME};
+      sinterp->_raw_size = strlen (sinterp->contents) + 1;
+    }
+
+"
+  else
+    ELF_INTERPRETER_SET_DEFAULT=
+  fi
+cat >>e${EMULATION_NAME}.c <<EOF
+
+/* This is called after the sections have been attached to output
+   sections, but before any sizes or addresses have been set.  */
+
+static void
+gld${EMULATION_NAME}_before_allocation ()
+{
+  const char *rpath;
+  asection *sinterp;
+
+  /* If we are going to make any variable assignments, we need to let
+     the ELF backend know about them in case the variables are
+     referred to by dynamic objects.  */
+  lang_for_each_statement (gld${EMULATION_NAME}_find_statement_assignment);
+
+  /* Let the ELF backend work out the sizes of any sections required
+     by dynamic linking.  */
+  rpath = command_line.rpath;
+  if (rpath == NULL)
+    rpath = (const char *) getenv ("LD_RUN_PATH");
+  if (! (bfd_elf${ELFSIZE}_size_dynamic_sections
+         (output_bfd, command_line.soname, rpath,
+	  command_line.filter_shlib,
+	  (const char * const *) command_line.auxiliary_filters,
+	  &link_info, &sinterp, lang_elf_version_info)))
+    einfo ("%P%F: failed to set dynamic section sizes: %E\n");
+${ELF_INTERPRETER_SET_DEFAULT}
+  /* Let the user override the dynamic linker we are using.  */
+  if (command_line.interpreter != NULL
+      && sinterp != NULL)
+    {
+      sinterp->contents = (bfd_byte *) command_line.interpreter;
+      sinterp->_raw_size = strlen (command_line.interpreter) + 1;
+    }
+
+  /* Look for any sections named .gnu.warning.  As a GNU extensions,
+     we treat such sections as containing warning messages.  We print
+     out the warning message, and then zero out the section size so
+     that it does not get copied into the output file.  */
+
+  {
+    LANG_FOR_EACH_INPUT_STATEMENT (is)
+      {
+	asection *s;
+	bfd_size_type sz;
+	char *msg;
+	boolean ret;
+
+	if (is->just_syms_flag)
+	  continue;
+
+	s = bfd_get_section_by_name (is->the_bfd, ".gnu.warning");
+	if (s == NULL)
+	  continue;
+
+	sz = bfd_section_size (is->the_bfd, s);
+	msg = xmalloc ((size_t) sz + 1);
+	if (! bfd_get_section_contents (is->the_bfd, s, msg, (file_ptr) 0, sz))
+	  einfo ("%F%B: Can't read contents of section .gnu.warning: %E\n",
+		 is->the_bfd);
+	msg[sz] = '\0';
+	ret = link_info.callbacks->warning (&link_info, msg,
+					    (const char *) NULL,
+					    is->the_bfd, (asection *) NULL,
+					    (bfd_vma) 0);
+	ASSERT (ret);
+	free (msg);
+
+	/* Clobber the section size, so that we don't waste copying the
+	   warning into the output file.  */
+	s->_raw_size = 0;
+      }
+  }
+}
+
+EOF
+fi
+
+if test x"$LDEMUL_OPEN_DYNAMIC_ARCHIVE" != xgld"$EMULATION_NAME"_open_dynamic_archive; then
+cat >>e${EMULATION_NAME}.c <<EOF
+
+/* Try to open a dynamic archive.  This is where we know that ELF
+   dynamic libraries have an extension of .so (or .sl on oddball systems
+   like hpux).  */
+
+static boolean
+gld${EMULATION_NAME}_open_dynamic_archive (arch, search, entry)
+     const char *arch;
+     search_dirs_type *search;
+     lang_input_statement_type *entry;
+{
+  const char *filename;
+  char *string;
+
+  if (! entry->is_archive)
+    return false;
+
+  filename = entry->filename;
+
+  /* This allocates a few bytes too many when EXTRA_SHLIB_EXTENSION
+     is defined, but it does not seem worth the headache to optimize
+     away those two bytes of space.  */
+  string = (char *) xmalloc (strlen (search->name)
+			     + strlen (filename)
+			     + strlen (arch)
+#ifdef EXTRA_SHLIB_EXTENSION
+			     + strlen (EXTRA_SHLIB_EXTENSION)
+#endif
+			     + sizeof "/lib.so");
+
+  sprintf (string, "%s/lib%s%s.so", search->name, filename, arch);
+
+#ifdef EXTRA_SHLIB_EXTENSION
+  /* Try the .so extension first.  If that fails build a new filename
+     using EXTRA_SHLIB_EXTENSION.  */
+  if (! ldfile_try_open_bfd (string, entry))
+    sprintf (string, "%s/lib%s%s%s", search->name,
+	     filename, arch, EXTRA_SHLIB_EXTENSION);
+#endif
+
+  if (! ldfile_try_open_bfd (string, entry))
+    {
+      free (string);
+      return false;
+    }
+
+  entry->filename = string;
+
+  /* We have found a dynamic object to include in the link.  The ELF
+     backend linker will create a DT_NEEDED entry in the .dynamic
+     section naming this file.  If this file includes a DT_SONAME
+     entry, it will be used.  Otherwise, the ELF linker will just use
+     the name of the file.  For an archive found by searching, like
+     this one, the DT_NEEDED entry should consist of just the name of
+     the file, without the path information used to find it.  Note
+     that we only need to do this if we have a dynamic object; an
+     archive will never be referenced by a DT_NEEDED entry.
+
+     FIXME: This approach--using bfd_elf_set_dt_needed_name--is not
+     very pretty.  I haven't been able to think of anything that is
+     pretty, though.  */
+  if (bfd_check_format (entry->the_bfd, bfd_object)
+      && (entry->the_bfd->flags & DYNAMIC) != 0)
+    {
+      ASSERT (entry->is_archive && entry->search_dirs_flag);
+
+      /* Rather than duplicating the logic above.  Just use the
+	 filename we recorded earlier.  */
+
+      filename = lbasename (entry->filename);
+      bfd_elf_set_dt_needed_name (entry->the_bfd, filename);
+    }
+
+  return true;
+}
+
+EOF
+fi
+
+if test x"$LDEMUL_PLACE_ORPHAN" != xgld"$EMULATION_NAME"_place_orphan; then
+cat >>e${EMULATION_NAME}.c <<EOF
+
+/* A variant of lang_output_section_find.  Used by place_orphan.  */
+
+static lang_output_section_statement_type *
+output_rel_find (sec)
+     asection *sec;
+{
+  lang_statement_union_type *u;
+  lang_output_section_statement_type *lookup;
+  lang_output_section_statement_type *last = NULL;
+  lang_output_section_statement_type *last_rel = NULL;
+  lang_output_section_statement_type *last_rel_alloc = NULL;
+  int rela = sec->name[4] == 'a';
+
+  for (u = lang_output_section_statement.head; u; u = lookup->next)
+    {
+      lookup = &u->output_section_statement;
+      if (strncmp (".rel", lookup->name, 4) == 0)
+	{
+	  /* Don't place after .rel.plt as doing so results in wrong
+	     dynamic tags.  Also, place allocated reloc sections before
+	     non-allocated.  */
+	  int lookrela = lookup->name[4] == 'a';
+
+	  if (strcmp (".plt", lookup->name + 4 + lookrela) == 0
+	      || (lookup->bfd_section != NULL
+		  && (lookup->bfd_section->flags & SEC_ALLOC) == 0))
+	    break;
+	  last = lookup;
+	  if (rela == lookrela)
+	    last_rel = lookup;
+	  if (lookup->bfd_section != NULL
+	      && (lookup->bfd_section->flags & SEC_ALLOC) != 0)
+	    last_rel_alloc = lookup;
+	}
+    }
+
+  if (last_rel_alloc)
+    return last_rel_alloc;
+
+  if (last_rel)
+    return last_rel;
+
+  return last;
+}
+
+/* Find the last output section before given output statement.
+   Used by place_orphan.  */
+
+static asection *
+output_prev_sec_find (os)
+     lang_output_section_statement_type *os;
+{
+  asection *s = (asection *) NULL;
+  lang_statement_union_type *u;
+  lang_output_section_statement_type *lookup;
+
+  for (u = lang_output_section_statement.head;
+       u != (lang_statement_union_type *) NULL;
+       u = lookup->next)
+    {
+      lookup = &u->output_section_statement;
+      if (lookup == os)
+	return s;
+
+      if (lookup->bfd_section != NULL && lookup->bfd_section->owner != NULL)
+	s = lookup->bfd_section;
+    }
+
+  return NULL;
+}
+
+/* Place an orphan section.  We use this to put random SHF_ALLOC
+   sections in the right segment.  */
+
+struct orphan_save {
+  lang_output_section_statement_type *os;
+  asection **section;
+  lang_statement_union_type **stmt;
+};
+
+static boolean
+gld${EMULATION_NAME}_place_orphan (file, s)
+     lang_input_statement_type *file;
+     asection *s;
+{
+  static struct orphan_save hold_text;
+  static struct orphan_save hold_rodata;
+  static struct orphan_save hold_data;
+  static struct orphan_save hold_bss;
+  static struct orphan_save hold_rel;
+  static struct orphan_save hold_interp;
+  static struct orphan_save hold_sdata;
+  static int count = 1;
+  struct orphan_save *place;
+  lang_statement_list_type *old;
+  lang_statement_list_type add;
+  etree_type *address;
+  const char *secname;
+  const char *ps = NULL;
+  lang_output_section_statement_type *os;
+  int isdyn = 0;
+
+  secname = bfd_get_section_name (s->owner, s);
+  if (! link_info.relocateable
+      && link_info.combreloc
+      && (s->flags & SEC_ALLOC)
+      && strncmp (secname, ".rel", 4) == 0)
+    {
+      if (secname[4] == 'a')
+	secname = ".rela.dyn";
+      else
+	secname = ".rel.dyn";
+      isdyn = 1;
+    }
+
+  if (isdyn || (!config.unique_orphan_sections && !unique_section_p (secname)))
+    {
+      /* Look through the script to see where to place this section.  */
+      os = lang_output_section_find (secname);
+
+      if (os != NULL
+	  && (os->bfd_section == NULL
+	      || ((s->flags ^ os->bfd_section->flags)
+		  & (SEC_LOAD | SEC_ALLOC)) == 0))
+	{
+	  /* We already have an output section statement with this
+	     name, and its bfd section, if any, has compatible flags.  */
+	  lang_add_section (&os->children, s, os, file);
+	  return true;
+	}
+    }
+
+  if (hold_text.os == NULL)
+    hold_text.os = lang_output_section_find (".text");
+
+  /* If this is a final link, then always put .gnu.warning.SYMBOL
+     sections into the .text section to get them out of the way.  */
+  if (! link_info.shared
+      && ! link_info.relocateable
+      && strncmp (secname, ".gnu.warning.", sizeof ".gnu.warning." - 1) == 0
+      && hold_text.os != NULL)
+    {
+      lang_add_section (&hold_text.os->children, s, hold_text.os, file);
+      return true;
+    }
+
+  /* Decide which segment the section should go in based on the
+     section name and section flags.  We put loadable .note sections
+     right after the .interp section, so that the PT_NOTE segment is
+     stored right after the program headers where the OS can read it
+     in the first page.  */
+#define HAVE_SECTION(hold, name) \
+(hold.os != NULL || (hold.os = lang_output_section_find (name)) != NULL)
+
+  if ((s->flags & SEC_EXCLUDE) != 0 && !link_info.relocateable)
+    {
+      if (s->output_section == NULL)
+	s->output_section = bfd_abs_section_ptr;
+      return true;
+    }
+
+  place = NULL;
+  if ((s->flags & SEC_ALLOC) == 0)
+    ;
+  else if ((s->flags & SEC_LOAD) != 0
+	   && strncmp (secname, ".note", 5) == 0
+	   && HAVE_SECTION (hold_interp, ".interp"))
+    place = &hold_interp;
+  else if ((s->flags & SEC_HAS_CONTENTS) == 0
+	   && HAVE_SECTION (hold_bss, ".bss"))
+    place = &hold_bss;
+  else if ((s->flags & SEC_SMALL_DATA) != 0
+	   && HAVE_SECTION (hold_sdata, ".sdata"))
+    place = &hold_sdata;
+  else if ((s->flags & SEC_READONLY) == 0
+	   && HAVE_SECTION (hold_data, ".data"))
+    place = &hold_data;
+  else if (strncmp (secname, ".rel", 4) == 0
+	   && (s->flags & SEC_LOAD) != 0
+	   && (hold_rel.os != NULL
+	       || (hold_rel.os = output_rel_find (s)) != NULL))
+    place = &hold_rel;
+  else if ((s->flags & (SEC_CODE | SEC_READONLY)) == SEC_READONLY
+	   && HAVE_SECTION (hold_rodata, ".rodata"))
+    place = &hold_rodata;
+  else if ((s->flags & (SEC_CODE | SEC_READONLY)) == (SEC_CODE | SEC_READONLY)
+	   && hold_text.os != NULL)
+    place = &hold_text;
+
+#undef HAVE_SECTION
+
+  /* Choose a unique name for the section.  This will be needed if the
+     same section name appears in the input file with different
+     loadable or allocatable characteristics.  */
+  if (bfd_get_section_by_name (output_bfd, secname) != NULL)
+    {
+      secname = bfd_get_unique_section_name (output_bfd, secname, &count);
+      if (secname == NULL)
+	einfo ("%F%P: place_orphan failed: %E\n");
+    }
+
+  /* Start building a list of statements for this section.
+     First save the current statement pointer.  */
+  old = stat_ptr;
+
+  /* If we have found an appropriate place for the output section
+     statements for this orphan, add them to our own private list,
+     inserting them later into the global statement list.  */
+  if (place != NULL)
+    {
+      stat_ptr = &add;
+      lang_list_init (stat_ptr);
+    }
+
+  if (config.build_constructors)
+    {
+      /* If the name of the section is representable in C, then create
+	 symbols to mark the start and the end of the section.  */
+      for (ps = secname; *ps != '\0'; ps++)
+	if (! ISALNUM (*ps) && *ps != '_')
+	  break;
+      if (*ps == '\0')
+	{
+	  char *symname;
+	  etree_type *e_align;
+
+	  symname = (char *) xmalloc (ps - secname + sizeof "__start_");
+	  sprintf (symname, "__start_%s", secname);
+	  e_align = exp_unop (ALIGN_K,
+			      exp_intop ((bfd_vma) 1 << s->alignment_power));
+	  lang_add_assignment (exp_assop ('=', symname, e_align));
+	}
+    }
+
+  if (link_info.relocateable || (s->flags & (SEC_LOAD | SEC_ALLOC)) == 0)
+    address = exp_intop ((bfd_vma) 0);
+  else
+    address = NULL;
+
+  os = lang_enter_output_section_statement (secname, address, 0,
+					    (bfd_vma) 0,
+					    (etree_type *) NULL,
+					    (etree_type *) NULL,
+					    (etree_type *) NULL);
+
+  lang_add_section (&os->children, s, os, file);
+
+  lang_leave_output_section_statement
+    ((bfd_vma) 0, "*default*",
+     (struct lang_output_section_phdr_list *) NULL, NULL);
+
+  if (config.build_constructors && *ps == '\0')
+    {
+      char *symname;
+
+      /* lang_leave_ouput_section_statement resets stat_ptr.  Put
+	 stat_ptr back where we want it.  */
+      if (place != NULL)
+	stat_ptr = &add;
+
+      symname = (char *) xmalloc (ps - secname + sizeof "__stop_");
+      sprintf (symname, "__stop_%s", secname);
+      lang_add_assignment (exp_assop ('=', symname,
+				      exp_nameop (NAME, ".")));
+    }
+
+  /* Restore the global list pointer.  */
+  stat_ptr = old;
+
+  if (place != NULL && os->bfd_section != NULL)
+    {
+      asection *snew, **pps;
+
+      snew = os->bfd_section;
+
+      /* Shuffle the bfd section list to make the output file look
+	 neater.  This is really only cosmetic.  */
+      if (place->section == NULL)
+	{
+	  asection *bfd_section = place->os->bfd_section;
+
+	  /* If the output statement hasn't been used to place
+	     any input sections (and thus doesn't have an output
+	     bfd_section), look for the closest prior output statement
+	     having an output section.  */
+	  if (bfd_section == NULL)
+	    bfd_section = output_prev_sec_find (place->os);
+
+	  if (bfd_section != NULL && bfd_section != snew)
+	    place->section = &bfd_section->next;
+	}
+
+      if (place->section != NULL)
+	{
+	  /* Unlink the section.  */
+	  for (pps = &output_bfd->sections; *pps != snew; pps = &(*pps)->next)
+	    ;
+	  bfd_section_list_remove (output_bfd, pps);
+
+	  /* Now tack it on to the "place->os" section list.  */
+	  bfd_section_list_insert (output_bfd, place->section, snew);
+	}
+
+      /* Save the end of this list.  Further ophans of this type will
+	 follow the one we've just added.  */
+      place->section = &snew->next;
+
+      /* The following is non-cosmetic.  We try to put the output
+	 statements in some sort of reasonable order here, because
+	 they determine the final load addresses of the orphan
+	 sections.  In addition, placing output statements in the
+	 wrong order may require extra segments.  For instance,
+	 given a typical situation of all read-only sections placed
+	 in one segment and following that a segment containing all
+	 the read-write sections, we wouldn't want to place an orphan
+	 read/write section before or amongst the read-only ones.  */
+      if (add.head != NULL)
+	{
+	  if (place->stmt == NULL)
+	    {
+	      /* Put the new statement list right at the head.  */
+	      *add.tail = place->os->header.next;
+	      place->os->header.next = add.head;
+	    }
+	  else
+	    {
+	      /* Put it after the last orphan statement we added.  */
+	      *add.tail = *place->stmt;
+	      *place->stmt = add.head;
+	    }
+
+	  /* Fix the global list pointer if we happened to tack our
+	     new list at the tail.  */
+	  if (*old->tail == add.head)
+	    old->tail = add.tail;
+
+	  /* Save the end of this list.  */
+	  place->stmt = add.tail;
+	}
+    }
+
+  return true;
+}
+EOF
+fi
+
+if test x"$LDEMUL_FINISH" != xgld"$EMULATION_NAME"_finish; then
+cat >>e${EMULATION_NAME}.c <<EOF
+
+static void
+gld${EMULATION_NAME}_finish ()
+{
+  if (bfd_elf${ELFSIZE}_discard_info (output_bfd, &link_info))
+    {
+      lang_reset_memory_regions ();
+
+      /* Resize the sections.  */
+      lang_size_sections (stat_ptr->head, abs_output_section,
+			  &stat_ptr->head, 0, (bfd_vma) 0, NULL);
+
+      /* Redo special stuff.  */
+      ldemul_after_allocation ();
+
+      /* Do the assignments again.  */
+      lang_do_assignments (stat_ptr->head, abs_output_section,
+			   (fill_type *) 0, (bfd_vma) 0);
+    }
+}
+EOF
+fi
+
+if test x"$LDEMUL_GET_SCRIPT" != xgld"$EMULATION_NAME"_get_script; then
+cat >>e${EMULATION_NAME}.c <<EOF
+
+static char *
+gld${EMULATION_NAME}_get_script (isfile)
+     int *isfile;
+EOF
+
+if test -n "$COMPILE_IN"
+then
+# Scripts compiled in.
+
+# sed commands to quote an ld script as a C string.
+sc="-f stringify.sed"
+
+cat >>e${EMULATION_NAME}.c <<EOF
+{
+  *isfile = 0;
+
+  if (link_info.relocateable == true && config.build_constructors == true)
+    return
+EOF
+sed $sc ldscripts/${EMULATION_NAME}.xu                     >> e${EMULATION_NAME}.c
+echo '  ; else if (link_info.relocateable == true) return' >> e${EMULATION_NAME}.c
+sed $sc ldscripts/${EMULATION_NAME}.xr                     >> e${EMULATION_NAME}.c
+echo '  ; else if (!config.text_read_only) return'         >> e${EMULATION_NAME}.c
+sed $sc ldscripts/${EMULATION_NAME}.xbn                    >> e${EMULATION_NAME}.c
+if cmp -s ldscripts/${EMULATION_NAME}.x ldscripts/${EMULATION_NAME}.xn; then : ; else
+echo '  ; else if (!config.magic_demand_paged) return'     >> e${EMULATION_NAME}.c
+sed $sc ldscripts/${EMULATION_NAME}.xn                     >> e${EMULATION_NAME}.c
+fi
+if test -n "$GENERATE_SHLIB_SCRIPT" ; then
+if test -n "$GENERATE_COMBRELOC_SCRIPT" ; then
+echo '  ; else if (link_info.shared && link_info.combreloc) return' >> e${EMULATION_NAME}.c
+sed $sc ldscripts/${EMULATION_NAME}.xsc                    >> e${EMULATION_NAME}.c
+fi
+echo '  ; else if (link_info.shared) return'		   >> e${EMULATION_NAME}.c
+sed $sc ldscripts/${EMULATION_NAME}.xs                     >> e${EMULATION_NAME}.c
+fi
+if test -n "$GENERATE_COMBRELOC_SCRIPT" ; then
+echo '  ; else if (link_info.combreloc) return'            >> e${EMULATION_NAME}.c
+sed $sc ldscripts/${EMULATION_NAME}.xc                     >> e${EMULATION_NAME}.c
+fi
+echo '  ; else return'                                     >> e${EMULATION_NAME}.c
+sed $sc ldscripts/${EMULATION_NAME}.x                      >> e${EMULATION_NAME}.c
+echo '; }'                                                 >> e${EMULATION_NAME}.c
+
+else
+# Scripts read from the filesystem.
+
+cat >>e${EMULATION_NAME}.c <<EOF
+{
+  *isfile = 1;
+
+  if (link_info.relocateable == true && config.build_constructors == true)
+    return "ldscripts/${EMULATION_NAME}.xu";
+  else if (link_info.relocateable == true)
+    return "ldscripts/${EMULATION_NAME}.xr";
+  else if (!config.text_read_only)
+    return "ldscripts/${EMULATION_NAME}.xbn";
+  else if (!config.magic_demand_paged)
+    return "ldscripts/${EMULATION_NAME}.xn";
+  else if (link_info.shared)
+    return "ldscripts/${EMULATION_NAME}.xs";
+  else
+    return "ldscripts/${EMULATION_NAME}.x";
+}
+
+EOF
+fi
+fi
+
+if test -n "$PARSE_AND_LIST_ARGS_CASES" -o x"$GENERATE_SHLIB_SCRIPT" = xyes; then
+
+if test x"$LDEMUL_PARSE_ARGS" != xgld"$EMULATION_NAME"_parse_args; then
+
+if test -n "$PARSE_AND_LIST_PROLOGUE" ; then
+cat >>e${EMULATION_NAME}.c <<EOF
+ $PARSE_AND_LIST_PROLOGUE
+EOF
+fi
+
+cat >>e${EMULATION_NAME}.c <<EOF
+
+#include "getopt.h"
+
+#define OPTION_IGNORE                   (300)
+#define OPTION_FLAVOR                   (OPTION_IGNORE + 1)
+
+#define OPTION_DISABLE_NEW_DTAGS	(400)
+#define OPTION_ENABLE_NEW_DTAGS		(OPTION_DISABLE_NEW_DTAGS + 1)
+#define OPTION_GROUP			(OPTION_ENABLE_NEW_DTAGS + 1)
+#define OPTION_EH_FRAME_HDR		(OPTION_GROUP + 1)
+
+static struct option longopts[] =
+{
+  {"flavor", required_argument, NULL, OPTION_FLAVOR},
+EOF
+
+if test x"$GENERATE_SHLIB_SCRIPT" = xyes; then
+cat >>e${EMULATION_NAME}.c <<EOF
+  /* getopt allows abbreviations, so we do this to stop it from
+     treating -d/-e as abbreviations for these options. */
+  {"disable-new-dtags", no_argument, NULL, OPTION_DISABLE_NEW_DTAGS},
+  {"disable-new-dtags", no_argument, NULL, OPTION_DISABLE_NEW_DTAGS},
+  {"enable-new-dtags", no_argument, NULL, OPTION_ENABLE_NEW_DTAGS},
+  {"enable-new-dtags", no_argument, NULL, OPTION_ENABLE_NEW_DTAGS},
+  {"eh-frame-hdr", no_argument, NULL, OPTION_EH_FRAME_HDR},
+  {"Bgroup", no_argument, NULL, OPTION_GROUP},
+  {"Bgroup", no_argument, NULL, OPTION_GROUP},
+EOF
+fi
+
+if test -n "$PARSE_AND_LIST_LONGOPTS" ; then
+cat >>e${EMULATION_NAME}.c <<EOF
+ $PARSE_AND_LIST_LONGOPTS
+EOF
+fi
+
+cat >>e${EMULATION_NAME}.c <<EOF
+  {NULL, no_argument, NULL, 0}
+};
+
+
+static int gld${EMULATION_NAME}_parse_args PARAMS ((int, char **));
+
+static int
+gld${EMULATION_NAME}_parse_args (argc, argv)
+     int argc;
+     char ** argv;
+{
+  int longind;
+  int optc;
+  static int prevoptind = -1;
+  int prevopterr = opterr;
+  int wanterror;
+
+  if (prevoptind != optind)
+    opterr = 0;
+
+  wanterror = opterr;
+  prevoptind = optind;
+
+  optc = getopt_long_only (argc, argv,
+			   "-${PARSE_AND_LIST_SHORTOPTS}z:", longopts,
+			   &longind);
+  opterr = prevopterr;
+
+  switch (optc)
+    {
+    default:
+      if (wanterror)
+	xexit (1);
+      optind = prevoptind;
+      return 0;
+
+    case OPTION_FLAVOR:
+      ldfile_add_flavor (optarg);
+      break;
+EOF
+
+if test x"$GENERATE_SHLIB_SCRIPT" = xyes; then
+cat >>e${EMULATION_NAME}.c <<EOF
+    case OPTION_DISABLE_NEW_DTAGS:
+      link_info.new_dtags = false;
+      break;
+
+    case OPTION_ENABLE_NEW_DTAGS:
+      link_info.new_dtags = true;
+      break;
+
+    case OPTION_EH_FRAME_HDR:
+      link_info.eh_frame_hdr = true;
+      break;
+
+    case OPTION_GROUP:
+      link_info.flags_1 |= (bfd_vma) DF_1_GROUP;
+      /* Groups must be self-contained.  */
+      link_info.no_undefined = true;
+      break;
+
+    case 'z':
+      if (strcmp (optarg, "initfirst") == 0)
+	link_info.flags_1 |= (bfd_vma) DF_1_INITFIRST;
+      else if (strcmp (optarg, "interpose") == 0)
+	link_info.flags_1 |= (bfd_vma) DF_1_INTERPOSE;
+      else if (strcmp (optarg, "loadfltr") == 0)
+	link_info.flags_1 |= (bfd_vma) DF_1_LOADFLTR;
+      else if (strcmp (optarg, "nodefaultlib") == 0)
+	link_info.flags_1 |= (bfd_vma) DF_1_NODEFLIB;
+      else if (strcmp (optarg, "nodelete") == 0)
+	link_info.flags_1 |= (bfd_vma) DF_1_NODELETE;
+      else if (strcmp (optarg, "nodlopen") == 0)
+	link_info.flags_1 |= (bfd_vma) DF_1_NOOPEN;
+      else if (strcmp (optarg, "nodump") == 0)
+	link_info.flags_1 |= (bfd_vma) DF_1_NODUMP;
+      else if (strcmp (optarg, "now") == 0)
+	{
+	  link_info.flags |= (bfd_vma) DF_BIND_NOW;
+	  link_info.flags_1 |= (bfd_vma) DF_1_NOW;
+	}
+      else if (strcmp (optarg, "origin") == 0)
+	{
+	  link_info.flags |= (bfd_vma) DF_ORIGIN;
+	  link_info.flags_1 |= (bfd_vma) DF_1_ORIGIN;
+	}
+      else if (strcmp (optarg, "defs") == 0)
+	link_info.no_undefined = true;
+      else if (strcmp (optarg, "muldefs") == 0)
+	link_info.allow_multiple_definition = true;
+      else if (strcmp (optarg, "combreloc") == 0)
+	link_info.combreloc = true;
+      else if (strcmp (optarg, "nocombreloc") == 0)
+	link_info.combreloc = false;
+      else if (strcmp (optarg, "nocopyreloc") == 0)
+        link_info.nocopyreloc = true;
+      /* What about the other Solaris -z options? FIXME.  */
+      break;
+EOF
+fi
+
+if test -n "$PARSE_AND_LIST_ARGS_CASES" ; then
+cat >>e${EMULATION_NAME}.c <<EOF
+ $PARSE_AND_LIST_ARGS_CASES
+EOF
+fi
+
+cat >>e${EMULATION_NAME}.c <<EOF
+    }
+
+  return 1;
+}
+
+EOF
+fi
+
+if test x"$LDEMUL_LIST_OPTIONS" != xgld"$EMULATION_NAME"_list_options; then
+cat >>e${EMULATION_NAME}.c <<EOF
+
+static void gld${EMULATION_NAME}_list_options PARAMS ((FILE * file));
+
+static void
+gld${EMULATION_NAME}_list_options (file)
+     FILE * file;
+{
+EOF
+
+if test x"$GENERATE_SHLIB_SCRIPT" = xyes; then
+cat >>e${EMULATION_NAME}.c <<EOF
+  fprintf (file, _("  -Bgroup\t\tSelects group name lookup rules for DSO\n"));
+  fprintf (file, _("  --disable-new-dtags\tDisable new dynamic tags\n"));
+  fprintf (file, _("  --enable-new-dtags\tEnable new dynamic tags\n"));
+  fprintf (file, _("  --eh-frame-hdr\tCreate .eh_frame_hdr section\n"));
+  fprintf (file, _("  -z combreloc\t\tMerge dynamic relocs into one section and sort\n"));
+  fprintf (file, _("  -z defs\t\tDisallows undefined symbols\n"));
+  fprintf (file, _("  -z initfirst\t\tMark DSO to be initialized first at runtime\n"));
+  fprintf (file, _("  -z interpose\t\tMark object to interpose all DSOs but executable\n"));
+  fprintf (file, _("  -z loadfltr\t\tMark object requiring immediate process\n"));
+  fprintf (file, _("  -z muldefs\t\tAllow multiple definitions\n"));
+  fprintf (file, _("  -z nocombreloc\tDon't merge dynamic relocs into one section\n"));
+  fprintf (file, _("  -z nocopyreloc\tDon't create copy relocs\n"));
+  fprintf (file, _("  -z nodefaultlib\tMark object not to use default search paths\n"));
+  fprintf (file, _("  -z nodelete\t\tMark DSO non-deletable at runtime\n"));
+  fprintf (file, _("  -z nodlopen\t\tMark DSO not available to dlopen\n"));
+  fprintf (file, _("  -z nodump\t\tMark DSO not available to dldump\n"));
+  fprintf (file, _("  -z now\t\tMark object non-lazy runtime binding\n"));
+  fprintf (file, _("  -z origin\t\tMark object requiring immediate \$ORIGIN processing\n\t\t\t  at runtime\n"));
+  fprintf (file, _("  -z KEYWORD\t\tIgnored for Solaris compatibility\n"));
+EOF
+fi
+
+if test -n "$PARSE_AND_LIST_OPTIONS" ; then
+cat >>e${EMULATION_NAME}.c <<EOF
+ $PARSE_AND_LIST_OPTIONS
+EOF
+fi
+
+cat >>e${EMULATION_NAME}.c <<EOF
+}
+EOF
+
+if test -n "$PARSE_AND_LIST_EPILOGUE" ; then
+cat >>e${EMULATION_NAME}.c <<EOF
+ $PARSE_AND_LIST_EPILOGUE
+EOF
+fi
+fi
+else
+if test x"$LDEMUL_PARSE_ARGS" != xgld"$EMULATION_NAME"_parse_args; then
+cat >>e${EMULATION_NAME}.c <<EOF
+#define gld${EMULATION_NAME}_parse_args   NULL
+EOF
+fi
+if test x"$LDEMUL_LIST_OPTIONS" != xgld"$EMULATION_NAME"_list_options; then
+cat >>e${EMULATION_NAME}.c <<EOF
+#define gld${EMULATION_NAME}_list_options NULL
+EOF
+fi
+fi
+
+cat >>e${EMULATION_NAME}.c <<EOF
+
+struct ld_emulation_xfer_struct ld_${EMULATION_NAME}_emulation =
+{
+  ${LDEMUL_BEFORE_PARSE-gld${EMULATION_NAME}_before_parse},
+  ${LDEMUL_SYSLIB-syslib_default},
+  ${LDEMUL_HLL-hll_default},
+  ${LDEMUL_AFTER_PARSE-after_parse_default},
+  ${LDEMUL_AFTER_OPEN-gld${EMULATION_NAME}_after_open},
+  ${LDEMUL_AFTER_ALLOCATION-after_allocation_default},
+  ${LDEMUL_SET_OUTPUT_ARCH-set_output_arch_default},
+  ${LDEMUL_CHOOSE_TARGET-ldemul_default_target},
+  ${LDEMUL_BEFORE_ALLOCATION-gld${EMULATION_NAME}_before_allocation},
+  ${LDEMUL_GET_SCRIPT-gld${EMULATION_NAME}_get_script},
+  "${EMULATION_NAME}",
+  "${OUTPUT_FORMAT}",
+  ${LDEMUL_FINISH-gld${EMULATION_NAME}_finish},
+  ${LDEMUL_CREATE_OUTPUT_SECTION_STATEMENTS-NULL},
+  ${LDEMUL_OPEN_DYNAMIC_ARCHIVE-gld${EMULATION_NAME}_open_dynamic_archive},
+  ${LDEMUL_PLACE_ORPHAN-gld${EMULATION_NAME}_place_orphan},
+  ${LDEMUL_SET_SYMBOLS-NULL},
+  ${LDEMUL_PARSE_ARGS-gld${EMULATION_NAME}_parse_args},
+  ${LDEMUL_UNRECOGNIZED_FILE-NULL},
+  ${LDEMUL_LIST_OPTIONS-gld${EMULATION_NAME}_list_options},
+  ${LDEMUL_RECOGNIZED_FILE-NULL},
+  ${LDEMUL_FIND_POTENTIAL_LIBRARIES-NULL},
+  ${LDEMUL_NEW_VERS_PATTERN-NULL}
+};
+EOF
diff --git a/ld/emultempl/morphos.em b/ld/emultempl/morphos.em
new file mode 100644
index 0000000000000000000000000000000000000000..cd3b9a790fb286187d8fa3e11af9382f1603d16b
--- /dev/null
+++ ld/emultempl/morphos.em
@@ -0,0 +1,1104 @@
+# This shell script emits a C file. -*- C -*-
+# It does some substitutions.
+# This file is now misnamed, because it supports both 32 bit and 64 bit
+# ELF emulations.
+test -z "${ELFSIZE}" && ELFSIZE=32
+if [ -z "$MACHINE" ]; then
+  OUTPUT_ARCH=${ARCH}
+else
+  OUTPUT_ARCH=${ARCH}:${MACHINE}
+fi
+cat >e${EMULATION_NAME}.c <<EOF
+/* This file is is generated by a shell script.  DO NOT EDIT! */
+
+/* ${ELFSIZE} bit ELF emulation code for ${EMULATION_NAME}
+   Copyright 1991, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001,
+   2002 Free Software Foundation, Inc.
+   Written by Steve Chamberlain <sac@cygnus.com>
+   ELF support by Ian Lance Taylor <ian@cygnus.com>
+   MorphOS support by Emmanuel Lesueur <lesueur@club-internet.fr>
+
+This file is part of GLD, the Gnu Linker.
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+
+#define TARGET_IS_${EMULATION_NAME}
+
+#include "bfd.h"
+#include "sysdep.h"
+#include "libiberty.h"
+#include "safe-ctype.h"
+
+#include "bfdlink.h"
+
+#include "ld.h"
+#include "ldmain.h"
+#include "ldmisc.h"
+#include "ldexp.h"
+#include "ldlang.h"
+#include "ldfile.h"
+#include "ldemul.h"
+#include <ldgram.h>
+#include "elf/common.h"
+
+static void gld${EMULATION_NAME}_before_parse
+  PARAMS ((void));
+static void gld${EMULATION_NAME}_set_symbols
+  PARAMS ((void));
+static lang_output_section_statement_type *output_rel_find
+  PARAMS ((asection *));
+static asection *output_prev_sec_find
+  PARAMS ((lang_output_section_statement_type *));
+static boolean gld${EMULATION_NAME}_place_orphan
+  PARAMS ((lang_input_statement_type *, asection *));
+static void gld${EMULATION_NAME}_finish
+  PARAMS ((void));
+static char *gld${EMULATION_NAME}_get_script
+  PARAMS ((int *isfile));
+
+extern void ldfile_add_flavor (char*);
+static int morphos_resident;
+
+EOF
+
+# Import any needed special functions and/or overrides.
+#
+if test -n "$EXTRA_EM_FILE" ; then
+. ${srcdir}/emultempl/${EXTRA_EM_FILE}.em
+fi
+
+# Functions in this file can be overridden by setting the LDEMUL_* shell
+# variables.  If the name of the overriding function is the same as is
+# defined in this file, then don't output this file's version.
+# If a different overriding name is given then output the standard function
+# as presumably it is called from the overriding function.
+#
+if test x"$LDEMUL_BEFORE_PARSE" != xgld"$EMULATION_NAME"_before_parse; then
+cat >>e${EMULATION_NAME}.c <<EOF
+
+static void
+gld${EMULATION_NAME}_before_parse ()
+{
+  const bfd_arch_info_type *arch = bfd_scan_arch ("${OUTPUT_ARCH}");
+  if (arch)
+    {
+      ldfile_output_architecture = arch->arch;
+      ldfile_output_machine = arch->mach;
+      ldfile_output_machine_name = arch->printable_name;
+    }
+  else
+    ldfile_output_architecture = bfd_arch_`echo ${ARCH} | sed -e 's/:.*//'`;
+  config.dynamic_link = ${DYNAMIC_LINK-true};
+  config.has_shared = `if test -n "$GENERATE_SHLIB_SCRIPT" ; then echo true ; else echo false ; fi`;
+  sort_flavors();
+}
+
+EOF
+fi
+
+if test x"$LDEMUL_SET_SYMBOLS" != xgld"$EMULATION_NAME"_set_symbols; then
+cat >>e${EMULATION_NAME}.c <<EOF
+static void
+gld${EMULATION_NAME}_set_symbols()
+{
+  if (link_info.strip == strip_all)
+    {
+      link_info.keep_hash = ((struct bfd_hash_table *)
+			     xmalloc (sizeof (struct bfd_hash_table)));
+
+      if (! bfd_hash_table_init (link_info.keep_hash, bfd_hash_newfunc))
+	einfo ("%P%F: bfd_hash_table_init failed: %E\n");
+
+      if (bfd_hash_lookup (link_info.keep_hash, "__amigappc__", true, true)
+	  == (struct bfd_hash_entry *) NULL)
+	einfo ("%P%F: bfd_hash_lookup for insertion failed: %E\n");
+
+      link_info.strip = strip_some;
+    }
+}
+EOF
+fi
+
+if test x"$LDEMUL_AFTER_OPEN" != xgld"$EMULATION_NAME"_after_open; then
+cat >>e${EMULATION_NAME}.c <<EOF
+
+/* This is called after all the input files have been opened.  */
+
+static void
+gld${EMULATION_NAME}_after_open ()
+{
+  struct bfd_link_needed_list *needed, *l;
+
+  /* We only need to worry about this when doing a final link.  */
+  if (link_info.relocateable || link_info.shared)
+    return;
+
+  /* Get the list of files which appear in DT_NEEDED entries in
+     dynamic objects included in the link (often there will be none).
+     For each such file, we want to track down the corresponding
+     library, and include the symbol table in the link.  This is what
+     the runtime dynamic linker will do.  Tracking the files down here
+     permits one dynamic object to include another without requiring
+     special action by the person doing the link.  Note that the
+     needed list can actually grow while we are stepping through this
+     loop.  */
+  needed = bfd_elf_get_needed_list (output_bfd, &link_info);
+  for (l = needed; l != NULL; l = l->next)
+    {
+      struct bfd_link_needed_list *ll;
+      int force = 0;
+
+      /* If we've already seen this file, skip it.  */
+      for (ll = needed; ll != l; ll = ll->next)
+	if (strcmp (ll->name, l->name) == 0)
+	  break;
+      if (ll != l)
+	continue;
+
+#if 0
+      /* See if this file was included in the link explicitly.  */
+      global_needed = l;
+      global_found = false;
+      lang_for_each_input_file (gld${EMULATION_NAME}_check_needed);
+      if (global_found)
+	continue;
+
+      if (trace_file_tries)
+	info_msg (_("%s needed by %B\n"), l->name, l->by);
+
+      /* We need to find this file and include the symbol table.  We
+	 want to search for the file in the same way that the dynamic
+	 linker will search.  That means that we want to use
+	 rpath_link, rpath, then the environment variable
+	 LD_LIBRARY_PATH (native only), then the DT_RPATH/DT_RUNPATH
+	 entries (native only), then the linker script LIB_SEARCH_DIRS.
+	 We do not search using the -L arguments.
+
+	 We search twice.  The first time, we skip objects which may
+	 introduce version mismatches.  The second time, we force
+	 their use.  See gld${EMULATION_NAME}_vercheck comment.  */
+      for (force = 0; force < 2; force++)
+	{
+	  size_t len;
+	  search_dirs_type *search;
+EOF
+if [ "x${host}" = "x${target}" ] ; then
+  case " ${EMULATION_LIBPATH} " in
+  *" ${EMULATION_NAME} "*)
+cat >>e${EMULATION_NAME}.c <<EOF
+	  const char *lib_path;
+	  struct bfd_link_needed_list *rp;
+	  int found;
+EOF
+  ;;
+  esac
+fi
+cat >>e${EMULATION_NAME}.c <<EOF
+
+	  if (gld${EMULATION_NAME}_search_needed (command_line.rpath_link,
+						  l->name, force))
+	    break;
+EOF
+if [ "x${host}" = "x${target}" ] ; then
+  case " ${EMULATION_LIBPATH} " in
+  *" ${EMULATION_NAME} "*)
+cat >>e${EMULATION_NAME}.c <<EOF
+	  if (gld${EMULATION_NAME}_search_needed (command_line.rpath,
+						  l->name, force))
+	    break;
+	  if (command_line.rpath_link == NULL
+	      && command_line.rpath == NULL)
+	    {
+	      lib_path = (const char *) getenv ("LD_RUN_PATH");
+	      if (gld${EMULATION_NAME}_search_needed (lib_path, l->name,
+						      force))
+		break;
+	    }
+	  lib_path = (const char *) getenv ("LD_LIBRARY_PATH");
+	  if (gld${EMULATION_NAME}_search_needed (lib_path, l->name, force))
+	    break;
+
+	  found = 0;
+	  rp = bfd_elf_get_runpath_list (output_bfd, &link_info);
+	  for (; !found && rp != NULL; rp = rp->next)
+	    {
+	      found = (rp->by == l->by
+		       && gld${EMULATION_NAME}_search_needed (rp->name,
+							      l->name,
+							      force));
+	    }
+	  if (found)
+	    break;
+
+EOF
+  ;;
+  esac
+fi
+cat >>e${EMULATION_NAME}.c <<EOF
+	  len = strlen (l->name);
+	  for (search = search_head; search != NULL; search = search->next)
+	    {
+	      char *filename;
+
+	      if (search->cmdline)
+		continue;
+	      filename = (char *) xmalloc (strlen (search->name) + len + 2);
+	      sprintf (filename, "%s/%s", search->name, l->name);
+	      if (gld${EMULATION_NAME}_try_needed (filename, force))
+		break;
+	      free (filename);
+	    }
+	  if (search != NULL)
+	    break;
+EOF
+if [ "x${host}" = "x${target}" ] ; then
+  case " ${EMULATION_LIBPATH} " in
+  *" ${EMULATION_NAME} "*)
+    case ${target} in
+      *-*-linux-gnu*)
+	cat >>e${EMULATION_NAME}.c <<EOF
+	  if (gld${EMULATION_NAME}_check_ld_so_conf (l->name, force))
+	    break;
+EOF
+	# Linux
+        ;;
+    esac
+  ;;
+  esac
+fi
+cat >>e${EMULATION_NAME}.c <<EOF
+	}
+#endif
+      if (force < 2)
+	continue;
+
+      einfo ("%P: warning: %s, needed by %B, not found (try using -rpath or -rpath-link)\n",
+	     l->name, l->by);
+    }
+}
+
+EOF
+fi
+
+
+if test x"$LDEMUL_BEFORE_ALLOCATION" != xgld"$EMULATION_NAME"_before_allocation; then
+  if test x"${ELF_INTERPRETER_NAME+set}" = xset; then
+    ELF_INTERPRETER_SET_DEFAULT="
+  if (sinterp != NULL)
+    {
+      sinterp->contents = ${ELF_INTERPRETER_NAME};
+      sinterp->_raw_size = strlen (sinterp->contents) + 1;
+    }
+
+"
+  else
+    ELF_INTERPRETER_SET_DEFAULT=
+  fi
+cat >>e${EMULATION_NAME}.c <<EOF
+
+/* This is called after the sections have been attached to output
+   sections, but before any sizes or addresses have been set.  */
+
+static void
+gld${EMULATION_NAME}_before_allocation ()
+{
+  const char *rpath;
+  asection *sinterp;
+
+  /* If we are going to make any variable assignments, we need to let
+     the ELF backend know about them in case the variables are
+     referred to by dynamic objects.  */
+  /*lang_for_each_statement (gld${EMULATION_NAME}_find_statement_assignment);*/
+
+  /* Add the data->data relocation table... */
+  if (morphos_resident)
+    {
+      asection *sec = bfd_make_section(output_bfd, "ddrelocs");
+      struct bfd_link_hash_entry *sym;
+
+      if (sec)
+	{
+	  bfd_set_section_flags(output_bfd, sec, SEC_ALLOC | SEC_LOAD | SEC_READONLY | 
+				SEC_DATA | SEC_HAS_CONTENTS);
+	  sec->output_section = sec;
+	  sec->output_offset = 0;
+	  sym = bfd_link_hash_lookup(link_info.hash, "__datadata_relocs", true, false, false);
+	  if (sym)
+	    {
+	      sym->type = bfd_link_hash_defined;
+	      sym->u.def.value = 0;
+	      sym->u.def.section = sec;
+	    }
+	}
+    }
+
+  /* Let the ELF backend work out the sizes of any sections required
+     by dynamic linking.  */
+  rpath = command_line.rpath;
+  /*if (rpath == NULL)
+    rpath = (const char *) getenv ("LD_RUN_PATH");*/
+  if (! (bfd_elf${ELFSIZE}_size_dynamic_sections
+         (output_bfd, command_line.soname, rpath,
+	  command_line.filter_shlib,
+	  (const char * const *) command_line.auxiliary_filters,
+	  &link_info, &sinterp, lang_elf_version_info)))
+    einfo ("%P%F: failed to set dynamic section sizes: %E\n");
+${ELF_INTERPRETER_SET_DEFAULT}
+  /* Let the user override the dynamic linker we are using.  */
+  if (command_line.interpreter != NULL
+      && sinterp != NULL)
+    {
+      sinterp->contents = (bfd_byte *) command_line.interpreter;
+      sinterp->_raw_size = strlen (command_line.interpreter) + 1;
+    }
+
+  /* Look for any sections named .gnu.warning.  As a GNU extensions,
+     we treat such sections as containing warning messages.  We print
+     out the warning message, and then zero out the section size so
+     that it does not get copied into the output file.  */
+
+  {
+    LANG_FOR_EACH_INPUT_STATEMENT (is)
+      {
+	asection *s;
+	bfd_size_type sz;
+	char *msg;
+	boolean ret;
+
+	if (is->just_syms_flag)
+	  continue;
+
+	s = bfd_get_section_by_name (is->the_bfd, ".gnu.warning");
+	if (s == NULL)
+	  continue;
+
+	sz = bfd_section_size (is->the_bfd, s);
+	msg = xmalloc ((size_t) sz + 1);
+	if (! bfd_get_section_contents (is->the_bfd, s, msg, (file_ptr) 0, sz))
+	  einfo ("%F%B: Can't read contents of section .gnu.warning: %E\n",
+		 is->the_bfd);
+	msg[sz] = '\0';
+	ret = link_info.callbacks->warning (&link_info, msg,
+					    (const char *) NULL,
+					    is->the_bfd, (asection *) NULL,
+					    (bfd_vma) 0);
+	ASSERT (ret);
+	free (msg);
+
+	/* Clobber the section size, so that we don't waste copying the
+	   warning into the output file.  */
+	s->_raw_size = 0;
+      }
+  }
+}
+
+EOF
+fi
+
+
+if test x"$LDEMUL_PLACE_ORPHAN" != xgld"$EMULATION_NAME"_place_orphan; then
+cat >>e${EMULATION_NAME}.c <<EOF
+
+/* A variant of lang_output_section_find.  Used by place_orphan.  */
+
+static lang_output_section_statement_type *
+output_rel_find (sec)
+     asection *sec;
+{
+  lang_statement_union_type *u;
+  lang_output_section_statement_type *lookup;
+  lang_output_section_statement_type *last = NULL;
+  lang_output_section_statement_type *last_rel = NULL;
+  lang_output_section_statement_type *last_rel_alloc = NULL;
+  int rela = sec->name[4] == 'a';
+
+  for (u = lang_output_section_statement.head; u; u = lookup->next)
+    {
+      lookup = &u->output_section_statement;
+      if (strncmp (".rel", lookup->name, 4) == 0)
+	{
+	  /* Don't place after .rel.plt as doing so results in wrong
+	     dynamic tags.  Also, place allocated reloc sections before
+	     non-allocated.  */
+	  int lookrela = lookup->name[4] == 'a';
+
+	  if (strcmp (".plt", lookup->name + 4 + lookrela) == 0
+	      || (lookup->bfd_section != NULL
+		  && (lookup->bfd_section->flags & SEC_ALLOC) == 0))
+	    break;
+	  last = lookup;
+	  if (rela == lookrela)
+	    last_rel = lookup;
+	  if (lookup->bfd_section != NULL
+	      && (lookup->bfd_section->flags & SEC_ALLOC) != 0)
+	    last_rel_alloc = lookup;
+	}
+    }
+
+  if (last_rel_alloc)
+    return last_rel_alloc;
+
+  if (last_rel)
+    return last_rel;
+
+  return last;
+}
+
+/* Find the last output section before given output statement.
+   Used by place_orphan.  */
+
+static asection *
+output_prev_sec_find (os)
+     lang_output_section_statement_type *os;
+{
+  asection *s = (asection *) NULL;
+  lang_statement_union_type *u;
+  lang_output_section_statement_type *lookup;
+
+  for (u = lang_output_section_statement.head;
+       u != (lang_statement_union_type *) NULL;
+       u = lookup->next)
+    {
+      lookup = &u->output_section_statement;
+      if (lookup == os)
+	return s;
+
+      if (lookup->bfd_section != NULL && lookup->bfd_section->owner != NULL)
+	s = lookup->bfd_section;
+    }
+
+  return NULL;
+}
+
+/* Place an orphan section.  We use this to put random SHF_ALLOC
+   sections in the right segment.  */
+
+struct orphan_save {
+  lang_output_section_statement_type *os;
+  asection **section;
+  lang_statement_union_type **stmt;
+};
+
+static boolean
+gld${EMULATION_NAME}_place_orphan (file, s)
+     lang_input_statement_type *file;
+     asection *s;
+{
+  static struct orphan_save hold_text;
+  static struct orphan_save hold_rodata;
+  static struct orphan_save hold_data;
+  static struct orphan_save hold_bss;
+  static struct orphan_save hold_rel;
+  static struct orphan_save hold_interp;
+  static struct orphan_save hold_sdata;
+  static int count = 1;
+  struct orphan_save *place;
+  lang_statement_list_type *old;
+  lang_statement_list_type add;
+  etree_type *address;
+  const char *secname;
+  const char *ps = NULL;
+  lang_output_section_statement_type *os;
+  int isdyn = 0;
+
+  secname = bfd_get_section_name (s->owner, s);
+  if (! link_info.relocateable
+      && link_info.combreloc
+      && (s->flags & SEC_ALLOC)
+      && strncmp (secname, ".rel", 4) == 0)
+    {
+      if (secname[4] == 'a')
+	secname = ".rela.dyn";
+      else
+	secname = ".rel.dyn";
+      isdyn = 1;
+    }
+
+  if (isdyn || (!config.unique_orphan_sections && !unique_section_p (secname)))
+    {
+      /* Look through the script to see where to place this section.  */
+      os = lang_output_section_find (secname);
+
+      if (os != NULL
+	  && (os->bfd_section == NULL
+	      || ((s->flags ^ os->bfd_section->flags)
+		  & (SEC_LOAD | SEC_ALLOC)) == 0))
+	{
+	  /* We already have an output section statement with this
+	     name, and its bfd section, if any, has compatible flags.  */
+	  lang_add_section (&os->children, s, os, file);
+	  return true;
+	}
+    }
+
+  if (hold_text.os == NULL)
+    hold_text.os = lang_output_section_find (".text");
+
+  /* If this is a final link, then always put .gnu.warning.SYMBOL
+     sections into the .text section to get them out of the way.  */
+  if (! link_info.shared
+      && ! link_info.relocateable
+      && strncmp (secname, ".gnu.warning.", sizeof ".gnu.warning." - 1) == 0
+      && hold_text.os != NULL)
+    {
+      lang_add_section (&hold_text.os->children, s, hold_text.os, file);
+      return true;
+    }
+
+  /* Decide which segment the section should go in based on the
+     section name and section flags.  We put loadable .note sections
+     right after the .interp section, so that the PT_NOTE segment is
+     stored right after the program headers where the OS can read it
+     in the first page.  */
+#define HAVE_SECTION(hold, name) \
+(hold.os != NULL || (hold.os = lang_output_section_find (name)) != NULL)
+
+  if ((s->flags & SEC_EXCLUDE) != 0 && !link_info.relocateable)
+    {
+      if (s->output_section == NULL)
+	s->output_section = bfd_abs_section_ptr;
+      return true;
+    }
+
+  place = NULL;
+  if ((s->flags & SEC_ALLOC) == 0)
+    ;
+  else if ((s->flags & SEC_LOAD) != 0
+	   && strncmp (secname, ".note", 5) == 0
+	   && HAVE_SECTION (hold_interp, ".interp"))
+    place = &hold_interp;
+  else if ((s->flags & SEC_HAS_CONTENTS) == 0
+	   && HAVE_SECTION (hold_bss, ".bss"))
+    place = &hold_bss;
+  else if ((s->flags & SEC_SMALL_DATA) != 0
+	   && HAVE_SECTION (hold_sdata, ".sdata"))
+    place = &hold_sdata;
+  else if ((s->flags & SEC_READONLY) == 0
+	   && HAVE_SECTION (hold_data, ".data"))
+    place = &hold_data;
+  else if (strncmp (secname, ".rel", 4) == 0
+	   && (s->flags & SEC_LOAD) != 0
+	   && (hold_rel.os != NULL
+	       || (hold_rel.os = output_rel_find (s)) != NULL))
+    place = &hold_rel;
+  else if ((s->flags & (SEC_CODE | SEC_READONLY)) == SEC_READONLY
+	   && HAVE_SECTION (hold_rodata, ".rodata"))
+    place = &hold_rodata;
+  else if ((s->flags & (SEC_CODE | SEC_READONLY)) == (SEC_CODE | SEC_READONLY)
+	   && hold_text.os != NULL)
+    place = &hold_text;
+
+#undef HAVE_SECTION
+
+  /* Choose a unique name for the section.  This will be needed if the
+     same section name appears in the input file with different
+     loadable or allocatable characteristics.  */
+  if (bfd_get_section_by_name (output_bfd, secname) != NULL)
+    {
+      secname = bfd_get_unique_section_name (output_bfd, secname, &count);
+      if (secname == NULL)
+	einfo ("%F%P: place_orphan failed: %E\n");
+    }
+
+  /* Start building a list of statements for this section.
+     First save the current statement pointer.  */
+  old = stat_ptr;
+
+  /* If we have found an appropriate place for the output section
+     statements for this orphan, add them to our own private list,
+     inserting them later into the global statement list.  */
+  if (place != NULL)
+    {
+      stat_ptr = &add;
+      lang_list_init (stat_ptr);
+    }
+
+  if (config.build_constructors)
+    {
+      /* If the name of the section is representable in C, then create
+	 symbols to mark the start and the end of the section.  */
+      for (ps = secname; *ps != '\0'; ps++)
+	if (! ISALNUM (*ps) && *ps != '_')
+	  break;
+      if (*ps == '\0')
+	{
+	  char *symname;
+	  etree_type *e_align;
+
+	  symname = (char *) xmalloc (ps - secname + sizeof "__start_");
+	  sprintf (symname, "__start_%s", secname);
+	  e_align = exp_unop (ALIGN_K,
+			      exp_intop ((bfd_vma) 1 << s->alignment_power));
+	  lang_add_assignment (exp_assop ('=', symname, e_align));
+	}
+    }
+
+  if (link_info.relocateable || (s->flags & (SEC_LOAD | SEC_ALLOC)) == 0)
+    address = exp_intop ((bfd_vma) 0);
+  else
+    address = NULL;
+
+  os = lang_enter_output_section_statement (secname, address, 0,
+					    (bfd_vma) 0,
+					    (etree_type *) NULL,
+					    (etree_type *) NULL,
+					    (etree_type *) NULL);
+
+  lang_add_section (&os->children, s, os, file);
+
+  lang_leave_output_section_statement
+    ((bfd_vma) 0, "*default*",
+     (struct lang_output_section_phdr_list *) NULL, NULL);
+
+  if (config.build_constructors && *ps == '\0')
+    {
+      char *symname;
+
+      /* lang_leave_ouput_section_statement resets stat_ptr.  Put
+	 stat_ptr back where we want it.  */
+      if (place != NULL)
+	stat_ptr = &add;
+
+      symname = (char *) xmalloc (ps - secname + sizeof "__stop_");
+      sprintf (symname, "__stop_%s", secname);
+      lang_add_assignment (exp_assop ('=', symname,
+				      exp_nameop (NAME, ".")));
+    }
+
+  /* Restore the global list pointer.  */
+  stat_ptr = old;
+
+  if (place != NULL && os->bfd_section != NULL)
+    {
+      asection *snew, **pps;
+
+      snew = os->bfd_section;
+
+      /* Shuffle the bfd section list to make the output file look
+	 neater.  This is really only cosmetic.  */
+      if (place->section == NULL)
+	{
+	  asection *bfd_section = place->os->bfd_section;
+
+	  /* If the output statement hasn't been used to place
+	     any input sections (and thus doesn't have an output
+	     bfd_section), look for the closest prior output statement
+	     having an output section.  */
+	  if (bfd_section == NULL)
+	    bfd_section = output_prev_sec_find (place->os);
+
+	  if (bfd_section != NULL && bfd_section != snew)
+	    place->section = &bfd_section->next;
+	}
+
+      if (place->section != NULL)
+	{
+	  /* Unlink the section.  */
+	  for (pps = &output_bfd->sections; *pps != snew; pps = &(*pps)->next)
+	    ;
+	  bfd_section_list_remove (output_bfd, pps);
+
+	  /* Now tack it on to the "place->os" section list.  */
+	  bfd_section_list_insert (output_bfd, place->section, snew);
+	}
+
+      /* Save the end of this list.  Further ophans of this type will
+	 follow the one we've just added.  */
+      place->section = &snew->next;
+
+      /* The following is non-cosmetic.  We try to put the output
+	 statements in some sort of reasonable order here, because
+	 they determine the final load addresses of the orphan
+	 sections.  In addition, placing output statements in the
+	 wrong order may require extra segments.  For instance,
+	 given a typical situation of all read-only sections placed
+	 in one segment and following that a segment containing all
+	 the read-write sections, we wouldn't want to place an orphan
+	 read/write section before or amongst the read-only ones.  */
+      if (add.head != NULL)
+	{
+	  if (place->stmt == NULL)
+	    {
+	      /* Put the new statement list right at the head.  */
+	      *add.tail = place->os->header.next;
+	      place->os->header.next = add.head;
+	    }
+	  else
+	    {
+	      /* Put it after the last orphan statement we added.  */
+	      *add.tail = *place->stmt;
+	      *place->stmt = add.head;
+	    }
+
+	  /* Fix the global list pointer if we happened to tack our
+	     new list at the tail.  */
+	  if (*old->tail == add.head)
+	    old->tail = add.tail;
+
+	  /* Save the end of this list.  */
+	  place->stmt = add.tail;
+	}
+    }
+
+  return true;
+}
+EOF
+fi
+
+if test x"$LDEMUL_FINISH" != xgld"$EMULATION_NAME"_finish; then
+cat >>e${EMULATION_NAME}.c <<EOF
+
+static void
+gld${EMULATION_NAME}_finish ()
+{
+  if (bfd_elf${ELFSIZE}_discard_info (output_bfd, &link_info))
+    {
+      lang_reset_memory_regions ();
+
+      /* Resize the sections.  */
+      lang_size_sections (stat_ptr->head, abs_output_section,
+			  &stat_ptr->head, 0, (bfd_vma) 0, NULL);
+
+      /* Redo special stuff.  */
+      ldemul_after_allocation ();
+
+      /* Do the assignments again.  */
+      lang_do_assignments (stat_ptr->head, abs_output_section,
+			   (fill_type *) 0, (bfd_vma) 0);
+    }
+}
+EOF
+fi
+
+if test x"$LDEMUL_GET_SCRIPT" != xgld"$EMULATION_NAME"_get_script; then
+cat >>e${EMULATION_NAME}.c <<EOF
+
+static char *
+gld${EMULATION_NAME}_get_script (isfile)
+     int *isfile;
+EOF
+
+if test -n "$COMPILE_IN"
+then
+# Scripts compiled in.
+
+# sed commands to quote an ld script as a C string.
+sc="-f stringify.sed"
+
+cat >>e${EMULATION_NAME}.c <<EOF
+{
+  *isfile = 0;
+
+  if (link_info.relocateable == true && config.build_constructors == true)
+    return
+EOF
+sed $sc ldscripts/${EMULATION_NAME}.xu                     >> e${EMULATION_NAME}.c
+echo '  ; else if (link_info.relocateable == true) return' >> e${EMULATION_NAME}.c
+sed $sc ldscripts/${EMULATION_NAME}.xr                     >> e${EMULATION_NAME}.c
+echo '  ; else return'                                     >> e${EMULATION_NAME}.c
+sed $sc ldscripts/${EMULATION_NAME}.x                      >> e${EMULATION_NAME}.c
+echo '; }'                                                 >> e${EMULATION_NAME}.c
+
+else
+# Scripts read from the filesystem.
+
+cat >>e${EMULATION_NAME}.c <<EOF
+{
+  *isfile = 1;
+
+  if (link_info.relocateable == true && config.build_constructors == true)
+    return "ldscripts/${EMULATION_NAME}.xu";
+  else if (link_info.relocateable == true)
+    return "ldscripts/${EMULATION_NAME}.xr";
+  else
+    return "ldscripts/${EMULATION_NAME}.x";
+}
+
+EOF
+fi
+fi
+
+if test -n "$PARSE_AND_LIST_ARGS_CASES" -o x"$GENERATE_SHLIB_SCRIPT" = xyes; then
+
+if test x"$LDEMUL_PARSE_ARGS" != xgld"$EMULATION_NAME"_parse_args; then
+
+if test -n "$PARSE_AND_LIST_PROLOGUE" ; then
+cat >>e${EMULATION_NAME}.c <<EOF
+ $PARSE_AND_LIST_PROLOGUE
+EOF
+fi
+
+cat >>e${EMULATION_NAME}.c <<EOF
+
+#include "getopt.h"
+
+#define OPTION_IGNORE (300)
+#define OPTION_MORPHOS_DATADATA_RELOC  (OPTION_IGNORE + 1)
+#define OPTION_MORPHOS_BASEREL32       (OPTION_IGNORE + 2)
+#define OPTION_FLAVOR                  (OPTION_IGNORE + 3)
+
+#define OPTION_DISABLE_NEW_DTAGS	(400)
+#define OPTION_ENABLE_NEW_DTAGS		(OPTION_DISABLE_NEW_DTAGS + 1)
+#define OPTION_GROUP			(OPTION_ENABLE_NEW_DTAGS + 1)
+#define OPTION_EH_FRAME_HDR		(OPTION_GROUP + 1)
+
+static struct option longopts[] =
+{
+  {"datadata-reloc", no_argument, NULL, OPTION_MORPHOS_DATADATA_RELOC},
+  /*    '\0', NULL, "Relocate for resident program", ONE_DASH },*/
+  {"flavor", required_argument, NULL, OPTION_FLAVOR},
+  /*'\0', NULL, "Select a library flavor", ONE_DASH },*/
+  /*{"baserel32", no_argument, NULL, OPTION_MORPHOS_BASEREL32},*/
+  /*    '\0', NULL, "Build a large-data base relative executable", ONE_DASH },*/
+EOF
+
+if test x"$GENERATE_SHLIB_SCRIPT" = xyes; then
+cat >>e${EMULATION_NAME}.c <<EOF
+  /* getopt allows abbreviations, so we do this to stop it from
+     treating -d/-e as abbreviations for these options. */
+  {"disable-new-dtags", no_argument, NULL, OPTION_DISABLE_NEW_DTAGS},
+  {"disable-new-dtags", no_argument, NULL, OPTION_DISABLE_NEW_DTAGS},
+  {"enable-new-dtags", no_argument, NULL, OPTION_ENABLE_NEW_DTAGS},
+  {"enable-new-dtags", no_argument, NULL, OPTION_ENABLE_NEW_DTAGS},
+  {"eh-frame-hdr", no_argument, NULL, OPTION_EH_FRAME_HDR},
+  {"Bgroup", no_argument, NULL, OPTION_GROUP},
+  {"Bgroup", no_argument, NULL, OPTION_GROUP},
+EOF
+fi
+
+if test -n "$PARSE_AND_LIST_LONGOPTS" ; then
+cat >>e${EMULATION_NAME}.c <<EOF
+ $PARSE_AND_LIST_LONGOPTS
+EOF
+fi
+
+cat >>e${EMULATION_NAME}.c <<EOF
+  {NULL, no_argument, NULL, 0}
+};
+
+
+static int gld${EMULATION_NAME}_parse_args PARAMS ((int, char **));
+
+static int
+gld${EMULATION_NAME}_parse_args (argc, argv)
+     int argc;
+     char ** argv;
+{
+  int longind;
+  int optc;
+  static int prevoptind = -1;
+  int prevopterr = opterr;
+  int wanterror;
+
+  if (prevoptind != optind)
+    opterr = 0;
+
+  wanterror = opterr;
+  prevoptind = optind;
+
+  optc = getopt_long_only (argc, argv,
+			   "-${PARSE_AND_LIST_SHORTOPTS}z:", longopts,
+			   &longind);
+  opterr = prevopterr;
+
+  switch (optc)
+    {
+    default:
+      if (wanterror)
+	xexit (1);
+      optind = prevoptind;
+      return 0;
+
+    case OPTION_MORPHOS_DATADATA_RELOC:
+      morphos_resident=1; /* Write out datadata_reloc array */
+      break;
+
+     /*case OPTION_MORPHOS_BASEREL32:
+      morphos_baserel32=1;
+      break;*/
+
+    case OPTION_FLAVOR:
+      ldfile_add_flavor (optarg);
+      break;
+EOF
+
+if test x"$GENERATE_SHLIB_SCRIPT" = xyes; then
+cat >>e${EMULATION_NAME}.c <<EOF
+    case OPTION_DISABLE_NEW_DTAGS:
+      link_info.new_dtags = false;
+      break;
+
+    case OPTION_ENABLE_NEW_DTAGS:
+      link_info.new_dtags = true;
+      break;
+
+    case OPTION_EH_FRAME_HDR:
+      link_info.eh_frame_hdr = true;
+      break;
+
+    case OPTION_GROUP:
+      link_info.flags_1 |= (bfd_vma) DF_1_GROUP;
+      /* Groups must be self-contained.  */
+      link_info.no_undefined = true;
+      break;
+
+    case 'z':
+      if (strcmp (optarg, "initfirst") == 0)
+	link_info.flags_1 |= (bfd_vma) DF_1_INITFIRST;
+      else if (strcmp (optarg, "interpose") == 0)
+	link_info.flags_1 |= (bfd_vma) DF_1_INTERPOSE;
+      else if (strcmp (optarg, "loadfltr") == 0)
+	link_info.flags_1 |= (bfd_vma) DF_1_LOADFLTR;
+      else if (strcmp (optarg, "nodefaultlib") == 0)
+	link_info.flags_1 |= (bfd_vma) DF_1_NODEFLIB;
+      else if (strcmp (optarg, "nodelete") == 0)
+	link_info.flags_1 |= (bfd_vma) DF_1_NODELETE;
+      else if (strcmp (optarg, "nodlopen") == 0)
+	link_info.flags_1 |= (bfd_vma) DF_1_NOOPEN;
+      else if (strcmp (optarg, "nodump") == 0)
+	link_info.flags_1 |= (bfd_vma) DF_1_NODUMP;
+      else if (strcmp (optarg, "now") == 0)
+	{
+	  link_info.flags |= (bfd_vma) DF_BIND_NOW;
+	  link_info.flags_1 |= (bfd_vma) DF_1_NOW;
+	}
+      else if (strcmp (optarg, "origin") == 0)
+	{
+	  link_info.flags |= (bfd_vma) DF_ORIGIN;
+	  link_info.flags_1 |= (bfd_vma) DF_1_ORIGIN;
+	}
+      else if (strcmp (optarg, "defs") == 0)
+	link_info.no_undefined = true;
+      else if (strcmp (optarg, "muldefs") == 0)
+	link_info.allow_multiple_definition = true;
+      else if (strcmp (optarg, "combreloc") == 0)
+	link_info.combreloc = true;
+      else if (strcmp (optarg, "nocombreloc") == 0)
+	link_info.combreloc = false;
+      else if (strcmp (optarg, "nocopyreloc") == 0)
+        link_info.nocopyreloc = true;
+      /* What about the other Solaris -z options? FIXME.  */
+      break;
+EOF
+fi
+
+if test -n "$PARSE_AND_LIST_ARGS_CASES" ; then
+cat >>e${EMULATION_NAME}.c <<EOF
+ $PARSE_AND_LIST_ARGS_CASES
+EOF
+fi
+
+cat >>e${EMULATION_NAME}.c <<EOF
+    }
+
+  return 1;
+}
+
+EOF
+fi
+
+if test x"$LDEMUL_LIST_OPTIONS" != xgld"$EMULATION_NAME"_list_options; then
+cat >>e${EMULATION_NAME}.c <<EOF
+
+static void gld${EMULATION_NAME}_list_options PARAMS ((FILE * file));
+
+static void
+gld${EMULATION_NAME}_list_options (file)
+     FILE * file;
+{
+EOF
+
+if test x"$GENERATE_SHLIB_SCRIPT" = xyes; then
+cat >>e${EMULATION_NAME}.c <<EOF
+  fprintf (file, _("  -Bgroup\t\tSelects group name lookup rules for DSO\n"));
+  fprintf (file, _("  --disable-new-dtags\tDisable new dynamic tags\n"));
+  fprintf (file, _("  --enable-new-dtags\tEnable new dynamic tags\n"));
+  fprintf (file, _("  --eh-frame-hdr\tCreate .eh_frame_hdr section\n"));
+  fprintf (file, _("  -z combreloc\t\tMerge dynamic relocs into one section and sort\n"));
+  fprintf (file, _("  -z defs\t\tDisallows undefined symbols\n"));
+  fprintf (file, _("  -z initfirst\t\tMark DSO to be initialized first at runtime\n"));
+  fprintf (file, _("  -z interpose\t\tMark object to interpose all DSOs but executable\n"));
+  fprintf (file, _("  -z loadfltr\t\tMark object requiring immediate process\n"));
+  fprintf (file, _("  -z muldefs\t\tAllow multiple definitions\n"));
+  fprintf (file, _("  -z nocombreloc\tDon't merge dynamic relocs into one section\n"));
+  fprintf (file, _("  -z nocopyreloc\tDon't create copy relocs\n"));
+  fprintf (file, _("  -z nodefaultlib\tMark object not to use default search paths\n"));
+  fprintf (file, _("  -z nodelete\t\tMark DSO non-deletable at runtime\n"));
+  fprintf (file, _("  -z nodlopen\t\tMark DSO not available to dlopen\n"));
+  fprintf (file, _("  -z nodump\t\tMark DSO not available to dldump\n"));
+  fprintf (file, _("  -z now\t\tMark object non-lazy runtime binding\n"));
+  fprintf (file, _("  -z origin\t\tMark object requiring immediate \$ORIGIN processing\n\t\t\t  at runtime\n"));
+  fprintf (file, _("  -z KEYWORD\t\tIgnored for Solaris compatibility\n"));
+EOF
+fi
+
+if test -n "$PARSE_AND_LIST_OPTIONS" ; then
+cat >>e${EMULATION_NAME}.c <<EOF
+ $PARSE_AND_LIST_OPTIONS
+EOF
+fi
+
+cat >>e${EMULATION_NAME}.c <<EOF
+}
+EOF
+
+if test -n "$PARSE_AND_LIST_EPILOGUE" ; then
+cat >>e${EMULATION_NAME}.c <<EOF
+ $PARSE_AND_LIST_EPILOGUE
+EOF
+fi
+fi
+else
+if test x"$LDEMUL_PARSE_ARGS" != xgld"$EMULATION_NAME"_parse_args; then
+cat >>e${EMULATION_NAME}.c <<EOF
+#define gld${EMULATION_NAME}_parse_args   NULL
+EOF
+fi
+if test x"$LDEMUL_LIST_OPTIONS" != xgld"$EMULATION_NAME"_list_options; then
+cat >>e${EMULATION_NAME}.c <<EOF
+#define gld${EMULATION_NAME}_list_options NULL
+EOF
+fi
+fi
+
+cat >>e${EMULATION_NAME}.c <<EOF
+
+struct ld_emulation_xfer_struct ld_${EMULATION_NAME}_emulation =
+{
+  ${LDEMUL_BEFORE_PARSE-gld${EMULATION_NAME}_before_parse},
+  ${LDEMUL_SYSLIB-syslib_default},
+  ${LDEMUL_HLL-hll_default},
+  ${LDEMUL_AFTER_PARSE-after_parse_default},
+  ${LDEMUL_AFTER_OPEN-gld${EMULATION_NAME}_after_open},
+  ${LDEMUL_AFTER_ALLOCATION-after_allocation_default},
+  ${LDEMUL_SET_OUTPUT_ARCH-set_output_arch_default},
+  ${LDEMUL_CHOOSE_TARGET-ldemul_default_target},
+  ${LDEMUL_BEFORE_ALLOCATION-gld${EMULATION_NAME}_before_allocation},
+  ${LDEMUL_GET_SCRIPT-gld${EMULATION_NAME}_get_script},
+  "${EMULATION_NAME}",
+  "${OUTPUT_FORMAT}",
+  ${LDEMUL_FINISH-gld${EMULATION_NAME}_finish},
+  ${LDEMUL_CREATE_OUTPUT_SECTION_STATEMENTS-NULL},
+  ${LDEMUL_OPEN_DYNAMIC_ARCHIVE-NULL},
+  ${LDEMUL_PLACE_ORPHAN-gld${EMULATION_NAME}_place_orphan},
+  ${LDEMUL_SET_SYMBOLS-gld${EMULATION_NAME}_set_symbols},
+  ${LDEMUL_PARSE_ARGS-gld${EMULATION_NAME}_parse_args},
+  ${LDEMUL_UNRECOGNIZED_FILE-NULL},
+  ${LDEMUL_LIST_OPTIONS-gld${EMULATION_NAME}_list_options},
+  ${LDEMUL_RECOGNIZED_FILE-NULL},
+  ${LDEMUL_FIND_POTENTIAL_LIBRARIES-NULL},
+  ${LDEMUL_NEW_VERS_PATTERN-NULL}
+};
+EOF
diff --git a/ld/emultempl/ppc32elf.em b/ld/emultempl/ppc32elf.em
index 6843770ca9431d7a4b698bfda7060082b215c41f..801d1d6424bc1f61bb0e7171de9f9b5178bc8100 100644
--- ld/emultempl/ppc32elf.em
+++ ld/emultempl/ppc32elf.em
@@ -26,12 +26,15 @@
 fragment <<EOF
 
 #include "libbfd.h"
 #include "elf32-ppc.h"
 #include "ldlex.h"
 
+extern int ppc_elf_amigaos_select_plt_layout (bfd *, struct bfd_link_info *,
+    enum ppc_elf_plt_type, int);
+
 #define is_ppc_elf(bfd) \
   (bfd_get_flavour (bfd) == bfd_target_elf_flavour \
    && elf_object_id (bfd) == PPC32_ELF_DATA)
 
 /* Whether to run tls optimization.  */
 static int notlsopt = 0;
@@ -56,14 +59,19 @@ ppc_after_open (void)
       lang_output_section_statement_type *os;
       lang_output_section_statement_type *plt_os[2];
       lang_output_section_statement_type *got_os[2];
 
       if (emit_stub_syms < 0)
 	emit_stub_syms = link_info.emitrelocations || link_info.shared;
+#ifdef TARGET_IS_amigaos
+      new_plt = ppc_elf_amigaos_select_plt_layout (link_info.output_bfd, &link_info,
+					   plt_style, emit_stub_syms);
+#else
       new_plt = ppc_elf_select_plt_layout (link_info.output_bfd, &link_info,
 					   plt_style, emit_stub_syms);
+#endif
       if (new_plt < 0)
 	einfo ("%X%P: select_plt_layout problem %E\n");
 
       num_got = 0;
       num_plt = 0;
       for (os = &lang_output_section_statement.head->output_section_statement;
@@ -185,12 +193,16 @@ PARSE_AND_LIST_PROLOGUE=${PARSE_AND_LIST_PROLOGUE}'
 #define OPTION_OLD_PLT			(OPTION_NEW_PLT + 1)
 #define OPTION_OLD_GOT			(OPTION_OLD_PLT + 1)
 #define OPTION_STUBSYMS			(OPTION_OLD_GOT + 1)
 #define OPTION_NO_STUBSYMS		(OPTION_STUBSYMS + 1)
 '
 
+#
+# CHECK: There was more here about use-dynld option.
+#
+
 PARSE_AND_LIST_LONGOPTS=${PARSE_AND_LIST_LONGOPTS}'
   { "emit-stub-syms", no_argument, NULL, OPTION_STUBSYMS },
   { "no-emit-stub-syms", no_argument, NULL, OPTION_NO_STUBSYMS },
   { "no-tls-optimize", no_argument, NULL, OPTION_NO_TLS_OPT },
   { "no-tls-get-addr-optimize", no_argument, NULL, OPTION_NO_TLS_GET_ADDR_OPT },
   { "secure-plt", no_argument, NULL, OPTION_NEW_PLT },
diff --git a/ld/ldctor.c b/ld/ldctor.c
index b29c1e0cbb13463f58989042722775698365cf9a..18d5f9370c7a0e9b009c74fdff48a4c45659245f 100644
--- ld/ldctor.c
+++ ld/ldctor.c
@@ -256,14 +256,18 @@ ldctor_build_sets (void)
       reloc_howto_type *howto;
       int reloc_size, size;
 
       /* If the symbol is defined, we may have been invoked from
 	 collect, and the sets may already have been built, so we do
 	 not do anything.  */
-      if (p->h->type == bfd_link_hash_defined
-	  || p->h->type == bfd_link_hash_defweak)
+      /* dgv -- libnix v1.1 uses absolute sets that are also explicitly
+	 defined in the library so that the sets need to be build even
+	 if the symbol is defined */
+      if ((bfd_get_flavour (link_info.output_bfd) != bfd_target_amiga_flavour) &&
+	  (p->h->type == bfd_link_hash_defined
+	  || p->h->type == bfd_link_hash_defweak))
 	continue;
 
       /* For each set we build:
 	   set:
 	     .long number_of_elements
 	     .long element0
@@ -353,21 +357,27 @@ ldctor_build_sets (void)
 		  print_space ();
 		  ++len;
 		}
 
 	      if (e->name != NULL)
 		minfo ("%T\n", e->name);
-	      else
+	      else if (e->section->owner)
 		minfo ("%G\n", e->section->owner, e->section, e->value);
+	      else
+		minfo ("%s\n", "** ABS **");
 	    }
 
 	  /* Need SEC_KEEP for --gc-sections.  */
 	  if (! bfd_is_abs_section (e->section))
 	    e->section->flags |= SEC_KEEP;
 
-	  if (link_info.relocatable)
+	  /* dgv -- on the amiga, we want the constructors to be relocateable
+	     objects. However, this should be arranged somewhere else (FIXME) */
+	  if (link_info.relocatable ||
+	      (bfd_get_flavour (link_info.output_bfd) == bfd_target_amiga_flavour &&
+	       e->section != bfd_abs_section_ptr))
 	    lang_add_reloc (p->reloc, howto, e->section, e->name,
 			    exp_intop (e->value));
 	  else
 	    lang_add_data (size, exp_relop (e->section, e->value));
 	}
 
diff --git a/ld/ldfile.c b/ld/ldfile.c
index e9091e9fa9ab0cb1182a102de48096ac13215a39..034eb2a7e452623f8c2571f4d6186b981c10c11d 100644
--- ld/ldfile.c
+++ ld/ldfile.c
@@ -63,12 +63,46 @@ typedef struct search_arch
 } search_arch_type;
 
 static search_dirs_type **search_tail_ptr = &search_head;
 static search_arch_type *search_arch_head;
 static search_arch_type **search_arch_tail_ptr = &search_arch_head;
 
+/* Flavour support.  */
+
+static int flavors_cmp PARAMS ((const void *f1, const void *f2));
+
+static int n_flavors, flavors_len;
+static char **flavors;
+
+static int
+flavors_cmp (f1, f2)
+     const void *f1, *f2;
+{
+  return strcmp (*(char **)f1, *(char **)f2);
+}
+
+void
+ldfile_sort_flavors ()
+{
+  if (n_flavors > 1)
+    qsort ((void *) flavors, n_flavors, sizeof (char **), flavors_cmp);
+}
+
+void
+ldfile_add_flavor (name)
+     const char *name;
+{
+  n_flavors++;
+  if (flavors)
+    flavors = (char **) xrealloc ((PTR)flavors, n_flavors * sizeof (char *));
+  else
+    flavors = (char **) xmalloc (sizeof (char *));
+  flavors [n_flavors-1] = (char *) name;
+  flavors_len += strlen (name);
+}
+
 /* Test whether a pathname, after canonicalization, is the same or a
    sub-directory of the sysroot directory.  */
 
 static bfd_boolean
 is_sysrooted_pathname (const char *name)
 {
@@ -332,12 +366,13 @@ success:
 bfd_boolean
 ldfile_open_file_search (const char *arch,
 			 lang_input_statement_type *entry,
 			 const char *lib,
 			 const char *suffix)
 {
+  char *flavor_dir = (char *) alloca (flavors_len + n_flavors + 1);
   search_dirs_type *search;
 
   /* If this is not an archive, try to open it in the current
      directory first.  */
   if (! entry->flags.maybe_archive)
     {
@@ -359,35 +394,50 @@ ldfile_open_file_search (const char *arch,
 	return FALSE;
     }
 
   for (search = search_head; search != NULL; search = search->next)
     {
       char *string;
+      int i, count;
 
       if (entry->flags.dynamic && ! link_info.relocatable)
 	{
 	  if (ldemul_open_dynamic_archive (arch, search, entry))
 	    return TRUE;
 	}
 
+  /* This is intentionally indented so strange to aid merging */
+  for (count=n_flavors; count>=0; count--)
+    {
+      *flavor_dir = '\0';
+      for (i=0; i<count; i++)
+	{
+	  strcat (flavor_dir, flavors[i]);
+	  strcat (flavor_dir, slash);
+	}
+
       if (entry->flags.maybe_archive)
-	string = concat (search->name, slash, lib, entry->filename,
+	string = concat (search->name, slash, flavor_dir, lib, entry->filename,
 			 arch, suffix, (const char *) NULL);
+      else if (entry->filename[0] == '/' || entry->filename[0] == '.')
+	string = concat(entry->filename, NULL);
       else
-	string = concat (search->name, slash, entry->filename,
+	string = concat (search->name, slash, flavor_dir, entry->filename,
 			 (const char *) 0);
 
       if (ldfile_try_open_bfd (string, entry))
 	{
 	  entry->filename = string;
 	  return TRUE;
 	}
 
       free (string);
     }
 
+    }
+
   return FALSE;
 }
 
 /* Open the input file specified by ENTRY.
    PR 4437: Do not stop on the first missing file, but
    continue processing other input files in case there
diff --git a/ld/ldfile.h b/ld/ldfile.h
index 945609250afc6fede2985dbdd59bf035cb835843..530fb0f3b78f7ce54421b074bea4fcd5ae28022d 100644
--- ld/ldfile.h
+++ ld/ldfile.h
@@ -56,7 +56,12 @@ extern bfd_boolean ldfile_try_open_bfd
 extern void ldfile_set_output_arch
   (const char *, enum bfd_architecture);
 extern bfd_boolean ldfile_open_file_search
   (const char *arch, struct lang_input_statement_struct *,
    const char *lib, const char *suffix);
 
+extern void ldfile_sort_flavors
+  PARAMS ((void));
+extern void ldfile_add_flavor
+  PARAMS ((const char *));
+
 #endif
diff --git a/ld/ldlang.c b/ld/ldlang.c
index 459f277a3ea5baa2f38e7b95db0ac9ef67d648b8..d199cda1fd9bd4d8bfa12fe72a44501861ffe1ff 100644
--- ld/ldlang.c
+++ ld/ldlang.c
@@ -3389,12 +3389,19 @@ typedef struct bfd_sym_chain ldlang_undef_chain_list_type;
 
 #define ldlang_undef_chain_list_head entry_symbol.next
 
 void
 ldlang_add_undef (const char *const name, bfd_boolean cmdline)
 {
+#if 1
+  /* This is a quick ugly hak of getting around the problem
+   * with -use-dynld being passed to the linker
+   */
+  if (strcmp(name, "se-dynld") == 0)
+    return;
+#endif
   ldlang_undef_chain_list_type *new_undef;
 
   undef_from_cmdline = undef_from_cmdline || cmdline;
   new_undef = (ldlang_undef_chain_list_type *) stat_alloc (sizeof (*new_undef));
   new_undef->next = ldlang_undef_chain_list_head;
   ldlang_undef_chain_list_head = new_undef;
diff --git a/ld/ldlang.h b/ld/ldlang.h
index d5ea8d20e34c9c4697d0aa14b4af09d2df8f0d20..f6f061dfe6e92cdb3a5097baf644773cc402ad3f 100644
--- ld/ldlang.h
+++ ld/ldlang.h
@@ -302,12 +302,14 @@ typedef struct lang_input_statement_struct
   /* Point to the next file, but skips archive contents.  */
   union lang_statement_union *next_real_file;
 
   const char *target;
 
   struct lang_input_statement_flags flags;
+  /* Added for AMIGA support of section attributes */
+  int amiga_attribute;
 } lang_input_statement_type;
 
 typedef struct
 {
   lang_statement_header_type header;
   asection *section;
diff --git a/ld/ldlex.c b/ld/ldlex.c
index 50bb3b1e14133555e524ad059d7b578cfaac6b24..eb7e21a7741a0fc82b72f2c7e3d88d1888998db8 100644
--- ld/ldlex.c
+++ ld/ldlex.c
@@ -1,17 +1,17 @@
 
-#line 3 "ldlex.c"
+#line 3 "/home/sba/amiga/adtools/branches/binutils/2.23.2/ld/ldlex.c"
 
 #define  YY_INT_ALIGNED short int
 
 /* A lexical scanner generated by flex */
 
 #define FLEX_SCANNER
 #define YY_FLEX_MAJOR_VERSION 2
 #define YY_FLEX_MINOR_VERSION 5
-#define YY_FLEX_SUBMINOR_VERSION 35
+#define YY_FLEX_SUBMINOR_VERSION 39
 #if YY_FLEX_SUBMINOR_VERSION > 0
 #define FLEX_BETA
 #endif
 
 /* First, we deal with  platform-specific or compiler-specific issues. */
 
@@ -50,13 +50,12 @@ typedef uint32_t flex_uint32_t;
 typedef signed char flex_int8_t;
 typedef short int flex_int16_t;
 typedef int flex_int32_t;
 typedef unsigned char flex_uint8_t; 
 typedef unsigned short int flex_uint16_t;
 typedef unsigned int flex_uint32_t;
-#endif /* ! C99 */
 
 /* Limits of integral types. */
 #ifndef INT8_MIN
 #define INT8_MIN               (-128)
 #endif
 #ifndef INT16_MIN
@@ -81,12 +80,14 @@ typedef unsigned int flex_uint32_t;
 #define UINT16_MAX             (65535U)
 #endif
 #ifndef UINT32_MAX
 #define UINT32_MAX             (4294967295U)
 #endif
 
+#endif /* ! C99 */
+
 #endif /* ! FLEXINT_H */
 
 #ifdef __cplusplus
 
 /* The "const" storage-class-modifier is valid. */
 #define YY_USE_CONST
@@ -137,33 +138,47 @@ typedef unsigned int flex_uint32_t;
 #define YY_NEW_FILE yyrestart(yyin  )
 
 #define YY_END_OF_BUFFER_CHAR 0
 
 /* Size of default input buffer. */
 #ifndef YY_BUF_SIZE
+#ifdef __ia64__
+/* On IA-64, the buffer size is 16k, not 8k.
+ * Moreover, YY_BUF_SIZE is 2*YY_READ_BUF_SIZE in the general case.
+ * Ditto for the __ia64__ case accordingly.
+ */
+#define YY_BUF_SIZE 32768
+#else
 #define YY_BUF_SIZE 16384
+#endif /* __ia64__ */
 #endif
 
 /* The state buf must be large enough to hold one state per character in the main buffer.
  */
 #define YY_STATE_BUF_SIZE   ((YY_BUF_SIZE + 2) * sizeof(yy_state_type))
 
 #ifndef YY_TYPEDEF_YY_BUFFER_STATE
 #define YY_TYPEDEF_YY_BUFFER_STATE
 typedef struct yy_buffer_state *YY_BUFFER_STATE;
 #endif
 
-extern int yyleng;
+#ifndef YY_TYPEDEF_YY_SIZE_T
+#define YY_TYPEDEF_YY_SIZE_T
+typedef size_t yy_size_t;
+#endif
+
+extern yy_size_t yyleng;
 
 extern FILE *yyin, *yyout;
 
 #define EOB_ACT_CONTINUE_SCAN 0
 #define EOB_ACT_END_OF_FILE 1
 #define EOB_ACT_LAST_MATCH 2
 
     #define YY_LESS_LINENO(n)
+    #define YY_LINENO_REWIND_TO(ptr)
     
 /* Return all but the first "n" matched characters back to the input stream. */
 #define yyless(n) \
 	do \
 		{ \
 		/* Undo effects of setting up yytext. */ \
@@ -175,17 +190,12 @@ extern FILE *yyin, *yyout;
 		YY_DO_BEFORE_ACTION; /* set up yytext again */ \
 		} \
 	while ( 0 )
 
 #define unput(c) yyunput( c, (yytext_ptr)  )
 
-#ifndef YY_TYPEDEF_YY_SIZE_T
-#define YY_TYPEDEF_YY_SIZE_T
-typedef size_t yy_size_t;
-#endif
-
 #ifndef YY_STRUCT_YY_BUFFER_STATE
 #define YY_STRUCT_YY_BUFFER_STATE
 struct yy_buffer_state
 	{
 	FILE *yy_input_file;
 
@@ -197,13 +207,13 @@ struct yy_buffer_state
 	 */
 	yy_size_t yy_buf_size;
 
 	/* Number of characters read into yy_ch_buf, not including EOB
 	 * characters.
 	 */
-	int yy_n_chars;
+	yy_size_t yy_n_chars;
 
 	/* Whether we "own" the buffer - i.e., we know we created it,
 	 * and can realloc() it to grow it, and should free() it to
 	 * delete it.
 	 */
 	int yy_is_our_buffer;
@@ -267,14 +277,14 @@ static YY_BUFFER_STATE * yy_buffer_stack = 0; /**< Stack as an array. */
  * NULL or when we need an lvalue. For internal use only.
  */
 #define YY_CURRENT_BUFFER_LVALUE (yy_buffer_stack)[(yy_buffer_stack_top)]
 
 /* yy_hold_char holds the character lost when yytext is formed. */
 static char yy_hold_char;
-static int yy_n_chars;		/* number of characters read into yy_ch_buf */
-int yyleng;
+static yy_size_t yy_n_chars;		/* number of characters read into yy_ch_buf */
+yy_size_t yyleng;
 
 /* Points to current character in buffer. */
 static char *yy_c_buf_p = (char *) 0;
 static int yy_init = 0;		/* whether we need to initialize */
 static int yy_start = 0;	/* start state number */
 
@@ -296,13 +306,13 @@ static void yy_load_buffer_state (void );
 static void yy_init_buffer (YY_BUFFER_STATE b,FILE *file  );
 
 #define YY_FLUSH_BUFFER yy_flush_buffer(YY_CURRENT_BUFFER )
 
 YY_BUFFER_STATE yy_scan_buffer (char *base,yy_size_t size  );
 YY_BUFFER_STATE yy_scan_string (yyconst char *yy_str  );
-YY_BUFFER_STATE yy_scan_bytes (yyconst char *bytes,int len  );
+YY_BUFFER_STATE yy_scan_bytes (yyconst char *bytes,yy_size_t len  );
 
 void *yyalloc (yy_size_t  );
 void *yyrealloc (void *,yy_size_t  );
 void yyfree (void *  );
 
 #define yy_new_buffer yy_create_buffer
@@ -1711,13 +1721,13 @@ int yywrap (void) { return 1; }
 
 
 
 
 
 
-#line 1718 "ldlex.c"
+#line 1728 "/home/sba/amiga/adtools/branches/binutils/2.23.2/ld/ldlex.c"
 
 #define INITIAL 0
 #define SCRIPT 1
 #define EXPRESSION 2
 #define BOTH 3
 #define DEFSYMEXP 4
@@ -1758,13 +1768,13 @@ FILE *yyget_in (void );
 void yyset_in  (FILE * in_str  );
 
 FILE *yyget_out (void );
 
 void yyset_out  (FILE * out_str  );
 
-int yyget_leng (void );
+yy_size_t yyget_leng (void );
 
 char *yyget_text (void );
 
 int yyget_lineno (void );
 
 void yyset_lineno (int line_number  );
@@ -1798,32 +1808,37 @@ static int input (void );
 #endif
 
 #endif
 
 /* Amount of stuff to slurp up with each read. */
 #ifndef YY_READ_BUF_SIZE
+#ifdef __ia64__
+/* On IA-64, the buffer size is 16k, not 8k */
+#define YY_READ_BUF_SIZE 16384
+#else
 #define YY_READ_BUF_SIZE 8192
+#endif /* __ia64__ */
 #endif
 
 /* Copy whatever the last rule matched to the standard output. */
 #ifndef ECHO
 /* This used to be an fputs(), but since the string might contain NUL's,
  * we now use fwrite().
  */
-#define ECHO fwrite( yytext, yyleng, 1, yyout )
+#define ECHO do { if (fwrite( yytext, yyleng, 1, yyout )) {} } while (0)
 #endif
 
 /* Gets input and stuffs it into "buf".  number of characters read, or YY_NULL,
  * is returned in "result".
  */
 #ifndef YY_INPUT
 #define YY_INPUT(buf,result,max_size) \
 	if ( YY_CURRENT_BUFFER_LVALUE->yy_is_interactive ) \
 		{ \
 		int c = '*'; \
-		yy_size_t n; \
+		size_t n; \
 		for ( n = 0; n < max_size && \
 			     (c = getc( yyin )) != EOF && c != '\n'; ++n ) \
 			buf[n] = (char) c; \
 		if ( c == '\n' ) \
 			buf[n++] = (char) c; \
 		if ( c == EOF && ferror( yyin ) ) \
@@ -1899,33 +1914,12 @@ extern int yylex (void);
 YY_DECL
 {
 	register yy_state_type yy_current_state;
 	register char *yy_cp, *yy_bp;
 	register int yy_act;
     
-#line 121 "ldlex.l"
-
-
-  if (parser_input != input_selected)
-    {
-      /* The first token of the input determines the initial parser state.  */
-      input_type t = parser_input;
-      parser_input = input_selected;
-      switch (t)
-	{
-	case input_script: return INPUT_SCRIPT; break;
-	case input_mri_script: return INPUT_MRI_SCRIPT; break;
-	case input_version_script: return INPUT_VERSION_SCRIPT; break;
-	case input_dynamic_list: return INPUT_DYNAMIC_LIST; break;
-	case input_defsym: return INPUT_DEFSYM; break;
-	default: abort ();
-	}
-    }
-
-#line 1925 "ldlex.c"
-
 	if ( !(yy_init) )
 		{
 		(yy_init) = 1;
 
 #ifdef YY_USER_INIT
 		YY_USER_INIT;
@@ -1946,12 +1940,34 @@ YY_DECL
 				yy_create_buffer(yyin,YY_BUF_SIZE );
 		}
 
 		yy_load_buffer_state( );
 		}
 
+	{
+#line 121 "ldlex.l"
+
+
+  if (parser_input != input_selected)
+    {
+      /* The first token of the input determines the initial parser state.  */
+      input_type t = parser_input;
+      parser_input = input_selected;
+      switch (t)
+	{
+	case input_script: return INPUT_SCRIPT; break;
+	case input_mri_script: return INPUT_MRI_SCRIPT; break;
+	case input_version_script: return INPUT_VERSION_SCRIPT; break;
+	case input_dynamic_list: return INPUT_DYNAMIC_LIST; break;
+	case input_defsym: return INPUT_DEFSYM; break;
+	default: abort ();
+	}
+    }
+
+#line 1967 "/home/sba/amiga/adtools/branches/binutils/2.23.2/ld/ldlex.c"
+
 	while ( 1 )		/* loops until end-of-file is reached */
 		{
 		yy_cp = (yy_c_buf_p);
 
 		/* Support of yytext. */
 		*yy_cp = (yy_hold_char);
@@ -1962,13 +1978,13 @@ YY_DECL
 		yy_bp = yy_cp;
 
 		yy_current_state = (yy_start);
 yy_match:
 		do
 			{
-			register YY_CHAR yy_c = yy_ec[YY_SC_TO_UI(*yy_cp)];
+			register YY_CHAR yy_c = yy_ec[YY_SC_TO_UI(*yy_cp)] ;
 			if ( yy_accept[yy_current_state] )
 				{
 				(yy_last_accepting_state) = yy_current_state;
 				(yy_last_accepting_cpos) = yy_cp;
 				}
 			while ( yy_chk[yy_base[yy_current_state] + yy_c] != yy_current_state )
@@ -3105,13 +3121,13 @@ lex_warn_invalid (" in expression", yytext);
 	YY_BREAK
 case 195:
 YY_RULE_SETUP
 #line 468 "ldlex.l"
 ECHO;
 	YY_BREAK
-#line 3112 "ldlex.c"
+#line 3128 "/home/sba/amiga/adtools/branches/binutils/2.23.2/ld/ldlex.c"
 
 	case YY_END_OF_BUFFER:
 		{
 		/* Amount of text matched not including the EOB char. */
 		int yy_amount_of_matched_text = (int) (yy_cp - (yytext_ptr)) - 1;
 
@@ -3234,12 +3250,13 @@ ECHO;
 
 	default:
 		YY_FATAL_ERROR(
 			"fatal flex scanner internal error--no action found" );
 	} /* end of action switch */
 		} /* end of scanning one token */
+	} /* end of user's declarations */
 } /* end of yylex */
 
 /* yy_get_next_buffer - try to read in a new buffer
  *
  * Returns a code representing an action:
  *	EOB_ACT_LAST_MATCH -
@@ -3289,27 +3306,27 @@ static int yy_get_next_buffer (void)
 		 * just force an EOF
 		 */
 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars) = 0;
 
 	else
 		{
-			int num_to_read =
+			yy_size_t num_to_read =
 			YY_CURRENT_BUFFER_LVALUE->yy_buf_size - number_to_move - 1;
 
 		while ( num_to_read <= 0 )
 			{ /* Not enough room in the buffer - grow it. */
 
 			/* just a shorter name for the current buffer */
-			YY_BUFFER_STATE b = YY_CURRENT_BUFFER;
+			YY_BUFFER_STATE b = YY_CURRENT_BUFFER_LVALUE;
 
 			int yy_c_buf_p_offset =
 				(int) ((yy_c_buf_p) - b->yy_ch_buf);
 
 			if ( b->yy_is_our_buffer )
 				{
-				int new_size = b->yy_buf_size * 2;
+				yy_size_t new_size = b->yy_buf_size * 2;
 
 				if ( new_size <= 0 )
 					b->yy_buf_size += b->yy_buf_size / 8;
 				else
 					b->yy_buf_size *= 2;
 
@@ -3334,13 +3351,13 @@ static int yy_get_next_buffer (void)
 
 		if ( num_to_read > YY_READ_BUF_SIZE )
 			num_to_read = YY_READ_BUF_SIZE;
 
 		/* Read in more data. */
 		YY_INPUT( (&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move]),
-			(yy_n_chars), (size_t) num_to_read );
+			(yy_n_chars), num_to_read );
 
 		YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars);
 		}
 
 	if ( (yy_n_chars) == 0 )
 		{
@@ -3429,13 +3446,13 @@ static int yy_get_next_buffer (void)
 		if ( yy_current_state >= 1706 )
 			yy_c = yy_meta[(unsigned int) yy_c];
 		}
 	yy_current_state = yy_nxt[yy_base[yy_current_state] + (unsigned int) yy_c];
 	yy_is_jam = (yy_current_state == 1705);
 
-	return yy_is_jam ? 0 : yy_current_state;
+		return yy_is_jam ? 0 : yy_current_state;
 }
 
 #ifndef YY_NO_INPUT
 #ifdef __cplusplus
     static int yyinput (void)
 #else
@@ -3456,13 +3473,13 @@ static int yy_get_next_buffer (void)
 		if ( (yy_c_buf_p) < &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] )
 			/* This was really a NUL. */
 			*(yy_c_buf_p) = '\0';
 
 		else
 			{ /* need more input */
-			int offset = (yy_c_buf_p) - (yytext_ptr);
+			yy_size_t offset = (yy_c_buf_p) - (yytext_ptr);
 			++(yy_c_buf_p);
 
 			switch ( yy_get_next_buffer(  ) )
 				{
 				case EOB_ACT_LAST_MATCH:
 					/* This happens because yy_g_n_b()
@@ -3616,16 +3633,12 @@ static void yy_load_buffer_state  (void)
 	if ( b->yy_is_our_buffer )
 		yyfree((void *) b->yy_ch_buf  );
 
 	yyfree((void *) b  );
 }
 
-#ifndef __cplusplus
-extern int isatty (int );
-#endif /* __cplusplus */
-    
 /* Initializes or reinitializes a buffer.
  * This function is sometimes called more than once on the same buffer,
  * such as during a yyrestart() or at EOF.
  */
     static void yy_init_buffer  (YY_BUFFER_STATE  b, FILE * file )
 
@@ -3732,13 +3745,13 @@ void yypop_buffer_state (void)
 
 /* Allocates the stack if it does not exist.
  *  Guarantees space for at least one push.
  */
 static void yyensure_buffer_stack (void)
 {
-	int num_to_alloc;
+	yy_size_t num_to_alloc;
     
 	if (!(yy_buffer_stack)) {
 
 		/* First allocation is just for 2 elements, since we don't know if this
 		 * scanner will even need a stack. We use 2 instead of 1 to avoid an
 		 * immediate realloc on the next call.
@@ -3824,23 +3837,23 @@ YY_BUFFER_STATE yy_scan_string (yyconst char * yystr )
     
 	return yy_scan_bytes(yystr,strlen(yystr) );
 }
 
 /** Setup the input buffer state to scan the given bytes. The next call to yylex() will
  * scan from a @e copy of @a bytes.
- * @param bytes the byte buffer to scan
- * @param len the number of bytes in the buffer pointed to by @a bytes.
+ * @param yybytes the byte buffer to scan
+ * @param _yybytes_len the number of bytes in the buffer pointed to by @a bytes.
  * 
  * @return the newly allocated buffer state object.
  */
-YY_BUFFER_STATE yy_scan_bytes  (yyconst char * yybytes, int  _yybytes_len )
+YY_BUFFER_STATE yy_scan_bytes  (yyconst char * yybytes, yy_size_t  _yybytes_len )
 {
 	YY_BUFFER_STATE b;
 	char *buf;
 	yy_size_t n;
-	int i;
+	yy_size_t i;
     
 	/* Get memory for full buffer, including space for trailing EOB's. */
 	n = _yybytes_len + 2;
 	buf = (char *) yyalloc(n  );
 	if ( ! buf )
 		YY_FATAL_ERROR( "out of dynamic memory in yy_scan_bytes()" );
@@ -3916,13 +3929,13 @@ FILE *yyget_out  (void)
         return yyout;
 }
 
 /** Get the length of the current token.
  * 
  */
-int yyget_leng  (void)
+yy_size_t yyget_leng  (void)
 {
         return yyleng;
 }
 
 /** Get the current token.
  * 
@@ -4064,13 +4077,13 @@ void yyfree (void * ptr )
 {
 	free( (char *) ptr );	/* see yyrealloc() for (char *) cast */
 }
 
 #define YYTABLES_NAME "yytables"
 
-#line 468 "ldlex.l"
+#line 467 "ldlex.l"
 
 
 
 
 /* Switch flex to reading script file NAME, open on FILE,
    saving the current input info on the include stack.  */
diff --git a/ld/ldmain.c b/ld/ldmain.c
index 73353309c3595a2e53e160cbf2bcfd215a92aab2..8b7513d8e83264c0cb236781cdb753181612fb14 100644
--- ld/ldmain.c
+++ ld/ldmain.c
@@ -408,16 +408,23 @@ main (int argc, char **argv)
     }
 
   lang_process ();
 
   /* Print error messages for any missing symbols, for any warning
      symbols, and possibly multiple definitions.  */
+#ifdef __amigaos4__
+  /* Make all files executable, even relocatable files */
+    link_info.output_bfd->flags |= EXEC_P;
+#else
+  /* Print error messages for any missing symbols, for any warning
+     symbols, and possibly multiple definitions.  */
   if (link_info.relocatable)
     link_info.output_bfd->flags &= ~EXEC_P;
   else
     link_info.output_bfd->flags |= EXEC_P;
+#endif
 
   ldwrite ();
 
   if (config.map_file != NULL)
     lang_map ();
   if (command_line.cref)
diff --git a/ld/scripttempl/amiga.sc b/ld/scripttempl/amiga.sc
new file mode 100644
index 0000000000000000000000000000000000000000..f5c9d694742ecabb3a2a9c6b85e8f2aaf23e78f1
--- /dev/null
+++ ld/scripttempl/amiga.sc
@@ -0,0 +1,49 @@
+cat <<EOF
+OUTPUT_FORMAT("${OUTPUT_FORMAT}")
+OUTPUT_ARCH(${ARCH})
+
+${RELOCATING+${LIB_SEARCH_DIRS}}
+${STACKZERO+${RELOCATING+${STACKZERO}}}
+${SHLIB_PATH+${RELOCATING+${SHLIB_PATH}}}
+
+SECTIONS
+{
+  ${RELOCATING+PROVIDE(___machtype = 0x0);}
+  ${RELOCATING+. = ${TEXT_START_ADDR};}
+  .text :
+  {
+    ${RELOCATING+__stext = .;}
+    *(.text)
+    ${RELOCATING+___datadata_relocs = .;}
+    ${RELOCATING+__etext = .;}
+    ${PAD_TEXT+${RELOCATING+. = ${DATA_ALIGNMENT};}}
+  }
+  ${RELOCATING+___text_size = SIZEOF(.text);}
+  ${RELOCATING+. = ${DATA_ALIGNMENT};}
+  .data :
+  {
+    ${RELOCATING+__sdata = .;}
+    ${CONSTRUCTING+CONSTRUCTORS}
+    *(.data)
+    ${RELOCATING+___a4_init = 0x7ffe;}
+    ${RELOCATING+__edata = .;}
+  }
+  ${RELOCATING+___data_size = SIZEOF(.data);}
+  .bss :
+  {
+    ${RELOCATING+__bss_start = .;}
+    *(.bss)
+    *(COMMON)
+    ${RELOCATING+__end = .;}
+  }
+  ${RELOCATING+___bss_size = SIZEOF(.bss);}
+  .data_chip :
+  {
+    *(.data_chip)
+  }
+  .bss_chip :
+  {
+    *(.bss_chip)
+  }
+}
+EOF
diff --git a/ld/scripttempl/amiga_bss.sc b/ld/scripttempl/amiga_bss.sc
new file mode 100644
index 0000000000000000000000000000000000000000..668ce7c0dee923dd0d4643a379bf24f4b352cef0
--- /dev/null
+++ ld/scripttempl/amiga_bss.sc
@@ -0,0 +1,41 @@
+cat <<EOF
+OUTPUT_FORMAT("${OUTPUT_FORMAT}")
+OUTPUT_ARCH(${ARCH})
+
+${RELOCATING+${LIB_SEARCH_DIRS}}
+${STACKZERO+${RELOCATING+${STACKZERO}}}
+${SHLIB_PATH+${RELOCATING+${SHLIB_PATH}}}
+
+SECTIONS
+{
+  ${RELOCATING+PROVIDE(___machtype = 0x0);}
+  ${RELOCATING+. = ${TEXT_START_ADDR};}
+  .text :
+  {
+    ${RELOCATING+__stext = .;}
+    *(.text)
+    ${RELOCATING+___datadata_relocs = .;}
+    ${RELOCATING+__etext = .;}
+    ${PAD_TEXT+${RELOCATING+. = ${DATA_ALIGNMENT};}}
+  }
+  ${RELOCATING+___text_size = SIZEOF(.text);}
+  ${RELOCATING+. = ${DATA_ALIGNMENT};}
+  .data :
+  {
+    ${RELOCATING+__sdata = .;}
+    ${CONSTRUCTING+CONSTRUCTORS}
+    *(.data)
+    ${RELOCATING+___a4_init = 0x7ffe;}
+    ${RELOCATING+__edata = .;}
+  }
+  .bss :
+  {
+    ${RELOCATING+__bss_start = .;}
+    *(.bss)
+    *(COMMON)
+    ${RELOCATING+__end = .;}
+  }
+  ${RELOCATING+___data_size = SIZEOF(.data) + SIZEOF(.bss);}
+  ${RELOCATING+___bss_size = 0x0;}
+}
+EOF
diff --git a/ld/scripttempl/elf64hppa.sc b/ld/scripttempl/amigaos.sc
similarity index 88%
copy from ld/scripttempl/elf64hppa.sc
copy to ld/scripttempl/amigaos.sc
index 18090e6b9b73969ba6c33ccb272d88fc125be19d..865c9ba63ca1746c6bc6b66153557a10da677e58 100644
--- ld/scripttempl/elf64hppa.sc
+++ ld/scripttempl/amigaos.sc
@@ -33,17 +33,14 @@
 #	OTHER_SDATA_SECTIONS - sections just after .sdata.
 #	OTHER_BSS_SYMBOLS - symbols that appear at the start of the
 #		.bss section besides __bss_start.
 #	DATA_PLT - .plt should be in data segment, not text segment.
 #	PLT_BEFORE_GOT - .plt just before .got when .plt is in data segement.
 #	BSS_PLT - .plt should be in bss segment
-#	NO_REL_RELOCS - Don't include .rel.* sections in script
-#	NO_RELA_RELOCS - Don't include .rela.* sections in script
-#	NON_ALLOC_DYN - Place dynamic sections after data segment.
 #	TEXT_DYNAMIC - .dynamic in text segment, not data segment.
-#	EMBEDDED - whether this is for an embedded system. 
+#	EMBEDDED - whether this is for an embedded system.
 #	SHLIB_TEXT_START_ADDR - if set, add to SIZEOF_HEADERS to set
 #		start address of shared library.
 #	INPUT_FILES - INPUT command of files to always include
 #	WRITABLE_RODATA - if set, the .rodata section should be writable
 #	INIT_START, INIT_END -  statements just before and just after
 # 	combination of .init sections.
@@ -98,13 +95,14 @@ test -z "${ALIGNMENT}" && ALIGNMENT="${ELFSIZE} / 8"
 test "$LD_FLAG" = "N" && DATA_ADDR=.
 test -z "${ETEXT_NAME}" && ETEXT_NAME=etext
 test -n "$CREATE_SHLIB$CREATE_PIE" && test -n "$SHLIB_DATA_ADDR" && COMMONPAGESIZE=""
 test -z "$CREATE_SHLIB$CREATE_PIE" && test -n "$DATA_ADDR" && COMMONPAGESIZE=""
 test -n "$RELRO_NOW" && unset SEPARATE_GOTPLT
 test -z "$ATTRS_SECTIONS" && ATTRS_SECTIONS=".gnu.attributes 0 : { KEEP (*(.gnu.attributes)) }"
-DATA_SEGMENT_ALIGN="ALIGN(${SEGMENT_SIZE}) + (. & (${MAXPAGESIZE} - 1))"
+DATA_SEGMENT_ALIGN="ALIGN(${SEGMENT_SIZE})"
+#DATA_SEGMENT_ALIGN="ALIGN(${SEGMENT_SIZE}) + (. & (${MAXPAGESIZE} - 1))"
 DATA_SEGMENT_RELRO_END=""
 DATA_SEGMENT_END=""
 if test -n "${COMMONPAGESIZE}"; then
   DATA_SEGMENT_ALIGN="ALIGN (${SEGMENT_SIZE}) - ((${MAXPAGESIZE} - .) & (${MAXPAGESIZE} - 1)); . = DATA_SEGMENT_ALIGN (${MAXPAGESIZE}, ${COMMONPAGESIZE})"
   DATA_SEGMENT_END=". = DATA_SEGMENT_END (.);"
   DATA_SEGMENT_RELRO_END=". = DATA_SEGMENT_RELRO_END (${SEPARATE_GOTPLT-0}, .);"
@@ -123,14 +121,14 @@ if test -z "$GOT"; then
     GOT=".got          ${RELOCATING-0} : { *(.got) }"
     GOTPLT=".got.plt      ${RELOCATING-0} : { *(.got.plt) }"
   fi
 fi
 DYNAMIC=".dynamic      ${RELOCATING-0} : { *(.dynamic) }"
 RODATA=".rodata       ${RELOCATING-0} : { *(.rodata${RELOCATING+ .rodata.* .gnu.linkonce.r.*}) }"
-DATARELRO=".data.rel.ro : { *(.data.rel.ro.local* .gnu.linkonce.d.rel.ro.local.*) *(.data.rel.ro .data.rel.ro.* .gnu.linkonce.d.rel.ro.*) }"
-DISCARDED="/DISCARD/ : { *(.note.GNU-stack) *(.gnu_debuglink)  *(.gnu.lto_*) }"
+DATARELRO=".data.rel.ro : { *(.data.rel.ro.local* .gnu.linkonce.d.rel.ro.local.*) *(.data.rel.ro* .gnu.linkonce.d.rel.ro.*) }"
+DISCARDED="/DISCARD/ : { *(.note.GNU-stack) *(.gnu_debuglink) }"
 if test -z "${NO_SMALL_DATA}"; then
   SBSS=".sbss         ${RELOCATING-0} :
   {
     ${RELOCATING+${SBSS_START_SYMBOLS}}
     ${CREATE_SHLIB+*(.sbss2 .sbss2.* .gnu.linkonce.sb2.*)}
     *(.dynsbss)
@@ -139,13 +137,13 @@ if test -z "${NO_SMALL_DATA}"; then
     ${RELOCATING+${SBSS_END_SYMBOLS}}
   }"
   SBSS2=".sbss2        ${RELOCATING-0} : { *(.sbss2${RELOCATING+ .sbss2.* .gnu.linkonce.sb2.*}) }"
   SDATA="/* We want the small data sections together, so single-instruction offsets
      can access them all, and initialized data all before uninitialized, so
      we can shorten the on-disk segment size.  */
-  .sdata        ${RELOCATING-0} : 
+  .sdata        ${RELOCATING-0} :
   {
     ${RELOCATING+${SDATA_START_SYMBOLS}}
     ${CREATE_SHLIB+*(.sdata2 .sdata2.* .gnu.linkonce.s2.*)}
     *(.sdata${RELOCATING+ .sdata.* .gnu.linkonce.s.*})
   }"
   SDATA2=".sdata2       ${RELOCATING-0} :
@@ -197,27 +195,13 @@ test "${LARGE_SECTIONS}" = "yes" && LARGE_SECTIONS="
   }
   .ldata ${RELOCATING-0} ${RELOCATING+ALIGN(${MAXPAGESIZE}) + (. & (${MAXPAGESIZE} - 1))} :
   {
     *(.ldata${RELOCATING+ .ldata.* .gnu.linkonce.l.*})
     ${RELOCATING+. = ALIGN(. != 0 ? ${ALIGNMENT} : 1);}
   }"
-INIT_ARRAY=".init_array   ${RELOCATING-0} :
-  {
-     ${RELOCATING+${CREATE_SHLIB-PROVIDE_HIDDEN (${USER_LABEL_PREFIX}__init_array_start = .);}}
-     KEEP (*(SORT(.init_array.*)))
-     KEEP (*(.init_array))
-     ${RELOCATING+${CREATE_SHLIB-PROVIDE_HIDDEN (${USER_LABEL_PREFIX}__init_array_end = .);}}
-  }"
-FINI_ARRAY=".fini_array   ${RELOCATING-0} :
-  {
-    ${RELOCATING+${CREATE_SHLIB-PROVIDE_HIDDEN (${USER_LABEL_PREFIX}__fini_array_start = .);}}
-    KEEP (*(SORT(.fini_array.*)))
-    KEEP (*(.fini_array))
-    ${RELOCATING+${CREATE_SHLIB-PROVIDE_HIDDEN (${USER_LABEL_PREFIX}__fini_array_end = .);}}
-  }"
-CTOR=".ctors        ${CONSTRUCTING-0} : 
+CTOR=".ctors        ${CONSTRUCTING-0} :
   {
     ${CONSTRUCTING+${CTOR_START}}
     /* gcc uses crtbegin.o to find the start of
        the constructors, so we make sure it is
        first.  Because this is a wildcard, it
        doesn't matter if the user does not
@@ -253,27 +237,24 @@ DTOR=".dtors        ${CONSTRUCTING-0} :
 STACK="  .stack        ${RELOCATING-0}${RELOCATING+${STACK_ADDR}} :
   {
     ${RELOCATING+_stack = .;}
     *(.stack)
   }"
 
-TEXT_START_ADDR="SEGMENT_START(\"text-segment\", ${TEXT_START_ADDR})"
-SHLIB_TEXT_START_ADDR="SEGMENT_START(\"text-segment\", ${SHLIB_TEXT_START_ADDR:-0})"
-
 # if this is for an embedded system, don't add SIZEOF_HEADERS.
 if [ -z "$EMBEDDED" ]; then
    test -z "${TEXT_BASE_ADDRESS}" && TEXT_BASE_ADDRESS="${TEXT_START_ADDR} + SIZEOF_HEADERS"
 else
    test -z "${TEXT_BASE_ADDRESS}" && TEXT_BASE_ADDRESS="${TEXT_START_ADDR}"
 fi
 
 cat <<EOF
 OUTPUT_FORMAT("${OUTPUT_FORMAT}", "${BIG_OUTPUT_FORMAT}",
 	      "${LITTLE_OUTPUT_FORMAT}")
 OUTPUT_ARCH(${OUTPUT_ARCH})
-${RELOCATING+ENTRY(${ENTRY})}
+ENTRY(${ENTRY})
 
 ${RELOCATING+${LIB_SEARCH_DIRS}}
 ${RELOCATING+${EXECUTABLE_SYMBOLS}}
 ${RELOCATING+${INPUT_FILES}}
 ${RELOCATING- /* For some reason, the Solaris linker makes bad executables
   if gld -r is used and the intermediate file has sections starting
@@ -281,33 +262,28 @@ ${RELOCATING- /* For some reason, the Solaris linker makes bad executables
   bug.  But for now assigning the zero vmas works.  */}
 
 SECTIONS
 {
   /* Read-only sections, merged into text segment: */
   ${CREATE_SHLIB-${CREATE_PIE-${RELOCATING+PROVIDE (__executable_start = ${TEXT_START_ADDR}); . = ${TEXT_BASE_ADDRESS};}}}
-  ${CREATE_SHLIB+${RELOCATING+. = ${SHLIB_TEXT_START_ADDR} + SIZEOF_HEADERS;}}
-  ${CREATE_PIE+${RELOCATING+. = ${SHLIB_TEXT_START_ADDR} + SIZEOF_HEADERS;}}
+  ${CREATE_SHLIB+${RELOCATING+. = ${SHLIB_TEXT_START_ADDR:-0} + SIZEOF_HEADERS;}}
+  ${CREATE_PIE+${RELOCATING+. = ${SHLIB_TEXT_START_ADDR:-0} + SIZEOF_HEADERS;}}
   ${INITIAL_READONLY_SECTIONS}
   .note.gnu.build-id : { *(.note.gnu.build-id) }
-EOF
-
-test -n "${RELOCATING+0}" || unset NON_ALLOC_DYN
-test -z "${NON_ALLOC_DYN}" || TEXT_DYNAMIC=
-cat > ldscripts/dyntmp.$$ <<EOF
   ${TEXT_DYNAMIC+${DYNAMIC}}
   .hash         ${RELOCATING-0} : { *(.hash) }
   .gnu.hash     ${RELOCATING-0} : { *(.gnu.hash) }
   .dynsym       ${RELOCATING-0} : { *(.dynsym) }
   .dynstr       ${RELOCATING-0} : { *(.dynstr) }
   .gnu.version  ${RELOCATING-0} : { *(.gnu.version) }
   .gnu.version_d ${RELOCATING-0}: { *(.gnu.version_d) }
   .gnu.version_r ${RELOCATING-0}: { *(.gnu.version_r) }
-EOF
 
+EOF
 if [ "x$COMBRELOC" = x ]; then
-  COMBRELOCCAT="cat >> ldscripts/dyntmp.$$"
+  COMBRELOCCAT=cat
 else
   COMBRELOCCAT="cat > $COMBRELOC"
 fi
 eval $COMBRELOCCAT <<EOF
   .rel.init     ${RELOCATING-0} : { *(.rel.init) }
   .rela.init    ${RELOCATING-0} : { *(.rela.init) }
@@ -315,14 +291,14 @@ eval $COMBRELOCCAT <<EOF
   .rela.text    ${RELOCATING-0} : { *(.rela.text${RELOCATING+ .rela.text.* .rela.gnu.linkonce.t.*}) }
   .rel.fini     ${RELOCATING-0} : { *(.rel.fini) }
   .rela.fini    ${RELOCATING-0} : { *(.rela.fini) }
   .rel.rodata   ${RELOCATING-0} : { *(.rel.rodata${RELOCATING+ .rel.rodata.* .rel.gnu.linkonce.r.*}) }
   .rela.rodata  ${RELOCATING-0} : { *(.rela.rodata${RELOCATING+ .rela.rodata.* .rela.gnu.linkonce.r.*}) }
   ${OTHER_READONLY_RELOC_SECTIONS}
-  .rel.data.rel.ro ${RELOCATING-0} : { *(.rel.data.rel.ro${RELOCATING+ .rel.data.rel.ro.* .rel.gnu.linkonce.d.rel.ro.*}) }
-  .rela.data.rel.ro ${RELOCATING-0} : { *(.rela.data.rel.ro${RELOCATING+ .rela.data.rel.ro.* .rela.gnu.linkonce.d.rel.ro.*}) }
+  .rel.data.rel.ro ${RELOCATING-0} : { *(.rel.data.rel.ro${RELOCATING+* .rel.gnu.linkonce.d.rel.ro.*}) }
+  .rela.data.rel.ro ${RELOCATING-0} : { *(.rela.data.rel.ro${RELOCATING+* .rela.gnu.linkonce.d.rel.ro.*}) }
   .rel.data     ${RELOCATING-0} : { *(.rel.data${RELOCATING+ .rel.data.* .rel.gnu.linkonce.d.*}) }
   .rela.data    ${RELOCATING-0} : { *(.rela.data${RELOCATING+ .rela.data.* .rela.gnu.linkonce.d.*}) }
   .rel.tdata	${RELOCATING-0} : { *(.rel.tdata${RELOCATING+ .rel.tdata.* .rel.gnu.linkonce.td.*}) }
   .rela.tdata	${RELOCATING-0} : { *(.rela.tdata${RELOCATING+ .rela.tdata.* .rela.gnu.linkonce.td.*}) }
   .rel.tbss	${RELOCATING-0} : { *(.rel.tbss${RELOCATING+ .rel.tbss.* .rel.gnu.linkonce.tb.*}) }
   .rela.tbss	${RELOCATING-0} : { *(.rela.tbss${RELOCATING+ .rela.tbss.* .rela.gnu.linkonce.tb.*}) }
@@ -338,76 +314,53 @@ eval $COMBRELOCCAT <<EOF
   ${REL_SDATA2}
   ${REL_SBSS2}
   .rel.bss      ${RELOCATING-0} : { *(.rel.bss${RELOCATING+ .rel.bss.* .rel.gnu.linkonce.b.*}) }
   .rela.bss     ${RELOCATING-0} : { *(.rela.bss${RELOCATING+ .rela.bss.* .rela.gnu.linkonce.b.*}) }
   ${REL_LARGE}
 EOF
-
 if [ -n "$COMBRELOC" ]; then
-cat >> ldscripts/dyntmp.$$ <<EOF
+cat <<EOF
   .rel.dyn      ${RELOCATING-0} :
     {
 EOF
-sed -e '/^[ 	]*[{}][ 	]*$/d;/:[ 	]*$/d;/\.rela\./d;s/^.*: { *\(.*\)}$/      \1/' $COMBRELOC >> ldscripts/dyntmp.$$
-cat >> ldscripts/dyntmp.$$ <<EOF
-    }
-  .rel.ifunc.dyn      ${RELOCATING-0} :
-    {
-      *(.rel.ifunc.*)
+sed -e '/^[ 	]*[{}][ 	]*$/d;/:[ 	]*$/d;/\.rela\./d;s/^.*: { *\(.*\)}$/      \1/' $COMBRELOC
+cat <<EOF
     }
   .rela.dyn     ${RELOCATING-0} :
     {
 EOF
-sed -e '/^[ 	]*[{}][ 	]*$/d;/:[ 	]*$/d;/\.rel\./d;s/^.*: { *\(.*\)}/      \1/' $COMBRELOC >> ldscripts/dyntmp.$$
-cat >> ldscripts/dyntmp.$$ <<EOF
-    }
-  .rela.ifunc.dyn     ${RELOCATING-0} :
-    {
-      *(.rela.ifunc.*)
+sed -e '/^[ 	]*[{}][ 	]*$/d;/:[ 	]*$/d;/\.rel\./d;s/^.*: { *\(.*\)}/      \1/' $COMBRELOC
+cat <<EOF
     }
 EOF
 fi
-
-cat >> ldscripts/dyntmp.$$ <<EOF
+cat <<EOF
   .rel.plt      ${RELOCATING-0} : { *(.rel.plt) }
   .rela.plt     ${RELOCATING-0} : { *(.rela.plt) }
   ${OTHER_PLT_RELOC_SECTIONS}
-EOF
 
-if test -z "${NON_ALLOC_DYN}"; then
-  if test -z "${NO_REL_RELOCS}${NO_RELA_RELOCS}"; then
-    cat ldscripts/dyntmp.$$
-  else
-    if test -z "${NO_REL_RELOCS}"; then
-      sed -e '/^[ 	]*\.rela\.[^}]*$/,/}/d' -e '/^[ 	]*\.rela\./d' ldscripts/dyntmp.$$
-    fi
-    if test -z "${NO_RELA_RELOCS}"; then
-      sed -e '/^[ 	]*\.rel\.[^}]*$/,/}/d' -e '/^[ 	]*\.rel\./d' ldscripts/dyntmp.$$
-    fi
-  fi
-  rm -f ldscripts/dyntmp.$$
-fi
-
-cat <<EOF
   .init         ${RELOCATING-0} : 
   { 
     ${RELOCATING+${INIT_START}}
     KEEP (*(.init))
     ${RELOCATING+${INIT_END}}
   } =${NOP-0}
 
-  ${TEXT_PLT+${PLT}}
   ${TINY_READONLY_SECTION}
   .text         ${RELOCATING-0} :
   {
     ${RELOCATING+${TEXT_START_SYMBOLS}}
     *(.text .stub${RELOCATING+ .text.* .gnu.linkonce.t.*})
+    KEEP (*(.text.*personality*))
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
     ${RELOCATING+${OTHER_TEXT_SECTIONS}}
   } =${NOP-0}
+  . = ALIGN(4096);
+  ${TEXT_PLT+${PLT}}
+  . = ALIGN(4096);
   .fini         ${RELOCATING-0} :
   {
     ${RELOCATING+${FINI_START}}
     KEEP (*(.fini))
     ${RELOCATING+${FINI_END}}
   } =${NOP-0}
@@ -432,21 +385,34 @@ cat <<EOF
   /* Exception handling  */
   .eh_frame     ${RELOCATING-0} : ONLY_IF_RW { KEEP (*(.eh_frame)) }
   .gcc_except_table ${RELOCATING-0} : ONLY_IF_RW { *(.gcc_except_table .gcc_except_table.*) }
 
   /* Thread Local Storage sections  */
   .tdata	${RELOCATING-0} : { *(.tdata${RELOCATING+ .tdata.* .gnu.linkonce.td.*}) }
+  .tbss		${RELOCATING-0} : { *(.tbss${RELOCATING+ .tbss.* .gnu.linkonce.tb.*})${RELOCATING+ *(.tcommon)} }
 
   .preinit_array   ${RELOCATING-0} :
   {
     ${RELOCATING+${CREATE_SHLIB-PROVIDE_HIDDEN (${USER_LABEL_PREFIX}__preinit_array_start = .);}}
     KEEP (*(.preinit_array))
     ${RELOCATING+${CREATE_SHLIB-PROVIDE_HIDDEN (${USER_LABEL_PREFIX}__preinit_array_end = .);}}
   }
-  ${RELOCATING+${INIT_ARRAY}}
-  ${RELOCATING+${FINI_ARRAY}}
+  .init_array   ${RELOCATING-0} :
+  {
+     ${RELOCATING+${CREATE_SHLIB-PROVIDE_HIDDEN (${USER_LABEL_PREFIX}__init_array_start = .);}}
+     KEEP (*(SORT(.init_array.*)))
+     KEEP (*(.init_array))
+     ${RELOCATING+${CREATE_SHLIB-PROVIDE_HIDDEN (${USER_LABEL_PREFIX}__init_array_end = .);}}
+  }
+  .fini_array   ${RELOCATING-0} :
+  {
+    ${RELOCATING+${CREATE_SHLIB-PROVIDE_HIDDEN (${USER_LABEL_PREFIX}__fini_array_start = .);}}
+    KEEP (*(.fini_array))
+    KEEP (*(SORT(.fini_array.*)))
+    ${RELOCATING+${CREATE_SHLIB-PROVIDE_HIDDEN (${USER_LABEL_PREFIX}__fini_array_end = .);}}
+  }
   ${SMALL_DATA_CTOR-${RELOCATING+${CTOR}}}
   ${SMALL_DATA_DTOR-${RELOCATING+${DTOR}}}
   .jcr          ${RELOCATING-0} : { KEEP (*(.jcr)) }
 
   ${RELOCATING+${DATARELRO}}
   ${OTHER_RELRO_SECTIONS}
@@ -461,12 +427,13 @@ cat <<EOF
   ${DATA_PLT+${PLT_BEFORE_GOT-${PLT}}}
 
   .data         ${RELOCATING-0} :
   {
     ${RELOCATING+${DATA_START_SYMBOLS}}
     *(.data${RELOCATING+ .data.* .gnu.linkonce.d.*})
+    ${RELOCATING+KEEP (*(.gnu.linkonce.d.*personality*))}
     ${CONSTRUCTING+SORT(CONSTRUCTORS)}
   }
   .data1        ${RELOCATING-0} : { *(.data1) }
   ${WRITABLE_RODATA+${RODATA}}
   ${OTHER_READWRITE_SECTIONS}
   ${SMALL_DATA_CTOR+${RELOCATING+${CTOR}}}
@@ -499,29 +466,13 @@ cat <<EOF
   ${RELOCATING+. = ALIGN(${ALIGNMENT});}
   ${LARGE_SECTIONS}
   ${RELOCATING+. = ALIGN(${ALIGNMENT});}
   ${RELOCATING+${OTHER_END_SYMBOLS}}
   ${RELOCATING+${END_SYMBOLS-${USER_LABEL_PREFIX}_end = .; PROVIDE (${USER_LABEL_PREFIX}end = .);}}
   ${RELOCATING+${DATA_SEGMENT_END}}
-EOF
-
-if test -n "${NON_ALLOC_DYN}"; then
-  if test -z "${NO_REL_RELOCS}${NO_RELA_RELOCS}"; then
-    cat ldscripts/dyntmp.$$
-  else
-    if test -z "${NO_REL_RELOCS}"; then
-      sed -e '/^[ 	]*\.rela\.[^}]*$/,/}/d' -e '/^[ 	]*\.rela\./d' ldscripts/dyntmp.$$
-    fi
-    if test -z "${NO_RELA_RELOCS}"; then
-      sed -e '/^[ 	]*\.rel\.[^}]*$/,/}/d' -e '/^[ 	]*\.rel\./d' ldscripts/dyntmp.$$
-    fi
-  fi
-  rm -f ldscripts/dyntmp.$$
-fi
 
-cat <<EOF
   /* Stabs debugging sections.  */
   .stab          0 : { *(.stab) }
   .stabstr       0 : { *(.stabstr) }
   .stab.excl     0 : { *(.stab.excl) }
   .stab.exclstr  0 : { *(.stab.exclstr) }
   .stab.index    0 : { *(.stab.index) }
@@ -561,15 +512,12 @@ cat <<EOF
   .debug_varnames  0 : { *(.debug_varnames) }
 
   /* DWARF 3 */
   .debug_pubtypes 0 : { *(.debug_pubtypes) }
   .debug_ranges   0 : { *(.debug_ranges) }
 
-  /* DWARF Extension.  */
-  .debug_macro    0 : { *(.debug_macro) } 
-  
   ${TINY_DATA_SECTION}
   ${TINY_BSS_SECTION}
 
   ${STACK_ADDR+${STACK}}
   ${ATTRS_SECTIONS}
   ${OTHER_SECTIONS}
diff --git a/ld/scripttempl/mep.sc b/ld/scripttempl/amithlon.sc
similarity index 76%
copy from ld/scripttempl/mep.sc
copy to ld/scripttempl/amithlon.sc
index 3fc1352e19184c0319302e809cccf7cc861ec8d7..b8248cd4966e34e95c8b262e515ace1802c6db35 100644
--- ld/scripttempl/mep.sc
+++ ld/scripttempl/amithlon.sc
@@ -1,57 +1,45 @@
 #
 # Unusual variables checked by this code:
 #	NOP - four byte opcode for no-op (defaults to 0)
 #	NO_SMALL_DATA - no .sbss/.sbss2/.sdata/.sdata2 sections if not
 #		empty.
-#	SMALL_DATA_CTOR - .ctors contains small data.
-#	SMALL_DATA_DTOR - .dtors contains small data.
 #	DATA_ADDR - if end-of-text-plus-one-page isn't right for data start
 #	INITIAL_READONLY_SECTIONS - at start of text segment
 #	OTHER_READONLY_SECTIONS - other than .text .init .rodata ...
 #		(e.g., .PARISC.milli)
 #	OTHER_TEXT_SECTIONS - these get put in .text when relocating
 #	OTHER_READWRITE_SECTIONS - other than .data .bss .ctors .sdata ...
 #		(e.g., .PARISC.global)
-#	OTHER_RELRO_SECTIONS - other than .data.rel.ro ...
-#		(e.g. PPC32 .fixup, .got[12])
 #	OTHER_BSS_SECTIONS - other than .bss .sbss ...
 #	OTHER_SECTIONS - at the end
 #	EXECUTABLE_SYMBOLS - symbols that must be defined for an
 #		executable (e.g., _DYNAMIC_LINK)
-#       TEXT_START_ADDR - the first byte of the text segment, after any
-#               headers.
-#       TEXT_BASE_ADDRESS - the first byte of the text segment.
 #	TEXT_START_SYMBOLS - symbols that appear at the start of the
 #		.text section.
 #	DATA_START_SYMBOLS - symbols that appear at the start of the
 #		.data section.
 #	OTHER_GOT_SYMBOLS - symbols defined just before .got.
 #	OTHER_GOT_SECTIONS - sections just after .got.
 #	OTHER_SDATA_SECTIONS - sections just after .sdata.
 #	OTHER_BSS_SYMBOLS - symbols that appear at the start of the
 #		.bss section besides __bss_start.
 #	DATA_PLT - .plt should be in data segment, not text segment.
-#	PLT_BEFORE_GOT - .plt just before .got when .plt is in data segement.
 #	BSS_PLT - .plt should be in bss segment
 #	TEXT_DYNAMIC - .dynamic in text segment, not data segment.
-#	EMBEDDED - whether this is for an embedded system. 
+#	EMBEDDED - whether this is for an embedded system.
 #	SHLIB_TEXT_START_ADDR - if set, add to SIZEOF_HEADERS to set
 #		start address of shared library.
 #	INPUT_FILES - INPUT command of files to always include
 #	WRITABLE_RODATA - if set, the .rodata section should be writable
 #	INIT_START, INIT_END -  statements just before and just after
 # 	combination of .init sections.
 #	FINI_START, FINI_END - statements just before and just after
 # 	combination of .fini sections.
 #	STACK_ADDR - start of a .stack section.
 #	OTHER_END_SYMBOLS - symbols to place right at the end of the script.
-#	SEPARATE_GOTPLT - if set, .got.plt should be separate output section,
-#		so that .got can be in the RELRO area.  It should be set to
-#		the number of bytes in the beginning of .got.plt which can be
-#		in the RELRO area as well.
 #
 # When adding sections, do note that the names of some sections are used
 # when specifying the start address of the next.
 #
 
 #  Many sections come in three flavours.  There is the 'real' section,
@@ -81,108 +69,85 @@ test -z "$ENTRY" && ENTRY=_start
 test -z "${BIG_OUTPUT_FORMAT}" && BIG_OUTPUT_FORMAT=${OUTPUT_FORMAT}
 test -z "${LITTLE_OUTPUT_FORMAT}" && LITTLE_OUTPUT_FORMAT=${OUTPUT_FORMAT}
 if [ -z "$MACHINE" ]; then OUTPUT_ARCH=${ARCH}; else OUTPUT_ARCH=${ARCH}:${MACHINE}; fi
 test -z "${ELFSIZE}" && ELFSIZE=32
 test -z "${ALIGNMENT}" && ALIGNMENT="${ELFSIZE} / 8"
 test "$LD_FLAG" = "N" && DATA_ADDR=.
-test -n "$CREATE_SHLIB$CREATE_PIE" && test -n "$SHLIB_DATA_ADDR" && COMMONPAGESIZE=""
-test -z "$CREATE_SHLIB$CREATE_PIE" && test -n "$DATA_ADDR" && COMMONPAGESIZE=""
-test -n "$RELRO_NOW" && unset SEPARATE_GOTPLT
-DATA_SEGMENT_ALIGN="ALIGN(${SEGMENT_SIZE}) + (. & (${MAXPAGESIZE} - 1))"
-DATA_SEGMENT_RELRO_END=""
-DATA_SEGMENT_RELRO_GOTPLT_END=""
+test -n "$CREATE_SHLIB" && test -n "$SHLIB_DATA_ADDR" && COMMONPAGESIZE=""
+test -z "$CREATE_SHLIB" && test -n "$DATA_ADDR" && COMMONPAGESIZE=""
+#DATA_SEGMENT_ALIGN="ALIGN(${MAXPAGESIZE}) + (. & (${MAXPAGESIZE} - 1))"
+DATA_SEGMENT_ALIGN="ALIGN(${MAXPAGESIZE}) + ${MAXPAGESIZE}"
 DATA_SEGMENT_END=""
 if test -n "${COMMONPAGESIZE}"; then
-  DATA_SEGMENT_ALIGN="ALIGN (${SEGMENT_SIZE}) - ((${MAXPAGESIZE} - .) & (${MAXPAGESIZE} - 1)); . = DATA_SEGMENT_ALIGN (${MAXPAGESIZE}, ${COMMONPAGESIZE})"
+  DATA_SEGMENT_ALIGN="DATA_SEGMENT_ALIGN(${MAXPAGESIZE}, ${COMMONPAGESIZE})"
   DATA_SEGMENT_END=". = DATA_SEGMENT_END (.);"
-  if test -n "${SEPARATE_GOTPLT}"; then
-    DATA_SEGMENT_RELRO_GOTPLT_END=". = DATA_SEGMENT_RELRO_END (${SEPARATE_GOTPLT}, .);"
-  else
-    DATA_SEGMENT_RELRO_END=". = DATA_SEGMENT_RELRO_END (0, .);"
-  fi
 fi
 INTERP=".interp       ${RELOCATING-0} : { *(.interp) }"
 PLT=".plt          ${RELOCATING-0} : { *(.plt) }"
-if test -z "$GOT"; then
-  if test -z "$SEPARATE_GOTPLT"; then
-    GOT=".got          ${RELOCATING-0} : { *(.got.plt) *(.got) }"
-  else
-    GOT=".got          ${RELOCATING-0} : { *(.got) }"
-    GOTPLT="${RELOCATING+${DATA_SEGMENT_RELRO_GOTPLT_END}}
-  .got.plt      ${RELOCATING-0} : { *(.got.plt) }"
-  fi
-fi
 DYNAMIC=".dynamic      ${RELOCATING-0} : { *(.dynamic) }"
 RODATA=".rodata       ${RELOCATING-0} : { *(.rodata${RELOCATING+ .rodata.* .gnu.linkonce.r.*}) }"
-DATARELRO=".data.rel.ro : { *(.data.rel.ro.local) *(.data.rel.ro .data.rel.ro.*) }"
-DISCARDED="/DISCARD/ : { *(.note.GNU-stack) *(.gnu_debuglink)  *(.gnu.lto_*) }"
 if test -z "${NO_SMALL_DATA}"; then
   SBSS=".sbss         ${RELOCATING-0} :
   {
     ${RELOCATING+PROVIDE (__sbss_start = .);}
     ${RELOCATING+PROVIDE (___sbss_start = .);}
-    ${CREATE_SHLIB+*(.sbss2 .sbss2.* .gnu.linkonce.sb2.*)}
     *(.dynsbss)
     *(.sbss${RELOCATING+ .sbss.* .gnu.linkonce.sb.*})
     *(.scommon)
     ${RELOCATING+PROVIDE (__sbss_end = .);}
     ${RELOCATING+PROVIDE (___sbss_end = .);}
   }"
   SBSS2=".sbss2        ${RELOCATING-0} : { *(.sbss2${RELOCATING+ .sbss2.* .gnu.linkonce.sb2.*}) }"
   SDATA="/* We want the small data sections together, so single-instruction offsets
      can access them all, and initialized data all before uninitialized, so
      we can shorten the on-disk segment size.  */
-  .sdata        ${RELOCATING-0} : 
+  .sdata        ${RELOCATING-0} :
   {
     ${RELOCATING+${SDATA_START_SYMBOLS}}
-    ${CREATE_SHLIB+*(.sdata2 .sdata2.* .gnu.linkonce.s2.*)}
     *(.sdata${RELOCATING+ .sdata.* .gnu.linkonce.s.*})
   }"
   SDATA2=".sdata2       ${RELOCATING-0} : { *(.sdata2${RELOCATING+ .sdata2.* .gnu.linkonce.s2.*}) }"
   REL_SDATA=".rel.sdata    ${RELOCATING-0} : { *(.rel.sdata${RELOCATING+ .rel.sdata.* .rel.gnu.linkonce.s.*}) }
   .rela.sdata   ${RELOCATING-0} : { *(.rela.sdata${RELOCATING+ .rela.sdata.* .rela.gnu.linkonce.s.*}) }"
   REL_SBSS=".rel.sbss     ${RELOCATING-0} : { *(.rel.sbss${RELOCATING+ .rel.sbss.* .rel.gnu.linkonce.sb.*}) }
   .rela.sbss    ${RELOCATING-0} : { *(.rela.sbss${RELOCATING+ .rela.sbss.* .rela.gnu.linkonce.sb.*}) }"
   REL_SDATA2=".rel.sdata2   ${RELOCATING-0} : { *(.rel.sdata2${RELOCATING+ .rel.sdata2.* .rel.gnu.linkonce.s2.*}) }
   .rela.sdata2  ${RELOCATING-0} : { *(.rela.sdata2${RELOCATING+ .rela.sdata2.* .rela.gnu.linkonce.s2.*}) }"
   REL_SBSS2=".rel.sbss2    ${RELOCATING-0} : { *(.rel.sbss2${RELOCATING+ .rel.sbss2.* .rel.gnu.linkonce.sb2.*}) }
   .rela.sbss2   ${RELOCATING-0} : { *(.rela.sbss2${RELOCATING+ .rela.sbss2.* .rela.gnu.linkonce.sb2.*}) }"
-else
-  NO_SMALL_DATA=" "
 fi
-test -n "$SEPARATE_GOTPLT" && SEPARATE_GOTPLT=" "
-CTOR=".ctors        ${CONSTRUCTING-0} : 
+CTOR=".ctors        ${CONSTRUCTING-0} :
   {
     ${CONSTRUCTING+${CTOR_START}}
     /* gcc uses crtbegin.o to find the start of
        the constructors, so we make sure it is
        first.  Because this is a wildcard, it
        doesn't matter if the user does not
        actually link against crtbegin.o; the
        linker won't look for a file to match a
        wildcard.  The wildcard also means that it
        doesn't matter which directory crtbegin.o
        is in.  */
 
-    KEEP (*crtbegin*.o(.ctors))
+    KEEP (*crtbegin.o(.ctors))
 
     /* We don't want to include the .ctor section from
        from the crtend.o file until after the sorted ctors.
        The .ctor section from the crtend file contains the
        end of ctors marker and it must be last */
 
-    KEEP (*(EXCLUDE_FILE (*crtend*.o $OTHER_EXCLUDE_FILES) .ctors))
+    KEEP (*(EXCLUDE_FILE (*crtend.o $OTHER_EXCLUDE_FILES) .ctors))
     KEEP (*(SORT(.ctors.*)))
     KEEP (*(.ctors))
     ${CONSTRUCTING+${CTOR_END}}
   }"
 DTOR=".dtors        ${CONSTRUCTING-0} :
   {
     ${CONSTRUCTING+${DTOR_START}}
-    KEEP (*crtbegin*.o(.dtors))
-    KEEP (*(EXCLUDE_FILE (*crtend*.o $OTHER_EXCLUDE_FILES) .dtors))
+    KEEP (*crtbegin.o(.dtors))
+    KEEP (*(EXCLUDE_FILE (*crtend.o $OTHER_EXCLUDE_FILES) .dtors))
     KEEP (*(SORT(.dtors.*)))
     KEEP (*(.dtors))
     ${CONSTRUCTING+${DTOR_END}}
   }"
 STACK="  .stack        ${RELOCATING-0}${RELOCATING+${STACK_ADDR}} :
   {
@@ -198,13 +163,13 @@ else
 fi
 
 cat <<EOF
 OUTPUT_FORMAT("${OUTPUT_FORMAT}", "${BIG_OUTPUT_FORMAT}",
 	      "${LITTLE_OUTPUT_FORMAT}")
 OUTPUT_ARCH(${OUTPUT_ARCH})
-${RELOCATING+ENTRY(${ENTRY})}
+ENTRY(${ENTRY})
 
 ${RELOCATING+${LIB_SEARCH_DIRS}}
 ${RELOCATING+/* Do we need any of these for elf?
    __DYNAMIC = 0; ${STACKZERO+${STACKZERO}} ${SHLIB_PATH+${SHLIB_PATH}}  */}
 ${RELOCATING+${EXECUTABLE_SYMBOLS}}
 ${RELOCATING+${INPUT_FILES}}
@@ -213,15 +178,14 @@ ${RELOCATING- /* For some reason, the Solaris linker makes bad executables
   at non-zero addresses.  Could be a Solaris ld bug, could be a GNU ld
   bug.  But for now assigning the zero vmas works.  */}
 
 SECTIONS
 {
   /* Read-only sections, merged into text segment: */
-  ${CREATE_SHLIB-${CREATE_PIE-${RELOCATING+PROVIDE (__executable_start = ${TEXT_START_ADDR}); . = ${TEXT_BASE_ADDRESS};}}}
+  ${CREATE_SHLIB-${RELOCATING+. = ${TEXT_BASE_ADDRESS};}}
   ${CREATE_SHLIB+${RELOCATING+. = ${SHLIB_TEXT_START_ADDR:-0} + SIZEOF_HEADERS;}}
-  ${CREATE_PIE+${RELOCATING+. = ${SHLIB_TEXT_START_ADDR:-0} + SIZEOF_HEADERS;}}
   ${CREATE_SHLIB-${INTERP}}
   ${INITIAL_READONLY_SECTIONS}
   ${TEXT_DYNAMIC+${DYNAMIC}}
   .hash         ${RELOCATING-0} : { *(.hash) }
   .dynsym       ${RELOCATING-0} : { *(.dynsym) }
   .dynstr       ${RELOCATING-0} : { *(.dynstr) }
@@ -242,14 +206,12 @@ eval $COMBRELOCCAT <<EOF
   .rela.text    ${RELOCATING-0} : { *(.rela.text${RELOCATING+ .rela.text.* .rela.gnu.linkonce.t.*}) }
   .rel.fini     ${RELOCATING-0} : { *(.rel.fini) }
   .rela.fini    ${RELOCATING-0} : { *(.rela.fini) }
   .rel.rodata   ${RELOCATING-0} : { *(.rel.rodata${RELOCATING+ .rel.rodata.* .rel.gnu.linkonce.r.*}) }
   .rela.rodata  ${RELOCATING-0} : { *(.rela.rodata${RELOCATING+ .rela.rodata.* .rela.gnu.linkonce.r.*}) }
   ${OTHER_READONLY_RELOC_SECTIONS}
-  .rel.data.rel.ro ${RELOCATING-0} : { *(.rel.data.rel.ro${RELOCATING+ .rel.data.rel.ro.*}) }
-  .rela.data.rel.ro ${RELOCATING-0} : { *(.rela.data.rel.ro${RELOCATING+ .rela.data.rel.ro.*}) }
   .rel.data     ${RELOCATING-0} : { *(.rel.data${RELOCATING+ .rel.data.* .rel.gnu.linkonce.d.*}) }
   .rela.data    ${RELOCATING-0} : { *(.rela.data${RELOCATING+ .rela.data.* .rela.gnu.linkonce.d.*}) }
   .rel.tdata	${RELOCATING-0} : { *(.rel.tdata${RELOCATING+ .rel.tdata.* .rel.gnu.linkonce.td.*}) }
   .rela.tdata	${RELOCATING-0} : { *(.rela.tdata${RELOCATING+ .rela.tdata.* .rela.gnu.linkonce.td.*}) }
   .rel.tbss	${RELOCATING-0} : { *(.rel.tbss${RELOCATING+ .rel.tbss.* .rel.gnu.linkonce.tb.*}) }
   .rela.tbss	${RELOCATING-0} : { *(.rela.tbss${RELOCATING+ .rela.tbss.* .rela.gnu.linkonce.tb.*}) }
@@ -285,12 +247,15 @@ EOF
 fi
 cat <<EOF
   .rel.plt      ${RELOCATING-0} : { *(.rel.plt) }
   .rela.plt     ${RELOCATING-0} : { *(.rela.plt) }
   ${OTHER_PLT_RELOC_SECTIONS}
 
+  /* Force a new section by skipping a page */
+  . = ALIGN(${MAXPAGESIZE}) + ${MAXPAGESIZE};
+
   .init         ${RELOCATING-0} : 
   { 
     ${RELOCATING+${INIT_START}}
     KEEP (*(.init))
     ${RELOCATING+${INIT_END}}
   } =${NOP-0}
@@ -310,69 +275,68 @@ cat <<EOF
     KEEP (*(.fini))
     ${RELOCATING+${FINI_END}}
   } =${NOP-0}
   ${RELOCATING+PROVIDE (__etext = .);}
   ${RELOCATING+PROVIDE (_etext = .);}
   ${RELOCATING+PROVIDE (etext = .);}
+
+  /* Force a new section by skipping a page */
+  . = ALIGN(${MAXPAGESIZE}) + ${MAXPAGESIZE};
+
   ${WRITABLE_RODATA-${RODATA}}
   .rodata1      ${RELOCATING-0} : { *(.rodata1) }
   ${CREATE_SHLIB-${SDATA2}}
   ${CREATE_SHLIB-${SBSS2}}
   ${OTHER_READONLY_SECTIONS}
   .eh_frame_hdr : { *(.eh_frame_hdr) }
-  .eh_frame     ${RELOCATING-0} : ONLY_IF_RO { KEEP (*(.eh_frame)) }
-  .gcc_except_table ${RELOCATING-0} : ONLY_IF_RO { KEEP (*(.gcc_except_table)) *(.gcc_except_table.*) }
 
   /* Adjust the address for the data segment.  We want to adjust up to
      the same address within the page on the next page up.  */
-  ${CREATE_SHLIB-${CREATE_PIE-${RELOCATING+. = ${DATA_ADDR-${DATA_SEGMENT_ALIGN}};}}}
+  ${CREATE_SHLIB-${RELOCATING+. = ${DATA_ADDR-${DATA_SEGMENT_ALIGN}};}}
   ${CREATE_SHLIB+${RELOCATING+. = ${SHLIB_DATA_ADDR-${DATA_SEGMENT_ALIGN}};}}
-  ${CREATE_PIE+${RELOCATING+. = ${SHLIB_DATA_ADDR-${DATA_SEGMENT_ALIGN}};}}
-
-  /* Exception handling  */
-  .eh_frame     ${RELOCATING-0} : ONLY_IF_RW { KEEP (*(.eh_frame)) }
-  .gcc_except_table ${RELOCATING-0} : ONLY_IF_RW { KEEP (*(.gcc_except_table)) *(.gcc_except_table.*) }
-
-  /* Thread Local Storage sections  */
-  .tdata	${RELOCATING-0} : { *(.tdata${RELOCATING+ .tdata.* .gnu.linkonce.td.*}) }
-  .tbss		${RELOCATING-0} : { *(.tbss${RELOCATING+ .tbss.* .gnu.linkonce.tb.*})${RELOCATING+ *(.tcommon)} }
-
-  .preinit_array   ${RELOCATING-0} : { KEEP (*(.preinit_array)) }
-  .init_array   ${RELOCATING-0} : { KEEP (*(.init_array)) }
-  .fini_array   ${RELOCATING-0} : { KEEP (*(.fini_array)) }
 
-  ${SMALL_DATA_CTOR-${RELOCATING+${CTOR}}}
-  ${SMALL_DATA_DTOR-${RELOCATING+${DTOR}}}
-  .jcr          ${RELOCATING-0} : { KEEP (*(.jcr)) }
+  /* Ensure the __preinit_array_start label is properly aligned.  We
+     could instead move the label definition inside the section, but
+     the linker would then create the section even if it turns out to
+     be empty, which isn't pretty.  */
+  ${RELOCATING+. = ALIGN(${ALIGNMENT});}
+  ${RELOCATING+${CREATE_SHLIB-PROVIDE (__preinit_array_start = .);}}
+  .preinit_array   ${RELOCATING-0} : { *(.preinit_array) }
+  ${RELOCATING+${CREATE_SHLIB-PROVIDE (__preinit_array_end = .);}}
 
-  ${RELOCATING+${DATARELRO}}
-  ${OTHER_RELRO_SECTIONS}
-  ${TEXT_DYNAMIC-${DYNAMIC}}
-  ${NO_SMALL_DATA+${RELRO_NOW+${GOT}}}
-  ${NO_SMALL_DATA+${RELRO_NOW-${SEPARATE_GOTPLT+${GOT}}}}
-  ${NO_SMALL_DATA+${RELRO_NOW-${SEPARATE_GOTPLT+${GOTPLT}}}}
-  ${RELOCATING+${DATA_SEGMENT_RELRO_END}}
-  ${NO_SMALL_DATA+${RELRO_NOW-${SEPARATE_GOTPLT-${GOT}}}}
+  ${RELOCATING+${CREATE_SHLIB-PROVIDE (__init_array_start = .);}}
+  .init_array   ${RELOCATING-0} : { *(.init_array) }
+  ${RELOCATING+${CREATE_SHLIB-PROVIDE (__init_array_end = .);}}
 
-  ${DATA_PLT+${PLT_BEFORE_GOT-${PLT}}}
+  ${RELOCATING+${CREATE_SHLIB-PROVIDE (__fini_array_start = .);}}
+  .fini_array   ${RELOCATING-0} : { *(.fini_array) }
+  ${RELOCATING+${CREATE_SHLIB-PROVIDE (__fini_array_end = .);}}
 
   .data         ${RELOCATING-0} :
   {
     ${RELOCATING+${DATA_START_SYMBOLS}}
     *(.data${RELOCATING+ .data.* .gnu.linkonce.d.*})
     ${CONSTRUCTING+SORT(CONSTRUCTORS)}
   }
   .data1        ${RELOCATING-0} : { *(.data1) }
+  .tdata	${RELOCATING-0} : { *(.tdata${RELOCATING+ .tdata.* .gnu.linkonce.td.*}) }
+  .tbss		${RELOCATING-0} : { *(.tbss${RELOCATING+ .tbss.* .gnu.linkonce.tb.*})${RELOCATING+ *(.tcommon)} }
+  .eh_frame     ${RELOCATING-0} : { KEEP (*(.eh_frame)) }
+  .gcc_except_table ${RELOCATING-0} : { *(.gcc_except_table) }
   ${WRITABLE_RODATA+${RODATA}}
   ${OTHER_READWRITE_SECTIONS}
-  ${SMALL_DATA_CTOR+${RELOCATING+${CTOR}}}
-  ${SMALL_DATA_DTOR+${RELOCATING+${DTOR}}}
-  ${DATA_PLT+${PLT_BEFORE_GOT+${PLT}}}
+  ${TEXT_DYNAMIC-${DYNAMIC}}
+  ${RELOCATING+${CTOR}}
+  ${RELOCATING+${DTOR}}
+  .jcr          ${RELOCATING-0} : { KEEP (*(.jcr)) }
+  ${DATA_PLT+${PLT}}
   ${RELOCATING+${OTHER_GOT_SYMBOLS}}
-  ${NO_SMALL_DATA-${GOT}}
+  .got          ${RELOCATING-0} : { *(.got.plt) *(.got) }
   ${OTHER_GOT_SECTIONS}
+  ${CREATE_SHLIB+${SDATA2}}
+  ${CREATE_SHLIB+${SBSS2}}
   ${SDATA}
   ${OTHER_SDATA_SECTIONS}
   ${RELOCATING+_edata = .;}
   ${RELOCATING+PROVIDE (edata = .);}
   ${RELOCATING+__bss_start = .;}
   ${RELOCATING+${OTHER_BSS_SYMBOLS}}
@@ -433,19 +397,16 @@ cat <<EOF
   /* SGI/MIPS DWARF 2 extensions */
   .debug_weaknames 0 : { *(.debug_weaknames) }
   .debug_funcnames 0 : { *(.debug_funcnames) }
   .debug_typenames 0 : { *(.debug_typenames) }
   .debug_varnames  0 : { *(.debug_varnames) }
 
-  /* DWARF 3 */
-  .debug_pubtypes 0 : { *(.debug_pubtypes) }
-  .debug_ranges   0 : { *(.debug_ranges) }
-
-  /* DWARF Extension.  */
-  .debug_macro    0 : { *(.debug_macro) } 
-
   ${STACK_ADDR+${STACK}}
   ${OTHER_SECTIONS}
   ${RELOCATING+${OTHER_END_SYMBOLS}}
-  ${RELOCATING+${DISCARDED}}
+
+  /* Libnix sections */
+  .libnix___INIT_LIST__ ${RELOCATING-0} : { *(.libnix___INIT_LIST__) }
+  .libnix___EXIT_LIST__ ${RELOCATING-0} : { *(.libnix___EXIT_LIST__) }
+  .libnix___LIB_LIST__  ${RELOCATING-0} : { *(.libnix___LIB_LIST__)  }
 }
 EOF
diff --git a/libiberty/config/mh-amigaos b/libiberty/config/mh-amigaos
new file mode 100644
index 0000000000000000000000000000000000000000..495fa7e35897000efe600c9f1dd844b086731fcd
--- /dev/null
+++ libiberty/config/mh-amigaos
@@ -0,0 +1,12 @@
+# Host makefile fragment for Commodore Amiga running AmigaOS.
+
+# We don't actually use libmmalloc.a, since there is no sbrk(),
+# but this allows us to compile it (and then ignore it).
+MMALLOC=
+MMALLOC_DISABLE = -DNO_MMALLOC
+
+# There is no standard system compiler.  Assume using GNU C.
+#CC = gcc
+
+# Compile for automatic stack extension.
+#HDEFINES = -mstackextend
diff --git a/libiberty/config/mh-morphos b/libiberty/config/mh-morphos
new file mode 100644
index 0000000000000000000000000000000000000000..064647ab3397b088317905a47cce0171e25a4bae
--- /dev/null
+++ libiberty/config/mh-morphos
@@ -0,0 +1,12 @@
+# Host makefile fragment for Commodore Amiga running AmigaOS.
+
+# We don't actually use libmmalloc.a, since there is no sbrk(),
+# but this allows us to compile it (and then ignore it).
+MMALLOC=
+MMALLOC_DISABLE = -DNO_MMALLOC
+
+# There is no standard system compiler.  Assume using GNU C.
+CC = gcc
+
+# Compile for automatic stack extension.
+HDEFINES =
diff --git a/libiberty/lrealpath.c b/libiberty/lrealpath.c
index b27c8de990e974c7294dfc4024ef44fbd3844a52..e94add4802d830aa3e04c9a784a8d081938ae0d5 100644
--- libiberty/lrealpath.c
+++ libiberty/lrealpath.c
@@ -69,12 +69,18 @@ extern char *canonicalize_file_name (const char *);
 # if defined (_WIN32)
 #  define WIN32_LEAN_AND_MEAN
 #  include <windows.h> /* for GetFullPathName */
 # endif
 #endif
 
+/* OS4 does not have _PC_PATH_MAX so we use the
+   REALPATH_LIMIT method only */
+#if defined(__amigaos4__)
+#undef HAVE_REALPATH
+#endif
+
 char *
 lrealpath (const char *filename)
 {
   /* Method 1: The system has a compile time upper bound on a filename
      path.  Use that and realpath() to canonicalize the name.  This is
      the most common case.  Note that, if there isn't a compile time
diff --git a/opcodes/m68k-dis.c b/opcodes/m68k-dis.c
index bc2dd491592e56fb664cdf96fc32491c08e1e075..bc40541b7c5aecc30a7a74fd61f29225acd21fcd 100644
--- opcodes/m68k-dis.c
+++ opcodes/m68k-dis.c
@@ -36,13 +36,13 @@ const char * const fpcr_names[] =
   "%fpiar/%fpcr", "%fpsr/%fpcr", "%fpiar/%fpsr/%fpcr"
 };
 
 static char *const reg_names[] =
 {
   "%d0", "%d1", "%d2", "%d3", "%d4", "%d5", "%d6", "%d7",
-  "%a0", "%a1", "%a2", "%a3", "%a4", "%a5", "%fp", "%sp",
+  "%a0", "%a1", "%a2", "%a3", "%a4", "%a5", "%a6", "%sp",
   "%ps", "%pc"
 };
 
 /* Name of register halves for MAC/EMAC.
    Seperate from reg_names since 'spu', 'fpl' look weird.  */
 static char *const reg_half_names[] =
-- 
2.1.4
