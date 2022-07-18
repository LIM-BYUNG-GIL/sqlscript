CREATE TABLE tbl_students (
	student_no char(7) PRIMARY KEY,
	name nvarchar2(20) NOT NULL,
	age NUMBER,
	address nvarchar2(20)
);

INSERT INTO tbl_students VALUES (2021001,'김모모',16,'서초구');
INSERT INTO tbl_students VALUES (2019019,'강다현',18,'강남구');

SELECT * FROM tbl_students;

CREATE TABLE tbl_scores (
	student_no char(7) NOT NULL,
	subject nvarchar2(20) NOT NULL,
	score nvarchar2(3) NOT NULL,
	teacher nvarchar2(20) NOT NULL,
	smester char(6) NOT NULL
);

-- alter table ~ add constraint
ALTER TABLE tbl_scores ADD CONSTRAINT pk_scores PRIMARY KEY (student_no,subject);
ALTER TABLE tbl_scores ADD CONSTRAINT fk_scores FOREIGN KEY (student_no) REFERENCES tbl_students(student_no);

INSERT INTO tbl_scores VALUES ('2021001','국어',89,'이나연','2022_1');
INSERT INTO tbl_scores VALUES ('2021001','영어',78,'김길동','2022_1');
INSERT INTO tbl_scores VALUES ('2021001','과학',67,'박세리','2021_2');
INSERT INTO tbl_scores VALUES ('2019019','국어',92,'이나연','2019_2');
INSERT INTO tbl_scores VALUES ('2019019','영어',85,'박지성','2019_2');
INSERT INTO tbl_scores VALUES ('2019019','과학',88,'박세리','2020_1');

SELECT * FROM tbl_scores;