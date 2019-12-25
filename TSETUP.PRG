******************************
* PROGRAM: TSETUP.PRG
* Program to setup initial Databases and indexes
* also this program searches if any file is missing
* PROGRAMMER : AMJAD IZHAR
*
* Test and Debugging program of TSETUP.PRG

*******************************
ON ERROR DO errhand WITH ERROR(), MESSAGE()

											*Debugging Information
											clear
											@ 22,0 say 'Starting Procedure'
											@ 23,0 say 'DO iniset'
											wait

											clear
											@ 22,0 say 'Program: '+program()
											@ 22,20 say 'Line No: '+Alltrim(str(lineno()))
											wait
DO IIISKS		
											clear
											@ 22,0 say 'Program: '+program()
											@ 22,20 say 'Line No: '+Alltrim(str(lineno()))
											wait

											clear
											@ 10,0 say 'Starting Procedure'
											@ 11,0 say 'DO srchfls'
											wait
											
											clear
											@ 22,0 say 'Program: '+program()
											@ 22,20 say 'Line No: '+Alltrim(str(lineno()))
											wait
DO srchfls
											
											clear
											@ 22,0 say 'Program: '+program()
											@ 22,20 say 'Line No: '+Alltrim(str(lineno()))
											wait
											
											clear
											@ 10,0 say 'Starting Procedure'
											@ 11,0 say 'DO endprog'
											wait
DO endprog
											clear
											@ 22,0 say 'Program: '+program()
											@ 22,20 say 'Line No: '+Alltrim(str(lineno()))
											wait


PROCEDURE iniset
											clear
											@ 10,0 say 'Starting Procedure'
											@ 11,0 say 'PROCEDURE iniset'
											wait
											
											clear
											@ 22,0 say 'Program: '+program()
											@ 22,20 say 'Line No: '+Alltrim(str(lineno()))
											wait

											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'CLEAR'
											wait
CLEAR
									
											clear
											@ 22,0 say 'Program: '+program()
											@ 22,20 say 'Line No: '+Alltrim(str(lineno()))
											wait

											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'CLEAR ALL'
											wait
CLEAR ALL
											clear
											@ 22,0 say 'Program: '+program()
											@ 22,20 say 'Line No: '+Alltrim(str(lineno()))
											wait
											
											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'SET FUNCTION F1 TO'
											wait
SET FUNCTION F1 TO
											clear
											@ 22,0 say 'Program: '+program()
											@ 22,20 say 'Line No: '+Alltrim(str(lineno()))
											wait
											
											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'SET FUNCTION F2 TO'
											wait
SET FUNCTION F2 TO
											clear
											@ 22,0 say 'Program: '+program()
											@ 22,20 say 'Line No: '+Alltrim(str(lineno()))
											wait

											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'SET FUNCTION F3 TO'
											wait
SET FUNCTION F3 TO
											clear
											@ 22,0 say 'Program: '+program()
											@ 22,20 say 'Line No: '+Alltrim(str(lineno()))
											wait

											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'SET FUNCTION F4 TO'
											wait
SET FUNCTION F4 TO
											clear
											@ 22,0 say 'Program: '+program()
											@ 22,20 say 'Line No: '+Alltrim(str(lineno()))
											wait

											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'SET FUNCTION F5 TO'
											wait
SET FUNCTION F5 TO
											clear
											@ 22,0 say 'Program: '+program()
											@ 22,20 say 'Line No: '+Alltrim(str(lineno()))
											wait

											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'SET FUNCTION F6 TO'
											wait
SET FUNCTION F6 TO



											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'SET FUNCTION F7 TO'
											wait
SET FUNCTION F7 TO

											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'SET FUNCTION F8 TO'
											wait
SET FUNCTION F8 TO

											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'SET FUNCTION F9 TO'
											wait
SET FUNCTION F9 TO

											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'SET FUNCTION F10 TO'
											wait
SET FUNCTION F10 TO

											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'SET FUNCTION F11 TO'
											wait
SET FUNCTION F11 TO

											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'SET FUNCTION F12 TO'
											wait
SET FUNCTION F12 TO

											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'SET SYSMENU OFF'
											wait
SET SYSMENU OFF

											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'SET TALK OFF'
											wait
SET TALK OFF

											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'SET SAFETY OFF'
											wait
SET SAFETY OFF


											clear
											@ 10,0 say 'Command will run'
											@ 11,0 say 'RETURN'
											wait

RETURN

***********************************
PROCEDURE srchfls
***********************************
DEFINE WINDOW full FROM 0,0 TO 24,79 DOUBLE
ACTIVATE WINDOW full

@ 0,3 SAY "This Software requires following files existing in current directory"
@ 1,1,1,78 BOX

row1=2
col1=2
col2=16
col3=30
col4=44

@ row1-1,col1+3 SAY "Database Files"
@ row1-1,col3+3 SAY "Index Files"

@ row1-1,col1-1,22,col3-4 BOX
@ row1-1,col3-1,22,col4+10 BOX

@ row1,col1 SAY "ATTEND.DBF"
IF FILE("ATTEND.DBF") = .T.
	@ row1,col2 SAY "Found - Ok"
ENDIF
IF FILE("ATTEND.DBF") = .F.
	@ row1,col2 SAY "Not Found!"
ENDIF


@ row1,col3 SAY "ATTEND.CDX"
IF FILE("ATTEND.CDX") = .T.
	@ row1,col4 SAY "Found - Ok"
ENDIF
IF FILE("ATTEND.CDX") = .F.
	@ row1,col4 SAY "Not Found!"
ENDIF

@ row1+1,col1 SAY "EMPLOYEE.DBF"
IF FILE("EMPLOYEE.DBF") = .T.
	@ row1+1,col2 SAY "Found - Ok"
ENDIF
IF FILE("EMPLOYEE.DBF") = .F.
	@ row1+1,col2 SAY "Not Found!"
ENDIF


@ row1+1,col3 SAY "EMPLOYEE.CDX"
IF FILE("EMPLOYEE.CDX") = .T.
	@ row1+1,col4 SAY "Found - Ok"
ENDIF
IF FILE("EMPLOYEE.CDX") = .F.
	@ row1+1,col4 SAY "Not Found!"
ENDIF

RETURN

PROCEDURE endprog

@ 18,60 GET moption ;
	PICTURE "@*HN \!Ok" ;
	SIZE 1,4,1 ;
	DEFAULT 1
READ

CLEAR WINDOWS
CLEAR ALL
CLEAR
CANCEL
RETURN

PROCEDURE errhand
PARAMETER errnum,message
@ 23,0 SAY Message+' ERROR: '+STR(Errnum)
RETURN
