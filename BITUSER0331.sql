create table dmlemp
as
select * from emp;

select * from dmlemp;

alter table dmlemp
add constraint pk_dmlemp_empno primary key(empno);

delete from dmlemp
where deptno='9999';