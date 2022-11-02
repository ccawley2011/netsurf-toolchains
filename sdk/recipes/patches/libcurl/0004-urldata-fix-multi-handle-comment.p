diff --git a/lib/urldata.h b/lib/urldata.h
index f5bd5a3e9..aba07c275 100644
--- lib/urldata.h
+++ lib/urldata.h
@@ -1531,7 +1531,7 @@ struct UrlState {
  * Character pointer fields point to dynamic storage, unless otherwise stated.
  */
 
-struct Curl_multi;    /* declared and used only in multi.c */
+struct Curl_multi;    /* declared in multihandle.c */
 
 /*
  * This enumeration MUST not use conditional directives (#ifdefs), new
-- 
2.34.1

