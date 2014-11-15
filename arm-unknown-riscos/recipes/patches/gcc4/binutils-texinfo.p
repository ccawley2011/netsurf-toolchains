--- recipe/patches/binutils/binutils.texinfo.p
+++ recipe/patches/binutils/binutils-texinfo.p
@@ -0,0 +1,85 @@
+--- binutils/doc/binutils.texi	29 Oct 2010 12:10:32 -0000	1.173
++++ binutils/doc/binutils.texi	15 Nov 2014 16:24:15 -0000
+@@ -4188,28 +4188,28 @@
+ 
+ @table @env
+ 
+-@itemx --input-mach=@var{machine}
++@item --input-mach=@var{machine}
+ Set the matching input ELF machine type to @var{machine}.  If
+ @option{--input-mach} isn't specified, it will match any ELF
+ machine types.
+ 
+ The supported ELF machine types are, @var{L1OM} and @var{x86-64}.
+ 
+-@itemx --output-mach=@var{machine}
++@item --output-mach=@var{machine}
+ Change the ELF machine type in the ELF header to @var{machine}.  The
+ supported ELF machine types are the same as @option{--input-mach}.
+ 
+-@itemx --input-type=@var{type}
++@item --input-type=@var{type}
+ Set the matching input ELF file type to @var{type}.  If
+ @option{--input-type} isn't specified, it will match any ELF file types.
+ 
+ The supported ELF file types are, @var{rel}, @var{exec} and @var{dyn}.
+ 
+-@itemx --output-type=@var{type}
++@item --output-type=@var{type}
+ Change the ELF file type in the ELF header to @var{type}.  The
+ supported ELF types are the same as @option{--input-type}.
+ 
+-@itemx --input-osabi=@var{osabi}
++@item --input-osabi=@var{osabi}
+ Set the matching input ELF file OSABI to @var{osbi}.  If
+ @option{--input-osabi} isn't specified, it will match any ELF OSABIs.
+ 
+@@ -4218,7 +4218,7 @@
+ @var{FreeBSD}, @var{TRU64}, @var{Modesto}, @var{OpenBSD}, @var{OpenVMS},
+ @var{NSK}, @var{AROS} and @var{FenixOS}.
+ 
+-@itemx --output-osabi=@var{osabi}
++@item --output-osabi=@var{osabi}
+ Change the ELF OSABI in the ELF header to @var{type}.  The
+ supported ELF OSABI are the same as @option{--input-osabi}.
+ 
+--- bfd/doc/bfd.texinfo	28 Oct 2010 11:40:25 -0000	1.18
++++ bfd/doc/bfd.texinfo	15 Nov 2014 16:52:33 -0000
+@@ -322,7 +322,7 @@
+ @printindex cp
+ 
+ @tex
+-% I think something like @colophon should be in texinfo.  In the
++% I think something like @@colophon should be in texinfo.  In the
+ % meantime:
+ \long\def\colophon{\hbox to0pt{}\vfill
+ \centerline{The body of this manual is set in}
+@@ -333,7 +333,7 @@
+ \centerline{{\sl\fontname\tensl\/}}
+ \centerline{are used for emphasis.}\vfill}
+ \page\colophon
+-% Blame: doc@cygnus.com, 28mar91.
++% Blame: doc@@cygnus.com, 28mar91.
+ @end tex
+ 
+ @bye
+--- ld/ld.texinfo	28 Oct 2010 11:40:26 -0000	1.267
++++ ld/ld.texinfo	15 Nov 2014 16:52:35 -0000
+@@ -7682,7 +7682,7 @@
+ @printindex cp
+ 
+ @tex
+-% I think something like @colophon should be in texinfo.  In the
++% I think something like @@colophon should be in texinfo.  In the
+ % meantime:
+ \long\def\colophon{\hbox to0pt{}\vfill
+ \centerline{The body of this manual is set in}
+@@ -7693,7 +7693,7 @@
+ \centerline{{\sl\fontname\tensl\/}}
+ \centerline{are used for emphasis.}\vfill}
+ \page\colophon
+-% Blame: doc@cygnus.com, 28mar91.
++% Blame: doc@@cygnus.com, 28mar91.
+ @end tex
+ 
+ @bye
