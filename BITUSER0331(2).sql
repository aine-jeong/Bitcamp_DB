select * from dmlemp where empno=7499;

create table trans_A(
  num number,
  name varchar2(20)
);

create table trans_B(
   num number constraint pk_trans_B_num primary key,
   name varchar2(20)
);

select * from trans_A;
select * from trans_B;

CREATE TABLE koreaMember
(
    id VARCHAR2(50) PRIMARY KEY ,
    pwd VARCHAR2(50) NOT NULL,
    NAME VARCHAR2(50) NOT NULL,
    age NUMBER ,
    gender CHAR(4),
    email VARCHAR2(50),
    ip   VARCHAR2(50)
);

select * from koreaMember;

select count(*) from koreamember;

update koreaMember
set ip='192.168.0.54';

commit;

-------------------------------0402--

create table memo(
	id varchar2(15) not null,
	email varchar2(20) not null,
	content varchar2(100)
);

select * from memo;

delete from memo where id in('1','5');

commit;

select count(id)
from memo
group by id;

alter table memo
add constraint pk_memo_id primary key(id);

SELECT * FROM memo WHERE id='ain';

-------0407-----------
create table mvcregister(
 id number constraint pk_mvcregister_id primary key,
 pwd varchar2(20) not null,
 email varchar2(20) not null
);

select * from mvcregister;