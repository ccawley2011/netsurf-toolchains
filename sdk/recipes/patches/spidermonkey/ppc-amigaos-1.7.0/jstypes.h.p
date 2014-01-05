--- js/src/jstypes.h	2006-08-14 20:32:06 
+++ js-amiga/src/jstypes.h	2012-07-29 12:14:05 
@@ -117,6 +117,21 @@
 #define JS_STATIC_DLL_CALLBACK(__x) __x JS_DLL_CALLBACK
 #endif /* _WINDLL */
 
+#elif defined(XP_AMIGA)
+#ifdef HAVE_VISIBILITY_ATTRIBUTE
+#define JS_EXTERNAL_VIS __attribute__((visibility ("default")))
+#else
+#define JS_EXTERNAL_VIS
+#endif
+
+#define JS_EXTERN_API(__type) extern __type
+#define JS_EXPORT_API(__type) __type
+#define JS_EXTERN_DATA(__type) extern __type
+#define JS_EXPORT_DATA(__type) __type
+
+#define JS_DLL_CALLBACK
+#define JS_STATIC_DLL_CALLBACK(__x) static __x
+
 #else /* Unix */
 
 #ifdef HAVE_VISIBILITY_ATTRIBUTE
@@ -241,11 +256,11 @@
 
 #if (defined(XP_WIN) && !defined(CROSS_COMPILE)) || defined (WINCE)
 #    include "jscpucfg.h"        /* Use standard Mac or Windows configuration */
-#elif defined(XP_UNIX) || defined(XP_BEOS) || defined(XP_OS2) || defined(CROSS_COMPILE)
+#elif defined(XP_UNIX) || defined(XP_AMIGA) || defined(XP_BEOS) || defined(XP_OS2) || defined(CROSS_COMPILE)
 #    include "jsautocfg.h"       /* Use auto-detected configuration */
 #    include "jsosdep.h"         /* ...and platform-specific flags */
 #else
-#    error "Must define one of XP_BEOS, XP_OS2, XP_WIN or XP_UNIX"
+#    error "Must define one of XP_BEOS, XP_OS2, XP_AMIGA, XP_WIN or XP_UNIX"
 #endif
 
 JS_BEGIN_EXTERN_C

