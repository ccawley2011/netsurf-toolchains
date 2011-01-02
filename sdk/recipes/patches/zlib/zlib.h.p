--- zlib.h.orig	2009-03-27 01:06:27.000000000 +0000
+++ zlib.h	2009-03-27 01:06:50.000000000 +0000
@@ -1571,7 +1571,7 @@
    ZEXTERN uLong ZEXPORT crc32_combine64 OF((uLong, uLong, z_off64_t));
 #endif
 
-#if !defined(ZLIB_INTERNAL) && _FILE_OFFSET_BITS-0 == 64 && _LFS64_LARGEFILE-0
+#if !defined(ZLIB_INTERNAL) && defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS-0 == 64 && _LFS64_LARGEFILE-0
 #  define gzopen gzopen64
 #  define gzseek gzseek64
 #  define gztell gztell64
