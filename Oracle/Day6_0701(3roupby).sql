-- ���� : ���� �׷�ȭ �մϴ�.
-- SELECT ��
-- [WHERE] �׷�ȭ �ϱ� ���� ����� ���ǽ�
-- GROUP BY �׷�ȭ�� ����� �÷���
-- [HAVING] �׷�ȭ ����� ���� ���ǽ�
-- [ORDER BY] �׷�ȭ ��� ������ �÷���� ���


SELECT PCODE, COUNT(*) FROM TBL_BUY tb GROUP BY PCODE ;
SELECT PCODE, COUNT(*), SUM(QUANTITY)
	FROM TBL_BUY tb
	GROUP BY PCODE
	ORDER BY 2;		-- ��ȸ�� �÷��� ��ġ

SELECT PCODE, COUNT(*) cnt, SUM(QUANTITY) total
	FROM TBL_BUY tb
	GROUP BY PCODE
	ORDER BY cnt;		-- �׷��Լ� ����� ��Ī

-- �׷�ȭ �Ŀ� �����հ谡 3 �̻� ��ȸ
SELECT PCODE, COUNT(*) cnt, SUM(QUANTITY) total
	FROM TBL_BUY tb
	GROUP BY PCODE
--	HAVING total >= 3	-- HAVING ���� �÷� ��Ī ��� ����. ���̺��÷����� ����� �� ����.
	HAVING sum(QUANTITY) >= 3
	ORDER BY cnt;		-- �׷��Լ� ����� ��Ī	

-- ���ų�¥ 2022-04-01 ������ �͸� �׷��Ͽ� ��ȸ
SELECT PCODE, COUNT(*) cnt, SUM(QUANTITY) total
	FROM TBL_BUY tb
	WHERE BUY_DATE >= '2022-04-01'
	GROUP BY PCODE
	ORDER BY cnt;
	
	
	

-- DAY2 ����
-- ��� �Լ� : count, avg, max, min, sum ����Լ��� �׷��Լ���� �մϴ�.
--			�ش� �Լ� ������� ���ϱ� ���� Ư�� �÷� ����Ͽ� ���� �����͸� �׷�ȭ�� �� ����

SELECT COUNT(*) FROM EMPLOYEES e ;		-- ���̺� ��ü ������ ���� :�� 107
SELECT MAX(salary) FROM EMPLOYEES e ;	-- salary �÷��� �ִ� : 24000
SELECT MIN(salary) FROM EMPLOYEES e ;	--				�ּڰ� : 2100
SELECT AVG(salary) FROM EMPLOYEES e ;	--				��հ� : 6461.83...
SELECT SUM(salary) FROM EMPLOYEES e ;	--				�հ� : 691416


-- �� 5�� ����Լ��� JOB_ID = 'IT_PROG' ���� ���ǽ����� �Ȱ��� �����غ���
SELECT COUNT(*) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'; -- 5
SELECT MAX(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';	-- 9000
SELECT MIN(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';	-- 4200
SELECT AVG(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';	-- 5760
SELECT SUM(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';	-- 28800

-- ����Լ� ����� �ٸ� �÷����� ���� ��ȸ ���մϴ�. (�׷��Լ��̱� �����Դϴ�.)
SELECT JOB_ID, COUNT(*) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'; -- ���� : ���� �׷��� �׷� �Լ��� �ƴմϴ�.