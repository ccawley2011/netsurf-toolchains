From 5e5e0a5505d8e5fc67697f3ab397fa5a39e085cc Mon Sep 17 00:00:00 2001
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Sat, 12 Sep 2015 11:29:01 +0200
Subject: [PATCH 4/8] Print symbol name when an unexpected type was
 encountered.

---
 bfd/elflink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bfd/elflink.c b/bfd/elflink.c
index bcd3add478ab13addffee21b54919afd5cdcd7d6..f10801b99e366ad956faf039401cfcbf0c42aaa1 100644
--- a/bfd/elflink.c
+++ b/bfd/elflink.c
@@ -8801,12 +8801,13 @@ elf_link_output_extsym (struct bfd_hash_entry *bh, void *data)
 
   switch (h->root.type)
     {
     default:
     case bfd_link_hash_new:
     case bfd_link_hash_warning:
+      (*_bfd_error_handler)(_("Unexpected type (%d) of symbol %s"), h->root.type, h->root.root.string);
       abort ();
       return FALSE;
 
     case bfd_link_hash_undefined:
     case bfd_link_hash_undefweak:
       input_sec = bfd_und_section_ptr;
-- 
2.11.0

