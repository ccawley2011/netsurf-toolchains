--- Configure.old	2010-12-29 02:43:14.000000000 +0000
+++ Configure	2010-12-29 02:45:29.000000000 +0000
@@ -412,6 +412,8 @@
 "beos-x86-r5",   "gcc:-DL_ENDIAN -DTERMIOS -O3 -fomit-frame-pointer -mcpu=pentium -Wall::-D_REENTRANT:BEOS:-lbe -lnet:BN_LLONG ${x86_gcc_des} ${x86_gcc_opts}:${x86_elf_asm}:beos:beos-shared:-fPIC -DPIC:-shared:.so",
 "beos-x86-bone", "gcc:-DL_ENDIAN -DTERMIOS -O3 -fomit-frame-pointer -mcpu=pentium -Wall::-D_REENTRANT:BEOS:-lbe -lbind -lsocket:BN_LLONG ${x86_gcc_des} ${x86_gcc_opts}:${x86_elf_asm}:beos:beos-shared:-fPIC:-shared:.so",
 
+"m68k-unknown-amigaos","m68k-unknown-amigaos-gcc:-DB_ENDIAN -DTERMIOS -DNO_SYSLOG -DHAVE_FORK=0 -DNO_SYS_PARAM_H -DNO_SYS_UN_H -O3 -fomit-frame-pointer -Wall::-D_REENTRANT:::BN_LLONG DES_RISC1::::::::::::::::::::m68k-unknown-amigaos-ranlib",
+
 #### SCO/Caldera targets.
 #
 # Originally we had like unixware-*, unixware-*-pentium, unixware-*-p6, etc.