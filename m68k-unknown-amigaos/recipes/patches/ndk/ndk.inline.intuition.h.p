--- sys-include/inline/intuition.h	2010-12-23 22:23:29.000000000 +0000
+++ sys-include/inline/intuition.h	2010-12-23 22:18:23.000000000 +0000
@@ -449,11 +449,14 @@
 	, INTUITION_BASE_NAME)
 
 #ifndef NO_INLINE_STDARG
-__inline APTR NewObject(struct IClass * classPtr, CONST_STRPTR classID, ULONG tagList, ...)
+static __inline APTR NewObjectI(void *INTUITION_BASE_NAME, struct IClass * classPtr, CONST_STRPTR classID, ULONG tagList, ...)
 {
   return NewObjectA(classPtr, classID, (const struct TagItem *) &tagList);
 }
 
+#define NewObject(classPtr, classID, tagList, ...) \
+	NewObjectI(INTUITION_BASE_NAME, classPtr, classID, tagList, __VA_ARGS__)
+
 #endif
 
 #define DisposeObject(object) \
