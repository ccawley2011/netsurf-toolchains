--- src/H_Pal.h.orig	2012-11-07 23:02:21.000000000 +0100
+++ src/H_Pal.h	2012-11-07 23:05:47.000000000 +0100
@@ -21,7 +21,7 @@
 /* Get a handle for a palette to work with. This allocates memory for an
    internal palette. Returns 0 if failed.
 */
-HERMES_C HermesHandle HERMES_API Hermes_PaletteInstance();
+HERMES_C HermesHandle HERMES_API Hermes_PaletteInstance(void);
 
 
 /*
