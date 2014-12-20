UPSTREAM_GCC_VERSION := 4.5.1
UPSTREAM_GCC_TARBALL := gcc-$(UPSTREAM_GCC_VERSION).tar.bz2
UPSTREAM_GCC_URI := http://ftp.gnu.org/gnu/gcc/gcc-$(UPSTREAM_GCC_VERSION)/$(UPSTREAM_GCC_TARBALL)

UPSTREAM_BINUTILS_VERSION := 2.14
# Not a tarball; so sue me
UPSTREAM_BINUTILS_TARBALL := binutils-$(UPSTREAM_BINUTILS_VERSION)
UPSTREAM_BINUTILS_URI := http://svn.code.sf.net/p/adtools/code/tags/before-merge-with-binutils-2.18/binutils/

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

UPSTREAM_CLIB2_VERSION := 2010-12-30
UPSTREAM_CLIB2_TARBALL := clib2-$(UPSTREAM_CLIB2_VERSION).tar.xz
UPSTREAM_CLIB2_URI := anonymous:@clib2.cvs.sourceforge.net:/cvsroot/clib2

UPSTREAM_NDK_TARBALL := ndk-3.9-includes.tar.bz2
UPSTREAM_NDK_URI := http://kas1e.mikendezign.com/zerohero_crosscompilers_backup/files/m68k-amigaos/ndk-3.9-includes.tar.bz2

UPSTREAM_OPENURL_VERSION := 7.15
UPSTREAM_OPENURL_TARBALL := openurl
UPSTREAM_OPENURL_URI := http://svn.code.sf.net/p/openurllib/code/releases/$(UPSTREAM_OPENURL_VERSION)/developer/C

# need to force the auto* version in use
GCC_AUTOCONF := autoconf2.64
GCC_AUTOHEADER := autoheader2.64
GCC_AUTORECONF := autoreconf2.64
GCC_AUTOM4TE := autom4te2.64

TOP := $(CURDIR)
RECIPES := $(TOP)/recipes
SOURCESDIR := $(TOP)/sources
BUILDDIR := $(TOP)/builddir
BUILDSTEPS := $(BUILDDIR)/build-steps
SRCDIR := $(BUILDDIR)/srcdir
GCC_SRCDIR := $(SRCDIR)/gcc
BINUTILS_SRCDIR := $(SRCDIR)/binutils

TARGET_NAME := m68k-unknown-amigaos

PREFIX ?= /opt/netsurf/$(TARGET_NAME)/cross

GCC_ENV_PARAMS := AUTOCONF=$(GCC_AUTOCONF) AUTOHEADER=$(GCC_AUTOHEADER) AUTOM4TE=$(GCC_AUTOM4TE) PATH="$(PREFIX)/bin:$(PATH)"

.PHONY: all clean distclean
all: $(BUILDSTEPS)/stage2.d

clean:
	rm -fr $(BUILDDIR)

distclean: clean
	rm -fr $(SOURCESDIR)

###
# Rules to build the full compiler
###

$(BUILDSTEPS)/stage2.d: $(BUILDSTEPS)/clib2.d
	cd $(BUILDDIR) && $(GCC_ENV_PARAMS) make all
	cd $(BUILDDIR) && $(GCC_ENV_PARAMS) make install
	touch $@

###
# Rules to build and install Clib2
###

$(BUILDSTEPS)/clib2.d: $(BUILDSTEPS)/bootstrap-compiler.d $(BUILDSTEPS)/ndk.d $(SOURCESDIR)/$(UPSTREAM_CLIB2_TARBALL)
	tar xaf $(SOURCESDIR)/$(UPSTREAM_CLIB2_TARBALL)
	mv library $(BUILDDIR)/clib2
	for p in `ls $(RECIPES)/patches/clib2/*.p` ; do patch -d $(BUILDDIR)/clib2 -p0 <$$p ; done
	for dir in `find $(RECIPES)/files/clib2/ -type d | grep -v '\.svn' | sed 's#$(RECIPES)/files/clib2##'` ; do mkdir -p $(BUILDDIR)/clib2$$dir ; done
	for file in `find $(RECIPES)/files/clib2/ -type f | grep -v '\.svn' | sed 's#$(RECIPES)/files/clib2##'` ; do cp -p $(RECIPES)/files/clib2$$file $(BUILDDIR)/clib2$$file ; done
	cd $(BUILDDIR)/clib2 && PATH="$(PREFIX)/bin:$(PATH)" make -f GNUmakefile.68k
	cp -r $(BUILDDIR)/clib2/include $(PREFIX)/$(TARGET_NAME)
	cp -r $(BUILDDIR)/clib2/lib $(PREFIX)/$(TARGET_NAME)
	touch $@

###
# Rules to install the NDK
###

$(BUILDSTEPS)/ndk.d: $(SOURCESDIR)/$(UPSTREAM_NDK_TARBALL) $(SOURCESDIR)/$(UPSTREAM_OPENURL_TARBALL)
	mkdir -p $(PREFIX)/$(TARGET_NAME)
	tar -C $(PREFIX)/$(TARGET_NAME) --strip-components=2 -xjf $(SOURCESDIR)/$(UPSTREAM_NDK_TARBALL)
	for p in `ls $(RECIPES)/patches/ndk/*.p` ; do patch -d $(PREFIX)/$(TARGET_NAME) -p0 <$$p ; done
	for dir in `find $(RECIPES)/files/ndk/ -type d | grep -v '\.svn' | sed 's#$(RECIPES)/files/ndk##'` ; do mkdir -p $(PREFIX)/$(TARGET_NAME)$$dir ; done
	for file in `find $(RECIPES)/files/ndk/ -type f | grep -v '\.svn' | sed 's#$(RECIPES)/files/ndk##'` ; do cp -p $(RECIPES)/files/ndk$$file $(PREFIX)/$(TARGET_NAME)$$file ; done
	cp -r $(SOURCESDIR)/$(UPSTREAM_OPENURL_TARBALL)/include/* $(PREFIX)/$(TARGET_NAME)/sys-include/
	touch $@

###
# Rules to build and install the bootstrap compiler
###

$(BUILDSTEPS)/bootstrap-compiler.d: $(BUILDSTEPS)/srcdir-step3.d $(BUILDSTEPS)/binutils.d
	cd $(BUILDDIR) && $(GCC_ENV_PARAMS) $(GCC_SRCDIR)/configure \
				--prefix=$(PREFIX) \
				--target=$(TARGET_NAME) \
				--with-cpu=m68040 --disable-threads \
				--disable-nls --disable-c-mbchar \
				--enable-languages=c --enable-checking=no \
				--enable-c99 --with-cross-host \
				--disable-multilib --without-x \
				--enable-maintainer-mode --disable-shared \
				--without-headers
	cd $(BUILDDIR) && $(GCC_ENV_PARAMS) make all-gcc
	cd $(BUILDDIR) && $(GCC_ENV_PARAMS) make install-gcc
	touch $@

###
# Rules to create the GCC source tree
###

$(BUILDSTEPS)/srcdir-step3.d: $(BUILDSTEPS)/srcdir-step2.d
	for p in `ls $(RECIPES)/patches/gcc/*.p` ; do patch -d $(GCC_SRCDIR) -p0 <$$p ; done
	for dir in `find $(RECIPES)/files/gcc/ -type d | grep -v '\.svn' | sed 's#$(RECIPES)/files/gcc##'` ; do mkdir -p $(GCC_SRCDIR)$$dir ; done
	for file in `find $(RECIPES)/files/gcc/ -type f | grep -v '\.svn' | sed 's#$(RECIPES)/files/gcc##'` ; do cp -p $(RECIPES)/files/gcc$$file $(GCC_SRCDIR)$$file ; done
	touch $@

$(BUILDSTEPS)/srcdir-step2.d: $(BUILDSTEPS)/srcdir-step1.d $(SOURCESDIR)/$(UPSTREAM_GMP_TARBALL) $(SOURCESDIR)/$(UPSTREAM_MPFR_TARBALL) $(SOURCESDIR)/$(UPSTREAM_MPC_TARBALL)
	tar xaf $(SOURCESDIR)/$(UPSTREAM_GMP_TARBALL)
	mv gmp-$(UPSTREAM_GMP_VERSION) $(GCC_SRCDIR)/gmp
	tar xaf $(SOURCESDIR)/$(UPSTREAM_MPFR_TARBALL)
	mv mpfr-$(UPSTREAM_MPFR_VERSION) $(GCC_SRCDIR)/mpfr
	tar xaf $(SOURCESDIR)/$(UPSTREAM_MPC_TARBALL)
	mv mpc-$(UPSTREAM_MPC_VERSION) $(GCC_SRCDIR)/mpc
	touch $@

$(BUILDSTEPS)/srcdir-step1.d: $(BUILDSTEPS)/$(UPSTREAM_GCC_TARBALL).d
	tar xjf $(SOURCESDIR)/$(UPSTREAM_GCC_TARBALL)
	mv gcc-$(UPSTREAM_GCC_VERSION) $(GCC_SRCDIR)
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
	for p in `ls $(RECIPES)/patches/binutils/*.p` ; do patch -d $(BINUTILS_SRCDIR) -p0 <$$p ; done
	touch $@

###
# Rules to fetch upstream sources
###

$(SOURCESDIR)/$(UPSTREAM_GCC_TARBALL):
	wget -q -O $@ $(UPSTREAM_GCC_URI)

$(SOURCESDIR)/$(UPSTREAM_GMP_TARBALL):
	wget -q -O $@ $(UPSTREAM_GMP_URI)

$(SOURCESDIR)/$(UPSTREAM_MPFR_TARBALL):
	wget -q -O $@ $(UPSTREAM_MPFR_URI)

$(SOURCESDIR)/$(UPSTREAM_MPC_TARBALL):
	wget -q -O $@ $(UPSTREAM_MPC_URI)

$(SOURCESDIR)/$(UPSTREAM_BINUTILS_TARBALL):
	svn co $(UPSTREAM_BINUTILS_URI) $@

$(SOURCESDIR)/$(UPSTREAM_CLIB2_TARBALL):
	cvs -Q -d:pserver:$(UPSTREAM_CLIB2_URI) login
	cvs -z9 -d:pserver:$(UPSTREAM_CLIB2_URI) checkout -D $(UPSTREAM_CLIB2_VERSION) library
	tar -caf $@ library
	rm -rf library

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
