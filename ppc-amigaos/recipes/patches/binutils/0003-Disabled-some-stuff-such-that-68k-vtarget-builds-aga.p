From be1c62376ea16552979036768972be85ca66c9ed Mon Sep 17 00:00:00 2001
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Tue, 17 Mar 2015 19:30:24 +0100
Subject: [PATCH 3/8] Disabled some stuff such that 68k vtarget builds again.

This doesn't imply that it is working.
---
 gas/config/tc-m68k.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/gas/config/tc-m68k.c b/gas/config/tc-m68k.c
index 8b5f6c60f2141ee91d6e9d1d639815abdf4e5042..9070a862b9c1266e84a8cea8da697f333227fa98 100644
--- a/gas/config/tc-m68k.c
+++ b/gas/config/tc-m68k.c
@@ -5158,22 +5158,22 @@ md_convert_frag_1 (fragS *fragP)
     case TAB (BRANCHBWPL, LONG):
       /* Here we are converting an unconditional branch into a pair of
 	 conditional branches, in order to get the range.  */
       fragP->fr_opcode[0] = 0x66; /* bne */
       fragP->fr_opcode[1] = 0xFF;
       fixP = fix_new (fragP, fragP->fr_fix, 4, fragP->fr_symbol,
-		      fragP->fr_offset, 1, RELAX_RELOC_PC32);
+		      fragP->fr_offset, 1, RELAX_RELOC_PC32, 0);
       fixP->fx_file = fragP->fr_file;
       fixP->fx_line = fragP->fr_line;
       fragP->fr_fix += 4;  /* Skip first offset */
       buffer_address += 4;
       *buffer_address++ = 0x67; /* beq */
       *buffer_address++ = 0xff;
       fragP->fr_fix += 2;  /* Skip second branch opcode */
       fixP = fix_new (fragP, fragP->fr_fix, 4, fragP->fr_symbol,
-		      fragP->fr_offset, 1, RELAX_RELOC_PC32);
+		      fragP->fr_offset, 1, RELAX_RELOC_PC32, 0);
       fragP->fr_fix += 4;
       break;
     case TAB (BRABSJUNC, LONG):
       if (flag_small_code)
 	{
 	  as_bad (_("Long branch in small code model, not supported."));
@@ -5348,12 +5348,14 @@ md_convert_frag_1 (fragS *fragP)
       fragP->fr_fix += 4;
       break;
     case TAB (ABSREL, BYTE):
       as_bad (_("ABSREL_BYTE: how the ** does this look??"));
       break;
     case TAB (ABSREL, SHORT):
+      as_bad (_("ABSREL_SHORT: sorry, not supported. See" __FILE__));
+#if 0
       fragP->fr_opcode[1] &= ~0x3f;
       fragP->fr_fix += 2;
       if (S_GET_TYPE (fragP->fr_symbol) == N_TEXT)
 	{
 	  /* so this is really a pc-relative address */
 	  fragP->fr_opcode[1] |= 0x3a;
@@ -5362,20 +5364,23 @@ md_convert_frag_1 (fragS *fragP)
 	}
       /* in that case we have to generate base-relative code
        * (note: if we're in N_UNDF, this could as well be pc-relative, but the linker
        *        will have to do the final patch in that case) */
       fragP->fr_opcode[1] |= 0x2c;  /* (a4) */
       fix_new (fragP, fragP->fr_fix, 2, fragP->fr_symbol, fragP->fr_offset, 0, NO_RELOC, 1);
+#endif
       break;
     case TAB (ABSREL, LONG):
       as_bad (_("ABSREL_LONG: sorry, not supported."));
       break;
     case TAB (IMMREL, BYTE):
       as_bad (_("IMMREL_BYTE: how the ** does this look??"));
       break;
     case TAB (IMMREL, SHORT):
+      as_bad (_("IMMREL_SHORT: sorry, not supported. See " __FILE__));
+#if 0
       if (S_GET_TYPE (fragP->fr_symbol) == N_TEXT)
 	{
 	/* we can only fix operations on data registers, not on <ea> */
 	if ((fragP->fr_opcode[1] & 0x38) != 0)
 	  {
 	    /* use the normal reloc32, sigh... */
@@ -5415,12 +5420,13 @@ md_convert_frag_1 (fragS *fragP)
        *     addl a4,d0
        */
 
       fix_new (fragP, fragP->fr_fix, 4, fragP->fr_symbol, fragP->fr_offset, 0, NO_RELOC, 1);
       *buffer_address++ = 0xd0;
       *buffer_address++ = 0x8c;
+#endif
       break;
     }
   if (fixP)
     {
       fixP->fx_file = fragP->fr_file;
       fixP->fx_line = fragP->fr_line;
@@ -8302,13 +8308,13 @@ m68k_elf_cons (int nbytes /* 4=.long */)
 
 	      p = frag_more (nbytes);
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
-- 
2.11.0

