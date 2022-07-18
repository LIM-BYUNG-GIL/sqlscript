-- 0715_문제 3
-- 작성자 : 임병길

INSERT INTO TBL_POSTCODE (postcode,area1)
VALUES (137964,'서울특별시 서초구 서초2동');
INSERT INTO TBL_POSTCODE (postcode,area1)
VALUES (138761,'서울특별시 송파구 장지동 409880');
INSERT INTO TBL_POSTCODE (postcode,area1)
VALUES (412510,'경기도 고양시 덕양구 벽제동');
INSERT INTO TBL_POSTCODE (postcode,area1)
VALUES (409880,'인천광역시 옹진군 자월면');

UPDATE "TBL_CUSTOM#" SET postcode = 137964 WHERE custom_id = 'mina012';
UPDATE "TBL_CUSTOM#" SET postcode = 412510 WHERE custom_id = 'hongGD';
UPDATE "TBL_CUSTOM#" SET postcode = 409880 WHERE custom_id = 'wonder';
UPDATE "TBL_CUSTOM#" SET postcode = 138761 WHERE custom_id = 'sana';

CREATE VIEW v_custom_info
AS
SELECT tc.CUSTOM_ID, tp.postcode, tp.area1
FROM tbl_postcode tp, tbl_custom# tc
WHERE tc.postcode = tp.postcode;

SELECT * FROM V_CUSTOM_INFO;
