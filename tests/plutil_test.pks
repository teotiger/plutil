create or replace package plutil_test authid definer as

  -- %suite(UnitTests for PLUTIL functions)

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
