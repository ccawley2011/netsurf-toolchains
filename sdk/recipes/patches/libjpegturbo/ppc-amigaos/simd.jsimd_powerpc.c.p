--- simd/jsimd_powerpc.c
+++ simd/jsimd_powerpc.c
@@ -14,6 +14,10 @@
  * PowerPC architecture.
  */
 
+#ifdef __amigaos4__
+#include <proto/exec.h>
+#endif
+
 #define JPEG_INTERNALS
 #include "../jinclude.h"
 #include "../jpeglib.h"
@@ -116,6 +120,11 @@ init_simd (void)
     if (bufsize > SOMEWHAT_SANE_PROC_CPUINFO_SIZE_LIMIT)
       break;
   }
+#elif defined(__amigaos4__)
+  uint32 altivec = 0;
+  IExec->GetCPUInfoTags(GCIT_VectorUnit, &altivec, TAG_DONE);
+  if(altivec == VECTORTYPE_ALTIVEC)
+    simd_support |= JSIMD_ALTIVEC;
 #endif
 
   /* Force different settings through environment variables */

