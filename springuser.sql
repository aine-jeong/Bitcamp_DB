-- USER SQL
CREATE USER SPRINGUSER IDENTIFIED BY 1004 
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS

-- ROLES
GRANT "RESOURCE" TO springuser WITH ADMIN OPTION;
GRANT "CONNECT" TO springuser WITH ADMIN OPTION;
ALTER USER springuser DEFAULT ROLE "RESOURCE","CONNECT";

-- SYSTEM PRIVILEGES





CREATE TABLE NOTICES
(
	"SEQ" VARCHAR2(10 BYTE), 
	"TITLE" VARCHAR2(200 BYTE), 
	"WRITER" VARCHAR2(50 BYTE), 
	"CONTENT" VARCHAR2(4000 BYTE), 
	"REGDATE" TIMESTAMP (6), 
	"HIT" NUMBER, 
	"FILESRC" VARCHAR2(500 BYTE)
);

CREATE TABLE "MEMBER"
(	
    "UID" VARCHAR2(50 BYTE), 
    "PWD" VARCHAR2(50 BYTE), 
    "NAME" VARCHAR2(50 BYTE), 
    "GENDER" VARCHAR2(10 BYTE), 
    "BIRTH" VARCHAR2(10 BYTE), 
    "IS_LUNAR" VARCHAR2(10 BYTE), 
    "CPHONE" VARCHAR2(15 BYTE), 
    "EMAIL" VARCHAR2(200 BYTE), 
    "HABIT" VARCHAR2(200 BYTE), 
    "REGDATE" DATE
);
 
INSERT INTO NOTICES(seq,title,writer,content,regdate,hit,filesrc)
VALUES(1,'title_1','writer_1','content_1',SYSDATE,0,'');
INSERT INTO NOTICES(seq,title,writer,content,regdate,hit,filesrc)
VALUES(2,'title_2','writer_2','content_2',SYSDATE,0,'');
INSERT INTO NOTICES(seq,title,writer,content,regdate,hit,filesrc)
VALUES(3,'title_3','writer_3','content_3',SYSDATE,0,'');
INSERT INTO NOTICES(seq,title,writer,content,regdate,hit,filesrc)
VALUES(4,'title_4','writer_4','content_4',SYSDATE,0,'');
INSERT INTO NOTICES(seq,title,writer,content,regdate,hit,filesrc)
VALUES(5,'title_5','writer_5','content_5',SYSDATE,0,'');
INSERT INTO NOTICES(seq,title,writer,content,regdate,hit,filesrc)
VALUES(6,'title_6','writer_6','content_6',SYSDATE,0,'');
INSERT INTO NOTICES(seq,title,writer,content,regdate,hit,filesrc)
VALUES(7,'title_7','writer_7','content_7',SYSDATE,0,'');
INSERT INTO NOTICES(seq,title,writer,content,regdate,hit,filesrc)
VALUES(8,'title_8','writer_8','content_8',SYSDATE,0,'');
INSERT INTO NOTICES(seq,title,writer,content,regdate,hit,filesrc)
VALUES(9,'title_9','writer_9','content_9',SYSDATE,0,'');
INSERT INTO NOTICES(seq,title,writer,content,regdate,hit,filesrc)
VALUES(10,'title_10','writer_10','content_10',SYSDATE,0,'');
COMMIT;




--게시판 쿼리
SELECT * FROM
		( SELECT ROWNUM NUM, N.* 
      FROM (
              SELECT * 
              FROM NOTICES 
              WHERE TITLE LIKE '%%' ORDER BY REGDATE DESC
            ) N
    )
		WHERE NUM BETWEEN 1 AND 5;


create table usermember(
 id varchar2(20),
 name varchar2(20),
 pwd  varchar2(20),
 email varchar2(20),
 age number
);

commit;

--다중파일 업로드용
alter table notices
add FileSrc2 varchar2(500);

select * from notices;
commit;


select * from member;
alter table member rename column "UID" to userid;


alter table member
modify gender varchar2(20);

desc member;

create table users
(
	userid varchar2(20),
	username varchar2(20),
	userpwd varchar2(20),
	usercmt varchar2(20)
);

create table guest(
  no number,
  name varchar2(20),
  pwd varchar2(20),
  email  varchar2(20),
  home  varchar2(20),
  content varchar2(20),
  regdate date
);
create sequence guest_seq;

CREATE TABLE board
  (
  num NUMBER, 
  NAME VARCHAR2(50), 
  email  VARCHAR2(50), 
  pwd  VARCHAR2(50), 
  subject  VARCHAR2(50), 
  content  VARCHAR2(50), 
  regdate  date,
  hit  NUMBER, 
  parent  NUMBER, 
  SORT  NUMBER, 
  tab  NUMBER
  );
  
  select * from BOARD;
  
alter table member
add point number;

alter table member 
add constraint ck_member_hit check(point < 3);

select * from member;

update member
set userid="ain";

update member
set point = nvl(point,0) + 1
where userid = 'ain';

rollback;
select * from member;

select userid , pwd as password from member;
select userid , pwd as password , 1 enabled from member;
--필요한 컬럼을 가상으로 이름붙이고 만들기
select userid , pwd as password , 1 enabled from member where userid='ain';

--[권장사항]
--설계 : Table 3개
--USER     ROLL
--USERANDROLL (다대다) : A 사용자 admin, user 권한일 수도 있고
--admin role : A, B, C
?
select m.userid, m.pwd , 1 enabled , r.ROLE_NAME 
from member m join roll r
on m.userid = r.userid
where m.userid='admin';

CREATE TABLE roll (
userid VARCHAR2(20),
Role_name VARCHAR2(30)
);
?
INSERT INTO roll VALUES('admin','ROLE_USER');
INSERT INTO roll VALUES('admin','ROLE_ADMIN');
INSERT INTO roll VALUES('kglim','ROLE_USER');
COMMIT;

select * from member;
select * from roll;

update member set userid = 'admin' where userid is null;

select userid , pwd as password , 1 enabled from member where userid='admin';

select m.userid, r.role_name
from member m join roll r
on m.userid = r.userid
where m.userid='admin';

alter table member
modify (pwd varchar2(2000));

desc member;

select * from member;
select * from roll;

insert into roll
values('hong','ROLE_ADMIN');

commit;

--회원가입하면 기본적으로 ROLE_USER
--트랜잭션, Oracle (Trigger) 사용 >> PL_SQL 배워야댕