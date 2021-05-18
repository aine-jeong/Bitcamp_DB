select * from (select rownum rn, c_number, title, content, writedate, filename, refer, depth, step, viewcount, email
        from ( SELECT * FROM ain_board ORDER BY refer DESC , step ASC)
				where rownum <= 5) where rn >= 1;
                
select * from (select rownum rn, c_number, title,
				content, writedate, filename, refer, depth, step, viewcount, email
				from ( SELECT * FROM ain_board ORDER BY refer DESC , step ASC)
				where rownum <= 5) where rn >= 1;
                
                
select cr_number, content, writedate, email, c_number from ain_reply_board where c_number=1 order by cr_number desc;

select c_number, title, content, writedate, filename, refer, depth, step, viewcount, email from ain_board where c_Number=1;

update ain_board set viewcount = viewcount + 1 where c_Number=1;
commit;

select * from ain_board;

select c_number, title, content, writedate, filename, refer, depth, step, viewcount, a.email, nickname from ain_board a join member m on a.email = m.email;

select c_number, title, content, writedate, filename, refer, depth, step, viewcount, a.email, nickname from ain_board a join member m on a.email = m.email where c_Number=1;

select cr_number, content, writedate, a.email, c_number from ain_reply_board a join member m on a.email = m.email where c_Number=1;

select cr_number, content, writedate, a.email, c_number, nickname from ain_reply_board a join member m on a.email = m.email where c_Number=1 order by cr_number desc;

select * from (select rownum rn, c_number, title, content, writedate, filename, refer, depth, step, viewcount, a.email, nickname
				from ( SELECT * FROM ain_board ORDER BY refer DESC , step ASC) a
                join member m on a.email = m.email
				where rownum <= 5) where rn >= 1;
            
SELECT ainsequence.NEXTVAL FROM ain_board;
                
insert into ain_board(cNumber, title, content, writedate, filename, refer, depth, step, viewcount, email, filerealname, filesize)
        values(C_Number.nextval,'테스트','테스트중입니다',21-04-22,null,8,0,0,10,'bit01@naver.com');
        
create sequence ainsequence;
create sequence ainreplyseq;

update ain_board set title='3333333' , content='33333' where c_number=5;
commit;

select refer , depth , step from ain_board where c_Number=21;

update ain_board set step=step+1 where step > 0 and refer =1;
commit;

insert into ain_board(c_Number, title, filename, filesize, filerealname, content, refer, depth, step, email)
        values(ainsequence.NEXTVAL,'RE_잠좀자자',null,null,null,'졸령',11,1,1,'bit01@naver.com');
        
        
insert into ain_reply_board (cr_number, content, writedate, email, c_number)
VALUES ('8', '111', '2021-04-16', 'bit31@naver.com', '18');
insert into ain_reply_board (cr_number, content, writedate, email, c_number)
VALUES ('9', '111', '2021-04-16', 'bit32@naver.com', '7');
commit;

--회원수불러오기
select count(*) cnt from member;

--회원리스트
select * from (select rownum rn, email, password, division, nickname
		from member
		where rownum <= 10) where rn >= 1;
        

select c.c_number, c.title from member m join ain_board c on m.email = c.email
where m.email = 'bit01@naver.com';

update member set division=99
where email='bit13@naver.com';
commit;

select email, password, division, nickname from member where nickname like '%b%';

select c_number, refer, depth, step from ain_board where c_number = 1;

select title depth, step, c_number, refer from ain_board where step = 1 and refer = 12;