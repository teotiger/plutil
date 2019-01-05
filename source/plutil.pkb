create or replace package body plutil
as
  c_namespace constant vc2_s:='userenv'; -- sys_context namespace value
  c_language  constant vc2_s:='language';-- sys_context parameter value
  c_year_fmt  constant vc2_s:='yyyy';    -- year format string
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
  function format_bytes(
      a_bytes in number,
      a_base  in number)
    return varchar2 deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end
    l_bytes number not null:=a_bytes;
    type ts is varray(9) of varchar2(3 char);
    -- https://en.wikipedia.org/wiki/Kilobyte
    l_2iec constant ts
      :=ts('B', 'KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB');
    l_10si constant ts
      :=ts('B', 'kB', 'MB',  'GB', 'TB', 'PB', 'EB', 'ZB', 'YB');
    l_idx simple_integer:=1;
    l_div number:=1024;
  begin
    if a_base=10
      then l_div:=1000;
    end if;

    while l_bytes>=l_div
    loop
      l_idx:=l_idx+1;
      l_bytes:=l_bytes/l_div;
    end loop;
    
    return to_char(round(l_bytes,1))||
           case when l_div=1000 then l_10si(l_idx) else l_2iec(l_idx) end;
  end format_bytes;
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
  function is_leap_year(
      a_year in date)
    return boolean deterministic
  is
    l_year date not null:=a_year;
  begin
    return is_leap_year(extract(year from l_year));
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
end plutil;
/
