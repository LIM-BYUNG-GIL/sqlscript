-- 오라클은 시퀀스를 이용하여 자동 증가되는 값을 만들고 이를 테이블의 컬럼 값으로 insert 한다.
-- (mysql은 다른 방법.)
CREATE SEQUENCE test_seq1;		-- 시퀀스 이름은 식별자(보통 테이블이름을 사용해서 작성)

-- dual은 연산, 함수 결과 등을 확인할 때 사용하는 임시 테이블입니다.
SELECT 2+3 FROM dual;

-- 시쿼스의 다음값으로 증가해라.
SELECT test_seq1.nextval FROM dual;
 -- 맨처음 nextval을 실행해야 currval(시퀀스의 현재값) 실행 가능
SELECT test_seq1.currval FROM dual;


CREATE TABLE tbl_seq (
	tno number(7),
	name nvarchar2(10)
);

INSERT INTO tbl_seq(tno,name) VALUES (test_seq1.nextval,'모모');
INSERT INTO tbl_seq(tno,name) VALUES (test_seq1.nextval,'쯔위');
INSERT INTO tbl_seq(tno,name) VALUES (test_seq1.nextval,'나연');
INSERT INTO tbl_seq(tno,name) VALUES (test_seq1.nextval,'다현');
INSERT INTO tbl_seq(tno,name) VALUES (test_seq1.nextval,'지효');
SELECT  * FROM tbl_seq;

CREATE SEQUENCE test_seq2
	INCREMENT BY 2		-- 증감 설정
	START WITH 20001;	-- 시작값		-- MAXVALUE는 최댓값
									-- MINVALUE는 최댓값 도달 수 순환하는 최솟값

SELECT test_seq2.nextval FROM dual;
SELECT test_seq2.currval FROM dual;
