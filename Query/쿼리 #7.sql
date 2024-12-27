-- 그린아카데미 데이터베이스를 생성
CREATE DATABASE 그린아카데미;

-- DB 사용하도록 변경
USE 그린아카데미;

-- 학과 테이블 명세서

/*
	컬럼명		데이터타입
	학과번호		고정문자형 2글자
	학과명		가변문자형 20글자
	학과장명		가변문자형 20글자			
*/

-- 학과의 데이터
/*
	학과번호		학과명		학과장명`그린무역``그린무역``그린아카데미``그린아카데미`sys`그린아카데미`
	AA			컴퓨터공학과		배경민
	BB			소프트웨어학과		김남준
	CC			디자인융합학과		박선영
*/


CREATE TABLE 학과(
	학과번호 CHAR(2),
	학과명 VARCHAR(20),
	학과장명 VARCHAR(20)
);

INSERT INTO 학과(학과번호, 학과명, 학과장명)
VALUES('AA','컴퓨터공학과','배경민'),
		('BB','소프트웨어학과','김남준'),
		('CC','디자인융합학과','박선영');

-- 학생 테이블 생성 
/*
	컬럼명		데이터타입
	학번			고정문자형 5글자
	이름			가변문자형 20글자
	생일			날짜형
	연락처		가변문자형 20글자
	학과명		고정문자형 2글자	
*/

CREATE TABLE 학생(
	학번 CHAR(5),
	이름 VARCHAR(5),
	생일 DATE,
	연락처 VARCHAR(20),
	학과번호 CHAR(2)
);

-- 학생 테이블 데이터 입력
/*
	학과번호		이름		생일			연락처			학과번호
	S0001			이윤주	2020-01-30 01033334444		AA
	S0002			이승은	2021-02-23 NULL				AA
	S0003			백재용	2018-03-31 01077778888		DD
*/

INSERT INTO 학생(학번,이름,생일,연락처,학과번호)
VALUES
		
-- 기존 테이블의 구조와 데이터를 그대로 복사
-- 학생 테이블을 사용하여 휴학생 테이블을 생성
-- 데이터는 복사하지 않고 구조만 복사

CREATE TABLE 휴학생 AS SELECT * FROM 학생;

DROP TABLE 휴학생;

CREATE TABLE 휴학생 AS SELECT * FROM 학생 WHERE 1=2;

-- 헬스장에서 회원을 관리하는 테이블을 생성
-- 이때 체질량지수가 자동 계산되어서 저장되도록 설정
-- 회원 테이블 명세서
/*
	컬럼명		데이터타입				제약조건
	아이디		가변문자형 20글자		기본키
	회원명		가변문자형 20글자
	키				정수형
	몸무게		 정수형
	체질량지수  실수형					몸무게/POWER(키,2)
*/

CREATE TABLE 회원(
	아이디 VARCHAR(20) PRIMARY KEY,
	회원명 VARCHAR(20),
	키 INT,
	몸무게 INT,
	체질량지수 DECIMAL(4,1) AS (몸무게/POWER(키/100,2)) STORED
);

INSERT INTO 회원(아이디,회원명,키,몸무게)
VALUES('GREEN','김그린',178,60);

-- 학생 테이블에 성별 칼럼을 추가
-- 성별 고정문자형 1글자

ALTER TABLE 학생 ADD COLUMN 성별 CHAR(1);

-- 학생 테이블의 성별 칼럼의 데이터 타입을 변경
-- 성별 가변문자형 2글자

ALTER TABLE 학생 MODIFY COLUMN 성별 VARCHAR(2);

-- 학생 테이블에서 연락처 컬럼명을 휴대폰번호로 변경
ALTER TABLE 학생 CHANGE COLUMN 연락처 휴대폰번호 VARCHAR(20);

-- 학생 테이블에서 성별 칼럼을 삭제
ALTER TABLE 학생 DROP COLUMN 성별;

-- 테이블명 변경
-- 휴학생 테이블명을 졸업생 테이블명으로 변경
ALTER TABLE 휴학생 RENAME 졸업생;

-- 학과, 학생 테이블을 삭제
DROP TABLE 학과;
DROP TABLE 학생;

CREATE TABLE 학생(
	학번 CHAR(5),
	이름 VARCHAR(5),
	생일 DATE,
	연락처 VARCHAR(20),
	학과번호 CHAR(2)
);

-- 학생 테이블명을 STUDENT 로 변경
ALTER TABLE 학생 RENAME student;

-- 학번 컬럼을 STUDENT_ID로 변경
ALTER TABLE student CHANGE COLUMN 학번 student_id CHAR(5);

-- STUDENT 테이블에 ADDRESS, 가변문자형 10글자 컬럼을 추가
ALTER TABLE student ADD COLUMN address VARCHAR(10);

-- ADDRESS 컬럼의 데이터타입 크기를 50으로 변경
ALTER TABLE student MODIFY COLUMN address VARCHAR(50);

-- ADDRESS 컬럼을 삭제
ALTER TABLE student DROP COLUMN address;

/*
기본키의 개체무결성
- 중복되지 않는 유일한 값(공백 불가능)

외래키의 참조무결성
- 기본키에 있는 값만 가질 수 있다.

- 기본키 : 각 행을 유일하게 구별하는데 사용되는 키
- 후보키 : 기본키로 선택될 수 있는 키들.
- 대체키 : 후보키 중에서 기본키로 선택되지 않은 키.
- 슈퍼키 : 하니 이상의 속성의 조합. 테이블의 각 행을 유일하게 구별할 수 있는 모든 키
				(유일성 만족, 최소성은 만족하지 않음..)
- 복합키 : 두개 이상의 열을 결합해서 만든 키.
				개별 속성만으로 유일성을 보장할 수 없을 때 사용
- 외래키 : 항 테이블의 열이 다른 테이블의 기본키와 연관될 때 사용하는 키
*/

-- 학과테이블을 생성
-- 학과 테이블 명세서
/*
	컬럼명			데이터타입			제약조건
	학과번호			고정문자형2글자	기본키
	학과명			가변문자형20글자	필수입력
	학과장명			가변문자형 20글자	
*/

CREATE TABLE 학과_(
	학과번호 CHAR(2) PRIMARY KEY,
	학과명 VARCHAR(20) NOT NULL,
	학과장명 VARCHAR(20)
);

-- 제약조건을 추가하여 학생 테이블을 새로 생성
-- 학생 테이블 명세서

/*
	컬럼명				데이터타입				제약조건
	학번				고정문자형 5				기본키
	이름					가변문자형 20			필수입력
	생일					날짜형					필수입력
	연락처				가변문자형 20			유일한 값만 입력가능
	학과번호				고정문자형2			학과 테이블의  학과번호 참조
	성별					고정문자형 1 			남 또는 여만 가능
	등록일					날짜형				오늘 날짜 자동 입력
*/

CREATE TABLE 학생(
	학번 CHAR(5) PRIMARY KEY,
	이름 VARCHAR(20) NOT NULL,
	생일 DATE NOT NULL,
	연락처 VARCHAR(20) UNIQUE,
	학과번호 CHAR(2) REFERENCE 학과(학과번호),
	성별 CHAR(1) CHECK(성별 IN ('남', '여')),
	등록일 DATE (CURDATE())
);

CREATE TABLE 학생(
	학번 CHAR(5) PRIMARY KEY,
	이름 VARCHAR(20) NOT NULL,
	생일 DATE NOT NULL,
	연락처 VARCHAR(20),
	학과번호 CHAR(2),
	성별 CHAR(1),
	등록일 DATE (CURDATE()),
	
	PRIMARY KEY(학번),
	UNIQUE(연락처),
	CHECK(성별 IN ('남', '여')),
	FOREIGN KEY (학과번호) REFERENCES 학과_(학과번호)
);

CREATE TABLE members(
	user_name VARCHAR(20) NOT NULL,
	phoneNumber VARCHAR(20) NOT NULL,
	id VARCHAR(20) NOT NULL,
	pw VARCHAR(20) NOT NULL,
	memberNum CHAR(5) PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE theater(
	theaterNum CHAR(5) PRIMARY KEY NOT NULL,
	movieNum CHAR(5) PRIMARY KEY NOT NULL,
	th_name VARCHAR(30) NOT NULL,
	th_seats INT(10) NOT NULL,
	m_name VARCHAR(50) NOT NULL
);

CREATE TABLE seats(
	seatNum CHAR(5) PRIMARY KEY NOT NULL,
	row_num INT(2) NOT NULL,
	col_num INT(2) NOT NULL,
	seat_yn CHAR(1) NOT NULL,
	theaterNum CHAR(5) NOT NULL,
	
	CHECK(seat_yn IN('y','n')),
	FOREIGN KEY (theaterNum) REFERENCES 상영관(theaterNum)
);

CREATE TABLE reservation(
	reservNum CHAR(5) PRIMARY KEY NOT NULL,
	memberNum CHAR(5) NOT NULL,
	seatNum CHAR(5) NOT NULL,
	theaterNum CHAR(5) NOT NULL,
	movieNum CHAR(5) NOT NULL,
	
	FOREIGN KEY (memberNum) REFERENCES members(memberNum),
	FOREIGN KEY (seatNum) REFERENCES seats(seatNum),
	FOREIGN KEY (theaterNum) REFERENCES theater(theaterNum),
	FOREIGN KEY (movieNum) REFERENCES theater(movieNum)
);

-- 제약조건을 추가하여 과목테이블 생성
-- 과목 테이블 명세서
/*
	컬럼명		데이터타입			제약조건
	과목번호		고정문자형5			기본키
	과목명		가변문자형20			필수입력
	학점			정수형					필수입력, 2~4학점까지만 입력가능
	구분			가변문자형20			전공, 교양, 일반만 입력 가능
*/

CREATE TABLE 과목(
	과목번호	CHAR(5) PRIMARY KEY,
	과목명 VARCHAR(20) NOT NULL,
	학점 INT NOT NULL CHECK(학점 BETWEEN 2 AND 4),
	구분 VARCHAR(20) CHECK(학점 IN ('전공', '교양', '일반'))
);

-- 제약조건을 추가하여 수강_1 테이블을 생성
-- 기본키는 수강년도, 수강학기, 학번, 과목번호를 모두 포함

/*
	컬럼명			데이터타입			제약조건
	수강년도			고정문자형 4			필수입력
	수강학기			가변문자형20			필수입력, 1학기, 2학기, 여름학기, 겨울학기만
	학번				고정문자형5			필수입력, 학생테이블의 학번 참조
	과목번호			고정문자형 5			필수입력, 과목테이블의 과목번호 참조
	성적				실수형					0~4.5까지 입력 가능 
*/

CREATE TABLE 수강_1(
	수강년도 CHAR(4) NOT NULL,
	수강학기 VARCHAR(20) NOT NULL CHECK(수강학기 IN('1학기','2학기','여름학기','겨울학기')),
	학번 CHAR(5) NOT NULL,
	과목번호 CHAR(5) NOT NULL,
	성적 DECIMAL(3,1) CHECK (성적 BETWEEN 0 AND 4.5),
	
	PRIMARY KEY (수강년도, 수강학기, 학번, 과목번호),
	FOREIGN KEY (학번) REFERENCES 학생(학번),
	FOREIGN KEY (과목번호) REFERENCES 과목(과목번호)
);

CREATE TABLE 수강_2(
	수강년도 INT PRIMARY KEY AUTO_INCREMENT,
	수강학기 VARCHAR(20) NOT NULL CHECK(수강학기 IN('1학기','2학기','여름학기','겨울학기')),
	학번 CHAR(5) NOT NULL,
	과목번호 CHAR(5) NOT NULL,
	성적 DECIMAL(3,1) CHECK (성적 BETWEEN 0 AND 4.5),
	
	PRIMARY KEY (수강년도, 수강학기, 학번, 과목번호),
	FOREIGN KEY (학번) REFERENCES 학생(학번),
	FOREIGN KEY (과목번호) REFERENCES 과목(과목번호)
);
 INSERT INTO 학생(학번, 이름,생일,학과번호)
VALUES('S0001','이윤주','2020-01-30','AA');

INSERT INTO 학생(학번, 이름,생일,학과번호)
VALUES('S0002','이승은','2021-02-23','AA');

INSERT INTO 학생(학번, 이름,생일,학과번호)
VALUES('S0003','백재용','2018-03-31','DD');

