--- test/rsa_complex.c.orig	2019-02-14 10:16:06.665734720 +0000
+++ test/rsa_complex.c	2019-02-14 10:16:18.581682332 +0000
@@ -12,11 +12,6 @@
  * The former defines "I" as a macro and earlier versions of the latter use
  * for function arguments.
  */
-#if defined(__STDC_VERSION__)
-# if __STDC_VERSION__ >= 199901L
-#  include <complex.h>
-# endif
-#endif
 #include <openssl/rsa.h>
 #include <stdlib.h>
 
