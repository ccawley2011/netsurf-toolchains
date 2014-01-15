Origin: https://github.com/bagder/curl/commit/2d435c7fb5b7691e8ca1f3052e1eb5bcd8a4ea27.diff

diff --git a/lib/connect.c b/lib/connect.c
index 33f7aec..05666eb 100644
--- lib/connect.c
+++ lib/connect.c
@@ -5,7 +5,7 @@
  *                            | (__| |_| |  _ <| |___
  *                             \___|\___/|_| \_\_____|
  *
- * Copyright (C) 1998 - 2013, Daniel Stenberg, <daniel@haxx.se>, et al.
+ * Copyright (C) 1998 - 2014, Daniel Stenberg, <daniel@haxx.se>, et al.
  *
  * This software is licensed as described in the file COPYING, which
  * you should have received as part of this distribution. The terms
@@ -556,7 +556,11 @@ static CURLcode trynextip(struct connectdata *conn,
     else {
       /* happy eyeballs - try the other protocol family */
       int firstfamily = conn->tempaddr[0]->ai_family;
+#ifdef ENABLE_IPV6
       family = (firstfamily == AF_INET) ? AF_INET6 : AF_INET;
+#else
+      family = firstfamily;
+#endif
       ai = conn->tempaddr[0]->ai_next;
     }
 
