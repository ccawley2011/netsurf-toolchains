--- mozilla/nsprpub/pr/src/pthreads/ptthread.c.orig	2012-12-11 13:03:16.440827000 +0000
+++ mozilla/nsprpub/pr/src/pthreads/ptthread.c	2012-12-11 13:03:42.923932000 +0000
@@ -1651,7 +1651,7 @@
 #endif

     *(void**)(&dynamic_pthread_setname_np) =
-        dlsym(RTLD_DEFAULT, "pthread_setname_np");
+        dlsym(RTLD_GLOBAL, "pthread_setname_np");
     if (!dynamic_pthread_setname_np)
         return PR_SUCCESS;

