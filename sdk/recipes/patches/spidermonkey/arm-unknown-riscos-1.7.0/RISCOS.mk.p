--- js/src/config/RISCOS.mk.orig	2012-12-16 12:03:22.369313976 +0000
+++ js/src/config/RISCOS.mk	2012-12-16 12:03:16.485339267 +0000
@@ -0,0 +1,66 @@
+# -*- Mode: makefile -*-
+#
+# ***** BEGIN LICENSE BLOCK *****
+# Version: MPL 1.1/GPL 2.0/LGPL 2.1
+#
+# The contents of this file are subject to the Mozilla Public License Version
+# 1.1 (the "License"); you may not use this file except in compliance with
+# the License. You may obtain a copy of the License at
+# http://www.mozilla.org/MPL/
+#
+# Software distributed under the License is distributed on an "AS IS" basis,
+# WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
+# for the specific language governing rights and limitations under the
+# License.
+#
+# The Original Code is Mozilla Communicator client code, released
+# March 31, 1998.
+#
+# The Initial Developer of the Original Code is
+# Netscape Communications Corporation.
+# Portions created by the Initial Developer are Copyright (C) 1998
+# the Initial Developer. All Rights Reserved.
+#
+# Contributor(s):
+#
+# Alternatively, the contents of this file may be used under the terms of
+# either the GNU General Public License Version 2 or later (the "GPL"), or
+# the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
+# in which case the provisions of the GPL or the LGPL are applicable instead
+# of those above. If you wish to allow use of your version of this file only
+# under the terms of either the GPL or the LGPL, and not to allow others to
+# use your version of this file under the terms of the MPL, indicate your
+# decision by deleting the provisions above and replace them with the notice
+# and other provisions required by the GPL or the LGPL. If you do not delete
+# the provisions above, a recipient may use your version of this file under
+# the terms of any one of the MPL, the GPL or the LGPL.
+#
+# ***** END LICENSE BLOCK *****
+
+#
+# Config for all versions of Linux
+#
+
+CCC := $(CXX)
+CC ?= gcc 
+CCC ?= g++
+CFLAGS += -static -Wall -Wno-format
+OS_CFLAGS = -DXP_UNIX -DSVR4 -DSYSV -D_BSD_SOURCE -DPOSIX_SOURCE -DHAVE_LOCALTIME_R
+
+RANLIB = echo
+MKSHLIB = $(LD) -shared $(XMKSHLIBOPTS)
+
+#.c.o:
+#      $(CC) -c -MD $*.d $(CFLAGS) $<
+
+CPU_ARCH = arm
+
+GFX_ARCH = x
+
+OS_LIBS = -lm -lc
+
+ASFLAGS += -x assembler-with-cpp
+
+# Use the editline library to provide line-editing support.
+JS_EDITLINE = 1
+
