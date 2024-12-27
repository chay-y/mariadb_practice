-- 과목테이블에서 레코드를 삭제하면
-- 수강 평가 테이블에서도 해당 과목에 대한 평가 레코드가
-- 삭제되도록 설정

-- 수강평가 명세서

/*
	컬럼명			데이터타입			제약조건
	평가순번			정수형			기본키,자동번호
	학번				고정문자형5			학생 테이블의 학번 참조
	과목번호			고정문자형5				과목 테이블의 과목번호 참조
	평점				정수형				0-5까지입력가능
	과목평가				가변문자형500
	평가일시			날짜시간형			현재 일시 자동 등록
*/

CREATE TABLE 수강평가(
	평가순번 INT PRIMARY KEY AUTO_INCREMENT,
	학번 CHAR(5),
	과목번호CHAR(5),
	평점 INT CHECK(평점 BETWEEN 0 AND 5),
	과목평가 VARCHAR(500),
	평가일시 DATE DEFAULT CURRENT_TIMESTAMP,
	
	FOREIGN KEY (학번) REFERENCES 학생(학번),
	FOREIGN KEY (과목번호) REFERENCES 과목(과목번호)
	ON DELETE CASCADE
);

-- 수강평가 테이블에 레코드 추가
INSERT INTO 수강평가(학번, 과목번호, 평점, 과목평가)
VALUES('S0001','C0001',5,'구웃'),
		('S0001','C0002',5,'조아여'),
		('S0003','C0003',5,'나이스'),
		('S0004','C0004',5,'베스트');

DELETE FROM 과목
WHERE 과목번호 = 'C0003';

DELETE FROM 과목
WHERE 과목번호 = 'C0001';

-- 계시판 테이블을 생성하려고 한다.
-- 계시판 테이블 명세서
-- 외래키의 제약조건 이름을 적절하게 설정하시오

/*
	컬럼명			데이터타입				제약조건
	번호					정수형					기본키,자동삽입
	제목					가변문자열50			필수입력
	내용					가변문자열1000		
	작성자				고정문자열5			학생 테이블의 학번 참조
	작성일				날짜					현재 날짜시간 자동 입력
*/

CREATE TABLE 계시판(
	번호 INT PRIMARY KEY AUTO_INCREMENT,
	제목 VARCHAR(5) NOT NULL,
	내용 VARCHAR(1000),
	작성자 CHAR(5),
	작성일 DATE DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fx_게시판_작성자 FOREIGN KEY (작성자) REFERENCE 학생(학번)
);

INSERT INTO 계시판(제목,내용,작성자)
VALUES('HELLO','안녕하세요','1'),
		('HEY','저기요','달달'),
		('WHAT','뭐에요','VV'),
		('THIS','뭔가요','라임');