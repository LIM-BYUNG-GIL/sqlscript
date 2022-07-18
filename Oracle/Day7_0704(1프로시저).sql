-- PL/SQL : Procedure(절차,순서) Language, 기존의 단순한 SQL이 확장된 언어(SQL로 만드는 프로그램)
--			변수, 제어문(if,반복문)을 사용하여 프로그래밍언어와 같이 SQL 실행의 흐름을 제어

-- 주의 : 디비버는 프로시저의 디버깅 기능이 없습니다.
DECLARE	-- 변수 선언부
--	vcustomid varchar2(20);
--	vage number(3,0);
	vname tbl_custom.name %TYPE;	-- 지정된 테이블의 컬럼과 동일 형식의 변수
	vage tbl_custom.age %TYPE;	
BEGIN	-- 프로시저 시작
-- 프로시저 내부에는 주로 DML 명령문들을 작성.(함께 실행해야할 여러 SQL : 트랜잭션)
	SELECT name, age
	INTO vname, vage	-- 프로시저 구문 : 검색결과를 변수에 저장
	FROM "TBL_CUSTOM" tc 
	WHERE custom_id = 'mina012';	-- 1개 행만 결과 조회되는 조건
									-- 여러개 생 조회될 때는 다른 cursor 필요.
	
-- 변수값을 콘솔에 출력(프로시저 명령)
	dbms_output.put_line('고객이름 : ' || vname);		-- ||는 문자열 연결 연산
	dbms_output.put_line('고객나이 : ' || vage);
	EXCEPTION		-- 예외(오류)처리
	WHEN no_data_found THEN		-- 예외 이름은 다양합니다. 예시 : no_date_found
		dbms_output.put_line('찾는 데이터가 없습니다.');
END;

-- 오라클 객체 프로시저 생성 : 검색할 값을 매개변수로 전달하기

CREATE OR REPLACE PROCEDURE search_custom(	-- 프로시저 이름 설정
	c_id IN tbl_custom.CUSTOM_ID %TYPE		-- 매개변수 IN 
												-- 리턴값 OUT 
)
IS 
	-- 일반 변수 선언
	vname tbl_custom.name %TYPE;	-- 지정된 테이블의 컬럼과 동일 형식의 변수
	vage tbl_custom.age %TYPE;
BEGIN 
	SELECT name, age
	INTO vname, vage
	FROM "TBL_CUSTOM" tc 
	WHERE custom_id = c_id;	-- 1개 행만 결과 조회되는 조건

	dbms_output.put_line('고객이름 : ' || vname);
	dbms_output.put_line('고객나이 : ' || vage);
	EXCEPTION		-- 예외(오류)처리
	WHEN no_data_found THEN
		dbms_output.put_line('찾는 데이터가 없습니다.');
END;

-- 프로시저 실행
BEGIN
	search_custom('twice');
END;


-- 출력(리턴값)이 있는 프로시저 정의

CREATE OR REPLACE PROCEDURE search_custom2(	-- 프로시저 이름 설정
	c_id IN tbl_custom.CUSTOM_ID %TYPE,		-- 매개변수 IN 입력값
	c_name OUT tbl_custom.NAME %TYPE		-- 리턴값 프로시저 출력 OUT 
)
IS 
	-- 일반 변수 선언
--	vname tbl_custom.name %TYPE;	-- 지정된 테이블의 컬럼과 동일 형식의 변수
--	vage tbl_custom.age %TYPE;
BEGIN 
	SELECT name
	INTO c_name
	FROM "TBL_CUSTOM" tc 
	WHERE custom_id = c_id;	-- 1개 행만 결과 조회되는 조건

	dbms_output.put_line('고객이름 : ' || c_name);
	EXCEPTION		-- 예외(오류)처리
	WHEN no_data_found THEN
		dbms_output.put_line('찾는 데이터가 없습니다.');
END;


CREATE OR REPLACE PROCEDURE search_custom2(	-- 프로시저 이름 설정
	c_id IN tbl_custom.CUSTOM_ID %TYPE,		-- 매개변수 IN 
	c_name OUT tbl_custom.NAME %TYPE		-- 리턴값 프로시저 출력 OUT 
)
IS 
	-- 일반 변수 선언
--	vname tbl_custom.name %TYPE;	-- 지정된 테이블의 컬럼과 동일 형식의 변수
--	vage tbl_custom.age %TYPE;
BEGIN 
	SELECT name
	INTO c_name
	FROM "TBL_CUSTOM" tc 
	WHERE custom_id = c_id;	-- 1개 행만 결과 조회되는 조건

	dbms_output.put_line('고객을 검색하였습니다.' || c_id);
	EXCEPTION		-- 예외(오류)처리
	WHEN no_data_found THEN
		dbms_output.put_line('찾는 데이터가 없습니다.');
		c_name := 'no match';		-- 대입문 := 기호
END;

-- 출력(리턴값)이 있는 프로시저 실행 : 출력값 저장을 위한 변수 필요합니다.
DECLARE 
	vname tbl_custom.name %TYPE;
BEGIN 
	search_custom2('mina012',vname)	;	-- vname은 프로시저 정의할때 OUT 으로 선어.
--	vname := search_custom2('mina012'); 과 같은 형식 아닙니다.
	dbms_output.put_line('*고객 이름 : ' || vname)	;
END;


-- BEGIN ~ END 에는 하나의 트랜잭션을 구성하는 DML(insert,update,delete 위주) 명령들로 구성
-- 오류가 생기면 EXCEPTION에서 rollback; 오류가 없을때만 commit;


-- 프로시저에 쓸 수 있는 몇가지SQL
-- 동일한 구조를 갖는 테이블 만들기
CREATE TABLE tbl_temp
AS
SELECT * FROM TBL_CUSTOM WHERE CUSTOM_ID = '0';

-- SELECT 한 결과를 insert 하기
INSERT INTO TBL_TEMP (SELECT * FROM TBL_CUSTOM tc WHERE CUSTOM_ID = 'wonder');

SELECT * FROM TBL_TEMP tt ;




-- Function 오라클 객체와 비교
-- 오라클 함수 : upper, lower, decode, round, to_date, to_char ...
-- Function 은 사용자 함수를 정의합니다. 테이블을 대상으로 하는 것이 아니라 특정 데이터를 조작하는 동작.











