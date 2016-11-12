conn scott/tiger

set linesize 5000;
set pagesize 5000;

@f:\insert_name.txt
clear screen;

/*
 *  创建了一个表来存存放student数据
 *
 */
drop table students;
Create table students(
    Sno      char(10),
    Sname    varchar(10),
    Sex      char(1),
    Email    varchar(30) not null,
    Tel      char(9) not null,
    Birthday date check(to_date('19900101', 'YYYYMMDD') <= birthday and 
                        to_date('19970831', 'YYYYMMDD') >= birthday )
);


--ABCD14EFGH

/*
 * 创建了4个序列来生成编号
 * 每个101到136来代替01到36的目的是为了不用补足长度
 */
drop SEQUENCE SEQ_AB;
Create SEQUENCE SEQ_AB
INCREMENT by 1
START WITH 101
MAXVALUE 200 MINVALUE 101
CYCLE;
/

drop SEQUENCE SEQ_CD;
Create SEQUENCE SEQ_CD
INCREMENT by 1
START WITH 101
MAXVALUE 200 MINVALUE 101
CYCLE;
/


drop SEQUENCE SEQ_EF;
Create SEQUENCE SEQ_EF
INCREMENT by 1
START WITH 101
MAXVALUE 137 MINVALUE 101
CYCLE;
/

drop SEQUENCE SEQ_GH;
Create SEQUENCE SEQ_GH
INCREMENT by 1
START WITH 101
MAXVALUE 137 MINVALUE 101
CYCLE;
/


set echo on;
set heading on;
set feedback on;

select systimestamp from dual;

Declare
    temp_name  varchar(10);
    temp_AB    number(3);
    temp_CD    number(3);
    temp_EF    number(3);
    temp_GH    number(3);
    -- 建立了一个游标来进行操作，生成的数据集太大了，在这个游标上电脑无响应是正常的，后台程序在执行
    -- 这里使用的笛卡尔乘积，生成大量的名字
    Cursor c_new_name is 
        select s1.xing||s2.ming||s3.zi from 
        (select distinct( substr(sname, 1, 1)) xing from sname where )s1,     --108
        (select distinct( substr(sname, 2, 1)) ming from sname where )s2,     --888
        (select distinct( substr(sname, 3, 1)) zi   from sname where )s3;

Begin
    Open c_new_name;
    select SEQ_AB.Nextval into temp_AB from dual;
    select SEQ_CD.Nextval into temp_CD from dual;
    select SEQ_EF.Nextval into temp_EF from dual;
    select SEQ_GH.Nextval into temp_GH from dual;

    While temp_AB <> 200 and temp_CD <> 200 and temp_EF <> 137 and temp_GH <> 137 Loop
        While temp_CD <> 200 and temp_EF <> 137 and temp_GH <> 137 Loop
            While temp_EF <> 137 and temp_GH <> 137 Loop
                While temp_GH <> 137 Loop
                    Fetch c_new_name into temp_name;
                    Exit When c_new_name % Notfound;
                    insert into students(sno, sname, Sex, birthday, Email, Tel) values(
                        substr( to_char(temp_AB), 2)|| substr( to_char(temp_CD), 2) ||'14'||substr( to_char(temp_EF), 2)||substr( to_char(temp_GH), 2),
                        temp_name,
                        round(dbms_random.value),
                        to_date(TRUNC(DBMS_RANDOM.VALUE(to_number(to_char(to_date('19900101',  'yyyymmdd'), 'J')),  
                                                        to_number(to_char(to_date('19970831', 'yyyymmdd')+1, 'J'))
                                                        )
                                     ),  'J'),
                        dbms_random.string('a', 6)||'@'||dbms_random.string('a',3)||'.com',
                        lpad(round(dbms_random.value(1,999999999)),9,0)
                        );
                    select SEQ_GH.Nextval into temp_GH from dual;
                End Loop;
                select SEQ_EF.Nextval into temp_EF from dual;
                select SEQ_GH.Nextval into temp_GH from dual;
            End Loop;
            select SEQ_CD.Nextval into temp_CD from dual;
            select SEQ_EF.Nextval into temp_EF from dual;
            select SEQ_GH.Nextval into temp_GH from dual;
        End Loop;
        select SEQ_AB.Nextval into temp_AB from dual;
        select SEQ_CD.Nextval into temp_CD from dual;
        select SEQ_EF.Nextval into temp_EF from dual;
        select SEQ_GH.Nextval into temp_GH from dual;
    End Loop;
    Close c_new_name;
End;
/

select systimestamp from dual;

select count(sno) from students;

select systimestamp from dual;

/*
 *  重新建立一个表来插入带主键的数据，下面的匿名过程与上面的基本上是完全一样的
 */
drop table students_with_key;
Create table students_with_key(
    Sno      char(10),
    Sname    varchar(10),
    Sex      char(1),
    Email    varchar(30) not null,
    Tel      char(9) not null,
    Birthday date check(to_date('19900101', 'YYYYMMDD') <= birthday and 
                        to_date('19970831', 'YYYYMMDD') >= birthday ),
    primary key(sno)
);


Declare
    temp_name  varchar(10);
    temp_AB    number(3);
    temp_CD    number(3);
    temp_EF    number(3);
    temp_GH    number(3);
    Cursor c_new_name is 
        select s1.xing||s2.ming||s3.zi from 
        (select distinct( substr(sname, 1, 1)) xing from sname where )s1,    --572    --108
        (select distinct( substr(sname, 2, 1)) ming from sname where )s2,    --14111  --888
        (select distinct( substr(sname, 3, 1)) zi   from sname where )s3;

Begin
    Open c_new_name;
    select SEQ_AB.Nextval into temp_AB from dual;
    select SEQ_CD.Nextval into temp_CD from dual;
    select SEQ_EF.Nextval into temp_EF from dual;
    select SEQ_GH.Nextval into temp_GH from dual;

    While temp_AB <> 200 and temp_CD <> 200 and temp_EF <> 137 and temp_GH <> 137 Loop
        While temp_CD <> 200 and temp_EF <> 137 and temp_GH <> 137 Loop
            While temp_EF <> 137 and temp_GH <> 137 Loop
                While temp_GH <> 137 Loop
                    Fetch c_new_name into temp_name;
                    Exit When c_new_name % Notfound;
                    insert into students_with_key(sno, sname, Sex, birthday, Email, Tel) values(
                        substr( to_char(temp_AB), 2)|| substr( to_char(temp_CD), 2) ||'14'||substr( to_char(temp_EF), 2)||substr( to_char(temp_GH), 2),
                        temp_name,
                        round(dbms_random.value),
                        to_date(TRUNC(DBMS_RANDOM.VALUE(to_number(to_char(to_date('19900101',  'yyyymmdd'), 'J')),  
                                                        to_number(to_char(to_date('19970831', 'yyyymmdd')+1, 'J'))
                                                        )
                                     ),  'J'),
                        dbms_random.string('a', 6)||'@'||dbms_random.string('a',3)||'.com',
                        lpad(round(dbms_random.value(1,999999999)),9,0)
                        );
                    select SEQ_GH.Nextval into temp_GH from dual;
                End Loop;
                select SEQ_EF.Nextval into temp_EF from dual;
                select SEQ_GH.Nextval into temp_GH from dual;
            End Loop;
            select SEQ_CD.Nextval into temp_CD from dual;
            select SEQ_EF.Nextval into temp_EF from dual;
            select SEQ_GH.Nextval into temp_GH from dual;
        End Loop;
        select SEQ_AB.Nextval into temp_AB from dual;
        select SEQ_CD.Nextval into temp_CD from dual;
        select SEQ_EF.Nextval into temp_EF from dual;
        select SEQ_GH.Nextval into temp_GH from dual;
    End Loop;
    Close c_new_name;
End;
/

select systimestamp from dual;
select count(sno) from students_with_key;
select systimestamp from dual;


select * from students where sname = '赵韵';
select systimestamp from dual;
Create index id_sname on students(sname); 
select systimestamp from dual;
select * from students where sname = '赵韵';
select systimestamp from dual;

