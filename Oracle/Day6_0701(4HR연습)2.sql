-- HR 스키마를 이용하여 조인과 group by 를 포함해서 select 으로 검색하는 문제를 10개 만들기
-- group by 결과로도 조인을 할 수 있습니다. 예시 : 부서인원이 가장많은 부서는 ? 5시 30분까지 제출하세요.

-- 주석으로 검색하는 내용쓰고
-- select 쿼리 작성하세요.

-- jobs 테이블
-- 1) min_salary 컬럼이 10000이상인 Job_title 조회
SELECT job_title FROM JOBS j WHERE MIN_SALARY >= 10000;
-- 2) job_title 컬럼이 programmer인 행의 모든 컬럼 조회
SELECT * FROM JOBS j WHERE JOB_TITLE = 'programmer';
SELECT * FROM JOBS j WHERE JOB_TITLE = 'Programmer';
-- 대소문자 상관없이 조건 검색한다면 문자열 관련 오라클 함수 : upper(), lower() 이용합니다.
SELECT * FROM JOBS j WHERE UPPER(JOB_TITLE) = 'PROGRAMMER';
SELECT * FROM JOBS j WHERE LOWER(JOB_TITLE) = 'programmer';
-- 3) max_salary 필드값의 컬럼의 최대값 조회
SELECT MAX(max_salary) FROM JOBS j ; 

-- locations 테이블
-- 1) city 컬럼이 London 인 postal_code 조회
SELECT postal_code FROM LOCATIONS l WHERE CITY = 'London';
SELECT postal_code FROM LOCATIONS l WHERE CITY = 'Seattle';
-- 2) LOCATIONAL_ID 컬럼이 1700, 2700, 2500이 아니고 city 컬럼이 Tokyo인 행의 모든 컬럼 조회
SELECT * FROM LOCATIONS l WHERE LOCATION_ID NOT IN (1700,2700,2500) AND CITY = 'Tokyo';

-- Jonathon Taylor 의 근무 이력 확인하기
SELECT * FROM EMPLOYEES e JOIN JOB_HISTORY jh ON e.EMPLOYEE_ID = jh.EMPLOYEE_ID 
AND FIRST_NAME = 'Jonathon' AND LAST_NAME = 'Taylor';

-- 통계함수(집계 함수) : employees 테이블
SELECT COUNT(*) FROM EMPLOYEES e ;		-- 총개수 : 107
SELECT COUNT(*) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';		-- 조건 job_id 직원 수 : 5

SELECT AVG(salary) FROM EMPLOYEES e ;	-- 직원 평균 급여 : 6461.83
SELECT AVG(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';	-- 조건 job_id 평균 급여 : 5760

SELECT MAX(salary) FROM EMPLOYEES e ;	-- 직원 중 최고 급여 : 24,000
SELECT MAX(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'; 	-- 조건 job_id 최고 급여 : 9000

SELECT MIN(salary) FROM EMPLOYEES e ;	-- 직원 중 최소 급여 : 2,100
SELECT MIN(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG'; 	-- 조건 job_id 최소 급여 : 4200

-- 부서테이블과 직원테이블 join
SELECT COUNT(*) FROM EMPLOYEES e2, DEPARTMENTS d2 WHERE e2.DEPARTMENT_ID = d2.DEPARTMENT_ID ;
SELECT COUNT(*) FROM EMPLOYEES e JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID ;

-- 부서명 'Sales' 의 직원들 인원 수 조회하기
SELECT COUNT(*) FROM EMPLOYEES e JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
AND department_name = 'Sales';

-- jobs 테이블 : min_salary 가 평균보다 작은 job에 대한 정보
SELECT AVG(min_salary) FROM JOBS j ;
SELECT job_id, job_title, min_salart FROM JOBS j 
WHERE MIN_SALARY < (SELECT AVG(MIN_SALARY) FROM JOBS j);

-- 아래 명령은 오류 -> 그룹함수는 반드시 SELECT 문으로 사용합니다. *
SELECT job_id, job_title, min_salary FROM JOBS j 
WHERE MIN_SALARY < AVG(MIN_SALARY);

-- 서브 쿼리 필요한 예시 : 동일한 테입르 대상
-- 최소급여를 받는 사람의 first_name, last_name 컬럼 조회하기
SELECT first_name, last_name, salary FROM EMPLOYEES e 
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG');

SELECT MIN(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';
-- job_id 가 'IT_PROG'가 아닌 것 조회
SELECT MIN(salary) FROM EMPLOYEES e WHERE JOB_ID <> 'IT_PROG';
SELECT MIN(salary) FROM EMPLOYEES e WHERE NOT JOB_ID = 'IT_PROG';	-- ** 

-- 부서별 평균 급여를 조회합니다. 정렬은 평균 급여 내림차순으로 부서_ID, 부서명, 평균급여 (소수점 1자리로 반올림)
-- 오라클 소수점 관련 함수 : round(반올림), trunc(버림), ceil(내림)

-- 그룹함수 조회할때 group by를 써야 그룹바이에 쓴 컬럼을 SELECT 로 조회할 수 있습니다.
-- 그룹바이 컬럼외에는 다른 컬럼 select 할 수 없습니다 -> JOIN , 서브쿼리
-- 1단계 : 사용할 그룹함수 실행하기
SELECT department_id, AVG(salary) FROM EMPLOYEES e GROUP BY DEPARTMENT_ID ;

-- 2단계 : 조인하기
SELECT * FROM DEPARTMENTS d JOIN
(SELECT DEPARTMENT_ID, AVG(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
ON d.DEPARTMENT_ID = tavg.department_id;

-- 3단계 : 컬럼 지정하기
SELECT d.department_id, d.department_name, ROUND(tavg.cavg,1) FROM DEPARTMENTS d  
JOIN (SELECT DEPARTMENT_ID, AVG(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
ON d.DEPARTMENT_ID = tavg.department_id
ORDER BY tavg.cavg DESC ;

-- 4단계 : 정렬한 결과로 틀정 위치 지정 : first n은 상위 n개를 조회.
SELECT d.department_id, d.department_name, ROUND(tavg.cavg,1) "평균급여" FROM DEPARTMENTS d 
JOIN (SELECT DEPARTMENT_ID, AVG(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
ON d.DEPARTMENT_ID = tavg.department_id
ORDER BY tavg.cavg DESC 
FETCH FIRST 1 ROWS ONLY ;

-- 다른 예시
SELECT d.department_id did, d.department_name, e.cnt
FROM DEPARTMENTS d 
JOIN (SELECT DEPARTMENT_ID, COUNT(*) cnt FROM EMPLOYEES GROUP BY DEPARTMENT_ID) e
ON d.DEPARTMENT_ID = e.department_id
ORDER BY cnt DESC 
FETCH FIRST 1 ROWS ONLY;

-- 오라클의 rownum은 가상의 임시컬럼으로 조회된 결과에 순차적으로 오라클이 부여하는 값입니다. 가상 컬럼 사용을 위해 join이 한번 더 필요합니다.
SELECT rownum, tcnt.* FROM
(SELECT DEPARTMENT_ID , count(*) cnt FROM EMPLOYEES 
	GROUP BY DEPARTMENT_ID ORDER BY cnt DESC) tcnt
	WHERE rownum < 5;

SELECT rownum, tcnt.* FROM
(SELECT DEPARTMENT_ID , count(*) cnt FROM EMPLOYEES 
	GROUP BY DEPARTMENT_ID ORDER BY cnt DESC) tcnt
	WHERE rownum = 1;

-- rownum 사용할 때 결과 확인이 안되는 예시 : rownum 1부터 시작해서 찾아갈 수 있는 조건식만 가능.
-- where rownum = 3;
-- where rownum > 5;
-- 그래서 한번 더 ROWNUM 을 포함한 조회 결과로 SELECT 를 합니다. 이때 ROWNUM 은 볓링 부여.

SELECT * FROM 
	(SELECT rownum rn, tcnt.* FROM
		(SELECT DEPARTMENT_ID , count(*) cnt FROM EMPLOYEES 
			GROUP BY DEPARTMENT_ID ORDER BY cnt DESC) tcnt)
WHERE rn BETWEEN 5 AND 9;
--	WHERE rn = 3;












