--- src/tool_operate.c.old	2012-10-19 21:42:57.000000000 +0100
+++ src/tool_operate.c	2012-10-19 21:43:27.000000000 +0100
@@ -1598,15 +1598,6 @@
           }
         }
 
-#ifdef __AMIGA__
-        if(!res && outs.s_isreg && outs.filename) {
-          /* Set the url (up to 80 chars) as comment for the file */
-          if(strlen(url) > 78)
-            url[79] = '\0';
-          SetComment(outs.filename, url);
-        }
-#endif
-
 #ifdef HAVE_UTIME
         /* File time can only be set _after_ the file has been closed */
         if(!res && config->remote_time && outs.s_isreg && outs.filename) {
