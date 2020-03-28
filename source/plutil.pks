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
  subtype unsigned_int8 is binary_integer range 0..255 not null;
  subtype unsigned_octet is unsigned_int8;
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
  -- This function converts a (UTC) date into the unix timestamp (number of 
  -- seconds since the unix epoch time on January 1st, 1970).
  -- @A date greater than January 1st, 1970.
  function date_to_unix_timestamp(
      a_date in date)
    return number deterministic;  
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
  -- This function formats the number of bytes. Base is 2.
  -- @The number of bytes.
  function format_bytes_binary(
      a_bytes in number)
    return varchar2 deterministic;  
  -- This function formats the number of bytes. Base is 10.
  -- @The number of bytes.
  function format_bytes_decimal(
      a_bytes in number)
    return varchar2 deterministic;  
  -- This function formats the number of seconds.
  -- @The number of seconds.
  function format_seconds(
      a_seconds in number)
    return varchar2 deterministic;
  -- This function converts a hexadecimal color value into RGB color values.
  -- @A valid hexadecimal color value.
  function hex_to_rgb(
      a_hex in varchar2) 
    return varchar2 deterministic;
  -- This function checks if the date is a leap year or not.
  -- @The date to check.
  function is_leap_year(
      a_date in date)
    return boolean deterministic;
  -- This function checks if the year is a leap year or not.
  -- @The year in the format YYYY.
  function is_leap_year(
      a_year in pls_integer)
    return boolean deterministic;
  -- This function converts RGB color values into a hexadecimal color value.
  -- @A valid value between 0 and 255 for the red color.
  -- @A valid value between 0 and 255 for the green color.
  -- @A valid value between 0 and 255 for the blue color.
  function rgb_to_hex(
      a_red   in number,
      a_green in number,
      a_blue  in number) 
    return varchar2 deterministic;
  -- This functions splits a string into a varray. Each element can have a
  -- length of max. 32767 chars.
  -- @A (character-delimited) text.
  -- @One char length delimiter.
  -- @An optional enclosure char.
  -- @Remove the enclosure from element if true.
  function split_to_list(
      a_text_value      in varchar2,
      a_delimiter       in varchar2,
      a_enclosure       in varchar2,
      a_trim_enclosure  in boolean)
    return sys.dbmsoutput_linesarray deterministic;
  -- This functions splits a string into a nested table. Each element can have a
  -- length of max. 4000 chars (splitted value may be trimmed).
  -- @A (character-delimited) text.
  -- @A one char length delimiter.
  -- @An optional enclosure char.
  -- @Remove the enclosure from element if true.
  function split_tt(
      a_text_value      in varchar2,
      a_delimiter       in varchar2,
      a_enclosure       in varchar2,
      a_trim_enclosure  in bool)
    return sys.ora_mining_varchar2_nt pipelined deterministic;
  -- This function converts the unix timestamp (number of seconds since the 
  -- unix epoch time on January 1st, 1970) to a valid (UTC) date.
  -- @The number of seconds.
  function unix_timestamp_to_date(
      a_unix_timestamp in number)
    return date deterministic;
end plutil;
/
