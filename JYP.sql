-- USER SQL
ALTER USER "JYP"
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
ACCOUNT UNLOCK ;

-- QUOTAS
ALTER USER "JYP" QUOTA UNLIMITED ON "USERS";

-- ROLES
ALTER USER "JYP" DEFAULT ROLE "CONNECT","RESOURCE";

-- SYSTEM PRIVILEGES

select * from member;
insert into member (email, password, division, nickname)
VALUES ('admin@naver.com', '1004', '0', '관리자');
INSERT into member (email, password, division, nickname)
VALUES ('bit01@naver.com', '1004', '1', 'bit01');
INSERT into member (email, password, division, nickname)
VALUES ('bit02@naver.com', '1004', '1', 'bit02');
INSERT into member (email, password, division, nickname)
VALUES ('bit03@naver.com', '1004', '1', 'bit03');
INSERT into member (email, password, division, nickname)
VALUES ('bit04@naver.com', '1004', '1', 'bit04');
INSERT into member (email, password, division, nickname)
VALUES ('bit05@naver.com', '1004', '1', 'bit05');
INSERT into member (email, password, division, nickname)
VALUES ('bit06@naver.com', '1004', '1', 'bit06');
INSERT into member (email, password, division, nickname)
VALUES ('bit07@naver.com', '1004', '1', 'bit07');
INSERT into member (email, password, division, nickname)
VALUES ('bit08@naver.com', '1004', '1', 'bit08');
INSERT into member (email, password, division, nickname)
VALUES ('bit09@naver.com', '1004', '1', 'bit09');
INSERT into member (email, password, division, nickname)
VALUES ('bit10@naver.com', '1004', '1', 'bit10');
INSERT into member (email, password, division, nickname)
VALUES ('bit11@naver.com', '1004', '1', 'bit11');
INSERT into member (email, password, division, nickname)
VALUES ('bit12@naver.com', '1004', '1', 'bit12');
INSERT into member (email, password, division, nickname)
VALUES ('bit13@naver.com', '1004', '1', 'bit13');
INSERT into member (email, password, division, nickname)
VALUES ('bit14@naver.com', '1004', '1', 'bit14');
INSERT into member (email, password, division, nickname)
VALUES ('bit15@naver.com', '1004', '1', 'bit15');
INSERT into member (email, password, division, nickname)
VALUES ('bit16@naver.com', '1004', '1', 'bit16');
INSERT into member (email, password, division, nickname)
VALUES ('bit17@naver.com', '1004', '1', 'bit17');
INSERT into member (email, password, division, nickname)
VALUES ('bit18@naver.com', '1004', '1', 'bit18');
INSERT into member (email, password, division, nickname)
VALUES ('bit19@naver.com', '1004', '1', 'bit19');
INSERT into member (email, password, division, nickname)
VALUES ('bit20@naver.com', '1004', '1', 'bit20');
INSERT into member (email, password, division, nickname)
VALUES ('bit21@naver.com', '1004', '1', 'bit21');
INSERT into member (email, password, division, nickname)
VALUES ('bit22@naver.com', '1004', '1', 'bit22');
INSERT into member (email, password, division, nickname)
VALUES ('bit23@naver.com', '1004', '1', 'bit23');
INSERT into member (email, password, division, nickname)
VALUES ('bit24@naver.com', '1004', '1', 'bit24');
INSERT into member (email, password, division, nickname)
VALUES ('bit25@naver.com', '1004', '1', 'bit25');
INSERT into member (email, password, division, nickname)
VALUES ('bit26@naver.com', '1004', '1', 'bit26');
INSERT into member (email, password, division, nickname)
VALUES ('bit27@naver.com', '1004', '1', 'bit27');
INSERT into member (email, password, division, nickname)
VALUES ('bit28@naver.com', '1004', '1', 'bit28');
INSERT into member (email, password, division, nickname)
VALUES ('bit29@naver.com', '1004', '1', 'bit29');
INSERT into member (email, password, division, nickname)
VALUES ('bit30@naver.com', '1004', '1', 'bit30');
INSERT into member (email, password, division, nickname)
VALUES ('bit31@naver.com', '1004', '1', 'bit31');
INSERT into member (email, password, division, nickname)
VALUES ('bit32@naver.com', '1004', '1', 'bit32');
INSERT into member (email, password, division, nickname)
VALUES ('bit33@naver.com', '1004', '1', 'bit33');
INSERT into member (email, password, division, nickname)
VALUES ('bit34@naver.com', '1004', '1', 'bit34');
INSERT into member (email, password, division, nickname)
VALUES ('bit35@naver.com', '1004', '1', 'bit35');
INSERT into member (email, password, division, nickname)
VALUES ('bit36@naver.com', '1004', '1', 'bit36');
INSERT into member (email, password, division, nickname)
VALUES ('bit37@naver.com', '1004', '1', 'bit37');
INSERT into member (email, password, division, nickname)
VALUES ('bit38@naver.com', '1004', '1', 'bit38');
INSERT into member (email, password, division, nickname)
VALUES ('bit39@naver.com', '1004', '1', 'bit39');
INSERT into member (email, password, division, nickname)
VALUES ('bit40@naver.com', '1004', '1', 'bit40');
INSERT into member (email, password, division, nickname)
VALUES ('bit41@naver.com', '1004', '1', 'bit41');
INSERT into member (email, password, division, nickname)
VALUES ('bit42@naver.com', '1004', '1', 'bit42');
INSERT into member (email, password, division, nickname)
VALUES ('bit43@naver.com', '1004', '1', 'bit43');
INSERT into member (email, password, division, nickname)
VALUES ('bit44@naver.com', '1004', '1', 'bit44');
INSERT into member (email, password, division, nickname)
VALUES ('bit45@naver.com', '1004', '1', 'bit45');
INSERT into member (email, password, division, nickname)
VALUES ('bit46@naver.com', '1004', '1', 'bit46');
INSERT into member (email, password, division, nickname)
VALUES ('bit47@naver.com', '1004', '1', 'bit47');
INSERT into member (email, password, division, nickname)
VALUES ('bit48@naver.com', '1004', '1', 'bit48');
INSERT into member (email, password, division, nickname)
VALUES ('bit49@naver.com', '1004', '1', 'bit49');
INSERT into member (email, password, division, nickname)
VALUES ('bit50@naver.com', '1004', '1', 'bit50');
commit;
select * from community_board;
insert into community_board (c_number, c_title, c_content, c_writedate, c_filename, c_refer, c_depth, c_step, c_viewcount, email)
VALUES ('1', '동행구해요', '한라산 같이 가실분?', '2021-04-18', null, '1', '1', '1', null, 'bit01@naver.com');
insert into community_board (c_number, c_title, c_content, c_writedate, c_filename, c_refer, c_depth, c_step, c_viewcount, email)
VALUES ('2', '불친절해요', '만덕해수욕장 스타벅스 오전 직원분 무서움', '2021-04-17', null, '2', '1', '1', null, 'bit02@naver.com');
insert into community_board (c_number, c_title, c_content, c_writedate, c_filename, c_refer, c_depth, c_step, c_viewcount, email)
VALUES ('3', '최고의 서비스', '위미리에 제주펜션 사장님 너무 친절하세용', '2021-04-16', null, '3', '1', '1', null, 'bit03@naver.com');
commit;
insert into community_reply_board (cr_number, cr_content, cr_writedate, email, c_number)
VALUES ('1', '언제 어디서 출발하시나요?', '2021-04-18', 'bit11@naver.com', '1');
insert into community_reply_board (cr_number, cr_content, cr_writedate, email, c_number)
VALUES ('2', '내일 한라산 비온다고 하던데 괜찮을까요?', '2021-04-18', 'bit21@naver.com', '1');
insert into community_reply_board (cr_number, cr_content, cr_writedate, email, c_number)
VALUES ('3', '저요!!', '2021-04-18', 'bit31@naver.com', '1');
insert into community_reply_board (cr_number, cr_content, cr_writedate, email, c_number)
VALUES ('4', '맞아요ㅡㅡ', '2021-04-17', 'bit12@naver.com', '2');
insert into community_reply_board (cr_number, cr_content, cr_writedate, email, c_number)
VALUES ('5', '저는 괜찮았었는데', '2021-04-17', 'bit22@naver.com', '2');
insert into community_reply_board (cr_number, cr_content, cr_writedate, email, c_number)
VALUES ('6', '정말 친절하심!!', '2021-04-16', 'bit31@naver.com', '3');
insert into community_reply_board (cr_number, cr_content, cr_writedate, email, c_number)
VALUES ('7', '정확한 위치가 어딘가요?', '2021-04-16', 'bit32@naver.com', '3');
select * from community_reply_board;
commit;
select * from community_attachedfile;
INSERT INTO community_attachedfile(c_filesize, c_filename, c_real_filename, c_number)
VALUES (1, '1.jpg', '1.jpg', '1');
-- 파일 사이즈가 mb인지 표시해주는 영역 필요한듯
INSERT INTO community_attachedfile(c_filesize, c_filename, c_real_filename, c_number)
VALUES (10, '1.png', '1.png', '2');
select * from notice_board;
--TRUNCATE table notice_board;
INSERT INTO notice_board (n_number, n_title, n_filename, n_filesize, n_real_filename, n_viewcount, email)
VALUES (1, '공지사항 게시판입니다.', null, null, null, null, 'admin@naver.com');
INSERT INTO notice_board (n_number, n_title, n_filename, n_filesize, n_real_filename, n_viewcount, email)
VALUES (2, '우도의 여행정보가 수정 예정중에 있습니다.', null, null, null, null, 'admin@naver.com');
INSERT INTO notice_board (n_number, n_title, n_filename, n_filesize, n_real_filename, n_viewcount, email)
VALUES (3, '비양도에 대한 정보가 추가될 예정입니다.', null, null, null, null, 'admin@naver.com');
select * from qna_board;
insert into qna_board (QNA_NUMBER, QNA_TITLE, QNA_FILENAME, QNA_FILESIZE, QNA_REAL_FILENAME, 
QNA_CONTENT,QNA_WRITEDATE,QNA_REFER, QNA_DEPTH, QNA_STEP, QNA_VIEWCOUNT, EMAIL)
VALUES (1, '정보가 잘못 표시되는거 같아요', null, null, null, '사이트에서 얻은 우도 여행지 관광정보에 대한 정보가 다른거 같아요 확인해주세요',
'2021-04-18', '1', '1', '1', '1', 'bit15@naver.com'); 
commit;


select * from cartlist;

INSERT INTO CARTLIST(EMAIL, CONTENT_ID) VALUES('bit47@naver.com', 'CNTS_000000000021375');
INSERT INTO CARTLIST(EMAIL, CONTENT_ID) VALUES('bit43@naver.com', 'CNTS_000000000021375');
INSERT INTO CARTLIST(EMAIL, CONTENT_ID) VALUES('bit40@naver.com', 'CNTS_000000000021375');

select CONTENT_ID from CARTLIST where email='bit01@naver.com';

SELECT COUNT(*) AS cnt FROM CARTLIST WHERE 1 = 1 AND EMAIL LIKE 'bit47@naver.com' AND CONTENT_ID LIKE 'CNTS_0000000000215';
DELETE FROM CARTLIST WHERE EMAIL LIKE 'bit47@naver.com' AND CONTENT_ID LIKE 'CNTS_000000000021375';


select * from ain_board;