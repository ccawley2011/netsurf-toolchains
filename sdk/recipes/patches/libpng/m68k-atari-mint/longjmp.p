--- png.h.orig	2012-08-17 11:28:10.000000000 +0100
+++ png.h	2012-08-17 11:29:27.000000000 +0100
@@ -1040,7 +1040,7 @@
 PNG_EXPORT(8, jmp_buf*, png_set_longjmp_fn, (png_structp png_ptr,
     png_longjmp_ptr longjmp_fn, size_t jmp_buf_size));
 #  define png_jmpbuf(png_ptr) \
-      (*png_set_longjmp_fn((png_ptr), longjmp, sizeof (jmp_buf)))
+      (*png_set_longjmp_fn((png_ptr), siglongjmp, sizeof (jmp_buf)))
 #else
 #  define png_jmpbuf(png_ptr) \
       (LIBPNG_WAS_COMPILED_WITH__PNG_NO_SETJMP)
