-- 테이블 만드는 create table, 데이터 형식 테스트

CREATE TABLE tbl_member(
	mno NUMBER,			-- 기본 38자리
	name nvarchar2(50),
	email varchar2(100),
	join_date date		-- 날짜 년-월-일, 시간 시:분:초.밀리초
);

-- 1. DML INSERT 형식 (데이터 행 row 추가)
-- 모든 컬럼에 데이터를 저장하는 형식(컬럼명 생략), 날짜는 date 자동변환
INSERT INTO tbl_member member VALUES (1,'김모모','momo@naver.com','2022-03-02');
-- 일부 컬럼에 데이터를 저장하는 형식
INSERT INTO tbl_member(mno,name)		-- 데이터 저장될 컬럼명 나열
VALUES (2,'이나나');
--------------------------------------------------------------
-- 2. DML SELECT 형식 (데이터 행 row 조회)
-- select 조회할 컬럼 목록 from 테이블 이름 [where 조건식]; 모든 컬럼은 * 로 대체
SELECT name FROM TBL_MEMBER ;
SELECT name, join_date FROM TBL_MEMBER ;
SELECT * FROM TBL_MEMBER ;
SELECT * FROM TBL_MEMBER WHERE name = '최다현'; -- 조건식은 컬럼이름으로 조회할 관계논리식
SELECT * FROM TBL_MEMBER tm WHERE mno > 2;
SELECT * FROM TBL_MEMBER tm WHERE JOIN_DATE > '2022-03-03';
SELECT name,email FROM TBL_MEMBER tm WHERE JOIN_DATE > '2022-03-03';
-- null 값 조회
SELECT * FROM TBL_MEMBER tm WHERE EMAIL IS NULL;
SELECT * FROM TBL_MEMBER tm WHERE EMAIL IS NOT NULL;
-- 문자열의 부분검색 : like 연산
SELECT * FROM TBL_MEMBER WHERE NAME LIKE '%다현'; -- %는 don't care
SELECT * FROM TBL_MEMBER WHERE NAME LIKE '다현%'; -- 조회결과는 ?
SELECT * FROM TBL_MEMBER WHERE NAME LIKE '%다현%'; -- 조회결과는 ?
-- or 연산 : mno값이 1 또는 2 또는 4
SELECT * FROM TBL_MEMBER WHERE mno = 1 OR mno = 2 OR mno = 4;
-- 오라클의 or 대체 연산자 : in (동일 컬럼에 대한 조건식일때)
SELECT * FROM  TBL_MEMBER WHERE mno IN (1,2,4);
SELECT * FROM  TBL_MEMBER WHERE mno NOT IN (1,2,4);
SELECT * FROM  TBL_MEMBER WHERE name IN ('김모모','최다현');

-- Date 형식
INSERT INTO tbl_member member VALUES (3,'최다현','dahy@naver.com','2022-03-04 16:47'); -- 오류 : 날짜형식으로 자동변환 못함.

-- 오라클의 to_date함수는 문자열을 날짜형식으로 변환.(두번째 인자는 패턴)
INSERT INTO tbl_member member VALUES (3,'최다현','dahy@naver.com',to_date('2022-03-04 16:47','YYYY-MM-DD HH24:MI'));

-- to_char 함수 : 날짜형식에서 문자열로 변경합니다. 두번째 인자는 패턴 -> 년도 또는 일부 값만 추출에 활용.
SELECT to_char(join_date,'YYYY') FROM tbl_member;

-- 현재 시스템의 날짜와 시간 : sysdate 함수
INSERT INTO tbl_member VALUES (4,'쯔위','aaa@gmail.com',sysdate);

SELECT  * FROM tbl_member;

-- 처음 만든 테이블 구조 중 mno 컬럼을 정밀도 5로 축소 변경
--			축소 변경할때는 mno 컬럼에 값이 없어야 합니다.
ALTER TABLE "C##IDEV".TBL_MEMBER MODIFY MNO NUMBER(5,0);