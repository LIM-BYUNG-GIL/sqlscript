CREATE TABLE tbl_custom (
	custom_id varchar2(20) PRIMARY KEY,
	name nvarchar2(20) NOT NULL,
	email nvarchar2(20),
	age number(3),
	reg_date DATE DEFAULT sysdate
);

-- 상품 테이블 : 카테고리 예시 A1 : 전자제품, B1 : 식품
CREATE TABLE tbl_product(
	pcode varchar2(20) PRIMARY KEY,
	category char(2) NOT NULL,
	pname nvarchar2(20) NOT NULL,
	price number(9) NOT NULL
);

-- 구매 테이블 : 어느 고객이 무슨 상품을 구입하는가 ?
CREATE TABLE tbl_buy(
	custom_id varchar2(20) NOT NULL,
	pcode varchar2(20) NOT NULL,
	quantity number(5) NOT NULL,
	buy_date DATE DEFAULT sysdate
);

INSERT INTO tbl_custom VALUES ('mina012','김미나','kimm@gmail.com',30,to_date('2022-03-10 14:23:25','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tbl_custom VALUES ('hongGD','홍길동','gil@korea.com',32,'2021-10-21');
INSERT INTO tbl_custom VALUES ('twice','박모모','momo@daum.net',29,'2021-12-25');
INSERT INTO tbl_custom VALUES ('wonder','이나나','lee@naver.com',40,sysdate);
SELECT * FROM tbl_custom;

INSERT INTO tbl_product VALUES ('IPAD011','A1','아이패드10',880000);
INSERT INTO tbl_product VALUES ('DOWON123a','B1','동원참치선물세트',54000);
INSERT INTO tbl_product VALUES ('dk_143','A2','모션데스크',234500);
SELECT * FROM tbl_product;

INSERT INTO tbl_buy VALUES ('mina012','IPAD011',1,'2022-02-06');
INSERT INTO tbl_buy VALUES ('hongGD','IPAD011',2,to_date('2022-06-29 20:37:47','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tbl_buy VALUES ('wonder','DOWON123a',3,'2022-02-06');
INSERT INTO tbl_buy VALUES ('mina012','dk_143',1,sysdate);
INSERT INTO tbl_buy VALUES ('twice','DOWON123a',2,to_date('2022-02-09 08:49:55','YYYY-MM-DD HH24:MI:SS'));
SELECT * FROM tbl_buy;

ALTER TABLE tbl_buy ADD buyNo number(8);

UPDATE tbl_buy SET buyno = 1001 WHERE custom_id = 'mina012';
UPDATE tbl_buy SET buyno = 1002 WHERE custom_id = 'hongGD';
UPDATE tbl_buy SET buyno = 1003 WHERE custom_id = 'wonder';
UPDATE tbl_buy SET buyno = 1004 WHERE pcode = 'dk_143';
UPDATE tbl_buy SET buyno = 1005 WHERE custom_id = 'twice';

ALTER TABLE tbl_buy ADD CONSTRAINT pk_buy PRIMARY KEY (buyno);
ALTER TABLE tbl_buy ADD CONSTRAINT fk1_buy FOREIGN KEY (custom_id) REFERENCES TBL_CUSTOM(custom_id) ;
ALTER TABLE tbl_buy ADD CONSTRAINT fk2_buy FOREIGN KEY (pcode) REFERENCES TBL_PRODUCT ;

CREATE SEQUENCE tblbuy_seq START WITH 1006;
SELECT tblbuy_seq.nextval FROM dual;
INSERT INTO TBL_BUY VALUES ('wonder','IPAD011',1,'2022-05-15',tblbuy_seq.currval);

SELECT * FROM TBL_CUSTOM WHERE AGE >= 30;
SELECT EMAIL FROM TBL_CUSTOM WHERE CUSTOM_ID = 'twice';
SELECT PNAME FROM TBL_PRODUCT WHERE CATEGORY = 'A2';
SELECT MAX(price) FROM TBL_PRODUCT;
SELECT SUM(quantity) FROM TBL_BUY WHERE PCODE = 'IPAD011';
SELECT * FROM TBL_BUY tb WHERE CUSTOM_ID = 'mina012';
SELECT PCODE FROM TBL_BUY WHERE PCODE LIKE '%0%';
SELECT PCODE FROM TBL_BUY WHERE LOWER(PCODE) LIKE '%on%';

-- Date 형식에 지정되는 패턴 설정하기 -> insert 할 때 to_date 함수 생략가능
ALTER SESSION SET NSL_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';





