--- js/src/jsnativestack.cpp.orig	2012-11-08 14:53:01.000000000 +0000
+++ js/src/jsnativestack.cpp	2012-11-08 14:53:58.000000000 +0000
@@ -204,7 +204,9 @@
      * FIXME: this function is non-portable;
      * other POSIX systems may have different np alternatives
      */
+#ifndef __riscos__
     pthread_getattr_np(thread, &sattr);
+#endif
 #  endif

     void *stackBase = 0;
@@ -212,7 +214,9 @@
 #  ifdef DEBUG
     int rc =
 #  endif
+#ifndef __riscos__
         pthread_attr_getstack(&sattr, &stackBase, &stackSize);
+#endif
     JS_ASSERT(!rc);
     JS_ASSERT(stackBase);
     pthread_attr_destroy(&sattr);
