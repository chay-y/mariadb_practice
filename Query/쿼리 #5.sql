-- 고객테이블에서 고객번호, 도시, 지역의 개수를 조회
SELECT COUNT(*), 		
		 COUNT(고객번호),
 		 COUNT(도시),
		 COUNT(지역),	
		 COUNT(마일리지)
FROM 고객;


-- 고객 테이블의 마일리지 합, 평균, 최대, 최소를 조회
SELECT SUM(마일리지),
		 AVG(마일리지),
		 MAX(마일리지),
		 MIN(마일리지)
FROM 고객;


-- 고객 테이블에서 '서울특별시'의 고객에 대해
-- 마일리지의 합, 평균을 계산
SELECT SUM(마일리지), AVG(마일리지)
FROM 고객
WHERE 도시 = '서울특별시';


-- 고객 테이블에서 도시별로 고객수와 해당 도시 고객들의
-- 마일리지 평균
-- GROUP BY  그룹별로
SELECT 도시, COUNT(*) '고객수', AVG(마일리지) '마일리지 평균'
FROM 고객
GROUP BY 도시;


-- 마일리지가 10000 이상인 사람들에 대해
-- 담당자 직위별로, 같은 담당자 직위에 대해서는 도시별로 묶어서
-- 고객수와 평균 마일리지 출력
-- 담당자직위, 도시순으로 정렬
SELECT 담당자직위, 도시, COUNT(*) '고객수', AVG(마일리지) '평균 마일리지'
FROM 고객
WHERE 마일리지 >= 10000
GROUP BY 담당자직위, 도시
ORDER BY 담당자직위, 도시;


-- 고객테이블에서 고객수가 10명 이상인 도시에 대해
-- 도시별로 그룹을 묶어서 고객수와 평균 마일리지를 구하고
SELECT 도시, COUNT(담당자명), COUNT(*) '고객수', AVG(마일리지) '평균마일리지'
FROM 고객
GROUP BY 도시
HAVING COUNT(*)>=1;  	
									
				
-- 고객번호가 'T'로 시작하는 고객에 대해
-- 도시별로 묶어서 고객의 마일리지의 합을 구하시오.
-- 이 때 마일리지 합이 1000점 이상인 레코드만 출력하시오.
SELECT 도시, SUM(마일리지)
FROM 고객
WHERE 고객번호 LIKE 'T%'
GROUP BY 도시	.
HAVING SUM(마일리지)>=1000;


-- '광역시' 고객에 대해 담당자직위별로 '최대 마일리지'를 보이되
-- 최대 마일리지가 10000점 이상인 자료만 출력하시오.
SELECT 담당자직위, MAX(마일리지)
FROM 고객
WHERE 도시 LIKE '%광역시'
GROUP BY 담당자직위
HAVING MAX(마일리지)>=10000;


-- 지역이 NULL인 고객에 대해 도시별로 고객수와 평균 마일리지 출력
-- 전체 고객수와 전체 고객에 대한 평균 마일리지도 함께 출력
SELECT IFNULL(도시, '합계') '도시', COUNT(*) '고객수', AVG(마일리지)	-
FROM 고객
WHERE 지역 IS NULL
GROUP BY 도시
WITH ROLLUP; 		


-- 담당자직위에 '마케팅'이 들어가 있는 고객에 대해
-- 담당자직위와 도시 별로 고객수를 출력
SELECT 도시, 담당자직위, COUNT(*) '고객수'
FROM 고객
WHERE 담당자직위 LIKE '%마케팅%'
GROUP BY 도시, 담당자직위 
WITH ROLLUP;				


-- GROUP_CONCAT() : 각 행에 있는 값을 하나로 결합
-- 사원 테이블에 있는 이름을 한행에 나열하기
SELECT GROUP_CONCAT(이름)
FROM 사원;


-- 고객 테이블에 있는 지역을 한행에 나열
SELECT GROUP_CONCAT(DISTINCT 지역)
FROM 고객;

-- 1. 제품번호별로 주문수량의 합계와 주문금액의 합계를 출력
SELECT 제품번호,
		 SUM(주문수량)"주문수량합",
		 SUM(주문수량*단가)"주문금액합"
FROM 주문세부
GROUP BY 제품번호;

-- 2. 주분번호별로 주문된 제품번호의 목록과 주문금액합을 출력
SELECT 주문번호, SUM(주문수량*단가)"주문금액합"
FROM 주문세부
GROUP BY 주문번호, 제품번호;

-- 3. 2021년 주문내역에 대하여 고객번호별로 주문건수를 출력하되,
-- 주문건수가 많은 상위 3건의 고객의 정보만 보이도록 하시오
SELECT 고객번호, COUNT(*) 주문건수
FROM 주문
WHERE YEAR(주문일)=2021
GROUP BY 고객번호
ORDER BY 주문건수 DESC
LIMIT 3;

-- 4. 직위별로 사원수와 사원이름 목록 출력
SELECT 직위, COUNT(*)사원수, GROUP_CONCAT(이름)사원이름목록
FROM 사원
GROUP BY 직위;

-- 5. 고객테이블의 도시수와 중복값을 제외한 도시수를 출력하시오.
SELECT COUNT(도시), COUNT(DISTINCT 도시)
FROM 고객;

-- 6. 주문테이블에서 주문년도별로 주문건수를 조회

-- 7. 주문테이블에서 주문년도와 분기별 주문건수,
-- 주문년도별 주문건수, 전체 주문건수를 조회하여 출력
SELECT YEAR(주문일)주문년도,
		 QUARTER(주문일)분기,
		 COUNT(*) 주문건수
FROM 주문
GROUP BY YEAR(주문일), QUARTER(주문일)
WITH ROLLUP;

-- 8. 주문테이블에서 요청일보다 발송이 늦어서진 주문내역이
-- 월별로 몇 건씩인지 요약하여 조회하여
-- 주문월 순서대로 정렬하여 출력
SELECT MONTH(주문일), COUNT(*)
FROM 주문
WHERE 요청일<발송일
GROUP BY MONTH (주문일)
ORDER BY MONTH (주문일);

-- 9. 제품 테이블에서'아이스크림'제품들에 대하여
-- 제품명별로 재고의 합계를 출력하시오
SELECT 제품명, SUM(재고) 재고합
FROM 제품
GROUP BY 제품명
HAVING 제품명 LIKE '%아이스크림%';

-- 10. 고객테이블에서 마일리지가 50000점 이상인 고객은 VIP고객
--  나머지 고객은 일반고객으로 구분하고
--  고객구분별로 고객수와 평균마일리지를 출력하시오. 
SELECT IF(마일리지>=50000, 'VIP고객','일반고객')고객구분,
		 COUNT(*)고객수,
		 AVG(마일리지)평균마일리지
FROM 고객
GROUP BY IF(마일리지>=50000, 'VIP고객','일반고객');