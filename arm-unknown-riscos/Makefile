# Going to use a known revision of trunk, until there's a release version that suits
UPSTREAM_GCCSDK_VERSION := 4957
UPSTREAM_GCCSDK_TARBALL := gcc4
UPSTREAM_GCCSDK_URI := svn://svn.riscos.info/gccsdk/trunk/gcc4@$(UPSTREAM_GCCSDK_VERSION)

# Ditto for OSLib
UPSTREAM_OSLIB_VERSION := 402
UPSTREAM_OSLIB_TARBALL := oslib
UPSTREAM_OSLIB_URI := https://ro-oslib.svn.sourceforge.net/svnroot/ro-oslib/trunk/!OSLib@$(UPSTREAM_OSLIB_VERSION)

# Ditto for CCRes
UPSTREAM_CCRES_VERSION := 96
UPSTREAM_CCRES_TARBALL := ccres
UPSTREAM_CCRES_URI := svn://svn.riscos.info/ccres/trunk@$(UPSTREAM_CCRES_VERSION)

# Ditto for Makerun
UPSTREAM_MAKERUN_VERSION := 11186
UPSTREAM_MAKERUN_TARBALL := makerun
UPSTREAM_MAKERUN_URI := svn://svn.netsurf-browser.org/trunk/tools/makerun@$(UPSTREAM_MAKERUN_VERSION)

TOP := $(CURDIR)
RECIPES := $(TOP)/recipes
BUILDSTEPS := $(TOP)/build-steps

TARGET_NAME := arm-unknown-riscos

PREFIX ?= /opt/netsurf/$(TARGET_NAME)

.PHONY: all clean distclean
all: $(BUILDSTEPS)/buildsteps.d $(BUILDSTEPS)/gcc.d $(BUILDSTEPS)/oslib.d \
	$(BUILDSTEPS)/ccres.d $(BUILDSTEPS)/makerun.d

clean:
	cd gcc4 && make clean

distclean: clean
	rm -fr $(UPSTREAM_GCCSDK_TARBALL)
	rm -fr $(UPSTREAM_OSLIB_TARBALL)
	rm -fr $(UPSTREAM_CCRES_TARBALL)
	rm -fr $(BUILDSTEPS)

# Buildsteps
$(BUILDSTEPS)/buildsteps.d:
	mkdir -p $(BUILDSTEPS)
	touch $@

# GCCSDK
$(BUILDSTEPS)/gcc.d: $(UPSTREAM_GCC_TARBALL)
	cp -p $(RECIPES)/files/gcc4/gccsdk-params gcc4/gccsdk-params
	sed -i 's#{PREFIX}#$(PREFIX)#' gcc4/gccsdk-params
	cd gcc4 && make
	touch $@

# OSLib
$(BUILDSTEPS)/oslib.d: $(BUILDSTEPS)/buildsteps.d $(BUILDSTEPS)/gcc.d $(UPSTREAM_OSLIB_TARBALL)
	cd $(UPSTREAM_OSLIB_TARBALL) && GCCSDK_INSTALL_ENV=$(PREFIX)/env GCCSDK_INSTALL_CROSSBIN=$(PREFIX)/cross/bin make install
	touch $@

# CCRes
$(BUILDSTEPS)/ccres.d: $(BUILDSTEPS)/buildsteps.d $(BUILDSTEPS)/oslib.d $(UPSTREAM_CCRES_TARBALL)
	cd $(UPSTREAM_CCRES_TARBALL) && GCCSDK_INSTALL_ENV=$(PREFIX)/env GCCSDK_INSTALL_CROSSBIN=$(PREFIX)/cross/bin make
	cd $(UPSTREAM_CCRES_TARBALL) && GCCSDK_INSTALL_ENV=$(PREFIX)/env GCCSDK_INSTALL_CROSSBIN=$(PREFIX)/cross/bin make install
	touch $@

# Makerun
$(BUILDSTEPS)/makerun.d: $(BUILDSTEPS)/buildsteps.d $(UPSTREAM_MAKERUN_TARBALL)
	cd $(UPSTREAM_MAKERUN_TARBALL) && GCCSDK_INSTALL_CROSSBIN=$(PREFIX)/cross/bin make install
	touch $@

###
# Rules to fetch upstream sources
###

$(UPSTREAM_GCCSDK_TARBALL):
	svn co $(UPSTREAM_GCCSDK_URI) $@

$(UPSTREAM_OSLIB_TARBALL):
	svn co $(UPSTREAM_OSLIB_URI) $@

$(UPSTREAM_CCRES_TARBALL):
	svn co $(UPSTREAM_CCRES_URI) $@

$(UPSTREAM_MAKERUN_TARBALL):
	svn co $(UPSTREAM_MAKERUN_URI) $@
