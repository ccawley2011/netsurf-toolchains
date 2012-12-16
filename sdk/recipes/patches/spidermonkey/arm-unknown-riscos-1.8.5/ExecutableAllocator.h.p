--- js/src/assembler/jit/ExecutableAllocator.h.orig	2012-11-08 14:37:17.000000000 +0000
+++ js/src/assembler/jit/ExecutableAllocator.h	2012-11-08 14:46:42.000000000 +0000
@@ -370,7 +370,7 @@
     }
 #elif WTF_CPU_ARM_TRADITIONAL && WTF_PLATFORM_LINUX && WTF_COMPILER_RVCT
     static __asm void cacheFlush(void* code, size_t size);
-#elif WTF_CPU_ARM_TRADITIONAL && (WTF_PLATFORM_LINUX || WTF_PLATFORM_ANDROID) && WTF_COMPILER_GCC
+#elif WTF_CPU_ARM_TRADITIONAL && (WTF_PLATFORM_LINUX || WTF_PLATFORM_ANDROID || WTF_PLATFORM_RISCOS) && WTF_COMPILER_GCC
     static void cacheFlush(void* code, size_t size)
     {
         asm volatile (
