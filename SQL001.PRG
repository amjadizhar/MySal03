* Listing 8.2 Page 368 of Vfp book
* PROGRAM 8.2
* Creates an outer join to list all products and their sales.

* CLOSE ALL
* CLEAR

* SELECT A.Product_ID, SUM(A.Quantity) AS TotalSales, ;
* 	B.Product_Name ;
* FROM \VFP\SAMPLES\MAINSAMP\DATA\TASTRADE!ORDER_LINE_ITEMS A, ;
*	   \VFP\SAMPLES\MAINSAMP\DATA\TASTRADE!PRODUCTS B;
* WHERE A.Product_ID = B.Product_ID
* GROUP BY A.Product_ID ;
* UNION ALL;
* 	SELECT B.Product_ID, 0, B.Product_Name ;
* 	FROM \VFP\SAMPLES\MAINSAMP\DATA\TASTRADE!PRODUCTS B ;
* 	WHERE Product_ID NOT IN 
*		(SELECT DISTINCT Product_ID ;
*		 FROM \VFP\SAMPLES\MAINSAMP\DATA\TASTRADE!ORDER_LINE_ITEMS)

****************************
PROCEDURE _001
****************************

* SQL for Report of Ledgers from Master
* Master file LDGRCODE.DBF
* CHILD FILE MASTER.DBF

CLEAR
CLEA ALL
CLOSE ALL


SELECT DATE() AS DATE,C1,C2,C3,ALLTRIM(STR(C1,2)+"-"+STR(C2,2)+"-"+STR(C3,3)) AS CODE,TITLE, ;
	   "DESC"+SPACE(26) AS DESC,"DESC1"+SPACE(25) AS DESC1,;
	   0 AS DR_AMOUNT,0 AS CR_AMOUNT;
FROM LDGRCODE ;
ORDER BY C1,C2,C3 ;
INTO DBF LDGRCOD1.DBF



SELECT B.DATE,B.C1,B.C2,B.C3,A.CODE,A.TITLE,;
	   B.DESC,B.DESC1,;
	   B.DR_AMOUNT,B.CR_AMOUNT;
FROM LDGRCOD1 A,;
	 MASTER B;
WHERE A.C1 = B.C1 AND A.C2=B.C2 AND A.C3=B.C3;
ORDER BY A.C1,A.C2,A.C3,B.DATE ;
INTO DBF LEDGERS1.DBF


BROW

CLOSE ALL

RETURN
******************************



****************************
PROCEDURE _002
****************************

* SQL for Report of Ledgers from Master
* Master file LDGRCODE.DBF
* CHILD FILE MASTER.DBF

CLEAR
CLEA ALL
CLOSE ALL


SELECT DATE() AS DATE,C1,C2,C3,ALLTRIM(STR(C1,2)+"-"+STR(C2,2)+"-"+STR(C3,3)) AS CODE,TITLE, ;
	   "DESC"+SPACE(26) AS DESC,"DESC1"+SPACE(25) AS DESC1,;
	   000000000000.00 AS DR_AMOUNT,000000000000.00 AS CR_AMOUNT,;
	   LDGR_BAL,STATUS;
FROM LDGRCODE ;
ORDER BY C1,C2,C3 ;
INTO DBF LDGRCOD1.DBF

CLOSE ALL

USE LDGRCOD1.DBF
SELECT LDGRCOD1
REPL ALL DR_AMOUNT WITH LDGR_BAL FOR STATUS = "DR"
REPL ALL CR_AMOUNT WITH LDGR_BAL FOR STATUS = "CR"

BROW

CLOSE ALL

RETURN
******************************



****************************
PROCEDURE _003
****************************


* SQL for Report of Ledgers from Master
* Master file LDGRCODE.DBF
* CHILD FILE MASTER.DBF

CLEAR
CLEA ALL
CLOSE ALL


SELECT A.DATE,A.C1,A.C2,A.C3,ALLTRIM(STR(A.C1,2)+"-"+STR(A.C2,2)+"-"+STR(A.C3,3)) AS CODE,B.TITLE, ;
	   A.DESC,A.DESC1,A.DR_AMOUNT,A.CR_AMOUNT;
FROM MASTER A, LDGRCODE B ;
WHERE A.C1 = B.C1 AND A.C2=B.C2 AND A.C3=B.C3;
ORDER BY A.C1,A.C2,A.C3,A.DATE ;
INTO DBF MASTER1.DBF

BROW 

CLOSE ALL


RETURN
******************************


* SELECT A.Product_ID, SUM(A.Quantity) AS TotalSales, ;
* 	B.Product_Name ;
* FROM \VFP\SAMPLES\MAINSAMP\DATA\TASTRADE!ORDER_LINE_ITEMS A, ;
*	   \VFP\SAMPLES\MAINSAMP\DATA\TASTRADE!PRODUCTS B;
* WHERE A.Product_ID = B.Product_ID
* GROUP BY A.Product_ID ;
* UNION ALL;
* 	SELECT B.Product_ID, 0, B.Product_Name ;
* 	FROM \VFP\SAMPLES\MAINSAMP\DATA\TASTRADE!PRODUCTS B ;
* 	WHERE Product_ID NOT IN 
*		(SELECT DISTINCT Product_ID ;
*		 FROM \VFP\SAMPLES\MAINSAMP\DATA\TASTRADE!ORDER_LINE_ITEMS)

****************************
PROCEDURE _004
****************************

* SQL for Report of Ledgers from Master
* Master file LDGRCODE.DBF
* CHILD FILE MASTER.DBF

CLEAR
CLEA ALL
CLOSE ALL


SELECT DATE() AS DATE,C1,C2,C3,ALLTRIM(STR(C1,2)+"-"+STR(C2,2)+"-"+STR(C3,3)) AS CODE,TITLE, ;
	   "DESC"+SPACE(26) AS DESC,"DESC1"+SPACE(25) AS DESC1,;
	   0 AS DR_AMOUNT,0 AS CR_AMOUNT;
FROM LDGRCODE ;
ORDER BY C1,C2,C3 ;
INTO DBF LDGRCOD1.DBF


SELECT A.DATE,A.C1,A.C2,A.C3,ALLTRIM(STR(A.C1,2)+"-"+STR(A.C2,2)+"-"+STR(A.C3,3)) AS CODE,B.TITLE, ;
	   A.DESC,A.DESC1,A.DR_AMOUNT,A.CR_AMOUNT;
FROM MASTER A, LDGRCODE B ;
WHERE A.C1 = B.C1 AND A.C2=B.C2 AND A.C3=B.C3;
ORDER BY A.C1,A.C2,A.C3,A.DATE ;
INTO DBF MASTER1.DBF


SELECT B.DATE,A.CODE,A.TITLE,;
	   B.DESC,B.DESC1,;
	   B.DR_AMOUNT,B.CR_AMOUNT;
FROM LDGRCOD1 A,;
	 MASTER1 B;
WHERE A.CODE = B.CODE;
ORDER BY A.CODE,B.DATE ;
INTO DBF LEDGERS1.DBF


BROW

CLOSE ALL


RETURN
******************************



* SELECT A.Product_ID, SUM(A.Quantity) AS TotalSales, ;
* 	B.Product_Name ;
* FROM \VFP\SAMPLES\MAINSAMP\DATA\TASTRADE!ORDER_LINE_ITEMS A, ;
*	   \VFP\SAMPLES\MAINSAMP\DATA\TASTRADE!PRODUCTS B;
* WHERE A.Product_ID = B.Product_ID
* GROUP BY A.Product_ID ;
* UNION ALL;
* 	SELECT B.Product_ID, 0, B.Product_Name ;
* 	FROM \VFP\SAMPLES\MAINSAMP\DATA\TASTRADE!PRODUCTS B ;
* 	WHERE Product_ID NOT IN 
*		(SELECT DISTINCT Product_ID ;
*		 FROM \VFP\SAMPLES\MAINSAMP\DATA\TASTRADE!ORDER_LINE_ITEMS)

****************************
PROCEDURE _005
****************************

* SQL for Report of Ledgers from Master
* Master file LDGRCODE.DBF
* CHILD FILE MASTER.DBF

CLEAR
CLEA ALL
CLOSE ALL

SELECT DATE() AS DATE,C1,C2,C3,ALLTRIM(STR(C1,2)+"-"+STR(C2,2)+"-"+STR(C3,3)) AS CODE,TITLE, ;
	   "DESC"+SPACE(26) AS DESC,"DESC1"+SPACE(25) AS DESC1,;
	   0 AS DR_AMOUNT,0 AS CR_AMOUNT;
FROM LDGRCODE ;
ORDER BY C1,C2,C3 ;
INTO DBF LDGRCOD1.DBF


SELECT A.DATE,A.C1,A.C2,A.C3,ALLTRIM(STR(A.C1,2)+"-"+STR(A.C2,2)+"-"+STR(A.C3,3)) AS CODE,B.TITLE, ;
	   ALLTRIM(A.DESC)+" "+ALLTRIM(A.DESC1) AS DESCRIP,A.DR_AMOUNT,A.CR_AMOUNT;
FROM MASTER A, LDGRCODE B ;
WHERE A.C1 = B.C1 AND A.C2=B.C2 AND A.C3=B.C3;
ORDER BY A.C1,A.C2,A.C3,A.DATE ;
INTO DBF MASTER1.DBF


SELECT B.DATE,A.CODE,A.TITLE,;
	   B.DR_AMOUNT,B.CR_AMOUNT;
FROM LDGRCOD1 A,;
	 MASTER1 B;
WHERE A.CODE = B.CODE;
UNION ALL ;
	SELECT B.DATE,B.CODE,B.TITLE,;
		   0,0;
	FROM LDGRCOD1 B;
	WHERE B.CODE NOT IN (SELECT DISTINCT CODE FROM MASTER1);
	INTO DBF LEDGERS2.DBF



BROW 

CLOSE ALL



RETURN
******************************




****************************
PROCEDURE _006
****************************

* SQL for Report of Ledgers from Master
* Master file LDGRCODE.DBF
* CHILD FILE MASTER.DBF

CLEAR
CLEA ALL
CLOSE ALL

SELECT DATE() AS DATE,C1,C2,C3,ALLTRIM(STR(C1,2)+"-"+STR(C2,2)+"-"+STR(C3,3)) AS CODE,TITLE, ;
	   "DESC"+SPACE(26) AS DESC,"DESC1"+SPACE(25) AS DESC1,;
	   0 AS DR_AMOUNT,0 AS CR_AMOUNT;
FROM LDGRCODE ;
ORDER BY C1,C2,C3 ;
INTO DBF LDGRCOD1.DBF


SELECT A.DATE,A.C1,A.C2,A.C3,ALLTRIM(STR(A.C1,2)+"-"+STR(A.C2,2)+"-"+STR(A.C3,3)) AS CODE,B.TITLE, ;
	   ALLTRIM(A.DESC)+" "+ALLTRIM(A.DESC1) AS DESCRIP,A.DR_AMOUNT,A.CR_AMOUNT;
FROM MASTER A, LDGRCODE B ;
WHERE A.C1 = B.C1 AND A.C2=B.C2 AND A.C3=B.C3;
ORDER BY A.C1,A.C2,A.C3,A.DATE ;
INTO DBF MASTER1.DBF


SELECT B.DATE,A.CODE,A.TITLE,;
	   B.DR_AMOUNT,B.CR_AMOUNT;
FROM LDGRCOD1 A,;
	 MASTER1 B;
WHERE A.CODE = B.CODE;
UNION ALL ;
	SELECT A.DATE,A.CODE,A.TITLE,;
		   A.DR_AMOUNT,A.CR_AMOUNT;
	FROM LDGRCOD1 A;
	WHERE A.CODE NOT IN (SELECT DISTINCT CODE FROM MASTER1);
	INTO DBF LEDGERS3.DBF


BROW

CLOSE ALL

* WORKED CORRECTLY AT 5:12 PM ON 27TH APRIL,2008


RETURN
******************************



****************************
PROCEDURE _007
****************************

* SQL for Report of Ledgers from Master
* Master file LDGRCODE.DBF
* CHILD FILE MASTER.DBF

CLEAR
CLEA ALL
CLOSE ALL

SELECT DATE() AS DATE,C1,C2,C3,ALLTRIM(STR(C1,2)+"-"+STR(C2,2)+"-"+STR(C3,3)) AS CODE,TITLE, ;
	   "DESC"+SPACE(26) AS DESC,"DESC1"+SPACE(25) AS DESC1,;
	   0 AS DR_AMOUNT,0 AS CR_AMOUNT;
FROM LDGRCODE ;
ORDER BY C1,C2,C3 ;
INTO DBF LDGRCOD1.DBF


SELECT A.DATE,A.C1,A.C2,A.C3,ALLTRIM(STR(A.C1,2)+"-"+STR(A.C2,2)+"-"+STR(A.C3,3)) AS CODE,B.TITLE, ;
	   ALLTRIM(A.DESC)+" "+ALLTRIM(A.DESC1) AS DESCRIP,A.DR_AMOUNT,A.CR_AMOUNT;
FROM MASTER A, LDGRCODE B ;
WHERE A.C1 = B.C1 AND A.C2=B.C2 AND A.C3=B.C3;
ORDER BY A.C1,A.C2,A.C3,A.DATE ;
INTO DBF MASTER1.DBF


SELECT B.DATE,A.CODE,A.TITLE,;
	   B.DESCRIP,;
	   B.DR_AMOUNT,B.CR_AMOUNT;
FROM LDGRCOD1 A,;
	 MASTER1 B;
WHERE A.CODE = B.CODE;
UNION ALL ;
	SELECT A.DATE,A.CODE,A.TITLE,;
		   ALLTRIM(A.DESC)+" "+ALLTRIM(A.DESC1) AS DESCRIP,;
		   A.DR_AMOUNT,A.CR_AMOUNT;
	FROM LDGRCOD1 A;
	WHERE A.CODE NOT IN (SELECT DISTINCT CODE FROM MASTER1)

* WORKED CORRECTLY



RETURN
******************************


****************************
PROCEDURE _008
****************************


* SQL for Report of Ledgers from Master
* Master file LDGRCODE.DBF
* CHILD FILE MASTER.DBF

CLEAR
CLEA ALL
CLOSE ALL


SELECT DATE() AS DATE,C1,C2,C3,CODE,TITLE, ;
	   SUM(DR_AMOUNT) AS TOT_DR,SUM(CR_AMOUNT) AS TOT_CR,;
	   -SUM(DR_AMOUNT)+SUM(CR_AMOUNT) AS BALANCE;
FROM MASTER1;
ORDER BY CODE,DATE ;
GROUP BY CODE;
INTO DBF TOTMAST1.DBF

BROW 

CLOSE ALL


RETURN
******************************
