--- lib/amigaos.c	2019-03-25 08:42:50.000000000 +0000
+++ lib/amigaos.c	2019-03-30 12:49:06.680985341 +0000
@@ -24,7 +24,7 @@
 
 #ifdef __AMIGA__
 #  include "amigaos.h"
-#  if defined(HAVE_PROTO_BSDSOCKET_H) && !defined(USE_AMISSL)
+#  if 0
 #    include <amitcp/socketbasetags.h>
 #  endif
 #  ifdef __libnix__
@@ -37,7 +37,7 @@
 #include "memdebug.h"
 
 #ifdef __AMIGA__
-#if defined(HAVE_PROTO_BSDSOCKET_H) && !defined(USE_AMISSL)
+#if 0
 struct Library *SocketBase = NULL;
 extern int errno, h_errno;
 
