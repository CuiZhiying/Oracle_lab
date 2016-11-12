/*
 *  命名规则：
 *
 *  1. 文件名取***_#???,其中#为班级号如4班、5班分别为4或5，？？？为学
 *     号后3位，如oraexp_4101.txt(sql)，最后源文件名可
 *     取.txt或*.sql等
 *  2. 其它对象名如用户、表、视图、过程、触发器等按规则$$_***_#???,其中
 *     $$为对象类型标识码，如用户取名u,表取t,视图V，过程取P，触发器取
 *     TG；???为学号后三位，与文件名的命名规则类同。***可自己命名，不
 *     作强制要求，可以用英文简写法，也可以用中文拼音首字母。
 *     如T_STUD_4202, p_sumscore_4303,tg_STUD_ST_4021。
 *
 *  遇到的问题：
 *  1. 插入utf-8的中文内容在数据库中显示为乱码，且编译通不过
 *     select userenv('language') from dual;
 *  2. Oracle's deifference on "" and ''
 *  3. is references but not reference
 *
 */


clear screen
Connect system/cuizy940602

set linesize 200
set pagesize 200
drop user u_czy_5203 cascade;
Create User u_czy_5203 Identified by czy666;
Grant resource, connect, create view to u_czy_5203;


Connect u_czy_5203/czy666;

Create Table t_class_203(
    CNO       char(8),
    CNAME     varchar2(30),
    LOCATION  char(10) check( LOCATION in  ('北校区', '南校区', '新校区', '铁道校区', '湘雅校区') ),
    monitorNo char(10),
    HeadNo    char(10),
    primary key(CNO)
);

Create Table t_student_203(
    SNO       char(10) primary key,
    SNAME     varchar2(30),
    SEX       char(4) check( SEX in ('男', '女', '其他', '其它')),
    TEL       char(11),
    EMAIL     char(30) check( EMAIL like '%@%.%' ),
    CNO       char(8) ,
    BIRTHDAY  date check( to_date('19970831', 'yyyymmdd') - BIRTHDAY > 0 ),
    Constraint fk_studnet_203_CNO foreign key(CNO) references t_class_203(CNO)
);

-- 插入班级信息 --
insert into t_class_203(CNO, CNAME, LOCATION, monitorNo, HeadNo) 
    Values('09021405', '计算机1405班', '新校区',  '0902140505', '0902140107');
insert into t_class_203(CNO, CNAME, LOCATION, monitorNo, HeadNo) 
    Values('09021402', '计算机1402班', '铁道校区', '0902140205', '0902140107');
insert into t_class_203(CNO, CNAME, LOCATION, monitorNo, HeadNo) 
    Values('09021401', '计算机1401班', '新校区',  '0902140108', '0902140107');


-- 插入用户信息 -- 
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140503', '崔志颖', '男', '15111473415', 'csu_cu@163.com', to_date('19940602', 'yyyymmdd'), '09021405');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140501', '杨朝来', '男', '15111473425', 'csu_ci@163.com',   to_date('19941204', 'yyyymmdd'), '09021405');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140502', '马达',   '男', '15111473435', 'csu_ui@163.com',   to_date('19940602', 'yyyymmdd'), '09021405');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140504', '王丽',   '女', '15191473445', 'csucui@163.com',   to_date('19940602', 'yyyymmdd'), '09021405');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140505', '王丹',   '女', '15111473455', 'cs_cui@163.com',   to_date('19940602', 'yyyymmdd'), '09021405');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140506', '邓志勇', '男', '15111473465', 'cu_cui@163.com',   to_date('19940602', 'yyyymmdd'), '09021405');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140507', '尹会南', '男', '15111473475', 'su_cui@163.com',   to_date('19940602', 'yyyymmdd'), '09021405');


insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140201', '叶汝红', '女', '15111473441', 'csu_cui1@163.com',  to_date('19940602', 'yyyymmdd'), '09021402');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140202', '付伟娜', '女', '15111473442', 'csu_cui2@163.com',  to_date('19940602', 'yyyymmdd'), '09021402');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140203', '付双红', '女', '15111473443', 'csu_cui3@163.com',  to_date('19940602', 'yyyymmdd'), '09021402');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140204', '毕泗迁', '男', '15111473444', 'csu_cui4@163.com',  to_date('19940602', 'yyyymmdd'), '09021402');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140205', '毛华强', '男', '15111473445', 'csu_cui5@163.com',  to_date('19940602', 'yyyymmdd'), '09021402');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140206', '孙媛媛', '女', '15111473446', 'csu_cui6@163.com',  to_date('19940602', 'yyyymmdd'), '09021402');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140207', '伍婷',   '女', '15111473447', 'csu_cui7@163.com',  to_date('19940602', 'yyyymmdd'), '09021402');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140208', '阳娣',   '女', '15111473448', 'csu_cui8@163.com',  to_date('19940602', 'yyyymmdd'), '09021402');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140209', '刘海兵', '男', '15111473449', 'csu_cui9@163.com',  to_date('19940602', 'yyyymmdd'), '09021402');


insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140101', '刘启龙', '男', '15111473145', 'csu_1cui@163.com',  to_date('19940602', 'yyyymmdd'), '09021401');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140102', '刘勇辉', '男', '15111473245', 'csu_2cui@163.com',  to_date('19940602', 'yyyymmdd'), '09021401');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140103', '张建辉', '男', '15111573345', 'csu_3cui@163.com',  to_date('19940602', 'yyyymmdd'), '09021401');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140104', '李湘群', '男', '15111473445', 'csu_4cui@163.com',  to_date('19940602', 'yyyymmdd'), '09021401');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140105', '邵彩云', '女', '15111473545', 'csu_5cui@163.com',  to_date('19940602', 'yyyymmdd'), '09021401');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140106', '杨知',   '男', '15111473645', 'csu_6cui@163.com',  to_date('19940602', 'yyyymmdd'), '09021401');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140107', '杨巧敏', '女', '15111473745', 'csu_7cui@163.com',  to_date('19940602', 'yyyymmdd'), '09021401');
insert into t_student_203(SNO, SNAME, SEX, TEL, EMAIL, BIRTHDAY, CNO) 
    Values('0902140108', '罗美',   '女', '15111483845', 'csu_8cui@163s.com', to_date('19940602', 'yyyymmdd'), '09021401');


/*Alter Table stud_203  Add Constraint foreign key(CNO) reference class_203(CNO);*/
-- 插入信息后在添加外键约束，可以省很多麻烦呀 -- 
Alter Table t_class_203 Add Constraint fk_class_203_HeadNo    foreign key(HeadNo)    references t_student_203(SNO);
Alter Table t_class_203 Add Constraint fk_class_203_monitorNo foreign key(monitorNo) references t_student_203(SNO);

-- 按照SQL生成SQL，生成创建用户的代码，并保存在F盘下
set   echo     off
set   feedback off
set   heading  off
spool f:\build_user.sql
select 'Drop user U'||SNO||' cascade;'                     from t_student_203;
select 'Create user U'||SNO||' Identified by P'||SNO||';'  from t_student_203;
select 'Grant connect to U'||SNO||';'                      from t_student_203;
spool off
set   echo     on
set   feedback on
set   heading  on

-- 建立视图 --
connect u_czy_5203/czy666
Create view v_public_203 as select * from t_student_203 where user = 'U'||SNO 
    or user = (select 'U'||monitorNo from t_class_203 where t_student_203.CNO = t_class_203.CNO)
    or user = (select 'U'||HeadNo from t_class_203 where t_student_203.CNO = t_class_203.CNO);

-- 将视图的权限分配给所有的用户，即public
Grant select on v_public_203 to public;

-- 必须进入管理员进行创建用户，并且分配用户权限
connect system/cuizy940602
@f:\build_user.sql
-- 创建用户完毕

/*
 *  测试代码，检验不同种类的用户使用该视图的时候是否正常。
 */
connect U0902140203/P0902140203
select * from u_czy_5203.v_public_203;

connect U0902140505/P0902140505
select * from u_czy_5203.v_public_203;

connect U0902140107/P0902140107
select * from u_czy_5203.v_public_203;



/*
 * 实验2 建立在实验1的基础上
 *
 *
 *
 *
 */

connect u_czy_5203/czy666

Create Table t_attend_203(
    SNO         char(10),
    CNO         char(8),
    COURSE      varchar2(32),
    COURSE_DATE date,
    COURSE_NO   number(2),
    STATE       number(1)
        check(STATE in(0, 2, 5, 1))
);

Alter Table t_class_203   Add sum_evaluation number(8);
Alter Table t_student_203 Add sum_evaluation number(8);
Update t_class_203 set sum_evaluation = 0;
Update t_class_203 set sum_evaluation = 0;
Update t_student_203 set sum_evaluation = 100;
Update t_student_203 set sum_evaluation = 100;



Create Table t_stud_attend(
    SNO          char(10),
    S_START_DATE date,
    S_END_DATE   date,
    ZC           number(3),
    CD           number(3),
    KK           number(3),
    QJ           number(3),
    SUM_EVA      number(6)

);


Create Table t_class_attend(
    CNO          char(8),
    C_START_DATE date,
    C_END_DATE   date,
    ZC           number(4),
    CD           number(4),
    KK           number(4),
    QJ           number(4),
    SUM_EVA      number(7)
);


Create or Replace trigger tr_attend_203
    Before insert or update or delete on t_attend_203
    For each row

    Begin
        if inserting then
            Update t_student_203 set sum_evaluation = (sum_evaluation - :new.STATE)
            where :new.SNO = t_student_203.SNO;
        end if;
        if updating then
            Update t_student_203 set sum_evaluation = (sum_evaluation + :old.STATE - :new.STATE)
            where :old.SNO = t_student_203.SNO;
        end if;
        if deleting then
            Update t_student_203 set sum_evaluation = (sum_evaluation + :old.STATE)
            where :old.SNO = t_student_203.SNO;
        end if;
    End;

.
/


-- 测试代码，测试触发器是否有效 -- 
select * from t_student_203;

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140503', '09021405', '大型数据库', to_date('20161028', 'yyyymmdd'), 12, 0);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140503', '09021405', '大型数据库', to_date('20161028', 'yyyymmdd'), 34, 5);
select * from t_student_203;
update t_attend_203 set STATE = 2 where SNO = '0902140503';
select * from t_student_203;

delete from t_attend_203 where STATE = 2;
select * from t_student_203;

/*
 * 建立过程，生成某班级某时段（起、止日期）的考勤汇总表class_attend中各字段值，
 * 并汇总相应班级，将考勤分值的汇总结果写入到class表中的sum_evaluation中。
 *
 */

/*
 * plsql中procedure的入参类型，如果是number或varchar2的话不需要定义长度。否则编译不能通过。




     CREATE OR REPLACE PROCEDURE cursorvariabletest(p_table IN VARCHAR2) IS  
      TYPE t_emp_dept IS REF CURSOR; --定义游标变量类型  
      v_cursorvar t_emp_dept; --声明游标变量  
      
      v_empno emp.empno%TYPE;  
      v_ename emp.ename%TYPE;  
      v_job   emp.job%TYPE;  
      v_dname dept.dname%TYPE;  
      v_loc   dept.loc%TYPE;  
      
    BEGIN  
      IF p_table = 'emp' THEN  
        v_empno := 7369;  
        OPEN v_cursorvar FOR  
          SELECT ename, job FROM emp WHERE empno = v_empno; --打开游标变量  
      ELSE  
        IF p_table = 'dept' THEN  
          OPEN v_cursorvar FOR  
            SELECT dname, loc FROM dept; --打开游标变量  
        ELSE  
          raise_application_error(-20000, '请输入emp或dept!');  
        END IF;  
      END IF;  
      
      LOOP  
        IF p_table = 'emp' THEN  
          FETCH v_cursorvar  
            INTO v_ename, v_job;  
          EXIT WHEN v_cursorvar%NOTFOUND;  
          dbms_output.put_line('ename=' || v_ename || ',job=' || v_job);  
        ELSE  
          FETCH v_cursorvar  
            INTO v_dname, v_loc;  
          EXIT WHEN v_cursorvar%NOTFOUND;  
          dbms_output.put_line('dname=' || v_dname || ',loc=' || v_loc);  
        END IF;  
      END LOOP;  
      CLOSE v_cursorvar; --关闭游标变量  
    END;  

 */

 -- 创建存储过程，使用到了游标 -- 
Create or Replace Procedure p_class_attendence_203(start_date char, end_date char)
is
    TYPE class_cursor IS REF CURSOR;

    c_cno_203      class_cursor;
    temp_class_number t_class_203.CNO%TYPE;
    temp_sum_student  t_student_203.sno%TYPE;
    temp_sum_score    number(7);
    temp_zc           number(5);
    temp_cd           number(5);
    temp_qj           number(5);
    temp_kk           number(5);
Begin
    Open c_cno_203 For select CNO from t_class_203;
    Loop
        Fetch c_cno_203 Into temp_class_number;
        Exit When c_cno_203 % Notfound;
        select count(*) into temp_sum_score from t_class_203 where CNO = temp_class_number;
        select sum(STATE) into temp_sum_score from t_attend_203 where CNO = temp_class_number 
            and COURSE_DATE >= to_date(start_date, 'yyyymmdd') 
            and COURSE_DATE <= to_date(end_date, 'yyyymmdd');

        select count(*) into temp_zc from t_attend_203 where CNO = temp_class_number 
            and COURSE_DATE >= to_date(start_date, 'yyyymmdd') 
            and COURSE_DATE <= to_date(end_date, 'yyyymmdd')
            and STATE = 0;
        select count(*) into temp_cd from t_attend_203 where CNO = temp_class_number 
            and COURSE_DATE >= to_date(start_date, 'yyyymmdd') 
            and COURSE_DATE <= to_date(end_date, 'yyyymmdd')
            and STATE = 2;
        select count(*) into temp_qj from t_attend_203 where CNO = temp_class_number 
            and COURSE_DATE >= to_date(start_date, 'yyyymmdd') 
            and COURSE_DATE <= to_date(end_date, 'yyyymmdd')
            and STATE = 1;
        select count(*) into temp_kk from t_attend_203 where CNO = temp_class_number 
            and COURSE_DATE >= to_date(start_date, 'yyyymmdd') 
            and COURSE_DATE <= to_date(end_date, 'yyyymmdd')
            and STATE = 5;

        Insert into t_class_attend(c_start_date, c_end_date, sum_eva, CNO, ZC, CD, QJ, KK)
        Values(to_date(start_date, 'yyyymmdd'), to_date(end_date, 'yyyymmdd'), 
            nvl(-1 * temp_sum_score, 0), temp_class_number, nvl(temp_zc, 0), nvl(temp_cd, 0), nvl(temp_qj, 0), nvl(temp_kk, 0));
    End Loop;
    close c_cno_203;
End;
/

show errors;

-- 插入测试数据 --

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140503', '09021405', '大型数据库', to_date('20161028', 'yyyymmdd'), 12, 0);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140503', '09021405', '大型数据库', to_date('20161028', 'yyyymmdd'), 34, 1);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140503', '09021405', '大型数据库', to_date('20161028', 'yyyymmdd'), 56, 2);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140503', '09021405', '大型数据库', to_date('20161028', 'yyyymmdd'), 78, 5);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140503', '09021405', '大型数据库', to_date('20161029', 'yyyymmdd'), 12, 5);




insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140103', '09021401', '大型数据库', to_date('20161028', 'yyyymmdd'), 12, 2);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140103', '09021401', '大型数据库', to_date('20161028', 'yyyymmdd'), 34, 2);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140103', '09021401', '大型数据库', to_date('20161028', 'yyyymmdd'), 56, 5);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140103', '09021401', '大型数据库', to_date('20161028', 'yyyymmdd'), 78, 0);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140103', '09021401', '大型数据库', to_date('20161029', 'yyyymmdd'), 12, 2);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140103', '09021401', '大型数据库', to_date('20161029', 'yyyymmdd'), 12, 0);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140103', '09021401', '大型数据库', to_date('20161029', 'yyyymmdd'), 34, 5);





insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140203', '09021402', '大型数据库', to_date('20161028', 'yyyymmdd'), 12, 0);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140203', '09021402', '大型数据库', to_date('20161028', 'yyyymmdd'), 34, 5);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140203', '09021402', '大型数据库', to_date('20161028', 'yyyymmdd'), 56, 0);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140203', '09021402', '大型数据库', to_date('20161028', 'yyyymmdd'), 78, 5);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140203', '09021402', '大型数据库', to_date('20161029', 'yyyymmdd'), 12, 0);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140203', '09021402', '大型数据库', to_date('20161029', 'yyyymmdd'), 34, 5);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140203', '09021402', '大型数据库', to_date('20161029', 'yyyymmdd'), 56, 0);

insert into t_attend_203(SNO, CNO, COURSE, COURSE_DATE, COURSE_NO, STATE)
    Values('0902140203', '09021402', '大型数据库', to_date('20161029', 'yyyymmdd'), 34, 5);


-- 测试存储过程 
execute p_class_attendence_203(19940602, 20170101);
select * from t_class_attend;

