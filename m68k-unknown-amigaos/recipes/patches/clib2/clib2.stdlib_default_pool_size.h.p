--- builddir/clib2/stdlib_default_pool_size.c	2015-04-24 15:00:24.000000000 +0100
+++ stdlib_default_pool_size.c	2016-02-27 11:30:52.124018382 +0000
@@ -37,4 +37,4 @@
 
 /****************************************************************************/
 
-int NOCOMMON __default_pool_size = 4096;
+int NOCOMMON __default_pool_size = 16384;
