-- 0715_문제 1
-- 작성자 : 임병길

CREATE TABLE tbl_product# (
pcode varchar2(20) PRIMARY KEY,
category char(2),
pname nvarchar2(20) NOT NULL,
price number(9,0) NOT NULL
);

CREATE TABLE tbl_custom# (
custom_id varchar2(20) PRIMARY KEY,
name nvarchar2(20) NOT NULL,
email varchar2(30),
age number(3,0),
reg_date timestamp
);

CREATE TABLE tbl_buy# (
buy_seq number(8,0) PRIMARY KEY,
custom_id varchar2(20),
pcode varchar2(20),
quantity number(5,0) NOT NULL,
buy_date timestamp,
FOREIGN KEY (custom_id) REFERENCES tbl_custom#(custom_id),
FOREIGN KEY (pcode) REFERENCES tbl_product#(pcode)
);

CREATE SEQUENCE buy_seq START WITH 2001;

CREATE TABLE tbl_postcode (
postcode char(6) PRIMARY KEY,
area1 varchar2(200) NOT NULL
);

ALTER TABLE tbl_custom# ADD postcode char(6);

ALTER TABLE tbl_custom# ADD CONSTRAINT fk_postcode FOREIGN KEY (postcode) REFERENCES tbl_postcode(postcode);
