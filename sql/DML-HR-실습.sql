-- DML-HR-실습.sql

-- 1) LOCATIONS 테이블의 모든 행을 조회
SELECT * FROM LOCATIONS;

-- 2) DEPARTMENTS 테이블의 부서아이디와 부서명을 조회
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS;

-- 3) EMPLOYEES 테이블의 모든 행의 수를 ROWCOUNT라는 컬럼명으로 조회
SELECT COUNT(*) AS ROWCOUNT
FROM EMPLOYEES;

-- 4) DEPARTMENTS 테이블에서 부서아이디가 100이상인 행을 조회
SELECT *
FROM DEPARTMENTS
WHERE DEPARTMENT_ID >= 100;

-- 5) DEPARTMENTS 테이블에서 MANAGER_ID가 존재하는 행을 조회
SELECT *
FROM DEPARTMENTS
WHERE MANAGER_ID IS NOT NULL;

-- 6) (1+2)*(3+4)의 연산 결괄르 RESULT라는 컬럼명으로 조회
SELECT (1+2)*(3+4) RESULT FROM DUAL;

-- 7) DEPARTMENTS 테이블의 LOCATION_ID를 하나씩만 조회
SELECT DISTINCT LOCATION_ID FROM DEPARTMENTS;

-- 8) EMPLOYEES 테이블에서 급여가 15000이상인 행을 조회
SELECT *
FROM EMPLOYEES
WHERE SALARY >= 15000;

-- 9) EMPLOYEES 테이블에서 50번 부서에 근무하며 급여가 5000을 넘는 직원들의 정보를 조회
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50 AND SALARY > 5000;

-- 10) EMPLOYEES 테이블에서 COMMISSION_PCT가 있는 직원의 수를 조회
SELECT COUNT(*)
FROM EMPLOYEES 
WHERE COMMISSION_PCT IS NOT NULL;

-- 11) EMPLOYEES 테이블에서 50, 90, 100번 부서에 근무하는 직원들의 정보를 조회
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (50, 90, 100);

-- 12) EMPLOYEES 테이블에서 급여가 7000에서 10000사이 (7000과 10000 포함)인 직원들의 정보를 조회
SELECT *
FROM EMPLOYEES
WHERE SALARY BETWEEN 7000 AND 10000;

-- 13) EMPLOYEES 테이블에서 FIRST_NAME에 s가 들어 있는 직원들의 정보를 조회
SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%s%';

-- 14) EMPLOYEES 테이블에서 LAST_NAME에 S가 들어 있는 직원들의 정보를 조회
SELECT *
FROM EMPLOYEES
WHERE LAST_NAME LIKE '%S%';

-- 15) EMPLOYEES 테이블에서 급여를 많이 받는 직원 순으로 조회
SELECT *
FROM EMPLOYEES
ORDER BY SALARY DESC;

-- 16) EMPLOYEES 테이블에서 부서아이디로 내림차순 조회 후 급여 순 내림차순 조회
SELECT *
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID DESC, SALARY DESC;

-- 17) EMPLOYEES 테이블에서 직원들의 연봉을 내림차순으로 조회 (연봉 = SALARY*12*COMMISSION_PCT)
SELECT SALARY*12*COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
ORDER BY SALARY DESC, COMMISSION_PCT DESC;

-- 18) DEPARTMENTS 테이블에서 매니져가 있는 부서의 이름을 내림차순으로 조회
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE MANAGER_ID IS NOT NULL
ORDER BY DEPARTMENT_NAME DESC;

-- 19) EMPLOYEES 테이블에서 매니져가 있는 직원들 중 COMMITION_PCT가 있는 직원들을 조회
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL AND COMMISSION_PCT IS NOT NULL;

-- 20) EMPLOYEES 테이블에서 풀네임(FIRST_NAME||' '||LAST_NAME)의 길이에 대해
--       내림차순으로 직원들을 조회
SELECT FIRST_NAME||' '||LAST_NAME FULLNAME, LENGTH(FIRST_NAME||' '||LAST_NAME)
FROM EMPLOYEES
ORDER BY LENGTH(FIRST_NAME||' '||LAST_NAME) DESC;













