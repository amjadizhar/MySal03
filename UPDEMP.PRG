* Program: UpdEmp.PRG
* TO update all data with employee.name, employee.empsrl etc
* Date Written: 04-May-2017
* this revision: 04-May-2017
***************************************

CLEAR
CLOSE DATA

PUBLIC mMcode, mYear
mMcode = 0
mYear = 0



SET DATE TO BRIT
SET CENT ON
SET TALK OFF
SET CONFIRM OFF
SET SAFE OFF

USE attend EXCL
GOTO TOP
STORE mcode TO mMcode
STORE year TO mYear

SELECT 1
USE attend EXCL
INDEX ON mcode TAG mcode
INDEX ON STR(mcode)+STR(year) TAG ymcode
INDEX ON empsrl TAG empsrl
INDEX ON name TAG name
INDEX ON STR(deptcode)+STR(empno) TAG empno2
INDEX ON STR(deptcode)+STR(empno)+STR(mcode)+STR(year) TAG empno
SET ORDER TO empno


SELECT 2
USE employee EXCL
INDEX ON STR(deptcode)+STR(empno)+STR(mcode)+STR(year) TAG empno
SET ORDER TO empno
REPLACE ALL EMPSRL WITH RECNO()

SELECT 1
SET RELATION TO STR(deptcode)+STR(empno)+STR(mcode)+STR(year) INTO employee ADDITIVE
REPLACE ALL attend.empsrl WITH employee.empsrl
REPLACE ALL attend.name WITH employee.name

CLEAR
CLOSE DATA

SELECT 1
USE salary EXCL
INDEX ON STR(deptcode)+STR(empno)+STR(mcode)+STR(year) TAG empno
SET ORDER TO empno

SELECT 2
USE employee EXCL
SET ORDER TO empno

SELECT 1
SET RELATION TO STR(deptcode)+STR(empno)+STR(mcode)+STR(year) INTO employee ADDITIVE
REPLACE ALL salary.empsrl WITH employee.empsrl
REPLACE ALL salary.name WITH employee.name

CLEAR
CLOSE DATA

SELECT 1
USE saldtail EXCL
INDEX ON STR(deptcode)+STR(empno)+STR(mcode)+STR(year) TAG empno
SET ORDER TO empno

SELECT 2
USE employee EXCL
SET ORDER TO empno

SELECT 1
SET RELATION TO STR(deptcode)+STR(empno)+STR(mcode)+STR(year) INTO employee ADDITIVE
REPLACE ALL saldtail.empsrl WITH employee.empsrl FOR mcode = mMcode AND year = mYear
REPLACE ALL saldtail.name WITH employee.name FOR mcode = mMcode AND year = mYear

CLEAR
CLOSE DATA

SELECT 1
USE saldtail EXCL
INDEX ON STR(mcode,2)+STR(year,4) TAG mcode
SET ORDER TO mcode

SELECT 2
USE salsheet EXCL
INDEX ON STR(mcode,2)+STR(year,4) TAG mcode
SET ORDER TO mcode

SELECT 1
SET RELATION TO STR(mcode,2)+STR(year,4) INTO salsheet ADDITIVE
REPLACE ALL saldtail.sheetno WITH salsheet.sheetno

CLEAR
CLOSE DATA
