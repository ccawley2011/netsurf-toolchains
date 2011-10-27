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

# Infozip
UPSTREAM_INFOZIP_VERSION := 30
UPSTREAM_INFOZIP_TARBALL := zip$(UPSTREAM_INFOZIP_VERSION).tgz
UPSTREAM_INFOZIP_URI := ftp://ftp.info-zip.org/pub/infozip/src/$(UPSTREAM_INFOZIP_TARBALL)

TOP := $(CURDIR)
RECIPES := $(TOP)/recipes
SOURCESDIR := $(TOP)/sources
BUILDDIR := $(TOP)/builddir
BUILDSTEPS := $(BUILDDIR)/build-steps

TARGET_NAME := arm-unknown-riscos

PREFIX ?= /opt/netsurf/$(TARGET_NAME)

.PHONY: all clean distclean
all: $(BUILDSTEPS)/toolchain.d

clean:
	rm -fr $(BUILDDIR)

distclean: clean
	rm -fr $(SOURCESDIR)

###
# Rules to build the full toolchain
###

$(BUILDSTEPS)/toolchain.d: $(BUILDSTEPS)/ccres.d $(BUILDSTEPS)/makerun.d $(BUILDSTEPS)/infozip.d
	touch $@

###
# Rules to build and install Infozip
###

$(BUILDSTEPS)/infozip.d: $(BUILDSTEPS)/gcc.d $(SOURCESDIR)/$(UPSTREAM_INFOZIP_TARBALL)
	tar -C $(BUILDDIR) -xzf $(SOURCESDIR)/$(UPSTREAM_INFOZIP_TARBALL)
	for p in `ls $(RECIPES)/patches/infozip/*.p` ; do patch -d $(BUILDDIR)/zip$(UPSTREAM_INFOZIP_VERSION) -p0 <$$p ; done
	cd $(BUILDDIR)/zip$(UPSTREAM_INFOZIP_VERSION) && make -f unix/Makefile generic LOCAL_ZIP=-DFORRISCOS
	cp $(BUILDDIR)/zip$(UPSTREAM_INFOZIP_VERSION)/zip $(PREFIX)/cross/bin/zip
	@# Yuck. Build host tooling should not be installed into the target environment
	ln -fs $(PREFIX)/cross/bin/zip $(PREFIX)/env/bin/zip
	touch $@

###
# Rules to build and install Makerun
###

$(BUILDSTEPS)/makerun.d: $(BUILDSTEPS)/gcc.d $(SOURCESDIR)/$(UPSTREAM_MAKERUN_TARBALL)
	cp -r $(SOURCESDIR)/$(UPSTREAM_MAKERUN_TARBALL) $(BUILDDIR)/makerun
	cd $(BUILDDIR)/makerun && GCCSDK_INSTALL_CROSSBIN=$(PREFIX)/cross/bin make install
	touch $@

###
# Rules to build and install CCRes
###

$(BUILDSTEPS)/ccres.d: $(BUILDSTEPS)/oslib.d $(SOURCESDIR)/$(UPSTREAM_CCRES_TARBALL)
	cp -r $(SOURCESDIR)/$(UPSTREAM_CCRES_TARBALL) $(BUILDDIR)/ccres
	cd $(BUILDDIR)/ccres && GCCSDK_INSTALL_ENV=$(PREFIX)/env GCCSDK_INSTALL_CROSSBIN=$(PREFIX)/cross/bin make
	cd $(BUILDDIR)/ccres && GCCSDK_INSTALL_ENV=$(PREFIX)/env GCCSDK_INSTALL_CROSSBIN=$(PREFIX)/cross/bin make install
	touch $@

###
# Rules to build and install OSLib
###

$(BUILDSTEPS)/oslib.d: $(BUILDSTEPS)/gcc.d $(SOURCESDIR)/$(UPSTREAM_OSLIB_TARBALL)
	cp -r $(SOURCESDIR)/$(UPSTREAM_OSLIB_TARBALL) $(BUILDDIR)/oslib
	for p in `ls $(RECIPES)/patches/oslib/*.p` ; do patch -d $(BUILDDIR)/oslib -p0 <$$p ; done
	cd $(BUILDDIR)/oslib && GCCSDK_INSTALL_ENV=$(PREFIX)/env GCCSDK_INSTALL_CROSSBIN=$(PREFIX)/cross/bin make install
	touch $@

###
# Rules to build and install GCCSDK
###

$(BUILDSTEPS)/gcc.d: $(BUILDSTEPS)/gccsdk-srcdir.d
	cd $(BUILDDIR)/gcc4 && make
	touch $@

$(BUILDSTEPS)/gccsdk-srcdir.d: $(BUILDSTEPS)/buildsteps.d $(SOURCESDIR)/$(UPSTREAM_GCCSDK_TARBALL)
	cp -r $(SOURCESDIR)/$(UPSTREAM_GCCSDK_TARBALL) $(BUILDDIR)/gcc4
	cp -p $(RECIPES)/files/gcc4/gccsdk-params $(BUILDDIR)/gcc4/gccsdk-params
	sed -i 's#{PREFIX}#$(PREFIX)#' $(BUILDDIR)/gcc4/gccsdk-params
	for p in `ls $(RECIPES)/patches/gcc4/*.p` ; do patch -d $(BUILDDIR)/gcc4 -p0 <$$p ; done
	touch $@

###
# Rules to fetch upstream sources
###

$(SOURCESDIR)/$(UPSTREAM_GCCSDK_TARBALL):
	svn co $(UPSTREAM_GCCSDK_URI) $@

$(SOURCESDIR)/$(UPSTREAM_OSLIB_TARBALL):
	svn co $(UPSTREAM_OSLIB_URI) $@

$(SOURCESDIR)/$(UPSTREAM_CCRES_TARBALL):
	svn co $(UPSTREAM_CCRES_URI) $@

$(SOURCESDIR)/$(UPSTREAM_MAKERUN_TARBALL):
	svn co $(UPSTREAM_MAKERUN_URI) $@

$(SOURCESDIR)/$(UPSTREAM_INFOZIP_TARBALL):
	wget -q -O $@ $(UPSTREAM_INFOZIP_URI)

###
# Rule to create buildsteps dir
###

$(BUILDSTEPS)/buildsteps.d: $(SOURCESDIR)
	mkdir -p $(BUILDSTEPS)
	touch $@

$(SOURCESDIR):
	mkdir -p $@

