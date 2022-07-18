/*
 * [[[[	'�����뿩' ó�� ����	]]]]
 * - ȸ���� �Ϸ翡 1���� å�� �뿩�� �� �ִ�.
 * - �뿩�Ѵ�. : rent_date �� �뿩����, exp_date �� �ݳ����������̸� rent_date + 14
 * - �ݳ��Ѵ�. : return date �� �ݳ�����, delay_days �� ��ü�ϼ� return date - exp_date
 * - return_date �� null �̸� �뿩��, null �� �ƴϸ� �ݳ��� ����.
 */

-- 1) ������ �߰��մϴ�. 'B1102', '��Ʈ����ũ ������', '��ö��', 'KBO', '2020-11-10'
INSERT INTO TBL_BOOK (bcode,title,writer,publisher,pdate)
VALUES ('B1102','��Ʈ����ũ ������','��ö��','KBO','2020-11-10');

-- 2) �ݳ��� ������ ��ü�ϼ��� ����Ͽ� delay_days �÷����� update �մϴ�.
UPDATE TBL_BOOKRENT SET delay_days = return_date - exp_date
WHERE RETURN_date IS NOT NULL;
SELECT * FROM TBL_BOOKRENT ;

-- 3) ���� ���� ���� ������ ��ü�ϼ� ����ؼ� ȸ��IDX, �����ڵ�, ��ü �ϼ� ��ȸ�ϱ�.
-- ���� ��¥ sysdate �� ����� ������ �������� �ʾ� �׳��ϸ� long ������ ���˴ϴ�.
SELECT mem_idx, bcode, to_date(to_char(sysdate,'yyyy-MM-dd')) - exp_date
FROM TBL_BOOKRENT WHERE RETURN_date IS NULL;
-- �Ǵ�
SELECT mem_idx, bcode, trunc(sysdate) - EXP_date	-- trunc(sysdate) �� sysdate �� �ð��κ��� �����ϴ�.
FROM TBL_BOOKRENT WHERE return_date IS NULL;

-- 4) ���� ���� ���� ���� �� ��ü�� ȸ���� �̸�, ��ȭ��ȣ�� �˻��մϴ�. ���� ��¥ sysdate �������� Ȯ���ϱ�.!
-- ���� �������� ��ü ���� ���� �ݳ����� < ���糯¥
SELECT name, tel FROM BOOK_MEMBER bm JOIN TBL_BOOKRENT tb
ON tm.mem_idx = tb.mem_idx AND SYSDATE > EXP_date AND RETURN_date IS NULL;

-- 5) ���� �������� ������ �������ڵ�� ������ �˻��մϴ�.
SELECT tb.bcode, title FROM TBL_BOOK tb JOIN TBL_BOOKRENT tb2
ON tb.bcode = tb2.bcode AND RETURN_date IS NULL;

-- 6) ���� ������ �뿩�� ȸ���� IDX�� ȸ���̸��� �˻��մϴ�.
SELECT bm.mem_idx, name FROM BOOK_MEMBER bm JOIN TBL_BOOKRENT tb
ON bm.mem_idx = tb.mem_idx AND return_date IS NULL;

-- 7) �������� ������ ȸ���̸�, ������, �ݳ����� �˻��մϴ�. -> DM���� �����ּ���.
SELECT bm.name, tb.title, tb2.exp_date
FROM BOOK_MEMBER bm, TBL_BOOK tb, TBL_BOOKRENT tb2
WHERE bm.mem_idx = tb2.mem_idx AND tb.bcode = tb2.bcode
AND tb2.return_date IS NULL;

-- �Ǵ�
SELECT name, title, exp_date FROM TBL_BOOKRENT tb
JOIN TBL_BOOK tb2 ON tb2.bcode = tb.bcode
JOIN BOOK_MEMBER bm ON tb.mem_idx = bm.mem_idx
WHERE return_date IS NULL;

-- 8) ���� ��ü ���� ������ ȸ��IDX, �����ڵ�, �ݳ������� �˻��մϴ�.
SELECT mem_idx, bcode, exp_date FROM TBL_BOOKRENT 
WHERE SYSDATE > exp_date;

-- 9) ȸ�� IDX '10002'�� ���� ������ �������� ���ν����� �ۼ��մϴ�.

DECLARE 
	vcnt NUMBER;
BEGIN 

	SELECT count(*) INTO vcnt
	FROM TBL_BOOKRENT tb
	WHERE mem_idx = 10001 AND return_date IS NULL;		-- vcnt �� 0�϶��� �뿩����
	IF (vcnt = 0) THEN 
		dbms_output.put_line('å �뿩 �����մϴ�.');
	ELSE 
		dbms_output.put_line('�뿩 ���� å�� �ݳ��ؾ� �����մϴ�.');
	END IF;
END;

-- ���ν��� ����Ŭ ��ü
CREATE OR REPLACE PROCEDURE check_member(
	arg_mem IN book_member.mem_idx%TYPE,	-- ���ν��� ������ �� ���� ���� �Ű�����
	isOK OUT varchar2		-- �ڹ��� ���ϰ��� �ش��ϴ� �κ�.
)
IS 
	vcnt NUMBER;
	vname varchar2(100);
BEGIN 
	-- �Է� �Ű������� ���� ȸ���ΰ��� Ȯ���ϴ� sql�� exception ó��. arg_mem���� ȸ�����̺��� name��ȸ
	-- ������ exception ó��
	SELECT name	INTO vname
		FROM BOOK_MEMBER bm WHERE MEM_IDX = arg_mem;
	
	SELECT count(*)
	INTO vcnt
	FROM TBL_BOOKRENT tb
	WHERE mem_idx = arg_mem AND return_date IS NULL;		-- vcnt �� 0�϶��� �뿩����
	IF (vcnt = 0) THEN 
		dbms_output.put_line('å �뿩 �����մϴ�.');
		isOK := '����';
	ELSE 
		dbms_output.put_line('�뿩 ���� å�� �ݳ��ؾ� �����մϴ�.');
		isOK := '�Ұ���';
	END IF;
	EXCEPTION 
	WHEN no_data_found THEN
		dbms_output.put_line('ȸ���� �ƴմϴ�.');
		isOK := 'no match';
END;

-- ���ν��� �����ϱ�
DECLARE
	vresult varchar(20);
BEGIN 
	check_member(10003,vresult);
	dbms_output.put_line('��� : ' || vresult);
END;


-- 10) ������ '�н�Ʈ'��� ������ ������ �������� ���ν����� �ۼ��մϴ�.
DECLARE
	v_bcode varchar2(100);
	v_cnt NUMBER;
BEGIN 
	SELECT bcode INTO v_bcode		-- v_bcode�� 'A1102'
		FROM TBL_BOOK tb WHERE title = '�н�Ʈ';
	SELECT count(*) INTO v_cnt		-- v_cnt ���� 1�̸� v_bcode å�� ������ ?
		FROM TBL_BOOKRENT tb2 WHERE bcode = v_bcode AND return_date IS NULL;
	IF (v_cnt = 1) THEN
		dbms_output.put_line('�뿩 ���� å�Դϴ�.');
	ELSE 
		dbms_output.put_line('å �뿩 �����մϴ�.');
	END IF;
END;


-- 11) 9�� 10�� �̿��ؼ� insert �� �ϴ� ���ν����� �ۼ��մϴ�.

-- ���ν��� ����Ŭ ��ü
CREATE OR REPLACE PROCEDURE check_book(
		arg_book IN tbl_book.title%TYPE,	-- ���ν��� ������ �� ���� ���� �Ű�����
		isOK OUT varchar2		-- �ڹ��� ���ϰ��� �ش��ϴ� �κ�.
	)
	IS
	v_bcode varchar2(100);
	v_cnt NUMBER;
BEGIN
	SELECT bcode INTO v_bcode		-- v_bcode �� 'A1102'
		FROM TBL_BOOK tb WHERE title = arg_book;
	-- ���� å �Է��ϸ� 
	SELECT count(*) INTO v_cnt		-- v_cnt ���� 1�̸� v_bcode å�� ���� ��
		FROM TBL_BOOKRENT tb2 WHERE bcode = v_bcode AND return_date IS NULL;
	IF (v_cnt = 1) THEN
		dbms_output.put_line('�뿩 ���� å �Դϴ�.');
		isOK := 'FALSE';
	ELSE
		dbms_output.put_line('å �뿩 �����մϴ�.');
		isOK := 'TRUE';
	END IF;
	EXCEPTION		-- ����(����)ó��
	WHEN no_data_found THEN
		dbms_output.put_line('ã�� å�� �����ϴ�.');
		isOK := 'no match';

	-- ���� å�� isOK := 'no match';
END;

-- ���ν��� �����ϱ�
	DECLARE
		vresult varchar2(100);
	BEGIN
		check_book('Ǫ������',vresult);		-- �ڽ���, Ǫ������ �ʹϴ� �� FALSE
		dbms_output.put_line('��� : ' || vresult);
	END;









