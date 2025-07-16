-- 객체-KMK.sql

/*
INDEX (인덱스)
- 대량의 데이터(일반적으로 한 테이블에 수십만건(행) 이상...)를 조회할 때
- 조회 속도를 높이기 위해 사용되는 객체
- B+ Tree 인덱싱 알고리즘을 사용 (중간값을 설정하고 작은값은 왼쪽, 큰값은 오른쪽으로 분류해 나가는 알고리즘)
- 데이터가 적을 때는 인덱스를 사용하는 것은 비효율적 (인덱스를 구성하는데 시간이 소요됨)
- 데이터의 삽입, 삭제가 빈번한 경우에도 인덱스를 사용하는 것은 비효율적 (인덱스를 구성하는데 시간이 소요됨)
- 인덱스로 사용하는 컬럼이나 컬럼집합의 값들이 유일할수록 인덱스 성능은 향상됨
- PK컬럼이 테이블에 있거나 시퀀스를 사용해서 PK컬럼으로 사용할때에는 PK 인덱스가 자동으로 생김
*/

-- T1테이블의 VAL컬럼에 IDX_T1_VAL 이라는 이름의 인덱스를 생성
CREATE INDEX IDX_T1_VAL ON T1(VAL);

-- 사용자의 인덱스가 적용된 테이블과 컬럼 정보 조회
SELECT * FROM USER_IND_COLUMNS; -- 데이터 사전 = 뷰

-- 인덱스 제거
DROP INDEX IDX_T1_VAL;

/*
view(뷰)
- 한 테이블의 일부 컬럼이나 조인된 결과 중 일부 또는 전체 컬럼을 조회할 목적으로 사용되는 객체 
- 뷰는 물리적으로 데이터를 저장하는 MATERIALIZED VIEW와 논리적으로 SELELCT구문인 뷰로 나눔
- 뷰를 사용하는 목적
- 1) 보안성 : 테이블에 직접 접근해서 데이터를 조회하지 못하도록 해서 보완성 유지하기 위함
- 2) 편리성 : 미리 조인을 해두고 결과를 조회하기 위해
- 실무적으로는 데이터베이스 설계시에 뷰들을 생성해서 개발자들에게 뷰만 공개
*/

-- 뷰 생성
-- insufficient PRIVILEGES : 뷰 생성 권한 없음 > 관리자계정에서 뷰 생성 권한 부여 필요
-- DBA권한으로 GRANT CREATE VIEW TO KMK
CREATE OR REPLACE VIEW VW_T1
AS
SELECT * FROM T1;

-- 뷰를 통해 데이터 조회
SELECT * FROM VW_T1;

-- 사용자의 뷰 정보 조회
SELECT * FROM USER_VIEWS;

-- 실습) HONG의 잔액과 KANG의 잔액을 함께 조회하는 VW_MONEY라는 뷰를 생성해서
--		두 계좌의 잔액을 조회해 봅시다

SELECT * FROM HONG;
SELECT * FROM KANG;

CREATE OR REPLACE VIEW VW_MONEY
AS
SELECT 
	(SELECT MONEY FROM HONG) "HONG잔액",
	(SELECT MONEY FROM KANG) "KANG잔액"
FROM DUAL;

SELECT * FROM VW_MONEY;

-- 실습) NETFIX테이블에서 상영시간이 90분을 초과하는 영화들의 
-- 		SHOW_ID, TITLE, DURATION을 조회하는 VW_90OVER_MOVIE 뷰 생성/조회
CREATE OR REPLACE VIEW VW_90OVER_MOVIE
AS
SELECT SHOW_ID, TITLE, DURATION
FROM NETFLIX
WHERE TO_NUMBER(SUBSTR(DURATION, 1, INSTR(DURATION, ' '))) > 90
	AND CONTENT_TYPE = 'Movie';

SELECT * FROM VW_90OVER_MOVIE;


-- 실습) HR계정이 소유한 테이블들에 의해 50번 부서에 근무하는 직원들의
-- 부서명, 풀네임, 급여를 조회하는 VW_50DEPT_EMP라는 뷰를 생성/조회
CREATE OR REPLACE VIEW VW_50DEPT_EMP
AS
SELECT D.DEPARTMENT_NAME 부서명, E.FIRST_NAME||''||E.LAST_NAME 풀네임, E.SALARY 급여
FROM HR.EMPLOYEES E, HR.DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
	AND E.DEPARTMENT_ID = 50;

SELECT * FROM VW_50DEPT_EMP;

/*
SEQUENCE(시퀀스)
- 연속번호 생성하는 객체
- 테이블에 PK가 없는 경우에 한해서 시퀀스를 생성해서 PK로 사용할 목적으로 생성
- 시퀀스는 한번 번호가 생성되면 되돌릴 수 없음
*/

-- 시퀀스 생성
CREATE SEQUENCE SEQ_T1; -- 1부터 1씩 증가하는 시퀀스

-- 시퀀스 사용
SELECT SEQ_T1.NEXTVAL FROM DUAL;
SELECT SEQ_T1.CURRVAL FROM DUAL;

-- 시퀀스 속성
CREATE SEQUENCE SEQ_T2
INCREMENT BY 2 -- 증가값
START WITH 10 -- 최초값
MINVALUE 10 -- 최소값
MAXVALUE 50 -- 최대값
NOCYCLE; -- 최대값에 도달했을 때 최초값으로 돌아갈지 여부

SELECT SEQ_T2.NEXTVAL FROM DUAL;

/*
SYNONYM (시노님)
- 객체명이 긴 경우 또는 객체명을 숨길 필요가 있을 때 객체명에 대한 별칭을 부여
*/
CREATE TABLE TB_MT_LONG_NAME_TABLE(
	NAME NVARCHAR2(200)	
);

-- 시노님 생성
-- GRANT CREATE SYNONYM TO KMK
CREATE SYNONYM TMLNT FOR TB_MT_LONG_NAME_TABLE;

SELECT * FROM TMLNT;




















