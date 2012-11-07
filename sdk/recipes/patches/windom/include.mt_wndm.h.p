--- ./include/mt_wndm.h.orig	2012-11-07 22:35:39.000000000 +0100
+++ ./include/mt_wndm.h	2012-11-07 22:38:14.000000000 +0100
@@ -1013,7 +1013,7 @@
 /* Object library */
 /** @addtogroup Object
  * @{ */
-/* int     mt_ObjcAttach      ( APPvar *app, int mode, WINDOW *win, int __index, int type, ...);*/
+int     mt_ObjcAttach      ( APPvar *app, int mode, WINDOW *win, int __index, int type, ...);
 int     mt_ObjcChange      ( APPvar *app, int mode, void *data, int __index, int state, int redraw);
 int     mt_ObjcChar        ( APPvar *app, OBJECT *tree, int idx, int put);
 int     mt_ObjcDrawParent  ( APPvar *app, int mode, void *win, int __index, int parent_depth, int child_depth);
@@ -1055,27 +1055,22 @@
  *  \a value_when_selected if the object is selected.
  */
 static inline int mt_ObjcAttachVar( APPvar *app, int mode, WINDOW *win, int __index, int *var, int value_when_selected ) {
-	int mt_ObjcAttach ( APPvar *, int, WINDOW *, int, int, ...);
 	return mt_ObjcAttach( app, mode, win, __index, BIND_VAR, var, value_when_selected);
 }
 
 static inline int mt_ObjcAttachBit( APPvar *app, int mode, WINDOW *win, int __index, int *var, int bit ) {
-	int mt_ObjcAttach ( APPvar *, int, WINDOW *, int, int, ...);
 	return mt_ObjcAttach( app, mode, win, __index, BIND_BIT, var, bit);
 }
 
 static inline int mt_ObjcAttachFormFunc( APPvar *app, WINDOW *win, int __index, func_bind fn, void *data ) {
-	int mt_ObjcAttach ( APPvar *, int, WINDOW *, int, int, ...);
 	return mt_ObjcAttach( app, OC_FORM, win, __index, BIND_FUNC, fn, data);
 }
 
 static inline int mt_ObjcAttachTBFunc( APPvar *app, WINDOW *win, int __index, func_bind fn, void *data ) {
-	int mt_ObjcAttach ( APPvar *, int, WINDOW *, int, int, ...);
 	return mt_ObjcAttach( app, OC_TOOLBAR, win, __index, BIND_FUNC, fn, data);
 }
 
 static inline int mt_ObjcAttachMenuFunc( APPvar *app, WINDOW *win, int __index, func_bindmenu fn, void *data ) {
-	int mt_ObjcAttach ( APPvar *, int, WINDOW *, int, int, ...);
 	return mt_ObjcAttach( app, OC_MENU, win, __index, BIND_FUNC, fn, data);
 }
 
