--- js/src/rules.mk.orig	2012-12-16 18:31:06.000000000 +0000
+++ js/src/rules.mk	2012-12-16 18:34:05.000000000 +0000
@@ -58,7 +58,7 @@
 # TARGETS = $(LIBRARY)   # $(PROGRAM) not supported for MSVC yet
 TARGETS += $(SHARED_LIBRARY) $(PROGRAM)  # it is now
 else
-TARGETS += $(LIBRARY) $(SHARED_LIBRARY) $(PROGRAM) 
+TARGETS += $(LIBRARY) $(PROGRAM) 
 endif
 
 all:
@@ -158,19 +158,21 @@
 
 export:
 	+$(LOOP_OVER_PREDIRS)	
-	mkdir -p $(DIST)/include $(DIST)/$(LIBDIR) $(DIST)/bin
+	mkdir -p $(DIST)/include/mozjs $(DIST)/$(LIBDIR)/pkgconfig $(DIST)/bin
 ifneq "$(strip $(HFILES))" ""
-	$(CP) $(HFILES) $(DIST)/include
+	$(CP) $(HFILES) $(DIST)/include/mozjs/
 endif
 ifneq "$(strip $(LIBRARY))" ""
 	$(CP) $(LIBRARY) $(DIST)/$(LIBDIR)
+	echo "prefix=$(DIST)" > $(DIST)/$(LIBDIR)/pkgconfig/mozilla-js.pc
+	cat mozilla-js.pc.in >> $(DIST)/$(LIBDIR)/pkgconfig/mozilla-js.pc
 endif
 ifneq "$(strip $(JARS))" ""
 	$(CP) $(JARS) $(DIST)/$(LIBDIR)
 endif
-ifneq "$(strip $(SHARED_LIBRARY))" ""
-	$(CP) $(SHARED_LIBRARY) $(DIST)/$(LIBDIR)
-endif
+#ifneq "$(strip $(SHARED_LIBRARY))" ""
+#	$(CP) $(SHARED_LIBRARY) $(DIST)/$(LIBDIR)
+#endif
 ifneq "$(strip $(PROGRAM))" ""
 	$(CP) $(PROGRAM) $(DIST)/bin
 endif
