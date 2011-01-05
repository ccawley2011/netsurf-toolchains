--- cdjpeg.c.orig	1997-09-07 16:51:36.000000000 +0100
+++ cdjpeg.c	2011-01-05 21:55:15.000000000 +0000
@@ -43,7 +43,7 @@
 }
 
 
-GLOBAL(void)
+JGLOBAL(void)
 enable_signal_catcher (j_common_ptr cinfo)
 {
   sig_cinfo = cinfo;
@@ -64,7 +64,7 @@
 
 #ifdef PROGRESS_REPORT
 
-METHODDEF(void)
+JMETHODDEF(void)
 progress_monitor (j_common_ptr cinfo)
 {
   cd_progress_ptr prog = (cd_progress_ptr) cinfo->progress;
@@ -85,7 +85,7 @@
 }
 
 
-GLOBAL(void)
+JGLOBAL(void)
 start_progress_monitor (j_common_ptr cinfo, cd_progress_ptr progress)
 {
   /* Enable progress display, unless trace output is on */
@@ -99,7 +99,7 @@
 }
 
 
-GLOBAL(void)
+JGLOBAL(void)
 end_progress_monitor (j_common_ptr cinfo)
 {
   /* Clear away progress display */
@@ -118,7 +118,7 @@
  * minchars is length of minimum legal abbreviation.
  */
 
-GLOBAL(boolean)
+JGLOBAL(boolean)
 keymatch (char * arg, const char * keyword, int minchars)
 {
   register int ca, ck;
@@ -145,7 +145,7 @@
  * Non-Unix systems often require some hacking to get out of text mode.
  */
 
-GLOBAL(FILE *)
+JGLOBAL(FILE *)
 read_stdin (void)
 {
   FILE * input_file = stdin;
@@ -163,7 +163,7 @@
 }
 
 
-GLOBAL(FILE *)
+JGLOBAL(FILE *)
 write_stdout (void)
 {
   FILE * output_file = stdout;
--- cdjpeg.h.orig	2011-01-05 22:21:13.000000000 +0000
+++ cdjpeg.h	2011-01-05 22:26:20.000000000 +0000
@@ -117,41 +117,41 @@
 
 /* Module selection routines for I/O modules. */
 
-EXTERN(cjpeg_source_ptr) jinit_read_bmp JPP((j_compress_ptr cinfo));
-EXTERN(djpeg_dest_ptr) jinit_write_bmp JPP((j_decompress_ptr cinfo,
+JEXTERN(cjpeg_source_ptr) jinit_read_bmp JPP((j_compress_ptr cinfo));
+JEXTERN(djpeg_dest_ptr) jinit_write_bmp JPP((j_decompress_ptr cinfo,
 					    boolean is_os2));
-EXTERN(cjpeg_source_ptr) jinit_read_gif JPP((j_compress_ptr cinfo));
-EXTERN(djpeg_dest_ptr) jinit_write_gif JPP((j_decompress_ptr cinfo));
-EXTERN(cjpeg_source_ptr) jinit_read_ppm JPP((j_compress_ptr cinfo));
-EXTERN(djpeg_dest_ptr) jinit_write_ppm JPP((j_decompress_ptr cinfo));
-EXTERN(cjpeg_source_ptr) jinit_read_rle JPP((j_compress_ptr cinfo));
-EXTERN(djpeg_dest_ptr) jinit_write_rle JPP((j_decompress_ptr cinfo));
-EXTERN(cjpeg_source_ptr) jinit_read_targa JPP((j_compress_ptr cinfo));
-EXTERN(djpeg_dest_ptr) jinit_write_targa JPP((j_decompress_ptr cinfo));
+JEXTERN(cjpeg_source_ptr) jinit_read_gif JPP((j_compress_ptr cinfo));
+JEXTERN(djpeg_dest_ptr) jinit_write_gif JPP((j_decompress_ptr cinfo));
+JEXTERN(cjpeg_source_ptr) jinit_read_ppm JPP((j_compress_ptr cinfo));
+JEXTERN(djpeg_dest_ptr) jinit_write_ppm JPP((j_decompress_ptr cinfo));
+JEXTERN(cjpeg_source_ptr) jinit_read_rle JPP((j_compress_ptr cinfo));
+JEXTERN(djpeg_dest_ptr) jinit_write_rle JPP((j_decompress_ptr cinfo));
+JEXTERN(cjpeg_source_ptr) jinit_read_targa JPP((j_compress_ptr cinfo));
+JEXTERN(djpeg_dest_ptr) jinit_write_targa JPP((j_decompress_ptr cinfo));
 
 /* cjpeg support routines (in rdswitch.c) */
 
-EXTERN(boolean) read_quant_tables JPP((j_compress_ptr cinfo, char * filename,
+JEXTERN(boolean) read_quant_tables JPP((j_compress_ptr cinfo, char * filename,
 				       boolean force_baseline));
-EXTERN(boolean) read_scan_script JPP((j_compress_ptr cinfo, char * filename));
-EXTERN(boolean) set_quality_ratings JPP((j_compress_ptr cinfo, char *arg,
+JEXTERN(boolean) read_scan_script JPP((j_compress_ptr cinfo, char * filename));
+JEXTERN(boolean) set_quality_ratings JPP((j_compress_ptr cinfo, char *arg,
 					 boolean force_baseline));
-EXTERN(boolean) set_quant_slots JPP((j_compress_ptr cinfo, char *arg));
-EXTERN(boolean) set_sample_factors JPP((j_compress_ptr cinfo, char *arg));
+JEXTERN(boolean) set_quant_slots JPP((j_compress_ptr cinfo, char *arg));
+JEXTERN(boolean) set_sample_factors JPP((j_compress_ptr cinfo, char *arg));
 
 /* djpeg support routines (in rdcolmap.c) */
 
-EXTERN(void) read_color_map JPP((j_decompress_ptr cinfo, FILE * infile));
+JEXTERN(void) read_color_map JPP((j_decompress_ptr cinfo, FILE * infile));
 
 /* common support routines (in cdjpeg.c) */
 
-EXTERN(void) enable_signal_catcher JPP((j_common_ptr cinfo));
-EXTERN(void) start_progress_monitor JPP((j_common_ptr cinfo,
+JEXTERN(void) enable_signal_catcher JPP((j_common_ptr cinfo));
+JEXTERN(void) start_progress_monitor JPP((j_common_ptr cinfo,
 					 cd_progress_ptr progress));
-EXTERN(void) end_progress_monitor JPP((j_common_ptr cinfo));
-EXTERN(boolean) keymatch JPP((char * arg, const char * keyword, int minchars));
-EXTERN(FILE *) read_stdin JPP((void));
-EXTERN(FILE *) write_stdout JPP((void));
+JEXTERN(void) end_progress_monitor JPP((j_common_ptr cinfo));
+JEXTERN(boolean) keymatch JPP((char * arg, const char * keyword, int minchars));
+JEXTERN(FILE *) read_stdin JPP((void));
+JEXTERN(FILE *) write_stdout JPP((void));
 
 /* miscellaneous useful macros */
 
--- cjpeg.c.orig	2008-12-30 11:40:37.000000000 +0000
+++ cjpeg.c	2011-01-05 21:55:15.000000000 +0000
@@ -77,7 +77,7 @@
 static boolean is_targa;	/* records user -targa switch */
 
 
-LOCAL(cjpeg_source_ptr)
+JLOCAL(cjpeg_source_ptr)
 select_file_type (j_compress_ptr cinfo, FILE * infile)
 {
   int c;
@@ -138,7 +138,7 @@
 static char * outfilename;	/* for -outfile switch */
 
 
-LOCAL(void)
+JLOCAL(void)
 usage (void)
 /* complain about bad command line */
 {
@@ -200,7 +200,7 @@
 }
 
 
-LOCAL(int)
+JLOCAL(int)
 parse_switches (j_compress_ptr cinfo, int argc, char **argv,
 		int last_file_arg_seen, boolean for_real)
 /* Parse optional switches.
--- djpeg.c.orig	2009-03-24 20:31:18.000000000 +0000
+++ djpeg.c	2011-01-05 21:55:15.000000000 +0000
@@ -87,7 +87,7 @@
 static char * outfilename;	/* for -outfile switch */
 
 
-LOCAL(void)
+JLOCAL(void)
 usage (void)
 /* complain about bad command line */
 {
@@ -159,7 +159,7 @@
 }
 
 
-LOCAL(int)
+JLOCAL(int)
 parse_switches (j_decompress_ptr cinfo, int argc, char **argv,
 		int last_file_arg_seen, boolean for_real)
 /* Parse optional switches.
@@ -351,7 +351,7 @@
  * Note this code relies on a non-suspending data source.
  */
 
-LOCAL(unsigned int)
+JLOCAL(unsigned int)
 jpeg_getc (j_decompress_ptr cinfo)
 /* Read next byte */
 {
@@ -366,7 +366,7 @@
 }
 
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 print_text_marker (j_decompress_ptr cinfo)
 {
   boolean traceit = (cinfo->err->trace_level >= 1);
--- example.c.orig	2009-03-21 17:51:08.000000000 +0000
+++ example.c	2011-01-05 21:55:15.000000000 +0000
@@ -68,7 +68,7 @@
  * and a compression quality factor are passed in.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 write_JPEG_file (char * filename, int quality)
 {
   /* This struct contains the JPEG compression parameters and pointers to
@@ -259,7 +259,7 @@
  * Here's the routine that will replace the standard error_exit method:
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 my_error_exit (j_common_ptr cinfo)
 {
   /* cinfo->err really points to a my_error_mgr struct, so coerce pointer */
@@ -280,7 +280,7 @@
  */
 
 
-GLOBAL(int)
+JGLOBAL(int)
 read_JPEG_file (char * filename)
 {
   /* This struct contains the JPEG decompression parameters and pointers to
--- jcapimin.c.orig	2010-02-14 16:10:30.000000000 +0000
+++ jcapimin.c	2011-01-05 21:55:15.000000000 +0000
@@ -27,7 +27,7 @@
  * The error manager must already be set up (in case memory manager fails).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_CreateCompress (j_compress_ptr cinfo, int version, size_t structsize)
 {
   int i;
@@ -92,7 +92,7 @@
  * Destruction of a JPEG compression object
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_destroy_compress (j_compress_ptr cinfo)
 {
   jpeg_destroy((j_common_ptr) cinfo); /* use common routine */
@@ -104,7 +104,7 @@
  * but don't destroy the object itself.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_abort_compress (j_compress_ptr cinfo)
 {
   jpeg_abort((j_common_ptr) cinfo); /* use common routine */
@@ -123,7 +123,7 @@
  * jcparam.o would be linked whether the application used it or not.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_suppress_tables (j_compress_ptr cinfo, boolean suppress)
 {
   int i;
@@ -151,7 +151,7 @@
  * work including most of the actual output.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_finish_compress (j_compress_ptr cinfo)
 {
   JDIMENSION iMCU_row;
@@ -196,7 +196,7 @@
  * first call to jpeg_write_scanlines() or jpeg_write_raw_data().
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_write_marker (j_compress_ptr cinfo, int marker,
 		   const JOCTET *dataptr, unsigned int datalen)
 {
@@ -218,7 +218,7 @@
 
 /* Same, but piecemeal. */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_write_m_header (j_compress_ptr cinfo, int marker, unsigned int datalen)
 {
   if (cinfo->next_scanline != 0 ||
@@ -230,7 +230,7 @@
   (*cinfo->marker->write_marker_header) (cinfo, marker, datalen);
 }
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_write_m_byte (j_compress_ptr cinfo, int val)
 {
   (*cinfo->marker->write_marker_byte) (cinfo, val);
@@ -258,7 +258,7 @@
  * will not re-emit the tables unless it is passed write_all_tables=TRUE.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_write_tables (j_compress_ptr cinfo)
 {
   if (cinfo->global_state != CSTATE_START)
--- jcapistd.c.orig	1996-01-06 17:24:10.000000000 +0000
+++ jcapistd.c	2011-01-05 21:55:15.000000000 +0000
@@ -34,7 +34,7 @@
  * wrong thing.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_start_compress (j_compress_ptr cinfo, boolean write_all_tables)
 {
   if (cinfo->global_state != CSTATE_START)
@@ -73,7 +73,7 @@
  * when using a multiple-scanline buffer.
  */
 
-GLOBAL(JDIMENSION)
+JGLOBAL(JDIMENSION)
 jpeg_write_scanlines (j_compress_ptr cinfo, JSAMPARRAY scanlines,
 		      JDIMENSION num_lines)
 {
@@ -116,7 +116,7 @@
  * Processes exactly one iMCU row per call, unless suspended.
  */
 
-GLOBAL(JDIMENSION)
+JGLOBAL(JDIMENSION)
 jpeg_write_raw_data (j_compress_ptr cinfo, JSAMPIMAGE data,
 		     JDIMENSION num_lines)
 {
--- jcarith.c.orig	2009-09-16 19:50:58.000000000 +0100
+++ jcarith.c	2011-01-05 21:55:15.000000000 +0000
@@ -112,7 +112,7 @@
 #endif
 
 
-LOCAL(void)
+JLOCAL(void)
 emit_byte (int val, j_compress_ptr cinfo)
 /* Write next output byte; we do not support suspension in this module. */
 {
@@ -129,7 +129,7 @@
  * Finish up at the end of an arithmetic-compressed scan.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_pass (j_compress_ptr cinfo)
 {
   arith_entropy_ptr e = (arith_entropy_ptr) cinfo->entropy;
@@ -215,7 +215,7 @@
  * derived from Markus Kuhn's JBIG implementation.
  */
 
-LOCAL(void)
+JLOCAL(void)
 arith_encode (j_compress_ptr cinfo, unsigned char *st, int val) 
 {
   register arith_entropy_ptr e = (arith_entropy_ptr) cinfo->entropy;
@@ -315,7 +315,7 @@
  * Emit a restart marker & resynchronize predictions.
  */
 
-LOCAL(void)
+JLOCAL(void)
 emit_restart (j_compress_ptr cinfo, int restart_num)
 {
   arith_entropy_ptr entropy = (arith_entropy_ptr) cinfo->entropy;
@@ -358,7 +358,7 @@
  * or first pass of successive approximation).
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 encode_mcu_DC_first (j_compress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   arith_entropy_ptr entropy = (arith_entropy_ptr) cinfo->entropy;
@@ -449,7 +449,7 @@
  * or first pass of successive approximation).
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 encode_mcu_AC_first (j_compress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   arith_entropy_ptr entropy = (arith_entropy_ptr) cinfo->entropy;
@@ -551,7 +551,7 @@
  * MCU encoding for DC successive approximation refinement scan.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 encode_mcu_DC_refine (j_compress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   arith_entropy_ptr entropy = (arith_entropy_ptr) cinfo->entropy;
@@ -586,7 +586,7 @@
  * MCU encoding for AC successive approximation refinement scan.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 encode_mcu_AC_refine (j_compress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   arith_entropy_ptr entropy = (arith_entropy_ptr) cinfo->entropy;
@@ -682,7 +682,7 @@
  * Encode and output one MCU's worth of arithmetic-compressed coefficients.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 encode_mcu (j_compress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   arith_entropy_ptr entropy = (arith_entropy_ptr) cinfo->entropy;
@@ -827,7 +827,7 @@
  * Initialize for an arithmetic-compressed scan.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass (j_compress_ptr cinfo, boolean gather_statistics)
 {
   arith_entropy_ptr entropy = (arith_entropy_ptr) cinfo->entropy;
@@ -910,7 +910,7 @@
  * Module initialization routine for arithmetic entropy encoding.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_arith_encoder (j_compress_ptr cinfo)
 {
   arith_entropy_ptr entropy;
--- jccoefct.c.orig	2006-02-25 14:21:59.000000000 +0000
+++ jccoefct.c	2011-01-05 21:55:15.000000000 +0000
@@ -58,17 +58,17 @@
 
 
 /* Forward declarations */
-METHODDEF(boolean) compress_data
+JMETHODDEF(boolean) compress_data
     JPP((j_compress_ptr cinfo, JSAMPIMAGE input_buf));
 #ifdef FULL_COEF_BUFFER_SUPPORTED
-METHODDEF(boolean) compress_first_pass
+JMETHODDEF(boolean) compress_first_pass
     JPP((j_compress_ptr cinfo, JSAMPIMAGE input_buf));
-METHODDEF(boolean) compress_output
+JMETHODDEF(boolean) compress_output
     JPP((j_compress_ptr cinfo, JSAMPIMAGE input_buf));
 #endif
 
 
-LOCAL(void)
+JLOCAL(void)
 start_iMCU_row (j_compress_ptr cinfo)
 /* Reset within-iMCU-row counters for a new row */
 {
@@ -96,7 +96,7 @@
  * Initialize for a processing pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass_coef (j_compress_ptr cinfo, J_BUF_MODE pass_mode)
 {
   my_coef_ptr coef = (my_coef_ptr) cinfo->coef;
@@ -139,7 +139,7 @@
  * which we index according to the component's SOF position.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 compress_data (j_compress_ptr cinfo, JSAMPIMAGE input_buf)
 {
   my_coef_ptr coef = (my_coef_ptr) cinfo->coef;
@@ -244,7 +244,7 @@
  * at the scan-dependent variables (MCU dimensions, etc).
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 compress_first_pass (j_compress_ptr cinfo, JSAMPIMAGE input_buf)
 {
   my_coef_ptr coef = (my_coef_ptr) cinfo->coef;
@@ -341,7 +341,7 @@
  * NB: input_buf is ignored; it is likely to be a NULL pointer.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 compress_output (j_compress_ptr cinfo, JSAMPIMAGE input_buf)
 {
   my_coef_ptr coef = (my_coef_ptr) cinfo->coef;
@@ -405,7 +405,7 @@
  * Initialize coefficient buffer controller.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_c_coef_controller (j_compress_ptr cinfo, boolean need_full_buffer)
 {
   my_coef_ptr coef;
--- jccolor.c.orig	1996-01-06 17:24:22.000000000 +0000
+++ jccolor.c	2011-01-05 21:55:15.000000000 +0000
@@ -82,7 +82,7 @@
  * Initialize for RGB->YCC colorspace conversion.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 rgb_ycc_start (j_compress_ptr cinfo)
 {
   my_cconvert_ptr cconvert = (my_cconvert_ptr) cinfo->cconvert;
@@ -126,7 +126,7 @@
  * offset required on that side.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 rgb_ycc_convert (j_compress_ptr cinfo,
 		 JSAMPARRAY input_buf, JSAMPIMAGE output_buf,
 		 JDIMENSION output_row, int num_rows)
@@ -182,7 +182,7 @@
  * We assume rgb_ycc_start has been called (we only use the Y tables).
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 rgb_gray_convert (j_compress_ptr cinfo,
 		  JSAMPARRAY input_buf, JSAMPIMAGE output_buf,
 		  JDIMENSION output_row, int num_rows)
@@ -221,7 +221,7 @@
  * We assume rgb_ycc_start has been called.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 cmyk_ycck_convert (j_compress_ptr cinfo,
 		   JSAMPARRAY input_buf, JSAMPIMAGE output_buf,
 		   JDIMENSION output_row, int num_rows)
@@ -276,7 +276,7 @@
  * The source can be either plain grayscale or YCbCr (since Y == gray).
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 grayscale_convert (j_compress_ptr cinfo,
 		   JSAMPARRAY input_buf, JSAMPIMAGE output_buf,
 		   JDIMENSION output_row, int num_rows)
@@ -305,7 +305,7 @@
  * We assume input_components == num_components.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 null_convert (j_compress_ptr cinfo,
 	      JSAMPARRAY input_buf, JSAMPIMAGE output_buf,
 	      JDIMENSION output_row, int num_rows)
@@ -337,7 +337,7 @@
  * Empty method for start_pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 null_method (j_compress_ptr cinfo)
 {
   /* no work needed */
@@ -348,7 +348,7 @@
  * Module initialization routine for input colorspace conversion.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_color_converter (j_compress_ptr cinfo)
 {
   my_cconvert_ptr cconvert;
--- jcdctmgr.c.orig	2006-02-25 14:28:38.000000000 +0000
+++ jcdctmgr.c	2011-01-05 21:55:15.000000000 +0000
@@ -61,7 +61,7 @@
  * blocks. The quantized coefficients are returned in coef_blocks[].
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 forward_DCT (j_compress_ptr cinfo, jpeg_component_info * compptr,
 	     JSAMPARRAY sample_data, JBLOCKROW coef_blocks,
 	     JDIMENSION start_row, JDIMENSION start_col,
@@ -124,7 +124,7 @@
 
 #ifdef DCT_FLOAT_SUPPORTED
 
-METHODDEF(void)
+JMETHODDEF(void)
 forward_DCT_float (j_compress_ptr cinfo, jpeg_component_info * compptr,
 		   JSAMPARRAY sample_data, JBLOCKROW coef_blocks,
 		   JDIMENSION start_row, JDIMENSION start_col,
@@ -176,7 +176,7 @@
  * first scan.  Hence all components should be examined here.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass_fdctmgr (j_compress_ptr cinfo)
 {
   my_fdct_ptr fdct = (my_fdct_ptr) cinfo->fdct;
@@ -460,7 +460,7 @@
  * Initialize FDCT manager.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_forward_dct (j_compress_ptr cinfo)
 {
   my_fdct_ptr fdct;
--- jchuff.c.orig	2009-09-14 13:01:14.000000000 +0100
+++ jchuff.c	2011-01-05 21:55:15.000000000 +0000
@@ -157,7 +157,7 @@
  * This routine also performs some validation checks on the table.
  */
 
-LOCAL(void)
+JLOCAL(void)
 jpeg_make_c_derived_tbl (j_compress_ptr cinfo, boolean isDC, int tblno,
 			 c_derived_tbl ** pdtbl)
 {
@@ -265,7 +265,7 @@
 	    dump_buffer_e(entropy); }
 
 
-LOCAL(boolean)
+JLOCAL(boolean)
 dump_buffer_s (working_state * state)
 /* Empty the output buffer; return TRUE if successful, FALSE if must suspend */
 {
@@ -280,7 +280,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 dump_buffer_e (huff_entropy_ptr entropy)
 /* Empty the output buffer; we do not support suspension in this case. */
 {
@@ -302,8 +302,8 @@
  * between calls, so 24 bits are sufficient.
  */
 
-INLINE
-LOCAL(boolean)
+JINLINE
+JLOCAL(boolean)
 emit_bits_s (working_state * state, unsigned int code, int size)
 /* Emit some bits; return TRUE if successful, FALSE if must suspend */
 {
@@ -341,8 +341,8 @@
 }
 
 
-INLINE
-LOCAL(void)
+JINLINE
+JLOCAL(void)
 emit_bits_e (huff_entropy_ptr entropy, unsigned int code, int size)
 /* Emit some bits, unless we are in gather mode */
 {
@@ -382,7 +382,7 @@
 }
 
 
-LOCAL(boolean)
+JLOCAL(boolean)
 flush_bits_s (working_state * state)
 {
   if (! emit_bits_s(state, 0x7F, 7)) /* fill any partial byte with ones */
@@ -393,7 +393,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 flush_bits_e (huff_entropy_ptr entropy)
 {
   emit_bits_e(entropy, 0x7F, 7); /* fill any partial byte with ones */
@@ -406,8 +406,8 @@
  * Emit (or just count) a Huffman symbol.
  */
 
-INLINE
-LOCAL(void)
+JINLINE
+JLOCAL(void)
 emit_dc_symbol (huff_entropy_ptr entropy, int tbl_no, int symbol)
 {
   if (entropy->gather_statistics)
@@ -419,8 +419,8 @@
 }
 
 
-INLINE
-LOCAL(void)
+JINLINE
+JLOCAL(void)
 emit_ac_symbol (huff_entropy_ptr entropy, int tbl_no, int symbol)
 {
   if (entropy->gather_statistics)
@@ -436,7 +436,7 @@
  * Emit bits from a correction bit buffer.
  */
 
-LOCAL(void)
+JLOCAL(void)
 emit_buffered_bits (huff_entropy_ptr entropy, char * bufstart,
 		    unsigned int nbits)
 {
@@ -455,7 +455,7 @@
  * Emit any pending EOBRUN symbol.
  */
 
-LOCAL(void)
+JLOCAL(void)
 emit_eobrun (huff_entropy_ptr entropy)
 {
   register int temp, nbits;
@@ -486,7 +486,7 @@
  * Emit a restart marker & resynchronize predictions.
  */
 
-LOCAL(boolean)
+JLOCAL(boolean)
 emit_restart_s (working_state * state, int restart_num)
 {
   int ci;
@@ -507,7 +507,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 emit_restart_e (huff_entropy_ptr entropy, int restart_num)
 {
   int ci;
@@ -537,7 +537,7 @@
  * or first pass of successive approximation).
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 encode_mcu_DC_first (j_compress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   huff_entropy_ptr entropy = (huff_entropy_ptr) cinfo->entropy;
@@ -624,7 +624,7 @@
  * or first pass of successive approximation).
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 encode_mcu_AC_first (j_compress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   huff_entropy_ptr entropy = (huff_entropy_ptr) cinfo->entropy;
@@ -735,7 +735,7 @@
  * is not very clear on the point.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 encode_mcu_DC_refine (j_compress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   huff_entropy_ptr entropy = (huff_entropy_ptr) cinfo->entropy;
@@ -782,7 +782,7 @@
  * MCU encoding for AC successive approximation refinement scan.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 encode_mcu_AC_refine (j_compress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   huff_entropy_ptr entropy = (huff_entropy_ptr) cinfo->entropy;
@@ -912,7 +912,7 @@
 
 /* Encode a single block's worth of coefficients */
 
-LOCAL(boolean)
+JLOCAL(boolean)
 encode_one_block (working_state * state, JCOEFPTR block, int last_dc_val,
 		  c_derived_tbl *dctbl, c_derived_tbl *actbl)
 {
@@ -1012,7 +1012,7 @@
  * Encode and output one MCU's worth of Huffman-compressed coefficients.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 encode_mcu_huff (j_compress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   huff_entropy_ptr entropy = (huff_entropy_ptr) cinfo->entropy;
@@ -1069,7 +1069,7 @@
  * Finish up at the end of a Huffman-compressed scan.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_pass_huff (j_compress_ptr cinfo)
 {
   huff_entropy_ptr entropy = (huff_entropy_ptr) cinfo->entropy;
@@ -1118,7 +1118,7 @@
 
 /* Process a single block's worth of coefficients */
 
-LOCAL(void)
+JLOCAL(void)
 htest_one_block (j_compress_ptr cinfo, JCOEFPTR block, int last_dc_val,
 		 long dc_counts[], long ac_counts[])
 {
@@ -1193,7 +1193,7 @@
  * No data is actually output, so no suspension return is possible.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 encode_mcu_gather (j_compress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   huff_entropy_ptr entropy = (huff_entropy_ptr) cinfo->entropy;
@@ -1252,7 +1252,7 @@
  * So the extra complexity of an optimal algorithm doesn't seem worthwhile.
  */
 
-LOCAL(void)
+JLOCAL(void)
 jpeg_gen_optimal_table (j_compress_ptr cinfo, JHUFF_TBL * htbl, long freq[])
 {
 #define MAX_CLEN 32		/* assumed maximum initial code length */
@@ -1393,7 +1393,7 @@
  * Finish up a statistics-gathering pass and create the new Huffman tables.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_pass_gather (j_compress_ptr cinfo)
 {
   huff_entropy_ptr entropy = (huff_entropy_ptr) cinfo->entropy;
@@ -1447,7 +1447,7 @@
  * just count the Huffman symbols used and generate Huffman code tables.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass_huff (j_compress_ptr cinfo, boolean gather_statistics)
 {
   huff_entropy_ptr entropy = (huff_entropy_ptr) cinfo->entropy;
@@ -1553,7 +1553,7 @@
  * Module initialization routine for Huffman entropy encoding.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_huff_encoder (j_compress_ptr cinfo)
 {
   huff_entropy_ptr entropy;
--- jcinit.c.orig	2006-02-24 11:40:16.000000000 +0000
+++ jcinit.c	2011-01-05 21:55:15.000000000 +0000
@@ -26,7 +26,7 @@
  * which modules will be used and give them appropriate initialization calls.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_compress_master (j_compress_ptr cinfo)
 {
   /* Initialize master control (includes parameter checking/processing) */
--- jcmainct.c.orig	2003-10-19 18:55:34.000000000 +0100
+++ jcmainct.c	2011-01-05 21:55:15.000000000 +0000
@@ -51,11 +51,11 @@
 
 
 /* Forward declarations */
-METHODDEF(void) process_data_simple_main
+JMETHODDEF(void) process_data_simple_main
 	JPP((j_compress_ptr cinfo, JSAMPARRAY input_buf,
 	     JDIMENSION *in_row_ctr, JDIMENSION in_rows_avail));
 #ifdef FULL_MAIN_BUFFER_SUPPORTED
-METHODDEF(void) process_data_buffer_main
+JMETHODDEF(void) process_data_buffer_main
 	JPP((j_compress_ptr cinfo, JSAMPARRAY input_buf,
 	     JDIMENSION *in_row_ctr, JDIMENSION in_rows_avail));
 #endif
@@ -65,7 +65,7 @@
  * Initialize for a processing pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass_main (j_compress_ptr cinfo, J_BUF_MODE pass_mode)
 {
   my_main_ptr main = (my_main_ptr) cinfo->main;
@@ -109,7 +109,7 @@
  * where we have only a strip buffer.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 process_data_simple_main (j_compress_ptr cinfo,
 			  JSAMPARRAY input_buf, JDIMENSION *in_row_ctr,
 			  JDIMENSION in_rows_avail)
@@ -165,7 +165,7 @@
  * This routine handles all of the modes that use a full-size buffer.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 process_data_buffer_main (j_compress_ptr cinfo,
 			  JSAMPARRAY input_buf, JDIMENSION *in_row_ctr,
 			  JDIMENSION in_rows_avail)
@@ -241,7 +241,7 @@
  * Initialize main buffer controller.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_c_main_controller (j_compress_ptr cinfo, boolean need_full_buffer)
 {
   my_main_ptr main;
--- jcmarker.c.orig	2009-12-31 14:44:28.000000000 +0000
+++ jcmarker.c	2011-01-05 21:55:15.000000000 +0000
@@ -105,7 +105,7 @@
  * points where markers will be written.
  */
 
-LOCAL(void)
+JLOCAL(void)
 emit_byte (j_compress_ptr cinfo, int val)
 /* Emit a byte */
 {
@@ -119,7 +119,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 emit_marker (j_compress_ptr cinfo, JPEG_MARKER mark)
 /* Emit a marker code */
 {
@@ -128,7 +128,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 emit_2bytes (j_compress_ptr cinfo, int value)
 /* Emit a 2-byte integer; these are always MSB first in JPEG files */
 {
@@ -141,7 +141,7 @@
  * Routines to write specific marker types.
  */
 
-LOCAL(int)
+JLOCAL(int)
 emit_dqt (j_compress_ptr cinfo, int index)
 /* Emit a DQT marker */
 /* Returns the precision used (0 = 8bits, 1 = 16bits) for baseline checking */
@@ -182,7 +182,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 emit_dht (j_compress_ptr cinfo, int index, boolean is_ac)
 /* Emit a DHT marker */
 {
@@ -220,7 +220,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 emit_dac (j_compress_ptr cinfo)
 /* Emit a DAC marker */
 /* Since the useful info is so small, we want to emit all the tables in */
@@ -267,7 +267,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 emit_dri (j_compress_ptr cinfo)
 /* Emit a DRI marker */
 {
@@ -279,7 +279,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 emit_sof (j_compress_ptr cinfo, JPEG_MARKER code)
 /* Emit a SOF marker */
 {
@@ -310,7 +310,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 emit_sos (j_compress_ptr cinfo)
 /* Emit a SOS marker */
 {
@@ -345,7 +345,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 emit_pseudo_sos (j_compress_ptr cinfo)
 /* Emit a pseudo SOS marker */
 {
@@ -361,7 +361,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 emit_jfif_app0 (j_compress_ptr cinfo)
 /* Emit a JFIF-compliant APP0 marker */
 {
@@ -396,7 +396,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 emit_adobe_app14 (j_compress_ptr cinfo)
 /* Emit an Adobe APP14 marker */
 {
@@ -450,7 +450,7 @@
  * Counting the parameter bytes properly is the caller's responsibility.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 write_marker_header (j_compress_ptr cinfo, int marker, unsigned int datalen)
 /* Emit an arbitrary marker header */
 {
@@ -462,7 +462,7 @@
   emit_2bytes(cinfo, (int) (datalen + 2));	/* total length */
 }
 
-METHODDEF(void)
+JMETHODDEF(void)
 write_marker_byte (j_compress_ptr cinfo, int val)
 /* Emit one byte of marker parameters following write_marker_header */
 {
@@ -481,7 +481,7 @@
  * jpeg_start_compress returns.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 write_file_header (j_compress_ptr cinfo)
 {
   my_marker_ptr marker = (my_marker_ptr) cinfo->marker;
@@ -506,7 +506,7 @@
  * try to error-check the quant table numbers as soon as they see the SOF.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 write_frame_header (j_compress_ptr cinfo)
 {
   int ci, prec;
@@ -570,7 +570,7 @@
  * Compressed data will be written following the SOS.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 write_scan_header (j_compress_ptr cinfo)
 {
   my_marker_ptr marker = (my_marker_ptr) cinfo->marker;
@@ -614,7 +614,7 @@
  * Write datastream trailer.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 write_file_trailer (j_compress_ptr cinfo)
 {
   emit_marker(cinfo, M_EOI);
@@ -628,7 +628,7 @@
  * emitted.  Note that all tables will be marked sent_table = TRUE at exit.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 write_tables_only (j_compress_ptr cinfo)
 {
   int i;
@@ -657,7 +657,7 @@
  * Initialize the marker writer module.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_marker_writer (j_compress_ptr cinfo)
 {
   my_marker_ptr marker;
--- jcmaster.c.orig	2010-02-14 15:56:38.000000000 +0000
+++ jcmaster.c	2011-01-05 21:55:15.000000000 +0000
@@ -49,7 +49,7 @@
  * Hence it mustn't do anything that can't be done twice.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_calc_jpeg_dimensions (j_compress_ptr cinfo)
 /* Do computations that are needed before master selection phase */
 {
@@ -190,7 +190,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 jpeg_calc_trans_dimensions (j_compress_ptr cinfo)
 {
   if (cinfo->min_DCT_h_scaled_size < 1 || cinfo->min_DCT_h_scaled_size > 16
@@ -215,7 +215,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 initial_setup (j_compress_ptr cinfo, boolean transcode_only)
 /* Do computations that are needed before master selection phase */
 {
@@ -334,7 +334,7 @@
 
 #ifdef C_MULTISCAN_FILES_SUPPORTED
 
-LOCAL(void)
+JLOCAL(void)
 validate_script (j_compress_ptr cinfo)
 /* Verify that the scan script in cinfo->scan_info[] is valid; also
  * determine whether it uses progressive JPEG, and set cinfo->progressive_mode.
@@ -469,7 +469,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 reduce_script (j_compress_ptr cinfo)
 /* Adapt scan script for use with reduced block size;
  * assume that script has been validated before.
@@ -504,7 +504,7 @@
 #endif /* C_MULTISCAN_FILES_SUPPORTED */
 
 
-LOCAL(void)
+JLOCAL(void)
 select_scan_parameters (j_compress_ptr cinfo)
 /* Set up the scan parameters for the current scan */
 {
@@ -548,7 +548,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 per_scan_setup (j_compress_ptr cinfo)
 /* Do computations that are needed before processing a JPEG scan */
 /* cinfo->comps_in_scan and cinfo->cur_comp_info[] are already set */
@@ -641,7 +641,7 @@
  * required.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 prepare_for_pass (j_compress_ptr cinfo)
 {
   my_master_ptr master = (my_master_ptr) cinfo->master;
@@ -729,7 +729,7 @@
  * In multi-pass processing, this routine is not used.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 pass_startup (j_compress_ptr cinfo)
 {
   cinfo->master->call_pass_startup = FALSE; /* reset flag so call only once */
@@ -743,7 +743,7 @@
  * Finish up at end of pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_pass_master (j_compress_ptr cinfo)
 {
   my_master_ptr master = (my_master_ptr) cinfo->master;
@@ -783,7 +783,7 @@
  * Initialize master compression control.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_c_master_control (j_compress_ptr cinfo, boolean transcode_only)
 {
   my_master_ptr master;
--- jcomapi.c.orig	1997-10-08 20:01:22.000000000 +0100
+++ jcomapi.c	2011-01-05 21:55:15.000000000 +0000
@@ -25,7 +25,7 @@
  * responsibility.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_abort (j_common_ptr cinfo)
 {
   int pool;
@@ -65,7 +65,7 @@
  * responsibility.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_destroy (j_common_ptr cinfo)
 {
   /* We need only tell the memory manager to release everything. */
@@ -82,7 +82,7 @@
  * (Would jutils.c be a more reasonable place to put these?)
  */
 
-GLOBAL(JQUANT_TBL *)
+JGLOBAL(JQUANT_TBL *)
 jpeg_alloc_quant_table (j_common_ptr cinfo)
 {
   JQUANT_TBL *tbl;
@@ -94,7 +94,7 @@
 }
 
 
-GLOBAL(JHUFF_TBL *)
+JGLOBAL(JHUFF_TBL *)
 jpeg_alloc_huff_table (j_common_ptr cinfo)
 {
   JHUFF_TBL *tbl;
--- jconfig.cfg.orig	2010-04-29 13:42:58.000000000 +0100
+++ jconfig.cfg	2011-01-05 21:55:15.000000000 +0000
@@ -28,7 +28,7 @@
 #ifdef JPEG_INTERNALS
 
 #undef RIGHT_SHIFT_IS_UNSIGNED
-#undef INLINE
+#undef JINLINE
 /* These are for configuring the JPEG memory manager. */
 #undef DEFAULT_MAX_MEM
 #undef NO_MKTEMP
--- jcparam.c.orig	2008-12-30 11:38:14.000000000 +0000
+++ jcparam.c	2011-01-05 21:55:15.000000000 +0000
@@ -20,7 +20,7 @@
  * Quantization table setup routines
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_add_quant_table (j_compress_ptr cinfo, int which_tbl,
 		      const unsigned int *basic_table,
 		      int scale_factor, boolean force_baseline)
@@ -87,7 +87,7 @@
 };
 
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_default_qtables (j_compress_ptr cinfo, boolean force_baseline)
 /* Set or change the 'quality' (quantization) setting, using default tables
  * and straight percentage-scaling quality scales.
@@ -102,7 +102,7 @@
 }
 
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_set_linear_quality (j_compress_ptr cinfo, int scale_factor,
 			 boolean force_baseline)
 /* Set or change the 'quality' (quantization) setting, using default tables
@@ -119,7 +119,7 @@
 }
 
 
-GLOBAL(int)
+JGLOBAL(int)
 jpeg_quality_scaling (int quality)
 /* Convert a user-specified quality rating to a percentage scaling factor
  * for an underlying quantization table, using our recommended scaling curve.
@@ -145,7 +145,7 @@
 }
 
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_set_quality (j_compress_ptr cinfo, int quality, boolean force_baseline)
 /* Set or change the 'quality' (quantization) setting, using default tables.
  * This is the standard quality-adjusting entry point for typical user
@@ -165,7 +165,7 @@
  * Huffman table setup routines
  */
 
-LOCAL(void)
+JLOCAL(void)
 add_huff_table (j_compress_ptr cinfo,
 		JHUFF_TBL **htblptr, const UINT8 *bits, const UINT8 *val)
 /* Define a Huffman table */
@@ -195,7 +195,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 std_huff_tables (j_compress_ptr cinfo)
 /* Set up the standard Huffman tables (cf. JPEG standard section K.3) */
 /* IMPORTANT: these are only valid for 8-bit data precision! */
@@ -281,7 +281,7 @@
  * your code will still work (they'll be set to reasonable defaults).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_set_defaults (j_compress_ptr cinfo)
 {
   int i;
@@ -377,7 +377,7 @@
  * Select an appropriate JPEG colorspace for in_color_space.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_default_colorspace (j_compress_ptr cinfo)
 {
   switch (cinfo->in_color_space) {
@@ -409,7 +409,7 @@
  * Set the JPEG colorspace, and choose colorspace-dependent default values.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_set_colorspace (j_compress_ptr cinfo, J_COLOR_SPACE colorspace)
 {
   jpeg_component_info * compptr;
@@ -493,7 +493,7 @@
 
 #ifdef C_PROGRESSIVE_SUPPORTED
 
-LOCAL(jpeg_scan_info *)
+JLOCAL(jpeg_scan_info *)
 fill_a_scan (jpeg_scan_info * scanptr, int ci,
 	     int Ss, int Se, int Ah, int Al)
 /* Support routine: generate one scan for specified component */
@@ -508,7 +508,7 @@
   return scanptr;
 }
 
-LOCAL(jpeg_scan_info *)
+JLOCAL(jpeg_scan_info *)
 fill_scans (jpeg_scan_info * scanptr, int ncomps,
 	    int Ss, int Se, int Ah, int Al)
 /* Support routine: generate one scan for each component */
@@ -527,7 +527,7 @@
   return scanptr;
 }
 
-LOCAL(jpeg_scan_info *)
+JLOCAL(jpeg_scan_info *)
 fill_dc_scans (jpeg_scan_info * scanptr, int ncomps, int Ah, int Al)
 /* Support routine: generate interleaved DC scan if possible, else N scans */
 {
@@ -555,7 +555,7 @@
  * cinfo->num_components and cinfo->jpeg_color_space must be correct.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_simple_progression (j_compress_ptr cinfo)
 {
   int ncomps = cinfo->num_components;
--- jcprepct.c.orig	2003-10-19 18:47:16.000000000 +0100
+++ jcprepct.c	2011-01-05 21:55:15.000000000 +0000
@@ -74,7 +74,7 @@
  * Initialize for a processing pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass_prep (j_compress_ptr cinfo, J_BUF_MODE pass_mode)
 {
   my_prep_ptr prep = (my_prep_ptr) cinfo->prep;
@@ -102,7 +102,7 @@
  * by duplicating the bottom row.
  */
 
-LOCAL(void)
+JLOCAL(void)
 expand_bottom_edge (JSAMPARRAY image_data, JDIMENSION num_cols,
 		    int input_rows, int output_rows)
 {
@@ -124,7 +124,7 @@
  * input rows.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 pre_process_data (j_compress_ptr cinfo,
 		  JSAMPARRAY input_buf, JDIMENSION *in_row_ctr,
 		  JDIMENSION in_rows_avail,
@@ -193,7 +193,7 @@
  * Process some data in the context case.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 pre_process_context (j_compress_ptr cinfo,
 		     JSAMPARRAY input_buf, JDIMENSION *in_row_ctr,
 		     JDIMENSION in_rows_avail,
@@ -265,7 +265,7 @@
  * Create the wrapped-around downsampling input buffer needed for context mode.
  */
 
-LOCAL(void)
+JLOCAL(void)
 create_context_buffer (j_compress_ptr cinfo)
 {
   my_prep_ptr prep = (my_prep_ptr) cinfo->prep;
@@ -314,7 +314,7 @@
  * Initialize preprocessing controller.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_c_prep_controller (j_compress_ptr cinfo, boolean need_full_buffer)
 {
   my_prep_ptr prep;
--- jcsample.c.orig	2003-10-21 15:13:36.000000000 +0100
+++ jcsample.c	2011-01-05 21:55:15.000000000 +0000
@@ -80,7 +80,7 @@
  * Initialize for a downsampling pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass_downsample (j_compress_ptr cinfo)
 {
   /* no work for now */
@@ -92,7 +92,7 @@
  * by duplicating the rightmost samples.
  */
 
-LOCAL(void)
+JLOCAL(void)
 expand_right_edge (JSAMPARRAY image_data, int num_rows,
 		   JDIMENSION input_cols, JDIMENSION output_cols)
 {
@@ -119,7 +119,7 @@
  * In this version we simply downsample each component independently.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 sep_downsample (j_compress_ptr cinfo,
 		JSAMPIMAGE input_buf, JDIMENSION in_row_index,
 		JSAMPIMAGE output_buf, JDIMENSION out_row_group_index)
@@ -146,7 +146,7 @@
  * Note that this version is not actually used for customary sampling ratios.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 int_downsample (j_compress_ptr cinfo, jpeg_component_info * compptr,
 		JSAMPARRAY input_data, JSAMPARRAY output_data)
 {
@@ -195,7 +195,7 @@
  * without smoothing.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 fullsize_downsample (j_compress_ptr cinfo, jpeg_component_info * compptr,
 		     JSAMPARRAY input_data, JSAMPARRAY output_data)
 {
@@ -220,7 +220,7 @@
  * alternate pixel locations (a simple ordered dither pattern).
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 h2v1_downsample (j_compress_ptr cinfo, jpeg_component_info * compptr,
 		 JSAMPARRAY input_data, JSAMPARRAY output_data)
 {
@@ -257,7 +257,7 @@
  * without smoothing.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 h2v2_downsample (j_compress_ptr cinfo, jpeg_component_info * compptr,
 		 JSAMPARRAY input_data, JSAMPARRAY output_data)
 {
@@ -301,7 +301,7 @@
  * with smoothing.  One row of context is required.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 h2v2_smooth_downsample (j_compress_ptr cinfo, jpeg_component_info * compptr,
 			JSAMPARRAY input_data, JSAMPARRAY output_data)
 {
@@ -402,7 +402,7 @@
  * with smoothing.  One row of context is required.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 fullsize_smooth_downsample (j_compress_ptr cinfo, jpeg_component_info *compptr,
 			    JSAMPARRAY input_data, JSAMPARRAY output_data)
 {
@@ -474,7 +474,7 @@
  * Note that we must select a routine for each component.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_downsampler (j_compress_ptr cinfo)
 {
   my_downsample_ptr downsample;
--- jctrans.c.orig	2009-09-14 00:35:44.000000000 +0100
+++ jctrans.c	2011-01-05 21:55:15.000000000 +0000
@@ -17,9 +17,9 @@
 
 
 /* Forward declarations */
-LOCAL(void) transencode_master_selection
+JLOCAL(void) transencode_master_selection
 	JPP((j_compress_ptr cinfo, jvirt_barray_ptr * coef_arrays));
-LOCAL(void) transencode_coef_controller
+JLOCAL(void) transencode_coef_controller
 	JPP((j_compress_ptr cinfo, jvirt_barray_ptr * coef_arrays));
 
 
@@ -35,7 +35,7 @@
  * typically will be realized during this routine and filled afterwards.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_write_coefficients (j_compress_ptr cinfo, jvirt_barray_ptr * coef_arrays)
 {
   if (cinfo->global_state != CSTATE_START)
@@ -60,7 +60,7 @@
  * scan script and Huffman optimization) are left in their default states.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_copy_critical_parameters (j_decompress_ptr srcinfo,
 			       j_compress_ptr dstinfo)
 {
@@ -159,7 +159,7 @@
  * This substitutes for jcinit.c's initialization of the full compressor.
  */
 
-LOCAL(void)
+JLOCAL(void)
 transencode_master_selection (j_compress_ptr cinfo,
 			      jvirt_barray_ptr * coef_arrays)
 {
@@ -217,7 +217,7 @@
 typedef my_coef_controller * my_coef_ptr;
 
 
-LOCAL(void)
+JLOCAL(void)
 start_iMCU_row (j_compress_ptr cinfo)
 /* Reset within-iMCU-row counters for a new row */
 {
@@ -245,7 +245,7 @@
  * Initialize for a processing pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass_coef (j_compress_ptr cinfo, J_BUF_MODE pass_mode)
 {
   my_coef_ptr coef = (my_coef_ptr) cinfo->coef;
@@ -268,7 +268,7 @@
  * NB: input_buf is ignored; it is likely to be a NULL pointer.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 compress_output (j_compress_ptr cinfo, JSAMPIMAGE input_buf)
 {
   my_coef_ptr coef = (my_coef_ptr) cinfo->coef;
@@ -353,7 +353,7 @@
  * with unitheight at least v_samp_factor.
  */
 
-LOCAL(void)
+JLOCAL(void)
 transencode_coef_controller (j_compress_ptr cinfo,
 			     jvirt_barray_ptr * coef_arrays)
 {
--- jdapimin.c.orig	2009-06-25 09:26:52.000000000 +0100
+++ jdapimin.c	2011-01-05 21:55:15.000000000 +0000
@@ -27,7 +27,7 @@
  * The error manager must already be set up (in case memory manager fails).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_CreateDecompress (j_decompress_ptr cinfo, int version, size_t structsize)
 {
   int i;
@@ -88,7 +88,7 @@
  * Destruction of a JPEG decompression object
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_destroy_decompress (j_decompress_ptr cinfo)
 {
   jpeg_destroy((j_common_ptr) cinfo); /* use common routine */
@@ -100,7 +100,7 @@
  * but don't destroy the object itself.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_abort_decompress (j_decompress_ptr cinfo)
 {
   jpeg_abort((j_common_ptr) cinfo); /* use common routine */
@@ -111,7 +111,7 @@
  * Set default decompression parameters.
  */
 
-LOCAL(void)
+JLOCAL(void)
 default_decompress_parms (j_decompress_ptr cinfo)
 {
   /* Guess the input colorspace, and set output colorspace accordingly. */
@@ -238,7 +238,7 @@
  * extra error checking.
  */
 
-GLOBAL(int)
+JGLOBAL(int)
 jpeg_read_header (j_decompress_ptr cinfo, boolean require_image)
 {
   int retcode;
@@ -284,7 +284,7 @@
  * method.
  */
 
-GLOBAL(int)
+JGLOBAL(int)
 jpeg_consume_input (j_decompress_ptr cinfo)
 {
   int retcode = JPEG_SUSPENDED;
@@ -331,7 +331,7 @@
  * Have we finished reading the input file?
  */
 
-GLOBAL(boolean)
+JGLOBAL(boolean)
 jpeg_input_complete (j_decompress_ptr cinfo)
 {
   /* Check for valid jpeg object */
@@ -346,7 +346,7 @@
  * Is there more than one scan?
  */
 
-GLOBAL(boolean)
+JGLOBAL(boolean)
 jpeg_has_multiple_scans (j_decompress_ptr cinfo)
 {
   /* Only valid after jpeg_read_header completes */
@@ -366,7 +366,7 @@
  * a suspending data source is used.
  */
 
-GLOBAL(boolean)
+JGLOBAL(boolean)
 jpeg_finish_decompress (j_decompress_ptr cinfo)
 {
   if ((cinfo->global_state == DSTATE_SCANNING ||
--- jdapistd.c.orig	2002-02-24 18:59:32.000000000 +0000
+++ jdapistd.c	2011-01-05 21:55:15.000000000 +0000
@@ -20,7 +20,7 @@
 
 
 /* Forward declarations */
-LOCAL(boolean) output_pass_setup JPP((j_decompress_ptr cinfo));
+JLOCAL(boolean) output_pass_setup JPP((j_decompress_ptr cinfo));
 
 
 /*
@@ -34,7 +34,7 @@
  * a suspending data source is used.
  */
 
-GLOBAL(boolean)
+JGLOBAL(boolean)
 jpeg_start_decompress (j_decompress_ptr cinfo)
 {
   if (cinfo->global_state == DSTATE_READY) {
@@ -91,7 +91,7 @@
  *       If suspended, returns FALSE and sets global_state = DSTATE_PRESCAN.
  */
 
-LOCAL(boolean)
+JLOCAL(boolean)
 output_pass_setup (j_decompress_ptr cinfo)
 {
   if (cinfo->global_state != DSTATE_PRESCAN) {
@@ -148,7 +148,7 @@
  * an oversize buffer (max_lines > scanlines remaining) is not an error.
  */
 
-GLOBAL(JDIMENSION)
+JGLOBAL(JDIMENSION)
 jpeg_read_scanlines (j_decompress_ptr cinfo, JSAMPARRAY scanlines,
 		     JDIMENSION max_lines)
 {
@@ -181,7 +181,7 @@
  * Processes exactly one iMCU row per call, unless suspended.
  */
 
-GLOBAL(JDIMENSION)
+JGLOBAL(JDIMENSION)
 jpeg_read_raw_data (j_decompress_ptr cinfo, JSAMPIMAGE data,
 		    JDIMENSION max_lines)
 {
@@ -224,7 +224,7 @@
  * Initialize for an output pass in buffered-image mode.
  */
 
-GLOBAL(boolean)
+JGLOBAL(boolean)
 jpeg_start_output (j_decompress_ptr cinfo, int scan_number)
 {
   if (cinfo->global_state != DSTATE_BUFIMAGE &&
@@ -249,7 +249,7 @@
  * a suspending data source is used.
  */
 
-GLOBAL(boolean)
+JGLOBAL(boolean)
 jpeg_finish_output (j_decompress_ptr cinfo)
 {
   if ((cinfo->global_state == DSTATE_SCANNING ||
--- jdarith.c.orig	2009-09-16 19:53:08.000000000 +0100
+++ jdarith.c	2011-01-05 21:55:15.000000000 +0000
@@ -61,7 +61,7 @@
 #define AC_STAT_BINS 256
 
 
-LOCAL(int)
+JLOCAL(int)
 get_byte (j_decompress_ptr cinfo)
 /* Read next input byte; we do not support suspension in this module. */
 {
@@ -102,7 +102,7 @@
  * derived from Markus Kuhn's JBIG implementation.
  */
 
-LOCAL(int)
+JLOCAL(int)
 arith_decode (j_decompress_ptr cinfo, unsigned char *st)
 {
   register arith_entropy_ptr e = (arith_entropy_ptr) cinfo->entropy;
@@ -186,7 +186,7 @@
  * Check for a restart marker & resynchronize decoder.
  */
 
-LOCAL(void)
+JLOCAL(void)
 process_restart (j_decompress_ptr cinfo)
 {
   arith_entropy_ptr entropy = (arith_entropy_ptr) cinfo->entropy;
@@ -238,7 +238,7 @@
  * or first pass of successive approximation).
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 decode_mcu_DC_first (j_decompress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   arith_entropy_ptr entropy = (arith_entropy_ptr) cinfo->entropy;
@@ -317,7 +317,7 @@
  * or first pass of successive approximation).
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 decode_mcu_AC_first (j_decompress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   arith_entropy_ptr entropy = (arith_entropy_ptr) cinfo->entropy;
@@ -394,7 +394,7 @@
  * MCU decoding for DC successive approximation refinement scan.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 decode_mcu_DC_refine (j_decompress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   arith_entropy_ptr entropy = (arith_entropy_ptr) cinfo->entropy;
@@ -427,7 +427,7 @@
  * MCU decoding for AC successive approximation refinement scan.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 decode_mcu_AC_refine (j_decompress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   arith_entropy_ptr entropy = (arith_entropy_ptr) cinfo->entropy;
@@ -499,7 +499,7 @@
  * Decode one MCU's worth of arithmetic-compressed coefficients.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 decode_mcu (j_decompress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   arith_entropy_ptr entropy = (arith_entropy_ptr) cinfo->entropy;
@@ -627,7 +627,7 @@
  * Initialize for an arithmetic-compressed scan.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass (j_decompress_ptr cinfo)
 {
   arith_entropy_ptr entropy = (arith_entropy_ptr) cinfo->entropy;
@@ -737,7 +737,7 @@
  * Module initialization routine for arithmetic entropy decoding.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_arith_decoder (j_decompress_ptr cinfo)
 {
   arith_entropy_ptr entropy;
--- jdatadst.c.orig	2009-11-16 15:52:18.000000000 +0000
+++ jdatadst.c	2011-01-05 21:55:15.000000000 +0000
@@ -60,7 +60,7 @@
  * before any data is actually written.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 init_destination (j_compress_ptr cinfo)
 {
   my_dest_ptr dest = (my_dest_ptr) cinfo->dest;
@@ -74,7 +74,7 @@
   dest->pub.free_in_buffer = OUTPUT_BUF_SIZE;
 }
 
-METHODDEF(void)
+JMETHODDEF(void)
 init_mem_destination (j_compress_ptr cinfo)
 {
   /* no work necessary here */
@@ -104,7 +104,7 @@
  * write it out when emptying the buffer externally.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 empty_output_buffer (j_compress_ptr cinfo)
 {
   my_dest_ptr dest = (my_dest_ptr) cinfo->dest;
@@ -119,7 +119,7 @@
   return TRUE;
 }
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 empty_mem_output_buffer (j_compress_ptr cinfo)
 {
   size_t nextsize;
@@ -159,7 +159,7 @@
  * for error exit.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 term_destination (j_compress_ptr cinfo)
 {
   my_dest_ptr dest = (my_dest_ptr) cinfo->dest;
@@ -176,7 +176,7 @@
     ERREXIT(cinfo, JERR_FILE_WRITE);
 }
 
-METHODDEF(void)
+JMETHODDEF(void)
 term_mem_destination (j_compress_ptr cinfo)
 {
   my_mem_dest_ptr dest = (my_mem_dest_ptr) cinfo->dest;
@@ -192,7 +192,7 @@
  * for closing it after finishing compression.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_stdio_dest (j_compress_ptr cinfo, FILE * outfile)
 {
   my_dest_ptr dest;
@@ -228,7 +228,7 @@
  * freeing the requested memory.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_mem_dest (j_compress_ptr cinfo,
 	       unsigned char ** outbuffer, unsigned long * outsize)
 {
--- jdatasrc.c.orig	2010-04-29 10:49:52.000000000 +0100
+++ jdatasrc.c	2011-01-05 21:55:15.000000000 +0000
@@ -41,7 +41,7 @@
  * before any data is actually read.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 init_source (j_decompress_ptr cinfo)
 {
   my_src_ptr src = (my_src_ptr) cinfo->src;
@@ -53,7 +53,7 @@
   src->start_of_file = TRUE;
 }
 
-METHODDEF(void)
+JMETHODDEF(void)
 init_mem_source (j_decompress_ptr cinfo)
 {
   /* no work necessary here */
@@ -93,7 +93,7 @@
  * the front of the buffer rather than discarding it.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 fill_input_buffer (j_decompress_ptr cinfo)
 {
   my_src_ptr src = (my_src_ptr) cinfo->src;
@@ -118,7 +118,7 @@
   return TRUE;
 }
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 fill_mem_input_buffer (j_decompress_ptr cinfo)
 {
   static JOCTET mybuffer[4];
@@ -151,7 +151,7 @@
  * buffer is the application writer's problem.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 skip_input_data (j_decompress_ptr cinfo, long num_bytes)
 {
   struct jpeg_source_mgr * src = cinfo->src;
@@ -192,7 +192,7 @@
  * for error exit.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 term_source (j_decompress_ptr cinfo)
 {
   /* no work necessary here */
@@ -205,7 +205,7 @@
  * for closing it after finishing decompression.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_stdio_src (j_decompress_ptr cinfo, FILE * infile)
 {
   my_src_ptr src;
@@ -244,7 +244,7 @@
  * The buffer must contain the whole JPEG data.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_mem_src (j_decompress_ptr cinfo,
 	      unsigned char * inbuffer, unsigned long insize)
 {
--- jdcoefct.c.orig	2002-02-24 18:29:28.000000000 +0000
+++ jdcoefct.c	2011-01-05 21:55:15.000000000 +0000
@@ -62,20 +62,20 @@
 typedef my_coef_controller * my_coef_ptr;
 
 /* Forward declarations */
-METHODDEF(int) decompress_onepass
+JMETHODDEF(int) decompress_onepass
 	JPP((j_decompress_ptr cinfo, JSAMPIMAGE output_buf));
 #ifdef D_MULTISCAN_FILES_SUPPORTED
-METHODDEF(int) decompress_data
+JMETHODDEF(int) decompress_data
 	JPP((j_decompress_ptr cinfo, JSAMPIMAGE output_buf));
 #endif
 #ifdef BLOCK_SMOOTHING_SUPPORTED
-LOCAL(boolean) smoothing_ok JPP((j_decompress_ptr cinfo));
-METHODDEF(int) decompress_smooth_data
+JLOCAL(boolean) smoothing_ok JPP((j_decompress_ptr cinfo));
+JMETHODDEF(int) decompress_smooth_data
 	JPP((j_decompress_ptr cinfo, JSAMPIMAGE output_buf));
 #endif
 
 
-LOCAL(void)
+JLOCAL(void)
 start_iMCU_row (j_decompress_ptr cinfo)
 /* Reset within-iMCU-row counters for a new row (input side) */
 {
@@ -103,7 +103,7 @@
  * Initialize for an input processing pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_input_pass (j_decompress_ptr cinfo)
 {
   cinfo->input_iMCU_row = 0;
@@ -115,7 +115,7 @@
  * Initialize for an output processing pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_output_pass (j_decompress_ptr cinfo)
 {
 #ifdef BLOCK_SMOOTHING_SUPPORTED
@@ -143,7 +143,7 @@
  * which we index according to the component's SOF position.
  */
 
-METHODDEF(int)
+JMETHODDEF(int)
 decompress_onepass (j_decompress_ptr cinfo, JSAMPIMAGE output_buf)
 {
   my_coef_ptr coef = (my_coef_ptr) cinfo->coef;
@@ -224,7 +224,7 @@
  * Dummy consume-input routine for single-pass operation.
  */
 
-METHODDEF(int)
+JMETHODDEF(int)
 dummy_consume_data (j_decompress_ptr cinfo)
 {
   return JPEG_SUSPENDED;	/* Always indicate nothing was done */
@@ -240,7 +240,7 @@
  * Return value is JPEG_ROW_COMPLETED, JPEG_SCAN_COMPLETED, or JPEG_SUSPENDED.
  */
 
-METHODDEF(int)
+JMETHODDEF(int)
 consume_data (j_decompress_ptr cinfo)
 {
   my_coef_ptr coef = (my_coef_ptr) cinfo->coef;
@@ -311,7 +311,7 @@
  * NB: output_buf contains a plane for each component in image.
  */
 
-METHODDEF(int)
+JMETHODDEF(int)
 decompress_data (j_decompress_ptr cinfo, JSAMPIMAGE output_buf)
 {
   my_coef_ptr coef = (my_coef_ptr) cinfo->coef;
@@ -401,7 +401,7 @@
  * more accurately than they really are.
  */
 
-LOCAL(boolean)
+JLOCAL(boolean)
 smoothing_ok (j_decompress_ptr cinfo)
 {
   my_coef_ptr coef = (my_coef_ptr) cinfo->coef;
@@ -457,7 +457,7 @@
  * Variant of decompress_data for use when doing block smoothing.
  */
 
-METHODDEF(int)
+JMETHODDEF(int)
 decompress_smooth_data (j_decompress_ptr cinfo, JSAMPIMAGE output_buf)
 {
   my_coef_ptr coef = (my_coef_ptr) cinfo->coef;
@@ -672,7 +672,7 @@
  * Initialize coefficient buffer controller.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_d_coef_controller (j_decompress_ptr cinfo, boolean need_full_buffer)
 {
   my_coef_ptr coef;
--- jdcolor.c.orig	1997-08-03 19:39:16.000000000 +0100
+++ jdcolor.c	2011-01-05 21:55:15.000000000 +0000
@@ -66,7 +66,7 @@
  * Initialize tables for YCC->RGB colorspace conversion.
  */
 
-LOCAL(void)
+JLOCAL(void)
 build_ycc_rgb_table (j_decompress_ptr cinfo)
 {
   my_cconvert_ptr cconvert = (my_cconvert_ptr) cinfo->cconvert;
@@ -116,7 +116,7 @@
  * offset required on that side.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 ycc_rgb_convert (j_decompress_ptr cinfo,
 		 JSAMPIMAGE input_buf, JDIMENSION input_row,
 		 JSAMPARRAY output_buf, int num_rows)
@@ -165,7 +165,7 @@
  * converting from separate-planes to interleaved representation.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 null_convert (j_decompress_ptr cinfo,
 	      JSAMPIMAGE input_buf, JDIMENSION input_row,
 	      JSAMPARRAY output_buf, int num_rows)
@@ -197,7 +197,7 @@
  * we just copy the Y (luminance) component and ignore chrominance.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 grayscale_convert (j_decompress_ptr cinfo,
 		   JSAMPIMAGE input_buf, JDIMENSION input_row,
 		   JSAMPARRAY output_buf, int num_rows)
@@ -213,7 +213,7 @@
  * with grayscale as a separate case.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 gray_rgb_convert (j_decompress_ptr cinfo,
 		  JSAMPIMAGE input_buf, JDIMENSION input_row,
 		  JSAMPARRAY output_buf, int num_rows)
@@ -241,7 +241,7 @@
  * We assume build_ycc_rgb_table has been called.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 ycck_cmyk_convert (j_decompress_ptr cinfo,
 		   JSAMPIMAGE input_buf, JDIMENSION input_row,
 		   JSAMPARRAY output_buf, int num_rows)
@@ -289,7 +289,7 @@
  * Empty method for start_pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass_dcolor (j_decompress_ptr cinfo)
 {
   /* no work needed */
@@ -300,7 +300,7 @@
  * Module initialization routine for output colorspace conversion.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_color_deconverter (j_decompress_ptr cinfo)
 {
   my_cconvert_ptr cconvert;
--- jdct.h.orig	2004-03-06 19:18:30.000000000 +0000
+++ jdct.h	2011-01-05 22:27:21.000000000 +0000
@@ -162,175 +162,175 @@
 
 /* Extern declarations for the forward and inverse DCT routines. */
 
-EXTERN(void) jpeg_fdct_islow
+JEXTERN(void) jpeg_fdct_islow
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_ifast
+JEXTERN(void) jpeg_fdct_ifast
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_float
+JEXTERN(void) jpeg_fdct_float
     JPP((FAST_FLOAT * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_7x7
+JEXTERN(void) jpeg_fdct_7x7
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_6x6
+JEXTERN(void) jpeg_fdct_6x6
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_5x5
+JEXTERN(void) jpeg_fdct_5x5
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_4x4
+JEXTERN(void) jpeg_fdct_4x4
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_3x3
+JEXTERN(void) jpeg_fdct_3x3
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_2x2
+JEXTERN(void) jpeg_fdct_2x2
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_1x1
+JEXTERN(void) jpeg_fdct_1x1
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_9x9
+JEXTERN(void) jpeg_fdct_9x9
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_10x10
+JEXTERN(void) jpeg_fdct_10x10
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_11x11
+JEXTERN(void) jpeg_fdct_11x11
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_12x12
+JEXTERN(void) jpeg_fdct_12x12
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_13x13
+JEXTERN(void) jpeg_fdct_13x13
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_14x14
+JEXTERN(void) jpeg_fdct_14x14
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_15x15
+JEXTERN(void) jpeg_fdct_15x15
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_16x16
+JEXTERN(void) jpeg_fdct_16x16
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_16x8
+JEXTERN(void) jpeg_fdct_16x8
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_14x7
+JEXTERN(void) jpeg_fdct_14x7
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_12x6
+JEXTERN(void) jpeg_fdct_12x6
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_10x5
+JEXTERN(void) jpeg_fdct_10x5
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_8x4
+JEXTERN(void) jpeg_fdct_8x4
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_6x3
+JEXTERN(void) jpeg_fdct_6x3
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_4x2
+JEXTERN(void) jpeg_fdct_4x2
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_2x1
+JEXTERN(void) jpeg_fdct_2x1
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_8x16
+JEXTERN(void) jpeg_fdct_8x16
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_7x14
+JEXTERN(void) jpeg_fdct_7x14
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_6x12
+JEXTERN(void) jpeg_fdct_6x12
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_5x10
+JEXTERN(void) jpeg_fdct_5x10
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_4x8
+JEXTERN(void) jpeg_fdct_4x8
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_3x6
+JEXTERN(void) jpeg_fdct_3x6
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_2x4
+JEXTERN(void) jpeg_fdct_2x4
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
-EXTERN(void) jpeg_fdct_1x2
+JEXTERN(void) jpeg_fdct_1x2
     JPP((DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col));
 
-EXTERN(void) jpeg_idct_islow
+JEXTERN(void) jpeg_idct_islow
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_ifast
+JEXTERN(void) jpeg_idct_ifast
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_float
+JEXTERN(void) jpeg_idct_float
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_7x7
+JEXTERN(void) jpeg_idct_7x7
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_6x6
+JEXTERN(void) jpeg_idct_6x6
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_5x5
+JEXTERN(void) jpeg_idct_5x5
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_4x4
+JEXTERN(void) jpeg_idct_4x4
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_3x3
+JEXTERN(void) jpeg_idct_3x3
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_2x2
+JEXTERN(void) jpeg_idct_2x2
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_1x1
+JEXTERN(void) jpeg_idct_1x1
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_9x9
+JEXTERN(void) jpeg_idct_9x9
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_10x10
+JEXTERN(void) jpeg_idct_10x10
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_11x11
+JEXTERN(void) jpeg_idct_11x11
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_12x12
+JEXTERN(void) jpeg_idct_12x12
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_13x13
+JEXTERN(void) jpeg_idct_13x13
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_14x14
+JEXTERN(void) jpeg_idct_14x14
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_15x15
+JEXTERN(void) jpeg_idct_15x15
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_16x16
+JEXTERN(void) jpeg_idct_16x16
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_16x8
+JEXTERN(void) jpeg_idct_16x8
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_14x7
+JEXTERN(void) jpeg_idct_14x7
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_12x6
+JEXTERN(void) jpeg_idct_12x6
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_10x5
+JEXTERN(void) jpeg_idct_10x5
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_8x4
+JEXTERN(void) jpeg_idct_8x4
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_6x3
+JEXTERN(void) jpeg_idct_6x3
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_4x2
+JEXTERN(void) jpeg_idct_4x2
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_2x1
+JEXTERN(void) jpeg_idct_2x1
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_8x16
+JEXTERN(void) jpeg_idct_8x16
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_7x14
+JEXTERN(void) jpeg_idct_7x14
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_6x12
+JEXTERN(void) jpeg_idct_6x12
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_5x10
+JEXTERN(void) jpeg_idct_5x10
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_4x8
+JEXTERN(void) jpeg_idct_4x8
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_3x6
+JEXTERN(void) jpeg_idct_3x6
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_2x4
+JEXTERN(void) jpeg_idct_2x4
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
-EXTERN(void) jpeg_idct_1x2
+JEXTERN(void) jpeg_idct_1x2
     JPP((j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	 JCOEFPTR coef_block, JSAMPARRAY output_buf, JDIMENSION output_col));
 
--- jddctmgr.c.orig	2010-02-20 09:41:32.000000000 +0000
+++ jddctmgr.c	2011-01-05 21:55:15.000000000 +0000
@@ -86,7 +86,7 @@
  * a matching multiplier table.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass (j_decompress_ptr cinfo)
 {
   my_idct_ptr idct = (my_idct_ptr) cinfo->idct;
@@ -358,7 +358,7 @@
  * Initialize IDCT manager.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_inverse_dct (j_decompress_ptr cinfo)
 {
   my_idct_ptr idct;
--- jdhuff.c.orig	2009-09-19 09:59:10.000000000 +0100
+++ jdhuff.c	2011-01-05 21:55:15.000000000 +0000
@@ -319,7 +319,7 @@
  * This routine also performs some validation checks on the table.
  */
 
-LOCAL(void)
+JLOCAL(void)
 jpeg_make_d_derived_tbl (j_decompress_ptr cinfo, boolean isDC, int tblno,
 			 d_derived_tbl ** pdtbl)
 {
@@ -461,7 +461,7 @@
 #endif
 
 
-LOCAL(boolean)
+JLOCAL(boolean)
 jpeg_fill_bit_buffer (bitread_working_state * state,
 		      register bit_buf_type get_buffer, register int bits_left,
 		      int nbits)
@@ -588,7 +588,7 @@
  * Out-of-line code for Huffman code decoding.
  */
 
-LOCAL(int)
+JLOCAL(int)
 jpeg_huff_decode (bitread_working_state * state,
 		  register bit_buf_type get_buffer, register int bits_left,
 		  d_derived_tbl * htbl, int min_bits)
@@ -632,7 +632,7 @@
  * Returns FALSE if must suspend.
  */
 
-LOCAL(boolean)
+JLOCAL(boolean)
 process_restart (j_decompress_ptr cinfo)
 {
   huff_entropy_ptr entropy = (huff_entropy_ptr) cinfo->entropy;
@@ -691,7 +691,7 @@
  * or first pass of successive approximation).
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 decode_mcu_DC_first (j_decompress_ptr cinfo, JBLOCKROW *MCU_data)
 {   
   huff_entropy_ptr entropy = (huff_entropy_ptr) cinfo->entropy;
@@ -762,7 +762,7 @@
  * or first pass of successive approximation).
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 decode_mcu_AC_first (j_decompress_ptr cinfo, JBLOCKROW *MCU_data)
 {   
   huff_entropy_ptr entropy = (huff_entropy_ptr) cinfo->entropy;
@@ -851,7 +851,7 @@
  * is not very clear on the point.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 decode_mcu_DC_refine (j_decompress_ptr cinfo, JBLOCKROW *MCU_data)
 {   
   huff_entropy_ptr entropy = (huff_entropy_ptr) cinfo->entropy;
@@ -900,7 +900,7 @@
  * MCU decoding for AC successive approximation refinement scan.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 decode_mcu_AC_refine (j_decompress_ptr cinfo, JBLOCKROW *MCU_data)
 {   
   huff_entropy_ptr entropy = (huff_entropy_ptr) cinfo->entropy;
@@ -1055,7 +1055,7 @@
  * partial blocks.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 decode_mcu_sub (j_decompress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   huff_entropy_ptr entropy = (huff_entropy_ptr) cinfo->entropy;
@@ -1183,7 +1183,7 @@
  * full-size blocks.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 decode_mcu (j_decompress_ptr cinfo, JBLOCKROW *MCU_data)
 {
   huff_entropy_ptr entropy = (huff_entropy_ptr) cinfo->entropy;
@@ -1306,7 +1306,7 @@
  * Initialize for a Huffman-compressed scan.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass_huff_decoder (j_decompress_ptr cinfo)
 {
   huff_entropy_ptr entropy = (huff_entropy_ptr) cinfo->entropy;
@@ -1505,7 +1505,7 @@
  * Module initialization routine for Huffman entropy decoding.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_huff_decoder (j_decompress_ptr cinfo)
 {
   huff_entropy_ptr entropy;
--- jdinput.c.orig	2009-12-28 10:01:10.000000000 +0000
+++ jdinput.c	2011-01-05 21:55:15.000000000 +0000
@@ -29,7 +29,7 @@
 
 
 /* Forward declarations */
-METHODDEF(int) consume_markers JPP((j_decompress_ptr cinfo));
+JMETHODDEF(int) consume_markers JPP((j_decompress_ptr cinfo));
 
 
 /*
@@ -43,7 +43,7 @@
  * Hence it mustn't do anything that can't be done twice.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_core_output_dimensions (j_decompress_ptr cinfo)
 /* Do computations that are needed before master selection phase.
  * This function is used for transcoding and full decompression.
@@ -204,7 +204,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 initial_setup (j_decompress_ptr cinfo)
 /* Called once, when first SOS marker is reached */
 {
@@ -384,7 +384,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 per_scan_setup (j_decompress_ptr cinfo)
 /* Do computations that are needed before processing a JPEG scan */
 /* cinfo->comps_in_scan and cinfo->cur_comp_info[] were set from SOS marker */
@@ -483,7 +483,7 @@
  * not at the current Q-table slots.
  */
 
-LOCAL(void)
+JLOCAL(void)
 latch_quant_tables (j_decompress_ptr cinfo)
 {
   int ci, qtblno;
@@ -517,7 +517,7 @@
  * Subsequent calls come from consume_markers, below.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_input_pass (j_decompress_ptr cinfo)
 {
   per_scan_setup(cinfo);
@@ -534,7 +534,7 @@
  * the expected data of the scan.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_input_pass (j_decompress_ptr cinfo)
 {
   cinfo->inputctl->consume_input = consume_markers;
@@ -555,7 +555,7 @@
  * read_markers is processed and then skipped for other markers.
  */
 
-METHODDEF(int)
+JMETHODDEF(int)
 consume_markers (j_decompress_ptr cinfo)
 {
   my_inputctl_ptr inputctl = (my_inputctl_ptr) cinfo->inputctl;
@@ -615,7 +615,7 @@
  * Reset state to begin a fresh datastream.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 reset_input_controller (j_decompress_ptr cinfo)
 {
   my_inputctl_ptr inputctl = (my_inputctl_ptr) cinfo->inputctl;
@@ -637,7 +637,7 @@
  * This is called only once, when the decompression object is created.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_input_controller (j_decompress_ptr cinfo)
 {
   my_inputctl_ptr inputctl;
--- jdmainct.c.orig	2002-02-24 19:07:28.000000000 +0000
+++ jdmainct.c	2011-01-05 21:55:15.000000000 +0000
@@ -140,20 +140,20 @@
 
 
 /* Forward declarations */
-METHODDEF(void) process_data_simple_main
+JMETHODDEF(void) process_data_simple_main
 	JPP((j_decompress_ptr cinfo, JSAMPARRAY output_buf,
 	     JDIMENSION *out_row_ctr, JDIMENSION out_rows_avail));
-METHODDEF(void) process_data_context_main
+JMETHODDEF(void) process_data_context_main
 	JPP((j_decompress_ptr cinfo, JSAMPARRAY output_buf,
 	     JDIMENSION *out_row_ctr, JDIMENSION out_rows_avail));
 #ifdef QUANT_2PASS_SUPPORTED
-METHODDEF(void) process_data_crank_post
+JMETHODDEF(void) process_data_crank_post
 	JPP((j_decompress_ptr cinfo, JSAMPARRAY output_buf,
 	     JDIMENSION *out_row_ctr, JDIMENSION out_rows_avail));
 #endif
 
 
-LOCAL(void)
+JLOCAL(void)
 alloc_funny_pointers (j_decompress_ptr cinfo)
 /* Allocate space for the funny pointer lists.
  * This is done only once, not once per pass.
@@ -191,7 +191,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 make_funny_pointers (j_decompress_ptr cinfo)
 /* Create the funny pointer lists discussed in the comments above.
  * The actual workspace is already allocated (in main->buffer),
@@ -234,7 +234,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 set_wraparound_pointers (j_decompress_ptr cinfo)
 /* Set up the "wraparound" pointers at top and bottom of the pointer lists.
  * This changes the pointer list state from top-of-image to the normal state.
@@ -262,7 +262,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 set_bottom_pointers (j_decompress_ptr cinfo)
 /* Change the pointer lists to duplicate the last sample row at the bottom
  * of the image.  whichptr indicates which xbuffer holds the final iMCU row.
@@ -303,7 +303,7 @@
  * Initialize for a processing pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass_main (j_decompress_ptr cinfo, J_BUF_MODE pass_mode)
 {
   my_main_ptr main = (my_main_ptr) cinfo->main;
@@ -341,7 +341,7 @@
  * This handles the simple case where no context is required.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 process_data_simple_main (j_decompress_ptr cinfo,
 			  JSAMPARRAY output_buf, JDIMENSION *out_row_ctr,
 			  JDIMENSION out_rows_avail)
@@ -381,7 +381,7 @@
  * This handles the case where context rows must be provided.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 process_data_context_main (j_decompress_ptr cinfo,
 			   JSAMPARRAY output_buf, JDIMENSION *out_row_ctr,
 			   JDIMENSION out_rows_avail)
@@ -455,7 +455,7 @@
 
 #ifdef QUANT_2PASS_SUPPORTED
 
-METHODDEF(void)
+JMETHODDEF(void)
 process_data_crank_post (j_decompress_ptr cinfo,
 			 JSAMPARRAY output_buf, JDIMENSION *out_row_ctr,
 			 JDIMENSION out_rows_avail)
@@ -472,7 +472,7 @@
  * Initialize main buffer controller.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_d_main_controller (j_decompress_ptr cinfo, boolean need_full_buffer)
 {
   my_main_ptr main;
--- jdmarker.c.orig	2009-08-29 18:49:24.000000000 +0100
+++ jdmarker.c	2011-01-05 21:55:15.000000000 +0000
@@ -194,7 +194,7 @@
  */
 
 
-LOCAL(boolean)
+JLOCAL(boolean)
 get_soi (j_decompress_ptr cinfo)
 /* Process an SOI marker */
 {
@@ -234,7 +234,7 @@
 }
 
 
-LOCAL(boolean)
+JLOCAL(boolean)
 get_sof (j_decompress_ptr cinfo, boolean is_baseline, boolean is_prog,
 	 boolean is_arith)
 /* Process a SOFn marker */
@@ -300,7 +300,7 @@
 }
 
 
-LOCAL(boolean)
+JLOCAL(boolean)
 get_sos (j_decompress_ptr cinfo)
 /* Process a SOS marker */
 {
@@ -374,7 +374,7 @@
 
 #ifdef D_ARITH_CODING_SUPPORTED
 
-LOCAL(boolean)
+JLOCAL(boolean)
 get_dac (j_decompress_ptr cinfo)
 /* Process a DAC marker */
 {
@@ -420,7 +420,7 @@
 #endif /* D_ARITH_CODING_SUPPORTED */
 
 
-LOCAL(boolean)
+JLOCAL(boolean)
 get_dht (j_decompress_ptr cinfo)
 /* Process a DHT marker */
 {
@@ -491,7 +491,7 @@
 }
 
 
-LOCAL(boolean)
+JLOCAL(boolean)
 get_dqt (j_decompress_ptr cinfo)
 /* Process a DQT marker */
 {
@@ -581,7 +581,7 @@
 }
 
 
-LOCAL(boolean)
+JLOCAL(boolean)
 get_dri (j_decompress_ptr cinfo)
 /* Process a DRI marker */
 {
@@ -617,7 +617,7 @@
 #define APPN_DATA_LEN	14	/* Must be the largest of the above!! */
 
 
-LOCAL(void)
+JLOCAL(void)
 examine_app0 (j_decompress_ptr cinfo, JOCTET FAR * data,
 	      unsigned int datalen, INT32 remaining)
 /* Examine first few bytes from an APP0.
@@ -693,7 +693,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 examine_app14 (j_decompress_ptr cinfo, JOCTET FAR * data,
 	       unsigned int datalen, INT32 remaining)
 /* Examine first few bytes from an APP14.
@@ -724,7 +724,7 @@
 }
 
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 get_interesting_appn (j_decompress_ptr cinfo)
 /* Process an APP0 or APP14 marker without saving it */
 {
@@ -772,7 +772,7 @@
 
 #ifdef SAVE_MARKERS_SUPPORTED
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 save_marker (j_decompress_ptr cinfo)
 /* Save an APPn or COM marker into the marker list */
 {
@@ -878,7 +878,7 @@
 #endif /* SAVE_MARKERS_SUPPORTED */
 
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 skip_variable (j_decompress_ptr cinfo)
 /* Skip over an unknown or uninteresting variable-length marker */
 {
@@ -907,7 +907,7 @@
  * but it will never be 0 or FF.
  */
 
-LOCAL(boolean)
+JLOCAL(boolean)
 next_marker (j_decompress_ptr cinfo)
 {
   int c;
@@ -954,7 +954,7 @@
 }
 
 
-LOCAL(boolean)
+JLOCAL(boolean)
 first_marker (j_decompress_ptr cinfo)
 /* Like next_marker, but used to obtain the initial SOI marker. */
 /* For this marker, we do not allow preceding garbage or fill; otherwise,
@@ -990,7 +990,7 @@
  * after processing for the caller.
  */
 
-METHODDEF(int)
+JMETHODDEF(int)
 read_markers (j_decompress_ptr cinfo)
 {
   /* Outer loop repeats once for each marker. */
@@ -1155,7 +1155,7 @@
  * it holds a marker which the decoder will be unable to read past.
  */
 
-METHODDEF(boolean)
+JMETHODDEF(boolean)
 read_restart_marker (j_decompress_ptr cinfo)
 {
   /* Obtain a marker unless we already did. */
@@ -1234,7 +1234,7 @@
  * any other marker would have to be bogus data in that case.
  */
 
-GLOBAL(boolean)
+JGLOBAL(boolean)
 jpeg_resync_to_restart (j_decompress_ptr cinfo, int desired)
 {
   int marker = cinfo->unread_marker;
@@ -1284,7 +1284,7 @@
  * Reset marker processing state to begin a fresh datastream.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 reset_marker_reader (j_decompress_ptr cinfo)
 {
   my_marker_ptr marker = (my_marker_ptr) cinfo->marker;
@@ -1304,7 +1304,7 @@
  * This is called only once, when the decompression object is created.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_marker_reader (j_decompress_ptr cinfo)
 {
   my_marker_ptr marker;
@@ -1342,7 +1342,7 @@
 
 #ifdef SAVE_MARKERS_SUPPORTED
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_save_markers (j_decompress_ptr cinfo, int marker_code,
 		   unsigned int length_limit)
 {
@@ -1391,7 +1391,7 @@
  * Install a special processing method for COM or APPn markers.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_set_marker_processor (j_decompress_ptr cinfo, int marker_code,
 			   jpeg_marker_parser_method routine)
 {
--- jdmaster.c.orig	2009-12-28 10:01:10.000000000 +0000
+++ jdmaster.c	2011-01-05 21:55:15.000000000 +0000
@@ -41,7 +41,7 @@
  * CRUCIAL: this must match the actual capabilities of jdmerge.c!
  */
 
-LOCAL(boolean)
+JLOCAL(boolean)
 use_merged_upsample (j_decompress_ptr cinfo)
 {
 #ifdef UPSAMPLE_MERGING_SUPPORTED
@@ -84,7 +84,7 @@
  * Also note that it may be called before the master module is initialized!
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_calc_output_dimensions (j_decompress_ptr cinfo)
 /* Do computations that are needed before master selection phase.
  * This function is used for full decompression.
@@ -227,7 +227,7 @@
  * enough and used often enough to justify this.
  */
 
-LOCAL(void)
+JLOCAL(void)
 prepare_range_limit_table (j_decompress_ptr cinfo)
 /* Allocate and fill in the sample_range_limit table */
 {
@@ -267,7 +267,7 @@
  * settings.
  */
 
-LOCAL(void)
+JLOCAL(void)
 master_selection (j_decompress_ptr cinfo)
 {
   my_master_ptr master = (my_master_ptr) cinfo->master;
@@ -410,7 +410,7 @@
  * (In the latter case, jdapistd.c will crank the pass to completion.)
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 prepare_for_output_pass (j_decompress_ptr cinfo)
 {
   my_master_ptr master = (my_master_ptr) cinfo->master;
@@ -470,7 +470,7 @@
  * Finish up at end of an output pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_output_pass (j_decompress_ptr cinfo)
 {
   my_master_ptr master = (my_master_ptr) cinfo->master;
@@ -487,7 +487,7 @@
  * Switch to a new external colormap between output passes.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_new_colormap (j_decompress_ptr cinfo)
 {
   my_master_ptr master = (my_master_ptr) cinfo->master;
@@ -515,7 +515,7 @@
  * This is performed at the start of jpeg_start_decompress.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_master_decompress (j_decompress_ptr cinfo)
 {
   my_master_ptr master;
--- jdmerge.c.orig	1996-01-06 17:27:36.000000000 +0000
+++ jdmerge.c	2011-01-05 21:55:15.000000000 +0000
@@ -79,7 +79,7 @@
  * This is taken directly from jdcolor.c; see that file for more info.
  */
 
-LOCAL(void)
+JLOCAL(void)
 build_ycc_rgb_table (j_decompress_ptr cinfo)
 {
   my_upsample_ptr upsample = (my_upsample_ptr) cinfo->upsample;
@@ -122,7 +122,7 @@
  * Initialize for an upsampling pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass_merged_upsample (j_decompress_ptr cinfo)
 {
   my_upsample_ptr upsample = (my_upsample_ptr) cinfo->upsample;
@@ -140,7 +140,7 @@
  * The control routine just handles the row buffering considerations.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 merged_2v_upsample (j_decompress_ptr cinfo,
 		    JSAMPIMAGE input_buf, JDIMENSION *in_row_group_ctr,
 		    JDIMENSION in_row_groups_avail,
@@ -189,7 +189,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 merged_1v_upsample (j_decompress_ptr cinfo,
 		    JSAMPIMAGE input_buf, JDIMENSION *in_row_group_ctr,
 		    JDIMENSION in_row_groups_avail,
@@ -222,7 +222,7 @@
  * Upsample and color convert for the case of 2:1 horizontal and 1:1 vertical.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 h2v1_merged_upsample (j_decompress_ptr cinfo,
 		      JSAMPIMAGE input_buf, JDIMENSION in_row_group_ctr,
 		      JSAMPARRAY output_buf)
@@ -284,7 +284,7 @@
  * Upsample and color convert for the case of 2:1 horizontal and 2:1 vertical.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 h2v2_merged_upsample (j_decompress_ptr cinfo,
 		      JSAMPIMAGE input_buf, JDIMENSION in_row_group_ctr,
 		      JSAMPARRAY output_buf)
@@ -366,7 +366,7 @@
  * of this module; no safety checks are made here.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_merged_upsampler (j_decompress_ptr cinfo)
 {
   my_upsample_ptr upsample;
--- jdpostct.c.orig	1996-01-06 17:27:44.000000000 +0000
+++ jdpostct.c	2011-01-05 21:55:15.000000000 +0000
@@ -43,20 +43,20 @@
 
 
 /* Forward declarations */
-METHODDEF(void) post_process_1pass
+JMETHODDEF(void) post_process_1pass
 	JPP((j_decompress_ptr cinfo,
 	     JSAMPIMAGE input_buf, JDIMENSION *in_row_group_ctr,
 	     JDIMENSION in_row_groups_avail,
 	     JSAMPARRAY output_buf, JDIMENSION *out_row_ctr,
 	     JDIMENSION out_rows_avail));
 #ifdef QUANT_2PASS_SUPPORTED
-METHODDEF(void) post_process_prepass
+JMETHODDEF(void) post_process_prepass
 	JPP((j_decompress_ptr cinfo,
 	     JSAMPIMAGE input_buf, JDIMENSION *in_row_group_ctr,
 	     JDIMENSION in_row_groups_avail,
 	     JSAMPARRAY output_buf, JDIMENSION *out_row_ctr,
 	     JDIMENSION out_rows_avail));
-METHODDEF(void) post_process_2pass
+JMETHODDEF(void) post_process_2pass
 	JPP((j_decompress_ptr cinfo,
 	     JSAMPIMAGE input_buf, JDIMENSION *in_row_group_ctr,
 	     JDIMENSION in_row_groups_avail,
@@ -69,7 +69,7 @@
  * Initialize for a processing pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass_dpost (j_decompress_ptr cinfo, J_BUF_MODE pass_mode)
 {
   my_post_ptr post = (my_post_ptr) cinfo->post;
@@ -122,7 +122,7 @@
  * This is used for color precision reduction as well as one-pass quantization.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 post_process_1pass (j_decompress_ptr cinfo,
 		    JSAMPIMAGE input_buf, JDIMENSION *in_row_group_ctr,
 		    JDIMENSION in_row_groups_avail,
@@ -154,7 +154,7 @@
  * Process some data in the first pass of 2-pass quantization.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 post_process_prepass (j_decompress_ptr cinfo,
 		      JSAMPIMAGE input_buf, JDIMENSION *in_row_group_ctr,
 		      JDIMENSION in_row_groups_avail,
@@ -198,7 +198,7 @@
  * Process some data in the second pass of 2-pass quantization.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 post_process_2pass (j_decompress_ptr cinfo,
 		    JSAMPIMAGE input_buf, JDIMENSION *in_row_group_ctr,
 		    JDIMENSION in_row_groups_avail,
@@ -246,7 +246,7 @@
  * Initialize postprocessing controller.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_d_post_controller (j_decompress_ptr cinfo, boolean need_full_buffer)
 {
   my_post_ptr post;
--- jdsample.c.orig	2008-12-30 11:29:14.000000000 +0000
+++ jdsample.c	2011-01-05 21:55:15.000000000 +0000
@@ -66,7 +66,7 @@
  * Initialize for an upsampling pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass_upsample (j_decompress_ptr cinfo)
 {
   my_upsample_ptr upsample = (my_upsample_ptr) cinfo->upsample;
@@ -86,7 +86,7 @@
  * color conversion a row at a time.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 sep_upsample (j_decompress_ptr cinfo,
 	      JSAMPIMAGE input_buf, JDIMENSION *in_row_group_ctr,
 	      JDIMENSION in_row_groups_avail,
@@ -154,7 +154,7 @@
  * "consumed" until we are done color converting and emitting it.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 fullsize_upsample (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		   JSAMPARRAY input_data, JSAMPARRAY * output_data_ptr)
 {
@@ -167,7 +167,7 @@
  * These components will not be referenced by color conversion.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 noop_upsample (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JSAMPARRAY input_data, JSAMPARRAY * output_data_ptr)
 {
@@ -186,7 +186,7 @@
  * you would be well advised to improve this code.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 int_upsample (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	      JSAMPARRAY input_data, JSAMPARRAY * output_data_ptr)
 {
@@ -230,7 +230,7 @@
  * It's still a box filter.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 h2v1_upsample (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JSAMPARRAY input_data, JSAMPARRAY * output_data_ptr)
 {
@@ -258,7 +258,7 @@
  * It's still a box filter.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 h2v2_upsample (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JSAMPARRAY input_data, JSAMPARRAY * output_data_ptr)
 {
@@ -290,7 +290,7 @@
  * Module initialization routine for upsampling.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_upsampler (j_decompress_ptr cinfo)
 {
   my_upsample_ptr upsample;
--- jdtrans.c.orig	2009-09-14 00:48:38.000000000 +0100
+++ jdtrans.c	2011-01-05 21:55:15.000000000 +0000
@@ -17,7 +17,7 @@
 
 
 /* Forward declarations */
-LOCAL(void) transdecode_master_selection JPP((j_decompress_ptr cinfo));
+JLOCAL(void) transdecode_master_selection JPP((j_decompress_ptr cinfo));
 
 
 /*
@@ -42,7 +42,7 @@
  * a suspending data source is used.
  */
 
-GLOBAL(jvirt_barray_ptr *)
+JGLOBAL(jvirt_barray_ptr *)
 jpeg_read_coefficients (j_decompress_ptr cinfo)
 {
   if (cinfo->global_state == DSTATE_READY) {
@@ -94,7 +94,7 @@
  * This substitutes for jdmaster.c's initialization of the full decompressor.
  */
 
-LOCAL(void)
+JLOCAL(void)
 transdecode_master_selection (j_decompress_ptr cinfo)
 {
   /* This is effectively a buffered-image operation. */
--- jerror.c.orig	1998-02-21 19:03:16.000000000 +0000
+++ jerror.c	2011-01-05 21:55:15.000000000 +0000
@@ -66,7 +66,7 @@
  * or jpeg_destroy) at some point.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 error_exit (j_common_ptr cinfo)
 {
   /* Always display the message */
@@ -94,7 +94,7 @@
  * not just not use this routine.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 output_message (j_common_ptr cinfo)
 {
   char buffer[JMSG_LENGTH_MAX];
@@ -124,7 +124,7 @@
  * or change the policy about which messages to display.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 emit_message (j_common_ptr cinfo, int msg_level)
 {
   struct jpeg_error_mgr * err = cinfo->err;
@@ -153,7 +153,7 @@
  * Few applications should need to override this method.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 format_message (j_common_ptr cinfo, char * buffer)
 {
   struct jpeg_error_mgr * err = cinfo->err;
@@ -208,7 +208,7 @@
  * this method if it has additional error processing state.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 reset_error_mgr (j_common_ptr cinfo)
 {
   cinfo->err->num_warnings = 0;
@@ -227,7 +227,7 @@
  * after which the application may override some of the methods.
  */
 
-GLOBAL(struct jpeg_error_mgr *)
+JGLOBAL(struct jpeg_error_mgr *)
 jpeg_std_error (struct jpeg_error_mgr * err)
 {
   err->error_exit = error_exit;
--- jfdctflt.c.orig	2009-01-18 00:02:53.000000000 +0000
+++ jfdctflt.c	2011-01-05 21:55:15.000000000 +0000
@@ -56,7 +56,7 @@
  * Perform the forward DCT on one block of samples.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_float (FAST_FLOAT * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   FAST_FLOAT tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7;
--- jfdctfst.c.orig	2009-01-18 00:03:07.000000000 +0000
+++ jfdctfst.c	2011-01-05 21:55:15.000000000 +0000
@@ -111,7 +111,7 @@
  * Perform the forward DCT on one block of samples.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_ifast (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   DCTELEM tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7;
--- jfdctint.c.orig	2009-06-08 20:40:24.000000000 +0100
+++ jfdctint.c	2011-01-05 21:55:15.000000000 +0000
@@ -154,7 +154,7 @@
  * Perform the forward DCT on one block of samples.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_islow (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3;
@@ -324,7 +324,7 @@
  * Perform the forward DCT on a 7x7 sample block.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_7x7 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3;
@@ -459,7 +459,7 @@
  * Perform the forward DCT on a 6x6 sample block.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_6x6 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2;
@@ -572,7 +572,7 @@
  * Perform the forward DCT on a 5x5 sample block.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_5x5 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2;
@@ -682,7 +682,7 @@
  * Perform the forward DCT on a 4x4 sample block.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_4x4 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1;
@@ -775,7 +775,7 @@
  * Perform the forward DCT on a 3x3 sample block.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_3x3 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2;
@@ -860,7 +860,7 @@
  * Perform the forward DCT on a 2x2 sample block.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_2x2 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3;
@@ -904,7 +904,7 @@
  * Perform the forward DCT on a 1x1 sample block.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_1x1 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   /* Pre-zero output coefficient block. */
@@ -922,7 +922,7 @@
  * Perform the forward DCT on a 9x9 sample block.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_9x9 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3, tmp4;
@@ -1072,7 +1072,7 @@
  * Perform the forward DCT on a 10x10 sample block.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_10x10 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3, tmp4;
@@ -1235,7 +1235,7 @@
  * Perform the forward DCT on an 11x11 sample block.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_11x11 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5;
@@ -1418,7 +1418,7 @@
  * Perform the forward DCT on a 12x12 sample block.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_12x12 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5;
@@ -1583,7 +1583,7 @@
  * Perform the forward DCT on a 13x13 sample block.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_13x13 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6;
@@ -1782,7 +1782,7 @@
  * Perform the forward DCT on a 14x14 sample block.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_14x14 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6;
@@ -1982,7 +1982,7 @@
  * Perform the forward DCT on a 15x15 sample block.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_15x15 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7;
@@ -2161,7 +2161,7 @@
  * Perform the forward DCT on a 16x16 sample block.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_16x16 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7;
@@ -2369,7 +2369,7 @@
  * 16-point FDCT in pass 1 (rows), 8-point in pass 2 (columns).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_16x8 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7;
@@ -2550,7 +2550,7 @@
  * 14-point FDCT in pass 1 (rows), 7-point in pass 2 (columns).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_14x7 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6;
@@ -2714,7 +2714,7 @@
  * 12-point FDCT in pass 1 (rows), 6-point in pass 2 (columns).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_12x6 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5;
@@ -2853,7 +2853,7 @@
  * 10-point FDCT in pass 1 (rows), 5-point in pass 2 (columns).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_10x5 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3, tmp4;
@@ -2985,7 +2985,7 @@
  * 8-point FDCT in pass 1 (rows), 4-point in pass 2 (columns).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_8x4 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3;
@@ -3121,7 +3121,7 @@
  * 6-point FDCT in pass 1 (rows), 3-point in pass 2 (columns).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_6x3 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2;
@@ -3221,7 +3221,7 @@
  * 4-point FDCT in pass 1 (rows), 2-point in pass 2 (columns).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_4x2 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1;
@@ -3304,7 +3304,7 @@
  * 2-point FDCT in pass 1 (rows), 1-point in pass 2 (columns).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_2x1 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1;
@@ -3337,7 +3337,7 @@
  * 8-point FDCT in pass 1 (rows), 16-point in pass 2 (columns).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_8x16 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7;
@@ -3525,7 +3525,7 @@
  * 7-point FDCT in pass 1 (rows), 14-point in pass 2 (columns).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_7x14 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6;
@@ -3706,7 +3706,7 @@
  * 6-point FDCT in pass 1 (rows), 12-point in pass 2 (columns).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_6x12 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5;
@@ -3855,7 +3855,7 @@
  * 5-point FDCT in pass 1 (rows), 10-point in pass 2 (columns).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_5x10 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3, tmp4;
@@ -4001,7 +4001,7 @@
  * 4-point FDCT in pass 1 (rows), 8-point in pass 2 (columns).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_4x8 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2, tmp3;
@@ -4137,7 +4137,7 @@
  * 3-point FDCT in pass 1 (rows), 6-point in pass 2 (columns).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_3x6 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1, tmp2;
@@ -4242,7 +4242,7 @@
  * 2-point FDCT in pass 1 (rows), 4-point in pass 2 (columns).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_2x4 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1;
@@ -4321,7 +4321,7 @@
  * 1-point FDCT in pass 1 (rows), 2-point in pass 2 (columns).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_fdct_1x2 (DCTELEM * data, JSAMPARRAY sample_data, JDIMENSION start_col)
 {
   INT32 tmp0, tmp1;
--- jidctflt.c.orig	2010-02-21 10:51:08.000000000 +0000
+++ jidctflt.c	2011-01-05 21:55:15.000000000 +0000
@@ -65,7 +65,7 @@
  * Perform dequantization and inverse DCT on one block of coefficients.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_float (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		 JCOEFPTR coef_block,
 		 JSAMPARRAY output_buf, JDIMENSION output_col)
--- jidctfst.c.orig	1998-01-14 21:10:06.000000000 +0000
+++ jidctfst.c	2011-01-05 21:55:15.000000000 +0000
@@ -164,7 +164,7 @@
  * Perform dequantization and inverse DCT on one block of coefficients.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_ifast (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		 JCOEFPTR coef_block,
 		 JSAMPARRAY output_buf, JDIMENSION output_col)
--- jidctint.c.orig	2009-06-08 20:41:14.000000000 +0100
+++ jidctint.c	2011-01-05 21:55:15.000000000 +0000
@@ -167,7 +167,7 @@
  * Perform dequantization and inverse DCT on one block of coefficients.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_islow (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		 JCOEFPTR coef_block,
 		 JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -424,7 +424,7 @@
  * cK represents sqrt(2) * cos(K*pi/14).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_7x7 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JCOEFPTR coef_block,
 	       JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -573,7 +573,7 @@
  * cK represents sqrt(2) * cos(K*pi/12).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_6x6 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JCOEFPTR coef_block,
 	       JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -694,7 +694,7 @@
  * cK represents sqrt(2) * cos(K*pi/10).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_5x5 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JCOEFPTR coef_block,
 	       JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -809,7 +809,7 @@
  * cK represents sqrt(2) * cos(K*pi/16) [refers to 8-point IDCT].
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_4x4 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JCOEFPTR coef_block,
 	       JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -914,7 +914,7 @@
  * cK represents sqrt(2) * cos(K*pi/6).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_3x3 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JCOEFPTR coef_block,
 	       JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -1003,7 +1003,7 @@
  * Multiplication-less algorithm.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_2x2 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JCOEFPTR coef_block,
 	       JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -1058,7 +1058,7 @@
  * average pixel value, which is one-eighth of the DC coefficient.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_1x1 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JCOEFPTR coef_block,
 	       JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -1085,7 +1085,7 @@
  * cK represents sqrt(2) * cos(K*pi/18).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_9x9 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JCOEFPTR coef_block,
 	       JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -1256,7 +1256,7 @@
  * cK represents sqrt(2) * cos(K*pi/20).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_10x10 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		 JCOEFPTR coef_block,
 		 JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -1451,7 +1451,7 @@
  * cK represents sqrt(2) * cos(K*pi/22).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_11x11 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		 JCOEFPTR coef_block,
 		 JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -1645,7 +1645,7 @@
  * cK represents sqrt(2) * cos(K*pi/24).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_12x12 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		 JCOEFPTR coef_block,
 		 JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -1861,7 +1861,7 @@
  * cK represents sqrt(2) * cos(K*pi/26).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_13x13 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		 JCOEFPTR coef_block,
 		 JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -2089,7 +2089,7 @@
  * cK represents sqrt(2) * cos(K*pi/28).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_14x14 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		 JCOEFPTR coef_block,
 		 JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -2315,7 +2315,7 @@
  * cK represents sqrt(2) * cos(K*pi/30).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_15x15 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		 JCOEFPTR coef_block,
 		 JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -2557,7 +2557,7 @@
  * cK represents sqrt(2) * cos(K*pi/32).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_16x16 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		 JCOEFPTR coef_block,
 		 JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -2818,7 +2818,7 @@
  * 8-point IDCT in pass 1 (columns), 16-point in pass 2 (rows).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_16x8 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		JCOEFPTR coef_block,
 		JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -3089,7 +3089,7 @@
  * 7-point IDCT in pass 1 (columns), 14-point in pass 2 (rows).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_14x7 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		JCOEFPTR coef_block,
 		JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -3284,7 +3284,7 @@
  * 6-point IDCT in pass 1 (columns), 12-point in pass 2 (rows).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_12x6 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		JCOEFPTR coef_block,
 		JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -3460,7 +3460,7 @@
  * 5-point IDCT in pass 1 (columns), 10-point in pass 2 (rows).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_10x5 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		JCOEFPTR coef_block,
 		JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -3621,7 +3621,7 @@
  * 4-point IDCT in pass 1 (columns), 8-point in pass 2 (rows).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_8x4 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JCOEFPTR coef_block,
 	       JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -3774,7 +3774,7 @@
  * 3-point IDCT in pass 1 (columns), 6-point in pass 2 (rows).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_6x3 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JCOEFPTR coef_block,
 	       JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -3884,7 +3884,7 @@
  * 2-point IDCT in pass 1 (columns), 4-point in pass 2 (rows).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_4x2 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JCOEFPTR coef_block,
 	       JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -3974,7 +3974,7 @@
  * 1-point IDCT in pass 1 (columns), 2-point in pass 2 (rows).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_2x1 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JCOEFPTR coef_block,
 	       JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -4016,7 +4016,7 @@
  * 16-point IDCT in pass 1 (columns), 8-point in pass 2 (rows).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_8x16 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		JCOEFPTR coef_block,
 		JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -4234,7 +4234,7 @@
  * 14-point IDCT in pass 1 (columns), 7-point in pass 2 (rows).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_7x14 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		JCOEFPTR coef_block,
 		JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -4417,7 +4417,7 @@
  * 12-point IDCT in pass 1 (columns), 6-point in pass 2 (rows).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_6x12 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		JCOEFPTR coef_block,
 		JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -4581,7 +4581,7 @@
  * 10-point IDCT in pass 1 (columns), 5-point in pass 2 (rows).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_5x10 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 		JCOEFPTR coef_block,
 		JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -4733,7 +4733,7 @@
  * 8-point IDCT in pass 1 (columns), 4-point in pass 2 (rows).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_4x8 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JCOEFPTR coef_block,
 	       JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -4913,7 +4913,7 @@
  * 6-point IDCT in pass 1 (columns), 3-point in pass 2 (rows).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_3x6 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JCOEFPTR coef_block,
 	       JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -5017,7 +5017,7 @@
  * 4-point IDCT in pass 1 (columns), 2-point in pass 2 (rows).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_2x4 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JCOEFPTR coef_block,
 	       JSAMPARRAY output_buf, JDIMENSION output_col)
@@ -5101,7 +5101,7 @@
  * 2-point IDCT in pass 1 (columns), 1-point in pass 2 (rows).
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_idct_1x2 (j_decompress_ptr cinfo, jpeg_component_info * compptr,
 	       JCOEFPTR coef_block,
 	       JSAMPARRAY output_buf, JDIMENSION output_col)
--- jmemansi.c.orig	1996-01-06 17:29:46.000000000 +0000
+++ jmemansi.c	2011-01-05 21:55:15.000000000 +0000
@@ -32,13 +32,13 @@
  * routines malloc() and free().
  */
 
-GLOBAL(void *)
+JGLOBAL(void *)
 jpeg_get_small (j_common_ptr cinfo, size_t sizeofobject)
 {
   return (void *) malloc(sizeofobject);
 }
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_free_small (j_common_ptr cinfo, void * object, size_t sizeofobject)
 {
   free(object);
@@ -52,13 +52,13 @@
  * you probably won't be able to process useful-size images in only 64KB.
  */
 
-GLOBAL(void FAR *)
+JGLOBAL(void FAR *)
 jpeg_get_large (j_common_ptr cinfo, size_t sizeofobject)
 {
   return (void FAR *) malloc(sizeofobject);
 }
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_free_large (j_common_ptr cinfo, void FAR * object, size_t sizeofobject)
 {
   free(object);
@@ -77,7 +77,7 @@
 #define DEFAULT_MAX_MEM		1000000L /* default: one megabyte */
 #endif
 
-GLOBAL(long)
+JGLOBAL(long)
 jpeg_mem_available (j_common_ptr cinfo, long min_bytes_needed,
 		    long max_bytes_needed, long already_allocated)
 {
@@ -93,7 +93,7 @@
  */
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 read_backing_store (j_common_ptr cinfo, backing_store_ptr info,
 		    void FAR * buffer_address,
 		    long file_offset, long byte_count)
@@ -106,7 +106,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 write_backing_store (j_common_ptr cinfo, backing_store_ptr info,
 		     void FAR * buffer_address,
 		     long file_offset, long byte_count)
@@ -119,7 +119,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 close_backing_store (j_common_ptr cinfo, backing_store_ptr info)
 {
   fclose(info->temp_file);
@@ -137,7 +137,7 @@
  * indeed, we can't even find out the actual name of the temp file.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_open_backing_store (j_common_ptr cinfo, backing_store_ptr info,
 			 long total_bytes_needed)
 {
@@ -154,13 +154,13 @@
  * cleanup required.
  */
 
-GLOBAL(long)
+JGLOBAL(long)
 jpeg_mem_init (j_common_ptr cinfo)
 {
   return DEFAULT_MAX_MEM;	/* default for max_memory_to_use */
 }
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_mem_term (j_common_ptr cinfo)
 {
   /* no work */
--- jmemdos.c.orig	1997-08-03 20:22:02.000000000 +0100
+++ jmemdos.c	2011-01-05 21:55:15.000000000 +0000
@@ -124,7 +124,7 @@
 
 static int next_file_num;	/* to distinguish among several temp files */
 
-LOCAL(void)
+JLOCAL(void)
 select_file_name (char * fname)
 {
   const char * env;
@@ -162,13 +162,13 @@
  * routines malloc() and free().
  */
 
-GLOBAL(void *)
+JGLOBAL(void *)
 jpeg_get_small (j_common_ptr cinfo, size_t sizeofobject)
 {
   return (void *) malloc(sizeofobject);
 }
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_free_small (j_common_ptr cinfo, void * object, size_t sizeofobject)
 {
   free(object);
@@ -179,13 +179,13 @@
  * "Large" objects are allocated in far memory, if possible
  */
 
-GLOBAL(void FAR *)
+JGLOBAL(void FAR *)
 jpeg_get_large (j_common_ptr cinfo, size_t sizeofobject)
 {
   return (void FAR *) far_malloc(sizeofobject);
 }
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_free_large (j_common_ptr cinfo, void FAR * object, size_t sizeofobject)
 {
   far_free(object);
@@ -204,7 +204,7 @@
 #define DEFAULT_MAX_MEM		300000L /* for total usage about 450K */
 #endif
 
-GLOBAL(long)
+JGLOBAL(long)
 jpeg_mem_available (j_common_ptr cinfo, long min_bytes_needed,
 		    long max_bytes_needed, long already_allocated)
 {
@@ -239,7 +239,7 @@
  */
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 read_file_store (j_common_ptr cinfo, backing_store_ptr info,
 		 void FAR * buffer_address,
 		 long file_offset, long byte_count)
@@ -255,7 +255,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 write_file_store (j_common_ptr cinfo, backing_store_ptr info,
 		  void FAR * buffer_address,
 		  long file_offset, long byte_count)
@@ -271,7 +271,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 close_file_store (j_common_ptr cinfo, backing_store_ptr info)
 {
   jdos_close(info->handle.file_handle);	/* close the file */
@@ -284,7 +284,7 @@
 }
 
 
-LOCAL(boolean)
+JLOCAL(boolean)
 open_file_store (j_common_ptr cinfo, backing_store_ptr info,
 		 long total_bytes_needed)
 {
@@ -329,7 +329,7 @@
 #define ODD(X)	(((X) & 1L) != 0)
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 read_xms_store (j_common_ptr cinfo, backing_store_ptr info,
 		void FAR * buffer_address,
 		long file_offset, long byte_count)
@@ -362,7 +362,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 write_xms_store (j_common_ptr cinfo, backing_store_ptr info,
 		 void FAR * buffer_address,
 		 long file_offset, long byte_count)
@@ -397,7 +397,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 close_xms_store (j_common_ptr cinfo, backing_store_ptr info)
 {
   XMScontext ctx;
@@ -410,7 +410,7 @@
 }
 
 
-LOCAL(boolean)
+JLOCAL(boolean)
 open_xms_store (j_common_ptr cinfo, backing_store_ptr info,
 		long total_bytes_needed)
 {
@@ -487,7 +487,7 @@
 #define LOBYTE(W)  ((W) & 0xFF)
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 read_ems_store (j_common_ptr cinfo, backing_store_ptr info,
 		void FAR * buffer_address,
 		long file_offset, long byte_count)
@@ -512,7 +512,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 write_ems_store (j_common_ptr cinfo, backing_store_ptr info,
 		 void FAR * buffer_address,
 		 long file_offset, long byte_count)
@@ -537,7 +537,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 close_ems_store (j_common_ptr cinfo, backing_store_ptr info)
 {
   EMScontext ctx;
@@ -550,7 +550,7 @@
 }
 
 
-LOCAL(boolean)
+JLOCAL(boolean)
 open_ems_store (j_common_ptr cinfo, backing_store_ptr info,
 		long total_bytes_needed)
 {
@@ -595,7 +595,7 @@
  * Initial opening of a backing-store object.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_open_backing_store (j_common_ptr cinfo, backing_store_ptr info,
 			 long total_bytes_needed)
 {
@@ -619,14 +619,14 @@
  * cleanup required.
  */
 
-GLOBAL(long)
+JGLOBAL(long)
 jpeg_mem_init (j_common_ptr cinfo)
 {
   next_file_num = 0;		/* initialize temp file name generator */
   return DEFAULT_MAX_MEM;	/* default for max_memory_to_use */
 }
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_mem_term (j_common_ptr cinfo)
 {
   /* Microsoft C, at least in v6.00A, will not successfully reclaim freed
--- jmemmac.c.orig	1997-08-03 20:26:18.000000000 +0100
+++ jmemmac.c	2011-01-05 21:55:15.000000000 +0000
@@ -78,13 +78,13 @@
  * with relocatable storage.
  */
 
-GLOBAL(void *)
+JGLOBAL(void *)
 jpeg_get_small (j_common_ptr cinfo, size_t sizeofobject)
 {
   return (void *) NewPtr(sizeofobject);
 }
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_free_small (j_common_ptr cinfo, void * object, size_t sizeofobject)
 {
   DisposePtr((Ptr) object);
@@ -98,13 +98,13 @@
  * on rational architectures like the Mac.
  */
 
-GLOBAL(void FAR *)
+JGLOBAL(void FAR *)
 jpeg_get_large (j_common_ptr cinfo, size_t sizeofobject)
 {
   return (void FAR *) NewPtr(sizeofobject);
 }
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_free_large (j_common_ptr cinfo, void FAR * object, size_t sizeofobject)
 {
   DisposePtr((Ptr) object);
@@ -115,7 +115,7 @@
  * This routine computes the total memory space available for allocation.
  */
 
-GLOBAL(long)
+JGLOBAL(long)
 jpeg_mem_available (j_common_ptr cinfo, long min_bytes_needed,
 		    long max_bytes_needed, long already_allocated)
 {
@@ -150,7 +150,7 @@
  */
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 read_backing_store (j_common_ptr cinfo, backing_store_ptr info,
 		    void FAR * buffer_address,
 		    long file_offset, long byte_count)
@@ -168,7 +168,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 write_backing_store (j_common_ptr cinfo, backing_store_ptr info,
 		     void FAR * buffer_address,
 		     long file_offset, long byte_count)
@@ -186,7 +186,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 close_backing_store (j_common_ptr cinfo, backing_store_ptr info)
 {
   FSClose ( info->temp_file );
@@ -201,7 +201,7 @@
  * and puts the temporary file in there.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_open_backing_store (j_common_ptr cinfo, backing_store_ptr info,
 			 long total_bytes_needed)
 {
@@ -268,7 +268,7 @@
  * cleanup required.
  */
 
-GLOBAL(long)
+JGLOBAL(long)
 jpeg_mem_init (j_common_ptr cinfo)
 {
   next_file_num = 0;
@@ -282,7 +282,7 @@
   return FreeMem();
 }
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_mem_term (j_common_ptr cinfo)
 {
   /* no work */
--- jmemmgr.c.orig	1997-04-14 20:56:38.000000000 +0100
+++ jmemmgr.c	2011-01-05 21:55:15.000000000 +0000
@@ -182,7 +182,7 @@
 
 #ifdef MEM_STATS		/* optional extra stuff for statistics */
 
-LOCAL(void)
+JLOCAL(void)
 print_mem_stats (j_common_ptr cinfo, int pool_id)
 {
   my_mem_ptr mem = (my_mem_ptr) cinfo->mem;
@@ -213,7 +213,7 @@
 #endif /* MEM_STATS */
 
 
-LOCAL(void)
+JLOCAL(void)
 out_of_memory (j_common_ptr cinfo, int which)
 /* Report an out-of-memory error and stop execution */
 /* If we compiled MEM_STATS support, report alloc requests before dying */
@@ -253,7 +253,7 @@
 #define MIN_SLOP  50		/* greater than 0 to avoid futile looping */
 
 
-METHODDEF(void *)
+JMETHODDEF(void *)
 alloc_small (j_common_ptr cinfo, int pool_id, size_t sizeofobject)
 /* Allocate a "small" object */
 {
@@ -338,7 +338,7 @@
  * deliberately bunch rows together to ensure a large request size.
  */
 
-METHODDEF(void FAR *)
+JMETHODDEF(void FAR *)
 alloc_large (j_common_ptr cinfo, int pool_id, size_t sizeofobject)
 /* Allocate a "large" object */
 {
@@ -391,7 +391,7 @@
  * a virtual array.
  */
 
-METHODDEF(JSAMPARRAY)
+JMETHODDEF(JSAMPARRAY)
 alloc_sarray (j_common_ptr cinfo, int pool_id,
 	      JDIMENSION samplesperrow, JDIMENSION numrows)
 /* Allocate a 2-D sample array */
@@ -439,7 +439,7 @@
  * This is essentially the same as the code for sample arrays, above.
  */
 
-METHODDEF(JBLOCKARRAY)
+JMETHODDEF(JBLOCKARRAY)
 alloc_barray (j_common_ptr cinfo, int pool_id,
 	      JDIMENSION blocksperrow, JDIMENSION numrows)
 /* Allocate a 2-D coefficient-block array */
@@ -519,7 +519,7 @@
  */
 
 
-METHODDEF(jvirt_sarray_ptr)
+JMETHODDEF(jvirt_sarray_ptr)
 request_virt_sarray (j_common_ptr cinfo, int pool_id, boolean pre_zero,
 		     JDIMENSION samplesperrow, JDIMENSION numrows,
 		     JDIMENSION maxaccess)
@@ -549,7 +549,7 @@
 }
 
 
-METHODDEF(jvirt_barray_ptr)
+JMETHODDEF(jvirt_barray_ptr)
 request_virt_barray (j_common_ptr cinfo, int pool_id, boolean pre_zero,
 		     JDIMENSION blocksperrow, JDIMENSION numrows,
 		     JDIMENSION maxaccess)
@@ -579,7 +579,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 realize_virt_arrays (j_common_ptr cinfo)
 /* Allocate the in-memory buffers for any unrealized virtual arrays */
 {
@@ -686,7 +686,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 do_sarray_io (j_common_ptr cinfo, jvirt_sarray_ptr ptr, boolean writing)
 /* Do backing store read or write of a virtual sample array */
 {
@@ -719,7 +719,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 do_barray_io (j_common_ptr cinfo, jvirt_barray_ptr ptr, boolean writing)
 /* Do backing store read or write of a virtual coefficient-block array */
 {
@@ -752,7 +752,7 @@
 }
 
 
-METHODDEF(JSAMPARRAY)
+JMETHODDEF(JSAMPARRAY)
 access_virt_sarray (j_common_ptr cinfo, jvirt_sarray_ptr ptr,
 		    JDIMENSION start_row, JDIMENSION num_rows,
 		    boolean writable)
@@ -837,7 +837,7 @@
 }
 
 
-METHODDEF(JBLOCKARRAY)
+JMETHODDEF(JBLOCKARRAY)
 access_virt_barray (j_common_ptr cinfo, jvirt_barray_ptr ptr,
 		    JDIMENSION start_row, JDIMENSION num_rows,
 		    boolean writable)
@@ -926,7 +926,7 @@
  * Release all objects belonging to a specified pool.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 free_pool (j_common_ptr cinfo, int pool_id)
 {
   my_mem_ptr mem = (my_mem_ptr) cinfo->mem;
@@ -998,7 +998,7 @@
  * Note that this cannot be called unless cinfo->mem is non-NULL.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 self_destruct (j_common_ptr cinfo)
 {
   int pool;
@@ -1024,7 +1024,7 @@
  * When this is called, only the error manager pointer is valid in cinfo!
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_memory_mgr (j_common_ptr cinfo)
 {
   my_mem_ptr mem;
--- jmemname.c.orig	1997-09-14 17:35:10.000000000 +0100
+++ jmemname.c	2011-01-05 21:55:15.000000000 +0000
@@ -91,7 +91,7 @@
 #endif
 
 
-LOCAL(void)
+JLOCAL(void)
 select_file_name (char * fname)
 {
   FILE * tfile;
@@ -122,7 +122,7 @@
 #define TEMP_FILE_NAME  "%sJPG%dXXXXXX"
 #endif
 
-LOCAL(void)
+JLOCAL(void)
 select_file_name (char * fname)
 {
   next_file_num++;		/* advance counter */
@@ -139,13 +139,13 @@
  * routines malloc() and free().
  */
 
-GLOBAL(void *)
+JGLOBAL(void *)
 jpeg_get_small (j_common_ptr cinfo, size_t sizeofobject)
 {
   return (void *) malloc(sizeofobject);
 }
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_free_small (j_common_ptr cinfo, void * object, size_t sizeofobject)
 {
   free(object);
@@ -159,13 +159,13 @@
  * you probably won't be able to process useful-size images in only 64KB.
  */
 
-GLOBAL(void FAR *)
+JGLOBAL(void FAR *)
 jpeg_get_large (j_common_ptr cinfo, size_t sizeofobject)
 {
   return (void FAR *) malloc(sizeofobject);
 }
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_free_large (j_common_ptr cinfo, void FAR * object, size_t sizeofobject)
 {
   free(object);
@@ -184,7 +184,7 @@
 #define DEFAULT_MAX_MEM		1000000L /* default: one megabyte */
 #endif
 
-GLOBAL(long)
+JGLOBAL(long)
 jpeg_mem_available (j_common_ptr cinfo, long min_bytes_needed,
 		    long max_bytes_needed, long already_allocated)
 {
@@ -200,7 +200,7 @@
  */
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 read_backing_store (j_common_ptr cinfo, backing_store_ptr info,
 		    void FAR * buffer_address,
 		    long file_offset, long byte_count)
@@ -213,7 +213,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 write_backing_store (j_common_ptr cinfo, backing_store_ptr info,
 		     void FAR * buffer_address,
 		     long file_offset, long byte_count)
@@ -226,7 +226,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 close_backing_store (j_common_ptr cinfo, backing_store_ptr info)
 {
   fclose(info->temp_file);	/* close the file */
@@ -243,7 +243,7 @@
  * Initial opening of a backing-store object.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_open_backing_store (j_common_ptr cinfo, backing_store_ptr info,
 			 long total_bytes_needed)
 {
@@ -262,14 +262,14 @@
  * cleanup required.
  */
 
-GLOBAL(long)
+JGLOBAL(long)
 jpeg_mem_init (j_common_ptr cinfo)
 {
   next_file_num = 0;		/* initialize temp file name generator */
   return DEFAULT_MAX_MEM;	/* default for max_memory_to_use */
 }
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_mem_term (j_common_ptr cinfo)
 {
   /* no work */
--- jmemnobs.c.orig	1996-01-06 17:31:18.000000000 +0000
+++ jmemnobs.c	2011-01-05 21:55:15.000000000 +0000
@@ -31,13 +31,13 @@
  * routines malloc() and free().
  */
 
-GLOBAL(void *)
+JGLOBAL(void *)
 jpeg_get_small (j_common_ptr cinfo, size_t sizeofobject)
 {
   return (void *) malloc(sizeofobject);
 }
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_free_small (j_common_ptr cinfo, void * object, size_t sizeofobject)
 {
   free(object);
@@ -51,13 +51,13 @@
  * you probably won't be able to process useful-size images in only 64KB.
  */
 
-GLOBAL(void FAR *)
+JGLOBAL(void FAR *)
 jpeg_get_large (j_common_ptr cinfo, size_t sizeofobject)
 {
   return (void FAR *) malloc(sizeofobject);
 }
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_free_large (j_common_ptr cinfo, void FAR * object, size_t sizeofobject)
 {
   free(object);
@@ -69,7 +69,7 @@
  * Here we always say, "we got all you want bud!"
  */
 
-GLOBAL(long)
+JGLOBAL(long)
 jpeg_mem_available (j_common_ptr cinfo, long min_bytes_needed,
 		    long max_bytes_needed, long already_allocated)
 {
@@ -83,7 +83,7 @@
  * this should never be called and we can just error out.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_open_backing_store (j_common_ptr cinfo, backing_store_ptr info,
 			 long total_bytes_needed)
 {
@@ -96,13 +96,13 @@
  * cleanup required.  Here, there isn't any.
  */
 
-GLOBAL(long)
+JGLOBAL(long)
 jpeg_mem_init (j_common_ptr cinfo)
 {
   return 0;			/* just set max_memory_to_use to 0 */
 }
 
-GLOBAL(void)
+JGLOBAL(void)
 jpeg_mem_term (j_common_ptr cinfo)
 {
   /* no work */
--- jmemsys.h.orig	1997-08-03 19:58:36.000000000 +0100
+++ jmemsys.h	2011-01-05 21:55:15.000000000 +0000
@@ -44,8 +44,8 @@
  * On an 80x86 machine using small-data memory model, these manage near heap.
  */
 
-EXTERN(void *) jpeg_get_small JPP((j_common_ptr cinfo, size_t sizeofobject));
-EXTERN(void) jpeg_free_small JPP((j_common_ptr cinfo, void * object,
+JEXTERN(void *) jpeg_get_small JPP((j_common_ptr cinfo, size_t sizeofobject));
+JEXTERN(void) jpeg_free_small JPP((j_common_ptr cinfo, void * object,
 				  size_t sizeofobject));
 
 /*
@@ -57,9 +57,9 @@
  * in case a different allocation strategy is desirable for large chunks.
  */
 
-EXTERN(void FAR *) jpeg_get_large JPP((j_common_ptr cinfo,
+JEXTERN(void FAR *) jpeg_get_large JPP((j_common_ptr cinfo,
 				       size_t sizeofobject));
-EXTERN(void) jpeg_free_large JPP((j_common_ptr cinfo, void FAR * object,
+JEXTERN(void) jpeg_free_large JPP((j_common_ptr cinfo, void FAR * object,
 				  size_t sizeofobject));
 
 /*
@@ -100,7 +100,7 @@
  * Conversely, zero may be returned to always use the minimum amount of memory.
  */
 
-EXTERN(long) jpeg_mem_available JPP((j_common_ptr cinfo,
+JEXTERN(long) jpeg_mem_available JPP((j_common_ptr cinfo,
 				     long min_bytes_needed,
 				     long max_bytes_needed,
 				     long already_allocated));
@@ -177,7 +177,7 @@
  * just take an error exit.)
  */
 
-EXTERN(void) jpeg_open_backing_store JPP((j_common_ptr cinfo,
+JEXTERN(void) jpeg_open_backing_store JPP((j_common_ptr cinfo,
 					  backing_store_ptr info,
 					  long total_bytes_needed));
 
@@ -194,5 +194,5 @@
  * all opened backing-store objects have been closed.
  */
 
-EXTERN(long) jpeg_mem_init JPP((j_common_ptr cinfo));
-EXTERN(void) jpeg_mem_term JPP((j_common_ptr cinfo));
+JEXTERN(long) jpeg_mem_init JPP((j_common_ptr cinfo));
+JEXTERN(void) jpeg_mem_term JPP((j_common_ptr cinfo));
--- jmorecfg.h.orig	2009-11-20 08:01:24.000000000 +0000
+++ jmorecfg.h	2011-01-05 21:55:15.000000000 +0000
@@ -188,13 +188,13 @@
  */
 
 /* a function called through method pointers: */
-#define METHODDEF(type)		static type
+#define JMETHODDEF(type)		static type
 /* a function used only in its module: */
-#define LOCAL(type)		static type
-/* a function referenced thru EXTERNs: */
-#define GLOBAL(type)		type
-/* a reference to a GLOBAL function: */
-#define EXTERN(type)		extern type
+#define JLOCAL(type)		static type
+/* a function referenced thru JEXTERNs: */
+#define JGLOBAL(type)		type
+/* a reference to a JGLOBAL function: */
+#define JEXTERN(type)		extern type
 
 
 /* This macro is used to declare a "method", that is, a function pointer.
@@ -328,16 +328,16 @@
 /* Definitions for speed-related optimizations. */
 
 
-/* If your compiler supports inline functions, define INLINE
+/* If your compiler supports inline functions, define JINLINE
  * as the inline keyword; otherwise define it as empty.
  */
 
-#ifndef INLINE
+#ifndef JINLINE
 #ifdef __GNUC__			/* for instance, GNU C knows about inline */
-#define INLINE __inline__
+#define JINLINE __inline__
 #endif
-#ifndef INLINE
-#define INLINE			/* default is to define it as empty */
+#ifndef JINLINE
+#define JINLINE			/* default is to define it as empty */
 #endif
 #endif
 
--- jpegint.h.orig	2009-09-19 09:51:24.000000000 +0100
+++ jpegint.h	2011-01-05 22:28:15.000000000 +0000
@@ -337,51 +337,51 @@
 
 
 /* Compression module initialization routines */
-EXTERN(void) jinit_compress_master JPP((j_compress_ptr cinfo));
-EXTERN(void) jinit_c_master_control JPP((j_compress_ptr cinfo,
+JEXTERN(void) jinit_compress_master JPP((j_compress_ptr cinfo));
+JEXTERN(void) jinit_c_master_control JPP((j_compress_ptr cinfo,
 					 boolean transcode_only));
-EXTERN(void) jinit_c_main_controller JPP((j_compress_ptr cinfo,
+JEXTERN(void) jinit_c_main_controller JPP((j_compress_ptr cinfo,
 					  boolean need_full_buffer));
-EXTERN(void) jinit_c_prep_controller JPP((j_compress_ptr cinfo,
+JEXTERN(void) jinit_c_prep_controller JPP((j_compress_ptr cinfo,
 					  boolean need_full_buffer));
-EXTERN(void) jinit_c_coef_controller JPP((j_compress_ptr cinfo,
+JEXTERN(void) jinit_c_coef_controller JPP((j_compress_ptr cinfo,
 					  boolean need_full_buffer));
-EXTERN(void) jinit_color_converter JPP((j_compress_ptr cinfo));
-EXTERN(void) jinit_downsampler JPP((j_compress_ptr cinfo));
-EXTERN(void) jinit_forward_dct JPP((j_compress_ptr cinfo));
-EXTERN(void) jinit_huff_encoder JPP((j_compress_ptr cinfo));
-EXTERN(void) jinit_arith_encoder JPP((j_compress_ptr cinfo));
-EXTERN(void) jinit_marker_writer JPP((j_compress_ptr cinfo));
+JEXTERN(void) jinit_color_converter JPP((j_compress_ptr cinfo));
+JEXTERN(void) jinit_downsampler JPP((j_compress_ptr cinfo));
+JEXTERN(void) jinit_forward_dct JPP((j_compress_ptr cinfo));
+JEXTERN(void) jinit_huff_encoder JPP((j_compress_ptr cinfo));
+JEXTERN(void) jinit_arith_encoder JPP((j_compress_ptr cinfo));
+JEXTERN(void) jinit_marker_writer JPP((j_compress_ptr cinfo));
 /* Decompression module initialization routines */
-EXTERN(void) jinit_master_decompress JPP((j_decompress_ptr cinfo));
-EXTERN(void) jinit_d_main_controller JPP((j_decompress_ptr cinfo,
+JEXTERN(void) jinit_master_decompress JPP((j_decompress_ptr cinfo));
+JEXTERN(void) jinit_d_main_controller JPP((j_decompress_ptr cinfo,
 					  boolean need_full_buffer));
-EXTERN(void) jinit_d_coef_controller JPP((j_decompress_ptr cinfo,
+JEXTERN(void) jinit_d_coef_controller JPP((j_decompress_ptr cinfo,
 					  boolean need_full_buffer));
-EXTERN(void) jinit_d_post_controller JPP((j_decompress_ptr cinfo,
+JEXTERN(void) jinit_d_post_controller JPP((j_decompress_ptr cinfo,
 					  boolean need_full_buffer));
-EXTERN(void) jinit_input_controller JPP((j_decompress_ptr cinfo));
-EXTERN(void) jinit_marker_reader JPP((j_decompress_ptr cinfo));
-EXTERN(void) jinit_huff_decoder JPP((j_decompress_ptr cinfo));
-EXTERN(void) jinit_arith_decoder JPP((j_decompress_ptr cinfo));
-EXTERN(void) jinit_inverse_dct JPP((j_decompress_ptr cinfo));
-EXTERN(void) jinit_upsampler JPP((j_decompress_ptr cinfo));
-EXTERN(void) jinit_color_deconverter JPP((j_decompress_ptr cinfo));
-EXTERN(void) jinit_1pass_quantizer JPP((j_decompress_ptr cinfo));
-EXTERN(void) jinit_2pass_quantizer JPP((j_decompress_ptr cinfo));
-EXTERN(void) jinit_merged_upsampler JPP((j_decompress_ptr cinfo));
+JEXTERN(void) jinit_input_controller JPP((j_decompress_ptr cinfo));
+JEXTERN(void) jinit_marker_reader JPP((j_decompress_ptr cinfo));
+JEXTERN(void) jinit_huff_decoder JPP((j_decompress_ptr cinfo));
+JEXTERN(void) jinit_arith_decoder JPP((j_decompress_ptr cinfo));
+JEXTERN(void) jinit_inverse_dct JPP((j_decompress_ptr cinfo));
+JEXTERN(void) jinit_upsampler JPP((j_decompress_ptr cinfo));
+JEXTERN(void) jinit_color_deconverter JPP((j_decompress_ptr cinfo));
+JEXTERN(void) jinit_1pass_quantizer JPP((j_decompress_ptr cinfo));
+JEXTERN(void) jinit_2pass_quantizer JPP((j_decompress_ptr cinfo));
+JEXTERN(void) jinit_merged_upsampler JPP((j_decompress_ptr cinfo));
 /* Memory manager initialization */
-EXTERN(void) jinit_memory_mgr JPP((j_common_ptr cinfo));
+JEXTERN(void) jinit_memory_mgr JPP((j_common_ptr cinfo));
 
 /* Utility routines in jutils.c */
-EXTERN(long) jdiv_round_up JPP((long a, long b));
-EXTERN(long) jround_up JPP((long a, long b));
-EXTERN(void) jcopy_sample_rows JPP((JSAMPARRAY input_array, int source_row,
+JEXTERN(long) jdiv_round_up JPP((long a, long b));
+JEXTERN(long) jround_up JPP((long a, long b));
+JEXTERN(void) jcopy_sample_rows JPP((JSAMPARRAY input_array, int source_row,
 				    JSAMPARRAY output_array, int dest_row,
 				    int num_rows, JDIMENSION num_cols));
-EXTERN(void) jcopy_block_row JPP((JBLOCKROW input_row, JBLOCKROW output_row,
+JEXTERN(void) jcopy_block_row JPP((JBLOCKROW input_row, JBLOCKROW output_row,
 				  JDIMENSION num_blocks));
-EXTERN(void) jzero_far JPP((void FAR * target, size_t bytestozero));
+JEXTERN(void) jzero_far JPP((void FAR * target, size_t bytestozero));
 /* Constant tables in jutils.c */
 #if 0				/* This table is not actually needed in v6a */
 extern const int jpeg_zigzag_order[]; /* natural coef order to zigzag order */
--- jpeglib.h.orig	2009-11-16 11:44:42.000000000 +0000
+++ jpeglib.h	2011-01-05 21:55:15.000000000 +0000
@@ -923,7 +923,7 @@
 
 
 /* Default error-management setup */
-EXTERN(struct jpeg_error_mgr *) jpeg_std_error
+JEXTERN(struct jpeg_error_mgr *) jpeg_std_error
 	JPP((struct jpeg_error_mgr * err));
 
 /* Initialization of JPEG compression objects.
@@ -939,82 +939,82 @@
 #define jpeg_create_decompress(cinfo) \
     jpeg_CreateDecompress((cinfo), JPEG_LIB_VERSION, \
 			  (size_t) sizeof(struct jpeg_decompress_struct))
-EXTERN(void) jpeg_CreateCompress JPP((j_compress_ptr cinfo,
+JEXTERN(void) jpeg_CreateCompress JPP((j_compress_ptr cinfo,
 				      int version, size_t structsize));
-EXTERN(void) jpeg_CreateDecompress JPP((j_decompress_ptr cinfo,
+JEXTERN(void) jpeg_CreateDecompress JPP((j_decompress_ptr cinfo,
 					int version, size_t structsize));
 /* Destruction of JPEG compression objects */
-EXTERN(void) jpeg_destroy_compress JPP((j_compress_ptr cinfo));
-EXTERN(void) jpeg_destroy_decompress JPP((j_decompress_ptr cinfo));
+JEXTERN(void) jpeg_destroy_compress JPP((j_compress_ptr cinfo));
+JEXTERN(void) jpeg_destroy_decompress JPP((j_decompress_ptr cinfo));
 
 /* Standard data source and destination managers: stdio streams. */
 /* Caller is responsible for opening the file before and closing after. */
-EXTERN(void) jpeg_stdio_dest JPP((j_compress_ptr cinfo, FILE * outfile));
-EXTERN(void) jpeg_stdio_src JPP((j_decompress_ptr cinfo, FILE * infile));
+JEXTERN(void) jpeg_stdio_dest JPP((j_compress_ptr cinfo, FILE * outfile));
+JEXTERN(void) jpeg_stdio_src JPP((j_decompress_ptr cinfo, FILE * infile));
 
 /* Data source and destination managers: memory buffers. */
-EXTERN(void) jpeg_mem_dest JPP((j_compress_ptr cinfo,
+JEXTERN(void) jpeg_mem_dest JPP((j_compress_ptr cinfo,
 			       unsigned char ** outbuffer,
 			       unsigned long * outsize));
-EXTERN(void) jpeg_mem_src JPP((j_decompress_ptr cinfo,
+JEXTERN(void) jpeg_mem_src JPP((j_decompress_ptr cinfo,
 			      unsigned char * inbuffer,
 			      unsigned long insize));
 
 /* Default parameter setup for compression */
-EXTERN(void) jpeg_set_defaults JPP((j_compress_ptr cinfo));
+JEXTERN(void) jpeg_set_defaults JPP((j_compress_ptr cinfo));
 /* Compression parameter setup aids */
-EXTERN(void) jpeg_set_colorspace JPP((j_compress_ptr cinfo,
+JEXTERN(void) jpeg_set_colorspace JPP((j_compress_ptr cinfo,
 				      J_COLOR_SPACE colorspace));
-EXTERN(void) jpeg_default_colorspace JPP((j_compress_ptr cinfo));
-EXTERN(void) jpeg_set_quality JPP((j_compress_ptr cinfo, int quality,
+JEXTERN(void) jpeg_default_colorspace JPP((j_compress_ptr cinfo));
+JEXTERN(void) jpeg_set_quality JPP((j_compress_ptr cinfo, int quality,
 				   boolean force_baseline));
-EXTERN(void) jpeg_set_linear_quality JPP((j_compress_ptr cinfo,
+JEXTERN(void) jpeg_set_linear_quality JPP((j_compress_ptr cinfo,
 					  int scale_factor,
 					  boolean force_baseline));
-EXTERN(void) jpeg_default_qtables JPP((j_compress_ptr cinfo,
+JEXTERN(void) jpeg_default_qtables JPP((j_compress_ptr cinfo,
 				       boolean force_baseline));
-EXTERN(void) jpeg_add_quant_table JPP((j_compress_ptr cinfo, int which_tbl,
+JEXTERN(void) jpeg_add_quant_table JPP((j_compress_ptr cinfo, int which_tbl,
 				       const unsigned int *basic_table,
 				       int scale_factor,
 				       boolean force_baseline));
-EXTERN(int) jpeg_quality_scaling JPP((int quality));
-EXTERN(void) jpeg_simple_progression JPP((j_compress_ptr cinfo));
-EXTERN(void) jpeg_suppress_tables JPP((j_compress_ptr cinfo,
+JEXTERN(int) jpeg_quality_scaling JPP((int quality));
+JEXTERN(void) jpeg_simple_progression JPP((j_compress_ptr cinfo));
+JEXTERN(void) jpeg_suppress_tables JPP((j_compress_ptr cinfo,
 				       boolean suppress));
-EXTERN(JQUANT_TBL *) jpeg_alloc_quant_table JPP((j_common_ptr cinfo));
-EXTERN(JHUFF_TBL *) jpeg_alloc_huff_table JPP((j_common_ptr cinfo));
+JEXTERN(JQUANT_TBL *) jpeg_alloc_quant_table JPP((j_common_ptr cinfo));
+JEXTERN(JHUFF_TBL *) jpeg_alloc_huff_table JPP((j_common_ptr cinfo));
 
 /* Main entry points for compression */
-EXTERN(void) jpeg_start_compress JPP((j_compress_ptr cinfo,
+JEXTERN(void) jpeg_start_compress JPP((j_compress_ptr cinfo,
 				      boolean write_all_tables));
-EXTERN(JDIMENSION) jpeg_write_scanlines JPP((j_compress_ptr cinfo,
+JEXTERN(JDIMENSION) jpeg_write_scanlines JPP((j_compress_ptr cinfo,
 					     JSAMPARRAY scanlines,
 					     JDIMENSION num_lines));
-EXTERN(void) jpeg_finish_compress JPP((j_compress_ptr cinfo));
+JEXTERN(void) jpeg_finish_compress JPP((j_compress_ptr cinfo));
 
 /* Precalculate JPEG dimensions for current compression parameters. */
-EXTERN(void) jpeg_calc_jpeg_dimensions JPP((j_compress_ptr cinfo));
+JEXTERN(void) jpeg_calc_jpeg_dimensions JPP((j_compress_ptr cinfo));
 
 /* Replaces jpeg_write_scanlines when writing raw downsampled data. */
-EXTERN(JDIMENSION) jpeg_write_raw_data JPP((j_compress_ptr cinfo,
+JEXTERN(JDIMENSION) jpeg_write_raw_data JPP((j_compress_ptr cinfo,
 					    JSAMPIMAGE data,
 					    JDIMENSION num_lines));
 
 /* Write a special marker.  See libjpeg.txt concerning safe usage. */
-EXTERN(void) jpeg_write_marker
+JEXTERN(void) jpeg_write_marker
 	JPP((j_compress_ptr cinfo, int marker,
 	     const JOCTET * dataptr, unsigned int datalen));
 /* Same, but piecemeal. */
-EXTERN(void) jpeg_write_m_header
+JEXTERN(void) jpeg_write_m_header
 	JPP((j_compress_ptr cinfo, int marker, unsigned int datalen));
-EXTERN(void) jpeg_write_m_byte
+JEXTERN(void) jpeg_write_m_byte
 	JPP((j_compress_ptr cinfo, int val));
 
 /* Alternate compression function: just write an abbreviated table file */
-EXTERN(void) jpeg_write_tables JPP((j_compress_ptr cinfo));
+JEXTERN(void) jpeg_write_tables JPP((j_compress_ptr cinfo));
 
 /* Decompression startup: read start of JPEG datastream to see what's there */
-EXTERN(int) jpeg_read_header JPP((j_decompress_ptr cinfo,
+JEXTERN(int) jpeg_read_header JPP((j_decompress_ptr cinfo,
 				  boolean require_image));
 /* Return value is one of: */
 #define JPEG_SUSPENDED		0 /* Suspended due to lack of input data */
@@ -1027,25 +1027,25 @@
  */
 
 /* Main entry points for decompression */
-EXTERN(boolean) jpeg_start_decompress JPP((j_decompress_ptr cinfo));
-EXTERN(JDIMENSION) jpeg_read_scanlines JPP((j_decompress_ptr cinfo,
+JEXTERN(boolean) jpeg_start_decompress JPP((j_decompress_ptr cinfo));
+JEXTERN(JDIMENSION) jpeg_read_scanlines JPP((j_decompress_ptr cinfo,
 					    JSAMPARRAY scanlines,
 					    JDIMENSION max_lines));
-EXTERN(boolean) jpeg_finish_decompress JPP((j_decompress_ptr cinfo));
+JEXTERN(boolean) jpeg_finish_decompress JPP((j_decompress_ptr cinfo));
 
 /* Replaces jpeg_read_scanlines when reading raw downsampled data. */
-EXTERN(JDIMENSION) jpeg_read_raw_data JPP((j_decompress_ptr cinfo,
+JEXTERN(JDIMENSION) jpeg_read_raw_data JPP((j_decompress_ptr cinfo,
 					   JSAMPIMAGE data,
 					   JDIMENSION max_lines));
 
 /* Additional entry points for buffered-image mode. */
-EXTERN(boolean) jpeg_has_multiple_scans JPP((j_decompress_ptr cinfo));
-EXTERN(boolean) jpeg_start_output JPP((j_decompress_ptr cinfo,
+JEXTERN(boolean) jpeg_has_multiple_scans JPP((j_decompress_ptr cinfo));
+JEXTERN(boolean) jpeg_start_output JPP((j_decompress_ptr cinfo,
 				       int scan_number));
-EXTERN(boolean) jpeg_finish_output JPP((j_decompress_ptr cinfo));
-EXTERN(boolean) jpeg_input_complete JPP((j_decompress_ptr cinfo));
-EXTERN(void) jpeg_new_colormap JPP((j_decompress_ptr cinfo));
-EXTERN(int) jpeg_consume_input JPP((j_decompress_ptr cinfo));
+JEXTERN(boolean) jpeg_finish_output JPP((j_decompress_ptr cinfo));
+JEXTERN(boolean) jpeg_input_complete JPP((j_decompress_ptr cinfo));
+JEXTERN(void) jpeg_new_colormap JPP((j_decompress_ptr cinfo));
+JEXTERN(int) jpeg_consume_input JPP((j_decompress_ptr cinfo));
 /* Return value is one of: */
 /* #define JPEG_SUSPENDED	0    Suspended due to lack of input data */
 #define JPEG_REACHED_SOS	1 /* Reached start of new scan */
@@ -1054,24 +1054,24 @@
 #define JPEG_SCAN_COMPLETED	4 /* Completed last iMCU row of a scan */
 
 /* Precalculate output dimensions for current decompression parameters. */
-EXTERN(void) jpeg_core_output_dimensions JPP((j_decompress_ptr cinfo));
-EXTERN(void) jpeg_calc_output_dimensions JPP((j_decompress_ptr cinfo));
+JEXTERN(void) jpeg_core_output_dimensions JPP((j_decompress_ptr cinfo));
+JEXTERN(void) jpeg_calc_output_dimensions JPP((j_decompress_ptr cinfo));
 
 /* Control saving of COM and APPn markers into marker_list. */
-EXTERN(void) jpeg_save_markers
+JEXTERN(void) jpeg_save_markers
 	JPP((j_decompress_ptr cinfo, int marker_code,
 	     unsigned int length_limit));
 
 /* Install a special processing method for COM or APPn markers. */
-EXTERN(void) jpeg_set_marker_processor
+JEXTERN(void) jpeg_set_marker_processor
 	JPP((j_decompress_ptr cinfo, int marker_code,
 	     jpeg_marker_parser_method routine));
 
 /* Read or write raw DCT coefficients --- useful for lossless transcoding. */
-EXTERN(jvirt_barray_ptr *) jpeg_read_coefficients JPP((j_decompress_ptr cinfo));
-EXTERN(void) jpeg_write_coefficients JPP((j_compress_ptr cinfo,
+JEXTERN(jvirt_barray_ptr *) jpeg_read_coefficients JPP((j_decompress_ptr cinfo));
+JEXTERN(void) jpeg_write_coefficients JPP((j_compress_ptr cinfo,
 					  jvirt_barray_ptr * coef_arrays));
-EXTERN(void) jpeg_copy_critical_parameters JPP((j_decompress_ptr srcinfo,
+JEXTERN(void) jpeg_copy_critical_parameters JPP((j_decompress_ptr srcinfo,
 						j_compress_ptr dstinfo));
 
 /* If you choose to abort compression or decompression before completing
@@ -1080,17 +1080,17 @@
  * if you're done with the JPEG object, but if you want to clean it up and
  * reuse it, call this:
  */
-EXTERN(void) jpeg_abort_compress JPP((j_compress_ptr cinfo));
-EXTERN(void) jpeg_abort_decompress JPP((j_decompress_ptr cinfo));
+JEXTERN(void) jpeg_abort_compress JPP((j_compress_ptr cinfo));
+JEXTERN(void) jpeg_abort_decompress JPP((j_decompress_ptr cinfo));
 
 /* Generic versions of jpeg_abort and jpeg_destroy that work on either
  * flavor of JPEG object.  These may be more convenient in some places.
  */
-EXTERN(void) jpeg_abort JPP((j_common_ptr cinfo));
-EXTERN(void) jpeg_destroy JPP((j_common_ptr cinfo));
+JEXTERN(void) jpeg_abort JPP((j_common_ptr cinfo));
+JEXTERN(void) jpeg_destroy JPP((j_common_ptr cinfo));
 
 /* Default restart-marker-resync procedure for use by data source modules */
-EXTERN(boolean) jpeg_resync_to_restart JPP((j_decompress_ptr cinfo,
+JEXTERN(boolean) jpeg_resync_to_restart JPP((j_decompress_ptr cinfo,
 					    int desired));
 
 
--- jpegtran.c.orig	2010-02-14 14:53:36.000000000 +0000
+++ jpegtran.c	2011-01-05 21:55:15.000000000 +0000
@@ -42,7 +42,7 @@
 static jpeg_transform_info transformoption; /* image transformation options */
 
 
-LOCAL(void)
+JLOCAL(void)
 usage (void)
 /* complain about bad command line */
 {
@@ -93,7 +93,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 select_transform (JXFORM_CODE transform)
 /* Silly little routine to detect multiple transform options,
  * which we can't handle.
@@ -116,7 +116,7 @@
 }
 
 
-LOCAL(int)
+JLOCAL(int)
 parse_switches (j_compress_ptr cinfo, int argc, char **argv,
 		int last_file_arg_seen, boolean for_real)
 /* Parse optional switches.
--- jquant1.c.orig	1996-01-06 17:31:32.000000000 +0000
+++ jquant1.c	2011-01-05 21:55:15.000000000 +0000
@@ -182,7 +182,7 @@
  */
 
 
-LOCAL(int)
+JLOCAL(int)
 select_ncolors (j_decompress_ptr cinfo, int Ncolors[])
 /* Determine allocation of desired colors to components, */
 /* and fill in Ncolors[] array to indicate choice. */
@@ -241,7 +241,7 @@
 }
 
 
-LOCAL(int)
+JLOCAL(int)
 output_value (j_decompress_ptr cinfo, int ci, int j, int maxj)
 /* Return j'th output value, where j will range from 0 to maxj */
 /* The output values must fall in 0..MAXJSAMPLE in increasing order */
@@ -255,7 +255,7 @@
 }
 
 
-LOCAL(int)
+JLOCAL(int)
 largest_input_value (j_decompress_ptr cinfo, int ci, int j, int maxj)
 /* Return largest input value that should map to j'th output value */
 /* Must have largest(j=0) >= 0, and largest(j=maxj) >= MAXJSAMPLE */
@@ -269,7 +269,7 @@
  * Create the colormap.
  */
 
-LOCAL(void)
+JLOCAL(void)
 create_colormap (j_decompress_ptr cinfo)
 {
   my_cquantize_ptr cquantize = (my_cquantize_ptr) cinfo->cquantize;
@@ -329,7 +329,7 @@
  * Create the color index table.
  */
 
-LOCAL(void)
+JLOCAL(void)
 create_colorindex (j_decompress_ptr cinfo)
 {
   my_cquantize_ptr cquantize = (my_cquantize_ptr) cinfo->cquantize;
@@ -392,7 +392,7 @@
  * distinct output values.
  */
 
-LOCAL(ODITHER_MATRIX_PTR)
+JLOCAL(ODITHER_MATRIX_PTR)
 make_odither_array (j_decompress_ptr cinfo, int ncolors)
 {
   ODITHER_MATRIX_PTR odither;
@@ -428,7 +428,7 @@
  * share a dither table.
  */
 
-LOCAL(void)
+JLOCAL(void)
 create_odither_tables (j_decompress_ptr cinfo)
 {
   my_cquantize_ptr cquantize = (my_cquantize_ptr) cinfo->cquantize;
@@ -455,7 +455,7 @@
  * Map some rows of pixels to the output colormapped representation.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 color_quantize (j_decompress_ptr cinfo, JSAMPARRAY input_buf,
 		JSAMPARRAY output_buf, int num_rows)
 /* General case, no dithering */
@@ -483,7 +483,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 color_quantize3 (j_decompress_ptr cinfo, JSAMPARRAY input_buf,
 		 JSAMPARRAY output_buf, int num_rows)
 /* Fast path for out_color_components==3, no dithering */
@@ -511,7 +511,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 quantize_ord_dither (j_decompress_ptr cinfo, JSAMPARRAY input_buf,
 		     JSAMPARRAY output_buf, int num_rows)
 /* General case, with ordered dithering */
@@ -561,7 +561,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 quantize3_ord_dither (j_decompress_ptr cinfo, JSAMPARRAY input_buf,
 		      JSAMPARRAY output_buf, int num_rows)
 /* Fast path for out_color_components==3, with ordered dithering */
@@ -606,7 +606,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 quantize_fs_dither (j_decompress_ptr cinfo, JSAMPARRAY input_buf,
 		    JSAMPARRAY output_buf, int num_rows)
 /* General case, with Floyd-Steinberg dithering */
@@ -718,7 +718,7 @@
  * Allocate workspace for Floyd-Steinberg errors.
  */
 
-LOCAL(void)
+JLOCAL(void)
 alloc_fs_workspace (j_decompress_ptr cinfo)
 {
   my_cquantize_ptr cquantize = (my_cquantize_ptr) cinfo->cquantize;
@@ -737,7 +737,7 @@
  * Initialize for one-pass color quantization.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass_1_quant (j_decompress_ptr cinfo, boolean is_pre_scan)
 {
   my_cquantize_ptr cquantize = (my_cquantize_ptr) cinfo->cquantize;
@@ -794,7 +794,7 @@
  * Finish up at the end of the pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_pass_1_quant (j_decompress_ptr cinfo)
 {
   /* no work in 1-pass case */
@@ -806,7 +806,7 @@
  * Shouldn't get to this module!
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 new_color_map_1_quant (j_decompress_ptr cinfo)
 {
   ERREXIT(cinfo, JERR_MODE_CHANGE);
@@ -817,7 +817,7 @@
  * Module initialization routine for 1-pass color quantization.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_1pass_quantizer (j_decompress_ptr cinfo)
 {
   my_cquantize_ptr cquantize;
--- jquant2.c.orig	1996-01-06 17:31:34.000000000 +0000
+++ jquant2.c	2011-01-05 21:55:15.000000000 +0000
@@ -220,7 +220,7 @@
  * NULL pointer).
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 prescan_quantize (j_decompress_ptr cinfo, JSAMPARRAY input_buf,
 		  JSAMPARRAY output_buf, int num_rows)
 {
@@ -269,7 +269,7 @@
 typedef box * boxptr;
 
 
-LOCAL(boxptr)
+JLOCAL(boxptr)
 find_biggest_color_pop (boxptr boxlist, int numboxes)
 /* Find the splittable box with the largest color population */
 /* Returns NULL if no splittable boxes remain */
@@ -289,7 +289,7 @@
 }
 
 
-LOCAL(boxptr)
+JLOCAL(boxptr)
 find_biggest_volume (boxptr boxlist, int numboxes)
 /* Find the splittable box with the largest (scaled) volume */
 /* Returns NULL if no splittable boxes remain */
@@ -309,7 +309,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 update_box (j_decompress_ptr cinfo, boxptr boxp)
 /* Shrink the min/max bounds of a box to enclose only nonzero elements, */
 /* and recompute its volume and population */
@@ -420,7 +420,7 @@
 }
 
 
-LOCAL(int)
+JLOCAL(int)
 median_cut (j_decompress_ptr cinfo, boxptr boxlist, int numboxes,
 	    int desired_colors)
 /* Repeatedly select and split the largest box until we have enough boxes */
@@ -495,7 +495,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 compute_color (j_decompress_ptr cinfo, boxptr boxp, int icolor)
 /* Compute representative color for a box, put it in colormap[icolor] */
 {
@@ -535,7 +535,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 select_colors (j_decompress_ptr cinfo, int desired_colors)
 /* Master routine for color selection */
 {
@@ -642,7 +642,7 @@
  * inner-loop variables.
  */
 
-LOCAL(int)
+JLOCAL(int)
 find_nearby_colors (j_decompress_ptr cinfo, int minc0, int minc1, int minc2,
 		    JSAMPLE colorlist[])
 /* Locate the colormap entries close enough to an update box to be candidates
@@ -771,7 +771,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 find_best_colors (j_decompress_ptr cinfo, int minc0, int minc1, int minc2,
 		  int numcolors, JSAMPLE colorlist[], JSAMPLE bestcolor[])
 /* Find the closest colormap entry for each cell in the update box,
@@ -851,7 +851,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 fill_inverse_cmap (j_decompress_ptr cinfo, int c0, int c1, int c2)
 /* Fill the inverse-colormap entries in the update box that contains */
 /* histogram cell c0/c1/c2.  (Only that one cell MUST be filled, but */
@@ -911,7 +911,7 @@
  * Map some rows of pixels to the output colormapped representation.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 pass2_no_dither (j_decompress_ptr cinfo,
 		 JSAMPARRAY input_buf, JSAMPARRAY output_buf, int num_rows)
 /* This version performs no dithering */
@@ -945,7 +945,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 pass2_fs_dither (j_decompress_ptr cinfo,
 		 JSAMPARRAY input_buf, JSAMPARRAY output_buf, int num_rows)
 /* This version performs Floyd-Steinberg dithering */
@@ -1104,7 +1104,7 @@
  * to Aaron Giles for this idea.
  */
 
-LOCAL(void)
+JLOCAL(void)
 init_error_limit (j_decompress_ptr cinfo)
 /* Allocate and fill in the error_limiter table */
 {
@@ -1139,7 +1139,7 @@
  * Finish up at the end of each pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_pass1 (j_decompress_ptr cinfo)
 {
   my_cquantize_ptr cquantize = (my_cquantize_ptr) cinfo->cquantize;
@@ -1152,7 +1152,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_pass2 (j_decompress_ptr cinfo)
 {
   /* no work */
@@ -1163,7 +1163,7 @@
  * Initialize for each processing pass.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_pass_2_quant (j_decompress_ptr cinfo, boolean is_pre_scan)
 {
   my_cquantize_ptr cquantize = (my_cquantize_ptr) cinfo->cquantize;
@@ -1226,7 +1226,7 @@
  * Switch to a new external colormap between output passes.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 new_color_map_2_quant (j_decompress_ptr cinfo)
 {
   my_cquantize_ptr cquantize = (my_cquantize_ptr) cinfo->cquantize;
@@ -1240,7 +1240,7 @@
  * Module initialization routine for 2-pass color quantization.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jinit_2pass_quantizer (j_decompress_ptr cinfo)
 {
   my_cquantize_ptr cquantize;
--- jutils.c.orig	2009-04-11 12:31:52.000000000 +0100
+++ jutils.c	2011-01-05 21:55:15.000000000 +0000
@@ -120,7 +120,7 @@
  * Arithmetic utilities
  */
 
-GLOBAL(long)
+JGLOBAL(long)
 jdiv_round_up (long a, long b)
 /* Compute a/b rounded up to next integer, ie, ceil(a/b) */
 /* Assumes a >= 0, b > 0 */
@@ -129,7 +129,7 @@
 }
 
 
-GLOBAL(long)
+JGLOBAL(long)
 jround_up (long a, long b)
 /* Compute a rounded up to next multiple of b, ie, ceil(a/b)*b */
 /* Assumes a >= 0, b > 0 */
@@ -159,7 +159,7 @@
 #endif
 
 
-GLOBAL(void)
+JGLOBAL(void)
 jcopy_sample_rows (JSAMPARRAY input_array, int source_row,
 		   JSAMPARRAY output_array, int dest_row,
 		   int num_rows, JDIMENSION num_cols)
@@ -193,7 +193,7 @@
 }
 
 
-GLOBAL(void)
+JGLOBAL(void)
 jcopy_block_row (JBLOCKROW input_row, JBLOCKROW output_row,
 		 JDIMENSION num_blocks)
 /* Copy a row of coefficient blocks from one place to another. */
@@ -213,7 +213,7 @@
 }
 
 
-GLOBAL(void)
+JGLOBAL(void)
 jzero_far (void FAR * target, size_t bytestozero)
 /* Zero out a chunk of FAR memory. */
 /* This might be sample-array data, block-array data, or alloc_large data. */
--- rdbmp.c.orig	2010-02-14 15:22:22.000000000 +0000
+++ rdbmp.c	2011-01-05 21:55:16.000000000 +0000
@@ -65,7 +65,7 @@
 } bmp_source_struct;
 
 
-LOCAL(int)
+JLOCAL(int)
 read_byte (bmp_source_ptr sinfo)
 /* Read next byte from BMP file */
 {
@@ -78,7 +78,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 read_colormap (bmp_source_ptr sinfo, int cmaplen, int mapentrysize)
 /* Read the colormap from a BMP file */
 {
@@ -116,7 +116,7 @@
  * it is an 8-bit image, we must expand colormapped pixels to 24bit format.
  */
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 get_8bit_row (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 /* This version is for reading 8-bit colormap indexes */
 {
@@ -147,7 +147,7 @@
 }
 
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 get_24bit_row (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 /* This version is for reading 24-bit pixels */
 {
@@ -178,7 +178,7 @@
 }
 
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 get_32bit_row (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 /* This version is for reading 32-bit pixels */
 {
@@ -215,7 +215,7 @@
  * get_8bit_row, get_24bit_row, or get_32bit_row on subsequent calls.
  */
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 preload_image (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 {
   bmp_source_ptr source = (bmp_source_ptr) sinfo;
@@ -272,7 +272,7 @@
  * Read the file header; return image size and component count.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_input_bmp (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 {
   bmp_source_ptr source = (bmp_source_ptr) sinfo;
@@ -449,7 +449,7 @@
  * Finish up at the end of the file.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_input_bmp (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 {
   /* no work */
@@ -460,7 +460,7 @@
  * The module selection routine for BMP format input.
  */
 
-GLOBAL(cjpeg_source_ptr)
+JGLOBAL(cjpeg_source_ptr)
 jinit_read_bmp (j_compress_ptr cinfo)
 {
   bmp_source_ptr source;
--- rdcolmap.c.orig	1996-11-19 10:38:44.000000000 +0000
+++ rdcolmap.c	2011-01-05 21:55:16.000000000 +0000
@@ -42,7 +42,7 @@
  * Add a (potentially) new color to the color map.
  */
 
-LOCAL(void)
+JLOCAL(void)
 add_map_entry (j_decompress_ptr cinfo, int R, int G, int B)
 {
   JSAMPROW colormap0 = cinfo->colormap[0];
@@ -75,7 +75,7 @@
  * Extract color map from a GIF file.
  */
 
-LOCAL(void)
+JLOCAL(void)
 read_gif_map (j_decompress_ptr cinfo, FILE * infile)
 {
   int header[13];
@@ -117,7 +117,7 @@
 /* Support routines for reading PPM */
 
 
-LOCAL(int)
+JLOCAL(int)
 pbm_getc (FILE * infile)
 /* Read next char, skipping over any comments */
 /* A comment/newline sequence is returned as a newline */
@@ -134,7 +134,7 @@
 }
 
 
-LOCAL(unsigned int)
+JLOCAL(unsigned int)
 read_pbm_integer (j_decompress_ptr cinfo, FILE * infile)
 /* Read an unsigned decimal integer from the PPM file */
 /* Swallows one trailing character after the integer */
@@ -167,7 +167,7 @@
  * Extract color map from a PPM file.
  */
 
-LOCAL(void)
+JLOCAL(void)
 read_ppm_map (j_decompress_ptr cinfo, FILE * infile)
 {
   int c;
@@ -227,7 +227,7 @@
  *  Output: colormap and actual_number_of_colors fields are set in cinfo.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 read_color_map (j_decompress_ptr cinfo, FILE * infile)
 {
   /* Allocate space for a color map of maximum supported size. */
--- rdgif.c.orig	1997-08-22 21:19:50.000000000 +0100
+++ rdgif.c	2011-01-05 21:55:16.000000000 +0000
@@ -27,7 +27,7 @@
  * The module selection routine for GIF format input.
  */
 
-GLOBAL(cjpeg_source_ptr)
+JGLOBAL(cjpeg_source_ptr)
 jinit_read_gif (j_compress_ptr cinfo)
 {
   fprintf(stderr, "GIF input is unsupported for legal reasons.  Sorry.\n");
--- rdppm.c.orig	2009-04-02 18:44:25.000000000 +0100
+++ rdppm.c	2011-01-05 21:55:16.000000000 +0000
@@ -81,7 +81,7 @@
 typedef ppm_source_struct * ppm_source_ptr;
 
 
-LOCAL(int)
+JLOCAL(int)
 pbm_getc (FILE * infile)
 /* Read next char, skipping over any comments */
 /* A comment/newline sequence is returned as a newline */
@@ -98,7 +98,7 @@
 }
 
 
-LOCAL(unsigned int)
+JLOCAL(unsigned int)
 read_pbm_integer (j_compress_ptr cinfo, FILE * infile)
 /* Read an unsigned decimal integer from the PPM file */
 /* Swallows one trailing character after the integer */
@@ -138,7 +138,7 @@
  */
 
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 get_text_gray_row (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 /* This version is for reading text-format PGM files with any maxval */
 {
@@ -156,7 +156,7 @@
 }
 
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 get_text_rgb_row (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 /* This version is for reading text-format PPM files with any maxval */
 {
@@ -176,7 +176,7 @@
 }
 
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 get_scaled_gray_row (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 /* This version is for reading raw-byte-format PGM files with any maxval */
 {
@@ -197,7 +197,7 @@
 }
 
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 get_scaled_rgb_row (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 /* This version is for reading raw-byte-format PPM files with any maxval */
 {
@@ -220,7 +220,7 @@
 }
 
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 get_raw_row (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 /* This version is for reading raw-byte-format files with maxval = MAXJSAMPLE.
  * In this case we just read right into the JSAMPLE buffer!
@@ -235,7 +235,7 @@
 }
 
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 get_word_gray_row (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 /* This version is for reading raw-word-format PGM files with any maxval */
 {
@@ -259,7 +259,7 @@
 }
 
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 get_word_rgb_row (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 /* This version is for reading raw-word-format PPM files with any maxval */
 {
@@ -293,7 +293,7 @@
  * Read the file header; return image size and component count.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_input_ppm (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 {
   ppm_source_ptr source = (ppm_source_ptr) sinfo;
@@ -429,7 +429,7 @@
  * Finish up at the end of the file.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_input_ppm (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 {
   /* no work */
@@ -440,7 +440,7 @@
  * The module selection routine for PPM format input.
  */
 
-GLOBAL(cjpeg_source_ptr)
+JGLOBAL(cjpeg_source_ptr)
 jinit_read_ppm (j_compress_ptr cinfo)
 {
   ppm_source_ptr source;
--- rdrle.c.orig	1996-01-06 17:32:20.000000000 +0000
+++ rdrle.c	2011-01-05 21:55:16.000000000 +0000
@@ -77,7 +77,7 @@
  * Read the file header; return image size and component count.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_input_rle (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 {
   rle_source_ptr source = (rle_source_ptr) sinfo;
@@ -183,7 +183,7 @@
  * Used for GRAYSCALE, MAPPEDGRAY, TRUECOLOR, and DIRECTCOLOR images.
  */
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 get_rle_row (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 {
   rle_source_ptr source = (rle_source_ptr) sinfo;
@@ -201,7 +201,7 @@
  * Used for PSEUDOCOLOR images.
  */
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 get_pseudocolor_row (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 {
   rle_source_ptr source = (rle_source_ptr) sinfo;
@@ -237,7 +237,7 @@
  * the appropriate row-reading routine.
  */
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 load_image (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 {
   rle_source_ptr source = (rle_source_ptr) sinfo;
@@ -356,7 +356,7 @@
  * Finish up at the end of the file.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_input_rle (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 {
   /* no work */
@@ -367,7 +367,7 @@
  * The module selection routine for RLE format input.
  */
 
-GLOBAL(cjpeg_source_ptr)
+JGLOBAL(cjpeg_source_ptr)
 jinit_read_rle (j_compress_ptr cinfo)
 {
   rle_source_ptr source;
--- rdswitch.c.orig	2003-11-03 20:51:40.000000000 +0000
+++ rdswitch.c	2011-01-05 21:55:16.000000000 +0000
@@ -18,7 +18,7 @@
 #include <ctype.h>		/* to declare isdigit(), isspace() */
 
 
-LOCAL(int)
+JLOCAL(int)
 text_getc (FILE * file)
 /* Read next char, skipping over any comments (# to end of line) */
 /* A comment/newline sequence is returned as a newline */
@@ -35,7 +35,7 @@
 }
 
 
-LOCAL(boolean)
+JLOCAL(boolean)
 read_text_integer (FILE * file, long * result, int * termchar)
 /* Read an unsigned decimal integer from a file, store it in result */
 /* Reads one trailing character after the integer; returns it in termchar */
@@ -70,7 +70,7 @@
 }
 
 
-GLOBAL(boolean)
+JGLOBAL(boolean)
 read_quant_tables (j_compress_ptr cinfo, char * filename, boolean force_baseline)
 /* Read a set of quantization tables from the specified file.
  * The file is plain ASCII text: decimal numbers with whitespace between.
@@ -126,7 +126,7 @@
 
 #ifdef C_MULTISCAN_FILES_SUPPORTED
 
-LOCAL(boolean)
+JLOCAL(boolean)
 read_scan_integer (FILE * file, long * result, int * termchar)
 /* Variant of read_text_integer that always looks for a non-space termchar;
  * this simplifies parsing of punctuation in scan scripts.
@@ -155,7 +155,7 @@
 }
 
 
-GLOBAL(boolean)
+JGLOBAL(boolean)
 read_scan_script (j_compress_ptr cinfo, char * filename)
 /* Read a scan script from the specified text file.
  * Each entry in the file defines one scan to be emitted.
@@ -263,7 +263,7 @@
 #endif /* C_MULTISCAN_FILES_SUPPORTED */
 
 
-GLOBAL(boolean)
+JGLOBAL(boolean)
 set_quality_ratings (j_compress_ptr cinfo, char *arg, boolean force_baseline)
 /* Process a quality-ratings parameter string, of the form
  *     N[,N,...]
@@ -295,7 +295,7 @@
 }
 
 
-GLOBAL(boolean)
+JGLOBAL(boolean)
 set_quant_slots (j_compress_ptr cinfo, char *arg)
 /* Process a quantization-table-selectors parameter string, of the form
  *     N[,N,...]
@@ -330,7 +330,7 @@
 }
 
 
-GLOBAL(boolean)
+JGLOBAL(boolean)
 set_sample_factors (j_compress_ptr cinfo, char *arg)
 /* Process a sample-factors parameter string, of the form
  *     HxV[,HxV,...]
--- rdtarga.c.orig	1996-01-07 11:42:36.000000000 +0000
+++ rdtarga.c	2011-01-05 21:55:16.000000000 +0000
@@ -84,7 +84,7 @@
 
 
 
-LOCAL(int)
+JLOCAL(int)
 read_byte (tga_source_ptr sinfo)
 /* Read next byte from Targa file */
 {
@@ -97,7 +97,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 read_colormap (tga_source_ptr sinfo, int cmaplen, int mapentrysize)
 /* Read the colormap from a Targa file */
 {
@@ -119,7 +119,7 @@
  * read_pixel methods: get a single pixel from Targa file into tga_pixel[]
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 read_non_rle_pixel (tga_source_ptr sinfo)
 /* Read one Targa pixel from the input file; no RLE expansion */
 {
@@ -132,7 +132,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 read_rle_pixel (tga_source_ptr sinfo)
 /* Read one Targa pixel from the input file, expanding RLE data as needed */
 {
@@ -170,7 +170,7 @@
  */
 
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 get_8bit_gray_row (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 /* This version is for reading 8-bit grayscale pixels */
 {
@@ -186,7 +186,7 @@
   return 1;
 }
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 get_8bit_row (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 /* This version is for reading 8-bit colormap indexes */
 {
@@ -207,7 +207,7 @@
   return 1;
 }
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 get_16bit_row (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 /* This version is for reading 16-bit pixels */
 {
@@ -235,7 +235,7 @@
   return 1;
 }
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 get_24bit_row (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 /* This version is for reading 24-bit pixels */
 {
@@ -269,7 +269,7 @@
  * with proper conversion of pixel format, but it's in a funny row order.
  */
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 get_memory_row (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 {
   tga_source_ptr source = (tga_source_ptr) sinfo;
@@ -296,7 +296,7 @@
  * get_memory_row on subsequent calls.
  */
 
-METHODDEF(JDIMENSION)
+JMETHODDEF(JDIMENSION)
 preload_image (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 {
   tga_source_ptr source = (tga_source_ptr) sinfo;
@@ -329,7 +329,7 @@
  * Read the file header; return image size and component count.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_input_tga (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 {
   tga_source_ptr source = (tga_source_ptr) sinfo;
@@ -469,7 +469,7 @@
  * Finish up at the end of the file.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_input_tga (j_compress_ptr cinfo, cjpeg_source_ptr sinfo)
 {
   /* no work */
@@ -480,7 +480,7 @@
  * The module selection routine for Targa format input.
  */
 
-GLOBAL(cjpeg_source_ptr)
+JGLOBAL(cjpeg_source_ptr)
 jinit_read_targa (j_compress_ptr cinfo)
 {
   tga_source_ptr source;
--- transupp.c.orig	2009-09-03 15:45:06.000000000 +0100
+++ transupp.c	2011-01-05 21:55:16.000000000 +0000
@@ -75,7 +75,7 @@
  */
 
 
-LOCAL(void)
+JLOCAL(void)
 do_crop (j_decompress_ptr srcinfo, j_compress_ptr dstinfo,
 	 JDIMENSION x_crop_offset, JDIMENSION y_crop_offset,
 	 jvirt_barray_ptr *src_coef_arrays,
@@ -113,7 +113,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 do_flip_h_no_crop (j_decompress_ptr srcinfo, j_compress_ptr dstinfo,
 		   JDIMENSION x_crop_offset,
 		   jvirt_barray_ptr *src_coef_arrays)
@@ -180,7 +180,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 do_flip_h (j_decompress_ptr srcinfo, j_compress_ptr dstinfo,
 	   JDIMENSION x_crop_offset, JDIMENSION y_crop_offset,
 	   jvirt_barray_ptr *src_coef_arrays,
@@ -242,7 +242,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 do_flip_v (j_decompress_ptr srcinfo, j_compress_ptr dstinfo,
 	   JDIMENSION x_crop_offset, JDIMENSION y_crop_offset,
 	   jvirt_barray_ptr *src_coef_arrays,
@@ -322,7 +322,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 do_transpose (j_decompress_ptr srcinfo, j_compress_ptr dstinfo,
 	      JDIMENSION x_crop_offset, JDIMENSION y_crop_offset,
 	      jvirt_barray_ptr *src_coef_arrays,
@@ -370,7 +370,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 do_rot_90 (j_decompress_ptr srcinfo, j_compress_ptr dstinfo,
 	   JDIMENSION x_crop_offset, JDIMENSION y_crop_offset,
 	   jvirt_barray_ptr *src_coef_arrays,
@@ -451,7 +451,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 do_rot_270 (j_decompress_ptr srcinfo, j_compress_ptr dstinfo,
 	    JDIMENSION x_crop_offset, JDIMENSION y_crop_offset,
 	    jvirt_barray_ptr *src_coef_arrays,
@@ -522,7 +522,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 do_rot_180 (j_decompress_ptr srcinfo, j_compress_ptr dstinfo,
 	    JDIMENSION x_crop_offset, JDIMENSION y_crop_offset,
 	    jvirt_barray_ptr *src_coef_arrays,
@@ -630,7 +630,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 do_transverse (j_decompress_ptr srcinfo, j_compress_ptr dstinfo,
 	       JDIMENSION x_crop_offset, JDIMENSION y_crop_offset,
 	       jvirt_barray_ptr *src_coef_arrays,
@@ -750,7 +750,7 @@
  * *strptr is advanced over the digit string, and *result is set to its value.
  */
 
-LOCAL(boolean)
+JLOCAL(boolean)
 jt_read_integer (const char ** strptr, JDIMENSION * result)
 {
   const char * ptr = *strptr;
@@ -780,7 +780,7 @@
  * This code is loosely based on XParseGeometry from the X11 distribution.
  */
 
-GLOBAL(boolean)
+JGLOBAL(boolean)
 jtransform_parse_crop_spec (jpeg_transform_info *info, const char *spec)
 {
   info->crop = FALSE;
@@ -826,7 +826,7 @@
 
 /* Trim off any partial iMCUs on the indicated destination edge */
 
-LOCAL(void)
+JLOCAL(void)
 trim_right_edge (jpeg_transform_info *info, JDIMENSION full_width)
 {
   JDIMENSION MCU_cols;
@@ -837,7 +837,7 @@
     info->output_width = MCU_cols * info->iMCU_sample_width;
 }
 
-LOCAL(void)
+JLOCAL(void)
 trim_bottom_edge (jpeg_transform_info *info, JDIMENSION full_height)
 {
   JDIMENSION MCU_rows;
@@ -866,7 +866,7 @@
  * and transformation is not perfect.  Otherwise returns TRUE.
  */
 
-GLOBAL(boolean)
+JGLOBAL(boolean)
 jtransform_request_workspace (j_decompress_ptr srcinfo,
 			      jpeg_transform_info *info)
 {
@@ -1097,7 +1097,7 @@
 
 /* Transpose destination image parameters */
 
-LOCAL(void)
+JLOCAL(void)
 transpose_critical_parameters (j_compress_ptr dstinfo)
 {
   int tblno, i, j, ci, itemp;
@@ -1143,7 +1143,7 @@
  * We try to adjust the Tags ExifImageWidth and ExifImageHeight if possible.
  */
 
-LOCAL(void)
+JLOCAL(void)
 adjust_exif_parameters (JOCTET FAR * data, unsigned int length,
 			JDIMENSION new_width, JDIMENSION new_height)
 {
@@ -1305,7 +1305,7 @@
  * to jpeg_write_coefficients().
  */
 
-GLOBAL(jvirt_barray_ptr *)
+JGLOBAL(jvirt_barray_ptr *)
 jtransform_adjust_parameters (j_decompress_ptr srcinfo,
 			      j_compress_ptr dstinfo,
 			      jvirt_barray_ptr *src_coef_arrays,
@@ -1400,7 +1400,7 @@
  * Note that some transformations will modify the source data arrays!
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jtransform_execute_transform (j_decompress_ptr srcinfo,
 			      j_compress_ptr dstinfo,
 			      jvirt_barray_ptr *src_coef_arrays,
@@ -1473,7 +1473,7 @@
  *           (may use custom action then)
  */
 
-GLOBAL(boolean)
+JGLOBAL(boolean)
 jtransform_perfect_transform(JDIMENSION image_width, JDIMENSION image_height,
 			     int MCU_width, int MCU_height,
 			     JXFORM_CODE transform)
@@ -1512,7 +1512,7 @@
  * This must be called before jpeg_read_header() to have the desired effect.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jcopy_markers_setup (j_decompress_ptr srcinfo, JCOPY_OPTION option)
 {
 #ifdef SAVE_MARKERS_SUPPORTED
@@ -1537,7 +1537,7 @@
  * JFIF APP0 or Adobe APP14 markers if selected.
  */
 
-GLOBAL(void)
+JGLOBAL(void)
 jcopy_markers_execute (j_decompress_ptr srcinfo, j_compress_ptr dstinfo,
 		       JCOPY_OPTION option)
 {
--- transupp.h.orig	2009-09-03 09:54:26.000000000 +0100
+++ transupp.h	2011-01-05 21:55:16.000000000 +0000
@@ -156,25 +156,25 @@
 #if TRANSFORMS_SUPPORTED
 
 /* Parse a crop specification (written in X11 geometry style) */
-EXTERN(boolean) jtransform_parse_crop_spec
+JEXTERN(boolean) jtransform_parse_crop_spec
 	JPP((jpeg_transform_info *info, const char *spec));
 /* Request any required workspace */
-EXTERN(boolean) jtransform_request_workspace
+JEXTERN(boolean) jtransform_request_workspace
 	JPP((j_decompress_ptr srcinfo, jpeg_transform_info *info));
 /* Adjust output image parameters */
-EXTERN(jvirt_barray_ptr *) jtransform_adjust_parameters
+JEXTERN(jvirt_barray_ptr *) jtransform_adjust_parameters
 	JPP((j_decompress_ptr srcinfo, j_compress_ptr dstinfo,
 	     jvirt_barray_ptr *src_coef_arrays,
 	     jpeg_transform_info *info));
 /* Execute the actual transformation, if any */
-EXTERN(void) jtransform_execute_transform
+JEXTERN(void) jtransform_execute_transform
 	JPP((j_decompress_ptr srcinfo, j_compress_ptr dstinfo,
 	     jvirt_barray_ptr *src_coef_arrays,
 	     jpeg_transform_info *info));
 /* Determine whether lossless transformation is perfectly
  * possible for a specified image and transformation.
  */
-EXTERN(boolean) jtransform_perfect_transform
+JEXTERN(boolean) jtransform_perfect_transform
 	JPP((JDIMENSION image_width, JDIMENSION image_height,
 	     int MCU_width, int MCU_height,
 	     JXFORM_CODE transform));
@@ -202,9 +202,9 @@
 #define JCOPYOPT_DEFAULT  JCOPYOPT_COMMENTS	/* recommended default */
 
 /* Setup decompression object to save desired markers in memory */
-EXTERN(void) jcopy_markers_setup
+JEXTERN(void) jcopy_markers_setup
 	JPP((j_decompress_ptr srcinfo, JCOPY_OPTION option));
 /* Copy markers saved in the given source object to the destination object */
-EXTERN(void) jcopy_markers_execute
+JEXTERN(void) jcopy_markers_execute
 	JPP((j_decompress_ptr srcinfo, j_compress_ptr dstinfo,
 	     JCOPY_OPTION option));
--- wrbmp.c.orig	1996-01-06 17:32:38.000000000 +0000
+++ wrbmp.c	2011-01-05 21:55:16.000000000 +0000
@@ -57,7 +57,7 @@
 
 
 /* Forward declarations */
-LOCAL(void) write_colormap
+JLOCAL(void) write_colormap
 	JPP((j_decompress_ptr cinfo, bmp_dest_ptr dest,
 	     int map_colors, int map_entry_size));
 
@@ -67,7 +67,7 @@
  * In this module rows_supplied will always be 1.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 put_pixel_rows (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo,
 		JDIMENSION rows_supplied)
 /* This version is for writing 24-bit pixels */
@@ -102,7 +102,7 @@
     *outptr++ = 0;
 }
 
-METHODDEF(void)
+JMETHODDEF(void)
 put_gray_rows (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo,
 	       JDIMENSION rows_supplied)
 /* This version is for grayscale OR quantized color output */
@@ -138,7 +138,7 @@
  * In this module we may as well postpone everything until finish_output.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_output_bmp (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo)
 {
   /* no work here */
@@ -153,7 +153,7 @@
  * First, routines to write the Windows and OS/2 variants of the file header.
  */
 
-LOCAL(void)
+JLOCAL(void)
 write_bmp_header (j_decompress_ptr cinfo, bmp_dest_ptr dest)
 /* Write a Windows-style BMP file header, including colormap if needed */
 {
@@ -226,7 +226,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 write_os2_header (j_decompress_ptr cinfo, bmp_dest_ptr dest)
 /* Write an OS2-style BMP file header, including colormap if needed */
 {
@@ -288,7 +288,7 @@
  * Windows uses BGR0 map entries; OS/2 uses BGR entries.
  */
 
-LOCAL(void)
+JLOCAL(void)
 write_colormap (j_decompress_ptr cinfo, bmp_dest_ptr dest,
 		int map_colors, int map_entry_size)
 {
@@ -340,7 +340,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_output_bmp (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo)
 {
   bmp_dest_ptr dest = (bmp_dest_ptr) dinfo;
@@ -386,7 +386,7 @@
  * The module selection routine for BMP format output.
  */
 
-GLOBAL(djpeg_dest_ptr)
+JGLOBAL(djpeg_dest_ptr)
 jinit_write_bmp (j_decompress_ptr cinfo, boolean is_os2)
 {
   bmp_dest_ptr dest;
--- wrgif.c.orig	1997-09-24 10:56:50.000000000 +0100
+++ wrgif.c	2011-01-05 21:55:16.000000000 +0000
@@ -77,7 +77,7 @@
  * A data block consists of a count byte (1..255) and that many data bytes.
  */
 
-LOCAL(void)
+JLOCAL(void)
 flush_packet (gif_dest_ptr dinfo)
 /* flush any accumulated data */
 {
@@ -101,7 +101,7 @@
 
 /* Routine to convert variable-width codes into a byte stream */
 
-LOCAL(void)
+JLOCAL(void)
 output (gif_dest_ptr dinfo, int code)
 /* Emit a code of n_bits bits */
 /* Uses cur_accum and cur_bits to reblock into 8-bit bytes */
@@ -139,7 +139,7 @@
  * one symbol in every 256.
  */
 
-LOCAL(void)
+JLOCAL(void)
 compress_init (gif_dest_ptr dinfo, int i_bits)
 /* Initialize pseudo-compressor */
 {
@@ -158,7 +158,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 compress_pixel (gif_dest_ptr dinfo, int c)
 /* Accept and "compress" one pixel value.
  * The given value must be less than n_bits wide.
@@ -178,7 +178,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 compress_term (gif_dest_ptr dinfo)
 /* Clean up at end */
 {
@@ -196,7 +196,7 @@
 /* GIF header construction */
 
 
-LOCAL(void)
+JLOCAL(void)
 put_word (gif_dest_ptr dinfo, unsigned int w)
 /* Emit a 16-bit word, LSB first */
 {
@@ -205,7 +205,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 put_3bytes (gif_dest_ptr dinfo, int val)
 /* Emit 3 copies of same byte value --- handy subr for colormap construction */
 {
@@ -215,7 +215,7 @@
 }
 
 
-LOCAL(void)
+JLOCAL(void)
 emit_header (gif_dest_ptr dinfo, int num_colors, JSAMPARRAY colormap)
 /* Output the GIF file header, including color map */
 /* If colormap==NULL, synthesize a gray-scale colormap */
@@ -298,7 +298,7 @@
  * Startup: write the file header.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_output_gif (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo)
 {
   gif_dest_ptr dest = (gif_dest_ptr) dinfo;
@@ -315,7 +315,7 @@
  * In this module rows_supplied will always be 1.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 put_pixel_rows (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo,
 		JDIMENSION rows_supplied)
 {
@@ -334,7 +334,7 @@
  * Finish up at the end of the file.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_output_gif (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo)
 {
   gif_dest_ptr dest = (gif_dest_ptr) dinfo;
@@ -356,7 +356,7 @@
  * The module selection routine for GIF format output.
  */
 
-GLOBAL(djpeg_dest_ptr)
+JGLOBAL(djpeg_dest_ptr)
 jinit_write_gif (j_decompress_ptr cinfo)
 {
   gif_dest_ptr dest;
--- wrppm.c.orig	2009-04-06 22:20:20.000000000 +0100
+++ wrppm.c	2011-01-05 21:55:16.000000000 +0000
@@ -87,7 +87,7 @@
  * output buffer is physically the same as the fwrite buffer.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 put_pixel_rows (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo,
 		JDIMENSION rows_supplied)
 {
@@ -102,7 +102,7 @@
  * format translation.  Typically this only happens in 12-bit mode.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 copy_pixel_rows (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo,
 		 JDIMENSION rows_supplied)
 {
@@ -125,7 +125,7 @@
  * We have to demap the color index values to straight data.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 put_demapped_rgb (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo,
 		  JDIMENSION rows_supplied)
 {
@@ -150,7 +150,7 @@
 }
 
 
-METHODDEF(void)
+JMETHODDEF(void)
 put_demapped_gray (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo,
 		   JDIMENSION rows_supplied)
 {
@@ -173,7 +173,7 @@
  * Startup: write the file header.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_output_ppm (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo)
 {
   ppm_dest_ptr dest = (ppm_dest_ptr) dinfo;
@@ -202,7 +202,7 @@
  * Finish up at the end of the file.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_output_ppm (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo)
 {
   /* Make sure we wrote the output file OK */
@@ -216,7 +216,7 @@
  * The module selection routine for PPM format output.
  */
 
-GLOBAL(djpeg_dest_ptr)
+JGLOBAL(djpeg_dest_ptr)
 jinit_write_ppm (j_decompress_ptr cinfo)
 {
   ppm_dest_ptr dest;
--- wrrle.c.orig	1996-01-06 17:32:50.000000000 +0000
+++ wrrle.c	2011-01-05 21:55:16.000000000 +0000
@@ -62,7 +62,7 @@
 typedef rle_dest_struct * rle_dest_ptr;
 
 /* Forward declarations */
-METHODDEF(void) rle_put_pixel_rows
+JMETHODDEF(void) rle_put_pixel_rows
     JPP((j_decompress_ptr cinfo, djpeg_dest_ptr dinfo,
 	 JDIMENSION rows_supplied));
 
@@ -73,7 +73,7 @@
  * In this module it's easier to wait till finish_output to write anything.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_output_rle (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo)
 {
   rle_dest_ptr dest = (rle_dest_ptr) dinfo;
@@ -149,7 +149,7 @@
  * This routine just saves the data away in a virtual array.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 rle_put_pixel_rows (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo,
 		    JDIMENSION rows_supplied)
 {
@@ -168,7 +168,7 @@
  * Here is where we really output the RLE file.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_output_rle (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo)
 {
   rle_dest_ptr dest = (rle_dest_ptr) dinfo;
@@ -273,7 +273,7 @@
  * The module selection routine for RLE format output.
  */
 
-GLOBAL(djpeg_dest_ptr)
+JGLOBAL(djpeg_dest_ptr)
 jinit_write_rle (j_decompress_ptr cinfo)
 {
   rle_dest_ptr dest;
--- wrtarga.c.orig	1996-01-06 17:32:54.000000000 +0000
+++ wrtarga.c	2011-01-05 21:55:16.000000000 +0000
@@ -50,7 +50,7 @@
 typedef tga_dest_struct * tga_dest_ptr;
 
 
-LOCAL(void)
+JLOCAL(void)
 write_header (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo, int num_colors)
 /* Create and write a Targa header */
 {
@@ -95,7 +95,7 @@
  * In this module rows_supplied will always be 1.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 put_pixel_rows (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo,
 		JDIMENSION rows_supplied)
 /* used for unquantized full-color output */
@@ -116,7 +116,7 @@
   (void) JFWRITE(dest->pub.output_file, dest->iobuffer, dest->buffer_width);
 }
 
-METHODDEF(void)
+JMETHODDEF(void)
 put_gray_rows (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo,
 	       JDIMENSION rows_supplied)
 /* used for grayscale OR quantized color output */
@@ -140,7 +140,7 @@
  * For Targa, this is only applied to grayscale data.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 put_demapped_gray (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo,
 		   JDIMENSION rows_supplied)
 {
@@ -163,7 +163,7 @@
  * Startup: write the file header.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 start_output_tga (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo)
 {
   tga_dest_ptr dest = (tga_dest_ptr) dinfo;
@@ -207,7 +207,7 @@
  * Finish up at the end of the file.
  */
 
-METHODDEF(void)
+JMETHODDEF(void)
 finish_output_tga (j_decompress_ptr cinfo, djpeg_dest_ptr dinfo)
 {
   /* Make sure we wrote the output file OK */
@@ -221,7 +221,7 @@
  * The module selection routine for Targa format output.
  */
 
-GLOBAL(djpeg_dest_ptr)
+JGLOBAL(djpeg_dest_ptr)
 jinit_write_targa (j_decompress_ptr cinfo)
 {
   tga_dest_ptr dest;
