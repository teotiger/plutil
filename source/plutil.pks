create or replace package plutil authid current_user
as
  /****************************************************************************
  *** DATA TYPES
  ****************************************************************************/
  subtype varchar2_xs is varchar2(1 char);      -- (2^1)-1
  subtype varchar2_s is varchar2(30 char);      -- (2^5)-2 oracle object length
  subtype varchar2_m is varchar2(255 char);     -- (2^8)-1
  subtype varchar2_l is varchar2(4000 char);    -- (2^12)-96  max. SQL  4000
  subtype varchar2_xl is varchar2(32767 char);  -- (2^15)-1   max. PLSQL
  subtype vc2_xs is varchar2_xs;
  subtype vc2_s is varchar2_s;
  subtype vc2_m is varchar2_m;
  subtype vc2_l is varchar2_l;
  subtype vc2_xl is varchar2_xl;
  subtype vc_xs is varchar2_xs;
  subtype vc_s is varchar2_s;
  subtype vc_m is varchar2_m;
  subtype vc_l is varchar2_l;
  subtype vc_xl is varchar2_xl;
  subtype bool is binary_integer range 0..1 not null;
  /****************************************************************************
  *** COLLECTION TYPES
  ****************************************************************************/
  type number_aa is table of number index by vc2_m;
  type integer_aa is table of integer index by vc2_m;
  type int_aa is table of integer index by vc2_m;
  type date_aa is table of date index by vc2_m;
  type varchar2_aa is table of vc2_xl index by vc2_m;
  type vc2_aa is table of vc2_xl index by vc2_m;
  type clob_aa is table of clob index by vc2_m;
  type blob_aa is table of blob index by vc2_m;
  /****************************************************************************
  *** SUBPROGRAMS
  ****************************************************************************/
  -- This function returns the passed string surrounded to the specified length
  -- with the specified character. If the string can not be centered exactly in
  -- the middle, the total length is reduced by one.
  -- @The string to surround by a character.
  -- @The total length of the returned expression.
  -- @The character to surround the passed the string.
  function cpad(
      a_string in varchar2,
      a_length in integer,
      a_char   in varchar2)
    return varchar2 deterministic;
  -- This function returns the current charset.
  function current_charset
    return varchar2 deterministic;
  -- This function returns the current iso language (ISO-3166).
  function current_iso_language
    return varchar2 deterministic;
  -- This function returns the current iso locale (ISO-3166).
  function current_iso_locale
    return varchar2 deterministic;
  -- This function returns the number of days in the month.
  -- @The date to check.
  function days_in_month(
      a_month in date)
    return integer deterministic;
  -- This function returns the number of days in the year.
  -- @The date to check.
  function days_in_year(
      a_year in date)
    return integer deterministic;
  -- This function returns the number of days in the year.
  -- @The year in the format YYYY.
  function days_in_year(
      a_year in integer)
    return integer deterministic;
  -- This function formats the number of bytes.
  -- @The number of bytes.
  -- @The base. Must be 2 (default) or 10. If not, base 2 is used.
  function format_bytes(
      a_bytes in number,
      a_base  in number default 2)
    return varchar2 deterministic;  
  -- This function formats the number of seconds.
  -- @The number of seconds.
  function format_seconds(
      a_seconds in number)
    return varchar2 deterministic;
  -- This function checks if the date is a leap year or not.
  -- @The date to check.
  function is_leap_year(
      a_year in date)
    return boolean deterministic;
  -- This function checks if the year is a leap year or not.
  -- @The year in the format YYYY.
  function is_leap_year(
      a_year in pls_integer)
    return boolean deterministic;
end plutil;
/