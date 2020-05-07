--- lib/hostip4.c	2020-01-05 09:50:51.000000000 +0000
+++ lib/hostip4.c	2020-05-07 16:02:59.313823259 +0100
@@ -120,6 +120,10 @@ Curl_addrinfo *Curl_getaddrinfo(struct c
  * implying that only threadsafe code and function calls may be used.
  *
  */
+#ifdef __amigaos4__
+#include <proto/exec.h>
+#include <proto/bsdsocket.h>
+#endif
 Curl_addrinfo *Curl_ipv4_resolve_r(const char *hostname,
                                    int port)
 {
@@ -130,6 +134,9 @@ Curl_addrinfo *Curl_ipv4_resolve_r(const
   struct hostent *h = NULL;
   struct in_addr in;
   struct hostent *buf = NULL;
+#ifdef __amigaos4__
+  struct SocketIFace *ISocket = NULL;
+#endif
 
 #ifdef ENABLE_IPV6
   {
@@ -302,7 +309,20 @@ Curl_addrinfo *Curl_ipv4_resolve_r(const
      * gethostbyname() is the preferred one.
      */
   else {
+#ifdef __amigaos4__
+    struct Library *SocketBase = IExec->OpenLibrary("bsdsocket.library", 4);
+    if (SocketBase)
+    {
+       ISocket = (struct SocketIFace *)IExec->GetInterface(SocketBase, "main", 1, NULL);
+    }
+
+    if (ISocket)
+    {
+       h = ISocket->gethostbyname((void*)hostname);
+    }
+#else  
     h = gethostbyname((void *)hostname);
+#endif
 #endif /* HAVE_GETADDRINFO_THREADSAFE || HAVE_GETHOSTBYNAME_R */
   }
 
@@ -312,7 +332,14 @@ Curl_addrinfo *Curl_ipv4_resolve_r(const
     if(buf) /* used a *_r() function */
       free(buf);
   }
-
+#ifdef __amigaos4__
+  if (ISocket)
+  {
+     struct Library *SocketBase = ISocket->Data.LibBase;
+     IExec->DropInterface((struct Interface *)ISocket);
+     IExec->CloseLibrary(SocketBase);
+  }
+#endif 
   return ai;
 }
 #endif /* defined(CURLRES_IPV4) && !defined(CURLRES_ARES) */
