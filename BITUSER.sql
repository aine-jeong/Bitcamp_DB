/*
[1일차 수업]
1. 오라클 소프트웨어 다운로드
https://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html

2. Oracle Database 11g Release 2 Express Edition for Windows 64 (무료설치)

3. Oracle 설치(SYS, SYSTEM 계정에 대한 암호 : 1004)

4.Sqlplus 프로그램 제공(CMD) : GUI 환경 일반개발자 사용 불편

5.별도의 Tool 설치 무료(SqlDeveloper , https://dbeaver.io/)  ,
                 유료(토드 , 오렌지 , SqlGate) 프로젝트시 설치 활용 ^^

6. SqlDeveloper 툴을 통해서 Oracle Server 접속 ....
   >> HR 계정 : 암호 1004 , Unlock 2가지 사용가능 .... (사원관리 실습 테이블)
   >> 새로운 계정 : BITUSER


7. 현재 접속 계정 확인 : show user;   >> USER이(가) "BITUSER"입니다.


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
실습코드

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
사원 정보를 저장할 수 있는 논리적인 공간을 만들겠다.
*/

-- 1. 사원테이블에서 모든 데이터를 출력하세요.
--[쿼리문]은 [대소문자]를 구별하지 않는다.
select * from emp;
SELECT * FROM EMP;

--2. 특정 컬럼 데이터 출력하기
select empno, ename, sal
from emp;

--3. 컬럼명에 가명칭(alias/ 별칭) 부여하기
select empno 사번, ename 이름
from emp;

--SQL(데이터를 다루는 수많은 소프트웨어가 있다) >> 표준을 정하자 >> ANSI 문법
--as"사   번" 요론게 표준문법이다.
--mysql, MS-SQL 에도 동일하게 아래 쿼리가 동작한다.
select empno as "사   번", ename as "이    름"
from emp;

--Oracle 데이터: [문자열 데이터]는 엄격하게 [대소문자]를 구분한다.
--JAVA: 문자-> 'A' , 문자열->"AAA"
--Oracle: 문자열 'A', 'AAA'
--Oracle: A 와 a는 다른 문자이다.
select empno, ename
from emp
where ename='king'; --조건절 (king은 없당... KING만있음)

select empno, ename
from emp
where ename='KING';

/*
select 절  3
from 절    1
where 절   2
*/

--Oracle Query(질의어): 언어
--연산자가 있다. (결합연산자 || , 산술연산자 + )
--java: + 숫자일때는 산술연산, 문자일때는 결합연산이였다!
--Tip) Ms-sql 은 +로 결합, 산술 둘다 한다.

select '사원의 이름은 ' || ename || '입니다.' as "사원정보"
from emp;

--테이블에는 컬럼 >> 타입
--java class Emp {private int empno, private String ename}
--Oracle create table emp (empno number)
--타입(컬럼): 숫자, 문자열, 날짜
--create table emp (ename varchar2(10));
--(10) -> 10Byte >> 한글 1자 2Byte / 영문자, 특수문자, 공백 1Byte
--한글 5자, 영문자 10자 입력 가능

desc emp;

--형변환 (내부적으로 자동 형변환이 일어난 후(숫자->문자열) 결합해준다.)
select empno || ename
from emp;
-- 아래 코드는 에러난다. (ORA-01722: invalid number / 숫자 '+' 문자열 불가)
select empno + ename
from emp;

--개발실 근무중...
--사장님 say "우리회사에 직종이 몇개나 있나?"
select job from emp; --이렇게 보여주면 안돼 ...
--중복 데이터를 제거하는 키워드(예약어): distinct
select distinct job
from emp;
--distinct의 원리: grouping

select distinct job, deptno 
from emp
order by job; 
--job으로 group, 그 안에 다시 deptno로 group 1건씩(중복되지 않는 데이터를 그루핑)

select distinct  deptno, job
from emp
order by deptno;

--Oracle sql 연산자 
--자바 ( +, -, *, /, % )
--Oracle : %를 연산자로 사용하지 않는다 >> 함수 Mod()

--사원테이블에서 사원의 급여를 100달라 인상한 결과를 출력하세요.

select empno, ename, sal, sal + 100 as "인상급여"
from emp;

--dual 임시 테이블(가상)
select 100 + 100 from dual; --데이터 테스트시 이용한다.
select 100 || 100 from dual; --100100
select '100' + 100 from dual; --200 (형변환) >> '100' 숫자형 문자(형변환시 숫자가 되는 데이터)
select 'A100' + 100 from dual; -- 에러 >> ORA-01722: invalid number

--비교 연산자
-- <  >  <=  >= 등등..
--주의
--java: == 같다 / = 할당
--javascript: ==, === 같다
--Oracle: = 같다 / != 같지않다

--논리 연산자
--AND, OR, NOT

select empno, ename, sal
from emp;

select empno, ename, sal
from emp
where sal >= 2000;

--사번이 7788번인 사원의 사번, 이름, 직종, 입사일을 출력해보세요
select empno, ename, job, hiredate   --3
from emp                             --1
where empno=7788;                    --2

/*
개발자: select (70%), insert, update, delete (CRUD)
관리자: 백업하고 복구, 장애(네트워크, 성능) 관리, 보안 (사용자권한.. 암호화)
튜닝(쿼리튜닝, 하드웨어): 문장튜닝(속도) -> 시간 단가
설계(모델러): 설계 (요구사항 정의, 분석) DB-Modeling : domain (업무)
*/

--사원의 이름이 king인 사원의 사번, 이름, 급여 정보를 출력하세요.
select empno, ename, sal
from emp
where ename='KING';

--급여가 2000달러 이상이면서, 직종이 manager인 사원의 모든 정보를 출력하세요
--hint: AND, OR
select *
from emp
where sal>=2000 AND job='MANAGER'; -- AND는 모든 조건에 만족

/*   AND   OR
0 0   0     0
0 1   0     1
1 0   0     1
1 1   1     1
*/

--급여가 2000달러 이상이거나 또는 직종이 manager인 사원의 모든 정보를 출력하세요
select *
from emp
where sal>=2000 OR job='MANAGER';


INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');
COMMIT;

select * from dept;

-- 삭제시 커밋까지 실행시켜줘야 댄다
delete from dept;
commit;

-- 오라클 날짜 (DB서버의 날짜)
-- 오라클 날짜 키워드 (sysdate)

select sysdate from dual; --21/03/02
-- 오라클이 설치되어있는 PC의 시간(서버시간)

--모든 시스템은 날짜가 필수로 구성되어있다.
--ex) 게시판 
--insert into board(writer, title, content, regdate)
--values('홍길동', '방가', '졸립다', sysdate)
--regdate 컬럼의 데이터 서버의 시간을 쓰겠다.
--Tip) ms-sql : select getdate()

--오라클 서버가 가지고 있는 날짜 환경 설정
select * from nls_session_parameters;
--    컬럼명            데이터
--NLS_DATE_FORMAT	 RR/MM/DD
--NLS_DATE_LANGUAGE  KOREAN
--NLS_TIME_FORMAT	 HH24:MI:SSXFF

--2021-03-02 형태로 바꾸고 싶다.
--##변경 정보는 현재 오라클에 접속한 사용자의 작업환경에서만 바뀌는 것이다.##
--so, 접속을 끊었다가 재연결하면 원래 상태로 복원된다.
--  (= 현재 session에만 반영된다)
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
--NLS_DATE_FORMAT	YYYY-MM-DD HH24:MI:SS

select sysdate from dual; --2021-03-02 14:10:10

select hiredate from emp; --1980-12-17 00:00:00

select *
from emp
where hiredate='1980-12-17'; --날짜 데이터도 문자로 취급한다.

select *
from emp
where hiredate='1980/12/17'; --이렇게도 사용 가능!!

-- 2019.12.17도 사용 가능... 하지만 되도록 사용하지 말자.

select *
from emp
where hiredate='80/12/17'; -- 현재 포맷과 일치하지 않으므로 사용 불가.


-- 사원의 급여가 2000이상이고, 4000이하인 모든 사원의 정보를 출력하세요
select *
from emp
where sal >= 2000 and sal <= 4000;

--연산자: 컬럼명 between A and B (=을 포함한다)
select *
from emp
where sal between 2000 and 4000;

-- 사원의 급여가 2000초과이고, 4000미만인 모든 사원의 정보를 출력하세요
-- 초과, 미만의 경우 between 사용 불가!
-- where sal > 2000 and sal < 4000;


--부서 번호가 10번 또는 20번 또는 30번인 사원의 사번, 이름, 급여, 부서번호를 출력하세요.
select empno, ename, sal, deptno
from emp;

--연산자 ( 'IN' -> 조건 or 조건 or .....)
select empno, ename, sal, deptno
from emp
where deptno in (10,20,30); -- where deptno=10 or deptno=20 or deptno=30; 과 같은 의미

--부서 번호가 10번 또는 20번이 아닌 사원의 사번, 이름, 급여, 부서번호를 출력하세요
select empno, ename, sal, deptno
from emp
where deptno!=10 and deptno!=20;

-- IN 부정 연산자: NOT IN -> 부정조건 and 부정조건 and...
select empno, ename, sal, deptno
from emp
where deptno not in (10, 20); -- where deptno!=10 and deptno!=20; 과 같다.

--POINT: Oracle에서 값이 없다(=데이터가 없다) >> null
--필요약 (null)

create table member(
  userid varchar2(20) not null, --null을 허용하지 않겠다 (필수 입력)
  name varchar2(20) not null, --필수입력
  hobby varchar2(50) --default null (기본적으로 null 허락) 선택입력
);

select * from member;
-- 회원가입 가정
insert into member(userid,hobby) values('hong','농구'); -- 에러(불가)
-- ORA-01400: cannot insert NULL into ("BITUSER"."MEMBER"."NAME")
insert into member(userid,name) values('hong','홍길동');
-- hobby컬럼의 데이터: null이 채워진다.


--POINT (Insert, Update, Delete)
--실제 반영을 위해서는 반드시 commit 명령을 수행 (rollback)

commit;

select * from member;

--데이터 삭제하기
delete from member;
commit;


--수당(comm)을 받지 않는 모든 사원의 정보를 출력하세요
-- 0도 데이터이다.(받는 것으로 인정)
select comm from emp;
-- 즉, comm컬럼의 데이터가 null인 것만 출력하시오

select *
from emp
where comm = null; -- 이런 문법은 없어요 ..

-- null비교는 (is null. is not null)로 해야한다. ##암기##
select * from emp
where comm is null;

-- 수당(comm)을 받는(null이 아닌) 모든 사원의 정보를 출력하세요
select * from emp
where comm is not null;

--사원테이블에서 사번, 이름, 급여, 수당, 총급여를 출력하세요
--총급여(급여+수당)
select empno, ename, sal, comm, sal+comm as "총급여"
from emp;

--POINT ##
--1. null 과의 모든 연산 결과는 :null ex) 100+null = null / 100-null = null
--2. 위 문제 해결: nvl(), nvl2()
--nvl(컬럼명, 대체값) >> 해당 컬럼명에서 null을 만나면 대체값으로 치환해서 연산해라.
--Tip) MS-SQL: null > convert()
--Tip) mysql: null < IFNULL()

select empno, ename, sal, comm, sal+nvl(comm,0) as "총급여"
from emp;
-- sal+nvl(comm,0) 
-->> comm 컬럼에서 null데이터를 만나면 0으로 치환해서 sal과 더해라.

select 1000 + null from dual; -- 불가
select 1000 + nvl(null,100) from dual;
select comm, nvl(comm,111111) from emp;

--사원의 급여가 1000이상이고, 수당을 받지 않는 사원의 사번, 이름, 직종, 급여, 수당을 출력하세요
select empno, ename, job, sal, comm
from emp
where sal>=1000 and comm is null;

--DQL(data query language): select 등
--DDL(정의어): creat, alter, drop (Table emp, dept) 객체라고 부른다.
--DML(조작어): insert, update, delete 
--  ㄴ-> 반드시 작업 후 실반영하고싶으면 commit, 작업을 취소하고싶으면 rollback 해줘야 한다.

--create table board (boardno number ...)
--JAVA: class board (private int boardno) 랑 같은것..

create table Board(
    boardid number not null, --숫자, 필수 입력
    title varchar2(50) not null, --글제목(한글 25자, 영문자 50자), 필수입력
    content varchar2(2000) not null, --글내용(한글1000자, 영문자2000자), 필수입력
    hp varchar2(20) --default null 필수 입력이 아니다 (null 사용)
);


select * from USER_TAB_COLUMNS where table_name='BOARD';
desc board;
/*
--dbeaver
SELECT * 
FROM ALL_ALL_TABLES  WHERE TABLE_NAME ='BOARD';

--dbeaver  사용자 컬럼 정보 보기
SELECT * 
FROM ALL_TAB_COLUMNS WHERE TABLE_NAME ='BOARD';
*/

--create, alter, drop >> commit, rollback(x)
--commit, rollback (insert, update, delete) 작업시만 실반영, 취소 결정

select * from board;

insert into board(boardid, title, content)
values (100, '오라클', '실수했네'); -- commit전 실제로 메모리에 작성되지 않은 것
-- 만약 데이터를 잘못 넣었다 -> rollback 하면 insert전으로 돌아간다.
rollback;

insert into board(boardid, title, content)
values (100, '오라클', '할만하네 ^^');
commit; -- 데이터 반영 (컴퓨터 껐다 켜도 남아있다)
--## commit한 데이터 rollback 불가 ##

/*
##Tip) MS-SQL: auto commit이 default
insert into emp(empno) values(100); -- 자동커밋

begin
    insert into emp(empno) values(100); -- 이 작업 할건데, 내 명령 기다려라
    
begin으로 시작 > 내가 commit, rollback 할때까지 기다려라

##TIP: Oracle은 개발자가 commit, rollback 명령어를 실행하기 전에는 실반영하지 않는다.
*/

select * from board;

insert into board(boardid, title, content)
values(200,'자바','그립다');

insert into board(boardid, title, content)
values(300,'자바','언젠가 보겠지');

select * from board;
-- rollback 시점: commit 한 뒤 (그 뒤로 1000건을 넣어도 롤백하면 전부 취소된다)
rollback;
/*
..... 작업
commit; 실반영
.....
.....
.....
rollback; 모두 취소 -> 커밋 이후로 전부 취소된다!
*/

select boardid, title, content, nvl(hp,'EMPTY') as "HP" 
                                -- ㄴ> hp컬럼에서 null값을 만나면 'EMPTY'로 바꿔서 출력하겠다.
from board; -- nvl : 숫자, 문자, 날짜 다 적용된다.

--문자열 검색
--주소검색: 검색어 입력시 '역삼'이라고 검색하면, 해당 단어가 포함된 모든 주소가 다 나온다.
--LIKE 패턴 검색
--문자열 패턴 검색(LIKE 연산자)

--like 연산자
--와일드카드 문자
--1. % (모든 것)
--2. _ (한문자)
--결합 패턴을 생성
--검색어가 한정적이다. >> 상세한 검색을 위해 정규표현식을 도입했다.
-- java에서의 정규표현식과 동일하다.

select *
from emp
where ename like '%A%'; -- ename 컬럼의 데이터가 A를 포함하면 다 출력해줘
--where ename like '%a%'; -- 불가 (패턴검색도 대소문자를 엄격하게 구분한다)
--where ename like 'A%'; -- 이름이 A로 시작하는 모든 사원 출력해줘
--where ename like '%E'; -- 이름이 E로 끝나는 모든 사원 출력해줘

--ex) 역삼이라는 단어가 들어있는 주소를 다 찾아라
--select *
--from zip
--where dong like '%역삼%'

select *
from emp
where ename like '%LL%'; --AllEN, MILLER

select *
from emp
where ename like '%A%A%'; --ADAMS (이름에 A가 두개 들어있으면 출력)

select *
from emp
where ename like '_A%'; --이름의 두번째가 A인 사람을 출력 
--WARD
--MARTIN
--JAMES

select *
from emp
where ename like '__A%'; --이름의 세번째가 A인 사람을 출력
--BLAKE
--CLARK
--ADAMS



--####오라클 과제 (regexp_like) 상세검색####
select * from emp where regexp_like(ename,'[A-C]');
--오라클 사용할 수 있는 정규 표현 검색 5개 만들기 (EMP)

-------------------------------------------------------[0303]---

--데이터 정렬하기
--order by 컬럼명 : 문자, 숫자, 날짜를 정렬할 수 있다.
--오름차순 : asc  (default)
--내림차순 : desc
--비용(cost)이 많이드는 작업이다 -> CUP와 memory를 많이 쓴다.

select *
from emp
order by sal; --default로 asc가 적용된다.

select *
from emp
order by sal asc; --위와 같은 구문

--급여를 많이 받는 순으로 정렬해라
select *
from emp
order by sal desc;

--입사일이 가장 늦은 순으로 정렬해서 사번, 이름, 급여, 입사일을 출력하세요
--(가장 최근에 입사한 순으로)
select empno, ename, sal, hiredate
from emp
order by hiredate desc;

select empno, ename
from emp
order by ename asc; --문자열 정렬 가능

/*
select 절    3
from 절      1
where 절     2
order by 절  4 -> select한 결과를 정렬한다.
*/

--해석
select empno, ename, sal, job, hiredate
from emp
where job='MANAGER'
order by hiredate desc;
--emp테이블에서, 직종이 매니저인 사원들을 검색하여 사번, 이름, 급여, 직종, 입사일을
--입사순으로 내림차순 정렬하여 출력하라.

-- order by 컬럼명 asc, 컬럼명 desc, 컬럼명 asc ... -> 정렬방법 여러가지 사용 가능
-- ##POINT## 답변형 게시판을 만들 때 필수로 사용된다.
select job, deptno
from emp
order by job asc, deptno desc;
--grouping 원리

--연산자
--합집합(union) : 테이블과 테이블의 데이터를 합치는 것 (중복값 배제)
--합집합(union all) : 중복값 허용

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
union -- 중복데이터 배제
select * from uta; --ut 집에 uta가 식구들 데리고 가는 것

select * from ut
union all
select * from uta;

--##union##
--1. 대응되는 컬럼의 타입이 동일해야 한다.
select empno, ename from emp --empno 숫자
union
select job, deptno from dept; --job 문자열
--ORA-00904: "JOB": invalid identifier
--데이터타입 오류 발생 (숫자방에 문자 못들어간당)
select empno, ename from emp --empno 숫자
union
select deptno, dname from dept;

--2. 대응되는 컬럼의 개수가 동일해야 한다.
--'필요악: null' 사용하자.
select empno, ename, job, sal from emp --4개
union
select deptno, dname, loc from dept; --3개
--1789: query block has incorrect number of result columns
select empno, ename, job, sal from emp --4개
union
select deptno, dname, loc, null from dept; -- null데이터 추가해서 4개
------------------------------------
--------------여기까지----------------
--초보 개발자가 의무적으로 해야하는 작업--
--(단일테이블에서 select하는 작업) --
------------------------------------

--Tip
--오라클 함수 ......
select * from SYS.NLS_DATABASE_PARAMETERS;
--NLS_CHARACTERSET  : 	AL32UTF8  한글 3byte 인식
--KO16KSC5601 2Byte (현재 변환하면 한글 다깨짐)
select * from nls_database_parameters where parameter like '%CHAR%';
------------------------------------------------------------------------------
create table test2(name varchar2(2));

insert into test2(name) values('a');
insert into test2(name) values('aa');
insert into test2(name) values('가'); --한글 1자 3byte 인지
--ORA-12899: value too large for column "BITUSER"."TEST2"."NAME" (actual: 3, maximum: 2)
--현재 세팅으로는 한글이 3byte로 인식되어있으므로 2바이트짜리 공간에는 들어갈 수 없다.
------------------------------------------------------------------------------

--[2차시]
--오라클이 가지고 있는 함수 사용법!
/*
## 단일 행 함수의 종류 ##
1) 문자형 함수 : 문자를 입력 받고 문자와 숫자 값 모두를 RETURN 할 수 있다.
2) 숫자형 함수 : 숫자를 입력 받고 숫자를 RETURN 한다.
3) 날짜형 함수 : 날짜형에 대해 수행하고 숫자를 RETURN 하는 MONTHS_BETWEEN 함수를
제외하고 모두 날짜 데이터형의 값을 RETURN 한다.
4) 변환형 함수 : 어떤 데이터형의 값을 다른 데이터형으로 변환한다.
5) 일반적인 함수 : NVL, DECODE
*/

--------------------------------문자열 함수-----------------------------------
select initcap('the super man') from dual;
-- initcap : 단어의 앞글자만 대문자로 바꿔주세용
select lower('AAA'), upper('aaa') from dual;
-- lower: 대문자를 소문자로 / upper: 소문자를 대문자로 바꿔주세용

select ename, lower(ename) as"ename" from emp;

select * from emp where lower(ename) = 'king';
--함수가 먼저 동작하므로, 이렇게 검색하면 KING 찾을 수 있다!

select length('abce') from dual; --문자열 개수
select length('홍길동') from dual; --결과: 3

select length('  홍 길 동 a') from dual; --결과: 9 (공백도 문자이므로 포함)

--#결합 연산자( || ) 
--concat()
--||가 더 확장성이 넓다(유연하다)
select 'a' || 'b' || 'c' as"data"
from dual; --결과: abc

select concat('a','b') from dual; --결과: ab
select concat('a','b','c') from dual;
--ORA-00909: invalid number of arguments
--파라미터를 3개이상 넣을 수 없다.

select ename || '     ' || job from emp; --가능
select concat(ename,job) from emp; --가능

--#부분 문자열 추출하기
--java: substring
--Oracle: substr
select substr('ABCDE',2,3) from dual;
--2번째부터 3개(자기자신부터 1개로)
--결과: BCD

select substr('ABCDE',1,1) from dual; --결과: A
select substr('ABCDE',3,1) from dual; --결과: C

select substr('ABCiqwojkasdawjw',3) from dual; --결과: Ciqwojkasdawjw
-- 세번째(C)부터 끝까지 출력

select substr('ABCDE',-2,1) from dual; --결과: D
-- 뒤부터 2번째(D)에서 문자 1개 출력
select substr('ABCDE',-2,2) from dual; --결과: DE

--사원테이블에서 ename 컬럼 데이터에 대해서 첫글자는 소문자로 나머지 글자는 대문자로 출력하되
--하나의 컬럼으로 만들어서 출력하세요
--컬럼의 별칭은: fullname
--첫글자와 나머지 문자 사이에는 공백 하나를 넣으세요
--SMITH >> s MITH 출력되도록 만들기
select lower(substr(ename,1,1)) || ' ' || substr(ename,2) as "fullname"
from emp;

--#lpad, rpad (채우기)
select lpad('ABC',10,'*') from dual; --결과: *******ABC
select rpad('ABC',10,'%') from dual; --결과: ABC%%%%%%%

--사용자의 비밀번호: hong1007
--화면에 ho****** 으로 출력하고싶다.
--사용자의 비밀번호: 1004 >> 10**
select rpad(substr('hong1007',1,2),length('hong1007'),'*') as "pwd"
from dual;
--결과: ho******
select rpad(substr('1004',1,2),length('1004'),'*') as "pwd"
from dual;
--결과: 10**

--DB에서 떼서 자바에 가져갈 수도 있고, 그냥 가져가서 자바에서 떼서 보여줄 수도 있다.
--여전히 논쟁중.. 현업가면 회사가 가지고 있는 규칙대로 처리하면 된다.

--emp테이블에서 ename 컬럼의 데이터를 출력하되 첫글자만 출력하고 나머지는 *로 출력하세요
select rpad(substr(ename,1,1),length(ename),'*') as "ename" from emp;

--#rtrim 함수: 오른쪽 문자를 지워라
--#ltrim: 왼쪽 문자를 지워라
select rtrim('MILLER', 'ER') from dual; --ER을 찾아서 지워라 (결과: MILL)
select ltrim('MILLLLLLLLLER', 'MIL') from dual; --결과: ER (모든 L을 지워버림 주의)

--공백지우기
select '>' || rtrim('MILLER       ', ' ') || '<' from dual;
--오른쪽에서 공백문자를 지워라
--결과: >MILLER<

--# 치환함수 (replace)
select ename, replace(ename, 'A', '와우') from emp;
-- 문자 A를 찾아서 와우로 바꿔라

-----주민번호-----
create table member2(
  id number ,
  jumin varchar2(14)
);

insert into member2(id, jumin) values(100,'123456-1234567');
insert into member2(id, jumin) values(200,'234567-1234567');
commit;

select * from member2;

--출력결과
--하나의 컬럼으로 출력 :
--100  : 123456-*******
--200 : 234567-*******
--컬럼의 가명칭 "juminnumber"

select id || ' : ' || rpad(substr(jumin,1,7),length(jumin),'*') as "jumin" from member2;

---------------------------------문자열함수-----------------------------------

--------------------------------숫자함수-------------------------------
--round(반올림 함수)
--trunc(절삭함수)
--#나머지 구하는 함수 mod()

-- -3, -2, -1, 0(정수), 1, 2, 3

--#round(반올림)
--정수부만 남겨라 (0)
select round(12.345,0) as "r" from dual; --결과: 12
select round(12.567,0) as "r" from dual; --결과: 13 (반올림)

--소수이하 첫번째 자리까지 남겨라 (1)
select round(12.345,1) as "r" from dual; --결과: 12.3
select round(12.567,1) as "r" from dual; --결과: 12.6 (반올림)

--10의자리까지 남겨라 (-1)
select round(12.345,-1) as "r" from dual; --결과: 10
select round(15.345,-1) as "r" from dual; --결과: 20 (반올림)

select round(12.345,-2) as "r" from dual; --결과: 0

--#trunc(반올림하지 않고 그냥 자르는 것)
select trunc(12.345,0) as "r" from dual; --결과: 12
select trunc(12.567,0) as "r" from dual; --결과: 12
select trunc(12.345,1) as "r" from dual; --결과: 12.3
select trunc(12.567,1) as "r" from dual; --결과: 12.5
select trunc(12.345,-1) as "r" from dual; --결과: 10
select trunc(15.345,-1) as "r" from dual; --결과: 10
select trunc(12.345,-2) as "r" from dual; --결과: 0

--#나머지
select 12/10 from dual; --결과: 1.2 (몫은 1이고, 나머지는 2)

select mod(12,10) from dual; --결과: 2(나머지)
--오라클은 0으로 나눌 수 있다. (자바는 0으로 나누면 오류난다)
select mod(0,0) from dual; --결과: 0


----------------------------------날짜함수---------------------------------

--alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
select sysdate from dual;

--##POINT##
--1. DATE + NUMBER >> DATE
--2. DATE - NUMBER >> DATE
--3. DATE - DATE >> NUMBER(일수) 주의

select sysdate + 100 from dual;
select sysdate + 1000 from dual;

select hiredate from emp;
--함수
select trunc(months_between('2018-02-27','2010-02-20'),0) from dual; --개월의 차는?
select months_between(sysdate, '2010-03-03') from dual; --결과: 132

select '2019-03-03' + 100 from dual; --에러 ORA-01722: invalid number
-- #POINT#
--to_date(): 문자를 날짜로 바꿔주는 함수 (변환함수)

select to_date('2019-03-03') + 100 from dual; --결과: 2019-06-11 00:00:00


--1. 사원 테이블에서 사원들의 입사일에서 현재날짜까지 근속월수를 구하세요  
-- ( 사원이름 , 입사일 , 근속월수 )
--단 근속월수는 정수부분만 출력하세요 (반올림 하지 마세요)
select ename, hiredate, trunc(months_between(sysdate,hiredate),0) as "근속월수" 
from emp;

--2. 한달이 31 일 이라는 기준에서 근속월수를 구하세요 (반올림 하지 마세요) 
--(함수 사용(x) >> 날짜 - 날짜 >> 150일 )요)
select ename, hiredate, trunc((sysdate-hiredate)/31,0) as "근속월수" 
from emp;


-----------------------------------------------
--(변환함수) Today ##POINT##
--Oracle 데이터: 문자열, 숫자, 날짜
--to_char(): 숫자 -> 문자 (1000 -> $100,000) : 숫자를 문자로 변환
--         : 날짜 -> 문자 ('2021-03-03' -> 2021년03월03일) : 날짜를 문자로 변환

--to_date(): 문자 -> 날짜
select to_date('2021-03-03') + 100 from dual;

--to_number(): 문자 -> 숫자 >> but, 자동 형변환이 있기 때문에 자주 사용되지 않는다.
select '100' + 100 from dual; -- 숫자형 문자라서 형변환이 일어나서 계산된다.
select to_number('100') + 100 from dual; -- 정식표현

-----------------------------------------------
/*
create table 테이블명 (컬럼명 타입, 컬럼명 타입)
1. create table member (age number); insert ... 1건~ 천건 가능
2. insert into member(age) values(100);
3. insert into member(age) values(200); ... x100번

java에서 클래스를 생성하는 것과 같음
1. class member {private int age;} -- 오라클에서의 insert 1건 = 자바의 객체 1개
member m = new member();
2. m.setAge(100);
3. List<member> mlist = new ArrayList<member>();
   m.list.add(new member(100));
   m.list.add(new member(200));
   m.list.add(new member(300));
   m.list.add(new member(400)); ... x 100번
   
@ 데이터타입
문자열
CHAR(10)       >> 10Byte >> 한글 5자 / 영문자, 특수문자, 공백 10자
VARCHAR2 (10)  >> 10Byte >> 한글 5자 / 영문자, 특수문자, 공백 10자

CHAR는 고정길이 문자열, VARCHAR2는 가변길이 문자열

CHAR(10) >> 'abc' >> 3byte >> [a][b][c][][][][][][][] >> 공간의 변화가 없다. (10byte)
VARCHAR(10) >> 'abc' >> 3byte >> [a][b][c]... >> 데이터크기만큼만 공간확보

-- 한글 1자가 3byte이고, (남,여) 둘 중 하나의 데이터만 들어간다는 가정
create table member(gender char(3)); -- 성능상 char가 우선된다.
create table member(gender varchar2(3));

-- 사람의 이름 데이터가 들어간다고 가정
create table member(name char(30)); 
create table member(name varchar2(30)); -- 얘를 쓰는게 더 효율적

@ 약속 : 고정길이 데이터(남/여, 대/중/소, 주민번호 등 정해진 데이터)의 경우 char 이용.
        가변길이 데이터 (사람이름, 주소, 취미 등 길이가 정해지지 않은 데이터)의 경우 varchar2 이용.
        
char() varchar2() 단점: 한글, 영문자(,특수문자,공백) 혼합
varchar2(10)

unicode: 한글, 영문자, 특수문자, 공백 모두 2byte로 보자.

##nchar(20) >> 20글자 >> 2*20 >> 40byte
##nvarchar2(20) >> 20글자

한글문화권은 n 이 붙어있는 유니코드 문자를 좋아한다.
*/
create table test3(name nchar(2), ename nvarchar2(2));

insert into test3(name) values('a');
insert into test3(name) values('가');

insert into test3(name) values('ab');
insert into test3(name) values('가나');

insert into test3(name) values('abc');
--ORA-12899: value too large for column "BITUSER"."TEST3"."NAME" (actual: 3, maximum: 2)
insert into test3(ename) values('가나다');
--ORA-12899: value too large for column "BITUSER"."TEST3"."ENAME" (actual: 3, maximum: 2)

commit;

--1. to_number(): 문자 -> 숫자 >> but, 자동 형변환이 있기 때문에 자주 사용되지 않는다.
select '1' + 1 from dual; -- 숫자형 문자라서 형변환이 일어나서 계산된다.
select to_number('1') + 1 from dual; -- 원칙

--2. to_char() : 숫자 -> 형식문자
--               날짜 -> 형식문자
select sysdate , to_char(sysdate,'YYYY') || '년' as "YYYY",
                 to_char(sysdate,'YEAR'),
                 to_char(sysdate,'MM'),
                 to_char(sysdate,'DD'),
                 to_char(sysdate,'DAY'),
                 to_char(sysdate,'DY')
from dual;

--입사일이 12월인 사원의 사번, 이름, 입사일, 입사년도, 입사월을 출력하세요
--hiredate에 함수 적용

select empno, ename, hiredate, to_char(hiredate,'YYYY') as "입사년도", to_char(hiredate,'MM') as "입사월"
from emp
where to_char(hiredate,'MM')='12';

select to_char(hiredate, 'YYYY MM DD') from emp;
select to_char(hiredate, 'YYYY년MM월DD일') from emp; --에러
select to_char(hiredate, 'YYYY"년" MM"월" DD"일"') from emp; --가능

--숫자형식모델
--###오라클.pdf (71p 표 참조)

--10000000 -> $10,000,000
select '>' || to_char(12345,'999999999') || '<' from dual; --결과: >     12345<
select '>' || to_char(12345,'0999999999') || '<' from dual; --결과: > 0000012345<
select '>' || to_char(12345,'$9,999,999,999') || '<' from dual; --결과: >        $12,345<

select sal, to_char(sal,'$999,999') from emp;
-- 결과로 나온 데이터는 [문자]데이터이다.

--HR 계정으로 잠깐 작업하고오자~!~!

select * from employees;
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
select sysdate from dual;

/*
사원테이블(employees)에서 사원의 이름은 last_name , first_name 합쳐서 fullname 별칭 부여해서 출력하고
입사일은  YYYY-MM-DD 형식으로 출력하고 연봉(급여 *12)을 구하고 연봉의 10%(연봉 * 1.1)인상한 값을
출력하고 그 결과는 1000단위 콤마 처리해서 출력하세요
단 2005년 이후 입사자들만 출력하세요 그리고 연봉이 높은 순으로  출력하세요
*/
select last_name || first_name as "fullname", 
       to_char(hire_date, 'YYYY-MM-DD') as "입사일",
       salary,
       salary*12 as "연봉",
       to_char((salary*12)*1.1,'$9,999,999') as "연봉인상"
from employees
where to_char(hire_date,'YYYY') >= '2005'
order by "연봉" desc;
--order by (salary*12) desc; / 가능
--order by 절에 select가 가지고 있는 별칭을 사용할 수 있다. (실행순서상 가능)

----------------------------------------------------------
----------------------------------------------------------

--일반함수(프로그램 성격이 강한 함수)
--nvl() ,nvl2() >> null 처리하는 함수
--decode() >> java의 if문 처럼 사용할 수 있는 함수
--case() >> java의 switch문 처럼 사용할 수 있는 함수

--오라클 SQL (변수, 제어문 개념이 없다)
--오라클 PL-SQL (변수, 제어문 사용 가능) ... 고급 ... -> SPRING할 때 합니다

--계정 다시 BITUSER로 바꿉니다
select comm, nvl(comm,0) from emp;

create table t_emp(
    id number(6), --뒤에 6을 적으면 [정수 6자리]
    job nvarchar2(20)
);

insert into t_emp(id,job) values(100,'IT');
insert into t_emp(id,job) values(200,'SALES');
insert into t_emp(id,job) values(300,'MGR'); --매니저
insert into t_emp(id) values(400);
insert into t_emp(id,job) values(500,'MGR');
COMMIT;

select * from t_emp;

select id, decode(id, 100, '아이티', 
                      200, '영업부', 
                      300, '관리팀', 
                      '기타부서') as "부서이름"
from t_emp;
--id값이 100이면 '아이티'를 ...~~~
--하나의 컬럼을 만드는 것

select empno, ename, deptno, decode(deptno, 10, '인사부',
                                            20, '관리부',
                                            30, '회계부',
                                            40, '부서',
                                            'ETC') as "부서이름"
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
t_emp2 테이블에서 id, jumin 데이터를 출력하되 jumin 컬럼의 앞자리가 1이면
'남성' 출력 2이면 '여성' 3이면 '중성' 그외는  '기타' 라고 출력하세요
컬럼명은 '성별'
*/
select id, jumin, decode(substr(jumin,1,1), 1, '남성',
                                            2, '여성',
                                            3, '중성',
                                            '기타') as "성별"
from t_emp2;


/*
if문 안에 if문 중첩

아래코드 decode() 함수 작업하기
부서번호가 20번인 사원중에서 SMITH라는 이름을 가진 사원이라면 HELLO 문자 출력
부서번호가 20번인 사원중에서 SMITH라는 이름을 가진 사원이 아니라면 WORLD 문자 출력
부서번호가 20번인 사원이 아니라면 ETC라는 문자 출력
*/

select ename, deptno, decode(deptno, 20, decode(ename, 'SMITH', 'HELLO',
                                        'WORLD'),
                     'ETC')
from emp;

--CASE문
-- = java의 스위치문
/*
1.
CASE 조건식 WHEN 결과1 THEN 출력1
           WHEN 결과2 THEN 출력2
           WHEN 결과3 THEN 출력3
           ELSE 출력4
END "컬럼명"

2.
CASE WHEN 컬럼명 조건 비교식 THEN
     WHEN 컬럼명 조건 비교식 THEN
     WHEN 컬럼명 조건 비교식 THEN
     ELSE
END "컬럼명"
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

select '0' || to_char(zipcode), CASE zipcode WHEN 2 THEN '서울'
                                             WHEN 31 THEN '경기'
                                             WHEN 32 THEN '강원'
                                             WHEN 41 THEN '제주'
                                             ELSE '기타지역'
                                END "지역이름"
FROM t_zip;


select case when sal <= 1000 then '4급'
            when sal between 1001 and 2000 then '3급'
            when sal between 2001 and 3000 then '2급'
            when sal between 3004 and 4000 then '1급'
            else '특급'
       end "등급"
from emp;

---------------------------------------------------------------------
--문자함수
--날짜함수
--숫자함수
--변환함수(to_char(), to_number(), to_date())
--일반함수(NVL, DECODE(), CASE 구문
--@@기본함수 END@@--
---------------------------------------------------------------------
---------------------------------------------------------------------
--집계(그룹)함수
--오라클.pdf 75p 참고

/*
1.count(*) >> row 수
  count(컬럼명) >> 데이터의 건수 (null은 포함하지 않는다)
2.sum()
3.avg()
4.max()
5.min()

1. 집계함수는 GROUP BY 절과 같이 사용한다.
2. 모든 집계함수는 NULL값을 무시한다
3. SELECT 절에 집계함수 이외의 다른 컬럼이 오면 그 컬럼은 반드시 GROUP BY절에 명시되어야 한다.
*/

SELECT COUNT(*) FROM emp; --결과: 14 / 총 14건 있습니다.(데이터 건수가 아니고, ROW의 수)

SELECT COUNT(empno) FROM emp; --결과: 14
SELECT COUNT(comm) FROM emp; --결과: 6 (comm컬럼에 있는 null 제외 건수)

-- 만약, comm 컬럼의 데이터도 14건으로 세고싶다면?
SELECT COUNT(NVL(comm,0)) FROM emp; --결과: 14


--급여의 합
SELECT SUM(sal) AS "급여의 합" FROM emp; --결과: 29025
--급여의 평균
SELECT AVG(sal) AS "급여 평균" FROM emp; --결과: 2073.214285714285714285714285714285714286
SELECT ROUND(AVG(sal),0) AS "급여 평균" FROM emp; --결과: 2073

--사장님 say: 우리회사 총 수당이 얼마나 지급되었나?
SELECT SUM(comm) FROM emp; --결과: 4330
-- 수당 평균은 얼만가?
SELECT AVG(comm) FROM emp;
SELECT TRUNC(AVG(comm), 0) FROM emp; --결과: 721
-- 수당 평균을 계산할 때 null을 무시하고 있다.
-- NULL값을 무시하고 있기 때문에 받는 사람 기준을 계산한 것이다.
-- null 제외, (300+200+30+300+3500+0 / 6) 을 했다 so, 721

-- 전체 사원 기준 평균
SELECT TRUNC((SUM(comm)/14),0) FROM emp; --결과: 309
SELECT TRUNC(AVG(NVL(comm,0))) FROM EMP; --바로 위줄과 같은 결과가 나오는 식

-- 721, 309 둘 다 맞는 값으로 볼 수 있다
-- 회사의 규정에 따라 다를 뿐이얌
-- 회사의 규정이 전체 사원 기준이면 309가 맞고, 받는 사람 기준이면 721이 맞다.

select max(sal) from emp;
select min(sal) from emp;

select empno, count(empno) from emp; --ORA-00937: not a single-group group function
-- 그룹으로 묶어주지 않으면 개수가 다르기 때문에 에러가 난다.

select sum(sal), avg(sal), max(sal), min(sal), count(sal)
from emp;

---부서별 평균 급여를 구하세요---
select deptno, avg(sal)
from emp
group by deptno;

--직종별 평균 급여를 구하세요
select job, avg(sal)
from emp
group by job;

--직종별 평균 급여, 급여의 합, 최대 급여, 최소 급여, 건수를 출력하세요.
-- ### 왜 select * 는 에러나징
select job, avg(sal), sum(sal), max(sal), min(sal), count(sal)
from emp
group by job;

/*
grouping의 원리가 적용되는 것
1. distinct 컬럼명1, 컬럼명2...
2. order by 컬럼명1, 컬럼명2...
3. group by 컬럼명1, 컬럼명2...
*/

--부서별, 직종별 급여의 합을 구하세요
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

--직종별 평균급여가 3000달러 이상인 사원의 직종과 평균 급여를 출력하세요
SELECT job, AVG(sal)
FROM emp
WHERE AVG(sal) >= 3000 -- 순서상 에러 (where절이 순서가 더 늦어서 집계가 아직 되지 않았으므로 실행 불가)
GROUP BY job;

/*
1. from절의 조건절: where
2. group by절의 조건절: having
*/

SELECT job, AVG(sal)
FROM emp
GROUP BY job
HAVING AVG(sal) >= 3000;
--having절에서는 select절의 가명칭을 사용하지 못한다 (실행순서상)
/*
SELECT    5
FROM      1
WHERE     2
GROUP BY  3
HAVING    4
ORDER BY  6
*/

/* 사원테이블에서 직종별 급여합을 출력하되 수당은 지급 받고 급여의 합이 5000 이상인 사원들의 목록을 출력하세요
--급여의 합이 낮은 순으로 출력하세요 */
SELECT job, sum(sal) as "sumsal"
FROM emp
WHERE comm IS NOT NULL
GROUP BY job
HAVING (SUM(sal) >= 5000)
ORDER BY sum(sal);
--ORDER BY "sumsal"; 로도 쓸 수 있다.

/* 사원테이블에서 부서 인원이 4명보다 많은 부서의 부서번호 ,인원수 , 급여의 합을 출력하세요 */
SELECT deptno, count(empno), sum(sal) as "부서별 급여의 합"
FROM emp
GROUP BY deptno
HAVING count(empno) > 4;
-- 답: HAVING COUNT(*) > 4;

SELECT COUNT(*) FROM emp WHERE job IS NULL; -- null 여부 확인하기

/* 사원테이블에서 직종별 급여의 합이 5000를 초과하는 직종과 급여의 합을 출력하세요
단 판매직종(salesman) 은 제외하고 급여합으로 내림차순 정렬하세요 */

SELECT job, sum(sal) as "sumsal"
FROM emp
WHERE job != 'SALESMAN'
GROUP BY job
HAVING sum(sal) > 5000 
ORDER BY sum(sal) DESC;

---### WHERE절에서 거를 수 있는 애는 걸러서 가져가자 (성능) ###
--------------------------------------------------
-----여기까지가 단일 테이블에서 데이터를 가져오는 것 끝!---
--------------------------------------------------
-- 예습: JOIN (한개 이상의 테이블에서 데이터를 가져오는 방법)
-- 오라클.pdf (6장) 85page

-----------------------------0304------------------------------

--다중테이블에서 데이터 가져오기
--RDBMS(Relational DataBase Management System) : 한개 이상의 테이블들이 서로 관계를 가지고있는 구조
--JOIN : 데이터를 가져오는 방법!
-- <관계>
--  1:1 (1대1)
--  1:N (1대다)
--  M:N (다대다)


--조인 실습 테이블 구성하기--
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

----------------------만약에 데이터 잘못 넣었당
--delete from m;
--commit;
--다시 insert
------------------------------------------

--<<종류>>
--1. 등가조인(equi join) (70%가 등가조인이다)
--   : 원 테이블과 대응되는 테이블에 있는 컬럼의 데이터를 1:1로 매핑
--<문법>
--1) SQL JOIN 문법(오라클 문법) >> 간단하게 (거의 사용하지 x)
select *
from m , s
where m.m1 = s.s1;

select m.m1 , m.m2 , s.s2
from m , s
where m.m1 = s.s1;

--2) ANSI 문법(표준) -> 권장: 무조건 이렇게 쓰세용 >> [inner] join on 조건절
select *
from m inner join s
on m.m1 = s.s1;

select m.m1, m.m2, s.s2
from m join s -- inner 일반적으로 생략
on m.m1 = s.s1;

--M, X 조인하기 (M.m1 = X.x1)
select m.m1, m.m2, x.x2
from m join x
on m.m1 = x.x1;

--emp, dept
--사원번호, 사원이름, 부서번호, 부서이름을 출력하세요.
select emp.empno, emp.ename, emp.deptno, dept.dname
from emp join dept
on emp.deptno = dept.deptno;

--현업: 테이블명이 길다
--join시 테이블의 이름을 줄여서 사용한다 (별칭 붙이기)
select e.empno, e.ename, e.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno;

--join
--테이블이 2개일수도, 3개일수도 ... ~~
--1) SQL JOIN (거의 사용하지 x)
select *
from m, s, x
where m.m1 = s.s1 and s.s1 = x.x1;

--2) ANSI JOIN
select m.m1, m.m2, s.s2, x.x2
from m join s on m.m1 = s.s1
       join x on s.s1 = x.x1;

/*
> a(a1), b(b1), c(c1), d(d1) 4개의 테이블 조인
from a join b on a.a1 = b.b1
       join c on b.b1 = c.c1
       join d on c.c1 = d.d1
*/

--HR 계정으로 이동
select * from employees;
select * from departments;
select * from locations;

--사번, 이름(last_name), 부서번호, 부서이름 출력
select e.employee_id, e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;
--문제점
--실제 사원수 107 , 데이터는 106건 출력 -> 부서번호가 null인 경우 누락된 것
--select * from employees where employee_ID=178;
--#등가조인은 null 처리불가 >> null값을 가진 데이터는 누락된다#

--사번, 이름(last_name), 부서번호, 부서이름, 지역코드, 도시명 출력
select e.employee_id, 
       e.last_name, 
       e.department_id, 
       d.department_name, 
       d.location_id, 
       l.city
from employees e join departments d on e.department_id = d.department_id
                 join locations l on d.location_id = l.location_id;
                 
-----------------
--bituser 계정으로
--<<종류>>
--2. 비등가조인(non-equi join)
--   : 1:1로 비교할 컬럼이 없다.
--   : 의미만 존재한다 (자기 문법이 없다) -> 등가join 문법을 사용한다.
--join: 컬럼과 컬럼이 1:1로 매핑될 때 가능한 것 (emp.deptno = dept.deptno)
select * from emp;
select * from salgrade;

--비등가조인
select e.empno, e.ename, e.sal, s.grade
from emp e join salgrade s
on e.sal between s.losal and s.hisal;

--3. outer join (equi join + null(나머지))
--      : equi join을 선행하고 그 다음 의사결정 (남은 데이터를 가져올 것인가)
--      : join테이블의 주종 관계를 파악하는 것이 중요하다.
--      : 주인이 되는 테이블의 남은 데이터를 가져올 수 있다.
--<문법>
--1) left (outer) join (왼쪽 테이블이 주인)
--2) right (outer) join (오른쪽 테이블이 주인)
--3) full (outer) join (left + right: union)
select *
from m left join s
on m.m1 = s.s1;

select *
from m right join s
on m.m1 = s.s1;

select *
from m full outer join s --outer 생략 가능
on m.m1 = s.s1;

---------------------------------
--HR계정
--사번, 이름(last_name), 부서번호, 부서이름 출력
--107명이 나오도록
select e.employee_id, e.last_name, e.department_id, d.department_name
from employees e left join departments d
on e.department_id = d.department_id;
---------------------------------
--bituser

--4. self join (자기참조)
--      : 문법이 존재하지 않는다. (의미만 존재) -> equi join 문법으로 사용
--      : 테이블의 컬럼이 자신의 테이블에 있는 다른 컬럼을 참조하는 경우 

--join 기본 테이블 2개
--emp 테이블 1개를 가명칭 붙여서 (복제개념?)사용

select e.empno, e.ename, m.empno, m.ename
from emp e join emp m
on e.mgr = m.empno;
-- 데이터 13건 출력 -> outer join 추가해서 해결

select e.empno, e.ename, m.empno, m.ename
from emp e left join emp m
on e.mgr = m.empno;

------------------------------------
select * from emp;
select * from dept;
select * from salgrade;
-- 1. 사원들의 이름, 부서번호, 부서이름을 출력하라.
select e.ename, e.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno;

-- 2. DALLAS에서 근무하는 사원의 이름, 직위, 부서번호, 부서이름을 출력하라.
select e.ename, e.job, e.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno
where d.loc = 'DALLAS';

-- 3. 이름에 'A'가 들어가는 사원들의 이름과 부서이름을 출력하라.
select e.ename, d.dname
from emp e join dept d
on e.deptno = d.deptno
where e.ename like '%A%'; --WHERE Regexp_like(E.ENAME,'^A'); 

-- 4. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을 출력하는데 월급이 3000이상인 사원을 출력하라.
select e.ename, d.dname, e.sal
from emp e join dept d
on e.deptno = d.deptno
where e.sal >= 3000;

-- 5. 직위(직종)가 'SALESMAN'인 사원들의 직위와 그 사원이름, 그리고 그 사원이 속한 부서 이름을 출력하라.
select e.job, e.ename, d.dname
from emp e join dept d
on e.deptno = d.deptno
where e.job = 'SALESMAN';
?
-- 6. 커미션이 책정된 사원들의 사원번호, 이름, 연봉, 연봉+커미션, 급여등급을 출력하되, 
--      각각의 컬럼명을 '사원번호', '사원이름', '연봉','실급여', '급여등급'으로 하여 출력하라.
select e.empno as "사원번호", 
       e.ename as "사원이름", 
       e.sal as "연봉",
       e.sal + nvl(e.comm,0) as "실급여",
       s.grade as "급여등급"
from emp e join salgrade s on e.sal between s.losal and s.hisal
where e.comm is not null;

-- 7. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름, 월급, 급여등급을 출력하라.
select d.deptno, d.dname, e.ename, e.sal, s.grade
from emp e join dept d on e.deptno = d.deptno
           join salgrade s on e.sal between s.losal and s.hisal
where e.deptno=10;

-- 8. 부서번호가 10번, 20번인 사원들의 부서번호, 부서이름, 사원이름, 월급, 급여등급을 출력하라. 
-- 그리고 그 출력된 결과물을 부서번호가 낮은 순으로, 월급이 높은 순으로 정렬하라.
select d.deptno, d.dname, e.ename, e.sal, s.grade
from emp e join dept d on e.deptno = d.deptno
           join salgrade s on e.sal between s.losal and s.hisal
where e.deptno=10 or e.deptno=20 -- WHERE E.DEPTNO IN (10,20)
order by e.deptno asc, e.sal desc;

-- 9. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의 사원번호와 사원이름을 출력하되 
-- 각각의 컬럼명을 '사원번호', '사원이름', '관리자번호', '관리자이름'으로 하여 출력하라.
select e.empno as "사원번호", 
       e.ename as "사원이름", 
       m.empno as "관리자번호",
       m.ename as "관리자이름"
from emp e left join emp m
on e.mgr = m.empno;

--------------------------------------------------------------
--------------------------------------------------------------

--Subquery
--오라클.pdf (제7장) 100p
--SQL의 꽃! SQL의 만능 해결사!
--1. 함수가 다중 테이블이다? >> JOIN >> 조인으로 해결이 안된다? SubQurey사용!

--사원테이블에서 사원들의 평균 급여보다 더 많은 급여를 받는 사원의 사번, 이름, 급여 를 출력하라.
select avg(sal) from emp; --2073
select empno, ename, sal
from emp
where sal > 2073; -- 평균 급여를 알고있어야 풀 수 있다 .....
-- 하나의 문제를 해결하기 위해서 쿼리가 2개 사용되었다. 
-- 1개의 쿼리 문장으로 결합해보자
select empno, ename, sal
from emp
where sal > (select avg(sal) from emp); -- 쿼리문 안에 쿼리문이 들어간다!.!
--             ㄴ> 서브쿼리가 먼저 실핻된다.

--<<Subquery>>
--<종류>
--why? 결과가 싱글이나, 멀티냐에 따라 사용되는 연산자가 다르다.
--1. single row subquery : subquery의 실행 결과가 단일 row(한줄)의 단일 column (=한개의 데이터 = 단일값)
--   기존 연산자 ( =, >, <, >=, <=) 사용
--2. multi row subquery  : subquery의 실행 결과가 한개 이상의 row로 구성 (=여러개의 값), 단일 column
--   IN , NOT IN, ANY, ALL 연산자 사용
--   ALL: sal > 1000 and sal > 4000 and ...
--   ANY: sal > 1000 or sal > 4000 or...

--<문법>
--1. 괄호안에 있어야 한다. >> ex. {select max(sal) from emp) 
--2. 단일 컬럼으로 구성되어야 한다. >> ex. select empno, sal from emp (불가)
--3. 단독으로 실행 가능해야 한다.

--<실행순서>
--1. subquery 먼저 실행
--2. subquery 결과를 가지고 query 실행

--Tip)
--SELECT (subquery) > 한개의 행만 반환할 경우 ( Scala sub query )
--FROM (subquery)   > Inline view(가상테이블 개념)
--WHERE (subquery)  > 조건으로 사용

-- 사원테이블에서 jones의 급여보다 더 많은 급여를 받는 사원의 사번, 이름, 급여를 출력하세요
SELECT empno, ename, sal
FROM emp
WHERE sal > (SELECT sal FROM emp WHERE ename='JONES');

SELECT *
FROM emp
WHERE sal = (SELECT sal FROM emp WHERE deptno=30);
--ORA-01427: single-row subquery returns more than one row
--suquery의 결과가 multi row라서 에러!

SELECT *
FROM emp
WHERE sal IN (SELECT sal FROM emp WHERE deptno=30);
-- sal = 1600 or sal = 1250 or ....

SELECT *
FROM emp
WHERE sal NOT IN (SELECT sal FROM emp WHERE deptno=30);
-- sal != 1600 and sal !=1250 and .... 
--NOT IN = 부정의 AND

--부하직원이 있는 사원의 사번과 이름을 출력하세요
--(내 사번이 MGR컬럼에 있다)
SELECT empno, ename
FROM emp
WHERE empno IN (SELECT mgr FROM emp);
--empno = 7902 or empno = 7698 ... or empno = null;
--or 연산에서는 null이 영향을 주지 않는다.

--부하직원이 없는 사원의 사번과 이름을 출력하세요.
SELECT empno, ename
FROM emp
WHERE empno NOT IN (SELECT mgr FROM emp);
--NOT IN이 NULL도 인식한당 ,,,
--empno != 7902 and empno != 7698 ... and
--and연산에 null이 들어있으면 그 결과는 null이 된다.
SELECT empno, ename
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr,0) FROM emp);

--king에게 보고하는(직속상관이 king인) 사원의 사번, 이름, 직종, 관리자 사번을 출력하세요
SELECT empno, ename, job, mgr
FROM emp
WHERE mgr = (SELECT empno FROM emp WHERE ename='KING');

--20번 부서의 사원 중에서 가장 많은 급여를 받는 사원보다 더 많은 급여를 받는 사원의 
--사번, 이름, 급여, 부서번호를 출력하세요.
SELECT empno, ename, sal, deptno
FROM emp
WHERE SAL > (SELECT MAX(sal) FROM emp WHERE deptno = 20);


--자기 부서의 평균 월급보다 더 많은 월급을 받는 사원의 사번, 이름, 부서번호, 부서별 평균 월급을 출력하세요
--hint : 부서 번호와 부서의 평균 월급을 담고 있는 테이블이 존재한다면.. (물리적인 테이블x)
-- ㄴ> FROM에 서브쿼리 사용
select e.empno, e.ename, e.deptno, e.sal, s.avgsal
from emp e 
    join (select deptno, round(avg(sal),0) as avgsal from emp group by deptno) s
    on e.deptno = s.deptno
where e.sal > s.avgsal;

--1. 'SMITH'보다 월급을 많이 받는 사원들의 이름과 월급을 출력하라.
SELECT ename, sal
FROM emp
WHERE sal > (SELECT sal FROM emp WHERE ename='SMITH');

--2. 10번 부서의 사원들과 같은 월급을 받는 사원들의 이름, 월급, 부서번호를 출력하라.
SELECT ename, sal, deptno
FROM emp
WHERE sal IN (SELECT sal FROM emp WHERE deptno = 10);

--3. 'BLAKE'와 같은 부서에 있는 사원들의 이름과 고용일을 뽑는데 'BLAKE'는 빼고 출력하라.
SELECT ename, hiredate
FROM emp
WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'BLAKE') AND
      ename != 'BLAKE';

--4. 평균급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 월급을 출력하되, 
--   월급이 높은 사람 순으로 출력하라.
SELECT empno, ename, sal
FROM emp
WHERE sal > (SELECT avg(sal) from emp)
ORDER BY sal DESC;

--5. 이름에 'T'를 포함하고 있는 사원들과 같은 부서에서 근무하고있는 사원의 사원번호와 이름을 출력하라.
SELECT empno, ename
FROM emp
WHERE deptno IN (SELECT deptno FROM emp WHERE ename LIKE '%T%');

--6. 30번 부서에 있는 사원들 중에서 가장 많은 월급을 받는 사원보다 많은 월급을 받는 사원들의 
--   이름, 부서번호, 월급을 출력하라. (단, ALL(and) 또는 ANY(or) 연산자를 사용할 것)
SELECT ename, deptno, sal
FROM emp
WHERE sal > ANY(SELECT max(sal) FROM emp WHERE deptno = 30);

--##--
SELECT ENAME , DEPTNO, SAL
FROM EMP
WHERE SAL > ALL(SELECT SAL FROM EMP WHERE DEPTNO=30);

--7. 'DALLAS'에서 근무하고 있는 사원과 같은 부서에서 일하는 사원의 이름, 부서번호, 직업을 출력하라.
SELECT ename, deptno, job
FROM emp  -- e JOIN dept d ON e.deptno = d.deptno
WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'DALLAS');

--8. SALES 부서에서 일하는 사원들의 부서번호, 이름, 직업을 출력하라.
SELECT deptno, ename, job
FROM emp
WHERE deptno IN(SELECT deptno FROM dept WHERE dname = 'SALES');

--9. 'KING'에게 보고하는 모든 사원의 이름과 급여를 출력하라 
--    king 이 사수인 사람 = mgr 데이터가 king 사번
SELECT ename, sal
FROM emp
WHERE mgr = (SELECT empno FROM emp WHERE ename='KING');


--##10. 자신의 급여가 평균 급여보다 많고, 이름에 'S'가 들어가는 사원과 동일한 부서에서 근무하는 
--    모든 사원의 사원번호, 이름, 급여를 출력하라.
SELECT empno, ename, sal
FROM emp
WHERE sal > (select avg(sal) from emp) AND
      deptno IN (SELECT deptno FROM emp WHERE ename LIKE '%S%');

--11. 커미션을 받는 사원과 부서번호, 월급이 같은 사원의 이름, 월급, 부서번호를 출력하라.
SELECT ename, sal, deptno
FROM emp
WHERE deptno IN (SELECT deptno FROM emp WHERE COMM IS NOT NULL) AND
      sal IN (SELECT sal FROM emp WHERE COMM IS NOT NULL);

--12. 30번 부서 사원들과 월급과 커미션이 같지 않은 사원들의 이름, 월급, 커미션을 출력하라.
SELECT ename, sal, comm
FROM emp
WHERE sal NOT IN(SELECT NVL(sal,0) FROM emp WHERE deptno=30) AND
      comm NOT IN(SELECT NVL(comm,0) FROM emp WHERE deptno=30);

------------------------------------
------------------------------
--데이터 조작(DML)
--오라클.pdf 10장 168page
--반드시 암기 (INSERT, UPDATE, DELETE)

/*
오라클 기준
DDL(데이터 정의어): create, alter, drop, truncatel, rename, modify
DML(데이터 조작어): insert, update, delete
DQL(데이터 질의어): select
DDL(데이터 제어어): (관리자 권한) grant, revoke
TCL(트랜잭션)    : commit, rollback, savepoint

DML작업 (insert, update, delete)
- ex)
- A 계좌에서 B라는 계좌로 100만원 이체
=======여기부터=======
- A계좌(잔고1000만원)에서 출금: update 계좌 set 금액 (-)
--> 900만원
- B계좌(잔고1000만원)에 입금: update 계좌 set 금액 (+)
--> 1100만원
=======여기까지=======
- 'A계좌에서 출금 - B계좌에 입금' 을 하나의 논리적인 단위로 묶어버리자
- 즉, 둘다 성공 또는 둘다 실패
- 이것을 '트랜잭션'이라고 한다.
- ##트랜잭션: 하나의 논리적인 단위##
- 트랜잭션을 처리하는 방법이 '커밋'과 '롤백'이다.
*/

--기본정보 확인: desc emp
--상세한 정보를 보고싶을 때는?
select * from tab; --현재 접속 계정이 가지고 있는 table의 목록)
--create table 할 때 기존에 이미 있는 table명은 사용할 수 없다.
--그때 필요한 확인 방법~!~!
select * from tab where tname='BOARD'; -- 해당 이름이 있는지 확인
/*
dbever 명령어
-사용자 테이블 정보 보기
SELECT *
FROM ALL_ALL_TABLE WHERE TAMLE_NAME = 'BOARD'
-사용자 컬럼 정보 보기
SELECT *
FROM ALL_TAB_TABLE WHERE TAMLE_NAME = 'EMP'
*/

select * from col where tname='EMP';

----------------------------------------------------------
create table temp(
    id number primary key, --제약: null값과, 중복데이터를 허용하지 않겠다.
                            -- '무결성'
    name nvarchar2(20)   
);

--1.가장 일반적인 INSERT
INSERT INTO temp(id, name)
VALUES(100, '홍길동');

select * from temp;

commit; --실반영 (컴퓨터를 껐다 켜도 기록이 남아있다)

--2. 컬럼 목록 생략 가능 (개발시 사용하지 말 것!!! 가독성x)
INSERT INTO temp
VALUES(200, '김유신');

SELECT * FROM TEMP;

ROLLBACK; -- INSERT 취소

--ID 컬럼 PK(Primary Key)
INSERT INTO temp(id, name)
VALUES(100,'아무개');
--ORA-00001: unique constraint (BITUSER.SYS_C007005) violated
INSERT INTO temp(name)
VALUES('누구야');
--ORA-01400: cannot insert NULL into ("BITUSER"."TEMP"."ID")

--------------------------------------------------------------------
----------------------------------0305------------------------------

--TIP)
--일반적인 SQL은 프로그램적인 요소가 없다.
--PL-SQL (변수, 제어문의 개념이 있다)
--개발시에 샘플 데이터 넣고 TEST (10만건씩 넣어보고 성능 테스트하고 그런다 ...)

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
--INSERT INTO 테이블명(컬럼리스트) VALUES(밸류리스트);

CREATE TABLE temp3(
    memberid NUMBER(3) NOT NULL, --정수 3자리, null값 불가
    name VARCHAR2(10), --null값 허용
    regdate DATE DEFAULT SYSDATE --초기값을 지정(기본값), insert 자동 시스템 날짜
);

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
SELECT SYSDATE FROM dual;

INSERT INTO temp3(memberid, name, regdate)
VALUES(100,'홍길동','2021-03-04');

SELECT * FROM temp3;
COMMIT;

INSERT INTO temp3(memberid, name)
VALUES(200,'김유신');

SELECT * FROM temp3;
COMMIT;

INSERT INTO temp3(memberid) VALUES(300);

SELECT * FROM temp3;
COMMIT;

INSERT INTO temp3(name) VALUES('누구');
--ORA-01400: cannot insert NULL into ("BITUSER"."TEMP3"."MEMBERID")

---------------------------------------
--TIP)
--1. 대량데이터 INSERT하기
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

--요구사항
--TEMP4에 있는 모든 데이터를 TEMP5에 넣어주세요.
--INSERT INTO 테이블명(컬럼리스트) SELECT 절
--조건: 컬럼의 타입이 일치해야하고, 받는 쪽의 크기가 더 크거나 같아야한다.

INSERT INTO temp5(num)
SELECT id FROM temp4;

SELECT * FROM temp5;
COMMIT;

--2. 대량 INSERT (2)
-- 테이블이 없는 상황에서, 테이블을 복제(구조, 스키마)하고 데이터를 삽입해준다.
-- 단, 제약정보는 복사가 안된다. (PK, FK 등...)
-- 순수한 데이터 구조와 데이터 복사

CREATE TABLE copyemp
AS SELECT * FROM emp;
--Table COPYEMP이(가) 생성되었습니다.

SELECT * FROM copyemp;
COMMIT;

CREATE TABLE copyemp2
AS 
  SELECT empno, ename, sal
  FROM emp
  WHERE deptno=30;
  
SELECT * FROM copyemp2;
COMMIT;

--질문
--틀(구조, 스키마) 구조만 복제하고 데이터는 복사하고싶지 않을때는?
CREATE TABLE copyemp3
AS
    SELECT * FROM emp WHERE 1=2; -- 거짓조건을 줘버리면 된다.
                                 -- 1=1 로 넣으면 항상 TRUE

SELECT * FROM copyemp3;
-----------------------------------insert end----------------------------

-----[UPDATE]-----
/*
UPDATE table_name
SET column1 = value1, [column2 = value2 ....]
[WHERE condition]

update 테이블명
set 컬럼 = 밸류 (컬럼2 = 밸류2 ...)
(where 조건절)

UPDATE table_name
SET column1 = (subquery)
WHERE column2 = (subquery)
*/

SELECT * FROM copyemp;

--컬럼의 모든 ROW가 바뀐다
UPDATE copyemp
SET sal = 0;

ROLLBACK;

UPDATE copyemp
SET sal=1111
WHERE deptno=20;

ROllBACK;

--서브쿼리를 사용한 업데이트
update copyemp
set sal = (select sum(sal) from emp);

SELECT * FROM copyemp;
ROLLBACK;

--여러개의 컬럼 업데이트
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

--개발자 (SQL) >> CRUD (Create(insert), Read(select), Update, Delete)
-- APP(JAVA) -  API(JDBC)   -Oracle
--자바코드를, 오라클이라는 소프트웨어에 저장해서 데이터를 넣고, 수정하고, 지우고, 선택(select)하는 것

--CRUD
--개발자: JAVA코드에서 전체 조회, 조건 조회, 삽입, 수정, 삭제 작업을 많이 한다.
--JAVA코드에서는 모두 함수로 만든다.
--전체조회: public List<Emp> getEmpAllList() { select * from emp }
--조건조회: public Emp getEmpListByEmpno(int empno) { select * from emp where empno=7788 }
--삽입: public int insertEmp(Emp emp) { insert into emp(...) values(.....)}



-----------------------------------------------------------------
--DDL (create, alter, drop (rename) : 테이블을 만들고, 수정하고, 삭제(테이블삭제)
--오라클.pdf (제9장) 138p

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

--TIP(정보조회)
select * from user_tables where lower(table_name) = 'board';
select * from user_constraints where lower(table_name) = 'board'; --제약정보 확인
--

--Oracle 11g >> 가상 컬럼(조합 컬럼)
--학생 성적 테이블: 국어, 영어, 수학, 총점
--국어, 영어, 수학 데이터만 insert하면 자동으로 총점 데이터가 만들어지게 하고 싶다.

create table vtable(
    no1 number,
    no2 number,
    no3 number GENERATED ALWAYS as (no1 + no2) VIRTUAL
);

insert into vtable(no1, no2) values(100,50);
insert into vtable(no1, no2) values(10,80);

select * from vtable;

-- 주의: no3에 insert하면 안돼
insert into vtable(no1, no2, no3) values(10,80, 90);
--SQL 오류: ORA-54013: INSERT operation disallowed on virtual columns

select * from user_tab_columns where table_name = 'VTABLE';
-- 가상테이블 확인하기
-- DEFAULT에 수식이 있으면 가상테이블


--실무에서  활용하는 코드
--제품정보 (입고일) 분기별 데이터 (4분기)
--입고일 : 2019-03-01 >> 1분기

create table vtable2
(
  no number , --순번
  p_code char(4), --제품코드 (A001 , B002)
  p_date char(8), --입고일(20190303)
  p_qty number, --수량
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
select * from vtable2 where p_bungi=1; --1분기데이터 가져오기

commit;

--------------------------------------------------
--DDL: 테이블 만들고 수정, 삭제

--1. 테이블 생성하기
create table temp6(id number);

--2. 기존테이블에 컬럼 추가하기
alter table temp6
add ename varchar2(20);

select * from temp6;
DESC temp6;


--3. 기존 테이블에 있는 기존 컬럼의 이름 바꾸기(rename)
alter table temp6
rename column ename to username;

select * from temp6;

--4. 기존 테이블에 있는 기존 컬럼의 타입 정보 수정(modify)
alter table temp6
modify(username varchar2(2000));

desc temp6;

--5. 기존 테이블에 있는 기존 컬럼 삭제
alter table temp6
drop column username;


--@@ delete : 데이터 삭제 (공간은 삭제되지 않음)
--테이블을 처음 만들면 처음에 크기가 주어진다 -> 데이터를 넣으면 데이터 크기만큼 테이블 크기도 커진다.
--ex) 처음 1m > 데이터 10만건 추가 > 100m >> 10만건 삭제(delete) > 데이터는 삭제되지만, 크기는 그대로다... (100m)

--테이블의 데이터를 삭제할 때 공간의 크기를 줄이려면..?
--truncate -> 단점: where절을 사용할 수 없다.
--ex) 처음 1m > 데이터 10만건 추가 > 100m >> 10만건 삭제(truncate) > 데이터 삭제 + 크기 1m

--7. 테이블 삭제(drop)
drop table temp6;

---------------------------------------------

---------------------------------------------
--테이블 제약 설정하기
--데이터 무결성 제약 조건
--오라클.pdf , 144p

--데이터 무결성 확보
--insert, update (제약)

/*
가) 컬럼 LEVEL 제약 조건(COLUMN LEVEL CONSTRAINT) 
1) 열별로 제약 조건을 정의한다.
2) 무결성 제약 조건 5 가지를 모두 적용할 수 있다.
3) NOT NULL 제약 조건은 컬럼 LEVEL 에서만 가능 하다.

나) 테이블 LEVEL 제약 조건(TABLE LEVEL CONSTRAINT) 
1) 테이블의 칼럼 정의와는 개별적으로 정의한다.
2) 하나 이상의 열을 참조할 경우에 사용
3) NOT NULL 을 제외한 나머지 제약 조건만 정의 가능하다.
*/
/*
PRIMARY KEY(PK)   :유일하게 테이블의 각행을 식별(NOT NULL 과 UNIQUE 조건을 만족)
                  :where empno=7788 > 데이터 1건 보장 > 성능
                    ㄴ> 조회를 많이하겠구나! > 내부적으로 index를 만든다
                  : 영허씨가 만화방을 시작했어용 (100권으로시작 -> 만화책 찾아주기 쉽다.)
                  : 만화책의 개수를 1000권으로 늘렸어용
                  : 준수씨가 만화를 빌리러왔는데 영허씨가 책을 찾아주는게 힘들어졌어용
                  : 책 찾는 시간이 오래걸려서 고객들이 떠나기 시작했어용
                  : 책의 위치정보를 가지고 있어야 한다는 컨설팅을 받았어용
                  : 책의 위치정보 -> 인덱스
                  : 책을 추가하거나 삭제하는게 힘이들어용 ... 
                     ㄴ> (DML에는 빠르게 찾기 위한 인덱스 부여 작업이 비효율적일 수도 있다)
                  : 인덱스를 부여하는 것이 효율적인지, 비효율적인지를 판단해야한다.
                  
FOREIGN KEY(FK)   :열과 참조된 열 사이의 외래키 관계를 적용하고 설정합니다.
                  :테이블과 테이블간의 관계를 정의하는 것 (참조제약)

UNIQUE key(UK)    :테이블의 모든 행을 유일하게 하는 값을 가진 열(NULL 을 허용)
                  :PRIMARY와 차이점 -> NULL 허용!!
                  :만약에 UNIQUE를 쓰고싶은데 NULL도 막고싶다면? -> NOT NULL UNIQUE
                    ㄴ> PK와 다른점은?
                        PK는 테이블당 한개만 사용할 수 있으나, (여러개의 컬럼을 묶어서 '한개'는 가능 (복합키))
                        UNIQUE는 컬럼의 개수만큼 사용할 수 있다.
                  
                  
NOT NULL(NN)      :열은 NULL 값을 포함할 수 없습니다. (필수입력)

CHECK(CK)         :참이어야 하는 조건을 지정함(대부분 업무 규칙을 설정)
                  :설정범위 내의 값만 입력받겠다.
                  : ex. gender 컬럼 -> 남/여 두개의 데이터만 입력되도록 하겠다.
                  :where gender in ('남','여') -> 이런 조건을 제약조건에 거는 것
                  : gender IN ('남','여')
*/

--제약 만드는 시점: create table
--테이블 생성 이후 추가: alter table ... add constraint ... (모델링 툴)

--TIP)
--제약정보를 확인하는 방법
select * from user_constraints where table_name ='EMP';

create table temp7
(
    --id number primary key -- 권장하지 않는 방법입니다.
                    -- ㄴ> 제약의 이름이 자동생성되기 때문에 삭제나 수정이 어렵다
    id number constraints pk_temp7_id primary key, -- 관용적 표현(이름설정: pk_temp7_id)
    name varchar2(20) not null,
    addr varchar2(50)
);

select * from user_constraints where table_name ='TEMP7';

insert into temp7(name,addr) values('홍길동','서울시 강남구');
--ORA-01400: cannot insert NULL into ("BITUSER"."TEMP7"."ID")
--ID컬럼에 NULL값 안돼용

insert into temp7(id,name,addr) values(10,'홍길동','서울시 강남구');

select * from temp7;
commit;

insert into temp7(id,name,addr) values(10,'아무개','서울시 개포동');
--ORA-00001: unique constraint (BITUSER.PK_TEMP7_ID) violated
--ID컬럼에 중복값 안돼용

--1. Primary Key: 테이블당 1개만 가능 (but, 여러개를 묶어서 1개는 가능!)
--create table member(ename, age) 
-- >> ename, age 두개의 컬럼을 묶어서 하나의 복합키를 만든 이유는?
-- ㄴ> 하나의 컬럼으로는 유일값이 나오지 않을 때!
-- ㄴ> ex, 동명이인이 있다면 이름만으로는 pk로 사용하기 힘든 경우니까 컬럼 여러개 묶어버리기! ->중복값이 안나오게!
-- 만약에, 동명이인인데 이름도 같다?
-- num도 같이 묶어서 복합키를 만들어 보아요 ... 등등

CREATE TABLE temp8(
id NUMBER CONSTRAINT pk_temp8_id PRIMARY KEY,
name nvarchar2(30) NOT NULL,
jumin nchar(6) CONSTRAINT uk_temp8_jumin UNIQUE,  -- jumin null 올수 있음 -> not null을 안걸어서
addr nvarchar2(1000)
);

INSERT INTO TEMP8(id, name, jumin, addr)
VALUES(10,'홍길동','123456','경기도');

SELECT * FROM TEMP8;
COMMIT;

INSERT INTO TEMP8(id, name, jumin, addr)
VALUES(20,'김유신','123456','서울');
--ORA-00001: unique constraint (BITUSER.UK_TEMP8_JUMIN) violated
--JUMIN에 UNIQUE를 걸어놔서 똑같은 주민번호를 넣을 수 없어용

--##UNIQUE -> NULL값을 허용한다.
INSERT INTO TEMP8(id, name, addr)
VALUES(20,'김유신','서울');

SELECT * FROM TEMP8;

--만약에 UNIQUE인데 NULL값도 방지하고싶어용
--jumin nchar(6) NOT NULL CONSTRAINT uk_temp8_jumin UNIQUE

--NULL은 중복체크를 하지 않는다.
INSERT INTO TEMP8(id, name, addr)
VALUES(30,'아무개','강원도');

SELECT * FROM TEMP8;
COMMIT;

-----------------------------------------------------------------
--테이블 생성 후 제약조건 추가하기
CREATE TABLE temp9 (id NUMBER);

--조건: 제약이 추가될 때 테이블에 있는 데이터를 검사해서, 
--     중복데이터가 있다면 PK걸 수 없음 -> 중복데이터를 삭제 후에 제약을 추가해야 한다.

ALTER TABLE temp9
ADD CONSTRAINT pk_temp9_id PRIMARY KEY(id);

select * from user_constraints where table_name ='TEMP9';

--복합키 어떻게 걸지요?
--ADD CONSTRAINT pk_temp9_id PRIMARY KEY(id,num); <- 컬럼을 두개 넣으면 된다.

ALTER TABLE temp9
ADD ENAME VARCHAR2(50);

--NOT NULL 추가
ALTER TABLE temp9
MODIFY(ename NOT NULL); --NOT NULL만 MODIFY로 추가한다
----------------------------------------------------------------
----------------------------------------------------------------

--CHECK 제약
--WHERE 조건과 동일한 형태의 제약 (-> WHERE gender IN ('남','여')
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
-- where age >= 19   -> 19세 이상만 찾으라 하면
);

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='TEMP10';

INSERT INTO TEMP10(id, name, jumin, addr, age)
VALUES(100,'홍길동','123456','서울시',25);

SELECT * FROM TEMP10;
COMMIT;

INSERT INTO TEMP10(id, name, jumin, addr, age)
VALUES(200,'김유신','123456','서울시',18);
--ORA-02290: check constraint (BITUSER.CK_TEMP10_AGE) violated
--CHECK 조건을 벗어난다.

--CHECK: 내가 원하는 데이터만 받겠다.

  
------------------------------------------------------------
--참조제약: 테이블과 테이블 간의 제약
CREATE TABLE c_emp
AS
   SELECT empno, ename, deptno FROM emp WHERE 1=2;
--emp의 껍데기만 복제

SELECT * FROM c_emp;

CREATE TABLE c_dept
AS
   SELECT deptno, dname FROM dept WHERE 1=2;
   
SELECT * FROM c_dept;

--참조: A테이블에 있는 어떠한 컬럼의 데이터는 B테이블에 컬럼의 데이터만 받겠다.
--ex. c_emp 테이블에 있는 deptno 컬럼의 데이터는 c_dept 테이블에 있는 deptno컬럼의 데이터만 쓰겠다.
--   = 참조하겠다(FK)

ALTER TABLE c_emp
ADD CONSTRAINT fk_c_emp_deptno FOREIGN KEY(deptno) REFERENCES c_dept(deptno);
-- 현재 c_dept의 deptno가 PK가 아니라서 참조할 수 없는 상태
-- ㄴ> 먼저 c_dept의 deptno에 PK 설정해줘야 한다.
--  = 실행하기 전에 c_dept >> deptno 컬럼에 참조해도 문제가 생기지 않는다는 믿음을 줘야한다.....

ALTER TABLE c_dept
ADD CONSTRAINT pk_c_dept_deptno PRIMARY KEY(deptno); -- 신용 확보 ..

ALTER TABLE c_emp
ADD CONSTRAINT fk_c_emp_deptno FOREIGN KEY(deptno) REFERENCES c_dept(deptno);
-- c_emp의 deptno는 c_dept의 deptno를 참조한다
-- c_deptno의 deptno는 c_emp의 deptno에 의해 참조당한다.

--제약
INSERT INTO c_dept(deptno, dname) VALUES(100, '인사팀');
INSERT INTO c_dept(deptno, dname) VALUES(200, '관리팀');
INSERT INTO c_dept(deptno, dname) VALUES(300, '회계팀');

COMMIT;
SELECT * FROM c_dept;

--신입사원 입사
INSERT INTO c_emp(empno, ename) VALUES(100,'홍길동'); --deptno를 입력하지 않은 상태
--deptno컬럼에 fk가 있어도 NOT NULL조건을 걸어두지 않으면 NULL값이 들어간다.
SELECT * FROM c_emp; 
-- '신입사원이 부서를 가지지 않을수도 있다' 라는 시나리오 조건이 있다면 not null을 안걸어두는것
-- 만약 '모든 사원이 반드시 부서를 가져야 한다'라면, NOT NULL을 걸어둬야 한다.
-- CREATE TABLE c_emp(deptno NOT NULL .. CONSTRAINT... )

INSERT INTO c_emp(empno, ename, deptno) VALUES(200, '김유신', 50);
--ORA-02291: integrity constraint (BITUSER.FK_C_EMP_DEPTNO) violated - parent key not found
-- ㄴ> DEPT테이블의 DEPTNO에 50은 없써 ..

INSERT INTO c_emp(empno, ename, deptno) VALUES(200, '김유신', 100);
--FK를 걸어놨으니까, dept테이블의 deptno에 있는 부서번호만 사용할 수 있다.

COMMIT;

------------------------------
--개발자관점
--테이블 (부모, 자식)
--c_emp, c_dept 테이블에서 deptno라는 컬럼을 기준으로 봤을 때, 누가 부모일까?
--부모(master): c_dept  - deptno관계 PK
--자식(detail): c_emp   - deptno관계 FK

--c_dept에서 100이라는 데이터를 삭제할 수 있을까?
--누군가 빌려쓰고 있는 상태라면, 삭제할 수 없다.
DELETE FROM c_dept WHERE deptno=100;
--ORA-02292: integrity constraint (BITUSER.FK_C_EMP_DEPTNO) violated - child record found
--데이터 '100'을 자식테이블이 이미 사용하고 있기 때문에!
--지우고싶다면, 먼저 자식테이블에서 100번을 삭제한 뒤에 지울 수 있다.
DELETE FROM c_Dept WHERE deptno=200; -- 가능 (사용하고있지 않기 때문에)

COMMIT;

/*
(column datatype [CONSTRAINT constraint_name]       
REFERENCES table_ name (column1[,column2,..] [ON DELETE CASCADE]) 

column datatype, . . . . . . . , 
[CONSTRAINT constraint_name] FOREIGN KEY (column1[,column2,..])        
REFERENCES table_name  (column1[,column2,..] [ON DELETE CASCADE]) 
*/
-- [ON DELETE CASCADE]  부모테이블과 생명을 같이 하겠다
-- 300 삭제 할 수 있나요?  네 
-- delete from c_dept where detpno=300;
-- 참조하는 자식 데이터 같이 삭제
-- delete from c_emp where deptno=300; 같이 실행

alter table c_emp
add constraint fk_emp_deptno foreign key(deptno) references c_dept(deptno) 
ON DELETE CASCADE;

--Tip
--MS-SQL
--ON DELETE CASCADE;
--ON UPDATE CASCADE;

/*
학생테이블: student_score
이름: name
학번: student_number
국어: korean
수학: math
영어: english
총점: sum
평균: avg

학과테이블: major
학과코드: major_code
학과명: major_name


--영문 테이블, 영문 컬럼명
--[학생 성적 테이블]
--학번의 데이터는 중복되거나 NULL 값을 허용하면 안된다
--이름 NULL 값을 허용하지 않는다
--국어, 영어, 수학 점수 컬럼은 숫자 타입이고 NULL 값을 허용
--값을 입력하지 않으면 default로 0값을 갖는다
--총점 ,평균 컬럼은 가상컬럼으로(조합컬럼) 생성한다
--학과코드는 학과 테이블에 학과코드를 참조한다
--학번 , 이름 , 국어 , 영어 , 수학 , 총점 , 평균 , 학과코드

--[학과 테이블]
--학과코드 데이터는 중복되거나 NULL 값을 허용하면 안된다,
--학과명 은 null값을 허락하지 않는다
--학과코드 , 학과명

--샘플 데이터 insert ..

--그리고 select 결과는
--학번 , 이름 총점, 평균 , 학과코드 , 학과명 을 출력하세요
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

--View 객체 ... (가상테이블)
--오라클.pdf (제12장) 192p

--view 객체 (create...)
--create view 뷰이름 as [select 구문]

--view는 테이블처럼 사용가능한 가상테이블이다 (실제로 데이터를 가지고 있는 것은 x)
--view는 메모리상에만 존재하는 가상테이블이다
--(subquery -> in line view -> from (select deptno avg(sal) from ... ) --> 임시적으로 만들었던 것
--create view는 view를 객체로 만들어서 필요할때마다 불러서 쓰겠다.

--view는 가상'테이블'
--사용법은 일반 테이블과 동일하다. (select , where ... )
--단, view가 볼 수 있는 데이터에 한해서만 가능하다.
--view를 통해서 원본테이블에 대한 DML(insert, update, delete)도 가능하다. --> 권장하지 x

create view v_001
as
  select empno, ename from emp;
  --ORA-01031: insufficient privileges
  --bituser에 view를 만들 수 있는 권한이 없다.
  
--GRANT CREATE ANY VIEW TO "BITUSER" WITH ADMIN OPTION;
--SYSTEM 계정에서 권한 부여함

create view v_001
as
  select empno, ename from emp;
  
select * from v_001; -- view가 가지고있는 SQL문장이 실행된 것이다.

--VIEW 사용목적
--1. 개발자의 편리성 : JOIN, SUBQUERY >> VIEW사용 >> 성능은 떨어진다 >> BUT 개발자의 편리성 때문에 사용
--2. 쿼리의 단순화(편리성) : 복잡한 쿼리를 매번 치는 것이 아니라 미리 만들어두고 사용하는 것이다.
--3. 관리자의 관점 > 보안성 : 특정 컬럼만 노출되니까!
--                      : 관리자가 EMP업무를 맡는 사원에게 VIEW를 만들어서 넘기는 등
CREATE VIEW v_emp
AS
    SELECT empno, ename, job, hiredate FROM emp;
-- 이렇게 만들어서 신입사원에게 view를 볼 수 있는 권한 + v_emp를 사용하라고 넘겨준다.

--VIEW를 통한 작업
SELECT * FROM v_emp;
SELECT * FROM v_emp WHERE job = 'CLERK';
SELECT empno FROM v_emp;

--편리성
CREATE VIEW v_002
AS
    SELECT e.empno, e.ename, e.deptno, d.dname
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno;
    
SELECT * FROM V_002;
SELECT * FROM v_002 WHERE deptno=20;

CREATE VIEW v_003
AS
    SELECT deptno, avg(sal) as avgsal -- 컬럼명 부여할 때(as), 띄어쓰기가 없으면 "" 안붙이는게 편하다
    FROM emp
    GROUP BY deptno;
--ORA-00998: must name this expression with a column alias
--뷰 가상테이블의 자존심.. '나도 테이블인데..컬럼명은 만들어줘라 ...'

SELECT deptno, avgsal FROM v_003;

/*
CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW view_name [(alias[,alias,...])]
AS Subquery 
[WITH CHECK OPTION [CONSTRAINT constraint ]]
[WITH READ ONLY]

OR REPLACE               이미 존재한다면 다시 생성한다.
FORCE Base Table         유무에 관계없이 VIEW 을 만든다.
NOFORCE                  기본 테이블이 존재할 경우에만 VIEW 를 생성한다.
view_name                VIEW 의 이름
Alias Subquery 를 통해 선택된 값에 대한 Column 명이 된다.
Subquery SELECT 문장을 기술한다.
WITH CHECK OPTION VIEW   에 의해 액세스 될 수 있는 행만이 입력,갱신될 수 있다.  
                        --view가 볼 수 있는 것만 수정, 데이터입력을 할 수 있도록 하겠다
Constraint CHECK OPTON   제약 조건에 대해 지정된 이름이다.
WITH READ ONLY           이 VIEW 에서 DML 이 수행될 수 없게 한다.
                        --읽기전용으로 하겠다. (수정, 삽입 x)

*/
create or replace view v_004 --없으면 새로 만들고, 있으면 덮어써라
as
    select avg(sal) as avgsal from emp;
    
select * from v_004;
    
create or replace view v_004 --없으면 새로 만들고, 있으면 덮어써라
as
    select round(avg(sal),0) as avgsal from emp;
    
select * from v_004;

--Q. select는 되는데 update, insert, delete가 안돼요 ....
--A. 프로젝트시 DB 한대를 공유할 것 /
--   한명이 update하면 그 사람이 commit과 rollback을 하기 전까지 rock 상태에 걸려있다.
--   commit, rollback을 습관화하자~~~~~

--view = 가상 테이블 (->DML작업이 가능하다 / insert, update, delete)
--단, "view를 통해서 볼 수 있는 데이터 + 단일테이블" 만 작업할 수 있다.

--단순 view (테이블 1개) >> DML가능, but 되도록이면 하지 마세용~~~
--복합 view (테이블 1개이상) >> join, subquery를 통해 만든 것은 DML 불가

select * from v_emp;

update v_emp set sal=0; 
-- v_emp는 sal을 볼 수 없는 상태이기 때문에 error
--ORA-00904: "SAL": invalid identifier

update v_emp set job='IT';
-- 가능
-- 실제 emp 테이블에 반영되는 것이다 (view는 데이터가 없으니까~~~)
--view가 가지는 원본 테이블의 데이터를 변경하는 것
select * from emp;
rollback;

--30번 부서 사원들의 직위, 이름, 월급을 담는 VIEW를 만드는데, 
--각각의 컬럼명을 직위, 사원이름, 월급으로 alias를 주고 월급이 300보다 많은 사원들만 추출하도록 하라

CREATE OR REPLACE VIEW VIEW_101
AS
    SELECT JOB AS 직위, ENAME AS 사원이름, SAL AS 월급
    FROM EMP
    WHERE DEPTNO=30 AND SAL >= 300;

SELECT * FROM VIEW_101;

/*
tIP
CREATE OR REPLACE VIEW VIEW_101(직위,사원이름,월급) --AS ALIAS 부여했을 때랑 똑같이 나온다.
AS
    SELECT JOB, ENAME, SAL
    FROM EMP
    WHERE DEPTNO=30 AND SAL >= 300;
    
*/

--부서별 평균월급을 담는 VIEW를 만들되, 평균월급이 2000이상인 부서만 출력하도록 하라
--FROM 조건 => WHERE
--GROUP BY 조건 => HAVING
SELECT * FROM EMP;

CREATE OR REPLACE VIEW  VIEW_102
AS
    SELECT DEPTNO, ROUND(AVG(SAL),0) AS 평균월급 FROM EMP
    GROUP BY DEPTNO HAVING AVG(SAL) >= 2000;
    
SELECT * FROM VIEW_102;

--DEPT와 조인해서, 부서이름도 출력하기
SELECT V.DEPTNO, V.평균월급, D.DNAME
FROM VIEW_102 V JOIN DEPT D
ON V.DEPTNO = D.DEPTNO;


----------------------------------------------------------------
--- 개발자 관점에서 SQL중에서 중요한 것 살펴보기 1번
--오라클.pdf (제11장) 185p
--순번 추출하기 (채번하기)
--SEQUENCE
--자동으로 번호를 생성하는 객체
/*
sequence_name        SEQUENCE 의 이름입니다.
INCREMENT BY n       정수 값인 n 으로 SEQUENCE 번호 사이의 간격을 지정.
                     이 절이 생략되면 SEQUENCE 는 1 씩 증가.
START WITH n         생성하기 위해 첫번째 SEQUENCE 를 지정.
                     이 절이 생략되면 SEQUENCE 는 1 로 시작.
MAXVALUE n           SEQUENCE 를 생성할 수 있는 최대 값을 지정.
NOMAXVALUE           오름차순용 10^27 최대값과 내림차순용-1 의 최소값을 지정.
MINVALUE n           최소 SEQUENCE 값을 지정.
NOMINVALUE           오름차순용 1 과 내림차순용-(10^26)의 최소값을 지정.
CYCLE | NOCYCLE      최대 또는 최소값에 도달한 후에 계속 값을 생성할 지의 여부를 지정. NOCYCLE 이 디폴트.
CACHE | NOCACHE      얼마나 많은 값이 메모리에 오라클 서버가 미리 할당하고 유지하는가를 지정. 
                     디폴트로 오라클 서버는 20 을 CACHE.
*/

--목적
-- ex) web site의 게시판 >> key(식별값) >> 1.2.3... 순번을 부여해야한다.

DROP TABLE board;

CREATE TABLE board(
    boardid NUMBER constraint pk_board_boardid primary key,
                    --PK: NOT NULL, UNIQUE 보장, 내부적으로 INDEXT 자동생성)
    title nvarchar2(50)
);

select * from board;
--게시판에 글을 쓰면
--INSERT INTO board(BOARDID, TITLE) VALUES();
--BOARDID 컬럼의 데이터는 처음 글을 쓰면 1 이라는 값이 INSERT되도록 하기
--그 다음 글 부터는 2,3,4.... 순차적인 데이터가 INSERT 되도록 규칙을 만들어 보세요.
-- HINT) VALUES 안에 SUBQUERY를 넣을 수 있다.
/*
INSERT INTO board(boardid, title)
VALUES( , '처음글') -- ID에 1이 들어가야한다.

INSERT INTO board(boardid, title)
VALUES( , '두번째글') -- ID에 2가 들어가야 한다.
*/

SELECT COUNT(BOARDID) + 1 FROM BOARD;

INSERT INTO board(boardid, title)
VALUES((SELECT COUNT(BOARDID) + 1 FROM BOARD) , '처음글'); -- ID에 1이 들어가야한다.

INSERT INTO board(boardid, title)
VALUES((SELECT COUNT(BOARDID) + 1 FROM BOARD) , '두번째글');

select * from board;
COMMIT;

--문제점??
--CRUD관점 (INSERT, UPDATE, DELETE)
DELETE FROM board WHERE boardid=1;
COMMIT;

INSERT INTO board(boardid, title)
VALUES((SELECT COUNT(BOARDID) + 1 FROM BOARD) , '세번째글');
--ORA-00001: unique constraint (BITUSER.PK_BOARD_BOARDID) violated
--중간에 삭제하고 다시 삽입시 똑같은 데이터가 들어간다.
--DML시 문제가 발생한다.

--다른 방법 필요!!
DELETE FROM board;
COMMIT;

INSERT INTO board(boardid, title)
VALUES((SELECT MAX(BOARDID) + 1 FROM BOARD) , '처음글');
--ORA-01400: cannot insert NULL into ("BITUSER"."BOARD"."BOARDID")

INSERT INTO board(boardid, title)
VALUES((SELECT NVL(MAX(BOARDID),0) + 1 FROM BOARD) , '처음글');
INSERT INTO board(boardid, title)
VALUES((SELECT NVL(MAX(BOARDID),0) + 1 FROM BOARD) , '두번째글');
INSERT INTO board(boardid, title)
VALUES((SELECT NVL(MAX(BOARDID),0) + 1 FROM BOARD) , '세번째글');

select * from board;
COMMIT;

DELETE FROM board WHERE boardid=1;

INSERT INTO board(boardid, title)
VALUES((SELECT NVL(MAX(BOARDID),0) + 1 FROM BOARD) , '네번째글');

select * from board;
COMMIT;

--------SEQUENCE 객체를 통해 번호 추출을 할 수 있다.
-- 중복값이 없고, 순차적인 값을 제공한다 (공유객체)

CREATE SEQUENCE board_num;

SELECT * FROM USER_SEQUENCES;

/*
187P (오라클.PDF)
>> NEXTVAL 과 CURRVAL 의사열 
> 특징 
1) NEXTVAL 는 다음 사용 가능한 SEQUENCE 값을 반환 한다.
2) SEQUENCE 가 참조될 때 마다, 다른 사용자에게 조차도 유일한 값을 반환한다.
3) CURRVAL 은 현재 SEQUENCE 값을 얻는다.
4) CURRVAL 이 참조되기 전에 NEXTVAL 이 사용되어야 한다.
*/

--번호추출
SELECT board_num.NEXTVAL FROM dual; --채번/반복실행하면 번호가 증가한다.
--현재까지 채번한 번호를 확인하기 (마지막 번호 확인)
SELECT board_num.CURRVAL FROM dual;

--------------------------------------------
--게시판 생성
CREATE TABLE kboard(
    num NUMBER CONSTRAINT pk_kboard_num PRIMARY KEY,
    title NVARCHAR2(20)
);

--게시판에서 사용되는 채번기 생성
CREATE SEQUENCE kboard_num;

INSERT INTO kboard VALUES(kboard_num.NEXTVAL , '첫번째 글 입니당');
INSERT INTO kboard VALUES(kboard_num.NEXTVAL , '두번째 글 입니당');
INSERT INTO kboard VALUES(kboard_num.NEXTVAL , '세번째 글 입니당');

SELECT * FROM KBOARD;

DELETE FROM kboard WHERE num=1;
SELECT * FROM KBOARD;
COMMIT;

SELECT kboard_num.CURRVAL FROM dual;

INSERT INTO kboard VALUES(kboard_num.NEXTVAL , '네번째 글 입니당');
SELECT * FROM KBOARD;
COMMIT;

-------------------------------------------------------------
--1. SEQUENCE 객체는 TABLE에 종속되지 않는다.
--   하나의 SEQUENCE를 여러개의 테이블에서 사용 가능하다)
--   SEQUENCE 생성 > A테이블, B테이블에서 사용 가능

--   웹사이트의 게시판이 10개일 때
--   상품 게시판, 관리자 게시판, 회원 게시판 ....
--   SEQUENCE를 10개 만들어서 각각 사용할 수도 있고, 1개만 만들어서 10개의 테이블에서 사용할 수도 있다.
--   클라이언트의 요구사항에 따라 만들면 된다.

--TIP)
--MS-SQL: CREATE TABLE board(boardnum INT identity(1,1), title VARCHAR(20));
--                                                  ㄴ> 시작값 1, 증가값 1
--        INSERT INTO board(title) values('방가') >> boardnum은 자동으로 1,2,3... 
--        identity의 경우 테이블에 종속적이다
--        2012버전부터는 SEQUENCE객체를 만들었다. (둘 다 있음)
--MYSQL: CREATE TABLE board(boardnum INT auto_increment, title VARCHAR(20));
--       INSERT INTO board(title) values('방가') >> boardnum은 자동으로 1,2,3...
--       SEQUENCE개념 없음
--MARIADB : MYSQL을 만든 사람들이 OPEN SOURCE개념으로 만든 것 (MYSQL과 같은 엔진을 사용한다)
--          https://mariadb.com/kb/en/create-sequence/
--          SEQUENCE 존재

----------------------------------------------------------
--옵션
CREATE SEQUENCE seq_num
START WITH 10   --10으로 시작
INCREMENT BY 2; --2씩 증가

SELECT seq_num.NEXTVAL FROM dual; --10으로 시작해서 2씩 증가 확인 가능
SELECT seq_num.CURRVAL FROM dual;

--게시판 글 100개
/*
num     title       content 
1
2
3
....
100

> 일반적인 게시판은 최신글(가장 나중에 쓴 글)이 화면 상단에 보여진다.
글번호를 내림차순 정렬한다.
ORDER BY 시퀀스번호 DESC;
*/
SELECT * FROM kboard ORDER BY num DESC;
--일반 게시판의 첫 쿼리
--최신글부터 위로 보여지도록 작성한 것
------------------------------------------------------------------
---------------------------------------------------------------
--- 개발자 관점에서 SQL중에서 중요한 것 살펴보기 2번
--rownum 의사컬럼: 실제 물리적으로 존재하는 컬럼이 아니고 논리적인 존재
--rownum: 실제로 테이블의 컬럼에 존재하지 않지만, 내부적으로 행의 번호를 부여할 수 있는 컬럼

SELECT * FROM emp;
SELECT ROWNUM AS 순번 , empno, ename FROM emp;
--SELECT한 결과에 순번을 부여하는 것

--목적
--1. TOP-n : 정렬된 기준으로 위에서 몇개 추출 (ex. 1등부터 10등까지~~)
--         : 테이블에서 조건에 맞는 상위(TOP)부터 레코드(row) n개 추출해라 
--TIP) MS-SQL: TOP 키워드 존재
--           : SELECT TOP 10, * FROM emp ORDER BY sal DESC;
--
--         : ORACLE에는 TOP 키워드 X
--         : rownum을 사용해서 순번을 부여한 뒤 특정 조건을 사용해서 top 쿼리 실행하기
--         : (1) 정렬의 기준을 정하기 (선행)
--         : (2) 정렬된 데이터를 기준으로 rownum을 설정하고, 
--         : (3) 조건을 걸어서 데이터를 추출

--(1) 정렬기준을 설정 (급여를 많이 받는 순으로 정렬)
SELECT *
FROM ( 
        SELECT *
        FROM emp
        ORDER BY sal DESC) e;

--(2) rownum 붙이기
SELECT ROWNUM AS num, e.*
FROM (  SELECT *
        FROM emp
        ORDER BY sal DESC) e;
--num: 가상테이블
        
--(3) 조건 걸기 (급여를 많이 받는 사원 5명)
SELECT *
FROM ( SELECT ROWNUM AS num, e.*
       FROM (  SELECT *
               FROM emp
               ORDER BY sal DESC) e
     ) n
WHERE num <= 5;
--------------------------------------------------------------------
--Top-n : 게시판의 paging처리에 사용된다.
--만약 데이터가 100건 있다
--웹 화면에 100건의 데이터를 한번에 출력하지 않는다.
--10건씩 한 화면에 출력하고 싶다.
--pagesize = 10 (한 화면(페이지)에 보여줄 수 있는 row의 건수)
--page의 개수를 알 수 있다. >> 10page가 나오겠군!
--1page, 2page, ... , 10page (1page 클릭 >> select 1~10 해서 JAVA에게 전달)
--                           (2page 클릭 >> select 11~20 해서 JAVA에게 전달 ...)
--<a hreg='page.jsp'>10</a> 10page( 91~100)
-------------------------------------------------------------------
--HR 계정으로 이동
SELECT * FROM employees; -- 107건의 데이터

--1단계. 기준이 되는 데이터 만들기
SELECT * FROM employees ORDER BY employee_id ASC;

--2단계. 기준데이터에 순번 부여하기
SELECT ROWNUM AS num, e.*
FROM ( SELECT * FROM employees ORDER BY employee_id ASC ) e;

SELECT ROWNUM AS num, e.*
FROM ( SELECT * FROM employees ORDER BY employee_id ASC ) e
WHERE ROWNUM <= 50; --내부적으로 생성된 ROWNUM 사용 (SELECT절에 있는 ROWNUM과 다른 것)

--3단계. 조건 걸기
SELECT *
FROM (  SELECT ROWNUM AS num, e.*
        FROM ( SELECT * FROM employees ORDER BY employee_id ASC ) e
        WHERE ROWNUM <= 50
      ) n
WHERE num >= 41;
--해석
--107건의 데이터
--pagesize = 10
--[1][2][3][4][5][6][7][8][9][10][11]
--[1] : 1~10번 데이터
--[2] : 11~20번 데이터
-- ...
--위의 쿼리문은 [5]번 페이지를 클릭했을 때의 출력일 것 (41~50번의 데이터를 보여주니까)

--IF, [1]번 페이지 클릭?
SELECT *
FROM (  SELECT ROWNUM AS num, e.*
        FROM ( SELECT * FROM employees ORDER BY employee_id ASC ) e
        WHERE ROWNUM <= 10
      ) n
WHERE num >= 1;

--BETWEEN A AND B 사용 가능
--WHERE ROWNUM BETWEEN 1 AND 10;
--SERVLET & JSP 수업때 다시 배울 것

---------------------------------------------------------------
--------------------------SQL END------------------------------
---------------------------------------------------------------