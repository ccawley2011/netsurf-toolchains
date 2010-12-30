# Going to use a known revision of trunk, until there's a release version that suits
UPSTREAM_GCCSDK_VERSION := 4957
UPSTREAM_GCCSDK_TARBALL := gcc4
UPSTREAM_GCCSDK_URI := svn://svn.riscos.info/gccsdk/trunk/gcc4@$(UPSTREAM_GCCSDK_VERSION)

TOP := $(CURDIR)
RECIPES := $(TOP)/recipes

TARGET_NAME := arm-unknown-riscos

PREFIX ?= /opt/netsurf/$(TARGET_NAME)

.PHONY: all clean distclean
all: $(UPSTREAM_GCCSDK_TARBALL)
	cp -p $(RECIPES)/files/gcc4/gccsdk-params gcc4/gccsdk-params
	sed -i 's#{PREFIX}#$(PREFIX)#' gcc4/gccsdk-params
	cd gcc4 && make

clean:
	cd gcc4 && make clean

distclean: clean
	rm -fr gcc4

###
# Rules to fetch upstream sources
###

$(UPSTREAM_GCCSDK_TARBALL):
	svn co $(UPSTREAM_GCCSDK_URI) $@

