--- src/H_Format.h.orig	2012-11-07 23:02:54.000000000 +0100
+++ src/H_Format.h	2012-11-07 23:05:47.000000000 +0100
@@ -17,7 +17,7 @@
   int32 colorkey;                  /* colorkey, if has_colorkey is 1 */
 } HermesFormat;
 
-HERMES_C HermesFormat* HERMES_API Hermes_FormatNewEmpty();
+HERMES_C HermesFormat* HERMES_API Hermes_FormatNewEmpty(void);
 
 /* Create a new format structure, returns 0 if failed.
 */
