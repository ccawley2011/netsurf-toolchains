--- js/src/rules.mk.orig	2012-12-16 14:55:34.000000000 +0000
+++ js/src/rules.mk	2012-12-16 15:01:53.000000000 +0000
@@ -58,7 +58,7 @@
 # TARGETS = $(LIBRARY)   # $(PROGRAM) not supported for MSVC yet
 TARGETS += $(SHARED_LIBRARY) $(PROGRAM)  # it is now
 else
-TARGETS += $(LIBRARY) $(SHARED_LIBRARY) $(PROGRAM) 
+TARGETS += $(LIBRARY) $(PROGRAM) 
 endif
 
 all:
@@ -158,9 +158,9 @@
 
 export:
 	+$(LOOP_OVER_PREDIRS)	
-	mkdir -p $(DIST)/include $(DIST)/$(LIBDIR) $(DIST)/bin
+	mkdir -p $(DIST)/include/js $(DIST)/$(LIBDIR) $(DIST)/bin
 ifneq "$(strip $(HFILES))" ""
-	$(CP) $(HFILES) $(DIST)/include
+	$(CP) $(HFILES) $(DIST)/include/js/
 endif
 ifneq "$(strip $(LIBRARY))" ""
 	$(CP) $(LIBRARY) $(DIST)/$(LIBDIR)
@@ -168,9 +168,9 @@
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
