--- include/sys/types.h	2010-12-29 00:58:25.000000000 +0000
+++ include/sys/types.h	2010-12-29 01:01:33.000000000 +0000
@@ -65,6 +65,15 @@
 
 /****************************************************************************/
 
+/* BSD types */
+#ifndef __u_char_defined
+typedef unsigned char u_char;
+typedef unsigned short int u_short;
+typedef unsigned int u_int;
+typedef unsigned long u_long;
+#define __u_char_defined
+#endif
+
 typedef char * caddr_t;
 typedef unsigned int comp_t;
 typedef unsigned long dev_t;
