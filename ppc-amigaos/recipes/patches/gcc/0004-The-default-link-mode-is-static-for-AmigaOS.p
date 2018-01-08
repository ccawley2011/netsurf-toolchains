From 0a073e9854a2f5b558631929467837cec073d624 Mon Sep 17 00:00:00 2001
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Wed, 2 Dec 2015 20:56:33 +0100
Subject: [PATCH 4/9] The default link mode is static for AmigaOS.

Changed the g++ driver to reflect this.
---
 gcc/cp/g++spec.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/gcc/cp/g++spec.c b/gcc/cp/g++spec.c
index 03cbde090cb361f7f6244c97a91c8ad567d9a092..c8dec4b7a0ad1d95811dd9a50a7916e3b4c76336 100644
--- a/gcc/cp/g++spec.c
+++ b/gcc/cp/g++spec.c
@@ -101,14 +101,14 @@ lang_specific_driver (struct cl_decoded_option **in_decoded_options,
   /* By default, we throw on the math library if we have one.  */
   int need_math = (MATH_LIBRARY[0] != '\0');
 
   /* By default, we throw on the time library if we have one.  */
   int need_time = (TIME_LIBRARY[0] != '\0');
 
-  /* True if we saw -static.  */
-  int static_link = 0;
+  /* False if we saw -shared.  */
+  int static_link = 1;
 
   /* True if we should add -shared-libgcc to the command-line.  */
   int shared_libgcc = 1;
 
   /* The total number of arguments with the new stuff.  */
   unsigned int argc;
@@ -195,12 +195,16 @@ lang_specific_driver (struct cl_decoded_option **in_decoded_options,
 	  break;
 
 	case OPT_static:
 	  static_link = 1;
 	  break;
 
+	case OPT_shared:
+	  static_link = 0;
+	  break;
+
 	case OPT_static_libgcc:
 	  shared_libgcc = 0;
 	  break;
 
 	case OPT_static_libstdc__:
 	  library = library >= 0 ? 2 : library;
-- 
1.9.1

