--- gcc-3.4.6/gcc/flow.c	2013-05-19 20:09:27.000000000 +0200
+++ gcc/flow.c	2013-05-19 20:23:32.000000000 +0200
@@ -2335,11 +2335,13 @@
   if (n_basic_blocks == 0
       || (regno < FIRST_PSEUDO_REGISTER
 	  && (global_regs[regno]
-	      || fixed_regs[regno]
-	      || FUNCTION_ARG_REGNO_P (regno))))
+/* begin-GG-local: explicit register specification for parameters */
+	      || fixed_regs[regno])))
     return 0;
 
-  return REGNO_REG_SET_P (ENTRY_BLOCK_PTR->global_live_at_end, regno);
+  return (REGNO_REG_SET_P (ENTRY_BLOCK_PTR->global_live_at_end, regno)
+	  && (regno >= FIRST_PSEUDO_REGISTER || ! function_arg_regno_p (regno)));
+/* end-GG-local */
 }
 
 /* 1 if register REGNO was alive at a place where `setjmp' was called
