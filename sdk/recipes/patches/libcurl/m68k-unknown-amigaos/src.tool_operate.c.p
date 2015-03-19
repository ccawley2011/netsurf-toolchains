--- src/tool_operate.c.orig	2015-02-24 21:49:02.000000000 +0000
+++ src/tool_operate.c	2015-03-19 22:13:50.477958123 +0000
@@ -1620,15 +1620,6 @@
           }
         }
 
-#ifdef __AMIGA__
-        if(!result && outs.s_isreg && outs.filename) {
-          /* Set the url (up to 80 chars) as comment for the file */
-          if(strlen(url) > 78)
-            url[79] = '\0';
-          SetComment(outs.filename, url);
-        }
-#endif
-
 #ifdef HAVE_UTIME
         /* File time can only be set _after_ the file has been closed */
         if(!result && config->remote_time && outs.s_isreg && outs.filename) {
