* procedures to get diff
* angles of tran and tran_key dbf's
*
****************************
PROCEDURE _001
****************************

CLEAR
CLEA ALL
CLOSE ALL


SELECT A.DATE,A.C1,A.C2,A.C3,ALLTRIM(STR(A.C1,2)+"-"+STR(A.C2,2)+"-"+STR(A.C3,3)) AS CODE,B.TITLE ;
FROM TRAN A, LDGRCODE B ;
WHERE A.C1 = B.C1 AND A.C2=B.C2 AND A.C3=B.C3;
ORDER BY A.C1,A.C2,A.C3,A.DATE ;
INTO DBF TRAN1.DBF



BROW

CLOSE ALL

RETURN
******************************

****************************
PROCEDURE _002
****************************

CLEAR
CLEA ALL
CLOSE ALL


SELECT A.DATE,A.C1,A.C2,A.C3,ALLTRIM(STR(A.C1,2)+"-"+STR(A.C2,2)+"-"+STR(A.C3,3)) AS CODE,B.TITLE, ;
	A.vch_type,A.vch_no1,A.vch_no2,A.sr_no,;
	ALLTRIM(STR(A.vch_type,1)+"-"+STR(A.vch_no1,2)+"-"+STR(A.vch_no2,5)) AS V_No;
FROM TRAN A, LDGRCODE B ;
WHERE A.C1 = B.C1 AND A.C2=B.C2 AND A.C3=B.C3;
ORDER BY A.C1,A.C2,A.C3,A.DATE ;
INTO DBF TRAN2.DBF



BROW

CLOSE ALL

RETURN
******************************



****************************
PROCEDURE _003
****************************

CLEAR
CLEA ALL
CLOSE ALL


SELECT A.DATE,A.C1,A.C2,A.C3,ALLTRIM(STR(A.C1,2)+"-"+STR(A.C2,2)+"-"+STR(A.C3,3)) AS CODE,B.TITLE, ;
	A.vch_type,A.vch_no1,A.vch_no2,A.sr_no,;
	ALLTRIM(STR(A.vch_type,1)+"-"+STR(A.vch_no1,2)+"-"+STR(A.vch_no2,5)) AS V_No,;
	ALLTRIM(STR(A.vch_type,1)+"-"+STR(A.vch_no1,2)+"-"+STR(A.vch_no2,5)+"-"+STR(A.sr_no,6)) AS V_No1;
FROM TRAN A, LDGRCODE B ;
WHERE A.C1 = B.C1 AND A.C2=B.C2 AND A.C3=B.C3;
ORDER BY A.C1,A.C2,A.C3,A.DATE ;
INTO DBF TRAN3.DBF



BROW

CLOSE ALL

RETURN
******************************



****************************
PROCEDURE _004
****************************

CLEAR
CLEA ALL
CLOSE ALL


SELECT A.DATE,A.C1,A.C2,A.C3,ALLTRIM(STR(A.C1,2)+"-"+STR(A.C2,2)+"-"+STR(A.C3,3)) AS CODE,B.TITLE, ;
	A.vch_type,A.vch_no1,A.vch_no2,A.sr_no,;
	ALLTRIM(STR(A.vch_type,1)+"-"+STR(A.vch_no1,2)+"-"+STR(A.vch_no2,5)) AS V_No,;
	ALLTRIM(STR(A.vch_type,1)+"-"+STR(A.vch_no1,2)+"-"+STR(A.vch_no2,5)+"-"+STR(A.sr_no,6)) AS V_No1,;
	A.Descrip,A.Descrip1,ALLTRIM(A.Descrip)+" "+ALLTRIM(A.Descrip1) AS Descrption;
FROM TRAN A, LDGRCODE B ;
WHERE A.C1 = B.C1 AND A.C2=B.C2 AND A.C3=B.C3;
ORDER BY A.C1,A.C2,A.C3,A.DATE ;
INTO DBF TRAN4.DBF



BROW

CLOSE ALL

RETURN
******************************



****************************
PROCEDURE _005
****************************

CLEAR
CLEA ALL
CLOSE ALL


SELECT A.DATE,A.C1,A.C2,A.C3,ALLTRIM(STR(A.C1,2)+"-"+STR(A.C2,2)+"-"+STR(A.C3,3)) AS CODE,B.TITLE, ;
	A.vch_type,A.vch_no1,A.vch_no2,A.sr_no,;
	ALLTRIM(STR(A.vch_type,1)+"-"+STR(A.vch_no1,2)+"-"+STR(A.vch_no2,5)) AS V_No,;
	ALLTRIM(STR(A.vch_type,1)+"-"+STR(A.vch_no1,2)+"-"+STR(A.vch_no2,5)+"-"+STR(A.sr_no,6)) AS V_No1,;
	A.Descrip,A.Descrip1,ALLTRIM(A.Descrip)+" "+ALLTRIM(A.Descrip1) AS Descrption,;
	dr_cr,amount,000000000000.00 AS dr_amount,000000000000.00 AS cr_amount;
FROM TRAN A, LDGRCODE B ;
WHERE A.C1 = B.C1 AND A.C2=B.C2 AND A.C3=B.C3;
ORDER BY A.C1,A.C2,A.C3,A.DATE ;
INTO DBF TRAN5.DBF

REPL ALL DR_AMOUNT WITH AMOUNT FOR DR_CR = "DR"
REPL ALL CR_AMOUNT WITH AMOUNT FOR DR_CR = "CR"


BROW

CLOSE ALL

RETURN
******************************


****************************
PROCEDURE _006
****************************

CLEAR
CLEA ALL
CLOSE ALL


SELECT A.DATE,A.C1,A.C2,A.C3,ALLTRIM(STR(A.C1,2)+"-"+STR(A.C2,2)+"-"+STR(A.C3,3)) AS CODE,B.TITLE, ;
	A.vch_type,A.vch_no1,A.vch_no2,A.sr_no,;
	ALLTRIM(STR(A.vch_type,1)+"-"+STR(A.vch_no1,2)+"-"+STR(A.vch_no2,5)) AS V_No,;
	ALLTRIM(STR(A.vch_type,1)+"-"+STR(A.vch_no1,2)+"-"+STR(A.vch_no2,5)+"-"+STR(A.sr_no,6)) AS V_No1,;
	A.Descrip,A.Descrip1,ALLTRIM(A.Descrip)+" "+ALLTRIM(A.Descrip1) AS Descrption,;
	dr_cr,amount,000000000000.00 AS dr_amount,000000000000.00 AS cr_amount;
FROM TRAN A, LDGRCODE B ;
WHERE A.C1 = B.C1 AND A.C2=B.C2 AND A.C3=B.C3;
ORDER BY A.C1,A.C2,A.C3,A.DATE ;
INTO DBF TRAN5.DBF

REPL ALL DR_AMOUNT WITH AMOUNT FOR DR_CR = "DR"
REPL ALL CR_AMOUNT WITH AMOUNT FOR DR_CR = "CR"

INDEX ON V_NO TAG V_NO




CLOSE ALL
SELECT * FROM TRAN5 ORDER BY V_NO1 INTO DBF VCHRS1

CLOSE ALL

*SELECT ;
*FROM ;
*ORDER BY ;
*INTO DBF

USE TRAN-KEY ALIAS TRAN_KEY

SELECT A.vch_type,A.vch_no1,A.vch_no2,;
	ALLTRIM(STR(A.vch_type,1)+"-"+STR(A.vch_no1,2)+"-"+STR(A.vch_no2,5)) AS V_No;
FROM TRAN_KEY A;
ORDER BY A.vch_type,A.vch_no1,A.vch_no2;
INTO DBF TRANKEY1



BROW

CLOSE ALL

RETURN
******************************



****************************
PROCEDURE _007
****************************

*DO _006

CLEAR
CLEA ALL
CLOSE ALL

* IN PROCEDURE _006 WE GOT DBF'S
*INTO DBF TRAN5.DBF
*INTO DBF TRANKEY1
* WE GET DATE IN TRANKEY2 FROM TRAN5 BY
* RELATION OF V_NO
*SELECT ;
*FROM ;
*ORDER BY ;
*INTO DBF

SELECT B.DATE,A.vch_type,A.vch_no1,A.vch_no2,A.V_No;
FROM TRANKEY1 A, TRAN5 B ;
WHERE A.V_NO = B.V_NO ;
ORDER BY A.V_No ;
INTO DBF TRANKEY2

CLOSE ALL

SELECT DISTINCT DATE,V_No;
FROM TRANKEY2;
ORDER BY DATE ;
INTO DBF TRANKEY3

INDEX ON V_NO TAG V_NO
INDEX ON DATE TAG DATE

SET ORDER TO DATE


BROW

CLOSE ALL

RETURN
******************************



****************************
PROCEDURE _008
****************************

*DO _006

CLEAR
CLEA ALL
CLOSE ALL

* IN PROCEDURE _006 WE GOT DBF'S
*INTO DBF TRAN5.DBF
*INTO DBF TRANKEY1
* WE GET DATE IN TRANKEY2 FROM TRAN5 BY
* RELATION OF V_NO
*SELECT ;
*FROM ;
*ORDER BY ;
*INTO DBF

SELECT * ;
FROM TRAN5 ;
ORDER BY V_NO1 ;
INTO DBF TRAN6

INDEX ON V_NO TAG V_NO


SELECT B.DATE,A.vch_type,A.vch_no1,A.vch_no2,A.V_No;
FROM TRANKEY1 A, TRAN5 B ;
WHERE A.V_NO = B.V_NO ;
ORDER BY A.V_No ;
INTO DBF TRANKEY2

CLOSE ALL

SELECT DISTINCT DATE,V_No;
FROM TRANKEY2;
ORDER BY DATE ;
INTO DBF TRANKEY3

INDEX ON V_NO TAG V_NO
INDEX ON DATE TAG DATE

SET ORDER TO DATE


BROW

CLOSE ALL

RETURN
******************************









