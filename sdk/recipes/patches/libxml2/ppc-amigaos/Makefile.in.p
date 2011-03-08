--- Makefile.in.old	2011-03-08 21:57:46.000000000 +0000
+++ Makefile.in	2011-03-08 21:58:04.000000000 +0000
@@ -41,9 +41,9 @@
 	testSAX$(EXEEXT) testHTML$(EXEEXT) testXPath$(EXEEXT) \
 	testURI$(EXEEXT) testThreads$(EXEEXT) testC14N$(EXEEXT) \
 	testAutomata$(EXEEXT) testRegexp$(EXEEXT) testReader$(EXEEXT) \
-	testapi$(EXEEXT) testModule$(EXEEXT) runtest$(EXEEXT) \
+	testapi$(EXEEXT) testModule$(EXEEXT) \
 	runsuite$(EXEEXT) testchar$(EXEEXT) testdict$(EXEEXT) \
-	runxmlconf$(EXEEXT) testrecurse$(EXEEXT)
+	runxmlconf$(EXEEXT)
 bin_PROGRAMS = xmllint$(EXEEXT) xmlcatalog$(EXEEXT)
 subdir = .
 DIST_COMMON = README $(am__configure_deps) $(srcdir)/Makefile.am \
