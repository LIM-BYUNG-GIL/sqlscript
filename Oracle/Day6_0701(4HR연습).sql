-- HR 스키마를 이용하여 조인과 group by 를 포함해서 select 으로 검색하는 문제를 10개 만들기
-- group by 결과로도 조인을 할 수 있습니다. 예시 : 부서인원이 가장많은 부서는 ? 5시 30분까지 제출하세요.

-- 주석으로 검색하는 내용쓰고
-- select 쿼리 작성하세요.


SELECT JOB_ID, max(MAX_SALARY) FROM JOBS j GROUP BY JOB_ID ;