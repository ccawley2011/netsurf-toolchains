--- crypto/Makefile	2017-01-26 13:22:03.000000000 +0000
+++ crypto/Makefile	2017-02-08 00:05:03.883009508 +0000
@@ -71,7 +71,7 @@ uplink-x86.s:	$(TOP)/ms/uplink-x86.pl
 
 x86_64cpuid.s: x86_64cpuid.pl;	$(PERL) x86_64cpuid.pl $(PERLASM_SCHEME) > $@
 ia64cpuid.s: ia64cpuid.S;	$(CC) $(CFLAGS) -E ia64cpuid.S > $@
-ppccpuid.s:	ppccpuid.pl;	$(PERL) ppccpuid.pl $(PERLASM_SCHEME) $@
+ppccpuid.s:	ppccpuid.pl;	$(PERL) ppccpuid.pl $(PERLASM_SCHEME) > $@
 pariscid.s:	pariscid.pl;	$(PERL) pariscid.pl $(PERLASM_SCHEME) $@
 alphacpuid.s:	alphacpuid.pl
 	(preproc=$$$$.$@.S; trap "rm $$preproc" INT; \
