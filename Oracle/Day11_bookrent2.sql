/*
 * [[[[	'도서대여' 처리 사항	]]]]
 * - 회원은 하루에 1권의 책만 대여할 수 있다.
 * - 대여한다. : rent_date 는 대여일자, exp_date 는 반납기한일자이며 rent_date + 14
 * - 반납한다. : return date 는 반납일자, delay_days 는 연체일수 return date - exp_date
 * - return_date 가 null 이면 대여중, null 이 아니면 반납된 도서.
 */

-- 1) 도서를 추가합니다. 'B1102', '스트라이크 던지기', '박철순', 'KBO', '2020-11-10'
INSERT INTO TBL_BOOK (bcode,title,writer,publisher,pdate)
VALUES ('B1102','스트라이크 던지기','박철순','KBO','2020-11-10');

-- 2) 반남된 도서의 연체일수를 계산하여 delay_days 컬럼값을 update 합니다.
UPDATE TBL_BOOKRENT SET delay_days = return_date - exp_date
WHERE RETURN_date IS NOT NULL;
SELECT * FROM TBL_BOOKRENT ;

-- 3) 현재 대출 중인 도서의 연체일수 계산해서 회원IDX, 도서코드, 연체 일수 조회하기.
-- 오늘 날짜 sysdate 는 년월일 패턴이 지정되지 않아 그냥하면 long 값으로 계산됩니다.
SELECT mem_idx, bcode, to_date(to_char(sysdate,'yyyy-MM-dd')) - exp_date
FROM TBL_BOOKRENT WHERE RETURN_date IS NULL;
-- 또는
SELECT mem_idx, bcode, trunc(sysdate) - EXP_date	-- trunc(sysdate) 는 sysdate 의 시간부분은 버립니다.
FROM TBL_BOOKRENT WHERE return_date IS NULL;

-- 4) 현재 대출 중인 도서 중 연체인 회원의 이름, 전화번호를 검색합니다. 오늘 날짜 sysdate 기준으로 확인하기.!
-- 현재 기준으로 연체 중인 것은 반납기한 < 현재날짜
SELECT name, tel FROM BOOK_MEMBER bm JOIN TBL_BOOKRENT tb
ON tm.mem_idx = tb.mem_idx AND SYSDATE > EXP_date AND RETURN_date IS NULL;

-- 5) 현재 대출중인 도서의 도서명코드와 도서명 검색합니다.
SELECT tb.bcode, title FROM TBL_BOOK tb JOIN TBL_BOOKRENT tb2
ON tb.bcode = tb2.bcode AND RETURN_date IS NULL;

-- 6) 현재 도서를 대여한 회원의 IDX와 회원이름을 검색합니다.
SELECT bm.mem_idx, name FROM BOOK_MEMBER bm JOIN TBL_BOOKRENT tb
ON bm.mem_idx = tb.mem_idx AND return_date IS NULL;

-- 7) 대충중인 도서의 회원이름, 도서명, 반납기한 검색합니다. -> DM으로 보내주세요.
SELECT bm.name, tb.title, tb2.exp_date
FROM BOOK_MEMBER bm, TBL_BOOK tb, TBL_BOOKRENT tb2
WHERE bm.mem_idx = tb2.mem_idx AND tb.bcode = tb2.bcode
AND tb2.return_date IS NULL;

-- 또는
SELECT name, title, exp_date FROM TBL_BOOKRENT tb
JOIN TBL_BOOK tb2 ON tb2.bcode = tb.bcode
JOIN BOOK_MEMBER bm ON tb.mem_idx = bm.mem_idx
WHERE return_date IS NULL;

-- 8) 현재 연체 중인 도서의 회원IDX, 도서코드, 반납기한을 검색합니다.
SELECT mem_idx, bcode, exp_date FROM TBL_BOOKRENT 
WHERE SYSDATE > exp_date;

-- 9) 회원 IDX '10002'는 도서 대출이 가능한지 프로시저를 작성합니다.

DECLARE 
	vcnt NUMBER;
BEGIN 

	SELECT count(*) INTO vcnt
	FROM TBL_BOOKRENT tb
	WHERE mem_idx = 10001 AND return_date IS NULL;		-- vcnt 가 0일때만 대여가능
	IF (vcnt = 0) THEN 
		dbms_output.put_line('책 대여 가능합니다.');
	ELSE 
		dbms_output.put_line('대여 중인 책을 반납해야 가능합니다.');
	END IF;
END;

-- 프로시저 오라클 객체
CREATE OR REPLACE PROCEDURE check_member(
	arg_mem IN book_member.mem_idx%TYPE,	-- 프로시저 실행할 때 값을 받을 매개변수
	isOK OUT varchar2		-- 자바의 리턴값에 해당하는 부분.
)
IS 
	vcnt NUMBER;
	vname varchar2(100);
BEGIN 
	-- 입력 매개변수가 없는 회원인가를 확인하는 sql과 exception 처리. arg_mem으로 회원테이블에서 name조회
	-- 없으면 exception 처리
	SELECT name	INTO vname
		FROM BOOK_MEMBER bm WHERE MEM_IDX = arg_mem;
	
	SELECT count(*)
	INTO vcnt
	FROM TBL_BOOKRENT tb
	WHERE mem_idx = arg_mem AND return_date IS NULL;		-- vcnt 가 0일때만 대여가능
	IF (vcnt = 0) THEN 
		dbms_output.put_line('책 대여 가능합니다.');
		isOK := '가능';
	ELSE 
		dbms_output.put_line('대여 중인 책을 반납해야 가능합니다.');
		isOK := '불가능';
	END IF;
	EXCEPTION 
	WHEN no_data_found THEN
		dbms_output.put_line('회원이 아닙니다.');
		isOK := 'no match';
END;

-- 프로시저 실행하기
DECLARE
	vresult varchar(20);
BEGIN 
	check_member(10003,vresult);
	dbms_output.put_line('결과 : ' || vresult);
END;


-- 10) 도서명 '패스트'라는 도서가 대출이 가능한지 프로시저를 작성합니다.
DECLARE
	v_bcode varchar2(100);
	v_cnt NUMBER;
BEGIN 
	SELECT bcode INTO v_bcode		-- v_bcode는 'A1102'
		FROM TBL_BOOK tb WHERE title = '패스트';
	SELECT count(*) INTO v_cnt		-- v_cnt 값이 1이면 v_bcode 책은 대출중 ?
		FROM TBL_BOOKRENT tb2 WHERE bcode = v_bcode AND return_date IS NULL;
	IF (v_cnt = 1) THEN
		dbms_output.put_line('대여 중인 책입니다.');
	ELSE 
		dbms_output.put_line('책 대여 가능합니다.');
	END IF;
END;


-- 11) 9와 10을 이용해서 insert 를 하는 프로시저를 작성합니다.

-- 프로시저 오라클 객체
CREATE OR REPLACE PROCEDURE check_book(
		arg_book IN tbl_book.title%TYPE,	-- 프로시저 실행할 때 값을 받을 매개변수
		isOK OUT varchar2		-- 자바의 리턴값에 해당하는 부분.
	)
	IS
	v_bcode varchar2(100);
	v_cnt NUMBER;
BEGIN
	SELECT bcode INTO v_bcode		-- v_bcode 는 'A1102'
		FROM TBL_BOOK tb WHERE title = arg_book;
	-- 없는 책 입력하면 
	SELECT count(*) INTO v_cnt		-- v_cnt 값이 1이면 v_bcode 책은 대출 중
		FROM TBL_BOOKRENT tb2 WHERE bcode = v_bcode AND return_date IS NULL;
	IF (v_cnt = 1) THEN
		dbms_output.put_line('대여 중인 책 입니다.');
		isOK := 'FALSE';
	ELSE
		dbms_output.put_line('책 대여 가능합니다.');
		isOK := 'TRUE';
	END IF;
	EXCEPTION		-- 예외(오류)처리
	WHEN no_data_found THEN
		dbms_output.put_line('찾는 책이 없습니다.');
		isOK := 'no match';

	-- 없는 책은 isOK := 'no match';
END;

-- 프로시저 실행하기
	DECLARE
		vresult varchar2(100);
	BEGIN
		check_book('푸른사자',vresult);		-- 코스모스, 푸른사자 와니니 는 FALSE
		dbms_output.put_line('결과 : ' || vresult);
	END;









