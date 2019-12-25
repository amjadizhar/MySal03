* PROGRAM TO GET MONTHLY SUMMARY SHEET AND OTHER REPORTS


*************************************************************
PROCEDURE SlrySum1 	&& SQL from employee.dbf FOR Salaried Persons
*************************************************************
PUBLIC Qmonth,Qyear,MnthDys,mFrds,mHdays

Qmonth = 5
Qyear = 1996
MnthDys = 0
mFrds = 0
mHdays = 0


USE month
LOCATE FOR mcode = Qmonth

STORE mDays TO MnthDys
STORE frds TO mFrds
STORE hdays TO mHdays
USE


*  EMP   Working Employees
******************
SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "CodEmp",;
	   name,;
	   working AS "W",;
	   probation AS "P",;
	   doa,;
	   dole;
FROM employee;
WHERE working = .t.;
ORDER BY CodEmp;
INTO CURSOR emp
******************

*  SAL
******************
SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "CodSal",;
	   name AS "E_Name",;
	   salcode AS "Sc",;
	   mpay AS "Mp",;	   
	   p AS "Prb",;
	   basic+hrent+convy+medical+cma+pma+other+special+dwratem AS "S_Gross",;
	   basic,hrent,convy,medical,cma,pma,other,special,dwratem,otrated;
FROM salary,emp;
WHERE STR(deptcode,2,0)+" -"+STR(empno,3,0) = emp.codEmp AND mpay = .t.;
ORDER BY CodSal;
INTO CURSOR sal
******************

*  EMPSAL
******************
SELECT CodSal,name,Sc,Mp,Prb,;
	   basic+hrent+convy+medical+cma+pma+other+special+dwratem AS "Gross",;
	   basic,hrent,convy,medical,cma,pma,other,special,otrated;
FROM emp,sal;
WHERE emp.CodEmp = sal.CodSal AND Mp = .t. AND Sc >= 1;
ORDER BY CodSal;
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
SELECT CodSal,name,Sc,Mp,Prb,;
	   d_mcode,d_year,;
	   ROUND(basic / MnthDys * days,0) AS "Basic",;
	   ROUND(hrent / MnthDys * days,0) AS "Hrent",;
	   ROUND(convy / MnthDys * days,0) AS "Convy",;
	   ROUND(medical / MnthDys * days,0) AS "Medical",;
	   ROUND(cma / MnthDys * days,0) AS "Cma",;
	   ROUND(pma / MnthDys * days,0) AS "Pma",;
	   ROUND(special / MnthDys * days,0) AS "Special",;
	   ROUND(other / MnthDys * days,0) AS "Other",;
	   midadv,advance,pfund,d_other,itax,;
	   ROUND(basic / MnthDys * days,0) + ROUND(hrent / MnthDys * days,0)+;
	   ROUND(convy / MnthDys * days,0) + ROUND(medical / MnthDys * days,0)+;
	   ROUND(cma / MnthDys * days,0) +  ROUND(pma / MnthDys * days,0)+;
	   ROUND(special / MnthDys * days,0) + ROUND(other / MnthDys * days,0) AS "Gross",;
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
SELECT Sc,00 AS "Rplc",descrip,;
	   Sum(Gross),;
	   Sum(midadv),;
	   Sum(advance),;
	   Sum(pfund),;
	   Sum(itax),;
	   Sum(d_other),;	   	   
	   Sum(Gross) - (Sum(midadv)+Sum(advance)+;
	   Sum(pfund)+Sum(itax)+Sum(d_other)) AS "Net";
FROM sheetsal,salcode;
WHERE Sc = salcode.salcode AND sheetsal.prb = .f.;
ORDER BY Sc;
GROUP BY Sc;
INTO CURSOR empsal2
******************



RETURN
******


