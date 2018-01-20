From cf7a9bcb04858a3a694cc64ccd440dd560bfc7a9 Mon Sep 17 00:00:00 2001
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Fri, 14 Nov 2014 20:03:56 +0100
Subject: [PATCH 2/9] Added new function attribute "lineartags" and pragma
 "amigaos tagtype".

Functions that have the lineartags attribute are assumed to be functions
with tags, in which case type checking is now enabled. That is, the value
that follow a specific tag is assumed to be a certain type. If this is
not the case, the compiler will warn.

The compiler can be taught about that types via the new pragma
#pragma amigaos tagtype(TYPE)
which is written before an "enum" or a "static const int" that defines
the number of the tag.

For instance:

#pragma amigaos tagtype(struct Screen *)
static const int WA_CustomScreen = WA_Dummy + 0x0D;

 or

#pragma amigaos tagtype(struct Screen *)
enum {WA_CustomScreen = WA_Dummy + 0x0D};

is possible now.

It is not very robust yet wrt to catching misuses of the new feature.
For instance, no check is done that the attribute is applied to varargs
functions.
---
 gcc/c-family/c-pragma.c            |  10 +++
 gcc/c/c-parser.c                   | 129 +++++++++++++++++++++++++++++++++++++
 gcc/c/c-typeck.c                   |  24 +++++++
 gcc/config/rs6000/amigaos-protos.h |   1 +
 gcc/config/rs6000/amigaos.c        |   7 ++
 5 files changed, 171 insertions(+)

diff --git a/gcc/c-family/c-pragma.c b/gcc/c-family/c-pragma.c
index c73aa8221049b85949b0b62e88f58120e43aa39d..6cda91994f9140398841610063c297735b797863 100644
--- gcc/c-family/c-pragma.c
+++ gcc/c-family/c-pragma.c
@@ -1124,12 +1124,21 @@ handle_pragma_message (cpp_reader *ARG_UNUSED(dummy))
     warning (OPT_Wpragmas, "junk at end of %<#pragma message%>");
 
   if (TREE_STRING_LENGTH (message) > 1)
     inform (input_location, "#pragma message: %s", TREE_STRING_POINTER (message));
 }
 
+/* This is queried by the invoker of the handler */
+int was_tagtypepragma;
+/* Tagtype pragma */
+static void
+handle_pragma_tagtype (cpp_reader *reader)
+{
+  was_tagtypepragma = 1;
+}
+
 /* Mark whether the current location is valid for a STDC pragma.  */
 
 static bool valid_location_for_stdc_pragma;
 
 void
 mark_valid_location_for_stdc_pragma (bool flag)
@@ -1555,12 +1564,13 @@ init_pragma (void)
 
   c_register_pragma_with_expansion (0, "redefine_extname",
 				    handle_pragma_redefine_extname);
 
   c_register_pragma_with_expansion (0, "message", handle_pragma_message);
 
+  c_register_pragma_with_expansion ("amigaos", "tagtype", handle_pragma_tagtype);
 #ifdef REGISTER_TARGET_PRAGMAS
   REGISTER_TARGET_PRAGMAS ();
 #endif
 
   global_sso = default_sso;
   c_register_pragma (0, "scalar_storage_order", 
diff --git a/gcc/c/c-parser.c b/gcc/c/c-parser.c
index 1b6bacd7498fb8ec37dc4b76bcfa26eacc1c8e1b..60eecd4854780322205cee5d47727d3376a6c9eb 100644
--- gcc/c/c-parser.c
+++ gcc/c/c-parser.c
@@ -84,12 +84,74 @@ set_c_expr_source_range (c_expr *expr,
 {
   expr->src_range = src_range;
   if (expr->value)
     set_source_range (expr->value, src_range);
 }
 
+static htab_t amigaos_tagdecl_to_type;
+
+struct amigaos_hash_type
+{
+  tree decl;
+  tree type;
+};
+
+static hashval_t
+amigaos_hash_descriptor (const void *p)
+{
+  return htab_hash_pointer (((const amigaos_hash_type *)p)->decl);
+}
+
+static int
+amigaos_eq_descriptor (const void *p1, const void *p2)
+{
+  return ((const amigaos_hash_type *)p1)->decl == ((const amigaos_hash_type *)p2)->decl;
+}
+
+/**
+ * Returns the tag type that is associated with the given type.
+ *
+ * @param type
+ * @return
+ */
+tree amigaos_get_type_associated_tagtype(tree decl)
+{
+  amigaos_hash_type aht = {decl, 0};
+  amigaos_hash_type *faht;
+
+  if (!amigaos_tagdecl_to_type)
+    return NULL;
+
+  faht = (amigaos_hash_type *)htab_find(amigaos_tagdecl_to_type, &aht);
+  if (!faht)
+    return NULL;
+  return faht->type;
+}
+
+static void amigaos_put_type_associated_tagtype(tree decl, tree type)
+{
+  gcc_assert(decl);
+
+  if (!amigaos_tagdecl_to_type)
+    amigaos_tagdecl_to_type = htab_create (10, amigaos_hash_descriptor, amigaos_eq_descriptor, NULL);
+
+  amigaos_hash_type *aht = (amigaos_hash_type *)xmalloc(sizeof(*aht));
+  aht->decl = decl;
+  aht->type = type;
+
+  void **pentry = htab_find_slot (amigaos_tagdecl_to_type, aht, INSERT);
+  gcc_assert(pentry);
+  gcc_assert(*pentry == NULL);
+  *pentry = aht;
+}
+
+/**
+ * Contains the tagtype that is currently processed or NULL_TREE
+ * if no tagtype is processed.
+ */
+static tree amigaos_current_tagtype;
 
 /* Initialization routine for this file.  */
 
 void
 c_parse_init (void)
 {
@@ -2514,12 +2576,15 @@ c_parser_declspecs (c_parser *parser, struct c_declspecs *specs,
 	    goto out;
 	  attrs_ok = true;
 	  seen_type = true;
 	  t = c_parser_enum_specifier (parser);
           invoke_plugin_callbacks (PLUGIN_FINISH_TYPE, t.spec);
 	  declspecs_add_type (loc, specs, t);
+	  /* Handle special tagtype enhanced enums */
+	  if (amigaos_current_tagtype != NULL_TREE && t.spec != NULL_TREE)
+	    amigaos_put_type_associated_tagtype(t.spec, amigaos_current_tagtype);
 	  break;
 	case RID_STRUCT:
 	case RID_UNION:
 	  if (!typespec_ok)
 	    goto out;
 	  attrs_ok = true;
@@ -10011,12 +10076,32 @@ c_parser_objc_at_dynamic_declaration (c_parser *parser)
     }
   c_parser_skip_until_found (parser, CPP_SEMICOLON, "expected %<;%>");
   objc_add_dynamic_declaration (loc, list);
 }
 
 
+/**
+ * This function is called whenever a declaration was finished that was preceded
+ * by a tagtype pragma.
+ *
+ * @param gcc_data will be the finished declaration
+ * @param user_data will be the parsed c type of the declaration (c_type_name *)
+ *  that was specified ahead of the declaration via the pragma.
+ */
+static void amigaos_tagtype_finish_decl_callback (void *gcc_data, void *user_data)
+{
+  tree decl = (tree)gcc_data;
+  c_type_name *ctype = (c_type_name*)user_data;
+  tree type = groktypename (ctype, NULL, NULL);
+
+  /* TODO: All sorts of checks */
+
+  /* Now put the association in our own hash table */
+  amigaos_put_type_associated_tagtype(decl, type);
+}
+
 /* Handle pragmas.  Some OpenMP pragmas are associated with, and therefore
    should be considered, statements.  ALLOW_STMT is true if we're within
    the context of a function and such pragmas are to be allowed.  Returns
    true if we actually parsed such a pragma.  */
 
 static bool
@@ -10210,12 +10295,56 @@ c_parser_pragma (c_parser *parser, enum pragma_context context, bool *if_p)
       break;
     }
 
   c_parser_consume_pragma (parser);
   c_invoke_pragma_handler (id);
 
+  /* If was_tagtypepragma is set, the pragma was a tagtype one,
+   * which, at the moment, cannot easily handled outside of this
+   * file.
+   */
+  extern int was_tagtypepragma;
+  if (was_tagtypepragma)
+  {
+    c_token *tok = c_parser_peek_token (the_parser);
+    enum cpp_ttype ret = tok->type;
+    c_parser_consume_token(parser);
+
+    c_type_name *ctype = c_parser_type_name(parser);
+    tree ctypetree = groktypename (ctype, NULL, NULL);
+
+    /* Make the parsed type available to all functions called from here on */
+    amigaos_current_tagtype = ctypetree;
+
+    tok = c_parser_peek_token (the_parser);
+    ret = tok->type;
+    c_parser_consume_token(parser);
+    c_parser_skip_to_pragma_eol(parser);
+
+    tok = c_parser_peek_token (the_parser);
+    ret = tok->type;
+
+    /* Parse the line that follows. We will register for a PLUGIN_FINISH_DECL event
+     * to minimize contermination
+     */
+    bool old_flag_plugin_added = flag_plugin_added;
+    register_callback ("amigaos-tagtype", PLUGIN_FINISH_DECL,
+                       amigaos_tagtype_finish_decl_callback,
+                       ctype);
+    flag_plugin_added = 1;
+    c_parser_declaration_or_fndef(parser, false, false, true, false, true, NULL, vNULL);
+    unregister_callback ("amigaos-tagtype", PLUGIN_FINISH_DECL);
+    flag_plugin_added = old_flag_plugin_added;
+    /* Reset the variable that is set in the pragma handler */
+    was_tagtypepragma = 0;
+    /* The tagtype has been processed */
+    amigaos_current_tagtype = NULL_TREE;
+    return false;
+  }
+
+
   /* Skip to EOL, but suppress any error message.  Those will have been
      generated by the handler routine through calling error, as opposed
      to calling c_parser_error.  */
   parser->error = true;
   c_parser_skip_to_pragma_eol (parser);
 
diff --git a/gcc/c/c-typeck.c b/gcc/c/c-typeck.c
index b1c5cd6d3db3bd6d21185bcb49af14d9bfc83d12..ebb7f5741007c6769e4af94c3c6b856af305132c 100644
--- gcc/c/c-typeck.c
+++ gcc/c/c-typeck.c
@@ -3169,12 +3169,14 @@ convert_arguments (location_t loc, vec<location_t> arg_loc, tree typelist,
   unsigned int parmnum;
   bool error_args = false;
   const bool type_generic = fundecl
     && lookup_attribute ("type generic", TYPE_ATTRIBUTES (TREE_TYPE (fundecl)));
   bool type_generic_remove_excess_precision = false;
   tree selector;
+  const bool lineartags = fundecl
+    && lookup_attribute ("lineartags", TYPE_ATTRIBUTES (TREE_TYPE (fundecl)));
 
   /* Change pointer to function to the function itself for
      diagnostics.  */
   if (TREE_CODE (function) == ADDR_EXPR
       && TREE_CODE (TREE_OPERAND (function, 0)) == FUNCTION_DECL)
     function = TREE_OPERAND (function, 0);
@@ -3208,12 +3210,14 @@ convert_arguments (location_t loc, vec<location_t> arg_loc, tree typelist,
   if (flag_cilkplus && fundecl && is_cilkplus_reduce_builtin (fundecl))
     return vec_safe_length (values);
 
   /* Scan the given expressions and types, producing individual
      converted arguments.  */
 
+  tree prev_tagtype = NULL_TREE;
+
   for (typetail = typelist, parmnum = 0;
        values && values->iterate (parmnum, &val);
        ++parmnum)
     {
       tree type = typetail ? TREE_VALUE (typetail) : 0;
       tree valtype = TREE_TYPE (val);
@@ -3262,12 +3266,32 @@ convert_arguments (location_t loc, vec<location_t> arg_loc, tree typelist,
 	}
       val = c_fully_fold (val, false, NULL);
       STRIP_TYPE_NOPS (val);
 
       val = require_complete_type (val);
 
+      /* If this is a function call with linear tags try to improve the expected
+       * type on base of recorded tag <-> type mapping.
+       */
+      if (lineartags && type == 0)
+        {
+          extern tree amigaos_get_type_associated_tagtype(tree type);
+
+          if (prev_tagtype)
+            {
+              type = prev_tagtype;
+              prev_tagtype = NULL_TREE;
+            }
+          else
+            {
+              prev_tagtype = amigaos_get_type_associated_tagtype(val);
+              if (!prev_tagtype)
+                prev_tagtype = amigaos_get_type_associated_tagtype((*origtypes)[parmnum]);
+            }
+        }
+
       if (type != 0)
 	{
 	  /* Formal parm type is specified by a function prototype.  */
 
 	  if (type == error_mark_node || !COMPLETE_TYPE_P (type))
 	    {
diff --git a/gcc/config/rs6000/amigaos-protos.h b/gcc/config/rs6000/amigaos-protos.h
index eb5f8fc5f3d546b8d8e1cdd8118a3085079df50e..3b8c994cdbd192eaf7112c780f0106a4d96cbb90 100644
--- gcc/config/rs6000/amigaos-protos.h
+++ gcc/config/rs6000/amigaos-protos.h
@@ -27,12 +27,13 @@ extern void amigaos_function_arg_advance (CUMULATIVE_ARGS *, enum machine_mode,
 extern struct rtx_def *amigaos_function_arg (CUMULATIVE_ARGS *, enum machine_mode, tree, int);
 extern void amigaos_expand_builtin_va_start (tree valist, rtx nextarg);
 extern struct rtx_def *amigaos_expand_builtin_saveregs (void);
 extern void amigaos_init_builtins (void);
 extern rtx amigaos_expand_builtin (tree, rtx, rtx, enum machine_mode, int, bool*);
 extern tree amigaos_handle_linearvarargs_attribute (tree *, tree, tree, int, bool*);
+extern tree amigaos_handle_lineartags_attribute (tree *, tree, tree, int, bool*);
 extern tree amigaos_handle_baserel_restore_attribute (tree *, tree, tree, int, bool*);
 extern tree amigaos_handle_force_no_baserel_attribute (tree *, tree, tree, int, bool*);
 extern tree amigaos_handle_check68kfuncptr_attribute (tree *, tree, tree, int, bool*);
 extern rtx amigaos_legitimize_baserel_address (rtx addr);
 extern int amigaos_baserel_operand(rtx x);
 extern int amigaos_not_baserel_tree_p(tree decl);
diff --git a/gcc/config/rs6000/amigaos.c b/gcc/config/rs6000/amigaos.c
index a6da7d543241e2fc8cf51a952633c62e19d7d875..797261177e46a34ac0aba97f2b9c2b8af8df2e72 100644
--- gcc/config/rs6000/amigaos.c
+++ gcc/config/rs6000/amigaos.c
@@ -342,12 +342,19 @@ amigaos_handle_linearvarargs_attribute (tree *node, tree name,
       *no_add_attrs = true;
     }
 
   return NULL_TREE;
 }
 
+tree
+amigaos_handle_lineartags_attribute (tree *node, tree name, tree args, int flags, bool *no_add_attrs)
+{
+  /* TODO: This function should applied only to functions or methods */
+  return NULL_TREE;
+}
+
 
 /* Generate code for base relative access */
 
 rtx
 amigaos_legitimize_baserel_address (rtx addr)
 {
-- 
1.9.1

