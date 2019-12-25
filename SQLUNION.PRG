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