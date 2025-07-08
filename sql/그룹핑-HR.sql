-- 그룹핑-HR.sql

SELECT * FROM EMPLOYEES; -- 107행

SELECT SUM(SALARY) FROM EMPLOYEES; -- 1행

-- FIRST_NAME 107개 행, SUM(SALARY)는 1개 행, 함께 조회 불가
-- SELECT FIRST_NAME, SUM(SALARY) FROM EMPLOYEES;

-- 결과 행의 수가 같으므로 조회 가능
SELECT 'HELLO', SUM(SALARY) FROM EMPLOYEES;
SELECT COUNT(*), SUM(SALARY) FROM EMPLOYEES;

SELECT 'HELLO' FROM DUAL; -- 1개 행
SELECT 'HELLO' FROM EMPLOYEES; -- 107개 행

-- SUM, AVG, COUNT, MAX, MIN 다중행 함수
SELECT
	SUM(SALARY) "급여 합",
	AVG(SALARY) "급여 평균",
	COUNT(SALARY) "직원수",
	MAX(SALARY) "최대 급여",
	MIN(SALARY) "최소 급여"
FROM 
	EMPLOYEES;

-- 결과 : 0, NULL의 수는 카운팅이 안됨
SELECT COUNT(MANAGER_ID) FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

-- 결과 : 1, 카운팅이 됨
SELECT COUNT(*) FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

-- 다중 행 함수를 WHERE절에 사용가능한가?
-- 사용 불가, WHERE는 FROM뒤의 테이블이나 뷰에서 한행씩 인출해서 조건을 비교
-- 그러므로 행이 여러개 필요한 다중행 함수는 WHERE절에 사용할 수 없음
--SELECT *
--FROM EMPLOYEES
--WHERE MAX(SALARY) > 1000;

-- 다중 행 함수와 GROUP BY에 사용된 컬럼은 함께 조회가 가능
-- 그룹핑된 결과의 수만큼 다중행 함수의 결과가 나오므로
SELECT SUM(SALARY), EMPLOYEE_ID
FROM EMPLOYEES
GROUP BY EMPLOYEE_ID;

SELECT SUM(SALARY), EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
GROUP BY EMPLOYEE_ID, FIRST_NAME;

-- 1) 부서별 직원 수와 부서별 월급 합계 (부서별로 그룹핑 => GROUP BY)
-- 2) 월급 합계가 50000이상인 부서 (그룹핑한 후 각 그룹에 대한 조건을 부여 => HAVING)
-- 3) 부서아이디가 없는 경우는 제외 (부서아이디가 없는 경우는 그룹핑 전에 제외 => WHERE)
-- 4) 월급합계가 많은 순으로 정렬 (부서별 월급합계게 대해 내림차순 정렬 => ORDER BY)
SELECT DEPARTMENT_ID, COUNT(*), SUM(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID
HAVING SUM(SALARY)>=50000
ORDER BY SUM(SALARY) DESC;




















