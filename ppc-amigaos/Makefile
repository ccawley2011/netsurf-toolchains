UPSTREAM_GCC_VERSION := 390
UPSTREAM_GCC_TARBALL := gcc-$(UPSTREAM_GCC_VERSION)
UPSTREAM_GCC_URI := https://adtools.svn.sourceforge.net/svnroot/adtools/trunk/gcc@$(UPSTREAM_BINUTILS_VERSION)

UPSTREAM_BINUTILS_VERSION := 390
UPSTREAM_BINUTILS_TARBALL := binutils-$(UPSTREAM_BINUTILS_VERSION)
UPSTREAM_BINUTILS_URI := https://adtools.svn.sourceforge.net/svnroot/adtools/trunk/binutils@$(UPSTREAM_BINUTILS_VERSION)

UPSTREAM_GMP_VERSION := 4.3.2
UPSTREAM_GMP_TARBALL := gmp-$(UPSTREAM_GMP_VERSION).tar.bz2
UPSTREAM_GMP_URI := http://ftp.gnu.org/gnu/gmp/$(UPSTREAM_GMP_TARBALL)

# Would use 3.0.0, but that dislikes in-tree gmp sources
UPSTREAM_MPFR_VERSION := 2.4.2
UPSTREAM_MPFR_TARBALL := mpfr-$(UPSTREAM_MPFR_VERSION).tar.bz2
UPSTREAM_MPFR_URI := http://www.mpfr.org/mpfr-$(UPSTREAM_MPFR_VERSION)/$(UPSTREAM_MPFR_TARBALL)

UPSTREAM_MPC_VERSION := 0.8.2
UPSTREAM_MPC_TARBALL := mpc-$(UPSTREAM_MPC_VERSION).tar.gz
UPSTREAM_MPC_URI := http://www.multiprecision.org/mpc/download/$(UPSTREAM_MPC_TARBALL)

UPSTREAM_NDK_TARBALL := SDK_53.20.lha
UPSTREAM_NDK_URI := "http://hyperion-entertainment.biz/index.php?option=com_registration&view=download&format=raw&file=38&Itemid=63"

UPSTREAM_OPENURL_VERSION := 7.8
UPSTREAM_OPENURL_TARBALL := openurl
UPSTREAM_OPENURL_URI := https://openurllib.svn.sourceforge.net/svnroot/openurllib/releases/$(UPSTREAM_OPENURL_VERSION)/developer/C

TOP := $(CURDIR)
RECIPES := $(TOP)/recipes
SOURCESDIR := $(TOP)/sources
BUILDDIR := $(TOP)/builddir
BUILDSTEPS := $(BUILDDIR)/build-steps
SRCDIR := $(BUILDDIR)/srcdir
GCC_SRCDIR := $(SRCDIR)/gcc
BINUTILS_SRCDIR := $(SRCDIR)/binutils

TARGET_NAME := ppc-amigaos

PREFIX ?= /opt/netsurf/$(TARGET_NAME)/cross

.PHONY: all clean distclean
all: $(BUILDSTEPS)/stage2.d

clean:
	rm -fr $(BUILDDIR)

distclean: clean
	rm -fr $(SOURCESDIR)

###
# Rules to build the full compiler
###

$(BUILDSTEPS)/stage2.d: $(BUILDSTEPS)/srcdir-step3.d $(BUILDSTEPS)/binutils.d $(BUILDSTEPS)/ndk.d
	cd $(BUILDDIR) && PATH="$(PREFIX)/bin:$(PATH)" $(GCC_SRCDIR)/configure --prefix=$(PREFIX) --target=$(TARGET_NAME) \
			--disable-nls --disable-c-mbchar --enable-languages=c --enable-checking=no --enable-c99 \
			--with-cross-host --without-x --enable-maintainer-mode --enable-haifa --enable-sjlj-exceptions \
			--disable-libstdcxx-pch --disable-tls --disable-libssp
	cd $(BUILDDIR) && PATH="$(PREFIX)/bin:$(PATH)" make all
	cd $(BUILDDIR) && PATH="$(PREFIX)/bin:$(PATH)" make install
	touch $@

###
# Rules to install the NDK
###

$(BUILDSTEPS)/ndk.d: $(SOURCESDIR)/$(UPSTREAM_NDK_TARBALL) $(SOURCESDIR)/$(UPSTREAM_OPENURL_TARBALL)
	mkdir -p $(BUILDDIR)/ndk/tmp/
	lha xw=$(BUILDDIR)/ndk $(SOURCESDIR)/$(UPSTREAM_NDK_TARBALL)
	lha xw=$(BUILDDIR)/ndk/tmp $(BUILDDIR)/ndk/SDK_Install/base.lha
	lha xw=$(BUILDDIR)/ndk/tmp $(BUILDDIR)/ndk/SDK_Install/newlib-53.9.lha
	lha xw=$(BUILDDIR)/ndk/tmp $(BUILDDIR)/ndk/SDK_Install/clib2-1.204.lha
	mkdir -p $(PREFIX)/$(TARGET_NAME)/SDK
	cp -r $(BUILDDIR)/ndk/tmp/Include $(PREFIX)/$(TARGET_NAME)/SDK/include
	cp -r $(BUILDDIR)/ndk/tmp/newlib $(PREFIX)/$(TARGET_NAME)/SDK/newlib
	cp -r $(BUILDDIR)/ndk/tmp/clib2 $(PREFIX)/$(TARGET_NAME)/SDK/clib2
	touch $@

###
# Rules to create the GCC source tree
###

$(BUILDSTEPS)/srcdir-step3.d: $(BUILDSTEPS)/srcdir-step2.d
	touch $@

$(BUILDSTEPS)/srcdir-step2.d: $(BUILDSTEPS)/srcdir-step1.d $(SOURCESDIR)/$(UPSTREAM_GMP_TARBALL) $(SOURCESDIR)/$(UPSTREAM_MPFR_TARBALL) $(SOURCESDIR)/$(UPSTREAM_MPC_TARBALL)
	tar xjf $(SOURCESDIR)/$(UPSTREAM_GMP_TARBALL)
	mv gmp-$(UPSTREAM_GMP_VERSION) $(GCC_SRCDIR)/gmp
	tar xjf $(SOURCESDIR)/$(UPSTREAM_MPFR_TARBALL)
	mv mpfr-$(UPSTREAM_MPFR_VERSION) $(GCC_SRCDIR)/mpfr
	tar xzf $(SOURCESDIR)/$(UPSTREAM_MPC_TARBALL)
	mv mpc-$(UPSTREAM_MPC_VERSION) $(GCC_SRCDIR)/mpc
	touch $@

$(BUILDSTEPS)/srcdir-step1.d: $(BUILDSTEPS)/$(UPSTREAM_GCC_TARBALL).d
	cp -r $(SOURCESDIR)/$(UPSTREAM_GCC_TARBALL) $(GCC_SRCDIR)
	touch $@

$(BUILDSTEPS)/$(UPSTREAM_GCC_TARBALL).d: $(BUILDSTEPS)/buildsteps.d $(SOURCESDIR)/$(UPSTREAM_GCC_TARBALL)
	touch $@

###
# Rules to build and install binutils
###

# Ugh. Upstream binutils is not remotely 64-bit safe.
# Build a 32bit binary until this gets fixed
$(BUILDSTEPS)/binutils.d: $(BUILDSTEPS)/binutils-srcdir.d
	mkdir -p $(BUILDDIR)/binutils
	cd $(BUILDDIR)/binutils && CFLAGS="-m32" LDFLAGS="-m32" $(BINUTILS_SRCDIR)/configure --prefix=$(PREFIX) --target=$(TARGET_NAME) --disable-nls
	cd $(BUILDDIR)/binutils && make
	cd $(BUILDDIR)/binutils && make install
	touch $@

$(BUILDSTEPS)/binutils-srcdir.d: $(SOURCESDIR)/$(UPSTREAM_BINUTILS_TARBALL)
	cp -r $(SOURCESDIR)/$(UPSTREAM_BINUTILS_TARBALL) $(BINUTILS_SRCDIR)
	touch $@

###
# Rules to fetch upstream sources
###

$(SOURCESDIR)/$(UPSTREAM_GCC_TARBALL):
	svn co $(UPSTREAM_GCC_URI) $@

$(SOURCESDIR)/$(UPSTREAM_GMP_TARBALL):
	wget -q -O $@ $(UPSTREAM_GMP_URI)

$(SOURCESDIR)/$(UPSTREAM_MPFR_TARBALL):
	wget -q -O $@ $(UPSTREAM_MPFR_URI)

$(SOURCESDIR)/$(UPSTREAM_MPC_TARBALL):
	wget -q -O $@ $(UPSTREAM_MPC_URI)

$(SOURCESDIR)/$(UPSTREAM_BINUTILS_TARBALL):
	svn co $(UPSTREAM_BINUTILS_URI) $@

$(SOURCESDIR)/$(UPSTREAM_NDK_TARBALL):
	wget -q -O $@ $(UPSTREAM_NDK_URI)

$(SOURCESDIR)/$(UPSTREAM_OPENURL_TARBALL):
	svn export $(UPSTREAM_OPENURL_URI) $@

###
# Rule to create buildsteps dir
###

$(BUILDSTEPS)/buildsteps.d: $(SOURCESDIR) $(SRCDIR)
	mkdir -p $(BUILDSTEPS)
	touch $@

$(SOURCESDIR):
	mkdir -p $@

$(SRCDIR):
	mkdir -p $@