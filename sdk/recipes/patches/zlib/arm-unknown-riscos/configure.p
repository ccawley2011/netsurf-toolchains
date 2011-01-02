--- configure.orig	2007-11-07 09:39:25.111922700 +0000
+++ configure	2007-11-07 09:42:47.386922700 +0000
@@ -260,18 +260,18 @@
   TEST="all teststatic testshared"
 fi
 
-cat > $test.c <<EOF
-#include <sys/types.h>
-off64_t dummy = 0;
-EOF
-if test "`($CC -c $CFLAGS -D_LARGEFILE64_SOURCE=1 $test.c) 2>&1`" = ""; then
-  CFLAGS="${CFLAGS} -D_LARGEFILE64_SOURCE=1"
-  SFLAGS="${SFLAGS} -D_LARGEFILE64_SOURCE=1"
-  ALL="${ALL} all64"
-  TEST="${TEST} test64"
-  echo "Checking for off64_t... Yes."
-  echo "Checking for fseeko... Yes."
-else
+#cat > $test.c <<EOF
+##include <sys/types.h>
+#off64_t dummy = 0;
+#EOF
+#if test "`($CC -c $CFLAGS -D_LARGEFILE64_SOURCE=1 $test.c) 2>&1`" = ""; then
+#  CFLAGS="${CFLAGS} -D_LARGEFILE64_SOURCE=1"
+#  SFLAGS="${SFLAGS} -D_LARGEFILE64_SOURCE=1"
+#  ALL="${ALL} all64"
+#  TEST="${TEST} test64"
+#  echo "Checking for off64_t... Yes."
+#  echo "Checking for fseeko... Yes."
+#else
   echo "Checking for off64_t... No."
   cat > $test.c <<EOF
 #include <stdio.h>
@@ -287,7 +287,7 @@
     SFLAGS="${SFLAGS} -DNO_FSEEKO"
     echo "Checking for fseeko... No."
   fi
-fi
+#fi
 
 cp -p zconf.h.in zconf.h
 
