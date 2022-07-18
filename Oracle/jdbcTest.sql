INSERT INTO tbl_buy(custom_id, PCODE, QUANTITY, BUYNO)
VALUES ('sana97', 'GALAXYS22', 1, tblbuy_seq.nextval);

SELECT * FROM TBL_BUY tb ;


--- commit과 rollback 테스트 ---
-- 회원의 구매 내역 삭제
DELETE FROM TBL_BUY tb WHERE CUSTOM_ID = 'twice';
DELETE FROM TBL_CUSTOM tc WHERE CUSTOM_ID = 'twice';

SELECT * FROM TBL_CUSTOM tc ;
SELECT * FROM TBL_BUY tb ;
ROLLBACK;



--

SELECT * FROM TBL_CUSTOM tc ;

SELECT name, email FROM TBL_CUSTOM tc WHERE CUSTOM_ID = 'twice';

ALTER TRIGGER secure_custom disable;
UPDATE TBL_CUSTOM SET EMAIL = 'test@gmail.com'
WHERE CUSTOM_ID = 'twice';

SELECT * FROM TBL_CUSTOM tc ;