-- 데이터베이스 트리거 : insert, update, delete 할 때 동작하는 프로시저
-- 특정 테이블에 속해있는 객체

CREATE OR REPLACE TRIGGER secure_custom
BEFORE UPDATE OR DELETE ON tbl_custom		-- 트리거 동작하는 테이블, SQL과 시점
BEGIN 
	IF to_char(sysdate, 'HH24:MI') BETWEEN '13:00' AND '15:00' THEN 
		raise_application_error(-20000,'지금은 오후 1시~3시는 작업할 수 없습니다.');
	END IF;	
END;
-- 트리거 동작 테스트
DELETE FROM TBL_CUSTOM WHERE CUSTOM_ID = 'twice';

-- 트리거 비활성화 : disable, 활성화 : enable
ALTER TRIGGER secure_custom enable;


-- 트리거에 필요한 테이블 사전에 생성.
CREATE TABLE TBL_TEMP 
AS
SELECT * FROM TBL_BUY tb WHERE CUSTOM_ID = '0';
-- 트리거 정의(생성)
CREATE OR REPLACE TRIGGER cancel_buy
AFTER DELETE ON tbl_buy
FOR EACH ROW		-- 만족(적용)하는 행이 여러개 일때, :OLD UPDATE 또는 DELETE 하기 전 값, :NEW 는 INSERT 한 값
BEGIN 
	-- 구매 취소한 데이터 tbl_temp 임시테이블에 insert
	INSERT INTO tbl_temp
	VALUES
	(:OLD.custom_id, :OLD.pcode, :OLD.quantity, :OLD.buy_date, :OLD.buyno);
END;
-- 트리거 동작 테스트
DELETE FROM TBL_BUY tb WHERE CUSTOM_ID = 'wonder';
SELECT * FROM TBL_TEMP;



-- 추가 view 생성 연습
-- grant resource, connect to c##idev -> 여기에는 view 생성권한은 없습니다.
-- grant create view to c##idev; -> 뷰 생성권한 없는 오류 생기면 추가 권한 부여 하세요.
CREATE VIEW v_buy
AS
SELECT tb.CUSTOM_ID , tb.PCODE , tc.NAME , tc.EMAIL , tb.QUANTITY
FROM TBL_BUY tb , TBL_CUSTOM tc 
WHERE tb.CUSTOM_ID = tc.CUSTOM_ID ;







