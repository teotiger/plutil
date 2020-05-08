create or replace package body plutil_test as
--------------------------------------------------------------------------------
  procedure cpad is
    c_str constant plutil.vc2_s:='HI';
    c_len constant pls_integer:=8;
    c_chr constant plutil.vc2_xs:='*';
    c_expected constant plutil.vc2_s:='***'||c_str||'***';
    l_actual plutil.vc2_s;
  begin
    l_actual:=plutil.cpad(a_string => c_str,
                          a_length => c_len,
                          a_char => c_chr);
    ut.expect(a_actual => l_actual).to_equal(a_expected => c_expected);
  end cpad;
--------------------------------------------------------------------------------
  procedure current_charset is
    c_where_param constant plutil.vc2_s:='NLS_CHARACTERSET';
    l_expected plutil.vc2_s;
    l_actual plutil.vc2_s;
  begin
    select max(value)
      into l_expected
      from nls_database_parameters 
     where parameter=c_where_param;
    l_actual:=plutil.current_charset;
    ut.expect(a_actual => l_actual).to_equal(a_expected => l_expected);
  end current_charset;
--------------------------------------------------------------------------------
  procedure current_iso_language is
    c_regexp constant plutil.vc2_s:='[a-z]{2}';
  begin
    ut.expect(
      a_actual => plutil.current_iso_language
    ).to_match(
      a_pattern => c_regexp
    );
  end current_iso_language;
--------------------------------------------------------------------------------
  procedure current_iso_locale is
    c_regexp constant plutil.vc2_s:='^[a-z]{2}_[A-Z]{2}$';
  begin
    ut.expect(
      a_actual => plutil.current_iso_locale
    ).to_match(
      a_pattern => c_regexp
    );
  end current_iso_locale;
--------------------------------------------------------------------------------
  procedure days_in_month_jan is
    c_act constant date:=date'2000-01-01';
    c_exp constant pls_integer:=31;
  begin
    ut.expect(
      a_actual => plutil.days_in_month(a_month => c_act)
    ).to_equal( 
      a_expected => c_exp
    );
  end days_in_month_jan;
--------------------------------------------------------------------------------
  procedure days_in_year_1996 is
    c_year constant pls_integer:=1996;
    c_days constant pls_integer:=366;
  begin
    ut.expect(
      a_actual => plutil.days_in_year(a_year => c_year)
    ).to_equal(
      a_expected => c_days
    );
  end days_in_year_1996;
--------------------------------------------------------------------------------
  procedure days_in_year_1998 is
    c_year constant date:=date'1998-08-28';
    c_days constant pls_integer:=365;
  begin
    ut.expect(
      a_actual => plutil.days_in_year(a_year => c_year)
    ).to_equal(
      a_expected => c_days
    );
  end days_in_year_1998;
--------------------------------------------------------------------------------
  procedure days_in_year_1999 is
    c_year constant pls_integer:=1999;
    c_days constant pls_integer:=365;
  begin
    ut.expect(
      a_actual => plutil.days_in_year(a_year => c_year)
    ).to_equal(
      a_expected => c_days
    );
  end days_in_year_1999;
--------------------------------------------------------------------------------
  procedure days_in_year_2000 is
    c_year constant pls_integer:=2000;
    c_days constant pls_integer:=366;
  begin
    ut.expect(
      a_actual => plutil.days_in_year(a_year => c_year)
    ).to_equal(
      a_expected => c_days
    );
  end days_in_year_2000;
--------------------------------------------------------------------------------
  procedure days_in_year_1600 is
    c_year constant pls_integer:=1600;
    c_days constant pls_integer:=366;
  begin
    ut.expect(
      a_actual => plutil.days_in_year(a_year => c_year)
    ).to_equal(
      a_expected => c_days
    );
  end days_in_year_1600;
--------------------------------------------------------------------------------
  procedure days_in_year_1900 is
    c_year constant pls_integer:=1900;
    c_days constant pls_integer:=365;
  begin
    ut.expect(
      a_actual => plutil.days_in_year(a_year => c_year)
    ).to_equal(
      a_expected => c_days
    );
  end days_in_year_1900;
--------------------------------------------------------------------------------
  procedure days_in_year_1904 is
    c_year constant pls_integer:=1904;
    c_days constant pls_integer:=366;
  begin
    ut.expect(
      a_actual => plutil.days_in_year(a_year => c_year)
    ).to_equal(
      a_expected => c_days
    );
  end days_in_year_1904;
--------------------------------------------------------------------------------
  procedure days_in_year_1800 is
    c_year constant pls_integer:=1800;
    c_days constant pls_integer:=365;
  begin
    ut.expect(
      a_actual => plutil.days_in_year(a_year => c_year)
    ).to_equal(
      a_expected => c_days
    );
  end days_in_year_1800;
--------------------------------------------------------------------------------
  procedure date_to_unix_timestamp_min is
  begin
    ut.expect(
      a_actual => 
        plutil.date_to_unix_timestamp(
          a_date => plutil.unix_timestamp_to_date(a_unix_timestamp => 1)
        )
    ).to_equal(
      a_expected => 1
    );
  end date_to_unix_timestamp_min;
--------------------------------------------------------------------------------
  procedure format_bytes_binary_small is
    c_act constant pls_integer:=1704;
    c_exp constant plutil.vc2_s:=1.7||'KiB';
  begin
    ut.expect(
      a_actual => plutil.format_bytes_binary(a_bytes => c_act)
    ).to_equal(
      a_expected => c_exp
    );
  end format_bytes_binary_small;
--------------------------------------------------------------------------------
  procedure format_bytes_binary_big is
    c_act constant pls_integer:=1024*1024*1024;
    c_exp constant plutil.vc2_s:='1GiB';
  begin
    ut.expect(
      a_actual => plutil.format_bytes_binary(a_bytes => c_act)
    ).to_equal(
      a_expected => c_exp
    );
  end format_bytes_binary_big;
--------------------------------------------------------------------------------
  procedure format_bytes_decimal_small is
    c_act constant pls_integer:=1704;
    c_exp constant plutil.vc2_s:=1.7||'kB';
  begin
    ut.expect(
      a_actual => plutil.format_bytes_decimal(a_bytes => c_act)
    ).to_equal(
      a_expected => c_exp
    );
  end format_bytes_decimal_small;
--------------------------------------------------------------------------------
  procedure format_bytes_decimal_big is
    c_act constant pls_integer:=1024*1024*1024;
    c_exp constant plutil.vc2_s:=1.1||'GB';
  begin
    ut.expect(
      a_actual => plutil.format_bytes_decimal(a_bytes => c_act)
    ).to_equal(
      a_expected => c_exp
    );
  end format_bytes_decimal_big;
--------------------------------------------------------------------------------
  procedure format_seconds_59 is
    c_act constant pls_integer:=59;
    c_exp constant plutil.vc2_s:='00:59';
  begin
    ut.expect(
      a_actual => plutil.format_seconds(a_seconds => c_act)
    ).to_equal(
      a_expected => c_exp
    );
  end format_seconds_59;
--------------------------------------------------------------------------------
  procedure format_seconds_60 is
    c_act constant pls_integer:=60;
    c_exp constant plutil.vc2_s:='01:00';
  begin
    ut.expect(
      a_actual => plutil.format_seconds(a_seconds => c_act)
    ).to_equal(
      a_expected => c_exp
    );
  end format_seconds_60;
--------------------------------------------------------------------------------
  procedure format_seconds_61 is
    c_act constant pls_integer:=61;
    c_exp constant plutil.vc2_s:='01:01';
  begin
    ut.expect(
      a_actual => plutil.format_seconds(a_seconds => c_act)
    ).to_equal(
      a_expected => c_exp
    );
  end format_seconds_61;
--------------------------------------------------------------------------------
  procedure format_seconds_1_comma_524 is
    c_act constant pls_integer:=1.524;
    c_exp constant plutil.vc2_s:='00:02';
  begin
    ut.expect(
      a_actual => plutil.format_seconds(a_seconds => c_act)
    ).to_equal(
      a_expected => c_exp
    );
  end format_seconds_1_comma_524;
--------------------------------------------------------------------------------
  procedure format_seconds_7284 is
    c_act constant pls_integer:=7284;
    c_exp constant plutil.vc2_s:='2:01:24';
  begin
    ut.expect(
      a_actual => plutil.format_seconds(a_seconds => c_act)
    ).to_equal(
      a_expected => c_exp
    );
  end format_seconds_7284;
--------------------------------------------------------------------------------
  procedure hex_to_rgb_red is
    c_act constant plutil.vc2_s:='#FF0000';
    c_exp constant plutil.vc2_s:='rgb(255, 0, 0)';
  begin
    ut.expect(
      a_actual => plutil.hex_to_rgb(a_hex=>c_act)
    ).to_equal( 
      a_expected => c_exp
    );
  end hex_to_rgb_red;
--------------------------------------------------------------------------------
  procedure hex_to_rgb_short is
    c_act constant plutil.vc2_s:='#F00';
    c_exp constant plutil.vc2_s:='rgb(255, 0, 0)';
  begin
    ut.expect(
      a_actual => plutil.hex_to_rgb(a_hex=>c_act)
    ).to_equal( 
      a_expected => c_exp
    );
  end hex_to_rgb_short;
--------------------------------------------------------------------------------
  procedure is_leap_year_2000 is
    c_2000 constant date:=date'2000-01-01';
  begin
    ut.expect( a_actual => plutil.is_leap_year(a_year=>c_2000) ).to_be_true;
  end is_leap_year_2000;
--------------------------------------------------------------------------------
  procedure prn_text is
    c_expected constant plutil.vc2_s:='Hola!';
    l_actual plutil.vc2_s;
    l_status integer;
  begin
    plutil.prn(a_string => c_expected);
    sys.dbms_output.get_line(l_actual, l_status);
    ut.expect(a_actual => l_actual).to_equal(a_expected => c_expected);
  end prn_text;
--------------------------------------------------------------------------------
  procedure prn_blank is
    l_actual plutil.vc2_s;
    l_status integer;
  begin
    plutil.prn;
    sys.dbms_output.get_line(l_actual, l_status);
    ut.expect(a_actual => l_actual).to_be_null;
  end prn_blank;
--------------------------------------------------------------------------------
  procedure replace_multi_sql is
    c_expected constant plutil.vc2_s:='Res severa est verum gaudium';
    c_str constant plutil.vc2_s:='Res #1# est verum #2#';
    c_rps constant sys.ora_mining_varchar2_nt
      :=sys.ora_mining_varchar2_nt('severa','gaudium');
    l_actual plutil.vc2_s;
  begin
    l_actual:=plutil.replace_multi(a_string=>c_str,
                                   a_replace_strings=>c_rps);
    ut.expect(a_actual => l_actual).to_equal(a_expected => c_expected);
  end replace_multi_sql;
--------------------------------------------------------------------------------
  procedure replace_multi_plsql is
    c_expected constant clob:='Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
    c_str constant plutil.vc2_m:='#1# ipsum #2# sit amet, consectetur adipiscing #3#.';
    c_rps constant sys.dbmsoutput_linesarray
      :=sys.dbmsoutput_linesarray('Lorem','dolor','elit');
    l_actual clob;
  begin
    l_actual:=plutil.replace_multi(a_string=>c_str,
                                   a_replace_strings=>c_rps);
    ut.expect(a_actual => l_actual).to_equal(a_expected => c_expected);
  end replace_multi_plsql;
--------------------------------------------------------------------------------
  procedure rgb_to_hex_red is
    c_red   constant plutil.unsigned_octet:=255;
    c_green constant plutil.unsigned_octet:=0;
    c_blue  constant plutil.unsigned_octet:=0;
    c_hex   constant plutil.vc2_s:='#ff0000';
  begin
    ut.expect(
      a_actual => plutil.rgb_to_hex(a_red => c_red,
                                    a_green => c_green,
                                    a_blue => c_blue)
    ).to_equal( 
      a_expected => c_hex
    );
  end rgb_to_hex_red;
--------------------------------------------------------------------------------
  procedure split_to_list_standard is
    c_csv constant plutil.vc2_m:='abc;defghij;X  Y123Z;;';
    c_del constant plutil.vc2_xs:=';';
    c_enc constant plutil.vc2_xs:=null;
    c_ist constant boolean:=false;
    c_exp constant sys.dbmsoutput_linesarray
      :=sys.dbmsoutput_linesarray('abc','defghij','X  Y123Z',null,null);
    l_act sys.dbmsoutput_linesarray;
  begin
    l_act:=plutil.split_to_list(a_string => c_csv,
                                a_delimiter => c_del,
                                a_enclosure => c_enc,
                                a_trim_enclosure => c_ist);
    ut.expect(
      a_actual => anydata.convertCollection(col => l_act) 
    ).to_equal( 
      a_expected => anydata.convertCollection(col => c_exp)
    );
  end split_to_list_standard;
--------------------------------------------------------------------------------
  procedure split_to_list_32k_in is
    c_8k constant pls_integer:=8191;
    c_char_a constant plutil.vc2_xs:='A';
    c_char_b constant plutil.vc2_xs:='B';
    c_char_c constant plutil.vc2_xs:='C';
    c_char_d constant plutil.vc2_xs:='D';
    c_del constant plutil.vc2_xs:=';';
    c_enc constant plutil.vc2_xs:=null;
    c_ist constant boolean:=false;
    l_aaa plutil.vc_xl;
    l_bbb plutil.vc_xl;
    l_ccc plutil.vc_xl;
    l_ddd plutil.vc_xl;
    l_act sys.dbmsoutput_linesarray;
    l_exp sys.dbmsoutput_linesarray;
  begin
    <<assign_data_to_variables>>
    while nvl(length(l_aaa),0)<c_8k loop
      l_aaa:=l_aaa||c_char_a;
      l_bbb:=l_bbb||c_char_b;
      l_ccc:=l_ccc||c_char_c;
      l_ddd:=l_ddd||c_char_d;
    end loop assign_data_to_variables;
    l_act:=plutil.split_to_list(a_string => l_aaa||c_del||
                                                l_bbb||c_del||
                                                l_ccc||c_del||
                                                l_ddd,
                                a_delimiter => c_del,
                                a_enclosure => c_enc,
                                a_trim_enclosure => c_ist);
    l_exp:=sys.dbmsoutput_linesarray(l_aaa,l_bbb,l_ccc,l_ddd);
    ut.expect(
      a_actual => anydata.convertCollection(col => l_act)
    ).to_equal( 
      a_expected => anydata.convertCollection(col => l_exp)
    );
  end split_to_list_32k_in;
--------------------------------------------------------------------------------
  procedure split_to_list_32k_out is
    c_32k constant pls_integer:=32000;
    c_char_a constant plutil.vc2_xs:='A';
    c_del constant plutil.vc2_xs:='?';
    c_enc constant plutil.vc2_xs:=null;
    c_ist constant boolean:=false;
    l_big plutil.vc_xl;
    l_act sys.dbmsoutput_linesarray;
    l_exp sys.dbmsoutput_linesarray;
  begin
    <<assign_data_to_variables>>
    while nvl(length(l_big),0)<c_32k loop
      l_big:=l_big||c_char_a;
    end loop assign_data_to_variables;
    l_act:=plutil.split_to_list(a_string => l_big,
                                a_delimiter => c_del,
                                a_enclosure => c_enc,
                                a_trim_enclosure => c_ist);
    l_exp:=sys.dbmsoutput_linesarray(l_big);
    ut.expect(
      a_actual => anydata.convertCollection(col => l_act) 
    ).to_equal( 
      a_expected => anydata.convertCollection(col => l_exp)
    );
  end split_to_list_32k_out;
--------------------------------------------------------------------------------
  procedure split_to_list_enc_and_esc is
    c_csv constant plutil.vc2_m:='"abc";defghij;"X  Y1\"23Z";;';
    c_del constant plutil.vc2_xs:=';';
    c_enc constant plutil.vc2_xs:='"';
    c_ist constant boolean:=true;
    c_exp constant sys.dbmsoutput_linesarray
      :=sys.dbmsoutput_linesarray('abc','defghij','X  Y1"23Z',null,null);
    l_act sys.dbmsoutput_linesarray;
  begin
    l_act:=plutil.split_to_list(a_string => c_csv,
                                a_delimiter => c_del,
                                a_enclosure => c_enc,
                                a_trim_enclosure => c_ist);
    ut.expect(
      a_actual => anydata.convertCollection(col => l_act) 
    ).to_equal( 
      a_expected => anydata.convertCollection(col => c_exp)
    );
  end split_to_list_enc_and_esc;
--------------------------------------------------------------------------------
  procedure split_to_list_null is
    c_csv constant plutil.vc2_m:=null;
    c_del constant plutil.vc2_xs:=';';
    c_enc constant plutil.vc2_xs:='"';
    c_ist constant boolean:=true;
    l_exp sys.dbmsoutput_linesarray;
    l_act sys.dbmsoutput_linesarray;
  begin
    l_act:=plutil.split_to_list(a_string => c_csv,
                                a_delimiter => c_del,
                                a_enclosure => c_enc,
                                a_trim_enclosure => c_ist);
    ut.expect(
      a_actual => anydata.convertCollection(col => l_act)
    ).to_equal( 
      a_expected => anydata.convertCollection(col => l_exp)
    );
  end split_to_list_null;
--------------------------------------------------------------------------------
  procedure split_tt_agg is
    c_csv constant plutil.vc2_m:='abc,def,ghijkl,yz';
    c_del constant plutil.vc2_xs:=',';
    c_enc constant plutil.vc2_xs:=null;
    c_ist constant plutil.bool:=0;
    l_act plutil.vc2_s;
  begin
    select listagg(column_value,c_del) within group(order by column_value) 
      into l_act
      from table(plutil.split_tt(a_string => c_csv,
                                 a_delimiter => c_del,
                                 a_enclosure => c_enc,
                                 a_trim_enclosure => c_ist));
    ut.expect(
      a_actual => l_act
    ).to_equal( 
      a_expected => c_csv
    );
  end split_tt_agg;
--------------------------------------------------------------------------------
  procedure unix_timestamp_to_date_min is
    c_act constant pls_integer:=power(-2,31);
    c_exp constant date:=to_date(19011213204552,'yyyymmddhh24miss');
  begin
    ut.expect(
      a_actual => plutil.unix_timestamp_to_date(a_unix_timestamp => c_act)
    ).to_equal( 
      a_expected => c_exp
    );
  end unix_timestamp_to_date_min;
--------------------------------------------------------------------------------
  procedure unix_timestamp_to_date_max is
    c_act constant pls_integer:=power(2,31)-1;
    c_exp constant date:=to_date(20380119031407,'yyyymmddhh24miss');
  begin
    ut.expect(
      a_actual => plutil.unix_timestamp_to_date(a_unix_timestamp => c_act)
    ).to_equal( 
      a_expected => c_exp
    );
  end unix_timestamp_to_date_max;
--------------------------------------------------------------------------------
end plutil_test;
/
