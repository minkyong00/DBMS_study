-- 커서-HR.sql

/*
CURSOR (커서)
- SELECT 결과행들을 하나씩 지창하는 포인터
- 커서의 종류
  1) 명시적 커서 (explicit cursor) : 커서명을 부여하고 선언해서 사용하는 커서
  2) 묵시적 커서 (implicit cursor) : 별도의 커서명 없이 사용하는 커서 (select 구문)
- 커서는 선언 > 오픈 > 패치(행 인출) > 클로즈 단계를 거쳐 사용
- FOR ~ IN ~ 구문 뒤에 사용하는 묵시적 커서는 선언, 오픈, 패치, 클로즈를 명시하지 않아도 됨
*/

-- 한 행의 데이터를 가리키는 커서
DECLARE
	-- 커서 선언
	CURSOR CUR_DEPT IS
		SELECT * FROM DEPARTMENTS
		WHERE DEPARTMENT_ID = 50;
	-- 커서 인출한 행의 데이터를 저장할 변수
	V_DEPT_ROW DEPARTMENTS%ROWTYPE;
BEGIN
	-- 커서 오픈
	OPEN CUR_DEPT;
	-- 커서에서 한 행을 인출해서 V_DEPT_ROW에 저장
	FETCH CUR_DEPT INTO V_DEPT_ROW;
	PL('부서아이디: '||V_DEPT_ROW.DEPARTMENT_ID);
	PL('부서명: '||V_DEPT_ROW.DEPARTMENT_NAME);
	-- 커서 닫기
	CLOSE CUR_DEPT;
END;


-- 여러 행을 가리키는 커서
DECLARE
	CURSOR CUR_DEPT IS
		SELECT * FROM DEPARTMENTS;
	V_DEPT_ROW DEPARTMENTS%ROWTYPE;
BEGIN
	OPEN CUR_DEPT;
	LOOP
		FETCH CUR_DEPT INTO V_DEPT_ROW;
		EXIT WHEN CUR_DEPT%NOTFOUND; -- 더이상 가리키는 행이 없다면 반복 탈출
		PL('부서아이디: '||V_DEPT_ROW.DEPARTMENT_ID);
		PL('부서명: '||V_DEPT_ROW.DEPARTMENT_NAME);
	END LOOP;
	CLOSE CUR_DEPT;
END;


-- 명시적 커서를 FOR ~ IN 구문과 함께 커서 사용
DECLARE
	CURSOR CUR_DEPT IS
		SELECT * FROM DEPARTMENTS;
	V_DEPT_ROW DEPARTMENTS%ROWTYPE;
BEGIN
	FOR V_DEPT_ROW IN CUR_DEPT
	LOOP
		PL('부서아이디: '||V_DEPT_ROW.DEPARTMENT_ID);
		PL('부서명: '||V_DEPT_ROW.DEPARTMENT_NAME);
	END LOOP;
END;

-- 묵시적 커서를 FOR ~ IN 구문과 함께 커서 사용
BEGIN
	FOR V_DEPT_ROW IN (SELECT * FROM DEPARTMENTS)
	LOOP
		PL('부서아이디: '||V_DEPT_ROW.DEPARTMENT_ID);
		PL('부서명: '||V_DEPT_ROW.DEPARTMENT_NAME);
	END LOOP;
END;


-- 파라미터를 사용하는 커서
DECLARE
	CURSOR CUR_DEPT(P_DEPT_ID DEPARTMENTS.DEPARTMENT_ID%TYPE)
	IS 
		SELECT * FROM DEPARTMENTS
		WHERE DEPARTMENT_ID = P_DEPT_ID;
BEGIN
	FOR V_DEPT_ROW IN CUR_DEPT(100)
	LOOP
		PL('부서아이디: '||V_DEPT_ROW.DEPARTMENT_ID);
		PL('부서명: '||V_DEPT_ROW.DEPARTMENT_NAME);
	END LOOP;
END;


































