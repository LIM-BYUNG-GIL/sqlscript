-- ȸ���� ������ '�뿩'�ϴ� ����ó���� ���õ� ���̺�.
CREATE TABLE book_member(
	mem_idx number(5) PRIMARY KEY,	-- ȸ����ȣ
	name varchar2(20) NOT NULL,
	email varchar2(20) NOT NULL,
	tel varchar2(20),
	password varchar2(10)
);

CREATE TABLE tbl_book(
	bcode char(5) PRIMARY KEY,
	title varchar2(30) NOT NULL,
	writer varchar2(20),
	publisher varchar2(20),
	pdate DATE
);

CREATE TABLE tbl_bookrent(			-- '�뿩' ���� ����
	rent_no number(5) PRIMARY KEY,	-- �Ϸù�ȣ
	mem_idx number(5) NOT NULL,
	bcode char(5) NOT NULL,
	rent_date DATE NOT NULL,		-- ���� ��¥
	exp_date DATE NOT NULL,			-- �ݳ����� ��¥
	return_date DATE,				-- ���� �ݳ� ��¥
	delay_days number(3),			-- ��ü �ϼ�
	CONSTRAINT fk1 FOREIGN KEY (mem_idx)
			REFERENCES book_member(mem_idx),
	CONSTRAINT fk2 FOREIGN KEY (bcode)
			REFERENCES tbl_book(bcode)
);

-- ȸ����ȣ ������
CREATE SEQUENCE memidx_seq START WITH 10001;
-- �뿩 �Ϸù�ȣ�� ���� ������
CREATE SEQUENCE bookrent_seq;

-- ȸ�������� �߰�
INSERT INTO book_member (mem_idx, name, email, tel, password)
	VALUES (memidx_seq.nextval, '���ϳ�','honey@naver.com','010-9889-0567','1122');
INSERT INTO book_member (mem_idx, name, email, tel, password)
	VALUES (memidx_seq.nextval, '�̼���','jong@daum.net','010-2354-6773','2345');
INSERT INTO book_member (mem_idx, name, email, tel, password)
	VALUES (memidx_seq.nextval, '�����','lucky@korea.com','010-5467-8792','9876');
INSERT INTO book_member (mem_idx, name, email, tel, password)
	VALUES (memidx_seq.nextval, '���浿','nadong@kkk.net','010-3456-8765','3456');
INSERT INTO book_member (mem_idx, name, email, tel, password)
	VALUES (memidx_seq.nextval, '������','haha@korea.net','010-3987-9087','1234');

INSERT INTO tbl_book (bcode, title, writer, publisher, pdate)
VALUES ('A1101','�ڽ���','Į���̰�','���̾𽺺Ͻ�',to_date('06/12/01','YY/MM/DD'));
-- ���ڿ����� ��¥Ÿ�����δ� �ڵ�ĳ���õ˴ϴ�. �Լ��� ����� ������ to_date() �Լ�����մϴ�.
-- ���� : ��¥Ÿ���� ���ڿ��� ��ȯ��Ű�� ���� ? to_char() �Լ�
INSERT INTO tbl_book (bcode, title, writer, publisher, pdate)
VALUES ('B1101','��Ŀ������','����Ŀ','��Ŀ����',to_date('18/07/10','YY/MM/DD'));
INSERT INTO tbl_book (bcode, title, writer, publisher, pdate)
VALUES ('C1101','Ǫ������ �ʹϴ�','����','â��',to_date('15/06/20','YY/MM/DD'));
INSERT INTO tbl_book (bcode, title, writer, publisher, pdate)
VALUES ('A1102','�佺Ʈ','�˺���Ʈ �','������',to_date('11/03/01','YY/MM/DD'));

SELECT * FROM TBL_BOOK ;

INSERT INTO TBL_BOOKRENT (rent_no,mem_idx,bcode,rent_date,exp_date,return_date)
VALUES(bookrent_seq.nextval,10001,'B1101','2021-09-01','2021-09-15','2021-09-14');
INSERT INTO TBL_BOOKRENT (rent_no,mem_idx,bcode,rent_date,exp_date,return_date)
VALUES(bookrent_seq.nextval,10002,'C1101','2021-09-12','2021-09-26','2021-09-29');
INSERT INTO TBL_BOOKRENT (rent_no,mem_idx,bcode,rent_date,exp_date,return_date)
VALUES(bookrent_seq.nextval,10003,'B1101','2021-09-03','2021-09-17','2021-09-17');
INSERT INTO TBL_BOOKRENT (rent_no,mem_idx,bcode,rent_date,exp_date)
VALUES(bookrent_seq.nextval,10004,'C1101','2022-06-30','2022-07-14');
INSERT INTO TBL_BOOKRENT (rent_no,mem_idx,bcode,rent_date,exp_date)
VALUES(bookrent_seq.nextval,10001,'A1101','2022-07-04','2022-07-18');
INSERT INTO TBL_BOOKRENT (rent_no,mem_idx,bcode,rent_date,exp_date,return_date)
VALUES(bookrent_seq.nextval,10003,'A1102','2021-07-06','2022-07-20','2022-07-13');


-- �����ϱ� : '�뿩' �⺻���� ������ �뿩��¥�� ����, �ݳ������� ���� + 14 �� �⺻������ �� �� �ֵ��� �մϴ�.
-- ALTER TABLE "C##IDEV".TBL_BOOKRENT MODIFY RENT_DATE DEFAULT sysdate;
-- ALTER TABLE "C##IDEV".TBL_BOOKRENT MODIFY EXP_DATE DEFAULT sysdate+14;
-- INSERT INTO TBL_BOOKRENT (rent_no, mem_idx, bcode)
-- values (bookrent_seq.nextval,10002,'A1102');

-- �÷� ����Ʈ �� ���ְ� ���� ��
-- ALTER TABLE "C#IDEV".TBL_BOOKRENT MODIFY RENT_DATE DATE DEFAULT NULL;



drop table book_member;
drop table tbl_book;
drop table tbl_bookrent;
drop sequence memidx_seq;
drop sequence bookrent_seq;


