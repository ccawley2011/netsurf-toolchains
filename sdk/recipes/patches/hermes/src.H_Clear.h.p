--- src/H_Clear.h.orig	2012-11-07 23:02:45.000000000 +0100
+++ src/H_Clear.h	2012-11-07 23:05:47.000000000 +0100
@@ -22,7 +22,7 @@
 /*
    Get a handle for a new clearer instance to work with. Returns 0 if failed.
 */
-HERMES_C HermesHandle HERMES_API Hermes_ClearerInstance();
+HERMES_C HermesHandle HERMES_API Hermes_ClearerInstance(void);
 
 
 /*
