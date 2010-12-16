/* Configuration for GNU C-compiler for m68k Amiga, running AmigaOS.
   Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 1998, 2003
   Free Software Foundation, Inc.  
   Contributed by Markus M. Wild (wild@amiga.physik.unizh.ch).
   Heavily modified by Kamil Iskra (iskra@student.uci.agh.edu.pl).

This file is part of GCC.

GCC is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2, or (at your option)
any later version.

GCC is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with GCC; see the file COPYING.  If not, write to
the Free Software Foundation, 59 Temple Place - Suite 330,
Boston, MA 02111-1307, USA.  */

//work without flag_writable_strings which is not in GCC4
//#include "config/m68k/amigaos.h"
#define REGPARMS_68K 1

#include "config.h"
#include "system.h"
#include "coretypes.h"
#include "tm.h"
#include "rtl.h"
#include "output.h"
#include "tree.h"
#include "flags.h"
#include "expr.h"
#include "toplev.h"
#include "tm_p.h"

static int amigaos_put_in_text (tree);
static rtx gen_stack_management_call (rtx, rtx, const char *);
int m68k_regparm; 
/* Baserel support.  */

/* Does operand (which is a symbolic_operand) live in text space? If
   so SYMBOL_REF_FLAG, which is set by ENCODE_SECTION_INFO, will be true.

   This function is used in base relative code generation. */

int
read_only_operand (rtx operand)
{
  if (GET_CODE (operand) == CONST)
    operand = XEXP (XEXP (operand, 0), 0);
  if (GET_CODE (operand) == SYMBOL_REF)
    return SYMBOL_REF_FLAG (operand) || CONSTANT_POOL_ADDRESS_P (operand);
  return 1;
}

/* Choose the section to use for DECL.  RELOC is true if its value contains
   any relocatable expression.  */

void
amigaos_select_section (tree decl, int reloc,
			unsigned HOST_WIDE_INT align ATTRIBUTE_UNUSED)
{
 // if (TREE_CODE (decl) == STRING_CST)
//    {
//// flag_writable_strings /data_section not in gcc4,
////make life easy and put to same section
////      if (! flag_writable_strings)
////	readonly_data_section ();
////      else
//	//data_section ();
//    }
//  else if (TREE_CODE (decl) == VAR_DECL)
//    {
//      if (TREE_READONLY (decl)
//	  && ! TREE_THIS_VOLATILE (decl)
//	  && DECL_INITIAL (decl)
//	  && (DECL_INITIAL (decl) == error_mark_node
//	      || TREE_CONSTANT (DECL_INITIAL (decl)))
//	  && (!flag_pic || (flag_pic<3 && !reloc)
//	      || SYMBOL_REF_FLAG (XEXP (DECL_RTL (decl), 0))))
//	readonly_data_section ();
//      else
//	data_section ();
//    }
//  else if ((!flag_pic || (flag_pic<3 && !reloc)) && DECL_P(decl)
//	   && SYMBOL_REF_FLAG (XEXP (DECL_RTL (decl), 0)))
//    readonly_data_section ();
//  else
    //data_section ();
}

/* This function is used while generating a base relative code.
   It returns 1 if a decl is not relocatable, i. e., if it can be put
   in the text section.
   Currently, it's very primitive: it just checks if the object size
   is less than 4 bytes (i. e., if it can hold a pointer).  It also
   supports arrays and floating point types.  */

static int
amigaos_put_in_text (tree decl)
{
  tree type = TREE_TYPE (decl);
  if (TREE_CODE (type) == ARRAY_TYPE)
    type = TREE_TYPE (type);
  return (TREE_INT_CST_HIGH (TYPE_SIZE (type)) == 0
	  && TREE_INT_CST_LOW (TYPE_SIZE (type)) < 32)
	  || FLOAT_TYPE_P (type);
}

/* Record properties of a DECL into the associated SYMBOL_REF.  */

void
amigaos_encode_section_info (tree decl, rtx rtl, int first)
{
  default_encode_section_info (decl, rtl, first);


  SYMBOL_REF_FLAG (XEXP (rtl, 0)) = 1;
  //if (TREE_CODE (decl) == FUNCTION_DECL) // huh seem do same. not in gcc4 flag_writable_strings
//    SYMBOL_REF_FLAG (XEXP (rtl, 0)) = 1;
//  else
//    {
//      if ((RTX_UNCHANGING_P (rtl) && !MEM_VOLATILE_P (rtl)
//           && (flag_pic<3 || (TREE_CODE (decl) == STRING_CST
//                              && !flag_writable_strings)
//               || amigaos_put_in_text (decl)))
//          || (TREE_CODE (decl) == VAR_DECL
//              && DECL_SECTION_NAME (decl) != NULL_TREE))
//        SYMBOL_REF_FLAG (XEXP (rtl, 0)) = 1;
//    }
}

/* Common routine used to check if a4 should be preserved/restored.  */

int
amigaos_restore_a4 (void)
{
  return (flag_pic >= 3 &&
	  (TARGET_RESTORE_A4 || TARGET_ALWAYS_RESTORE_A4
	   || lookup_attribute ("saveds",
				TYPE_ATTRIBUTES (TREE_TYPE (current_function_decl)))));
}

void
amigaos_alternate_pic_setup (FILE *stream)
{
  if (TARGET_RESTORE_A4 || TARGET_ALWAYS_RESTORE_A4)
    asm_fprintf (stream, "\tjbsr %U__restore_a4\n");
  else if (lookup_attribute ("saveds",
			     TYPE_ATTRIBUTES (TREE_TYPE (current_function_decl))))
    asm_fprintf (stream, "\tlea %U__a4_init,%Ra4\n");
}

/* Attributes support.  */

#define AMIGA_CHIP_SECTION_NAME ".datachip"

/* Handle a "chip" attribute;
   arguments as in struct attribute_spec.handler.  */

tree
amigaos_handle_decl_attribute (tree *node, tree name,
			       tree args ATTRIBUTE_UNUSED,
			       int flags ATTRIBUTE_UNUSED,
			       bool *no_add_attrs)
{
  if (TREE_CODE (*node) == VAR_DECL)
    {
      if (is_attribute_p ("chip", name))
#ifdef TARGET_ASM_NAMED_SECTION
        {
	  if (! TREE_STATIC (*node) && ! DECL_EXTERNAL (*node))
	    error ("`chip' attribute cannot be specified for local variables");
	  else
	    {
	      /* The decl may have already been given a section attribute from
	         a previous declaration.  Ensure they match.  */
	      if (DECL_SECTION_NAME (*node) == NULL_TREE)
	        DECL_SECTION_NAME (*node) =
		  build_string (strlen (AMIGA_CHIP_SECTION_NAME) + 1,
			        AMIGA_CHIP_SECTION_NAME);
	      else if (strcmp (TREE_STRING_POINTER (DECL_SECTION_NAME (*node)),
			       AMIGA_CHIP_SECTION_NAME) != 0)
	        {
		  error_with_decl (*node,
			  "`chip' for `%s' conflicts with previous declaration");
	        }
	    }
        }
#else
        error ("`chip' attribute is not supported for this target");
#endif
    }
  else
    {
      warning ("`%s' attribute only applies to variables",
	       IDENTIFIER_POINTER (name));
      *no_add_attrs = true;
    }

  return NULL_TREE;
}

//----- from 68k.c start




 
/* Handle a "regparm" or "stkparm" attribute;
   arguments as in struct attribute_spec.handler.  */


static tree
m68k_handle_type_attribute (tree *node, tree name, tree args,
			    int flags ATTRIBUTE_UNUSED, bool *no_add_attrs)
{
 
  if (TREE_CODE (*node) == FUNCTION_TYPE || TREE_CODE (*node) == METHOD_TYPE)
    {
      /* 'regparm' accepts one optional argument - number of registers in
	 single class that should be used to pass arguments.  */
      if (is_attribute_p ("regparm_x", name))
	{
	  if (lookup_attribute ("stkparm_x", TYPE_ATTRIBUTES(*node)))
	    {
	      error ("`regparm' and `stkparm' are mutually exclusive");
	    }
	  if (args && TREE_CODE (args) == TREE_LIST)
	    {
	      tree numofregs = TREE_VALUE (args);
	      if (numofregs)
		if (TREE_CODE (numofregs) != INTEGER_CST
/*
		    || compare_tree_int(numofregs, 1) < 0
		    || compare_tree_int(numofregs, M68K_MAX_REGPARM) > 0)
*/
		    || TREE_INT_CST_HIGH (numofregs)
		    || TREE_INT_CST_LOW (numofregs) < 1
		    || TREE_INT_CST_LOW (numofregs) > M68K_MAX_REGPARM)
		  {
		    error ("invalid argument to `regparm' attribute");
		  }
	    }
	}
      else if (is_attribute_p ("stkparm_x", name))
	{
	  if (lookup_attribute ("regparm_x", TYPE_ATTRIBUTES(*node)))
	    {
	      error ("`regparm' and `stkparm' are mutually exclusive");
	    }
	}
    }
  else
    {
      warning ("`%s' attribute only applies to functions",
	       IDENTIFIER_POINTER (name));
      *no_add_attrs = true;
    }

  return NULL_TREE;
}

/* Return zero if the attributes on TYPE1 and TYPE2 are incompatible,
   one if they are compatible, and two if they are nearly compatible
   (which causes a warning to be generated). */

static int
m68k_comp_type_attributes (tree type1, tree type2)
{
    
  /* Functions or methods are incompatible if they specify mutually
     exclusive ways of passing arguments.  */
  if (TREE_CODE (type1) == FUNCTION_TYPE || TREE_CODE (type1) == METHOD_TYPE)
    {
      tree arg1, arg2;
      if (!! lookup_attribute ("stkparm_x", TYPE_ATTRIBUTES (type1)) !=
	     !! lookup_attribute ("stkparm_x", TYPE_ATTRIBUTES (type2))
	  || !! lookup_attribute ("regparm_x", TYPE_ATTRIBUTES (type1)) !=
	     !! lookup_attribute ("regparm_x", TYPE_ATTRIBUTES (type2)))
	return 0; /* 'regparm' and 'stkparm' are mutually exclusive.  */

      arg1 = lookup_attribute ("regparm_x", TYPE_ATTRIBUTES (type1));
      arg2 = lookup_attribute ("regparm_x", TYPE_ATTRIBUTES (type2));
      if (arg1 && arg2)
	{
	  int num1 = 0, num2 = 0;
	  if (TREE_VALUE (arg1) && TREE_CODE (TREE_VALUE (arg1)) == TREE_LIST)
	    {
	      tree numofregs = TREE_VALUE (TREE_VALUE (arg1));
	      if (numofregs)
		num1 = TREE_INT_CST_LOW (numofregs);
	    }
	  if (TREE_VALUE (arg2) && TREE_CODE (TREE_VALUE (arg2)) == TREE_LIST)
	    {
	      tree numofregs = TREE_VALUE (TREE_VALUE (arg2));
	      if (numofregs)
		num2 = TREE_INT_CST_LOW (numofregs);
	    }
	  if (num1 != num2)
	    return 0; /* Different numbers, or no number in one type.  */
	}
    }
#ifdef TARGET_AMIGAOS
    return amigaos_comp_type_attributes(type1, type2);
#else
  return 1;
#endif
}

/* Argument-passing support functions.  */

/* Initialize a variable CUM of type CUMULATIVE_ARGS
   for a call to a function whose data type is FNTYPE.
   For a library call, FNTYPE is 0.  */

void
m68k_init_cumulative_args (CUMULATIVE_ARGS *cum, tree fntype)
{
  cum->last_arg_reg = -1;
  cum->regs_already_used = 0;
  if (fntype)
    {
      if (lookup_attribute ("stkparm_x", TYPE_ATTRIBUTES (fntype)))
	cum->num_of_regs = 0;
      else
	{
	  tree ratree = lookup_attribute ("regparm_x", TYPE_ATTRIBUTES (fntype));
	  if (ratree)
	    {
	      cum->num_of_regs = m68k_regparm ? m68k_regparm
					      : M68K_DEFAULT_REGPARM;
	      if (TREE_VALUE (ratree)
		  && TREE_CODE (TREE_VALUE (ratree)) == TREE_LIST)
		{
		  tree num_of_regs = TREE_VALUE (TREE_VALUE (ratree));
		  cum->num_of_regs =
		    num_of_regs ? TREE_INT_CST_LOW (num_of_regs) :
		      (m68k_regparm ? m68k_regparm : M68K_DEFAULT_REGPARM);
		}
	    }
	  else
	    cum->num_of_regs = m68k_regparm;
	}
    }
  else /* Libcall.  */
    cum->num_of_regs = 0;

  if (cum->num_of_regs)
    {
      /* If this is a vararg call, put all arguments on stack.  */
      tree param, next_param;
      for (param = TYPE_ARG_TYPES (fntype); param; param = next_param)
	{
	  next_param = TREE_CHAIN (param);
	  if (!next_param && TREE_VALUE (param) != void_type_node)
	    cum->num_of_regs = 0;
	}
    }

#if ! defined (PCC_STATIC_STRUCT_RETURN) && defined (M68K_STRUCT_VALUE_REGNUM)
  /* If return value is a structure, and we pass the buffer address in a
     register, we can't use this register for our own purposes.
     FIXME: Something similar would be useful for static chain.  */
  if (fntype && aggregate_value_p (TREE_TYPE (fntype), fntype))
    cum->regs_already_used |= (1 << M68K_STRUCT_VALUE_REGNUM);
#endif
}

/* Update the data in CUM to advance over an argument.  */

void
m68k_function_arg_advance (CUMULATIVE_ARGS *cum)
{
  if (cum->last_arg_reg != -1)
    {
      int count;
      for (count = 0; count < cum->last_arg_len; count++)
	cum->regs_already_used |= (1 << (cum->last_arg_reg + count));
      cum->last_arg_reg = -1;
    }
}

/* Define where to put the arguments to a function.
   Value is zero to push the argument on the stack,
   or a hard register in which to store the argument.

   MODE is the argument's machine mode.
   TYPE is the data type of the argument (as a tree).
    This is null for libcalls where that information may
    not be available.
   CUM is a variable of type CUMULATIVE_ARGS which gives info about
    the preceding args and about the function being called.  */

struct rtx_def *
m68k_function_arg (CUMULATIVE_ARGS *cum, enum machine_mode mode, tree type)
{
  if (cum->num_of_regs)
    {
      int regbegin = -1, altregbegin = -1, len;

      /* FIXME: The last condition below is a workaround for a bug.  */
      if (TARGET_68881 && FLOAT_MODE_P (mode) &&
	  GET_MODE_UNIT_SIZE (mode) <= 12 &&
	  (GET_MODE_CLASS (mode) != MODE_COMPLEX_FLOAT || mode == SCmode))
	{
	  regbegin = 16; /* FPx */
	  len = GET_MODE_NUNITS (mode);
	}
      /* FIXME: Two last conditions below are workarounds for bugs.  */
      else if (INTEGRAL_MODE_P (mode) && mode !=CQImode && mode != CHImode)
	{
	  if (POINTER_TYPE_P (type))
	    regbegin = 8; /* Ax */
	  else
	    regbegin = 0; /* Dx */
	  altregbegin = 8 - regbegin;
	  len = (GET_MODE_SIZE (mode) + (UNITS_PER_WORD - 1)) / UNITS_PER_WORD;
	}

      if (regbegin != -1)
	{
	  int reg;
	  long mask;

look_for_reg:
	  mask = 1 << regbegin;
	  for (reg = 0; reg < cum->num_of_regs; reg++, mask <<= 1)
	    if (!(cum->regs_already_used & mask))
	      {
		int end;
		for (end = reg; end < cum->num_of_regs && end < reg + len;
		     end++, mask <<= 1)
		  if (cum->regs_already_used & mask)
		    break;
		if (end == reg + len)
		  {
		    cum->last_arg_reg = reg + regbegin;
		    cum->last_arg_len = len;
		    break;
		  }
	      }

	  if (reg == cum->num_of_regs && altregbegin != -1)
	    {
	      regbegin = altregbegin;
	      altregbegin = -1;
	      goto look_for_reg;
	    }
	}

      if (cum->last_arg_reg != -1)
	return gen_rtx_REG (mode, cum->last_arg_reg);
    }
  return 0;
}

// end from 68k.h diff

/* Handle a "stackext", "interrupt" or "saveds" attribute;
+   arguments as in struct attribute_spec.handler.  */

tree
amigaos_handle_type_attribute (tree *node, tree name,
			       tree args ATTRIBUTE_UNUSED,
			       int flags ATTRIBUTE_UNUSED,
			       bool *no_add_attrs)
{
  if (TREE_CODE (*node) == FUNCTION_TYPE || TREE_CODE (*node) == METHOD_TYPE)
    {
      if (is_attribute_p ("stackext", name))
	{
	  if (lookup_attribute ("interrupt", TYPE_ATTRIBUTES(*node)))
	    {
	      error ("`stackext' and `interrupt' are mutually exclusive");
	    }
	}
      else if (is_attribute_p ("interrupt", name))
	{
	  if (lookup_attribute ("stackext", TYPE_ATTRIBUTES(*node)))
	    {
	      error ("`stackext' and `interrupt' are mutually exclusive");
	    }
	}
      else if (is_attribute_p ("saveds", name))
	{
	}
    }
  else
    {
      warning ("`%s' attribute only applies to functions",
	       IDENTIFIER_POINTER (name));
      *no_add_attrs = true;
    }

  return NULL_TREE;
}

/* Stack checking and automatic extension support.  */

void
amigaos_prologue_begin_hook (FILE *stream, int fsize)
{
  if (TARGET_STACKCHECK)
    {
      if (fsize < 256)
	asm_fprintf (stream, "\tcmpl %s,%Rsp\n"
			     "\tjcc 0f\n"
			     "\tjra %U__stkovf\n"
			     "\t0:\n",
		     (flag_pic == 3 ? "a4@(___stk_limit:W)" :
				      (flag_pic == 4 ? "a4@(___stk_limit:L)" :
						       "___stk_limit")));
      else
	asm_fprintf (stream, "\tmovel %I%d,%Rd0\n\tjbsr %U__stkchk_d0\n",
		     fsize);
    }
}

void
amigaos_alternate_frame_setup_f (FILE *stream, int fsize)
{
  if (fsize < 128)
    asm_fprintf (stream, "\tcmpl %s,%Rsp\n"
			 "\tjcc 0f\n"
			 "\tmoveq %I%d,%Rd0\n"
			 "\tmoveq %I0,%Rd1\n"
			 "\tjbsr %U__stkext_f\n"
			 "0:\tlink %Ra5,%I%d:W\n",
		 (flag_pic == 3 ? "a4@(___stk_limit:W)" :
				  (flag_pic == 4 ? "a4@(___stk_limit:L)" :
						   "___stk_limit")),
		 fsize, -fsize);
  else
    asm_fprintf (stream, "\tmovel %I%d,%Rd0\n\tjbsr %U__link_a5_d0_f\n",
		 fsize);
}

void
amigaos_alternate_frame_setup (FILE *stream, int fsize)
{
  if (!fsize)
    asm_fprintf (stream, "\tcmpl %s,%Rsp\n"
			 "\tjcc 0f\n"
			 "\tmoveq %I0,%Rd0\n"
			 "\tmoveq %I0,%Rd1\n"
			 "\tjbsr %U__stkext_f\n"
			 "0:\n",
		 (flag_pic == 3 ? "a4@(___stk_limit:W)" :
				  (flag_pic == 4 ? "a4@(___stk_limit:L)" :
						   "___stk_limit")));
  else if (fsize < 128)
    asm_fprintf (stream, "\tcmpl %s,%Rsp\n"
			 "\tjcc 0f\n"
			 "\tmoveq %I%d,%Rd0\n"
			 "\tmoveq %I0,%Rd1\n"
			 "\tjbsr %U__stkext_f\n"
			 "0:\taddw %I%d,%Rsp\n",
		 (flag_pic == 3 ? "a4@(___stk_limit:W)" :
				  (flag_pic == 4 ? "a4@(___stk_limit:L)" :
						   "___stk_limit")),
		 fsize, -fsize);
  else
    asm_fprintf (stream, "\tmovel %I%d,%Rd0\n\tjbsr %U__sub_d0_sp_f\n",
		 fsize);
}

//static rtx
//gen_stack_management_call (rtx stack_pointer, rtx arg, const char *func)
//{
//  rtx call_insn, call, seq, name;
//  start_sequence ();
//
//  /* Move arg to d0.  */
//  emit_move_insn (gen_rtx_REG (SImode, 0), arg);
//
//  /* Generate the function reference.  */
//  name = gen_rtx_SYMBOL_REF (Pmode, func);
//  SYMBOL_REF_FLAG (name) = 1;
//  /* If optimizing, put it in a psedo so that several loads can be merged
//     into one.  */
//  if (optimize && ! flag_no_function_cse)
//    name = copy_to_reg (name);
//
//  /* Generate the function call.  */
//  call = gen_rtx_CALL (VOIDmode, gen_rtx_MEM (FUNCTION_MODE, name),
//		  const0_rtx);
//  /* If we are doing stack extension, notify about the sp change.  */
//  if (stack_pointer)
//    call = gen_rtx_SET (VOIDmode, stack_pointer, call);
//
//  /* Generate the call instruction.  */
//  call_insn = emit_call_insn (call);
//  /* Stack extension does not change memory in an unpredictable way.  */
//  RTL_CONST_OR_PURE_CALL_P (call_insn) = 1;
//  /* We pass an argument in d0.  */
//  CALL_INSN_FUNCTION_USAGE (call_insn) = gen_rtx_EXPR_LIST (VOIDmode,
//	gen_rtx_USE (VOIDmode, gen_rtx_REG (SImode, 0)), 0);
//
//  seq = get_insns ();
//  end_sequence ();
//  return seq;
//}
//
//rtx
//gen_stack_cleanup_call (rtx stack_pointer, rtx sa)
//{
//  return gen_stack_management_call (stack_pointer, sa, "__move_d0_sp");
//}
//
//void
//amigaos_alternate_allocate_stack (rtx *operands)
//{
//  if (TARGET_STACKEXTEND)
//    emit_insn (gen_stack_management_call (stack_pointer_rtx, operands[1],
//					  "__sub_d0_sp"));
//  else
//    {
//      if (TARGET_STACKCHECK)
//	emit_insn (gen_stack_management_call (0, operands[1], "__stkchk_d0"));
//      anti_adjust_stack (operands[1]);
//    }
//  emit_move_insn (operands[0], virtual_stack_dynamic_rtx);
//}

/* begin-GG-local: explicit register specification for parameters */

/* Initialize a variable CUM of type CUMULATIVE_ARGS
   for a call to a function whose data type is FNTYPE.
   For a library call, FNTYPE is 0.  */

void
amigaos_init_cumulative_args(CUMULATIVE_ARGS *cum, tree fntype)
{
  m68k_init_cumulative_args(cum, fntype);

  if (fntype)
    cum->formal_type=TYPE_ARG_TYPES(fntype);
  else /* Call to compiler-support function. */
    cum->formal_type=0;
}

/* Update the data in CUM to advance over an argument.  */

void
amigaos_function_arg_advance(CUMULATIVE_ARGS *cum)
{
  m68k_function_arg_advance(cum);

  if (cum->formal_type)
    cum->formal_type=TREE_CHAIN((tree)cum->formal_type);
}

/* A C expression that controls whether a function argument is passed
   in a register, and which register. */

struct rtx_def *
amigaos_function_arg(CUMULATIVE_ARGS *cum, enum machine_mode mode, tree type)
{
  tree asmtree;
  return m68k_function_arg(cum, mode, type); // use old routine
  if (cum->formal_type && TREE_VALUE((tree)cum->formal_type)
      && (asmtree=lookup_attribute("asm_x",
			TYPE_ATTRIBUTES(TREE_VALUE((tree)cum->formal_type)))))
    {
      int i;
#if 0
      /* See c-decl.c/push_parm_decl for an explanation why this doesn't work.
       */
      cum->last_arg_reg=TREE_INT_CST_LOW(TREE_VALUE(TREE_VALUE(asmtree)));
#else
      cum->last_arg_reg=TREE_INT_CST_LOW(TREE_VALUE(asmtree));
#endif
      cum->last_arg_len=HARD_REGNO_NREGS(cum->last_arg_reg, mode);

      for (i=0; i<cum->last_arg_len; i++)
	if (cum->regs_already_used & (1 << cum->last_arg_reg+i))
	  {
	    error("two parameters allocated for one register");
	    break;
	  }
      return gen_rtx_REG (mode, cum->last_arg_reg);
    }
  else
    return m68k_function_arg(cum, mode, type);
}

/* Return zero if the attributes on TYPE1 and TYPE2 are incompatible,
   one if they are compatible, and two if they are nearly compatible
   (which causes a warning to be generated). */

int
amigaos_comp_type_attributes (tree type1, tree type2)
{
  /* Functions or methods are incompatible if they specify mutually exclusive
     ways of passing arguments. */
  if (TREE_CODE(type1)==FUNCTION_TYPE || TREE_CODE(type1)==METHOD_TYPE)
    {
      tree arg1, arg2;
      arg1=TYPE_ARG_TYPES(type1);
      arg2=TYPE_ARG_TYPES(type2);
      for (; arg1 && arg2; arg1=TREE_CHAIN(arg1), arg2=TREE_CHAIN(arg2))
	if (TREE_VALUE(arg1) && TREE_VALUE(arg2))
	  {
	    tree asm1, asm2;
	    asm1=lookup_attribute("asm_x", TYPE_ATTRIBUTES(TREE_VALUE(arg1)));
	    asm2=lookup_attribute("asm_x", TYPE_ATTRIBUTES(TREE_VALUE(arg2)));
	    if (asm1 && asm2)
	      {
		if (TREE_INT_CST_LOW(TREE_VALUE(asm1))!=
		    TREE_INT_CST_LOW(TREE_VALUE(asm2)))
		  return 0; /* Two different registers specified. */
	      }
	    else
	      if (asm1 || asm2)
		return 0; /* "asm" used in only one type. */
	  }
    }
  return 1;
}

/* end-GG-local */ 
