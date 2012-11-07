--- src/Hermes.h.orig	2012-11-07 23:02:36.000000000 +0100
+++ src/Hermes.h	2012-11-07 23:05:47.000000000 +0100
@@ -17,11 +17,11 @@
 #include "H_Config.h"
 
 /* Initialise Hermes, returns 0 if failed */
-HERMES_C int  HERMES_API Hermes_Init();
+HERMES_C int  HERMES_API Hermes_Init(void);
 
 
 /* Deinitialise Hermes, returns 0 if failed */
-HERMES_C int HERMES_API Hermes_Done();
+HERMES_C int HERMES_API Hermes_Done(void);
 
 
 #endif
