
CLEAR
CLOSE DATABASES

USE attend
STORE mcode TO mmcode
STORE year TO myear

CLOSE DATABASES

SELECT 1
	USE deduct ORDER empno
	SET FILTER TO 
	SET FILTER TO mcode = mmcode AND year = myear

SELECT 2
	USE salary ORDER empno2

SELECT 3
	USE employee ORDER empno
	
SELECT 4
	USE saldtail ORDER empno
	SET FILTER TO
	SET FILTER TO mcode = mmcode AND year = myear

SELECT 1
	SET RELATION TO str(deptcode)+str(empno) INTO salary ADDITIVE
	SET RELATION TO str(deptcode)+str(empno) INTO employee ADDITIVE
	SET RELATION TO str(deptcode)+str(empno)+str(mcode)+str(year) INTO saldtail ADDITIVE
	
	REPLACE ALL pfund WITH salary.basic/100*6 FOR NOT salary.probation;
		AND salary.mpay = .T.;
		AND salary.working = .T.;
		AND salary.salcode <> 0;
		AND saldtail.days > 5

