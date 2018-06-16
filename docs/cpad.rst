PLUTIL PL/SQL Package Reference
===============================

.. contents:: PLUtil API Reference

FiUNCTION CPAD
-------------

This function returns the passed string surrounded to the specified length with the specified character. If the string can not be centered exactly in the middle, the total length is reduced by one.

Syntax
``````

.. code-block:: SQL

  PLUTIL.CPAD (
    p_string  IN  VARCHAR2,
    p_length  IN  NUMBER,
    p_char    IN  VARCHAR2)
  RETURN VARCHAR2;

Parameters
``````````

=========== ===========
Parameter   Descripción
=========== ===========
P_STRING    The string to surround by a character.
P_LENGTH    The total length of the returned expression.
P_CHAR      The character to surround the passed the string.
=========== ===========
