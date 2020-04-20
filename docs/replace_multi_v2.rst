REPLACE_MULTI Function (2)
==========================

Replace string '#1#', '#2#' ... '#n#' with element n from the collection.

Syntax
------

.. code-block:: SQL

  PLUTIL.REPLACE_MULTI (
    a_string           IN  VARCHAR2,
    a_replace_strings  IN  SYS.ORA_MINING_VARCHAR2_NT)
  RETURN VARCHAR2;

Parameter
---------

===================== =====================
Parameter             Description
===================== =====================
A_STRING              A text with placeholders.
A_REPLACE_STRINGS     A list of replace strings.
===================== =====================

