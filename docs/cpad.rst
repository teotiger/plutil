CPAD Function
=============

This function returns the passed string surrounded to the specified length with the specified character. If the string can not be centered exactly in the middle, the total length is reduced by one.

Syntax
------

.. code-block:: SQL

  PLUTIL.CPAD (
    a_string  IN  VARCHAR2,
    a_length  IN  NUMBER,
    a_char    IN  VARCHAR2)
  RETURN VARCHAR2;

Parameter
---------

===================== =====================
Parameter             Description
===================== =====================
A_STRING              The string to surround by a character.
A_LENGTH              The total length of the returned expression.
A_CHAR                The character to surround the passed the string.
===================== =====================

