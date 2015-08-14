--- recipe/files/gcc/gcc/config/arm/riscos.md	(revision 6894)
+++ recipe/files/gcc/gcc/config/arm/riscos.md	(working copy)
@@ -127,6 +127,7 @@
 	       (match_operand 3 "" "")] UNSPEC_STK)
    (clobber (reg:SI 8))
    (clobber (reg:SI SL_REGNUM))
+   (use (reg:SI 11))
    (clobber (reg:SI IP_REGNUM))
    (clobber (reg:SI LR_REGNUM))
    (clobber (reg:CC CC_REGNUM))]
