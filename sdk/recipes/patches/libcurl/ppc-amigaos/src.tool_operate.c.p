--- src/tool_operate.c	2019-03-30 12:33:41.315465662 +0000
+++ src/tool_operate.c	2019-03-30 12:42:36.643382219 +0000
@@ -1872,7 +1872,7 @@ static CURLcode operate_do(struct Global
           /* Set the url (up to 80 chars) as comment for the file */
           if(strlen(urlnode->url) > 78)
             urlnode->url[79] = '\0';
-          SetComment(outs.filename, urlnode->url);
+          IDOS->SetComment(outs.filename, urlnode->url);
         }
 #endif
 
