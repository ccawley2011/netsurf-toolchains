--- src/tool_operate.c.orig	2019-02-14 14:10:08.086190650 +0000
+++ src/tool_operate.c	2019-02-14 14:10:04.862196063 +0000
@@ -33,6 +33,10 @@
 #  include <fabdef.h>
 #endif
 
+#ifdef __AMIGA__
+#include <proto/dos.h>
+#endif
+
 #include "strcase.h"
 
 #define ENABLE_CURLX_PRINTF
@@ -1856,9 +1860,9 @@
 #ifdef __AMIGA__
         if(!result && outs.s_isreg && outs.filename) {
           /* Set the url (up to 80 chars) as comment for the file */
-          if(strlen(url) > 78)
-            url[79] = '\0';
-          SetComment(outs.filename, url);
+          if(strlen(urlnode->url) > 78)
+            urlnode->url[79] = '\0';
+          /*SetComment(outs.filename, urlnode->url);*/ /* cannot get a header to include that provides this function */
         }
 #endif
 
