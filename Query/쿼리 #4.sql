-- 문자수 확인
SELECT CHAR_LENGTH('ABCDE'),
		 LENGTH('ABCDE'),
		 CHAR_LENGTH('안녕'),
		 LENGTH('안녕');

-- 문자열 연결
SELECT CONCAT('A','B','C'),
		 CONCAT_WS('-','1','2','3');
		 
-- 문자열 반환
SELECT LEFT('데이터베이스 공부', 3),
		 RIGHT('데이터베이스 공부', 2),
		 SUBSTR('데이터베이스 공부', 2, 5),
		 SUBSTR('데이터베이스 공부', 5);
		 
SELECT SUBSTRING_INDEX("울산시 남구 삼산동", " ", 2);

-- 특정 문자로 채우기
SELECT RPAD("A", 5, "*");

-- 'SQL'문자열의 앞 7칸은 #으로 채우고
-- 'SQL'문자열 뒤 2칸에는 '*'로 채워서 출력
SELECT LPAD('SQL',10,'#'),
	 	 RPAD('SQL',5,'*');
	 	 
SELECT LTRIM('     SQL     '),
		 RTRIM('     SQL     '),
		 TRIM('     SQL     ');
	
-- 공백제거	 
SELECT LENGTH('     SQL     '),
		 LENGTH (LTRIM('     SQL     ')),
		 LENGTH (RTRIM('     SQL     ')),
		 LENGTH (TRIM('     SQL     '));

SELECT TRIM(BOTH 'ABC' FROM 'ABCSQLABCABC'),
		 TRIM(LEADING 'ABC' FROM 'ABCSQLABCABC'),
		 TRIM(TRAILING 'ABC' FROM 'ABCSQLABCABC');
		 
-- 문자열의 위치값
SELECT FIELD('JAVA', 'SQL', 'JAVA', 'C'),
		 FIND_IN_SET('JAVA','SQL,JAVA,C'),
		 INSTR('문자열의 위치값 찾기','위치'),
		 LOCATE('위치','문자열의 위치값 찾기');
		 
-- 지정한 위치에 있는 문자열 반환
SELECT ELT(2, 'SQL', 'JAVA', 'C');

-- 문자열 반복
SELECT REPEAT('*', 5);

-- 문자열 대체
SELECT REPLACE('010.1111.2222','.','-');

-- 문자열 뒤집기
SELECT REVERSE('HELLO WORLD');

-- 숫자형 함수

-- 숫자 올림, 내림, 반올림, 버림
SELECT CEILING(123.56),
		 FLOOR(123.56),
		 ROUND(123.56),
		 TRUNCATE(123.56, 1);
		 
-- 숫자값이 양수인지 음수인지 확인
SELECT ABS(-100),
		 ABS(100),
		 SIGN(-120),
		 SIGN(120);

-- 나머지
SELECT MOD(234,5),
		 234 % 5,
		 234 MOD 5;
		 
-- 랜덤수
SELECT RAND()*100;

-- 날짜/시간

-- 현재 날짜, 시간
SELECT NOW(), SYSDATE(), CURDATE(), CURTIME();

SELECT NOW(),
		 YEAR(NOW()),
		 QUARTER(NOW()),
		 MONTH(NOW()),
		 DAY(NOW()),
		 HOUR(NOW()),
		 MINUTE(NOW()),
		 SECOND(NOW());


-- 기간 반환 함수
SELECT NOW(),
		 DATEDIFF('2024-12-31',NOW()),
		 DATEDIFF(NOW(), '2024-12-31'),
		 TIMESTAMPDIFF(YEAR, NOW(), '2026-9-25'),
		 TIMESTAMPDIFF(MONTH, NOW(), '2026-9-25'),
		 TIMESTAMPDIFF(DAY, NOW(), '2026-9-25');

-- 기간을 반영하는 함수 
SELECT NOW(),
		 SUBDATE(NOW(), 50),
		 SUBDATE(NOW(), INTERVAL 50 DAY),
		 SUBDATE(NOW(), INTERVAL 50 MONTH),
		 SUBDATE(NOW(), INTERVAL 50 HOUR);
		 
-- 날짜 반환 함수
-- WEEKDAY : 월요일(0) ~ 일요일(6)
SELECT NOW(),
		 LAST_DAY(NOW()),
		 DAYOFYEAR(NOW()),
		 MONTHNAME(NOW()),
		 WEEKDAY(NOW());

-- 형 변환 함수
-- 문자 '1'을 숫자형식으로 변경
-- 숫자 2를 문자 형식으로 변경
SELECT CAST('1'AS UNSIGNED),
		 CAST(2 AS CHAR),
		 CONVERT('1', UNSIGNED),
		 CONVERT(2, CHAR);
		 
SELECT IF(1>2,"참","거짓");

-- 12500원 제품을 450개 이상한 주문한 금액이
-- 5000000원 이상이면 '할인',아니면'할인없음'
SELECT IF(12500*500 > 5000000,"할인","할인없음");

SELECT IFNULL(1, 0),
		 IFNULL(NULL, 0),
		 IFNULL(1/0, 'OK');
		 
SELECT NULLIF(10*2, 20),
		 NULLIF(100*2, 20);
		 
-- 12500원 제품을 450개 주문한 경우
-- 주문금액이 5000000원 이상이면 '초과 달성'
-- 4000000원 이상이면'달성'
-- 나머지는 '미달성'으로 출력

SELECT CASE WHEN 12500*450 > 5000000 THEN "초과달성"
				WHEN 12500*450 > 4000000 THEN "달성"
				ELSE "미달성"
		 END;

SELECT RPAD(고객회사명,10,'#')
FROM 고객;


-- 1. 고객테이블에서 고객회사명과 전화번호를
-- 다른 형태로 출력하도록 하시오..
-- 조건1) 고객회사명2 :  기존 고객회사명 중 앞 두자리를 *로 변환하여 출력
-- 조건2) 전화번호2: 기존 전화번호를 XX-XXXX-XXXX형식으로 변환하여 출력
SELECT REPLACE(고객회사명,LPAD(고객회사명,2),'**')"고객회사명2",
		 REPLACE(SUBSTR(전화번호,2),")","-")"전화번호2"
FROM 고객;

-- 2. 주문 세부 테이블의 모든 열과 주문금액, 할인금액, 실제 주문금액을 출력하시오.
--    단, 모든 금액은 1의 단위에서 버림하고 10원 단위까지 보이도록 할 것
-- 주문금액 : 주문 수량 * 단가
-- 할인금액 : 주문 수량 * 단가 * 할인율
-- 실주문금액 : 주문금액 - 할인금액
SELECT *,
		주문수량*단가 "주문금액",
		TRUNCATE(주문수량*단가*할인율, -1) "할인금액",
		(주문수량*단가)-(주문수량*단가*할인율)"실주문금액"
FROM 주문세부;

-- 3. 사원테이블에서 전체 사원의 이름, 생일, 만나이,
--		입사일, 입사일수, 입사한지 1000일 후의 날짜를 출력
SELECT 이름,생일,입사일,
		 TIMESTAMPDIFF(YEAR, 생일, CURDATE()) "만나이",
		 DATEDIFF(CURDATE(),입사일)"입사일수",
		 ADDDATE(입사일,1000)"1000일 후"
FROM 사원;

-- 4. 고객테이블에서 도서 칼럼의 데이터를 다음 조건에 따라 대도시와 도시로 구분하고 마일리지 점수에 따라서 vvip,vip,일반고객으로 구분하여 출력
-- 도시구분 : 특별시나 광역시는 대도시 / 나머지는 도시로 구분
-- 마일리지 구분 : 마일리지가 100000점 이상이면 VVIP 고객/ 10000점 이상이면VIP / 나머지 일반고객
SELECT 고객회사명, 도시,
		 IF(도시 LIKE '%특별시'OR 도시 LIKE '%광역시','대도시','도시')"도시구분",
		 CASE WHEN 마일리지 >= 1000000 THEN "VVIP"
				WHEN 마일리지 >= 10000 THEN "VIP"
				ELSE "일반고객"
		 END"고객등급"
FROM 고객;

-- 5. 주문테이블에서 주문번호, 고객번호, 주문일, 주문년도
-- 분기, 월, 일, 요일 한글요일을 출력
SELECT 주문번호, 고객번호, 주문일,
		 YEAR(주문일)"주문 년도",
		 QUARTER(주문일)"분기",
		 MONTH(주문일)"주문 월",
		 DAY(주문일)"주문 일",
		 CASE WEEKDAY(주문일) WHEN 0 THEN '월요일'
		 							 WHEN 1 THEN '화요일'
		 							 WHEN 2 THEN '수요일'
		 							 WHEN 3 THEN '목요일'
		 							 WHEN 4 THEN '금요일'
	 						    	 WHEN 5 THEN '토요일'
		 							 WHEN 6 THEN '일요일'
		 END"주문 요일"
FROM 주문;



-- 6. 주문 테이블에서 요청일보다 발송일이 7일 이상 느린 제품을 출력
SELECT *,
		 DATEDIFF(발송일, 요청일)"지연일수"
FROM 주문
WHERE DATEDIFF(발송일, 요청일) >=7;

-- 7. 이름에 '정'이 들어가는 담당자명을 검색하여 출력
SELECT *
FROM 고객
WHERE INSTR(담당자명,'정')>1;

-- 8. 2020년 2사분기 주문내역을 출력
SELECT *
FROM 주문
WHERE YEAR(주문일)=2020 AND QUARTER(주문일) =2;

-- 9. 제품번호, 제품명, 재고, 재고구분을 출력
-- 재고구분 : 재고가 100개 이상이면 '과다재고' 10개 이상이면 '적정' 나머지는 '재고 부족'
SELECT 제품번호, 제품명, 재고,
		 CASE WHEN 재고 >= 100 THEN'과다재고'
		      WHEN 재고 >= 10 THEN'적정'
		      ELSE'재고부족'
		 END "재고구분"
FROM 제품;

SELECT movieNum, theaterNum, seat_yn, 
		 CASE WHEN seat_yn = 'Y' THEN '예매가능'
				WHEN seat_yn = 'N' THEN '예매할 수 있는 좌석이 없습니다.'
		 END "예매가능여부"
FROM seats;

-- 10. 입사한지 60개월이 지난 사원을 찾아
-- 이름, 부서번호, 직위, 입사일, 입사일수, 입사개월수 출력
SELECT 이름, 부서번호, 직위, 입사일,
		 DATEDIFF(CURDATE(), 입사일)"입사일수",
		 TIMESTAMPDIFF(MONTH, 입사일, CURDATE())"입사개월수"
FROM 사원
WHERE TIMESTAMPDIFF(MONTH, 입사일, CURDATE()) > 60;

