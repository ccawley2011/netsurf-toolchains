Backport upstream workaround for old F5 BIG-IP firmware which
stalls on receipt of ClientHello messages with a record size
in the range [256,511].

Further context:
    https://www.imperialviolet.org/2013/10/07/f5update.html
    http://www.ietf.org/mail-archive/web/tls/current/msg10423.html
    https://tools.ietf.org/html/draft-agl-tls-padding-03

Upstream-Issue: http://rt.openssl.org/Ticket/Display.html?id=2771
X-Git-Url: http://git.openssl.org/gitweb/?p=openssl.git;a=commitdiff_plain;h=0467ea68624450ecece4cde0d5803499aaff19c2
X-Git-Url: http://git.openssl.org/gitweb/?p=openssl.git;a=commitdiff_plain;h=4fcdd66fff5fea0cfa1055c6680a76a4303f28a2

--- ssl/t1_lib.c
+++ ssl/t1_lib.c
@@ -661,6 +661,35 @@ unsigned char *ssl_add_clienthello_tlsext(SSL *s, unsigned char *p, unsigned cha
                 ret += el;
                 }
 #endif
+#ifdef TLSEXT_TYPE_padding
+	/* Add padding to workaround bugs in F5 terminators.
+	 * See https://tools.ietf.org/html/draft-agl-tls-padding-02
+	 *
+	 * NB: because this code works out the length of all existing
+	 * extensions it MUST always appear last.
+	 */
+	{
+	int hlen = ret - (unsigned char *)s->init_buf->data;
+	/* The code in s23_clnt.c to build ClientHello messages includes the
+	 * 5-byte record header in the buffer, while the code in s3_clnt.c does
+	 * not. */
+	if (s->state == SSL23_ST_CW_CLNT_HELLO_A)
+		hlen -= 5;
+	if (hlen > 0xff && hlen < 0x200)
+		{
+		hlen = 0x200 - hlen;
+		if (hlen >= 4)
+			hlen -= 4;
+		else
+			hlen = 0;
+
+		s2n(TLSEXT_TYPE_padding, ret);
+		s2n(hlen, ret);
+		memset(ret, 0, hlen);
+		ret += hlen;
+		}
+	}
+#endif
 
 	if ((extdatalen = ret-p-2)== 0) 
 		return p;
--- ssl/tls1.h
+++ ssl/tls1.h
@@ -248,6 +248,9 @@
 #define TLSEXT_TYPE_next_proto_neg		13172
 #endif
 
+/* See https://tools.ietf.org/html/draft-agl-tls-padding-02 */
+#define TLSEXT_TYPE_padding                    35655
+
 /* NameType value from RFC 3546 */
 #define TLSEXT_NAMETYPE_host_name 0
 /* status request value from RFC 3546 */
