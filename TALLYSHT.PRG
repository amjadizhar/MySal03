* Report Program for Attendence Tally Sheet


DO iniset


REPORT FORM TallySht.frx TO tallysht.txt



*REPORT FORM TallySht.frx PREVIEW



****************************
PROCEDURE iniset
****************************


CLEAR
CLOSE DATABASES

SELECT 1
USE attend ORDER empno2

SELECT 2
USE employee ORDER empno

SELECT 3
USE salary ORDER empno

SELECT 4
USE ovtime ORDER empno2

SELECT 1
SET RELATION TO str(deptcode)+str(empno) INTO employee ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO salary ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO ovtime ADDITIVE

RETURN
******************************

