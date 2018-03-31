--***************************
-- PLUTIL INSTALLATION SCRIPT
--***************************
set scan off;
prompt => Start installation process
@@plutil.pks
@@plutil.pkb
prompt => Compile in native mode
alter package plutil compile plsql_code_type=native;
prompt => Grant to public
grant execute on plutil to public;
exit
