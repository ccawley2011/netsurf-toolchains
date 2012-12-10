--- js/src/assembler/jit/ExecutableAllocatorPosix.cpp.orig	2012-11-08 16:02:56.000000000 +0000
+++ js/src/assembler/jit/ExecutableAllocatorPosix.cpp	2012-11-08 15:34:03.000000000 +0000
@@ -25,7 +25,7 @@

 #include "ExecutableAllocator.h"

-#if ENABLE_ASSEMBLER && WTF_PLATFORM_UNIX && !WTF_PLATFORM_SYMBIAN
+#if ENABLE_ASSEMBLER && (WTF_PLATFORM_UNIX || WTF_PLATFORM_RISCOS) && !WTF_PLATFORM_SYMBIAN

 #include <sys/mman.h>
 #include <unistd.h>
