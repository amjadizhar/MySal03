* Prorgram: UPDEMPSR.PRG
* To Update empsrl Field in all tables
* To Update name Field in all tables
* THIS UPDATE: 11-JUL-2017
*******************************


CLEAR
CLEAR ALL
CLOSE ALL

PUBLIC mMcode, mYear
mMcode = 0
mYear = 0

USE employee EXCL
REPLACE ALL empsrl WITH RECNO()
USE

USE employee
GOTO TOP

SCAN
	repliYear=REPLICATE('0',4-LEN(LTRIM(STR(year))))+LTRIM(STR(year))
	repliMcode = REPLICATE('0',2-LEN(LTRIM(STR(mcode))))+LTRIM(STR(mcode))
	repliDeptcode=REPLICATE('0',2-LEN(LTRIM(STR(deptcode))))+LTRIM(STR(deptcode))
	repliEmpNo = REPLICATE('0',3-LEN(LTRIM(STR(empno))))+LTRIM(STR(empno))
	repliEmpSrl=REPLICATE('0',12-LEN(LTRIM(STR(empsrl))))+LTRIM(STR(empsrl))
	mEmpID = repliYear + repliMcode + repliDeptcode + repliEmpNo + repliEmpSrl
	REPLACE EmpID WITH mEmpID
ENDSCAN
USE

***********************************************************

SELECT 1
USE employee EXCL
INDEX ON STR(DEPTCODE)+STR(EMPNO)+STR(MCODE)+STR(YEAR) TAG empno
SET ORDER TO empno

SELECT 2
USE salary EXCL
INDEX ON STR(DEPTCODE)+STR(EMPNO)+STR(MCODE)+STR(YEAR) TAG empno
SET ORDER TO empno

SELECT salary
SET RELATION TO STR(DEPTCODE)+STR(EMPNO)+STR(MCODE)+STR(YEAR) INTO employee ADDITIVE
REPLACE ALL salary.empsrl WITH employee.empsrl
REPLACE ALL salary.name WITH employee.name
REPLACE ALL salary.empid WITH employee.empid


SELECT 3
USE attend EXCL
INDEX ON STR(DEPTCODE)+STR(EMPNO)+STR(MCODE)+STR(YEAR) TAG empno
SET ORDER TO empno

mMcode = attend.mcode
mYear = attend.year


SELECT attend
SET RELATION TO STR(DEPTCODE)+STR(EMPNO)+STR(MCODE)+STR(YEAR) INTO employee ADDITIVE
REPLACE ALL attend.empsrl WITH employee.empsrl
REPLACE ALL attend.name WITH employee.name
REPLACE ALL attend.empid WITH employee.empid

SELECT 4
USE artime EXCL
INDEX ON STR(DEPTCODE)+STR(EMPNO)+STR(MCODE)+STR(YEAR) TAG empno
SET ORDER TO empno

SELECT artime
SET RELATION TO STR(DEPTCODE)+STR(EMPNO)+STR(MCODE)+STR(YEAR) INTO employee ADDITIVE
REPLACE ALL artime.empsrl WITH employee.empsrl
REPLACE ALL artime.name WITH employee.name
REPLACE ALL artime.empid WITH employee.empid

SELECT 5
USE ovtime EXCL
INDEX ON STR(DEPTCODE)+STR(EMPNO)+STR(MCODE)+STR(YEAR) TAG empno
SET ORDER TO empno

SELECT ovtime
SET RELATION TO STR(DEPTCODE)+STR(EMPNO)+STR(MCODE)+STR(YEAR) INTO employee ADDITIVE
REPLACE ALL ovtime.empsrl WITH employee.empsrl
REPLACE ALL ovtime.name WITH employee.name
REPLACE ALL ovtime.empid WITH employee.empid

SELECT 6
USE dptime EXCL
INDEX ON STR(DEPTCODE)+STR(EMPNO)+STR(MCODE)+STR(YEAR) TAG empno
SET ORDER TO empno

SELECT dptime
SET RELATION TO STR(DEPTCODE)+STR(EMPNO)+STR(MCODE)+STR(YEAR) INTO employee ADDITIVE
REPLACE ALL dptime.empsrl WITH employee.empsrl
REPLACE ALL dptime.name WITH employee.name
REPLACE ALL dptime.empid WITH employee.empid

SELECT 7
USE deduct EXCL
INDEX ON STR(DEPTCODE)+STR(EMPNO)+STR(MCODE)+STR(YEAR) TAG empno
SET ORDER TO empno

SELECT deduct
SET FILTER TO
SET FILTER TO mcode = mMcode AND year = mYear
SET RELATION TO STR(DEPTCODE)+STR(EMPNO)+STR(MCODE)+STR(YEAR) INTO employee ADDITIVE
REPLACE ALL deduct.empsrl WITH employee.empsrl
REPLACE ALL deduct.name WITH employee.name
REPLACE ALL deduct.empid WITH employee.empid

SELECT 8
USE saldtail EXCL
INDEX ON STR(DEPTCODE)+STR(EMPNO)+STR(MCODE)+STR(YEAR) TAG empno
SET ORDER TO empno

SELECT saldtail
SET FILTER TO
SET FILTER TO mcode = mMcode AND year = mYear
SET RELATION TO STR(DEPTCODE)+STR(EMPNO)+STR(MCODE)+STR(YEAR) INTO employee ADDITIVE
REPLACE ALL saldtail.empsrl WITH employee.empsrl
REPLACE ALL saldtail.name WITH employee.name
REPLACE ALL saldtail.empid WITH employee.empid

CLEAR
CLEA ALL
CLOSE ALL
