--- /home/chris/netsurf/toolchains/sdk/builddir-ppc-amigaos/openssl/openssl-1.0.2k/crypto/ppccap.c	2017-01-26 13:22:03.000000000 +0000
+++ ppccap.c	2017-02-08 17:33:45.674017881 +0000
@@ -73,6 +73,7 @@ void sha512_block_data_order(void *ctx,
         sha512_block_ppc(ctx, inp, len);
 }
 
+#ifndef OPENSSL_SYS_AMIGAOS4
 static sigjmp_buf ill_jmp;
 static void ill_handler(int sig)
 {
@@ -157,3 +158,24 @@ void OPENSSL_cpuid_setup(void)
     sigaction(SIGILL, &ill_oact, NULL);
     sigprocmask(SIG_SETMASK, &oset, NULL);
 }
+#else
+#include <proto/exec.h>
+void OPENSSL_cpuid_setup(void)
+{
+    uint32 family, vec;
+
+    GetCPUInfoTags(GCIT_Family, &family, GCIT_VectorUnit, &vec, TAG_DONE);
+
+    OPENSSL_ppccap_P = PPC_FPU;
+
+    if((family == CPUFAMILY_PA6T) || (family == CPUFAMILY_E5500))
+        OPENSSL_ppccap_P |= PPC_FPU64;
+
+    if((vec == VECTORTYPE_ALTIVEC) &&
+       ((SysBase->lib_Version == 51 && SysBase->lib_Revision >= 12) || SysBase->lib_Version > 51))
+    {
+        OPENSSL_ppccap_P |= PPC_ALTIVEC;
+    }
+}
+#endif
+
