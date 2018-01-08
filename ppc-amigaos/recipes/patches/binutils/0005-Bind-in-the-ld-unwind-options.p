From ce074fe73deeb899bf1cd863092c174034f56e67 Mon Sep 17 00:00:00 2001
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Thu, 22 Oct 2015 09:48:26 +0200
Subject: [PATCH 5/8] Bind in the ld unwind options.

---
 ld/emulparams/amigaos.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ld/emulparams/amigaos.sh b/ld/emulparams/amigaos.sh
index 605b81e76bcbbd2322561d7d9502190dc7c00674..2661d4ddcd1c5ecab9adea84af7f7d0ba054aa95 100644
--- a/ld/emulparams/amigaos.sh
+++ b/ld/emulparams/amigaos.sh
@@ -1,7 +1,9 @@
-#. ${srcdir}/emulparams/elf32ppccommon.sh
+. ${srcdir}/emulparams/elf32ppccommon.sh
+. ${srcdir}/emulparams/plt_unwind.sh
+
 TEMPLATE_NAME=amigaos
 SCRIPT_NAME=amigaos
 OUTPUT_FORMAT="elf32-amigaos"
 MAXPAGESIZE="CONSTANT (MAXPAGESIZE)"
 COMMONPAGESIZE="CONSTANT (COMMONPAGESIZE)"
 ALIGNMENT=16
-- 
2.11.0

