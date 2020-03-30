SPLIT_TT Function
=================

This functions splits a string into a nested table. Each element can have a length of max. 4000 chars.

Syntax
------

.. code-block:: SQL

  PLUTIL.SPLIT_TT (
      a_string          IN VARCHAR2,
      a_delimiter       IN VARCHAR2,
      a_enclosure       IN VARCHAR2,
      a_trim_enclosure  IN BOOL)
    RETURN SYS.ORA_MINING_VARCHAR2_NT DETERMINISTIC;;

Parameter
---------

===================== =====================
Parameter             Description
===================== =====================
A_STRING              A (character-delimited) text.
A_DELIMITER           One char length delimiter.
A_ENCLOSURE           An optional enclosure char.
A_TRIM_ENCLOSURE      Remove the enclosure from element if 1.
===================== =====================

