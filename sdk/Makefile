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
	cd $(BUILDDIR)/zlib && tar xjf $(SOURCEDIR)/zlib-1.2.5.tar.bz2
	for p in `ls $(RECIPES)/patches/zlib/*.p` ; do patch -d $(BUILDDIR)/zlib/zlib-1.2.5 -p0 <$$p ; done
	cd $(BUILDDIR)/zlib/zlib-1.2.5 && ./configure --prefix=$(GCCSDK_INSTALL_ENV)
	cd $(BUILDDIR)/zlib/zlib-1.2.5 && make install
	touch $@

$(BUILDSTEPS)/zlib-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/zlib-1.2.5.tar.bz2
	touch $@

$(SOURCEDIR)/zlib-1.2.5.tar.bz2:
	wget -q -O $@ http://zlib.net/$(subst $(SOURCEDIR)/,,$@)

# libiconv
$(BUILDSTEPS)/libiconv.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/libiconv-src.d
	mkdir -p $(BUILDDIR)/libiconv
	cd $(BUILDDIR)/libiconv && tar xzf $(SOURCEDIR)/libiconv-1.13.1.tar.gz
	for p in `ls $(RECIPES)/patches/libiconv/*.p` ; do patch -d $(BUILDDIR)/libiconv/libiconv-1.13.1 -p0 <$$p ; done
	cd $(BUILDDIR)/libiconv/libiconv-1.13.1 && ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/libiconv/libiconv-1.13.1 && make install
	touch $@

$(BUILDSTEPS)/libiconv-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/libiconv-1.13.1.tar.gz
	touch $@

$(SOURCEDIR)/libiconv-1.13.1.tar.gz:
	wget -q -O $@ http://ftp.gnu.org/pub/gnu/libiconv/$(subst $(SOURCEDIR)/,,$@)

# regex
$(BUILDSTEPS)/libtre.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/libtre-src.d
	mkdir -p $(BUILDDIR)/libtre
	cd $(BUILDDIR)/libtre && tar xjf $(SOURCEDIR)/tre-0.8.0.tar.bz2
	cd $(BUILDDIR)/libtre/tre-0.8.0 && ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/libtre/tre-0.8.0 && make install
	cp $(RECIPES)/files/libtre/regex.h $(GCCSDK_INSTALL_ENV)/include/regex.h
	touch $@

$(BUILDSTEPS)/libtre-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/tre-0.8.0.tar.bz2
	touch $@

$(SOURCEDIR)/tre-0.8.0.tar.bz2:
	wget -q -O $@ http://laurikari.net/tre/$(subst $(SOURCEDIR)/,,$@)

# libXML2
$(BUILDSTEPS)/libxml2.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/libiconv.d $(BUILDSTEPS)/libxml2-src.d
	mkdir -p $(BUILDDIR)/libxml2
	cd $(BUILDDIR)/libxml2 && tar xzf $(SOURCEDIR)/libxml2-2.7.8.tar.gz
	cd $(BUILDDIR)/libxml2/libxml2-2.7.8 && ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/libxml2/libxml2-2.7.8 && make install
	touch $@

$(BUILDSTEPS)/libxml2-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/libxml2-2.7.8.tar.gz
	touch $@

$(SOURCEDIR)/libxml2-2.7.8.tar.gz:
	wget -q -O $@ ftp://xmlsoft.org/libxml2/$(subst $(SOURCEDIR)/,,$@)

# OpenSSL
$(BUILDSTEPS)/openssl.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/openssl-src.d
	mkdir -p $(BUILDDIR)/openssl
	cd $(BUILDDIR)/openssl && tar xzf $(SOURCEDIR)/openssl-1.0.0c.tar.gz
	for p in `ls $(RECIPES)/patches/openssl/*.p` ; do patch -d $(BUILDDIR)/openssl/openssl-1.0.0c -p0 <$$p ; done
	cd $(BUILDDIR)/openssl/openssl-1.0.0c && ./Configure --prefix=$(GCCSDK_INSTALL_ENV) $(TARGET) no-shared no-asm no-threads
	cd $(BUILDDIR)/openssl/openssl-1.0.0c && make install
	touch $@

$(BUILDSTEPS)/openssl-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/openssl-1.0.0c.tar.gz
	touch $@

$(SOURCEDIR)/openssl-1.0.0c.tar.gz:
	wget -q -O $@ http://openssl.org/source/$(subst $(SOURCEDIR)/,,$@)

# libPNG
$(BUILDSTEPS)/libpng.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/libpng-src.d
	mkdir -p $(BUILDDIR)/libpng
	cd $(BUILDDIR)/libpng && tar xzf $(SOURCEDIR)/libpng-1.4.5.tar.gz
	cd $(BUILDDIR)/libpng/libpng-1.4.5 && ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/libpng/libpng-1.4.5 && make install
	touch $@

$(BUILDSTEPS)/libpng-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/libpng-1.4.5.tar.gz
	touch $@

$(SOURCEDIR)/libpng-1.4.5.tar.gz:
	wget -q -O $@ ftp://ftp.simplesystems.org/pub/libpng/png/src/$(subst $(SOURCEDIR)/,,$@)

# libjpeg
# TODO: rename the LOCAL/GLOBAL/EXTERN macros in jmorecfg.h
$(BUILDSTEPS)/libjpeg.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/libjpeg-src.d
	mkdir -p $(BUILDDIR)/libjpeg
	cd $(BUILDDIR)/libjpeg && tar xzf $(SOURCEDIR)/jpegsrc.v8b.tar.gz
	cd $(BUILDDIR)/libjpeg/jpeg-8b && ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/libjpeg/jpeg-8b && make install
	touch $@

$(BUILDSTEPS)/libjpeg-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/jpegsrc.v8b.tar.gz
	touch $@

$(SOURCEDIR)/jpegsrc.v8b.tar.gz:
	wget -q -O $@ http://ijg.org/files/$(subst $(SOURCEDIR)/,,$@)

# liblcms
$(BUILDSTEPS)/liblcms.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/libjpeg.d $(BUILDSTEPS)/liblcms-src.d
	mkdir -p $(BUILDDIR)/liblcms
	cd $(BUILDDIR)/liblcms && tar xzf $(SOURCEDIR)/lcms2-2.1.tar.gz
	cd $(BUILDDIR)/liblcms/lcms2-2.1 && ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/liblcms/lcms2-2.1 && make install
	touch $@

$(BUILDSTEPS)/liblcms-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/lcms2-2.1.tar.gz
	touch $@

$(SOURCEDIR)/lcms2-2.1.tar.gz:
	wget -q -O $@ http://downloads.sourceforge.net/project/lcms/lcms/2.1/$(subst $(SOURCEDIR)/,,$@)

# libMNG
$(BUILDSTEPS)/libmng.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/libjpeg.d $(BUILDSTEPS)/liblcms.d $(BUILDSTEPS)/libmng-src.d
	mkdir -p $(BUILDDIR)/libmng
	cd $(BUILDDIR)/libmng && tar xzf $(SOURCEDIR)/libmng-1.0.10.tar.gz
	for p in `ls $(RECIPES)/patches/libmng/*.p` ; do patch -d $(BUILDDIR)/libmng/libmng-1.0.10 -p0 <$$p ; done
	cp $(BUILDDIR)/libmng/libmng-1.0.10/makefiles/makefile.unix $(BUILDDIR)/libmng/libmng-1.0.10/Makefile
	cd $(BUILDDIR)/libmng/libmng-1.0.10 && make install
	touch $@

$(BUILDSTEPS)/libmng-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/libmng-1.0.10.tar.gz
	touch $@

$(SOURCEDIR)/libmng-1.0.10.tar.gz:
	wget -q -O $@ http://downloads.sourceforge.net/project/libmng/libmng-devel/1.0.10/$(subst $(SOURCEDIR)/,,$@)

# libcares
$(BUILDSTEPS)/libcares.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/libcares-src.d
	mkdir -p $(BUILDDIR)/libcares
	cd $(BUILDDIR)/libcares && tar xzf $(SOURCEDIR)/c-ares-1.7.4.tar.gz
	cd $(BUILDDIR)/libcares/c-ares-1.7.4 && ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared
	cd $(BUILDDIR)/libcares/c-ares-1.7.4 && make install
	touch $@

$(BUILDSTEPS)/libcares-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/c-ares-1.7.4.tar.gz
	touch $@

$(SOURCEDIR)/c-ares-1.7.4.tar.gz:
	wget -q -O $@ http://c-ares.haxx.se/$(subst $(SOURCEDIR)/,,$@)

# libcurl
$(BUILDSTEPS)/libcurl.d: $(BUILDSTEPS)/builddir.d $(BUILDSTEPS)/zlib.d $(BUILDSTEPS)/openssl.d $(BUILDSTEPS)/libcares.d $(BUILDSTEPS)/libcurl-src.d
	mkdir -p $(BUILDDIR)/libcurl
	cd $(BUILDDIR)/libcurl && tar xjf $(SOURCEDIR)/curl-7.21.3.tar.bz2
	for p in `ls $(RECIPES)/patches/libcurl/*.p` ; do patch -d $(BUILDDIR)/libcurl/curl-7.21.3 -p0 <$$p ; done
	cd $(BUILDDIR)/libcurl/curl-7.21.3 && ./configure --prefix=$(GCCSDK_INSTALL_ENV) --target=$(TARGET) --host=$(TARGET) --disable-shared --without-libidn --enable-nonblocking --enable-ares=$(GCCSDK_INSTALL_ENV)/lib --without-random
	cd $(BUILDDIR)/libcurl/curl-7.21.3 && make install
	touch $@

$(BUILDSTEPS)/libcurl-src.d: $(BUILDSTEPS)/sourcedir.d $(SOURCEDIR)/curl-7.21.3.tar.bz2
	touch $@

$(SOURCEDIR)/curl-7.21.3.tar.bz2:
	wget -q -O $@ http://curl.haxx.se/download/$(subst $(SOURCEDIR)/,,$@)

