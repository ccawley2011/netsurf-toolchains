--- js/src/Makefile.ref.orig	2006-07-26 20:16:47.000000000 +0100
+++ js/src/Makefile.ref	2012-12-16 12:32:02.331547000 +0000
@@ -305,7 +305,7 @@
 $(OBJDIR)/jskwgen.$(OBJ_SUFFIX): jskwgen.c jskeyword.tbl

 $(OBJDIR)/jsautokw.h: $(OBJDIR)/jskwgen$(HOST_BIN_SUFFIX) jskeyword.tbl
-	$(OBJDIR)/jskwgen$(HOST_BIN_SUFFIX) $@
+#	$(OBJDIR)/jskwgen$(HOST_BIN_SUFFIX) $@

 ifdef USE_MSVC

@@ -349,8 +349,8 @@
 $(HFILES) $(CFILES): $(OBJDIR)/jsautocfg.h

 $(OBJDIR)/jsautocfg.h: $(OBJDIR)/jscpucfg
-	rm -f $@
-	$(OBJDIR)/jscpucfg > $@
+#	rm -f $@
+#	$(OBJDIR)/jscpucfg > $@

 $(OBJDIR)/jscpucfg: $(OBJDIR)/jscpucfg.o
 	$(CC) -o $@ $(OBJDIR)/jscpucfg.o
--- js/src/editline/Makefile.ref.orig	2005-02-12 20:10:33.000000000 +0000
+++ js/src/editline/Makefile.ref	2012-12-16 12:36:54.983350000 +0000
@@ -103,7 +103,7 @@
 LIBRARY = $(OBJDIR)/libedit.a

 define MAKE_OBJDIR
-if test ! -d $(@D); then rm -rf $(@D); mkdir $(@D); fi
+if test ! -d $(@D); then rm -rf $(@D); mkdir -p $(@D); fi
 endef

 all: $(LIBRARY)
