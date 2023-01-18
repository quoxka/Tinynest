CREATE TABLE product (
    p_code NUMBER(4) PRIMARY KEY,
    p_name VARCHAR2(100) NOT NULL,
    p_img VARCHAR2(500) NOT NULL,
    p_price NUMBER(6) NOT NULL,
    p_info VARCHAR2(500),
    P_amount NUMBER(3) NOT NULL,
    p_cate VARCHAR2(100) NOT NULL
);

CREATE TABLE member (
    id VARCHAR2(20) PRIMARY KEY,
    pw VARCHAR2(100) NOT NULL,
    name VARCHAR2(20) NOT NULL,
    zipcode NUMBER(5) NOT NULL,
    address1 VARCHAR2(200) NOT NULL,
    address2 VARCHAR2(200) NOT NULL,
    phone VARCHAR2(30) NOT NULL,
    email VARCHAR2(50) NOT NULL,
    status NUMBER(1) NOT NULL
);

CREATE TABLE basket (
    b_no NUMBER(3) PRIMARY KEY,
    b_id VARCHAR2(20),
    b_code NUMBER(4),
    b_amount NUMBER(3),
    FOREIGN KEY(b_id) REFERENCES member(id),
    FOREIGN KEY(b_code) REFERENCES product(p_code)
);

CREATE TABLE purchase (
    pc_no NUMBER(4) PRIMARY KEY,
    pc_id VARCHAR2(20),
    pc_date DATE NOT NULL,
    pc_status NUMBER(1) NOT NULL,
    pc_code NUMBER(4),
    pc_amount NUMBER(3) NOT NULL,
    pc_price NUMBER(9) NOT NULL,
    pc_Lname VARCHAR2(20) NOT NULL,
    pc_Lphone VARCHAR2(20) NOT NULL,
    pc_zipcode NUMBER(5) NOT NULL,
    pc_Laddress1 VARCHAR2(200) NOT NULL,
    pc_Laddress2 VARCHAR2(200) NOT NULL,
    FOREIGN KEY(pc_id) REFERENCES member(id),
    FOREIGN KEY(pc_code) REFERENCES product(p_code)
);

CREATE TABLE notice (
    n_no NUMBER(3) PRIMARY KEY,
    n_title VARCHAR2(100) NOT NULL,
    n_id VARCHAR2(20),
    n_content VARCHAR2(1000),
    n_date DATE NOT NULL
);

CREATE TABLE qna (
    q_no NUMBER(3) PRIMARY KEY,
    q_title VARCHAR2(200) NOT NULL,
    q_id VARCHAR2(20),
    q_content VARCHAR2(1000),
    q_date DATE NOT NULL,
    q_code NUMBER(4),
    q_answer VARCHAR2(1000),
    FOREIGN KEY(q_id) REFERENCES member(id),
    FOREIGN KEY(q_code) REFERENCES product(p_code)
);

CREATE TABLE review (
    r_no NUMBER(3) PRIMARY KEY,
    r_id VARCHAR2(20),
    r_content VARCHAR2(1000),
    r_date DATE NOT NULL,
    r_code NUMBER(4),
    r_pcno NUMBER(4),
    FOREIGN KEY(r_id) REFERENCES member(id),
    FOREIGN KEY(r_code) REFERENCES product(p_code),
    FOREIGN KEY(r_pcno) REFERENCES purchase(pc_no)
);

CREATE SEQUENCE PRODUCT_SEQ;
CREATE SEQUENCE NOTICE_SEQ;
CREATE SEQUENCE QNA_SEQ;
CREATE SEQUENCE REVIEW_SEQ;
CREATE SEQUENCE BASKET_SEQ;
CREATE SEQUENCE PURCHASE_SEQ;
