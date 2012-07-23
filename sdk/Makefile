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
VERSION_ZLIB := 1.2.7
VERSION_LIBICONV := 1.13.1
VERSION_LIBTRE := 0.8.0
VERSION_LIBXML := 2.7.8
VERSION_OPENSSL := 1.0.0c
VERSION_LIBPNG := 1.5.12
VERSION_LIBJPEG := 8b
VERSION_LIBLCMS := 2.1
VERSION_LIBMNG := 1.0.10
VERSION_LIBCARES := 1.9.1
VERSION_LIBCURL := 7.26.0
VERSION_LIBGNURX := 2.5.1

# Path
path__ := $(GCCSDK_INSTALL_CROSSBIN):$(PATH)

# Tools
cc__ := $(wildcard $(GCCSDK_INSTALL_CROSSBIN)/*gcc)
cxx__ := $(wildcard $(GCCSDK_INSTALL_CROSSBIN)/*g++)
ar__ := $(wildcard $(GCCSDK_INSTALL_CROSSBIN)/*ar)
ranlib__ := $(wildcard $(GCCSDK_INSTALL_CROSSBIN)/*ranlib)

# Flags
cflags__ := -I$(GCCSDK_INSTALL_ENV)/include
cppflags__ := -I$(GCCSDK_INSTALL_ENV)/include
ldflags__ := -L$(GCCSDK_INSTALL_ENV)/lib
pkg_config_libdir__ := $(GCCSDK_INSTALL_ENV)/lib/pkgconfig

# Target
TARGET := $(shell $(cc__) -dumpmachine)

# Environment
env := PATH="$(path__)" CC="$(cc__)" CXX="$(cxx__)" AR="$(ar__)" RANLIB="$(ranlib__)" CFLAGS="$(cflags__)" CPPFLAGS="$(cppflags__)" LDFLAGS="$(ldflags__)" PKG_CONFIG_LIBDIR="$(pkg_config_libdir__)"

RECIPES := $(CURDIR)/recipes
SOURCEDIR := $(CURDIR)/sources
BUILDDIR := $(CURDIR)/builddir-$(TARGET)
BUILDSTEPS := $(BUILDDIR)/build-steps

# Compute the SDK components
SDK_ITEMS :=

COMMON_SDK_ITEMS := $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/libxml2.d $(BUILDSTEPS)/openssl.d \
		$(BUILDSTEPS)/libpng.d $(BUILDSTEPS)/libjpeg.d $(BUILDSTEPS)/liblcms.d \
		$(BUILDSTEPS)/libmng.d $(BUILDSTEPS)/libcares.d $(BUILDSTEPS)/libcurl.d

ifeq ($(TARGET),m68k-atari-mint)
  EXTRAARGS_LIBXML := --enable-ipv6=no
  SDK_ITEMS := $(BUILDSTEPS)/libiconv.d $(COMMON_SDK_ITEMS)
  EXTRAARGS_LIBCARES := --disable-shared
endif

ifeq ($(TARGET),m68k-unknown-amigaos)
  SDK_ITEMS := $(BUILDSTEPS)/libiconv.d $(BUILDSTEPS)/libtre.d $(COMMON_SDK_ITEMS)
  EXTRAARGS_LIBCARES := --disable-shared
endif

ifeq ($(TARGET),arm-unknown-riscos)
  SDK_ITEMS := $(COMMON_SDK_ITEMS)
  EXTRAARGS_LIBCARES := --disable-shared
endif

ifeq ($(TARGET),ppc-amigaos)
  SDK_ITEMS := $(BUILDSTEPS)/libtre.d $(COMMON_SDK_ITEMS)
  EXTRAARGS_LIBCARES := --disable-shared
  VERSION_LIBCURL := 7.21.3
endif

ifeq ($(TARGET),i686-w64-mingw32)
  SDK_ITEMS := $(BUILDSTEPS)/libiconv.d $(BUILDSTEPS)/libgnurx.d $(COMMON_SDK_ITEMS)
endif

ifeq ($(SDK_ITEMS),)
  $(error Unable to compute SDK components for target $(TARGET))
endif

.PHONY: all clean distclean
all: $(SDK_ITEMS)

clean:
	rm -fr $(BUILDDIR)

distclean: clean
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
ifneq ($(realpath $(RECIPES)/patches/zlib/$(TARGET)),)
	for p in `ls $(RECIPES)/patches/zlib/$(TARGET)/*.p` ; do patch -d $(BUILDDIR)/zlib/zlib-$(VERSION_ZLIB) -p0 <$$p ; done
endif
	cd $(BUILDDIR)/zlib/zlib-$(VERSION_ZLIB) && $(env) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --static
	cd $(BUILDDIR)/zlib/zlib-$(VERSION_ZLIB) && $(env) make install
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
	cd $(BUILDDIR)/libiconv/libiconv-$(VERSION_LIBICONV) && $(env) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/libiconv/libiconv-$(VERSION_LIBICONV) && $(env) make install
	touch $@

$(BUILDSTEPS)/libiconv-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/libiconv-$(VERSION_LIBICONV).tar.gz
	touch $@

$(SOURCEDIR)/libiconv-$(VERSION_LIBICONV).tar.gz:
	wget -q -O $@ http://ftp.gnu.org/pub/gnu/libiconv/$(subst $(SOURCEDIR)/,,$@)

# libgnurx
$(BUILDSTEPS)/libgnurx.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/libgnurx-src.d
	mkdir -p $(BUILDDIR)/libgnurx
	cd $(BUILDDIR)/libgnurx && tar xzf $(SOURCEDIR)/libgnurx-$(VERSION_LIBGNURX).tar.gz
	for p in `ls $(RECIPES)/patches/libgnurx/*.p` ; do patch -d $(BUILDDIR)/libgnurx/mingw-libgnurx-$(VERSION_LIBGNURX) -p0 <$$p ; done
	cd $(BUILDDIR)/libgnurx/mingw-libgnurx-$(VERSION_LIBGNURX) && $(env) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) 
	cd $(BUILDDIR)/libgnurx/mingw-libgnurx-$(VERSION_LIBGNURX) && $(env) make
	cd $(BUILDDIR)/libgnurx/mingw-libgnurx-$(VERSION_LIBGNURX) && $(env) make install
	touch $@

$(BUILDSTEPS)/libgnurx-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/libgnurx-$(VERSION_LIBGNURX).tar.gz
	touch $@

$(SOURCEDIR)/libgnurx-$(VERSION_LIBGNURX).tar.gz:
	wget -q -O $@ "http://downloads.sourceforge.net/project/mingw/Other/UserContributed/regex/mingw-regex-$(VERSION_LIBGNURX)/mingw-libgnurx-$(VERSION_LIBGNURX)-src.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fmingw%2Ffiles%2FOther%2FUserContributed%2Fregex%2Fmingw-regex-2.5.1%2F&ts=1343071687&use_mirror=freefr"

# regex
$(BUILDSTEPS)/libtre.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/libtre-src.d
	mkdir -p $(BUILDDIR)/libtre
	cd $(BUILDDIR)/libtre && tar xjf $(SOURCEDIR)/tre-$(VERSION_LIBTRE).tar.bz2
	cd $(BUILDDIR)/libtre/tre-$(VERSION_LIBTRE) && $(env) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/libtre/tre-$(VERSION_LIBTRE) && $(env) make install
	cp $(RECIPES)/files/libtre/regex.h $(GCCSDK_INSTALL_ENV)/include/regex.h
	touch $@

$(BUILDSTEPS)/libtre-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/tre-$(VERSION_LIBTRE).tar.bz2
	touch $@

$(SOURCEDIR)/tre-$(VERSION_LIBTRE).tar.bz2:
	wget -q -O $@ http://laurikari.net/tre/$(subst $(SOURCEDIR)/,,$@)

# libXML2
$(BUILDSTEPS)/libxml2.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/libxml2-src.d
	mkdir -p $(BUILDDIR)/libxml2
	cd $(BUILDDIR)/libxml2 && tar xzf $(SOURCEDIR)/libxml2-$(VERSION_LIBXML).tar.gz
	for p in `ls $(RECIPES)/patches/libxml2/*.p` ; do patch -d $(BUILDDIR)/libxml2/libxml2-$(VERSION_LIBXML) -p0 <$$p ; done
ifneq ($(realpath $(RECIPES)/patches/libxml2/$(TARGET)),)
	for p in `ls $(RECIPES)/patches/libxml2/$(TARGET)/*.p` ; do patch -d $(BUILDDIR)/libxml2/libxml2-$(VERSION_LIBXML) -p0 <$$p ; done
endif
	cd $(BUILDDIR)/libxml2/libxml2-$(VERSION_LIBXML) && $(env) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared --without-python $(EXTRAARGS_LIBXML)
	cd $(BUILDDIR)/libxml2/libxml2-$(VERSION_LIBXML) && $(env) make install
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
ifneq ($(realpath $(RECIPES)/patches/openssl/$(TARGET)),)
	for p in `ls $(RECIPES)/patches/openssl/$(TARGET)/*.p` ; do patch -d $(BUILDDIR)/openssl/openssl-$(VERSION_OPENSSL) -p0 <$$p ; done
endif
	cd $(BUILDDIR)/openssl/openssl-$(VERSION_OPENSSL) && $(env) ./Configure --prefix=$(GCCSDK_INSTALL_ENV) $(TARGET) no-shared no-asm no-threads
	cd $(BUILDDIR)/openssl/openssl-$(VERSION_OPENSSL) && $(env) make install
	touch $@

$(BUILDSTEPS)/openssl-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/openssl-$(VERSION_OPENSSL).tar.gz
	touch $@

$(SOURCEDIR)/openssl-$(VERSION_OPENSSL).tar.gz:
	wget -q -O $@ http://openssl.org/source/$(subst $(SOURCEDIR)/,,$@)

# libPNG
$(BUILDSTEPS)/libpng.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/libpng-src.d
	mkdir -p $(BUILDDIR)/libpng
	cd $(BUILDDIR)/libpng && tar xzf $(SOURCEDIR)/libpng-$(VERSION_LIBPNG).tar.gz
ifneq ($(realpath $(RECIPES)/patches/libpng/$(TARGET)),)
	for p in `ls $(RECIPES)/patches/libpng/$(TARGET)/*.p` ; do patch -d $(BUILDDIR)/libpng/libpng-$(VERSION_LIBPNG) -p0 <$$p ; done
endif
	cd $(BUILDDIR)/libpng/libpng-$(VERSION_LIBPNG) && $(env) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/libpng/libpng-$(VERSION_LIBPNG) && $(env) make install
	touch $@

$(BUILDSTEPS)/libpng-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/libpng-$(VERSION_LIBPNG).tar.gz
	touch $@

$(SOURCEDIR)/libpng-$(VERSION_LIBPNG).tar.gz:
	wget -q -O $@ http://downloads.sourceforge.net/libpng/$(subst $(SOURCEDIR)/,,$@)

# libjpeg
$(BUILDSTEPS)/libjpeg.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/libjpeg-src.d
	mkdir -p $(BUILDDIR)/libjpeg
	cd $(BUILDDIR)/libjpeg && tar xzf $(SOURCEDIR)/jpegsrc.v$(VERSION_LIBJPEG).tar.gz
	for p in `ls $(RECIPES)/patches/libjpeg/*.p` ; do patch -d $(BUILDDIR)/libjpeg/jpeg-$(VERSION_LIBJPEG) -p0 <$$p ; done
	cd $(BUILDDIR)/libjpeg/jpeg-$(VERSION_LIBJPEG) && $(env) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/libjpeg/jpeg-$(VERSION_LIBJPEG) && $(env) make install
	touch $@

$(BUILDSTEPS)/libjpeg-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/jpegsrc.v$(VERSION_LIBJPEG).tar.gz
	touch $@

$(SOURCEDIR)/jpegsrc.v$(VERSION_LIBJPEG).tar.gz:
	wget -q -O $@ http://ijg.org/files/$(subst $(SOURCEDIR)/,,$@)

# liblcms
$(BUILDSTEPS)/liblcms.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/libjpeg.d $(BUILDSTEPS)/liblcms-src.d
	mkdir -p $(BUILDDIR)/liblcms
	cd $(BUILDDIR)/liblcms && tar xzf $(SOURCEDIR)/lcms2-$(VERSION_LIBLCMS).tar.gz
	for p in `ls $(RECIPES)/patches/liblcms/*.p` ; do patch -d $(BUILDDIR)/liblcms/lcms2-$(VERSION_LIBLCMS) -p0 <$$p ; done
ifneq ($(realpath $(RECIPES)/patches/liblcms/$(TARGET)),)
	for p in `ls $(RECIPES)/patches/liblcms/$(TARGET)/*.p` ; do patch -d $(BUILDDIR)/liblcms/lcms2-$(VERSION_LIBLCMS) -p0 <$$p ; done
endif
	cd $(BUILDDIR)/liblcms/lcms2-$(VERSION_LIBLCMS) && $(env) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/liblcms/lcms2-$(VERSION_LIBLCMS) && $(env) make install
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
	cd $(BUILDDIR)/libmng/libmng-$(VERSION_LIBMNG) && $(env) make install
	touch $@

$(BUILDSTEPS)/libmng-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/libmng-$(VERSION_LIBMNG).tar.gz
	touch $@

$(SOURCEDIR)/libmng-$(VERSION_LIBMNG).tar.gz:
	wget -q -O $@ http://downloads.sourceforge.net/project/libmng/libmng-devel/$(VERSION_LIBMNG)/$(subst $(SOURCEDIR)/,,$@)

# libcares
$(BUILDSTEPS)/libcares.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/libcares-src.d
	mkdir -p $(BUILDDIR)/libcares
	cd $(BUILDDIR)/libcares && tar xzf $(SOURCEDIR)/c-ares-$(VERSION_LIBCARES).tar.gz
	for p in `ls $(RECIPES)/patches/libcares/*.p` ; do patch -d $(BUILDDIR)/libcares/c-ares-$(VERSION_LIBCARES) -p0 <$$p ; done
ifneq ($(realpath $(RECIPES)/patches/libcares/$(TARGET)),)
	for p in `ls $(RECIPES)/patches/libcares/$(TARGET)/*.p` ; do patch -d $(BUILDDIR)/libcares/c-ares-$(VERSION_LIBCARES) -p0 <$$p ; done
endif
	cd $(BUILDDIR)/libcares/c-ares-$(VERSION_LIBCARES) && $(env) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) $(EXTRAARGS_LIBCARES)
	cd $(BUILDDIR)/libcares/c-ares-$(VERSION_LIBCARES) && $(env) make install
	touch $@

$(BUILDSTEPS)/libcares-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/c-ares-$(VERSION_LIBCARES).tar.gz
	touch $@

$(SOURCEDIR)/c-ares-$(VERSION_LIBCARES).tar.gz:
	wget -q -O $@ http://c-ares.haxx.se/download/$(subst $(SOURCEDIR)/,,$@)

# libcurl
$(BUILDSTEPS)/libcurl.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/openssl.d $(BUILDSTEPS)/libcares.d $(BUILDSTEPS)/libcurl-src.d
	mkdir -p $(BUILDDIR)/libcurl
	cd $(BUILDDIR)/libcurl && tar xjf $(SOURCEDIR)/curl-$(VERSION_LIBCURL).tar.bz2
	for p in `ls $(RECIPES)/patches/libcurl/*.p` ; do patch -d $(BUILDDIR)/libcurl/curl-$(VERSION_LIBCURL) -p0 <$$p ; done
ifneq ($(realpath $(RECIPES)/patches/libcurl/$(TARGET)),)
	for p in `ls $(RECIPES)/patches/libcurl/$(TARGET)/*.p` ; do patch -d $(BUILDDIR)/libcurl/curl-$(VERSION_LIBCURL) -p0 <$$p ; done
endif
	cd $(BUILDDIR)/libcurl/curl-$(VERSION_LIBCURL) && $(env) ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared --without-libidn --enable-nonblocking --enable-ares --without-random
	cd $(BUILDDIR)/libcurl/curl-$(VERSION_LIBCURL) && $(env) make install
	touch $@

$(BUILDSTEPS)/libcurl-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/curl-$(VERSION_LIBCURL).tar.bz2
	touch $@

$(SOURCEDIR)/curl-$(VERSION_LIBCURL).tar.bz2:
	wget -q -O $@ http://curl.haxx.se/download/$(subst $(SOURCEDIR)/,,$@)

