create or replace package utl$
as
  -- check if date is a leap year
  function is_leap_year(
      p_year in date)
    return boolean deterministic;
  -- check if year is a leap year
  function is_leap_year(
      p_year in pls_integer)
    return boolean deterministic;
  -- check if date is a leap year
  function leap_year(
      p_year in date)
    return pls_integer deterministic;
  -- check if year is a leap year
  function leap_year(
      p_year in pls_integer)
    return pls_integer deterministic;
end utl$;