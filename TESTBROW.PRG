*****************************************
* PROGRAMM TESTBROW.PRG
* A programm to test Browsing Employee's 
* Information in Screen and Brows Windows
*****************************************

SET SYSMENU OFF

CLEAR
@ 0,3 SAY "Employee Information"


@ 1,0,15,33 BOX


DEFINE WINDOW mainbrows FROM 2,1 TO 14,32



SET VIEW TO testbrow

BROWS FIELDS;
	Eno = RIGHT(str(deptcode),2)+"-"+;
		RIGHT(str(empno),3)+"ณ";
		:H = "Code",;
	name;
	WINDOW mainbrows;
	Title " ";
	NOEDIT NOAPPEND NODELETE;
	WHEN empinf()

	
@ 1,0 TO 15,33 CLEAR
CANCEL



FUNCTION empinf
@ 2,35 TO 24,78 CLEAR

@ 2,35 SAY "Department    :"
@ 2,52 SAY deptt.deptname

IF salary.mpay = .T.

@ 3,35 SAY "Basic         :"
@ 3,52 SAY salary.basic
@ 4,35 SAY "House Rent    :"
@ 4,54 SAY salary.hrent

	IF salary.convy > 0
		@ 5,35 SAY "Conveyance    :"
		@ 5,54 SAY salary.convy
	ELSE
		@ 5,35 TO 5,79 CLEAR
	ENDIF

	IF salary.medical > 0
		@ 6,35 SAY "Medical       :"
		@ 6,54 SAY salary.medical
	ELSE
		@ 6,35 TO 6,79 CLEAR
	ENDIF

	IF salary.cma > 0
		@ 7,35 SAY "CMA           :"
		@ 7,54 SAY salary.cma
	ELSE
		@ 7,35 TO 7,79 CLEAR
	ENDIF

	IF salary.pma > 0
		@ 8,35 SAY "PMA           :"
		@ 8,54 SAY salary.cma
	ELSE
		@ 8,35 TO 8,79 CLEAR
	ENDIF

	IF salary.other > 0
		@ 9,35 SAY "Other         :"
		@ 9,54 SAY salary.other
	ELSE
		@ 9,35 TO 9,79 CLEAR
	ENDIF

	IF salary.special > 0
		@ 10,35 SAY "Special       :"
		@ 10,54 SAY salary.special
	ELSE
		@ 10,35 TO 10,79 CLEAR
	ENDIF

@ 11,35 SAY "อออออออออออออออออออออออ"

@ 12,51 SAY salary.basic+salary.hrent+salary.convy+salary.medical+;
			salary.cma+salary.pma+salary.other+salary.special;
			PICT "999,999"
@ 12,35 SAY "Total:"
@ 13,35 SAY "อออออออออออออออออออออออ"
ELSE

@ 3,35 SAY "D.Wages Rate  :"
@ 3,52 SAY salary.dwrate

ENDIF



RETURN .T.