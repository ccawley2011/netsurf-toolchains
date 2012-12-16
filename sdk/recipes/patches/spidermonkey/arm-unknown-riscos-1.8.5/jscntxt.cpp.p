--- js/src/jscntxt.cpp.orig	2012-11-08 14:49:30.000000000 +0000
+++ js/src/jscntxt.cpp	2012-11-08 14:50:19.000000000 +0000
@@ -179,7 +179,7 @@
 #elif defined(XP_OS2)
     DosFreeMem(base);
 #else
-#ifdef SOLARIS
+#if defined(SOLARIS) || defined(__riscos__)
     munmap((caddr_t)base, CAPACITY_BYTES);
 #else
     munmap(base, CAPACITY_BYTES);
