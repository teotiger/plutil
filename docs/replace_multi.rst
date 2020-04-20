REPLACE_MULTI Function (1)
==========================

Replace string '#1#', '#2#' ... '#n#' with element n from the collection.

Syntax
------

.. code-block:: SQL

  PLUTIL.REPLACE_MULTI (
    a_string           IN  VARCHAR2,
    a_replace_strings  IN  SYS.DBMSOUTPUT_LINESARRAY)
  RETURN CLOB;

Parameter
---------

===================== =====================
Parameter             Description
===================== =====================
A_STRING              A text with placeholders.
A_REPLACE_STRINGS     A list of replace strings.
===================== =====================

