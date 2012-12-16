--- js/src/Makefile.in.orig	2012-12-16 13:10:27.000000000 +0000
+++ js/src/Makefile.in	2012-12-16 13:10:59.000000000 +0000
@@ -878,7 +878,7 @@
 install:: $(LIBRARY) $(SHARED_LIBRARY) $(IMPORT_LIBRARY)
 ifneq (,$(LIBRARY))
 	$(SYSINSTALL) $(LIBRARY) $(DESTDIR)$(libdir)
-	mv -f $(DESTDIR)$(libdir)/$(LIBRARY) $(subst $(STATIC_LIBRARY_NAME),mozjs185-$(SRCREL_ABI_VERSION),$(DESTDIR)$(libdir)/$(LIBRARY))
+	mv -f $(DESTDIR)$(libdir)/$(LIBRARY) $(subst $(STATIC_LIBRARY_NAME),mozjs185,$(DESTDIR)$(libdir)/$(LIBRARY))
 endif
 ifneq (,$(SHARED_LIBRARY))
 ifeq (,$(HOST_BIN_SUFFIX))
@@ -968,7 +968,8 @@
 # Needed to "configure" it correctly.  Unfortunately these
 # flags wind up being applied to all code in js/src, not just
 # the code in js/src/assembler.
-CXXFLAGS += -DUSE_SYSTEM_MALLOC=1 -DENABLE_ASSEMBLER=1 -DENABLE_JIT=1
+CXXFLAGS += -DUSE_SYSTEM_MALLOC=1 
+#-DENABLE_ASSEMBLER=1 -DENABLE_JIT=1
 
 INCLUDES +=	-I$(srcdir)/assembler -I$(srcdir)/yarr
 
