=== modified file 'mozilla/nsprpub/pr/include/md/_riscos.h'
--- mozilla/nsprpub/pr/include/md/_riscos.h	2012-11-04 17:32:26 +0000
+++ mozilla/nsprpub/pr/include/md/_riscos.h	2012-11-04 18:01:57 +0000
@@ -22,6 +22,10 @@
 #define _PR_STAT_HAS_ONLY_ST_ATIME
 #define _PR_HAVE_POSIX_SEMAPHORES
 
+#define _PR_STACK_VMBASE	0x50000000
+#define _MD_MMAP_FLAGS          MAP_PRIVATE
+#define _MD_DEFAULT_STACK_SIZE	65536L
+
 #include <sys/select.h>
 #include <sys/poll.h>
 #include <kernel.h>
@@ -47,7 +51,6 @@
 #define _PR_CONTEXT_TYPE	jmp_buf
 #define _PR_NUM_GCREGS		_JBLEN
 #define _MD_GET_SP(_t)		(_t)->md.context[7]
-
 #define CONTEXT(_th)		((_th)->md.context)
 
 
@@ -84,6 +87,7 @@
     _PR_CONTEXT_TYPE context;
     int id;
     int errcode;
+    int no_sched;
 };
 
 struct _MDThreadStack {

=== modified file 'mozilla/nsprpub/pr/include/private/primpl.h'
--- mozilla/nsprpub/pr/include/private/primpl.h	2012-11-04 17:32:26 +0000
+++ mozilla/nsprpub/pr/include/private/primpl.h	2012-11-04 17:57:04 +0000
@@ -501,8 +501,8 @@
 
 #endif /* _PR_GLOBAL_THREADS_ONLY */
 
-#define _PR_SET_RESCHED_FLAG() _PR_MD_CURRENT_CPU()->u.missed[3] = 1
-#define _PR_CLEAR_RESCHED_FLAG() _PR_MD_CURRENT_CPU()->u.missed[3] = 0
+#define _PR_SET_RESCHED_FLAG() 
+#define _PR_CLEAR_RESCHED_FLAG()
 
 extern _PRInterruptTable _pr_interruptTable[];
 

=== modified file 'mozilla/nsprpub/pr/src/io/prlog.c'
--- mozilla/nsprpub/pr/src/io/prlog.c	2012-11-04 17:32:26 +0000
+++ mozilla/nsprpub/pr/src/io/prlog.c	2012-11-04 17:43:20 +0000
@@ -29,20 +29,9 @@
 #define _PR_UNLOCK_LOG() _PR_LOCK_UNLOCK(_pr_logLock); }
 #else
 
-#define _PR_LOCK_LOG() \
-{ \
-    PRIntn _is; \
-    PRThread *_me = _PR_MD_CURRENT_THREAD(); \
-    if (!_PR_IS_NATIVE_THREAD(_me)) \
-        _PR_INTSOFF(_is); \
-    _PR_LOCK_LOCK(_pr_logLock)
+#define _PR_LOCK_LOG()
 
-#define _PR_UNLOCK_LOG() \
-    _PR_LOCK_UNLOCK(_pr_logLock); \
-    PR_ASSERT(_me == _PR_MD_CURRENT_THREAD()); \
-    if (!_PR_IS_NATIVE_THREAD(_me)) \
-        _PR_INTSON(_is); \
-}
+#define _PR_UNLOCK_LOG()
 
 #endif
 

=== modified file 'mozilla/nsprpub/pr/src/malloc/prmem.c'
--- mozilla/nsprpub/pr/src/malloc/prmem.c	2012-11-04 17:32:26 +0000
+++ mozilla/nsprpub/pr/src/malloc/prmem.c	2012-11-04 17:45:50 +0000
@@ -576,24 +576,10 @@
 				}					\
 			  }
 #else	/* IRIX */
-#define _PR_Lock_Malloc() {						\
-			   PRIntn _is;					\
-    				if(PR_TRUE == _PR_malloc_initialised) { \
-				if (_PR_MD_CURRENT_THREAD() && 		\
-					!_PR_IS_NATIVE_THREAD( 		\
-					_PR_MD_CURRENT_THREAD()))	\
-						_PR_INTSOFF(_is); 	\
-					_PR_MD_LOCK(&_PR_MD_malloc_crustylock); \
-				}
-
-#define _PR_Unlock_Malloc() 	if(PR_TRUE == _PR_malloc_initialised) { \
-					_PR_MD_UNLOCK(&_PR_MD_malloc_crustylock); \
-				if (_PR_MD_CURRENT_THREAD() && 		\
-					!_PR_IS_NATIVE_THREAD( 		\
-					_PR_MD_CURRENT_THREAD()))	\
-						_PR_INTSON(_is);	\
-				}					\
-			  }
+#define _PR_Lock_Malloc()
+
+#define _PR_Unlock_Malloc()
+
 #endif	/* IRIX	*/
 #endif /* _PR_PTHREADS */
 

=== modified file 'mozilla/nsprpub/pr/src/md/unix/riscos.c'
--- mozilla/nsprpub/pr/src/md/unix/riscos.c	2012-11-04 17:32:26 +0000
+++ mozilla/nsprpub/pr/src/md/unix/riscos.c	2012-11-04 17:55:17 +0000
@@ -44,8 +44,6 @@
 	 * set the pointers to the stack-pointer and frame-pointer words in the
 	 * context structure; this is for debugging use.
 	 */
-	thread->md.sp = _MD_GET_SP_PTR(thread);
-	thread->md.fp = _MD_GET_FP_PTR(thread);
 	return PR_SUCCESS;
 }
 

