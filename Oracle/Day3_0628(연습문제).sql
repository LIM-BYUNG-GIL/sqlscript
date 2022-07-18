CREATE TABLE tbl_students (
	student_no char(7) PRIMARY KEY,
	name nvarchar2(20) NOT NULL,
	age NUMBER,
	address nvarchar2(20)
);

INSERT INTO tbl_students VALUES (2021001,'����',16,'���ʱ�');
INSERT INTO tbl_students VALUES (2019019,'������',18,'������');

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

INSERT INTO tbl_scores VALUES ('2021001','����',89,'�̳���','2022_1');
INSERT INTO tbl_scores VALUES ('2021001','����',78,'��浿','2022_1');
INSERT INTO tbl_scores VALUES ('2021001','����',67,'�ڼ���','2021_2');
INSERT INTO tbl_scores VALUES ('2019019','����',92,'�̳���','2019_2');
INSERT INTO tbl_scores VALUES ('2019019','����',85,'������','2019_2');
INSERT INTO tbl_scores VALUES ('2019019','����',88,'�ڼ���','2020_1');

SELECT * FROM tbl_scores;