UNIX_TIMESTAMP_TO_DATE Function
===============================

This function converts the unix timestamp (number of seconds since the unix epoch time on January 1st, 1970) to a valid (UTC) date.

Syntax
------

.. code-block:: SQL

  PLUTIL.UNIX_TIMESTAMP_TO_DATE (
    a_unix_timestamp  IN  NUMBER)
  RETURN DATE;

Parameter
---------

===================== =====================
Parameter             Description
===================== =====================
A_UNIX_TIMESTAMP      The number of seconds.
===================== =====================

