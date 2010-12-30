--- sys-include/inline/intuition.h.orig	2006-05-10 18:29:23.000000000 +0100
+++ sys-include/inline/intuition.h	2010-12-30 01:24:28.000000000 +0000
@@ -449,8 +449,10 @@
 	, INTUITION_BASE_NAME)
 
 #ifndef NO_INLINE_STDARG
-__inline APTR NewObject(struct IClass * classPtr, CONST_STRPTR classID, ULONG tagList, ...)
+static __inline APTR NewObject(struct IClass * classPtr, CONST_STRPTR classID, ULONG tagList, ...)
 {
+  extern struct IntuitionBase *INTUITION_BASE_NAME;
+
   return NewObjectA(classPtr, classID, (const struct TagItem *) &tagList);
 }
 
