From 9592197f4e9723b6a435318b9c39521beab07c7b Mon Sep 17 00:00:00 2001
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Wed, 15 Feb 2017 22:12:54 +0100
Subject: [PATCH 8/8] Fix undefined behaviour.

This should ensure that the code compiles with more recent version of GCC.
Changes have been backported from more recent version of binutils.
---
 binutils/dwarf.c     | 2 +-
 gas/config/tc-ppc.c  | 2 +-
 gas/read.c           | 2 +-
 gas/write.c          | 2 +-
 include/opcode/ppc.h | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/binutils/dwarf.c b/binutils/dwarf.c
index 6e93906af385ff3dd0f8785792a1e8cc3d04a774..9fc4a594cfe83693f44f686fc752987b3e2a5653 100644
--- a/binutils/dwarf.c
+++ b/binutils/dwarf.c
@@ -214,13 +214,13 @@ read_leb128 (unsigned char *data, unsigned int *length_return, int sign)
   while (byte & 0x80);
 
   if (length_return != NULL)
     *length_return = num_read;
 
   if (sign && (shift < 8 * sizeof (result)) && (byte & 0x40))
-    result |= -1L << shift;
+    result |= -((dwarf_vma) 1 << shift);
 
   return result;
 }
 
 /* Create a signed version to avoid painful typecasts.  */
 static dwarf_signed_vma
diff --git a/gas/config/tc-ppc.c b/gas/config/tc-ppc.c
index 11949323d80802138ec23fb8174727c0a7c4fd45..14346e30661d408d5dba4d456cc274f2f4dc3820 100644
--- a/gas/config/tc-ppc.c
+++ b/gas/config/tc-ppc.c
@@ -1466,13 +1466,13 @@ insn_validate (const struct powerpc_opcode *op)
 	  as_bad (_("operand index error for %s"), op->name);
 	  return TRUE;
         }
       else
         {
 	  const struct powerpc_operand *operand = &powerpc_operands[*o];
-	  if (operand->shift != PPC_OPSHIFT_INV)
+	  if (operand->shift != (int) PPC_OPSHIFT_INV)
 	    {
 	      unsigned long mask;
 
 	      if (operand->shift >= 0)
 		mask = operand->bitm << operand->shift;
 	      else
diff --git a/gas/read.c b/gas/read.c
index 9de62b9c512025212d52a19833ffe28004944dd1..dfd466be7934cfd379b2a0c99f08c7ea877fdbe0 100644
--- a/gas/read.c
+++ b/gas/read.c
@@ -5172,13 +5172,13 @@ output_big_sleb128 (char *p, LITTLENUM_TYPE *bignum, int size)
 
   /* Mop up any left-over bits (of which there will be less than 7).  */
   if ((byte & 0x80) != 0)
     {
       /* Sign-extend VAL.  */
       if (val & (1 << (loaded - 1)))
-	val |= ~0 << loaded;
+	val |= ~0U << loaded;
       if (orig)
 	*p = val & 0x7f;
       p++;
     }
 
   return p - orig;
diff --git a/gas/write.c b/gas/write.c
index 8a9746c927a3e8b7007cdec9c7f16e47509b5f45..be6969865f7373cdeb396df44506ef537206fbd8 100644
--- a/gas/write.c
+++ b/gas/write.c
@@ -2310,13 +2310,13 @@ static relax_addressT
 relax_align (register relax_addressT address,	/* Address now.  */
 	     register int alignment	/* Alignment (binary).  */)
 {
   relax_addressT mask;
   relax_addressT new_address;
 
-  mask = ~((~0) << alignment);
+  mask = ~((relax_addressT) ~0 << alignment);
   new_address = (address + mask) & (~mask);
 #ifdef LINKER_RELAXING_SHRINKS_ONLY
   if (linkrelax)
     /* We must provide lots of padding, so the linker can discard it
        when needed.  The linker will not add extra space, ever.  */
     new_address += (1 << alignment);
diff --git a/include/opcode/ppc.h b/include/opcode/ppc.h
index e57b118b02e5a2faba62f5dbd524f03827f719c0..40a1262ecd17944de229f6b192f8c6e078f70728 100644
--- a/include/opcode/ppc.h
+++ b/include/opcode/ppc.h
@@ -267,13 +267,13 @@ struct powerpc_operand
 extern const struct powerpc_operand powerpc_operands[];
 extern const unsigned int num_powerpc_operands;
 
 /* Use with the shift field of a struct powerpc_operand to indicate
      that BITM and SHIFT cannot be used to determine where the operand
      goes in the insn.  */
-#define PPC_OPSHIFT_INV (-1 << 31)
+#define PPC_OPSHIFT_INV (-1U << 31)
 
 /* Values defined for the flags field of a struct powerpc_operand.  */
 
 /* This operand takes signed values.  */
 #define PPC_OPERAND_SIGNED (0x1)
 
-- 
2.11.0

