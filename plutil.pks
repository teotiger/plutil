CREATE OR REPLACE package plutil authid current_user
as
  /****************************************************************************
  *** DATA TYPES
  ****************************************************************************/
  subtype varchar2_xs is varchar2(1 char);      -- (2^1)-1
  subtype varchar2_s is varchar2(30 char);      -- (2^5)-2 oracle object length
  subtype varchar2_m is varchar2(256 char);     -- (2^8)
  subtype varchar2_l is varchar2(4000 char);    -- (2^12)-96  max. SQL  4000
  subtype varchar2_xl is varchar2(32767 char);  -- (2^15)-1   max. PLSQL
  subtype vc2_xs is varchar2_xs;
  subtype vc2_s is varchar2_s;
  subtype vc2_m is varchar2_m;
  subtype vc2_l is varchar2_l;
  subtype vc2_xl is varchar2_xl;
  subtype bool is binary_integer range 0..1;
  /****************************************************************************
  *** COLLECTION TYPES
  ****************************************************************************/
  type t_number_aa is table of number index by vc2_m;
  type t_integer_aa is table of integer index by vc2_m;
  type t_int_aa is table of integer index by vc2_m;
  type t_date_aa is table of date index by vc2_m;
  type t_varchar2_aa is table of vc2_xl index by vc2_m;
  type t_vc2_aa is table of vc2_xl index by vc2_m;
  type t_clob_aa is table of clob index by vc2_m;
  type t_blob_aa is table of blob index by vc2_m;
  /****************************************************************************
  *** SUBPROGRAMS
  ****************************************************************************/
  -- This function returns the current charset.
  function current_charset
    return varchar2 deterministic;
  -- This function returns the current iso language (ISO-3166).
  function current_iso_language
    return varchar2 deterministic;
  -- This function returns the current iso locale (ISO-3166).
  function current_iso_locale
    return varchar2 deterministic;
  -- This function returns the number of days in the year.
  -- @The date to check.
  function days_in_year(
      p_year in date)
    return integer deterministic;
  -- This function returns the number of days in the year.
  -- @The year in the format YYYY.
  function days_in_year(
      p_year in integer)
    return integer deterministic;
  -- This function checks if the date is a leap year or not.
  -- @The date to check.
  function is_leap_year(
      p_year in date)
    return boolean deterministic;
  -- This function checks if the year is a leap year or not.
  -- @The year in the format YYYY.
  function is_leap_year(
      p_year in pls_integer)
    return boolean deterministic;
end plutil;
/

