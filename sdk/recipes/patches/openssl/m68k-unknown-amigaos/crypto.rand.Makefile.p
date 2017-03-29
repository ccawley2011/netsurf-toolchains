--- crypto/rand/Makefile	2017-03-29 18:44:57.752006689 +0100
+++ crypto/rand/Makefile	2017-03-29 18:45:23.976006610 +0100
@@ -18,9 +18,9 @@ APPS=
 
 LIB=$(TOP)/libcrypto.a
 LIBSRC=md_rand.c randfile.c rand_lib.c rand_err.c rand_egd.c \
-	rand_win.c rand_unix.c rand_os2.c rand_nw.c
+	rand_win.c rand_unix.c rand_os2.c rand_nw.c rand_amiga.c
 LIBOBJ=md_rand.o randfile.o rand_lib.o rand_err.o rand_egd.o \
-	rand_win.o rand_unix.o rand_os2.o rand_nw.o
+	rand_win.o rand_unix.o rand_os2.o rand_nw.o rand_amiga.o
 
 SRC= $(LIBSRC)

