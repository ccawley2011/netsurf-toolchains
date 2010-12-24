UPSTREAM_GCC_VERSION := 4.5.1
UPSTREAM_GCC_TARBALL := gcc-$(UPSTREAM_GCC_VERSION).tar.bz2
UPSTREAM_GCC_URI := http://ftp.gnu.org/gnu/gcc/gcc-$(UPSTREAM_GCC_VERSION)/$(UPSTREAM_GCC_TARBALL)

UPSTREAM_BINUTILS_VERSION := 2.14
# Not a tarball; so sue me
UPSTREAM_BINUTILS_TARBALL := binutils-$(UPSTREAM_BINUTILS_VERSION)
UPSTREAM_BINUTILS_URI := https://adtools.svn.sourceforge.net/svnroot/adtools/tags/before-merge-with-binutils-2.18/binutils

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

UPSTREAM_CLIB2_TARBALL := clib2
UPSTREAM_CLIB2_URI := anonymous@clib2.cvs.sourceforge.net:/cvsroot/clib2

UPSTREAM_NDK_TARBALL := ndk-3.9-includes.tar.bz2
UPSTREAM_NDK_URI := http://www.zerohero.se/cross/files/m68k-amigaos/ndk-3.9-includes.tar.bz2

TOP := $(CURDIR)
RECIPES := $(TOP)/recipes
BUILDSTEPS := $(TOP)/build-steps
SRCDIR := $(TOP)/srcdir
BINUTILS_SRCDIR := $(TOP)/binutils-srcdir
BUILDDIR := $(TOP)/builddir

PREFIX ?= /usr/local/netsurf/cross/amiga68k/

TARGET_NAME := m68k-unknown-amigaos

.PHONY: all
all: $(BUILDSTEPS)/stage2.d

###
# Rules to build the full compiler
###

$(BUILDSTEPS)/stage2.d: $(BUILDSTEPS)/clib2.d
	rm -fr $(BUILDDIR)
	mkdir -p $(BUILDDIR)
	cd $(BUILDDIR) && PATH="$(PREFIX)/bin:$(PATH)" $(SRCDIR)/configure --prefix=$(PREFIX) --target=$(TARGET_NAME) \
			--with-cpu=m68040 --disable-threads --disable-nls --disable-c-mbchar \
			--enable-languages=c --enable-checking=no --enable-c99 --with-cross-host \
			--disable-multilib --without-x --enable-maintainer-mode --disable-shared
	cd $(BUILDDIR) && PATH="$(PREFIX)/bin:$(PATH)" make all
	cd $(BUILDDIR) && PATH="$(PREFIX)/bin:$(PATH)" make install
	touch $@

###
# Rules to build and install Clib2
###

$(BUILDSTEPS)/clib2.d: $(BUILDSTEPS)/bootstrap-compiler.d $(BUILDSTEPS)/ndk.d $(UPSTREAM_CLIB2_TARBALL)
	cp -r $(UPSTREAM_CLIB2_TARBALL) $(BUILDDIR)/clib2
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

$(BUILDSTEPS)/ndk.d: $(UPSTREAM_NDK_TARBALL)
	mkdir -p $(PREFIX)/$(TARGET_NAME)
	tar -C $(PREFIX)/$(TARGET_NAME) --strip-components=2 -xjf $(UPSTREAM_NDK_TARBALL)
	for p in `ls $(RECIPES)/patches/ndk/*.p` ; do patch -d $(PREFIX)/$(TARGET_NAME) -p0 <$$p ; done
	for dir in `find $(RECIPES)/files/ndk/ -type d | grep -v '\.svn' | sed 's#$(RECIPES)/files/ndk##'` ; do mkdir -p $(PREFIX)/$(TARGET_NAME)$$dir ; done
	for file in `find $(RECIPES)/files/ndk/ -type f | grep -v '\.svn' | sed 's#$(RECIPES)/files/ndk##'` ; do cp -p $(RECIPES)/files/ndk$$file $(PREFIX)/$(TARGET_NAME)$$file ; done
	touch $@

###
# Rules to build and install the bootstrap compiler
###

$(BUILDSTEPS)/bootstrap-compiler.d: $(BUILDSTEPS)/srcdir-step3.d $(BUILDSTEPS)/binutils.d
	cd $(BUILDDIR) && PATH="$(PREFIX)/bin:$(PATH)" $(SRCDIR)/configure --prefix=$(PREFIX) --target=$(TARGET_NAME) \
			--with-cpu=m68040 --disable-threads --disable-nls --disable-c-mbchar \
			--enable-languages=c --enable-checking=no --enable-c99 --with-cross-host \
			--disable-multilib --without-x --enable-maintainer-mode --disable-shared \
			--without-headers
	cd $(BUILDDIR) && PATH="$(PREFIX)/bin:$(PATH)" make all-gcc
	cd $(BUILDDIR) && PATH="$(PREFIX)/bin:$(PATH)" make install-gcc
	touch $@

###
# Rules to create the GCC source tree
###

$(BUILDSTEPS)/srcdir-step3.d: $(BUILDSTEPS)/srcdir-step2.d
	for p in `ls $(RECIPES)/patches/gcc/*.p` ; do patch -d $(SRCDIR) -p0 <$$p ; done
	for dir in `find $(RECIPES)/files/gcc/ -type d | grep -v '\.svn' | sed 's#$(RECIPES)/files/gcc##'` ; do mkdir -p $(SRCDIR)$$dir ; done
	for file in `find $(RECIPES)/files/gcc/ -type f | grep -v '\.svn' | sed 's#$(RECIPES)/files/gcc##'` ; do cp -p $(RECIPES)/files/gcc$$file $(SRCDIR)$$file ; done
	touch $@

$(BUILDSTEPS)/srcdir-step2.d: $(BUILDSTEPS)/srcdir-step1.d $(UPSTREAM_GMP_TARBALL) $(UPSTREAM_MPFR_TARBALL) $(UPSTREAM_MPC_TARBALL)
	tar xjf $(UPSTREAM_GMP_TARBALL)
	mv gmp-$(UPSTREAM_GMP_VERSION) $(SRCDIR)/gmp
	tar xjf $(UPSTREAM_MPFR_TARBALL)
	mv mpfr-$(UPSTREAM_MPFR_VERSION) $(SRCDIR)/mpfr
	tar xzf $(UPSTREAM_MPC_TARBALL)
	mv mpc-$(UPSTREAM_MPC_VERSION) $(SRCDIR)/mpc
	touch $@

$(BUILDSTEPS)/srcdir-step1.d: $(BUILDSTEPS)/$(UPSTREAM_GCC_TARBALL).d
	tar xjf $(UPSTREAM_GCC_TARBALL)
	mv gcc-$(UPSTREAM_GCC_VERSION) srcdir
	touch $@

$(BUILDSTEPS)/$(UPSTREAM_GCC_TARBALL).d: $(BUILDSTEPS)/buildsteps.d $(UPSTREAM_GCC_TARBALL)
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

$(BUILDSTEPS)/binutils-srcdir.d: $(UPSTREAM_BINUTILS_TARBALL)
	cp -r $(UPSTREAM_BINUTILS_TARBALL) $(BINUTILS_SRCDIR)
	for p in `ls $(RECIPES)/patches/binutils/*.p` ; do patch -d $(BINUTILS_SRCDIR) -p0 <$$p ; done
	touch $@

###
# Rules to fetch upstream sources
###

$(UPSTREAM_GCC_TARBALL):
	wget -q -O $@ $(UPSTREAM_GCC_URI)

$(UPSTREAM_GMP_TARBALL):
	wget -q -O $@ $(UPSTREAM_GMP_URI)

$(UPSTREAM_MPFR_TARBALL):
	wget -q -O $@ $(UPSTREAM_MPFR_URI)

$(UPSTREAM_MPC_TARBALL):
	wget -q -O $@ $(UPSTREAM_MPC_URI)

$(UPSTREAM_BINUTILS_TARBALL):
	svn co $(UPSTREAM_BINUTILS_URI) $@

$(UPSTREAM_CLIB2_TARBALL):
	cvs -Q -d:pserver:$(UPSTREAM_CLIB2_URI) login
	cvs -z9 -d:pserver:$(UPSTREAM_CLIB2_URI) co library
	mv library $@

$(UPSTREAM_NDK_TARBALL):
	wget -q -O $@ $(UPSTREAM_NDK_URI)

###
# Rule to create buildsteps dir
###

$(BUILDSTEPS)/buildsteps.d:
	mkdir -p $(BUILDSTEPS)
	touch $@
