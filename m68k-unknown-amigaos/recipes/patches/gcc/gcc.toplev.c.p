--- gcc-3.4.6/gcc/toplev.c	2013-05-19 20:09:28.000000000 +0200
+++ gcc/toplev.c	2013-05-19 20:23:32.000000000 +0200
@@ -1100,6 +1100,8 @@
   {"branch-count-reg",&flag_branch_on_count_reg, 1 },
   {"pic", &flag_pic, 1 },
   {"PIC", &flag_pic, 2 },
+  {"baserel", &flag_pic, 3 },
+  {"baserel32", &flag_pic, 4 },
   {"pie", &flag_pie, 1 },
   {"PIE", &flag_pie, 2 },
   {"exceptions", &flag_exceptions, 1 },
