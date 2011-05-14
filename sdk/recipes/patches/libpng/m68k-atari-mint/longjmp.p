--- png.h	2010-12-09 13:48:10.000000000 +0000
+++ png.h	2011-05-14 02:12:40.000000000 +0100
@@ -1545,7 +1545,7 @@
    PNGARG((png_structp png_ptr, png_longjmp_ptr longjmp_fn, size_t
        jmp_buf_size));
 #  define png_jmpbuf(png_ptr) \
-   (*png_set_longjmp_fn((png_ptr), longjmp, sizeof (jmp_buf)))
+   (*png_set_longjmp_fn((png_ptr), siglongjmp, sizeof (jmp_buf)))
 #else
 #  define png_jmpbuf(png_ptr) \
    (LIBPNG_WAS_COMPILED_WITH__PNG_NO_SETJMP)
