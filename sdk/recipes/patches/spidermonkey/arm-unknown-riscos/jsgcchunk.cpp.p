--- js/src/jsgcchunk.cpp	2012-12-10 00:50:18.369597597 +0000
+++ js/src/jsgcchunk.cpp	2012-12-10 00:51:36.317984488 +0000
@@ -322,13 +322,13 @@
      * We don't use MAP_FIXED here, because it can cause the *replacement*
      * of existing mappings, and we only want to create new mappings.
      */
-    void *p = mmap(addr, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON,
+    void *p = mmap((caddr_t)addr, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON,
                    -1, 0);
     if (p == MAP_FAILED)
         return NULL;
     if (addr && p != addr) {
         /* We succeeded in mapping memory, but not in the right place. */
-        JS_ALWAYS_TRUE(munmap(p, size) == 0);
+        JS_ALWAYS_TRUE(munmap((caddr_t)p, size) == 0);
         return NULL;
     }
     return p;
@@ -342,7 +342,7 @@
 #ifdef SOLARIS
     JS_ALWAYS_TRUE(munmap((caddr_t) addr, size) == 0);
 #else
-    JS_ALWAYS_TRUE(munmap(addr, size) == 0);
+    JS_ALWAYS_TRUE(munmap((caddr_t)addr, size) == 0);
 #endif
 }
 
