
-- 1. 제품테이블의 재고 컬럼에 check 제약 조건 추가
-- 조건> 재고는 0보다 크거나 같아야 함
ALTER TABLE 제품 ADD CHECK(재고>=0);

-- 2. 제품 테이블에 재고금액 컬럼을 추가
-- 재고금액은 단가*재고가 자동으로 계산되어 나오도록 함
ALTER TABLE 제품 ADD 재고금액 INT AS(단가*재고) STORED;

-- 3. 제품 테이블에서 제품 레코드를 삭제하면 주문세부 테이블에 있는 관련 레코드도 함께 삭제되도록
-- 주문세부 테이블의 제품번호 컬럼에 외래키 제약조건과 옵션을 설정
ALTER TABLE 주문세부
ADD FOREIGN KEY(제품번호) REFERENCES 제품(제품번호)
	ON DELETE CASCADE;

-- 4. 영화 테이블 생성
-- 컬럼명		데이터타입		제약조건
-- 영화번호		고정문자형 5		기본키
-- 타이틀		가변문자형100 		필수입력
-- 장르			가변문자형 20		코미디, 드라마, 다큐
-- 										sf, 액션, 역사, 기타만 입력 가능
-- 배우			가변자형100 		필수입력
-- 감독			가변문자형50		필수입력
-- 제작사		가변문자형 50		필수입력
-- 개봉일		날짜형			
-- 등록일		날짜형			오늘 날짜 자동 입력
CREATE TABLE 영화(
	영화번호 CHAR(5) PRIMARY KEY, 
	타이틀 VARCHAR(100) NOT NULL,
	장르 VARCHAR(20) CHECK(장르 IN('코미디','드라마','다큐','sf','액션','역사','기타')),
	배우 VARCHAR(100) NOT NULL,
	감독 VARCHAR(50) NOT NULL,
	제작사 VARCHAR(50) NOT NULL,
	개봉일 DATE,
	등록일 DATE DEFAULT (CURDATE())
);

-- 5. 평점관리 테이블 생성
-- 컬럼명		데이터타입		제약조건
-- 번호			숫자형			일련버호 자동입력, 기본키
-- 평가자닉네임		가변문자형50		필수입력
-- 영화번호			고정문자형5			필수입력 , 영화테이블의 영화번호 참조
-- 평점			숫자형				1~5사이의 값만 입력, 필수입력
-- 평가			가변문자형2000			필수입력
-- 등록일			날짜형			오늘날짜 자동입력
CREATE TABLE 평점관리(
	번호 INT PRIMARY KEY AUTO_INCREMENT,
	평가자닉네임 VARCHAR(50) NOT NULL,
	영화번호 CHAR(5) NOT NULL,
	평점 INT NOT NULL CHECK(평점 BETWEEN 1 AND 5),
	평가 VARCHAR(2000) NOT NULL,
	등록일 DATE DEFAULT (CURDATE()),
	FOREIGN KEY (영화번호) REFERENCES 영화(영화번호)
);

-- 사원테이블을 사용하여 사원의 이름, 집전화, 입사일, 주소를
-- 보여주는 뷰를 작성

CREATE OR REPLACE VIEW view_사원
	AS SELECT 이름, 집전화 AS 전화번호, 입사일, 주소
		FROM 사원;
		
SELECT * FROM VIEW_사원;

-- 제품테이블, 주문세부테이블을 조인하여
-- 제품명과 주문수량합을 보여주는 뷰를 작성
-- 뷰이름 : view_제품별주문수량합

SELECT 제품명, SUM(주문수량) AS 주문수량합
FROM 제품 INNER JOIN 주문세부
	ON 제품.제품번호 = 주문세부.제품번호
GROUP BY 제품명;

-- '여'사원에 대하여 사원의 이름, 집전화, 입사일, 주소,
-- 성별을 보여주는 'view_사원_여'뷰를 생성하시오.

CREATE OR REPLACE VIEW view_사원_여
AS
SELECT 이름, 집전화, 입사일, 주소, 성별
FROM 사원
WHERE 성별 = '여';

-- view_사원_여 뷰에서 전화번호에 88이 들어간 사원의 정보 검색
SELECT *
FROM view_사원_여
WHERE 집전화 LIKE '%88%'

-- view_제품별주문수량합에서 주문수량합이
-- 1200개 이상인 레코드를 검색
SELECT *
FROM view_제품별주문수량함
WHERE 주문수량합>=1200;

-- 뷰 정보 확인
SELECT *
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_NAME='view_사원';

-- 뷰 삭제하기
DROP VIEW view_사원;

-- 'view_사원_여'뷰에 내용을 추가
INSERT INTO view_사원_여(사원본호,이름,전화번호,입사일,주소,성별)
VALUES('e12','황여름','(02)587-4959',...);

SELECT * FROM VIEW_사원_여;
SELECT * FROM 사원;

-- view_사원_여

-- 날씨테이블과 인덱스를 생성
-- 컬럼				데이터형식			제약조건
-- 년도				정수					기본키
-- 월					정수					기본키
--  일				정수					기본키
-- 도시				가변문자열20			기본키
-- 기온				실수(총3자리중 소수점 1자리)
-- 습도				정수

-- 주문건수가 많은 고객순으로 고객회사명별 주문건수를 출력
SELECT 고객회사명, COUNT(*) 주문건수
FROM 고객 INNER JOIN 주문
		ON 고객.고객번호=주문.고객번호
GROUP BY 고객회사명
ORDER BY COUNT(*) DESC;

-- 1. 주문금액의 합이 많은 상위 3명의 고객정보를 보이는 뷰를 작성하고 실행
-- 뷰이름 : view_상위3고객
-- 컬럼 : 고객번호, 고객회사명, 담당자명, 주문금액합

CREATE OR REPLACE VIEW view_상위3고객
AS
SELECT 고객번호, 고객회사명, 담당자명,
		SUM(주문수량*단가)주문금액합
FROM 고객 INNER JOIN 주문
		ON 고객.고객번호=주문.고객번호
		INNER JOIN 주문세부
		ON 주문.주문번호=주문세부.주문번호
		
GROUP BY 고객.고객번호, 고객회사명, 담당자명
ORDER BY SUM(주문수량*단가) DESC
LIMIT 3;

-- 2. 제품명별로 주문수량합과 주문금액합을 보이는 뷰는 생성
-- 뷰이름 : view_제품명별주문 요약
-- 칼럼 : 제품명, 주문수량합, 주문금액합
CREATE OR REPLACE VIEW view_제품명별주문요약(제품명,주문수량합,주문금액합),
	SUM(주문수량),

-- 3. view_제품명별주문요약 뷰를 사용하여
-- 주문수량합이 1000개 이상인 레코드를 검색하시오

-- 4. 광역시 에 사는 고객에 대해 고객회사명과 담당자명, 도시정보를 보여주는
-- 뷰를 작성할 것
-- 작성한 뷰를 통해 광역시 이외의 도시에 사는 고객은 삽입되지 않도록 옵션을 설정
-- 오류 발생시 적절하게 조치할 것
-- 뷰이름 : view_광역시고객
CREATE OR REPLACE VIEW view_광역시고객
AS
SELECT 고객번호,고객회사명,담당자명,도시
FROM 고객
WHERE 도시 LIKE '%광역시'
WITH CHECK OPTION;

INSERT INTO view_광역시고객(고객번호,고객회사명,담당자명,도시정보
VALUES('asdf','gds','nt','hie광역시');

-- 피벗테이블
CREATE OR REPLACE VIEW view_도시_직위별_고객수
AS
SELECT 도시,
		SUM(CASE WHEN 담당자 직위='대표 이사'THEN 1 ELSE 0 END) AS '대표 이사'
		SUM(CASE WHEN 담당자 직위='영업%'THEN 1 ELSE 0 END) AS '영업'
		SUM(CASE WHEN 담당자 직위='마케팅%'THEN 1 ELSE 0 END) AS '마케팅'
		SUM(CASE WHEN 담당자 직위='회계%'THEN 1 ELSE 0 END) AS '회계'
FROM 고객


-- 1. 고객테이블에 있는 담당자명을 입력하면
-- 그 담당자의 회사명 주문건수 주문금액합을 반환하는
-- 프로시저를 작성
DELIMITER $$
CREATE PROCEDURE proc_담당자명_주문내역
	(
		IN contact_staff VARCHAR(50),
		OUT company VARCHAR(50),
		OUT order_count INT,
		OUT order_amount int
	)
	
	BEGIN 
		SET company = (SELECT 고객회사명
							FROM 고객
							WHERE 담당자명=contact_staff
							);
		SET order_count = (SELECT COUNT(*)
								 FROM 고객 INNER JOIN 주문
								 	ON 고객.고객번호=주문.고객번호
								 WHERE 담당자명=contact_staff	
								);
		SET order_amount = (SELECT SUM(주문수량*주문세부.단가)
								 FROM 고객 INNER JOIN 주문
								 	ON 고객.고객번호=주문.고객번호
								 		INNER JOIN 주문세부
									ON 주문.주문번호=주문.주문번호
								 WHERE 담당자명=contact_staff	
								);
END $$
DELIMITER;

CALL proc_담당자명_주문내역('이은광',@고객회사,@주문수량합,@주문금액합)

SELECT @고객회사, @주문수량합, @주문금액합;

-- 2. 주문시작일과 주문끝일을 입력하면 해당기간에
-- 주문 금액합이 많았던 상위 10개의 제품에 대해
-- 순위별로 제품명, 주문금액합을 보여주는 프로시저 작성

DROP PROCEDURE proc_주문기간_상위10주문내역;

DELIMITER $$

CREATE PROCEDURE proc_주문기간_상위10주문내역(
	IN fromdate DATE,
	IN todate DATE
)
BEGIN 
	SELECT 제품명, SUM(주문수량*주문세부.단가)
	FROM 제품inner JOIN 주문세부
					ON 제품.제품번호=주문세부.제품번호
				INNER JOIN 주문
					ON 주문.주문번호=주문세부.주문번호;
	WHERE 주문일 BETWEEN '2020-01-01' AND '2020-12-31'
	GROUP BY 제품명
	LIMIT 10;
END $$

DELIMITER;

CALL proc_주문기간_상위10주문내역('2020-01-01','2020-12-31');

-- 3. 생일을 입력하면 나이대를 반환하는 함수를 ㅈ가성
-- (예)20대 초반, 20대 중반 등
-- 이때 나이 끝자리가 3보다 작거나 같으면'초반'
-- 7보다 작거나 같으면 중반
-- 그 외는 후반으로

DELIMITER $$

CREATE FUNCTION func_나이대(birthday DATE)
	RETURNS VARCHAR(20)

BEGIN
	DECLARE 나이 INT;
	DECLARE 나이대 VARCHAR(20);
	
	SET 나이 = (YEAR(NOW()) - YEAR(birthday));
	SET 나이대 = (SELECT CONCAT(나이DIV 10*10,"대",
						CASE WHEN RIGHT(나이,1)<=3 THEN '초반'
							  WHEN RIGHT(나이,1)<=7 THEN '중반'
							  ELSE '후반'
							  END)
							  );
		RETURN 나이대;
END $$
DELIMITER;

SELECT 사원번호,이름,생일,func_나이대(생일) AS 나이대
FROM 사원;

-- 4. 주문세부 테이블에 레코드가 추가될 떄 마다
-- 주문된 수량만큼 제품 테이블의 재고수량에서 빠지는 트리거를 작성

DELIMITER $$

CREATE TRIGGER trigger_주문수량_재고수정
	AFTER INSERT ON 주문세부
	FOR EACH ROW
	BEGIN
		UPDATE 제품
		SET 재고=재고-NEW.주문수량
		WHERE 제품번호=NEW.제품번호;
END $$
DELIMITER;

SELECT * FROM 제품 WHERE 제품번호=12;

INSERT INTO 주문세부
VALUES ('H0248',12,1380,20,0); 

-- 5. 제품명의 일부를 입력하면 해당 제품들에 대하여
-- 제품명별로 주문수량합, 주문금액합을 보여주는
-- 프로시저를 작성

DELIMITER $$
CREATE PRODECURE proc_제품명_주문내역(
	IN product_name VARCHAR(50)
)

BEGIN 
	SELECT 제품명, SUM(주문수량)주문수량합,
			 SUM(주문세부.단가*주문수량)주문금액합
	FROM 제품 INNER JOIN 주문세부
			 ON 제품.제품번호=주문세부.제품번호
	WHERE 제품명 LIKE CONCAT('%',product_name,'%')
	GROUP BY 제품명;
END $$

DELIMITER;

CALL proc_제품명_주문내역('캔디');

-- 6. 생일을 입력하면 연령구분을 반환하는 함수 생성
--		나이가 20살보다 적으면 미성년
--		나이가 20살보다 많고 30살보다 적으면 청년층
--		나이가 30살보다 많고 55살보다 적으면 중년충
--		나이가 55살보다 많고 70살보다 적으면 장년층

DELIMITER $$

CREATE FUNCTION func_연령구분(birthday DATE)
	RETURNS VARCHAR(20)
	
BEGIN
	DECLARE 나이 INT;
	DECLARE 연령구분 VARCHAR(20);
	
	SET 나이 = YEAR(NOW())-YEAR(birthday);
	
	SET 연령구분 = (SELECT CASE
									WHEN 나이 < 20 THEN '미성년'
									WHEN 나이 < 30 THEN '청년층'
									WHEN 나이 < 55 THEN '중년층'
									WHEN 나이 < 70 THEN '장년층'
									ELSE '노년층'
						 END);
	RETURN 연령구분;
END $$

DELIMITER;

SELECT 이름, 생일, YEAR(NOW())-YEAR(생일)

-- 부산광역시 고객의 평균 마일리지
SELECT AVG(마일리지),
			고객회사명,
			마일리지,
			AVG(마일리지)OVER()
FROM 고객
WHERE 도시='부산광역시';

-- 부산광역시 고객에 대해 고객번호, 고객회사명, 마일리지,
-- 평균마일리지, 각 고객의 마일리지와 평균 마일리지간의 차이를 출력

SELECT 고객번호, 도시, 마일ㄹ지ㅣ,
		AVG(마일리지) OVER(PARTITION BY 도시) AS 평균마일리지,
		마일리지-AVG(마일리지) OVER(PARTITION BY 도시) AS 차이
FROM 고객
WHERE 지역='경기도';

-- 부산광역시의 고객에 대해 고객번호, 마일리지,
-- 모든 고객의 마일리지 합, 고객번호 순으로
-- 마일리지의 누적합을 계산출력
SELECT 고객번호, 마일리지, SUM(마일리지)

-- 부산광역시 고객에 대해 마일리지가 많은 순서대로 순위 매기기
SELECT 고객번호, 고객회사명, 담당자명, 마일리지,
			RANK() OVER(ORDER BY 마일리지 DESC)AS 순위
FROM 고객
WHERE 도시 = '부산광역시';

-- 경기도지역의 도시별로 마일리지가 많은 고객부터 순위

-- 시럽 제품에 대해 단가를 기준으로 백분율 순위를 출력
SELECT 제품명,단가,
			PERCENT_RANK() OVER(ORDER BY 단가)
FROM 제품
WHERE 제품명 LIKE '%시럽%';

SELECT 고객번호, 도시, 마일리지,
		NTILE(3) OVER(ORDER BY 마일리지)AS 그룹
FROM 고객
WHERE 도시 = '인천광역시';

SELECT 고객회사명, 마일리지,
	FIRST_VALUE(고객회사명)OVER(ORDER BY 마일리지)
			AS 최소마일리지회사명,
	FIRST_VALUE(마일리지)OVER(ORDER BY 마일리지)
			AS 최소마일리지,
	마일리지-FIRST_VALUE(마일리지)OVER(ORDER BY 마일리지)
			AS 차이
FROM 고객
WHERE 도시='부산광역시';

-- 1. 2021년도의 주문에 대해 월별 주문금액합과 월별 주문금액합에 대한
-- 누적합을 출력
SELECT 주문월, 주문금액합,
			SUM(주문금액합) OVER(ORDER BY 주문월) AS 누적금액합
FROM (SELECT MONTH(주문일) AS 주문월,
				 SUM(주문수량*단가) AS 주문금액합
		FROM 주문 INNER JOIN 주문세부
			ON 주문.주문번호 = 주문세부.주문번호
		WHERE YEAR(주문일) = 2021
		GROUP BY MONTH(주문일)
		) AS 월별주문;


-- 2. 제품 테이블에서 단가를 기준으로 세 그룹으로 나누시오
SELECT *, NTILE(3)OVER (ORDER BY 단가)AS 그룹
FROM 제품;

-- 3. 주문세부 테이블에서 각 제품별로 주문합이 많은것부터 
-- 순위를 출력
SELECT 제품번호, SUM(단가*주문수량)주문금액,
			RANK() OVER(ORDER BY SUM(단가*주문수량)DESC) 순위
FROM 주문세부
GROUP BY 제품번호;


CREATE TABLE DEPT
	AS SELECT * FROM 부서;

-- DEPT 테이블에 명령어 실행
INSERT INTO DEPT
VALUES('A6','인사부');

UPDATE DEPT
SET 부서명 = '총무부'
WHERE 부서번호='A1';

DELETE FROM DEPT
WHERE 부서번호='A3';

SELECT * FROM DEPT;

SHOW VARIABLES LIKE 'Autocommit%';

SET AUTOCOMMIT = FALSE;

-- 실행취소
ROLLBACK;

-- 저장하기(DB에 반영하기)
COMMIT;

UPDATE DEPT
SET 부서명='개발부';

INSERT INTO DEPT
VALUES('A7','개발부');

SAVEPOINT INS;

UPDATE DEPT
SET 부서명 = '관리부'
WHERE 부서번호 = 'A4';

SAVEPOINT UP;

DELETE FROM DEPT
WHERE 부서번호 = 'A5';

SAVEPOINT DEL;

SELECT * FROM DEPT;

ROLLBACK TO UP;

UPDATE DEPT
SET 부서명='개발부'
WHERE 부서번호='A1';


