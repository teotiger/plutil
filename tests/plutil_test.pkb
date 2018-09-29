create or replace package body plutil_test as
--------------------------------------------------------------------------------
  procedure format_seconds_59 is
  begin
    ut.expect( plutil.format_seconds(59) ).to_( equal('00:59') );
  end format_seconds_59;
--------------------------------------------------------------------------------
  procedure format_seconds_60 is
  begin
    ut.expect( plutil.format_seconds(60) ).to_( equal('01:00') );
  end format_seconds_60;
--------------------------------------------------------------------------------
  procedure format_seconds_61 is
  begin
    ut.expect( plutil.format_seconds(61) ).to_( equal('01:01') );
  end format_seconds_61;
--------------------------------------------------------------------------------
  procedure format_seconds_1_comma_524 is
  begin
    ut.expect( plutil.format_seconds(1.524) ).to_( equal('00:02') );
  end format_seconds_1_comma_524;
--------------------------------------------------------------------------------
  procedure format_seconds_7284 is
  begin
    ut.expect( plutil.format_seconds(7284) ).to_( equal('2:01:24') );
  end format_seconds_7284;  
--------------------------------------------------------------------------------
  procedure days_in_year_1996 is
  begin
    ut.expect( plutil.days_in_year(1996) ).to_( equal(366) );
  end days_in_year_1996;
--------------------------------------------------------------------------------
  procedure days_in_year_1999 is
  begin
    ut.expect( plutil.days_in_year(1999) ).to_( equal(365) );
  end days_in_year_1999;
--------------------------------------------------------------------------------
  procedure days_in_year_2000 is
  begin
    ut.expect( plutil.days_in_year(2000) ).to_( equal(366) );
  end days_in_year_2000;
--------------------------------------------------------------------------------
  procedure days_in_year_1600 is
  begin
    ut.expect( plutil.days_in_year(1600) ).to_( equal(366) );
  end days_in_year_1600;
--------------------------------------------------------------------------------
  procedure days_in_year_1900 is
  begin
    ut.expect( plutil.days_in_year(1900) ).to_( equal(365) );
  end days_in_year_1900;
--------------------------------------------------------------------------------
  procedure days_in_year_1904 is
  begin
    ut.expect( plutil.days_in_year(1904) ).to_( equal(366) );
  end days_in_year_1904;
--------------------------------------------------------------------------------
  procedure days_in_year_1800 is
  begin
    ut.expect( plutil.days_in_year(1800) ).to_( equal(365) );
  end days_in_year_1800;
--------------------------------------------------------------------------------
end plutil_test;
/
