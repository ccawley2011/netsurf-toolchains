--- apps/s_socket.c.orig	2019-02-13 18:04:36.643334493 +0000
+++ apps/s_socket.c	2019-02-13 18:04:46.271279170 +0000
@@ -160,6 +160,7 @@
     sock_protocol = BIO_ADDRINFO_protocol(res);
     sock_address = BIO_ADDRINFO_address(res);
     next = BIO_ADDRINFO_next(res);
+#ifdef AF_INET6
     if (sock_family == AF_INET6)
         sock_options |= BIO_SOCK_V6_ONLY;
     if (next != NULL
@@ -174,6 +175,7 @@
             sock_options &= ~BIO_SOCK_V6_ONLY;
         }
     }
+#endif
 
     asock = BIO_socket(sock_family, sock_type, sock_protocol, 0);
     if (asock == INVALID_SOCKET
