-- 0715_���� 3
-- �ۼ��� : �Ӻ���

INSERT INTO TBL_POSTCODE (postcode,area1)
VALUES (137964,'����Ư���� ���ʱ� ����2��');
INSERT INTO TBL_POSTCODE (postcode,area1)
VALUES (138761,'����Ư���� ���ı� ������ 409880');
INSERT INTO TBL_POSTCODE (postcode,area1)
VALUES (412510,'��⵵ ���� ���籸 ������');
INSERT INTO TBL_POSTCODE (postcode,area1)
VALUES (409880,'��õ������ ������ �ڿ���');

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
