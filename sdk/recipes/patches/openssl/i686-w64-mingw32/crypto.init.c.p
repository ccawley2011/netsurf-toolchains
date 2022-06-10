--- crypto/init.c.orig	2022-06-10 20:39:03.707464637 +0100
+++ crypto/init.c	2022-06-10 20:40:12.843797907 +0100
@@ -124,7 +124,7 @@
 
 #if !defined(OPENSSL_USE_NODELETE) \
     && !defined(OPENSSL_NO_PINSHARED)
-# if defined(DSO_WIN32) && !defined(_WIN32_WCE)
+# if defined(DSO_WIN32) && !defined(_WIN32_WCE) && defined(_WIN32_WINNT) && _WIN32_WINNT >= 0x0501
     {
         HMODULE handle = NULL;
         BOOL ret;
@@ -668,7 +668,7 @@
         } handlersym;
 
         handlersym.func = handler;
-# if defined(DSO_WIN32) && !defined(_WIN32_WCE)
+# if defined(DSO_WIN32) && !defined(_WIN32_WCE) && defined(_WIN32_WINNT) && _WIN32_WINNT >= 0x0501
         {
             HMODULE handle = NULL;
             BOOL ret;
