SPLIT_TO_LIST Function
======================

This functions splits a string into a varray. Each element can have a length of max. 32767 chars.

Syntax
------

.. code-block:: SQL

  PLUTIL.SPLIT_TO_LIST (
      a_string          IN VARCHAR2,
      a_delimiter       IN VARCHAR2,
      a_enclosure       IN VARCHAR2,
      a_trim_enclosure  IN BOOLEAN)
    RETURN SYS.DBMSOUTPUT_LINESARRAY DETERMINISTIC;;

Parameter
---------

===================== =====================
Parameter             Description
===================== =====================
A_STRING              A (character-delimited) text.
A_DELIMITER           One char length delimiter.
A_ENCLOSURE           An optional enclosure char.
A_TRIM_ENCLOSURE      Remove the enclosure from element if true.
===================== =====================

