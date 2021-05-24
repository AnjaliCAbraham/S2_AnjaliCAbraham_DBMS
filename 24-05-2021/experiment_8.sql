/*EXPERIMENT NO.8 (GROUP BY AND HAVING) */

CREATE TABLE CUSTOMER (CNAME VARCHAR(15) PRIMARY KEY ,CITY	VARCHAR(20) NOT NULL );
INSERT INTO CUSTOMER VALUES('SUNIL','DELHI');
INSERT INTO CUSTOMER VALUES('MEHUL','BARODA');
INSERT INTO CUSTOMER VALUES('MANDAR','PATNA');
INSERT INTO CUSTOMER VALUES('MADHURI','NAGPUR');
INSERT INTO CUSTOMER VALUES('PRAMOD',	'NAGPUR');
INSERT INTO CUSTOMER VALUES('SANDIP','SURAT');
INSERT INTO CUSTOMER VALUES('SHIVANI','BOMBAY');
INSERT INTO CUSTOMER VALUES('KRANTI','BOMBAY');
INSERT INTO CUSTOMER VALUES('NAREN','BOMBAY');
      
CREATE TABLE  BRANCH (BNAME VARCHAR(20) PRIMARY KEY,CITY VARCHAR(30) CHECK (CITY IN ('NAGPUR','DELHI','BANGALORE','BOMBAY')) NOT NULL);
INSERT INTO BRANCH VALUES('VRCE','NAGPUR');
INSERT INTO BRANCH VALUES('AJNI','NAGPUR');
INSERT INTO BRANCH VALUES('KAROLBAGH','DELHI');
INSERT INTO BRANCH VALUES('CHANDNI'	,'DELHI');
INSERT INTO BRANCH VALUES('DHARAMPETH'	,'NAGPUR');
INSERT INTO BRANCH VALUES('MG ROAD'	,'BANGALORE');
INSERT INTO BRANCH VALUES('ANDHERI',	'BOMBAY');
INSERT INTO BRANCH VALUES('NEHRU PALACE'	,'DELHI');
INSERT INTO BRANCH VALUES('POWAI','BOMBAY');

CREATE TABLE BORROW (LOANNO VARCHAR(8) CHECK (LOANNO LIKE 'L%')  PRIMARY KEY,CNAME VARCHAR(15) REFERENCES CUSTOMER(CNAME) ,BNAME VARCHAR(20) REFERENCES BRANCH(BNAME),AMOUNT FLOAT(8) CHECK (AMOUNT>0) NOT NULL);
INSERT INTO BORROW VALUES('L201',	'ANIL',	'VRCE',	1000.00);
INSERT INTO BORROW VALUES('L206',	'MEHUL',	'AJNI',	5000.00);
INSERT INTO BORROW VALUES('L311',	'SUNIL',	'DHARAMPETH',	3000.00);
INSERT INTO BORROW VALUES('L321',	'MADHURI',	'ANDHERI',	2000.00);
INSERT INTO BORROW VALUES('L371',	'PRAMOD',	'VIRAR',	8000.00);
INSERT INTO BORROW VALUES('L481',	'KRANTI',	'NEHRU PLACE',	3000.00);



CREATE TABLE DEPOSIT (ACTNO	VARCHAR(5) CHECK (ACTNO LIKE 'D%')	PRIMARY KEY ,CNAME VARCHAR(15) REFERENCES CUSTOMER(CNAME) ,BNAME VARCHAR(20) REFERENCES BRANCH(BNAME),AMOUNT FLOAT(8) CHECK (AMOUNT>0) NOT NULL, ADATE DATE);INSERT INTO CUSTOMER VALUES('ANIL','CALCUTTA');
INSERT INTO DEPOSIT VALUES('D100','ANIL','VRCE',	1000.00	,'1995-03-01');
INSERT INTO DEPOSIT VALUES('D101','SUNIL','ANJNI',500.00,'1996-01-04');
INSERT INTO DEPOSIT VALUES('D102','MEHUL','KAROLBAGH',3500.00,'1995-11-17');
INSERT INTO DEPOSIT VALUES('D104','MADHURI','CHANDNI',1200.00,'1995-12-17');
INSERT INTO DEPOSIT VALUES('D105','PRAMOD'	,'MG ROAD'	,3000.00,'1996-03-27');
INSERT INTO DEPOSIT VALUES('D106','SANDIP	','ANDHERI',2000.00,'1996-03-31');
INSERT INTO DEPOSIT VALUES('D107'	,'SHIVANI'	,'VIRAR',1000.00,'1995-09-05');
INSERT INTO DEPOSIT VALUES('D108'	,'KRANTI',	'NEHRU PLACE',5000.00,'1995-07-05');
INSERT INTO DEPOSIT VALUES('D109'	,'MINU',	'POWAI'	,7000.00,'1995-08-10');

SELECT D.BNAME FROM DEPOSIT D , BRANCH B WHERE D.BNAME=B.BNAME GROUP BY D.BNAME HAVING SUM(D.AMOUNT) > 5000;
SELECT D.BNAME FROM DEPOSIT D , BRANCH B WHERE D.BNAME=B.BNAME AND B.CITY='BOMBAY' GROUP BY D.BNAME HAVING SUM(D.AMOUNT) > 5000;
SELECT CNAME FROM DEPOSIT WHERE AMOUNT=(SELECT AVG(AMOUNT) FROM DEPOSIT GROUP BY BNAME HAVING AVG(AMOUNT)>5000)
SELECT D1.BNAME FROM DEPOSIT D1 GROUP BY D1.BNAME HAVING COUNT(D1.CNAME) >=  ALL(SELECT COUNT (D2.CNAME) FROM DEPOSIT D2 GROUP BY D2.BNAME)
SELECT MAX(AMOUNT)"AMOUNT" FROM DEPOSIT
SELECT COUNT(DEPOSIT.CNAME)FROM DEPOSIT,CUSTOMER where  CUSTOMER.CITY='nagpur'
SELECT CNAME FROM DEPOSIT  WHERE BNAME='VRCE' AND  AMOUNT=(SELECT MAX(AMOUNT)  FROM DEPOSIT WHERE BNAME='VRCE')
SELECT BNAME FROM DEPOSIT GROUP BY BNAME HAVING COUNT(BNAME)>5
SELECT C.CNAME ,COUNT(B.BNAME) FROM CUSTOMER C INNER JOIN BRANCH B ON C.CNAME=B.BNAME GROUP BY C.CNAME ORDER BY COUNT(B.BNAME) DESC
SELECT COUNT(b1.bname) FROM DEPOSIT d1 , BORROW b1 , CUSTOMER c1 WHERE c1.cname=d1.cname AND d1.cname=b1.cname AND c1.city IN (SELECT CITY FROM CUSTOMER)




