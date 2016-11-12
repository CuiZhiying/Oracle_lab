clear screen;
conn system/cuizy940602
set linesize 5000;
set pagesize 5000;

-- ���ٲ���Ҫ����Ϣ --
set echo off;
set feedback off;
set heading off;

-- Sql ���� SQL -- 
spool f:\make_record.sql
select 'select * from '||tname||' where rownum <= 5;'
    from PUBLICSYN where tname like 'DBA%';
spool off;

set echo on;
set feedback on;
set heading on;
spool f:\result_of_five_record.txt
@f:\make_record.sql;
spool off;


/*
 * ���û����������еĴ���������Scott/tigerΪʵ��
 * ALTER TIGGER trigger_name [DISABLE | ENABLE ];
 * SELECT trigger_name,table_owner,table_name FROM user_triggers;
 */

conn scott/tiger;
set linesize 5000;
set pagesize 5000;
set echo off;
set feedback off;
set heading off;
spool f:\shiyan4_disable_triger.sql
select 'ALTER TIGGER '||trigger_name||' DISABLE;' FROM user_triggers;
spool off
set echo on;
set feedback on;
set heading on;
@f:\shiyan4_disable_triger.sql


set echo off;
set feedback off;
set heading off;
spool f:\shiyan4_enable_triger.sql
select 'ALTER TIGGER '||trigger_name||' ENABLE;' FROM user_triggers;
set echo on;
set feedback on;
set heading on;
@f:\shiyan4_enable_triger.sql
