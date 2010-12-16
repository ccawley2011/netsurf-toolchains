UPSTREAM_VERSION := 4.5.1
UPSTREAM_TARBALL := gcc-$(UPSTREAM_VERSION).tar.bz2
UPSTREAM_URI := http://ftp.gnu.org/gnu/gcc/gcc-$(UPSTREAM_VERSION)/$(UPSTREAM_TARBALL)

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
all: $(BUILDSTEPS)/make.d

install: $(BUILDSTEPS)/install.d

$(BUILDSTEPS)/install.d: $(BUILDSTEPS)/make.d
	cd $(BUILDDIR) && make install
	touch $@

$(BUILDSTEPS)/make.d: $(BUILDSTEPS)/configure.d
	cd $(BUILDDIR) && make all
	touch $@

$(BUILDSTEPS)/configure.d: $(BUILDSTEPS)/builddir.d
	cd $(BUILDDIR) && $(SRCDIR)/configure --prefix=$(PREFIX) --target=$(TARGET_NAME) \
			--with-cpu=m68040 --disable-threads --disable-nls --disable-c-mbchar \
			--enable-languages=c --enable-checking=no --enable-c99 --with-cross-host \
			--disable-multilib --without-x --enable-maintainer-mode
	touch $@

$(BUILDSTEPS)/builddir.d: $(BUILDSTEPS)/srcdir-step3.d
	mkdir -p $(BUILDDIR)
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
	for p in `ls $(RECIPES)/patches/*.p` ; do patch -d $(SRCDIR) -p0 <$$p ; done
	for dir in `find $(RECIPES)/files -type d | grep -v '\.svn' | sed 's#$(RECIPES)/files/##'` ; do mkdir -p $(SRCDIR)/$$dir ; done
	for file in `find $(RECIPES)/files -type f | grep -v '\.svn' | sed 's#$(RECIPES)/files/##'` ; do cp -p $(RECIPES)/files/$$file $(SRCDIR)/$$file ; done
	touch $@

$(BUILDSTEPS)/srcdir-step1.d: $(BUILDSTEPS)/orig.gcc.d
	mkdir -p $(SRCDIR)
	cp -r orig.gcc/* $(SRCDIR)
	touch $@

$(BUILDSTEPS)/orig.gcc.d: $(BUILDSTEPS)/orig.gcc-$(UPSTREAM_TARBALL).d
	tar xjf orig.gcc-$(UPSTREAM_TARBALL)
	mv gcc-$(UPSTREAM_VERSION) orig.gcc
	touch $@

$(BUILDSTEPS)/orig.gcc-$(UPSTREAM_TARBALL).d: $(BUILDSTEPS)/buildsteps.d orig.gcc-$(UPSTREAM_TARBALL)
	touch $@

orig.gcc-$(UPSTREAM_TARBALL):
	wget -q -O $@ $(UPSTREAM_URI)

$(UPSTREAM_GMP_TARBALL):
	wget -q -O $@ $(UPSTREAM_GMP_URI)

$(UPSTREAM_MPFR_TARBALL):
	wget -q -O $@ $(UPSTREAM_MPFR_URI)

$(UPSTREAM_MPC_TARBALL):
	wget -q -O $@ $(UPSTREAM_MPC_URI)

$(BUILDSTEPS)/buildsteps.d:
	mkdir -p $(BUILDSTEPS)
	touch $@
