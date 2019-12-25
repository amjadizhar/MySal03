* ZONEPROC.PRG
* AMJAD IZHAR
* 24-NOV-2005
* ASKAR


******************
PROCEDURE ZONE_MEN
******************
DO WHILE .T.
   L= 8
   M= 25

IF _DOS
   SET COLOR TO 7/1
ENDIF

   CLEAR
   DO top
   DO bot

IF _DOS
   SET COLOR TO +7/1
ENDIF

   @ 6, 25 SAY '   Zone Code File Maintenance'

IF _DOS
   SET COLOR TO 7/1
ENDIF

   @ L+0, M PROMPT ' 1 - Zone Code .... Entry      '
   @ L+2, M PROMPT ' 2 - Zone Code .... Correction '
   @ L+4, M PROMPT ' 3 - Zone Code .... Deletion   '
   @ L+6, M PROMPT ' 4 - Zone Code .... Printing   '
   @ L+8, M PROMPT ' 9 - Return to Previous Menu   '
   MCHOICE= 0
   MENU TO MCHOICE
   DO CASE
      CASE MCHOICE=1
         CLEAR
         DO zone_ent
      CASE MCHOICE=2
         CLEAR
         DO zone_cor
      CASE MCHOICE=3
         CLEAR
         DO zone_del
      CASE MCHOICE=4
         CLEAR
         DO zone_prt
      CASE MCHOICE=5
         CLEAR
         CLOSE ALL
         RETURN
   ENDCASE
ENDDO
RETURN
**********

******************
PROCEDURE ZONE_ENT
******************
CLEAR
CLOSE ALL
USE zone ORDER zone_idx
DO WHILE .T.

IF _DOS
   SET COLOR TO 7/1
ENDIF

   CLEAR
   STORE 0 TO MZONE_CODE, CNT
   STORE SPACE(20) TO MZONE

IF _DOS
   SET COLOR TO +7/1
ENDIF

   @ 5, 25 SAY 'Zone Codes Entry'

IF _DOS
   SET COLOR TO 7/1
ENDIF

   DO WHILE .T.
      @ 23, 42 SAY 'Press Ctrl Q to Return'
      @ 9, 20 SAY 'Zone Code ' GET MZONE_CODE PICTURE '99'
      READ

IF _DOS
      SET COLOR TO /w
ENDIF

      MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MZONE_CODE))))+LTRIM(STR(MZONE_CODE))
      @ 9, 31 SAY MPC1

IF _DOS
      SET COLOR TO 7/1
ENDIF

      IF READKEY()=12
         CLEAR
         CLOSE ALL
         RETURN
      ENDIF
      @ 23, 40 CLEAR TO 23, 64
      IF MZONE_CODE=0
         LOOP
      ENDIF
      SEEK MZONE_CODE
      IF CNT=0
         IF FOUND()
            @ 23, 18 SAY 'This Code Already Exist -- Press any key'
            WAIT ''
            @ 23, 17 CLEAR TO 23, 73
            LOOP
         ENDIF
         APPEND BLANK
         IF .not. RLOCK()
            rlock()
         ENDIF
         REPLACE ZONE_CODE WITH MZONE_CODE
         UNLOCK
         CNT= 1
      ENDIF
      @ 11, 20 SAY 'Zone      ' GET MZONE
      READ
      MYES= ' '
      DO WHILE .not. MYES$'YN'
         @ 23, 28 SAY ' Any Correction - Y/N ' GET MYES FUNCTION '!'
         READ
      ENDDO
      @ 23, 19 CLEAR TO 23, 61
      IF MYES='Y'
         LOOP
      ENDIF
      IF .not. RLOCK()
         rlock()
      ENDIF
      REPLACE ZONE WITH MZONE
      UNLOCK
      P= ' '
      DO WHILE .not. P$'YN'
         @ 23, 28 SAY ' More Data Entry - Y/N ' GET P FUNCTION '!'
         READ
      ENDDO
      IF P='N'
         CLEAR
         CLOSE ALL
         RETURN
      ENDIF
      EXIT
   ENDDO
ENDDO
RETURN
******

******************
PROCEDURE ZONE_COR
*******************
CLEAR
CLOSE ALL
USE zone ORDER zone_idx
DO WHILE .T.

IF _DOS
   SET COLOR TO 7/1
ENDIF

   CLEAR
   STORE 0 TO MZONE_CODE

IF _DOS
   SET COLOR TO +7/1
ENDIF

   @ 5, 25 SAY 'Zone Codes Correction'

IF _DOS
   SET COLOR TO 7/1
ENDIF

   @ 23, 42 SAY 'Press Ctrl Q to Return'
   @ 9, 20 SAY 'Zone Code ' GET MZONE_CODE PICTURE '99'
   READ

IF _DOS
   SET COLOR TO /w
ENDIF

   MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MZONE_CODE))))+LTRIM(STR(MZONE_CODE))
   @ 9, 31 SAY MPC1

IF _DOS
   SET COLOR TO 7/1
ENDIF

   IF READKEY()=12
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
   @ 23, 40 CLEAR TO 23, 64
   IF MZONE_CODE=0
      LOOP
   ENDIF
   SEEK MZONE_CODE
   IF .not. FOUND()
      @ 23, 18 SAY 'This Code Does Not Exist -- Press any key'
      WAIT ''
      @ 23, 17 CLEAR TO 23, 63
      LOOP
   ENDIF
   @ 11, 20 SAY 'Zone      ' GET ZONE
   READ
   P= ' '
   DO WHILE .not. P$'YN'
      @ 23, 28 SAY ' More Data Correction - Y/N ' GET P FUNCTION '!'
      READ
   ENDDO
   IF P='N'
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
ENDDO
RETURN
******

******************
PROCEDURE ZONE_DEL
******************
CLEAR
CLOSE ALL
SET DELETED ON
USE zone ORDER zone_idx
DO WHILE .T.

IF _DOS
   SET COLOR TO 7/1
ENDIF

   CLEAR
   STORE 0 TO MZONE_CODE

IF _DOS
   SET COLOR TO +7/1
ENDIF

   @ 5, 25 SAY 'Zone Codes Deletion'

IF _DOS
   SET COLOR TO 7/1
ENDIF

   @ 23, 42 SAY 'Press Ctrl Q to Return'
   @ 9, 20 SAY 'Zone Code ' GET MZONE_CODE PICTURE '99'
   READ

IF _DOS
   SET COLOR TO /w
ENDIF

   MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MZONE_CODE))))+LTRIM(STR(MZONE_CODE))
   @ 9, 31 SAY MPC1

IF _DOS
   SET COLOR TO 7/1
ENDIF

   IF READKEY()=12
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
   @ 23, 40 CLEAR TO 23, 64
   IF MZONE_CODE=0
      LOOP
   ENDIF
   SEEK MZONE_CODE
   IF .not. FOUND()
      @ 23, 18 SAY 'This Code Does Not Exist -- Press any key'
      WAIT ''
      @ 23, 17 CLEAR TO 23, 63
      LOOP
   ENDIF
   @ 11, 20 SAY 'Zone      '

IF _DOS
   SET COLOR TO /w
ENDIF

   @ 11, 30 SAY ZONE

IF _DOS
   SET COLOR TO 7/1
ENDIF

   P= ' '
   DO WHILE .not. P$'YN'
      @ 23, 28 SAY ' Are you Sure - Y/N ' GET P FUNCTION '!'
      READ
   ENDDO
   @ 23, 25 CLEAR TO 23, 64
   IF P='Y'
      DELETE
   ENDIF
   P= ' '
   DO WHILE .not. P$'YN'
      @ 23, 25 SAY ' More Data Deletion - Y/N ' GET P FUNCTION '!'
      READ
   ENDDO
   IF P='N'
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
ENDDO
RETURN
******

******************
PROCEDURE ZONE_PRT
******************

IF _DOS
SET COLOR TO 7/1
ENDIF

CLEAR
CLOSE ALL
USE zone ORDER zone_idx
IF RECCOUNT()=0
   CLEAR
   @ 12, 12 SAY 'No Codes in Code File  -  Press any key to return to menu .... '
   WAIT ''
   CLEAR
   CLOSE ALL
   RETURN
ENDIF
P= ' '
DO WHILE .not. P$'PSQ'
   @ 5, 4 SAY 'Printer/Screen/Quit - P/S/Q  ' GET P FUNCTION '!'
   READ
ENDDO
IF P='Q'
   CLEAR
   CLOSE ALL
   RETURN
ENDIF
IF P='S'
   CLEAR
   SET PRINTER OFF
   SET DEVICE TO SCREEN
ELSE
   CLEAR
   @ 11, 15 SAY 'Please wait ... Printing in progress '
   SET PRINTER ON
   SET DEVICE TO PRINTER
ENDIF
HEADING= .T.
PAGE= 0
DO WHILE .not. EOF()
   IF HEADING
      L= 1
      PAGE= PAGE+1
      IF P='P'
         DO top-prt
         @ 3, 10 SAY CHR(14)
         @ 3, 20 SAY 'Z O N E   C O D E S '
         L= L+2
      ELSE
         DO SCREEN IN TBL_PROC.PRG
         L= L+2
         @ 3, 28 SAY ' Z O N E   C O D E S  '
      ENDIF
      L= L+1
      @ L, 66 SAY 'Page No -'
      @ L, 77 SAY PAGE PICTURE '99'
      L= L+1
      @ L, 1 SAY REPLICATE('-',79)
      L= L+1
      @ L, 25 SAY ' Code  '
      @ L, 40 SAY ' Zone   '
      L= L+1
      @ L, 1 SAY REPLICATE('-',79)
      HEADING= .F.
   ENDIF
   L= L+1
   @ L, 25 SAY ZONE_CODE PICTURE '99'
   MPC1= REPLICATE('0',2-LEN(LTRIM(STR(ZONE_CODE))))+LTRIM(STR(ZONE_CODE))
   @ L, 25 SAY MPC1
   @ L, 40 SAY ZONE
   SKIP
   IF P='S'.and.L>20
      ANS= ' '
      DO WHILE .not. ANS$'CQ'
         @ 24, 58 SAY 'Continue/Quit C/Q' GET ANS FUNCTION '!'
         READ
      ENDDO
      IF ANS='C'
         CLEAR
         HEADING= .T.
      ELSE
         CLEAR
         CLOSE ALL
         RETURN
      ENDIF
   ENDIF
   IF P='P'.and.L>=56
      L= 1
   ENDIF
ENDDO
IF P='S'
   @ 24, 7 SAY 'End of Screen Printing  -  Press any key to return to menu.... '
   WAIT ''
ENDIF
IF P='P'
   EJECT
   SET PRINTER OFF
   SET DEVICE TO SCREEN
ENDIF
CLOSE ALL
CLEAR
RETURN
******
