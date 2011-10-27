Index: Tools/DefMod2/assembler.c
===================================================================
--- Tools/DefMod2/assembler.c	(revision 402)
+++ Tools/DefMod2/assembler.c	(working copy)
@@ -880,8 +880,8 @@
    if (DoELF)
    {
        /* Define size of function body.  */
-       sprintf (s2, ". - %s", c_name + (!nonx? 1: 0));
-       if ((rc = Emit2 (file, ".size", c_name + (!nonx? 1: 0), s2)) < 0)
+       sprintf (s2, ". - %s", c_name);
+       if ((rc = Emit2 (file, ".size", c_name, s2)) < 0)
          goto finish;
    }
 
