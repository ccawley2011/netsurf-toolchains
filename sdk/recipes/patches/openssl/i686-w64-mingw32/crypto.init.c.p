--- crypto/init.c.orig	2022-11-01 14:14:36.000000000 +0000
+++ crypto/init.c	2022-11-04 19:05:19.666957832 +0000
@@ -131,7 +131,7 @@
 
 #if !defined(OPENSSL_USE_NODELETE) \
     && !defined(OPENSSL_NO_PINSHARED)
-# if defined(DSO_WIN32) && !defined(_WIN32_WCE)
+# if defined(DSO_WIN32) && !defined(_WIN32_WCE) && defined(_WIN32_WINNT) && _WIN32_WINNT >= 0x0501
     {
         HMODULE handle = NULL;
         BOOL ret;
@@ -659,7 +659,7 @@
 #if !defined(OPENSSL_USE_NODELETE)\
     && !defined(OPENSSL_NO_PINSHARED)
     {
-# if defined(DSO_WIN32) && !defined(_WIN32_WCE)
+# if defined(DSO_WIN32) && !defined(_WIN32_WCE) && defined(_WIN32_WINNT) && _WIN32_WINNT >= 0x0501
         HMODULE handle = NULL;
         BOOL ret;
         union {
