--- gcc-3.4.6/gcc/config/m68k/m68k.c	2013-05-19 20:09:27.000000000 +0200
+++ gcc/config/m68k/m68k.c	2013-05-19 20:23:32.000000000 +0200
@@ -123,6 +123,8 @@
 static tree m68k_handle_fndecl_attribute (tree *node, tree name,
 					  tree args, int flags,
 					  bool *no_add_attrs);
+static tree m68k_handle_type_attribute (tree *, tree, tree, int, bool *);
+static int m68k_comp_type_attributes (tree, tree);
 static void m68k_compute_frame_layout (void);
 static bool m68k_save_reg (unsigned int regno, bool interrupt_handler);
 static int const_int_cost (rtx);
@@ -138,6 +140,8 @@
 const char *m68k_align_funcs_string;
 /* Specify the identification number of the library being built */
 const char *m68k_library_id_string;
+/* Specify number of registers for integer, pointer and float arguments.  */
+const char *m68k_regparm_string;
 
 /* Specify power of two alignment used for loops.  */
 int m68k_align_loops;
@@ -145,6 +149,8 @@
 int m68k_align_jumps;
 /* Specify power of two alignment used for functions.  */
 int m68k_align_funcs;
+/* Specify number of registers for integer, pointer and float arguments.  */
+int m68k_regparm;
 
 /* Nonzero if the last compare/test insn had FP operands.  The
    sCC expanders peek at this to determine what to do for the
@@ -208,9 +214,30 @@
 {
   /* { name, min_len, max_len, decl_req, type_req, fn_type_req, handler } */
   { "interrupt_handler", 0, 0, true,  false, false, m68k_handle_fndecl_attribute },
+
+  /* Stkparm attribute specifies to pass arguments on the stack */
+  { "stkparm",           0, 0, false, true,  true,  m68k_handle_type_attribute },
+  /* Regparm attribute specifies how many integer arguments are to be
+     passed in registers.  */
+  { "regparm",           0, 1, false, true,  true,  m68k_handle_type_attribute },
+
+#ifdef TARGET_AMIGAOS
+  /* Stackext attribute specifies to generate stackextension code */
+  { "stackext",          0, 0, false, true,  true,  amigaos_handle_type_attribute },
+  /* Interrupt attribute specifies to generate a special exit code */
+  { "interrupt",         0, 0, false, true,  true,  amigaos_handle_type_attribute },
+  /* Saveds attribute specifies to generate baserel setup code */
+  { "saveds",            0, 0, false, true,  true,  amigaos_handle_type_attribute },
+  /* Chip attribute specifies to place data in a "special" section  */
+  { "chip",              0, 0, true, false,  false, amigaos_handle_decl_attribute },
+#endif
+
   { NULL,                0, 0, false, false, false, NULL }
 };
 
+#undef TARGET_COMP_TYPE_ATTRIBUTES
+#define TARGET_COMP_TYPE_ATTRIBUTES m68k_comp_type_attributes
+
 struct gcc_target targetm = TARGET_INITIALIZER;
 
 /* Sometimes certain combinations of command options do not make
@@ -296,6 +323,23 @@
 	m68k_align_funcs = i;
     }
 
+  /* Validate -mregparm and -mregparm= value.  */
+  if (m68k_regparm_string)
+    {
+      m68k_regparm = atoi (m68k_regparm_string);
+      if (m68k_regparm < 1 || m68k_regparm > M68K_MAX_REGPARM)
+	error ("-mregparm=%d is not between 1 and %d",
+	       m68k_regparm, M68K_MAX_REGPARM);
+      target_flags |= MASK_REGPARM;
+    }
+  else
+    if (TARGET_REGPARM)
+      m68k_regparm = M68K_DEFAULT_REGPARM;
+
+  /* XXX: FIXME: Workaround for a bug.  */
+  if (flag_pic >= 3)
+    flag_strength_reduce = 0;
+
   /* -fPIC uses 32-bit pc-relative displacements, which don't exist
      until the 68020.  */
   if (!TARGET_68020 && !TARGET_COLDFIRE && (flag_pic == 2))
@@ -312,12 +356,14 @@
      the PLT entry for `foo'. Doing function cse will cause the address of
      `foo' to be loaded into a register, which is exactly what we want to
      avoid when we are doing PIC on svr4 m68k.  */
-  if (flag_pic)
+  if (flag_pic && flag_pic < 3)
     flag_no_function_cse = 1;
 
   SUBTARGET_OVERRIDE_OPTIONS;
 }
 
+/* Attributes support.  */
+
 /* Return nonzero if FUNC is an interrupt function as specified by the
    "interrupt_handler" attribute.  */
 static bool
@@ -350,6 +396,251 @@
   return NULL_TREE;
 }
 
+/* Handle a "regparm" or "stkparm" attribute;
+   arguments as in struct attribute_spec.handler.  */
+
+static tree
+m68k_handle_type_attribute (tree *node, tree name, tree args,
+			    int flags ATTRIBUTE_UNUSED, bool *no_add_attrs)
+{
+  if (TREE_CODE (*node) == FUNCTION_TYPE || TREE_CODE (*node) == METHOD_TYPE)
+    {
+      /* 'regparm' accepts one optional argument - number of registers in
+	 single class that should be used to pass arguments.  */
+      if (is_attribute_p ("regparm", name))
+	{
+	  if (lookup_attribute ("stkparm", TYPE_ATTRIBUTES(*node)))
+	    {
+	      error ("`regparm' and `stkparm' are mutually exclusive");
+	    }
+	  if (args && TREE_CODE (args) == TREE_LIST)
+	    {
+	      tree numofregs = TREE_VALUE (args);
+	      if (numofregs)
+		if (TREE_CODE (numofregs) != INTEGER_CST
+/*
+		    || compare_tree_int(numofregs, 1) < 0
+		    || compare_tree_int(numofregs, M68K_MAX_REGPARM) > 0)
+*/
+		    || TREE_INT_CST_HIGH (numofregs)
+		    || TREE_INT_CST_LOW (numofregs) < 1
+		    || TREE_INT_CST_LOW (numofregs) > M68K_MAX_REGPARM)
+		  {
+		    error ("invalid argument to `regparm' attribute");
+		  }
+	    }
+	}
+      else if (is_attribute_p ("stkparm", name))
+	{
+	  if (lookup_attribute ("regparm", TYPE_ATTRIBUTES(*node)))
+	    {
+	      error ("`regparm' and `stkparm' are mutually exclusive");
+	    }
+	}
+    }
+  else
+    {
+      warning ("`%s' attribute only applies to functions",
+	       IDENTIFIER_POINTER (name));
+      *no_add_attrs = true;
+    }
+
+  return NULL_TREE;
+}
+
+/* Return zero if the attributes on TYPE1 and TYPE2 are incompatible,
+   one if they are compatible, and two if they are nearly compatible
+   (which causes a warning to be generated). */
+
+static int
+m68k_comp_type_attributes (tree type1, tree type2)
+{
+  /* Functions or methods are incompatible if they specify mutually
+     exclusive ways of passing arguments.  */
+  if (TREE_CODE (type1) == FUNCTION_TYPE || TREE_CODE (type1) == METHOD_TYPE)
+    {
+      tree arg1, arg2;
+      if (!! lookup_attribute ("stkparm", TYPE_ATTRIBUTES (type1)) !=
+	     !! lookup_attribute ("stkparm", TYPE_ATTRIBUTES (type2))
+	  || !! lookup_attribute ("regparm", TYPE_ATTRIBUTES (type1)) !=
+	     !! lookup_attribute ("regparm", TYPE_ATTRIBUTES (type2)))
+	return 0; /* 'regparm' and 'stkparm' are mutually exclusive.  */
+
+      arg1 = lookup_attribute ("regparm", TYPE_ATTRIBUTES (type1));
+      arg2 = lookup_attribute ("regparm", TYPE_ATTRIBUTES (type2));
+      if (arg1 && arg2)
+	{
+	  int num1 = 0, num2 = 0;
+	  if (TREE_VALUE (arg1) && TREE_CODE (TREE_VALUE (arg1)) == TREE_LIST)
+	    {
+	      tree numofregs = TREE_VALUE (TREE_VALUE (arg1));
+	      if (numofregs)
+		num1 = TREE_INT_CST_LOW (numofregs);
+	    }
+	  if (TREE_VALUE (arg2) && TREE_CODE (TREE_VALUE (arg2)) == TREE_LIST)
+	    {
+	      tree numofregs = TREE_VALUE (TREE_VALUE (arg2));
+	      if (numofregs)
+		num2 = TREE_INT_CST_LOW (numofregs);
+	    }
+	  if (num1 != num2)
+	    return 0; /* Different numbers, or no number in one type.  */
+	}
+    }
+#ifdef TARGET_AMIGAOS
+    return amigaos_comp_type_attributes(type1, type2);
+#else
+  return 1;
+#endif
+}
+
+/* Argument-passing support functions.  */
+
+/* Initialize a variable CUM of type CUMULATIVE_ARGS
+   for a call to a function whose data type is FNTYPE.
+   For a library call, FNTYPE is 0.  */
+
+void
+m68k_init_cumulative_args (CUMULATIVE_ARGS *cum, tree fntype)
+{
+  cum->last_arg_reg = -1;
+  cum->regs_already_used = 0;
+  if (fntype)
+    {
+      if (lookup_attribute ("stkparm", TYPE_ATTRIBUTES (fntype)))
+	cum->num_of_regs = 0;
+      else
+	{
+	  tree ratree = lookup_attribute ("regparm", TYPE_ATTRIBUTES (fntype));
+	  if (ratree)
+	    {
+	      cum->num_of_regs = m68k_regparm ? m68k_regparm
+					      : M68K_DEFAULT_REGPARM;
+	      if (TREE_VALUE (ratree)
+		  && TREE_CODE (TREE_VALUE (ratree)) == TREE_LIST)
+		{
+		  tree num_of_regs = TREE_VALUE (TREE_VALUE (ratree));
+		  cum->num_of_regs =
+		    num_of_regs ? TREE_INT_CST_LOW (num_of_regs) :
+		      (m68k_regparm ? m68k_regparm : M68K_DEFAULT_REGPARM);
+		}
+	    }
+	  else
+	    cum->num_of_regs = m68k_regparm;
+	}
+    }
+  else /* Libcall.  */
+    cum->num_of_regs = 0;
+
+  if (cum->num_of_regs)
+    {
+      /* If this is a vararg call, put all arguments on stack.  */
+      tree param, next_param;
+      for (param = TYPE_ARG_TYPES (fntype); param; param = next_param)
+	{
+	  next_param = TREE_CHAIN (param);
+	  if (!next_param && TREE_VALUE (param) != void_type_node)
+	    cum->num_of_regs = 0;
+	}
+    }
+
+#if ! defined (PCC_STATIC_STRUCT_RETURN) && defined (STRUCT_VALUE_REGNUM)
+  /* If return value is a structure, and we pass the buffer address in a
+     register, we can't use this register for our own purposes.
+     FIXME: Something similar would be useful for static chain.  */
+  if (fntype && aggregate_value_p (TREE_TYPE (fntype), fntype))
+    cum->regs_already_used |= (1 << STRUCT_VALUE_REGNUM);
+#endif
+}
+
+/* Update the data in CUM to advance over an argument.  */
+
+void
+m68k_function_arg_advance (CUMULATIVE_ARGS *cum)
+{
+  if (cum->last_arg_reg != -1)
+    {
+      int count;
+      for (count = 0; count < cum->last_arg_len; count++)
+	cum->regs_already_used |= (1 << (cum->last_arg_reg + count));
+      cum->last_arg_reg = -1;
+    }
+}
+
+/* Define where to put the arguments to a function.
+   Value is zero to push the argument on the stack,
+   or a hard register in which to store the argument.
+
+   MODE is the argument's machine mode.
+   TYPE is the data type of the argument (as a tree).
+    This is null for libcalls where that information may
+    not be available.
+   CUM is a variable of type CUMULATIVE_ARGS which gives info about
+    the preceding args and about the function being called.  */
+
+struct rtx_def *
+m68k_function_arg (CUMULATIVE_ARGS *cum, enum machine_mode mode, tree type)
+{
+  if (cum->num_of_regs)
+    {
+      int regbegin = -1, altregbegin = -1, len;
+
+      /* FIXME: The last condition below is a workaround for a bug.  */
+      if (TARGET_68881 && FLOAT_MODE_P (mode) &&
+	  GET_MODE_UNIT_SIZE (mode) <= 12 &&
+	  (GET_MODE_CLASS (mode) != MODE_COMPLEX_FLOAT || mode == SCmode))
+	{
+	  regbegin = 16; /* FPx */
+	  len = GET_MODE_NUNITS (mode);
+	}
+      /* FIXME: Two last conditions below are workarounds for bugs.  */
+      else if (INTEGRAL_MODE_P (mode) && mode !=CQImode && mode != CHImode)
+	{
+	  if (POINTER_TYPE_P (type))
+	    regbegin = 8; /* Ax */
+	  else
+	    regbegin = 0; /* Dx */
+	  altregbegin = 8 - regbegin;
+	  len = (GET_MODE_SIZE (mode) + (UNITS_PER_WORD - 1)) / UNITS_PER_WORD;
+	}
+
+      if (regbegin != -1)
+	{
+	  int reg;
+	  long mask;
+
+look_for_reg:
+	  mask = 1 << regbegin;
+	  for (reg = 0; reg < cum->num_of_regs; reg++, mask <<= 1)
+	    if (!(cum->regs_already_used & mask))
+	      {
+		int end;
+		for (end = reg; end < cum->num_of_regs && end < reg + len;
+		     end++, mask <<= 1)
+		  if (cum->regs_already_used & mask)
+		    break;
+		if (end == reg + len)
+		  {
+		    cum->last_arg_reg = reg + regbegin;
+		    cum->last_arg_len = len;
+		    break;
+		  }
+	      }
+
+	  if (reg == cum->num_of_regs && altregbegin != -1)
+	    {
+	      regbegin = altregbegin;
+	      altregbegin = -1;
+	      goto look_for_reg;
+	    }
+	}
+
+      if (cum->last_arg_reg != -1)
+	return gen_rtx_REG (mode, cum->last_arg_reg);
+    }
+  return 0;
+}
+
 static void
 m68k_compute_frame_layout (void)
 {
@@ -428,10 +719,14 @@
 static bool
 m68k_save_reg (unsigned int regno, bool interrupt_handler)
 {
-  if (flag_pic && current_function_uses_pic_offset_table
+  if (flag_pic && flag_pic < 3 && current_function_uses_pic_offset_table
       && regno == PIC_OFFSET_TABLE_REGNUM)
     return true;
 
+#ifdef EXTRA_SAVE_REG
+  EXTRA_SAVE_REG(regno);
+#endif
+
   if (current_function_calls_eh_return)
     {
       unsigned int i;
@@ -480,6 +775,9 @@
 m68k_output_function_prologue (FILE *stream, HOST_WIDE_INT size ATTRIBUTE_UNUSED)
 {
   HOST_WIDE_INT fsize_with_regs;
+#if !defined (DWARF2_DEBUGGING_INFO) && !defined (DWARF2_UNWIND_INFO)
+#define dwarf2out_do_frame() 0
+#endif
   HOST_WIDE_INT cfa_offset = INCOMING_FRAME_SP_OFFSET;
 
   m68k_compute_frame_layout();
@@ -496,8 +794,17 @@
   if (TARGET_COLDFIRE && current_frame.reg_no > 2)
     fsize_with_regs += current_frame.reg_no * 4;
 
+#ifdef PROLOGUE_BEGIN_HOOK
+  PROLOGUE_BEGIN_HOOK (stream, fsize_with_regs);
+#endif
+
   if (frame_pointer_needed)
     {
+#ifdef HAVE_ALTERNATE_FRAME_SETUP_F
+      if (HAVE_ALTERNATE_FRAME_SETUP_F (fsize_with_regs))
+	ALTERNATE_FRAME_SETUP_F (stream, fsize_with_regs);
+      else
+#endif
       if (current_frame.size == 0 && TARGET_68040)
 	/* on the 68040, pea + move is faster than link.w 0 */
 	fprintf (stream, MOTOROLA ?
@@ -528,6 +835,10 @@
 	  cfa_offset += current_frame.size;
 	}
     }
+#ifdef HAVE_ALTERNATE_FRAME_SETUP
+  else if (HAVE_ALTERNATE_FRAME_SETUP (fsize_with_regs))
+    ALTERNATE_FRAME_SETUP (stream, fsize_with_regs);
+#endif
   else if (fsize_with_regs) /* !frame_pointer_needed */
     {
       if (fsize_with_regs < 0x8000)
@@ -658,7 +969,12 @@
 	      dwarf2out_reg_save (l, regno, -cfa_offset + n_regs++ * 4);
 	}
     }
-  if (!TARGET_SEP_DATA && flag_pic &&
+#ifdef HAVE_ALTERNATE_PIC_SETUP
+  if (HAVE_ALTERNATE_PIC_SETUP)
+    ALTERNATE_PIC_SETUP (stream);
+  else
+#endif
+  if (!TARGET_SEP_DATA && flag_pic && flag_pic < 3 &&
       (current_function_uses_pic_offset_table ||
         (!current_function_is_leaf && TARGET_ID_SHARED_LIBRARY)))
     {
@@ -921,6 +1237,11 @@
 	}
     }
   if (frame_pointer_needed)
+#ifdef HAVE_ALTERNATE_FRAME_DESTR_F
+    if (HAVE_ALTERNATE_FRAME_DESTR_F (fsize_with_regs))
+      ALTERNATE_FRAME_DESTR_F (stream, fsize_with_regs);
+    else
+#endif
     fprintf (stream, "\tunlk %s\n",
 	     reg_names[FRAME_POINTER_REGNUM]);
   else if (fsize_with_regs)
@@ -958,10 +1279,17 @@
     }
   if (current_function_calls_eh_return)
     asm_fprintf (stream, "\tadd" ASM_DOT"l %Ra0,%Rsp\n");
+#ifdef EPILOGUE_END_HOOK
+  EPILOGUE_END_HOOK (stream);
+#endif
   if (m68k_interrupt_function_p (current_function_decl))
     fprintf (stream, "\trte\n");
   else if (current_function_pops_args)
     asm_fprintf (stream, "\trtd %I%d\n", current_function_pops_args);
+#ifdef HAVE_ALTERNATE_RETURN
+  else if (HAVE_ALTERNATE_RETURN)
+    ALTERNATE_RETURN (stream);
+#endif
   else
     fprintf (stream, "\trts\n");
 }
@@ -1454,12 +1782,20 @@
   /* First handle a simple SYMBOL_REF or LABEL_REF */
   if (GET_CODE (orig) == SYMBOL_REF || GET_CODE (orig) == LABEL_REF)
     {
+#ifdef LEGITIMATE_BASEREL_OPERAND_P
+      if (LEGITIMATE_BASEREL_OPERAND_P (orig))
+	return orig;
+#endif
+
       if (reg == 0)
 	abort ();
 
-      pic_ref = gen_rtx_MEM (Pmode,
-			     gen_rtx_PLUS (Pmode,
-					   pic_offset_table_rtx, orig));
+      if (flag_pic < 3)
+	pic_ref = gen_rtx_MEM (Pmode,
+			       gen_rtx_PLUS (Pmode,
+					     pic_offset_table_rtx, orig));
+      else
+	pic_ref = gen_rtx_PLUS (Pmode, pic_offset_table_rtx, orig);
       current_function_uses_pic_offset_table = 1;
       RTX_UNCHANGING_P (pic_ref) = 1;
       emit_move_insn (reg, pic_ref);
@@ -3001,6 +3337,10 @@
 		          fprintf (file, ":w"); break;
 		        case 2:
 		          fprintf (file, ":l"); break;
+		        case 3:
+		          fprintf (file, ":W"); break;
+		        case 4:
+		          fprintf (file, ":L"); break;
 		        default:
 		          break;
 		        }
@@ -3488,7 +3828,7 @@
   xops[0] = DECL_RTL (function);
 
   /* Logic taken from call patterns in m68k.md.  */
-  if (flag_pic)
+  if (flag_pic && flag_pic < 3)
     {
       if (TARGET_PCREL)
 	fmt = "bra.l %o0";
@@ -3544,7 +3884,8 @@
 
 /* Value is true if hard register REGNO can hold a value of machine-mode MODE.
    On the 68000, the cpu registers can hold any mode except bytes in address
-   registers, but the 68881 registers can hold only SFmode or DFmode.  */
+   registers, but the 68881 registers can hold only SFmode or DFmode.
+   The 68881 registers can't hold anything if 68881 use is disabled.  */
 bool
 m68k_regno_mode_ok (int regno, enum machine_mode mode)
 {
@@ -3569,6 +3910,7 @@
 	   smaller.  */
 	if ((GET_MODE_CLASS (mode) == MODE_FLOAT
 	     || GET_MODE_CLASS (mode) == MODE_COMPLEX_FLOAT)
+	    && TARGET_68881
 	    && GET_MODE_UNIT_SIZE (mode) <= 12)
 	  return true;
     }
