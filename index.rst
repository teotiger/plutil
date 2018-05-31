PLUTIL PL/SQL Package Reference
===============================

Contents:

.. toctree::
    :maxdepth: 2


PLUTIL
======


FgUNCTION CPAD
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

FUNCTION CURRENT_CHARSET
------------------------

This function returns the current charset.

Syntax
``````

.. code-block:: SQL

  PLUTIL.CURRENT_CHARSET
  
  RETURN VARCHAR2;

FUNCTION CURRENT_ISO_LANGUAGE
-----------------------------

This function returns the current iso language (ISO-3166).

Syntax
``````

.. code-block:: SQL

  PLUTIL.CURRENT_ISO_LANGUAGE
  
  RETURN VARCHAR2;

FUNCTION CURRENT_ISO_LOCALE
---------------------------

This function returns the current iso locale (ISO-3166).

Syntax
``````

.. code-block:: SQL

  PLUTIL.CURRENT_ISO_LOCALE
  
  RETURN VARCHAR2;

FUNCTION DAYS_IN_MONTH
----------------------

This function returns the number of days in the month.

Syntax
``````

.. code-block:: SQL

  PLUTIL.DAYS_IN_MONTH (
    p_month  IN  DATE)
  RETURN NUMBER;

Parameters
``````````

=========== ===========
Parameter   Descripción
=========== ===========
P_MONTH     The date to check.
=========== ===========

FUNCTION DAYS_IN_YEAR
---------------------

This function returns the number of days in the year.

Syntax
``````

.. code-block:: SQL

  PLUTIL.DAYS_IN_YEAR (
    p_year  IN  DATE)
  RETURN NUMBER;

Parameters
``````````

=========== ===========
Parameter   Descripción
=========== ===========
P_YEAR      The date to check.
=========== ===========

FUNCTION DAYS_IN_YEAR
---------------------

This function returns the number of days in the year.

Syntax
``````

.. code-block:: SQL

  PLUTIL.DAYS_IN_YEAR (
    p_year  IN  NUMBER)
  RETURN NUMBER;

Parameters
``````````

=========== ===========
Parameter   Descripción
=========== ===========
P_YEAR      The year in the format YYYY.
=========== ===========

FUNCTION FORMAT_SECONDS
-----------------------

This function formats the number of seconds.

Syntax
``````

.. code-block:: SQL

  PLUTIL.FORMAT_SECONDS (
    p_seconds  IN  NUMBER)
  RETURN VARCHAR2;

Parameters
``````````

=========== ===========
Parameter   Descripción
=========== ===========
P_SECONDS   The number of seconds.
=========== ===========

FUNCTION IS_LEAP_YEAR
---------------------

This function checks if the date is a leap year or not.

Syntax
``````

.. code-block:: SQL

  PLUTIL.IS_LEAP_YEAR (
    p_year  IN  DATE)
  RETURN PL/SQL BOOLEAN;

Parameters
``````````

=========== ===========
Parameter   Descripción
=========== ===========
P_YEAR      The date to check.
=========== ===========

FUNCTION IS_LEAP_YEAR
---------------------

This function checks if the year is a leap year or not.

Syntax
``````

.. code-block:: SQL

  PLUTIL.IS_LEAP_YEAR (
    p_year  IN  BINARY_INTEGER)
  RETURN PL/SQL BOOLEAN;

Parameters
``````````

=========== ===========
Parameter   Descripción
=========== ===========
P_YEAR      The year in the format YYYY.
=========== ===========
