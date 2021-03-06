create or replace package body plutil
as
--------------------------------------------------------------------------------
  function cpad(
      a_string in varchar2,
      a_length in integer,
      a_char   in varchar2)
    return varchar2 deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end
    c_div constant pls_integer:=2;
    l_string vc2_l:=a_string;
    l_length pls_integer:=a_length;
    l_char vc2_xs:=a_char;
    l_surround vc2_l;
  begin
    l_length:=l_length-mod(l_length-length(l_string),c_div);
    l_surround:=lpad(l_char,
                     (l_length-length(l_string))/c_div,
                     l_char);
    return l_surround||l_string||l_surround;
  end cpad;
--------------------------------------------------------------------------------
  function current_charset
    return varchar2 deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end
    c_namespace constant vc2_s:='userenv';
    c_language  constant vc2_s:='language';
    c_pattern   constant vc2_s   :='[[:alnum:]]*';
    c_position  constant positive:=1;
    c_occurence constant positive:=5;
  begin
    return regexp_substr( 
      sys_context(c_namespace,c_language), 
      c_pattern,
      c_position,
      c_occurence
    );
  end current_charset; 
--------------------------------------------------------------------------------
  function current_iso_language
    return varchar2 deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end
    c_namespace constant vc2_s:='userenv';
    c_language  constant vc2_s:='language';
    c_pattern constant vc2_s:='[A-Z]+';
  begin
    return sys.utl_gdk.language_map(
      regexp_substr(
        sys_context(c_namespace,c_language),
        c_pattern
      ),
      sys.utl_gdk.oracle_to_iso
    );
  end current_iso_language;
--------------------------------------------------------------------------------
  function current_iso_locale
    return varchar2 deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end
    c_namespace constant vc2_s:='userenv';
    c_language  constant vc2_s:='language';
    c_pattern   constant vc2_s:='[A-Z]+';
    c_territory constant vc2_s:='nls_territory';
  begin
    return sys.utl_i18n.map_locale_to_iso(
      regexp_substr(
        sys_context(c_namespace,c_language),
        c_pattern
      ),
      sys_context(c_namespace,c_territory)
    );
  end current_iso_locale;
--------------------------------------------------------------------------------
  function date_to_unix_timestamp(
      a_date in date)
    return number deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end  
    c_unix_epti constant date:=to_date(19700101,'yyyymmdd');
    c_div constant simple_integer:=86400;   
    l_date date not null:=a_date;
    l_out pls_integer;
  begin
    l_out:=case when l_date>=c_unix_epti 
            then (l_date-c_unix_epti)*c_div
           end;
    return l_out;
  end date_to_unix_timestamp;
--------------------------------------------------------------------------------
  function days_in_month(
      a_month in date)
    return integer deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end
    c_last_month constant pls_integer:=-1;
    l_month date not null:=a_month;
  begin
    return last_day(l_month)-last_day(add_months(l_month,c_last_month));
  end days_in_month;
--------------------------------------------------------------------------------
  function days_in_year(
      a_year in date)
    return integer deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end
    c_year_fmt constant vc2_s:='yyyy';
    c_year_in_months constant pls_integer:=12;
    l_year date not null:=a_year;
    l_next_year date;
  begin
    l_next_year:=add_months(l_year,c_year_in_months);
    return trunc(l_next_year,c_year_fmt)-
      trunc(l_year,c_year_fmt);
  end days_in_year;
--------------------------------------------------------------------------------
  function days_in_year(
      a_year in integer)
    return integer deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end  
    c_days_in_normal_year constant pls_integer:=365;
    c_days_in_leap_year constant pls_integer:=366;
    l_year pls_integer not null:=a_year;    
  begin
    return 
      case when is_leap_year(l_year) 
        then c_days_in_leap_year
        else c_days_in_normal_year
      end;
  end days_in_year;
--------------------------------------------------------------------------------
  function format_bytes_binary(
        a_bytes in number)
    return varchar2 deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end
    type ts is varray(7) of varchar2(3 char);
    -- https://en.wikipedia.org/wiki/Kilobyte
    c_bin_iec constant ts:=ts('B', 'KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB');
    c_bin_div constant simple_integer:=1024;
    l_bytes naturaln:=a_bytes; 
    l_floor decimal;
  begin
    l_floor := floor(log(c_bin_div, l_bytes));
    return to_char( 
            round( l_bytes/power(c_bin_div, l_floor), 1)
           )||c_bin_iec(l_floor+1);
  end format_bytes_binary;
--------------------------------------------------------------------------------
  function format_bytes_decimal(
      a_bytes in number)
    return varchar2 deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end
    type ts is varray(7) of varchar2(2 char);
    c_dec_si constant ts:=ts('B', 'kB', 'MB',  'GB', 'TB', 'PB', 'EB');
    c_dec_div constant simple_integer:=1000;
    l_bytes naturaln:=a_bytes; 
    l_floor decimal;
  begin
    l_floor := floor(log(c_dec_div, l_bytes));
    return to_char( 
            round( l_bytes/power(c_dec_div, l_floor), 1)
           )||c_dec_si(l_floor+1);
  end format_bytes_decimal;
--------------------------------------------------------------------------------
  function format_seconds(
      a_seconds in number)
    return varchar2 deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end  
    c_ss constant pls_integer:=60;
    c_mm constant pls_integer:=3600;
    c_pl constant pls_integer:=2;
    c_pc constant vc2_xs:='0';
    c_dp constant vc2_xs:=':';
    l_seconds naturaln:=a_seconds;
  begin
    return 
      case when floor(l_seconds/c_mm)>0 
        then floor(l_seconds/c_mm)||c_dp 
      end
      || lpad( floor(mod(l_seconds,c_mm)/c_ss) ,c_pl,c_pc)
      || c_dp
      || lpad( mod(l_seconds,c_ss) ,c_pl,c_pc);
  end format_seconds;
--------------------------------------------------------------------------------
  function hex_to_rgb(
    a_hex in varchar2) 
  return varchar2 deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end  
    c_sp constant vc2_xs not null:='#';
    c_nm2 constant simple_integer:=2;
    c_nm3 constant simple_integer:=3;
    c_rgb constant vc2_s not null:='rgb(';
    c_hex constant vc2_s not null:='xx';
    c_col constant vc2_s not null:=', ';
    c_end constant vc2_s not null:=')';
    l_hex vc2_s not null:=a_hex;
  begin
    l_hex:=ltrim(l_hex,c_sp);
    if length(l_hex)=c_nm3 then
      l_hex:=substr(l_hex,1,1)||substr(l_hex,1,1)||
             substr(l_hex,c_nm2,1)||substr(l_hex,c_nm2,1)||
             substr(l_hex,c_nm3,1)||substr(l_hex,c_nm3,1);
    end if;
     return c_rgb||to_number(substr(l_hex,1,c_nm2),c_hex)||c_col
                 ||to_number(substr(l_hex,c_nm3,c_nm2),c_hex)||c_col
                 ||to_number(substr(l_hex,c_nm3+c_nm2,c_nm2),c_hex)
            ||c_end;
  end hex_to_rgb;
--------------------------------------------------------------------------------
  function is_leap_year(
      a_year in date)
    return boolean deterministic
  is
    l_date date not null:=a_year;
  begin
    return is_leap_year(extract(year from l_date));
  end is_leap_year;
--------------------------------------------------------------------------------
  function is_leap_year(
      a_year in pls_integer)
    return boolean deterministic
  is
    c_ly_normal constant pls_integer:=4;
    c_ly_extra1 constant pls_integer:=100;
    c_ly_extra2 constant pls_integer:=400;
    l_year pls_integer not null:=a_year;
    l_out boolean:=false;
  begin
    if mod(l_year,c_ly_normal)=0 and 
       (not(mod(l_year,c_ly_extra1)=0 and mod(l_year,c_ly_extra2)<>0)) then
      l_out:=true;      
    end if;
    return l_out;
  end is_leap_year;
--------------------------------------------------------------------------------
  procedure prn(
      a_string in varchar2)
  is
    l_txt vc2_l := a_string;
  begin
    if l_txt is null then
      sys.dbms_output.new_line;
    else
      sys.dbms_output.put_line(l_txt);
    end if;
  end prn;
--------------------------------------------------------------------------------
  function replace_multi(
      a_string          in varchar2,
      a_replace_strings in sys.dbmsoutput_linesarray)
    return clob deterministic
  is
    c_enc constant vc2_xs:='#';
    l_out clob:=a_string;
    l_rep sys.dbmsoutput_linesarray:=a_replace_strings;
  begin
    <<replace_loop>>
    for i in 1..l_rep.count loop
      l_out:=replace(l_out,c_enc||i||c_enc,l_rep(i));
    end loop replace_loop;
    return l_out;
  end replace_multi;
--------------------------------------------------------------------------------
  function replace_multi(
      a_string          in varchar2,
      a_replace_strings in sys.ora_mining_varchar2_nt)
    return varchar2 deterministic
  is
    c_enc constant vc2_xs:='#';
    l_txt vc2_l:=a_string;
    l_rep sys.ora_mining_varchar2_nt:=a_replace_strings;
    l_idx pls_integer;
  begin
    if l_rep is not null then
      l_idx:=l_rep.first;
    end if;
    <<replace_loop>>
    while l_idx is not null loop
      l_txt:=replace(l_txt,c_enc||l_idx||c_enc,l_rep(l_idx));
      l_idx:=l_rep.next(l_idx);
    end loop replace_loop;
    return l_txt;
  end replace_multi;
--------------------------------------------------------------------------------
  function rgb_to_hex(
      a_red   in number,
      a_green in number,
      a_blue  in number)
    return varchar2 deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end  
    c_pfx constant vc2_xs:='#';
    c_fmt constant vc2_s:='fm0x';
    l_red   unsigned_octet:=a_red;
    l_green unsigned_octet:=a_green;
    l_blue  unsigned_octet:=a_blue;
  begin
    return c_pfx||
      to_char(l_red, c_fmt)||to_char(l_green, c_fmt)||to_char(l_blue, c_fmt);
  end rgb_to_hex;
--------------------------------------------------------------------------------
  function split_to_list(
      a_string          in varchar2,
      a_delimiter       in varchar2,
      a_enclosure       in varchar2,
      a_trim_enclosure  in boolean)
    return sys.dbmsoutput_linesarray deterministic
  is
    -- escape char
    c_esc constant vc2_xs:='\';
    l_txt vc2_xl null:=a_string;
    l_del vc2_xs not null:=a_delimiter;  
    l_enc vc2_xs null:=a_enclosure;
     -- is_trim
    l_ist boolean:=a_trim_enclosure;
    l_out sys.dbmsoutput_linesarray;
    l_len pls_integer;
    l_pos pls_integer:=1;
    l_cur vc2_xs;
    l_tmp vc2_xl;
    -- is_blocked
    l_isb boolean:=false;
  begin
    l_len:=length(l_txt);
    if l_len is null then
      l_len:=0;
    else
      l_out:=sys.dbmsoutput_linesarray();
    end if;

    <<char_looping>>
    while l_pos<=l_len
    loop
      -- find the current and the next character
      l_cur:=substr(l_txt, l_pos, 1);

      -- in case of escaped enclosure append enc and skip 2 positions
      if l_cur=c_esc and substr(l_txt, l_pos+1, 1)=l_enc then
        l_tmp:=l_tmp||l_enc;
        l_pos:=l_pos+1+1;
        continue;
      end if;

      -- set blocker if enclosure found
      if l_cur=l_enc then
        -- toggle blocked mode
        l_isb:=not l_isb;
      end if;

      -- add collection element if delimiter
      if l_cur=l_del and not l_isb then
        l_out.extend;
        l_out(l_out.count):=case when l_ist 
                              then trim(both l_enc from l_tmp) 
                              else l_tmp 
                            end;
        -- reset tmp variable
        l_tmp:=null;
      end if;

      -- append if not delimiter
      if l_cur!=l_del or l_isb then
        l_tmp:=l_tmp||l_cur;
      end if;

      -- add collection element if last position
      if l_pos=l_len then
        l_out.extend;
        l_out(l_out.count):=case when l_ist 
                              then trim(both l_enc from l_tmp) 
                              else l_tmp 
                            end;
      end if;

      -- increment position
      l_pos:=l_pos+1;
    end loop char_looping;

    return l_out;
  end split_to_list;
--------------------------------------------------------------------------------
  function split_tt(
      a_string          in varchar2,
      a_delimiter       in varchar2,
      a_enclosure       in varchar2,
      a_trim_enclosure  in bool)
    return sys.ora_mining_varchar2_nt pipelined deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end  
    l_txt vc2_xl null:=a_string;
    l_del vc2_xs not null:=a_delimiter;  
    l_enc vc2_xs null:=a_enclosure;
    l_tfl bool:=a_trim_enclosure; -- trim flag
    l_arr sys.dbmsoutput_linesarray;
    l_idx pls_integer;
  begin
    l_arr:=split_to_list(a_string => l_txt,
                         a_delimiter => l_del,
                         a_enclosure => l_enc,
                         a_trim_enclosure => l_tfl=1);
    if l_arr is not null then
      l_idx:=l_arr.first;
    end if;
    <<loop_through_array>>
    while l_idx is not null loop
      pipe row(l_arr(l_idx));
      l_idx:=l_arr.next(l_idx);
    end loop loop_through_array;
    return;
  end split_tt;
--------------------------------------------------------------------------------
  function unix_timestamp_to_date(
      a_unix_timestamp in number)
    return date deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end  
    c_unix_epti constant date:=to_date(19700101,'yyyymmdd');
    c_div constant simple_integer:=86400;    
    l_unix_timestamp pls_integer:=a_unix_timestamp;
  begin
    return c_unix_epti+l_unix_timestamp/c_div;
  end unix_timestamp_to_date;
--------------------------------------------------------------------------------
end plutil;
/
