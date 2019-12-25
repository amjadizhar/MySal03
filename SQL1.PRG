* Sql commands practice 1 file
clear all
****************************************
PROCEDURE emp1 	&& SQL from employee.dbf
****************************************

SELECT deptcode,empno;
FROM employee

RETURN
******
****************************************
PROCEDURE emp2 	&& SQL from employee.dbf
****************************************

SELECT DISTINCT deptcode;
FROM employee

RETURN
******


****************************************
PROCEDURE emp3 	&& SQL from employee.dbf
****************************************

SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "EmpCode";
FROM employee;
ORDER BY EmpCode

RETURN
******

****************************************
PROCEDURE emp4 	&& SQL from employee.dbf
****************************************

SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "EmpCode",;
	   name,;
	   working AS "W",;
	   probation AS "P",;
	   doa,;
	   dole;
FROM employee;
ORDER BY EmpCode;
INTO CURSOR emp

RETURN
******


****************************************
PROCEDURE emp5 	&& SQL from employee.dbf
****************************************

SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "EmpCode",;
	   name,;
	   working AS "W",;
	   probation AS "P",;
	   doa,;
	   dole;
FROM employee;
ORDER BY EmpCode;
INTO CURSOR emp


SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "EmpCode",;
	   salcode AS "Sc",;
	   mpay AS "Mp";	   
FROM salary;
ORDER BY EmpCode;
INTO CURSOR sal


RETURN
******


****************************************
PROCEDURE emp6 	&& SQL from employee.dbf
****************************************

SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "EmpCode",;
	   name,;
	   working AS "W",;
	   probation AS "P",;
	   doa,;
	   dole;
FROM employee;
ORDER BY EmpCode;
INTO CURSOR emp


SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "EmpCode",;
	   salcode AS "Sc",;
	   mpay AS "Mp";	   
FROM salary;
ORDER BY EmpCode;
INTO CURSOR sal

SELECT name,Sc,Mp;
FROM emp,sal;
WHERE emp.EmpCode = sal.Empcode;
INTO CURSOR empsal


RETURN
******


****************************************
PROCEDURE emp7 	&& SQL from employee.dbf
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
	   salcode AS "Sc",;
	   mpay AS "Mp";	   
FROM salary;
ORDER BY CodSal;
INTO CURSOR sal

SELECT CodSal,name,Sc,Mp;
FROM emp,sal;
WHERE emp.CodEmp = sal.CodSal;
INTO CURSOR empsal



RETURN
******

****************************************
PROCEDURE emp8 	&& SQL from employee.dbf
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
	   salcode AS "Sc",;
	   mpay AS "Mp",;	   
	   basic,hrent,convy,medical,cma,pma,other,special,dwratem;
FROM salary;
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
PROCEDURE emp9 	&& SQL from employee.dbf
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
	   salcode AS "Sc",;
	   mpay AS "Mp",;	   
	   basic,hrent,convy,medical,cma,pma,other,special;
FROM salary;
ORDER BY CodSal;
INTO CURSOR sal

SELECT Sc,;
	   Sum(basic+hrent+convy+medical+cma+pma+other+special) AS "Gr_total";
FROM emp,sal;
WHERE emp.CodEmp = sal.CodSal AND emp.w = .T.;
ORDER BY Sc;
GROUP BY Sc;
INTO CURSOR empsal



RETURN
******


****************************************
PROCEDURE emp10 	&& SQL from employee.dbf
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
	   salcode AS "Sc",;
	   mpay AS "Mp",;	   
	   basic,hrent,convy,medical,cma,pma,other,special,dwratem;
FROM salary;
ORDER BY CodSal;
INTO CURSOR sal

SELECT Sc,descrip,;
	   Sum(basic+hrent+convy+medical+cma+pma+other+special+dwratem) AS "Gr_total";
FROM emp,sal,salcode;
WHERE emp.CodEmp = sal.CodSal AND emp.w = .T. AND Sc = salcode.salcode;
ORDER BY Sc;
GROUP BY Sc;
INTO CURSOR empsal2



RETURN
******
