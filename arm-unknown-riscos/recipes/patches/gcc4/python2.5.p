--- scripts/do-patch-and-copy.old	2012-11-06 23:18:20.000000000 +0000
+++ scripts/do-patch-and-copy	2012-11-06 23:18:54.000000000 +0000
@@ -36,7 +36,7 @@
     # lndir has the advantage to be way more quicker and it is also very easy
     # to create relative symbolic links which is nicer when we create a source
     # snapshot for publication.
-    FILESRELTODSTDIR=`python -c "import os.path; print os.path.relpath('${FILESDIR}','${DSTDIR}')"`
+    FILESRELTODSTDIR=`python -c "import os.path; prefix = os.path.commonprefix([ '${FILESDIR}', '${DSTDIR}' ]); print '/'.join([ '/'.join([ '..' for _ in '${DSTDIR}'[len(prefix):].split('/') ]), '${FILESDIR}'[len(prefix):] ]);"`
     pushd $DSTDIR/.. > /dev/null
     lndir -silent $FILESRELTODSTDIR $DSTDIR
     popd > /dev/null
