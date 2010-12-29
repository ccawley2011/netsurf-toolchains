--- Makefile.in.old	2010-12-29 00:23:58.000000000 +0000
+++ Makefile.in	2010-12-29 00:25:00.000000000 +0000
@@ -168,7 +168,9 @@
 	-@if [ ! -d $(DESTDIR)$(man3dir)      ]; then mkdir -p $(DESTDIR)$(man3dir); fi
 	-@if [ ! -d $(DESTDIR)$(pkgconfigdir) ]; then mkdir -p $(DESTDIR)$(pkgconfigdir); fi
 	cp $(STATICLIB) $(DESTDIR)$(libdir)
+ifneq ($(SHAREDLIBV),)
 	cp $(SHAREDLIBV) $(DESTDIR)$(sharedlibdir)
+endif
 	cd $(DESTDIR)$(libdir); chmod u=rw,go=r $(STATICLIB)
 	-@(cd $(DESTDIR)$(libdir); $(RANLIB) libz.a || true) >/dev/null 2>&1
 	-@cd $(DESTDIR)$(sharedlibdir); if test "$(SHAREDLIBV)" -a -f $(SHAREDLIBV); then \
