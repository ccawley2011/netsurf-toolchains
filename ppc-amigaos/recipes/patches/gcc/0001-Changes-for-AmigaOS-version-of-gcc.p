From eecb39df390b5b8cd36a8a417f61d4afba24c187 Mon Sep 17 00:00:00 2001
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Tue, 17 Feb 2015 20:25:55 +0100
Subject: [PATCH 1/6] Changes for AmigaOS version of gcc.

---
 fixincludes/configure                 |    1 +
 fixincludes/configure.ac              |    1 +
 gcc/Makefile.in                       |    1 +
 gcc/c-family/c-common.c               |   26 +
 gcc/c/c-typeck.c                      |   25 +
 gcc/config.gcc                        |    8 +
 gcc/config.host                       |    6 +
 gcc/config/rs6000/amigaos-protos.h    |   41 +
 gcc/config/rs6000/amigaos.c           |  466 +++++++++
 gcc/config/rs6000/amigaos.h           |  431 ++++++++
 gcc/config/rs6000/amigaos.opt         |   37 +
 gcc/config/rs6000/rs6000-builtin.def  |    7 +
 gcc/config/rs6000/rs6000.c            |  176 +++-
 gcc/config/rs6000/rs6000.h            |    3 +
 gcc/config/rs6000/rs6000.md           |   27 +-
 gcc/config/rs6000/t-amigaos           |   20 +
 gcc/cp/typeck.c                       |   16 +
 gcc/doc/extend.texi                   |  167 +++
 gcc/doc/invoke.texi                   |  136 +++
 gcc/expr.c                            |    1 -
 gcc/gcc.c                             |   12 +-
 gcc/prefix.c                          |    2 +-
 intl/dcigettext.c                     |    2 +
 libcpp/line-map.c                     |    3 +
 libgcc/config.host                    |    3 +
 libgcc/config/rs6000/t-amigaos        |   45 +
 libiberty/Makefile.in                 |    9 +
 libiberty/basename.c                  |   21 +-
 libiberty/configure                   |    1 +
 libiberty/configure.ac                |    1 +
 libiberty/lrealpath.c                 |    3 +-
 libiberty/make-relative-prefix.c      |   37 +-
 libiberty/make-temp-file.c            |   27 +-
 libiberty/pex-amigaos.c               |  325 ++++++
 libstdc++-v3/configure                | 1852 ++++++++++++++++++++++++++++++++-
 libstdc++-v3/configure.ac             |    3 +
 libstdc++-v3/crossconfig.m4           |    8 +
 libstdc++-v3/include/c_global/cstddef |    3 +
 libstdc++-v3/include/c_std/cstddef    |    3 +
 39 files changed, 3879 insertions(+), 77 deletions(-)
 create mode 100644 gcc/config/rs6000/amigaos-protos.h
 create mode 100644 gcc/config/rs6000/amigaos.c
 create mode 100644 gcc/config/rs6000/amigaos.h
 create mode 100644 gcc/config/rs6000/amigaos.opt
 create mode 100644 gcc/config/rs6000/t-amigaos
 create mode 100644 libgcc/config/rs6000/t-amigaos
 create mode 100644 libiberty/pex-amigaos.c

diff --git a/fixincludes/configure b/fixincludes/configure
index 4836cd886537e9cdf73ef2bb064bfa581fc1068a..6bee1a37ee30a1c12a8f41f05c21d956d1be1a09 100755
--- fixincludes/configure
+++ fixincludes/configure
@@ -4712,12 +4712,13 @@ else
 fi
 else
   case $host in
 	i?86-*-msdosdjgpp* | \
 	i?86-*-mingw32* | \
 	x86_64-*-mingw32* | \
+	*-*-amigaos* | \
 	*-*-beos* | \
         *-*-*vms*)
 		TARGET=twoprocess
 		;;
 
 	* )
diff --git a/fixincludes/configure.ac b/fixincludes/configure.ac
index f8f352fb7153445782727eb3311d4305f33fa260..66a501d80528fdd50b4cd2f9f3282e3c562bf2e2 100644
--- fixincludes/configure.ac
+++ fixincludes/configure.ac
@@ -50,12 +50,13 @@ else
 	TARGET=oneprocess
 fi],
 [case $host in
 	i?86-*-msdosdjgpp* | \
 	i?86-*-mingw32* | \
 	x86_64-*-mingw32* | \
+	*-*-amigaos* | \
 	*-*-beos* | \
         *-*-*vms*)
 		TARGET=twoprocess
 		;;
 
 	* )
diff --git a/gcc/Makefile.in b/gcc/Makefile.in
index 07c6f0af71749b653c16ef7843a191e0bd9aa95d..c464690a51e62c8ba92fa3543dccb70488bd12f9 100644
--- gcc/Makefile.in
+++ gcc/Makefile.in
@@ -1972,12 +1972,13 @@ default-c.o: config/default-c.c
 CFLAGS-prefix.o += -DPREFIX=\"$(prefix)\" -DBASEVER=$(BASEVER_s)
 prefix.o: $(BASEVER)
 
 # Language-independent files.
 
 DRIVER_DEFINES = \
+  -DEXEC_PREFIX=\"$(exec_prefix)/\" \
   -DSTANDARD_STARTFILE_PREFIX=\"$(unlibsubdir)/\" \
   -DSTANDARD_EXEC_PREFIX=\"$(libdir)/gcc/\" \
   -DSTANDARD_LIBEXEC_PREFIX=\"$(libexecdir)/gcc/\" \
   -DDEFAULT_TARGET_VERSION=\"$(version)\" \
   -DDEFAULT_REAL_TARGET_MACHINE=\"$(real_target_noncanonical)\" \
   -DDEFAULT_TARGET_MACHINE=\"$(target_noncanonical)\" \
diff --git a/gcc/c-family/c-common.c b/gcc/c-family/c-common.c
index 117f89c023842aa8ea10a6a94088f4095246d9e3..4e1bbf417e6b774bdaa6c01dccef933fc73505ea 100644
--- gcc/c-family/c-common.c
+++ gcc/c-family/c-common.c
@@ -381,12 +381,13 @@ static tree handle_vector_size_attribute (tree *, tree, tree, int,
 					  bool *);
 static tree handle_nonnull_attribute (tree *, tree, tree, int, bool *);
 static tree handle_nothrow_attribute (tree *, tree, tree, int, bool *);
 static tree handle_cleanup_attribute (tree *, tree, tree, int, bool *);
 static tree handle_warn_unused_result_attribute (tree *, tree, tree, int,
 						 bool *);
+static tree handle_libcall_attribute (tree *, tree, tree, int, bool *);
 static tree handle_sentinel_attribute (tree *, tree, tree, int, bool *);
 static tree handle_type_generic_attribute (tree *, tree, tree, int, bool *);
 static tree handle_alloc_size_attribute (tree *, tree, tree, int, bool *);
 static tree handle_alloc_align_attribute (tree *, tree, tree, int, bool *);
 static tree handle_assume_aligned_attribute (tree *, tree, tree, int, bool *);
 static tree handle_target_attribute (tree *, tree, tree, int, bool *);
@@ -755,12 +756,17 @@ const struct attribute_spec c_common_attribute_table[] =
 			      handle_nothrow_attribute, false },
   { "may_alias",	      0, 0, false, true, false, NULL, false },
   { "cleanup",		      1, 1, true, false, false,
 			      handle_cleanup_attribute, false },
   { "warn_unused_result",     0, 0, false, true, true,
 			      handle_warn_unused_result_attribute, false },
+  { "libcall",                0, 0, false, true,  true,
+                              handle_libcall_attribute, false },
+  /* Similiar to libcall but doesn't imply linearvarargs. Can be handled as libcall here. */
+  { "libcall2",               0, 0, false, true,  true,
+                              handle_libcall_attribute, false },
   { "sentinel",               0, 1, false, true, true,
 			      handle_sentinel_attribute, false },
   /* For internal use (marking of builtins) only.  The name contains space
      to prevent its usage in source code.  */
   { "type generic",           0, 0, false, true, true,
 			      handle_type_generic_attribute, false },
@@ -9218,12 +9224,32 @@ handle_warn_unused_result_attribute (tree *node, tree name,
       *no_add_attrs = true;
     }
 
   return NULL_TREE;
 }
 
+/* Handle a "libcall" attribute.  No special handling.  */
+
+static tree
+handle_libcall_attribute (tree *node, tree name,
+       tree args ATTRIBUTE_UNUSED, int flags ATTRIBUTE_UNUSED,
+       bool *no_add_attrs)
+{
+  if (TREE_CODE (*node) != FUNCTION_TYPE
+      && TREE_CODE (*node) != METHOD_TYPE
+      && TREE_CODE (*node) != FIELD_DECL
+      && TREE_CODE (*node) != TYPE_DECL)
+    {
+      warning (OPT_Wattributes,"%qs attribute only applies to functions",
+              IDENTIFIER_POINTER (name));
+      *no_add_attrs = true;
+    }
+
+   return NULL_TREE;
+}
+
 /* Handle a "sentinel" attribute.  */
 
 static tree
 handle_sentinel_attribute (tree *node, tree name, tree args,
 			   int ARG_UNUSED (flags), bool *no_add_attrs)
 {
diff --git a/gcc/c/c-typeck.c b/gcc/c/c-typeck.c
index ffba66bb6c4cf935bc86fc3896fadcc5e40023a7..a98622b16f546b88eb7fdce9ca7631c3ca37470a 100644
--- gcc/c/c-typeck.c
+++ gcc/c/c-typeck.c
@@ -2888,12 +2888,14 @@ build_function_call_vec (location_t loc, vec<location_t> arg_loc,
   tree fntype, fundecl = 0;
   tree name = NULL_TREE, result;
   tree tem;
   int nargs;
   tree *argarray;
 
+  vec<tree, va_gc> *new_params = NULL;
+  vec<tree, va_gc> *new_origtypes = NULL;
 
   /* Strip NON_LVALUE_EXPRs, etc., since we aren't using as an lvalue.  */
   STRIP_TYPE_NOPS (function);
 
   /* Convert anything with function type to a pointer-to-function.  */
   if (TREE_CODE (function) == FUNCTION_DECL)
@@ -2950,12 +2952,35 @@ build_function_call_vec (location_t loc, vec<location_t> arg_loc,
   if (fundecl && TREE_THIS_VOLATILE (fundecl))
     current_function_returns_abnormally = 1;
 
   /* fntype now gets the type of function pointed to.  */
   fntype = TREE_TYPE (fntype);
 
+  if (lookup_attribute ("libcall", TYPE_ATTRIBUTES (fntype)) ||
+      lookup_attribute ("libcall2", TYPE_ATTRIBUTES (fntype)))
+  {
+	if (TREE_CODE (function) == COMPONENT_REF && lvalue_p (function))
+	{
+		/* We copy the involved vectors here, as adding an element may
+		 * free the original pointer, but we are not the owner of those.
+		 *
+		 * FIXME: At the moment, we don't free the memory allocated here
+		 * If it is freed at the exit of the function via VEC_free() in
+		 * some cases a segfault occurs */
+		params = new_params = vec_safe_copy(params);
+		origtypes = new_origtypes = vec_safe_copy(origtypes);
+
+		/* Type of 0 operand of a component ref is always a dereferenced object but
+		 * we need to pass the address of this object */
+		vec_safe_insert(params,0,
+			build1(ADDR_EXPR, build_pointer_type (TREE_TYPE (TREE_OPERAND (function, 0))),
+				TREE_OPERAND (function, 0)));
+		vec_safe_insert(origtypes,0,(tree)NULL);
+	}
+  }
+
   /* Convert the parameters to the types declared in the
      function prototype, or apply default promotions.  */
 
   nargs = convert_arguments (loc, arg_loc, TYPE_ARG_TYPES (fntype), params,
 			     origtypes, function, fundecl);
   if (nargs < 0)
diff --git a/gcc/config.gcc b/gcc/config.gcc
index c835734128b0aef5a0b558ccd7ad24fd17bb9bee..6fcd952f5235f04160e5de45aff781993bf120a1 100644
--- gcc/config.gcc
+++ gcc/config.gcc
@@ -2245,12 +2245,20 @@ nvptx-*)
 	fi
 	;;
 pdp11-*-*)
 	tm_file="${tm_file} newlib-stdint.h"
 	use_gcc_stdint=wrap
 	;;
+powerpc-*-amigaos*)
+	tm_file="${tm_file} dbxelf.h elfos.h rs6000/sysv4.h rs6000/amigaos.h"
+	tm_p_file="${tm_p_file} rs6000/amigaos-protos.h"
+	extra_options="${extra_options} rs6000/sysv4.opt rs6000/amigaos.opt"
+	tmake_file="rs6000/t-amigaos"
+	extra_objs=amigaos.o
+	use_collect2=no
+	;;
 # port not yet contributed
 #powerpc-*-openbsd*)
 #	tmake_file="${tmake_file} rs6000/t-fprules"
 #	extra_headers=
 #	;;
 powerpc-*-darwin*)
diff --git a/gcc/config.host b/gcc/config.host
index b0f5940c26379ebc75e0ca462cbb2cb01dabd2fa..51675e166b9833d327ec43fcca67d6a2b3560068 100644
--- gcc/config.host
+++ gcc/config.host
@@ -242,12 +242,18 @@ case ${host} in
     exit 1
     ;;
   i[34567]86-*-darwin* | x86_64-*-darwin*)
     out_host_hook_obj="${out_host_hook_obj} host-i386-darwin.o"
     host_xmake_file="${host_xmake_file} i386/x-darwin"
     ;;
+  powerpc-*-amigaos*) # AmigaOS 4
+    prefix=/gcc
+    local_prefix=/gcc
+    host_can_use_collect2=no
+    host_xm_defines=HOST_LACKS_INODE_NUMBERS
+    ;;
   powerpc-*-beos*)
     host_can_use_collect2=no
     ;;
   powerpc-*-darwin*)
     out_host_hook_obj="${out_host_hook_obj} host-ppc-darwin.o"
     host_xmake_file="${host_xmake_file} rs6000/x-darwin"
diff --git a/gcc/config/rs6000/amigaos-protos.h b/gcc/config/rs6000/amigaos-protos.h
new file mode 100644
index 0000000000000000000000000000000000000000..eb5f8fc5f3d546b8d8e1cdd8118a3085079df50e
--- /dev/null
+++ gcc/config/rs6000/amigaos-protos.h
@@ -0,0 +1,41 @@
+/* Prototypes.
+   Copyright (C) 2003 Free Software Foundation, Inc.
+
+   This file is part of GCC.
+
+   GCC is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published
+   by the Free Software Foundation; either version 2, or (at your
+   option) any later version.
+
+   GCC is distributed in the hope that it will be useful, but WITHOUT
+   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+   License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with GCC; see the file COPYING.  If not, write to the
+   Free Software Foundation, 59 Temple Place - Suite 330, Boston,
+   MA 02111-1307, USA.  */
+
+
+//#ifdef RTX_CODE
+//#ifdef TREE_CODE
+
+extern void amigaos_init_cumulative_args (CUMULATIVE_ARGS *, tree, rtx, int, int);
+extern void amigaos_function_arg_advance (CUMULATIVE_ARGS *, enum machine_mode, tree, int);
+extern struct rtx_def *amigaos_function_arg (CUMULATIVE_ARGS *, enum machine_mode, tree, int);
+extern void amigaos_expand_builtin_va_start (tree valist, rtx nextarg);
+extern struct rtx_def *amigaos_expand_builtin_saveregs (void);
+extern void amigaos_init_builtins (void);
+extern rtx amigaos_expand_builtin (tree, rtx, rtx, enum machine_mode, int, bool*);
+extern tree amigaos_handle_linearvarargs_attribute (tree *, tree, tree, int, bool*);
+extern tree amigaos_handle_baserel_restore_attribute (tree *, tree, tree, int, bool*);
+extern tree amigaos_handle_force_no_baserel_attribute (tree *, tree, tree, int, bool*);
+extern tree amigaos_handle_check68kfuncptr_attribute (tree *, tree, tree, int, bool*);
+extern rtx amigaos_legitimize_baserel_address (rtx addr);
+extern int amigaos_baserel_operand(rtx x);
+extern int amigaos_not_baserel_tree_p(tree decl);
+
+//#endif /* TREE_CODE */
+//#endif /* RTX_CODE */
diff --git a/gcc/config/rs6000/amigaos.c b/gcc/config/rs6000/amigaos.c
new file mode 100644
index 0000000000000000000000000000000000000000..0f575a38e4dc4aac0b454c56bf62f625c0f7eb9c
--- /dev/null
+++ gcc/config/rs6000/amigaos.c
@@ -0,0 +1,466 @@
+/* Subroutines used for code generation on Amiga OS 4
+   Copyright (C) 2003 Free Software Foundation, Inc.
+   Contributed by Thomas Frieden (ThomasF@hyperion-entertainment.com)
+
+   This file is part of GCC.
+
+   GCC is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published
+   by the Free Software Foundation; either version 2, or (at your
+   option) any later version.
+
+   GCC is distributed in the hope that it will be useful, but WITHOUT
+   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+   License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with GCC; see the file COPYING.  If not, write to the
+   Free Software Foundation, 59 Temple Place - Suite 330, Boston,
+   MA 02111-1307, USA.  */
+
+
+#include "config.h"
+#include "system.h"
+#include "coretypes.h"
+#include "diagnostic-core.h"
+#include "tm.h"
+#include "hash-set.h"
+#include "inchash.h"
+#include "rtl.h"
+#include "regs.h"
+#include "hard-reg-set.h"
+#include "real.h"
+#include "insn-config.h"
+#include "conditions.h"
+#include "insn-flags.h"
+#include "insn-attr.h"
+#include "flags.h"
+#include "recog.h"
+#include "obstack.h"
+#include "symtab.h"
+#include "tree.h"
+#include "expr.h"
+#include "optabs.h"
+#include "except.h"
+#include "function.h"
+#include "output.h"
+#include "tm_p.h"
+#include "fold-const.h"
+#include "langhooks.h"
+#include "explow.h"
+
+#undef DEBUG
+#ifdef DEBUG
+#define dprintf(...)      			\
+printf("%s: ", __PRETTY_FUNCTION__);		\
+printf(__VA_ARGS__)
+#else
+#define dprintf(...) /* __VA_ARGS__ */
+#endif
+
+#undef TARGET_EXPAND_BUILTIN_SAVEREGS
+#define TARGET_EXPAND_BUILTIN_SAVEREGS() \
+    amigaos_expand_builtin_saveregs ()
+
+#ifdef __amigaos4__
+static const char * __attribute__((used)) amigaos_stack_cookie = "$STACK:768000";
+#endif /* __amigaos4__ */
+
+#if 0
+const char *amigaos_crt_string;
+#endif
+
+/* Initialize a variable CUM of type CUMULATIVE_ARGS
+   for a call to a function whose data type is FNTYPE.
+   For a library call, FNTYPE is 0.
+
+   Most of the work is delegated to init_cumulative_args() in rs6000.c,
+   here we just check for special attributes and update call_cookie
+   accordingly.  */
+#if 0
+void
+amigaos_init_cumulative_args (CUMULATIVE_ARGS *cum, tree fntype,
+	rtx libname ATTRIBUTE_UNUSED, int incoming,
+	int n_named_args)
+{
+  dprintf ("enter(cum=%p,fntype=%p)\n",cum,fntype);
+  init_cumulative_args (cum, fntype, libname, incoming, FALSE, n_named_args);
+
+  /* Check if either libcall or linear varargs, set appropriate cookie */
+  if (fntype && (lookup_attribute ("libcall", TYPE_ATTRIBUTES (fntype))))
+    cum->call_cookie |= CALL_LINEARVARARGS;
+
+  if (fntype && (lookup_attribute ("linearvarargs", TYPE_ATTRIBUTES (fntype))))
+    cum->call_cookie |= CALL_LINEARVARARGS;
+
+  dprintf ("exit\n");
+}
+
+/* Update the data in CUM to advance over an argument
+   of mode MODE and data type TYPE.
+   (TYPE is null for libcalls where that information may not be available.)
+
+   If the function has the linearvarargs attribute and this argument
+   to advance over is the last non-vararg argument, then advance over
+   all registers, so that the overflow area is hit immediately.
+   Otherwise, just let function_arg_advance () from rs6000.c do its
+   thing.  */
+
+void
+amigaos_function_arg_advance (CUMULATIVE_ARGS *cum, enum machine_mode mode,
+	tree type, int named)
+{
+  dprintf ("enter\n");
+  function_arg_advance (cum, mode, type, named, 0);
+
+  if (cum->call_cookie & CALL_LINEARVARARGS && cum->nargs_prototype <= 0)
+    {
+      cum->sysv_gregno = GP_ARG_MAX_REG + 1;
+      cum->fregno = FP_ARG_V4_MAX_REG + 1;
+    }
+  dprintf ("exit\n");
+}
+
+
+/* Determine where to put an argument to a function.
+
+   Linearvarargs should always go to the stack, apart from that
+   any decision made by function_arg () in rs6000.c will be OK. */
+
+struct rtx_def *
+amigaos_function_arg (CUMULATIVE_ARGS *cum, enum machine_mode mode,
+	tree type, int named)
+{
+  struct rtx_def *res = 0;
+
+  dprintf ("enter\n");
+  if (mode == VOIDmode && cum->call_cookie & CALL_LINEARVARARGS)
+    res = GEN_INT (cum->call_cookie);
+  else
+    res = function_arg (cum, mode, type, named);
+
+  dprintf ("exit\n");
+
+  return res;
+}
+#endif
+
+/* Implement va_start.
+
+   For linearvarargs functions, immediately increase the fpr
+   and gpr count to the maximum value, so that va_arg will look
+   only at the stack. */
+#if 0
+void
+amigaos_expand_builtin_va_start (tree valist, rtx nextarg)
+{
+printf("amigaos_expand_builtin_va_start()\n");
+  rs6000_va_start (valist, nextarg);
+
+  if (crtl->args.info.call_cookie & CALL_LINEARVARARGS)
+    {
+      tree f_gpr, f_fpr;
+      tree gpr, fpr, t;
+
+      f_gpr = TYPE_FIELDS (TREE_TYPE (va_list_type_node));
+      f_fpr = TREE_CHAIN (f_gpr);
+
+      valist = build1 (INDIRECT_REF, TREE_TYPE (TREE_TYPE (valist)), valist);
+      gpr = build3 (COMPONENT_REF, TREE_TYPE (f_gpr), valist, f_gpr, NULL_TREE);
+      fpr = build3 (COMPONENT_REF, TREE_TYPE (f_fpr), valist, f_fpr, NULL_TREE);
+
+      /* Set gpr use count to 8, forcing the overflow area to be used */
+      t = build2 (MODIFY_EXPR, TREE_TYPE (gpr), gpr, build_int_cst (NULL_TREE, 8));
+      TREE_SIDE_EFFECTS (t) = 1;
+      expand_expr (t, const0_rtx, VOIDmode, EXPAND_NORMAL);
+
+      /* Likewise for floating point arguments */
+      t = build2 (MODIFY_EXPR, TREE_TYPE (fpr), fpr, build_int_cst (NULL_TREE, 8));
+      TREE_SIDE_EFFECTS (t) = 1;
+      expand_expr (t, const0_rtx, VOIDmode, EXPAND_NORMAL);
+    }
+}
+#endif
+
+/* Implement __builtin_saveregs for linearvarargs functions. */
+#if 0
+struct rtx_def *
+amigaos_expand_builtin_saveregs (void)
+{
+  rtx block, mem_gpr_fpr, mem_overflow, tmp;
+  tree fntype;
+  int stdarg_p;
+  HOST_WIDE_INT words, gpr;
+  struct rtx_def *res;
+
+  dprintf ("enter\n");
+
+  if (crtl->args.info.call_cookie & CALL_LINEARVARARGS)
+    {
+      HOST_WIDE_INT bits;
+
+      fntype = TREE_TYPE (current_function_decl);
+      stdarg_p = (TYPE_ARG_TYPES (fntype) != 0
+		  && (TREE_VALUE (tree_last (TYPE_ARG_TYPES (fntype)))
+		      != void_type_node));
+
+      /* Allocate the va_list constructor.  */
+      block = assign_stack_local (BLKmode, 3 * UNITS_PER_WORD, BITS_PER_WORD);
+      MEM_READONLY_P (block) = 1;
+      MEM_READONLY_P (XEXP (block, 0)) = 1;
+
+      mem_gpr_fpr = change_address (block, word_mode, XEXP (block, 0));
+      mem_overflow = change_address (block, ptr_mode,
+				     plus_constant (XEXP (block, 0),
+                                                UNITS_PER_WORD));
+      /*mem_reg_save_area = change_address (block, ptr_mode,
+	plus_constant (XEXP (block, 0),
+	2 * UNITS_PER_WORD));*/
+
+      /* Construct the two characters of `gpr' and `fpr' as a unit.  */
+      words = crtl->args.info.words;
+      gpr = crtl->args.info.sysv_gregno - GP_ARG_MIN_REG;
+
+      /* Varargs has the va_dcl argument, but we don't count it.  */
+      if (!stdarg_p)
+	{
+	  if (gpr > GP_ARG_NUM_REG)
+	    words -= 1;
+	}
+
+      bits = (GP_ARG_MAX_REG - GP_ARG_MIN_REG + 1) << 8
+	| (FP_ARG_MAX_REG - FP_ARG_MIN_REG + 1);
+      if (HOST_BITS_PER_WIDE_INT >= BITS_PER_WORD)
+	tmp = GEN_INT (bits << (BITS_PER_WORD - 16));
+      else
+	{
+	  bits <<= BITS_PER_WORD - HOST_BITS_PER_WIDE_INT - 16;
+	  tmp = immed_double_const (0, bits, word_mode);
+	}
+
+      emit_move_insn (mem_gpr_fpr, tmp);
+
+      /* Find the overflow area.  */
+      tmp = expand_binop (Pmode, add_optab, virtual_incoming_args_rtx,
+			  GEN_INT (words * UNITS_PER_WORD),
+			  mem_overflow, 0, OPTAB_WIDEN);
+      if (tmp != mem_overflow)
+	  emit_move_insn (mem_overflow, tmp);
+
+      /*tmp = expand_binop (Pmode, add_optab, virtual_stack_vars_rtx,
+	GEN_INT (-RS6000_VARARGS_SIZE),
+	mem_reg_save_area, 0, OPTAB_WIDEN);
+	if (tmp != mem_reg_save_area)
+	emit_move_insn (mem_reg_save_area, tmp);*/
+
+      /* Return the address of the va_list constructor.  */
+      res = XEXP (block, 0);
+    }
+  else
+    {
+      res = expand_builtin_saveregs ();
+    }
+
+  dprintf ("exit\n");
+  return res;
+}
+#endif
+
+/* Define subtarget builtins */
+
+void
+amigaos_init_builtins (void)
+{
+	tree ftype;
+  ftype = build_function_type (ptr_type_node,
+			 tree_cons (NULL_TREE,
+				    build_pointer_type (TREE_TYPE (va_list_type_node)),
+				    void_list_node));
+
+  add_builtin_function ("__builtin_getlinearva",
+		    ftype,
+		    AMIGAOS_BUILTIN_GETLINEARVA,
+		    BUILT_IN_MD, NULL, NULL_TREE);
+}
+
+
+/* Expand builtins */
+rtx
+amigaos_expand_builtin (tree exp, rtx target, rtx subtarget ATTRIBUTE_UNUSED,
+			enum machine_mode mode ATTRIBUTE_UNUSED,
+			int ignore ATTRIBUTE_UNUSED, bool *success)
+{
+  tree fndecl = TREE_OPERAND (CALL_EXPR_FN (exp), 0);
+  tree f_gpr, f_fpr, f_res, f_ovf;
+  tree arg0, valist, ovf;
+
+  unsigned int fcode = DECL_FUNCTION_CODE (fndecl);
+
+//  debug_tree(exp);
+//  debug_tree(fndecl);
+  if (fcode != AMIGAOS_BUILTIN_GETLINEARVA)
+  {
+	  *success = 0;
+	  return NULL_RTX;
+  }
+
+  if (! (crtl->args.info.call_cookie & CALL_LINEARVARARGS))
+  {
+      /* TODO: This probably should be a fatal, but then the generated executable can't be linked. */
+      error ("__builtin_getlinearva can only be used in a linearvarargs function");
+      *success = 1;
+      return 0;
+  }
+
+  arg0 = CALL_EXPR_ARG (exp, 0);
+  if (arg0 == error_mark_node)
+    return const0_rtx;
+
+  f_gpr = TYPE_FIELDS (TREE_TYPE (va_list_type_node));
+  f_fpr = TREE_CHAIN (f_gpr);
+  f_res = TREE_CHAIN (f_fpr);
+  f_ovf = TREE_CHAIN (f_res);
+  target = const0_rtx;
+  valist = build_simple_mem_ref(arg0);//build1 (INDIRECT_REF, TREE_TYPE (TREE_TYPE (arg0)), arg0);
+  ovf = build3 (COMPONENT_REF, TREE_TYPE (f_ovf), valist, f_ovf, NULL_TREE);
+  target = copy_to_reg (expand_expr (ovf, NULL_RTX, Pmode, EXPAND_NORMAL));
+  *success = 1;
+  return target;
+}
+
+/* Handle a "linearvarargs" attribute. */
+tree
+amigaos_handle_linearvarargs_attribute (tree *node, tree name,
+	tree args ATTRIBUTE_UNUSED, int flags ATTRIBUTE_UNUSED,
+	bool *no_add_attrs)
+{
+  if (TREE_CODE (*node) != FUNCTION_TYPE
+      && TREE_CODE (*node) != METHOD_TYPE
+      && TREE_CODE (*node) != FIELD_DECL
+      && TREE_CODE (*node) != TYPE_DECL)
+    {
+      warning (0, "%s attribute only applies to functions",
+	       IDENTIFIER_POINTER (name));
+      *no_add_attrs = true;
+    }
+
+  return NULL_TREE;
+}
+
+
+/* Generate code for base relative access */
+
+rtx
+amigaos_legitimize_baserel_address (rtx addr)
+{
+  rtx dest = gen_reg_rtx (Pmode);
+
+  emit_insn (gen_elf_base_high (dest, gen_rtx_REG (Pmode, 2), addr));
+  emit_insn (gen_elf_base_low (dest, dest, addr));
+
+  return dest;
+}
+
+int
+amigaos_not_baserel_tree_p(tree decl)
+{
+  return(TREE_READONLY(decl)
+         || TREE_CONSTANT(decl)
+         || (DECL_ATTRIBUTES(decl)
+             && lookup_attribute("force_no_baserel", DECL_ATTRIBUTES(decl))));
+}
+
+int
+amigaos_baserel_operand(rtx x)
+{
+  tree decl;
+  int ret = 0;
+
+  if (GET_CODE(x) == SYMBOL_REF)
+  {
+    decl = SYMBOL_REF_DECL(x);
+
+    if (decl)
+    {
+      if (SYMBOL_REF_FUNCTION_P(x) || amigaos_not_baserel_tree_p(decl))
+        ret = 0;
+      else
+        ret = 1;
+    }
+  }
+  else if (GET_CODE(x) == CONST
+           && GET_CODE(XEXP(x, 0)) == PLUS
+           && GET_CODE(XEXP(XEXP(x, 0), 0)) == SYMBOL_REF
+           && GET_CODE(XEXP(XEXP(x, 0), 1)) == CONST_INT)
+    ret = amigaos_baserel_operand(XEXP(XEXP(x, 0), 0));
+  else if (GET_CODE(x) == LO_SUM)
+    ret = amigaos_baserel_operand(XEXP(x, 1));
+
+  return ret;
+}
+
+void amigaos_function_end_prologue(FILE *file);
+void amigaos_function_end_prologue(FILE *file)
+{
+  if (TARGET_BASEREL
+      && current_function_decl
+      && lookup_attribute ("baserel_restore", TYPE_ATTRIBUTES (TREE_TYPE (current_function_decl))))
+    {
+       fprintf( file, "\tbl __baserel_get_addr\n");
+    }
+}
+
+
+tree
+amigaos_handle_baserel_restore_attribute (tree *node, tree name,
+	tree args ATTRIBUTE_UNUSED, int flags ATTRIBUTE_UNUSED,
+	bool *no_add_attrs)
+{
+  if (TREE_CODE (*node) != FUNCTION_TYPE
+      && TREE_CODE (*node) != METHOD_TYPE
+      && TREE_CODE (*node) != FIELD_DECL
+      && TREE_CODE (*node) != TYPE_DECL)
+    {
+      warning (0, "%s attribute only applies to functions",
+	       IDENTIFIER_POINTER (name));
+      *no_add_attrs = true;
+    }
+
+  return NULL_TREE;
+}
+
+tree
+amigaos_handle_force_no_baserel_attribute (tree *node, tree name,
+	tree args ATTRIBUTE_UNUSED, int flags ATTRIBUTE_UNUSED,
+	bool *no_add_attrs)
+{
+  if (TREE_CODE (*node) != VAR_DECL)
+    {
+      warning (0, "%s attribute only applies to variables",
+	       IDENTIFIER_POINTER (name));
+      *no_add_attrs = true;
+    }
+
+  return NULL_TREE;
+}
+
+/* Handle a "check68kfuncptr" attribute. */
+
+tree
+amigaos_handle_check68kfuncptr_attribute (tree *node, tree name,
+	tree args ATTRIBUTE_UNUSED, int flags ATTRIBUTE_UNUSED,
+	bool *no_add_attrs)
+{
+  if (TREE_CODE (*node) != FUNCTION_TYPE
+      && TREE_CODE (*node) != METHOD_TYPE
+      && TREE_CODE (*node) != FIELD_DECL
+      && TREE_CODE (*node) != TYPE_DECL)
+    {
+      warning (0, "%s attribute only applies to functions",
+	       IDENTIFIER_POINTER (name));
+      *no_add_attrs = true;
+    }
+
+  return NULL_TREE;
+}
diff --git a/gcc/config/rs6000/amigaos.h b/gcc/config/rs6000/amigaos.h
new file mode 100644
index 0000000000000000000000000000000000000000..4556163c22a8fadc51c9ed7401c7e6c414e58c0e
--- /dev/null
+++ gcc/config/rs6000/amigaos.h
@@ -0,0 +1,431 @@
+/* Definitions of target machine for GNU compiler, for AmigaOS.
+   Copyright (C) 1997, 2003, 2005 Free Software Foundation, Inc.
+
+   This file is part of GCC.
+
+   GCC is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published
+   by the Free Software Foundation; either version 2, or (at your
+   option) any later version.
+
+   GCC is distributed in the hope that it will be useful, but WITHOUT
+   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+   License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with GCC; see the file COPYING.  If not, write to the
+   Free Software Foundation, 59 Temple Place - Suite 330, Boston,
+   MA 02111-1307, USA.  */
+
+
+/* Don't assume anything about the header files. */
+#define NO_IMPLICIT_EXTERN_C
+
+#undef MD_EXEC_PREFIX
+#undef MD_STARTFILE_PREFIX
+
+/* Make CPU default to 604e. FIXME: Make this 750 later */
+#undef PROCESSOR_DEFAULT
+#define PROCESSOR_DEFAULT PROCESSOR_PPC604e
+
+#undef DEFAULT_ABI
+#define DEFAULT_ABI ABI_V4
+
+#undef ASM_CPU_SPEC
+#define ASM_CPU_SPEC \
+"%{!mcpu*: \
+  %{mpower: %{!mpower2: -mpwr}} \
+  %{mpower2: -mpwrx} \
+  %{mpowerpc64*: -mppc64} \
+  %{!mpowerpc64*: %{mpowerpc*: -mppc}} \
+  %{mno-power: %{!mpowerpc*: -mcom}} \
+  %{!mno-power: %{!mpower*: %(asm_default)}}} \
+%{mcpu=common: -mcom} \
+%{mcpu=power: -mpwr} \
+%{mcpu=power2: -mpwrx} \
+%{mcpu=power3: -mppc64} \
+%{mcpu=power4: -mpower4} \
+%{mcpu=power5: -mpower4} \
+%{mcpu=powerpc: -mppc} \
+%{mcpu=rios: -mpwr} \
+%{mcpu=rios1: -mpwr} \
+%{mcpu=rios2: -mpwrx} \
+%{mcpu=rsc: -mpwr} \
+%{mcpu=rsc1: -mpwr} \
+%{mcpu=rs64a: -mppc64} \
+%{mcpu=401: -mppc} \
+%{mcpu=403: -m403} \
+%{mcpu=405: -m405} \
+%{mcpu=405fp: -m405} \
+%{mcpu=440: -m440} \
+%{mcpu=440fp: -m440} \
+%{mcpu=505: -mppc} \
+%{mcpu=601: -m601} \
+%{mcpu=602: -mppc} \
+%{mcpu=603: -mppc} \
+%{mcpu=603e: -mppc} \
+%{mcpu=ec603e: -mppc} \
+%{mcpu=604: -mppc} \
+%{mcpu=604e: -mppc} \
+%{mcpu=620: -mppc64} \
+%{mcpu=630: -mppc64} \
+%{mcpu=740: -mppc} \
+%{mcpu=750: -mppc} \
+%{mcpu=G3: -mppc} \
+%{mcpu=7400: -mppc -maltivec} \
+%{mcpu=7450: -mppc -maltivec} \
+%{mcpu=G4: -mppc -maltivec} \
+%{mcpu=801: -mppc} \
+%{mcpu=821: -mppc} \
+%{mcpu=823: -mppc} \
+%{mcpu=860: -mppc} \
+%{mcpu=970: -mpower4 -maltivec} \
+%{mcpu=G5: -mpower4 -maltivec} \
+%{mcpu=8540: -me500} \
+%{maltivec: -maltivec}"
+
+#define IS_MCRT(MCRTNAME) \
+  (strcmp(amigaos_crt, MCRTNAME) == 0)
+
+/* Make most of the definitions from other compilers available */
+#undef TARGET_OS_CPP_BUILTINS
+#define TARGET_OS_CPP_BUILTINS()                \
+  do                                            \
+    {                                           \
+      builtin_define_std ("PPC");		\
+      builtin_define_std ("powerpc");		\
+      builtin_assert ("cpu=powerpc");		\
+      builtin_assert ("machine=powerpc");	\
+      builtin_define_std ("AMIGA");		\
+      builtin_define_std ("AMIGAOS");		\
+      builtin_define_std ("AMIGAOS4");		\
+      builtin_define_std ("amiga");		\
+      builtin_define_std ("amigaos");		\
+      builtin_define_std ("amigaos4");		\
+      builtin_assert ("system=amigaos");	\
+      if (!amigaos_crt)			\
+        {					\
+          error ("no CRT specified");		\
+        }					\
+      else if (IS_MCRT("clib2") || IS_MCRT("clib2-ts")) \
+        {					\
+          builtin_define_std ("CLIB2");		\
+          if (IS_MCRT("clib2-ts"))		\
+            builtin_define ("__THREAD_SAFE");	\
+        }					\
+      else if (IS_MCRT("ixemul"))		\
+        {					\
+          builtin_define_std ("ixemul");	\
+          builtin_define_std ("IXEMUL");	\
+        }					\
+      else if (IS_MCRT("libnix"))		\
+        {					\
+          builtin_define_std ("libnix");	\
+          builtin_define_std ("LIBNIX");	\
+        }					\
+      else if (IS_MCRT("newlib"))		\
+        {					\
+          builtin_define_std ("NEWLIB");	\
+        }					\
+      TARGET_OS_SYSV_CPP_BUILTINS ();		\
+    }                                           \
+  while (0)
+
+#undef CPP_SPEC
+#define CPP_SPEC "%{posix: -D_POSIX_SOURCE} %(cpp_os_default)"
+
+/*#define STANDARD_INCLUDE_DIR "/GCC/include"*/
+/*#undef SYSTEM_INCLUDE_DIR *//* So that the include path order is the same in native and cross compilers */
+#undef LOCAL_INCLUDE_DIR
+
+#ifndef CROSS_DIRECTORY_STRUCTURE
+#define BASE_GCC_SPEC "/GCC/"
+#define BASE_SDK_SPEC "/SDK/"
+#else
+#define BASE_GCC_SPEC EXEC_PREFIX
+#define BASE_SDK_SPEC EXEC_PREFIX "ppc-amigaos/SDK/"
+#endif
+
+#define LIB_SUBDIR_TYPE_SPEC "\
+%{mbaserel:/baserel; msdata|msdata=default|msdata=sysv:/small-data}\
+%{msoft-float:/soft-float}"
+
+/* default linker specs */
+#undef REAL_LIBGCC_SPEC
+#define REAL_LIBGCC_SPEC "\
+%{static|static-libgcc: %{!use-dynld: -lgcc -lgcc_eh} %{use-dynld: -lgcc} }%{!static:%{!static-libgcc:%{!shared:%{!shared-libgcc: %{!use-dynld: -lgcc -lgcc_eh} %{use-dynld: -lgcc}}%{shared-libgcc:-lgcc}}%{shared:%{shared-libgcc:-lgcc}%{!shared-libgcc:-lgcc}}}}"
+
+
+/* make newlib the default */
+#if 1
+#define CPP_AMIGA_DEFAULT_SPEC "%{mcrt=default|!mcrt=*:%<mcrt=default -mcrt=newlib} %(cpp_newlib)"
+#define LINK_AMIGA_DEFAULT_SPEC "%(link_newlib)"
+#define STARTFILE_AMIGA_DEFAULT_SPEC "%(startfile_newlib)"
+#define ENDFILE_AMIGA_DEFAULT_SPEC "%(endfile_newlib)"
+#undef MULTILIB_DEFAULTS
+#define MULTILIB_DEFAULTS {"mcrt=newlib"}
+#else
+/* make clib2 the default */
+#define CPP_AMIGA_DEFAULT_SPEC "%{mcrt=default|!mcrt=*:%<mcrt=default -mcrt=clib2} %(cpp_clib2)"
+#define LINK_AMIGA_DEFAULT_SPEC "%(link_clib2)"
+#define STARTFILE_AMIGA_DEFAULT_SPEC "%(startfile_clib2)"
+#define ENDFILE_AMIGA_DEFAULT_SPEC "%(endfile_clib2)"
+#undef MULTILIB_DEFAULTS
+#define MULTILIB_DEFAULTS {"mcrt=clib2"}
+#endif
+
+/* clib2 */
+
+#define CPP_CLIB2_SPEC "\
+-isystem %(base_sdk)clib2/include -isystem %(base_sdk)local/clib2/include"
+
+#define LIB_SUBDIR_CLIB2_SPEC "%{mcrt=clib2-ts:lib.threadsafe; :lib}%(lib_subdir_type)"
+
+#define LINK_CLIB2_SPEC "\
+-L%(base_sdk)clib2/%(lib_subdir_clib2) \
+-L%(base_gcc)lib/gcc/ppc-amigaos/%(version)/%{mcrt=clib2-ts:clib2-ts; :clib2}/lib%(lib_subdir_type) \
+-L%(base_sdk)local/clib2/%(lib_subdir_clib2)"
+
+#define STARTFILE_CLIB2_SPEC "\
+%(base_sdk)clib2/%{mcrt=clib2-ts:lib.threadsafe; :lib}" \
+                 "%{!msoft-float:%(lib_subdir_type)}/crtbegin.o \
+%(base_sdk)clib2/%{mcrt=clib2-ts:lib.threadsafe; :lib}" \
+                 "%{!msoft-float:%(lib_subdir_type)}/crt0.o"
+
+#define ENDFILE_CLIB2_SPEC "\
+%(base_sdk)clib2/%{mcrt=clib2-ts:lib.threadsafe; :lib}" \
+                 "%{!msoft-float:%(lib_subdir_type)}/crtend.o"
+
+/* ixemul */
+
+#define CPP_IXEMUL_SPEC "\
+-isystem %(base_sdk)ixemul/include -isystem %(base_sdk)local/ixemul/include"
+
+#define LIB_SUBDIR_IXEMUL_SPEC "lib%(lib_subdir_type)"
+
+#define LINK_IXEMUL_SPEC "\
+-L%(base_sdk)ixemul/%(lib_subdir_ixemul) \
+-L%(base_gcc)lib/gcc/ppc-amigaos/%(version)/ixemul/%(lib_subdir_ixemul) \
+-L%(base_sdk)local/ixemul/%(lib_subdir_ixemul)"
+
+/* ixemul startfile should work for all library flavours */
+#define STARTFILE_IXEMUL_SPEC "%(base_sdk)ixemul/%(lib_subdir_ixemul)/crtbegin.o"
+#define ENDFILE_IXEMUL_SPEC "%(base_sdk)ixemul/%(lib_subdir_ixemul)/crtend.o"
+
+/* libnix */
+
+#define CPP_LIBNIX_SPEC "\
+-isystem %(base_sdk)libnix/include -isystem %(base_sdk)local/libnix/include"
+
+#define LIB_SUBDIR_LIBNIX_SPEC "lib%(lib_subdir_type)"
+
+#define LINK_LIBNIX_SPEC "\
+-L%(base_sdk)libnix/%(lib_subdir_libnix) \
+-L%(base_gcc)lib/gcc/ppc-amigaos/%(version)/libnix/%(lib_subdir_libnix) \
+-L%(base_sdk)local/libnix/%(lib_subdir_libnix)"
+
+#define STARTFILE_LIBNIX_SPEC "%(base_sdk)libnix/%(lib_subdir_libnix)/crtbegin.o"
+#define ENDFILE_LIBNIX_SPEC "%(base_sdk)libnix/%(lib_subdir_libnix)/crtend.o"
+
+/* newlib */
+
+#define CPP_NEWLIB_SPEC "\
+-isystem %(base_sdk)newlib/include -isystem %(base_sdk)local/newlib/include"
+
+#define LIB_SUBDIR_NEWLIB_SPEC "lib%(lib_subdir_type)"
+
+#define LINK_NEWLIB_SPEC "\
+-L%(base_sdk)newlib/%(lib_subdir_newlib) \
+-L%(base_gcc)lib/gcc/ppc-amigaos/%(version)/newlib/%(lib_subdir_newlib) \
+-L%(base_sdk)local/newlib/%(lib_subdir_newlib)"
+
+/* newlib startfile should work for all library flavours */
+#define STARTFILE_NEWLIB_SPEC "\
+%{shared: %(base_sdk)newlib/%(lib_subdir_newlib)/shcrtbegin.o} %{!shared: %(base_sdk)newlib/%(lib_subdir_newlib)/crtbegin.o}"
+
+#define ENDFILE_NEWLIB_SPEC "\
+%{shared: %(base_sdk)newlib/%(lib_subdir_newlib)/shcrtend.o} %{!shared: %(base_sdk)newlib/%(lib_subdir_newlib)/crtend.o}"
+
+/* End clib specific */
+
+#undef CPP_OS_DEFAULT_SPEC
+#define CPP_OS_DEFAULT_SPEC "\
+%{mcrt=clib2|mcrt=clib2-ts: %(cpp_clib2); \
+mcrt=ixemul: %(cpp_ixemul); \
+mcrt=libnix: %(cpp_libnix); \
+mcrt=newlib: %(cpp_newlib); \
+mcrt=default|!mcrt=*: %{mcrt=default|!nostdinc: %(cpp_amiga_default)}; \
+: %eInvalid C runtime library} \
+-isystem %(base_sdk)include/include_h \
+-isystem %(base_sdk)include/netinclude \
+-isystem %(base_sdk)local/common/include \
+%{mbaserel: %{msdata|msdata=default|msdata=sysv: %e-mbaserel and -msdata options are incompatible}} \
+%{newlib: %e-newlib is obsolete, use -mcrt=newlib instead}"
+
+#undef LINK_SPEC
+#define LINK_SPEC "\
+--defsym __amigaos4__=1 \
+%{!shared: %{!use-dynld: -Bstatic}} \
+-q -d %{h*} %{v:-V} %{G*} \
+%{Wl,*:%*} %{YP,*} %{R*} \
+%{Qy:} %{!Qn:-Qy} \
+%(link_shlib) %(link_text) \
+%{mbaserel: %{msdata|msdata=default|msdata=sysv: %e-mbaserel and -msdata options are incompatible}} \
+%{mcrt=clib2|mcrt=clib2-ts: %(link_clib2); \
+mcrt=ixemul: %(link_ixemul); \
+mcrt=libnix: %(link_libnix); \
+mcrt=newlib: %(link_newlib); \
+mcrt=default|!mcrt=*: %(link_amiga_default); \
+: %eInvalid C runtime library} \
+-L%(base_sdk)local/common/lib%(lib_subdir_type) \
+%{newlib: %e-newlib is obsolete, use -mcrt=newlib instead}"
+
+/* FIXME: LINK_TEXT has been made empty now. Could we get rid of it? */
+#if 0
+#define LINK_TEXT "\
+%{use-dynld: -Ttext=0x100000} %{!use-dynld: %{shared: -Ttext=0x100000} %{!shared: %{!Wl,-T*: %{!T*:-Ttext=0}}}}"
+#else
+#define LINK_TEXT ""
+#endif
+
+#define LINK_SHLIB "\
+%{shared:-shared -dy --defsym __dynld_version__=1} %{!shared: %{static:-static}} %{use-dynld: -dy}"
+
+#undef STARTFILE_SPEC
+#define STARTFILE_SPEC "\
+%{mcrt=clib2|mcrt=clib2-ts: %(startfile_clib2); \
+mcrt=ixemul: %(startfile_ixemul); \
+mcrt=libnix: %(startfile_libnix); \
+mcrt=newlib: %(startfile_newlib); \
+mcrt=default|!mcrt=*: %(startfile_amiga_default); \
+: %eInvalid C runtime library}"
+
+#undef ENDFILE_SPEC
+#define ENDFILE_SPEC "\
+%{mcrt=clib2|mcrt=clib2-ts: %(endfile_clib2); \
+mcrt=ixemul: %(endfile_ixemul); \
+mcrt=libnix: %(endfile_libnix); \
+mcrt=newlib: %(endfile_newlib); \
+mcrt=default|!mcrt=*: %(endfile_amiga_default); \
+: %eInvalid C runtime library}"
+
+#undef LIB_SPEC
+#define LIB_SPEC "\
+--start-group -lc --end-group"
+
+#undef TARGET_DEFAULT
+#define TARGET_DEFAULT 0
+
+#undef SUBTARGET_EXTRA_SPECS
+#define SUBTARGET_EXTRA_SPECS \
+  {"base_gcc", BASE_GCC_SPEC}, \
+  {"base_sdk", BASE_SDK_SPEC}, \
+  {"cpp_os_default", CPP_OS_DEFAULT_SPEC}, \
+  {"lib_subdir_type", LIB_SUBDIR_TYPE_SPEC}, \
+  /* default C runtime */ \
+  {"cpp_amiga_default", CPP_AMIGA_DEFAULT_SPEC}, \
+  {"link_amiga_default", LINK_AMIGA_DEFAULT_SPEC}, \
+  {"startfile_amiga_default", STARTFILE_AMIGA_DEFAULT_SPEC}, \
+  {"endfile_amiga_default", ENDFILE_AMIGA_DEFAULT_SPEC}, \
+  /* clib2 */ \
+  {"cpp_clib2", CPP_CLIB2_SPEC}, \
+  {"lib_subdir_clib2", LIB_SUBDIR_CLIB2_SPEC}, \
+  {"link_clib2", LINK_CLIB2_SPEC}, \
+  {"startfile_clib2", STARTFILE_CLIB2_SPEC}, \
+  {"endfile_clib2", ENDFILE_CLIB2_SPEC}, \
+  /* ixemul */ \
+  {"cpp_ixemul", CPP_IXEMUL_SPEC}, \
+  {"lib_subdir_ixemul", LIB_SUBDIR_IXEMUL_SPEC}, \
+  {"link_ixemul", LINK_IXEMUL_SPEC}, \
+  {"startfile_ixemul", STARTFILE_IXEMUL_SPEC}, \
+  {"endfile_ixemul", ENDFILE_IXEMUL_SPEC}, \
+  /* libnix */ \
+  {"cpp_libnix", CPP_LIBNIX_SPEC}, \
+  {"lib_subdir_libnix", LIB_SUBDIR_LIBNIX_SPEC}, \
+  {"link_libnix", LINK_LIBNIX_SPEC}, \
+  {"startfile_libnix", STARTFILE_LIBNIX_SPEC}, \
+  {"endfile_libnix", ENDFILE_LIBNIX_SPEC}, \
+  /* newlib */ \
+  {"cpp_newlib", CPP_NEWLIB_SPEC}, \
+  {"lib_subdir_newlib", LIB_SUBDIR_NEWLIB_SPEC}, \
+  {"link_newlib", LINK_NEWLIB_SPEC}, \
+  {"startfile_newlib", STARTFILE_NEWLIB_SPEC}, \
+  {"endfile_newlib", ENDFILE_NEWLIB_SPEC}, \
+  /* used in link spec  */ \
+  {"link_text", LINK_TEXT}, \
+  {"link_shlib", LINK_SHLIB},
+
+#undef DEFAULT_VTABLE_THUNKS
+#ifndef USE_GNULIBC_1
+#define DEFAULT_VTABLE_THUNKS 1
+#endif
+
+#undef JUMP_TABLES_IN_TEXT_SECTION
+#define JUMP_TABLES_IN_TEXT_SECTION 0
+
+/* Used as cookie for linear vararg passing */
+#define CALL_LINEARVARARGS      0x10000000
+
+/* AmigaOS specific options */
+
+/* Strings provided for own options management in rs6000.c */
+/*extern const char *amigaos_crt_string;*/
+
+#define SUB3TARGET_OVERRIDE_OPTIONS  \
+do                                   \
+{                                    \
+  if (TARGET_ALTIVEC)                \
+  {                                  \
+    rs6000_altivec_abi = 1;          \
+    TARGET_ALTIVEC_VRSAVE = 1;       \
+  }                                  \
+} while(0)
+
+#undef SUBTARGET_EXPAND_BUILTIN
+#define SUBTARGET_EXPAND_BUILTIN(EXP, TARGET, SUBTARGET, MODE, IGNORE, SUCCESS) \
+  amigaos_expand_builtin (EXP, TARGET, SUBTARGET, MODE, IGNORE, SUCCESS)
+
+#undef SUBTARGET_INIT_BUILTINS
+#define SUBTARGET_INIT_BUILTINS \
+  amigaos_init_builtins ()
+
+/* AmigaOS specific attribute */
+#define SUBTARGET_ATTRIBUTE_TABLE \
+  { "linearvarargs", 0, 0, false, true,  true, amigaos_handle_linearvarargs_attribute, false}, \
+  { "lineartags", 0, 0, false, true, true, amigaos_handle_lineartags_attribute, false}, \
+  { "baserel_restore", 0, 0, false, true, true, amigaos_handle_baserel_restore_attribute, false }, \
+  { "force_no_baserel", 0, 0, true, false, false, amigaos_handle_force_no_baserel_attribute, false }, \
+  { "check68kfuncptr", 0, 0, false, true, true, amigaos_handle_check68kfuncptr_attribute, false }
+
+/* Overrides */
+/*
+#undef INIT_CUMULATIVE_ARGS
+#define INIT_CUMULATIVE_ARGS(CUM, FNTYPE, LIBNAME, INDIRECT, N_NAMED_ARGS) \
+  amigaos_init_cumulative_args (&CUM, FNTYPE, LIBNAME, FALSE, N_NAMED_ARGS)
+
+#undef INIT_CUMULATIVE_INCOMING_ARGS
+#define INIT_CUMULATIVE_INCOMING_ARGS(CUM, FNTYPE, LIBNAME) \
+  amigaos_init_cumulative_args (&CUM, FNTYPE, LIBNAME, TRUE, 1000)
+
+#undef FUNCTION_ARG_ADVANCE
+#define FUNCTION_ARG_ADVANCE(CUM, MODE, TYPE, NAMED)    \
+  amigaos_function_arg_advance (&CUM, MODE, TYPE, NAMED)
+
+#undef FUNCTION_ARG
+#define FUNCTION_ARG(CUM, MODE, TYPE, NAMED) \
+  amigaos_function_arg (&CUM, MODE, TYPE, NAMED)
+*/
+#undef EXPAND_BUILTIN_VA_START
+#define EXPAND_BUILTIN_VA_START(VALIST, NEXTARG) \
+  amigaos_expand_builtin_va_start (VALIST, NEXTARG)
+
+#undef SLOW_UNALIGNED_ACCESS
+#define SLOW_UNALIGNED_ACCESS(MODE, ALIGN)				\
+  (STRICT_ALIGNMENT							\
+   || (((MODE) == SFmode) && (ALIGN) < 32)				\
+   || (((MODE) == DFmode || (MODE) == TFmode || (MODE) == DImode)	\
+       && (ALIGN) < 64))
+
+/* This target uses the amigaos.opt file.  */
+#define TARGET_USES_AMIGAOS_OPT 1
diff --git a/gcc/config/rs6000/amigaos.opt b/gcc/config/rs6000/amigaos.opt
new file mode 100644
index 0000000000000000000000000000000000000000..93d74f10bea8c1b23c82a9650bb0c3c153464ba7
--- /dev/null
+++ gcc/config/rs6000/amigaos.opt
@@ -0,0 +1,37 @@
+; Options for the PowerPC AmigaOS port
+;
+; Copyright (C) 2005 Free Software Foundation, Inc.
+; Contributed by Jens Langner <Jens.Langner@light-speed.de>
+;
+; This file is part of GCC.
+;
+; GCC is free software; you can redistribute it and/or modify it under
+; the terms of the GNU General Public License as published by the Free
+; Software Foundation; either version 2, or (at your option) any later
+; version.
+;
+; GCC is distributed in the hope that it will be useful, but WITHOUT
+; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+; License for more details.
+;
+; You should have received a copy of the GNU General Public License
+; along with GCC; see the file COPYING.  If not, write to the Free
+; Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
+; 02110-1301, USA.
+
+mcrt=
+Target RejectNegative Joined Var(amigaos_crt) Init("newlib")
+Select C runtime library
+
+mbaserel
+Target Report Mask(BASEREL)
+Generate base relative data access
+
+mcheck68kfuncptr
+Target Report Var(CHECK68KFUNCPTR)
+Generate target checking for function pointers
+
+use-dynld
+Target Driver
+Generated binary employs the dynamic linker for shared objects.
diff --git a/gcc/config/rs6000/rs6000-builtin.def b/gcc/config/rs6000/rs6000-builtin.def
index 7b79efcedb31000524ac8ac485a054bef70ff9c3..07ecb46ca445f2503529b61f1acecfd722b673ce 100644
--- gcc/config/rs6000/rs6000-builtin.def
+++ gcc/config/rs6000/rs6000-builtin.def
@@ -1985,6 +1985,13 @@ RS6000_BUILTIN_X (RS6000_BUILTIN_MTFSF, "__builtin_mtfsf",
 	          RS6000_BTC_MISC | RS6000_BTC_UNARY | RS6000_BTC_VOID,
 		  CODE_FOR_rs6000_mtfsf)
 
 /* Darwin CfString builtin.  */
 BU_SPECIAL_X (RS6000_BUILTIN_CFSTRING, "__builtin_cfstring", RS6000_BTM_ALWAYS,
 	      RS6000_BTC_MISC)
+
+/* AmigaOS specific builtin. */
+RS6000_BUILTIN_2 (AMIGAOS_BUILTIN_GETLINEARVA,	/* ENUM */	\
+		    "__builtin_getlinearva",	/* NAME */	\
+		    RS6000_BTM_ALWAYS,		/* MASK */	\
+		    RS6000_BTC_MISC,		/* ATTR */	\
+		    CODE_FOR_nothing)		/* ICODE */
diff --git a/gcc/config/rs6000/rs6000.c b/gcc/config/rs6000/rs6000.c
index f5c2d422a8076e6fa5da3b864ade636c54cd9af8..ee0ea2ffabb6b9c6fdcba687d88be1e1164374ee 100644
--- gcc/config/rs6000/rs6000.c
+++ gcc/config/rs6000/rs6000.c
@@ -161,12 +161,18 @@ typedef struct rs6000_stack {
 				   not in save_size */
   int spe_gp_size;		/* size of 64-bit GPR save size for SPE */
   int spe_padding_size;
   HOST_WIDE_INT total_size;	/* total bytes allocated for stack */
   int spe_64bit_regs_used;
   int savres_strategy;
+#ifdef TARGET_BASEREL
+  int baserel_save_p;           /* true if the baserel register needs to be
+                                   saved */
+  int baserel_save_offset;      /* offset to save baserel register */
+  int baserel_size;             /* size of saved baserel register */
+#endif
 } rs6000_stack_t;
 
 /* A C structure for machine-specific, per-function data.
    This is added to the cfun structure.  */
 typedef struct GTY(()) machine_function
 {
@@ -1426,12 +1432,18 @@ static const struct attribute_spec rs6000_attribute_table[] =
 
 #undef TARGET_ASM_FUNCTION_PROLOGUE
 #define TARGET_ASM_FUNCTION_PROLOGUE rs6000_output_function_prologue
 #undef TARGET_ASM_FUNCTION_EPILOGUE
 #define TARGET_ASM_FUNCTION_EPILOGUE rs6000_output_function_epilogue
 
+#ifdef TARGET_BASEREL
+extern void amigaos_function_end_prologue(FILE *);
+#undef TARGET_ASM_FUNCTION_END_PROLOGUE
+#define TARGET_ASM_FUNCTION_END_PROLOGUE amigaos_function_end_prologue
+#endif
+
 #undef TARGET_ASM_OUTPUT_ADDR_CONST_EXTRA
 #define TARGET_ASM_OUTPUT_ADDR_CONST_EXTRA rs6000_output_addr_const_extra
 
 #undef TARGET_LEGITIMIZE_ADDRESS
 #define TARGET_LEGITIMIZE_ADDRESS rs6000_legitimize_address
 
@@ -6957,12 +6969,20 @@ rs6000_legitimize_address (rtx x, rtx oldx ATTRIBUTE_UNUSED,
     {
       enum tls_model model = SYMBOL_REF_TLS_MODEL (x);
       if (model != 0)
 	return rs6000_legitimize_tls_address (x, model);
     }
 
+#ifdef TARGET_BASEREL
+  if (TARGET_BASEREL
+      && amigaos_baserel_operand(x))
+    {
+      return amigaos_legitimize_baserel_address(x);
+    }
+#endif
+
   extra = 0;
   switch (mode)
     {
     case TFmode:
     case TDmode:
     case TImode:
@@ -8549,12 +8569,21 @@ rs6000_emit_move (rtx dest, rtx source, machine_mode mode)
 	  tmp = gen_rtx_PLUS (mode, tmp, addend);
 	  tmp = force_operand (tmp, operands[0]);
 	}
       operands[1] = tmp;
     }
 
+#ifdef TARGET_BASEREL
+  if (/*GET_CODE (operands[1]) == SYMBOL_REF
+      && */TARGET_BASEREL
+      && amigaos_baserel_operand (operands[1]))
+    {
+       operands[1] = amigaos_legitimize_baserel_address (operands[1]);
+    }
+#endif
+
   /* Handle the case where reload calls us with an invalid address.  */
   if (reload_in_progress && mode == Pmode
       && (! general_operand (operands[1], mode)
 	  || ! nonimmediate_operand (operands[0], mode)))
     goto emit_set;
 
@@ -8852,12 +8881,20 @@ rs6000_emit_move (rtx dest, rtx source, machine_mode mode)
 #endif
 	      emit_insn (gen_macho_high (target, operands[1]));
 	      emit_insn (gen_macho_low (operands[0], target, operands[1]));
 	      return;
 	    }
 
+#ifdef TARGET_BASEREL
+	  if (TARGET_BASEREL && amigaos_baserel_operand(operands[1]))
+	    {
+              emit_insn (gen_elf_base_high (target, gen_rtx_REG (Pmode, 2), operands[1]));
+              emit_insn (gen_elf_base_low (operands[0], target, operands[1]));
+              return;
+        }
+#endif
 	  emit_insn (gen_elf_high (target, operands[1]));
 	  emit_insn (gen_elf_low (operands[0], target, operands[1]));
 	  return;
 	}
 
       /* If this is a SYMBOL_REF that refers to a constant pool entry,
@@ -9372,12 +9409,18 @@ init_cumulative_args (CUMULATIVE_ARGS *cum, tree fntype,
   if ((!fntype && rs6000_default_long_calls)
       || (fntype
 	  && lookup_attribute ("longcall", TYPE_ATTRIBUTES (fntype))
 	  && !lookup_attribute ("shortcall", TYPE_ATTRIBUTES (fntype))))
     cum->call_cookie |= CALL_LONG;
 
+  /* AmigaOS4: Check if either libcall or linear varargs, set appropriate cookie */
+  if (fntype && (lookup_attribute ("libcall", TYPE_ATTRIBUTES (fntype))))
+    cum->call_cookie |= CALL_LINEARVARARGS;
+  if (fntype && (lookup_attribute ("linearvarargs", TYPE_ATTRIBUTES (fntype))))
+    cum->call_cookie |= CALL_LINEARVARARGS;
+
   if (TARGET_DEBUG_ARG)
     {
       fprintf (stderr, "\ninit_cumulative_args:");
       if (fntype)
 	{
 	  tree ret_type = TREE_TYPE (fntype);
@@ -10023,12 +10066,21 @@ rs6000_function_arg_advance_1 (CUMULATIVE_ARGS *cum, machine_mode mode,
 	  fprintf (stderr, "nargs = %4d, proto = %d, mode = %4s, ",
 		   cum->nargs_prototype, cum->prototype, GET_MODE_NAME (mode));
 	  fprintf (stderr, "named = %d, align = %d, depth = %d\n",
 		   named, align_words - start_words, depth);
 	}
     }
+
+  /*  If the function has the linearvarargs attribute and this argument
+   to advance over is the last non-vararg argument, then advance over
+   all registers, so that the overflow area is hit immediately. */
+  if (cum->call_cookie & CALL_LINEARVARARGS && cum->nargs_prototype <= 0)
+    {
+      cum->sysv_gregno = GP_ARG_MAX_REG + 1;
+      cum->fregno = FP_ARG_V4_MAX_REG + 1;
+    }
 }
 
 static void
 rs6000_function_arg_advance (cumulative_args_t cum, machine_mode mode,
 			     const_tree type, bool named)
 {
@@ -11189,12 +11241,18 @@ setup_incoming_varargs (cumulative_args_t cum, machine_mode mode,
       save_area = virtual_incoming_args_rtx;
 
       if (targetm.calls.must_pass_in_stack (mode, type))
 	first_reg_offset += rs6000_arg_size (TYPE_MODE (type), type);
     }
 
+#ifdef CALL_LINEARVARARGS
+  /* For AmigaOS: No need to save registers for linearvarargs functions */
+  if (next_cum.call_cookie & CALL_LINEARVARARGS)
+    return;
+#endif
+
   set = get_varargs_alias_set ();
   if (! no_rtl && first_reg_offset < GP_ARG_NUM_REG
       && cfun->va_list_gpr_size)
     {
       int n_gpr, nregs = GP_ARG_NUM_REG - first_reg_offset;
 
@@ -11316,13 +11374,13 @@ rs6000_build_builtin_va_list (void)
   return build_array_type (record, build_index_type (size_zero_node));
 }
 
 /* Implement va_start.  */
 
 static void
-rs6000_va_start (tree valist, rtx nextarg)
+rs6000_va_start2 (tree valist, rtx nextarg)
 {
   HOST_WIDE_INT words, n_gpr, n_fpr;
   tree f_gpr, f_fpr, f_res, f_ovf, f_sav;
   tree gpr, fpr, ovf, sav, t;
 
   /* Only SVR4 needs something special.  */
@@ -11351,12 +11409,21 @@ rs6000_va_start (tree valist, rtx nextarg)
   words = crtl->args.info.words;
   n_gpr = MIN (crtl->args.info.sysv_gregno - GP_ARG_MIN_REG,
 	       GP_ARG_NUM_REG);
   n_fpr = MIN (crtl->args.info.fregno - FP_ARG_MIN_REG,
 	       FP_ARG_NUM_REG);
 
+  /* For linearvarargs functions, immediately increase the fpr
+     and gpr count to the maximum value, so that va_arg will look
+     only at the stack. */
+  if (crtl->args.info.call_cookie & CALL_LINEARVARARGS)
+    {
+	n_gpr = GP_ARG_NUM_REG;
+	n_fpr = FP_ARG_NUM_REG;
+    }
+
   if (TARGET_DEBUG_ARG)
     fprintf (stderr, "va_start: words = "HOST_WIDE_INT_PRINT_DEC", n_gpr = "
 	     HOST_WIDE_INT_PRINT_DEC", n_fpr = "HOST_WIDE_INT_PRINT_DEC"\n",
 	     words, n_gpr, n_fpr);
 
   if (cfun->va_list_gpr_size)
@@ -11402,12 +11469,18 @@ rs6000_va_start (tree valist, rtx nextarg)
     t = fold_build_pointer_plus_hwi (t, cfun->machine->varargs_save_offset);
   t = build2 (MODIFY_EXPR, TREE_TYPE (sav), sav, t);
   TREE_SIDE_EFFECTS (t) = 1;
   expand_expr (t, const0_rtx, VOIDmode, EXPAND_NORMAL);
 }
 
+void
+rs6000_va_start (tree valist, rtx nextarg)
+{
+  rs6000_va_start2(valist, nextarg);
+}
+
 /* Implement va_arg.  */
 
 static tree
 rs6000_gimplify_va_arg (tree valist, tree type, gimple_seq *pre_p,
 			gimple_seq *post_p)
 {
@@ -14155,12 +14228,20 @@ rs6000_expand_builtin (tree exp, rtx target, rtx subtarget ATTRIBUTE_UNUSED,
   size_t i;
   rtx ret;
   bool success;
   HOST_WIDE_INT mask = rs6000_builtin_info[uns_fcode].mask;
   bool func_valid_p = ((rs6000_builtin_mask & mask) == mask);
 
+  /* Try subtarget first */
+#ifdef SUBTARGET_EXPAND_BUILTIN
+  ret = SUBTARGET_EXPAND_BUILTIN (exp, target, subtarget, mode, ignore, &success);
+  if (success)
+    return ret;
+#endif
+
+
   if (TARGET_DEBUG_BUILTIN)
     {
       enum insn_code icode = rs6000_builtin_info[uns_fcode].icode;
       const char *name1 = rs6000_builtin_info[uns_fcode].name;
       const char *name2 = ((icode != CODE_FOR_nothing)
 			   ? get_insn_name ((int)icode)
@@ -19214,13 +19295,22 @@ print_operand_address (FILE *file, rtx x)
 #endif
 #if TARGET_ELF
   else if (GET_CODE (x) == LO_SUM && REG_P (XEXP (x, 0))
 	   && CONSTANT_P (XEXP (x, 1)))
     {
       output_addr_const (file, XEXP (x, 1));
+#ifdef TARGET_BASEREL
+      if (TARGET_BASEREL && amigaos_baserel_operand(x))
+        {
+          fprintf (file, "@brel@l(%s)", reg_names[ REGNO (XEXP (x, 0)) ]);
+        }
+      else
+          fprintf (file, "@l(%s)", reg_names[ REGNO (XEXP (x, 0)) ]);
+#else
       fprintf (file, "@l(%s)", reg_names[ REGNO (XEXP (x, 0)) ]);
+#endif
     }
 #endif
   else if (toc_relative_expr_p (x, false))
     {
       /* This hack along with a corresponding hack in
 	 rs6000_output_addr_const_extra arranges to output addends
@@ -21827,12 +21917,25 @@ rs6000_stack_info (void)
 				 - info_ptr->first_altivec_reg_save);
 
   /* Does this function call anything?  */
   info_ptr->calls_p = (! crtl->is_leaf 
 		       || cfun->machine->ra_needs_full_frame);
 
+#ifdef TARGET_BASEREL
+  /* Check if the function wants to setup the baserel register (r2) */
+  if (TARGET_BASEREL
+      && current_function_decl
+      && lookup_attribute ("baserel_restore", TYPE_ATTRIBUTES (TREE_TYPE (current_function_decl))))
+    {
+      info_ptr->baserel_save_p = 1;
+      info_ptr->baserel_size = reg_size;
+      df_set_regs_ever_live(2,true);
+      info_ptr->calls_p = 1;
+    }
+#endif /* TARGET_BASEREL */
+
   /* Determine if we need to save the condition code registers.  */
   if (df_regs_ever_live_p (CR2_REGNO)
       || df_regs_ever_live_p (CR3_REGNO)
       || df_regs_ever_live_p (CR4_REGNO))
     {
       info_ptr->cr_save_p = 1;
@@ -21944,13 +22047,19 @@ rs6000_stack_info (void)
       info_ptr->lr_save_offset   = 2*reg_size;
       break;
 
     case ABI_V4:
       info_ptr->fp_save_offset   = - info_ptr->fp_size;
       info_ptr->gp_save_offset   = info_ptr->fp_save_offset - info_ptr->gp_size;
+#ifdef TARGET_BASEREL
+      info_ptr->baserel_save_offset = info_ptr->gp_save_offset
+                                       - info_ptr->baserel_size;
+      info_ptr->cr_save_offset   = info_ptr->baserel_save_offset - info_ptr->cr_size;
+#else
       info_ptr->cr_save_offset   = info_ptr->gp_save_offset - info_ptr->cr_size;
+#endif
 
       if (TARGET_SPE_ABI && info_ptr->spe_64bit_regs_used != 0)
 	{
 	  /* Align stack so SPE GPR save area is aligned on a
 	     double-word boundary.  */
 	  if (info_ptr->spe_gp_size != 0 && info_ptr->cr_save_offset != 0)
@@ -22004,12 +22113,16 @@ rs6000_stack_info (void)
 					 + ehrd_size
 					 + ehcr_size
 					 + info_ptr->cr_size
 					 + info_ptr->vrsave_size,
 					 save_align);
 
+#ifdef TARGET_BASEREL
+  info_ptr->save_size += RS6000_ALIGN (info_ptr->baserel_size, save_align);
+#endif
+
   non_fixed_size	 = (info_ptr->vars_size
 			    + info_ptr->parm_size
 			    + info_ptr->save_size);
 
   info_ptr->total_size = RS6000_ALIGN (non_fixed_size + info_ptr->fixed_size,
 				       ABI_STACK_BOUNDARY / BITS_PER_UNIT);
@@ -22188,12 +22301,17 @@ debug_stack_info (rs6000_stack_t *info)
   if (info->lr_save_p)
     fprintf (stderr, "\tlr_save_p           = %5d\n", info->lr_save_p);
 
   if (info->cr_save_p)
     fprintf (stderr, "\tcr_save_p           = %5d\n", info->cr_save_p);
 
+#ifdef TARGET_BASEREL
+  if (info->baserel_save_p)
+    fprintf (stderr, "\tbaserel_save_p      = %5d\n", info->baserel_save_p);
+#endif
+
   if (info->vrsave_mask)
     fprintf (stderr, "\tvrsave_mask         = 0x%x\n", info->vrsave_mask);
 
   if (info->push_p)
     fprintf (stderr, "\tpush_p              = %5d\n", info->push_p);
 
@@ -22224,12 +22342,17 @@ debug_stack_info (rs6000_stack_t *info)
   if (info->cr_save_offset)
     fprintf (stderr, "\tcr_save_offset      = %5d\n", info->cr_save_offset);
 
   if (info->varargs_save_offset)
     fprintf (stderr, "\tvarargs_save_offset = %5d\n", info->varargs_save_offset);
 
+#ifdef TARGET_BASEREL
+  if (info->baserel_save_offset && TARGET_BASEREL)
+    fprintf (stderr, "\tbaserel_save_offset = %5d\n", info->baserel_save_offset);
+#endif
+
   if (info->total_size)
     fprintf (stderr, "\ttotal_size          = "HOST_WIDE_INT_PRINT_DEC"\n",
 	     info->total_size);
 
   if (info->vars_size)
     fprintf (stderr, "\tvars_size           = "HOST_WIDE_INT_PRINT_DEC"\n",
@@ -22253,12 +22376,17 @@ debug_stack_info (rs6000_stack_t *info)
   if (info->altivec_size)
     fprintf (stderr, "\taltivec_size        = %5d\n", info->altivec_size);
 
   if (info->vrsave_size)
     fprintf (stderr, "\tvrsave_size         = %5d\n", info->vrsave_size);
 
+#ifdef TARGET_BASEREL
+  if (info->baserel_size && TARGET_BASEREL)
+    fprintf (stderr, "\tbaserel_size        = %5d\n", info->baserel_size);
+#endif
+
   if (info->altivec_padding_size)
     fprintf (stderr, "\taltivec_padding_size= %5d\n",
 	     info->altivec_padding_size);
 
   if (info->spe_padding_size)
     fprintf (stderr, "\tspe_padding_size    = %5d\n",
@@ -23989,12 +24117,28 @@ rs6000_emit_prologue (void)
 	  emit_frame_save (frame_reg_rtx, reg_mode,
 			   info->first_gp_reg_save + i,
 			   info->gp_save_offset + frame_off + reg_size * i,
 			   sp_off - frame_off);
     }
 
+#ifdef TARGET_BASEREL
+  if (info->baserel_save_p && TARGET_BASEREL)
+    {
+      /* Store r2 */
+      rtx addr, reg, mem;
+
+      addr = gen_rtx_PLUS (Pmode, frame_reg_rtx,
+			   GEN_INT (info->baserel_save_offset + frame_off)); /* or sp_off? */
+      mem = gen_frame_mem (reg_mode, addr);
+
+      reg = gen_rtx_REG (reg_mode, 2);
+      insn = emit_move_insn (mem, reg);
+      rs6000_frame_related (insn, gen_rtx_REG (Pmode, 12), info->total_size, /* verify info->total_size */
+				NULL_RTX, NULL_RTX);
+    }
+#endif
   if (crtl->calls_eh_return)
     {
       unsigned int i;
       rtvec p;
 
       for (i = 0; ; ++i)
@@ -24446,12 +24590,19 @@ rs6000_emit_prologue (void)
 
       if (!info->lr_save_p)
 	emit_move_insn (lr, gen_rtx_REG (Pmode, 0));
     }
 #endif
 
+#ifdef TARGET_BASEREL
+      /* Emit a blockage to prevent r2-dependant instructions from moving into
+       * the prologue. r2 is set up later in amigaos_function_end_prologue.  */
+      if (info->baserel_save_p && TARGET_BASEREL)
+        emit_insn (gen_blockage ());
+#endif
+
   /* If we need to, save the TOC register after doing the stack setup.
      Do not emit eh frame info for this save.  The unwinder wants info,
      conceptually attached to instructions in this function, about
      register values in the caller of this function.  This R2 may have
      already been changed from the value in the caller.
      We don't attempt to write accurate DWARF EH frame info for R2
@@ -24502,12 +24653,17 @@ rs6000_output_savres_externs (FILE *file)
 		     & REST_NOINLINE_FPRS_DOESNT_RESTORE_LR) == 0;
 	  int sel = SAVRES_FPR | (lr ? SAVRES_LR : 0);
 	  name = rs6000_savres_routine_name (info, regno, sel);
 	  fprintf (file, "\t.extern %s\n", name);
 	}
     }
+
+#ifdef TARGET_BASEREL
+  if (info->baserel_save_p && TARGET_BASEREL)
+    fprintf (file, "\t.extern __baserel_get_addr\n");
+#endif
 }
 
 /* Write function prologue.  */
 
 static void
 rs6000_output_function_prologue (FILE *file,
@@ -25319,12 +25475,30 @@ rs6000_emit_epilogue (int sibcall)
 				      + reg_size * (int) i);
 
 	  emit_move_insn (gen_rtx_REG (reg_mode, regno), mem);
 	}
     }
 
+#ifdef TARGET_BASEREL
+  if (info->baserel_save_p && TARGET_BASEREL)
+    {
+      rtx addr, mem, reg;
+
+      /* Restore r2 */
+      addr = gen_rtx_PLUS (Pmode, gen_rtx_REG (Pmode, 12),
+			   GEN_INT (info->baserel_save_offset + frame_off)); /* or sp_off? */
+      mem = gen_frame_mem (reg_mode, addr);
+
+      reg = gen_rtx_REG (reg_mode, 2);
+      emit_move_insn (reg, mem);
+
+      /* Mark register as used.  */
+      emit_insn (gen_rtx_USE (VOIDmode, reg));
+    }
+#endif
+
   /* Restore GPRs.  This is done as a PARALLEL if we are using
      the load-multiple instructions.  */
   if (TARGET_SPE_ABI
       && info->spe_64bit_regs_used
       && info->first_gp_reg_save != 32)
     {
diff --git a/gcc/config/rs6000/rs6000.h b/gcc/config/rs6000/rs6000.h
index 653c2c94e11a6f22d20fe3e33532e4d354c2be5e..99ad439bc53ba7194804bb9bcb47e5756e7175e2 100644
--- gcc/config/rs6000/rs6000.h
+++ gcc/config/rs6000/rs6000.h
@@ -2771,6 +2771,9 @@ enum rs6000_builtin_type_index
 #define void_type_internal_node		 (rs6000_builtin_types[RS6000_BTI_void])
 
 extern GTY(()) tree rs6000_builtin_types[RS6000_BTI_MAX];
 extern GTY(()) tree rs6000_builtin_decls[RS6000_BUILTIN_COUNT];
 
 #define TARGET_SUPPORTS_WIDE_INT 1
+
+/* Used by amigaos port */
+void rs6000_va_start (tree valist, rtx nextarg);
diff --git a/gcc/config/rs6000/rs6000.md b/gcc/config/rs6000/rs6000.md
index 0e5883c7fc895a454d3677f0818c4f13b625c9ce..c8304a75b801c6c5fbe7617e0b42eb46ad15d050 100644
--- gcc/config/rs6000/rs6000.md
+++ gcc/config/rs6000/rs6000.md
@@ -10950,12 +10950,37 @@
    "TARGET_TOC"
    "la %0,%a1"
    "&& TARGET_CMODEL != CMODEL_SMALL && reload_completed"
   [(set (match_dup 0) (high:P (match_dup 1)))
    (set (match_dup 0) (lo_sum:P (match_dup 0) (match_dup 1)))])
 
+;; This needs to be above elf_high/elf_low since elf_base_low and elf_low
+;; have the same instruction signature, so in some cases elf_low would be
+;; generated instead of elf_base_low. Since the requirements for elf_base_low
+;; are more restrictive than those for elf_low, there should be no problems
+;; when determining which instruction to use. Additionally, the elf_low function
+;; has now been guared against used accidently.
+(define_insn "elf_base_high"
+  [(set (match_operand:SI 0 "gpc_reg_operand" "=b")
+        (plus:SI (match_operand:SI 1 "gpc_reg_operand" "b")
+                 (high:SI (match_operand 2 "" ""))))]
+  "TARGET_ELF && ! TARGET_64BIT && TARGET_BASEREL"
+  "{cau|addis} %0,%1,%2@brel@ha"
+  [(set_attr "length" "4")])
+
+;; Nearly same as elf_low, but used base relative relocs.
+;; The second alternative has also been removed (as %K always
+;; uses normal relocs, see rs6000.c/print_operand()).
+(define_insn "elf_base_low"
+  [(set (match_operand:SI 0 "gpc_reg_operand" "=r")
+	(lo_sum:SI (match_operand:SI 1 "gpc_reg_operand" "b")
+		   (match_operand 2 "" "")))]
+   "TARGET_ELF && ! TARGET_64BIT && TARGET_BASEREL && amigaos_baserel_operand(operands[2])"
+   "{cal|la} %0,%2@brel@l(%1)"
+   [(set_attr "length" "4")])
+
 ;; Elf specific ways of loading addresses for non-PIC code.
 ;; The output of this could be r0, but we make a very strong
 ;; preference for a base register because it will usually
 ;; be needed there.
 (define_insn "elf_high"
   [(set (match_operand:SI 0 "gpc_reg_operand" "=b*r")
@@ -10964,13 +10989,13 @@
   "lis %0,%1@ha")
 
 (define_insn "elf_low"
   [(set (match_operand:SI 0 "gpc_reg_operand" "=r")
 	(lo_sum:SI (match_operand:SI 1 "gpc_reg_operand" "b")
 		   (match_operand 2 "" "")))]
-   "TARGET_ELF && ! TARGET_64BIT"
+   "TARGET_ELF && ! TARGET_64BIT && !(TARGET_BASEREL && amigaos_baserel_operand(operands[2]))"
    "la %0,%2@l(%1)")
 
 ;; Call and call_value insns
 (define_expand "call"
   [(parallel [(call (mem:SI (match_operand 0 "address_operand" ""))
 		    (match_operand 1 "" ""))
diff --git a/gcc/config/rs6000/t-amigaos b/gcc/config/rs6000/t-amigaos
new file mode 100644
index 0000000000000000000000000000000000000000..15d9d3fd5a5f0c8109cd158242745fa52b19257e
--- /dev/null
+++ gcc/config/rs6000/t-amigaos
@@ -0,0 +1,20 @@
+# Makefile fragment for AmigaOS/PPC target.
+
+# Extra object file linked to the cc1* executables.
+amigaos.o: $(srcdir)/config/rs6000/amigaos.c $(CONFIG_H)
+	$(CXX) -c $(ALL_CXXFLAGS) $(ALL_CPPFLAGS) $(INCLUDES) $< $(OUTPUT_OPTION)
+
+# We always have limits.h.
+LIMITS_H_TEST = true
+
+# Override defaults.
+# FIXME: This is only correct when building a native version natively.
+NATIVE_SYSTEM_HEADER_DIR=/gcc/include
+#OTHER_FIXINCLUDES_DIRS=${gcc_tooldir}/include
+
+# Build the libraries for both newlib and clib2
+# We do not build soft float flavours as none of the
+# libs support soft floats
+MULTILIB_OPTIONS = mcrt=newlib/mcrt=clib2
+MULTILIB_DIRNAMES = newlib clib2
+#MULTILIB_REUSE = =mcrt=newlib
diff --git a/gcc/cp/typeck.c b/gcc/cp/typeck.c
index 22792556c2431d1875e36cee2304c91d709102ea..cd6a6f14e32a9ee078dd048f5d20965960ac4f44 100644
--- gcc/cp/typeck.c
+++ gcc/cp/typeck.c
@@ -3525,12 +3525,28 @@ cp_build_function_call_vec (tree function, vec<tree, va_gc> **params,
 
       return error_mark_node;
     }
 
   /* fntype now gets the type of function pointed to.  */
   fntype = TREE_TYPE (fntype);
+
+  if (lookup_attribute ("libcall", TYPE_ATTRIBUTES (fntype)) ||
+      lookup_attribute ("libcall2", TYPE_ATTRIBUTES (fntype)))
+  {
+	if (TREE_CODE (function) == COMPONENT_REF && lvalue_p (function))
+	{
+		/* Type of 0 operand of a component ref is always a dereferenced object but
+		 * we need to pass the address of this object */
+
+		/* FIXME: param_types? */
+		vec_safe_insert(*params,0,
+			build1(ADDR_EXPR, build_pointer_type (TREE_TYPE (TREE_OPERAND (function, 0))),
+				TREE_OPERAND (function, 0)));
+	}
+  }
+
   parm_types = TYPE_ARG_TYPES (fntype);
 
   if (params == NULL)
     {
       allocated = make_tree_vector ();
       params = &allocated;
diff --git a/gcc/doc/extend.texi b/gcc/doc/extend.texi
index 70a09032d433c2834f6d1458dcaee92763616570..f63512c1029aa2168a89824ce284844387121082 100644
--- gcc/doc/extend.texi
+++ gcc/doc/extend.texi
@@ -4508,12 +4508,163 @@ The @code{weak} attribute causes the declaration to be emitted as a weak
 symbol rather than a global.  This is primarily useful in defining
 library functions that can be overridden in user code, though it can
 also be used with non-function declarations.  Weak symbols are supported
 for ELF targets, and also for a.out targets when using the GNU assembler
 and linker.
 
+@item libcall
+@cindex AmigaOS specific function attributes
+On AmigaOS, the @code{libcall} attribute is used to declare function
+pointers in an AmigaOS @emph{Interface}.  When such a function pointer
+is invoked, a pointer to the Interface itself is passed as a hidden
+first argument, similar to @code{this} in C++.
+
+ISO/IEC 9899:1999 Edits for Libcall functions
+
+The following are a set of changes to ISO/IEC 9899:1999 (aka C99)
+that document the exact semantics of the language extension.
+
+@itemize @bullet
+@item
+@cite{6.5.2.2  Function calls}
+
+Change paragraph 3 to
+
+@quotation
+[...] denotes the called function.  The arguments to the function
+are specified by the implicit argument, if any, followed by the list
+of expressions.
+@end quotation
+
+Add new paragraph before paragraph 4
+
+@quotation
+If the expression that denotes the called function is a structure or union
+member expression as defined in (6.5.2.3) (or such an expression enclosed
+in any number of parentheses expressions), is an lvalue, and has a type
+that includes the attribute @code{libcall}, then the function call has an
+implicit argument.  In other cases there is no implicit argument.  If there
+is an implicit argument, then this will be the first argument to the function,
+and the list of expressions will follow it.  The type of the implicit
+argument is that of a pointer to the structure or union object of which the
+function expression designates a member.  The value of the implicit argument
+is the address of this structure or union object.
+@end quotation
+@end itemize
+
+@item linearvarargs
+@cindex AmigaOS specific function attributes
+On AmigaOS, the @code{linearvarargs} attribute causes all unprototyped
+arguments to a varargs function to be passed on the stack, and not in
+registers as the SVR4 ABI defines.  Please note that @code{libcall} also
+implies @code{linearvarargs}.
+
+@item baserel_restore
+@cindex AmigaOS specific function attributes
+On AmigaOS, when compiling with @option{-mbaserel} causes the compiler
+to create a call to @code{baserel_get_addr} function in the function prologue
+to set up register @code{r2}. The previous contents of register @code{r2}
+are restored in the function epilogue. See @option{-mbaserel} option for
+more details.
+
+@item check68kfuncptr
+@cindex AmigaOS specific function attributes
+On AmigaOS, when calling a function using a function pointer causes
+the compiler to emit additional code to allow for function pointers
+to m68k functions. This is currently available only in the C front end.
+
+The generated code will call @code{__amigaos4_check68k_check} function
+which expects one function pointer argument and returns an integer
+value. If the return value is non-zero, the function pointer will be
+used to perform the function call in the usual way, otherwise
+@code{__amigaos4_check68k_trampoline} function will be called to perform
+the call. The @code{__amigaos4_check68k_check} function should be provided
+by the user and will usually just return the result of
+@code{exec.library} @code{IsNative} call on its argument.
+
+The @code{__amigaos4_check68k_trampoline} function is a @code{linearvarargs}
+function and should also be provided by the user. It will receive at
+least two arguments: the number of arguments to the function pointer and
+the function pointer itself. Additionally, the arguments to the function
+pointer will follow on the stack, each having one zero longword in front
+of it with one final zero longword after all the arguments. This makes it
+possible to create tag pairs and a terminating @code{TAG_DONE} for a
+call to @code{EmulateTags} in @code{exec.library}. The return code of
+@code{__amigaos4_check68k_trampoline} function will be used as a return
+code of the function pointer call.
+
+The following example can be used for functions that have no more than
+13 arguments:
+
+@smallexample
+static const UWORD trampoline_code[][6] =
+@{
+    /* @r{JMP (A5)} */
+    @{0X4ED5, 0, 0, 0, 0, 0@},
+    /* @r{MOVEM.L D0, -(A7); JSR (A5); ADDQ.L #4,A7; RTS} */
+    @{0X48E7, 0X8000, 0X4E95, 0X588F, 0X4E75, 0@},
+    /* @r{MOVEM.L D0-D1, -(A7); JSR (A5); ADDQ.L #8, A7; RTS} */
+    @{0X48E7, 0XC000, 0X4E95, 0X508F, 0X4E75, 0@},
+    /* @r{MOVEM.L D0-D2, -(A7); JSR (A5); ADDA.W #0X000C, A7; RTS} */
+    @{0X48E7, 0XE000, 0X4E95, 0XDEFC, 0X000C, 0X4E75@},
+    /* @r{MOVEM.L D0-D3, -(A7); JSR (A5); ADDA.W #0X0010, A7; RTS} */
+    @{0X48E7, 0XF000, 0X4E95, 0XDEFC, 0X0010, 0X4E75@},
+    /* @r{MOVEM.L D0-D4, -(A7); JSR (A5); ADDA.W #0X0014, A7; RTS} */
+    @{0X48E7, 0XF800, 0X4E95, 0XDEFC, 0X0014, 0X4E75@},
+    /* @r{MOVEM.L D0-D5, -(A7); JSR (A5); ADDA.W #0X0018, A7; RTS} */
+    @{0X48E7, 0XFC00, 0X4E95, 0XDEFC, 0X0018, 0X4E75@},
+    /* @r{MOVEM.L D0-D6, -(A7); JSR (A5); ADDA.W #0X001C, A7; RTS} */
+    @{0X48E7, 0XFE00, 0X4E95, 0XDEFC, 0X001C, 0X4E75@},
+    /* @r{MOVEM.L D0-D7, -(A7); JSR (A5); ADDA.W #0X0020, A7; RTS} */
+    @{0X48E7, 0XFF00, 0X4E95, 0XDEFC, 0X0020, 0X4E75@},
+    /* @r{MOVEM.L D0-D7/A0, -(A7); JSR (A5); ADDA.W #0X0024, A7; RTS} */
+    @{0X48E7, 0XFF80, 0X4E95, 0XDEFC, 0X0024, 0X4E75@},
+    /* @r{MOVEM.L D0-D7/A0-A1, -(A7); JSR (A5); ADDA.W #0X0028, A7; RTS} */
+    @{0X48E7, 0XFFC0, 0X4E95, 0XDEFC, 0X0028, 0X4E75@},
+    /* @r{MOVEM.L D0-D7/A0-A2, -(A7); JSR (A5); ADDA.W #0X002C, A7; RTS} */
+    @{0X48E7, 0XFFE0, 0X4E95, 0XDEFC, 0X002C, 0X4E75@},
+    /* @r{MOVEM.L D0-D7/A0-A3, -(A7); JSR (A5); ADDA.W #0X0030, A7; RTS} */
+    @{0X48E7, 0XFFF0, 0X4E95, 0XDEFC, 0X0030, 0X4E75@},
+    /* @r{MOVEM.L D0-D7/A0-A3, -(A7); JSR (A5); ADDA.W #0X0034, A7; RTS} */
+    @{0X48E7, 0XFFF8, 0X4E95, 0XDEFC, 0X0034, 0X4E75@}
+@};
+
+int VARARGS68K __amigaos4_check68k_trampoline(int num_args,
+                                              int func,
+                                              ...)
+@{
+    int result, i;
+    va_list args;
+    long *stack;
+
+    va_startlinear(args, func);
+    stack = va_getlinearva(args, long *);
+
+    /* @r{Replace 0's with tag id's} */
+    for(i = 0; i < 8 && i < num_args; i++)
+        stack[i * 2] = ET_RegisterD0 + i;
+
+    while(i < num_args)
+    @{
+        stack[i * 2] = ET_RegisterA0 + i - 8;
+        i++;
+    @}
+
+    if (num_args < sizeof(trampoline_code)
+                   / sizeof(trampoline_code[0]))
+        result = IExec->EmulateTags(trampoline_code[num_args],
+                                    ET_SaveRegs, TRUE,
+                                    ET_RegisterA5, func,
+                                    TAG_MORE, stack);
+
+    va_end(args);
+
+    return(result);
+@}
+@end smallexample
+
 @item weakref
 @itemx weakref ("@var{target}")
 @cindex @code{weakref} function attribute
 The @code{weakref} attribute marks a declaration as a weak reference.
 Without arguments, it should be accompanied by an @code{alias} attribute
 naming the target symbol.  Optionally, the @var{target} may be given as
@@ -5698,12 +5849,28 @@ struct
 
 @noindent
 Here, @code{t5} takes up 2 bytes.
 @end enumerate
 @end table
 
+@subsection AmigaOS PPC Variable Attributes
+
+One attribute is currently defined for AmigaOS PPC.
+
+@table @code
+@item force_no_baserel
+@cindex forcing a variable not to be addressed base relative
+
+This attribute forces access to a variable in code compiled with
+@option{-mbaserel} option not to be base relative. If necessary, the
+access should be protected with some sort of arbitration. See
+documentation on @option{-mbaserel} option for more details about this
+attribute.
+
+@end table
+
 @subsection Xstormy16 Variable Attributes
 
 One attribute is currently defined for xstormy16 configurations:
 @code{below100}.
 
 @table @code
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index d3be5899c57fa2147893f27c7c7bddac98bd4ff4..68ecbffa0f2f92f5ecc7331e8e855240134dbcdf 100644
--- gcc/doc/invoke.texi
+++ gcc/doc/invoke.texi
@@ -1109,12 +1109,16 @@ See RS/6000 and PowerPC Options.
 -mtarget-align  -mno-target-align @gol
 -mlongcalls  -mno-longcalls}
 
 @emph{zSeries Options}
 See S/390 and zSeries Options.
 
+@emph{AmigaOS PPC options}
+@gccoptlist{-mcrt=@var{crt}  -mbaserel  -mno-baserel @gol
+-mcheck68kfuncptr}
+
 @item Code Generation Options
 @xref{Code Gen Options,,Options for Code Generation Conventions}.
 @gccoptlist{-fcall-saved-@var{reg}  -fcall-used-@var{reg} @gol
 -ffixed-@var{reg}  -fexceptions @gol
 -fnon-call-exceptions  -fdelete-dead-exceptions  -funwind-tables @gol
 -fasynchronous-unwind-tables @gol
@@ -12227,12 +12231,13 @@ platform.
 * VMS Options::
 * VxWorks Options::
 * x86 Options::
 * x86 Windows Options::
 * Xstormy16 Options::
 * Xtensa Options::
+* AmigaOS PPC options::
 * zSeries Options::
 @end menu
 
 @node AArch64 Options
 @subsection AArch64 Options
 @cindex AArch64 Options
@@ -23178,12 +23183,143 @@ These options are defined for Xstormy16:
 @table @gcctabopt
 @item -msim
 @opindex msim
 Choose startup files and linker script suitable for the simulator.
 @end table
 
+@node AmigaOS PPC options
+@subsection AmigaOS PPC options
+@cindex AmigaOS PPC options
+
+@table @gcctabopt
+
+@item -mcrt=@var{crt}
+@opindex mcrt
+
+Select the C runtime library to use. The same option must be used for
+both compiling and linking. Some of the possible values are @samp{default},
+@samp{clib2}, @samp{clib2-ts} (thread-safe variant of clib2) and @samp{newlib}.
+Each option makes available an appropriate define, for example
+@code{__CLIB2__}, @code{__NEWLIB__} etc. Additionally, @samp{clib2-ts} option
+provides the @code{__THREAD_SAFE} define.
+
+@item -mbaserel
+@opindex mbaserel
+
+Generate code to access all non-constant data relative to register @code{r2}.
+The executable should also be linked with @option{-mbaserel} option.
+
+This option is useful for creating shared libraries for which all
+openers have a separate copy of non-constant data but share the constant
+data. A better way to do this is by using interface cloning, but
+sometimes this is not possible, for example when some package is being
+ported in form of shared library.
+
+This option can also be used to create residentable programs with
+special startup code.
+
+The startup code or the appropriate interface setup method should use
+@code{CopyDataSegment} function from @samp{elf.library} v51.8 or later to
+copy and relocate the data segment that each instance should have a copy of
+and then set up @code{r2} (and/or @code{EnvironmentVector} interface field
+for libraries) appropriately:
+
+@smallexample
+Elf32_Handle handle = NULL;
+BPTR seg = IDOS->GetProcSegList(NULL);
+
+if (seg)
+@{
+    IDOS->GetSegListInfoTags(seg, GSLI_ElfHandle, &handle, TAG_DONE);
+
+    if (handle
+        && (handle = IElf->OpenElfTags(OET_ElfHandle, handle, TAG_DONE)))
+    @{
+        uint32 offset;
+        uint8 *data = IElf->CopyDataSegment(handle, &offset);
+
+        if (data)
+        @{
+            /* @r{Store @code{data} somewhere since it will be required}
+             * @r{in the cleanup stage}
+             */
+
+            CurrentInterface->Data.EnvironmentVector = data + offset;
+
+            /* @r{Optionally, set r2 to the same value as @code{EnvironmentVector}} if the
+             * @r{current method will call functions access instance local data. This is}
+             * @r{not necessary if the current method will only call interface methods}
+             * @r{which have @code{baserel_restore} attribute (see below).}
+             */
+
+            IElf->CloseElfTags(handle, CET_ReClose, TRUE, TAG_DONE);
+        @}
+        else
+            /* Data was not allocated */;
+    @}
+    else
+        /* ELF handle couldn't be obtained */;
+@}
+else
+    /* Process segment list was not retrieved */;
+
+@end smallexample
+
+The copied data segment should be freed in the cleanup stage using the
+same procedure to obtain the ELF handle and then @code{FreeDataSegmentCopy}
+should be called with the value @code{CopyDataSegment} returned (@emph{not}
+with the value that @code{EnvironmentVector} contains).
+
+Interface methods should include @code{baserel_restore} attribute in their
+definition. When this attribute is present, the compiler will call
+@code{__baserel_get_addr} function in the function prologue. This function
+should set up @code{r2} register and must not modify any other registers
+except @code{r2}. Since it will be called in function prologue, register
+@code{r3} will contain the the first argument of the function. For
+interfaces, this is the interface pointer through which
+@code{EnvironmentVector} field can be accessed. Previous contents
+of register @code{r2} will be restored in the function epilogue.
+
+One possible implementation of @code{__baserel_get_addr} function:
+
+@smallexample
+asm("\n\
+     text\n\
+     globl __baserel_get_addr\n\
+
+__baserel_get_addr:\n\
+     lwz 2, 48(3) /* @r{Fetch EnvironmentVector from struct Interface *} */\n\
+     blr\n\
+");
+@end smallexample
+
+If some non-constant variable needs to be shared by all instances, it
+can be declared with @code{force_no_baserel} attribute. The variable will
+still be present in instance local data area that was created on
+startup, but the compiler will generate code to access it in the
+original data section for all instances. Because of that, the
+declaration of the variable with this attribute must be available to the
+compiler whenever the variable is accessed, otherwise it will generate
+code to access instance local copy of that variable which is probably
+not the desired behaviour. Additionally, some sort of access arbitration
+is probably required.
+
+@item -mno-baserel
+@opindex mno-baserel
+
+Generate absolute data access. This is the default.
+
+@item -mcheck68kfuncptr
+@opindex mcheck68kfuncptr
+
+Causes each function call through a function pointer to be performed as
+if the function pointer was declared with the @samp{check68kfuncptr}
+function attribute. @xref{Function Attributes}.
+
+@end table
+
 @node Xtensa Options
 @subsection Xtensa Options
 @cindex Xtensa Options
 
 These options are supported for Xtensa targets:
 
diff --git a/gcc/expr.c b/gcc/expr.c
index 5c095507f4a303b1c4ab3519d165735be5a37d07..fb57de6652c4bd9dd39300eaaf6c3b2b8aad5fb8 100644
--- gcc/expr.c
+++ gcc/expr.c
@@ -8134,13 +8134,12 @@ expand_expr_real_2 (sepops ops, rtx target, machine_mode tmode,
   tree treeop0, treeop1, treeop2;
 #define REDUCE_BIT_FIELD(expr)	(reduce_bit_field			  \
 				 ? reduce_to_bit_field_precision ((expr), \
 								  target, \
 								  type)	  \
 				 : (expr))
-
   type = ops->type;
   mode = TYPE_MODE (type);
   unsignedp = TYPE_UNSIGNED (type);
 
   treeop0 = ops->op0;
   treeop1 = ops->op1;
diff --git a/gcc/gcc.c b/gcc/gcc.c
index d956c36b151eea45681aa650c39c522f85be359f..d4d061080ba1166fb14069094556246b32265da4 100644
--- gcc/gcc.c
+++ gcc/gcc.c
@@ -2730,13 +2730,13 @@ execute (void)
       commands[0].argv[0] = (string) ? string : commands[0].argv[0];
     }
 
   for (n_commands = 1, i = 0; argbuf.iterate (i, &arg); i++)
     if (arg && strcmp (arg, "|") == 0)
       {				/* each command.  */
-#if defined (__MSDOS__) || defined (OS2) || defined (VMS)
+#if defined (__MSDOS__) || defined (OS2) || defined (VMS) || defined(AMIGA)
 	fatal_error (input_location, "-pipe not supported");
 #endif
 	argbuf[i] = 0; /* Termination of
 						     command args.  */
 	commands[n_commands].prog = argbuf[i + 1];
 	commands[n_commands].argv
@@ -4261,13 +4261,12 @@ process_command (unsigned int decoded_options_count,
       add_prefix (&exec_prefixes, standard_exec_prefix, "BINUTILS",
 		  PREFIX_PRIORITY_LAST, 2, 0);
 #endif
       add_prefix (&startfile_prefixes, standard_exec_prefix, "BINUTILS",
 		  PREFIX_PRIORITY_LAST, 1, 0);
     }
-
   gcc_assert (!IS_ABSOLUTE_PATH (tooldir_base_prefix));
   tooldir_prefix2 = concat (tooldir_base_prefix, spec_host_machine,
 			    dir_separator_str, NULL);
 
   /* Look for tools relative to the location from which the driver is
      running, or, if that is not available, the configured prefix.  */
@@ -6312,12 +6311,17 @@ give_switch (int switchnum, int omit_first_word)
 	      if (dot)
 		(CONST_CAST (char *, arg))[length] = '.';
 	      do_spec_1 (suffix_subst, 1, NULL);
 	    }
 	  else
 	    do_spec_1 (arg, 1, NULL);
+
+#ifdef __amigaos__
+	  /* Don't lose args which happen to be the empty string */
+	  arg_going = 1;
+#endif /* __amigaos__ */
 	}
     }
 
   do_spec_1 (" ", 0, NULL);
   switches[switchnum].validated = true;
 }
@@ -6702,13 +6706,15 @@ is_directory (const char *path1, bool linker)
   len1 = strlen (path1);
   path = (char *) alloca (3 + len1);
   memcpy (path, path1, len1);
   cp = path + len1;
   if (!IS_DIR_SEPARATOR (cp[-1]))
     *cp++ = DIR_SEPARATOR;
+#ifndef __amigaos__
   *cp++ = '.';
+#endif
   *cp = '\0';
 
   /* Exclude directories that the linker is known to search.  */
   if (linker
       && IS_DIR_SEPARATOR (path[0])
       && ((cp - path == 6
@@ -7223,22 +7229,24 @@ driver::set_up_specs () const
 			      ? gcc_exec_prefix : standard_exec_prefix,
 			      machine_suffix,
 			      standard_startfile_prefix, NULL),
 		      NULL, PREFIX_PRIORITY_LAST, 0, 1);
 	}
 
+#ifndef __amigaos__
       /* Sysrooted prefixes are relocated because target_system_root is
 	 also relocated by gcc_exec_prefix.  */
       if (*standard_startfile_prefix_1)
  	add_sysrooted_prefix (&startfile_prefixes,
 			      standard_startfile_prefix_1, "BINUTILS",
 			      PREFIX_PRIORITY_LAST, 0, 1);
       if (*standard_startfile_prefix_2)
 	add_sysrooted_prefix (&startfile_prefixes,
 			      standard_startfile_prefix_2, "BINUTILS",
 			      PREFIX_PRIORITY_LAST, 0, 1);
+#endif
     }
 
   /* Process any user specified specs in the order given on the command
      line.  */
   for (struct user_specs *uptr = user_specs_head; uptr; uptr = uptr->next)
     {
diff --git a/gcc/prefix.c b/gcc/prefix.c
index 3d7532380d5ea5b6a56fd89688cbd76a5d01df57..4ce2ce2e576ca3ad7e9ffee2a2ddc0d25620b3b9 100644
--- gcc/prefix.c
+++ gcc/prefix.c
@@ -326,13 +326,13 @@ update_path (const char *path, const char *key)
 
 #ifdef UPDATE_PATH_HOST_CANONICALIZE
   /* Perform host dependent canonicalization when needed.  */
   UPDATE_PATH_HOST_CANONICALIZE (result);
 #endif
 
-#ifdef DIR_SEPARATOR_2
+#if defined (DIR_SEPARATOR_2) && !defined (__amigaos__)
   /* Convert DIR_SEPARATOR_2 to DIR_SEPARATOR.  */
   if (DIR_SEPARATOR_2 != DIR_SEPARATOR)
     tr (result, DIR_SEPARATOR_2, DIR_SEPARATOR);
 #endif
 
 #if defined (DIR_SEPARATOR) && !defined (DIR_SEPARATOR_2)
diff --git a/intl/dcigettext.c b/intl/dcigettext.c
index a8d4a14d273b153b117b507ec76356635ccd876e..a9cc1066050e10b539149027a5c159f21accfaca 100644
--- intl/dcigettext.c
+++ intl/dcigettext.c
@@ -145,13 +145,15 @@ extern int errno;
 # define tfind __tfind
 #else
 # if !defined HAVE_GETCWD
 char *getwd ();
 #  define getcwd(buf, max) getwd (buf)
 # else
+#   if !defined getcwd
 char *getcwd ();
+#   endif
 # endif
 # ifndef HAVE_STPCPY
 static char *stpcpy PARAMS ((char *dest, const char *src));
 # endif
 # ifndef HAVE_MEMPCPY
 static void *mempcpy PARAMS ((void *dest, const void *src, size_t n));
diff --git a/libcpp/line-map.c b/libcpp/line-map.c
index f9260d00008988a5b5f6b23e03f8f9abd61edd16..b48616406c55ca77e0ebfaa795f83bc661445f3e 100644
--- libcpp/line-map.c
+++ libcpp/line-map.c
@@ -717,12 +717,15 @@ linemap_ordinary_map_lookup (struct line_maps *set, source_location line)
 
   mn = LINEMAPS_ORDINARY_CACHE (set);
   mx = LINEMAPS_ORDINARY_USED (set);
   
   cached = LINEMAPS_ORDINARY_MAP_AT (set, mn);
   /* We should get a segfault if no line_maps have been added yet.  */
+#ifdef __amigaos4__
+  linemap_assert(cached != 0);
+#endif
   if (line >= MAP_START_LOCATION (cached))
     {
       if (mn + 1 == mx || line < MAP_START_LOCATION (&cached[1]))
 	return cached;
     }
   else
diff --git a/libgcc/config.host b/libgcc/config.host
index 4329891fb986fee1c1e01ee367df18c927a7a4b8..9b5c8e2c189ad14dbadbd8e982b6e25113a41fa5 100644
--- libgcc/config.host
+++ libgcc/config.host
@@ -956,12 +956,15 @@ nios2-*-*)
 	tmake_file="$tmake_file nios2/t-nios2 t-softfp-sfdf t-softfp-excl t-softfp"
 	extra_parts="$extra_parts crti.o crtn.o"
 	;;
 pdp11-*-*)
 	tmake_file="pdp11/t-pdp11 t-fdpbit"
 	;;
+powerpc-*-amigaos*)
+	tmake_file="${tmake_file} rs6000/t-savresfgpr rs6000/t-amigaos"
+	;;
 powerpc-*-darwin*)
 	case ${host} in
 	*-*-darwin9* | *-*-darwin[12][0-9]*)
 	  # libSystem contains unwind information for signal frames since
 	  # Darwin 9.
 	  ;;
diff --git a/libgcc/config/rs6000/t-amigaos b/libgcc/config/rs6000/t-amigaos
new file mode 100644
index 0000000000000000000000000000000000000000..da1e303eed7e60df883971a610e8904db0df3e23
--- /dev/null
+++ libgcc/config/rs6000/t-amigaos
@@ -0,0 +1,45 @@
+# We need to enable the altivec in the assembler as
+# crtsavevr.S needs it. Not sure how this is handled
+# on other platforms or if this is a limitiation
+# of our binutils.
+HOST_LIBGCC2_CFLAGS += -Wa,-maltivec
+
+# The shared library needs to be compiled with -fPIC
+
+gcc_s_compile += -fPIC
+
+
+# We want fine grained libraries, so use the new code to build the
+# floating point emulation libraries.
+FPBIT = fp-bit.c
+DPBIT = dp-bit.c
+
+dp-bit.c: $(srcdir)/config/fp-bit.c
+	cat $(srcdir)/config/fp-bit.c > dp-bit.c
+
+fp-bit.c: $(srcdir)/config/fp-bit.c
+	echo '#define FLOAT' > fp-bit.c
+	cat $(srcdir)/config/fp-bit.c >> fp-bit.c
+
+# Build a shared libgcc library.
+# Note that this also builds clib2 shared lib which is not useable at
+# this writing
+#
+# We don't set LIBGCC2_CFLAGS += -fPIC here as this will also
+# produce a position independend static library. The -fPIC is
+# ensured in the special libgcc t-amigaos file.
+#
+SHLIB_DIR = @multilib_dir@
+SHLIB_SLIBDIR_QUAL = @shlib_slibdir_qual@
+SHLIB_OBJS = @shlib_objs@
+SHLIB_EXT = .so
+SHLIB_SONAME = @shlib_base_name@$(SHLIB_EXT)
+SHLIB_LINK = $(GCC_FOR_TARGET) -shared $(SHLIB_OBJS) -nodefaultlibs $(LIBGCC2_CFLAGS) \
+	-Wl,--soname=libgcc$(SHLIB_EXT) \
+	-o $(SHLIB_DIR)/$(SHLIB_SONAME) @multilib_flags@ $(SHLIB_LC)
+
+# Install the shared libgcc library, but ensure that the name is libgcc.so
+SHLIB_INSTALL = \
+	$(mkinstalldirs) $(DESTDIR)$(inst_libdir); \
+	$(INSTALL_DATA) $(SHLIB_DIR)/$(SHLIB_SONAME) \
+	  $(DESTDIR)$(inst_libdir)/libgcc$(SHLIB_EXT);
diff --git a/libiberty/Makefile.in b/libiberty/Makefile.in
index f06cc69a973bcf39235febce84a2d7fad7130eed..a3d556b812465e04f339b04bfee766aaaa8eb65b 100644
--- libiberty/Makefile.in
+++ libiberty/Makefile.in
@@ -140,12 +140,13 @@ CFILES = alloca.c argv.c asprintf.c atexit.c				\
 	make-temp-file.c md5.c memchr.c memcmp.c memcpy.c memmem.c	\
 	 memmove.c mempcpy.c memset.c mkstemps.c			\
 	objalloc.c obstack.c						\
 	partition.c pexecute.c						\
 	 pex-common.c pex-djgpp.c pex-msdos.c pex-one.c			\
 	 pex-unix.c pex-win32.c						\
+	 pex-amigaos.c		\
          physmem.c putenv.c						\
 	random.c regex.c rename.c rindex.c				\
 	safe-ctype.c setenv.c setproctitle.c sha1.c sigsetmask.c        \
 	 simple-object.c simple-object-coff.c simple-object-elf.c	\
 	 simple-object-mach-o.c simple-object-xcoff.c			\
          snprintf.c sort.c						\
@@ -207,12 +208,13 @@ CONFIGURED_OFILES = ./asprintf.$(objext) ./atexit.$(objext)		\
 	./getcwd.$(objext) ./getpagesize.$(objext)			\
 	 ./gettimeofday.$(objext)					\
 	./index.$(objext) ./insque.$(objext)				\
 	./memchr.$(objext) ./memcmp.$(objext) ./memcpy.$(objext) 	\
 	./memmem.$(objext) ./memmove.$(objext)				\
 	 ./mempcpy.$(objext) ./memset.$(objext) ./mkstemps.$(objext)	\
+	./pex-amigaos.$(objext)						\
 	./pex-djgpp.$(objext) ./pex-msdos.$(objext)			\
 	 ./pex-unix.$(objext) ./pex-win32.$(objext)			\
 	 ./putenv.$(objext)						\
 	./random.$(objext) ./rename.$(objext) ./rindex.$(objext)	\
 	./setenv.$(objext) 						\
 	 ./setproctitle.$(objext)					\
@@ -1120,12 +1122,19 @@ $(CONFIGURED_OFILES): stamp-picdir stamp-noasandir
 	else true; fi
 	if [ x"$(NOASANFLAG)" != x ]; then \
 	  $(COMPILE.c) $(PICFLAG) $(NOASANFLAG) $(srcdir)/pex-win32.c -o noasan/$@; \
 	else true; fi
 	$(COMPILE.c) $(srcdir)/pex-win32.c $(OUTPUT_OPTION)
 
+./pex-amigaos.$(objext): $(srcdir)/pex-amigaos.c config.h $(INCDIR)/ansidecl.h \
+	$(INCDIR)/libiberty.h $(srcdir)/pex-common.h
+	if [ x"$(PICFLAG)" != x ]; then \
+	  $(COMPILE.c) $(PICFLAG) $(srcdir)/pex-amigaos.c -o pic/$@; \
+	else true; fi
+	$(COMPILE.c) $(srcdir)/pex-amigaos.c $(OUTPUT_OPTION)
+
 ./pexecute.$(objext): $(srcdir)/pexecute.c config.h $(INCDIR)/ansidecl.h \
 	$(INCDIR)/libiberty.h
 	if [ x"$(PICFLAG)" != x ]; then \
 	  $(COMPILE.c) $(PICFLAG) $(srcdir)/pexecute.c -o pic/$@; \
 	else true; fi
 	if [ x"$(NOASANFLAG)" != x ]; then \
diff --git a/libiberty/basename.c b/libiberty/basename.c
index 0f2c069f0ccf5a7d91e4913548e068c247e12efb..6ba5c4aa4f814fbc28f03127d22e91253c980c1b 100644
--- libiberty/basename.c
+++ libiberty/basename.c
@@ -15,32 +15,13 @@ Behavior is undefined if the pathname ends in a directory separator.
 #ifdef HAVE_CONFIG_H
 #include "config.h"
 #endif
 #include "ansidecl.h"
 #include "libiberty.h"
 #include "safe-ctype.h"
-
-#ifndef DIR_SEPARATOR
-#define DIR_SEPARATOR '/'
-#endif
-
-#if defined (_WIN32) || defined (__MSDOS__) || defined (__DJGPP__) || \
-  defined (__OS2__)
-#define HAVE_DOS_BASED_FILE_SYSTEM
-#ifndef DIR_SEPARATOR_2 
-#define DIR_SEPARATOR_2 '\\'
-#endif
-#endif
-
-/* Define IS_DIR_SEPARATOR.  */
-#ifndef DIR_SEPARATOR_2
-# define IS_DIR_SEPARATOR(ch) ((ch) == DIR_SEPARATOR)
-#else /* DIR_SEPARATOR_2 */
-# define IS_DIR_SEPARATOR(ch) \
-	(((ch) == DIR_SEPARATOR) || ((ch) == DIR_SEPARATOR_2))
-#endif /* DIR_SEPARATOR_2 */
+#include "filenames.h"
 
 char *
 basename (const char *name)
 {
   const char *base;
 
diff --git a/libiberty/configure b/libiberty/configure
index b06cab24efa57a9bc6aff387d47833188b796e53..645595a1fdbe34c8387fd19ad78dc1132b4760e3 100755
--- libiberty/configure
+++ libiberty/configure
@@ -6809,12 +6809,13 @@ fi
 
 # Figure out which version of pexecute to use.
 case "${host}" in
      *-*-mingw* | *-*-winnt*)	pexecute=pex-win32  ;;
      *-*-msdosdjgpp*)		pexecute=pex-djgpp  ;;
      *-*-msdos*)		pexecute=pex-msdos  ;;
+     *-*-amigaos*)		pexecute=pex-amigaos;;
      *)				pexecute=pex-unix   ;;
 esac
 
 
 if test x$gcc_no_link = xyes; then
   if test "x${ac_cv_func_mmap_fixed_mapped+set}" != xset; then
diff --git a/libiberty/configure.ac b/libiberty/configure.ac
index 922aa86e9b03719135b2b12ee5aad1c0cbd74342..1c5704ff8cf09fc7446aea2d17e163c9589af542 100644
--- libiberty/configure.ac
+++ libiberty/configure.ac
@@ -685,12 +685,13 @@ fi
 
 # Figure out which version of pexecute to use.
 case "${host}" in
      *-*-mingw* | *-*-winnt*)	pexecute=pex-win32  ;;
      *-*-msdosdjgpp*)		pexecute=pex-djgpp  ;;
      *-*-msdos*)		pexecute=pex-msdos  ;;
+     *-*-amigaos*)		pexecute=pex-amigaos ;;
      *)				pexecute=pex-unix   ;;
 esac
 AC_SUBST(pexecute)
 
 libiberty_AC_FUNC_STRNCMP
 
diff --git a/libiberty/lrealpath.c b/libiberty/lrealpath.c
index b27c8de990e974c7294dfc4024ef44fbd3844a52..1491511553f865caaf8effc67a3ea42319edd3cf 100644
--- libiberty/lrealpath.c
+++ libiberty/lrealpath.c
@@ -46,12 +46,13 @@ components will be simplified.  The returned value will be allocated using
 #ifdef HAVE_UNISTD_H
 #include <unistd.h>
 #endif
 #ifdef HAVE_STRING_H
 #include <string.h>
 #endif
+#include <stdio.h> /* for MAXPATHLEN */
 
 /* On GNU libc systems the declaration is only visible with _GNU_SOURCE.  */
 #if defined(HAVE_CANONICALIZE_FILE_NAME) \
     && defined(NEED_DECLARATION_CANONICALIZE_FILE_NAME)
 extern char *canonicalize_file_name (const char *);
 #endif
@@ -106,13 +107,13 @@ lrealpath (const char *filename)
      compile time buffer size and no alternative function.  Query the
      OS, using pathconf(), for the buffer limit.  Care is needed
      though, some systems do not limit PATH_MAX (return -1 for
      pathconf()) making it impossible to pass a correctly sized buffer
      to realpath() (it could always overflow).  On those systems, we
      skip this.  */
-#if defined (HAVE_REALPATH) && defined (HAVE_UNISTD_H)
+#if !defined (REALPATH_LIMIT) && defined (HAVE_REALPATH) && defined (HAVE_UNISTD_H)
   {
     /* Find out the max path size.  */
     long path_max = pathconf ("/", _PC_PATH_MAX);
     if (path_max > 0)
       {
 	/* PATH_MAX is bounded.  */
diff --git a/libiberty/make-relative-prefix.c b/libiberty/make-relative-prefix.c
index fe639d18bd2815a5ec33aef28720386725ab1bd5..0b5691adc3f6ed9013472568d9d001495205673b 100644
--- libiberty/make-relative-prefix.c
+++ libiberty/make-relative-prefix.c
@@ -63,44 +63,43 @@ relative prefix can be found, return @code{NULL}.
 #endif
 
 #include <string.h>
 
 #include "ansidecl.h"
 #include "libiberty.h"
+#include "filenames.h"
 
 #ifndef R_OK
 #define R_OK 4
 #define W_OK 2
 #define X_OK 1
 #endif
 
-#ifndef DIR_SEPARATOR
-#  define DIR_SEPARATOR '/'
-#endif
-
 #if defined (_WIN32) || defined (__MSDOS__) \
     || defined (__DJGPP__) || defined (__OS2__)
-#  define HAVE_DOS_BASED_FILE_SYSTEM
-#  define HAVE_HOST_EXECUTABLE_SUFFIX
-#  define HOST_EXECUTABLE_SUFFIX ".exe"
-#  ifndef DIR_SEPARATOR_2 
-#    define DIR_SEPARATOR_2 '\\'
-#  endif
-#  define PATH_SEPARATOR ';'
-#else
-#  define PATH_SEPARATOR ':'
+# define HAVE_HOST_EXECUTABLE_SUFFIX
+# define HOST_EXECUTABLE_SUFFIX ".exe"
+# define PATH_SEPARATOR ';'
+#endif
+
+#ifdef __amigaos__
+# define PATH_SEPARATOR ':'
+# define DIR_UP ".."
 #endif
 
-#ifndef DIR_SEPARATOR_2
-#  define IS_DIR_SEPARATOR(ch) ((ch) == DIR_SEPARATOR)
-#else
-#  define IS_DIR_SEPARATOR(ch) \
-	(((ch) == DIR_SEPARATOR) || ((ch) == DIR_SEPARATOR_2))
+#ifndef PATH_SEPARATOR
+# define PATH_SEPARATOR ':'
 #endif
 
-#define DIR_UP ".."
+#ifndef DIR_UP
+# define DIR_UP ".."
+#endif
+
+#ifndef DIR_SEPARATOR
+# define DIR_SEPARATOR '/'
+#endif
 
 static char *save_string (const char *, int);
 static char **split_directories	(const char *, int *);
 static void free_split_directories (char **);
 
 static char *
diff --git a/libiberty/make-temp-file.c b/libiberty/make-temp-file.c
index 244cc23c5090e1c0d227820dc703adbc8022f8d5..5edcd153410bcd459a0546fd9d3cef6ee91a29af 100644
--- libiberty/make-temp-file.c
+++ libiberty/make-temp-file.c
@@ -38,25 +38,26 @@ Boston, MA 02110-1301, USA.  */
 #include <sys/file.h>   /* May get R_OK, etc. on some systems.  */
 #endif
 #if defined(_WIN32) && !defined(__CYGWIN__)
 #include <windows.h>
 #endif
 
+#ifndef DIR_SEPARATOR
+#define DIR_SEPARATOR '/'
+#endif
+
 #ifndef R_OK
 #define R_OK 4
 #define W_OK 2
 #define X_OK 1
 #endif
 
 #include "libiberty.h"
-extern int mkstemps (char *, int);
+#include "filenames.h"
 
-/* '/' works just fine on MS-DOS based systems.  */
-#ifndef DIR_SEPARATOR
-#define DIR_SEPARATOR '/'
-#endif
+extern int mkstemps (char *, int);
 
 /* Name of temporary file.
    mktemp requires 6 trailing X's.  */
 #define TEMP_FILE "ccXXXXXX"
 #define TEMP_FILE_LEN (sizeof(TEMP_FILE) - 1)
 
@@ -78,17 +79,19 @@ try_dir (const char *dir, const char *base)
   if (dir != 0
       && access (dir, R_OK | W_OK | X_OK) == 0)
     return dir;
   return 0;
 }
 
+#ifndef __amigaos__
 static const char tmp[] = { DIR_SEPARATOR, 't', 'm', 'p', 0 };
 static const char usrtmp[] =
 { DIR_SEPARATOR, 'u', 's', 'r', DIR_SEPARATOR, 't', 'm', 'p', 0 };
 static const char vartmp[] =
 { DIR_SEPARATOR, 'v', 'a', 'r', DIR_SEPARATOR, 't', 'm', 'p', 0 };
+#endif /* __amigaos__ */
 
 #endif
 
 static char *memoized_tmpdir;
 
 /*
@@ -127,27 +130,37 @@ choose_tmpdir (void)
       if (strcmp (P_tmpdir, "\\") == 0)
 	base = try_dir ("\\.", base);
       else
 	base = try_dir (P_tmpdir, base);
 #endif
 
+#ifndef __amigaos__
       /* Try /var/tmp, /usr/tmp, then /tmp.  */
       base = try_dir (vartmp, base);
       base = try_dir (usrtmp, base);
       base = try_dir (tmp, base);
+#else
+      base = try_dir ("T:", base);
+#endif
       
       /* If all else fails, use the current directory!  */
       if (base == 0)
 	base = ".";
       /* Append DIR_SEPARATOR to the directory we've chosen
 	 and return it.  */
       len = strlen (base);
       tmpdir = XNEWVEC (char, len + 2);
       strcpy (tmpdir, base);
-      tmpdir[len] = DIR_SEPARATOR;
-      tmpdir[len+1] = '\0';
+
+      /* Don't add DIR_SEPARATOR if base already ends with a dir separator,
+         it's unneeded and can cause ill effects on e.g. AmigaOS.  */
+      if (!IS_DIR_SEPARATOR(base[len-1]))
+        {
+          tmpdir[len] = DIR_SEPARATOR;
+          tmpdir[len+1] = '\0';
+        }
       memoized_tmpdir = tmpdir;
 #else /* defined(_WIN32) && !defined(__CYGWIN__) */
       DWORD len;
 
       /* Figure out how much space we need.  */
       len = GetTempPath(0, NULL);
diff --git a/libiberty/pex-amigaos.c b/libiberty/pex-amigaos.c
new file mode 100644
index 0000000000000000000000000000000000000000..0c61a108764c8501f8a2e9552c7c07499f402b1a
--- /dev/null
+++ libiberty/pex-amigaos.c
@@ -0,0 +1,325 @@
+/* Utilities to execute a program in a subprocess (possibly linked by pipes
+   with other subprocesses), and wait for it.  Generic AMIGAOS specialization.
+   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001, 2003, 2005
+   Free Software Foundation, Inc.
+
+This file is part of the libiberty library.
+Libiberty is free software; you can redistribute it and/or
+modify it under the terms of the GNU Library General Public
+License as published by the Free Software Foundation; either
+version 2 of the License, or (at your option) any later version.
+
+Libiberty is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+Library General Public License for more details.
+
+You should have received a copy of the GNU Library General Public
+License along with libiberty; see the file COPYING.LIB.  If not,
+write to the Free Software Foundation, Inc., 51 Franklin Street - Fifth Floor,
+Boston, MA 02110-1301, USA.  */
+
+#include "pex-common.h"
+
+#include <stdio.h>
+#include <errno.h>
+#ifdef NEED_DECLARATION_ERRNO
+extern int errno;
+#endif
+#ifdef HAVE_STDLIB_H
+#include <stdlib.h>
+#endif
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <ctype.h>
+
+/* Use ECHILD if available, otherwise use EINVAL.  */
+#ifdef ECHILD
+#define PWAIT_ERROR ECHILD
+#else
+#define PWAIT_ERROR EINVAL
+#endif
+
+#if !defined(FD_CLOEXEC)
+#define FD_CLOEXEC 1
+#endif
+
+static int pex_amiga_open_read (struct pex_obj *, const char *, int);
+static int pex_amiga_open_write (struct pex_obj *, const char *, int);
+static pid_t pex_amiga_exec_child (struct pex_obj *, int, const char *,
+				 char * const *, char * const *,
+				 int, int, int, int,
+				 const char **, int *);
+static int pex_amiga_close (struct pex_obj *, int);
+static int pex_amiga_wait (struct pex_obj *, long, int *, struct pex_time *,
+			   int, const char **, int *);
+static FILE *pex_amiga_fdopenr (struct pex_obj *, int, int);
+static FILE *pex_amiga_fdopenw (struct pex_obj *, int, int);
+
+/* The list of functions we pass to the common routines.  */
+
+const struct pex_funcs funcs =
+{
+  pex_amiga_open_read,
+  pex_amiga_open_write,
+  pex_amiga_exec_child,
+  pex_amiga_close,
+  pex_amiga_wait,
+  NULL, /* pipe */
+  pex_amiga_fdopenr,
+  pex_amiga_fdopenw,
+  NULL, /* cleanup */
+};
+
+/* Return a newly initialized pex_obj structure.  */
+
+struct pex_obj *
+pex_init (int flags, const char *pname, const char *tempbase)
+{
+  /* AMIGAOS does not support pipes.  */
+  flags &= ~ PEX_USE_PIPES;
+  return pex_init_common (flags, pname, tempbase, &funcs);
+}
+
+/* Open a file for reading.  */
+
+static int
+pex_amiga_open_read (struct pex_obj *obj ATTRIBUTE_UNUSED, const char *name,
+		    int binary ATTRIBUTE_UNUSED)
+{
+  return open (name, O_RDONLY);
+}
+
+/* Open a file for writing.  */
+
+static int
+pex_amiga_open_write (struct pex_obj *obj ATTRIBUTE_UNUSED, const char *name,
+		     int binary ATTRIBUTE_UNUSED)
+{
+  /* Note that we can't use O_EXCL here because gcc may have already
+     created the temporary file via make_temp_file.  */
+  return open (name, O_WRONLY | O_CREAT | O_TRUNC);
+}
+
+/* Close a file.  */
+
+static int
+pex_amiga_close (struct pex_obj *obj ATTRIBUTE_UNUSED, int fd)
+{
+  return close (fd);
+}
+
+/* Execute a child.  */
+
+const unsigned char __shell_escape_character = '\\';
+
+static pid_t
+pex_amiga_exec_child (struct pex_obj *obj, int flags ATTRIBUTE_UNUSED, const char *executable ATTRIBUTE_UNUSED,
+		     char * const * argv, char * const * env ATTRIBUTE_UNUSED,
+                     int in ATTRIBUTE_UNUSED, int out ATTRIBUTE_UNUSED, int errdes ATTRIBUTE_UNUSED,
+		     int toclose ATTRIBUTE_UNUSED, const char **errmsg, int *err)
+{
+  int rc;
+  char *scmd,*s;
+  int i,j,c,len,arglen;
+  int need_quote;
+  int already_have_quote;
+  int escaped;
+  int *statuses;
+
+  len = 0;
+
+  for(i = 0 ; argv[i] != NULL ; i++)
+  {
+    arglen = strlen(argv[i]);
+
+    len += 1 + arglen;
+
+    need_quote = already_have_quote = 0;
+
+    /* Check if this parameter is already surrounded by double quotes.
+       What counts is that the first character is a double quote. We
+       hope that the last character is an unescaped double quote, but
+       don't check for it. */
+    if(argv[i][0] == '\"')
+    {
+      already_have_quote = 1;
+    }
+    else
+    {
+      /* Check if there's a blank space in the argument. If so, we will
+         need to add double quote characters. */
+      for (j = 0 ; j < arglen ; j++)
+      {
+        c = argv[i][j];
+
+        if (isspace(c))
+        {
+          need_quote = 1;
+          break;
+        }
+      }
+
+      /* Make room for the double quote characters that we will have to add. */
+      if(need_quote)
+        len += 2;
+    }
+
+    /* Check if there are " or * characters in the quoted string which
+       may have to be escaped. */
+    if (need_quote || already_have_quote)
+    {
+      for (j = 0 ; j < arglen ; j++)
+      {
+        c = argv[i][j];
+
+        /* We just might have to add an escape character in front of these two. */
+        if (c == '\"' || c == '*')
+	        len++;
+      }
+    }
+  }
+
+  s = scmd = (char *) xmalloc (len+1);
+
+  for(i = 0 ; argv[i] != NULL ; i++)
+  {
+    arglen = strlen(argv[i]);
+
+    need_quote = already_have_quote = 0;
+
+    if (argv[i][0] == '\"')
+    {
+      already_have_quote = 1;
+    }
+    else
+    {
+      for (j = 0 ; j < arglen ; j++)
+      {
+        c = argv[i][j];
+
+        if (isspace(c))
+        {
+          need_quote = 1;
+          break;
+        }
+      }
+    }
+
+    if(s != scmd)
+      (*s++) = ' ';
+
+    if(need_quote)
+      (*s++) = '\"';
+
+    escaped = 0;
+
+    for(j = 0 ; j < arglen ; j++)
+    {
+      c = argv[i][j];
+
+      /* If this is a " or * and the parameter is quoted, try to
+         add an escape character in front of it. */
+      if((c == '\"' || c == '*') && (need_quote || already_have_quote))
+	    {
+        /* Careful, don't escape the first double
+           quote character by mistake. */
+        if(!already_have_quote || j > 0)
+        {
+          /* Don't add an escape character here if the previous character
+             already was an escape character. */
+          if(!escaped)
+            (*s++) = '*';
+	      }
+      }
+
+      (*s++) = c;
+
+      /* Remember if the last character read was an escape character. */
+      if (escaped)
+        escaped = 0;
+      else
+        escaped = (c == __shell_escape_character && c != '*');
+    }
+
+    if(need_quote)
+      (*s++) = '\"';
+  }
+
+  (*s) = '\0';
+
+  rc = system (scmd);
+
+  free (scmd);
+
+  if (rc == -1)
+  {
+    *err = errno;
+    *errmsg = install_error_msg;
+    return -1;
+  }
+
+  /* Save the exit status for later.  When we are called, obj->count
+     is the number of children which have executed before this
+     one.  */
+  statuses = (int *) obj->sysdep;
+  statuses = XRESIZEVEC (int, statuses, obj->count + 1);
+  statuses[obj->count] = (rc << 8); /* Tuck the status away for pwait */
+  obj->sysdep = (void *) statuses;
+
+  return obj->count;
+}
+
+/* Create a pipe.  */
+/*
+static int
+pex_amiga_pipe (struct pex_obj *obj ATTRIBUTE_UNUSED, int *p,
+	       int binary ATTRIBUTE_UNUSED)
+{
+  return pipe (p);
+}
+*/
+
+/* Get a FILE pointer to read from a file descriptor.  */
+
+static FILE *
+pex_amiga_fdopenr (struct pex_obj *obj ATTRIBUTE_UNUSED, int fd,
+		  int binary ATTRIBUTE_UNUSED)
+{
+  return fdopen (fd, "r");
+}
+
+/* Get a FILE pointer to write to a file descriptor.  */
+
+static FILE *
+pex_amiga_fdopenw (struct pex_obj *obj ATTRIBUTE_UNUSED, int fd,
+		  int binary ATTRIBUTE_UNUSED)
+{
+  if (fcntl (fd, F_SETFD, FD_CLOEXEC) < 0)
+    return NULL;
+  return fdopen (fd, "w");
+}
+
+
+/* Wait for a child process to complete.  Actually the child process
+   has already completed, and we just need to return the exit
+   status.  */
+
+static int
+pex_amiga_wait (struct pex_obj *obj, long pid, int *status,
+		struct pex_time *time, int done ATTRIBUTE_UNUSED,
+		const char **errmsg ATTRIBUTE_UNUSED,
+		int *err ATTRIBUTE_UNUSED)
+{
+  int *statuses;
+
+  if (time != NULL)
+    memset (time, 0, sizeof (struct pex_time));
+
+  statuses = (int *) obj->sysdep;
+  *status = statuses[pid];
+
+  return 0;
+}
diff --git a/libstdc++-v3/configure b/libstdc++-v3/configure
index 8cd4c76e70d82a9913c45f26b99e386ad659a3a0..b14ada402280cf8afa221731680d82b794a83352 100755
--- libstdc++-v3/configure
+++ libstdc++-v3/configure
@@ -77229,12 +77229,171 @@ done
 
     $as_echo "#define HAVE_TANF 1" >>confdefs.h
 
     $as_echo "#define HAVE_TANHF 1" >>confdefs.h
 
     ;;
+  *-amigaos*)
+    for ac_header in nan.h ieeefp.h endian.h sys/isa_defs.h \
+      machine/endian.h machine/param.h sys/machine.h sys/types.h \
+      fp.h locale.h float.h inttypes.h
+do :
+  as_ac_Header=`$as_echo "ac_cv_header_$ac_header" | $as_tr_sh`
+ac_fn_c_check_header_mongrel "$LINENO" "$ac_header" "$as_ac_Header" "$ac_includes_default"
+eval as_val=\$$as_ac_Header
+   if test "x$as_val" = x""yes; then :
+  cat >>confdefs.h <<_ACEOF
+#define `$as_echo "HAVE_$ac_header" | $as_tr_cpp` 1
+_ACEOF
+
+fi
+
+done
+
+    SECTION_FLAGS='-ffunction-sections -fdata-sections'
+
+
+  # If we're not using GNU ld, then there's no point in even trying these
+  # tests.  Check for that first.  We should have already tested for gld
+  # by now (in libtool), but require it now just to be safe...
+  test -z "$SECTION_LDFLAGS" && SECTION_LDFLAGS=''
+  test -z "$OPT_LDFLAGS" && OPT_LDFLAGS=''
+
+
+
+  # The name set by libtool depends on the version of libtool.  Shame on us
+  # for depending on an impl detail, but c'est la vie.  Older versions used
+  # ac_cv_prog_gnu_ld, but now it's lt_cv_prog_gnu_ld, and is copied back on
+  # top of with_gnu_ld (which is also set by --with-gnu-ld, so that actually
+  # makes sense).  We'll test with_gnu_ld everywhere else, so if that isn't
+  # set (hence we're using an older libtool), then set it.
+  if test x${with_gnu_ld+set} != xset; then
+    if test x${ac_cv_prog_gnu_ld+set} != xset; then
+      # We got through "ac_require(ac_prog_ld)" and still not set?  Huh?
+      with_gnu_ld=no
+    else
+      with_gnu_ld=$ac_cv_prog_gnu_ld
+    fi
+  fi
+
+  # Start by getting the version number.  I think the libtool test already
+  # does some of this, but throws away the result.
+  glibcxx_ld_is_gold=no
+  if test x"$with_gnu_ld" = x"yes"; then
+    { $as_echo "$as_me:${as_lineno-$LINENO}: checking for ld version" >&5
+$as_echo_n "checking for ld version... " >&6; }
+
+    if $LD --version 2>/dev/null | grep 'GNU gold' >/dev/null 2>&1; then
+      glibcxx_ld_is_gold=yes
+    fi
+    ldver=`$LD --version 2>/dev/null |
+	   sed -e 's/GNU gold /GNU ld /;s/GNU ld version /GNU ld /;s/GNU ld ([^)]*) /GNU ld /;s/GNU ld \([0-9.][0-9.]*\).*/\1/; q'`
+
+    glibcxx_gnu_ld_version=`echo $ldver | \
+	   $AWK -F. '{ if (NF<3) $3=0; print ($1*100+$2)*100+$3 }'`
+    { $as_echo "$as_me:${as_lineno-$LINENO}: result: $glibcxx_gnu_ld_version" >&5
+$as_echo "$glibcxx_gnu_ld_version" >&6; }
+  fi
+
+  # Set --gc-sections.
+  glibcxx_have_gc_sections=no
+  if test "$glibcxx_ld_is_gold" = "yes"; then
+    if $LD --help 2>/dev/null | grep gc-sections >/dev/null 2>&1; then
+      glibcxx_have_gc_sections=yes
+    fi
+  else
+    glibcxx_gcsections_min_ld=21602
+    if test x"$with_gnu_ld" = x"yes" &&
+	test $glibcxx_gnu_ld_version -gt $glibcxx_gcsections_min_ld ; then
+      glibcxx_have_gc_sections=yes
+    fi
+  fi
+  if test "$glibcxx_have_gc_sections" = "yes"; then
+    # Sufficiently young GNU ld it is!  Joy and bunny rabbits!
+    # NB: This flag only works reliably after 2.16.1. Configure tests
+    # for this are difficult, so hard wire a value that should work.
+
+    ac_test_CFLAGS="${CFLAGS+set}"
+    ac_save_CFLAGS="$CFLAGS"
+    CFLAGS='-Wl,--gc-sections'
+
+    # Check for -Wl,--gc-sections
+    { $as_echo "$as_me:${as_lineno-$LINENO}: checking for ld that supports -Wl,--gc-sections" >&5
+$as_echo_n "checking for ld that supports -Wl,--gc-sections... " >&6; }
+    if test x$gcc_no_link = xyes; then
+  as_fn_error "Link tests are not allowed after GCC_NO_EXECUTABLES." "$LINENO" 5
+fi
+cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+ int one(void) { return 1; }
+     int two(void) { return 2; }
+
+int
+main ()
+{
+ two();
+  ;
+  return 0;
+}
+_ACEOF
+if ac_fn_c_try_link "$LINENO"; then :
+  ac_gcsections=yes
+else
+  ac_gcsections=no
+fi
+rm -f core conftest.err conftest.$ac_objext \
+    conftest$ac_exeext conftest.$ac_ext
+    if test "$ac_gcsections" = "yes"; then
+      rm -f conftest.c
+      touch conftest.c
+      if $CC -c conftest.c; then
+	if $LD --gc-sections -o conftest conftest.o 2>&1 | \
+	   grep "Warning: gc-sections option ignored" > /dev/null; then
+	  ac_gcsections=no
+	fi
+      fi
+      rm -f conftest.c conftest.o conftest
+    fi
+    if test "$ac_gcsections" = "yes"; then
+      SECTION_LDFLAGS="-Wl,--gc-sections $SECTION_LDFLAGS"
+    fi
+    { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_gcsections" >&5
+$as_echo "$ac_gcsections" >&6; }
+
+    if test "$ac_test_CFLAGS" = set; then
+      CFLAGS="$ac_save_CFLAGS"
+    else
+      # this is the suspicious part
+      CFLAGS=''
+    fi
+  fi
+
+  # Set -z,relro.
+  # Note this is only for shared objects.
+  ac_ld_relro=no
+  if test x"$with_gnu_ld" = x"yes"; then
+    { $as_echo "$as_me:${as_lineno-$LINENO}: checking for ld that supports -Wl,-z,relro" >&5
+$as_echo_n "checking for ld that supports -Wl,-z,relro... " >&6; }
+    cxx_z_relo=`$LD -v --help 2>/dev/null | grep "z relro"`
+    if test -n "$cxx_z_relo"; then
+      OPT_LDFLAGS="-Wl,-z,relro"
+      ac_ld_relro=yes
+    fi
+    { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_ld_relro" >&5
+$as_echo "$ac_ld_relro" >&6; }
+  fi
+
+  # Set linker optimization flags.
+  if test x"$with_gnu_ld" = x"yes"; then
+    OPT_LDFLAGS="-Wl,-O1 $OPT_LDFLAGS"
+  fi
+
+
+
+
+    ;;
   *)
     as_fn_error "No support for this host/target combination." "$LINENO" 5
    ;;
 esac
 
   fi
@@ -80295,43 +80454,1687 @@ $as_echo "$gxx_include_dir" >&6; }
 
 
   WARN_FLAGS='-Wall -Wextra -Wwrite-strings -Wcast-qual -Wabi'
 
 
 
-ac_config_files="$ac_config_files Makefile"
-
-ac_config_files="$ac_config_files scripts/testsuite_flags"
-
-ac_config_files="$ac_config_files scripts/extract_symvers"
+# create libtool - libtool > 2.0:
+: ${CONFIG_LT=./config.lt}
+{ $as_echo "$as_me:${as_lineno-$LINENO}: creating $CONFIG_LT" >&5
+$as_echo "$as_me: creating $CONFIG_LT" >&6;}
+as_write_fail=0
+cat >"$CONFIG_LT" <<_ASEOF || as_write_fail=1
+#! $SHELL
+# Generated by $as_me.
+# Run this file to recreate a libtool stub with the current configuration.
+SHELL=\${CONFIG_SHELL-$SHELL}
+export SHELL
+_ASEOF
+cat >>"$CONFIG_LT" <<\_ASEOF || as_write_fail=1
+## -------------------- ##
+## M4sh Initialization. ##
+## -------------------- ##
 
-ac_config_files="$ac_config_files doc/xsl/customization.xsl"
+# Be more Bourne compatible
+DUALCASE=1; export DUALCASE # for MKS sh
+if test -n "${ZSH_VERSION+set}" && (emulate sh) >/dev/null 2>&1; then :
+  emulate sh
+  NULLCMD=:
+  # Pre-4.2 versions of Zsh do word splitting on ${1+"$@"}, which
+  # is contrary to our usage.  Disable this feature.
+  alias -g '${1+"$@"}'='"$@"'
+  setopt NO_GLOB_SUBST
+else
+  case `(set -o) 2>/dev/null` in #(
+  *posix*) :
+    set -o posix ;; #(
+  *) :
+     ;;
+esac
+fi
 
 
-# Multilibs need MULTISUBDIR defined correctly in certain makefiles so
-# that multilib installs will end up installed in the correct place.
-# The testsuite needs it for multilib-aware ABI baseline files.
-# To work around this not being passed down from config-ml.in ->
-# srcdir/Makefile.am -> srcdir/{src,libsupc++,...}/Makefile.am, manually
-# append it here.  Only modify Makefiles that have just been created.
-#
-# Also, get rid of this simulated-VPATH thing that automake does.
-ac_config_files="$ac_config_files include/Makefile libsupc++/Makefile src/Makefile src/c++98/Makefile src/c++11/Makefile src/filesystem/Makefile doc/Makefile po/Makefile testsuite/Makefile python/Makefile"
+as_nl='
+'
+export as_nl
+# Printing a long string crashes Solaris 7 /usr/bin/printf.
+as_echo='\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\'
+as_echo=$as_echo$as_echo$as_echo$as_echo$as_echo
+as_echo=$as_echo$as_echo$as_echo$as_echo$as_echo$as_echo
+# Prefer a ksh shell builtin over an external printf program on Solaris,
+# but without wasting forks for bash or zsh.
+if test -z "$BASH_VERSION$ZSH_VERSION" \
+    && (test "X`print -r -- $as_echo`" = "X$as_echo") 2>/dev/null; then
+  as_echo='print -r --'
+  as_echo_n='print -rn --'
+elif (test "X`printf %s $as_echo`" = "X$as_echo") 2>/dev/null; then
+  as_echo='printf %s\n'
+  as_echo_n='printf %s'
+else
+  if test "X`(/usr/ucb/echo -n -n $as_echo) 2>/dev/null`" = "X-n $as_echo"; then
+    as_echo_body='eval /usr/ucb/echo -n "$1$as_nl"'
+    as_echo_n='/usr/ucb/echo -n'
+  else
+    as_echo_body='eval expr "X$1" : "X\\(.*\\)"'
+    as_echo_n_body='eval
+      arg=$1;
+      case $arg in #(
+      *"$as_nl"*)
+	expr "X$arg" : "X\\(.*\\)$as_nl";
+	arg=`expr "X$arg" : ".*$as_nl\\(.*\\)"`;;
+      esac;
+      expr "X$arg" : "X\\(.*\\)" | tr -d "$as_nl"
+    '
+    export as_echo_n_body
+    as_echo_n='sh -c $as_echo_n_body as_echo'
+  fi
+  export as_echo_body
+  as_echo='sh -c $as_echo_body as_echo'
+fi
 
+# The user is always right.
+if test "${PATH_SEPARATOR+set}" != set; then
+  PATH_SEPARATOR=:
+  (PATH='/bin;/bin'; FPATH=$PATH; sh -c :) >/dev/null 2>&1 && {
+    (PATH='/bin:/bin'; FPATH=$PATH; sh -c :) >/dev/null 2>&1 ||
+      PATH_SEPARATOR=';'
+  }
+fi
 
-ac_config_commands="$ac_config_commands generate-headers"
 
+# IFS
+# We need space, tab and new line, in precisely that order.  Quoting is
+# there to prevent editors from complaining about space-tab.
+# (If _AS_PATH_WALK were called with IFS unset, it would disable word
+# splitting by setting IFS to empty value.)
+IFS=" ""	$as_nl"
 
-cat >confcache <<\_ACEOF
-# This file is a shell script that caches the results of configure
-# tests run on this system so they can be shared between configure
-# scripts and configure runs, see configure's option --config-cache.
-# It is not useful on other systems.  If it contains results you don't
-# want to keep, you may remove or edit it.
-#
-# config.status only pays attention to the cache file if you give it
+# Find who we are.  Look in the path if we contain no directory separator.
+case $0 in #((
+  *[\\/]* ) as_myself=$0 ;;
+  *) as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+    test -r "$as_dir/$0" && as_myself=$as_dir/$0 && break
+  done
+IFS=$as_save_IFS
+
+     ;;
+esac
+# We did not find ourselves, most probably we were run as `sh COMMAND'
+# in which case we are not to be found in the path.
+if test "x$as_myself" = x; then
+  as_myself=$0
+fi
+if test ! -f "$as_myself"; then
+  $as_echo "$as_myself: error: cannot find myself; rerun with an absolute file name" >&2
+  exit 1
+fi
+
+# Unset variables that we do not need and which cause bugs (e.g. in
+# pre-3.0 UWIN ksh).  But do not cause bugs in bash 2.01; the "|| exit 1"
+# suppresses any "Segmentation fault" message there.  '((' could
+# trigger a bug in pdksh 5.2.14.
+for as_var in BASH_ENV ENV MAIL MAILPATH
+do eval test x\${$as_var+set} = xset \
+  && ( (unset $as_var) || exit 1) >/dev/null 2>&1 && unset $as_var || :
+done
+PS1='$ '
+PS2='> '
+PS4='+ '
+
+# NLS nuisances.
+LC_ALL=C
+export LC_ALL
+LANGUAGE=C
+export LANGUAGE
+
+# CDPATH.
+(unset CDPATH) >/dev/null 2>&1 && unset CDPATH
+
+
+# as_fn_error ERROR [LINENO LOG_FD]
+# ---------------------------------
+# Output "`basename $0`: error: ERROR" to stderr. If LINENO and LOG_FD are
+# provided, also output the error to LOG_FD, referencing LINENO. Then exit the
+# script with status $?, using 1 if that was 0.
+as_fn_error ()
+{
+  as_status=$?; test $as_status -eq 0 && as_status=1
+  if test "$3"; then
+    as_lineno=${as_lineno-"$2"} as_lineno_stack=as_lineno_stack=$as_lineno_stack
+    $as_echo "$as_me:${as_lineno-$LINENO}: error: $1" >&$3
+  fi
+  $as_echo "$as_me: error: $1" >&2
+  as_fn_exit $as_status
+} # as_fn_error
+
+
+# as_fn_set_status STATUS
+# -----------------------
+# Set $? to STATUS, without forking.
+as_fn_set_status ()
+{
+  return $1
+} # as_fn_set_status
+
+# as_fn_exit STATUS
+# -----------------
+# Exit the shell with STATUS, even in a "trap 0" or "set -e" context.
+as_fn_exit ()
+{
+  set +e
+  as_fn_set_status $1
+  exit $1
+} # as_fn_exit
+
+# as_fn_unset VAR
+# ---------------
+# Portably unset VAR.
+as_fn_unset ()
+{
+  { eval $1=; unset $1;}
+}
+as_unset=as_fn_unset
+# as_fn_append VAR VALUE
+# ----------------------
+# Append the text in VALUE to the end of the definition contained in VAR. Take
+# advantage of any shell optimizations that allow amortized linear growth over
+# repeated appends, instead of the typical quadratic growth present in naive
+# implementations.
+if (eval "as_var=1; as_var+=2; test x\$as_var = x12") 2>/dev/null; then :
+  eval 'as_fn_append ()
+  {
+    eval $1+=\$2
+  }'
+else
+  as_fn_append ()
+  {
+    eval $1=\$$1\$2
+  }
+fi # as_fn_append
+
+# as_fn_arith ARG...
+# ------------------
+# Perform arithmetic evaluation on the ARGs, and store the result in the
+# global $as_val. Take advantage of shells that can avoid forks. The arguments
+# must be portable across $(()) and expr.
+if (eval "test \$(( 1 + 1 )) = 2") 2>/dev/null; then :
+  eval 'as_fn_arith ()
+  {
+    as_val=$(( $* ))
+  }'
+else
+  as_fn_arith ()
+  {
+    as_val=`expr "$@" || test $? -eq 1`
+  }
+fi # as_fn_arith
+
+
+if expr a : '\(a\)' >/dev/null 2>&1 &&
+   test "X`expr 00001 : '.*\(...\)'`" = X001; then
+  as_expr=expr
+else
+  as_expr=false
+fi
+
+if (basename -- /) >/dev/null 2>&1 && test "X`basename -- / 2>&1`" = "X/"; then
+  as_basename=basename
+else
+  as_basename=false
+fi
+
+if (as_dir=`dirname -- /` && test "X$as_dir" = X/) >/dev/null 2>&1; then
+  as_dirname=dirname
+else
+  as_dirname=false
+fi
+
+as_me=`$as_basename -- "$0" ||
+$as_expr X/"$0" : '.*/\([^/][^/]*\)/*$' \| \
+	 X"$0" : 'X\(//\)$' \| \
+	 X"$0" : 'X\(/\)' \| . 2>/dev/null ||
+$as_echo X/"$0" |
+    sed '/^.*\/\([^/][^/]*\)\/*$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\/\(\/\/\)$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\/\(\/\).*/{
+	    s//\1/
+	    q
+	  }
+	  s/.*/./; q'`
+
+# Avoid depending upon Character Ranges.
+as_cr_letters='abcdefghijklmnopqrstuvwxyz'
+as_cr_LETTERS='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
+as_cr_Letters=$as_cr_letters$as_cr_LETTERS
+as_cr_digits='0123456789'
+as_cr_alnum=$as_cr_Letters$as_cr_digits
+
+ECHO_C= ECHO_N= ECHO_T=
+case `echo -n x` in #(((((
+-n*)
+  case `echo 'xy\c'` in
+  *c*) ECHO_T='	';;	# ECHO_T is single tab character.
+  xy)  ECHO_C='\c';;
+  *)   echo `echo ksh88 bug on AIX 6.1` > /dev/null
+       ECHO_T='	';;
+  esac;;
+*)
+  ECHO_N='-n';;
+esac
+
+rm -f conf$$ conf$$.exe conf$$.file
+if test -d conf$$.dir; then
+  rm -f conf$$.dir/conf$$.file
+else
+  rm -f conf$$.dir
+  mkdir conf$$.dir 2>/dev/null
+fi
+if (echo >conf$$.file) 2>/dev/null; then
+  if ln -s conf$$.file conf$$ 2>/dev/null; then
+    as_ln_s='ln -s'
+    # ... but there are two gotchas:
+    # 1) On MSYS, both `ln -s file dir' and `ln file dir' fail.
+    # 2) DJGPP < 2.04 has no symlinks; `ln -s' creates a wrapper executable.
+    # In both cases, we have to default to `cp -p'.
+    ln -s conf$$.file conf$$.dir 2>/dev/null && test ! -f conf$$.exe ||
+      as_ln_s='cp -p'
+  elif ln conf$$.file conf$$ 2>/dev/null; then
+    as_ln_s=ln
+  else
+    as_ln_s='cp -p'
+  fi
+else
+  as_ln_s='cp -p'
+fi
+rm -f conf$$ conf$$.exe conf$$.dir/conf$$.file conf$$.file
+rmdir conf$$.dir 2>/dev/null
+
+
+# as_fn_mkdir_p
+# -------------
+# Create "$as_dir" as a directory, including parents if necessary.
+as_fn_mkdir_p ()
+{
+
+  case $as_dir in #(
+  -*) as_dir=./$as_dir;;
+  esac
+  test -d "$as_dir" || eval $as_mkdir_p || {
+    as_dirs=
+    while :; do
+      case $as_dir in #(
+      *\'*) as_qdir=`$as_echo "$as_dir" | sed "s/'/'\\\\\\\\''/g"`;; #'(
+      *) as_qdir=$as_dir;;
+      esac
+      as_dirs="'$as_qdir' $as_dirs"
+      as_dir=`$as_dirname -- "$as_dir" ||
+$as_expr X"$as_dir" : 'X\(.*[^/]\)//*[^/][^/]*/*$' \| \
+	 X"$as_dir" : 'X\(//\)[^/]' \| \
+	 X"$as_dir" : 'X\(//\)$' \| \
+	 X"$as_dir" : 'X\(/\)' \| . 2>/dev/null ||
+$as_echo X"$as_dir" |
+    sed '/^X\(.*[^/]\)\/\/*[^/][^/]*\/*$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\/\)[^/].*/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\/\)$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\).*/{
+	    s//\1/
+	    q
+	  }
+	  s/.*/./; q'`
+      test -d "$as_dir" && break
+    done
+    test -z "$as_dirs" || eval "mkdir $as_dirs"
+  } || test -d "$as_dir" || as_fn_error "cannot create directory $as_dir"
+
+
+} # as_fn_mkdir_p
+if mkdir -p . 2>/dev/null; then
+  as_mkdir_p='mkdir -p "$as_dir"'
+else
+  test -d ./-p && rmdir ./-p
+  as_mkdir_p=false
+fi
+
+if test -x / >/dev/null 2>&1; then
+  as_test_x='test -x'
+else
+  if ls -dL / >/dev/null 2>&1; then
+    as_ls_L_option=L
+  else
+    as_ls_L_option=
+  fi
+  as_test_x='
+    eval sh -c '\''
+      if test -d "$1"; then
+	test -d "$1/.";
+      else
+	case $1 in #(
+	-*)set "./$1";;
+	esac;
+	case `ls -ld'$as_ls_L_option' "$1" 2>/dev/null` in #((
+	???[sx]*):;;*)false;;esac;fi
+    '\'' sh
+  '
+fi
+as_executable_p=$as_test_x
+
+# Sed expression to map a string onto a valid CPP name.
+as_tr_cpp="eval sed 'y%*$as_cr_letters%P$as_cr_LETTERS%;s%[^_$as_cr_alnum]%_%g'"
+
+# Sed expression to map a string onto a valid variable name.
+as_tr_sh="eval sed 'y%*+%pp%;s%[^_$as_cr_alnum]%_%g'"
+
+
+exec 6>&1
+## --------------------------------- ##
+## Main body of "$CONFIG_LT" script. ##
+## --------------------------------- ##
+_ASEOF
+test $as_write_fail = 0 && chmod +x "$CONFIG_LT"
+
+cat >>"$CONFIG_LT" <<\_LTEOF
+lt_cl_silent=false
+exec 5>>config.log
+{
+  echo
+  sed 'h;s/./-/g;s/^.../## /;s/...$/ ##/;p;x;p;x' <<_ASBOX
+## Running $as_me. ##
+_ASBOX
+} >&5
+
+lt_cl_help="\
+\`$as_me' creates a local libtool stub from the current configuration,
+for use in further configure time tests before the real libtool is
+generated.
+
+Usage: $0 [OPTIONS]
+
+  -h, --help      print this help, then exit
+  -V, --version   print version number, then exit
+  -q, --quiet     do not print progress messages
+  -d, --debug     don't remove temporary files
+
+Report bugs to <bug-libtool@gnu.org>."
+
+lt_cl_version="\
+package-unused config.lt version-unused
+configured by $0, generated by GNU Autoconf 2.64.
+
+Copyright (C) 2009 Free Software Foundation, Inc.
+This config.lt script is free software; the Free Software Foundation
+gives unlimited permision to copy, distribute and modify it."
+
+while test $# != 0
+do
+  case $1 in
+    --version | --v* | -V )
+      echo "$lt_cl_version"; exit 0 ;;
+    --help | --h* | -h )
+      echo "$lt_cl_help"; exit 0 ;;
+    --debug | --d* | -d )
+      debug=: ;;
+    --quiet | --q* | --silent | --s* | -q )
+      lt_cl_silent=: ;;
+
+    -*) as_fn_error "unrecognized option: $1
+Try \`$0 --help' for more information." "$LINENO" 5 ;;
+
+    *) as_fn_error "unrecognized argument: $1
+Try \`$0 --help' for more information." "$LINENO" 5 ;;
+  esac
+  shift
+done
+
+if $lt_cl_silent; then
+  exec 6>/dev/null
+fi
+_LTEOF
+
+cat >>"$CONFIG_LT" <<_LTEOF
+
+
+# The HP-UX ksh and POSIX shell print the target directory to stdout
+# if CDPATH is set.
+(unset CDPATH) >/dev/null 2>&1 && unset CDPATH
+
+sed_quote_subst='$sed_quote_subst'
+double_quote_subst='$double_quote_subst'
+delay_variable_subst='$delay_variable_subst'
+macro_version='`$ECHO "$macro_version" | $SED "$delay_single_quote_subst"`'
+macro_revision='`$ECHO "$macro_revision" | $SED "$delay_single_quote_subst"`'
+enable_shared='`$ECHO "$enable_shared" | $SED "$delay_single_quote_subst"`'
+enable_static='`$ECHO "$enable_static" | $SED "$delay_single_quote_subst"`'
+pic_mode='`$ECHO "$pic_mode" | $SED "$delay_single_quote_subst"`'
+enable_fast_install='`$ECHO "$enable_fast_install" | $SED "$delay_single_quote_subst"`'
+SHELL='`$ECHO "$SHELL" | $SED "$delay_single_quote_subst"`'
+ECHO='`$ECHO "$ECHO" | $SED "$delay_single_quote_subst"`'
+host_alias='`$ECHO "$host_alias" | $SED "$delay_single_quote_subst"`'
+host='`$ECHO "$host" | $SED "$delay_single_quote_subst"`'
+host_os='`$ECHO "$host_os" | $SED "$delay_single_quote_subst"`'
+build_alias='`$ECHO "$build_alias" | $SED "$delay_single_quote_subst"`'
+build='`$ECHO "$build" | $SED "$delay_single_quote_subst"`'
+build_os='`$ECHO "$build_os" | $SED "$delay_single_quote_subst"`'
+SED='`$ECHO "$SED" | $SED "$delay_single_quote_subst"`'
+Xsed='`$ECHO "$Xsed" | $SED "$delay_single_quote_subst"`'
+GREP='`$ECHO "$GREP" | $SED "$delay_single_quote_subst"`'
+EGREP='`$ECHO "$EGREP" | $SED "$delay_single_quote_subst"`'
+FGREP='`$ECHO "$FGREP" | $SED "$delay_single_quote_subst"`'
+LD='`$ECHO "$LD" | $SED "$delay_single_quote_subst"`'
+NM='`$ECHO "$NM" | $SED "$delay_single_quote_subst"`'
+LN_S='`$ECHO "$LN_S" | $SED "$delay_single_quote_subst"`'
+max_cmd_len='`$ECHO "$max_cmd_len" | $SED "$delay_single_quote_subst"`'
+ac_objext='`$ECHO "$ac_objext" | $SED "$delay_single_quote_subst"`'
+exeext='`$ECHO "$exeext" | $SED "$delay_single_quote_subst"`'
+lt_unset='`$ECHO "$lt_unset" | $SED "$delay_single_quote_subst"`'
+lt_SP2NL='`$ECHO "$lt_SP2NL" | $SED "$delay_single_quote_subst"`'
+lt_NL2SP='`$ECHO "$lt_NL2SP" | $SED "$delay_single_quote_subst"`'
+reload_flag='`$ECHO "$reload_flag" | $SED "$delay_single_quote_subst"`'
+reload_cmds='`$ECHO "$reload_cmds" | $SED "$delay_single_quote_subst"`'
+OBJDUMP='`$ECHO "$OBJDUMP" | $SED "$delay_single_quote_subst"`'
+deplibs_check_method='`$ECHO "$deplibs_check_method" | $SED "$delay_single_quote_subst"`'
+file_magic_cmd='`$ECHO "$file_magic_cmd" | $SED "$delay_single_quote_subst"`'
+AR='`$ECHO "$AR" | $SED "$delay_single_quote_subst"`'
+AR_FLAGS='`$ECHO "$AR_FLAGS" | $SED "$delay_single_quote_subst"`'
+STRIP='`$ECHO "$STRIP" | $SED "$delay_single_quote_subst"`'
+RANLIB='`$ECHO "$RANLIB" | $SED "$delay_single_quote_subst"`'
+old_postinstall_cmds='`$ECHO "$old_postinstall_cmds" | $SED "$delay_single_quote_subst"`'
+old_postuninstall_cmds='`$ECHO "$old_postuninstall_cmds" | $SED "$delay_single_quote_subst"`'
+old_archive_cmds='`$ECHO "$old_archive_cmds" | $SED "$delay_single_quote_subst"`'
+lock_old_archive_extraction='`$ECHO "$lock_old_archive_extraction" | $SED "$delay_single_quote_subst"`'
+CC='`$ECHO "$CC" | $SED "$delay_single_quote_subst"`'
+CFLAGS='`$ECHO "$CFLAGS" | $SED "$delay_single_quote_subst"`'
+compiler='`$ECHO "$compiler" | $SED "$delay_single_quote_subst"`'
+GCC='`$ECHO "$GCC" | $SED "$delay_single_quote_subst"`'
+lt_cv_sys_global_symbol_pipe='`$ECHO "$lt_cv_sys_global_symbol_pipe" | $SED "$delay_single_quote_subst"`'
+lt_cv_sys_global_symbol_to_cdecl='`$ECHO "$lt_cv_sys_global_symbol_to_cdecl" | $SED "$delay_single_quote_subst"`'
+lt_cv_sys_global_symbol_to_c_name_address='`$ECHO "$lt_cv_sys_global_symbol_to_c_name_address" | $SED "$delay_single_quote_subst"`'
+lt_cv_sys_global_symbol_to_c_name_address_lib_prefix='`$ECHO "$lt_cv_sys_global_symbol_to_c_name_address_lib_prefix" | $SED "$delay_single_quote_subst"`'
+objdir='`$ECHO "$objdir" | $SED "$delay_single_quote_subst"`'
+MAGIC_CMD='`$ECHO "$MAGIC_CMD" | $SED "$delay_single_quote_subst"`'
+lt_prog_compiler_no_builtin_flag='`$ECHO "$lt_prog_compiler_no_builtin_flag" | $SED "$delay_single_quote_subst"`'
+lt_prog_compiler_wl='`$ECHO "$lt_prog_compiler_wl" | $SED "$delay_single_quote_subst"`'
+lt_prog_compiler_pic='`$ECHO "$lt_prog_compiler_pic" | $SED "$delay_single_quote_subst"`'
+lt_prog_compiler_static='`$ECHO "$lt_prog_compiler_static" | $SED "$delay_single_quote_subst"`'
+lt_cv_prog_compiler_c_o='`$ECHO "$lt_cv_prog_compiler_c_o" | $SED "$delay_single_quote_subst"`'
+need_locks='`$ECHO "$need_locks" | $SED "$delay_single_quote_subst"`'
+DSYMUTIL='`$ECHO "$DSYMUTIL" | $SED "$delay_single_quote_subst"`'
+NMEDIT='`$ECHO "$NMEDIT" | $SED "$delay_single_quote_subst"`'
+LIPO='`$ECHO "$LIPO" | $SED "$delay_single_quote_subst"`'
+OTOOL='`$ECHO "$OTOOL" | $SED "$delay_single_quote_subst"`'
+OTOOL64='`$ECHO "$OTOOL64" | $SED "$delay_single_quote_subst"`'
+libext='`$ECHO "$libext" | $SED "$delay_single_quote_subst"`'
+shrext_cmds='`$ECHO "$shrext_cmds" | $SED "$delay_single_quote_subst"`'
+extract_expsyms_cmds='`$ECHO "$extract_expsyms_cmds" | $SED "$delay_single_quote_subst"`'
+archive_cmds_need_lc='`$ECHO "$archive_cmds_need_lc" | $SED "$delay_single_quote_subst"`'
+enable_shared_with_static_runtimes='`$ECHO "$enable_shared_with_static_runtimes" | $SED "$delay_single_quote_subst"`'
+export_dynamic_flag_spec='`$ECHO "$export_dynamic_flag_spec" | $SED "$delay_single_quote_subst"`'
+whole_archive_flag_spec='`$ECHO "$whole_archive_flag_spec" | $SED "$delay_single_quote_subst"`'
+compiler_needs_object='`$ECHO "$compiler_needs_object" | $SED "$delay_single_quote_subst"`'
+old_archive_from_new_cmds='`$ECHO "$old_archive_from_new_cmds" | $SED "$delay_single_quote_subst"`'
+old_archive_from_expsyms_cmds='`$ECHO "$old_archive_from_expsyms_cmds" | $SED "$delay_single_quote_subst"`'
+archive_cmds='`$ECHO "$archive_cmds" | $SED "$delay_single_quote_subst"`'
+archive_expsym_cmds='`$ECHO "$archive_expsym_cmds" | $SED "$delay_single_quote_subst"`'
+module_cmds='`$ECHO "$module_cmds" | $SED "$delay_single_quote_subst"`'
+module_expsym_cmds='`$ECHO "$module_expsym_cmds" | $SED "$delay_single_quote_subst"`'
+with_gnu_ld='`$ECHO "$with_gnu_ld" | $SED "$delay_single_quote_subst"`'
+allow_undefined_flag='`$ECHO "$allow_undefined_flag" | $SED "$delay_single_quote_subst"`'
+no_undefined_flag='`$ECHO "$no_undefined_flag" | $SED "$delay_single_quote_subst"`'
+hardcode_libdir_flag_spec='`$ECHO "$hardcode_libdir_flag_spec" | $SED "$delay_single_quote_subst"`'
+hardcode_libdir_flag_spec_ld='`$ECHO "$hardcode_libdir_flag_spec_ld" | $SED "$delay_single_quote_subst"`'
+hardcode_libdir_separator='`$ECHO "$hardcode_libdir_separator" | $SED "$delay_single_quote_subst"`'
+hardcode_direct='`$ECHO "$hardcode_direct" | $SED "$delay_single_quote_subst"`'
+hardcode_direct_absolute='`$ECHO "$hardcode_direct_absolute" | $SED "$delay_single_quote_subst"`'
+hardcode_minus_L='`$ECHO "$hardcode_minus_L" | $SED "$delay_single_quote_subst"`'
+hardcode_shlibpath_var='`$ECHO "$hardcode_shlibpath_var" | $SED "$delay_single_quote_subst"`'
+hardcode_automatic='`$ECHO "$hardcode_automatic" | $SED "$delay_single_quote_subst"`'
+inherit_rpath='`$ECHO "$inherit_rpath" | $SED "$delay_single_quote_subst"`'
+link_all_deplibs='`$ECHO "$link_all_deplibs" | $SED "$delay_single_quote_subst"`'
+fix_srcfile_path='`$ECHO "$fix_srcfile_path" | $SED "$delay_single_quote_subst"`'
+always_export_symbols='`$ECHO "$always_export_symbols" | $SED "$delay_single_quote_subst"`'
+export_symbols_cmds='`$ECHO "$export_symbols_cmds" | $SED "$delay_single_quote_subst"`'
+exclude_expsyms='`$ECHO "$exclude_expsyms" | $SED "$delay_single_quote_subst"`'
+include_expsyms='`$ECHO "$include_expsyms" | $SED "$delay_single_quote_subst"`'
+prelink_cmds='`$ECHO "$prelink_cmds" | $SED "$delay_single_quote_subst"`'
+file_list_spec='`$ECHO "$file_list_spec" | $SED "$delay_single_quote_subst"`'
+variables_saved_for_relink='`$ECHO "$variables_saved_for_relink" | $SED "$delay_single_quote_subst"`'
+need_lib_prefix='`$ECHO "$need_lib_prefix" | $SED "$delay_single_quote_subst"`'
+need_version='`$ECHO "$need_version" | $SED "$delay_single_quote_subst"`'
+version_type='`$ECHO "$version_type" | $SED "$delay_single_quote_subst"`'
+runpath_var='`$ECHO "$runpath_var" | $SED "$delay_single_quote_subst"`'
+shlibpath_var='`$ECHO "$shlibpath_var" | $SED "$delay_single_quote_subst"`'
+shlibpath_overrides_runpath='`$ECHO "$shlibpath_overrides_runpath" | $SED "$delay_single_quote_subst"`'
+libname_spec='`$ECHO "$libname_spec" | $SED "$delay_single_quote_subst"`'
+library_names_spec='`$ECHO "$library_names_spec" | $SED "$delay_single_quote_subst"`'
+soname_spec='`$ECHO "$soname_spec" | $SED "$delay_single_quote_subst"`'
+install_override_mode='`$ECHO "$install_override_mode" | $SED "$delay_single_quote_subst"`'
+postinstall_cmds='`$ECHO "$postinstall_cmds" | $SED "$delay_single_quote_subst"`'
+postuninstall_cmds='`$ECHO "$postuninstall_cmds" | $SED "$delay_single_quote_subst"`'
+finish_cmds='`$ECHO "$finish_cmds" | $SED "$delay_single_quote_subst"`'
+finish_eval='`$ECHO "$finish_eval" | $SED "$delay_single_quote_subst"`'
+hardcode_into_libs='`$ECHO "$hardcode_into_libs" | $SED "$delay_single_quote_subst"`'
+sys_lib_search_path_spec='`$ECHO "$sys_lib_search_path_spec" | $SED "$delay_single_quote_subst"`'
+sys_lib_dlsearch_path_spec='`$ECHO "$sys_lib_dlsearch_path_spec" | $SED "$delay_single_quote_subst"`'
+hardcode_action='`$ECHO "$hardcode_action" | $SED "$delay_single_quote_subst"`'
+enable_dlopen='`$ECHO "$enable_dlopen" | $SED "$delay_single_quote_subst"`'
+enable_dlopen_self='`$ECHO "$enable_dlopen_self" | $SED "$delay_single_quote_subst"`'
+enable_dlopen_self_static='`$ECHO "$enable_dlopen_self_static" | $SED "$delay_single_quote_subst"`'
+old_striplib='`$ECHO "$old_striplib" | $SED "$delay_single_quote_subst"`'
+striplib='`$ECHO "$striplib" | $SED "$delay_single_quote_subst"`'
+compiler_lib_search_dirs='`$ECHO "$compiler_lib_search_dirs" | $SED "$delay_single_quote_subst"`'
+predep_objects='`$ECHO "$predep_objects" | $SED "$delay_single_quote_subst"`'
+postdep_objects='`$ECHO "$postdep_objects" | $SED "$delay_single_quote_subst"`'
+predeps='`$ECHO "$predeps" | $SED "$delay_single_quote_subst"`'
+postdeps='`$ECHO "$postdeps" | $SED "$delay_single_quote_subst"`'
+compiler_lib_search_path='`$ECHO "$compiler_lib_search_path" | $SED "$delay_single_quote_subst"`'
+LD_CXX='`$ECHO "$LD_CXX" | $SED "$delay_single_quote_subst"`'
+reload_flag_CXX='`$ECHO "$reload_flag_CXX" | $SED "$delay_single_quote_subst"`'
+reload_cmds_CXX='`$ECHO "$reload_cmds_CXX" | $SED "$delay_single_quote_subst"`'
+old_archive_cmds_CXX='`$ECHO "$old_archive_cmds_CXX" | $SED "$delay_single_quote_subst"`'
+compiler_CXX='`$ECHO "$compiler_CXX" | $SED "$delay_single_quote_subst"`'
+GCC_CXX='`$ECHO "$GCC_CXX" | $SED "$delay_single_quote_subst"`'
+lt_prog_compiler_no_builtin_flag_CXX='`$ECHO "$lt_prog_compiler_no_builtin_flag_CXX" | $SED "$delay_single_quote_subst"`'
+lt_prog_compiler_wl_CXX='`$ECHO "$lt_prog_compiler_wl_CXX" | $SED "$delay_single_quote_subst"`'
+lt_prog_compiler_pic_CXX='`$ECHO "$lt_prog_compiler_pic_CXX" | $SED "$delay_single_quote_subst"`'
+lt_prog_compiler_static_CXX='`$ECHO "$lt_prog_compiler_static_CXX" | $SED "$delay_single_quote_subst"`'
+lt_cv_prog_compiler_c_o_CXX='`$ECHO "$lt_cv_prog_compiler_c_o_CXX" | $SED "$delay_single_quote_subst"`'
+archive_cmds_need_lc_CXX='`$ECHO "$archive_cmds_need_lc_CXX" | $SED "$delay_single_quote_subst"`'
+enable_shared_with_static_runtimes_CXX='`$ECHO "$enable_shared_with_static_runtimes_CXX" | $SED "$delay_single_quote_subst"`'
+export_dynamic_flag_spec_CXX='`$ECHO "$export_dynamic_flag_spec_CXX" | $SED "$delay_single_quote_subst"`'
+whole_archive_flag_spec_CXX='`$ECHO "$whole_archive_flag_spec_CXX" | $SED "$delay_single_quote_subst"`'
+compiler_needs_object_CXX='`$ECHO "$compiler_needs_object_CXX" | $SED "$delay_single_quote_subst"`'
+old_archive_from_new_cmds_CXX='`$ECHO "$old_archive_from_new_cmds_CXX" | $SED "$delay_single_quote_subst"`'
+old_archive_from_expsyms_cmds_CXX='`$ECHO "$old_archive_from_expsyms_cmds_CXX" | $SED "$delay_single_quote_subst"`'
+archive_cmds_CXX='`$ECHO "$archive_cmds_CXX" | $SED "$delay_single_quote_subst"`'
+archive_expsym_cmds_CXX='`$ECHO "$archive_expsym_cmds_CXX" | $SED "$delay_single_quote_subst"`'
+module_cmds_CXX='`$ECHO "$module_cmds_CXX" | $SED "$delay_single_quote_subst"`'
+module_expsym_cmds_CXX='`$ECHO "$module_expsym_cmds_CXX" | $SED "$delay_single_quote_subst"`'
+with_gnu_ld_CXX='`$ECHO "$with_gnu_ld_CXX" | $SED "$delay_single_quote_subst"`'
+allow_undefined_flag_CXX='`$ECHO "$allow_undefined_flag_CXX" | $SED "$delay_single_quote_subst"`'
+no_undefined_flag_CXX='`$ECHO "$no_undefined_flag_CXX" | $SED "$delay_single_quote_subst"`'
+hardcode_libdir_flag_spec_CXX='`$ECHO "$hardcode_libdir_flag_spec_CXX" | $SED "$delay_single_quote_subst"`'
+hardcode_libdir_flag_spec_ld_CXX='`$ECHO "$hardcode_libdir_flag_spec_ld_CXX" | $SED "$delay_single_quote_subst"`'
+hardcode_libdir_separator_CXX='`$ECHO "$hardcode_libdir_separator_CXX" | $SED "$delay_single_quote_subst"`'
+hardcode_direct_CXX='`$ECHO "$hardcode_direct_CXX" | $SED "$delay_single_quote_subst"`'
+hardcode_direct_absolute_CXX='`$ECHO "$hardcode_direct_absolute_CXX" | $SED "$delay_single_quote_subst"`'
+hardcode_minus_L_CXX='`$ECHO "$hardcode_minus_L_CXX" | $SED "$delay_single_quote_subst"`'
+hardcode_shlibpath_var_CXX='`$ECHO "$hardcode_shlibpath_var_CXX" | $SED "$delay_single_quote_subst"`'
+hardcode_automatic_CXX='`$ECHO "$hardcode_automatic_CXX" | $SED "$delay_single_quote_subst"`'
+inherit_rpath_CXX='`$ECHO "$inherit_rpath_CXX" | $SED "$delay_single_quote_subst"`'
+link_all_deplibs_CXX='`$ECHO "$link_all_deplibs_CXX" | $SED "$delay_single_quote_subst"`'
+fix_srcfile_path_CXX='`$ECHO "$fix_srcfile_path_CXX" | $SED "$delay_single_quote_subst"`'
+always_export_symbols_CXX='`$ECHO "$always_export_symbols_CXX" | $SED "$delay_single_quote_subst"`'
+export_symbols_cmds_CXX='`$ECHO "$export_symbols_cmds_CXX" | $SED "$delay_single_quote_subst"`'
+exclude_expsyms_CXX='`$ECHO "$exclude_expsyms_CXX" | $SED "$delay_single_quote_subst"`'
+include_expsyms_CXX='`$ECHO "$include_expsyms_CXX" | $SED "$delay_single_quote_subst"`'
+prelink_cmds_CXX='`$ECHO "$prelink_cmds_CXX" | $SED "$delay_single_quote_subst"`'
+file_list_spec_CXX='`$ECHO "$file_list_spec_CXX" | $SED "$delay_single_quote_subst"`'
+hardcode_action_CXX='`$ECHO "$hardcode_action_CXX" | $SED "$delay_single_quote_subst"`'
+compiler_lib_search_dirs_CXX='`$ECHO "$compiler_lib_search_dirs_CXX" | $SED "$delay_single_quote_subst"`'
+predep_objects_CXX='`$ECHO "$predep_objects_CXX" | $SED "$delay_single_quote_subst"`'
+postdep_objects_CXX='`$ECHO "$postdep_objects_CXX" | $SED "$delay_single_quote_subst"`'
+predeps_CXX='`$ECHO "$predeps_CXX" | $SED "$delay_single_quote_subst"`'
+postdeps_CXX='`$ECHO "$postdeps_CXX" | $SED "$delay_single_quote_subst"`'
+compiler_lib_search_path_CXX='`$ECHO "$compiler_lib_search_path_CXX" | $SED "$delay_single_quote_subst"`'
+
+LTCC='$LTCC'
+LTCFLAGS='$LTCFLAGS'
+compiler='$compiler_DEFAULT'
+
+# A function that is used when there is no print builtin or printf.
+func_fallback_echo ()
+{
+  eval 'cat <<_LTECHO_EOF
+\$1
+_LTECHO_EOF'
+}
+
+# Quote evaled strings.
+for var in SHELL \
+ECHO \
+SED \
+GREP \
+EGREP \
+FGREP \
+LD \
+NM \
+LN_S \
+lt_SP2NL \
+lt_NL2SP \
+reload_flag \
+OBJDUMP \
+deplibs_check_method \
+file_magic_cmd \
+AR \
+AR_FLAGS \
+STRIP \
+RANLIB \
+CC \
+CFLAGS \
+compiler \
+lt_cv_sys_global_symbol_pipe \
+lt_cv_sys_global_symbol_to_cdecl \
+lt_cv_sys_global_symbol_to_c_name_address \
+lt_cv_sys_global_symbol_to_c_name_address_lib_prefix \
+lt_prog_compiler_no_builtin_flag \
+lt_prog_compiler_wl \
+lt_prog_compiler_pic \
+lt_prog_compiler_static \
+lt_cv_prog_compiler_c_o \
+need_locks \
+DSYMUTIL \
+NMEDIT \
+LIPO \
+OTOOL \
+OTOOL64 \
+shrext_cmds \
+export_dynamic_flag_spec \
+whole_archive_flag_spec \
+compiler_needs_object \
+with_gnu_ld \
+allow_undefined_flag \
+no_undefined_flag \
+hardcode_libdir_flag_spec \
+hardcode_libdir_flag_spec_ld \
+hardcode_libdir_separator \
+fix_srcfile_path \
+exclude_expsyms \
+include_expsyms \
+file_list_spec \
+variables_saved_for_relink \
+libname_spec \
+library_names_spec \
+soname_spec \
+install_override_mode \
+finish_eval \
+old_striplib \
+striplib \
+compiler_lib_search_dirs \
+predep_objects \
+postdep_objects \
+predeps \
+postdeps \
+compiler_lib_search_path \
+LD_CXX \
+reload_flag_CXX \
+compiler_CXX \
+lt_prog_compiler_no_builtin_flag_CXX \
+lt_prog_compiler_wl_CXX \
+lt_prog_compiler_pic_CXX \
+lt_prog_compiler_static_CXX \
+lt_cv_prog_compiler_c_o_CXX \
+export_dynamic_flag_spec_CXX \
+whole_archive_flag_spec_CXX \
+compiler_needs_object_CXX \
+with_gnu_ld_CXX \
+allow_undefined_flag_CXX \
+no_undefined_flag_CXX \
+hardcode_libdir_flag_spec_CXX \
+hardcode_libdir_flag_spec_ld_CXX \
+hardcode_libdir_separator_CXX \
+fix_srcfile_path_CXX \
+exclude_expsyms_CXX \
+include_expsyms_CXX \
+file_list_spec_CXX \
+compiler_lib_search_dirs_CXX \
+predep_objects_CXX \
+postdep_objects_CXX \
+predeps_CXX \
+postdeps_CXX \
+compiler_lib_search_path_CXX; do
+    case \`eval \\\\\$ECHO \\\\""\\\\\$\$var"\\\\"\` in
+    *[\\\\\\\`\\"\\\$]*)
+      eval "lt_\$var=\\\\\\"\\\`\\\$ECHO \\"\\\$\$var\\" | \\\$SED \\"\\\$sed_quote_subst\\"\\\`\\\\\\""
+      ;;
+    *)
+      eval "lt_\$var=\\\\\\"\\\$\$var\\\\\\""
+      ;;
+    esac
+done
+
+# Double-quote double-evaled strings.
+for var in reload_cmds \
+old_postinstall_cmds \
+old_postuninstall_cmds \
+old_archive_cmds \
+extract_expsyms_cmds \
+old_archive_from_new_cmds \
+old_archive_from_expsyms_cmds \
+archive_cmds \
+archive_expsym_cmds \
+module_cmds \
+module_expsym_cmds \
+export_symbols_cmds \
+prelink_cmds \
+postinstall_cmds \
+postuninstall_cmds \
+finish_cmds \
+sys_lib_search_path_spec \
+sys_lib_dlsearch_path_spec \
+reload_cmds_CXX \
+old_archive_cmds_CXX \
+old_archive_from_new_cmds_CXX \
+old_archive_from_expsyms_cmds_CXX \
+archive_cmds_CXX \
+archive_expsym_cmds_CXX \
+module_cmds_CXX \
+module_expsym_cmds_CXX \
+export_symbols_cmds_CXX \
+prelink_cmds_CXX; do
+    case \`eval \\\\\$ECHO \\\\""\\\\\$\$var"\\\\"\` in
+    *[\\\\\\\`\\"\\\$]*)
+      eval "lt_\$var=\\\\\\"\\\`\\\$ECHO \\"\\\$\$var\\" | \\\$SED -e \\"\\\$double_quote_subst\\" -e \\"\\\$sed_quote_subst\\" -e \\"\\\$delay_variable_subst\\"\\\`\\\\\\""
+      ;;
+    *)
+      eval "lt_\$var=\\\\\\"\\\$\$var\\\\\\""
+      ;;
+    esac
+done
+
+ac_aux_dir='$ac_aux_dir'
+xsi_shell='$xsi_shell'
+lt_shell_append='$lt_shell_append'
+
+# See if we are running on zsh, and set the options which allow our
+# commands through without removal of \ escapes INIT.
+if test -n "\${ZSH_VERSION+set}" ; then
+   setopt NO_GLOB_SUBST
+fi
+
+
+    PACKAGE='$PACKAGE'
+    VERSION='$VERSION'
+    TIMESTAMP='$TIMESTAMP'
+    RM='$RM'
+    ofile='$ofile'
+
+
+
+
+
+_LTEOF
+
+cat >>"$CONFIG_LT" <<\_LTEOF
+{ $as_echo "$as_me:${as_lineno-$LINENO}: creating $ofile" >&5
+$as_echo "$as_me: creating $ofile" >&6;}
+
+
+    # See if we are running on zsh, and set the options which allow our
+    # commands through without removal of \ escapes.
+    if test -n "${ZSH_VERSION+set}" ; then
+      setopt NO_GLOB_SUBST
+    fi
+
+    cfgfile="${ofile}T"
+    trap "$RM \"$cfgfile\"; exit 1" 1 2 15
+    $RM "$cfgfile"
+
+    cat <<_LT_EOF >> "$cfgfile"
+#! $SHELL
+
+# `$ECHO "$ofile" | sed 's%^.*/%%'` - Provide generalized library-building support services.
+# Generated automatically by $as_me ($PACKAGE$TIMESTAMP) $VERSION
+# Libtool was configured on host `(hostname || uname -n) 2>/dev/null | sed 1q`:
+# NOTE: Changes made to this file will be lost: look at ltmain.sh.
+#
+#   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001, 2003, 2004, 2005,
+#                 2006, 2007, 2008, 2009 Free Software Foundation, Inc.
+#   Written by Gordon Matzigkeit, 1996
+#
+#   This file is part of GNU Libtool.
+#
+# GNU Libtool is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# As a special exception to the GNU General Public License,
+# if you distribute this file as part of a program or library that
+# is built using GNU Libtool, you may include this file under the
+# same distribution terms that you use for the rest of that program.
+#
+# GNU Libtool is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with GNU Libtool; see the file COPYING.  If not, a copy
+# can be downloaded from http://www.gnu.org/licenses/gpl.html, or
+# obtained by writing to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
+
+
+# The names of the tagged configurations supported by this script.
+available_tags="CXX "
+
+# ### BEGIN LIBTOOL CONFIG
+
+# Which release of libtool.m4 was used?
+macro_version=$macro_version
+macro_revision=$macro_revision
+
+# Whether or not to build shared libraries.
+build_libtool_libs=$enable_shared
+
+# Whether or not to build static libraries.
+build_old_libs=$enable_static
+
+# What type of objects to build.
+pic_mode=$pic_mode
+
+# Whether or not to optimize for fast installation.
+fast_install=$enable_fast_install
+
+# Shell to use when invoking shell scripts.
+SHELL=$lt_SHELL
+
+# An echo program that protects backslashes.
+ECHO=$lt_ECHO
+
+# The host system.
+host_alias=$host_alias
+host=$host
+host_os=$host_os
+
+# The build system.
+build_alias=$build_alias
+build=$build
+build_os=$build_os
+
+# A sed program that does not truncate output.
+SED=$lt_SED
+
+# Sed that helps us avoid accidentally triggering echo(1) options like -n.
+Xsed="\$SED -e 1s/^X//"
+
+# A grep program that handles long lines.
+GREP=$lt_GREP
+
+# An ERE matcher.
+EGREP=$lt_EGREP
+
+# A literal string matcher.
+FGREP=$lt_FGREP
+
+# A BSD- or MS-compatible name lister.
+NM=$lt_NM
+
+# Whether we need soft or hard links.
+LN_S=$lt_LN_S
+
+# What is the maximum length of a command?
+max_cmd_len=$max_cmd_len
+
+# Object file suffix (normally "o").
+objext=$ac_objext
+
+# Executable file suffix (normally "").
+exeext=$exeext
+
+# whether the shell understands "unset".
+lt_unset=$lt_unset
+
+# turn spaces into newlines.
+SP2NL=$lt_lt_SP2NL
+
+# turn newlines into spaces.
+NL2SP=$lt_lt_NL2SP
+
+# An object symbol dumper.
+OBJDUMP=$lt_OBJDUMP
+
+# Method to check whether dependent libraries are shared objects.
+deplibs_check_method=$lt_deplibs_check_method
+
+# Command to use when deplibs_check_method == "file_magic".
+file_magic_cmd=$lt_file_magic_cmd
+
+# The archiver.
+AR=$lt_AR
+AR_FLAGS=$lt_AR_FLAGS
+
+# A symbol stripping program.
+STRIP=$lt_STRIP
+
+# Commands used to install an old-style archive.
+RANLIB=$lt_RANLIB
+old_postinstall_cmds=$lt_old_postinstall_cmds
+old_postuninstall_cmds=$lt_old_postuninstall_cmds
+
+# Whether to use a lock for old archive extraction.
+lock_old_archive_extraction=$lock_old_archive_extraction
+
+# A C compiler.
+LTCC=$lt_CC
+
+# LTCC compiler flags.
+LTCFLAGS=$lt_CFLAGS
+
+# Take the output of nm and produce a listing of raw symbols and C names.
+global_symbol_pipe=$lt_lt_cv_sys_global_symbol_pipe
+
+# Transform the output of nm in a proper C declaration.
+global_symbol_to_cdecl=$lt_lt_cv_sys_global_symbol_to_cdecl
+
+# Transform the output of nm in a C name address pair.
+global_symbol_to_c_name_address=$lt_lt_cv_sys_global_symbol_to_c_name_address
+
+# Transform the output of nm in a C name address pair when lib prefix is needed.
+global_symbol_to_c_name_address_lib_prefix=$lt_lt_cv_sys_global_symbol_to_c_name_address_lib_prefix
+
+# The name of the directory that contains temporary libtool files.
+objdir=$objdir
+
+# Used to examine libraries when file_magic_cmd begins with "file".
+MAGIC_CMD=$MAGIC_CMD
+
+# Must we lock files when doing compilation?
+need_locks=$lt_need_locks
+
+# Tool to manipulate archived DWARF debug symbol files on Mac OS X.
+DSYMUTIL=$lt_DSYMUTIL
+
+# Tool to change global to local symbols on Mac OS X.
+NMEDIT=$lt_NMEDIT
+
+# Tool to manipulate fat objects and archives on Mac OS X.
+LIPO=$lt_LIPO
+
+# ldd/readelf like tool for Mach-O binaries on Mac OS X.
+OTOOL=$lt_OTOOL
+
+# ldd/readelf like tool for 64 bit Mach-O binaries on Mac OS X 10.4.
+OTOOL64=$lt_OTOOL64
+
+# Old archive suffix (normally "a").
+libext=$libext
+
+# Shared library suffix (normally ".so").
+shrext_cmds=$lt_shrext_cmds
+
+# The commands to extract the exported symbol list from a shared archive.
+extract_expsyms_cmds=$lt_extract_expsyms_cmds
+
+# Variables whose values should be saved in libtool wrapper scripts and
+# restored at link time.
+variables_saved_for_relink=$lt_variables_saved_for_relink
+
+# Do we need the "lib" prefix for modules?
+need_lib_prefix=$need_lib_prefix
+
+# Do we need a version for libraries?
+need_version=$need_version
+
+# Library versioning type.
+version_type=$version_type
+
+# Shared library runtime path variable.
+runpath_var=$runpath_var
+
+# Shared library path variable.
+shlibpath_var=$shlibpath_var
+
+# Is shlibpath searched before the hard-coded library search path?
+shlibpath_overrides_runpath=$shlibpath_overrides_runpath
+
+# Format of library name prefix.
+libname_spec=$lt_libname_spec
+
+# List of archive names.  First name is the real one, the rest are links.
+# The last name is the one that the linker finds with -lNAME
+library_names_spec=$lt_library_names_spec
+
+# The coded name of the library, if different from the real name.
+soname_spec=$lt_soname_spec
+
+# Permission mode override for installation of shared libraries.
+install_override_mode=$lt_install_override_mode
+
+# Command to use after installation of a shared archive.
+postinstall_cmds=$lt_postinstall_cmds
+
+# Command to use after uninstallation of a shared archive.
+postuninstall_cmds=$lt_postuninstall_cmds
+
+# Commands used to finish a libtool library installation in a directory.
+finish_cmds=$lt_finish_cmds
+
+# As "finish_cmds", except a single script fragment to be evaled but
+# not shown.
+finish_eval=$lt_finish_eval
+
+# Whether we should hardcode library paths into libraries.
+hardcode_into_libs=$hardcode_into_libs
+
+# Compile-time system search path for libraries.
+sys_lib_search_path_spec=$lt_sys_lib_search_path_spec
+
+# Run-time system search path for libraries.
+sys_lib_dlsearch_path_spec=$lt_sys_lib_dlsearch_path_spec
+
+# Whether dlopen is supported.
+dlopen_support=$enable_dlopen
+
+# Whether dlopen of programs is supported.
+dlopen_self=$enable_dlopen_self
+
+# Whether dlopen of statically linked programs is supported.
+dlopen_self_static=$enable_dlopen_self_static
+
+# Commands to strip libraries.
+old_striplib=$lt_old_striplib
+striplib=$lt_striplib
+
+
+# The linker used to build libraries.
+LD=$lt_LD
+
+# How to create reloadable object files.
+reload_flag=$lt_reload_flag
+reload_cmds=$lt_reload_cmds
+
+# Commands used to build an old-style archive.
+old_archive_cmds=$lt_old_archive_cmds
+
+# A language specific compiler.
+CC=$lt_compiler
+
+# Is the compiler the GNU compiler?
+with_gcc=$GCC
+
+# Compiler flag to turn off builtin functions.
+no_builtin_flag=$lt_lt_prog_compiler_no_builtin_flag
+
+# How to pass a linker flag through the compiler.
+wl=$lt_lt_prog_compiler_wl
+
+# Additional compiler flags for building library objects.
+pic_flag=$lt_lt_prog_compiler_pic
+
+# Compiler flag to prevent dynamic linking.
+link_static_flag=$lt_lt_prog_compiler_static
+
+# Does compiler simultaneously support -c and -o options?
+compiler_c_o=$lt_lt_cv_prog_compiler_c_o
+
+# Whether or not to add -lc for building shared libraries.
+build_libtool_need_lc=$archive_cmds_need_lc
+
+# Whether or not to disallow shared libs when runtime libs are static.
+allow_libtool_libs_with_static_runtimes=$enable_shared_with_static_runtimes
+
+# Compiler flag to allow reflexive dlopens.
+export_dynamic_flag_spec=$lt_export_dynamic_flag_spec
+
+# Compiler flag to generate shared objects directly from archives.
+whole_archive_flag_spec=$lt_whole_archive_flag_spec
+
+# Whether the compiler copes with passing no objects directly.
+compiler_needs_object=$lt_compiler_needs_object
+
+# Create an old-style archive from a shared archive.
+old_archive_from_new_cmds=$lt_old_archive_from_new_cmds
+
+# Create a temporary old-style archive to link instead of a shared archive.
+old_archive_from_expsyms_cmds=$lt_old_archive_from_expsyms_cmds
+
+# Commands used to build a shared archive.
+archive_cmds=$lt_archive_cmds
+archive_expsym_cmds=$lt_archive_expsym_cmds
+
+# Commands used to build a loadable module if different from building
+# a shared archive.
+module_cmds=$lt_module_cmds
+module_expsym_cmds=$lt_module_expsym_cmds
+
+# Whether we are building with GNU ld or not.
+with_gnu_ld=$lt_with_gnu_ld
+
+# Flag that allows shared libraries with undefined symbols to be built.
+allow_undefined_flag=$lt_allow_undefined_flag
+
+# Flag that enforces no undefined symbols.
+no_undefined_flag=$lt_no_undefined_flag
+
+# Flag to hardcode \$libdir into a binary during linking.
+# This must work even if \$libdir does not exist
+hardcode_libdir_flag_spec=$lt_hardcode_libdir_flag_spec
+
+# If ld is used when linking, flag to hardcode \$libdir into a binary
+# during linking.  This must work even if \$libdir does not exist.
+hardcode_libdir_flag_spec_ld=$lt_hardcode_libdir_flag_spec_ld
+
+# Whether we need a single "-rpath" flag with a separated argument.
+hardcode_libdir_separator=$lt_hardcode_libdir_separator
+
+# Set to "yes" if using DIR/libNAME\${shared_ext} during linking hardcodes
+# DIR into the resulting binary.
+hardcode_direct=$hardcode_direct
+
+# Set to "yes" if using DIR/libNAME\${shared_ext} during linking hardcodes
+# DIR into the resulting binary and the resulting library dependency is
+# "absolute",i.e impossible to change by setting \${shlibpath_var} if the
+# library is relocated.
+hardcode_direct_absolute=$hardcode_direct_absolute
+
+# Set to "yes" if using the -LDIR flag during linking hardcodes DIR
+# into the resulting binary.
+hardcode_minus_L=$hardcode_minus_L
+
+# Set to "yes" if using SHLIBPATH_VAR=DIR during linking hardcodes DIR
+# into the resulting binary.
+hardcode_shlibpath_var=$hardcode_shlibpath_var
+
+# Set to "yes" if building a shared library automatically hardcodes DIR
+# into the library and all subsequent libraries and executables linked
+# against it.
+hardcode_automatic=$hardcode_automatic
+
+# Set to yes if linker adds runtime paths of dependent libraries
+# to runtime path list.
+inherit_rpath=$inherit_rpath
+
+# Whether libtool must link a program against all its dependency libraries.
+link_all_deplibs=$link_all_deplibs
+
+# Fix the shell variable \$srcfile for the compiler.
+fix_srcfile_path=$lt_fix_srcfile_path
+
+# Set to "yes" if exported symbols are required.
+always_export_symbols=$always_export_symbols
+
+# The commands to list exported symbols.
+export_symbols_cmds=$lt_export_symbols_cmds
+
+# Symbols that should not be listed in the preloaded symbols.
+exclude_expsyms=$lt_exclude_expsyms
+
+# Symbols that must always be exported.
+include_expsyms=$lt_include_expsyms
+
+# Commands necessary for linking programs (against libraries) with templates.
+prelink_cmds=$lt_prelink_cmds
+
+# Specify filename containing input files.
+file_list_spec=$lt_file_list_spec
+
+# How to hardcode a shared library path into an executable.
+hardcode_action=$hardcode_action
+
+# The directories searched by this compiler when creating a shared library.
+compiler_lib_search_dirs=$lt_compiler_lib_search_dirs
+
+# Dependencies to place before and after the objects being linked to
+# create a shared library.
+predep_objects=$lt_predep_objects
+postdep_objects=$lt_postdep_objects
+predeps=$lt_predeps
+postdeps=$lt_postdeps
+
+# The library search path used internally by the compiler when linking
+# a shared library.
+compiler_lib_search_path=$lt_compiler_lib_search_path
+
+# ### END LIBTOOL CONFIG
+
+_LT_EOF
+
+  case $host_os in
+  aix3*)
+    cat <<\_LT_EOF >> "$cfgfile"
+# AIX sometimes has problems with the GCC collect2 program.  For some
+# reason, if we set the COLLECT_NAMES environment variable, the problems
+# vanish in a puff of smoke.
+if test "X${COLLECT_NAMES+set}" != Xset; then
+  COLLECT_NAMES=
+  export COLLECT_NAMES
+fi
+_LT_EOF
+    ;;
+  esac
+
+
+ltmain="$ac_aux_dir/ltmain.sh"
+
+
+  # We use sed instead of cat because bash on DJGPP gets confused if
+  # if finds mixed CR/LF and LF-only lines.  Since sed operates in
+  # text mode, it properly converts lines to CR/LF.  This bash problem
+  # is reportedly fixed, but why not run on old versions too?
+  sed '/^# Generated shell functions inserted here/q' "$ltmain" >> "$cfgfile" \
+    || (rm -f "$cfgfile"; exit 1)
+
+  case $xsi_shell in
+  yes)
+    cat << \_LT_EOF >> "$cfgfile"
+
+# func_dirname file append nondir_replacement
+# Compute the dirname of FILE.  If nonempty, add APPEND to the result,
+# otherwise set result to NONDIR_REPLACEMENT.
+func_dirname ()
+{
+  case ${1} in
+    */*) func_dirname_result="${1%/*}${2}" ;;
+    *  ) func_dirname_result="${3}" ;;
+  esac
+}
+
+# func_basename file
+func_basename ()
+{
+  func_basename_result="${1##*/}"
+}
+
+# func_dirname_and_basename file append nondir_replacement
+# perform func_basename and func_dirname in a single function
+# call:
+#   dirname:  Compute the dirname of FILE.  If nonempty,
+#             add APPEND to the result, otherwise set result
+#             to NONDIR_REPLACEMENT.
+#             value returned in "$func_dirname_result"
+#   basename: Compute filename of FILE.
+#             value retuned in "$func_basename_result"
+# Implementation must be kept synchronized with func_dirname
+# and func_basename. For efficiency, we do not delegate to
+# those functions but instead duplicate the functionality here.
+func_dirname_and_basename ()
+{
+  case ${1} in
+    */*) func_dirname_result="${1%/*}${2}" ;;
+    *  ) func_dirname_result="${3}" ;;
+  esac
+  func_basename_result="${1##*/}"
+}
+
+# func_stripname prefix suffix name
+# strip PREFIX and SUFFIX off of NAME.
+# PREFIX and SUFFIX must not contain globbing or regex special
+# characters, hashes, percent signs, but SUFFIX may contain a leading
+# dot (in which case that matches only a dot).
+func_stripname ()
+{
+  # pdksh 5.2.14 does not do ${X%$Y} correctly if both X and Y are
+  # positional parameters, so assign one to ordinary parameter first.
+  func_stripname_result=${3}
+  func_stripname_result=${func_stripname_result#"${1}"}
+  func_stripname_result=${func_stripname_result%"${2}"}
+}
+
+# func_opt_split
+func_opt_split ()
+{
+  func_opt_split_opt=${1%%=*}
+  func_opt_split_arg=${1#*=}
+}
+
+# func_lo2o object
+func_lo2o ()
+{
+  case ${1} in
+    *.lo) func_lo2o_result=${1%.lo}.${objext} ;;
+    *)    func_lo2o_result=${1} ;;
+  esac
+}
+
+# func_xform libobj-or-source
+func_xform ()
+{
+  func_xform_result=${1%.*}.lo
+}
+
+# func_arith arithmetic-term...
+func_arith ()
+{
+  func_arith_result=$(( $* ))
+}
+
+# func_len string
+# STRING may not start with a hyphen.
+func_len ()
+{
+  func_len_result=${#1}
+}
+
+_LT_EOF
+    ;;
+  *) # Bourne compatible functions.
+    cat << \_LT_EOF >> "$cfgfile"
+
+# func_dirname file append nondir_replacement
+# Compute the dirname of FILE.  If nonempty, add APPEND to the result,
+# otherwise set result to NONDIR_REPLACEMENT.
+func_dirname ()
+{
+  # Extract subdirectory from the argument.
+  func_dirname_result=`$ECHO "${1}" | $SED "$dirname"`
+  if test "X$func_dirname_result" = "X${1}"; then
+    func_dirname_result="${3}"
+  else
+    func_dirname_result="$func_dirname_result${2}"
+  fi
+}
+
+# func_basename file
+func_basename ()
+{
+  func_basename_result=`$ECHO "${1}" | $SED "$basename"`
+}
+
+
+# func_stripname prefix suffix name
+# strip PREFIX and SUFFIX off of NAME.
+# PREFIX and SUFFIX must not contain globbing or regex special
+# characters, hashes, percent signs, but SUFFIX may contain a leading
+# dot (in which case that matches only a dot).
+# func_strip_suffix prefix name
+func_stripname ()
+{
+  case ${2} in
+    .*) func_stripname_result=`$ECHO "${3}" | $SED "s%^${1}%%; s%\\\\${2}\$%%"`;;
+    *)  func_stripname_result=`$ECHO "${3}" | $SED "s%^${1}%%; s%${2}\$%%"`;;
+  esac
+}
+
+# sed scripts:
+my_sed_long_opt='1s/^\(-[^=]*\)=.*/\1/;q'
+my_sed_long_arg='1s/^-[^=]*=//'
+
+# func_opt_split
+func_opt_split ()
+{
+  func_opt_split_opt=`$ECHO "${1}" | $SED "$my_sed_long_opt"`
+  func_opt_split_arg=`$ECHO "${1}" | $SED "$my_sed_long_arg"`
+}
+
+# func_lo2o object
+func_lo2o ()
+{
+  func_lo2o_result=`$ECHO "${1}" | $SED "$lo2o"`
+}
+
+# func_xform libobj-or-source
+func_xform ()
+{
+  func_xform_result=`$ECHO "${1}" | $SED 's/\.[^.]*$/.lo/'`
+}
+
+# func_arith arithmetic-term...
+func_arith ()
+{
+  func_arith_result=`expr "$@"`
+}
+
+# func_len string
+# STRING may not start with a hyphen.
+func_len ()
+{
+  func_len_result=`expr "$1" : ".*" 2>/dev/null || echo $max_cmd_len`
+}
+
+_LT_EOF
+esac
+
+case $lt_shell_append in
+  yes)
+    cat << \_LT_EOF >> "$cfgfile"
+
+# func_append var value
+# Append VALUE to the end of shell variable VAR.
+func_append ()
+{
+  eval "$1+=\$2"
+}
+_LT_EOF
+    ;;
+  *)
+    cat << \_LT_EOF >> "$cfgfile"
+
+# func_append var value
+# Append VALUE to the end of shell variable VAR.
+func_append ()
+{
+  eval "$1=\$$1\$2"
+}
+
+_LT_EOF
+    ;;
+  esac
+
+
+  sed -n '/^# Generated shell functions inserted here/,$p' "$ltmain" >> "$cfgfile" \
+    || (rm -f "$cfgfile"; exit 1)
+
+  mv -f "$cfgfile" "$ofile" ||
+    (rm -f "$ofile" && cp "$cfgfile" "$ofile" && rm -f "$cfgfile")
+  chmod +x "$ofile"
+
+
+    cat <<_LT_EOF >> "$ofile"
+
+# ### BEGIN LIBTOOL TAG CONFIG: CXX
+
+# The linker used to build libraries.
+LD=$lt_LD_CXX
+
+# How to create reloadable object files.
+reload_flag=$lt_reload_flag_CXX
+reload_cmds=$lt_reload_cmds_CXX
+
+# Commands used to build an old-style archive.
+old_archive_cmds=$lt_old_archive_cmds_CXX
+
+# A language specific compiler.
+CC=$lt_compiler_CXX
+
+# Is the compiler the GNU compiler?
+with_gcc=$GCC_CXX
+
+# Compiler flag to turn off builtin functions.
+no_builtin_flag=$lt_lt_prog_compiler_no_builtin_flag_CXX
+
+# How to pass a linker flag through the compiler.
+wl=$lt_lt_prog_compiler_wl_CXX
+
+# Additional compiler flags for building library objects.
+pic_flag=$lt_lt_prog_compiler_pic_CXX
+
+# Compiler flag to prevent dynamic linking.
+link_static_flag=$lt_lt_prog_compiler_static_CXX
+
+# Does compiler simultaneously support -c and -o options?
+compiler_c_o=$lt_lt_cv_prog_compiler_c_o_CXX
+
+# Whether or not to add -lc for building shared libraries.
+build_libtool_need_lc=$archive_cmds_need_lc_CXX
+
+# Whether or not to disallow shared libs when runtime libs are static.
+allow_libtool_libs_with_static_runtimes=$enable_shared_with_static_runtimes_CXX
+
+# Compiler flag to allow reflexive dlopens.
+export_dynamic_flag_spec=$lt_export_dynamic_flag_spec_CXX
+
+# Compiler flag to generate shared objects directly from archives.
+whole_archive_flag_spec=$lt_whole_archive_flag_spec_CXX
+
+# Whether the compiler copes with passing no objects directly.
+compiler_needs_object=$lt_compiler_needs_object_CXX
+
+# Create an old-style archive from a shared archive.
+old_archive_from_new_cmds=$lt_old_archive_from_new_cmds_CXX
+
+# Create a temporary old-style archive to link instead of a shared archive.
+old_archive_from_expsyms_cmds=$lt_old_archive_from_expsyms_cmds_CXX
+
+# Commands used to build a shared archive.
+archive_cmds=$lt_archive_cmds_CXX
+archive_expsym_cmds=$lt_archive_expsym_cmds_CXX
+
+# Commands used to build a loadable module if different from building
+# a shared archive.
+module_cmds=$lt_module_cmds_CXX
+module_expsym_cmds=$lt_module_expsym_cmds_CXX
+
+# Whether we are building with GNU ld or not.
+with_gnu_ld=$lt_with_gnu_ld_CXX
+
+# Flag that allows shared libraries with undefined symbols to be built.
+allow_undefined_flag=$lt_allow_undefined_flag_CXX
+
+# Flag that enforces no undefined symbols.
+no_undefined_flag=$lt_no_undefined_flag_CXX
+
+# Flag to hardcode \$libdir into a binary during linking.
+# This must work even if \$libdir does not exist
+hardcode_libdir_flag_spec=$lt_hardcode_libdir_flag_spec_CXX
+
+# If ld is used when linking, flag to hardcode \$libdir into a binary
+# during linking.  This must work even if \$libdir does not exist.
+hardcode_libdir_flag_spec_ld=$lt_hardcode_libdir_flag_spec_ld_CXX
+
+# Whether we need a single "-rpath" flag with a separated argument.
+hardcode_libdir_separator=$lt_hardcode_libdir_separator_CXX
+
+# Set to "yes" if using DIR/libNAME\${shared_ext} during linking hardcodes
+# DIR into the resulting binary.
+hardcode_direct=$hardcode_direct_CXX
+
+# Set to "yes" if using DIR/libNAME\${shared_ext} during linking hardcodes
+# DIR into the resulting binary and the resulting library dependency is
+# "absolute",i.e impossible to change by setting \${shlibpath_var} if the
+# library is relocated.
+hardcode_direct_absolute=$hardcode_direct_absolute_CXX
+
+# Set to "yes" if using the -LDIR flag during linking hardcodes DIR
+# into the resulting binary.
+hardcode_minus_L=$hardcode_minus_L_CXX
+
+# Set to "yes" if using SHLIBPATH_VAR=DIR during linking hardcodes DIR
+# into the resulting binary.
+hardcode_shlibpath_var=$hardcode_shlibpath_var_CXX
+
+# Set to "yes" if building a shared library automatically hardcodes DIR
+# into the library and all subsequent libraries and executables linked
+# against it.
+hardcode_automatic=$hardcode_automatic_CXX
+
+# Set to yes if linker adds runtime paths of dependent libraries
+# to runtime path list.
+inherit_rpath=$inherit_rpath_CXX
+
+# Whether libtool must link a program against all its dependency libraries.
+link_all_deplibs=$link_all_deplibs_CXX
+
+# Fix the shell variable \$srcfile for the compiler.
+fix_srcfile_path=$lt_fix_srcfile_path_CXX
+
+# Set to "yes" if exported symbols are required.
+always_export_symbols=$always_export_symbols_CXX
+
+# The commands to list exported symbols.
+export_symbols_cmds=$lt_export_symbols_cmds_CXX
+
+# Symbols that should not be listed in the preloaded symbols.
+exclude_expsyms=$lt_exclude_expsyms_CXX
+
+# Symbols that must always be exported.
+include_expsyms=$lt_include_expsyms_CXX
+
+# Commands necessary for linking programs (against libraries) with templates.
+prelink_cmds=$lt_prelink_cmds_CXX
+
+# Specify filename containing input files.
+file_list_spec=$lt_file_list_spec_CXX
+
+# How to hardcode a shared library path into an executable.
+hardcode_action=$hardcode_action_CXX
+
+# The directories searched by this compiler when creating a shared library.
+compiler_lib_search_dirs=$lt_compiler_lib_search_dirs_CXX
+
+# Dependencies to place before and after the objects being linked to
+# create a shared library.
+predep_objects=$lt_predep_objects_CXX
+postdep_objects=$lt_postdep_objects_CXX
+predeps=$lt_predeps_CXX
+postdeps=$lt_postdeps_CXX
+
+# The library search path used internally by the compiler when linking
+# a shared library.
+compiler_lib_search_path=$lt_compiler_lib_search_path_CXX
+
+# ### END LIBTOOL TAG CONFIG: CXX
+_LT_EOF
+
+
+as_fn_exit 0
+_LTEOF
+chmod +x "$CONFIG_LT"
+
+# configure is writing to config.log, but config.lt does its own redirection,
+# appending to config.log, which fails on DOS, as config.log is still kept
+# open by configure.  Here we exec the FD to /dev/null, effectively closing
+# config.log, so it can be properly (re)opened and appended to by config.lt.
+lt_cl_success=:
+test "$silent" = yes &&
+  lt_config_lt_args="$lt_config_lt_args --quiet"
+exec 5>/dev/null
+$SHELL "$CONFIG_LT" $lt_config_lt_args || lt_cl_success=false
+exec 5>>config.log
+$lt_cl_success || as_fn_exit 1
+
+
+ac_config_files="$ac_config_files Makefile"
+
+ac_config_files="$ac_config_files scripts/testsuite_flags"
+
+ac_config_files="$ac_config_files scripts/extract_symvers"
+
+ac_config_files="$ac_config_files doc/xsl/customization.xsl"
+
+
+# Multilibs need MULTISUBDIR defined correctly in certain makefiles so
+# that multilib installs will end up installed in the correct place.
+# The testsuite needs it for multilib-aware ABI baseline files.
+# To work around this not being passed down from config-ml.in ->
+# srcdir/Makefile.am -> srcdir/{src,libsupc++,...}/Makefile.am, manually
+# append it here.  Only modify Makefiles that have just been created.
+#
+# Also, get rid of this simulated-VPATH thing that automake does.
+ac_config_files="$ac_config_files include/Makefile libsupc++/Makefile src/Makefile src/c++98/Makefile src/c++11/Makefile src/filesystem/Makefile doc/Makefile po/Makefile testsuite/Makefile python/Makefile"
+
+
+ac_config_commands="$ac_config_commands generate-headers"
+
+
+cat >confcache <<\_ACEOF
+# This file is a shell script that caches the results of configure
+# tests run on this system so they can be shared between configure
+# scripts and configure runs, see configure's option --config-cache.
+# It is not useful on other systems.  If it contains results you don't
+# want to keep, you may remove or edit it.
+#
+# config.status only pays attention to the cache file if you give it
 # the --recheck option to rerun configure.
 #
 # `ac_cv_env_foo' variables (set or unset) will be overridden when
 # loading this file, other *unset* `ac_cv_foo' will be assigned the
 # following values.
 
@@ -81494,12 +83297,13 @@ fi
     TIMESTAMP='$TIMESTAMP'
     RM='$RM'
     ofile='$ofile'
 
 
 
+ac_aux_dir='$ac_aux_dir'
 
 
 
 GCC="$GCC"
 CC="$CC"
 acx_cv_header_stdint="$acx_cv_header_stdint"
diff --git a/libstdc++-v3/configure.ac b/libstdc++-v3/configure.ac
index 580fb8b2eb8ab25bed4872f1d071ba925cf3dcff..76ddbdae13f46336f68672e217e5dfa2fdffee97 100644
--- libstdc++-v3/configure.ac
+++ libstdc++-v3/configure.ac
@@ -492,12 +492,15 @@ fi
 GLIBCXX_EXPORT_INSTALL_INFO
 
 # Export all the include and flag information to Makefiles.
 GLIBCXX_EXPORT_INCLUDES
 GLIBCXX_EXPORT_FLAGS
 
+# create libtool - libtool > 2.0:
+LT_OUTPUT
+
 dnl In autoconf 2.5x, AC_OUTPUT is replaced by four AC_CONFIG_* macros,
 dnl which can all be called multiple times as needed, plus one (different)
 dnl AC_OUTPUT macro.  This one lists the files to be created:
 AC_CONFIG_FILES(Makefile)
 AC_CONFIG_FILES([scripts/testsuite_flags],[chmod +x scripts/testsuite_flags])
 AC_CONFIG_FILES([scripts/extract_symvers],[chmod +x scripts/extract_symvers])
diff --git a/libstdc++-v3/crossconfig.m4 b/libstdc++-v3/crossconfig.m4
index 10247f940b55ee77df940044c3889b08b51cfb4c..c7d1034f4870e92dfd502d25bc7cc858f6a19370 100644
--- libstdc++-v3/crossconfig.m4
+++ libstdc++-v3/crossconfig.m4
@@ -266,11 +266,19 @@ case "${host}" in
     AC_DEFINE(HAVE_SINF)
     AC_DEFINE(HAVE_SINHF)
     AC_DEFINE(HAVE_SQRTF)
     AC_DEFINE(HAVE_TANF)
     AC_DEFINE(HAVE_TANHF)
     ;;
+  *-amigaos*)
+    AC_CHECK_HEADERS([nan.h ieeefp.h endian.h sys/isa_defs.h \
+      machine/endian.h machine/param.h sys/machine.h sys/types.h \
+      fp.h locale.h float.h inttypes.h])
+    SECTION_FLAGS='-ffunction-sections -fdata-sections'
+    AC_SUBST(SECTION_FLAGS)
+    GLIBCXX_CHECK_LINKER_FEATURES
+    ;;
   *)
     AC_MSG_ERROR([No support for this host/target combination.])
    ;;
 esac
 ])
diff --git a/libstdc++-v3/include/c_global/cstddef b/libstdc++-v3/include/c_global/cstddef
index 33f4f8f76bd497d345ec7440b9397427e26671eb..7c39a30d2bc41b4eb82b13c3d390cfce52854457 100644
--- libstdc++-v3/include/c_global/cstddef
+++ libstdc++-v3/include/c_global/cstddef
@@ -44,12 +44,15 @@
 #include <bits/c++config.h>
 #include <stddef.h>
 
 #if __cplusplus >= 201103L
 namespace std
 {
+/* Needed as clib2 on AmigaOS has no C11 support yet */
+#if __STDC_VERSION__ >= 201112L
   // We handle size_t, ptrdiff_t, and nullptr_t in c++config.h.
   using ::max_align_t;
+#endif
 }
 #endif
 
 #endif // _GLIBCXX_CSTDDEF
diff --git a/libstdc++-v3/include/c_std/cstddef b/libstdc++-v3/include/c_std/cstddef
index d46a4ea16388d674917a74620c3f50d43de84bb6..9189ed063448a45439a265bf4a51cc36e0c731ed 100644
--- libstdc++-v3/include/c_std/cstddef
+++ libstdc++-v3/include/c_std/cstddef
@@ -44,12 +44,15 @@
 #include <bits/c++config.h>
 #include <stddef.h>
 
 #if __cplusplus >= 201103L
 namespace std
 {
+/* Needed as clib2 on AmigaOS has no C11 support yet */
+#if __STDC_VERSION__ >= 201112L
   // We handle size_t, ptrdiff_t, and nullptr_t in c++config.h.
   using ::max_align_t;
+#endif
 }
 #endif
 
 #endif // _GLIBCXX_CSTDDEF
-- 
2.1.4
