* PROGRAM  TMPDE.PRG
* Print Taken on :  05-06-96

*Brows Fields;
*deptcode,deptt.deptname,Salutation,name,empno

*BROWS FIELDS;
*deptcode,deptt.deptname,empno,employee.salutation,employee.name,salcode,salcode.descrip


************************************
* Enter Employee's Salaries & Allowances
* 
************************************
*set view to sal
*BROWS FIELDS;
*deptcode,empno,salcode,salcode.descrip,employee.name,basic,hrent,convy,medical,cma,pma,other,special;
*for salcode = 1

************************************
* Enter Employee's Daily Wages &  
* Over time Rate Daily
************************************
*set view to sal
*BROWS FIELDS;
*deptcode,empno,salcode,salcode.descrip,employee.name,dwrate,otrated;
*for salcode = 3

**************************************
* Enter Employee's Deductions Monthly*
**************************************

*set view to deduct
*brow fields;
*deptcode,empno,salary.salcode,employee.name,advance,pfund,;
*salary.basic,month,month.mnthdescrp,;
*year,itax;
*for salary.salcode = 2

**************************************
* Enter New Employee DAILY WAGES *****
**************************************

*set view to newemp
*brow fields;
*deptcode,deptt.deptname,empno,salutation,name,father,salary.salcode,;
*salary.dwrate,salary.otrated


**************************************
* Entry for New Salary Sheet
* and Salary Detail in SALDTAIL.DBF
**************************************

*PUBLIC msheet,mmonth,myear

*USE salsheet ORDER Sheetno
*GOTO BOTTOM
*msheet = SHEETNO + 1
*mmonth = 0
*myear = 0

*CLEAR

*@ 3,10 SAY "New Sheet No.: "
*@ 3,35 SAY msheet
*@ 4,10 SAY "Enter the Month No.  :" GET mmonth PICT "99"
*@ 5,10 SAY "Enter the Year (1995):" GET myear PICT "9999"
*READ

*APPEND BLANK
*REPLACE sheetno WITH msheet
*REPLACE month WITH mmonth
*REPLACE year WITH myear
*use

*SET VIEW TO saldtail.vue

*APPEND FROM employee.dbf FIELDS deptcode,empno;
*	FOR employee.working

*REPLACE ALL sheetno WITH msheet




*********************************************
* View Salary Sheet for 
* SalCodes 1
*********************************************

*SET VIEW TO viewsal.vue
*BROW FIELDS;
*deptcode,empno,employee.name,basic,hrent,medical,cma,pma,other,special,;
*deduct.advance,deduct.other,deduct.pfund;
*for salcode = 7 .and. deduct.month = 9


*********************************************
* View Salary Sheet for 
* SalCodes 4,7,8,10
*********************************************
*
*SET VIEW TO viewsal.vue
*BROW FIELDS;
*deptcode,empno,employee.name,basic,hrent,convy,medical,cma,pma,other,special,;
*deduct.advance,deduct.other,deduct.pfund;
*for salcode = 8 .and. deduct.month = 9


**********************************************
* Report Salary Sheet 
* for Salcode 1,4,7,8,10,11,12
**********************************************

*****************************
PROCEDURE PSalSht
*****************************

SET TALK OFF
SET SAFETY OFF

??? CHR(15)

CLEAR
CLOSE DATABASES

SELECT 1
USE salary ORDER empno

SELECT 2
USE employee ORDER empno

SELECT 3
USE deduct ORDER empno

SELECT 4
USE salcode ORDER salcode

SELECT 5
USE month ORDER mcode

SELECT 6
USE salsheet ORDER sheetno

SELECT 7
USE saldtail ORDER empno

SELECT 1
SET RELATION TO salcode INTO salsheet ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO deduct ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO employee ADDITIVE

SELECT 7
SET RELATION TO str(deptcode)+str(empno) INTO employee ADDITIVE
SET RELATION TO mcode INTO month ADDITIVE
SET RELATION TO sheetno INTO salsheet ADDITIVE


Rmonth = 0
Rsalcode = 0

clear
@ 6,10 SAY "Enter the Salary Sheet Code  : "
@ 7,12 GET Rsalcode PICT "99"
READ

SELECT salcode
SEEK(Rsalcode)
@ 7,25 SAY salcode.descrip
title = salcode.descrip

@ 10,10 SAY "Enter the Month No. You want to get Salary Sheet"
@ 12,10 GET Rmonth PICT "99"
READ

SELECT saldtail
set filter to 
set filter to mcode = Rmonth

SELECT deduct
set filter to
set filter to mcode = Rmonth


SELECT month
SEEK(Rmonth)
@ 14,10 SAY month.month

mdescrip1 = ALLTRIM(month.month)

SELECT salsheet
SET ORDER TO mcode
SEEK(Rmonth)
@ 14,22 SAY salsheet.year
mdescrip = mdescrip1 + "," + ALLTRIM(str(salsheet.year))
SET ORDER TO sheetno
wait

SELECT salary

SET FILTER TO
SET FILTER TO SALCODE = Rsalcode

??? CHR(15)
REPORT FORM sheetsal PREVIEW
RETURN
****************************
*****************************************************
* Data Entry for Wages Days and Over Time & advance Deductions
* for Employees Who have Wages Rate Daily
*****************************************************


*SET VIEW TO wages
*SELECT saldtail



*BROWS FIELDS;
*	sheetno,salsheet.mcode,deptcode,empno,employee.name,salary.mpay,;
*	salary.wrdaily,;
*	days,salary.dwrate,salary.dwratem,;
*	wages = days*salary.dwrate,;
*	othrs,salary.otrated,;
*	otamt = othrs*salary.otrated,;
*	bonday,bonamt = bonday*salary.dwrate,;
*	total = (days*salary.dwrate) + (othrs*salary.otrated) + (bonday*salary.dwrate),;
*	deduct.advance,;
*	net = ((days*salary.dwrate) + (othrs*salary.otrated) + (bonday*salary.dwrate)) - deduct.advance;
*	for not salary.mpay .and. salary.wrdaily


*****************************************************
* Data Entry for Wages Days and Over Time & advance Deductions
* for Employees Who have Wages Rate ***  MONTHLY   **************************
*****************************************************


*SET VIEW TO wages
*SELECT saldtail



*BROWS FIELDS;
*	sheetno,mcode,month.month,deptcode,empno,employee.name,salary.mpay,;
*	salary.wrdaily,;
*	days,salary.dwrate,salary.dwratem,;
*	wages = days*(salary.dwratem/month.mdays),;
*	othrs,salary.otrated,;
*	otamt = othrs*salary.otrated,;
*	bonday,bonamt = bonday*salary.dwrate,;
*	total = (days*(salary.dwratem/month.mdays)) + (othrs*salary.otrated) + (bonday*salary.dwrate),;
*	deduct.advance,;
*	net = ((days*(salary.dwratem/month.mdays)) + (othrs*salary.otrated) + (bonday*salary.dwrate)) - deduct.advance;
*	for not salary.mpay .and. not salary.wrdaily
*	


*****************************************************
* Data Entry for Over Time
* for Employees Who have Monthly Pay
*****************************************************


*SET VIEW TO wages
*SELECT saldtail



*BROWS FIELDS;
*	sheetno,salsheet.mcode,deptcode,empno,employee.name,salary.salcode,;
*	days,;
*	othrs,salary.otrated,;
*	otamt = othrs*salary.otrated;
*	for salary.salcode = 1


**********************************************
* Report Wages Sheet 
* for Salcode 2,3,5,6
**********************************************

************************
PROCEDURE PWagesSht
************************


SET TALK OFF
SET SAFETY OFF

??? CHR(15)
CLEAR
CLOSE DATABASES

PUBLIC Rmonth,mYear,Rsalcode

SELECT 1
USE saldtail ORDER empno

SELECT 2
USE employee ORDER empno

SELECT 3
USE salsheet ORDER sheetno

SELECT 4
USE month ORDER mcode

SELECT 5
USE salary ORDER empno

SELECT 6
USE deduct ORDER empno

SELECT 7
USE instded ORDER empno

SELECT 8
USE salcode ORDER salcode



SELECT 1
SET RELATION TO str(deptcode)+str(empno) INTO employee ADDITIVE
SET RELATION TO sheetno INTO salsheet ADDITIVE
SET RELATION TO mcode INTO month ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO salary ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO deduct ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO instded ADDITIVE


Rmonth = 0
Rsalcode = 0
myear = 0

clear
@ 6,10 SAY "Enter the Wages Sheet Code  : "
@ 7,12 GET Rsalcode PICT "99"
READ

SELECT salcode
SEEK(Rsalcode)
@ 7,25 SAY salcode.descrip
title = salcode.descrip

@ 10,10 SAY "Enter the Month No. You want to get Salary Sheet";
GET Rmonth PICT "99"
@ 14,10 SAY "Enter the Year " GET mYear PICT "9999"
READ

SELECT saldtail
set filter to 
set filter to mcode = Rmonth AND year = myear

SELECT deduct
set filter to
set filter to mcode = Rmonth AND year = myear


SELECT month
SEEK(Rmonth)
@ 14,10 SAY month.month

mdescrip1 = ALLTRIM(month.month)

SELECT salsheet
SET ORDER TO mcode
SEEK(Rmonth)
@ 14,22 SAY salsheet.year
mdescrip = mdescrip1 + "," + ALLTRIM(str(salsheet.year))
SET ORDER TO sheetno
wait


SELECT saldtail


??? CHR(15)
REPORT FORM sheetwag FOR salary.salcode = Rsalcode PREVIEW
RETURN
*********************************************

* Report Sheet O.T. For salaried Persons

********************
PROCEDURE POtSht
*********************

SET TALK OFF
SET SAFETY OFF

??? CHR(15)
CLEAR
CLOSE DATABASES

mdescrip = "June,1996"
title = "Factory Management"

SELECT 1
USE saldtail ORDER empno
SET FILTER TO mcode = 6 .and. year = 1996


SELECT 2
USE employee ORDER empno

SELECT 3
USE salary ORDER empno

SELECT 1
SET RELATION TO str(deptcode)+str(empno) INTO employee ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO salary ADDITIVE

REPORT FORM sheetot FOR salary.salcode = 1 AND salary.otrated <> 0 PREVIEW


RETURN