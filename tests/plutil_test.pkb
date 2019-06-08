create or replace package body plutil_test as
--------------------------------------------------------------------------------
  procedure date_to_unix_timestamp_min is
  begin
    ut.expect(
      plutil.date_to_unix_timestamp( plutil.unix_timestamp_to_date(1) )
    ).to_( equal(1) );
  end date_to_unix_timestamp_min;
--------------------------------------------------------------------------------
  procedure unix_timestamp_to_date_min is
    c_exp date:=to_date(19011213204552,'yyyymmddhh24miss');
  begin
    ut.expect( 
      plutil.unix_timestamp_to_date(power(-2,31)) ).to_( equal(c_exp) 
    );
  end unix_timestamp_to_date_min;
--------------------------------------------------------------------------------
  procedure unix_timestamp_to_date_max is
    c_exp date:=to_date(20380119031407,'yyyymmddhh24miss');
  begin
    ut.expect(
      plutil.unix_timestamp_to_date(power(2,31)-1) ).to_( equal(c_exp) 
    );
  end unix_timestamp_to_date_max;
--------------------------------------------------------------------------------
  procedure hex_to_rgb_red is
  begin
    ut.expect( plutil.hex_to_rgb('#FF0000') ).to_( equal('rgb(255, 0, 0)') );
  end hex_to_rgb_red;
--------------------------------------------------------------------------------
  procedure rgb_to_hex_red is
  begin
    ut.expect( plutil.rgb_to_hex(255, 0, 0) ).to_( equal('#ff0000') );
  end rgb_to_hex_red;
--------------------------------------------------------------------------------
  procedure format_bytes_binary_small is
  begin
    ut.expect( plutil.format_bytes_binary(1704) ).to_( equal('1,7KiB') );
  end format_bytes_binary_small;
--------------------------------------------------------------------------------
  procedure format_bytes_decimal_small is
  begin
    ut.expect( plutil.format_bytes_decimal(1704) ).to_( equal('1,7kB') );
  end format_bytes_decimal_small;
--------------------------------------------------------------------------------
  procedure format_bytes_binary_big is
  begin
    ut.expect( 
      plutil.format_bytes_binary(1024*1024*1024) ).to_( equal('1GiB') 
    );
  end format_bytes_binary_big;
--------------------------------------------------------------------------------
  procedure format_bytes_decimal_big is
  begin
    ut.expect( 
      plutil.format_bytes_decimal(1024*1024*1024 ) ).to_( equal('1,1GB') 
    );
  end format_bytes_decimal_big;
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
  procedure days_in_year_1998 is
    l_dat date := to_date('28081998','ddmmyyyy');
  begin
    ut.expect( plutil.days_in_year(l_dat) ).to_( equal(365) );
  end days_in_year_1998;
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
