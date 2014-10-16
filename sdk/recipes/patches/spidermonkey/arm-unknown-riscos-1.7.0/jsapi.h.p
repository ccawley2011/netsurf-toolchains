--- js/src/jsapi.h.orig	2014-10-15 16:23:17.799241148 +0100
+++ js/src/jsapi.h	2014-10-15 16:25:08.771240608 +0100
@@ -214,7 +214,7 @@
  * comment in jstypes.h regarding safe int64 usage.
  */
 extern JS_PUBLIC_API(int64)
-JS_Now();
+JS_Now(void);
 
 /* Don't want to export data, so provide accessors for non-inline jsvals. */
 extern JS_PUBLIC_API(jsval)
@@ -971,11 +971,11 @@
     JSEqualityOp        equality;
     JSObjectOp          outerObject;
     JSObjectOp          innerObject;
-    void                (*reserved0)();
-    void                (*reserved1)();
-    void                (*reserved2)();
-    void                (*reserved3)();
-    void                (*reserved4)();
+    void                (*reserved0)(void);
+    void                (*reserved1)(void);
+    void                (*reserved2)(void);
+    void                (*reserved3)(void);
+    void                (*reserved4)(void);
 };
 
 #define JSCLASS_HAS_PRIVATE             (1<<0)  /* objects have private slot */
@@ -1962,7 +1962,7 @@
  * to get UTF-8 support.
  */
 JS_PUBLIC_API(JSBool)
-JS_CStringsAreUTF8();
+JS_CStringsAreUTF8(void);
 
 /*
  * Character encoding support.
