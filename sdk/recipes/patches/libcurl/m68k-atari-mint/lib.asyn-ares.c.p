--- lib/asyn-ares.c	2012-10-19 21:37:45.000000000 +0100
+++ lib/asyn-ares.c	2012-10-19 21:38:09.000000000 +0100
@@ -669,7 +669,7 @@
 CURLcode Curl_set_dns_local_ip6(struct SessionHandle *data,
                                 const char *local_ip6)
 {
-#if (ARES_VERSION >= 0x010704)
+#if (ARES_VERSION >= 0x010704) && defined(ENABLE_IPV6)
   unsigned char a6[INET6_ADDRSTRLEN];
 
   if((!local_ip6) || (local_ip6[0] == 0)) {
