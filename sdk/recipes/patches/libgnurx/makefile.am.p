--- Makefile.am.orig	1970-01-01 01:00:00.000000000 +0100
+++ Makefile.am	2015-04-26 13:56:54.997424989 +0100
@@ -0,0 +1,8 @@
+lib_LTLIBRARIES = libgnurx.la
+
+libgnurx_la_SOURCES = regex.c
+libgnurx_la_includedir = $(includedir)
+libgnurx_la_include_HEADERS = regex.h
+libgnurx_la_CFLAGS = -I$(top_srcdir)
+libgnurx_la_LDFLAGS = -no-undefined -version-info 0:0:0 -export-dynamic
+
