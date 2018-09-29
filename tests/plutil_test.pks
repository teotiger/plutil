create or replace package plutil_test as

  -- %suite(UnitTests for PLUTIL functions)

  -- %test(Returns 365 days because 1999 is not a leap year.)
  procedure days_in_year_1999;
  
end plutil_test;
/
