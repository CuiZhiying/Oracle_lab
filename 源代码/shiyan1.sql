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
