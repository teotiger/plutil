CREATE OR REPLACE package body plutil
as
  c_namespace constant vc2_s:='userenv'; -- sys_context namespace value
  c_language  constant vc2_s:='language';-- sys_context parameter value
  c_year_fmt  constant vc2_s:='yyyy';    -- year format string
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
  function days_in_year(
      p_year in date)
    return integer deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end
    c_year_in_months constant pls_integer:=12;
    l_year date not null:=p_year;
    l_next_year date;
  begin
    l_next_year:=add_months(l_year,c_year_in_months);
    return trunc(l_next_year,c_year_fmt)-
      trunc(l_year,c_year_fmt);
  end days_in_year;
--------------------------------------------------------------------------------
  function days_in_year(
      p_year in integer)
    return integer deterministic
  is
    $if not sys.dbms_db_version.ver_le_11 $then pragma udf; $end  
    c_days_in_normal_year constant pls_integer:=365;
    c_days_in_leap_year constant pls_integer:=366;
    l_year pls_integer not null:=p_year;    
  begin
    return 
      case when is_leap_year(l_year) 
        then c_days_in_leap_year
        else c_days_in_normal_year
      end;
  end days_in_year;
--------------------------------------------------------------------------------
  function is_leap_year(
      p_year in date)
    return boolean deterministic
  is
    l_year date not null:=p_year;
  begin
    return is_leap_year(extract(year from l_year));
  end is_leap_year;
--------------------------------------------------------------------------------
  function is_leap_year(
      p_year in pls_integer)
    return boolean deterministic
  is
    c_ly_normal constant pls_integer:=4;
    c_ly_extra1 constant pls_integer:=100;
    c_ly_extra2 constant pls_integer:=400;
    l_year pls_integer not null:=p_year;
    l_out boolean:=false;
  begin
    if mod(l_year,c_ly_normal)=0 then
      if not(mod(l_year,c_ly_extra1)=0 and mod(l_year,c_ly_extra2)<>0) then
        l_out:=true;
      end if;
    end if;
    return l_out;
  end is_leap_year;
--------------------------------------------------------------------------------
end plutil;
/

