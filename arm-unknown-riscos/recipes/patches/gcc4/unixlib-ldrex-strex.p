Backport r7043 from upstream: partially replaces use of SWP with LDREX/STREX
on systems where SWP is no longer available. This fix is incomplete, 
but sufficient for our purposes.

Fri Mar 11 14:51:54 GMT  2016  Lee Noar  <leenoar@sky.com>

        * sys/_cpucaps.s: New file. Provide functions to probe the
        OS for details of the CPU (currently SWP, LDREX/STREX
        availability).
        * Makefile.am: Add above file.
        * include/unixlib/local.h: Add declarations for user facing
        functions provided above.
        * incl-local/internal/asm_dec.s(__ul_global): Add entry to
        record CPU flags.
        * incl-local/internal/unix.h: Likewise.
        * pthread/_ints.s(__pthread_disable_ints,__pthread_protect_unsafe):
        Use CPU flags to determine whether to use the SWP instruction or
        LRDEX/STREX.
        * sys/_syslib.s(__main): Add call to __probe_cpu_caps.
        (__unixlib_fatal): Use CPU flags to determine whether to use the
        SWP instruction or LRDEX/STREX.


Index: gcc4/recipe/files/gcc/libunixlib/pthread/_ints.s
===================================================================
--- gcc4/recipe/files/gcc/libunixlib/pthread/_ints.s	(revision 7042)
+++ gcc4/recipe/files/gcc/libunixlib/pthread/_ints.s	(revision 7043)
@@ -2,7 +2,7 @@
 @ disable_ints can be called multiple times, provided enable_ints is
 @ subsequently called an equal number of times
 @ Written by Martin Piper and Alex Waugh
-@ Copyright (c) 2002-2008 UnixLib Developers
+@ Copyright (c) 2002-2016 UnixLib Developers
 
 #include "internal/asm_dec.s"
 
@@ -20,15 +20,26 @@
  PICEQ "LDR	a2, [a2, #0]"
  PICEQ "LDR	a2, [a2, #__GOTT_INDEX__]"	@ a2 = GOT ptr
 
-	LDR	a1, .L0			@=__ul_global
+	LDR	a1, .L0				@ =__ul_global
  PICEQ "LDR	a1, [a2, a1]"
+	LDR	a4, [a1, #GBL_CPU_FLAGS]
 	ADD	a1, a1, #GBL_PTH_WORKSEMAPHORE
+	TST	a4, #__CPUCAP_HAVE_SWP
+	@ From this point onwards we will not be interrupted by the callback
+	BEQ	0f
+
 	MOV	a3, #1
 	SWP	a2, a3, [a1]
-	@ From this point onwards we will not be interrupted by the callback
 	ADD	a2, a2, #1
 	STR	a2, [a1]
 	MOV	pc, lr
+0:
+	LDREX	a2, [a1]
+	ADD	a2, a2, #1
+	STREX	a3, a2, [a1]
+	TEQ	a3, #1
+	BEQ	0b
+	MOV	pc, lr
 .L0:
 	WORD	__ul_global
 	DECLARE_FUNCTION __pthread_disable_ints
@@ -78,18 +89,32 @@
  PICEQ "LDR	a1, [a1, #0]"
  PICEQ "LDR	a1, [a1, #__GOTT_INDEX__]"	@ a1 = GOT ptr
 
-	LDR	a4, .L2			@=__ul_global
+	LDR	a4, .L2				@ =__ul_global
  PICEQ "LDR	a4, [a1, a4]"
+	LDR	a2, [a4, #GBL_CPU_FLAGS]
 	ADD	a1, a4, #GBL_PTH_WORKSEMAPHORE
+	TST	a2, #__CPUCAP_HAVE_SWP
+	@ From this point onwards we cannot be interrupted by the callback
+	BEQ	0f
+
 	MOV	a2, #1
 	SWP	a3, a2, [a1]
-	@ From this point onwards we cannot be interrupted by the callback
 	CMP	a3, #0
-	STRNE	a3, [a1, #0]	@ Restore original value
+	BEQ	1f
+	STR	a3, [a1, #0]	@ Restore original value
 	@ Return, as if ints are disabled on entry to the
 	@ calling function then they should not be reenabled
 	@ until the calling function has returned
+	MOV	pc, lr
+0:
+	LDREX	a3, [a1]
+	MOV	ip, #1
+	STREX	a2, ip, [a1]
+	TEQ	a2, #1
+	BEQ	0b
+	TEQ	a3, #0
 	MOVNE	pc, lr
+1:
 
 #if __UNIXLIB_PARANOID
 	LDR	a3, [a4, #GBL_PTH_RETURN_ADDRESS]
Index: gcc4/recipe/files/gcc/libunixlib/include/unixlib/local.h
===================================================================
--- gcc4/recipe/files/gcc/libunixlib/include/unixlib/local.h	(revision 7042)
+++ gcc4/recipe/files/gcc/libunixlib/include/unixlib/local.h	(revision 7043)
@@ -133,6 +133,16 @@
    socket.  Is -1 when socket handle is not valid.  */
 extern int __get_ro_socket (int __sockfd);
 
+/* Return 1 if the SWP instruction is available, otherwise 0.  */
+extern unsigned int __cpucap_have_swp (void);
+
+/* Return 1 if the LDREX/STREX instructions are available, otherwise 0.  */
+extern unsigned int __cpucap_have_rex (void);
+
+/* Return 1 if the LDREX/STREX instructions that operate on bytes, half-words
+   and double words are available, otherwise 0.  */
+extern unsigned int __cpucap_have_rexbhd (void);
+
 __END_DECLS
 
 #endif
 	* incl-local/internal/asm_dec.s(XSOM_DeregisterClient): Add
Index: gcc4/recipe/files/gcc/libunixlib/Makefile.am
===================================================================
--- gcc4/recipe/files/gcc/libunixlib/Makefile.am	(revision 7042)
+++ gcc4/recipe/files/gcc/libunixlib/Makefile.am	(revision 7043)
@@ -1027,6 +1027,7 @@
 	sys/sigsetjmp.c \
 	sys/stackalloc.c \
 	sys/vfork.c \
+	sys/_cpucaps.s \
 	sys/_getcpuarch.s \
 	sys/_jmp.s \
 	sys/_mman.s \
Index: gcc4/recipe/files/gcc/libunixlib/incl-local/internal/asm_dec.s
===================================================================
--- gcc4/recipe/files/gcc/libunixlib/incl-local/internal/asm_dec.s	(revision 7042)
+++ gcc4/recipe/files/gcc/libunixlib/incl-local/internal/asm_dec.s	(revision 7043)
@@ -269,8 +269,10 @@
 .set	GBL_FLS_LBSTM_ON_RD, 108	@ = __ul_global.fls_lbstm_on_rd
 .set	GBL_PTH_CALLEVERY_RMA, 112	@ = __ul_global.pthread_callevery_rma
 
+.set	GBL_CPU_FLAGS, 116		@ = __ul_global.cpu_flags
+
 #if !defined(__SOFTFP__) && defined(__VFP_FP__)
-.set	GBL_VFP_REGCOUNT, 116		@ = __ul_global.vfp_regcount
+.set	GBL_VFP_REGCOUNT, 120		@ = __ul_global.vfp_regcount
 #endif
 
 	@ Entries in the __ul_memory table.  Must be kept in sync with
@@ -322,3 +324,7 @@
 .set	CRT1_LIB_FINI, 32	@ Ptr to function to finalise shared libraries
 				@ at program exit - can be NULL.
 #endif
+
+#define __CPUCAP_HAVE_SWP    0x1
+#define __CPUCAP_HAVE_REX    0x2
+#define __CPUCAP_HAVE_REXBHD 0x4
Index: gcc4/recipe/files/gcc/libunixlib/incl-local/internal/unix.h
===================================================================
--- gcc4/recipe/files/gcc/libunixlib/incl-local/internal/unix.h	(revision 7042)
+++ gcc4/recipe/files/gcc/libunixlib/incl-local/internal/unix.h	(revision 7043)
@@ -197,6 +197,8 @@
     the life of the program. This block is passed to the call_every handler in
     r12.  */
 
+  unsigned int cpu_flags; /* Flags indicating the capabilities of the CPU.  */
+
 #if !defined(__SOFTFP__) && defined(__VFP_FP__)
   int vfp_regcount; /* Number of doubleword registers we should request for
     VFP contexts */
Index: gcc4/recipe/files/gcc/libunixlib/sys/_cpucaps.s
===================================================================
--- gcc4/recipe/files/gcc/libunixlib/sys/_cpucaps.s	(revision 0)
+++ gcc4/recipe/files/gcc/libunixlib/sys/_cpucaps.s	(revision 7043)
@@ -0,0 +1,91 @@
+@ Determine the capabilities of the CPU and allow callers to enquire
+@ what they are.
+@ Copyright (c) 2016 UnixLib Developers.
+@ Written by Lee Noar.
+
+#include "internal/asm_dec.s"
+
+	.text
+
+@ Determine what the CPU capabilities are, and record them.
+@ Called early on during program initialisation in _syslib.s.
+	.global __probe_cpu_caps
+	NAME	__probe_cpu_caps
+__probe_cpu_caps:
+	MOV	r0, #0
+	SWI	XOS_PlatformFeatures
+	MOVVS	r0, #0
+
+	MOV	r2, #0
+	@ The OS flag is set to 1 to indicate _no_ SWP instruction available (for
+	@ backwards compatibility). We reverse it here and set our flag to 1 to
+	@ indicate that SWP _is_ available.
+	TST	r0, #1<<11			@ SWP{B} not available
+	ORREQ	r2, r2, #__CPUCAP_HAVE_SWP
+	TST	r0, #1<<12			@ LDREX/STREX available
+	ORRNE	r2, r2, #__CPUCAP_HAVE_REX
+	TST	r0, #1<<13			@ LDREX/STREX{B/H/D} available
+	ORRNE	r2, r2, #__CPUCAP_HAVE_REXBHD
+
+ PICEQ "LDR	r0, =__GOTT_BASE__"
+ PICEQ "LDR	r0, [r0, #0]"
+ PICEQ "LDR	r0, [r0, #__GOTT_INDEX__]"	@ r0 = GOT ptr
+	LDR	r1, .L0				@ =__ul_global
+ PICEQ "LDR	r1, [r0, r1]"
+	STR	r2, [r1, #GBL_CPU_FLAGS]
+
+	MOV	pc, lr
+.L0:
+	WORD	__ul_global
+	DECLARE_FUNCTION __probe_cpu_caps
+
+	.global	__cpucap_have_swp
+	NAME	__cpucap_have_swp
+__cpucap_have_swp:
+ PICEQ "LDR	r0, =__GOTT_BASE__"
+ PICEQ "LDR	r0, [r0, #0]"
+ PICEQ "LDR	r0, [r0, #__GOTT_INDEX__]"	@ r0 = GOT ptr
+	LDR	r1, .L0				@ =__ul_global
+ PICEQ "LDR	r1, [r0, r1]"
+	LDR	r0, [r1, #GBL_CPU_FLAGS]
+	TST	r0, #__CPUCAP_HAVE_SWP
+	MOVEQ	r0, #0
+	MOVNE	r0, #1
+
+	MOV	pc, lr
+	DECLARE_FUNCTION __cpucap_have_swp
+
+@ Return 1 if LDREX/STREX instructions are available on the CPU, otherwise 0.
+	.global	__cpucap_have_rex
+	NAME	__cpucap_have_rex
+__cpucap_have_rex:
+ PICEQ "LDR	r0, =__GOTT_BASE__"
+ PICEQ "LDR	r0, [r0, #0]"
+ PICEQ "LDR	r0, [r0, #__GOTT_INDEX__]"	@ r0 = GOT ptr
+	LDR	r1, .L0				@ =__ul_global
+ PICEQ "LDR	r1, [r0, r1]"
+	LDR	r0, [r1, #GBL_CPU_FLAGS]
+	TST	r0, #__CPUCAP_HAVE_REX
+	MOVEQ	r0, #0
+	MOVNE	r0, #1
+
+	MOV	pc, lr
+	DECLARE_FUNCTION __cpucap_have_rex
+
+@ Return 1 if LDREX/STREX instructions that work on non-32 bit data sizes
+@ are available on the CPU, otherwise 0.
+	.global	__cpucap_have_rexbhd
+	NAME	__cpucap_have_rexbhd
+__cpucap_have_rexbhd:
+ PICEQ "LDR	r0, =__GOTT_BASE__"
+ PICEQ "LDR	r0, [r0, #0]"
+ PICEQ "LDR	r0, [r0, #__GOTT_INDEX__]"	@ r0 = GOT ptr
+	LDR	r1, .L0				@ =__ul_global
+ PICEQ "LDR	r1, [r0, r1]"
+	LDR	r0, [r1, #GBL_CPU_FLAGS]
+	TST	r0, #__CPUCAP_HAVE_REXBHD
+	MOVEQ	r0, #0
+	MOVNE	r0, #1
+
+	MOV	pc, lr
+	DECLARE_FUNCTION __cpucap_have_rexbhd
Index: gcc4/recipe/files/gcc/libunixlib/sys/_syslib.s
===================================================================
--- gcc4/recipe/files/gcc/libunixlib/sys/_syslib.s	(revision 7042)
+++ gcc4/recipe/files/gcc/libunixlib/sys/_syslib.s	(revision 7043)
@@ -255,6 +255,8 @@
 	BCC	__exit_with_error_num
 unknown_cpu_arch:
 
+	BL	__probe_cpu_caps
+
 	@ Use of DAs explicitly overridden if __dynamic_no_da is declared
 	MOV	lr, #-1
 	STR	lr, [ip, #GBL_DYNAMIC_NUM]
@@ -1286,9 +1288,21 @@
 	@ error handling.  As last resort to avoid an infinite loop
 	@ we go for a straight OS_Exit scenario.  Anything better we
 	@ can do ?
+	ADD	a3, a4, #GBL_PANIC_MODE
+	LDR	a2, [a4, #GBL_CPU_FLAGS]
+	TST	a2, #__CPUCAP_HAVE_SWP
+	BEQ	0f
+
 	MOV	a2, #1
-	ADD	a3, a4, #GBL_PANIC_MODE
 	SWP	a2, a2, [a3]
+	B	1f
+0:
+	LDREX	a2, [a3]
+	MOV	ip, #1
+	STREX	lr, ip, [a3]
+	TEQ	lr, #1
+	BEQ	0b
+1:
 	TEQ	a2, #0
 	BEQ	__unixlib_fatal_cont1
 
