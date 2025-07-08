-- NETFLIX-KMK-실습.sql
-- 넷플릭스 2019년 TV Show와 Movie 데이터 (출처:kaggle)
SELECT * FROM NETFLIX;

-- 1) 영화와 TV Show의 개수를 조회
SELECT COUNT(CONTENT_TYPE) "TV Show"
FROM NETFLIX
WHERE CONTENT_TYPE = 'TV Show'
UNION
SELECT COUNT(CONTENT_TYPE) "Movie"
FROM NETFLIX
WHERE CONTENT_TYPE = 'Movie';

-- 2) 한국 작품들의 수를 조회 (다국 합작 포함)
SELECT COUNT(*)
FROM NETFLIX
WHERE INSTR(COUNTRY, 'South Korea')>0;

-- 3) 'Lee Jung-jae'가 배우로 참여한 작품들의 타이틀을 조회
SELECT TITLE
FROM NETFLIX
WHERE INSTR(SHOW_CAST, 'Lee Jung-jae')>0
GROUP BY TITLE;

-- 4) 방영연도별 방영연도와 작품 수를 방영연도로 내림차순 정렬 조회
SELECT TO_CHAR(TO_DATE(DATE_ADDED), 'YYYY') RELEASE_YEAR, COUNT(*)
FROM NETFLIX
WHERE DATE_ADDED IS NOT NULL
GROUP BY TO_CHAR(TO_DATE(DATE_ADDED), 'YYYY')
ORDER BY RELEASE_YEAR DESC;

-- 5) 두명 이상이 감독으로 참여한 작품의 감독명과 타이틀을 조회
SELECT DIRECTOR, TITLE
FROM NETFLIX
WHERE INSTR(DIRECTOR, ',') > 0;

-- 6) 영화 상영시간에 대해 내림차순 정렬하여 타이틀과 상영시간 조회
SELECT TITLE, DURATION
FROM NETFLIX
WHERE INSTR(DURATION, 'min')>0 -- min 포함
	AND INSTR(DURATION, 'Seasons') = 0 -- Seasons 제외
ORDER BY TO_NUMBER(SUBSTR(DURATION, 1, INSTR(DURATION, 'min')-1)) DESC;
-- DURATION 숫자만 추출해서 숫자로 변환 후 내림차순 정렬함

-- 7) 영화 상영시간이 90분을 넘는 영화와 90분 이하인 영화의 수를 아래와 같이 조회
--     90분 이하    1,400
--     90분 초과    2,531
SELECT '90분 초과', COUNT(*)
FROM NETFLIX
WHERE TO_NUMBER(SUBSTR(DURATION, 1, INSTR(DURATION, 'min')-1))>90
UNION
SELECT '90분 이하', COUNT(*)
FROM NETFLIX
WHERE TO_NUMBER(SUBSTR(DURATION, 1, INSTR(DURATION, 'min')-1))<=90;











