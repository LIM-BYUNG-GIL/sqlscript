-- DDL : create, alter, drop, truncate
-- (����� user, table, sequence, view, ... �� truncate �� ���̺� ���)
-- DML : insert, update, delete, select -> Ʈ��������� �����˴ϴ�.

DROP TABLE students0;	-- ���� : students0 ���̺� ���� �����ϸ�
						-- ���� : �ܷ� Ű�� ���� �����Ǵ� ����/�⺻ Ű�� ���̺� �ֽ��ϴ�
DROP TABLE scores0;

-- UPDATE ���̺�� SET �÷��� = ��,�÷��� = ��,�÷��� = ��,... WHERE �����÷� �����
-- DELETE FROM ���̺�� WHERE �����÷������
-- ������ �� : UPDATE �� DELETE �� WHERE ���� ����ϴ� ���� ������ ����.
-- TRUNCATE �� ������ ���(rollback) �� �� ���� ������ DDL�� ���մϴ�.

SELECT * FROM STUDENTS0 s ;
-- UPDATE, DELETE, SELECT ���� WHERE �� �÷��� �⺻Ű �÷����� ���������̸� ����Ǵ� ����� �ݿ��Ǵ� ���� ��ϱ�� ? �ִ� 1��;
-- �⺻Ű�� ������ ���̺��� ��������� ����(�ĺ�)
UPDATE STUDENTS0 SET age = 17 WHERE STUNO  = 2021001;

-- rollback, commit �׽�Ʈ (�����ͺ��̽� �޴����� Ʈ����� ��带 manual�� �����մϴ�.)
-- ������� �����ϼ���.
UPDATE STUDENTS0 SET ADDRESS = '���ϱ�', AGE  = 16 WHERE STUNO = 2021001;
ROLLBACK;	-- ���� UPDATE ������ ���
SELECT * FROM STUDENTS0;	-- �ٽ� '���ʱ�', 17���� ����
UPDATE STUDENTS0 SET ADDRESS = '���ϱ�', AGE  = 16 WHERE STUNO = 2021001;
COMMIT;
SELECT * FROM STUDENTS0;	-- '���ϱ�', 16���� �ݿ���.
ROLLBACK;
SELECT * FROM STUDENTS0;	-- �̹� COMMIT�� �� ��ɾ�� ROLLBACK ����.
------------------------------ �������
-- Ʈ����� ���� ��� : rollback, commit

DELETE FROM SCORES0;
ROLLBACK;
SELECT * FROM SCORES0;
DELETE FROM SCORES0 WHERE STUNO = 2019019;
SELECT * FROM SCORES0;
-- 37���α��� ����������
-- �� ������� Ʈ����� ���� ����̰� ���� â������ SELECT ��� 2019019�� �����ϴ�.
-- �ٸ� ������� �ٸ� Ŭ���̾�Ʈ �̹Ƿ� ���� ����(���� Ŀ���� ����)�� �������ϴ�.
ROLLBACK;
SELECT * FROM SCORES0;

-------------------------------------------------- ������� �ι�° ����
TRUNCATE TABLE SCORES0;	       					-- ��� �����͸� ����ϴ�. ROLLBACK ���� Ȯ�� ? 
												-- �� : rollback �Ұ�.
-- ��� �����͸� ���� ���� Ȯ���ϸ� �ٸ� �͵�� ������ �ѹ���� �ʰ� Ȯ���ϰ� TRUNCATE �ض�.
--------------------------------------------------
/*
 * INSERT
 * DELETE
 * COMMIT;		(1)
 * UPDATE
 * DELETE;
 * ROLLBACK;	(2)
 * INSERT;
 * INSERT;
 * ROLLBACK;	(3)
 * INSERT
 * UPDATE;
 * COMMIT;		(4)
 */
