# Required environment:
#
# GCCSDK_INSTALL_ENV      -- /path/to/install/prefix
# GCCSDK_INSTALL_CROSSBIN -- /path/to/toolchain/bin

ifeq ($(GCCSDK_INSTALL_ENV),)
  $(error GCCSDK_INSTALL_ENV not set)
endif

ifeq ($(GCCSDK_INSTALL_CROSSBIN),)
  $(error GCCSDK_INSTALL_CROSSBIN not set)
endif

# Upstream package versions
VERSION_ZLIB := 1.2.5
VERSION_LIBICONV := 1.13.1
VERSION_LIBTRE := 0.8.0
VERSION_LIBXML := 2.7.8
VERSION_OPENSSL := 1.0.0c
VERSION_LIBPNG := 1.4.5
VERSION_LIBJPEG := 8b
VERSION_LIBLCMS := 2.1
VERSION_LIBMNG := 1.0.10
VERSION_LIBCARES := 1.7.4
VERSION_LIBCURL := 7.21.3

# Path
export PATH := $(GCCSDK_INSTALL_CROSSBIN):$(PATH)

# Tools
export CC := $(wildcard $(GCCSDK_INSTALL_CROSSBIN)/*gcc)
export CXX := $(wildcard $(GCCSDK_INSTALL_CROSSBIN)/*g++)
export AR := $(wildcard $(GCCSDK_INSTALL_CROSSBIN)/*ar)

# Flags
export CFLAGS := -I$(GCCSDK_INSTALL_ENV)/include
export CPPFLAGS := -I$(GCCSDK_INSTALL_ENV)/include
export LDFLAGS := -L$(GCCSDK_INSTALL_ENV)/lib
export PKG_CONFIG_LIBDIR := $(GCCSDK_INSTALL_ENV)/lib/pkgconfig

# Target
TARGET := $(shell $(CC) -dumpmachine)

# Environment
RECIPES := $(CURDIR)/recipes
SOURCEDIR := $(CURDIR)/sources
BUILDDIR := $(CURDIR)/builddir-$(TARGET)
BUILDSTEPS := $(BUILDDIR)/build-steps

# Compute the SDK components
SDK_ITEMS :=

COMMON_SDK_ITEMS := $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/libxml2.d $(BUILDSTEPS)/openssl.d \
		$(BUILDSTEPS)/libpng.d $(BUILDSTEPS)/libjpeg.d $(BUILDSTEPS)/liblcms.d \
		$(BUILDSTEPS)/libmng.d $(BUILDSTEPS)/libcares.d $(BUILDSTEPS)/libcurl.d

ifeq ($(TARGET),m68k-unknown-amigaos)
  SDK_ITEMS := $(BUILDSTEPS)/libiconv.d $(BUILDSTEPS)/libtre.d $(COMMON_SDK_ITEMS)
endif

#ifeq ($(TARGET),arm-unknown-riscos)
#  SDK_ITEMS := $(COMMON_SDK_ITEMS)
#endif

ifeq ($(SDK_ITEMS),)
  $(error Unable to compute SDK components for target $(TARGET))
endif

.PHONY: all clean distclean
all: $(SDK_ITEMS)

clean:
	rm -fr $(BUILDDIR)

distclean:
	rm -fr $(BUILDDIR)
	rm -fr $(SOURCEDIR)

# Sourcedir
$(BUILDSTEPS)/sourcedir.d: $(BUILDSTEPS)/builddir.d
	mkdir -p $(SOURCEDIR)
	touch $@

# Builddir
$(BUILDSTEPS)/builddir.d:
	mkdir -p $(BUILDSTEPS)
	touch $@

# zlib
$(BUILDSTEPS)/zlib.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib-src.d
	mkdir -p $(BUILDDIR)/zlib
	cd $(BUILDDIR)/zlib && tar xjf $(SOURCEDIR)/zlib-$(VERSION_ZLIB).tar.bz2
	for p in `ls $(RECIPES)/patches/zlib/*.p` ; do patch -d $(BUILDDIR)/zlib/zlib-$(VERSION_ZLIB) -p0 <$$p ; done
	cd $(BUILDDIR)/zlib/zlib-$(VERSION_ZLIB) && ./configure --prefix=$(GCCSDK_INSTALL_ENV)
	cd $(BUILDDIR)/zlib/zlib-$(VERSION_ZLIB) && make install
	touch $@

$(BUILDSTEPS)/zlib-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/zlib-$(VERSION_ZLIB).tar.bz2
	touch $@

$(SOURCEDIR)/zlib-$(VERSION_ZLIB).tar.bz2:
	wget -q -O $@ http://zlib.net/$(subst $(SOURCEDIR)/,,$@)

# libiconv
$(BUILDSTEPS)/libiconv.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/libiconv-src.d
	mkdir -p $(BUILDDIR)/libiconv
	cd $(BUILDDIR)/libiconv && tar xzf $(SOURCEDIR)/libiconv-$(VERSION_LIBICONV).tar.gz
	for p in `ls $(RECIPES)/patches/libiconv/*.p` ; do patch -d $(BUILDDIR)/libiconv/libiconv-$(VERSION_LIBICONV) -p0 <$$p ; done
	cd $(BUILDDIR)/libiconv/libiconv-$(VERSION_LIBICONV) && ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/libiconv/libiconv-$(VERSION_LIBICONV) && make install
	touch $@

$(BUILDSTEPS)/libiconv-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/libiconv-$(VERSION_LIBICONV).tar.gz
	touch $@

$(SOURCEDIR)/libiconv-$(VERSION_LIBICONV).tar.gz:
	wget -q -O $@ http://ftp.gnu.org/pub/gnu/libiconv/$(subst $(SOURCEDIR)/,,$@)

# regex
$(BUILDSTEPS)/libtre.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/libtre-src.d
	mkdir -p $(BUILDDIR)/libtre
	cd $(BUILDDIR)/libtre && tar xjf $(SOURCEDIR)/tre-$(VERSION_LIBTRE).tar.bz2
	cd $(BUILDDIR)/libtre/tre-$(VERSION_LIBTRE) && ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/libtre/tre-$(VERSION_LIBTRE) && make install
	cp $(RECIPES)/files/libtre/regex.h $(GCCSDK_INSTALL_ENV)/include/regex.h
	touch $@

$(BUILDSTEPS)/libtre-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/tre-$(VERSION_LIBTRE).tar.bz2
	touch $@

$(SOURCEDIR)/tre-$(VERSION_LIBTRE).tar.bz2:
	wget -q -O $@ http://laurikari.net/tre/$(subst $(SOURCEDIR)/,,$@)

# libXML2
$(BUILDSTEPS)/libxml2.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/libiconv.d $(BUILDSTEPS)/libxml2-src.d
	mkdir -p $(BUILDDIR)/libxml2
	cd $(BUILDDIR)/libxml2 && tar xzf $(SOURCEDIR)/libxml2-$(VERSION_LIBXML).tar.gz
	cd $(BUILDDIR)/libxml2/libxml2-$(VERSION_LIBXML) && ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/libxml2/libxml2-$(VERSION_LIBXML) && make install
	touch $@

$(BUILDSTEPS)/libxml2-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/libxml2-$(VERSION_LIBXML).tar.gz
	touch $@

$(SOURCEDIR)/libxml2-$(VERSION_LIBXML).tar.gz:
	wget -q -O $@ ftp://xmlsoft.org/libxml2/$(subst $(SOURCEDIR)/,,$@)

# OpenSSL
$(BUILDSTEPS)/openssl.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/openssl-src.d
	mkdir -p $(BUILDDIR)/openssl
	cd $(BUILDDIR)/openssl && tar xzf $(SOURCEDIR)/openssl-$(VERSION_OPENSSL).tar.gz
	for p in `ls $(RECIPES)/patches/openssl/*.p` ; do patch -d $(BUILDDIR)/openssl/openssl-$(VERSION_OPENSSL) -p0 <$$p ; done
	cd $(BUILDDIR)/openssl/openssl-$(VERSION_OPENSSL) && ./Configure --prefix=$(GCCSDK_INSTALL_ENV) $(TARGET) no-shared no-asm no-threads
	cd $(BUILDDIR)/openssl/openssl-$(VERSION_OPENSSL) && make install
	touch $@

$(BUILDSTEPS)/openssl-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/openssl-$(VERSION_OPENSSL).tar.gz
	touch $@

$(SOURCEDIR)/openssl-$(VERSION_OPENSSL).tar.gz:
	wget -q -O $@ http://openssl.org/source/$(subst $(SOURCEDIR)/,,$@)

# libPNG
$(BUILDSTEPS)/libpng.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/libpng-src.d
	mkdir -p $(BUILDDIR)/libpng
	cd $(BUILDDIR)/libpng && tar xzf $(SOURCEDIR)/libpng-$(VERSION_LIBPNG).tar.gz
	cd $(BUILDDIR)/libpng/libpng-$(VERSION_LIBPNG) && ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/libpng/libpng-$(VERSION_LIBPNG) && make install
	touch $@

$(BUILDSTEPS)/libpng-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/libpng-$(VERSION_LIBPNG).tar.gz
	touch $@

$(SOURCEDIR)/libpng-$(VERSION_LIBPNG).tar.gz:
	wget -q -O $@ http://downloads.sourceforge.net/project/libpng/libpng14/$(VERSION_LIBPNG)/$(subst $(SOURCEDIR)/,,$@)

# libjpeg
# TODO: rename the LOCAL/GLOBAL/EXTERN macros in jmorecfg.h
$(BUILDSTEPS)/libjpeg.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/libjpeg-src.d
	mkdir -p $(BUILDDIR)/libjpeg
	cd $(BUILDDIR)/libjpeg && tar xzf $(SOURCEDIR)/jpegsrc.v$(VERSION_LIBJPEG).tar.gz
	cd $(BUILDDIR)/libjpeg/jpeg-$(VERSION_LIBJPEG) && ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/libjpeg/jpeg-$(VERSION_LIBJPEG) && make install
	touch $@

$(BUILDSTEPS)/libjpeg-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/jpegsrc.v$(VERSION_LIBJPEG).tar.gz
	touch $@

$(SOURCEDIR)/jpegsrc.v$(VERSION_LIBJPEG).tar.gz:
	wget -q -O $@ http://ijg.org/files/$(subst $(SOURCEDIR)/,,$@)

# liblcms
$(BUILDSTEPS)/liblcms.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/libjpeg.d $(BUILDSTEPS)/liblcms-src.d
	mkdir -p $(BUILDDIR)/liblcms
	cd $(BUILDDIR)/liblcms && tar xzf $(SOURCEDIR)/lcms2-$(VERSION_LIBLCMS).tar.gz
	cd $(BUILDDIR)/liblcms/lcms2-$(VERSION_LIBLCMS) && ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/liblcms/lcms2-$(VERSION_LIBLCMS) && make install
	touch $@

$(BUILDSTEPS)/liblcms-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/lcms2-$(VERSION_LIBLCMS).tar.gz
	touch $@

$(SOURCEDIR)/lcms2-$(VERSION_LIBLCMS).tar.gz:
	wget -q -O $@ http://downloads.sourceforge.net/project/lcms/lcms/$(VERSION_LIBLCMS)/$(subst $(SOURCEDIR)/,,$@)

# libMNG
$(BUILDSTEPS)/libmng.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/libjpeg.d $(BUILDSTEPS)/liblcms.d $(BUILDSTEPS)/libmng-src.d
	mkdir -p $(BUILDDIR)/libmng
	cd $(BUILDDIR)/libmng && tar xzf $(SOURCEDIR)/libmng-$(VERSION_LIBMNG).tar.gz
	for p in `ls $(RECIPES)/patches/libmng/*.p` ; do patch -d $(BUILDDIR)/libmng/libmng-$(VERSION_LIBMNG) -p0 <$$p ; done
	cp $(BUILDDIR)/libmng/libmng-$(VERSION_LIBMNG)/makefiles/makefile.unix $(BUILDDIR)/libmng/libmng-$(VERSION_LIBMNG)/Makefile
	cd $(BUILDDIR)/libmng/libmng-$(VERSION_LIBMNG) && make install
	touch $@

$(BUILDSTEPS)/libmng-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/libmng-$(VERSION_LIBMNG).tar.gz
	touch $@

$(SOURCEDIR)/libmng-$(VERSION_LIBMNG).tar.gz:
	wget -q -O $@ http://downloads.sourceforge.net/project/libmng/libmng-devel/$(VERSION_LIBMNG)/$(subst $(SOURCEDIR)/,,$@)

# libcares
$(BUILDSTEPS)/libcares.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/libcares-src.d
	mkdir -p $(BUILDDIR)/libcares
	cd $(BUILDDIR)/libcares && tar xzf $(SOURCEDIR)/c-ares-$(VERSION_LIBCARES).tar.gz
	cd $(BUILDDIR)/libcares/c-ares-$(VERSION_LIBCARES) && ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/libcares/c-ares-$(VERSION_LIBCARES) && make install
	touch $@

$(BUILDSTEPS)/libcares-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/c-ares-$(VERSION_LIBCARES).tar.gz
	touch $@

$(SOURCEDIR)/c-ares-$(VERSION_LIBCARES).tar.gz:
	wget -q -O $@ http://c-ares.haxx.se/$(subst $(SOURCEDIR)/,,$@)

# libcurl
$(BUILDSTEPS)/libcurl.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/openssl.d $(BUILDSTEPS)/libcares.d $(BUILDSTEPS)/libcurl-src.d
	mkdir -p $(BUILDDIR)/libcurl
	cd $(BUILDDIR)/libcurl && tar xjf $(SOURCEDIR)/curl-$(VERSION_LIBCURL).tar.bz2
	for p in `ls $(RECIPES)/patches/libcurl/*.p` ; do patch -d $(BUILDDIR)/libcurl/curl-$(VERSION_LIBCURL) -p0 <$$p ; done
	cd $(BUILDDIR)/libcurl/curl-$(VERSION_LIBCURL) && ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared --without-libidn --enable-nonblocking --enable-ares=$(GCCSDK_INSTALL_ENV)/lib --without-random
	cd $(BUILDDIR)/libcurl/curl-$(VERSION_LIBCURL) && make install
	touch $@

$(BUILDSTEPS)/libcurl-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/curl-$(VERSION_LIBCURL).tar.bz2
	touch $@

$(SOURCEDIR)/curl-$(VERSION_LIBCURL).tar.bz2:
	wget -q -O $@ http://curl.haxx.se/download/$(subst $(SOURCEDIR)/,,$@)

