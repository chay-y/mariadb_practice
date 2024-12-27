-- 1
CREATE TABLE MY_MEMEBER(
	회원번호 INT PRIMARY KEY,
	아이디 VARCHAR(50) NOT NULL,
	비밀번호 VARCHAR(50) NOT NULL,
	회원이름 VARCHAR(20) NOT NULL,
	나이 CHAR(5) NOT NULL,
	이메일주소 VARCHAR(50)
);

-- 2
INSERT INTO MY_MEMEBER
VALUES(1,'USER1','1234','이예진',25,'USER12@naver.com');

DELETE FROM my_memeber;

-- 3
UPDATE MY_MEMEBER
SET 회원이름 = '김자바'
WHERE 회원번호 = 1;

UPDATE MY_MEMEBER
SET 아이디 = 'KIMJAVA'
WHERE 회원번호 = 1;

-- 4 사원들 중 이름이 민/소로 끝나는 사원들의
-- 사원번호, 이름, 입사일
-- 사원번호기준 내림차순 정렬
SELECT 사원번호, 이름, 입사일
FROM 사원
WHERE 이름 LIKE '%%민' OR '%%소'
ORDER BY 사원번호 DESC;

-- 5 사원의 사원번호, 이름, 부서번호, 부서명 
-- 부서명은 부서번호가...
-- A1 : 영업부
-- A2 : 기획부
-- A3 : 개발부

SELECT 사원번호, 이름, 부서번호,
			(SELECT 부서명
			 FROM 부서
			 WHERE 부서번호.A1='영업부', 부서번호.A2='기획부', 부서번호.A3='개발부')'부서명'	
FROM 사원;


-- 6 마일리지가 10000에서 50000사이
-- 지역이 NULL 인 고객
-- 의 고객번호, 고객회사명, 담당자명, 도시, 지역, 마일리지

SELECT 고객번호, 고객회사명, 담당자명, 도시, 지역, 마일리지
FROM 고객
WHERE 마일리지>= 10000 AND 50000 >= 마일리지 AND 지역 = NULL;

-- 7 도시별 마일리지의 합과
-- 마일리지의 평균을 조회
-- 합의 내림차순
SELECT SUM(마일리지)"마일리지합", AVG(마일리지)"마일리지평균"
FROM 고객
GROUP BY 도시 DESC;

-- 8 고객번호별로 주문수량의 합계와 주문금액의 합계를 계산
-- 단가X주문수량에 할인율적용  =  주문금액
SELECT SUM(주문수량)"주문수량합계",
		 SUM(주문수량*단가*할인율)"주문금액합계"
FROM 주문세부, 고객
GROUP BY 고객번호;


