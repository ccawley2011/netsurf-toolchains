UPSTREAM_VERSION := 4.5.1
UPSTREAM_TARBALL := gcc-$(UPSTREAM_VERSION).tar.bz2
UPSTREAM_URI := http://ftp.gnu.org/gnu/gcc/gcc-$(UPSTREAM_VERSION)/$(UPSTREAM_TARBALL)

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

TOP := $(CURDIR)
RECIPES := $(TOP)/recipes
BUILDSTEPS := $(TOP)/build-steps
SRCDIR := $(TOP)/srcdir
BUILDDIR := $(TOP)/builddir

PREFIX ?= /usr/local/netsurf/cross/amiga68k/

TARGET_NAME := m68k-unknown-amigaos

.PHONY: all install
all: $(BUILDSTEPS)/toolchain.d

install: $(BUILDSTEPS)/install.d

$(BUILDSTEPS)/install.d: $(BUILDSTEPS)/toolchain.d
	cd $(BUILDDIR)/binutils/target && make install
	cd $(BUILDDIR) && make install
	touch $@

$(BUILDSTEPS)/toolchain.d: $(BUILDSTEPS)/make.d $(BUILDSTEPS)/binutils.d
	touch $@

$(BUILDSTEPS)/make.d: $(BUILDSTEPS)/configure.d
	cd $(BUILDDIR) && PATH="$(BUILDDIR)/binutils/bootstrap/prefix/bin:$(PATH)" make all
	touch $@

$(BUILDSTEPS)/configure.d: $(BUILDSTEPS)/srcdir-step3.d
	cd $(BUILDDIR) && PATH="$(BUILDDIR)/binutils/bootstrap/prefix/bin:$(PATH)" $(SRCDIR)/configure --prefix=$(PREFIX) --target=$(TARGET_NAME) \
			--with-cpu=m68040 --disable-threads --disable-nls --disable-c-mbchar \
			--enable-languages=c --enable-checking=no --enable-c99 --with-cross-host \
			--enable-multilib --without-x --enable-maintainer-mode
	touch $@

$(BUILDSTEPS)/srcdir-step3.d: $(BUILDSTEPS)/srcdir-step2.d $(UPSTREAM_GMP_TARBALL) $(UPSTREAM_MPFR_TARBALL) $(UPSTREAM_MPC_TARBALL)
	tar xjf $(UPSTREAM_GMP_TARBALL)
	mv gmp-$(UPSTREAM_GMP_VERSION) $(SRCDIR)/gmp
	tar xjf $(UPSTREAM_MPFR_TARBALL)
	mv mpfr-$(UPSTREAM_MPFR_VERSION) $(SRCDIR)/mpfr
	tar xzf $(UPSTREAM_MPC_TARBALL)
	mv mpc-$(UPSTREAM_MPC_VERSION) $(SRCDIR)/mpc
	touch $@

$(BUILDSTEPS)/srcdir-step2.d: $(BUILDSTEPS)/srcdir-step1.d
	for p in `ls $(RECIPES)/patches/gcc/*.p` ; do patch -d $(SRCDIR) -p0 <$$p ; done
	for dir in `find $(RECIPES)/files -type d | grep -v '\.svn' | sed 's#$(RECIPES)/files/##'` ; do mkdir -p $(SRCDIR)/$$dir ; done
	for file in `find $(RECIPES)/files -type f | grep -v '\.svn' | sed 's#$(RECIPES)/files/##'` ; do cp -p $(RECIPES)/files/$$file $(SRCDIR)/$$file ; done
	touch $@

$(BUILDSTEPS)/srcdir-step1.d: $(BUILDSTEPS)/orig.gcc.d $(BUILDSTEPS)/bootstrap-binutils.d
	ln -s orig.gcc $(SRCDIR)
	touch $@

$(BUILDSTEPS)/orig.gcc.d: $(BUILDSTEPS)/orig.gcc-$(UPSTREAM_TARBALL).d
	tar xjf orig.gcc-$(UPSTREAM_TARBALL)
	mv gcc-$(UPSTREAM_VERSION) orig.gcc
	touch $@

$(BUILDSTEPS)/orig.gcc-$(UPSTREAM_TARBALL).d: $(BUILDSTEPS)/buildsteps.d orig.gcc-$(UPSTREAM_TARBALL)
	touch $@

orig.gcc-$(UPSTREAM_TARBALL):
	wget -q -O $@ $(UPSTREAM_URI)

# Ugh. Upstream binutils is not remotely 64-bit safe.
# Build a 32bit binary until this gets fixed
$(BUILDSTEPS)/binutils.d: $(UPSTREAM_BINUTILS_TARBALL)
	mkdir -p $(BUILDDIR)/binutils/target
	cd $(BUILDDIR)/binutils/target && CFLAGS="-m32" LDFLAGS="-m32" $(TOP)/binutils-$(UPSTREAM_BINUTILS_VERSION)/configure --prefix=$(PREFIX) --target=$(TARGET_NAME)
	cd $(BUILDDIR)/binutils/target && make
	touch $@

$(BUILDSTEPS)/bootstrap-binutils.d: $(UPSTREAM_BINUTILS_TARBALL)
	mkdir -p $(BUILDDIR)/binutils/bootstrap
	cd $(BUILDDIR)/binutils/bootstrap && CFLAGS="-m32" LDFLAGS="-m32" $(TOP)/binutils-$(UPSTREAM_BINUTILS_VERSION)/configure --prefix=$(BUILDDIR)/binutils/bootstrap/prefix --target=$(TARGET_NAME)
	cd $(BUILDDIR)/binutils/bootstrap && make
	cd $(BUILDDIR)/binutils/bootstrap && make install
	touch $@

$(UPSTREAM_GMP_TARBALL):
	wget -q -O $@ $(UPSTREAM_GMP_URI)

$(UPSTREAM_MPFR_TARBALL):
	wget -q -O $@ $(UPSTREAM_MPFR_URI)

$(UPSTREAM_MPC_TARBALL):
	wget -q -O $@ $(UPSTREAM_MPC_URI)

$(UPSTREAM_BINUTILS_TARBALL):
	svn co $(UPSTREAM_BINUTILS_URI) $@

$(BUILDSTEPS)/buildsteps.d:
	mkdir -p $(BUILDSTEPS)
	touch $@
