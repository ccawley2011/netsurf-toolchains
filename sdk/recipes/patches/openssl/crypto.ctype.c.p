--- crypto/ctype.c.orig	2022-05-03 14:32:01.000000000 +0100
+++ crypto/ctype.c	2022-06-10 23:51:44.458533541 +0100
@@ -295,7 +295,7 @@
 /* str[n]casecmp_l is defined in POSIX 2008-01. Value is taken accordingly
  * https://www.gnu.org/software/libc/manual/html_node/Feature-Test-Macros.html */
 
-#if (defined OPENSSL_SYS_WINDOWS) || (defined(_POSIX_C_SOURCE) && _POSIX_C_SOURCE >= 200809L)
+#if (!defined OPENSSL_SYS_WINDOWS) && (defined(_POSIX_C_SOURCE) && _POSIX_C_SOURCE >= 200809L)
 
 # if defined OPENSSL_SYS_WINDOWS
 # define locale_t _locale_t
