create or replace package plutil_test authid definer as

  -- %suite(UnitTests for PLUTIL functions)

  -- %test(Returns true)
  procedure is_leap_year_2000;

  -- %test(Returns 31)
  procedure days_in_month_jan;

  -- %test(Returns 1)
  procedure date_to_unix_timestamp_min;

  -- %test(Returns 20:45:52 Friday, 13 December 1901 UTC)
  procedure unix_timestamp_to_date_min;

  -- %test(Returns 03:14:07 Tuesday, 19 January 2038 UTC)
  procedure unix_timestamp_to_date_max;

  -- %test(Returns rgb(255, 0, 0))
  procedure hex_to_rgb_red;

  -- %test(Returns #FF0000)
  procedure rgb_to_hex_red;

  -- %test(Returns 1,7KiB)
  procedure format_bytes_binary_small;
  
  -- %test(Returns 1,7kB)
  procedure format_bytes_decimal_small;
  
  -- %test(Returns 1GiB)
  procedure format_bytes_binary_big;
  
  -- %test(Returns 1,1GB)
  procedure format_bytes_decimal_big;
			  
  -- %test(Returns 00:59)
  procedure format_seconds_59;
  
  -- %test(Returns 01:00)
  procedure format_seconds_60;

  -- %test(Returns 01:01)
  procedure format_seconds_61;
  
  -- %test(Returns 08:44)
  procedure format_seconds_1_comma_524;

  -- %test(Returns 2:01:24)
  procedure format_seconds_7284;
  
  -- %test(Returns 366 days because 1996 is a leap year.)
  procedure days_in_year_1996;

  -- %test(Returns 365 days because 1998 is not a leap year.)
  procedure days_in_year_1998;

  -- %test(Returns 365 days because 1999 is not a leap year.)
  procedure days_in_year_1999;

  -- %test(Returns 366 days because 2000 is a leap year.)
  procedure days_in_year_2000;
  
  -- %test(Returns 366 days because 1600 is a leap year.)
  procedure days_in_year_1600;

  -- %test(Returns 365 days because 1900 is not a leap year.)
  procedure days_in_year_1900;

  -- %test(Returns 366 days because 1904 is a leap year.)
  procedure days_in_year_1904;

  -- %test(Returns 365 days because 1800 is not a leap year.)
  procedure days_in_year_1800;

end plutil_test;
/
