--- js/src/jstypedarray.cpp.orig	2012-11-08 16:22:50.000000000 +0000
+++ js/src/jstypedarray.cpp	2012-11-08 16:23:25.000000000 +0000
@@ -454,7 +454,7 @@
     inline operator uint8() const {
         return val;
     }
-};
+} __attribute__((packed));

 /* Make sure the compiler isn't doing some funky stuff */
 JS_STATIC_ASSERT(sizeof(uint8_clamped) == 1);
