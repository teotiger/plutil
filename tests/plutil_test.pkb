create or replace package body plutil_test as
--------------------------------------------------------------------------------
  procedure days_in_year_1999 is
  begin
    ut.expect( plutil.days_in_year(1999) ).to_( equal(365) );
  end days_in_year_1999;
--------------------------------------------------------------------------------
end plutil_test;
/
