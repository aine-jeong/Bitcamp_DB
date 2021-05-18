CREATE TABLE board(
board_num number,              --글번호
board_name VARCHAR2(20),   --작성자
board_pass  VARCHAR2(15),     --작성자 비번
board_subject VARCHAR2(50),  --글제목
board_content VARCHAR2(2000), --글내용
board_file VARCHAR(50), --글의 첨부될 파일 이름
board_re_ref NUMBER,     --참조글(글의 묶음)
board_re_lev  NUMBER,    --글의 깊이 (들여쓰기)(depth)
board_re_seq  NUMBER,   --글의 순서 (step)
board_readcount NUMBER, --글의 조회수
board_date DATE,          --글쓴 날짜
PRIMARY KEY(board_num)
);

alter table board
add notice varchar2(10);

select * from board;