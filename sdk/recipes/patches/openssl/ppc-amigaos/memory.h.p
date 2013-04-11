--- crypto/jpake/jpake.c.orig	2011-03-08 22:19:36.000000000 +0000
+++ crypto/jpake/jpake.c	2011-03-08 22:19:49.000000000 +0000
@@ -3,7 +3,7 @@
 #include <openssl/crypto.h>
 #include <openssl/sha.h>
 #include <openssl/err.h>
-#include <memory.h>
+#include <string.h>
 
 /*
  * In the definition, (xa, xb, xc, xd) are Alice's (x1, x2, x3, x4) or
--- crypto/pkcs7/bio_pk7.c.orig	2011-03-08 22:21:16.000000000 +0000
+++ crypto/pkcs7/bio_pk7.c	2011-03-08 22:21:23.000000000 +0000
@@ -57,7 +57,7 @@
 #include <openssl/bio.h>
 
 #if !defined(OPENSSL_SYSNAME_NETWARE) && !defined(OPENSSL_SYSNAME_VXWORKS)
-#include <memory.h>
+#include <string.h>
 #endif
 #include <stdio.h>
 
