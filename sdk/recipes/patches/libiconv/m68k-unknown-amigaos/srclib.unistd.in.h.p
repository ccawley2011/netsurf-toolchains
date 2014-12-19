--- srclib/unistd.in.h.orig	2014-01-15 01:06:20.525844246 +0000
+++ srclib/unistd.in.h	2014-01-15 01:06:48.717471325 +0000
@@ -1145,40 +1145,6 @@
 #endif
 
 
-#if @GNULIB_READLINK@
-/* Read the contents of the symbolic link FILE and place the first BUFSIZE
-   bytes of it into BUF.  Return the number of bytes placed into BUF if
-   successful, otherwise -1 and errno set.
-   See the POSIX:2001 specification
-   <http://www.opengroup.org/susv3xsh/readlink.html>.  */
-# if @REPLACE_READLINK@
-#  if !(defined __cplusplus && defined GNULIB_NAMESPACE)
-#   define readlink rpl_readlink
-#  endif
-_GL_FUNCDECL_RPL (readlink, ssize_t,
-                  (const char *file, char *buf, size_t bufsize)
-                  _GL_ARG_NONNULL ((1, 2)));
-_GL_CXXALIAS_RPL (readlink, ssize_t,
-                  (const char *file, char *buf, size_t bufsize));
-# else
-#  if !@HAVE_READLINK@
-_GL_FUNCDECL_SYS (readlink, ssize_t,
-                  (const char *file, char *buf, size_t bufsize)
-                  _GL_ARG_NONNULL ((1, 2)));
-#  endif
-_GL_CXXALIAS_SYS (readlink, ssize_t,
-                  (const char *file, char *buf, size_t bufsize));
-# endif
-_GL_CXXALIASWARN (readlink);
-#elif defined GNULIB_POSIXCHECK
-# undef readlink
-# if HAVE_RAW_DECL_READLINK
-_GL_WARN_ON_USE (readlink, "readlink is unportable - "
-                 "use gnulib module readlink for portability");
-# endif
-#endif
-
-
 #if @GNULIB_READLINKAT@
 # if !@HAVE_READLINKAT@
 _GL_FUNCDECL_SYS (readlinkat, ssize_t,
