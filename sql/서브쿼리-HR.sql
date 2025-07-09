-- 서브쿼리-HR.sql
-- 서브쿼리 : 메인쿼리 안에 사용되는 쿼리, 쿼리의 결과를 메인쿼리에 사용하기 위한 쿼리

-- 단일행 서브쿼리 (SINGLE ROW SUM QUERY)
-- 서브쿼리의 결과가 한 행

-- 입사일이 149번 직원의 입사일보다 빠른 직원들의 정보를 조회
SELECT *
FROM EMPLOYEES
WHERE HIRE_DATE < (
	SELECT HIRE_DATE 
	FROM EMPLOYEES 
	WHERE EMPLOYEE_ID = 149
);

-- 다중행 서브쿼리 (MULTI ROW SUB QUERY)
-- 서브쿼리의 결과가 여러 행으로 조회

-- 부서별로 최고 급여에 해당하는 급여를 받는 직원들의 정보를 조회
SELECT *
FROM EMPLOYEES
WHERE SALARY IN (
	SELECT MAX(SALARY)
	FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID
);

SELECT *
FROM EMPLOYEES
WHERE SALARY = ANY (
	SELECT MAX(SALARY)
	FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID
);

SELECT *
FROM EMPLOYEES
WHERE SALARY = SOME (
	SELECT MAX(SALARY)
	FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID
);

-- 실습 1) 30번 부서 직원들의 최대 급여보다 적은 급여를 받는 직원 조회
SELECT *
FROM EMPLOYEES
WHERE SALARY < (
	SELECT MAX(SALARY)
	FROM EMPLOYEES
	WHERE DEPARTMENT_ID = 30
);


-- 실습 2) 30번 부서 직원들의 최소 급여보다 많은 급여를 받는 직원 조회
SELECT *
FROM EMPLOYEES
WHERE SALARY > (
	SELECT MIN(SALARY)
	FROM EMPLOYEES
	WHERE DEPARTMENT_ID = 30
);

SELECT *
FROM EMPLOYEES
WHERE SALARY > ALL (
	SELECT MIN(SALARY)
	FROM EMPLOYEES
	WHERE DEPARTMENT_ID = 30
);

-- 서브쿼리의 결과가 존재하면 메인쿼리를 수행
SELECT *
FROM EMPLOYEES
WHERE EXISTS (
	SELECT * FROM DUAL
	WHERE 1 = 0 -- 무조건 FALSE인 조건
);

SELECT *
FROM EMPLOYEES
WHERE EXISTS (
	SELECT * FROM DUAL
	WHERE 1 = 1 -- 무조건 FALSE인 조건
);

-- 다중열 서브쿼리 (MULTI COLUMN SUB QUERY)
-- 서브쿼리 결과가 일부 컬럼의 조합으로 조회되는 서브쿼리

-- 부서별로 최대 급여를 받는 직원 정보 조회
SELECT *
FROM EMPLOYEES
WHERE (DEPARTMENT_ID, SALARY) IN (
	SELECT DEPARTMENT_ID, MAX(SALARY)
	FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID	
);

-- INLINE VIEW
-- FROM 뒤에 사용하는 서브쿼리
-- 서브 쿼리의 조회 결과를 토대로 다시 조회할 때 사용
SELECT *
FROM (
	SELECT *
	FROM EMPLOYEES
	WHERE DEPARTMENT_ID = 30
);

-- ROWID, ROWNUM
-- ROWID : 오라클이 제공하는 조회된 행에 자동으로 부여되는 아이디
-- ROWNUM : 오라클이 제공하는 조회된 행에 자동으로 부여되는 번호, 1번부터 시작

SELECT ROWID, ROWNUM FROM EMPLOYEES;

-- TOP-N QUERY : 상위 N개를 조회하는 쿼리

-- 50번 부서 직원 중 조회순으로 상위 10명의 직원 정보 조회
SELECT ROWNUM, E.*
FROM (
	SELECT *
	FROM EMPLOYEES
	WHERE DEPARTMENT_ID = 50
) E
WHERE ROWNUM < 11;

-- 실습 : 50번 부서 직원 중 조회순으로 3번째에서 5번째의 직원 정보 조회
-- 1) 제일 안쪽의 서브쿼리에서 부서ID가 50인 행들을 조회
-- 2) 중간 서브쿼리에서 상위 5개 번호를 매김
-- 3) 메인 쿼리에서 중간 서브쿼리가 매겨놓은 번호를 사용

SELECT *
FROM (
	SELECT ROWNUM RN, E.*
	FROM (
		SELECT *
		FROM EMPLOYEES
		WHERE DEPARTMENT_ID = 50
	) E
	WHERE ROWNUM <= 5
)
WHERE RN >= 3;

-- 오라클 12c 버전 이상에서는 FETCH FIRST / OFFSET 사용
-- SELECT *
-- FROM EMPLOYEES
-- WHERE DEPARTMENT_ID = 50
-- OFFSET 2 ROWS FETCH NEXT 3 ROWS ONLY;











