--- apps/lib/opt.c.orig	2017-11-22 08:42:07.605882648 +0000
+++ apps/lib/opt.c	2017-11-22 08:48:31.712843519 +0000
@@ -564,6 +564,11 @@
     defined(INTMAX_MAX) && defined(UINTMAX_MAX) && \
     !defined(OPENSSL_NO_INTTYPES_H)
 
+#if defined(OPENSSL_SYS_AMIGAOS3) || defined(OPENSSL_SYS_AMIGAOS4)
+# define strtoimax strtol
+# define strtoumax strtoul
+#endif
+
 /* Parse an intmax_t, put it into *result; return 0 on failure, else 1. */
 int opt_intmax(const char *value, ossl_intmax_t *result)
 {
