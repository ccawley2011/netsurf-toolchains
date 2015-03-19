--- apps.c	2014-10-15 13:53:39.000000000 +0100
+++ apps/apps.c	2015-01-05 21:02:13.650018727 +0000
@@ -2872,11 +2872,12 @@ double app_tminterval(int stop,int usert
     struct rusage rus;
     struct timeval now;
     static struct timeval tmstart;
-
+#if !defined(OPENSSL_SYS_AMIGAOS3)
     if (usertime)
         getrusage(RUSAGE_SELF, &rus), now = rus.ru_utime;
     else
+#endif
         gettimeofday(&now, NULL);
 
     if (stop == TM_START)
