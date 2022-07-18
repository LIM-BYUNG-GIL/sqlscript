-- 0715_문제 2
-- 작성자 : 임병길

INSERT INTO "TBL_CUSTOM#" (custom_id, name, email, age, reg_date)
VALUES ('mina012','김미나','kimm@gmail.com',20,'2022-02-07 15:03:06');
INSERT INTO "TBL_CUSTOM#" (custom_id, name, email, age, reg_date)
VALUES ('hongGD','홍길동','gil@korea.com',32,'2022-02-07 15:03:06');
INSERT INTO "TBL_CUSTOM#" (custom_id, name, email, age, reg_date)
VALUES ('twice','박모모','momo@daum.net',39,'2022-02-05');
INSERT INTO "TBL_CUSTOM#" (custom_id, name, email, age, reg_date)
VALUES ('wonder','이나나','nana@korea.kr',23,'2022-02-05');
INSERT INTO "TBL_CUSTOM#" (custom_id, name, email, age, reg_date)
VALUES ('sana','최사나','unknown',22,'2022-02-09 15:19:24.000');

INSERT INTO "TBL_PRODUCT#" (pcode, category, pname, price)
VALUES ('CJ-BABQ1','B1','CJ햇반잡곡밥SET',26000);
INSERT INTO "TBL_PRODUCT#" (pcode, category, pname, price)
VALUES ('DOWON123a','B1','동원참치선물세트',54000);
INSERT INTO "TBL_PRODUCT#" (pcode, category, pname, price)
VALUES ('dk_143','A2','모션데스크',234500);
INSERT INTO "TBL_PRODUCT#" (pcode, category, pname, price)
VALUES ('IPAD011','A1','아이패드10',880000);
INSERT INTO "TBL_PRODUCT#" (pcode, category, pname, price)
VALUES ('GAL0112','A1','갤럭시20',912300);
INSERT INTO "TBL_PRODUCT#" (pcode, category, pname, price)
VALUES ('CHR-J59','A2','S체어',98700);

INSERT INTO "TBL_BUY#" (buy_seq,custom_id,pcode,quantity,buy_date)
VALUES (buy_seq.nextval,'mina012','IPAD011',1,'22-02-06');
INSERT INTO "TBL_BUY#" (buy_seq,custom_id,pcode,quantity,buy_date)
VALUES (buy_seq.nextval,'hongGD','IPAD011',2,'22-02-08 15:55:08');
INSERT INTO "TBL_BUY#" (buy_seq,custom_id,pcode,quantity,buy_date)
VALUES (buy_seq.nextval,'wonder','DOWON123a',3,'22-02-06');
INSERT INTO "TBL_BUY#" (buy_seq,custom_id,pcode,quantity,buy_date)
VALUES (buy_seq.nextval,'mina012','dk_143',1,'22-02-08 15:55:08');
INSERT INTO "TBL_BUY#" (buy_seq,custom_id,pcode,quantity,buy_date)
VALUES (buy_seq.nextval,'twice','DOWON123a',2,'22-02-07');
INSERT INTO "TBL_BUY#" (buy_seq,custom_id,pcode,quantity,buy_date)
VALUES (buy_seq.nextval,'hongGD','dk_143',1,'22-02-11');
INSERT INTO "TBL_BUY#" (buy_seq,custom_id,pcode,quantity,buy_date)
VALUES (buy_seq.nextval,'twice','CHR-J59',2,'22-02-12');
INSERT INTO "TBL_BUY#" (buy_seq,custom_id,pcode,quantity,buy_date)
VALUES (buy_seq.nextval,'hongGD','CJ-BABQ1',4,'22-02-11');

SELECT * FROM "TBL_BUY#" tb WHERE buy_date >= '2022-02-11';

SELECT pcode, pname, price FROM "TBL_PRODUCT#" tp WHERE price = (SELECT max(price) FROM "TBL_PRODUCT#" );

SELECT category, max(price) FROM "TBL_PRODUCT#" tp GROUP BY category;

SELECT tc.custom_id, tc.name, tb.quantity FROM "TBL_BUY#" tb, "TBL_CUSTOM#" tc
WHERE tc.custom_id = tb.custom_id AND tb.pcode = 'IPAD011';

SELECT tc.CUSTOM_ID, tc.NAME, tc.AGE FROM "TBL_CUSTOM#" tc, "TBL_BUY#" tb  
	WHERE tc.CUSTOM_ID(+) = tb.CUSTOM_ID;

SELECT tb.buy_date, sum(p) FROM "TBL_PRODUCT#" tp JOIN (SELECT pcode FROM "TBL_BUY#" tb GROUP BY BUY_DATE) p;




