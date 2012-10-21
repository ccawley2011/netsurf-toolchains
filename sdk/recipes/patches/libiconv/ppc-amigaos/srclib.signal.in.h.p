--- srclib/signal.in.h.old	2012-10-21 01:08:10.000000000 +0100
+++ srclib/signal.in.h	2012-10-21 01:10:19.000000000 +0100
@@ -76,26 +76,6 @@
 /* This code supports only 32 signals.  */
 typedef int verify_NSIG_constraint[2 * (NSIG <= 32) - 1];
 
-/* A set or mask of signals.  */
-# if !@HAVE_SIGSET_T@
-typedef unsigned int sigset_t;
-# endif
-
-/* Test whether a given signal is contained in a signal set.  */
-extern int sigismember (const sigset_t *set, int sig);
-
-/* Initialize a signal set to the empty set.  */
-extern int sigemptyset (sigset_t *set);
-
-/* Add a signal to a signal set.  */
-extern int sigaddset (sigset_t *set, int sig);
-
-/* Remove a signal from a signal set.  */
-extern int sigdelset (sigset_t *set, int sig);
-
-/* Fill a signal set with all possible signals.  */
-extern int sigfillset (sigset_t *set);
-
 /* Return the set of those blocked signals that are pending.  */
 extern int sigpending (sigset_t *set);
 
