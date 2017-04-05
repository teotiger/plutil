create or replace package body utl$
as
  c_year_fmt  constant varchar2(4 char):='yyyy';
  c_ly_normal constant pls_integer     :=4;
  c_ly_extra1 constant pls_integer     :=100;
  c_ly_extra2 constant pls_integer     :=400;
  ------------------------------------------------------------------------------
  function is_leap_year(
      p_year in date)
    return boolean deterministic
  as
    l_year date not null:=p_year;
  begin
    return is_leap_year(to_number(to_char(l_year,c_year_fmt)));
  end is_leap_year;
--------------------------------------------------------------------------------
  function is_leap_year(
      p_year in pls_integer)
    return boolean deterministic
  as
    l_out boolean:=false;
  begin
    if mod(p_year,c_ly_normal)      =0 then
      if not(mod(p_year,c_ly_extra1)=0 and mod(p_year,c_ly_extra2)<>0) then
        l_out                      :=true;
      end if;
    end if;
    return l_out;
  end is_leap_year;
--------------------------------------------------------------------------------
  function leap_year(
      p_year in date)
    return pls_integer deterministic
  as
    $if sys.dbms_db_version.version >= 12 $then pragma udf;
    $end
  begin
    return
    case
    when is_leap_year(to_number(to_char(p_year,c_year_fmt))) then
      1
    else
      0
    end;
  end leap_year;
--------------------------------------------------------------------------------
  function leap_year(
      p_year in pls_integer)
    return pls_integer deterministic
  as
    $if sys.dbms_db_version.version >= 12 $then pragma udf;
    $end l_out pls_integer          :=0;
  begin
    if mod(p_year,c_ly_normal)      =0 then
      if not(mod(p_year,c_ly_extra1)=0 and mod(p_year,c_ly_extra2)<>0) then
        l_out                      :=1;
      end if;
    end if;
    return l_out;
  end leap_year;
--------------------------------------------------------------------------------
end utl$;