--고객테이블의 모든 자료 보기
SELECT *
FROM 고객;

--고객테이블에서 고객회사명만 보기
SELECT 고객회사명, 담당자
FROM 고객;

---

SELECT 고객번호, 담당자명, 고객회사명, 마일리지 AS 포인트
FROM 고객;

--

SELECT 고객번호, 담당자명, 고객회사명,
			마일리지 AS '포인트 점수',
			마일리지 * 1.1 AS '10% 인상된 금액'
FROM 고객;

--

SELECT 고객번호, 담당자명, 마일리지
FROM 고객
WHERE 마일리지>=100000;

--

SELECT 고객번호, 고객회사명, 담당자명, 담당자직위
FROM 고객
WHERE 담당자직위='영업사원';

SELECT * FROM 고객;

--

SELECT 고객번호, 담당자명, 도시, 마일리지
FROM 고객
WHERE 도시='서울특별시';

SELECT * FROM 고객;

--

SELECT 마일리지, 고객번호, 도시, 담당자명
FROM 고객
WHERE 도시='서울특별시'
ORDER BY 마일리지  DESC;


--마일리지가 많은 고객부터 상위 3명 출력
SELECT *
FROM 고객
ORDER BY 마일리지 DESC
LIMIT 3;

--
SELECT*
FROM 고객
ORDER BY 마일리지 ASC
LIMIT 3 OFFSET 10;

--
SELECT DISTINCT 도시
FROM 고객

--

SELECT 22+4 AS 더하기,
       22-4 AS 빼기,
		 22*4 AS 곱하기, 
		 22/4 AS 나누기, 
		 22%4 AS 나머지;

--

SELECT 고객번호, 고객회사명, 도시, 지역, 전화번호
FROM 고객
WHERE 지역 != '경기도';

--

SELECT *
FROM 고객
WHERE 도시 !='부산광역시' AND 마일리지<1000
SELECT * FROM 고객;

--도시가 '서울특별시'이거나 담당자 직위가'대표 이사'
--이면서 마일리지가 3000이상인 자료의
--고객번호, 고객회사명, 도시, 담당자직위, 마일리지 출력
