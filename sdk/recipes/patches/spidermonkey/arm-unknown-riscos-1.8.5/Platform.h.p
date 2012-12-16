--- js/src/assembler/wtf/Platform.h.orig	2011-03-31 20:08:36.000000000 +0100
+++ js/src/assembler/wtf/Platform.h	2012-11-08 14:48:57.000000000 +0000
@@ -188,6 +188,7 @@
 #elif !defined(__ARM_EABI__) \
    && !defined(__EABI__) \
    && !defined(__VFP_FP__) \
+   && !defined(__riscos__) \
    && !defined(ANDROID)
 #define WTF_CPU_MIDDLE_ENDIAN 1

@@ -232,6 +233,7 @@

 #endif

+#ifndef __riscos__
 /* Set WTF_THUMB_ARCH_VERSION */
 #if   defined(__ARM_ARCH_4T__)
 #define WTF_THUMB_ARCH_VERSION 1
@@ -263,6 +265,13 @@
 #define WTF_THUMB_ARCH_VERSION 0
 #endif

+#else
+
+#define WTF_THUMB_ARCH_VERSION 0
+#define WTF_PLATFORM_RISCOS 1
+#define WTF_CPU_ARM_TRADITIONAL 0
+
+#endif

 /* CPU(ARMV5_OR_LOWER) - ARM instruction set v5 or earlier */
 /* On ARMv5 and below the natural alignment is required.
