--***************************
-- PLUTIL INSTALLATION SCRIPT
--***************************
clear screen;
set scan off;
prompt => Set plsql_optimize_level to 3
alter session set plsql_optimize_level=3;
alter session set plsql_warnings = 'ENABLE:ALL', 'DISABLE:(6005,7206)';
prompt => Install Package Specification
@@source/plutil.pks
prompt => Install Package Body
@@source/plutil.pkb
prompt => Compile in native mode
alter package plutil compile plsql_code_type=native;
prompt => Grant to public
grant execute on plutil to public;
exit
