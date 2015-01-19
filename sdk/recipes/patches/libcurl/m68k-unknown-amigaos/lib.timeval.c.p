--- lib/timeval.c.orig	2015-01-19 18:31:02.436021392 +0000
+++ lib/timeval.c	2015-01-19 18:30:53.552021418 +0000
@@ -110,7 +110,7 @@ struct timeval curlx_tvnow(void)
 long curlx_tvdiff(struct timeval newer, struct timeval older)
 {
   return (newer.tv_sec-older.tv_sec)*1000+
-    (newer.tv_usec-older.tv_usec)/1000;
+    (long)(newer.tv_usec-older.tv_usec)/1000;
 }
 
 /*
