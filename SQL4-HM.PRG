* Sql commands practice 4 file


****************************************
PROCEDURE emp10 	&& SQL from employee.dbf
****************************************


* 1
* EMPL
***********************************************************
SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "CodEmp",;
	   salutation,name AS "E_name",father,addr1,addr2,addr3,;
	   city,phone1,phone2,phonepp,nicno,doa,Designatn,probation,;
	   working,dole,ssecno,eobino,pfundact,pfundbnk,ref1,ref2,;
	   notes;
FROM employee;
ORDER BY CodEmp;
INTO CURSOR empl
*************************************************************


* 2
* SAL
*************************************************************
SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "CodSal",;
	   salcode AS "Sc",;
	   mpay,basic,hrent,convy,medical,cma,pma,other,special,;
	   wrdaily,dwrate,dwratem,otdaily,otrated,otratem,payslip;
FROM salary;
ORDER BY CodSal;
INTO CURSOR sal
*************************************************************

* 3
* EMPSAL
*************************************************************
SELECT CodEmp,E_name,doa,dole,;
	   mpay,basic,wrdaily,otrated;
FROM empl,sal;
INTO CURSOR empsal;
WHERE CodEmp = CodSal AND sal.basic < 1000 AND sal.basic > 1;
UNION ALL;
SELECT CodEmp,E_name,doa,dole,;
	   mpay,basic,wrdaily,otrated;
FROM empl,sal;
WHERE CodEmp = CodSal AND sal.basic < 2000 AND sal.basic > 1000;
UNION ALL;
SELECT CodEmp,E_name,doa,dole,;
	   mpay,basic,wrdaily,otrated;
FROM empl,sal;
WHERE CodEmp = CodSal AND sal.basic < 3000 AND sal.basic > 2000;
UNION ALL;
SELECT CodEmp,E_name,doa,dole,;
	   mpay,basic,wrdaily,otrated;
FROM empl,sal;
WHERE CodEmp = CodSal AND sal.basic < 4000 AND sal.basic > 3000;
UNION ALL;
SELECT CodEmp,E_name,doa,dole,;
	   mpay,basic,wrdaily,otrated;
FROM empl,sal;
WHERE CodEmp = CodSal AND sal.basic < 5000 AND sal.basic > 4000;
UNION ALL;
SELECT CodEmp,E_name,doa,dole,;
	   mpay,basic,wrdaily,otrated;
FROM empl,sal;
WHERE CodEmp = CodSal AND sal.basic < 6000 AND sal.basic > 5000

*************************************************************