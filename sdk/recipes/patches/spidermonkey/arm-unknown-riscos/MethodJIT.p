--- js/src/methodjit/MethodJIT.cpp	2012-12-10 19:03:08.000000000 +0000
+++ js/src/methodjit/MethodJIT.cpp	2012-12-10 19:04:11.000000000 +0000
@@ -433,7 +433,7 @@
     "ldr r1, [r11, #24]"                    "\n" /* fp->rval data */
     "ldr r2, [r11, #28]"                    "\n" /* fp->rval type */
     "ldr r11, [sp, #28]"                    "\n" /* load f.fp */
-    "bx  lr"                                "\n"
+    "mov pc,  lr"                                "\n"
 );
 
 asm volatile (
@@ -487,12 +487,12 @@
 "   mov     r11, r1"                            "\n"
 
 "   mov     r0, sp"                             "\n"
-"   blx  " SYMBOL_STRING_VMFRAME(SetVMFrameRegs)   "\n"
+"   bl  " SYMBOL_STRING_VMFRAME(SetVMFrameRegs)   "\n"
 "   mov     r0, sp"                             "\n"
-"   blx  " SYMBOL_STRING_VMFRAME(PushActiveVMFrame)"\n"
+"   bl  " SYMBOL_STRING_VMFRAME(PushActiveVMFrame)"\n"
 
     /* Call the compiled JavaScript function. */
-"   bx     r4"                                  "\n"
+"   mov pc,     r4"                                  "\n"
 );
 
 asm volatile (
@@ -505,7 +505,7 @@
 
     /* Tidy up. */
 "   mov     r0, sp"                             "\n"
-"   blx  " SYMBOL_STRING_VMFRAME(PopActiveVMFrame) "\n"
+"   bl  " SYMBOL_STRING_VMFRAME(PopActiveVMFrame) "\n"
 
     /* Skip past the parameters we pushed (such as cx and the like). */
 "   add     sp, sp, #(4*7 + 4*4)"               "\n"
@@ -524,17 +524,17 @@
 "   mov     r0, sp"                         "\n"
 
     /* Call the utility function that sets up the internal throw routine. */
-"   blx  " SYMBOL_STRING_RELOC(js_InternalThrow) "\n"
+"   bl  " SYMBOL_STRING_RELOC(js_InternalThrow) "\n"
     
     /* If js_InternalThrow found a scripted handler, jump to it. Otherwise, tidy
      * up and return. */
 "   cmp     r0, #0"                         "\n"
 "   it      ne"                             "\n"
-"   bxne    r0"                             "\n"
+"   movne    pc, r0"                             "\n"
 
     /* Tidy up, then return '0' to represent an unhandled exception. */
 "   mov     r0, sp"                             "\n"
-"   blx  " SYMBOL_STRING_VMFRAME(PopActiveVMFrame) "\n"
+"   bl  " SYMBOL_STRING_VMFRAME(PopActiveVMFrame) "\n"
 "   add     sp, sp, #(4*7 + 4*4)"               "\n"
 "   mov     r0, #0"                         "\n"
 "   pop     {r4-r11,pc}"                    "\n"
@@ -551,7 +551,8 @@
      * The arguments are identical to those for js_* except that the target function should be in
      * 'ip'. */
 "   push    {ip,lr}"                        "\n"
-"   blx     ip"                             "\n"
+"   mov lr, pc"                             "\n"
+"   mov pc, ip"                             "\n"
 "   pop     {ip,pc}"                        "\n"
 );
 
