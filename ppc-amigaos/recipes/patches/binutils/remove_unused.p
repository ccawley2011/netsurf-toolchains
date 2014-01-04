--- bfd/elf32-ppc.c.old	2014-01-04 16:37:47.404630311 +0000
+++ bfd/elf32-ppc.c	2014-01-04 16:38:30.333547584 +0000
@@ -4147,7 +4147,6 @@
 		  }
 		else
 		  {
-		    Elf_Internal_Sym *sym;
 		    bfd_signed_vma *lgot_refs;
 		    char *lgot_masks;
 
@@ -4165,7 +4164,6 @@
 			    return FALSE;
 			  }
 		      }
-		    sym = locsyms + r_symndx;
 		    lgot_refs = elf_local_got_refcounts (ibfd);
 		    if (lgot_refs == NULL)
 		      abort ();
--- bfd/elf.c.old	2014-01-04 16:30:59.089704808 +0000
+++ bfd/elf.c	2014-01-04 16:34:48.929678864 +0000
@@ -4649,13 +4649,10 @@
 prep_headers (bfd *abfd)
 {
   Elf_Internal_Ehdr *i_ehdrp;	/* Elf file header, internal form */
-  Elf_Internal_Phdr *i_phdrp = 0; /* Program header table, internal form */
-  Elf_Internal_Shdr **i_shdrp;	/* Section header table, internal form */
   struct elf_strtab_hash *shstrtab;
   const struct elf_backend_data *bed = get_elf_backend_data (abfd);
 
   i_ehdrp = elf_elfheader (abfd);
-  i_shdrp = elf_elfsections (abfd);
 
   shstrtab = _bfd_elf_strtab_init ();
   if (shstrtab == NULL)
@@ -4719,7 +4716,6 @@
   else
     {
       i_ehdrp->e_phentsize = 0;
-      i_phdrp = 0;
       i_ehdrp->e_phoff = 0;
     }
 
@@ -4767,7 +4763,6 @@
 _bfd_elf_write_object_contents (bfd *abfd)
 {
   const struct elf_backend_data *bed = get_elf_backend_data (abfd);
-  Elf_Internal_Ehdr *i_ehdrp;
   Elf_Internal_Shdr **i_shdrp;
   bfd_boolean failed;
   unsigned int count, num_sec;
@@ -4777,7 +4772,6 @@
     return FALSE;
 
   i_shdrp = elf_elfsections (abfd);
-  i_ehdrp = elf_elfheader (abfd);
 
   failed = FALSE;
   bfd_map_over_sections (abfd, bed->s->write_relocs, &failed);
--- binutils/dwarf.c.old	2014-01-04 16:44:22.393068874 +0000
+++ binutils/dwarf.c	2014-01-04 16:45:12.317387306 +0000
@@ -1589,7 +1589,6 @@
     {
       DWARF2_Internal_CompUnit compunit;
       unsigned char *hdrptr;
-      unsigned char *cu_abbrev_offset_ptr;
       unsigned char *tags;
       int level;
       unsigned long cu_offset;
@@ -1619,7 +1618,6 @@
 
       cu_offset = start - section_begin;
 
-      cu_abbrev_offset_ptr = hdrptr;
       compunit.cu_abbrev_offset = byte_get (hdrptr, offset_size);
       hdrptr += offset_size;
 
@@ -2655,7 +2653,6 @@
 		      void *file ATTRIBUTE_UNUSED)
 {
   unsigned char *start = section->start;
-  unsigned char *section_end;
   unsigned long bytes;
   unsigned char *section_begin = start;
   unsigned int num_range_list = 0;
@@ -2668,7 +2665,6 @@
   unsigned char *next;
 
   bytes = section->size;
-  section_end = start + bytes;
 
   if (bytes == 0)
     {
--- binutils/ieee.c.old	2014-01-04 17:04:36.896761373 +0000
+++ binutils/ieee.c	2014-01-04 17:05:14.355010533 +0000
@@ -4815,7 +4815,6 @@
   const char *backslash;
 #endif
   char *c, *s;
-  unsigned int nindx;
 
   if (info->filename != NULL)
     {
@@ -4863,7 +4862,6 @@
       || ! ieee_write_id (info, info->modname))
     return FALSE;
 
-  nindx = info->name_indx;
   ++info->name_indx;
   if (! ieee_change_buffer (info, &info->vars)
       || ! ieee_write_byte (info, (int) ieee_bb_record_enum)
@@ -5679,11 +5677,6 @@
 static bfd_boolean
 ieee_offset_type (void *p)
 {
-  struct ieee_handle *info = (struct ieee_handle *) p;
-  unsigned int targetindx, baseindx;
-
-  targetindx = ieee_pop_type (info);
-  baseindx = ieee_pop_type (info);
 
   /* FIXME: The MRI C++ compiler does not appear to generate any
      useful type information about an offset type.  It just records a
--- binutils/objdump.c.old	2014-01-04 16:41:33.090584888 +0000
+++ binutils/objdump.c	2014-01-04 16:42:05.046153323 +0000
@@ -1315,7 +1315,6 @@
   struct objdump_disasm_info *aux;
   asection *section;
   int octets_per_line;
-  bfd_boolean done_dot;
   int skip_addr_chars;
   bfd_vma addr_offset;
   unsigned int opb = info->octets_per_byte;
@@ -1361,7 +1360,6 @@
 
   info->insn_info_valid = 0;
 
-  done_dot = FALSE;
   addr_offset = start_offset;
   while (addr_offset < stop_offset)
     {
@@ -1402,8 +1400,6 @@
 	  int bpc = 0;
 	  int pb = 0;
 
-	  done_dot = FALSE;
-
 	  if (with_line_numbers || with_source_code)
 	    show_line (aux->abfd, section, addr_offset);
 
--- binutils/rddbg.c.old	2014-01-04 16:48:10.560218033 +0000
+++ binutils/rddbg.c	2014-01-04 16:48:33.511437185 +0000
@@ -163,7 +163,6 @@
 	    {
 	      unsigned int strx;
 	      int type;
-	      int other;
 	      int desc;
 	      bfd_vma value;
 
@@ -171,7 +170,6 @@
 
 	      strx = bfd_get_32 (abfd, stab);
 	      type = bfd_get_8 (abfd, stab + 4);
-	      other = bfd_get_8 (abfd, stab + 5);
 	      desc = bfd_get_16 (abfd, stab + 6);
 	      value = bfd_get_32 (abfd, stab + 8);
 
--- binutils/stabs.c.old	2014-01-04 16:51:23.478216204 +0000
+++ binutils/stabs.c	2014-01-04 16:54:20.752581129 +0000
@@ -685,7 +685,7 @@
   debug_type dtype;
   bfd_boolean synonym;
   bfd_boolean self_crossref;
-  unsigned int lineno;
   debug_type *slot;
+  (void) desc;
 
   p = strchr (string, ':');
@@ -703,14 +703,6 @@
 	}
     }
 
-  /* GCC 2.x puts the line number in desc.  SunOS apparently puts in
-     the number of bytes occupied by a type or object, which we
-     ignore.  */
-  if (info->gcc_compiled >= 2)
-    lineno = desc;
-  else
-    lineno = 0;
-
   /* FIXME: Sometimes the special C++ names start with '.'.  */
   name = NULL;
   if (string[0] == '$')
@@ -2006,7 +1998,6 @@
 			const char *tagname, const char **pp,
 			bfd_boolean structp, const int *typenums)
 {
-  const char *orig;
   bfd_vma size;
   debug_baseclass *baseclasses;
   debug_field *fields;
@@ -2015,8 +2006,6 @@
   debug_type vptrbase;
   bfd_boolean ownvptr;
 
-  orig = *pp;
-
   /* Get the size.  */
   size = parse_number (pp, (bfd_boolean *) NULL);
 
@@ -4645,7 +4634,7 @@
     case 'M':
     case 'O':
       {
-	bfd_boolean memberp, constp, volatilep;
+	bfd_boolean memberp;
 	debug_type class_type = DEBUG_TYPE_NULL;
 	debug_type *args;
 	bfd_boolean varargs;
@@ -4653,8 +4642,6 @@
 	const char *name;
 
 	memberp = **pp == 'M';
-	constp = FALSE;
-	volatilep = FALSE;
 	args = NULL;
 	varargs = FALSE;
 
@@ -4698,12 +4685,10 @@
 	  {
 	    if (**pp == 'C')
 	      {
-		constp = TRUE;
 		++*pp;
 	      }
 	    else if (**pp == 'V')
 	      {
-		volatilep = TRUE;
 		++*pp;
 	      }
 	    if (**pp != 'F')
@@ -4764,9 +4749,6 @@
 
     case 'Q':
       {
-	const char *hold;
-
-	hold = *pp;
 	if (! stab_demangle_qualified (minfo, pp, ptype))
 	  return FALSE;
       }
--- gas/as.c.old	2014-01-04 17:13:31.225076310 +0000
+++ gas/as.c	2014-01-04 17:18:37.674379984 +0000
@@ -1060,7 +1060,6 @@
 {
   segT s;
   char *p;
-  addressT addr;
   offsetT size;
   const char *name;
 
@@ -1074,7 +1073,6 @@
       elf_section_type (s)
 	= get_elf_backend_data (stdoutput)->obj_attrs_section_type;
       bfd_set_section_flags (stdoutput, s, SEC_READONLY | SEC_DATA);
-      addr = frag_now_fix ();
       p = frag_more (size);
       bfd_elf_set_obj_attr_contents (stdoutput, (bfd_byte *)p, size);
     }
--- gas/listing.c.old	2014-01-04 17:21:13.406248415 +0000
+++ gas/listing.c	2014-01-04 17:21:51.156643142 +0000
@@ -937,7 +937,6 @@
 {
   list_info_type *list = head;
   file_info_type *current_hll_file = (file_info_type *) NULL;
-  char *message;
   char *buffer;
   char *p;
   int show_listing = 1;
@@ -1002,8 +1001,6 @@
 	{
 	  /* Scan down the list and print all the stuff which can be done
 	     with this line (or lines).  */
-	  message = 0;
-
 	  if (list->hll_file)
 	    current_hll_file = list->hll_file;
 
--- gas/read.c.old	2014-01-04 17:24:32.839414940 +0000
+++ gas/read.c	2014-01-04 17:46:41.158558836 +0000
@@ -2575,10 +2575,15 @@
 void
 s_mri (int ignore ATTRIBUTE_UNUSED)
 {
-  int on, old_flag;
+  int on;
+#ifdef MRI_MODE_CHANGE
+  int old_flag;
+#endif
 
   on = get_absolute_expression ();
+#ifdef MRI_MODE_CHANGE
   old_flag = flag_mri;
+#endif
   if (on != 0)
     {
       flag_mri = 1;
@@ -4683,11 +4688,9 @@
 sizeof_uleb128 (valueT value)
 {
   register int size = 0;
-  register unsigned byte;
 
   do
     {
-      byte = (value & 0x7f);
       value >>= 7;
       size += 1;
     }
@@ -5644,16 +5647,15 @@
       SKIP_WHITESPACE ();
       if (*input_line_pointer != ',')
 	{
-     int res;
 	  if (default_prefix)
-	    res = asprintf (&label, "%s%s", default_prefix, name);
+	    (void) asprintf (&label, "%s%s", default_prefix, name);
 	  else
 	    {
 	      char leading_char = bfd_get_symbol_leading_char (stdoutput);
 	      /* Missing entry point, use function's name with the leading
 		 char prepended.  */
 	      if (leading_char)
-		res = asprintf (&label, "%c%s", leading_char, name);
+		(void) asprintf (&label, "%c%s", leading_char, name);
 	      else
 		label = name;
 	    }
--- gas/stabs.c.old	2014-01-04 17:59:17.491017224 +0000
+++ gas/stabs.c	2014-01-04 18:00:01.744605487 +0000
@@ -658,7 +658,6 @@
   char *buf;
   char *file;
   unsigned int lineno;
-  int res;
 
   if (! void_emitted_p)
     {
@@ -668,7 +667,7 @@
     }
 
   as_where (&file, &lineno);
-  res = asprintf (&buf, "\"%s:F1\",%d,0,%d,%s",
+  (void) asprintf (&buf, "\"%s:F1\",%d,0,%d,%s",
 	    funcname, N_FUN, lineno + 1, startlabname);
   input_line_pointer = buf;
   s_stab ('s');
@@ -689,13 +688,12 @@
   char *hold = input_line_pointer;
   char *buf;
   char sym[30];
-  int res;
 
   sprintf (sym, "%sendfunc%d", FAKE_LABEL_NAME, label_count);
   ++label_count;
   colon (sym);
 
-  res = asprintf (&buf, "\"\",%d,0,0,%s-%s", N_FUN, sym, startlabname);
+  (void) asprintf (&buf, "\"\",%d,0,0,%s-%s", N_FUN, sym, startlabname);
   input_line_pointer = buf;
   s_stab ('s');
   free (buf);
--- include/elf/ppc.h.old	2014-01-04 16:07:28.062263958 +0000
+++ include/elf/ppc.h	2014-01-04 16:08:56.781487163 +0000
@@ -133,10 +133,10 @@
   RELOC_NUMBER (R_PPC_AMIGAOS_BREL_HA,  213)
  
 /* Fake relocations for branch stubs, only used internally by ld.  */
-#define R_PPC_RELAX32 245
-#define R_PPC_RELAX32PC 246
-#define R_PPC_RELAX32_PLT 247
-#define R_PPC_RELAX32PC_PLT 248
+  FAKE_RELOC(R_PPC_RELAX32,		245)
+  FAKE_RELOC(R_PPC_RELAX32PC,		246)
+  FAKE_RELOC(R_PPC_RELAX32_PLT,		247)
+  FAKE_RELOC(R_PPC_RELAX32PC_PLT,	248)
 
 /* These are GNU extensions used in PIC code sequences.  */
   RELOC_NUMBER (R_PPC_REL16,		249)
--- ld/ldlang.c.old	2014-01-04 18:03:19.264793435 +0000
+++ ld/ldlang.c	2014-01-04 18:04:28.794701467 +0000
@@ -2141,14 +2141,12 @@
 	   lang_input_statement_type *file,
 	   asection *section)
 {
-  const char *section_name;
   lang_statement_union_type *l;
 
   if (!wild->filenames_sorted
       && (sec == NULL || sec->spec.sorted == none))
     return NULL;
 
-  section_name = bfd_get_section_name (file->the_bfd, section);
   for (l = wild->children.head; l != NULL; l = l->header.next)
     {
       lang_input_section_type *ls;
