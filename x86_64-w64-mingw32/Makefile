#!/bin/make

# mingw toolchain

UPSTREAM_GCC_VERSION := 4.6.3
UPSTREAM_GCC_TARBALL := gcc-core-$(UPSTREAM_GCC_VERSION).tar.gz
UPSTREAM_GCC_URI := http://ftpmirror.gnu.org/gcc/gcc-$(UPSTREAM_GCC_VERSION)/$(UPSTREAM_GCC_TARBALL)

UPSTREAM_BINUTILS_VERSION := 2.22
UPSTREAM_BINUTILS_TARBALL := binutils-$(UPSTREAM_BINUTILS_VERSION).tar.gz
UPSTREAM_BINUTILS_URI := http://ftpmirror.gnu.org/binutils/$(UPSTREAM_BINUTILS_TARBALL)

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

UPSTREAM_MINGW_VERSION := 2.0.4
UPSTREAM_MINGW_TARBALL := mingw-w64-v$(UPSTREAM_MINGW_VERSION).tar.gz
UPSTREAM_MINGW_URI := "http://downloads.sourceforge.net/project/mingw-w64/mingw-w64/mingw-w64-release/${UPSTREAM_MINGW_URI}?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fmingw-w64%2F&ts=1342830561&use_mirror=switch"


TOP := $(CURDIR)
RECIPES := $(TOP)/recipes
SOURCESDIR := $(TOP)/sources
BUILDDIR := $(TOP)/builddir
BUILDSTEPS := $(BUILDDIR)/build-steps
SRCDIR := $(BUILDDIR)/srcdir
GCC_SRCDIR := $(SRCDIR)/gcc
BINUTILS_SRCDIR := $(SRCDIR)/binutils
MINGW_SRCDIR := $(SRCDIR)/mingw

TARGET_NAME := x86_64-w64-mingw32

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

$(BUILDSTEPS)/stage2.d: $(BUILDSTEPS)/srcdir-step3.d $(BUILDSTEPS)/mingw.d $(BUILDSTEPS)/binutils.d 
	cd $(BUILDDIR) && PATH="$(PREFIX)/bin:$(PATH)" $(GCC_SRCDIR)/configure \
		--prefix=$(PREFIX) --target=$(TARGET_NAME) --disable-nls \
		--disable-c-mbchar --enable-languages=c --enable-checking=no \
		--enable-c99 --with-cross-host --without-x \
		--enable-maintainer-mode --enable-haifa \
		--enable-sjlj-exceptions --disable-libstdcxx-pch \
		--disable-tls --disable-libssp
	cd $(BUILDDIR) && PATH="$(PREFIX)/bin:$(PATH)" make all
	cd $(BUILDDIR) && PATH="$(PREFIX)/bin:$(PATH)" make install
	touch $@

###
# Rules to install mingw
###

$(BUILDSTEPS)/mingw.d: $(BUILDSTEPS)/mingw-srcdir.d
	mkdir -p $(BUILDDIR)/mingw
	cd $(BUILDDIR)/mingw && PATH="$(PREFIX)/bin:$(PATH)" $(MINGW_SRCDIR)/configure \
	--prefix=$(PREFIX) --host=$(TARGET_NAME)
	cd $(BUILDDIR)/mingw && make
	cd $(BUILDDIR)/mingw && make install
	touch $@

$(BUILDSTEPS)/mingw-srcdir.d: $(SOURCESDIR)/$(UPSTREAM_MINGW_TARBALL)
	tar xjf $(SOURCESDIR)/$(UPSTREAM_MINGW_TARBALL)
	mv mingw-$(UPSTREAM_MINGW_VERSION) $(MINGW_SRCDIR)
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

$(BUILDSTEPS)/srcdir-step1.d: $(BUILDSTEPS)/$(UPSTREAM_GCC_TARBALL)
	tar xjf $(BUILDSTEPS)/$(UPSTREAM_GCC_TARBALL)
	mv gcc-$(UPSTREAM_GCC_VERSION) $(GCC_SRCDIR)
	touch $@


###
# Rules to build and install binutils
###

$(BUILDSTEPS)/binutils.d: $(BUILDSTEPS)/binutils-srcdir.d
	mkdir -p $(BUILDDIR)/binutils
	cd $(BUILDDIR)/binutils && $(BINUTIL_SRCDIR)/configure \
	--enable-targets=x86_64-w64-mingw32,i686-w64-mingw32 \
	--with-sysroot=$(PREFIX) --prefix=$(PREFIX) --target=$(TARGET_NAME)
	cd $(BUILDDIR)/binutils && make
	cd $(BUILDDIR)/binutils && make install
	touch $@

$(BUILDSTEPS)/binutils-srcdir.d: $(SOURCESDIR)/$(UPSTREAM_BINUTILS_TARBALL)
	tar xjf $(SOURCESDIR)/$(UPSTREAM_BINUTILS_TARBALL)
	mv binutils-$(UPSTREAM_BINUTILS_VERSION) $(BINUTILS_SRCDIR)
	touch $@

###
# Rules to fetch upstream sources
###

$(SOURCESDIR)/$(UPSTREAM_GCC_TARBALL):
	wget -q -O $@ $(UPSTREAM_GCC_URI) $@

$(SOURCESDIR)/$(UPSTREAM_GMP_TARBALL):
	wget -q -O $@ $(UPSTREAM_GMP_URI)

$(SOURCESDIR)/$(UPSTREAM_MPFR_TARBALL):
	wget -q -O $@ $(UPSTREAM_MPFR_URI)

$(SOURCESDIR)/$(UPSTREAM_MPC_TARBALL):
	wget -q -O $@ $(UPSTREAM_MPC_URI)

$(SOURCESDIR)/$(UPSTREAM_BINUTILS_TARBALL):
	wget -q -O $@ $(UPSTREAM_BINUTILS_URI) $@

$(SOURCESDIR)/$(UPSTREAM_MINGW_TARBALL):
	wget -q -O $@ $(UPSTREAM_MINGW_URI)

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
