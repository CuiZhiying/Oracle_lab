set echo on;
conn scott;
clear screen;
set linesize 5000;
set pagesize 5000;
select * from user_tables;
set echo off;
set heading off;
set feedback off;
spool f:\select_five_record_of_user_table.txt
select 'select * from '||table_name||' where rownum<=5; '
    from user_tables;
spool off;
@f:\select_five_record_of_user_table.txt;