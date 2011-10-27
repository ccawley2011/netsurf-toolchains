Index: recipe/files/gcc/libunixlib/sys/stackalloc.c
===================================================================
--- recipe/files/gcc/libunixlib/sys/stackalloc.c	(revision 5392)
+++ recipe/files/gcc/libunixlib/sys/stackalloc.c	(working copy)
@@ -326,9 +326,36 @@
 void
 __stackalloc_init (void)
 {
-  /* The initial stack chunk is set up in _syslib.s
-     __ul_memory.stack points 8 bytes below the base of the initial chunk
-     There are also 8 bytes spare above the initial chunk */
+  /* The stack is set up in _syslib.s as follows:
+   *
+   * appspace_himem   -------------
+   *                     8 bytes    - <-- dummytopblock
+   * Signalhandler SP ------------- -
+   *                                 \
+   *                                  \
+   *                   3584 bytes      \
+   *                                    \
+   *                                     } Signal handler chunk (4k)
+   * Signalhandler SL -------------     /
+   *                                   /
+   *                    512 bytes     /
+   *                                 /
+   *                  ------------- -
+   *                     8 bytes    - <-- signalhandlerblock (avoid!)
+   * Initial SP       ------------- -
+   *                                 \
+   *                                  \
+   *                   3560 bytes      \
+   *                                    \
+   *                                     } Initial chunk (4k)
+   * Initial SL       -------------     /
+   *                                   /
+   *                    536 bytes     /
+   *                                 /
+   *                  ------------- -
+   *                     8 bytes    - <-- initialblock
+   * __ulmemory.stack -------------
+   */
 
 #ifdef DEBUG
   debug_printf ("-- stackalloc_init: stack=%08x  appspace_himem=%08x  "
@@ -350,9 +377,14 @@
   dummybottomblock = initialblock - 1;
   dummybottomblock->startofcon = NULL;
 
+  /* Initialise the signal handler block */
   dummytopblock = initialblock + 1;
   dummytopblock->size = 1;
+  dummytopblock->startofcon = NULL;
 
+  dummytopblock += 1;
+  dummytopblock->size = 1;
+
   freelist = NULL;
 }
 
Index: recipe/files/gcc/libunixlib/sys/_syslib.s
===================================================================
--- recipe/files/gcc/libunixlib/sys/_syslib.s	(revision 5392)
+++ recipe/files/gcc/libunixlib/sys/_syslib.s	(working copy)
@@ -142,10 +142,11 @@
 	@ in a dynamic area because GCC might generate trampolines.  In USR32
 	@ mode we could however.
 
-	@ 8 bytes are needed above the initial chunk
+	@ Reserve the top 4K for the signal handler stack
+	@ 8 bytes are needed above the signal handler stack
 	@ for the stackalloc heap
-	@ Reserve the top 4K for the signal handler stack
 	SUB	sp, sp, #8
+
 	STR	sp, [ip, #GBL_SIGNALHANDLER_SP]
 	@ The signal handler stack cannot be extended, so we don't need to
 	@ setup the chunk structure.
@@ -153,6 +154,10 @@
 	ADD	sl, sp, #512
 	STR	sl, [ip, #GBL_SIGNALHANDLER_SL]
 
+	@ Reserve a further 8 bytes above the initial chunk
+	@ for the stackalloc heap
+	SUB	sp, sp, #8
+
 	SUB	a1, sp, #4096
 	ADD	sl, a1, #512 + CHUNK_OVERHEAD
 
