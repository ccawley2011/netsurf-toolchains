From 385667d2ba86a86f1d44651999d293a797650f30 Mon Sep 17 00:00:00 2001
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Fri, 22 Jan 2016 20:04:50 +0100
Subject: [PATCH 8/9] Added libstc++ support for AmigaOS.

---
 libstdc++-v3/config/os/amigaos/ctype_base.h        |  59 +++++++
 .../config/os/amigaos/ctype_configure_char.cc      |  99 ++++++++++++
 libstdc++-v3/config/os/amigaos/ctype_inline.h      | 173 ++++++++++++++++++++
 libstdc++-v3/config/os/amigaos/error_constants.h   | 178 +++++++++++++++++++++
 libstdc++-v3/config/os/amigaos/os_defines.h        |  43 +++++
 libstdc++-v3/configure.host                        |   3 +
 6 files changed, 555 insertions(+)
 create mode 100644 libstdc++-v3/config/os/amigaos/ctype_base.h
 create mode 100644 libstdc++-v3/config/os/amigaos/ctype_configure_char.cc
 create mode 100644 libstdc++-v3/config/os/amigaos/ctype_inline.h
 create mode 100644 libstdc++-v3/config/os/amigaos/error_constants.h
 create mode 100644 libstdc++-v3/config/os/amigaos/os_defines.h

diff --git a/libstdc++-v3/config/os/amigaos/ctype_base.h b/libstdc++-v3/config/os/amigaos/ctype_base.h
new file mode 100644
index 0000000000000000000000000000000000000000..260b6142b6fc6a11a1e5f0bf7820b592d09f285e
--- /dev/null
+++ libstdc++-v3/config/os/amigaos/ctype_base.h
@@ -0,0 +1,59 @@
+// Locale support -*- C++ -*-
+
+// Copyright (C) 1997-2015 Free Software Foundation, Inc.
+//
+// This file is part of the GNU ISO C++ Library.  This library is free
+// software; you can redistribute it and/or modify it under the
+// terms of the GNU General Public License as published by the
+// Free Software Foundation; either version 3, or (at your option)
+// any later version.
+
+// This library is distributed in the hope that it will be useful,
+// but WITHOUT ANY WARRANTY; without even the implied warranty of
+// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+// GNU General Public License for more details.
+
+// Under Section 7 of GPL version 3, you are granted additional
+// permissions described in the GCC Runtime Library Exception, version
+// 3.1, as published by the Free Software Foundation.
+
+// You should have received a copy of the GNU General Public License and
+// a copy of the GCC Runtime Library Exception along with this program;
+// see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
+// <http://www.gnu.org/licenses/>.
+
+//
+// ISO C++ 14882: 22.1  Locales
+//
+
+// Default information, may not be appropriate for specific host.
+
+namespace std _GLIBCXX_VISIBILITY(default)
+{
+_GLIBCXX_BEGIN_NAMESPACE_VERSION
+
+  /// @brief  Base class for ctype.
+  struct ctype_base
+  {
+    // Non-standard typedefs.
+    typedef const int* 		__to_type;
+
+    // NB: Offsets into ctype<char>::_M_table force a particular size
+    // on the mask type. Because of this, we don't use an enum.
+    typedef unsigned int 	mask;
+    static const mask upper    	= 1 << 0;
+    static const mask lower 	= 1 << 1;
+    static const mask alpha 	= 1 << 2;
+    static const mask digit 	= 1 << 3;
+    static const mask xdigit 	= 1 << 4;
+    static const mask space 	= 1 << 5;
+    static const mask print 	= 1 << 6;
+    static const mask graph 	= (1 << 2) | (1 << 3) | (1 << 9); // alnum|punct
+    static const mask cntrl 	= 1 << 8;
+    static const mask punct 	= 1 << 9;
+    static const mask alnum 	= (1 << 2) | (1 << 3);  // alpha|digit
+    static const mask blank	= 1 << 10;
+  };
+
+_GLIBCXX_END_NAMESPACE_VERSION
+} // namespace
diff --git a/libstdc++-v3/config/os/amigaos/ctype_configure_char.cc b/libstdc++-v3/config/os/amigaos/ctype_configure_char.cc
new file mode 100644
index 0000000000000000000000000000000000000000..e6f4895aee78da54bc6b1e01df00816206361c41
--- /dev/null
+++ libstdc++-v3/config/os/amigaos/ctype_configure_char.cc
@@ -0,0 +1,99 @@
+// Locale support -*- C++ -*-
+
+// Copyright (C) 2011-2015 Free Software Foundation, Inc.
+//
+// This file is part of the GNU ISO C++ Library.  This library is free
+// software; you can redistribute it and/or modify it under the
+// terms of the GNU General Public License as published by the
+// Free Software Foundation; either version 3, or (at your option)
+// any later version.
+
+// This library is distributed in the hope that it will be useful,
+// but WITHOUT ANY WARRANTY; without even the implied warranty of
+// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+// GNU General Public License for more details.
+
+// Under Section 7 of GPL version 3, you are granted additional
+// permissions described in the GCC Runtime Library Exception, version
+// 3.1, as published by the Free Software Foundation.
+
+// You should have received a copy of the GNU General Public License and
+// a copy of the GCC Runtime Library Exception along with this program;
+// see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
+// <http://www.gnu.org/licenses/>.
+
+/** @file ctype_configure_char.cc */
+
+//
+// ISO C++ 14882: 22.1  Locales
+//
+
+#include <locale>
+#include <cstdlib>
+#include <cstring>
+
+namespace std _GLIBCXX_VISIBILITY(default)
+{
+_GLIBCXX_BEGIN_NAMESPACE_VERSION
+
+// Information as gleaned from /usr/include/ctype.h
+
+  const ctype_base::mask*
+  ctype<char>::classic_table() throw()
+  { return 0; }
+
+  ctype<char>::ctype(__c_locale, const mask* __table, bool __del, 
+		     size_t __refs) 
+  : facet(__refs), _M_del(__table != 0 && __del), 
+  _M_toupper(NULL), _M_tolower(NULL), 
+  _M_table(__table ? __table : classic_table()) 
+  { 
+    memset(_M_widen, 0, sizeof(_M_widen));
+    _M_widen_ok = 0;
+    memset(_M_narrow, 0, sizeof(_M_narrow));
+    _M_narrow_ok = 0;
+  }
+
+  ctype<char>::ctype(const mask* __table, bool __del, size_t __refs) 
+  : facet(__refs), _M_del(__table != 0 && __del), 
+  _M_toupper(NULL), _M_tolower(NULL), 
+  _M_table(__table ? __table : classic_table())
+  { 
+    memset(_M_widen, 0, sizeof(_M_widen));
+    _M_widen_ok = 0;
+    memset(_M_narrow, 0, sizeof(_M_narrow));
+    _M_narrow_ok = 0;
+  }
+
+  char
+  ctype<char>::do_toupper(char __c) const
+  { return ::toupper((int) __c); }
+
+  const char*
+  ctype<char>::do_toupper(char* __low, const char* __high) const
+  {
+    while (__low < __high)
+      {
+	*__low = ::toupper((int) *__low);
+	++__low;
+      }
+    return __high;
+  }
+
+  char
+  ctype<char>::do_tolower(char __c) const
+  { return ::tolower((int) __c); }
+
+  const char* 
+  ctype<char>::do_tolower(char* __low, const char* __high) const
+  {
+    while (__low < __high)
+      {
+	*__low = ::tolower((int) *__low);
+	++__low;
+      }
+    return __high;
+  }
+
+_GLIBCXX_END_NAMESPACE_VERSION
+} // namespace
diff --git a/libstdc++-v3/config/os/amigaos/ctype_inline.h b/libstdc++-v3/config/os/amigaos/ctype_inline.h
new file mode 100644
index 0000000000000000000000000000000000000000..cfa0146ae6b70623c2fe63b864ceef7bce0d5fe0
--- /dev/null
+++ libstdc++-v3/config/os/amigaos/ctype_inline.h
@@ -0,0 +1,173 @@
+// Locale support -*- C++ -*-
+
+// Copyright (C) 2000-2015 Free Software Foundation, Inc.
+//
+// This file is part of the GNU ISO C++ Library.  This library is free
+// software; you can redistribute it and/or modify it under the
+// terms of the GNU General Public License as published by the
+// Free Software Foundation; either version 3, or (at your option)
+// any later version.
+
+// This library is distributed in the hope that it will be useful,
+// but WITHOUT ANY WARRANTY; without even the implied warranty of
+// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+// GNU General Public License for more details.
+
+// Under Section 7 of GPL version 3, you are granted additional
+// permissions described in the GCC Runtime Library Exception, version
+// 3.1, as published by the Free Software Foundation.
+
+// You should have received a copy of the GNU General Public License and
+// a copy of the GCC Runtime Library Exception along with this program;
+// see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
+// <http://www.gnu.org/licenses/>.
+
+/** @file bits/ctype_inline.h
+ *  This is an internal header file, included by other library headers.
+ *  Do not attempt to use it directly. @headername{locale}
+ */
+
+//
+// ISO C++ 14882: 22.1  Locales
+//
+  
+// ctype bits to be inlined go here. Non-inlinable (ie virtual do_*)
+// functions go in ctype.cc
+  
+// The following definitions are portable, but insanely slow. If one
+// cares at all about performance, then specialized ctype
+// functionality should be added for the native os in question: see
+// the config/os/bits/ctype_*.h files.
+
+// Constructing a synthetic "C" table should be seriously considered...
+
+namespace std _GLIBCXX_VISIBILITY(default)
+{
+_GLIBCXX_BEGIN_NAMESPACE_VERSION
+
+  bool
+  ctype<char>::
+  is(mask __m, char __c) const
+  { 
+    if (_M_table)
+      return _M_table[static_cast<unsigned char>(__c)] & __m;
+    else
+      {
+	bool __ret = false;
+	const size_t __bitmasksize = 15; 
+	size_t __bitcur = 0; // Lowest bitmask in ctype_base == 0
+	for (; __bitcur <= __bitmasksize; ++__bitcur)
+	  {
+	    const mask __bit = static_cast<mask>(1 << __bitcur);
+	    if (__m & __bit)
+	      {
+		bool __testis;
+		switch (__bit)
+		  {
+		  case space:
+		    __testis = isspace(__c);
+		    break;
+		  case print:
+		    __testis = isprint(__c);
+		    break;
+		  case cntrl:
+		    __testis = iscntrl(__c);
+		    break;
+		  case upper:
+		    __testis = isupper(__c);
+		    break;
+		  case lower:
+		    __testis = islower(__c);
+		    break;
+		  case alpha:
+		    __testis = isalpha(__c);
+		    break;
+		  case digit:
+		    __testis = isdigit(__c);
+		    break;
+		  case punct:
+		    __testis = ispunct(__c);
+		    break;
+		  case xdigit:
+		    __testis = isxdigit(__c);
+		    break;
+		  case alnum:
+		    __testis = isalnum(__c);
+		    break;
+		  case graph:
+		    __testis = isgraph(__c);
+		    break;
+#ifdef _GLIBCXX_USE_C99_CTYPE_TR1
+		  case blank:
+		    __testis = isblank(__c);
+		    break;
+#endif
+		  default:
+		    __testis = false;
+		    break;
+		  }
+		__ret |= __testis;
+	      }
+	  }
+	return __ret;
+      }
+  }
+   
+  const char*
+  ctype<char>::
+  is(const char* __low, const char* __high, mask* __vec) const
+  {
+    if (_M_table)
+      while (__low < __high)
+	*__vec++ = _M_table[static_cast<unsigned char>(*__low++)];
+    else
+      {
+	// Highest bitmask in ctype_base == 11.
+	const size_t __bitmasksize = 15; 
+	for (;__low < __high; ++__vec, ++__low)
+	  {
+	    mask __m = 0;
+	    // Lowest bitmask in ctype_base == 0
+	    size_t __i = 0; 
+	    for (;__i <= __bitmasksize; ++__i)
+	      {
+		const mask __bit = static_cast<mask>(1 << __i);
+		if (this->is(__bit, *__low))
+		  __m |= __bit;
+	      }
+	    *__vec = __m;
+	  }
+      }
+    return __high;
+  }
+
+  const char*
+  ctype<char>::
+  scan_is(mask __m, const char* __low, const char* __high) const
+  {
+    if (_M_table)
+      while (__low < __high
+	     && !(_M_table[static_cast<unsigned char>(*__low)] & __m))
+	++__low;
+    else
+      while (__low < __high && !this->is(__m, *__low))
+	++__low;
+    return __low;
+  }
+
+  const char*
+  ctype<char>::
+  scan_not(mask __m, const char* __low, const char* __high) const
+  {
+    if (_M_table)
+      while (__low < __high
+	     && (_M_table[static_cast<unsigned char>(*__low)] & __m) != 0)
+	++__low;
+    else
+      while (__low < __high && this->is(__m, *__low) != 0)
+	++__low;
+    return __low;
+  }
+
+_GLIBCXX_END_NAMESPACE_VERSION
+} // namespace
diff --git a/libstdc++-v3/config/os/amigaos/error_constants.h b/libstdc++-v3/config/os/amigaos/error_constants.h
new file mode 100644
index 0000000000000000000000000000000000000000..74492cf61c875eac28cb8a86d5bfdb3b8807aa16
--- /dev/null
+++ libstdc++-v3/config/os/amigaos/error_constants.h
@@ -0,0 +1,178 @@
+// Specific definitions for generic platforms  -*- C++ -*-
+
+// Copyright (C) 2007-2015 Free Software Foundation, Inc.
+//
+// This file is part of the GNU ISO C++ Library.  This library is free
+// software; you can redistribute it and/or modify it under the
+// terms of the GNU General Public License as published by the
+// Free Software Foundation; either version 3, or (at your option)
+// any later version.
+
+// This library is distributed in the hope that it will be useful,
+// but WITHOUT ANY WARRANTY; without even the implied warranty of
+// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+// GNU General Public License for more details.
+
+// Under Section 7 of GPL version 3, you are granted additional
+// permissions described in the GCC Runtime Library Exception, version
+// 3.1, as published by the Free Software Foundation.
+
+// You should have received a copy of the GNU General Public License and
+// a copy of the GCC Runtime Library Exception along with this program;
+// see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
+// <http://www.gnu.org/licenses/>.
+
+/** @file bits/error_constants.h
+ *  This is an internal header file, included by other library headers.
+ *  Do not attempt to use it directly. @headername{system_error}
+ */
+
+#ifndef _GLIBCXX_ERROR_CONSTANTS
+#define _GLIBCXX_ERROR_CONSTANTS 1
+
+#include <bits/c++config.h>
+#include <cerrno>
+
+namespace std _GLIBCXX_VISIBILITY(default)
+{
+_GLIBCXX_BEGIN_NAMESPACE_VERSION
+
+  enum class errc
+    {
+      address_family_not_supported = 		EAFNOSUPPORT,
+      address_in_use = 				EADDRINUSE,
+      address_not_available = 			EADDRNOTAVAIL,
+      already_connected = 			EISCONN,
+      argument_list_too_long = 			E2BIG,
+      argument_out_of_domain = 			EDOM,
+      bad_address = 				EFAULT,
+      bad_file_descriptor = 			EBADF,
+
+#ifdef _GLIBCXX_HAVE_EBADMSG
+      bad_message = 				EBADMSG,
+#endif
+
+      broken_pipe = 				EPIPE,
+      connection_aborted = 			ECONNABORTED,
+      connection_already_in_progress = 		EALREADY,
+      connection_refused = 			ECONNREFUSED,
+      connection_reset = 			ECONNRESET,
+      cross_device_link = 			EXDEV,
+      destination_address_required = 		EDESTADDRREQ,
+      device_or_resource_busy = 		EBUSY,
+      directory_not_empty = 			ENOTEMPTY,
+      executable_format_error = 		ENOEXEC,
+      file_exists = 	       			EEXIST,
+      file_too_large = 				EFBIG,
+      filename_too_long = 			ENAMETOOLONG,
+      function_not_supported = 			ENOSYS,
+      host_unreachable = 			EHOSTUNREACH,
+
+#ifdef _GLIBCXX_HAVE_EIDRM
+      identifier_removed = 			EIDRM,
+#endif
+
+      illegal_byte_sequence = 			EILSEQ,
+      inappropriate_io_control_operation = 	ENOTTY,
+      interrupted = 				EINTR,
+      invalid_argument = 			EINVAL,
+      invalid_seek = 				ESPIPE,
+      io_error = 				EIO,
+      is_a_directory = 				EISDIR,
+      message_size = 				EMSGSIZE,
+      network_down = 				ENETDOWN,
+      network_reset = 				ENETRESET,
+      network_unreachable = 			ENETUNREACH,
+      no_buffer_space = 			ENOBUFS,
+      no_child_process = 			ECHILD,
+
+#ifdef _GLIBCXX_HAVE_ENOLINK
+      no_link = 				ENOLINK,
+#endif
+
+      no_lock_available = 			ENOLCK,
+
+#ifdef _GLIBCXX_HAVE_ENODATA
+      no_message_available = 			ENODATA, 
+#endif
+
+      no_message = 				ENOMSG, 
+      no_protocol_option = 			ENOPROTOOPT,
+      no_space_on_device = 			ENOSPC,
+
+#ifdef _GLIBCXX_HAVE_ENOSR
+      no_stream_resources = 			ENOSR,
+#endif
+
+      no_such_device_or_address = 		ENXIO,
+      no_such_device = 				ENODEV,
+      no_such_file_or_directory = 		ENOENT,
+      no_such_process = 			ESRCH,
+      not_a_directory = 			ENOTDIR,
+      not_a_socket = 				ENOTSOCK,
+
+#ifdef _GLIBCXX_HAVE_ENOSTR
+      not_a_stream = 				ENOSTR,
+#endif
+
+      not_connected = 				ENOTCONN,
+      not_enough_memory = 			ENOMEM,
+
+#ifdef _GLIBCXX_HAVE_ENOTSUP
+      not_supported = 				ENOTSUP,
+#endif
+
+#ifdef _GLIBCXX_HAVE_ECANCELED
+      operation_canceled = 			ECANCELED,
+#endif
+
+      operation_in_progress = 			EINPROGRESS,
+      operation_not_permitted = 		EPERM,
+      operation_not_supported = 		EOPNOTSUPP,
+      operation_would_block = 			EWOULDBLOCK,
+
+#ifdef _GLIBCXX_HAVE_EOWNERDEAD
+      owner_dead = 				EOWNERDEAD,
+#endif
+
+      permission_denied = 			EACCES,
+
+#ifdef _GLIBCXX_HAVE_EPROTO
+      protocol_error = 				EPROTO,
+#endif
+
+      protocol_not_supported = 			EPROTONOSUPPORT,
+      read_only_file_system = 			EROFS,
+      resource_deadlock_would_occur = 		EDEADLK,
+      resource_unavailable_try_again = 		EAGAIN,
+      result_out_of_range = 			ERANGE,
+
+#ifdef _GLIBCXX_HAVE_ENOTRECOVERABLE
+      state_not_recoverable = 			ENOTRECOVERABLE,
+#endif
+
+#ifdef _GLIBCXX_HAVE_ETIME
+      stream_timeout = 				ETIME,
+#endif
+
+#ifdef _GLIBCXX_HAVE_ETXTBSY
+      text_file_busy = 				ETXTBSY,
+#endif
+
+      timed_out = 				ETIMEDOUT,
+      too_many_files_open_in_system = 		ENFILE,
+      too_many_files_open = 			EMFILE,
+      too_many_links = 				EMLINK,
+      too_many_symbolic_link_levels = 		ELOOP,
+
+#ifdef _GLIBCXX_HAVE_EOVERFLOW
+      value_too_large = 			EOVERFLOW,
+#endif
+
+      wrong_protocol_type = 			EPROTOTYPE
+    };
+
+_GLIBCXX_END_NAMESPACE_VERSION
+} // namespace
+
+#endif
diff --git a/libstdc++-v3/config/os/amigaos/os_defines.h b/libstdc++-v3/config/os/amigaos/os_defines.h
new file mode 100644
index 0000000000000000000000000000000000000000..346f063958cd7e80ebf97be4acee0bdf391cb811
--- /dev/null
+++ libstdc++-v3/config/os/amigaos/os_defines.h
@@ -0,0 +1,43 @@
+// Specific definitions for AmigaOS -*- C++ -*-
+
+// Copyright (C) 2000-2015 Free Software Foundation, Inc.
+//
+// This file is part of the GNU ISO C++ Library.  This library is free
+// software; you can redistribute it and/or modify it under the
+// terms of the GNU General Public License as published by the
+// Free Software Foundation; either version 3, or (at your option)
+// any later version.
+
+// This library is distributed in the hope that it will be useful,
+// but WITHOUT ANY WARRANTY; without even the implied warranty of
+// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+// GNU General Public License for more details.
+
+// Under Section 7 of GPL version 3, you are granted additional
+// permissions described in the GCC Runtime Library Exception, version
+// 3.1, as published by the Free Software Foundation.
+
+// You should have received a copy of the GNU General Public License and
+// a copy of the GCC Runtime Library Exception along with this program;
+// see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
+// <http://www.gnu.org/licenses/>.
+
+/** @file bits/os_defines.h
+ *  This is an internal header file, included by other library headers.
+ *  Do not attempt to use it directly. @headername{iosfwd}
+ */
+
+#ifndef _GLIBCXX_OS_DEFINES
+#define _GLIBCXX_OS_DEFINES 1
+
+// System-specific #define, typedefs, corrections, etc, go here.  This
+// file will come before all others.
+
+// No ioctl() on AmigaOS
+#define _GLIBCXX_NO_IOCTL 1
+
+#ifdef __NEWLIB__
+#define _GLIBCXX_USE_C99_STDINT_TR1 1
+#endif
+
+#endif
diff --git a/libstdc++-v3/configure.host b/libstdc++-v3/configure.host
index 0b366eafaae8cfa0abd09128bd8ac16b9f775c7c..e54afbc0c30a4b0a40949d9ed78f64661224c253 100644
--- libstdc++-v3/configure.host
+++ libstdc++-v3/configure.host
@@ -223,12 +223,15 @@ case "${host_os}" in
     atomicity_dir="os/aix"
     ;;
   aix*)
     os_include_dir="os/generic"
     atomicity_dir="cpu/generic"
     ;;
+  amigaos*)
+    os_include_dir="os/amigaos"
+    ;;
   bsd*)
     # Plain BSD attempts to share FreeBSD files.
     os_include_dir="os/bsd/freebsd"
     ;;
   cygwin*)
     os_include_dir="os/newlib"
-- 
1.9.1

