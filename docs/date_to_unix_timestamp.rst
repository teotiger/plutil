DATE_TO_UNIX_TIMESTAMP Function
===============================

This function converts a (UTC) date into the unix timestamp (number of seconds since the unix epoch time on January 1st, 1970).

Syntax
------

.. code-block:: SQL

  PLUTIL.DATE_TO_UNIX_TIMESTAMP (
    a_date  IN  DATE)
  RETURN NUMBER;

Parameter
---------

===================== =====================
Parameter             Description
===================== =====================
A_DATE                A date greater than January 1st, 1970.
===================== =====================

