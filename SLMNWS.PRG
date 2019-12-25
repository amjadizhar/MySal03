

SELECT str(salcode,2)+"-"+str(deptcode,2)+"-"+str(empno,3) AS "code",;
	   "T_"+str(year,4)+"_"+str(mcode,2) AS "mnyr",;
	   tot_pay;
FROM slrydat;
INTO DBF tpmnws;
UNION ALL;
SELECT str(salcode,2)+"-"+str(deptcode,2)+"-"+str(empno,3) AS "code",;
	   "O_"+str(year,4)+"_"+str(mcode,2) AS "mnyr",;
	   ot_amt;
FROM slrydat;
UNION ALL;
SELECT str(salcode,2)+"-"+str(deptcode,2)+"-"+str(empno,3) AS "code",;
	   "N_"+str(year,4)+"_"+str(mcode,2) AS "mnyr",;
	   Net_Pay;
FROM slrydat;
ORDER BY code,mnyr




SELECT tpmnws
DO genxtab WITH 'tab1'


CLOSE DATA

SELECT salcode,  ;
	       sum(t_1996_1) AS "T_1_96",sum(o_1996_1) AS "O_1_96",sum(n_1996_1) AS "N_1_96", ;
	       sum(t_1996_2) AS "T_2_96",sum(o_1996_2) AS "O_2_96",sum(n_1996_2) AS "N_2_96", ;
	       sum(t_1996_3) AS "T_3_96",sum(o_1996_3) AS "O_3_96",sum(n_1996_3) AS "N_3_96", ;
	       sum(t_1996_4) AS "T_4_96",sum(o_1996_4) AS "O_4_96",sum(n_1996_4) AS "N_4_96", ;
	       sum(t_1996_5) AS "T_5_96",sum(o_1996_5) AS "O_5_96",sum(n_1996_5) AS "N_5_96", ;
	       sum(t_1996_6) AS "T_6_96",sum(o_1996_6) AS "O_6_96",sum(n_1996_6) AS "N_6_96", ;
	       sum(t_1996_7) AS "T_7_96",sum(o_1996_7) AS "O_7_96",sum(n_1996_7) AS "N_7_96", ;
	       sum(t_1996_8) AS "T_8_96",sum(o_1996_8) AS "O_8_96",sum(n_1996_8) AS "N_8_96", ;
	       sum(t_1996_9) AS "T_9_96",sum(o_1996_9) AS "O_9_96",sum(n_1996_9) AS "N_9_96", ;
	       sum(t_1996_10) AS "T_10_96",sum(o_1996_10) AS "O_10_96",sum(n_1996_10) AS "N_10_96", ;
	       sum(t_1996_11) AS "T_11_96",sum(o_1996_11) AS "O_11_96",sum(n_1996_11) AS "N_11_96", ;
	       sum(t_1996_12) AS "T_12_96",sum(o_1996_12) AS "O_12_96",sum(n_1996_12) AS "N_12_96" ;
FROM slmnws ;
WHERE salcode <> 0;
GROUP BY salcode ;
INTO DBF slmnws1

CLOSE DATA


SELECT 1
USE SlMnWs.dbf
ZAP
APPEND FROM tab1

SET DECIMAL TO 0

REPLACE ALL deptcode WITH VAL(SUBSTR(code,4,2))
REPLACE ALL empno WITH VAL(SUBSTR(code,8,3))
REPLACE ALL salcode WITH VAL(SUBSTR(code,1,2))

SELECT 2
USE employee ORDER empno

SELECT 3
USE salary ORDER empno2

SELECT 4
USE deptt ORDER deptcode

SELECT 5
USE slrydat ORDER empno2


SELECT 1
SET RELATION TO str(deptcode)+str(empno) INTO employee ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO salary ADDITIVE
SET RELATION TO deptcode INTO deptt ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO slrydat ADDITIVE


REPLACE ALL name WITH employee.name
REPLACE ALL deptname WITH deptt.deptname




INDEX ON salcode TAG salcode ADDITIVE







********************
PROCEDURE CalcMnWs
********************

PUBLIC GrossPay,OtAmt,NetPay
GrossPay = 0
OtAmt = 0
NetPay = 0

CLOSE DATA

SELECT 1
USE slrydat

SELECT 2
USE saldtail ORDER empno

SELECT 3
USE deduct ORDER empno

SELECT 4
USE month ORDER mcode


SELECT 1
SET RELATION TO str(deptcode)+str(empno)+str(mcode)+str(year);
	INTO saldtail ADDITIVE
SET RELATION TO str(deptcode)+str(empno)+str(mcode)+str(year);
	INTO deduct ADDITIVE
SET RELATION TO mcode INTO month ADDITIVE
	



SCAN

IF slrydat.mcode <= 12 AND year <= 1995
DO CASE

CASE slrydat.mpay AND slrydat.dwratem = 0

GrossPay = slrydat.basic+;
		   slrydat.hrent+;
		   slrydat.convy+;
		   slrydat.medical+;
		   slrydat.cma+;
		   slrydat.pma+;
		   slrydat.other+;
		   slrydat.special
		   
OtAmt = ROUND(slrydat.otrated*saldtail.othrs,0)

NetPay = GrossPay - (deduct.advance+deduct.midadv+deduct.other+;
					deduct.pfund+deduct.itax)+OtAmt


CASE NOT slrydat.mpay AND slrydat.dwrate <> 0

GrossPay = ROUND(slrydat.dwrate*saldtail.days,0);
		   +(saldtail.bonday * slrydat.dwrate)

OtAmt = ROUND(slrydat.otrated*saldtail.othrs,0)

NetPay = GrossPay - (deduct.advance+deduct.midadv+deduct.other+;
					deduct.pfund+deduct.itax)+OtAmt


CASE NOT slrydat.mpay AND slrydat.dwratem <> 0

GrossPay = slrydat.dwratem

OtAmt = ROUND(slrydat.otrated*saldtail.othrs,0)		   

NetPay = (GrossPay+OtAmt) - (deduct.advance+deduct.midadv+deduct.other+;
					deduct.pfund+deduct.itax)


ENDCASE

REPLACE Tot_Pay WITH GrossPay
REPLACE Ot_Amt WITH OtAmt
REPLACE Net_Pay WITH NetPay


ENDIF




IF slrydat.mcode <= 3 AND year <= 1996
DO CASE

CASE slrydat.mpay AND slrydat.dwratem = 0

GrossPay = slrydat.basic+;
		   slrydat.hrent+;
		   slrydat.convy+;
		   slrydat.medical+;
		   slrydat.cma+;
		   slrydat.pma+;
		   slrydat.other+;
		   slrydat.special
		   
OtAmt = ROUND(slrydat.otrated*saldtail.othrs,0)


NetPay = (GrossPay+OtAmt) - (deduct.advance+deduct.midadv+deduct.other+;
					deduct.pfund+deduct.itax)



CASE NOT slrydat.mpay AND slrydat.dwrate <> 0

GrossPay = ROUND(slrydat.dwrate*saldtail.days,0);
		   +(saldtail.bonday * slrydat.dwrate)

OtAmt = ROUND(slrydat.otrated*saldtail.othrs,0)


NetPay = (GrossPay+OtAmt) - (deduct.advance+deduct.midadv+deduct.other+;
					deduct.pfund+deduct.itax)


CASE NOT slrydat.mpay AND slrydat.dwratem <> 0

GrossPay = slrydat.dwratem

OtAmt = ROUND(slrydat.otrated*saldtail.othrs,0)		   

NetPay = (GrossPay+OtAmt) - (deduct.advance+deduct.midadv+deduct.other+;
					deduct.pfund+deduct.itax)


ENDCASE

REPLACE Tot_Pay WITH GrossPay
REPLACE Ot_Amt WITH OtAmt
REPLACE Net_Pay WITH NetPay

ENDIF





IF slrydat.mcode >= 4 AND year >= 1996
DO CASE

CASE slrydat.mpay AND slrydat.dwratem = 0

GrossPay = ROUND(slrydat.basic / month.mdays * saldtail.days,0)+;
		   ROUND(slrydat.hrent / month.mdays * saldtail.days,0)+;
		   ROUND(slrydat.convy / month.mdays * saldtail.days,0)+;
		   ROUND(slrydat.medical / month.mdays * saldtail.days,0)+;
		   ROUND(slrydat.cma / month.mdays * saldtail.days,0)+;
		   ROUND(slrydat.pma / month.mdays * saldtail.days,0)+;
		   ROUND(slrydat.other / month.mdays * saldtail.days,0)+;
		   ROUND(slrydat.special / month.mdays * saldtail.days,0)

OtAmt = ROUND(slrydat.otrated*saldtail.othrs,0)


NetPay = GrossPay - (deduct.advance+deduct.midadv+deduct.other+;
					deduct.pfund+deduct.itax)+OtAmt


CASE NOT slrydat.mpay AND slrydat.dwrate <> 0

GrossPay = ROUND(slrydat.dwrate*saldtail.days,0)+;
		   (saldtail.bonday * slrydat.dwrate)

OtAmt = ROUND(slrydat.otrated*saldtail.othrs,0)

NetPay = (GrossPay+OtAmt) - (deduct.advance+deduct.midadv+deduct.other+;
					deduct.pfund+deduct.itax)


CASE NOT slrydat.mpay AND slrydat.dwratem <> 0

GrossPay = ROUND(slrydat.dwratem / month.mdays * saldtail.days,0)
		   
OtAmt = ROUND(slrydat.otrated*saldtail.othrs,0)

NetPay = (GrossPay+OtAmt) - (deduct.advance+deduct.midadv+deduct.other+;
					deduct.pfund+deduct.itax)


ENDCASE

REPLACE Tot_Pay WITH GrossPay
REPLACE Ot_Amt WITH OtAmt
REPLACE Net_Pay WITH NetPay

ENDIF

ENDSCAN


RETURN
****************