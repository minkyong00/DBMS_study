-- PLSQL-HR.sql

/*
PL/SQL (Procedual Language / Structured Query Language)
- 오라클에서 사용하는 절차적 프로그래밍 언어
- 기본 구조
  1) DECLARE : 변수, 상수, 커서 등을 선언하는 블럭 (선택사항)
  2) BEGIN ~ END : 실행할 SQL문장들이 모인 블럭 (필수)
  3) EXCEPTION : SQL 실행 중 예외발생 시 예외를 처리하는 블럭 (선택)
*/

-- 문자열을 콘솔에 출력하는 PL/SQL 블럭 (익명 프로시져)
BEGIN
	DBMS_OUTPUT.PUT_LINE('Hello PL/SQL');
END;

-- 한 줄 주석
/*
	여러 줄 주석
	여러 줄 주석
*/

-- 변수, 상수 선언
DECLARE
	V_GREETING NVARCHAR2(20) := 'HELLO HI!'; -- 변수 선언
	C_PI CONSTANT NUMBER := 3.14; -- 상수 선언
BEGIN
	DBMS_OUTPUT.PUT_LINE(V_GREETING);
	DBMS_OUTPUT.PUT_LINE(C_PI);
--	C_PI := 5; -- 상수는 값 변경 불가
END;

-- 데이터 타입
-- 1. 스칼라(SCALAR) 타입 : 문자, 숫자, 날짜, 불리언 등 단일값을 저장하는 타입
-- 2. 참조(REFERENCE) 타입 : %ROWTYPE (테이블의 한 행의 모든 컬럼의 타입)
--                         %TYPE(테이블의 어떤 컬럼의 타입)
-- 3. 복합(COMPLEX) 타입 : 레코드 (여러 다른 타입들의 집합 타입)
--                       컬렉션 (한 가지 타입의 여러 값들을 모은 타입)
-- 4. LOB(LARAGE OBJECT) 타입
--    BLOB(BINARY) : 4G바이트까지 바이너리 데이터(영상, 음성, 이미지 ...) 저장을 위한 타입
--    CLOB(CHARACTER) : 4G바이트까지 바이너리 문자데이터 저장을 위한 타입
--    FLOB(FILE) : 4G바이트까지 바이너리 파일데이터 저장을 위한 타입

DECLARE
	V_NUM NUMBER := 3;
	V_NVC NVARCHAR2(20) := 'HELLO';
	V_DT DATE := SYSDATE;
	V_RT EMPLOYEES%ROWTYPE;
	V_T EMPLOYEES.EMPLOYEE_ID%TYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE(V_NUM);
	DBMS_OUTPUT.PUT_LINE(V_NVC);
	DBMS_OUTPUT.PUT_LINE(V_DT);
	SELECT * INTO V_RT 
	FROM EMPLOYEES
	WHERE EMPLOYEE_ID=100; -- 여러행이 뽑히므로 한 행만 나오게 해야함
	DBMS_OUTPUT.PUT_LINE(V_RT.FIRST_NAME||' '||V_RT.LAST_NAME);
	SELECT EMPLOYEE_ID INTO V_T -- SELECT되는 컬럼과 변수와 컬럼이 같아야함
	FROM EMPLOYEES
	WHERE EMPLOYEE_ID=100;
	DBMS_OUTPUT.PUT_LINE(V_T);
END;

-- 제어문 (IF, CASE)
BEGIN
	IF 5 > 3 THEN DBMS_OUTPUT.PUT_LINE('5는 3보다 큽니다!');
	ELSE DBMS_OUTPUT.PUT_LINE('5는 3보다 크지 않습니다!');
	END IF;
END;

DECLARE
	V_GENDER CHAR(1) := 'F';
BEGIN
	CASE V_GENDER
		WHEN 'M' THEN DBMS_OUTPUT.PUT_LINE('남성');
		WHEN 'F' THEN DBMS_OUTPUT.PUT_LINE('여성');
		ELSE DBMS_OUTPUT.PUT_LINE('???');
	END CASE;
END;

-- 반복문 (LOOP, FOR, WHILE)

DECLARE
	V_NUM NUMBER := 0;
BEGIN
LOOP
	V_NUM := V_NUM + 1;
	CONTINUE WHEN V_NUM = 5; -- 다음번 반복 수행
	EXIT WHEN V_NUM>10; -- 반복 종료
	DBMS_OUTPUT.PUT_LINE(V_NUM);
END LOOP;
END;

BEGIN
	FOR I IN 1..10
	LOOP
		DBMS_OUTPUT.PUT_LINE(I);		
	END LOOP;
END;

BEGIN
	FOR I IN REVERSE 1..10
	LOOP
		DBMS_OUTPUT.PUT_LINE(I);		
	END LOOP;
END;

DECLARE
	V_NUM NUMBER := 0;
BEGIN
	WHILE V_NUM<10
	LOOP
		V_NUM := V_NUM + 1;
		DBMS_OUTPUT.PUT_LINE(V_NUM);
	END LOOP;
END;




























