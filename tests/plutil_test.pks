create or replace package plutil_test authid definer as

  -- %suite(UnitTests for PLUTIL functions)

--cpad
--current_charset
--current_iso_language
--current_iso_locale

  -- %test(DATE_TO_UNIX_TIMESTAMP returns 1 for 01.01.1970 00:00:00 UTC.)
  procedure date_to_unix_timestamp_min;

  -- %test(DAYS_IN_MONTH returns 31 for january.)
  procedure days_in_month_jan;

  -- %test(DAYS_IN_YEAR returns 366 days because 1996 is a leap year.)
  procedure days_in_year_1996;

  -- %test(DAYS_IN_YEAR returns 365 days because 1998 is not a leap year.)
  procedure days_in_year_1998;

  -- %test(DAYS_IN_YEAR returns 365 days because 1999 is not a leap year.)
  procedure days_in_year_1999;

  -- %test(DAYS_IN_YEAR returns 366 days because 2000 is a leap year.)
  procedure days_in_year_2000;

  -- %test(DAYS_IN_YEAR returns 366 days because 1600 is a leap year.)
  procedure days_in_year_1600;

  -- %test(DAYS_IN_YEAR returns 365 days because 1900 is not a leap year.)
  procedure days_in_year_1900;

  -- %test(DAYS_IN_YEAR returns 366 days because 1904 is a leap year.)
  procedure days_in_year_1904;

  -- %test(DAYS_IN_YEAR returns 365 days because 1800 is not a leap year.)
  procedure days_in_year_1800;

  -- %test(FORMAT_BYTES_BINARY returns 1,7KiB for 1704 bytes.)
  procedure format_bytes_binary_small;

  -- %test(FORMAT_BYTES_BINARY returns 1GiB for 1024^3.)
  procedure format_bytes_binary_big;

  -- %test(FORMAT_BYTES_DECIMAL returns 1,7kB for 1704 bytes.)
  procedure format_bytes_decimal_small;

  -- %test(FORMAT_BYTES_DECIMAL returns 1,1GB for 1024^3.)
  procedure format_bytes_decimal_big;

  -- %test(FORMAT_SECONDS returns 00:59 for 59 seconds.)
  procedure format_seconds_59;

  -- %test(FORMAT_SECONDS returns 01:00 for 60 seconds.)
  procedure format_seconds_60;

  -- %test(FORMAT_SECONDS returns 01:01 for 61 seconds.)
  procedure format_seconds_61;

  -- %test(FORMAT_SECONDS returns 08:44 for 524 seconds.)
  procedure format_seconds_1_comma_524;

  -- %test(FORMAT_SECONDS returns 2:01:24 for 7284 seconds.)
  procedure format_seconds_7284;

  -- %test(HEX_TO_RGB returns rgb(255, 0, 0) for #FF0000.)
  procedure hex_to_rgb_red;

  -- %test(HEX_TO_RGB returns rgb(255, 0, 0) for #F00 too.)
  procedure hex_to_rgb_short;

  -- %test(IS_LEAP_YEAR returns true for 2000.)
  procedure is_leap_year_2000;

  -- %test(RGB_TO_HEX returns #FF0000 for 255,0,0.)
  procedure rgb_to_hex_red;

  --%context(split_tests)

    -- %test(SPLIT_TO_LIST can split simple csv text strings.)
    procedure split_to_list_standard;

    -- %test(SPLIT_TO_LIST can deal with 32k input strings.)
    procedure split_to_list_32k_in;

    -- %test(SPLIT_TO_LIST can deal with 32k output strings.)
    procedure split_to_list_32k_out;

    -- %test(SPLIT_TO_LIST can deal with enclosures and escaping.)
    procedure split_to_list_enc_and_esc;

    -- %test(SPLIT_TO_LIST return null if null is passed as text.)
    procedure split_to_list_null;

    -- %test(SPLIT_TT in combination with LISTAGG return the input text value.)
    procedure split_tt_agg;


--split_tt

  --%endcontext

  -- %test(UNIX_TIMESTAMP_TO_DATE returns 20:45:52 Friday, 13 December 1901 UTC for the minimum value -2^31.)
  procedure unix_timestamp_to_date_min;

  -- %test(UNIX_TIMESTAMP_TO_DATE returns 03:14:07 Tuesday, 19 January 2038 UTC for the maximum value (2^31)-2.)
  procedure unix_timestamp_to_date_max;

end plutil_test;
/