--- recipe/patches/binutils/binutils.texinfo.p
+++ recipe/patches/binutils/binutils-texinfo.p
@@ -0,0 +1,362 @@
+Index: bfd/doc/bfd.texinfo
+===================================================================
+RCS file: /cvs/src/src/bfd/doc/bfd.texinfo,v
+retrieving revision 1.18
+diff -u -r1.18 bfd.texinfo
+--- bfd/doc/bfd.texinfo	28 Oct 2010 11:40:25 -0000	1.18
++++ bfd/doc/bfd.texinfo	15 Nov 2014 18:00:35 -0000
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
+Index: binutils/doc/binutils.texi
+===================================================================
+RCS file: /cvs/src/src/binutils/doc/binutils.texi,v
+retrieving revision 1.173
+diff -u -r1.173 binutils.texi
+--- binutils/doc/binutils.texi	29 Oct 2010 12:10:32 -0000	1.173
++++ binutils/doc/binutils.texi	15 Nov 2014 18:00:36 -0000
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
+Index: gas/doc/c-arc.texi
+===================================================================
+RCS file: /cvs/src/src/gas/doc/c-arc.texi,v
+retrieving revision 1.9
+diff -u -r1.9 c-arc.texi
+--- gas/doc/c-arc.texi	2 Sep 2009 07:24:21 -0000	1.9
++++ gas/doc/c-arc.texi	15 Nov 2014 18:00:36 -0000
+@@ -212,7 +212,7 @@
+ encodings for use of these instructions according to the specification
+ by the user.  The parameters are:
+ 
+-@table @bullet
++@itemize @bullet
+ @item @var{name}
+ Name of the extension instruction 
+ 
+@@ -271,7 +271,7 @@
+ with SYNTAX_20P.
+ 
+ @end itemize 
+-@end table
++@end itemize
+ 
+ For example, defining 64-bit multiplier with immediate operands:
+ 
+Index: gas/doc/c-arm.texi
+===================================================================
+RCS file: /cvs/src/src/gas/doc/c-arm.texi,v
+retrieving revision 1.81
+diff -u -r1.81 c-arm.texi
+--- gas/doc/c-arm.texi	23 Sep 2010 15:52:18 -0000	1.81
++++ gas/doc/c-arm.texi	15 Nov 2014 18:00:36 -0000
+@@ -376,7 +376,7 @@
+ @code{unified} syntax, which can be selected via the @code{.syntax}
+ directive, and has the following main features:
+ 
+-@table @bullet
++@itemize @bullet
+ @item
+ Immediate operands do not require a @code{#} prefix.
+ 
+@@ -401,7 +401,7 @@
+ @item
+ All instructions set the flags if and only if they have an @code{s}
+ affix.
+-@end table
++@end itemize
+ 
+ @node ARM-Chars
+ @subsection Special Characters
+@@ -433,28 +433,6 @@
+ @cindex register names, ARM
+ *TODO* Explain about ARM register naming, and the predefined names.
+ 
+-@node ARM-Neon-Alignment
+-@subsection NEON Alignment Specifiers
+-
+-@cindex alignment for NEON instructions
+-Some NEON load/store instructions allow an optional address
+-alignment qualifier.
+-The ARM documentation specifies that this is indicated by
+-@samp{@@ @var{align}}. However GAS already interprets
+-the @samp{@@} character as a "line comment" start,
+-so @samp{: @var{align}} is used instead.  For example:
+-
+-@smallexample
+-        vld1.8 @{q0@}, [r0, :128]
+-@end smallexample
+-
+-@node ARM Floating Point
+-@section Floating Point
+-
+-@cindex floating point, ARM (@sc{ieee})
+-@cindex ARM floating point (@sc{ieee})
+-The ARM family uses @sc{ieee} floating-point numbers.
+-
+ @node ARM-Relocations
+ @subsection ARM relocation generation
+ 
+@@ -497,6 +475,28 @@
+         MOVT r0, #:upper16:foo
+ @end smallexample
+ 
++@node ARM-Neon-Alignment
++@subsection NEON Alignment Specifiers
++
++@cindex alignment for NEON instructions
++Some NEON load/store instructions allow an optional address
++alignment qualifier.
++The ARM documentation specifies that this is indicated by
++@samp{@@ @var{align}}. However GAS already interprets
++the @samp{@@} character as a "line comment" start,
++so @samp{: @var{align}} is used instead.  For example:
++
++@smallexample
++        vld1.8 @{q0@}, [r0, :128]
++@end smallexample
++
++@node ARM Floating Point
++@section Floating Point
++
++@cindex floating point, ARM (@sc{ieee})
++@cindex ARM floating point (@sc{ieee})
++The ARM family uses @sc{ieee} floating-point numbers.
++
+ @node ARM Directives
+ @section ARM Machine Directives
+ 
+Index: gas/doc/c-cr16.texi
+===================================================================
+RCS file: /cvs/src/src/gas/doc/c-cr16.texi,v
+retrieving revision 1.3
+diff -u -r1.3 c-cr16.texi
+--- gas/doc/c-cr16.texi	2 Sep 2009 07:24:21 -0000	1.3
++++ gas/doc/c-cr16.texi	15 Nov 2014 18:00:36 -0000
+@@ -43,26 +43,26 @@
+ CR16 target operand qualifiers and its size (in bits):
+ 
+ @table @samp
+-@item Immediate Operand
+-- s ---- 4 bits
+-@item 
+-- m ---- 16 bits, for movb and movw instructions.
+-@item 
+-- m ---- 20 bits, movd instructions.
+-@item 
+-- l ---- 32 bits
+-
+-@item Absolute Operand
+-- s ---- Illegal specifier for this operand.
+-@item  
+-- m ---- 20 bits, movd instructions.
+-
+-@item Displacement Operand
+-- s ---- 8 bits
+-@item
+-- m ---- 16 bits
+-@item 
+-- l ---- 24 bits
++@item Immediate Operand: s
++4 bits
++@item Immediate Operand: m
++16 bits, for movb and movw instructions.
++@item Immediate Operand: m
++20 bits, movd instructions.
++@item Immediate Operand: l
++32 bits
++
++@item Absolute Operand: s
++Illegal specifier for this operand.
++@item Absolute Operand: m
++20 bits, movd instructions.
++
++@item Displacement Operand: s
++8 bits
++@item Displacement Operand: m
++16 bits
++@item Displacement Operand: l
++24 bits
+ @end table
+ 
+ For example:
+Index: gas/doc/c-mips.texi
+===================================================================
+RCS file: /cvs/src/src/gas/doc/c-mips.texi,v
+retrieving revision 1.56
+diff -u -r1.56 c-mips.texi
+--- gas/doc/c-mips.texi	4 Oct 2010 15:24:48 -0000	1.56
++++ gas/doc/c-mips.texi	15 Nov 2014 18:00:36 -0000
+@@ -220,7 +220,7 @@
+ instructions around accesses to the @samp{HI} and @samp{LO} registers.
+ @samp{-no-m4650} turns off this option.
+ 
+-@itemx -m3900
++@item -m3900
+ @itemx -no-m3900
+ @itemx -m4100
+ @itemx -no-m4100
+Index: gas/doc/c-score.texi
+===================================================================
+RCS file: /cvs/src/src/gas/doc/c-score.texi,v
+retrieving revision 1.1
+diff -u -r1.1 c-score.texi
+--- gas/doc/c-score.texi	2 Mar 2009 10:33:07 -0000	1.1
++++ gas/doc/c-score.texi	15 Nov 2014 18:00:36 -0000
+@@ -36,7 +36,7 @@
+ @item -EB
+ Assemble code for a big-endian cpu
+ 
+-@itemx -EL
++@item -EL
+ Assemble code for a little-endian cpu
+ 
+ @item -FIXDD 
+@@ -48,13 +48,13 @@
+ @item -SCORE5
+ Assemble code for target is SCORE5
+ 
+-@itemx -SCORE5U
++@item -SCORE5U
+ Assemble code for target is SCORE5U
+ 
+-@itemx -SCORE7
++@item -SCORE7
+ Assemble code for target is SCORE7, this is default setting
+ 
+-@itemx -SCORE3
++@item -SCORE3
+ Assemble code for target is SCORE3
+ 
+ @item -march=score7
+Index: gas/doc/c-tic54x.texi
+===================================================================
+RCS file: /cvs/src/src/gas/doc/c-tic54x.texi,v
+retrieving revision 1.8
+diff -u -r1.8 c-tic54x.texi
+--- gas/doc/c-tic54x.texi	21 Jun 2010 10:49:41 -0000	1.8
++++ gas/doc/c-tic54x.texi	15 Nov 2014 18:00:36 -0000
+@@ -108,7 +108,7 @@
+ is replaced with x.  At this point, x has already been encountered
+ and the substitution stops.
+ 
+-@smallexample @code
++@smallexample
+  .asg   "x",SYM1 
+  .asg   "SYM1",SYM2
+  .asg   "SYM2",x
+@@ -125,14 +125,14 @@
+ ambiguous by placing colons on either side of the subsym.  The following
+ code: 
+ 
+-@smallexample @code
++@smallexample
+  .eval  "10",x
+ LAB:X:  add     #x, a
+ @end smallexample
+ 
+ When assembled becomes:
+ 
+-@smallexample @code
++@smallexample
+ LAB10  add     #10, a
+ @end smallexample
+ 
+@@ -308,7 +308,7 @@
+ of a label or address.  For example, if an address @code{_label} resides
+ in extended program memory, the value of @code{_label} may be loaded as
+ follows:
+-@smallexample @code
++@smallexample
+  ldx     #_label,16,a    ; loads extended bits of _label
+  or      #_label,a       ; loads lower 16 bits of _label
+  bacc    a               ; full address is in accumulator A
+@@ -344,7 +344,7 @@
+ performed on @var{string} before assignment.
+ 
+ @cindex @code{eval} directive, TIC54X
+-@itemx .eval @var{string}, @var{name}
++@item .eval @var{string}, @var{name}
+ Evaluate the contents of string @var{string} and assign the result as a
+ string to the subsym @var{name}.  String replacement is performed on
+ @var{string} before assignment. 
+Index: ld/ld.texinfo
+===================================================================
+RCS file: /cvs/src/src/ld/ld.texinfo,v
+retrieving revision 1.267
+diff -u -r1.267 ld.texinfo
+--- ld/ld.texinfo	28 Oct 2010 11:40:26 -0000	1.267
++++ ld/ld.texinfo	15 Nov 2014 18:00:37 -0000
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
