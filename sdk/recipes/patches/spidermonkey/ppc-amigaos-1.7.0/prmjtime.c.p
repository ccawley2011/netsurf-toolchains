--- js/src/prmjtime.c	2005-07-07 22:35:39 
+++ js-amiga/src/prmjtime.c	2012-07-06 21:22:31 
@@ -89,13 +89,17 @@ static void PRMJ_basetime(JSInt64 tsecs,
 JSInt32
 PRMJ_LocalGMTDifference()
 {
-#if defined(XP_UNIX) || defined(XP_WIN) || defined(XP_OS2) || defined(XP_BEOS)
+#if defined(XP_UNIX) || defined(XP_WIN) || defined(XP_OS2) || defined(XP_BEOS) || defined(XP_AMIGA)
     struct tm ltime;
 
     /* get the difference between this time zone and GMT */
     memset((char *)&ltime,0,sizeof(ltime));
     ltime.tm_mday = 2;
+#ifdef XP_AMIGA
+    ltime.tm_year = 78;
+#else
     ltime.tm_year = 70;
+#endif
 #ifdef SUNOS4
     ltime.tm_zone = 0;
     ltime.tm_gmtoff = 0;
@@ -158,11 +162,21 @@ PRMJ_Now(void)
     ten = JSLL_INIT(0, 10);
     FILETIME time, midnight;
 #endif
-#if defined(XP_UNIX) || defined(XP_BEOS)
+#if defined(XP_UNIX) || defined(XP_BEOS) || defined(XP_AMIGA)
     struct timeval tv;
     JSInt64 s, us, s2us;
 #endif /* XP_UNIX */
 
+#if defined(XP_AMIGA)
+	gettimeofday(&tv, 0);
+	JSLL_UI2L(s2us, PRMJ_USEC_PER_SEC);
+	JSLL_UI2L(s, tv.tv_sec);
+	JSLL_UI2L(us, tv.tv_usec);
+	JSLL_MUL(s, s, s2us);
+	JSLL_ADD(s, s, us);
+	return s;
+#endif
+
 #ifdef XP_OS2
     ftime(&b);
     JSLL_UI2L(ms2us, PRMJ_USEC_PER_MSEC);
@@ -268,7 +282,7 @@ PRMJ_DSTOffset(JSInt64 local_time)
 size_t
 PRMJ_FormatTime(char *buf, int buflen, char *fmt, PRMJTime *prtm)
 {
-#if defined(XP_UNIX) || defined(XP_WIN) || defined(XP_OS2) || defined(XP_BEOS)
+#if defined(XP_UNIX) || defined(XP_WIN) || defined(XP_OS2) || defined(XP_BEOS) || defined(XP_AMIGA)
     struct tm a;
 
     /* Zero out the tm struct.  Linux, SunOS 4 struct tm has extra members int

