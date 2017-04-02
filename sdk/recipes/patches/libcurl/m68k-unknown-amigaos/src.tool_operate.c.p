--- src/tool_operate.c	2017-02-23 22:14:58.000000000 +0000
+++ src/tool_operate.c	2017-03-26 23:54:19.624614960 +0100
@@ -1742,15 +1742,6 @@ static CURLcode operate_do(struct Global
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
 #if defined(HAVE_UTIME) || \
     (defined(WIN32) && (CURL_SIZEOF_CURL_OFF_T >= 8))
         /* File time can only be set _after_ the file has been closed */
