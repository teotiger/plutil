RGB_TO_HEX Function
===================

This function converts RGB color values into a hexadecimal color value.

Syntax
------

.. code-block:: SQL

  PLUTIL.RGB_TO_HEX (
    a_red    IN  NUMBER,
    a_green  IN  NUMBER,
    a_blue   IN  NUMBER)
  RETURN VARCHAR2;    

Parameter
---------

===================== =====================
Parameter             Description
===================== =====================
A_RED                 A valid value between 0 and 255 for the red color.
A_GREEN               A valid value between 0 and 255 for the green color.
A_BLUE                A valid value between 0 and 255 for the blue color.
===================== =====================

