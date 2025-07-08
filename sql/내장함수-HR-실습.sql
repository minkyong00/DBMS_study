-- 내장함수-HR-실습.SQL

-- 1) 모든 직원들의 풀네임(FIRST_NAME||' '||LAST_NAME)을 대문자로 조회
SELECT UPPER(FIRST_NAME||' '||LAST_NAME) FROM EMPLOYEES;

-- 2) FIRST_NAME이 3글자 이하인 직원들의 LAST_NAME을 조회
SELECT LAST_NAME
FROM EMPLOYEES
WHERE LENGTH(FIRST_NAME)<=3;

-- 3) 모든 직원들의 전화번호를 .기호를 제거하여 조회
SELECT REPLACE(PHONE_NUMBER, '.', '') FROM EMPLOYEES;

-- 4) 모든 직원들의 LAST_NAME에서 처음 나오는 a를 제거하여 조회
SELECT LAST_NAME, 
	SUBSTR(LAST_NAME, 1, INSTR(LAST_NAME, 'a')-1)
	|| SUBSTR(LAST_NAME, INSTR(LAST_NAME, 'a')+1)
FROM EMPLOYEES;

-- 5) 모든 직원들의 이메일주소를 20자리에 맞춰 좌측을 -기호로 채워 조회
SELECT LPAD(EMAIL, 20, '-') 
FROM EMPLOYEES;

-- 6) 한달은 30일로 가정, 직원들은 모두 하루 8시간 근무한다고 가정하고
--     직원들의 분당 급여의 CEIL값과 FLOOR값을 조회
SELECT 
	CEIL(SALARY / 30 / 8 / 60), 
	FLOOR(SALARY / 30 / 8 / 60) 
FROM EMPLOYEES;

-- 7) MANAGER_ID가 짝수인 직원의 정보를 조회
SELECT * 
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL AND MOD(MANAGER_ID, 2) = 0;

-- 8) 현재시간에서 5개월 지난 시점의 날짜/시간 정보를 조회
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- 9) 현재시간에서 3개월 지난 시점 이후의 가장 빠른 토요일의 날짜/시간 정보를 조회
SELECT NEXT_DAY(ADD_MONTHS(SYSDATE, 3), '토요일') FROM DUAL;

-- 10)직원들의 고용일자를 '2024년 6월 8일' 형식으로 조회
SELECT 
	TO_CHAR(HIRE_DATE, 'YYYY') || '년 ' 
	|| TO_CHAR(HIRE_DATE , 'MM') || '월 '
	|| TO_CHAR(HIRE_DATE, 'DD') || '일'
FROM EMPLOYEES;

-- 11) MANAGER_ID가 149인 직원들의 직원아이디, 직원풀네임, 월급을 조회
SELECT EMPLOYEE_ID "직원아이디", FIRST_NAME||''||LAST_NAME "직원풀네임", SALARY "월급"
FROM EMPLOYEES
WHERE MANAGER_ID = 149;

-- 12) FIRST_NAME이나 LAST_NAME이 5문자 이하인 직원의 정보를 조회
SELECT *
FROM EMPLOYEES
WHERE LENGTH(FIRST_NAME)<=5 OR LENGTH(LAST_NAME)<=5;

-- 13) 짝수년도에 고용된 직원 중에서 COMMISSION_PCT가 있는 직원의 정보를 조회
SELECT *
FROM EMPLOYEES
WHERE MOD(TO_CHAR(HIRE_DATE, 'YYYY'), 2)=0 
	AND COMMISSION_PCT IS NOT NULL;

-- 14) 월급이 10000이상이면 '고소득자', 10000미만 5000이상이면 '일반소득자'
--       5000미만이면 '저소득자'로 직원의 정보를 조회
SELECT E.*,
	CASE WHEN SALARY>=10000 THEN '고소득자'
		 WHEN SALARY BETWEEN 5000 AND 9999 THEN '일반소득자'
		 WHEN SALARY<5000 THEN '저소득자'
	END "소득분류"
FROM EMPLOYEES E; 

-- 15) 월급이 2000달러에서 3000달러 사이(양쪽 다 포함)인 직원의 정보를 
--       월급 많은순으로 조회
SELECT *
FROM EMPLOYEES
WHERE SALARY BETWEEN 2000 AND 3000
ORDER BY SALARY DESC;

-- 16) 매니져가 없는 부서의 부서명을 오름차순으로 조회
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE MANAGER_ID IS NULL
ORDER BY DEPARTMENT_NAME;

-- 17) 직원들의 JOB_ID를 12자리에 맞춰 오른쪽으로 정렬해서 조회
SELECT LPAD(JOB_ID, 12, ' ')
FROM EMPLOYEES;

-- 18) 직원들의 JOB_ID를 AC는 ACC로 ST는 STT로 변경해서 조회
SELECT 
	CASE WHEN SUBSTR(JOB_ID, 1, 2)='AC' THEN REPLACE(JOB_ID, 'AC', 'ACC')
		 WHEN SUBSTR(JOB_ID, 1, 2)='ST' THEN REPLACE(JOB_ID, 'ST', 'STT')
		 ELSE JOB_ID
	END
FROM EMPLOYEES;

SELECT REPLACE(REPLACE(JOB_ID, 'AC', 'ACC'), 'ST', 'STT')
FROM EMPLOYEES;

-- 19) 직원들의 직무시작일은 한달 전으로 직무종료일은 한달 후로 변경해 조회
SELECT START_DATE, ADD_MONTHS(START_DATE, -1), END_DATE, ADD_MONTHS(END_DATE, +1)
FROM JOB_HISTORY;

-- 20) JOB_ID가 IT_PROG 또는 AC_ACCOUNT 또는 AC_MGR인 것에 대해
--       IT_PROG이면 "정보부", AC_ACCOUNT이면 "회계부", AC_MGR이면 
--       "관리부"로 조회
SELECT JOB_ID, 
	DECODE(JOB_ID, 'IT_PROG', '정보부', 'AC_ACCOUNT', '회계부', 'AC_MGR', '관리부')
FROM EMPLOYEES
WHERE JOB_ID IN ('IT_PROG', 'AC_ACCOUNT', 'AC_MGR');




















