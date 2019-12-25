* Sql commands practice 5 file

*************************************************************
PROCEDURE emp8 	&& SQL from employee.dbf FOR Salaried Persons
*************************************************************

Qmonth = 1
Qyear = 1996

*  EMP
******************
SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "CodEmp",;
	   name,;
	   working AS "W",;
	   probation AS "P",;
	   doa,;
	   dole;
FROM employee;
ORDER BY CodEmp;
INTO CURSOR emp
******************

*  SAL
******************
SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "CodSal",;
	   name AS "E_Name",;
	   salcode AS "Sc",;
	   mpay AS "Mp",;	   
	   basic+hrent+convy+medical+cma+pma+other+special+dwratem AS "S_Gross",;
	   basic,hrent,convy,medical,cma,pma,other,special,dwratem,otrated;
FROM salary,emp;
WHERE STR(deptcode,2,0)+" -"+STR(empno,3,0) = emp.codEmp AND mpay = .t.;
ORDER BY CodSal;
INTO CURSOR sal
******************

*  EMPSAL
******************
SELECT CodSal,name,Sc,Mp,;
	   basic+hrent+convy+medical+cma+pma+other+special+dwratem AS "Gross",;
	   basic,hrent,convy,medical,cma,pma,other,special,otrated;
FROM emp,sal;
WHERE emp.CodEmp = sal.CodSal AND Mp = .t. AND Sc >= 1;
ORDER BY Sc;
INTO CURSOR empsal
******************

* SDTAIL
******************
SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "Sdet_Eno",;
	   name AS "Sd_Name",;
	   mcode AS "Sd_mcode",year AS "Sd_year",days,othrs,bonday;
FROM saldtail,empsal;
WHERE mcode = Qmonth AND year = Qyear AND;
	  STR(deptcode,2,0)+" -"+STR(empno,3,0) = empsal.CodSal;
ORDER BY Sdet_Eno;
INTO CURSOR sdtail
******************



* DED
******************
SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "ded_Eno",;
	   name AS "ded_Name",;
	   mcode AS "d_mcode",year AS "d_year",advance,midadv,other AS "d_other",;
	   pfund,itax;
FROM deduct,emp;
WHERE mcode = Qmonth AND year = Qyear AND;
	  STR(deptcode,2,0)+" -"+STR(empno,3,0) = emp.CodEmp;
ORDER BY ded_Eno;
INTO CURSOR ded
******************

*  SHEETSAL
******************
SELECT CodSal,name,Sc,Mp,;
	   d_mcode,d_year,;
	   basic,hrent,convy,medical,cma,pma,;
	   special,other,Gross,;
	   midadv,advance,pfund,d_other,itax,;
	   Gross - (midadv+advance+pfund+d_other+itax) AS "Net_Pay",;
   	   days,othrs,otrated,ROUND(othrs*otrated,0) AS "Ot_Amt",;
	   (Gross - (midadv+advance+pfund+d_other+itax)) + ;
	   ROUND(othrs*otrated,0) AS "Net_Pbl";
FROM empsal,sdtail,ded;
WHERE CodSal = sdtail.Sdet_Eno AND CodSal = ded.ded_Eno;
ORDER BY Sc;
INTO CURSOR sheetsal
******************

*  EMPSAL2
******************
SELECT Sc,descrip,;
	   Sum(Net_Pbl) AS "Gr_total";
FROM sheetsal,salcode;
WHERE Sc = salcode.salcode;
ORDER BY Sc;
GROUP BY Sc;
INTO CURSOR empsal2
******************



RETURN
******


****************************************
PROCEDURE emp9 	&& SQL from employee.dbf FOR WAGES persons.
****************************************

Qmonth = 1
Qyear = 1996




* WEMP
***************************************
SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "CodEmp",;
	   name,;
	   working AS "W",;
	   probation AS "P",;
	   doa,;
	   dole;
FROM employee;
ORDER BY CodEmp;
INTO CURSOR wemp
*****************



* WSAL
*****************************************
SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "CodSal",;
	   name AS "E_Name",;
	   salcode AS "Sc",;
	   mpay AS "Mp",;	   
	   dwrate*30 AS "W_Gross",;
	   dwrate,otrated;
FROM salary,wemp;
WHERE STR(deptcode,2,0)+" -"+STR(empno,3,0) = wemp.codEmp AND mpay = .f.;
ORDER BY CodSal;
INTO CURSOR wsal
****************



* WEMPSAL
****************************************
SELECT CodSal,name,Sc,Mp,;
	   dwrate*30 AS "Gross_30d",;
	   dwrate,otrated;
FROM wemp,wsal;
WHERE wemp.CodEmp = wsal.CodSal AND Mp = .f. AND Sc >= 1;
ORDER BY Sc;
INTO CURSOR wempsal
*******************


* WSDTAIL
******************
SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "Sdet_Eno",;
	   name AS "Sd_Name",;
	   mcode AS "Sd_mcode",year AS "Sd_year",days,othrs,bonday;
FROM saldtail,wempsal;
WHERE mcode = Qmonth AND year = Qyear AND;
	  STR(deptcode,2,0)+" -"+STR(empno,3,0) = wempsal.CodSal;
ORDER BY Sdet_Eno;
INTO CURSOR wsdtail
******************


* WDED
******************
SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "ded_Eno",;
	   name AS "ded_Name",;
	   mcode AS "d_mcode",year AS "d_year",advance,midadv,other AS "d_other",;
	   pfund,itax;
FROM deduct,wemp;
WHERE mcode = Qmonth AND year = Qyear AND;
	  STR(deptcode,2,0)+" -"+STR(empno,3,0) = wemp.CodEmp;
ORDER BY ded_Eno;
INTO CURSOR wded
******************




*  SHEETWAG
******************
SELECT CodSal,name,Sc,Mp,;
	   d_mcode,d_year,;
	   days,dwrate,;
	   (days*dwrate) AS "Twages",;
	   othrs,otrated,;
	   ROUND(othrs*otrated,0) AS "Tot_Ot",;
	   (bonday*dwrate) AS "Bns",;
	   (days*dwrate)+ROUND(othrs*otrated,0)+(bonday*dwrate) AS "Gross_w",;
	   midadv,advance,d_other,;
	   ((days*dwrate)+ROUND(othrs*otrated,0)+(bonday*dwrate)) - ;
	   (midadv+advance+d_other) AS "Net_Pbl";
FROM wempsal,wsdtail,wded;
WHERE CodSal = wsdtail.Sdet_Eno AND CodSal = wded.ded_Eno;
ORDER BY Sc;
INTO CURSOR sheetwag
******************







* WEMPSAL2
*****************************************
SELECT Sc,descrip,;
	   Sum(Net_Pbl) AS "Gr_total";
FROM sheetwag,salcode;
WHERE Sc = salcode.salcode;
ORDER BY Sc;
GROUP BY Sc;
INTO CURSOR wempsal2
********************


RETURN
******

