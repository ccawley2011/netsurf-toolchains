From 035f3afce47e01ee70c7972a71a9dccea2b61e6f Mon Sep 17 00:00:00 2001
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Thu, 3 Dec 2015 23:48:21 +0100
Subject: [PATCH 7/8] Keep symbols for stripped sections. This is important for
 _SDA_BASE_,

---
 binutils/objcopy.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/binutils/objcopy.c b/binutils/objcopy.c
index 4beee77179b85479d5b43507d9eb2a6e0caf384e..8750db51279ec56080aba114cd61780d061b168f 100644
--- a/binutils/objcopy.c
+++ b/binutils/objcopy.c
@@ -1239,13 +1239,23 @@ filter_symbols (bfd *abfd, bfd *obfd, asymbol **osyms,
       if (!keep
 	  && ((keep_file_symbols && (flags & BSF_FILE))
 	      || is_specified_symbol (name, keep_specific_htab)))
 	keep = TRUE;
 
       if (keep && is_strip_section (abfd, bfd_get_section (sym)))
-	keep = FALSE;
+	{
+          /* If the symbol refers to a stripped section, we still want to
+           * keep it, e.g., _SDA_BASE_ TODO: We should perhaps output a
+           * warning or add another option to trigger this behaviour.
+           * FIXME: The section to which symbol refers must be adjusted
+           * as well */
+          if (!is_specified_symbol (name, keep_specific_htab))
+            {
+              keep = FALSE;
+            }
+	}
 
       if (keep)
 	{
 	  if ((flags & BSF_GLOBAL) != 0
 	      && (weaken || is_specified_symbol (name, weaken_specific_htab)))
 	    {
-- 
2.11.0

