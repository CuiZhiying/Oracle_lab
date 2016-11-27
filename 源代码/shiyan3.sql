conn scott/tiger

set linesize 5000;
set pagesize 5000;

@f:\insert_name.txt
clear screen;

/*
 *  ������һ����������student����
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
 * ������4�����������ɱ��
 * ÿ��101��136������01��36��Ŀ����Ϊ�˲��ò��㳤��
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
    -- ������һ���α������в��������ɵ����ݼ�̫���ˣ�������α��ϵ�������Ӧ�������ģ���̨������ִ��
    -- ����ʹ�õĵѿ����˻������ɴ���������
    Cursor c_new_name is 
        select s1.xing||s2.ming||s3.zi from 
        (select distinct( substr(sname, 1, 1)) xing from sname )s1,     --108
        (select distinct( substr(sname, 2, 1)) ming from sname )s2,     --888
        (select distinct( substr(sname, 3, 1)) zi   from sname )s3;

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
 *  ���½���һ��������������������ݣ��������������������Ļ���������ȫһ����
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
        (select distinct( substr(sname, 1, 1)) xing from sname)s1,    --572    --108
        (select distinct( substr(sname, 2, 1)) ming from sname)s2,    --14111  --888
        (select distinct( substr(sname, 3, 1)) zi   from sname)s3;

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

/*
 *

CREATE TABLE rooms (
  room_id          NUMBER(5) PRIMARY KEY,
  building          VARCHAR2(15),
  room_number      NUMBER(4),
  number_seats      NUMBER(4),
  description        VARCHAR2(50)
 )
PARTITION BY RANGE (room_id)
SUBPARTITION BY HASH (number_seats)
SUBPARTITIONS 2
(PARTITION rooms_1 VALUES LESS THAN (30000),
PARTITION rooms_2 VALUES LESS THAN (60000),
PARTITION rooms_3 VALUES LESS THAN (maxvalue))�� 

 *
 *  ����һ���������ٲ������ݣ�����һ���������ı�students_with_partion
 */

drop table students_with_partion;
Create table students_with_partion(
    Sno      char(10),
    Sname    varchar(10),
    Sex      char(1),
    Email    varchar(30) not null,
    Tel      char(9) not null,
    Birthday date check(to_date('19900101', 'YYYYMMDD') <= birthday and 
                        to_date('19970831', 'YYYYMMDD') >= birthday ),
    primary key(sno)
)
PARTITION BY RANGE(Sno)
(
    PARTITION students_0  VALUES LESS THAN ('0199999999'),
    PARTITION students_1  VALUES LESS THAN ('0299999999'),
    PARTITION students_2  VALUES LESS THAN ('0399999999'),
    PARTITION students_3  VALUES LESS THAN ('0499999999'),
    PARTITION students_4  VALUES LESS THAN ('0599999999'),
    PARTITION students_5  VALUES LESS THAN ('0699999999'),
    PARTITION students_6  VALUES LESS THAN ('0799999999'),
    PARTITION students_7  VALUES LESS THAN ('0899999999'),
    PARTITION students_8  VALUES LESS THAN ('0999999999'),
    PARTITION students_9  VALUES LESS THAN ('9999999999')
);

select systimestamp from dual;

-- select count(distinct( substr(sname, 1, 1))) xing from sname;
-- select count(distinct( substr(sname, 2, 1))) xing from sname;
-- select count(distinct( substr(sname, 3, 1))) xing from sname;

Declare
    temp_name  varchar(10);
    temp_AB    number(3);
    temp_CD    number(3);
    temp_EF    number(3);
    temp_GH    number(3);
    Cursor c_new_name is 
        select s1.xing||s2.ming||s3.zi from 
        (select distinct( substr(sname, 1, 1)) xing from sname)s1,    -- 572
        (select distinct( substr(sname, 2, 1)) ming from sname)s2,    -- 1504
        (select distinct( substr(sname, 3, 1)) zi   from sname)s3;    -- 1203
                                                                      -- 1034926464

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
                    insert into students_with_partion(sno, sname, Sex, birthday, Email, Tel) values(
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

-- 
select count(*) from students where sex = 0;
select systimestamp from dual;
-- ����λͼ���� bitmap index -- 
create bitmap index bit_ind on students(sex);
select systimestamp from dual;
select count(*) from students where sex=0;


select systimestamp from dual;

-- ͳ����û�н����������Ա�ͳ��
select count(*) from students where substr(sname, 1, 1) = '��';
select systimestamp from dual;
Create index index_sname on students(sname); 
select systimestamp from dual;
select count(*) from students where substr(sname, 1, 1) = '��';
select systimestamp from dual;
-- 

-- ������ѯ
-- SELECT * FROM students PARTITION��history��ss    WHERE ss.current_credits=12  