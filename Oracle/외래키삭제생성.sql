-- tbl_custom �����ϴ� �ܷ�Ű ����
ALTER TABLE TBL_BUY DROP CONSTRAINT FK1_BUY;
-- on delete �ɼ����� �ٽ� �ܷ�Ű ����
ALTER TABLE TBL_BUY ADD CONSTRAINT fk_cutom_id
	FOREIGN KEY (custom_id)		-- tbl_buy ���̺��� �÷�
	REFERENCES tbl_custom(custom_id)	-- tbl_custom ���� ���̺� �÷� custom_id
ON DELETE CASCADE;

ROLLBACK;