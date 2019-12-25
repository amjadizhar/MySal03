* PROGRAM: UPDBON.PRG
* BONUS DAY PROGRAM
* TO UPDATE THE BONUS DAY
* WRITTEN BY AMJAD IZHAR
* LAST REVISED ON 02-03-2001
***********************************

CLEAR
CLOSE DATABASES
SET TALK OFF

PUBLIC mbonday,BdStr,mmcode,myear
mbonday = 0
BdStr = 0
mmcode = 0
myear = 0


SELECT 1
USE attend
STORE mcode TO mmcode
STORE year TO myear
USE

USE ysetting
SET FILTER TO year = myear
STORE bonday TO mbonday
USE

SET TALK ON

SELECT 1
USE month ORDER mcode
SEEK(mmcode)

* checking the Working Days

BdStr = mdays - (frds+hdays)
USE


*RESTORE SCREEN FROM Pwait1

SELECT 1
USE saldtail ORDER empno

SELECT 2
USE salary ORDER empno

SELECT 3
USE month ORDER mcode

SELECT 1
SET RELATION TO str(deptcode)+str(empno) INTO salary ADDITIVE
SET RELATION TO mcode INTO month ADDITIVE


SELECT saldtail
SET FILTER TO mcode = mmcode AND year = myear AND salary.wrdaily = .t.

REPLACE ALL bonday WITH mbonday;
	        FOR days = BdStr
	        
RETURN
***************************

