--- ./include/windom.h.orig	2012-11-07 22:35:46.000000000 +0100
+++ ./include/windom.h	2012-11-07 22:39:06.000000000 +0100
@@ -594,27 +594,22 @@
 }
 
 static inline int ObjcAttachVar( int mode, WINDOW *win, int __index, int *var, int value_when_selected ) {
-	int mt_ObjcAttach ( APPvar *, int, WINDOW *, int, int, ...);
 	return mt_ObjcAttach( gl_appvar, mode, win, __index, BIND_VAR, var, value_when_selected);
 }
 
 static inline int ObjcAttachBit( int mode, WINDOW *win, int __index, int *var, int bit ) {
-	int mt_ObjcAttach ( APPvar *, int, WINDOW *, int, int, ...);
 	return mt_ObjcAttach( gl_appvar, mode, win, __index, BIND_BIT, var, bit);
 }
 
 static inline int ObjcAttachFormFunc( WINDOW *win, int __index, func_bind fn, void *data ) {
-	int mt_ObjcAttach ( APPvar *, int, WINDOW *, int, int, ...);
 	return mt_ObjcAttach( gl_appvar, OC_FORM, win, __index, BIND_FUNC, fn, data);
 }
 
 static inline int ObjcAttachTBFunc( WINDOW *win, int __index, func_bind fn, void *data ) {
-	int mt_ObjcAttach ( APPvar *, int, WINDOW *, int, int, ...);
 	return mt_ObjcAttach( gl_appvar, OC_TOOLBAR, win, __index, BIND_FUNC, fn, data);
 }
 
 static inline int ObjcAttachMenuFunc( WINDOW *win, int __index, func_bindmenu fn, void *data ) {
-	int mt_ObjcAttach ( APPvar *, int, WINDOW *, int, int, ...);
 	return mt_ObjcAttach( gl_appvar, OC_MENU, win, __index, BIND_FUNC, fn, data);
 }
 
