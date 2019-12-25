* Sql commands practice 2 file

****************************************
PROCEDURE emp8 	&& SQL from employee.dbf FOR Salaried Persons
****************************************

SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "CodEmp",;
	   name,;
	   working AS "W",;
	   probation AS "P",;
	   doa,;
	   dole;
FROM employee;
ORDER BY CodEmp;
INTO CURSOR emp


SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "CodSal",;
	   name AS "E_Name",;
	   salcode AS "Sc",;
	   mpay AS "Mp",;	   
	   basic+hrent+convy+medical+cma+pma+other+special+dwratem AS "S_Gross",;
	   basic,hrent,convy,medical,cma,pma,other,special,dwratem;
FROM salary,emp;
WHERE STR(deptcode,2,0)+" -"+STR(empno,3,0) = emp.codEmp AND mpay = .t.;
ORDER BY CodSal;
INTO CURSOR sal

SELECT CodSal,name,Sc,Mp,;
	   basic+hrent+convy+medical+cma+pma+other+special+dwratem AS "Gross",;
	   basic,hrent,convy,medical,cma,pma,other,special;
FROM emp,sal;
WHERE emp.CodEmp = sal.CodSal AND Mp = .t. AND Sc >= 1;
ORDER BY Sc;
INTO CURSOR empsal

SELECT Sc,descrip,;
	   Sum(Gross) AS "Gr_total";
FROM empsal,salcode;
WHERE Sc = salcode.salcode;
ORDER BY Sc;
GROUP BY Sc;
INTO CURSOR empsal2



RETURN
******


****************************************
PROCEDURE emp9 	&& SQL from employee.dbf FOR WAGES persons.
****************************************

SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "CodEmp",;
	   name,;
	   working AS "W",;
	   probation AS "P",;
	   doa,;
	   dole;
FROM employee;
ORDER BY CodEmp;
INTO CURSOR wemp


SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "CodSal",;
	   salcode AS "Sc",;
	   mpay AS "Mp",;	   
	   dwrate,otrated;
FROM salary;
WHERE mpay = .f.;
ORDER BY CodSal;
INTO CURSOR wsal

SELECT CodSal,name,Sc,Mp,;
	   dwrate*30 AS "Gross_30d",;
	   dwrate,otrated;
FROM wemp,wsal;
WHERE wemp.CodEmp = wsal.CodSal AND Mp = .f. AND Sc >= 1;
ORDER BY Sc;
INTO CURSOR wempsal

SELECT Sc,descrip,;
	   Sum(Gross_30d) AS "Gr_total";
FROM wempsal,salcode;
WHERE Sc = salcode.salcode;
ORDER BY Sc;
GROUP BY Sc;
INTO CURSOR wempsal2



RETURN
******

