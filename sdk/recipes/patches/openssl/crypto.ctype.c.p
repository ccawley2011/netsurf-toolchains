--- crypto/ctype.c.orig 2022-05-27 00:00:00.000000000 +0000
--- crypto/ctype.c      2022-05-27 00:00:00.000000000 +0000
@@ -295,7 +295,7 @@
 /* str[n]casecmp_l is defined in POSIX 2008-01. Value is taken accordingly
  * https://www.gnu.org/software/libc/manual/html_node/Feature-Test-Macros.html */
 
-#if (defined OPENSSL_SYS_WINDOWS) || (defined(_POSIX_C_SOURCE) && _POSIX_C_SOURCE >= 200809L)
+#if (defined OPENSSL_SYS_WINDOWS) || (defined(_POSIX_C_SOURCE) && _POSIX_C_SOURCE >= 200809L && !defined(OPENSSL_SYS_RISCOS))
 
 # if defined OPENSSL_SYS_WINDOWS
 # define locale_t _locale_t
