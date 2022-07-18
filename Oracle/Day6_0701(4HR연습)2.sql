-- HR ��Ű���� �̿��Ͽ� ���ΰ� group by �� �����ؼ� select ���� �˻��ϴ� ������ 10�� �����
-- group by ����ε� ������ �� �� �ֽ��ϴ�. ���� : �μ��ο��� ���帹�� �μ��� ? 5�� 30�б��� �����ϼ���.

-- �ּ����� �˻��ϴ� ���뾲��
-- select ���� �ۼ��ϼ���.

-- jobs ���̺�
-- 1) min_salary �÷��� 10000�̻��� Job_title ��ȸ
SELECT job_title FROM JOBS j WHERE MIN_SALARY >= 10000;
-- 2) job_title �÷��� programmer�� ���� ��� �÷� ��ȸ
SELECT * FROM JOBS j WHERE JOB_TITLE = 'programmer';
SELECT * FROM JOBS j WHERE JOB_TITLE = 'Programmer';
-- ��ҹ��� ������� ���� �˻��Ѵٸ� ���ڿ� ���� ����Ŭ �Լ� : upper(), lower() �̿��մϴ�.
SELECT * FROM JOBS j WHERE UPPER(JOB_TITLE) = 'PROGRAMMER';
SELECT * FROM JOBS j WHERE LOWER(JOB_TITLE) = 'programmer';
-- 3) max_salary �ʵ尪�� �÷��� �ִ밪 ��ȸ
SELECT MAX(max_salary) FROM JOBS j ; 

-- locations ���̺�
-- 1) city �÷��� London �� postal_code ��ȸ
SELECT postal_code FROM LOCATIONS l WHERE CITY = 'London';
SELECT postal_code FROM LOCATIONS l WHERE CITY = 'Seattle';
-- 2) LOCATIONAL_ID �÷��� 1700, 2700, 2500�� �ƴϰ� city �÷��� Tokyo�� ���� ��� �÷� ��ȸ
SELECT * FROM LOCATIONS l WHERE LOCATION_ID NOT IN (1700,2700,2500) AND CITY = 'Tokyo';

-- Jonathon Taylor �� �ٹ� �̷� Ȯ���ϱ�
SELECT * FROM EMPLOYEES e JOIN JOB_HISTORY jh ON e.EMPLOYEE_ID = jh.EMPLOYEE_ID 
AND FIRST_NAME = 'Jonathon' AND LAST_NAME = 'Taylor';

-- ����Լ�(���� �Լ�) : employees ���̺�
SELECT COUNT(*) FROM EMPLOYEES e ;		-- �Ѱ��� : 107
SELECT COUNT(*) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';		-- ���� job_id ���� �� : 5

SELECT AVG(salary) FROM EMPLOYEES e ;	-- ���� ��� �޿� : 6461.83
SELECT AVG(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';	-- ���� job_id ��� �޿� : 5760

SELECT MAX(salary) FROM EMPLOYEES e ;	-- ���� �� �ְ� �޿� : 24,000
SELECT MAX(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'; 	-- ���� job_id �ְ� �޿� : 9000

SELECT MIN(salary) FROM EMPLOYEES e ;	-- ���� �� �ּ� �޿� : 2,100
SELECT MIN(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'; 	-- ���� job_id �ּ� �޿� : 4200

-- �μ����̺�� �������̺� join
SELECT COUNT(*) FROM EMPLOYEES e2, DEPARTMENTS d2 WHERE e2.DEPARTMENT_ID = d2.DEPARTMENT_ID ;
SELECT COUNT(*) FROM EMPLOYEES e JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID ;

-- �μ��� 'Sales' �� ������ �ο� �� ��ȸ�ϱ�
SELECT COUNT(*) FROM EMPLOYEES e JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
AND department_name = 'Sales';

-- jobs ���̺� : min_salary �� ��պ��� ���� job�� ���� ����
SELECT AVG(min_salary) FROM JOBS j ;
SELECT job_id, job_title, min_salart FROM JOBS j 
WHERE MIN_SALARY < (SELECT AVG(MIN_SALARY) FROM JOBS j);

-- �Ʒ� ����� ���� -> �׷��Լ��� �ݵ�� SELECT ������ ����մϴ�. *
SELECT job_id, job_title, min_salary FROM JOBS j 
WHERE MIN_SALARY < AVG(MIN_SALARY);

-- ���� ���� �ʿ��� ���� : ������ ���Ը� ���
-- �ּұ޿��� �޴� ����� first_name, last_name �÷� ��ȸ�ϱ�
SELECT first_name, last_name, salary FROM EMPLOYEES e 
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG');

SELECT MIN(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';
-- job_id �� 'IT_PROG'�� �ƴ� �� ��ȸ
SELECT MIN(salary) FROM EMPLOYEES e WHERE JOB_ID <> 'IT_PROG';
SELECT MIN(salary) FROM EMPLOYEES e WHERE NOT JOB_ID = 'IT_PROG';	-- ** 

-- �μ��� ��� �޿��� ��ȸ�մϴ�. ������ ��� �޿� ������������ �μ�_ID, �μ���, ��ձ޿� (�Ҽ��� 1�ڸ��� �ݿø�)
-- ����Ŭ �Ҽ��� ���� �Լ� : round(�ݿø�), trunc(����), ceil(����)

-- �׷��Լ� ��ȸ�Ҷ� group by�� ��� �׷���̿� �� �÷��� SELECT �� ��ȸ�� �� �ֽ��ϴ�.
-- �׷���� �÷��ܿ��� �ٸ� �÷� select �� �� �����ϴ� -> JOIN , ��������
-- 1�ܰ� : ����� �׷��Լ� �����ϱ�
SELECT department_id, AVG(salary) FROM EMPLOYEES e GROUP BY DEPARTMENT_ID ;

-- 2�ܰ� : �����ϱ�
SELECT * FROM DEPARTMENTS d JOIN
(SELECT DEPARTMENT_ID, AVG(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
ON d.DEPARTMENT_ID = tavg.department_id;

-- 3�ܰ� : �÷� �����ϱ�
SELECT d.department_id, d.department_name, ROUND(tavg.cavg,1) FROM DEPARTMENTS d  
JOIN (SELECT DEPARTMENT_ID, AVG(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
ON d.DEPARTMENT_ID = tavg.department_id
ORDER BY tavg.cavg DESC ;

-- 4�ܰ� : ������ ����� Ʋ�� ��ġ ���� : first n�� ���� n���� ��ȸ.
SELECT d.department_id, d.department_name, ROUND(tavg.cavg,1) "��ձ޿�" FROM DEPARTMENTS d 
JOIN (SELECT DEPARTMENT_ID, AVG(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
ON d.DEPARTMENT_ID = tavg.department_id
ORDER BY tavg.cavg DESC 
FETCH FIRST 1 ROWS ONLY ;

-- �ٸ� ����
SELECT d.department_id did, d.department_name, e.cnt
FROM DEPARTMENTS d 
JOIN (SELECT DEPARTMENT_ID, COUNT(*) cnt FROM EMPLOYEES GROUP BY DEPARTMENT_ID) e
ON d.DEPARTMENT_ID = e.department_id
ORDER BY cnt DESC 
FETCH FIRST 1 ROWS ONLY;

-- ����Ŭ�� rownum�� ������ �ӽ��÷����� ��ȸ�� ����� ���������� ����Ŭ�� �ο��ϴ� ���Դϴ�. ���� �÷� ����� ���� join�� �ѹ� �� �ʿ��մϴ�.
SELECT rownum, tcnt.* FROM
(SELECT DEPARTMENT_ID , count(*) cnt FROM EMPLOYEES 
	GROUP BY DEPARTMENT_ID ORDER BY cnt DESC) tcnt
	WHERE rownum < 5;

SELECT rownum, tcnt.* FROM
(SELECT DEPARTMENT_ID , count(*) cnt FROM EMPLOYEES 
	GROUP BY DEPARTMENT_ID ORDER BY cnt DESC) tcnt
	WHERE rownum = 1;

-- rownum ����� �� ��� Ȯ���� �ȵǴ� ���� : rownum 1���� �����ؼ� ã�ư� �� �ִ� ���ǽĸ� ����.
-- where rownum = 3;
-- where rownum > 5;
-- �׷��� �ѹ� �� ROWNUM �� ������ ��ȸ ����� SELECT �� �մϴ�. �̶� ROWNUM �� �ܸ� �ο�.

SELECT * FROM 
	(SELECT rownum rn, tcnt.* FROM
		(SELECT DEPARTMENT_ID , count(*) cnt FROM EMPLOYEES 
			GROUP BY DEPARTMENT_ID ORDER BY cnt DESC) tcnt)
WHERE rn BETWEEN 5 AND 9;
--	WHERE rn = 3;












