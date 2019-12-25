* Date: 07-Dec-2019.
*---------------------------------------------------------------
* PROGRAM : TBL_PROC.PRG
* Author: Amjad Izhar
* for General Accounts
* Target: 1 Million accounts opened and available for editing.
*----------------------------------------------------------------
*==================================================================

******************
PROCEDURE TOP
******************

#DEFINE Programmer "Amjad Izhar"
#DEFINE ContactEmail "amjad18@yahoo.com"
#DEFINE ThisUpdate "07-Dec-2019"
#DEFINE BottomLine "Integrated : Accounting + Inventory + Payroll    &    Others"

#DEFINE DesignBy "Designed & Developed by Amjad Izhar :"
#DEFINE MyCompany "CosmoSoft Systems , Lahore"
#DEFINE CompanyName "General One Million Accounts"

#DEFINE LSLNO "001-2019"


IF _DOS

 SET STEP OFF
 SET ECHO OFF
 SET DOHISTORY OFF
 SET DATE BRIT
 SET CENT ON

 @ 1, 1 SAY DesignBy
 @ 1, 40 SAY MyCompany
 @ 1, 70 SAY LSLNO
 @ 2, 0 TO 2, 79
 @ 3, 16 SAY CompanyName
 @ 3, 50 SAY ContactEmail
 @ 4, 0 TO 4, 79
 
ENDIF


IF _WINDOWS

 SET STEP OFF
 SET ECHO OFF
 SET DOHISTORY OFF
 SET DATE BRIT
 SET CENT ON

 @ 1, 1 SAY DesignBy FONT "FoxFont",11
 @ 1, 134 SAY MyCompany FONT "FoxFont",11 	
 @ 3, 145 SAY ContactEmail FONT "FoxFont",11
	*Horizontal Lines
 @ 2, 0 TO 2, 171
 @ 4, 0 TO 4, 171
 @ 3, 65 SAY CompanyName FONT "FoxFont",11

ENDIF



RETURN
*******************

*******************
PROCEDURE BOT
*******************

IF _DOS

 PUBLIC mCdir,mDrive
 STORE sys(5) TO mDrive
 STORE curdir() TO mCdir

IF _DOS
 @ 22, 3 SAY 'Working Directory :'
 @ 23, 0 TO 23, 79 DOUBLE
 @ 24, 3 SAY ALLTRIM(mDrive)+ALLTRIM(mCdir)
 @ 24, 35 SAY cdow(date())
 @ 24, 55 SAY date()
ENDIF

IF _WINDOWS
 @ 22, 3 SAY 'Working Directory :' FONT 'FoxFont',11
 @ 23, 0 TO 23, 79 DOUBLE
 @ 24, 3 SAY ALLTRIM(mDrive)+ALLTRIM(mCdir) FONT 'FoxFont',11
 @ 24, 55 SAY date() FONT 'FoxFont',11
 @ 24, 45 SAY cdow(date()) 'FoxFont',11
ENDIF


IF _DOS
 SET CLOCK ON
 SET CLOCK TO 24,68
ENDIF

ENDIF


IF _WINDOWS

 PUBLIC mDrive, mCdir
 
 STORE sys(5) TO mDrive
 STORE curdir() TO mCdir


* BL Bottom Line

BL = 39
  
 @ BL, 3 SAY 'Working Directory :' FONT "FoxFont",11

	* Horizontal Line
 @ BL+1, 0 TO BL+1, 171

 @ BL+2, 3 SAY ALLTRIM(mDrive)+ALLTRIM(mCdir) FONT "FoxFont",11

 PUBLIC mPCUser
 STORE SYS(0) TO mPCUser
 @ BL+2, 68 SAY ALLTRIM(mPCUser) FONT "FoxFont",11

 @ BL+2, 140 SAY cdow(date()) FONT "FoxFont",11

 @ BL+2, 155 SAY date() FONT "FoxFont",11

* SET CLOCK ON
* SET CLOCK TO 30,105

ENDIF


RETURN
*******************


*****************
PROCEDURE LOGO
*****************


IF _WINDOWS


 SET TALK OFF
 SET SAFETY OFF
 SET STATUS OFF
 SET ESCAPE OFF

*do logo.spr

ENDIF



IF _DOS


 SET TALK OFF
 SET SAFETY OFF
 SET STATUS OFF
 SET ESCAPE OFF
 SET CONFIRM OFF

 IF _DOS
  SET COLOR TO 7/1
 ENDIF

 CLEAR

IF _DOS
 @ 10,35 SAY "Accounting Software"
ENDIF

*   	FONT "FoxFont",11

IF _WINDOWS
 @ 10,35 SAY "Accounting Software";
    	FONT "FoxFont",11
ENDIF

 ABC= 0
 DO WHILE ABC<=20000
    ABC= ABC+1
 ENDDO
 R= 18
 L= 24
 @ L, R SAY 'A'
 ABC= 0
 DO WHILE ABC<=5000
    ABC= ABC+1
 ENDDO
 R= R+2
 @ L, R SAY 'C'
 ABC= 0
 DO WHILE ABC<=5000
    ABC= ABC+1
 ENDDO
 R= R+2
 @ L, R SAY 'C'
 ABC= 0
 DO WHILE ABC<=500
    ABC= ABC+1
 ENDDO
 R= R+2
 @ L, R SAY 'O'
 ABC= 0
 DO WHILE ABC<=500
    ABC= ABC+1
 ENDDO
 R= R+2
 @ L, R SAY 'U'
 ABC= 0
 DO WHILE ABC<=500
    ABC= ABC+1
 ENDDO
 R= R+2
 @ L, R SAY 'N'
 ABC= 0
 DO WHILE ABC<=5000
    ABC= ABC+1
 ENDDO
 R= R+2
 @ L, R SAY 'T'
 ABC= 0
 DO WHILE ABC<=5000
    ABC= ABC+1
 ENDDO
 R= R+2
 @ L, R SAY 'I'
 ABC= 0
 DO WHILE ABC<=5000
    ABC= ABC+1
 ENDDO
 R= R+2
 @ L, R SAY 'N'
 ABC= 0
 DO WHILE ABC<=5000
    ABC= ABC+1
 ENDDO
 R= R+2
 @ L, R SAY 'G'
 ABC= 0
 DO WHILE ABC<=5000
    ABC= ABC+1
 ENDDO
 R= R+6
 @ L, R SAY 'S'
 ABC= 0
 DO WHILE ABC<=5000
    ABC= ABC+1
 ENDDO
 R= R+2
 @ L, R SAY 'O'
 ABC= 0
 DO WHILE ABC<=5000
    ABC= ABC+1
 ENDDO
 R= R+2
 @ L, R SAY 'F'
 ABC= 0
 DO WHILE ABC<=5000
    ABC= ABC+1
 ENDDO
 R= R+2
 @ L, R SAY 'T'
 ABC= 0
 DO WHILE ABC<=5000
    ABC= ABC+1
 ENDDO
 R= R+2
 @ L, R SAY 'W'
 ABC= 0
 DO WHILE ABC<=5000
    ABC= ABC+1
 ENDDO
 R= R+2
 @ L, R SAY 'A'
 ABC= 0
 DO WHILE ABC<=5000
    ABC= ABC+1
 ENDDO
 R= R+2
 @ L, R SAY 'R'
 ABC= 0
 DO WHILE ABC<=5000
    ABC= ABC+1
 ENDDO
 R= R+2
 @ L, R SAY 'E'

 IF _DOS
  SET COLOR TO 7/1
 ENDIF

 CLEAR

 PUBLIC MDATE
 MDATE = {00/00/00}

 STORE DATE() TO MDATE

IF _DOS

 TEXT

    лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
                     Amjad Izhar
                     General One Million Accounts
    лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

               Program :  Accounting System Under DOS FOXPRO VER 2.6
               Version :  18.1
               Revision:  by Amjad Izhar from 1996 to 07-Dec-2019.


               Dated   :  Dec. 06, 2019
               
               This System Is Licensed Exclusively For The
               Use Of Messrs.

               General One Million Accounts. 
               Liecence # LSL-001-2019

 ENDTEXT

ELSE
*Windows

CLEAR

                 @ 3,25 SAY 'Amjad Izhar' 
                 @ 4,25 SAY 'General One Million Accounts '


			   @ 6,25 SAY ''
			   	
			   
               @ 8,25 SAY 'Program :  Accounting System Under Windows Visual Foxpro Ver 6.0' 

               	
               @ 9,25 SAY 'Version :  18.1' 
               
               @ 11,25 SAY 'Revision:  by Amjad Izhar from 1996 to Date.' 
               
               @ 17,25 SAY 'This System Is Licensed Exclusively For The' 
               @ 18,25 SAY 'Use Of Messrs.' 

               @ 20,25 SAY 'General One Million Accounts ' 
               @ 21,25 SAY 'Liecence # LSL-001-2019' 




ENDIF

 @ 22, 35 SAY "Enter Today's Date: " GET MDATE PICT "@E"
 READ


 * MDT= LTRIM(STR(MONTH(MDATE),2))+'-'+LTRIM(STR(DAY(MDATE),2)+'-'+STR(YEAR(MDATE),4))

 * !date &mdt

 CLEAR

ENDIF

RETURN
*******************


********************
PROCEDURE SCREEN
********************


SET STEP OFF
SET ECHO OFF
SET DOHISTORY OFF
CLEAR

IF _DOS
@ 0, 15 SAY CompanyName
ENDIF



IF _WINDOWS
@ 0, 15 SAY CompanyName;
  	FONT "FoxFont",11
ENDIF


RETURN
*********************



*********************
PROCEDURE TOP_PRT1
*********************

SET STEP OFF
SET ECHO OFF
SET DOHISTORY OFF

IF _DOS
@ 0, 0 SAY CHR(18)
@ 0, 0 SAY CHR(14)
@ 0, 1 SAY CompanyName
ENDIF

IF _WINDOWS
@ 0, 1 SAY CompanyName;
  	FONT "FoxFont",11
ENDIF



RETURN
***************

*********************
PROCEDURE top_prt2
*********************


SET STEP OFF
SET ECHO OFF
SET DOHISTORY OFF

IF _DOS
@ 0, 0 SAY CHR(18)
@ 0, 0 SAY CHR(14)
@ 0, 1 SAY CompanyName
ENDIF

IF _WINDOWS
@ 0, 1 SAY CompanyName;
  	FONT "FoxFont",11
ENDIF

CLEAR


RETURN
***********************


********************
PROCEDURE DIS_PRT
********************

SET STEP OFF
SET ECHO OFF
SET DOHISTORY OFF
CLEAR

IF _DOS
@ 10, 15 SAY 'This Report requires 80 Column   (10 Inch Wide) '
@ 11, 15 SAY 'continues Printer Paper.  Please load the Paper '
@ 12, 15 SAY 'in the Printer, set it to TOF (Top of Form) and '
@ 13, 15 SAY 'Strike any key when ready ......'
ENDIF



IF _WINDOWS
@ 10, 15 SAY 'This Report requires 80 Column   (10 Inch Wide) ';
  	FONT "FoxFont",11
@ 11, 15 SAY 'continues Printer Paper.  Please load the Paper ';
  	FONT "FoxFont",11
@ 12, 15 SAY 'in the Printer, set it to TOF (Top of Form) and ';
  	FONT "FoxFont",11
@ 13, 15 SAY 'Strike any key when ready ......';
  	FONT "FoxFont",11
ENDIF

WAIT ''
CLEAR
PRT= ' '
DO WHILE .not. PRT$'CQ'

IF _DOS
   @ 5, 5 SAY 'Continue/Quit - C/Q ' GET PRT FUNCTION '!'
   READ
ENDIF

*  	FONT "FoxFont",11

IF _WINDOWS
   @ 5, 5 SAY 'Continue/Quit - C/Q ' GET PRT FUNCTION '!';
     	FONT "FoxFont",11
   READ
ENDIF



ENDDO
IF PRT='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF

RETURN
***************


*****************
PROCEDURE CHK
*****************

SET DATE brit
SET CENT ON

*IF mDATE > {30/06/2095}
*quit
*ENDIF

RETURN
*******************

*******************
PROCEDURE CHK2
*******************

SET STEP OFF
SET ECHO OFF
SET DOHISTORY OFF
SET DATE brit
SET CENT ON

*IF MDATE>CTOD('01/07/92').or.MDATE<CTOD('01/07/91')

*ENDIF

RETURN
********************



***********************
PROCEDURE PRNCHK
***********************

IF SYS(13)='OFFLINE'
   PANS= ' ' && Printer Answer whether it is on
   DO WHILE .not. PANS$'CQ'
      CLEAR
      
      IF _DOS
       SET COLOR TO 7/1
      ENDIF
      
      CLEAR

	  IF _DOS
      @ 10, 10 SAY 'You Printer is Not Connected - Please Check'
      @ 11, 10 SAY 'Continue/Quit - C/Q ' GET PANS PICTURE '!'
	  ENDIF

*  	FONT "FoxFont",11

	  IF _WINDOWS
      @ 10, 10 SAY 'You Printer is Not Connected - Please Check';
        	FONT "FoxFont",11
      @ 11, 10 SAY 'Continue/Quit - C/Q ' GET PANS PICTURE '!';
        	FONT "FoxFont",11
	  ENDIF

      READ
   ENDDO
   IF PANS='C'
      CLEAR
      RETRY
   ENDIF
   IF PANS='Q'
      CLEAR
      CLOSE DATA
      RETURN TO master
   ELSE
      RETURN
   ENDIF
ENDIF

RETURN
***********************

*****************
PROCEDURE TOP_PRT
*****************


IF _DOS
@ 1, 0 SAY CHR(14)
@ 1, 6 SAY CompanyName
ENDIF


*  	FONT "FoxFont",11

IF _WINDOWS
@ 1, 6 SAY CompanyName;
  	FONT "FoxFont",11
ENDIF


RETURN
******

