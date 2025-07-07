-- 사용자 생성
CREATE  USER KMK IDENTIFIED BY KMK;

-- 생성한 사용자에 롤 부여
-- CONNECT : 접속에 관한 권한 모음, RESOURCE : 자원사용에 관한 권한 모음
GRANT CONNECT, RESOURCE TO KMK;

