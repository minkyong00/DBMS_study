-- DDL-KMK.sql

/*
DDL (Data Definition Language)
- 데이터베이스의 객체들을 생성, 수정, 삭제하는 SQL
- CREATE(생성), ALTER(수정), DROP(제거), TRUNCATE(데이터삭제 후 커밋)
*/ 

-- 테이블 생성
CREATE TABLE MEMBER(
	MID NUMBER PRIMARY KEY, -- 주키(PK): NOT NULL + UNIQUE, 각 행을 식별하는 역할
	MNAME NVARCHAR2(200) NOT NULL -- NULL을 허용하지 않음 (즉, 데이터가 있어야함)
);

-- 시퀀스 생성
-- 테이블의 컬럼이나 컬럼의 조합으로 주키를 특정할 수 없을때만 사용!
CREATE SEQUENCE SEQ_MEMBER; -- 1부터 시작해서 1씩 증가하는 자동 번호

-- 테이블에 컬럼 추가
ALTER TABLE MEMBER ADD (MAGE NUMBER);

-- 테이블에서 컬럼 삭제 : 컬럼에 데이터가 없을때만 삭제됨
ALTER TABLE MEMBER DROP COLUMN MAGE;

-- 테이블의 컬럼 수정 : 컬럼내의 데이터가 손실될 경우는 수정 안됨
ALTER TABLE MEMBER MODIFY (MNAME NVARCHAR2(500));

-- 테이블명 변경
RENAME MEMBER TO MEM;

-- 테이블 데이터 입력
INSERT INTO MEM VALUES (SEQ_MEMBER.NEXTVAL, '홍길동');
INSERT INTO MEM VALUES (SEQ_MEMBER.NEXTVAL, '이순신');
INSERT INTO MEM VALUES (SEQ_MEMBER.NEXTVAL, '강감찬');
COMMIT;
SELECT * FROM MEM;

-- 테이블의 데이터 삭제 
DELETE FROM MEM;
ROLLBACK; -- COMMIT전까지는 ROLLBACK 가능
SELECT * FROM MEM;

-- 테이블의 데이터 삭제 (DDL)
TRUNCATE TABLE MEM;
ROLLBACK; -- DDL은 수행 즉시 COMMMIT되므로 ROLLBACK 불가!
SELECT * FROM MEM;

-- 테이블에 데이터 입력
INSERT INTO MEM VALUES (SEQ_MEMBER.NEXTVAL, '홍길동');
SELECT * FROM MEM;
ROLLBACK;
SELECT * FROM MEM;

-- 테이블에 데이터 입력
INSERT INTO MEM VALUES (SEQ_MEMBER.NEXTVAL, '강감찬');
SELECT * FROM MEM;
COMMIT; -- 트랜잭션을 데이터베이스에 반영
ROLLBACK; -- 최종 커밋 다음 시점으로 되돌아감
SELECT * FROM MEM;

-- 테이블 전체 데이터 삭제
TRUNCATE TABLE MEM;
SELECT * FROM MEM;

-- 데이터 입력
INSERT INTO MEM VALUES (SEQ_MEMBER.NEXTVAL, '홍길동');
INSERT INTO MEM VALUES (SEQ_MEMBER.NEXTVAL, '강감찬');
SELECT * FROM MEM;
COMMIT;

-- 데이터 입력
INSERT INTO MEM VALUES (SEQ_MEMBER.NEXTVAL, '이순신');
SELECT * FROM MEM;

-- 커밋의 중간지점
SAVEPOINT ROW2;

-- 데이터 입력
INSERT INTO MEM VALUES (SEQ_MEMBER.NEXTVAL, '유관순');
SELECT * FROM MEM;

-- 중간지점으로 롤백
ROLLBACK TO ROW2;
SELECT * FROM MEM;

-- 커밋
COMMIT;
SELECT * FROM MEM;















