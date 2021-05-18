/*
[1���� ����]
1. ����Ŭ ����Ʈ���� �ٿ�ε�
https://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html

2. Oracle Database 11g Release 2 Express Edition for Windows 64 (���ἳġ)

3. Oracle ��ġ(SYS, SYSTEM ������ ���� ��ȣ : 1004)

4.Sqlplus ���α׷� ����(CMD) : GUI ȯ�� �Ϲݰ����� ��� ����

5.������ Tool ��ġ ����(SqlDeveloper , https://dbeaver.io/)  ,
                 ����(��� , ������ , SqlGate) ������Ʈ�� ��ġ Ȱ�� ^^

6. SqlDeveloper ���� ���ؼ� Oracle Server ���� ....
   >> HR ���� : ��ȣ 1004 , Unlock 2���� ��밡�� .... (������� �ǽ� ���̺�)
   >> ���ο� ���� : BITUSER


7. ���� ���� ���� Ȯ�� : show user;   >> USER��(��) "BITUSER"�Դϴ�.


-- USER SQL
CREATE USER "BITUSER" IDENTIFIED BY "1004"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS

-- ROLES
GRANT "CONNECT" TO "BITUSER" WITH ADMIN OPTION;
GRANT "RESOURCE" TO "BITUSER" WITH ADMIN OPTION;
ALTER USER "BITUSER" DEFAULT ROLE "CONNECT","RESOURCE";

-- SYSTEM PRIVILEGES


*/

/*
�ǽ��ڵ�

CREATE TABLE EMP
(EMPNO number not null,
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
MGR number ,
HIREDATE date,
SAL number ,
COMM number ,
DEPTNO number );
--alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800,null,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,200,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,'1981-04-02',2975,30,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,300,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,'1981-04-01',2850,null,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,'1981-06-01',2450,null,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,'1982-10-09',3000,null,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',null,'1981-11-17',5000,3500,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,'1983-01-12',1100,null,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,'1981-10-03',950,null,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,'1981-10-3',3000,null,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,'1982-01-23',1300,null,10);

COMMIT;

CREATE TABLE DEPT
(DEPTNO number,
DNAME VARCHAR2(14),
LOC VARCHAR2(13) );

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

COMMIT;



CREATE TABLE SALGRADE
( GRADE number,
LOSAL number,
HISAL number );

INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
COMMIT;

*/

/* 
��� ������ ������ �� �ִ� ������ ������ ����ڴ�.
*/

-- 1. ������̺��� ��� �����͸� ����ϼ���.
--[������]�� [��ҹ���]�� �������� �ʴ´�.
select * from emp;
SELECT * FROM EMP;

--2. Ư�� �÷� ������ ����ϱ�
select empno, ename, sal
from emp;

--3. �÷��� ����Ī(alias/ ��Ī) �ο��ϱ�
select empno ���, ename �̸�
from emp;

--SQL(�����͸� �ٷ�� ������ ����Ʈ��� �ִ�) >> ǥ���� ������ >> ANSI ����
--as"��   ��" ��а� ǥ�ع����̴�.
--mysql, MS-SQL ���� �����ϰ� �Ʒ� ������ �����Ѵ�.
select empno as "��   ��", ename as "��    ��"
from emp;

--Oracle ������: [���ڿ� ������]�� �����ϰ� [��ҹ���]�� �����Ѵ�.
--JAVA: ����-> 'A' , ���ڿ�->"AAA"
--Oracle: ���ڿ� 'A', 'AAA'
--Oracle: A �� a�� �ٸ� �����̴�.
select empno, ename
from emp
where ename='king'; --������ (king�� ����... KING������)

select empno, ename
from emp
where ename='KING';

/*
select ��  3
from ��    1
where ��   2
*/

--Oracle Query(���Ǿ�): ���
--�����ڰ� �ִ�. (���տ����� || , ��������� + )
--java: + �����϶��� �������, �����϶��� ���տ����̿���!
--Tip) Ms-sql �� +�� ����, ��� �Ѵ� �Ѵ�.

select '����� �̸��� ' || ename || '�Դϴ�.' as "�������"
from emp;

--���̺��� �÷� >> Ÿ��
--java class Emp {private int empno, private String ename}
--Oracle create table emp (empno number)
--Ÿ��(�÷�): ����, ���ڿ�, ��¥
--create table emp (ename varchar2(10));
--(10) -> 10Byte >> �ѱ� 1�� 2Byte / ������, Ư������, ���� 1Byte
--�ѱ� 5��, ������ 10�� �Է� ����

desc emp;

--����ȯ (���������� �ڵ� ����ȯ�� �Ͼ ��(����->���ڿ�) �������ش�.)
select empno || ename
from emp;
-- �Ʒ� �ڵ�� ��������. (ORA-01722: invalid number / ���� '+' ���ڿ� �Ұ�)
select empno + ename
from emp;

--���߽� �ٹ���...
--����� say "�츮ȸ�翡 ������ ��� �ֳ�?"
select job from emp; --�̷��� �����ָ� �ȵ� ...
--�ߺ� �����͸� �����ϴ� Ű����(�����): distinct
select distinct job
from emp;
--distinct�� ����: grouping

select distinct job, deptno 
from emp
order by job; 
--job���� group, �� �ȿ� �ٽ� deptno�� group 1�Ǿ�(�ߺ����� �ʴ� �����͸� �׷���)

select distinct  deptno, job
from emp
order by deptno;

--Oracle sql ������ 
--�ڹ� ( +, -, *, /, % )
--Oracle : %�� �����ڷ� ������� �ʴ´� >> �Լ� Mod()

--������̺��� ����� �޿��� 100�޶� �λ��� ����� ����ϼ���.

select empno, ename, sal, sal + 100 as "�λ�޿�"
from emp;

--dual �ӽ� ���̺�(����)
select 100 + 100 from dual; --������ �׽�Ʈ�� �̿��Ѵ�.
select 100 || 100 from dual; --100100
select '100' + 100 from dual; --200 (����ȯ) >> '100' ������ ����(����ȯ�� ���ڰ� �Ǵ� ������)
select 'A100' + 100 from dual; -- ���� >> ORA-01722: invalid number

--�� ������
-- <  >  <=  >= ���..
--����
--java: == ���� / = �Ҵ�
--javascript: ==, === ����
--Oracle: = ���� / != �����ʴ�

--�� ������
--AND, OR, NOT

select empno, ename, sal
from emp;

select empno, ename, sal
from emp
where sal >= 2000;

--����� 7788���� ����� ���, �̸�, ����, �Ի����� ����غ�����
select empno, ename, job, hiredate   --3
from emp                             --1
where empno=7788;                    --2

/*
������: select (70%), insert, update, delete (CRUD)
������: ����ϰ� ����, ���(��Ʈ��ũ, ����) ����, ���� (����ڱ���.. ��ȣȭ)
Ʃ��(����Ʃ��, �ϵ����): ����Ʃ��(�ӵ�) -> �ð� �ܰ�
����(�𵨷�): ���� (�䱸���� ����, �м�) DB-Modeling : domain (����)
*/

--����� �̸��� king�� ����� ���, �̸�, �޿� ������ ����ϼ���.
select empno, ename, sal
from emp
where ename='KING';

--�޿��� 2000�޷� �̻��̸鼭, ������ manager�� ����� ��� ������ ����ϼ���
--hint: AND, OR
select *
from emp
where sal>=2000 AND job='MANAGER'; -- AND�� ��� ���ǿ� ����

/*   AND   OR
0 0   0     0
0 1   0     1
1 0   0     1
1 1   1     1
*/

--�޿��� 2000�޷� �̻��̰ų� �Ǵ� ������ manager�� ����� ��� ������ ����ϼ���
select *
from emp
where sal>=2000 OR job='MANAGER';


INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');
COMMIT;

select * from dept;

-- ������ Ŀ�Ա��� ���������� ���
delete from dept;
commit;

-- ����Ŭ ��¥ (DB������ ��¥)
-- ����Ŭ ��¥ Ű���� (sysdate)

select sysdate from dual; --21/03/02
-- ����Ŭ�� ��ġ�Ǿ��ִ� PC�� �ð�(�����ð�)

--��� �ý����� ��¥�� �ʼ��� �����Ǿ��ִ�.
--ex) �Խ��� 
--insert into board(writer, title, content, regdate)
--values('ȫ�浿', '�氡', '������', sysdate)
--regdate �÷��� ������ ������ �ð��� ���ڴ�.
--Tip) ms-sql : select getdate()

--����Ŭ ������ ������ �ִ� ��¥ ȯ�� ����
select * from nls_session_parameters;
--    �÷���            ������
--NLS_DATE_FORMAT	 RR/MM/DD
--NLS_DATE_LANGUAGE  KOREAN
--NLS_TIME_FORMAT	 HH24:MI:SSXFF

--2021-03-02 ���·� �ٲٰ� �ʹ�.
--##���� ������ ���� ����Ŭ�� ������ ������� �۾�ȯ�濡���� �ٲ�� ���̴�.##
--so, ������ �����ٰ� �翬���ϸ� ���� ���·� �����ȴ�.
--  (= ���� session���� �ݿ��ȴ�)
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
--NLS_DATE_FORMAT	YYYY-MM-DD HH24:MI:SS

select sysdate from dual; --2021-03-02 14:10:10

select hiredate from emp; --1980-12-17 00:00:00

select *
from emp
where hiredate='1980-12-17'; --��¥ �����͵� ���ڷ� ����Ѵ�.

select *
from emp
where hiredate='1980/12/17'; --�̷��Ե� ��� ����!!

-- 2019.12.17�� ��� ����... ������ �ǵ��� ������� ����.

select *
from emp
where hiredate='80/12/17'; -- ���� ���˰� ��ġ���� �����Ƿ� ��� �Ұ�.


-- ����� �޿��� 2000�̻��̰�, 4000������ ��� ����� ������ ����ϼ���
select *
from emp
where sal >= 2000 and sal <= 4000;

--������: �÷��� between A and B (=�� �����Ѵ�)
select *
from emp
where sal between 2000 and 4000;

-- ����� �޿��� 2000�ʰ��̰�, 4000�̸��� ��� ����� ������ ����ϼ���
-- �ʰ�, �̸��� ��� between ��� �Ұ�!
-- where sal > 2000 and sal < 4000;


--�μ� ��ȣ�� 10�� �Ǵ� 20�� �Ǵ� 30���� ����� ���, �̸�, �޿�, �μ���ȣ�� ����ϼ���.
select empno, ename, sal, deptno
from emp;

--������ ( 'IN' -> ���� or ���� or .....)
select empno, ename, sal, deptno
from emp
where deptno in (10,20,30); -- where deptno=10 or deptno=20 or deptno=30; �� ���� �ǹ�

--�μ� ��ȣ�� 10�� �Ǵ� 20���� �ƴ� ����� ���, �̸�, �޿�, �μ���ȣ�� ����ϼ���
select empno, ename, sal, deptno
from emp
where deptno!=10 and deptno!=20;

-- IN ���� ������: NOT IN -> �������� and �������� and...
select empno, ename, sal, deptno
from emp
where deptno not in (10, 20); -- where deptno!=10 and deptno!=20; �� ����.

--POINT: Oracle���� ���� ����(=�����Ͱ� ����) >> null
--�ʿ�� (null)

create table member(
  userid varchar2(20) not null, --null�� ������� �ʰڴ� (�ʼ� �Է�)
  name varchar2(20) not null, --�ʼ��Է�
  hobby varchar2(50) --default null (�⺻������ null ���) �����Է�
);

select * from member;
-- ȸ������ ����
insert into member(userid,hobby) values('hong','��'); -- ����(�Ұ�)
-- ORA-01400: cannot insert NULL into ("BITUSER"."MEMBER"."NAME")
insert into member(userid,name) values('hong','ȫ�浿');
-- hobby�÷��� ������: null�� ä������.


--POINT (Insert, Update, Delete)
--���� �ݿ��� ���ؼ��� �ݵ�� commit ����� ���� (rollback)

commit;

select * from member;

--������ �����ϱ�
delete from member;
commit;


--����(comm)�� ���� �ʴ� ��� ����� ������ ����ϼ���
-- 0�� �������̴�.(�޴� ������ ����)
select comm from emp;
-- ��, comm�÷��� �����Ͱ� null�� �͸� ����Ͻÿ�

select *
from emp
where comm = null; -- �̷� ������ ����� ..

-- null�񱳴� (is null. is not null)�� �ؾ��Ѵ�. ##�ϱ�##
select * from emp
where comm is null;

-- ����(comm)�� �޴�(null�� �ƴ�) ��� ����� ������ ����ϼ���
select * from emp
where comm is not null;

--������̺��� ���, �̸�, �޿�, ����, �ѱ޿��� ����ϼ���
--�ѱ޿�(�޿�+����)
select empno, ename, sal, comm, sal+comm as "�ѱ޿�"
from emp;

--POINT ##
--1. null ���� ��� ���� ����� :null ex) 100+null = null / 100-null = null
--2. �� ���� �ذ�: nvl(), nvl2()
--nvl(�÷���, ��ü��) >> �ش� �÷����� null�� ������ ��ü������ ġȯ�ؼ� �����ض�.
--Tip) MS-SQL: null > convert()
--Tip) mysql: null < IFNULL()

select empno, ename, sal, comm, sal+nvl(comm,0) as "�ѱ޿�"
from emp;
-- sal+nvl(comm,0) 
-->> comm �÷����� null�����͸� ������ 0���� ġȯ�ؼ� sal�� ���ض�.

select 1000 + null from dual; -- �Ұ�
select 1000 + nvl(null,100) from dual;
select comm, nvl(comm,111111) from emp;

--����� �޿��� 1000�̻��̰�, ������ ���� �ʴ� ����� ���, �̸�, ����, �޿�, ������ ����ϼ���
select empno, ename, job, sal, comm
from emp
where sal>=1000 and comm is null;

--DQL(data query language): select ��
--DDL(���Ǿ�): creat, alter, drop (Table emp, dept) ��ü��� �θ���.
--DML(���۾�): insert, update, delete 
--  ��-> �ݵ�� �۾� �� �ǹݿ��ϰ������ commit, �۾��� ����ϰ������ rollback ����� �Ѵ�.

--create table board (boardno number ...)
--JAVA: class board (private int boardno) �� ������..

create table Board(
    boardid number not null, --����, �ʼ� �Է�
    title varchar2(50) not null, --������(�ѱ� 25��, ������ 50��), �ʼ��Է�
    content varchar2(2000) not null, --�۳���(�ѱ�1000��, ������2000��), �ʼ��Է�
    hp varchar2(20) --default null �ʼ� �Է��� �ƴϴ� (null ���)
);


select * from USER_TAB_COLUMNS where table_name='BOARD';
desc board;
/*
--dbeaver
SELECT * 
FROM ALL_ALL_TABLES  WHERE TABLE_NAME ='BOARD';

--dbeaver  ����� �÷� ���� ����
SELECT * 
FROM ALL_TAB_COLUMNS WHERE TABLE_NAME ='BOARD';
*/

--create, alter, drop >> commit, rollback(x)
--commit, rollback (insert, update, delete) �۾��ø� �ǹݿ�, ��� ����

select * from board;

insert into board(boardid, title, content)
values (100, '����Ŭ', '�Ǽ��߳�'); -- commit�� ������ �޸𸮿� �ۼ����� ���� ��
-- ���� �����͸� �߸� �־��� -> rollback �ϸ� insert������ ���ư���.
rollback;

insert into board(boardid, title, content)
values (100, '����Ŭ', '�Ҹ��ϳ� ^^');
commit; -- ������ �ݿ� (��ǻ�� ���� �ѵ� �����ִ�)
--## commit�� ������ rollback �Ұ� ##

/*
##Tip) MS-SQL: auto commit�� default
insert into emp(empno) values(100); -- �ڵ�Ŀ��

begin
    insert into emp(empno) values(100); -- �� �۾� �Ұǵ�, �� ��� ��ٷ���
    
begin���� ���� > ���� commit, rollback �Ҷ����� ��ٷ���

##TIP: Oracle�� �����ڰ� commit, rollback ��ɾ �����ϱ� ������ �ǹݿ����� �ʴ´�.
*/

select * from board;

insert into board(boardid, title, content)
values(200,'�ڹ�','�׸���');

insert into board(boardid, title, content)
values(300,'�ڹ�','������ ������');

select * from board;
-- rollback ����: commit �� �� (�� �ڷ� 1000���� �־ �ѹ��ϸ� ���� ��ҵȴ�)
rollback;
/*
..... �۾�
commit; �ǹݿ�
.....
.....
.....
rollback; ��� ��� -> Ŀ�� ���ķ� ���� ��ҵȴ�!
*/

select boardid, title, content, nvl(hp,'EMPTY') as "HP" 
                                -- ��> hp�÷����� null���� ������ 'EMPTY'�� �ٲ㼭 ����ϰڴ�.
from board; -- nvl : ����, ����, ��¥ �� ����ȴ�.

--���ڿ� �˻�
--�ּҰ˻�: �˻��� �Է½� '����'�̶�� �˻��ϸ�, �ش� �ܾ ���Ե� ��� �ּҰ� �� ���´�.
--LIKE ���� �˻�
--���ڿ� ���� �˻�(LIKE ������)

--like ������
--���ϵ�ī�� ����
--1. % (��� ��)
--2. _ (�ѹ���)
--���� ������ ����
--�˻�� �������̴�. >> ���� �˻��� ���� ����ǥ������ �����ߴ�.
-- java������ ����ǥ���İ� �����ϴ�.

select *
from emp
where ename like '%A%'; -- ename �÷��� �����Ͱ� A�� �����ϸ� �� �������
--where ename like '%a%'; -- �Ұ� (���ϰ˻��� ��ҹ��ڸ� �����ϰ� �����Ѵ�)
--where ename like 'A%'; -- �̸��� A�� �����ϴ� ��� ��� �������
--where ename like '%E'; -- �̸��� E�� ������ ��� ��� �������

--ex) �����̶�� �ܾ ����ִ� �ּҸ� �� ã�ƶ�
--select *
--from zip
--where dong like '%����%'

select *
from emp
where ename like '%LL%'; --AllEN, MILLER

select *
from emp
where ename like '%A%A%'; --ADAMS (�̸��� A�� �ΰ� ��������� ���)

select *
from emp
where ename like '_A%'; --�̸��� �ι�°�� A�� ����� ��� 
--WARD
--MARTIN
--JAMES

select *
from emp
where ename like '__A%'; --�̸��� ����°�� A�� ����� ���
--BLAKE
--CLARK
--ADAMS



--####����Ŭ ���� (regexp_like) �󼼰˻�####
select * from emp where regexp_like(ename,'[A-C]');
--����Ŭ ����� �� �ִ� ���� ǥ�� �˻� 5�� ����� (EMP)

-------------------------------------------------------[0303]---

--������ �����ϱ�
--order by �÷��� : ����, ����, ��¥�� ������ �� �ִ�.
--�������� : asc  (default)
--�������� : desc
--���(cost)�� ���̵�� �۾��̴� -> CUP�� memory�� ���� ����.

select *
from emp
order by sal; --default�� asc�� ����ȴ�.

select *
from emp
order by sal asc; --���� ���� ����

--�޿��� ���� �޴� ������ �����ض�
select *
from emp
order by sal desc;

--�Ի����� ���� ���� ������ �����ؼ� ���, �̸�, �޿�, �Ի����� ����ϼ���
--(���� �ֱٿ� �Ի��� ������)
select empno, ename, sal, hiredate
from emp
order by hiredate desc;

select empno, ename
from emp
order by ename asc; --���ڿ� ���� ����

/*
select ��    3
from ��      1
where ��     2
order by ��  4 -> select�� ����� �����Ѵ�.
*/

--�ؼ�
select empno, ename, sal, job, hiredate
from emp
where job='MANAGER'
order by hiredate desc;
--emp���̺���, ������ �Ŵ����� ������� �˻��Ͽ� ���, �̸�, �޿�, ����, �Ի�����
--�Ի������ �������� �����Ͽ� ����϶�.

-- order by �÷��� asc, �÷��� desc, �÷��� asc ... -> ���Ĺ�� �������� ��� ����
-- ##POINT## �亯�� �Խ����� ���� �� �ʼ��� ���ȴ�.
select job, deptno
from emp
order by job asc, deptno desc;
--grouping ����

--������
--������(union) : ���̺�� ���̺��� �����͸� ��ġ�� �� (�ߺ��� ����)
--������(union all) : �ߺ��� ���

create table uta (name varchar2(20));

insert into uta(name) values('AAA');
insert into uta(name) values('BBB');
insert into uta(name) values('CCC');
insert into uta(name) values('DDD');
commit;

select * from uta;

create table ut (name varchar2(20));

insert into ut(name) values('AAA');
insert into ut(name) values('BBB');
insert into ut(name) values('CCC');
commit;

select * from ut;

select * from ut
union -- �ߺ������� ����
select * from uta; --ut ���� uta�� �ı��� ������ ���� ��

select * from ut
union all
select * from uta;

--##union##
--1. �����Ǵ� �÷��� Ÿ���� �����ؾ� �Ѵ�.
select empno, ename from emp --empno ����
union
select job, deptno from dept; --job ���ڿ�
--ORA-00904: "JOB": invalid identifier
--������Ÿ�� ���� �߻� (���ڹ濡 ���� ������)
select empno, ename from emp --empno ����
union
select deptno, dname from dept;

--2. �����Ǵ� �÷��� ������ �����ؾ� �Ѵ�.
--'�ʿ��: null' �������.
select empno, ename, job, sal from emp --4��
union
select deptno, dname, loc from dept; --3��
--1789: query block has incorrect number of result columns
select empno, ename, job, sal from emp --4��
union
select deptno, dname, loc, null from dept; -- null������ �߰��ؼ� 4��
------------------------------------
--------------�������----------------
--�ʺ� �����ڰ� �ǹ������� �ؾ��ϴ� �۾�--
--(�������̺��� select�ϴ� �۾�) --
------------------------------------

--Tip
--����Ŭ �Լ� ......
select * from SYS.NLS_DATABASE_PARAMETERS;
--NLS_CHARACTERSET  : 	AL32UTF8  �ѱ� 3byte �ν�
--KO16KSC5601 2Byte (���� ��ȯ�ϸ� �ѱ� �ٱ���)
select * from nls_database_parameters where parameter like '%CHAR%';
------------------------------------------------------------------------------
create table test2(name varchar2(2));

insert into test2(name) values('a');
insert into test2(name) values('aa');
insert into test2(name) values('��'); --�ѱ� 1�� 3byte ����
--ORA-12899: value too large for column "BITUSER"."TEST2"."NAME" (actual: 3, maximum: 2)
--���� �������δ� �ѱ��� 3byte�� �νĵǾ������Ƿ� 2����Ʈ¥�� �������� �� �� ����.
------------------------------------------------------------------------------

--[2����]
--����Ŭ�� ������ �ִ� �Լ� ����!
/*
## ���� �� �Լ��� ���� ##
1) ������ �Լ� : ���ڸ� �Է� �ް� ���ڿ� ���� �� ��θ� RETURN �� �� �ִ�.
2) ������ �Լ� : ���ڸ� �Է� �ް� ���ڸ� RETURN �Ѵ�.
3) ��¥�� �Լ� : ��¥���� ���� �����ϰ� ���ڸ� RETURN �ϴ� MONTHS_BETWEEN �Լ���
�����ϰ� ��� ��¥ ���������� ���� RETURN �Ѵ�.
4) ��ȯ�� �Լ� : � ���������� ���� �ٸ� ������������ ��ȯ�Ѵ�.
5) �Ϲ����� �Լ� : NVL, DECODE
*/

--------------------------------���ڿ� �Լ�-----------------------------------
select initcap('the super man') from dual;
-- initcap : �ܾ��� �ձ��ڸ� �빮�ڷ� �ٲ��ּ���
select lower('AAA'), upper('aaa') from dual;
-- lower: �빮�ڸ� �ҹ��ڷ� / upper: �ҹ��ڸ� �빮�ڷ� �ٲ��ּ���

select ename, lower(ename) as"ename" from emp;

select * from emp where lower(ename) = 'king';
--�Լ��� ���� �����ϹǷ�, �̷��� �˻��ϸ� KING ã�� �� �ִ�!

select length('abce') from dual; --���ڿ� ����
select length('ȫ�浿') from dual; --���: 3

select length('  ȫ �� �� a') from dual; --���: 9 (���鵵 �����̹Ƿ� ����)

--#���� ������( || ) 
--concat()
--||�� �� Ȯ�强�� �д�(�����ϴ�)
select 'a' || 'b' || 'c' as"data"
from dual; --���: abc

select concat('a','b') from dual; --���: ab
select concat('a','b','c') from dual;
--ORA-00909: invalid number of arguments
--�Ķ���͸� 3���̻� ���� �� ����.

select ename || '     ' || job from emp; --����
select concat(ename,job) from emp; --����

--#�κ� ���ڿ� �����ϱ�
--java: substring
--Oracle: substr
select substr('ABCDE',2,3) from dual;
--2��°���� 3��(�ڱ��ڽź��� 1����)
--���: BCD

select substr('ABCDE',1,1) from dual; --���: A
select substr('ABCDE',3,1) from dual; --���: C

select substr('ABCiqwojkasdawjw',3) from dual; --���: Ciqwojkasdawjw
-- ����°(C)���� ������ ���

select substr('ABCDE',-2,1) from dual; --���: D
-- �ں��� 2��°(D)���� ���� 1�� ���
select substr('ABCDE',-2,2) from dual; --���: DE

--������̺��� ename �÷� �����Ϳ� ���ؼ� ù���ڴ� �ҹ��ڷ� ������ ���ڴ� �빮�ڷ� ����ϵ�
--�ϳ��� �÷����� ���� ����ϼ���
--�÷��� ��Ī��: fullname
--ù���ڿ� ������ ���� ���̿��� ���� �ϳ��� ��������
--SMITH >> s MITH ��µǵ��� �����
select lower(substr(ename,1,1)) || ' ' || substr(ename,2) as "fullname"
from emp;

--#lpad, rpad (ä���)
select lpad('ABC',10,'*') from dual; --���: *******ABC
select rpad('ABC',10,'%') from dual; --���: ABC%%%%%%%

--������� ��й�ȣ: hong1007
--ȭ�鿡 ho****** ���� ����ϰ�ʹ�.
--������� ��й�ȣ: 1004 >> 10**
select rpad(substr('hong1007',1,2),length('hong1007'),'*') as "pwd"
from dual;
--���: ho******
select rpad(substr('1004',1,2),length('1004'),'*') as "pwd"
from dual;
--���: 10**

--DB���� ���� �ڹٿ� ������ ���� �ְ�, �׳� �������� �ڹٿ��� ���� ������ ���� �ִ�.
--������ ������.. �������� ȸ�簡 ������ �ִ� ��Ģ��� ó���ϸ� �ȴ�.

--emp���̺��� ename �÷��� �����͸� ����ϵ� ù���ڸ� ����ϰ� �������� *�� ����ϼ���
select rpad(substr(ename,1,1),length(ename),'*') as "ename" from emp;

--#rtrim �Լ�: ������ ���ڸ� ������
--#ltrim: ���� ���ڸ� ������
select rtrim('MILLER', 'ER') from dual; --ER�� ã�Ƽ� ������ (���: MILL)
select ltrim('MILLLLLLLLLER', 'MIL') from dual; --���: ER (��� L�� �������� ����)

--���������
select '>' || rtrim('MILLER       ', ' ') || '<' from dual;
--�����ʿ��� ���鹮�ڸ� ������
--���: >MILLER<

--# ġȯ�Լ� (replace)
select ename, replace(ename, 'A', '�Ϳ�') from emp;
-- ���� A�� ã�Ƽ� �Ϳ�� �ٲ��

-----�ֹι�ȣ-----
create table member2(
  id number ,
  jumin varchar2(14)
);

insert into member2(id, jumin) values(100,'123456-1234567');
insert into member2(id, jumin) values(200,'234567-1234567');
commit;

select * from member2;

--��°��
--�ϳ��� �÷����� ��� :
--100  : 123456-*******
--200 : 234567-*******
--�÷��� ����Ī "juminnumber"

select id || ' : ' || rpad(substr(jumin,1,7),length(jumin),'*') as "jumin" from member2;

---------------------------------���ڿ��Լ�-----------------------------------

--------------------------------�����Լ�-------------------------------
--round(�ݿø� �Լ�)
--trunc(�����Լ�)
--#������ ���ϴ� �Լ� mod()

-- -3, -2, -1, 0(����), 1, 2, 3

--#round(�ݿø�)
--�����θ� ���ܶ� (0)
select round(12.345,0) as "r" from dual; --���: 12
select round(12.567,0) as "r" from dual; --���: 13 (�ݿø�)

--�Ҽ����� ù��° �ڸ����� ���ܶ� (1)
select round(12.345,1) as "r" from dual; --���: 12.3
select round(12.567,1) as "r" from dual; --���: 12.6 (�ݿø�)

--10���ڸ����� ���ܶ� (-1)
select round(12.345,-1) as "r" from dual; --���: 10
select round(15.345,-1) as "r" from dual; --���: 20 (�ݿø�)

select round(12.345,-2) as "r" from dual; --���: 0

--#trunc(�ݿø����� �ʰ� �׳� �ڸ��� ��)
select trunc(12.345,0) as "r" from dual; --���: 12
select trunc(12.567,0) as "r" from dual; --���: 12
select trunc(12.345,1) as "r" from dual; --���: 12.3
select trunc(12.567,1) as "r" from dual; --���: 12.5
select trunc(12.345,-1) as "r" from dual; --���: 10
select trunc(15.345,-1) as "r" from dual; --���: 10
select trunc(12.345,-2) as "r" from dual; --���: 0

--#������
select 12/10 from dual; --���: 1.2 (���� 1�̰�, �������� 2)

select mod(12,10) from dual; --���: 2(������)
--����Ŭ�� 0���� ���� �� �ִ�. (�ڹٴ� 0���� ������ ��������)
select mod(0,0) from dual; --���: 0


----------------------------------��¥�Լ�---------------------------------

--alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
select sysdate from dual;

--##POINT##
--1. DATE + NUMBER >> DATE
--2. DATE - NUMBER >> DATE
--3. DATE - DATE >> NUMBER(�ϼ�) ����

select sysdate + 100 from dual;
select sysdate + 1000 from dual;

select hiredate from emp;
--�Լ�
select trunc(months_between('2018-02-27','2010-02-20'),0) from dual; --������ ����?
select months_between(sysdate, '2010-03-03') from dual; --���: 132

select '2019-03-03' + 100 from dual; --���� ORA-01722: invalid number
-- #POINT#
--to_date(): ���ڸ� ��¥�� �ٲ��ִ� �Լ� (��ȯ�Լ�)

select to_date('2019-03-03') + 100 from dual; --���: 2019-06-11 00:00:00


--1. ��� ���̺��� ������� �Ի��Ͽ��� ���糯¥���� �ټӿ����� ���ϼ���  
-- ( ����̸� , �Ի��� , �ټӿ��� )
--�� �ټӿ����� �����κи� ����ϼ��� (�ݿø� ���� ������)
select ename, hiredate, trunc(months_between(sysdate,hiredate),0) as "�ټӿ���" 
from emp;

--2. �Ѵ��� 31 �� �̶�� ���ؿ��� �ټӿ����� ���ϼ��� (�ݿø� ���� ������) 
--(�Լ� ���(x) >> ��¥ - ��¥ >> 150�� )��)
select ename, hiredate, trunc((sysdate-hiredate)/31,0) as "�ټӿ���" 
from emp;


-----------------------------------------------
--(��ȯ�Լ�) Today ##POINT##
--Oracle ������: ���ڿ�, ����, ��¥
--to_char(): ���� -> ���� (1000 -> $100,000) : ���ڸ� ���ڷ� ��ȯ
--         : ��¥ -> ���� ('2021-03-03' -> 2021��03��03��) : ��¥�� ���ڷ� ��ȯ

--to_date(): ���� -> ��¥
select to_date('2021-03-03') + 100 from dual;

--to_number(): ���� -> ���� >> but, �ڵ� ����ȯ�� �ֱ� ������ ���� ������ �ʴ´�.
select '100' + 100 from dual; -- ������ ���ڶ� ����ȯ�� �Ͼ�� ���ȴ�.
select to_number('100') + 100 from dual; -- ����ǥ��

-----------------------------------------------
/*
create table ���̺�� (�÷��� Ÿ��, �÷��� Ÿ��)
1. create table member (age number); insert ... 1��~ õ�� ����
2. insert into member(age) values(100);
3. insert into member(age) values(200); ... x100��

java���� Ŭ������ �����ϴ� �Ͱ� ����
1. class member {private int age;} -- ����Ŭ������ insert 1�� = �ڹ��� ��ü 1��
member m = new member();
2. m.setAge(100);
3. List<member> mlist = new ArrayList<member>();
   m.list.add(new member(100));
   m.list.add(new member(200));
   m.list.add(new member(300));
   m.list.add(new member(400)); ... x 100��
   
@ ������Ÿ��
���ڿ�
CHAR(10)       >> 10Byte >> �ѱ� 5�� / ������, Ư������, ���� 10��
VARCHAR2 (10)  >> 10Byte >> �ѱ� 5�� / ������, Ư������, ���� 10��

CHAR�� �������� ���ڿ�, VARCHAR2�� �������� ���ڿ�

CHAR(10) >> 'abc' >> 3byte >> [a][b][c][][][][][][][] >> ������ ��ȭ�� ����. (10byte)
VARCHAR(10) >> 'abc' >> 3byte >> [a][b][c]... >> ������ũ�⸸ŭ�� ����Ȯ��

-- �ѱ� 1�ڰ� 3byte�̰�, (��,��) �� �� �ϳ��� �����͸� ���ٴ� ����
create table member(gender char(3)); -- ���ɻ� char�� �켱�ȴ�.
create table member(gender varchar2(3));

-- ����� �̸� �����Ͱ� ���ٰ� ����
create table member(name char(30)); 
create table member(name varchar2(30)); -- �긦 ���°� �� ȿ����

@ ��� : �������� ������(��/��, ��/��/��, �ֹι�ȣ �� ������ ������)�� ��� char �̿�.
        �������� ������ (����̸�, �ּ�, ��� �� ���̰� �������� ���� ������)�� ��� varchar2 �̿�.
        
char() varchar2() ����: �ѱ�, ������(,Ư������,����) ȥ��
varchar2(10)

unicode: �ѱ�, ������, Ư������, ���� ��� 2byte�� ����.

##nchar(20) >> 20���� >> 2*20 >> 40byte
##nvarchar2(20) >> 20����

�ѱ۹�ȭ���� n �� �پ��ִ� �����ڵ� ���ڸ� �����Ѵ�.
*/
create table test3(name nchar(2), ename nvarchar2(2));

insert into test3(name) values('a');
insert into test3(name) values('��');

insert into test3(name) values('ab');
insert into test3(name) values('����');

insert into test3(name) values('abc');
--ORA-12899: value too large for column "BITUSER"."TEST3"."NAME" (actual: 3, maximum: 2)
insert into test3(ename) values('������');
--ORA-12899: value too large for column "BITUSER"."TEST3"."ENAME" (actual: 3, maximum: 2)

commit;

--1. to_number(): ���� -> ���� >> but, �ڵ� ����ȯ�� �ֱ� ������ ���� ������ �ʴ´�.
select '1' + 1 from dual; -- ������ ���ڶ� ����ȯ�� �Ͼ�� ���ȴ�.
select to_number('1') + 1 from dual; -- ��Ģ

--2. to_char() : ���� -> ���Ĺ���
--               ��¥ -> ���Ĺ���
select sysdate , to_char(sysdate,'YYYY') || '��' as "YYYY",
                 to_char(sysdate,'YEAR'),
                 to_char(sysdate,'MM'),
                 to_char(sysdate,'DD'),
                 to_char(sysdate,'DAY'),
                 to_char(sysdate,'DY')
from dual;

--�Ի����� 12���� ����� ���, �̸�, �Ի���, �Ի�⵵, �Ի���� ����ϼ���
--hiredate�� �Լ� ����

select empno, ename, hiredate, to_char(hiredate,'YYYY') as "�Ի�⵵", to_char(hiredate,'MM') as "�Ի��"
from emp
where to_char(hiredate,'MM')='12';

select to_char(hiredate, 'YYYY MM DD') from emp;
select to_char(hiredate, 'YYYY��MM��DD��') from emp; --����
select to_char(hiredate, 'YYYY"��" MM"��" DD"��"') from emp; --����

--�������ĸ�
--###����Ŭ.pdf (71p ǥ ����)

--10000000 -> $10,000,000
select '>' || to_char(12345,'999999999') || '<' from dual; --���: >     12345<
select '>' || to_char(12345,'0999999999') || '<' from dual; --���: > 0000012345<
select '>' || to_char(12345,'$9,999,999,999') || '<' from dual; --���: >        $12,345<

select sal, to_char(sal,'$999,999') from emp;
-- ����� ���� �����ʹ� [����]�������̴�.

--HR �������� ��� �۾��ϰ����~!~!

select * from employees;
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
select sysdate from dual;

/*
������̺�(employees)���� ����� �̸��� last_name , first_name ���ļ� fullname ��Ī �ο��ؼ� ����ϰ�
�Ի�����  YYYY-MM-DD �������� ����ϰ� ����(�޿� *12)�� ���ϰ� ������ 10%(���� * 1.1)�λ��� ����
����ϰ� �� ����� 1000���� �޸� ó���ؼ� ����ϼ���
�� 2005�� ���� �Ի��ڵ鸸 ����ϼ��� �׸��� ������ ���� ������  ����ϼ���
*/
select last_name || first_name as "fullname", 
       to_char(hire_date, 'YYYY-MM-DD') as "�Ի���",
       salary,
       salary*12 as "����",
       to_char((salary*12)*1.1,'$9,999,999') as "�����λ�"
from employees
where to_char(hire_date,'YYYY') >= '2005'
order by "����" desc;
--order by (salary*12) desc; / ����
--order by ���� select�� ������ �ִ� ��Ī�� ����� �� �ִ�. (��������� ����)

----------------------------------------------------------
----------------------------------------------------------

--�Ϲ��Լ�(���α׷� ������ ���� �Լ�)
--nvl() ,nvl2() >> null ó���ϴ� �Լ�
--decode() >> java�� if�� ó�� ����� �� �ִ� �Լ�
--case() >> java�� switch�� ó�� ����� �� �ִ� �Լ�

--����Ŭ SQL (����, ��� ������ ����)
--����Ŭ PL-SQL (����, ��� ��� ����) ... ��� ... -> SPRING�� �� �մϴ�

--���� �ٽ� BITUSER�� �ٲߴϴ�
select comm, nvl(comm,0) from emp;

create table t_emp(
    id number(6), --�ڿ� 6�� ������ [���� 6�ڸ�]
    job nvarchar2(20)
);

insert into t_emp(id,job) values(100,'IT');
insert into t_emp(id,job) values(200,'SALES');
insert into t_emp(id,job) values(300,'MGR'); --�Ŵ���
insert into t_emp(id) values(400);
insert into t_emp(id,job) values(500,'MGR');
COMMIT;

select * from t_emp;

select id, decode(id, 100, '����Ƽ', 
                      200, '������', 
                      300, '������', 
                      '��Ÿ�μ�') as "�μ��̸�"
from t_emp;
--id���� 100�̸� '����Ƽ'�� ...~~~
--�ϳ��� �÷��� ����� ��

select empno, ename, deptno, decode(deptno, 10, '�λ��',
                                            20, '������',
                                            30, 'ȸ���',
                                            40, '�μ�',
                                            'ETC') as "�μ��̸�"
from emp;


--Quiz
CREATE TABLE t_emp2(
id NUMBER(2),
jumin CHAR(7)
);
INSERT INTO t_emp2(id, jumin) VALUES(1,'1234567');
INSERT INTO t_emp2(id, jumin) VALUES(2,'2234567');
INSERT INTO t_emp2(id, jumin) VALUES(3,'3234567');
INSERT INTO t_emp2(id, jumin) VALUES(4,'4234567');
INSERT INTO t_emp2(id, jumin) VALUES(5,'5234567');
COMMIT;
SELECT * FROM t_emp2;
/*
t_emp2 ���̺��� id, jumin �����͸� ����ϵ� jumin �÷��� ���ڸ��� 1�̸�
'����' ��� 2�̸� '����' 3�̸� '�߼�' �׿ܴ�  '��Ÿ' ��� ����ϼ���
�÷����� '����'
*/
select id, jumin, decode(substr(jumin,1,1), 1, '����',
                                            2, '����',
                                            3, '�߼�',
                                            '��Ÿ') as "����"
from t_emp2;


/*
if�� �ȿ� if�� ��ø

�Ʒ��ڵ� decode() �Լ� �۾��ϱ�
�μ���ȣ�� 20���� ����߿��� SMITH��� �̸��� ���� ����̶�� HELLO ���� ���
�μ���ȣ�� 20���� ����߿��� SMITH��� �̸��� ���� ����� �ƴ϶�� WORLD ���� ���
�μ���ȣ�� 20���� ����� �ƴ϶�� ETC��� ���� ���
*/

select ename, deptno, decode(deptno, 20, decode(ename, 'SMITH', 'HELLO',
                                        'WORLD'),
                     'ETC')
from emp;

--CASE��
-- = java�� ����ġ��
/*
1.
CASE ���ǽ� WHEN ���1 THEN ���1
           WHEN ���2 THEN ���2
           WHEN ���3 THEN ���3
           ELSE ���4
END "�÷���"

2.
CASE WHEN �÷��� ���� �񱳽� THEN
     WHEN �÷��� ���� �񱳽� THEN
     WHEN �÷��� ���� �񱳽� THEN
     ELSE
END "�÷���"
*/

create table t_zip(
    zipcode number(10)
);

insert into t_zip(zipcode) values(2);
insert into t_zip(zipcode) values(31);
insert into t_zip(zipcode) values(32);
insert into t_zip(zipcode) values(33);
insert into t_zip(zipcode) values(41);
commit;

select * from t_zip;

select '0' || to_char(zipcode), CASE zipcode WHEN 2 THEN '����'
                                             WHEN 31 THEN '���'
                                             WHEN 32 THEN '����'
                                             WHEN 41 THEN '����'
                                             ELSE '��Ÿ����'
                                END "�����̸�"
FROM t_zip;


select case when sal <= 1000 then '4��'
            when sal between 1001 and 2000 then '3��'
            when sal between 2001 and 3000 then '2��'
            when sal between 3004 and 4000 then '1��'
            else 'Ư��'
       end "���"
from emp;

---------------------------------------------------------------------
--�����Լ�
--��¥�Լ�
--�����Լ�
--��ȯ�Լ�(to_char(), to_number(), to_date())
--�Ϲ��Լ�(NVL, DECODE(), CASE ����
--@@�⺻�Լ� END@@--
---------------------------------------------------------------------
---------------------------------------------------------------------
--����(�׷�)�Լ�
--����Ŭ.pdf 75p ����

/*
1.count(*) >> row ��
  count(�÷���) >> �������� �Ǽ� (null�� �������� �ʴ´�)
2.sum()
3.avg()
4.max()
5.min()

1. �����Լ��� GROUP BY ���� ���� ����Ѵ�.
2. ��� �����Լ��� NULL���� �����Ѵ�
3. SELECT ���� �����Լ� �̿��� �ٸ� �÷��� ���� �� �÷��� �ݵ�� GROUP BY���� ��õǾ�� �Ѵ�.
*/

SELECT COUNT(*) FROM emp; --���: 14 / �� 14�� �ֽ��ϴ�.(������ �Ǽ��� �ƴϰ�, ROW�� ��)

SELECT COUNT(empno) FROM emp; --���: 14
SELECT COUNT(comm) FROM emp; --���: 6 (comm�÷��� �ִ� null ���� �Ǽ�)

-- ����, comm �÷��� �����͵� 14������ ����ʹٸ�?
SELECT COUNT(NVL(comm,0)) FROM emp; --���: 14


--�޿��� ��
SELECT SUM(sal) AS "�޿��� ��" FROM emp; --���: 29025
--�޿��� ���
SELECT AVG(sal) AS "�޿� ���" FROM emp; --���: 2073.214285714285714285714285714285714286
SELECT ROUND(AVG(sal),0) AS "�޿� ���" FROM emp; --���: 2073

--����� say: �츮ȸ�� �� ������ �󸶳� ���޵Ǿ���?
SELECT SUM(comm) FROM emp; --���: 4330
-- ���� ����� �󸸰�?
SELECT AVG(comm) FROM emp;
SELECT TRUNC(AVG(comm), 0) FROM emp; --���: 721
-- ���� ����� ����� �� null�� �����ϰ� �ִ�.
-- NULL���� �����ϰ� �ֱ� ������ �޴� ��� ������ ����� ���̴�.
-- null ����, (300+200+30+300+3500+0 / 6) �� �ߴ� so, 721

-- ��ü ��� ���� ���
SELECT TRUNC((SUM(comm)/14),0) FROM emp; --���: 309
SELECT TRUNC(AVG(NVL(comm,0))) FROM EMP; --�ٷ� ���ٰ� ���� ����� ������ ��

-- 721, 309 �� �� �´� ������ �� �� �ִ�
-- ȸ���� ������ ���� �ٸ� ���̾�
-- ȸ���� ������ ��ü ��� �����̸� 309�� �°�, �޴� ��� �����̸� 721�� �´�.

select max(sal) from emp;
select min(sal) from emp;

select empno, count(empno) from emp; --ORA-00937: not a single-group group function
-- �׷����� �������� ������ ������ �ٸ��� ������ ������ ����.

select sum(sal), avg(sal), max(sal), min(sal), count(sal)
from emp;

---�μ��� ��� �޿��� ���ϼ���---
select deptno, avg(sal)
from emp
group by deptno;

--������ ��� �޿��� ���ϼ���
select job, avg(sal)
from emp
group by job;

--������ ��� �޿�, �޿��� ��, �ִ� �޿�, �ּ� �޿�, �Ǽ��� ����ϼ���.
-- ### �� select * �� ������¡
select job, avg(sal), sum(sal), max(sal), min(sal), count(sal)
from emp
group by job;

/*
grouping�� ������ ����Ǵ� ��
1. distinct �÷���1, �÷���2...
2. order by �÷���1, �÷���2...
3. group by �÷���1, �÷���2...
*/

--�μ���, ������ �޿��� ���� ���ϼ���
select deptno, job, sum(sal), count(sal)
from emp
group by deptno, job;

/*
SELECT    4
FROM      1
WHERE     2
GROUP BY  3
ORDER BY  5
*/

--������ ��ձ޿��� 3000�޷� �̻��� ����� ������ ��� �޿��� ����ϼ���
SELECT job, AVG(sal)
FROM emp
WHERE AVG(sal) >= 3000 -- ������ ���� (where���� ������ �� �ʾ ���谡 ���� ���� �ʾ����Ƿ� ���� �Ұ�)
GROUP BY job;

/*
1. from���� ������: where
2. group by���� ������: having
*/

SELECT job, AVG(sal)
FROM emp
GROUP BY job
HAVING AVG(sal) >= 3000;
--having�������� select���� ����Ī�� ������� ���Ѵ� (���������)
/*
SELECT    5
FROM      1
WHERE     2
GROUP BY  3
HAVING    4
ORDER BY  6
*/

/* ������̺��� ������ �޿����� ����ϵ� ������ ���� �ް� �޿��� ���� 5000 �̻��� ������� ����� ����ϼ���
--�޿��� ���� ���� ������ ����ϼ��� */
SELECT job, sum(sal) as "sumsal"
FROM emp
WHERE comm IS NOT NULL
GROUP BY job
HAVING (SUM(sal) >= 5000)
ORDER BY sum(sal);
--ORDER BY "sumsal"; �ε� �� �� �ִ�.

/* ������̺��� �μ� �ο��� 4���� ���� �μ��� �μ���ȣ ,�ο��� , �޿��� ���� ����ϼ��� */
SELECT deptno, count(empno), sum(sal) as "�μ��� �޿��� ��"
FROM emp
GROUP BY deptno
HAVING count(empno) > 4;
-- ��: HAVING COUNT(*) > 4;

SELECT COUNT(*) FROM emp WHERE job IS NULL; -- null ���� Ȯ���ϱ�

/* ������̺��� ������ �޿��� ���� 5000�� �ʰ��ϴ� ������ �޿��� ���� ����ϼ���
�� �Ǹ�����(salesman) �� �����ϰ� �޿������� �������� �����ϼ��� */

SELECT job, sum(sal) as "sumsal"
FROM emp
WHERE job != 'SALESMAN'
GROUP BY job
HAVING sum(sal) > 5000 
ORDER BY sum(sal) DESC;

---### WHERE������ �Ÿ� �� �ִ� �ִ� �ɷ��� �������� (����) ###
--------------------------------------------------
-----��������� ���� ���̺��� �����͸� �������� �� ��!---
--------------------------------------------------
-- ����: JOIN (�Ѱ� �̻��� ���̺��� �����͸� �������� ���)
-- ����Ŭ.pdf (6��) 85page

-----------------------------0304------------------------------

--�������̺��� ������ ��������
--RDBMS(Relational DataBase Management System) : �Ѱ� �̻��� ���̺���� ���� ���踦 �������ִ� ����
--JOIN : �����͸� �������� ���!
-- <����>
--  1:1 (1��1)
--  1:N (1���)
--  M:N (�ٴ��)


--���� �ǽ� ���̺� �����ϱ�--
create table M (M1 char(6) , M2 char(10));
create table S (S1 char(6) , S2 char(10));
create table X (X1 char(6) , X2 char(10));

insert into M values('A','1');
insert into M values('B','1');
insert into M values('C','3');
insert into M values(null,'3');
commit;

insert into S values('A','X');
insert into S values('B','Y');
insert into S values(null,'Z');
commit;

insert into X values('A','DATA');
commit;

select * from m;
select * from s;
select * from x;

----------------------���࿡ ������ �߸� �־���
--delete from m;
--commit;
--�ٽ� insert
------------------------------------------

--<<����>>
--1. �����(equi join) (70%�� ������̴�)
--   : �� ���̺�� �����Ǵ� ���̺� �ִ� �÷��� �����͸� 1:1�� ����
--<����>
--1) SQL JOIN ����(����Ŭ ����) >> �����ϰ� (���� ������� x)
select *
from m , s
where m.m1 = s.s1;

select m.m1 , m.m2 , s.s2
from m , s
where m.m1 = s.s1;

--2) ANSI ����(ǥ��) -> ����: ������ �̷��� ������ >> [inner] join on ������
select *
from m inner join s
on m.m1 = s.s1;

select m.m1, m.m2, s.s2
from m join s -- inner �Ϲ������� ����
on m.m1 = s.s1;

--M, X �����ϱ� (M.m1 = X.x1)
select m.m1, m.m2, x.x2
from m join x
on m.m1 = x.x1;

--emp, dept
--�����ȣ, ����̸�, �μ���ȣ, �μ��̸��� ����ϼ���.
select emp.empno, emp.ename, emp.deptno, dept.dname
from emp join dept
on emp.deptno = dept.deptno;

--����: ���̺���� ���
--join�� ���̺��� �̸��� �ٿ��� ����Ѵ� (��Ī ���̱�)
select e.empno, e.ename, e.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno;

--join
--���̺��� 2���ϼ���, 3���ϼ��� ... ~~
--1) SQL JOIN (���� ������� x)
select *
from m, s, x
where m.m1 = s.s1 and s.s1 = x.x1;

--2) ANSI JOIN
select m.m1, m.m2, s.s2, x.x2
from m join s on m.m1 = s.s1
       join x on s.s1 = x.x1;

/*
> a(a1), b(b1), c(c1), d(d1) 4���� ���̺� ����
from a join b on a.a1 = b.b1
       join c on b.b1 = c.c1
       join d on c.c1 = d.d1
*/

--HR �������� �̵�
select * from employees;
select * from departments;
select * from locations;

--���, �̸�(last_name), �μ���ȣ, �μ��̸� ���
select e.employee_id, e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;
--������
--���� ����� 107 , �����ʹ� 106�� ��� -> �μ���ȣ�� null�� ��� ������ ��
--select * from employees where employee_ID=178;
--#������� null ó���Ұ� >> null���� ���� �����ʹ� �����ȴ�#

--���, �̸�(last_name), �μ���ȣ, �μ��̸�, �����ڵ�, ���ø� ���
select e.employee_id, 
       e.last_name, 
       e.department_id, 
       d.department_name, 
       d.location_id, 
       l.city
from employees e join departments d on e.department_id = d.department_id
                 join locations l on d.location_id = l.location_id;
                 
-----------------
--bituser ��������
--<<����>>
--2. ������(non-equi join)
--   : 1:1�� ���� �÷��� ����.
--   : �ǹ̸� �����Ѵ� (�ڱ� ������ ����) -> �join ������ ����Ѵ�.
--join: �÷��� �÷��� 1:1�� ���ε� �� ������ �� (emp.deptno = dept.deptno)
select * from emp;
select * from salgrade;

--������
select e.empno, e.ename, e.sal, s.grade
from emp e join salgrade s
on e.sal between s.losal and s.hisal;

--3. outer join (equi join + null(������))
--      : equi join�� �����ϰ� �� ���� �ǻ���� (���� �����͸� ������ ���ΰ�)
--      : join���̺��� ���� ���踦 �ľ��ϴ� ���� �߿��ϴ�.
--      : ������ �Ǵ� ���̺��� ���� �����͸� ������ �� �ִ�.
--<����>
--1) left (outer) join (���� ���̺��� ����)
--2) right (outer) join (������ ���̺��� ����)
--3) full (outer) join (left + right: union)
select *
from m left join s
on m.m1 = s.s1;

select *
from m right join s
on m.m1 = s.s1;

select *
from m full outer join s --outer ���� ����
on m.m1 = s.s1;

---------------------------------
--HR����
--���, �̸�(last_name), �μ���ȣ, �μ��̸� ���
--107���� ��������
select e.employee_id, e.last_name, e.department_id, d.department_name
from employees e left join departments d
on e.department_id = d.department_id;
---------------------------------
--bituser

--4. self join (�ڱ�����)
--      : ������ �������� �ʴ´�. (�ǹ̸� ����) -> equi join �������� ���
--      : ���̺��� �÷��� �ڽ��� ���̺� �ִ� �ٸ� �÷��� �����ϴ� ��� 

--join �⺻ ���̺� 2��
--emp ���̺� 1���� ����Ī �ٿ��� (��������?)���

select e.empno, e.ename, m.empno, m.ename
from emp e join emp m
on e.mgr = m.empno;
-- ������ 13�� ��� -> outer join �߰��ؼ� �ذ�

select e.empno, e.ename, m.empno, m.ename
from emp e left join emp m
on e.mgr = m.empno;

------------------------------------
select * from emp;
select * from dept;
select * from salgrade;
-- 1. ������� �̸�, �μ���ȣ, �μ��̸��� ����϶�.
select e.ename, e.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno;

-- 2. DALLAS���� �ٹ��ϴ� ����� �̸�, ����, �μ���ȣ, �μ��̸��� ����϶�.
select e.ename, e.job, e.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno
where d.loc = 'DALLAS';

-- 3. �̸��� 'A'�� ���� ������� �̸��� �μ��̸��� ����϶�.
select e.ename, d.dname
from emp e join dept d
on e.deptno = d.deptno
where e.ename like '%A%'; --WHERE Regexp_like(E.ENAME,'^A'); 

-- 4. ����̸��� �� ����� ���� �μ��� �μ���, �׸��� ������ ����ϴµ� ������ 3000�̻��� ����� ����϶�.
select e.ename, d.dname, e.sal
from emp e join dept d
on e.deptno = d.deptno
where e.sal >= 3000;

-- 5. ����(����)�� 'SALESMAN'�� ������� ������ �� ����̸�, �׸��� �� ����� ���� �μ� �̸��� ����϶�.
select e.job, e.ename, d.dname
from emp e join dept d
on e.deptno = d.deptno
where e.job = 'SALESMAN';
?
-- 6. Ŀ�̼��� å���� ������� �����ȣ, �̸�, ����, ����+Ŀ�̼�, �޿������ ����ϵ�, 
--      ������ �÷����� '�����ȣ', '����̸�', '����','�Ǳ޿�', '�޿����'���� �Ͽ� ����϶�.
select e.empno as "�����ȣ", 
       e.ename as "����̸�", 
       e.sal as "����",
       e.sal + nvl(e.comm,0) as "�Ǳ޿�",
       s.grade as "�޿����"
from emp e join salgrade s on e.sal between s.losal and s.hisal
where e.comm is not null;

-- 7. �μ���ȣ�� 10���� ������� �μ���ȣ, �μ��̸�, ����̸�, ����, �޿������ ����϶�.
select d.deptno, d.dname, e.ename, e.sal, s.grade
from emp e join dept d on e.deptno = d.deptno
           join salgrade s on e.sal between s.losal and s.hisal
where e.deptno=10;

-- 8. �μ���ȣ�� 10��, 20���� ������� �μ���ȣ, �μ��̸�, ����̸�, ����, �޿������ ����϶�. 
-- �׸��� �� ��µ� ������� �μ���ȣ�� ���� ������, ������ ���� ������ �����϶�.
select d.deptno, d.dname, e.ename, e.sal, s.grade
from emp e join dept d on e.deptno = d.deptno
           join salgrade s on e.sal between s.losal and s.hisal
where e.deptno=10 or e.deptno=20 -- WHERE E.DEPTNO IN (10,20)
order by e.deptno asc, e.sal desc;

-- 9. �����ȣ�� ����̸�, �׸��� �� ����� �����ϴ� �������� �����ȣ�� ����̸��� ����ϵ� 
-- ������ �÷����� '�����ȣ', '����̸�', '�����ڹ�ȣ', '�������̸�'���� �Ͽ� ����϶�.
select e.empno as "�����ȣ", 
       e.ename as "����̸�", 
       m.empno as "�����ڹ�ȣ",
       m.ename as "�������̸�"
from emp e left join emp m
on e.mgr = m.empno;

--------------------------------------------------------------
--------------------------------------------------------------

--Subquery
--����Ŭ.pdf (��7��) 100p
--SQL�� ��! SQL�� ���� �ذ��!
--1. �Լ��� ���� ���̺��̴�? >> JOIN >> �������� �ذ��� �ȵȴ�? SubQurey���!

--������̺��� ������� ��� �޿����� �� ���� �޿��� �޴� ����� ���, �̸�, �޿� �� ����϶�.
select avg(sal) from emp; --2073
select empno, ename, sal
from emp
where sal > 2073; -- ��� �޿��� �˰��־�� Ǯ �� �ִ� .....
-- �ϳ��� ������ �ذ��ϱ� ���ؼ� ������ 2�� ���Ǿ���. 
-- 1���� ���� �������� �����غ���
select empno, ename, sal
from emp
where sal > (select avg(sal) from emp); -- ������ �ȿ� �������� ����!.!
--             ��> ���������� ���� ���P�ȴ�.

--<<Subquery>>
--<����>
--why? ����� �̱��̳�, ��Ƽ�Ŀ� ���� ���Ǵ� �����ڰ� �ٸ���.
--1. single row subquery : subquery�� ���� ����� ���� row(����)�� ���� column (=�Ѱ��� ������ = ���ϰ�)
--   ���� ������ ( =, >, <, >=, <=) ���
--2. multi row subquery  : subquery�� ���� ����� �Ѱ� �̻��� row�� ���� (=�������� ��), ���� column
--   IN , NOT IN, ANY, ALL ������ ���
--   ALL: sal > 1000 and sal > 4000 and ...
--   ANY: sal > 1000 or sal > 4000 or...

--<����>
--1. ��ȣ�ȿ� �־�� �Ѵ�. >> ex. {select max(sal) from emp) 
--2. ���� �÷����� �����Ǿ�� �Ѵ�. >> ex. select empno, sal from emp (�Ұ�)
--3. �ܵ����� ���� �����ؾ� �Ѵ�.

--<�������>
--1. subquery ���� ����
--2. subquery ����� ������ query ����

--Tip)
--SELECT (subquery) > �Ѱ��� �ุ ��ȯ�� ��� ( Scala sub query )
--FROM (subquery)   > Inline view(�������̺� ����)
--WHERE (subquery)  > �������� ���

-- ������̺��� jones�� �޿����� �� ���� �޿��� �޴� ����� ���, �̸�, �޿��� ����ϼ���
SELECT empno, ename, sal
FROM emp
WHERE sal > (SELECT sal FROM emp WHERE ename='JONES');

SELECT *
FROM emp
WHERE sal = (SELECT sal FROM emp WHERE deptno=30);
--ORA-01427: single-row subquery returns more than one row
--suquery�� ����� multi row�� ����!

SELECT *
FROM emp
WHERE sal IN (SELECT sal FROM emp WHERE deptno=30);
-- sal = 1600 or sal = 1250 or ....

SELECT *
FROM emp
WHERE sal NOT IN (SELECT sal FROM emp WHERE deptno=30);
-- sal != 1600 and sal !=1250 and .... 
--NOT IN = ������ AND

--���������� �ִ� ����� ����� �̸��� ����ϼ���
--(�� ����� MGR�÷��� �ִ�)
SELECT empno, ename
FROM emp
WHERE empno IN (SELECT mgr FROM emp);
--empno = 7902 or empno = 7698 ... or empno = null;
--or ���꿡���� null�� ������ ���� �ʴ´�.

--���������� ���� ����� ����� �̸��� ����ϼ���.
SELECT empno, ename
FROM emp
WHERE empno NOT IN (SELECT mgr FROM emp);
--NOT IN�� NULL�� �ν��Ѵ� ,,,
--empno != 7902 and empno != 7698 ... and
--and���꿡 null�� ��������� �� ����� null�� �ȴ�.
SELECT empno, ename
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr,0) FROM emp);

--king���� �����ϴ�(���ӻ���� king��) ����� ���, �̸�, ����, ������ ����� ����ϼ���
SELECT empno, ename, job, mgr
FROM emp
WHERE mgr = (SELECT empno FROM emp WHERE ename='KING');

--20�� �μ��� ��� �߿��� ���� ���� �޿��� �޴� ������� �� ���� �޿��� �޴� ����� 
--���, �̸�, �޿�, �μ���ȣ�� ����ϼ���.
SELECT empno, ename, sal, deptno
FROM emp
WHERE SAL > (SELECT MAX(sal) FROM emp WHERE deptno = 20);


--�ڱ� �μ��� ��� ���޺��� �� ���� ������ �޴� ����� ���, �̸�, �μ���ȣ, �μ��� ��� ������ ����ϼ���
--hint : �μ� ��ȣ�� �μ��� ��� ������ ��� �ִ� ���̺��� �����Ѵٸ�.. (�������� ���̺�x)
-- ��> FROM�� �������� ���
select e.empno, e.ename, e.deptno, e.sal, s.avgsal
from emp e 
    join (select deptno, round(avg(sal),0) as avgsal from emp group by deptno) s
    on e.deptno = s.deptno
where e.sal > s.avgsal;

--1. 'SMITH'���� ������ ���� �޴� ������� �̸��� ������ ����϶�.
SELECT ename, sal
FROM emp
WHERE sal > (SELECT sal FROM emp WHERE ename='SMITH');

--2. 10�� �μ��� ������ ���� ������ �޴� ������� �̸�, ����, �μ���ȣ�� ����϶�.
SELECT ename, sal, deptno
FROM emp
WHERE sal IN (SELECT sal FROM emp WHERE deptno = 10);

--3. 'BLAKE'�� ���� �μ��� �ִ� ������� �̸��� ������� �̴µ� 'BLAKE'�� ���� ����϶�.
SELECT ename, hiredate
FROM emp
WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'BLAKE') AND
      ename != 'BLAKE';

--4. ��ձ޿����� ���� �޿��� �޴� ������� �����ȣ, �̸�, ������ ����ϵ�, 
--   ������ ���� ��� ������ ����϶�.
SELECT empno, ename, sal
FROM emp
WHERE sal > (SELECT avg(sal) from emp)
ORDER BY sal DESC;

--5. �̸��� 'T'�� �����ϰ� �ִ� ������ ���� �μ����� �ٹ��ϰ��ִ� ����� �����ȣ�� �̸��� ����϶�.
SELECT empno, ename
FROM emp
WHERE deptno IN (SELECT deptno FROM emp WHERE ename LIKE '%T%');

--6. 30�� �μ��� �ִ� ����� �߿��� ���� ���� ������ �޴� ������� ���� ������ �޴� ������� 
--   �̸�, �μ���ȣ, ������ ����϶�. (��, ALL(and) �Ǵ� ANY(or) �����ڸ� ����� ��)
SELECT ename, deptno, sal
FROM emp
WHERE sal > ANY(SELECT max(sal) FROM emp WHERE deptno = 30);

--##--
SELECT ENAME , DEPTNO, SAL
FROM EMP
WHERE SAL > ALL(SELECT SAL FROM EMP WHERE DEPTNO=30);

--7. 'DALLAS'���� �ٹ��ϰ� �ִ� ����� ���� �μ����� ���ϴ� ����� �̸�, �μ���ȣ, ������ ����϶�.
SELECT ename, deptno, job
FROM emp  -- e JOIN dept d ON e.deptno = d.deptno
WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'DALLAS');

--8. SALES �μ����� ���ϴ� ������� �μ���ȣ, �̸�, ������ ����϶�.
SELECT deptno, ename, job
FROM emp
WHERE deptno IN(SELECT deptno FROM dept WHERE dname = 'SALES');

--9. 'KING'���� �����ϴ� ��� ����� �̸��� �޿��� ����϶� 
--    king �� ����� ��� = mgr �����Ͱ� king ���
SELECT ename, sal
FROM emp
WHERE mgr = (SELECT empno FROM emp WHERE ename='KING');


--##10. �ڽ��� �޿��� ��� �޿����� ����, �̸��� 'S'�� ���� ����� ������ �μ����� �ٹ��ϴ� 
--    ��� ����� �����ȣ, �̸�, �޿��� ����϶�.
SELECT empno, ename, sal
FROM emp
WHERE sal > (select avg(sal) from emp) AND
      deptno IN (SELECT deptno FROM emp WHERE ename LIKE '%S%');

--11. Ŀ�̼��� �޴� ����� �μ���ȣ, ������ ���� ����� �̸�, ����, �μ���ȣ�� ����϶�.
SELECT ename, sal, deptno
FROM emp
WHERE deptno IN (SELECT deptno FROM emp WHERE COMM IS NOT NULL) AND
      sal IN (SELECT sal FROM emp WHERE COMM IS NOT NULL);

--12. 30�� �μ� ������ ���ް� Ŀ�̼��� ���� ���� ������� �̸�, ����, Ŀ�̼��� ����϶�.
SELECT ename, sal, comm
FROM emp
WHERE sal NOT IN(SELECT NVL(sal,0) FROM emp WHERE deptno=30) AND
      comm NOT IN(SELECT NVL(comm,0) FROM emp WHERE deptno=30);

------------------------------------
------------------------------
--������ ����(DML)
--����Ŭ.pdf 10�� 168page
--�ݵ�� �ϱ� (INSERT, UPDATE, DELETE)

/*
����Ŭ ����
DDL(������ ���Ǿ�): create, alter, drop, truncatel, rename, modify
DML(������ ���۾�): insert, update, delete
DQL(������ ���Ǿ�): select
DDL(������ �����): (������ ����) grant, revoke
TCL(Ʈ�����)    : commit, rollback, savepoint

DML�۾� (insert, update, delete)
- ex)
- A ���¿��� B��� ���·� 100���� ��ü
=======�������=======
- A����(�ܰ�1000����)���� ���: update ���� set �ݾ� (-)
--> 900����
- B����(�ܰ�1000����)�� �Ա�: update ���� set �ݾ� (+)
--> 1100����
=======�������=======
- 'A���¿��� ��� - B���¿� �Ա�' �� �ϳ��� ������ ������ ���������
- ��, �Ѵ� ���� �Ǵ� �Ѵ� ����
- �̰��� 'Ʈ�����'�̶�� �Ѵ�.
- ##Ʈ�����: �ϳ��� ������ ����##
- Ʈ������� ó���ϴ� ����� 'Ŀ��'�� '�ѹ�'�̴�.
*/

--�⺻���� Ȯ��: desc emp
--���� ������ ������� ����?
select * from tab; --���� ���� ������ ������ �ִ� table�� ���)
--create table �� �� ������ �̹� �ִ� table���� ����� �� ����.
--�׶� �ʿ��� Ȯ�� ���~!~!
select * from tab where tname='BOARD'; -- �ش� �̸��� �ִ��� Ȯ��
/*
dbever ��ɾ�
-����� ���̺� ���� ����
SELECT *
FROM ALL_ALL_TABLE WHERE TAMLE_NAME = 'BOARD'
-����� �÷� ���� ����
SELECT *
FROM ALL_TAB_TABLE WHERE TAMLE_NAME = 'EMP'
*/

select * from col where tname='EMP';

----------------------------------------------------------
create table temp(
    id number primary key, --����: null����, �ߺ������͸� ������� �ʰڴ�.
                            -- '���Ἲ'
    name nvarchar2(20)   
);

--1.���� �Ϲ����� INSERT
INSERT INTO temp(id, name)
VALUES(100, 'ȫ�浿');

select * from temp;

commit; --�ǹݿ� (��ǻ�͸� ���� �ѵ� ����� �����ִ�)

--2. �÷� ��� ���� ���� (���߽� ������� �� ��!!! ������x)
INSERT INTO temp
VALUES(200, '������');

SELECT * FROM TEMP;

ROLLBACK; -- INSERT ���

--ID �÷� PK(Primary Key)
INSERT INTO temp(id, name)
VALUES(100,'�ƹ���');
--ORA-00001: unique constraint (BITUSER.SYS_C007005) violated
INSERT INTO temp(name)
VALUES('������');
--ORA-01400: cannot insert NULL into ("BITUSER"."TEMP"."ID")

--------------------------------------------------------------------
----------------------------------0305------------------------------

--TIP)
--�Ϲ����� SQL�� ���α׷����� ��Ұ� ����.
--PL-SQL (����, ����� ������ �ִ�)
--���߽ÿ� ���� ������ �ְ� TEST (10���Ǿ� �־�� ���� �׽�Ʈ�ϰ� �׷��� ...)

create table temp2 (id varchar2(50));
/*
BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO temp2(id) VALUES('A' || to_char(i));
    END LOOP;
END;
*/
SELECT * FROM temp2;
------------------------------------
--INSERT INTO ���̺��(�÷�����Ʈ) VALUES(�������Ʈ);

CREATE TABLE temp3(
    memberid NUMBER(3) NOT NULL, --���� 3�ڸ�, null�� �Ұ�
    name VARCHAR2(10), --null�� ���
    regdate DATE DEFAULT SYSDATE --�ʱⰪ�� ����(�⺻��), insert �ڵ� �ý��� ��¥
);

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
SELECT SYSDATE FROM dual;

INSERT INTO temp3(memberid, name, regdate)
VALUES(100,'ȫ�浿','2021-03-04');

SELECT * FROM temp3;
COMMIT;

INSERT INTO temp3(memberid, name)
VALUES(200,'������');

SELECT * FROM temp3;
COMMIT;

INSERT INTO temp3(memberid) VALUES(300);

SELECT * FROM temp3;
COMMIT;

INSERT INTO temp3(name) VALUES('����');
--ORA-01400: cannot insert NULL into ("BITUSER"."TEMP3"."MEMBERID")

---------------------------------------
--TIP)
--1. �뷮������ INSERT�ϱ�
CREATE TABLE temp4(id NUMBER);
CREATE TABLE temp5(num NUMBER);

INSERT INTO temp4(id) VALUES(1);
INSERT INTO temp4(id) VALUES(2);
INSERT INTO temp4(id) VALUES(3);
INSERT INTO temp4(id) VALUES(4);
INSERT INTO temp4(id) VALUES(5);
INSERT INTO temp4(id) VALUES(6);
INSERT INTO temp4(id) VALUES(7);
INSERT INTO temp4(id) VALUES(8);
INSERT INTO temp4(id) VALUES(9);
INSERT INTO temp4(id) VALUES(10);

SELECT * FROM temp4;
COMMIT;

SELECT * FROM temp5;

--�䱸����
--TEMP4�� �ִ� ��� �����͸� TEMP5�� �־��ּ���.
--INSERT INTO ���̺��(�÷�����Ʈ) SELECT ��
--����: �÷��� Ÿ���� ��ġ�ؾ��ϰ�, �޴� ���� ũ�Ⱑ �� ũ�ų� ���ƾ��Ѵ�.

INSERT INTO temp5(num)
SELECT id FROM temp4;

SELECT * FROM temp5;
COMMIT;

--2. �뷮 INSERT (2)
-- ���̺��� ���� ��Ȳ����, ���̺��� ����(����, ��Ű��)�ϰ� �����͸� �������ش�.
-- ��, ���������� ���簡 �ȵȴ�. (PK, FK ��...)
-- ������ ������ ������ ������ ����

CREATE TABLE copyemp
AS SELECT * FROM emp;
--Table COPYEMP��(��) �����Ǿ����ϴ�.

SELECT * FROM copyemp;
COMMIT;

CREATE TABLE copyemp2
AS 
  SELECT empno, ename, sal
  FROM emp
  WHERE deptno=30;
  
SELECT * FROM copyemp2;
COMMIT;

--����
--Ʋ(����, ��Ű��) ������ �����ϰ� �����ʹ� �����ϰ���� ��������?
CREATE TABLE copyemp3
AS
    SELECT * FROM emp WHERE 1=2; -- ���������� ������� �ȴ�.
                                 -- 1=1 �� ������ �׻� TRUE

SELECT * FROM copyemp3;
-----------------------------------insert end----------------------------

-----[UPDATE]-----
/*
UPDATE table_name
SET column1 = value1, [column2 = value2 ....]
[WHERE condition]

update ���̺��
set �÷� = ��� (�÷�2 = ���2 ...)
(where ������)

UPDATE table_name
SET column1 = (subquery)
WHERE column2 = (subquery)
*/

SELECT * FROM copyemp;

--�÷��� ��� ROW�� �ٲ��
UPDATE copyemp
SET sal = 0;

ROLLBACK;

UPDATE copyemp
SET sal=1111
WHERE deptno=20;

ROllBACK;

--���������� ����� ������Ʈ
update copyemp
set sal = (select sum(sal) from emp);

SELECT * FROM copyemp;
ROLLBACK;

--�������� �÷� ������Ʈ
update copyemp
set ename='AAA', job='BBB', hiredate=sysdate, sal = (select sum(sal) from emp)
where empno=7369;

ROLLBACK;

-----------------------------------update end-----------------------

--DELETE
delete from copyemp;

select * from copyemp;
rollback;

delete from copyemp where deptno=10;
commit;
-----------------------------delete end-----------------------

--������ (SQL) >> CRUD (Create(insert), Read(select), Update, Delete)
-- APP(JAVA) -  API(JDBC)   -Oracle
--�ڹ��ڵ带, ����Ŭ�̶�� ����Ʈ��� �����ؼ� �����͸� �ְ�, �����ϰ�, �����, ����(select)�ϴ� ��

--CRUD
--������: JAVA�ڵ忡�� ��ü ��ȸ, ���� ��ȸ, ����, ����, ���� �۾��� ���� �Ѵ�.
--JAVA�ڵ忡���� ��� �Լ��� �����.
--��ü��ȸ: public List<Emp> getEmpAllList() { select * from emp }
--������ȸ: public Emp getEmpListByEmpno(int empno) { select * from emp where empno=7788 }
--����: public int insertEmp(Emp emp) { insert into emp(...) values(.....)}



-----------------------------------------------------------------
--DDL (create, alter, drop (rename) : ���̺��� �����, �����ϰ�, ����(���̺����)
--����Ŭ.pdf (��9��) 138p

select * from board;

drop table board;
select * from board;
--ORA-00942: table or view does not exist

create table board(
    boardid number,
    title nvarchar2(50),
    content nvarchar2(2000),
    regdate date
);

desc board;

--TIP(������ȸ)
select * from user_tables where lower(table_name) = 'board';
select * from user_constraints where lower(table_name) = 'board'; --�������� Ȯ��
--

--Oracle 11g >> ���� �÷�(���� �÷�)
--�л� ���� ���̺�: ����, ����, ����, ����
--����, ����, ���� �����͸� insert�ϸ� �ڵ����� ���� �����Ͱ� ��������� �ϰ� �ʹ�.

create table vtable(
    no1 number,
    no2 number,
    no3 number GENERATED ALWAYS as (no1 + no2) VIRTUAL
);

insert into vtable(no1, no2) values(100,50);
insert into vtable(no1, no2) values(10,80);

select * from vtable;

-- ����: no3�� insert�ϸ� �ȵ�
insert into vtable(no1, no2, no3) values(10,80, 90);
--SQL ����: ORA-54013: INSERT operation disallowed on virtual columns

select * from user_tab_columns where table_name = 'VTABLE';
-- �������̺� Ȯ���ϱ�
-- DEFAULT�� ������ ������ �������̺�


--�ǹ�����  Ȱ���ϴ� �ڵ�
--��ǰ���� (�԰���) �б⺰ ������ (4�б�)
--�԰��� : 2019-03-01 >> 1�б�

create table vtable2
(
  no number , --����
  p_code char(4), --��ǰ�ڵ� (A001 , B002)
  p_date char(8), --�԰���(20190303)
  p_qty number, --����
  p_bungi number(1) GENERATED ALWAYS as (
                              CASE WHEN substr(p_date,5,2) IN ('01','02','03') THEN 1
                                   WHEN substr(p_date,5,2) IN ('04','05','06') THEN 2
                                   WHEN substr(p_date,5,2) IN ('07','08','09') THEN 3
                                   ELSE 4
                              END ) VIRTUAL
  );

select COLUMN_NAME , DATA_TYPE , DATA_DEFAULT 
from user_tab_columns where table_name='VTABLE2';

insert into vtable2(p_date) values('20180101');
insert into vtable2(p_date) values('20180126');
insert into vtable2(p_date) values('20190301');
insert into vtable2(p_date) values('20191225');
insert into vtable2(p_date) values('20190525');
select * from vtable2;
select * from vtable2 where p_bungi=1; --1�бⵥ���� ��������

commit;

--------------------------------------------------
--DDL: ���̺� ����� ����, ����

--1. ���̺� �����ϱ�
create table temp6(id number);

--2. �������̺� �÷� �߰��ϱ�
alter table temp6
add ename varchar2(20);

select * from temp6;
DESC temp6;


--3. ���� ���̺� �ִ� ���� �÷��� �̸� �ٲٱ�(rename)
alter table temp6
rename column ename to username;

select * from temp6;

--4. ���� ���̺� �ִ� ���� �÷��� Ÿ�� ���� ����(modify)
alter table temp6
modify(username varchar2(2000));

desc temp6;

--5. ���� ���̺� �ִ� ���� �÷� ����
alter table temp6
drop column username;


--@@ delete : ������ ���� (������ �������� ����)
--���̺��� ó�� ����� ó���� ũ�Ⱑ �־����� -> �����͸� ������ ������ ũ�⸸ŭ ���̺� ũ�⵵ Ŀ����.
--ex) ó�� 1m > ������ 10���� �߰� > 100m >> 10���� ����(delete) > �����ʹ� ����������, ũ��� �״�δ�... (100m)

--���̺��� �����͸� ������ �� ������ ũ�⸦ ���̷���..?
--truncate -> ����: where���� ����� �� ����.
--ex) ó�� 1m > ������ 10���� �߰� > 100m >> 10���� ����(truncate) > ������ ���� + ũ�� 1m

--7. ���̺� ����(drop)
drop table temp6;

---------------------------------------------

---------------------------------------------
--���̺� ���� �����ϱ�
--������ ���Ἲ ���� ����
--����Ŭ.pdf , 144p

--������ ���Ἲ Ȯ��
--insert, update (����)

/*
��) �÷� LEVEL ���� ����(COLUMN LEVEL CONSTRAINT) 
1) ������ ���� ������ �����Ѵ�.
2) ���Ἲ ���� ���� 5 ������ ��� ������ �� �ִ�.
3) NOT NULL ���� ������ �÷� LEVEL ������ ���� �ϴ�.

��) ���̺� LEVEL ���� ����(TABLE LEVEL CONSTRAINT) 
1) ���̺��� Į�� ���ǿʹ� ���������� �����Ѵ�.
2) �ϳ� �̻��� ���� ������ ��쿡 ���
3) NOT NULL �� ������ ������ ���� ���Ǹ� ���� �����ϴ�.
*/
/*
PRIMARY KEY(PK)   :�����ϰ� ���̺��� ������ �ĺ�(NOT NULL �� UNIQUE ������ ����)
                  :where empno=7788 > ������ 1�� ���� > ����
                    ��> ��ȸ�� �����ϰڱ���! > ���������� index�� �����
                  : ���㾾�� ��ȭ���� �����߾�� (100�����ν��� -> ��ȭå ã���ֱ� ����.)
                  : ��ȭå�� ������ 1000������ �÷Ⱦ��
                  : �ؼ����� ��ȭ�� �������Դµ� ���㾾�� å�� ã���ִ°� ����������
                  : å ã�� �ð��� �����ɷ��� ������ ������ �����߾��
                  : å�� ��ġ������ ������ �־�� �Ѵٴ� �������� �޾Ҿ��
                  : å�� ��ġ���� -> �ε���
                  : å�� �߰��ϰų� �����ϴ°� ���̵��� ... 
                     ��> (DML���� ������ ã�� ���� �ε��� �ο� �۾��� ��ȿ������ ���� �ִ�)
                  : �ε����� �ο��ϴ� ���� ȿ��������, ��ȿ���������� �Ǵ��ؾ��Ѵ�.
                  
FOREIGN KEY(FK)   :���� ������ �� ������ �ܷ�Ű ���踦 �����ϰ� �����մϴ�.
                  :���̺�� ���̺��� ���踦 �����ϴ� �� (��������)

UNIQUE key(UK)    :���̺��� ��� ���� �����ϰ� �ϴ� ���� ���� ��(NULL �� ���)
                  :PRIMARY�� ������ -> NULL ���!!
                  :���࿡ UNIQUE�� ��������� NULL�� ����ʹٸ�? -> NOT NULL UNIQUE
                    ��> PK�� �ٸ�����?
                        PK�� ���̺�� �Ѱ��� ����� �� ������, (�������� �÷��� ��� '�Ѱ�'�� ���� (����Ű))
                        UNIQUE�� �÷��� ������ŭ ����� �� �ִ�.
                  
                  
NOT NULL(NN)      :���� NULL ���� ������ �� �����ϴ�. (�ʼ��Է�)

CHECK(CK)         :���̾�� �ϴ� ������ ������(��κ� ���� ��Ģ�� ����)
                  :�������� ���� ���� �Է¹ްڴ�.
                  : ex. gender �÷� -> ��/�� �ΰ��� �����͸� �Էµǵ��� �ϰڴ�.
                  :where gender in ('��','��') -> �̷� ������ �������ǿ� �Ŵ� ��
                  : gender IN ('��','��')
*/

--���� ����� ����: create table
--���̺� ���� ���� �߰�: alter table ... add constraint ... (�𵨸� ��)

--TIP)
--���������� Ȯ���ϴ� ���
select * from user_constraints where table_name ='EMP';

create table temp7
(
    --id number primary key -- �������� �ʴ� ����Դϴ�.
                    -- ��> ������ �̸��� �ڵ������Ǳ� ������ ������ ������ ��ƴ�
    id number constraints pk_temp7_id primary key, -- ������ ǥ��(�̸�����: pk_temp7_id)
    name varchar2(20) not null,
    addr varchar2(50)
);

select * from user_constraints where table_name ='TEMP7';

insert into temp7(name,addr) values('ȫ�浿','����� ������');
--ORA-01400: cannot insert NULL into ("BITUSER"."TEMP7"."ID")
--ID�÷��� NULL�� �ȵſ�

insert into temp7(id,name,addr) values(10,'ȫ�浿','����� ������');

select * from temp7;
commit;

insert into temp7(id,name,addr) values(10,'�ƹ���','����� ������');
--ORA-00001: unique constraint (BITUSER.PK_TEMP7_ID) violated
--ID�÷��� �ߺ��� �ȵſ�

--1. Primary Key: ���̺�� 1���� ���� (but, �������� ��� 1���� ����!)
--create table member(ename, age) 
-- >> ename, age �ΰ��� �÷��� ��� �ϳ��� ����Ű�� ���� ������?
-- ��> �ϳ��� �÷����δ� ���ϰ��� ������ ���� ��!
-- ��> ex, ���������� �ִٸ� �̸������δ� pk�� ����ϱ� ���� ���ϱ� �÷� ������ ���������! ->�ߺ����� �ȳ�����!
-- ���࿡, ���������ε� �̸��� ����?
-- num�� ���� ��� ����Ű�� ����� ���ƿ� ... ���

CREATE TABLE temp8(
id NUMBER CONSTRAINT pk_temp8_id PRIMARY KEY,
name nvarchar2(30) NOT NULL,
jumin nchar(6) CONSTRAINT uk_temp8_jumin UNIQUE,  -- jumin null �ü� ���� -> not null�� �Ȱɾ
addr nvarchar2(1000)
);

INSERT INTO TEMP8(id, name, jumin, addr)
VALUES(10,'ȫ�浿','123456','��⵵');

SELECT * FROM TEMP8;
COMMIT;

INSERT INTO TEMP8(id, name, jumin, addr)
VALUES(20,'������','123456','����');
--ORA-00001: unique constraint (BITUSER.UK_TEMP8_JUMIN) violated
--JUMIN�� UNIQUE�� �ɾ���� �Ȱ��� �ֹι�ȣ�� ���� �� �����

--##UNIQUE -> NULL���� ����Ѵ�.
INSERT INTO TEMP8(id, name, addr)
VALUES(20,'������','����');

SELECT * FROM TEMP8;

--���࿡ UNIQUE�ε� NULL���� �����ϰ�;��
--jumin nchar(6) NOT NULL CONSTRAINT uk_temp8_jumin UNIQUE

--NULL�� �ߺ�üũ�� ���� �ʴ´�.
INSERT INTO TEMP8(id, name, addr)
VALUES(30,'�ƹ���','������');

SELECT * FROM TEMP8;
COMMIT;

-----------------------------------------------------------------
--���̺� ���� �� �������� �߰��ϱ�
CREATE TABLE temp9 (id NUMBER);

--����: ������ �߰��� �� ���̺� �ִ� �����͸� �˻��ؼ�, 
--     �ߺ������Ͱ� �ִٸ� PK�� �� ���� -> �ߺ������͸� ���� �Ŀ� ������ �߰��ؾ� �Ѵ�.

ALTER TABLE temp9
ADD CONSTRAINT pk_temp9_id PRIMARY KEY(id);

select * from user_constraints where table_name ='TEMP9';

--����Ű ��� ������?
--ADD CONSTRAINT pk_temp9_id PRIMARY KEY(id,num); <- �÷��� �ΰ� ������ �ȴ�.

ALTER TABLE temp9
ADD ENAME VARCHAR2(50);

--NOT NULL �߰�
ALTER TABLE temp9
MODIFY(ename NOT NULL); --NOT NULL�� MODIFY�� �߰��Ѵ�
----------------------------------------------------------------
----------------------------------------------------------------

--CHECK ����
--WHERE ���ǰ� ������ ������ ���� (-> WHERE gender IN ('��','��')
CREATE TABLE temp10(
    id NUMBER CONSTRAINT pk_temp10_id PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,
    jumin CHAR6(6) CONSTRAINT uk_temp10_jumin UNIQUE,
    addr VARCHAR2(20),
    age NUMBER CONSTRAINT ck_temp10_age CHECK(age >= 19)
);

CREATE TABLE temp10 (
id NUMBER CONSTRAINT pk_temp10_id PRIMARY KEY ,
name varchar2(20) NOT NULL ,
jumin char(6) CONSTRAINT uk_temp10_jumin UNIQUE,
addr varchar2(20),
age NUMBER CONSTRAINT ck_temp10_age check(age >= 19 )
-- where age >= 19   -> 19�� �̻� ã���� �ϸ�
);

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='TEMP10';

INSERT INTO TEMP10(id, name, jumin, addr, age)
VALUES(100,'ȫ�浿','123456','�����',25);

SELECT * FROM TEMP10;
COMMIT;

INSERT INTO TEMP10(id, name, jumin, addr, age)
VALUES(200,'������','123456','�����',18);
--ORA-02290: check constraint (BITUSER.CK_TEMP10_AGE) violated
--CHECK ������ �����.

--CHECK: ���� ���ϴ� �����͸� �ްڴ�.

  
------------------------------------------------------------
--��������: ���̺�� ���̺� ���� ����
CREATE TABLE c_emp
AS
   SELECT empno, ename, deptno FROM emp WHERE 1=2;
--emp�� �����⸸ ����

SELECT * FROM c_emp;

CREATE TABLE c_dept
AS
   SELECT deptno, dname FROM dept WHERE 1=2;
   
SELECT * FROM c_dept;

--����: A���̺� �ִ� ��� �÷��� �����ʹ� B���̺� �÷��� �����͸� �ްڴ�.
--ex. c_emp ���̺� �ִ� deptno �÷��� �����ʹ� c_dept ���̺� �ִ� deptno�÷��� �����͸� ���ڴ�.
--   = �����ϰڴ�(FK)

ALTER TABLE c_emp
ADD CONSTRAINT fk_c_emp_deptno FOREIGN KEY(deptno) REFERENCES c_dept(deptno);
-- ���� c_dept�� deptno�� PK�� �ƴ϶� ������ �� ���� ����
-- ��> ���� c_dept�� deptno�� PK ��������� �Ѵ�.
--  = �����ϱ� ���� c_dept >> deptno �÷��� �����ص� ������ ������ �ʴ´ٴ� ������ ����Ѵ�.....

ALTER TABLE c_dept
ADD CONSTRAINT pk_c_dept_deptno PRIMARY KEY(deptno); -- �ſ� Ȯ�� ..

ALTER TABLE c_emp
ADD CONSTRAINT fk_c_emp_deptno FOREIGN KEY(deptno) REFERENCES c_dept(deptno);
-- c_emp�� deptno�� c_dept�� deptno�� �����Ѵ�
-- c_deptno�� deptno�� c_emp�� deptno�� ���� �������Ѵ�.

--����
INSERT INTO c_dept(deptno, dname) VALUES(100, '�λ���');
INSERT INTO c_dept(deptno, dname) VALUES(200, '������');
INSERT INTO c_dept(deptno, dname) VALUES(300, 'ȸ����');

COMMIT;
SELECT * FROM c_dept;

--���Ի�� �Ի�
INSERT INTO c_emp(empno, ename) VALUES(100,'ȫ�浿'); --deptno�� �Է����� ���� ����
--deptno�÷��� fk�� �־ NOT NULL������ �ɾ���� ������ NULL���� ����.
SELECT * FROM c_emp; 
-- '���Ի���� �μ��� ������ �������� �ִ�' ��� �ó����� ������ �ִٸ� not null�� �Ȱɾ�δ°�
-- ���� '��� ����� �ݵ�� �μ��� ������ �Ѵ�'���, NOT NULL�� �ɾ�־� �Ѵ�.
-- CREATE TABLE c_emp(deptno NOT NULL .. CONSTRAINT... )

INSERT INTO c_emp(empno, ename, deptno) VALUES(200, '������', 50);
--ORA-02291: integrity constraint (BITUSER.FK_C_EMP_DEPTNO) violated - parent key not found
-- ��> DEPT���̺��� DEPTNO�� 50�� ���� ..

INSERT INTO c_emp(empno, ename, deptno) VALUES(200, '������', 100);
--FK�� �ɾ�����ϱ�, dept���̺��� deptno�� �ִ� �μ���ȣ�� ����� �� �ִ�.

COMMIT;

------------------------------
--�����ڰ���
--���̺� (�θ�, �ڽ�)
--c_emp, c_dept ���̺��� deptno��� �÷��� �������� ���� ��, ���� �θ��ϱ�?
--�θ�(master): c_dept  - deptno���� PK
--�ڽ�(detail): c_emp   - deptno���� FK

--c_dept���� 100�̶�� �����͸� ������ �� ������?
--������ �������� �ִ� ���¶��, ������ �� ����.
DELETE FROM c_dept WHERE deptno=100;
--ORA-02292: integrity constraint (BITUSER.FK_C_EMP_DEPTNO) violated - child record found
--������ '100'�� �ڽ����̺��� �̹� ����ϰ� �ֱ� ������!
--�����ʹٸ�, ���� �ڽ����̺��� 100���� ������ �ڿ� ���� �� �ִ�.
DELETE FROM c_Dept WHERE deptno=200; -- ���� (����ϰ����� �ʱ� ������)

COMMIT;

/*
(column datatype [CONSTRAINT constraint_name]       
REFERENCES table_ name (column1[,column2,..] [ON DELETE CASCADE]) 

column datatype, . . . . . . . , 
[CONSTRAINT constraint_name] FOREIGN KEY (column1[,column2,..])        
REFERENCES table_name  (column1[,column2,..] [ON DELETE CASCADE]) 
*/
-- [ON DELETE CASCADE]  �θ����̺�� ������ ���� �ϰڴ�
-- 300 ���� �� �� �ֳ���?  �� 
-- delete from c_dept where detpno=300;
-- �����ϴ� �ڽ� ������ ���� ����
-- delete from c_emp where deptno=300; ���� ����

alter table c_emp
add constraint fk_emp_deptno foreign key(deptno) references c_dept(deptno) 
ON DELETE CASCADE;

--Tip
--MS-SQL
--ON DELETE CASCADE;
--ON UPDATE CASCADE;

/*
�л����̺�: student_score
�̸�: name
�й�: student_number
����: korean
����: math
����: english
����: sum
���: avg

�а����̺�: major
�а��ڵ�: major_code
�а���: major_name


--���� ���̺�, ���� �÷���
--[�л� ���� ���̺�]
--�й��� �����ʹ� �ߺ��ǰų� NULL ���� ����ϸ� �ȵȴ�
--�̸� NULL ���� ������� �ʴ´�
--����, ����, ���� ���� �÷��� ���� Ÿ���̰� NULL ���� ���
--���� �Է����� ������ default�� 0���� ���´�
--���� ,��� �÷��� �����÷�����(�����÷�) �����Ѵ�
--�а��ڵ�� �а� ���̺� �а��ڵ带 �����Ѵ�
--�й� , �̸� , ���� , ���� , ���� , ���� , ��� , �а��ڵ�

--[�а� ���̺�]
--�а��ڵ� �����ʹ� �ߺ��ǰų� NULL ���� ����ϸ� �ȵȴ�,
--�а��� �� null���� ������� �ʴ´�
--�а��ڵ� , �а���

--���� ������ insert ..

--�׸��� select �����
--�й� , �̸� ����, ��� , �а��ڵ� , �а��� �� ����ϼ���
*/


CREATE TABLE MAJOR(
    MAJOR_CODE NUMBER CONSTRAINTS PK_MAJOR_MAJER_CODE PRIMARY KEY,
    MAJOR_NAME NVARCHAR2(10) NOT NULL
);

SELECT * FROM MAJOR;

CREATE TABLE STUDENT_SCORE(
    STUDENT_NUMBER NUMBER CONSTRAINTS PK_SCORE_STUDENT_NUMBER PRIMARY KEY,
    NAME NVARCHAR2(10) NOT NULL,
    KOREAN NUMBER DEFAULT 0,
    ENGLISH NUMBER DEFAULT 0,
    MATH NUMBER DEFAULT 0,
    SUM NUMBER GENERATED ALWAYS as (KOREAN + ENGLISH + MATH) VIRTUAL,
    AVG NUMBER GENERATED ALWAYS as ((KOREAN + ENGLISH + MATH)/3) VIRTUAL,
    MAJOR_CODE NUMBER
);

SELECT * FROM STUDENT_SCORE;

ALTER TABLE STUDENT_SCORE
ADD CONSTRAINT fk_SCORE_MAJOR_CODE FOREIGN KEY(MAJOR_CODE) REFERENCES MAJOR(MAJOR_CODE);

INSERT INTO MAJOR(MAJOR_CODE, MAJOR_NAME) VALUES(10, 'liberal');
INSERT INTO MAJOR(MAJOR_CODE, MAJOR_NAME) VALUES(20, 'natural');
INSERT INTO MAJOR(MAJOR_CODE, MAJOR_NAME) VALUES(30, 'artistic');

SELECT * FROM MAJOR;
COMMIT;

DELETE FROM MAJOR;

INSERT INTO STUDENT_SCORE(STUDENT_NUMBER, NAME, KOREAN, ENGLISH, MATH, MAJOR_CODE)
VALUES(1,'HONG',50,60,70,10);

INSERT INTO STUDENT_SCORE(STUDENT_NUMBER, NAME, KOREAN, ENGLISH, MATH, MAJOR_CODE)
VALUES(2,'KIM',80,80,30,20);
INSERT INTO STUDENT_SCORE(STUDENT_NUMBER, NAME, KOREAN, ENGLISH, MATH, MAJOR_CODE)
VALUES(3,'LEE',10,20,10,30);
INSERT INTO STUDENT_SCORE(STUDENT_NUMBER, NAME, KOREAN, ENGLISH, MATH, MAJOR_CODE)
VALUES(4,'PARK',90,90,100,30);
INSERT INTO STUDENT_SCORE(STUDENT_NUMBER, NAME, KOREAN, ENGLISH, MATH, MAJOR_CODE)
VALUES(5,'JUNG',30,40,70,10);
INSERT INTO STUDENT_SCORE(STUDENT_NUMBER, NAME, KOREAN, ENGLISH, MATH, MAJOR_CODE)
VALUES(6,'MOON',100,70,90,20);

SELECT * FROM STUDENT_SCORE;
COMMIT;

SELECT S.STUDENT_NUMBER, S.NAME, S.SUM, trunc(S.AVG,1), M.MAJOR_CODE, M.MAJOR_NAME
FROM STUDENT_SCORE S JOIN MAJOR M
ON S.MAJOR_CODE = M.MAJOR_CODE;


---------------------------------------------------------------------------
---------------------------------[0308]------------------------------------

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

select * from emp;
select * from dept;
select * from salgrade;

--View ��ü ... (�������̺�)
--����Ŭ.pdf (��12��) 192p

--view ��ü (create...)
--create view ���̸� as [select ����]

--view�� ���̺�ó�� ��밡���� �������̺��̴� (������ �����͸� ������ �ִ� ���� x)
--view�� �޸𸮻󿡸� �����ϴ� �������̺��̴�
--(subquery -> in line view -> from (select deptno avg(sal) from ... ) --> �ӽ������� ������� ��
--create view�� view�� ��ü�� ���� �ʿ��Ҷ����� �ҷ��� ���ڴ�.

--view�� ����'���̺�'
--������ �Ϲ� ���̺�� �����ϴ�. (select , where ... )
--��, view�� �� �� �ִ� �����Ϳ� ���ؼ��� �����ϴ�.
--view�� ���ؼ� �������̺� ���� DML(insert, update, delete)�� �����ϴ�. --> �������� x

create view v_001
as
  select empno, ename from emp;
  --ORA-01031: insufficient privileges
  --bituser�� view�� ���� �� �ִ� ������ ����.
  
--GRANT CREATE ANY VIEW TO "BITUSER" WITH ADMIN OPTION;
--SYSTEM �������� ���� �ο���

create view v_001
as
  select empno, ename from emp;
  
select * from v_001; -- view�� �������ִ� SQL������ ����� ���̴�.

--VIEW ������
--1. �������� ���� : JOIN, SUBQUERY >> VIEW��� >> ������ �������� >> BUT �������� ���� ������ ���
--2. ������ �ܼ�ȭ(����) : ������ ������ �Ź� ġ�� ���� �ƴ϶� �̸� �����ΰ� ����ϴ� ���̴�.
--3. �������� ���� > ���ȼ� : Ư�� �÷��� ����Ǵϱ�!
--                      : �����ڰ� EMP������ �ô� ������� VIEW�� ���� �ѱ�� ��
CREATE VIEW v_emp
AS
    SELECT empno, ename, job, hiredate FROM emp;
-- �̷��� ���� ���Ի������ view�� �� �� �ִ� ���� + v_emp�� ����϶�� �Ѱ��ش�.

--VIEW�� ���� �۾�
SELECT * FROM v_emp;
SELECT * FROM v_emp WHERE job = 'CLERK';
SELECT empno FROM v_emp;

--����
CREATE VIEW v_002
AS
    SELECT e.empno, e.ename, e.deptno, d.dname
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno;
    
SELECT * FROM V_002;
SELECT * FROM v_002 WHERE deptno=20;

CREATE VIEW v_003
AS
    SELECT deptno, avg(sal) as avgsal -- �÷��� �ο��� ��(as), ���Ⱑ ������ "" �Ⱥ��̴°� ���ϴ�
    FROM emp
    GROUP BY deptno;
--ORA-00998: must name this expression with a column alias
--�� �������̺��� ������.. '���� ���̺��ε�..�÷����� �������� ...'

SELECT deptno, avgsal FROM v_003;

/*
CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW view_name [(alias[,alias,...])]
AS Subquery 
[WITH CHECK OPTION [CONSTRAINT constraint ]]
[WITH READ ONLY]

OR REPLACE               �̹� �����Ѵٸ� �ٽ� �����Ѵ�.
FORCE Base Table         ������ ������� VIEW �� �����.
NOFORCE                  �⺻ ���̺��� ������ ��쿡�� VIEW �� �����Ѵ�.
view_name                VIEW �� �̸�
Alias Subquery �� ���� ���õ� ���� ���� Column ���� �ȴ�.
Subquery SELECT ������ ����Ѵ�.
WITH CHECK OPTION VIEW   �� ���� �׼��� �� �� �ִ� �ุ�� �Է�,���ŵ� �� �ִ�.  
                        --view�� �� �� �ִ� �͸� ����, �������Է��� �� �� �ֵ��� �ϰڴ�
Constraint CHECK OPTON   ���� ���ǿ� ���� ������ �̸��̴�.
WITH READ ONLY           �� VIEW ���� DML �� ����� �� ���� �Ѵ�.
                        --�б��������� �ϰڴ�. (����, ���� x)

*/
create or replace view v_004 --������ ���� �����, ������ ������
as
    select avg(sal) as avgsal from emp;
    
select * from v_004;
    
create or replace view v_004 --������ ���� �����, ������ ������
as
    select round(avg(sal),0) as avgsal from emp;
    
select * from v_004;

--Q. select�� �Ǵµ� update, insert, delete�� �ȵſ� ....
--A. ������Ʈ�� DB �Ѵ븦 ������ �� /
--   �Ѹ��� update�ϸ� �� ����� commit�� rollback�� �ϱ� ������ rock ���¿� �ɷ��ִ�.
--   commit, rollback�� ����ȭ����~~~~~

--view = ���� ���̺� (->DML�۾��� �����ϴ� / insert, update, delete)
--��, "view�� ���ؼ� �� �� �ִ� ������ + �������̺�" �� �۾��� �� �ִ�.

--�ܼ� view (���̺� 1��) >> DML����, but �ǵ����̸� ���� ������~~~
--���� view (���̺� 1���̻�) >> join, subquery�� ���� ���� ���� DML �Ұ�

select * from v_emp;

update v_emp set sal=0; 
-- v_emp�� sal�� �� �� ���� �����̱� ������ error
--ORA-00904: "SAL": invalid identifier

update v_emp set job='IT';
-- ����
-- ���� emp ���̺� �ݿ��Ǵ� ���̴� (view�� �����Ͱ� �����ϱ�~~~)
--view�� ������ ���� ���̺��� �����͸� �����ϴ� ��
select * from emp;
rollback;

--30�� �μ� ������� ����, �̸�, ������ ��� VIEW�� ����µ�, 
--������ �÷����� ����, ����̸�, �������� alias�� �ְ� ������ 300���� ���� ����鸸 �����ϵ��� �϶�

CREATE OR REPLACE VIEW VIEW_101
AS
    SELECT JOB AS ����, ENAME AS ����̸�, SAL AS ����
    FROM EMP
    WHERE DEPTNO=30 AND SAL >= 300;

SELECT * FROM VIEW_101;

/*
tIP
CREATE OR REPLACE VIEW VIEW_101(����,����̸�,����) --AS ALIAS �ο����� ���� �Ȱ��� ���´�.
AS
    SELECT JOB, ENAME, SAL
    FROM EMP
    WHERE DEPTNO=30 AND SAL >= 300;
    
*/

--�μ��� ��տ����� ��� VIEW�� �����, ��տ����� 2000�̻��� �μ��� ����ϵ��� �϶�
--FROM ���� => WHERE
--GROUP BY ���� => HAVING
SELECT * FROM EMP;

CREATE OR REPLACE VIEW  VIEW_102
AS
    SELECT DEPTNO, ROUND(AVG(SAL),0) AS ��տ��� FROM EMP
    GROUP BY DEPTNO HAVING AVG(SAL) >= 2000;
    
SELECT * FROM VIEW_102;

--DEPT�� �����ؼ�, �μ��̸��� ����ϱ�
SELECT V.DEPTNO, V.��տ���, D.DNAME
FROM VIEW_102 V JOIN DEPT D
ON V.DEPTNO = D.DEPTNO;


----------------------------------------------------------------
--- ������ �������� SQL�߿��� �߿��� �� ���캸�� 1��
--����Ŭ.pdf (��11��) 185p
--���� �����ϱ� (ä���ϱ�)
--SEQUENCE
--�ڵ����� ��ȣ�� �����ϴ� ��ü
/*
sequence_name        SEQUENCE �� �̸��Դϴ�.
INCREMENT BY n       ���� ���� n ���� SEQUENCE ��ȣ ������ ������ ����.
                     �� ���� �����Ǹ� SEQUENCE �� 1 �� ����.
START WITH n         �����ϱ� ���� ù��° SEQUENCE �� ����.
                     �� ���� �����Ǹ� SEQUENCE �� 1 �� ����.
MAXVALUE n           SEQUENCE �� ������ �� �ִ� �ִ� ���� ����.
NOMAXVALUE           ���������� 10^27 �ִ밪�� ����������-1 �� �ּҰ��� ����.
MINVALUE n           �ּ� SEQUENCE ���� ����.
NOMINVALUE           ���������� 1 �� ����������-(10^26)�� �ּҰ��� ����.
CYCLE | NOCYCLE      �ִ� �Ǵ� �ּҰ��� ������ �Ŀ� ��� ���� ������ ���� ���θ� ����. NOCYCLE �� ����Ʈ.
CACHE | NOCACHE      �󸶳� ���� ���� �޸𸮿� ����Ŭ ������ �̸� �Ҵ��ϰ� �����ϴ°��� ����. 
                     ����Ʈ�� ����Ŭ ������ 20 �� CACHE.
*/

--����
-- ex) web site�� �Խ��� >> key(�ĺ���) >> 1.2.3... ������ �ο��ؾ��Ѵ�.

DROP TABLE board;

CREATE TABLE board(
    boardid NUMBER constraint pk_board_boardid primary key,
                    --PK: NOT NULL, UNIQUE ����, ���������� INDEXT �ڵ�����)
    title nvarchar2(50)
);

select * from board;
--�Խ��ǿ� ���� ����
--INSERT INTO board(BOARDID, TITLE) VALUES();
--BOARDID �÷��� �����ʹ� ó�� ���� ���� 1 �̶�� ���� INSERT�ǵ��� �ϱ�
--�� ���� �� ���ʹ� 2,3,4.... �������� �����Ͱ� INSERT �ǵ��� ��Ģ�� ����� ������.
-- HINT) VALUES �ȿ� SUBQUERY�� ���� �� �ִ�.
/*
INSERT INTO board(boardid, title)
VALUES( , 'ó����') -- ID�� 1�� �����Ѵ�.

INSERT INTO board(boardid, title)
VALUES( , '�ι�°��') -- ID�� 2�� ���� �Ѵ�.
*/

SELECT COUNT(BOARDID) + 1 FROM BOARD;

INSERT INTO board(boardid, title)
VALUES((SELECT COUNT(BOARDID) + 1 FROM BOARD) , 'ó����'); -- ID�� 1�� �����Ѵ�.

INSERT INTO board(boardid, title)
VALUES((SELECT COUNT(BOARDID) + 1 FROM BOARD) , '�ι�°��');

select * from board;
COMMIT;

--������??
--CRUD���� (INSERT, UPDATE, DELETE)
DELETE FROM board WHERE boardid=1;
COMMIT;

INSERT INTO board(boardid, title)
VALUES((SELECT COUNT(BOARDID) + 1 FROM BOARD) , '����°��');
--ORA-00001: unique constraint (BITUSER.PK_BOARD_BOARDID) violated
--�߰��� �����ϰ� �ٽ� ���Խ� �Ȱ��� �����Ͱ� ����.
--DML�� ������ �߻��Ѵ�.

--�ٸ� ��� �ʿ�!!
DELETE FROM board;
COMMIT;

INSERT INTO board(boardid, title)
VALUES((SELECT MAX(BOARDID) + 1 FROM BOARD) , 'ó����');
--ORA-01400: cannot insert NULL into ("BITUSER"."BOARD"."BOARDID")

INSERT INTO board(boardid, title)
VALUES((SELECT NVL(MAX(BOARDID),0) + 1 FROM BOARD) , 'ó����');
INSERT INTO board(boardid, title)
VALUES((SELECT NVL(MAX(BOARDID),0) + 1 FROM BOARD) , '�ι�°��');
INSERT INTO board(boardid, title)
VALUES((SELECT NVL(MAX(BOARDID),0) + 1 FROM BOARD) , '����°��');

select * from board;
COMMIT;

DELETE FROM board WHERE boardid=1;

INSERT INTO board(boardid, title)
VALUES((SELECT NVL(MAX(BOARDID),0) + 1 FROM BOARD) , '�׹�°��');

select * from board;
COMMIT;

--------SEQUENCE ��ü�� ���� ��ȣ ������ �� �� �ִ�.
-- �ߺ����� ����, �������� ���� �����Ѵ� (������ü)

CREATE SEQUENCE board_num;

SELECT * FROM USER_SEQUENCES;

/*
187P (����Ŭ.PDF)
>> NEXTVAL �� CURRVAL �ǻ翭 
> Ư¡ 
1) NEXTVAL �� ���� ��� ������ SEQUENCE ���� ��ȯ �Ѵ�.
2) SEQUENCE �� ������ �� ����, �ٸ� ����ڿ��� ������ ������ ���� ��ȯ�Ѵ�.
3) CURRVAL �� ���� SEQUENCE ���� ��´�.
4) CURRVAL �� �����Ǳ� ���� NEXTVAL �� ���Ǿ�� �Ѵ�.
*/

--��ȣ����
SELECT board_num.NEXTVAL FROM dual; --ä��/�ݺ������ϸ� ��ȣ�� �����Ѵ�.
--������� ä���� ��ȣ�� Ȯ���ϱ� (������ ��ȣ Ȯ��)
SELECT board_num.CURRVAL FROM dual;

--------------------------------------------
--�Խ��� ����
CREATE TABLE kboard(
    num NUMBER CONSTRAINT pk_kboard_num PRIMARY KEY,
    title NVARCHAR2(20)
);

--�Խ��ǿ��� ���Ǵ� ä���� ����
CREATE SEQUENCE kboard_num;

INSERT INTO kboard VALUES(kboard_num.NEXTVAL , 'ù��° �� �Դϴ�');
INSERT INTO kboard VALUES(kboard_num.NEXTVAL , '�ι�° �� �Դϴ�');
INSERT INTO kboard VALUES(kboard_num.NEXTVAL , '����° �� �Դϴ�');

SELECT * FROM KBOARD;

DELETE FROM kboard WHERE num=1;
SELECT * FROM KBOARD;
COMMIT;

SELECT kboard_num.CURRVAL FROM dual;

INSERT INTO kboard VALUES(kboard_num.NEXTVAL , '�׹�° �� �Դϴ�');
SELECT * FROM KBOARD;
COMMIT;

-------------------------------------------------------------
--1. SEQUENCE ��ü�� TABLE�� ���ӵ��� �ʴ´�.
--   �ϳ��� SEQUENCE�� �������� ���̺��� ��� �����ϴ�)
--   SEQUENCE ���� > A���̺�, B���̺��� ��� ����

--   ������Ʈ�� �Խ����� 10���� ��
--   ��ǰ �Խ���, ������ �Խ���, ȸ�� �Խ��� ....
--   SEQUENCE�� 10�� ���� ���� ����� ���� �ְ�, 1���� ���� 10���� ���̺��� ����� ���� �ִ�.
--   Ŭ���̾�Ʈ�� �䱸���׿� ���� ����� �ȴ�.

--TIP)
--MS-SQL: CREATE TABLE board(boardnum INT identity(1,1), title VARCHAR(20));
--                                                  ��> ���۰� 1, ������ 1
--        INSERT INTO board(title) values('�氡') >> boardnum�� �ڵ����� 1,2,3... 
--        identity�� ��� ���̺� �������̴�
--        2012�������ʹ� SEQUENCE��ü�� �������. (�� �� ����)
--MYSQL: CREATE TABLE board(boardnum INT auto_increment, title VARCHAR(20));
--       INSERT INTO board(title) values('�氡') >> boardnum�� �ڵ����� 1,2,3...
--       SEQUENCE���� ����
--MARIADB : MYSQL�� ���� ������� OPEN SOURCE�������� ���� �� (MYSQL�� ���� ������ ����Ѵ�)
--          https://mariadb.com/kb/en/create-sequence/
--          SEQUENCE ����

----------------------------------------------------------
--�ɼ�
CREATE SEQUENCE seq_num
START WITH 10   --10���� ����
INCREMENT BY 2; --2�� ����

SELECT seq_num.NEXTVAL FROM dual; --10���� �����ؼ� 2�� ���� Ȯ�� ����
SELECT seq_num.CURRVAL FROM dual;

--�Խ��� �� 100��
/*
num     title       content 
1
2
3
....
100

> �Ϲ����� �Խ����� �ֽű�(���� ���߿� �� ��)�� ȭ�� ��ܿ� ��������.
�۹�ȣ�� �������� �����Ѵ�.
ORDER BY ��������ȣ DESC;
*/
SELECT * FROM kboard ORDER BY num DESC;
--�Ϲ� �Խ����� ù ����
--�ֽűۺ��� ���� ���������� �ۼ��� ��
------------------------------------------------------------------
---------------------------------------------------------------
--- ������ �������� SQL�߿��� �߿��� �� ���캸�� 2��
--rownum �ǻ��÷�: ���� ���������� �����ϴ� �÷��� �ƴϰ� ������ ����
--rownum: ������ ���̺��� �÷��� �������� ������, ���������� ���� ��ȣ�� �ο��� �� �ִ� �÷�

SELECT * FROM emp;
SELECT ROWNUM AS ���� , empno, ename FROM emp;
--SELECT�� ����� ������ �ο��ϴ� ��

--����
--1. TOP-n : ���ĵ� �������� ������ � ���� (ex. 1����� 10�����~~)
--         : ���̺��� ���ǿ� �´� ����(TOP)���� ���ڵ�(row) n�� �����ض� 
--TIP) MS-SQL: TOP Ű���� ����
--           : SELECT TOP 10, * FROM emp ORDER BY sal DESC;
--
--         : ORACLE���� TOP Ű���� X
--         : rownum�� ����ؼ� ������ �ο��� �� Ư�� ������ ����ؼ� top ���� �����ϱ�
--         : (1) ������ ������ ���ϱ� (����)
--         : (2) ���ĵ� �����͸� �������� rownum�� �����ϰ�, 
--         : (3) ������ �ɾ �����͸� ����

--(1) ���ı����� ���� (�޿��� ���� �޴� ������ ����)
SELECT *
FROM ( 
        SELECT *
        FROM emp
        ORDER BY sal DESC) e;

--(2) rownum ���̱�
SELECT ROWNUM AS num, e.*
FROM (  SELECT *
        FROM emp
        ORDER BY sal DESC) e;
--num: �������̺�
        
--(3) ���� �ɱ� (�޿��� ���� �޴� ��� 5��)
SELECT *
FROM ( SELECT ROWNUM AS num, e.*
       FROM (  SELECT *
               FROM emp
               ORDER BY sal DESC) e
     ) n
WHERE num <= 5;
--------------------------------------------------------------------
--Top-n : �Խ����� pagingó���� ���ȴ�.
--���� �����Ͱ� 100�� �ִ�
--�� ȭ�鿡 100���� �����͸� �ѹ��� ������� �ʴ´�.
--10�Ǿ� �� ȭ�鿡 ����ϰ� �ʹ�.
--pagesize = 10 (�� ȭ��(������)�� ������ �� �ִ� row�� �Ǽ�)
--page�� ������ �� �� �ִ�. >> 10page�� �����ڱ�!
--1page, 2page, ... , 10page (1page Ŭ�� >> select 1~10 �ؼ� JAVA���� ����)
--                           (2page Ŭ�� >> select 11~20 �ؼ� JAVA���� ���� ...)
--<a hreg='page.jsp'>10</a> 10page( 91~100)
-------------------------------------------------------------------
--HR �������� �̵�
SELECT * FROM employees; -- 107���� ������

--1�ܰ�. ������ �Ǵ� ������ �����
SELECT * FROM employees ORDER BY employee_id ASC;

--2�ܰ�. ���ص����Ϳ� ���� �ο��ϱ�
SELECT ROWNUM AS num, e.*
FROM ( SELECT * FROM employees ORDER BY employee_id ASC ) e;

SELECT ROWNUM AS num, e.*
FROM ( SELECT * FROM employees ORDER BY employee_id ASC ) e
WHERE ROWNUM <= 50; --���������� ������ ROWNUM ��� (SELECT���� �ִ� ROWNUM�� �ٸ� ��)

--3�ܰ�. ���� �ɱ�
SELECT *
FROM (  SELECT ROWNUM AS num, e.*
        FROM ( SELECT * FROM employees ORDER BY employee_id ASC ) e
        WHERE ROWNUM <= 50
      ) n
WHERE num >= 41;
--�ؼ�
--107���� ������
--pagesize = 10
--[1][2][3][4][5][6][7][8][9][10][11]
--[1] : 1~10�� ������
--[2] : 11~20�� ������
-- ...
--���� �������� [5]�� �������� Ŭ������ ���� ����� �� (41~50���� �����͸� �����ִϱ�)

--IF, [1]�� ������ Ŭ��?
SELECT *
FROM (  SELECT ROWNUM AS num, e.*
        FROM ( SELECT * FROM employees ORDER BY employee_id ASC ) e
        WHERE ROWNUM <= 10
      ) n
WHERE num >= 1;

--BETWEEN A AND B ��� ����
--WHERE ROWNUM BETWEEN 1 AND 10;
--SERVLET & JSP ������ �ٽ� ��� ��

---------------------------------------------------------------
--------------------------SQL END------------------------------
---------------------------------------------------------------