--- crypto/bio/b_sock2.c.orig	2019-02-15 10:07:24.181612545 +0000
+++ crypto/bio/b_sock2.c	2019-02-15 10:07:15.637654488 +0000
@@ -94,6 +94,7 @@
         }
     }
 
+#if defined(TCP_NODELAY)
     if (options & BIO_SOCK_NODELAY) {
         if (setsockopt(sock, IPPROTO_TCP, TCP_NODELAY, &on, sizeof(on)) != 0) {
             SYSerr(SYS_F_SETSOCKOPT, get_last_socket_error());
@@ -101,6 +102,7 @@
             return 0;
         }
     }
+#endif
 
     if (connect(sock, BIO_ADDR_sockaddr(addr),
                 BIO_ADDR_sockaddr_size(addr)) == -1) {
@@ -193,6 +195,7 @@
         }
     }
 
+#if defined(TCP_NODELAY)
     if (options & BIO_SOCK_NODELAY) {
         if (setsockopt(sock, IPPROTO_TCP, TCP_NODELAY, &on, sizeof(on)) != 0) {
             SYSerr(SYS_F_SETSOCKOPT, get_last_socket_error());
@@ -200,6 +203,7 @@
             return 0;
         }
     }
+#endif
 
 # ifdef IPV6_V6ONLY
     if (BIO_ADDR_family(addr) == AF_INET6) {
