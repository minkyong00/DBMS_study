-- 예외처리-HR.sql

DECLARE 
	V_NO NUMBER;
BEGIN
	SELECT DEPARTMENT_NAME 
	INTO V_NO
	FROM DEPARTMENTS
	WHERE DEPARTMENT_ID=50;
	PL('예외가 발생하면 이 구문은 수행 안됨!');
	EXCEPTION
		WHEN VALUE_ERROR THEN PL('VALUE_ERROR 발생!');
	PL('예외가 발생해도 이 구문은 수행 됨!');
END;

-- 여러가지 예외처리
DECLARE
	V_NO NUMBER;
BEGIN
	SELECT DEPARTMENT_NAME
	INTO V_NO	
	FROM DEPARTMENTS;
	EXCEPTION
	  WHEN VALUE_ERROR THEN PL('VALUE_ERROR 발생!');
	  WHEN TOO_MANY_ROWS THEN PL('TOO_MANY_ROWS 발생!');
	  WHEN OTHERS THEN PL('그 외의 예외 발생!');
END;


-- 예외코드 / 예외메세지
DECLARE
	V_NO NUMBER;
BEGIN
	SELECT DEPARTMENT_NAME
	INTO V_NO
	FROM DEPARTMENTS;
	EXCEPTION
	  WHEN TOO_MANY_ROWS THEN 
		PL(SQLCODE); -- -1422
		PL(SQLERRM); -- ORA-01422: exact fetch returns more than requested number of rows
END;


-- 사용자 정의 예외
-- RAISE_APPLICATION_ERROR(에러코드, 에러메세지)
-- 에러코드 범위: -20000 ~ -20999 까지 가능

-- 사원 풀네임과 급여를 출력하는 동안 급여가 10000을 초과하면
-- 에러코드 20888, 에러메세지 '급여가 10000을 초과했습니다!' 출력

BEGIN
	FOR EMP IN (SELECT * FROM EMPLOYEES)
	LOOP
	BEGIN
		IF EMP.SALARY > 10000 THEN
			RAISE_APPLICATION_ERROR (-20888, '급여가 10000을 초과했습니다!');
		ELSE
			PL(
				EMP.FIRST_NAME||''||EMP.LAST_NAME||''||
				EMP.SALARY
			);
		END IF;
	 EXCEPTION
		WHEN OTHERS THEN
	      PL(EMP.FIRST_NAME||''||EMP.LAST_NAME||''|| '오류: '|| SQLERRM);
	END;
	END LOOP;
END;











































