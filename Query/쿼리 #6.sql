-- 사원테이블과 부서 테이블을 크로스 조인하여 출력

-- ANSI
SELECT *
FROM 부서 CROSS JOIN 사원;

-- 배재용 사원에 대한 정보를 출력
SELECT 이름, 사원.부서번호, 부서명
FROM 부서 CROSS JOIN 사원
WHERE 이름='배재용';

-- NON-ANSI
SELECT 이름, 사원.부서번호, 부서명
FROM 부서, 사원
WHERE 이름='배재용';

-- '이소미'사원의 사원번호, 직위, 부서번호, 부서명 출력
SELECT 사원번호, 이름, 직위, 사원.부서번호, 부서명
FROM 사원 INNER JOIN 부서
		ON 사원.부서번호=부서.부서번호
WHERE 이름='이소미';

SELECT 사원번호, 이름, 직위, 사원.부서번호, 부서명
FROM 사원, 부서
WHERE 사원.부서번호=부서.부서번호
		 AND 이름='이소미';

-- 주문테이블과 주문세부 테이블을 이용하여
-- 주문번호, 고객번호, 주문한 제품번호를 출력

SELECT 주문.주문번호, 고객번호, 제품번호
FROM 주문 JOIN 주문세부
	ON 주문.주문번호 = 주문세부.주문번호;
	
-- NON-ANSI
SELECT 주문.주문번호, 고객번호, 제품번호
FROM 주문, 주문세부
WHERE 주문.주문번호 = 주문세부.주문번호;


-- 1. 마일리지 등급별로 고객수를 추력
SELECT COUNT(고객)
FROM 마일리지,고객;

-- 2. 주문번호 H0249룰 주문한 모든 고객정보 
SELECT 고객.*
FROM 고객 INNER JOIN 주문
	ON 고객.고객번호 = 주문.고객번호;
WHERE 주문번호='H0249'

-- 3.
SELECT 고객.*,주문일
FROM 고객 INNER JOIN 주문
	ON 고객.고객번호=주문.고객번호
WHERE 주문일='2020-04-09';

-- 4.도시별로 주문금액의 합을 추력하되
--   주문금액합이 많은 상위 5개의 도시에 대한 결과만 출력
SELECT 도시, SUM(주문수량*단가)주문금액합
FROM 고객 INNER JOIN 주문
					ON 고객.고객번호 = 주문.고객번호
			 INNER JOIN 주문세부
			 		ON 주문.주문번호=주문세부.주문번호
GROUP BY 도시
ORDER BY 주문금액합 DESC
LIMIT 5;

-- 5. 제품별로 주문수량합과 주문금액의 합을 출력
SELECT 제품명, SUM(주문수량)주문수량합, SUM(주문수량*주문세부.단가)주문금액합
FROM 제품 INNER JOIN 주문세부
 ON 제품.제품번호=주문세부.제품번호;
 

-- 6. 아이스크림 제품에 대하여 주문년도와 제품명별로 주문수량의 합계를 출력
SELECT
FROM 제품INNER JOIN 주문세부
					ON 제품.제품번호=주문세부.제품번호
			INNER JOIN 주문
					ON 주문.주문번호=주문세부.주문번호
WHERE 제품명 LIKE '%아이스크림%';


-- 7. 제품명별로 주문수량의 합을 출력
--		이 때 주문이 한번도 안된 제품에 대한 정보도 함께 출력할 것
SELECT 제품명, SUM(주문수량)
FROM 제품LEFT JOIN 주문세부
	ON 제품.제품번호=주문세부.제품번호
GROUP BY 제품명;

-- 8. 마일리지 등급이 A인 고객의 정보를 조회하여
--		고객번호, 담당자명, 고객회사명, 등급, 마일리지를 출력
SELECT 고객번호,담당자명,고객회사명,등급명,마일리지
FROM 고객 INNER JOIN 마일리지등급
				ON 마일리지 BETWEEN 하한마일리지 AND 상한마일리지
WHERE 등급명='A';


-- 최고 마일리지를 보유한 고객의 고객번호, 고객회사명,
-- 담당자명, 마일리지를 출력
SELECT 고객번호, 고객회사명, 담당자명, 마일리지
FROM 고객
GROUP BY 고객번호, 고객회사명, 담당자명;

SELECT 고객회사명, 담당자명, 고개번호
FROM 고객
WHERE 고객번호 = SELECT 고객번호
					  FROM 주문
					  WHERE 주문번호='H0250'
					  
-- '부산광역시'고객의 최소 마일리지보다
-- 더 큰 마일리지를 가진 고객의 담당자명, 고객회사명, 마일리지 출력
SELECT 담당자명, 고객회사명, 마일리지
FROM 고객
WHERE 마일리지 > (SELECT MIN(마일리지)
						FROM 고객
						WHERE 도시 = '부산광역시');

-- 부산광역시 고객에 주문한 주문건수를 출력
SELECT COUNT(*) 주문건수
FROM 고객
WHERE 도시=(SELECT 고객번호
				FROM 고객
				WHERE 도시 = '부산광역시');
				
-- 각 지역의 어느 평균 마일리지보다도
-- 마일리지가 큰 고객의 정보를 출력
SELECT 담당자명, 고객회사명, 마일리지
FROM 고객
WHERE 마일리지>ANY( SELECT AVG(마일리지)
							FROM 고객
							GROUP BY 지역);

-- 한번이라도 주문한 적이 있는 고객의 정보 출력
SELECT 고객번호, 고객회사명
FROM 고객
WHERE EXISTS (SELECT *
					FROM 주문
					WHERE 주문.고객번호=고객.고객번호);
					
SELECT 고객번호,고객회사명
FROM 고객
WHERE 고객번호 IN (SELECT 고객번호
						 FROM 주문);

SELECT 고객번호,고객회사명
FROM 고객 INNER JOIN 주문
				OR 고객.고객번호=주문.고객번호;
						 
-- 고객 전체의 평균 마일리지보다 평균 마일리지가 큰 도시의
-- 도시명과 도시의 평균 마일리지 출력
SELECT 도시, AVG(마일리지)평균마일리지
FROM 고객
GROUP BY 도시
HAVING AVG(마일리지)>(SELECT AVG(마일리지)
					 FROM 고객);

-- 담당자명, 고객회사명, 마일리지, 도시, 해당 도시의 평균
-- 마일리지를 출력.

SELECT 담당자명, 고객회사명, 마일리지, AVG(마일리지)
FROM 고객,(
			  SELECT 도시, AVG(마일리지)평균마일리지
		  	  FROM 고객
		 	  GROUP BY 도시;
		 	  )
GROUP BY 도시;


SELECT 담당자명, 고객회사명, 마일리지, 고객.도시,
		 평균마일리지, 평균마일리지-마일리지 AS 차이
FROM 고객,(
			  SELECT 도시, AVG(마일리지)평균마일리지
		  	  FROM 고객
		 	  GROUP BY 도시
		 	  )도시별평균
WHERE 고객.도시=도시별평균.도시;

-- 고객번호, 담당자명과 고객의 최종 주문일 출력
SELECT 고객번호, 담당자명,;

SELECT 고객.고객번호, MAX(주문일)
FROM 고객, 주문
WHERE 고객.고객번호=주문.고객번호
GROUP BY 고객.고객번호;

-- 고객번호, 담당자명과 고객의 최종 주문일 출력
SELECT 고객번호, 담당자명 (
									SELECT 고객.고객번호, MAX(주문일)
									FROM 고객, 주문
									WHERE 고객.고객번호=주문.고객번호)
									AS 최종주문일
FROM 고객;

-- 사원테이블에서 사원번호, 사원이름, 상사번호, 상사의 이름 출력
SELECT 사원번호, 이름, 상사번호,
		 (SELECT 이름
		 	FROM 사원 AS 상사
		 	WHERE 상사.사원번호=사원.사원번호
		 ) AS 상사이름
FROM 사원;

-- 각 도시마다 최고 마일리지르 ㄹ보유한 고객의 정보 출력 
SELECT 도시, 고객회사명, 마일리지
FROM 고객
WHERE (도시,마일리지)IN(SELECT 도시,MAX(마일리지)
					 		  	 FROM 고객
					 			 GROUP BY 도시);


