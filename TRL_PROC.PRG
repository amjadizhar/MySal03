**********************************
* PROGRAM : TRL_PROC.PRG         *
* Author: Amjad Izhar            *
* Trial Balance Reports          *
* Written : 21-09-96             *
* This Revision : 18-02-2017
*
**********************************


**************************
PROCEDURE BS_C1
**************************


CLEAR
CLOSE ALL

SET TALK OFF
SET SAFE OFF
SET DOHISTORY OFF
SET DATE TO BRIT
SET CENT ON
SET COLOR TO 7/1

SELECT 1
USE master ORDER mastdate

GOTO BOTTOM
STORE DATE TO MTDATE

DO top IN tbl_proc.PRG
DO bot IN tbl_proc.PRG


@ 6, 5 SAY 'Balance Sheet Report '
@ 8, 5 SAY 'Your last posted voucher is dated '
@ 8, 45 SAY MTDATE
@ 9, 5 SAY 'Do you want to dispaly same date on your Report '
@ 10, 5 SAY 'Or enter the date you want to dispaly  '
@ 10, 45 GET MTDATE
READ

P= SPACE(1)
DO WHILE .not. P$'PSQ'
   @ 21, 25 SAY 'Printer/Screen/Quit  -  P/S/Q  ' 
   @ 21, 60 GET P FUNCTION '!'
   READ
ENDDO

IF P='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
IF P='P'
   CLEAR
   @ 8, 17 SAY 'Balance Sheet Report '
   @ 10, 17 SAY 'Please use 80 column (10 inches wide) continous'
   @ 11, 17 SAY 'printer paper and set Top Of Form'
   @ 12, 17 SAY 'Press ENTER when ready...........'
   WAIT ''
   @ 14, 17 SAY 'Printing In Progress'
ENDIF
IF P='P'
   CLEAR
   PANS= ' '
   DO prnchk IN tbl_proc.prg
   IF PANS='Q'
      CLOSE ALL
      CLEAR
      RETURN
   ENDIF
   @ 11, 20 SAY 'Please wait ... Printing in progress '
   SET PRINTER ON
   SET DEVICE TO PRINTER
ELSE
   CLEAR
   @ 10, 17 SAY 'Please Wait Balance Sheet Calculations In Progress'
   SET DEVICE TO SCREEN
ENDIF
STORE SPACE(30) TO WTITLE, WHTITLE
STORE 0 TO AMT6, AMT7, AMT8, AMT9, GPFT, GPFT2
SELECT 2
USE chart ORDER cht

GOTO TOP
MF1= FR
MT1= TO
SELECT 1
USE pl-work2
ZAP
APPEND FROM ldgrcode FOR C1>=MF1.and.C1<=MT1
REPLACE FOR CHART_NO=0 CHART_NO WITH 1
SELECT 2
DO WHILE .not. EOF()
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   MF2= FR
   MT2= TO
   SELECT 1
   IF MF2<>0.and.MT2<>0
      APPEND FROM ldgrcode FOR C1>=MF2.and.C1<=MT2
      REPLACE FOR CHART_NO=0 CHART_NO WITH 2
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   MF3= FR
   MT3= TO
   SELECT 1
   IF MF3<>0.and.MT3<>0
      APPEND FROM ldgrcode FOR C1>=MF3.and.C1<=MT3
      REPLACE FOR CHART_NO=0 CHART_NO WITH 3
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   MF4= FR
   MT4= TO
   SELECT 1
   IF MF4<>0.and.MT4<>0
      APPEND FROM ldgrcode FOR C1>=MF4.and.C1<=MT4
      REPLACE FOR CHART_NO=0 CHART_NO WITH 4
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   MF5= FR
   MT5= TO
   SELECT 1
   IF MF5<>0.and.MT5<>0
      APPEND FROM ldgrcode FOR C1>=MF5.and.C1<=MT5
      REPLACE FOR CHART_NO=0 CHART_NO WITH 5
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   MF6= FR
   MT6= TO
   SELECT 1
   IF MF6<>0.and.MT6<>0
      APPEND FROM ldgrcode FOR C1>=MF6.and.C1<=MT6
      REPLACE FOR CHART_NO=0 CHART_NO WITH 6
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   MF7= FR
   MT7= TO
   SELECT 1
   IF MF7<>0.and.MT7<>0
      APPEND FROM ldgrcode FOR C1>=MF7.and.C1<=MT7
      REPLACE FOR CHART_NO=0 CHART_NO WITH 7
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   MF8= FR
   MT8= TO
   SELECT 1
   IF MF8<>0.and.MT8<>0
      APPEND FROM ldgrcode FOR C1>=MF8.and.C1<=MT8
      REPLACE FOR CHART_NO=0 CHART_NO WITH 8
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   MF9= FR
   MT9= TO
   SELECT 1
   IF MF9<>0.and.MT9<>0
      APPEND FROM ldgrcode FOR C1>=MF9.and.C1<=MT9
      REPLACE FOR CHART_NO=0 CHART_NO WITH 9
   ENDIF
ENDDO
SELECT 1
USE pl-work2 ORDER bl_c1

GOTO TOP
MCODE= 0
HEADING= .T.
PAGE= 1
STORE 0 TO WRECNO, MSRNO, WCODE
WGTITLE= SPACE(30)
STORE 0 TO DRTOT, CRTOT, GTDR, GTCR, LINE, TOTDR, TOTCR
STORE 0 TO TCR1, TDR1, TCR2, TDR2, TCR3, TDR3
STORE 0 TO TCR4, TDR4, TCR5, TDR5, TCR6, TDR6
STORE 0 TO TCR7, TDR7, TCR8, TDR8, TCR9, TDR9
MC1= C1
MC2= C2
MC3= C3
CLEAR
DO WHILE .not. EOF()
   IF EOF()
      EXIT
   ENDIF
   IF C3=0
      SKIP
      LOOP
   ENDIF
   IF CHART_NO=1
      IF STATUS='DR'
         TDR1= TDR1+LDGR_BAL
      ELSE
         TCR1= TCR1+LDGR_BAL
      ENDIF
   ENDIF
   IF CHART_NO=2
      IF STATUS='DR'
         TDR2= TDR2+LDGR_BAL
      ELSE
         TCR2= TCR2+LDGR_BAL
      ENDIF
   ENDIF
   IF CHART_NO=3
      IF STATUS='DR'
         TDR3= TDR3+LDGR_BAL
      ELSE
         TCR3= TCR3+LDGR_BAL
      ENDIF
   ENDIF
   IF CHART_NO=4
      IF STATUS='DR'
         TDR4= TDR4+LDGR_BAL
      ELSE
         TCR4= TCR4+LDGR_BAL
      ENDIF
   ENDIF
   IF CHART_NO=5
      IF STATUS='DR'
         TDR5= TDR5+LDGR_BAL
      ELSE
         TCR5= TCR5+LDGR_BAL
      ENDIF
   ENDIF
   IF CHART_NO=6
      IF STATUS='DR'
         TDR6= TDR6+LDGR_BAL
      ELSE
         TCR6= TCR6+LDGR_BAL
      ENDIF
   ENDIF
   IF CHART_NO>6
      IF STATUS='DR'
         TDR7= TDR7+LDGR_BAL
      ELSE
         TCR7= TCR7+LDGR_BAL
      ENDIF
   ENDIF
   SKIP
ENDDO
AMT1= TCR1-TDR1
AMT2= TCR2-TDR2
AMT3= TCR3-TDR3
AMT4= TDR4-TCR4
AMT5= TDR5-TCR5
AMT6= TCR6-TDR6
AMT7= TDR7-TCR7
PLS= AMT6-AMT7
HEADING= .T.
SELECT 1
IF HEADING
   IF P='S'
      DO screen IN tbl_proc.prg
   ELSE
      DO PRNCHK IN tbl_proc.prg
      DO top_prt1 IN tbl_proc.prg
   ENDIF
   @ 2, 10 SAY 'B A L A N C E    S H E E T     A S   O N :'
   @ 2, 55 SAY MTDATE
   @ 3, 1 SAY REPLICATE('-',79)
   @ 4, 3 SAY '     L I A B I L I T I E S'
   @ 4, 55 SAY 'A S S E T S'
   @ 5, 1 SAY REPLICATE('-',79)
   @ 5, 40 SAY '|'
   L= 6
   @ 6, 40 SAY '|'
   HEADING= .F.
ENDIF
@ L, 1 SAY '  Capital / Equity '
@ L, 20 SAY AMT1 PICTURE '@( 999,999,999,999.99'
@ L, 40 SAY '|'
@ L, 42 SAY ' Long Term Assets     '
@ L, 61 SAY AMT4 PICTURE '@( 999,999,999,999.99'
L= L+1
@ L, 1 SAY '  Long Term Liabs  '
@ L, 20 SAY AMT2 PICTURE '@( 999,999,999,999.99'
@ L, 40 SAY '|'
@ L, 42 SAY ' Current Assets       '
@ L, 61 SAY AMT5 PICTURE '@( 999,999,999,999.99'
L= L+1
@ L, 1 SAY '  Short Term Liabs    '
@ L, 20 SAY AMT3 PICTURE '@( 999,999,999,999.99'
@ L, 40 SAY '|'
L= L+1
@ L, 40 SAY '|'
L= L+1
@ L, 40 SAY '|'
L= L+1
@ L, 40 SAY '|'
L= L+1
@ L, 1 SAY '  Profit/(Loss)  '
@ L, 20 SAY PLS PICTURE '@( 999,999,999,999.99'
@ L, 40 SAY '|'
L= L+1
@ L, 40 SAY '|'
L= L+1
@ L, 1 SAY REPLICATE('-',79)
@ L, 40 SAY '|'
L= L+1
LTOT= AMT1+AMT2+AMT3+PLS
@ L, 20 SAY LTOT PICTURE '@( 999,999,999,999.99'
@ L, 40 SAY '|'
RTOT= AMT4+AMT5
@ L, 61 SAY RTOT PICTURE '@( 999,999,999,999.99'
L= L+1
@ L, 1 SAY REPLICATE('-',79)
IF P='P'
   EJECT
ELSE
   @ 23, 1 SAY ''
   WAIT SPACE(15)+'Press Any Key To Continue For Balance Sheet Details '
ENDIF
DO bs_c2


****************************
PROCEDURE BS_C2
*****************************

CLEAR
IF P='S'
   @ 10, 20 SAY 'Please Wait - For Balance Sheet Level 2'
ENDIF
SELECT 2
USE chart ORDER cht

GOTO TOP
SELECT 3
USE ldgrcode ORDER ac1

SELECT 1
USE pl-work2 ORDER bl_c1

GOTO TOP
STORE 0 TO LTAMT, DTAMT, MCODE, PCON
HEADING= .T.
PAGE= 1
STORE 0 TO WRECNO, MSRNO, WCODE
WGTITLE= SPACE(30)
STORE 0 TO DRTOT, CRTOT, GTDR, GTCR, LINE, TOTDR, TOTCR, NTOT
STORE 0 TO TCR1, TDR1, TCR2, TDR2, TCR3, TDR3
STORE 0 TO TCR4, TDR4, TCR5, TDR5
MC3= 0
R= 5
CLEAR
GOTO TOP
CLEAR
DO WHILE .not. EOF()
   IF EOF()
      EXIT
   ENDIF
   IF CHART_NO>5
      IF .not. EOF()
         SKIP
      ENDIF
      LOOP
   ENDIF
   TAMT= 0
   IF CHART_NO<=3
      STORE CHART_NO TO MCHART
      DO WHILE CHART_NO=MCHART
         STORE 0 TO TDR, TCR, AMT, MC3
         STORE C1 TO MC1
         STORE C2 TO MC2
         DO WHILE C1=MC1.and.C2=MC2
            IF STATUS='DR'
               TDR= TDR+LDGR_BAL
            ELSE
               TCR= TCR+LDGR_BAL
            ENDIF
            IF .not. EOF()
               SKIP
            ENDIF
         ENDDO
         STORE STR(MC1,2)+STR(MC2,2)+STR(MC3,3) TO MCODE
         SELECT 3
         SEEK MCODE
         IF FOUND()
            STORE TITLE TO MTITLE
         ELSE
            STORE 'Group Total ' TO MTITLE
         ENDIF
         SELECT 1
         IF MCHART<=3
            AMT= TCR-TDR
         ELSE
            AMT= TDR-TCR
         ENDIF
         IF HEADING
            IF P='S'
               DO screen IN tbl_proc.prg
            ELSE
               DO PRNCHK IN tbl_proc.prg
               DO top_prt1 IN tbl_proc.prg
            ENDIF
            @ 2, 10 SAY 'B A L A N C E   S H E E T - 2   A S   O N :'
            @ 2, 54 SAY MTDATE
            @ 3, 1 SAY REPLICATE('-',79)
            @ 4, 1 SAY '(1).   L I A B I L I T I E S'
            R= 6
            HEADING= .F.
         ENDIF
         IF MC2<>0.and.AMT=0
            IF .not. EOF()
               SKIP
            ENDIF
            LOOP
         ENDIF
         MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MC1))))+LTRIM(STR(MC1))
         @ R, 1 SAY MPC1 PICTURE '99'
         @ R, 3 SAY '-'
         MPC2= REPLICATE('0',2-LEN(LTRIM(STR(MC2))))+LTRIM(STR(MC2))
         @ R, 4 SAY MPC2 PICTURE '99'
         IF MC2=0
            @ R, 12 SAY MTITLE
         ELSE
            @ R, 15 SAY MTITLE
            @ R, 60 SAY AMT PICTURE '@( 9,999,999,999.99'
            TAMT= AMT+TAMT
         ENDIF
         R= R+1
         IF P='S'.and.R>=16
            ANS= ' '
            DO WHILE .not. ANS$'CQ'

IF _DOS
               SET COLOR TO +7/1
ENDIF

               SET CONFIRM OFF
               @ 24, 20 SAY 'Please Enter <C> To Continue <Q> To Quit' GET ANS PICTURE '!'
               READ

IF _DOS
               SET COLOR TO 7/1
ENDIF

            ENDDO
            IF ANS='C'
               CLEAR
               R= 6
               PAGE= PAGE+1
               HEADING= .T.
            ELSE
               CLOSE DATA
               CLEAR
               RETURN
            ENDIF
         ENDIF
         IF P='P'.and.R>=56
            PAGE= PAGE+1
            HEADING= .T.
            EJECT
         ENDIF
      ENDDO
      IF P='S'.and.R>=13
         ANS= ' '
         DO WHILE .not. ANS$'CQ'

IF _DOS
            SET COLOR TO +7/1
ENDIF

            SET CONFIRM OFF
            @ 24, 20 SAY 'Please Enter <C> To Continue <Q> To Quit' GET ANS PICTURE '!'
            READ

IF _DOS
            SET COLOR TO 7/1
ENDIF

         ENDDO
         IF ANS='C'
            CLEAR
            R= 6
            PAGE= PAGE+1
            HEADING= .T.
         ELSE
            CLOSE DATA
            CLEAR
            RETURN
         ENDIF
      ENDIF
      SELECT 2
      SEEK MCHART
      R= R+1
      IF FOUND()
      ENDIF
      SELECT 1
      @ R, 60 SAY '-----------------'
      R= R+1
      @ R, 40 SAY 'Total '
      @ R, 60 SAY TAMT PICTURE '@( 9,999,999,999.99'
      R= R+1
      @ R, 60 SAY '-----------------'
      R= R+1
      LTAMT= LTAMT+TAMT
   ELSE
      IF PCON=0
         R= R+1
         @ R, 5 SAY 'Profit / (Loss)'
         @ R, 60 SAY PLS PICTURE '@( 9,999,999,999.99'
         R= R+2
         LTAMT= LTAMT+PLS
         R= R+2
         @ R, 60 SAY '-----------------'
         R= R+1
         @ R, 40 SAY 'Total'
         @ R, 60 SAY LTAMT PICTURE '@( 9,999,999,999.99'
         R= R+1
         @ R, 60 SAY '================='
         PCON= 2
         HEADING= .T.
         IF P='S'
            ANS= ' '
            DO WHILE .not. ANS$'CQ'

IF _DOS
               SET COLOR TO +7/1
ENDIF

               SET CONFIRM OFF
               @ 24, 20 SAY 'Please Enter <C> To Continue <Q> To Quit' GET ANS PICTURE '!'
               READ

IF _DOS
               SET COLOR TO 7/1
ENDIF

            ENDDO
            IF ANS='C'
               CLEAR
               R= 6
               PAGE= PAGE+1
               HEADING= .T.
            ELSE
               CLOSE DATA
               CLEAR
               RETURN
            ENDIF
         ENDIF
         IF P='P'
            PAGE= PAGE+1
            HEADING= .T.
            EJECT
         ENDIF
         endi &p4 
         STORE CHART_NO TO MCHART
         DO WHILE CHART_NO=MCHART
            STORE 0 TO TDR, TCR, AMT, MC3
            STORE C1 TO MC1
            STORE C2 TO MC2
            DO WHILE C1=MC1.and.C2=MC2
               IF STATUS='DR'
                  TDR= TDR+LDGR_BAL
               ELSE
                  TCR= TCR+LDGR_BAL
               ENDIF
               IF .not. EOF()
                  SKIP
               ENDIF
            ENDDO
            STORE STR(MC1,2)+STR(MC2,2)+STR(MC3,3) TO MCODE
            SELECT 3
            SEEK MCODE
            IF FOUND()
               STORE TITLE TO MTITLE
            ELSE
               STORE 'Group Total ' TO MTITLE
            ENDIF
            SELECT 1
            IF MCHART<=3
               AMT= TCR-TDR
            ELSE
               AMT= TDR-TCR
            ENDIF
            IF HEADING
               IF P='S'
                  DO screen IN tbl_proc.prg
               ELSE
                  DO PRNCHK IN tbl_proc.prg
                  DO top_prt1 IN tbl_proc.prg
               ENDIF
               @ 2, 10 SAY 'B A L A N C E   S H E E T - 2   A S   O N :'
               @ 2, 54 SAY MTDATE
               @ 3, 1 SAY REPLICATE('-',79)
               @ 5, 1 SAY '(2).  A S S E T S :-'
               R= 7
               HEADING= .F.
            ENDIF
            IF MC2<>0.and.AMT=0
               IF .not. EOF()
                  SKIP
               ENDIF
               LOOP
            ENDIF
            MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MC1))))+LTRIM(STR(MC1))
            @ R, 1 SAY MPC1 PICTURE '99'
            @ R, 3 SAY '-'
            MPC2= REPLICATE('0',2-LEN(LTRIM(STR(MC2))))+LTRIM(STR(MC2))
            @ R, 4 SAY MPC2 PICTURE '99'
            IF MC2=0
               @ R, 12 SAY MTITLE
            ELSE
               @ R, 15 SAY MTITLE
               @ R, 60 SAY AMT PICTURE '@( 9,999,999,999.99'
               TAMT= AMT+TAMT
            ENDIF
            R= R+1
            IF P='S'.and.R>=16
               ANS= ' '
               DO WHILE .not. ANS$'CQ'

IF _DOS
                  SET COLOR TO +7/1
ENDIF

                  SET CONFIRM OFF
                  @ 24, 20 SAY 'Please Enter <C> To Continue <Q> To Quit' GET ANS PICTURE '!'
                  READ

IF _DOS
                  SET COLOR TO 7/1
ENDIF

               ENDDO
               IF ANS='C'
                  CLEAR
                  PAGE= PAGE+1
                  HEADING= .T.
               ELSE
                  CLOSE DATA
                  CLEAR
                  RETURN
               ENDIF
            ENDIF
            IF P='P'.and.R>=56
               PAGE= PAGE+1
               HEADING= .T.
               EJECT
            ENDIF
         ENDDO
         SELECT 2
         SEEK MCHART
         R= R+1
         IF FOUND()
         ENDIF
         SELECT 1
         @ R, 60 SAY '-----------------'
         R= R+1
         @ R, 40 SAY 'Total '
         @ R, 60 SAY TAMT PICTURE '@( 9,999,999,999.99'
         R= R+1
         @ R, 60 SAY '-----------------'
         R= R+1
         DTAMT= DTAMT+TAMT
      ENDIF
   ENDDO
   R= R+2
   @ R, 60 SAY '-----------------'
   R= R+1
   @ R, 40 SAY 'Total'
   @ R, 60 SAY DTAMT PICTURE '@( 9,999,999,999.99'
   R= R+1
   @ R, 60 SAY '=================='
   IF P='P'
      EJECT
      SET DEVICE TO SCREEN
      SET PRINTER OFF
   ELSE
      @ 23, 1 SAY ''
      WAIT SPACE(25)+'Press Any Key To Return '
   ENDIF
   CLOSE ALL
   USE pl-work2
   ZAP
   CLOSE ALL

RETURN
*****************************


*************************
PROCEDURE BUD_COMP
*************************

CLEAR
CLOSE ALL

IF _DOS
SET COLOR TO 7/1
ENDIF

CLEAR
SELECT 2
USE ldgrcode ORDER ac1

SELECT 1
USE master ORDER ac2

R2= 'r=r+1'
CL= 'set colo to n/w'
CL2= 'set colo to 7/1'
SET DATE brit
STORE 0 TO MC1, MC2, MC3
STORE 0 TO NC1, NC2, NC3
STORE DATE() TO FDATE, SDATE
HEAD= .T.
DO WHILE .T.
   CLEAR
   R= 4
   @ 2, 20 SAY 'Budget Variance Report'
   @ R, 20 SAY 'Budget From Head Code '
   &r2
   &r2
   @ R, 20 GET MC1 PICTURE '99' RANGE 60, 89
   @ R, 40 SAY 'Range For level From 60 to 89 '
   &cl
   @ R, 22 SAY '-'
   @ R, 23 SAY 'xx' PICTURE '99'
   &cl
   @ R, 25 SAY '-'
   @ R, 26 SAY 'xxx' PICTURE '999'
   &cl2
   READ
   IF READKEY()=12
      CLOSE DATA
      CLEAR
      RETURN
   ENDIF
   &r2
   &r2
   @ R, 20 SAY ' " " "  To Head Code No'
   &r2
   &r2
   @ R, 20 GET NC1 PICTURE '99' RANGE 60, 89
   &cl
   @ R, 22 SAY '-'
   @ R, 23 SAY 'xx' PICTURE '99'
   &cl
   @ R, 25 SAY '-'
   @ R, 26 SAY 'xxx' PICTURE '999'
   &cl2
   READ
   IF READKEY()=12
      CLOSE DATA
      CLEAR
      RETURN
   ENDIF
   &r2
   &r2
   @ R, 20 SAY 'From   Date ' GET FDATE
   &r2
   &r2
   @ R, 20 SAY 'To     Date ' GET SDATE
   READ
   IF READKEY()=12
      EXIT
   ENDIF
   IF FDATE>SDATE
      @ 14, 15 SAY '" From Date " Cannot Be Greater Than " To Date " - Retry'
      WAIT ''
      LOOP
   ENDIF
   EXIT
ENDDO
CLEAR
P= ' '
DO WHILE .not. P$'PSQ'
   @ 5, 4 SAY 'Printer/Screen/Quit  -  P/S/Q  ' GET P FUNCTION '!'
   READ
ENDDO
IF P='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
IF P='S'
   CLEAR
   SET PRINTER OFF
   SET DEVICE TO SCREEN
ELSE
   CLEAR
   PANS= ' '
   DO prnchk IN tbl_proc.prg
   IF PANS='Q'
      CLOSE ALL
      CLEAR
      RETURN
   ENDIF
   @ 11, 20 SAY 'Please wait ... Printing in progress '
   SET PRINTER ON
   SET DEVICE TO PRINTER
ENDIF
SELECT 1
COPY TO mfil FOR C1>=MC1.and.C1<=NC1.and.DATE>=FDATE.and.DATE<=SDATE.and.C3<>0
USE mfil
IF RECCOUNT()=0
   CLEAR
   @ 12, 8 SAY 'No Transaction Exist in Data File  -  Press any key to return to menu '
   WAIT ''
   CLEAR
   CLOSE ALL
   RETURN
ENDIF
CLEAR
INDEX ON STR(C1,2)+STR(C2,2)+STR(C3,3) TAG mfil ADDITIVE
TDAY= SDATE-FDATE+1
CLEAR
DO WHILE .not. EOF()
   IF EOF()
      CLOSE DATA
      CLEAR
      RETURN
   ENDIF
   STORE STR(C1,2)+STR(C2,2)+STR(C3,3) TO MCODE
   STORE 0 TO TAMT, TCRAMT, TDRAMT
   STORE C1 TO MC1
   STORE C2 TO MC2
   STORE C3 TO MC3
   SELECT 2
   SEEK MCODE
   IF FOUND()
      IF BUDGET=0
         SKIP
         LOOP
      ENDIF
      STORE BUDGET TO MTBUJET
      STORE BUDGET/365 TO MBUJET
      STORE TITLE TO MTITLE
   ELSE
      STORE 'Invalid Code' TO MTITLE
   ENDIF
   SELECT 1
   DO WHILE STR(C1,2)+STR(C2,2)+STR(C3,3)=MCODE
      TDRAMT= DR_AMOUNT+TDRAMT
      TCRAMT= CR_AMOUNT+TCRAMT
      IF EOF()
         EXIT
      ENDIF
      SKIP
   ENDDO
   IF MC1>60.and.MC1<70
      TAMT= TCRAMT-TDRAMT+TAMT
   ENDIF
   IF MC1>70
      TAMT= TDRAMT-TCRAMT+TAMT
   ENDIF
   IF TAMT=0
      SKIP
      LOOP
   ENDIF
   IF HEAD
      IF P='P'
         DO PRNCHK IN tbl_proc.prg
         DO top_prt1 IN tbl_proc.prg
      ENDIF
      IF P='S'
         DO screen IN tbl_proc.prg
      ENDIF
      R= 3
      @ R, 25 SAY 'Revenve Budgeting Variance Report'
      &r2
      @ R, 25 SAY '---------------------------------'
      &r2
      &r2
      @ R, 5 SAY 'From'
      @ R, 11 SAY FDATE
      @ R, 24 SAY 'To'
      @ R, 28 SAY SDATE
      @ R, 60 SAY 'Dated'
      @ R, 70 SAY DATE()
      &r2
      &r2
      @ R, 5 SAY 'Code'
      @ R, 22 SAY 'Title'
      @ R, 38 SAY 'Annual'
      @ R, 50 SAY 'For This Period'
      @ R, 70 SAY 'Variance'
      &r2
      @ R, 38 SAY 'Budget'
      @ R, 49 SAY '| Budget |'
      @ R, 60 SAY 'Actual|'
      @ R, 75 SAY '%'
      &r2
      @ R, 1 SAY REPLICATE('-',79)
      &r2
      HEAD= .F.
   ENDIF
   MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MC1))))+LTRIM(STR(MC1))
   @ R, 1 SAY MPC1 PICTURE '99'
   @ R, 3 SAY '-'
   MPC2= REPLICATE('0',2-LEN(LTRIM(STR(MC2))))+LTRIM(STR(MC2))
   @ R, 4 SAY MPC2 PICTURE '99'
   @ R, 6 SAY '-'
   MPC3= REPLICATE('0',3-LEN(LTRIM(STR(MC3))))+LTRIM(STR(MC3))
   @ R, 7 SAY MPC3 PICTURE '999'
   @ R, 12 SAY MTITLE
   @ R, 35 SAY MTBUJET PICTURE '9999999999.99'
   ACT= TDAY*MBUJET
   @ R, 48 SAY ACT PICTURE '9999999999.99'
   @ R, 58 SAY TAMT PICTURE '99999999999.99'
   IF MTBUJET<>0
      @ R, 70 SAY 100-TAMT/ACT*100 PICTURE '9999999999.99'
   ENDIF
   &r2
   IF P='S'
      IF R>21
         @ 24, 15 SAY ''
         XYZ= ' '
         DO WHILE .not. XYZ$'CQ'
            SET CONFIRM OFF
            @ 24, 55 SAY 'Continue/Quit - C/Q ' GET XYZ FUNCTION '!'
            READ
         ENDDO
         IF XYZ='Q'
            CLEAR
            SET DEVICE TO SCREEN
            CLOSE ALL
            RETURN
         ENDIF
         CLEAR
         R= 3
         HEAD= .T.
      ENDIF
   ENDIF
   IF P='P'
      IF R>56
         EJECT
         HEAD= .T.
      ENDIF
   ENDIF
ENDDO
IF P='S'
   @ 24, 7 SAY 'End of Screen Printing  -  Press any key to return to menu.... '
   WAIT ''
ENDIF
IF P='P'
   SET DEVICE TO SCREEN
   SET PRINTER OFF
   EJECT
ENDIF
RUN del mfil.dbf
CLOSE ALL

RETURN
************************

*************************
PROCEDURE BUD_COMP2
*************************


SELECT 2
USE ldgrcode ORDER ac1

SELECT 1
USE master ORDER ac2

R2= 'r=r+1'
CL= 'set colo to n/w'
CL2= 'set colo to '
SET DATE brit
STORE 0 TO MC1, MC2, MC3
STORE 0 TO NC1, NC2, NC3
STORE DATE() TO FDATE, SDATE
HEAD= .T.
DO WHILE .T.
   CLEAR
   R= 4
   @ 2, 20 SAY 'Budget Variance Report'
   @ R, 20 SAY 'Budget From Head Code '
   &r2
   &r2
   @ R, 20 GET MC1 PICTURE '99' RANGE 70, 89
   &cl
   @ R, 22 SAY '-'
   &cl2
   @ R, 23 GET MC2 PICTURE '99'
   &cl
   @ R, 25 SAY '-'
   &cl2
   @ R, 26 GET MC3 PICTURE '999'
   READ
   IF READKEY()=12
      CLOSE DATA
      CLEAR
      RETURN
   ENDIF
   STORE STR(MC1,2)+STR(MC2,2)+STR(MC3,3) TO MCODE
   SELECT 2
   SEEK MCODE
   IF .not. FOUND()
      &r2
      @ R, 20 SAY 'This Code does not Exist - Retry '
      WAIT ''
      LOOP
   ELSE
      &cl
      @ R, 32 SAY TITLE
      &cl2
   ENDIF
   &r2
   &r2
   @ R, 20 SAY ' " " "  To Head Code No'
   &r2
   &r2
   @ R, 20 GET NC1 PICTURE '99' RANGE 70, 89
   &cl
   @ R, 22 SAY '-'
   &cl2
   @ R, 23 GET NC2 PICTURE '99'
   &cl
   @ R, 25 SAY '-'
   &cl2
   @ R, 26 GET NC3 PICTURE '999'
   READ
   IF READKEY()=12
      CLOSE DATA
      CLEAR
      RETURN
   ENDIF
   STORE STR(NC1,2)+STR(NC2,2)+STR(NC3,3) TO MCODE
   SELECT 2
   SEEK MCODE
   IF .not. FOUND()
      &r2
      @ R, 20 SAY 'This Code does not Exist - Retry '
      WAIT ''
      LOOP
   ELSE
      &cl
      @ R, 32 SAY TITLE
      &cl2
   ENDIF
   &r2
   &r2
   @ R, 20 SAY 'From   Date ' GET FDATE
   &r2
   &r2
   @ R, 20 SAY 'To     Date ' GET SDATE
   READ
   IF READKEY()=12
      EXIT
   ENDIF
   IF FDATE>SDATE
      @ 14, 20 SAY 'Second Connot Be Greater Than First Date - Retry'
      WAIT ''
      LOOP
   ENDIF
   EXIT
ENDDO
CLEAR
P= ' '
DO WHILE .not. P$'PSQ'
   @ 5, 4 SAY 'Printer/Screen/Quit  -  P/S/Q  ' GET P FUNCTION '!'
   READ
ENDDO
IF P='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
IF P='S'
   CLEAR
   SET PRINTER OFF
   SET DEVICE TO SCREEN
ELSE
   CLEAR
   PANS= ' '
   DO prnchk IN tbl_proc.prg
   IF PANS='Q'
      CLOSE ALL
      CLEAR
      RETURN
   ENDIF
   @ 11, 20 SAY 'Please wait ... Printing in progress '
   SET PRINTER ON
   SET DEVICE TO PRINTER
ENDIF
SELECT 1
COPY TO mfil FOR C1>=MC1.and.C1<=NC1.and.DATE>=FDATE.and.DATE<=SDATE.and.C3<>0
USE mfil
IF RECCOUNT()=0
   CLEAR
   @ 12, 12 SAY 'No Transaction Exist in Data File  -  Press any key to return to menu .... '
   WAIT ''
   CLEAR
   CLOSE ALL
   RETURN
ENDIF
CLEAR
INDEX ON STR(C1,2)+STR(C2,2)+STR(C3,3) TAG mfil ADDITIVE
TDAY= SDATE-FDATE+1
CLEAR
DO WHILE .not. EOF()
   STORE STR(C1,2)+STR(C2,2)+STR(C3,3) TO MCODE
   STORE 0 TO TAMT, TCRAMT, TDRAMT
   STORE C1 TO MC1
   STORE C2 TO MC2
   STORE C3 TO MC3
   SELECT 2
   SEEK MCODE
   IF FOUND()
      STORE BUDGET TO MTBUJET
      STORE BUDGET/365 TO MBUJET
      STORE TITLE TO MTITLE
   ELSE
      STORE 'Invalid Code' TO MTITLE
   ENDIF
   SELECT 1
   DO WHILE STR(C1,2)+STR(C2,2)+STR(C3,3)=MCODE
      TDRAMT= DR_AMOUNT+TDRAMT
      TCRAMT= CR_AMOUNT+TCRAMT
      IF EOF()
         EXIT
      ENDIF
      SKIP
   ENDDO
   IF MC1>70.and.MC1<80
      TAMT= TCRAMT-TDRAMT+TAMT
   ENDIF
   IF MC1>80
      TAMT= TDRAMT-TCRAMT+TAMT
   ENDIF
   IF HEAD
      IF P='P'
         DO PRNCHK IN tbl_proc.prg
         DO top_prt1 IN tbl_proc.prg
      ENDIF
      IF P='S'
         DO screen IN tbl_proc.prg
      ENDIF
      R= 3
      @ R, 25 SAY 'Revenve Budgeting Variance Report'
      &r2
      @ R, 25 SAY '---------------------------------'
      &r2
      &r2
      @ R, 5 SAY 'From'
      @ R, 11 SAY FDATE
      @ R, 24 SAY 'To'
      @ R, 28 SAY SDATE
      @ R, 60 SAY 'Dated'
      @ R, 70 SAY DATE()
      &r2
      &r2
      @ R, 5 SAY 'Code'
      @ R, 22 SAY 'Title'
      @ R, 38 SAY 'Annual'
      @ R, 50 SAY 'For This Period'
      @ R, 70 SAY 'Variance'
      &r2
      @ R, 38 SAY 'Budget'
      @ R, 49 SAY '| Budget |'
      @ R, 60 SAY 'Actual|'
      @ R, 75 SAY '%'
      &r2
      @ R, 1 SAY REPLICATE('-',79)
      &r2
      HEAD= .F.
   ENDIF
   @ R, 1 SAY MC1 PICTURE '99'
   @ R, 3 SAY '-'
   @ R, 4 SAY MC2 PICTURE '99'
   @ R, 6 SAY '-'
   @ R, 7 SAY MC3 PICTURE '999'
   @ R, 12 SAY MTITLE
   @ R, 35 SAY MTBUJET PICTURE '9999999.99'
   ACT= TDAY*MBUJET
   @ R, 48 SAY ACT PICTURE '999999.99'
   @ R, 58 SAY TAMT PICTURE '9999999.99'
   IF MTBUJET<>0
      @ R, 70 SAY TAMT/ACT*100 PICTURE '9999.99'
   ENDIF
   &r2
   IF P='S'
      IF R>21
         @ 24, 15 SAY ''
         XYZ= ' '
         DO WHILE .not. XYZ$'CQ'
            SET CONFIRM OFF
            @ 24, 55 SAY 'Continue/Quit - C/Q ' GET XYZ FUNCTION '!'
            READ
         ENDDO
         IF XYZ='Q'
            CLEAR
            SET DEVICE TO SCREEN
            CLOSE ALL
            RETURN
         ENDIF
         CLEAR
         R= 3
         HEAD= .T.
      ENDIF
   ENDIF
   IF P='P'
      IF R>56
         EJECT
         HEAD= .T.
      ENDIF
   ENDIF
ENDDO
IF P='S'
   @ 24, 7 SAY 'End of Screen Printing  -  Press any key to return to menu.... '
   WAIT ''
ENDIF
IF P='P'
   SET DEVICE TO SCREEN
   SET PRINTER OFF
   EJECT
ENDIF
CLOSE ALL
RUN del mfil.dbf

RETURN
***********************


************************
PROCEDURE TRL_DTL
************************
CLEAR
CLOSE ALL

IF _DOS
SET COLOR TO 7/1
ENDIF

CLEAR
STORE 0 TO DRTOT, CRTOT, TCR, TDR, LINE
@ 2, 2 SAY 'Convert To Lotus File Format'
@ 4, 2 SAY 'Subsideries (Detailed) Trial Balance '
@ 8, 2 SAY 'This option will create :'
@ 10, 2 SAY '" Subsideries (Detailed) Trial Balance " Report output file'
@ 11, 2 SAY '  named  " TRL-DTL.DBF ". This Foxbase/dBase file can be   '
@ 12, 2 SAY '  converted to a LOTUS worksheet file using LOTUS Translate Option.'
ANS= ' '
DO WHILE .not. ANS$'CQ'
   @ 24, 55 SAY 'Continue/Quit - C/Q ' GET ANS FUNCTION '!'
   READ
ENDDO
IF ANS='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
ZEROBAL= ' '
CLEAR
DO WHILE .not. ZEROBAL$'YN'
   @ 4, 2 SAY 'Do You Want To Include Ledger Heads Having Zero Balance - Y/N ' GET ZEROBAL FUNCTION '!'
   READ
ENDDO
@ 4, 2 SAY SPACE(70)
ANS= ' '
DO WHILE .not. ANS$'CQ'
   @ 4, 2 SAY 'Continue/Quit - C/Q ' GET ANS FUNCTION '!'
   READ
ENDDO
IF ANS='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
SELECT 1
USE ldgrcode ORDER ac1

SELECT 2
USE trl-dtl
ZAP
STORE 0 TO MCODE, WRECNO, MSRNO, WCODE, MNO
STORE 0 TO DRTOT, CRTOT, TCR, TDR, LINE
SELECT 1
GOTO TOP
CLEAR
DO WHILE .not. EOF()
   IF EOF()
      EXIT
   ENDIF
   IF ZEROBAL='N'
      IF LDGR_BAL=0
         SKIP
         LOOP
      ENDIF
   ENDIF
   IF C3=0
      SKIP
      LOOP
   ENDIF
   MC1= C1
   MC2= C2
   MC3= C3
   MC1= REPLICATE('0',2-LEN(LTRIM(STR(MC1))))+LTRIM(STR(MC1))
   MC2= REPLICATE('0',2-LEN(LTRIM(STR(MC2))))+LTRIM(STR(MC2))
   MC3= REPLICATE('0',3-LEN(LTRIM(STR(MC3))))+LTRIM(STR(MC3))
   MSTAT= STATUS
   SELECT 2
   APPEND BLANK
   REPLACE CODE WITH MC1+'-'+MC2+'-'+MC3
   REPLACE TITLE WITH  A->TITLE
   IF MSTAT='DR'
      REPLACE DR_AMOUNT WITH  A->LDGR_BAL
   ELSE
      REPLACE CR_AMOUNT WITH  A->LDGR_BAL
   ENDIF
   SELECT 1
   SKIP
ENDDO
CLEAR
CLOSE ALL

RETURN
*****************************


*******************************
PROCEDURE TRL_SUM
*******************************

CLEAR
CLOSE ALL

IF _DOS
SET COLOR TO 7/1
ENDIF

CLEAR
@ 2, 2 SAY 'Convert To Lotus File Format'
@ 4, 2 SAY 'Subsideries (Summary) Trial Balance '
@ 8, 2 SAY 'This option will create :'
@ 10, 2 SAY '" Subsideries (Summary) Trial Balance " Report output file'
@ 11, 2 SAY '  named  " TRL-SUM.DBF ". This Foxbase/dBase file can be   '
@ 12, 2 SAY '  converted to a LOTUS worksheet file using LOTUS Translate Option.'
ANS= ' '
DO WHILE .not. ANS$'CQ'
   @ 24, 55 SAY 'Continue/Quit - C/Q ' GET ANS FUNCTION '!'
   READ
ENDDO
IF ANS='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
SELECT 1
USE ldgrcode ORDER ac1

SELECT 2
USE trl-sum
ZAP
SELECT 1
GOTO TOP
DO WHILE .not. EOF()
   SELECT 1
   IF LDGR_BAL=0.and.C3<>0
      SKIP
      LOOP
   ENDIF
   IF EOF()
      EXIT
   ENDIF
   MC1= C1
   MC2= C2
   MTITLE= TITLE
   MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MC1))))+LTRIM(STR(MC1))
   MPC2= REPLICATE('0',2-LEN(LTRIM(STR(MC2))))+LTRIM(STR(MC2))
   STORE 0 TO TDR, TCR, TAMT
   DO WHILE C1=MC1.and.C2=MC2
      IF C1<>MC1.and.C2<>MC2
         EXIT
      ENDIF
      IF STATUS='DR'
         TDR= TDR+LDGR_BAL
      ELSE
         TCR= TCR+LDGR_BAL
      ENDIF
      SKIP
   ENDDO
   IF TDR>TCR
      TAMT= TDR-TCR
   ENDIF
   IF TCR>TDR
      TAMT= TCR-TDR
   ENDIF
   IF TAMT=0
      LOOP
   ENDIF
   SELECT 2
   APPEND BLANK
   REPLACE CODE WITH MPC1+'-'+MPC2
   REPLACE TITLE WITH MTITLE
   IF TDR>TCR
      REPLACE DR_AMOUNT WITH TAMT
   ELSE
      REPLACE CR_AMOUNT WITH TAMT
   ENDIF
   SELECT 1
ENDDO
CLEAR
CLOSE ALL

RETURN
***********************



**********************
PROCEDURE PL_DTL
**********************

CLEAR
CLOSE ALL

IF _DOS
SET COLOR TO 7/1
ENDIF

CLEAR
CLEAR PROGRAM
@ 2, 2 SAY 'Convert To Lotus File Format'
@ 4, 2 SAY '(Detailed) Profit & Loss '
@ 8, 2 SAY 'This option will create :'
@ 10, 2 SAY '" (Detailed) Profit & Loss " Report output file'
@ 11, 2 SAY '  named  " PL-DTL.DBF ". This Foxbase/dBase file can be   '
@ 12, 2 SAY '  converted to a LOTUS worksheet file using LOTUS Translate Option.'
ANS= ' '
DO WHILE .not. ANS$'CQ'
   @ 24, 55 SAY 'Continue/Quit - C/Q ' GET ANS FUNCTION '!'
   READ
ENDDO
IF ANS='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
CLEAR
ZEROBAL= ' '
DO WHILE .not. ZEROBAL$'YN'
   @ 4, 2 SAY 'Do You Want To Include Ledger Heads Having Zero Balance - Y/N ' GET ZEROBAL FUNCTION '!'
   READ
ENDDO
P= ' '
DO WHILE .not. P$'CQ'
   @ 23, 50 SAY 'Continue/Quit - C/Q ' GET P FUNCTION '!'
   READ
ENDDO
IF P='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
STORE SPACE(30) TO WTITLE, WHTITLE
STORE 0 TO DRTOT, CRTOT, TCR, TDR, LINE, TOTCR7, TOTDR7, TOTCR8, TOTDR8, TOT7, TOT8, SWCH
STORE 0 TO AMT6, AMT7, AMT8, AMT9, GPFT, GPFT2
SELECT 2
USE chart
COPY TO abc FOR CHART_NO>5.and.CHART_NO<10
USE abc
INDEX ON CHART_NO TAG cht_idx ADDITIVE
GOTO TOP
M1= FR
M2= TO
SELECT 1
USE pl-work2
ZAP
APPEND FROM ldgrcode FOR C1>=M1.and.C1<=M2
REPLACE FOR CHART_NO=0 CHART_NO WITH 6
SELECT 2
DO WHILE .not. EOF()
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   M3= FR
   M4= TO
   SELECT 1
   IF M3<>0.and.M4<>0
      APPEND FROM ldgrcode FOR C1>=M3.and.C1<=M4
      REPLACE FOR CHART_NO=0 CHART_NO WITH 7
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   M5= FR
   M6= TO
   SELECT 1
   IF M5<>0.and.M6<>0
      APPEND FROM ldgrcode FOR C1>=M5.and.C1<=M6
      REPLACE FOR CHART_NO=0 CHART_NO WITH 8
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   M7= FR
   M8= TO
   SELECT 1
   IF M7<>0.and.M8<>0
      APPEND FROM ldgrcode FOR C1>=M7.and.C1<=M8
      REPLACE FOR CHART_NO=0 CHART_NO WITH 9
   ENDIF
   EXIT
ENDDO
SELECT 4
USE pl-dtl
ZAP
SELECT 3
USE ldgrcode ORDER ac1

SELECT 1
USE pl-work2 ORDER bl_c1

SELECT 2
GOTO TOP
SELECT 1
WGTITLE= SPACE(30)
STORE 0 TO WRECNO, MSRNO, WCODE, MCODE
STORE 0 TO DRTOT, CRTOT, TCR6, TDR6, GTDR, GTCR, LINE, TOTDR, TOTCR
STORE 0 TO TCR7, TDR7, TCR8, TDR8, TCR9, TDR9
MC1= C1
MC2= C2
MC3= C3
CLEAR
DO WHILE .not. EOF()
   IF ZEROBAL='N'
      IF LDGR_BAL=0
         SKIP
         LOOP
      ENDIF
   ENDIF
   MC1= C1
   MCHART= CHART_NO
   CHD= 0
   DO WHILE CHART_NO=MCHART
      IF EOF()
         EXIT
      ENDIF
      IF ZEROBAL='N'
         IF LDGR_BAL=0
            SKIP
            LOOP
         ENDIF
      ENDIF
      IF C3=0
         SKIP
         LOOP
      ENDIF
      STORE SPACE(30) TO WTITLE
      STORE TITLE TO WTITLE
      MSTAT= STATUS
      IF CHD=0
         STORE CHART_NO*10 TO MC1
         STORE 0 TO MC2, MC3
         STORE STR(MC1,2)+STR(MC2,2)+STR(MC3,3) TO MLCODE
         SELECT 3
         SEEK MLCODE
         IF .not. FOUND()
            SELECT 2
            HD= AT('Head',CHART)
         ELSE
            SELECT 3
         ENDIF
         SELECT 1
         CHD= 1
      ENDIF
      MPC1= REPLICATE('0',2-LEN(LTRIM(STR(C1))))+LTRIM(STR(C1))
      MPC2= REPLICATE('0',2-LEN(LTRIM(STR(C2))))+LTRIM(STR(C2))
      MPC3= REPLICATE('0',3-LEN(LTRIM(STR(C3))))+LTRIM(STR(C3))
      SELECT 4
      APPEND BLANK
      REPLACE CODE WITH MPC1+'-'+MPC2+'-'+MPC3
      REPLACE TITLE WITH WTITLE
      IF MCHART=6
         IF MSTAT='DR'
            REPLACE AMOUNT WITH  A->LDGR_BAL* -1
         ELSE
            REPLACE AMOUNT WITH  A->LDGR_BAL
         ENDIF
      ENDIF
      IF MCHART>6
         IF MSTAT='DR'
            REPLACE AMOUNT WITH  A->LDGR_BAL
         ELSE
            REPLACE AMOUNT WITH  A->LDGR_BAL* -1
         ENDIF
      ENDIF
      SELECT 1
      SKIP
   ENDDO
ENDDO
CLEAR
CLOSE ALL
USE pl-work2
ZAP
USE work
ZAP
RUN del abc.dbf
CLOSE ALL


RETURN
*********************


*************************
PROCEDURE PL_SUM
*************************

CLEAR
CLOSE ALL

IF _DOS
SET COLOR TO 7/1
ENDIF

CLEAR PROGRAM
CLEAR
@ 2, 2 SAY 'Convert To Lotus File Format'
@ 4, 2 SAY '(Summary) Profit & Loss '
@ 8, 2 SAY 'This option will create :'
@ 10, 2 SAY '" (Summary) Profit & Loss " Report output file'
@ 11, 2 SAY '  named  " PL-SUM.DBF ". This Foxbase/dBase file can be   '
@ 12, 2 SAY '  converted to a LOTUS worksheet file using LOTUS Translate Option.'
P= ' '
DO WHILE .not. P$'CQ'
   @ 23, 50 SAY 'Continue/Quit - C/Q ' GET P FUNCTION '!'
   READ
ENDDO
IF P='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
STORE SPACE(30) TO WTITLE, WHTITLE
STORE 0 TO DRTOT, CRTOT, TCR, TDR, LINE, TOTCR7, TOTDR7, TOTCR8, TOTDR8
STORE 0 TO AMT6, AMT7, AMT8, AMT9, GPFT, GPFT2, TOT7, TOT8, SWCH
SELECT 2
USE chart
COPY TO abc FOR CHART_NO>5.and.CHART_NO<10
USE abc
INDEX ON CHART_NO TAG cht_idx ADDITIVE
GOTO TOP
M1= FR
M2= TO
SELECT 1
USE pl-work2
ZAP
APPEND FROM ldgrcode FOR C1>=M1.and.C1<=M2
REPLACE FOR CHART_NO=0 CHART_NO WITH 6
SELECT 2
DO WHILE .not. EOF()
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   M3= FR
   M4= TO
   SELECT 1
   IF M3<>0.and.M4<>0
      APPEND FROM ldgrcode FOR C1>=M3.and.C1<=M4
      REPLACE FOR CHART_NO=0 CHART_NO WITH 7
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   M5= FR
   M6= TO
   SELECT 1
   IF M5<>0.and.M6<>0
      APPEND FROM ldgrcode FOR C1>=M5.and.C1<=M6
      REPLACE FOR CHART_NO=0 CHART_NO WITH 8
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   M7= FR
   M8= TO
   SELECT 1
   IF M7<>0.and.M8<>0
      APPEND FROM ldgrcode FOR C1>=M7.and.C1<=M8
      REPLACE FOR CHART_NO=0 CHART_NO WITH 9
   ENDIF
   EXIT
ENDDO
SELECT 4
USE pl-sum
ZAP
SELECT 3
USE ldgrcode ORDER ac1

SELECT 1
USE pl-work2 ORDER bl_c1

SELECT 2
GOTO TOP
SELECT 1
GOTO TOP
WGTITLE= SPACE(30)
STORE 0 TO WRECNO, MSRNO, WCODE, MCODE
STORE 0 TO DRTOT, CRTOT, TCR6, TDR6, GTDR, GTCR, LINE, TOTDR, TOTCR
STORE 0 TO TCR7, TDR7, TCR8, TDR8, TCR9, TDR9
MC1= C1
MC2= C2
MC3= C3
CLEAR
DO WHILE .not. EOF()
   MCHART= CHART_NO
   STORE 0 TO MTOTDR, MTOTCR
   CHD= 0
   DO WHILE CHART_NO=MCHART
      MCC1= C1
      MCC2= C2
      STORE 0 TO TDR, TCR
      IF EOF()
         EXIT
      ENDIF
      IF C3=0
         SKIP
         LOOP
      ENDIF
      LINE= LINE+1
      IF CHD=0
         STORE CHART_NO*10 TO MC1
         STORE 0 TO MD2, MD3
         STORE STR(MC1,2)+STR(MD2,2)+STR(MD3,3) TO MLCODE
         SELECT 3
         SEEK MLCODE
         IF .not. FOUND()
            SELECT 2
            HD= AT('Head',CHART)
         ELSE
            SELECT 3
         ENDIF
         SELECT 1
         CHD= 1
      ENDIF
      MCC3= 0
      STORE SPACE(30) TO WTITLE
      STORE STR(MCC1,2)+STR(MCC2,2)+STR(MCC3,3) TO MLCODE
      SELECT 3
      SEEK MLCODE
      IF FOUND()
         STORE TITLE TO WTITLE
      ENDIF
      MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MCC1))))+LTRIM(STR(MCC1))
      MPC2= REPLICATE('0',2-LEN(LTRIM(STR(MCC2))))+LTRIM(STR(MCC2))
      SELECT 1
      DO WHILE C1=MCC1.and.C2=MCC2
         IF STATUS='DR'
            TDR= TDR+LDGR_BAL
            MTOTDR= MTOTDR+LDGR_BAL
         ELSE
            TCR= TCR+LDGR_BAL
            MTOTCR= MTOTCR+LDGR_BAL
         ENDIF
         MSTAT= STATUS
         SKIP
      ENDDO
      SELECT 4
      APPEND BLANK
      REPLACE CODE WITH MPC1+'-'+MPC2
      REPLACE TITLE WITH WTITLE
      IF MCHART=6
         IF TCR>=TDR
            REPLACE AMOUNT WITH TCR-TDR
         ELSE
            REPLACE AMOUNT WITH TDR* -1-TCR
         ENDIF
      ENDIF
      IF MCHART>6
         IF TDR>=TCR
            REPLACE AMOUNT WITH TDR-TCR
         ELSE
            REPLACE AMOUNT WITH TCR* -1-TDR
         ENDIF
      ENDIF
      SELECT 1
   ENDDO
ENDDO
CLEAR
CLOSE ALL
USE pl-work2
ZAP
USE work
ZAP
RUN del abc.dbf
CLOSE ALL

RETURN
********************


********************
PROCEDURE BS_SUM
********************

CLEAR
CLOSE ALL
@ 2, 2 SAY 'Convert To Lotus File Format'
@ 4, 2 SAY '(Summary) Balance Sheet '
@ 8, 2 SAY 'This option will create :'
@ 10, 2 SAY '" (Summary) Balance Sheet " Report output file'
@ 11, 2 SAY '  named  " BS-SUM.DBF ". This Foxbase/dBase file can be   '
@ 12, 2 SAY '  converted to a LOTUS worksheet file using LOTUS Translate Option.'
P= ' '
DO WHILE .not. P$'CQ'
   @ 23, 50 SAY 'Continue/Quit - C/Q ' GET P FUNCTION '!'
   READ
ENDDO
IF P='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
STORE SPACE(30) TO WTITLE, WHTITLE
STORE 0 TO AMT6, AMT7, AMT8, AMT9, GPFT, GPFT2
SELECT 2
USE chart ORDER cht

GOTO TOP
MF1= FR
MT1= TO
SELECT 1
USE pl-work2
ZAP
APPEND FROM ldgrcode FOR C1>=MF1.and.C1<=MT1
REPLACE FOR CHART_NO=0 CHART_NO WITH 1
SELECT 2
DO WHILE .not. EOF()
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   MF2= FR
   MT2= TO
   SELECT 1
   IF MF2<>0.and.MT2<>0
      APPEND FROM ldgrcode FOR C1>=MF2.and.C1<=MT2
      REPLACE FOR CHART_NO=0 CHART_NO WITH 2
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   MF3= FR
   MT3= TO
   SELECT 1
   IF MF3<>0.and.MT3<>0
      APPEND FROM ldgrcode FOR C1>=MF3.and.C1<=MT3
      REPLACE FOR CHART_NO=0 CHART_NO WITH 3
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   MF4= FR
   MT4= TO
   SELECT 1
   IF MF4<>0.and.MT4<>0
      APPEND FROM ldgrcode FOR C1>=MF4.and.C1<=MT4
      REPLACE FOR CHART_NO=0 CHART_NO WITH 4
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   MF5= FR
   MT5= TO
   SELECT 1
   IF MF5<>0.and.MT5<>0
      APPEND FROM ldgrcode FOR C1>=MF5.and.C1<=MT5
      REPLACE FOR CHART_NO=0 CHART_NO WITH 5
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   MF6= FR
   MT6= TO
   SELECT 1
   IF MF6<>0.and.MT6<>0
      APPEND FROM ldgrcode FOR C1>=MF6.and.C1<=MT6
      REPLACE FOR CHART_NO=0 CHART_NO WITH 6
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   MF7= FR
   MT7= TO
   SELECT 1
   IF MF7<>0.and.MT7<>0
      APPEND FROM ldgrcode FOR C1>=MF7.and.C1<=MT7
      REPLACE FOR CHART_NO=0 CHART_NO WITH 7
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   MF8= FR
   MT8= TO
   SELECT 1
   IF MF8<>0.and.MT8<>0
      APPEND FROM ldgrcode FOR C1>=MF8.and.C1<=MT8
      REPLACE FOR CHART_NO=0 CHART_NO WITH 8
   ENDIF
   SELECT 2
   IF .not. EOF()
      SKIP
   ENDIF
   MF9= FR
   MT9= TO
   SELECT 1
   IF MF9<>0.and.MT9<>0
      APPEND FROM ldgrcode FOR C1>=MF9.and.C1<=MT9
      REPLACE FOR CHART_NO=0 CHART_NO WITH 9
   ENDIF
ENDDO
CLEAR
CLOSE ALL
SELECT 4
USE BS-sum
ZAP
SELECT 3
USE ldgrcode ORDER ac1

SELECT 2
USE chart ORDER cht

GOTO TOP
SELECT 1
USE pl-work2 ORDER bl_c1

WGTITLE= SPACE(30)
STORE 0 TO LTAMT, DTAMT, MCODE, PCON
STORE 0 TO WRECNO, MSRNO, WCODE
STORE 0 TO DRTOT, CRTOT, GTDR, GTCR, LINE, TOTDR, TOTCR, NTOT
STORE 0 TO TCR1, TDR1, TCR2, TDR2, TCR3, TDR3
STORE 0 TO TCR4, TDR4, TCR5, TDR5, MC3
CLEAR
GOTO TOP
DO WHILE .not. EOF()
   IF EOF()
      EXIT
   ENDIF
   IF CHART_NO>5
      SKIP
      LOOP
   ENDIF
   TAMT= 0
   IF CHART_NO<=3
      STORE CHART_NO TO MCHART
      DO WHILE CHART_NO=MCHART
         STORE 0 TO TDR, TCR, AMT, MC3
         STORE C1 TO MC1
         STORE C2 TO MC2
         DO WHILE C1=MC1.and.C2=MC2
            IF STATUS='DR'
               TDR= TDR+LDGR_BAL
            ELSE
               TCR= TCR+LDGR_BAL
            ENDIF
            SKIP
         ENDDO
         STORE STR(MC1,2)+STR(MC2,2)+STR(MC3,3) TO MCODE
         SELECT 3
         SEEK MCODE
         IF FOUND()
            STORE TITLE TO MTITLE
         ELSE
            STORE 'Group Total ' TO MTITLE
         ENDIF
         SELECT 1
         IF MCHART<=3
            AMT= TCR-TDR
         ELSE
            AMT= TDR-TCR
         ENDIF
         MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MC1))))+LTRIM(STR(MC1))
         MPC2= REPLICATE('0',2-LEN(LTRIM(STR(MC2))))+LTRIM(STR(MC2))
         SELECT 4
         APPEND BLANK
         REPLACE CODE WITH MPC1+'-'+MPC2
         REPLACE TITLE WITH MTITLE
         IF MC2<>0
            REPLACE AMOUNT WITH AMT
            TAMT= AMT+TAMT
         ENDIF
         SELECT 1
      ENDDO
      SELECT 2
      SEEK MCHART
      IF FOUND()
      ENDIF
      SELECT 1
      LTAMT= LTAMT+TAMT
   ELSE
      IF PCON=0
         PCON= 2
         HEADING= .T.
      ENDIF
      STORE CHART_NO TO MCHART
      DO WHILE CHART_NO=MCHART
         STORE 0 TO TDR, TCR, AMT, MC3
         STORE C1 TO MC1
         STORE C2 TO MC2
         DO WHILE C1=MC1.and.C2=MC2
            IF STATUS='DR'
               TDR= TDR+LDGR_BAL
            ELSE
               TCR= TCR+LDGR_BAL
            ENDIF
            SKIP
         ENDDO
         STORE STR(MC1,2)+STR(MC2,2)+STR(MC3,3) TO MCODE
         SELECT 3
         SEEK MCODE
         IF FOUND()
            STORE TITLE TO MTITLE
         ELSE
            STORE 'Group Total ' TO MTITLE
         ENDIF
         SELECT 1
         IF MCHART<=3
            AMT= TCR-TDR
         ELSE
            AMT= TDR-TCR
         ENDIF
         MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MC1))))+LTRIM(STR(MC1))
         MPC2= REPLICATE('0',2-LEN(LTRIM(STR(MC2))))+LTRIM(STR(MC2))
         SELECT 4
         APPEND BLANK
         REPLACE CODE WITH MPC1+'-'+MPC2
         REPLACE TITLE WITH MTITLE
         IF MC2<>0
            REPLACE AMOUNT WITH AMT
            TAMT= AMT+TAMT
         ENDIF
         SELECT 1
      ENDDO
      SELECT 2
      SEEK MCHART
      IF FOUND()
      ENDIF
      SELECT 1
      DTAMT= DTAMT+TAMT
   ENDIF
ENDDO
CLEAR
CLOSE ALL

RETURN
*****************************


**************************
PROCEDURE C3_TRL1
**************************

CLEAR
CLOSE ALL

IF _DOS
SET COLOR TO 7/1
ENDIF

CLEAR
STORE 0 TO DRTOT, CRTOT, TCR, TDR, LINE
@ 2, 2 SAY 'Subsideries Trial Balance With Group Totals '
ZEROBAL= ' '
DO WHILE .not. ZEROBAL$'YN'
   @ 4, 2 SAY 'Do You Want To Include Ledger Heads Having Zero Balance - Y/N ' GET ZEROBAL FUNCTION '!'
   READ
ENDDO
@ 4, 2 SAY SPACE(70)
ANS= ' '
DO WHILE .not. ANS$'PSQ'
   @ 4, 2 SAY 'Printer/Screen/Quit -  P/S/Q ' GET ANS FUNCTION '!'
   READ
ENDDO
IF ANS='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
CLEAR

USE master  ALIAS master EXCLUSIVE
INDEX ON DATE TAG mastdate
SET ORDER TO mastdate



GOTO BOTTOM
STORE DATE TO MTDATE
CLEAR
@ 3, 5 SAY 'Your last posted voucher is dated '
@ 3, 42 SAY MTDATE
@ 4, 5 SAY 'Do you want to dispaly same date on your Trial Balance'
@ 5, 5 SAY 'Or enter the date you want to dispaly  ' GET MTDATE
READ
GOTO TOP
USE ldgrcode ORDER ac1

STORE 0 TO MCODE, WRECNO, MSRNO, WCODE, MNO
CLEAR
IF ANS='P'
   CLEAR
   @ 2, 5 SAY 'No Of Copies       ' GET MNO PICTURE '99'
   READ
   CLEAR
   @ 8, 17 SAY 'Subsideries Trial Balance Printing'
   @ 10, 17 SAY 'Please use 80 column (10 inches wide) continous'
   @ 11, 17 SAY 'printer paper and set Top Of Form'
   @ 12, 17 SAY 'Press ENTER when ready...........'
   WAIT ''
   PANS= ' '
   DO prnchk IN tbl_proc.prg
   IF PANS='Q'
      CLOSE ALL
      CLEAR
      RETURN
   ENDIF
   @ 11, 20 SAY 'Please wait ... Printing in progress '
   SET PRINTER ON
   SET DEVICE TO PRINTER
ENDIF
IF ANS='S'
   MNO= 1
ENDIF
ABC= 1
DO WHILE ABC<=MNO
   PAGE= 1
   HEADING= .T.
   GOTO TOP
   STORE 0 TO DRTOT, CRTOT, TCR, TDR, LINE
   CLEAR
   DO WHILE .not. EOF()
      IF HEADING
         IF ANS='S'
            DO screen IN tbl_proc.prg
            @ 2, 20 SAY 'TRIAL  BALANCE  AS  ON: '
         ENDIF
         IF ANS='P'
            DO PRNCHK IN tbl_proc.prg
            DO top_prt1 IN tbl_proc.prg
            @ 2, 23 SAY 'TRIAL BALANCE AS ON: '
         ENDIF
         @ 2, 44 SAY MTDATE
         @ 2, 72 SAY 'PAGE: '
         @ 2, 78 SAY PAGE PICTURE '99'
         @ 3, 1 SAY REPLICATE('-',79)
         @ 4, 1 SAY 'CODE-----'
         @ 4, 11 SAY '   ---- ACCOUNT  TITLE ----'
         @ 4, 50 SAY 'D E B I T'
         @ 4, 69 SAY 'C R E D I T'
         @ 5, 1 SAY REPLICATE('-',79)
         LINE= 6
         HEADING= .F.
      ENDIF
      IF EOF()
         EXIT
      ENDIF
      STORE SPACE(30) TO WTITLE
      STORE TITLE TO WTITLE
      MC1= C1
      MC2= C2
      STORE 0 TO MDR, MCR
      DO WHILE C1=MC1.and.C2=MC2
         IF HEADING
            IF ANS='S'
               DO screen IN tbl_proc.prg
               @ 2, 20 SAY 'TRIAL  BALANCE  AS  ON: '
            ENDIF
            IF ANS='P'
               DO PRNCHK IN tbl_proc.prg
               DO top_prt1 IN tbl_proc.prg
               @ 2, 23 SAY 'TRIAL BALANCE AS ON: '
            ENDIF
            @ 2, 44 SAY MTDATE
            @ 2, 72 SAY 'PAGE: '
            @ 2, 78 SAY PAGE PICTURE '99'
            @ 3, 1 SAY REPLICATE('-',79)
            @ 4, 1 SAY 'CODE-----'
            @ 4, 11 SAY '   ---- ACCOUNT  TITLE ----'
            @ 4, 50 SAY 'D E B I T'
            @ 4, 69 SAY 'C R E D I T'
            @ 5, 1 SAY REPLICATE('-',79)
            LINE= 6
            HEADING= .F.
         ENDIF
         IF C1<>MC1.and.C2<>MC2
            EXIT
         ENDIF
         STORE SPACE(30) TO WTITLE
         STORE TITLE TO WTITLE
         IF C3<>0
            IF ZEROBAL='N'
               IF LDGR_BAL=0
                  SKIP
                  LOOP
               ENDIF
            ENDIF
         ENDIF
         IF C3=0
            LINE= LINE+1
            MPC1= REPLICATE('0',2-LEN(LTRIM(STR(C1))))+LTRIM(STR(C1))
            @ LINE, 1 SAY MPC1
            @ LINE, 3 SAY '-'
            MPC2= REPLICATE('0',2-LEN(LTRIM(STR(C2))))+LTRIM(STR(C2))
            @ LINE, 4 SAY MPC2
            @ LINE, 6 SAY '-'
            MPC3= REPLICATE('0',3-LEN(LTRIM(STR(C3))))+LTRIM(STR(C3))
            @ LINE, 7 SAY MPC3
            @ LINE, 11 SAY TITLE
            MLEN= LEN(RTRIM(TITLE))
            LINE= LINE+1
            @ LINE, 1 SAY REPLICATE('-',15+MLEN)
            LINE= LINE+1
            SKIP
            IF ANS='S'.and.LINE>19
               IF EOF()
                  EXIT
               ENDIF
               XYZ= ' '
               DO WHILE .not. XYZ$'CQ'
                  SET CONFIRM OFF
                  @ 23, 57 SAY 'Continue/Quit - C/Q' GET XYZ FUNCTION '!'
                  READ
               ENDDO
               IF XYZ='Q'
                  CLEAR
                  CLOSE ALL
                  RETURN
               ENDIF
               CLEAR
               PAGE= PAGE+1
               HEADING= .T.
            ENDIF
            IF ANS='P'.and.LINE>=56
               PAGE= PAGE+1
               HEADING= .T.
            ENDIF
            LOOP
         ENDIF
         MPC1= REPLICATE('0',2-LEN(LTRIM(STR(C1))))+LTRIM(STR(C1))
         @ LINE, 1 SAY MPC1
         @ LINE, 3 SAY '-'
         MPC2= REPLICATE('0',2-LEN(LTRIM(STR(C2))))+LTRIM(STR(C2))
         @ LINE, 4 SAY MPC2
         @ LINE, 6 SAY '-'
         MPC3= REPLICATE('0',3-LEN(LTRIM(STR(C3))))+LTRIM(STR(C3))
         @ LINE, 7 SAY MPC3
         @ LINE, 11 SAY WTITLE
         COL= IIF(STATUS='DR',45,63)
         @ LINE, COL SAY ABS(LDGR_BAL) PICTURE '9,999,999,999.99'
         IF COL=45
            DRTOT= DRTOT+LDGR_BAL
            MDR= MDR+LDGR_BAL
         ELSE
            CRTOT= CRTOT+LDGR_BAL
            MCR= MCR+LDGR_BAL
         ENDIF
         LINE= LINE+1
         IF .not. EOF()
            SKIP
         ENDIF
         IF ANS='S'.and.LINE>19
            IF EOF()
               EXIT
            ENDIF
            XYZ= ' '
            DO WHILE .not. XYZ$'CQ'
               SET CONFIRM OFF
               @ 23, 57 SAY 'Continue/Quit - C/Q' GET XYZ FUNCTION '!'
               READ
            ENDDO
            IF XYZ='Q'
               CLEAR
               CLOSE ALL
               RETURN
            ENDIF
            CLEAR
            PAGE= PAGE+1
            HEADING= .T.
         ENDIF
         IF ANS='P'.and.LINE>=56
            PAGE= PAGE+1
            HEADING= .T.
         ENDIF
      ENDDO
      IF MDR<>0.or.MCR<>0
         @ LINE, 50 SAY REPLICATE('-',30)
         LINE= LINE+1
         @ LINE, 47 SAY MDR PICTURE '9999999,999.99'
         @ LINE, 65 SAY MCR PICTURE '9999999,999.99'
         LINE= LINE+1
         @ LINE, 50 SAY REPLICATE('-',30)
      ENDIF
   ENDDO
   IF ANS='S'.and.LINE>20
      LINE= LINE-1
   ENDIF
   LINE= LINE+1
   @ LINE, 1 SAY REPLICATE('-',79)
   LINE= LINE+1
   @ LINE, 10 SAY '        T O T A L S :'
   @ LINE, 47 SAY DRTOT PICTURE '9999999,999.99'
   @ LINE, 65 SAY CRTOT PICTURE '9999999,999.99'
   LINE= LINE+1
   @ LINE, 1 SAY REPLICATE('-',79)
   IF ANS='S'
      @ 24, 7 SAY 'End of Screen Printing  -  Press any key to return to menu.... '
      WAIT ''
   ENDIF
   IF ANS='P'
      EJECT
   ENDIF
   ABC= ABC+1
ENDDO
IF ANS='P'
   SET PRINTER OFF
   SET DEVICE TO SCREEN
ENDIF
CLEAR
SET FILTER TO
CLOSE ALL

RETURN
*******************************



****************************
PROCEDURE PRV_TRL
****************************

CLEAR
CLOSE ALL


SET COLOR TO 7/1


STORE 0 TO DRTOT, CRTOT, TCR, TDR, LINE
STORE DATE() TO MTDATE

CLEAR

@ 8, 15 SAY 'Enter the date for Previous Trial Balance' GET MTDATE
READ

IF READKEY()=12
   CLOSE ALL
   CLEAR
   RETURN
ENDIF

CLEAR

@ 13, 23 SAY 'Please wait - Calculations in progress ...'

SELECT 2
USE ldgrcode
COPY TO mldgr
USE mldgr EXCL
INDEX ON STR(C1,2)+STR(C2,2)+STR(C3,3) TAG mac2
SET ORDER TO mac2
REPLACE ALL LDGR_BAL WITH 0, STATUS WITH '  '
REPLACE ALL LDGR_BAL WITH OPEN_BAL, STATUS WITH OPEN_STAT
GOTO TOP

SELECT 1
USE tran
COPY TO mtran FOR DATE<=MTDATE
USE mtran
REPLACE ALL FLAG WITH ' '
CLOSE ALL
SET DATE brit
HEADING= .T.
STORE DATE() TO MPDATE
SELECT 1
USE mtran
INDEX ON DATE TAG trandate ADDITIVE
GOTO BOTTOM
SELECT 2
USE mldgr ORDER mac2
SELECT 3
USE master
COPY TO mmast STRUCTURE
USE mmast
STORE 0 TO MDB_CODE, MCR_CODE, WSRNO, WRECNO, MSRNO, WAMOUNT, MAMOUNT, Q
MVOUCH_NO= SPACE(8)
MDISC= SPACE(30)
MDATE= DATE()
STORE '  ' TO ST, RST
SELECT 1
SET FILTER TO FLAG=' '
GOTO TOP
R= 2
DO WHILE .not. EOF()
   SELECT 1
   STORE STR(C1,2)+STR(C2,2)+STR(C3,3) TO MCODE
   SELECT 2
   SEEK MCODE
   IF .not. FOUND()
      IF HEADING
         @ R, 10 SAY 'The Following Account Codes Do Not Exist In Code File'
         R= R+1
         @ R, 10 SAY 'These Account Codes Were Probably Deleted Before Data Posting'
         R= R+1
         @ R, 10 SAY 'Please Correct Your Vouchers Or Create Missing Ledger Heads'
         R= R+1
         @ R, 10 SAY 'Before Data Posting'
         R= R+1
         @ R, 1 TO R, 78
         R= R+1
         @ R, 1 SAY 'Voucher No'
         @ R, 13 SAY 'Voucher Type'
         @ R, 28 SAY 'Account Code'
         R= R+1
         @ R, 1 TO R, 78
         HEADING= .F.
      ENDIF
      SELECT 1
      R= R+1
      @ R, 1 SAY VCH_NO
      @ R, 18 SAY VCH_TYPE
      @ R, 28 SAY C1
      @ R, 30 SAY '-'
      @ R, 31 SAY C2
      @ R, 33 SAY '-'
      @ R, 34 SAY C3
      Q= 21
   ENDIF
   IF R>=21
      WAIT
      CLEAR
      R= 2
      HEADING= .T.
   ENDIF
   SELECT 1
   SKIP
ENDDO
IF EOF().and.Q=21
   @ 24, 5 SAY 'Vouchers Not Posted --- Press Any Key To Return to Menu '
   WAIT ''
   CLEAR
   CLOSE DATA
   RETURN
ENDIF
SELECT 1
GOTO TOP
DO WHILE .not. EOF()
   DO chk IN tbl_proc.prg
   IF FLAG='Y'
      SKIP
      LOOP
   ENDIF
   IF DR_CR='DR'
      MDR_AMOUNT= AMOUNT
      MCR_AMOUNT= 0
   ELSE
      MCR_AMOUNT= AMOUNT
      MDR_AMOUNT= 0
   ENDIF
   MDATE= DATE
   MC1= C1
   MC2= C2
   MC3= C3
   MVCH_TYPE= VCH_TYPE
   MVCH_NO1= VCH_NO1
   MVCH_NO2= VCH_NO2
   MDISC= DESCRIP
   SELECT 2
   SEEK STR(MC1,2)+STR(MC2,2)+STR(MC3,3)
   IF FOUND()
      WSRNO= SR_NO+1
      IF  B->STATUS='  '
         IF MDR_AMOUNT>0
            WAMOUNT= MDR_AMOUNT
            ST= 'DR'
         ELSE
            WAMOUNT= MCR_AMOUNT
            ST= 'CR'
         ENDIF
      ENDIF
      IF  B->STATUS='DR'
         IF MDR_AMOUNT>0
            WAMOUNT= LDGR_BAL+MDR_AMOUNT
            ST= 'DR'
         ELSE
            WAMOUNT= LDGR_BAL-MCR_AMOUNT
            IF WAMOUNT>0
               ST= 'DR'
            ELSE
               ST= 'CR'
            ENDIF
         ENDIF
      ENDIF
      IF  B->STATUS='CR'
         IF MCR_AMOUNT>0
            WAMOUNT= LDGR_BAL+MCR_AMOUNT
            ST= 'CR'
         ELSE
            WAMOUNT= LDGR_BAL-MDR_AMOUNT
            IF WAMOUNT>0
               ST= 'CR'
            ELSE
               ST= 'DR'
            ENDIF
         ENDIF
      ENDIF
      REPLACE LDGR_BAL WITH ABS(WAMOUNT)
      REPLACE SR_NO WITH WSRNO
      REPLACE B->STATUS WITH ST
   ENDIF
   SELECT 3
   APPEND BLANK
   REPLACE DATE WITH MDATE
   REPLACE C1 WITH MC1, C2 WITH MC2, C3 WITH MC3
   REPLACE BL_AMOUNT WITH ABS(WAMOUNT)
   IF MDR_AMOUNT>0
      REPLACE DR_AMOUNT WITH MDR_AMOUNT
   ELSE
      REPLACE CR_AMOUNT WITH MCR_AMOUNT
   ENDIF
   REPLACE DESC WITH MDISC
   REPLACE VCH_TYPE WITH MVCH_TYPE
   REPLACE VCH_NO1 WITH MVCH_NO1, SR_NO WITH WSRNO
   REPLACE C->STATUS WITH ST, VCH_NO2 WITH MVCH_NO2
   WSRNO= 0
   SELECT 1
   REPLACE FLAG WITH 'Y'
   SKIP
ENDDO
SELECT 3
INDEX ON STR(C1,2)+STR(C2,2)+STR(C3,3) TAG ac1 ADDITIVE
CLOSE ALL
CLEAR
STORE 0 TO DRTOT, CRTOT, TCR, TDR, LINE
CLEAR
@ 2, 2 SAY 'Subsideries Trial Balance '
ZEROBAL= ' '
DO WHILE .not. ZEROBAL$'YN'
   @ 4, 2 SAY 'Do You Want To Include Ledger Heads Having Zero Balance - Y/N ' GET ZEROBAL FUNCTION '!'
   READ
ENDDO
@ 4, 2 SAY SPACE(70)
ANS= ' '
DO WHILE .not. ANS$'PSQ'
   @ 4, 2 SAY 'Printer/Screen/Quit -  P/S/Q ' GET ANS FUNCTION '!'
   READ
ENDDO
IF ANS='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
CLEAR
USE mldgr ORDER mac2

STORE 0 TO MCODE, WRECNO, MSRNO, WCODE
PAGE= 1
HEADING= .T.
IF ANS='P'
   CLEAR
   @ 8, 17 SAY 'Previous Trial Balance Printing'
   @ 10, 17 SAY 'Please use 80 column (10 inches wide) continous'
   @ 11, 17 SAY 'printer paper and set Top Of Form'
   @ 12, 17 SAY 'Press ENTER when ready...........'
   WAIT ''
   CLEAR
   PANS= ' '
   DO prnchk IN tbl_proc.prg
   IF PANS='Q'
      CLOSE ALL
      CLEAR
      RETURN
   ENDIF
   @ 11, 20 SAY 'Please wait ... Printing in progress '
   SET PRINTER ON
   SET DEVICE TO PRINTER
ENDIF
GOTO TOP
WCODE= 0
CLEAR
DO WHILE .not. EOF()
   IF ZEROBAL='N'
      IF LDGR_BAL=0
         SKIP
         LOOP
      ENDIF
   ENDIF
   IF HEADING
      IF ANS='S'
         DO screen IN tbl_proc.prg
         @ 2, 20 SAY 'TRIAL  BALANCE  AS  ON: '
      ENDIF
      IF ANS='P'
         DO PRNCHK IN tbl_proc.prg
         DO top_prt1 IN tbl_proc.prg
         @ 2, 23 SAY 'TRIAL BALANCE AS ON: '
      ENDIF
      @ 2, 44 SAY MTDATE
      @ 2, 72 SAY 'PAGE: '
      @ 2, 78 SAY PAGE PICTURE '99'
      @ 3, 1 SAY REPLICATE('-',79)
      @ 4, 1 SAY 'CODE-----'
      @ 4, 11 SAY '   ---- ACCOUNT  TITLE ----'
      @ 4, 57 SAY 'D E B I T'
      @ 4, 69 SAY 'C R E D I T'
      @ 5, 1 SAY REPLICATE('-',79)
      LINE= 6
      HEADING= .F.
   ENDIF
   IF EOF()
      EXIT
   ENDIF
   STORE SPACE(30) TO WTITLE
   STORE TITLE TO WTITLE
   IF C3=0
      IF ZEROBAL='N'
         IF LDGR_BAL=0
            SKIP
            LOOP
         ENDIF
      ENDIF
      LINE= LINE+1
      MPC1= REPLICATE('0',2-LEN(LTRIM(STR(C1))))+LTRIM(STR(C1))
      @ LINE, 1 SAY MPC1
      @ LINE, 3 SAY '-'
      MPC2= REPLICATE('0',2-LEN(LTRIM(STR(C2))))+LTRIM(STR(C2))
      @ LINE, 4 SAY MPC2
      @ LINE, 6 SAY '-'
      MPC3= REPLICATE('0',3-LEN(LTRIM(STR(C3))))+LTRIM(STR(C3))
      @ LINE, 7 SAY MPC3
      @ LINE, 14 SAY TITLE
      MLEN= LEN(RTRIM(TITLE))
      LINE= LINE+1
      @ LINE, 1 SAY REPLICATE('-',15+MLEN)
      LINE= LINE+1
      SKIP
      IF ANS='S'.and.LINE>21
         IF EOF()
            EXIT
         ENDIF
         XYZ= ' '
         DO WHILE .not. XYZ$'CQ'
            SET CONFIRM OFF
            @ 23, 57 SAY 'Continue/Quit - C/Q' GET XYZ FUNCTION '!'
            READ
         ENDDO
         IF XYZ='Q'
            CLEAR
            CLOSE ALL
            RETURN
         ENDIF
         CLEAR
         PAGE= PAGE+1
         HEADING= .T.
      ENDIF
      IF ANS='P'.and.LINE>=56
         PAGE= PAGE+1
         HEADING= .T.
      ENDIF
      LOOP
   ENDIF
   MPC1= REPLICATE('0',2-LEN(LTRIM(STR(C1))))+LTRIM(STR(C1))
   @ LINE, 3 SAY MPC1
   @ LINE, 5 SAY '-'
   MPC2= REPLICATE('0',2-LEN(LTRIM(STR(C2))))+LTRIM(STR(C2))
   @ LINE, 6 SAY MPC2
   @ LINE, 8 SAY '-'
   MPC3= REPLICATE('0',3-LEN(LTRIM(STR(C3))))+LTRIM(STR(C3))
   @ LINE, 9 SAY MPC3
   @ LINE, 16 SAY WTITLE
   COL= IIF(STATUS='DR',54,63)
   @ LINE, COL SAY ABS(LDGR_BAL) PICTURE '9,999,999,999.99'
   IF COL=54
      DRTOT= DRTOT+LDGR_BAL
   ELSE
      CRTOT= CRTOT+LDGR_BAL
   ENDIF
   LINE= LINE+1
   IF .not. EOF()
      SKIP
   ENDIF
   IF ANS='S'.and.LINE>21
      IF EOF()
         EXIT
      ENDIF
      XYZ= ' '
      DO WHILE .not. XYZ$'CQ'
         SET CONFIRM OFF
         @ 23, 57 SAY 'Continue/Quit - C/Q' GET XYZ FUNCTION '!'
         READ
      ENDDO
      IF XYZ='Q'
         CLEAR
         CLOSE ALL
         RETURN
      ENDIF
      CLEAR
      PAGE= PAGE+1
      HEADING= .T.
   ENDIF
   IF ANS='P'.and.LINE>=56
      PAGE= PAGE+1
      HEADING= .T.
   ENDIF
ENDDO
IF ANS='S'.and.LINE>21
   LINE= LINE-1
ENDIF
LINE= LINE+1
@ LINE, 1 SAY REPLICATE('-',79)
LINE= LINE+1
@ LINE, 10 SAY '        T O T A L S :'
@ LINE, 51 SAY DRTOT PICTURE '9999999,999.99'
@ LINE, 65 SAY CRTOT PICTURE '9999999,999.99'
LINE= LINE+1
@ LINE, 1 SAY REPLICATE('-',79)
IF ANS='S'
   @ 24, 7 SAY 'End of Screen Printing  -  Press any key to return to menu.... '
   WAIT ''
ENDIF
IF ANS='P'
   EJECT
   SET PRINTER OFF
   SET DEVICE TO SCREEN
ENDIF
CLEAR
SET FILTER TO
CLOSE ALL
RUN del mldgr.dbf
RUN del mtran.dbf
RUN del mmast.dbf

RETURN
***********************

************************
PROCEDURE PRV_TRL2
************************

CLEAR
CLOSE ALL

IF _DOS
SET COLOR TO 7/1
ENDIF

CLEAR
STORE 0 TO DRTOT, CRTOT, TCR, TDR, LINE
P= ' '
DO WHILE .not. P$'PSQ'
   @ 3, 2 SAY 'Printer/Screen/Quit  -  P/S/Q  ' GET P FUNCTION '!'
   READ
ENDDO
IF P='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
CLEAR
STORE DATE() TO MTDATE
CLEAR
@ 8, 15 SAY 'Enter the date of Previous Trail ' GET MTDATE
READ
IF P='P'
   CLEAR
   PANS= ' '
   DO prnchk IN tbl_proc.prg
   IF PANS='Q'
      CLOSE ALL
      CLEAR
      RETURN
   ENDIF
   @ 11, 20 SAY 'Please wait ... Printing in progress '
   SET PRINTER ON
   SET DEVICE TO PRINTER
ELSE
   SET DEVICE TO SCREEN
ENDIF
SELECT 2
USE ldgrcode ORDER ac1

SELECT 1
USE master ORDER ac2

SET FILTER TO DATE<=MTDATE
GOTO TOP
MCODE= 0
HEADING= .T.
PAGE= 1
STORE 0 TO WRECNO, MSRNO, WCODE, AMT1, AMT2
GOTO TOP
WCODE= 0
CLEAR
DO WHILE .not. EOF()
   IF DR_AMOUNT=0.and.CR_AMOUNT=0.and.BL_AMOUNT=0
      SKIP
      LOOP
   ENDIF
   IF HEADING
      IF P='P'
         DO PRNCHK IN tbl_proc.prg
         DO top_prt1 IN tbl_proc.prg
      ELSE
         DO screen IN tbl_proc.prg
      ENDIF
      @ 2, 20 SAY 'TRIAL  BALANCE  AS  ON: '
      @ 2, 44 SAY MTDATE
      @ 2, 72 SAY 'PAGE: '
      @ 2, 78 SAY PAGE PICTURE '99'
      @ 3, 1 SAY REPLICATE('-',79)
      @ 4, 1 SAY 'CODE-----'
      @ 4, 11 SAY '   ---- ACCOUNT  TITLE ----'
      @ 4, 57 SAY 'D E B I T'
      @ 4, 69 SAY 'C R E D I T'
      @ 5, 1 SAY REPLICATE('-',79)
      LINE= 6
      HEADING= .F.
   ENDIF
   IF EOF()
      EXIT
   ENDIF
   IF C3=0
      SKIP
      LOOP
   ENDIF
   STORE STR(C1,2)+STR(C2,2)+STR(C3,3) TO MCODE
   STORE C1 TO MC1
   STORE C2 TO MC2
   STORE C3 TO MC3
   STORE 0 TO DRTOT, CRTOT, AMT
   DO WHILE C1=MC1.and.C2=MC2.and.C3=MC3
      IF SR_NO=1.and.STATUS='DR'
         DRTOT= DRTOT+BL_AMOUNT
         SKIP
         LOOP
      ENDIF
      IF SR_NO=1.and.STATUS='CR'
         CRTOT= CRTOT+BL_AMOUNT
         SKIP
         LOOP
      ENDIF
      IF CR_AMOUNT=0
         DRTOT= DRTOT+DR_AMOUNT
      ENDIF
      IF DR_AMOUNT=0
         CRTOT= CRTOT+CR_AMOUNT
      ENDIF
      SKIP
   ENDDO
   AMT= DRTOT-CRTOT
   SELECT 2
   SEEK MCODE
   IF FOUND()
      STORE SPACE(30) TO WTITLE
      STORE TITLE TO WTITLE
   ENDIF
   SELECT 1
   MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MC1))))+LTRIM(STR(MC1))
   @ LINE, 1 SAY MPC1
   @ LINE, 3 SAY '-'
   MPC2= REPLICATE('0',2-LEN(LTRIM(STR(MC2))))+LTRIM(STR(MC2))
   @ LINE, 4 SAY MPC2
   @ LINE, 6 SAY '-'
   MPC3= REPLICATE('0',3-LEN(LTRIM(STR(MC3))))+LTRIM(STR(MC3))
   @ LINE, 7 SAY MPC3
   @ LINE, 14 SAY WTITLE
   IF DRTOT>CRTOT
      @ LINE, 53 SAY ABS(AMT)
      AMT1= AMT1+ABS(AMT)
   ENDIF
   IF CRTOT>DRTOT
      @ LINE, 67 SAY ABS(AMT)
      AMT2= AMT2+ABS(AMT)
   ENDIF
   LINE= LINE+1
   IF P='P'
      IF LINE>54
         PAGE= PAGE+1
         HEADING= .T.
         EJECT
      ENDIF
   ELSE
      IF LINE>20
         PAGE= PAGE+1
         HEADING= .T.
         ANS= ' '
         DO WHILE .not. ANS$'CQ'
            SET CONFIRM OFF
            @ 23, 50 SAY 'Continue/Quit  -  C/Q  ' GET ANS FUNCTION '!'
            READ
         ENDDO
         CLEAR
         IF ANS='Q'
            CLOSE ALL
            CLEAR
            RETURN
         ENDIF
      ENDIF
   ENDIF
ENDDO
LINE= LINE+1
@ LINE, 1 SAY REPLICATE('-',79)
LINE= LINE+1
@ LINE, 10 SAY '        T O T A L S :'
@ LINE, 51 SAY AMT1 PICTURE '9999999,999.99'
@ LINE, 66 SAY AMT2 PICTURE '9999999,999.99'
LINE= LINE+1
@ LINE, 1 SAY REPLICATE('-',79)
IF P='P'
   SET DEVICE TO SCREEN
   EJECT
ELSE
   @ 23, 1 SAY ''
   WAIT '       End Of Screen Display     Press Any Key To Go Back ... '
ENDIF
CLOSE ALL

RETURN
*********************

*************************
PROCEDURE DATE_TRL
*************************

CLEAR
CLOSE ALL

IF _DOS
SET COLOR TO 7/1
ENDIF

CLEAR
STORE 0 TO DRTOT, CRTOT, TCR, TDR, LINE
STORE 0 TO AMT1, AMT2
@ 5, 25 SAY 'Trial Balance Between Two Dates '
STORE DATE() TO DD1, DD2
@ 10, 25 SAY 'From Date ' GET DD1
@ 12, 25 SAY 'To   Date ' GET DD2
READ
P= ' '
DO WHILE .not. P$'PSQ'
   @ 23, 45 SAY 'Printer/Screen/Quit  -  P/S/Q  ' GET P FUNCTION '!'
   READ
ENDDO
IF P='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
IF P='P'
   CLEAR
   PANS= ' '
   DO prnchk IN tbl_proc.prg
   IF PANS='Q'
      CLOSE ALL
      CLEAR
      RETURN
   ENDIF
   @ 11, 20 SAY 'Please wait ... Printing in progress '
   SET PRINTER ON
   SET DEVICE TO PRINTER
ELSE
   SET DEVICE TO SCREEN
ENDIF
SELECT 2
USE ldgrcode ORDER ac1

SELECT 1
USE master ORDER ac2

COPY TO trl-work FOR DATE>=DD1.and.DATE<=DD2
MCODE= 0
HEADING= .T.
PAGE= 1
WRECNO= 0
MSRNO= 0
WCODE= 0
GOTO TOP
WCODE= 0
CLEAR
SELECT 1
USE trl-work
INDEX ON STR(C1,2)+STR(C2,2)+STR(C3,3) TAG trl_idx ADDITIVE
DO WHILE .not. EOF()
   IF DR_AMOUNT=0.and.CR_AMOUNT=0.and.BL_AMOUNT=0
      SKIP
      LOOP
   ENDIF
   IF HEADING
      IF P='P'
         DO PRNCHK IN tbl_proc.prg
         DO top_prt1 IN tbl_proc.prg
      ELSE
         DO screen IN tbl_proc.prg
      ENDIF
      @ 2, 20 SAY 'TRIAL  BALANCE  BETWEEN  TWO  DATES '
      @ 3, 20 SAY 'From :'
      @ 3, 28 SAY DD1
      @ 3, 40 SAY 'To :'
      @ 3, 45 SAY DD2
      @ 3, 70 SAY 'PAGE : '
      @ 3, 76 SAY PAGE PICTURE '99'
      @ 4, 1 SAY REPLICATE('-',79)
      @ 5, 1 SAY 'CODE-----'
      @ 5, 11 SAY '   ---- ACCOUNT  TITLE ----'
      @ 5, 57 SAY 'D E B I T'
      @ 5, 69 SAY 'C R E D I T'
      @ 6, 1 SAY REPLICATE('-',79)
      LINE= 7
      HEADING= .F.
   ENDIF
   IF EOF()
      EXIT
   ENDIF
   IF C3=0
      SKIP
      LOOP
   ENDIF
   STORE STR(C1,2)+STR(C2,2)+STR(C3,3) TO MCODE
   STORE C1 TO MC1
   STORE C2 TO MC2
   STORE C3 TO MC3
   STORE 0 TO DRTOT, CRTOT
   DO WHILE C1=MC1.and.C2=MC2.and.C3=MC3
      IF CR_AMOUNT=0
         DRTOT= DRTOT+DR_AMOUNT
      ENDIF
      IF DR_AMOUNT=0
         CRTOT= CRTOT+CR_AMOUNT
      ENDIF
      SKIP
   ENDDO
   SELECT 2
   SEEK MCODE
   IF FOUND()
      STORE TITLE TO WTITLE
   ENDIF
   SELECT 1
   MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MC1))))+LTRIM(STR(MC1))
   @ LINE, 1 SAY MPC1
   @ LINE, 3 SAY '-'
   MPC2= REPLICATE('0',2-LEN(LTRIM(STR(MC2))))+LTRIM(STR(MC2))
   @ LINE, 4 SAY MPC2
   @ LINE, 6 SAY '-'
   MPC3= REPLICATE('0',3-LEN(LTRIM(STR(MC3))))+LTRIM(STR(MC3))
   @ LINE, 7 SAY MPC3
   @ LINE, 14 SAY WTITLE
   AMT= 0
   AMT= DRTOT-CRTOT
   IF DRTOT>CRTOT
      @ LINE, 54 SAY ABS(AMT) PICTURE '9,999,999,999.99'
      AMT1= AMT1+ABS(AMT)
   ENDIF
   IF CRTOT>DRTOT
      @ LINE, 62 SAY ABS(AMT) PICTURE '9,999,999,999.99'
      AMT2= AMT2+ABS(AMT)
   ENDIF
   LINE= LINE+1
   IF P='P'
      IF LINE>54
         PAGE= PAGE+1
         HEADING= .T.
         EJECT
      ENDIF
   ELSE
      IF LINE>20
         PAGE= PAGE+1
         HEADING= .T.
         ANS= ' '
         DO WHILE .not. ANS$'CQ'
            SET CONFIRM OFF
            @ 23, 50 SAY 'Continue/Quit  -  C/Q  ' GET ANS FUNCTION '!'
            READ
         ENDDO
         CLEAR
         IF ANS='Q'
            CLOSE ALL
            CLEAR
            RETURN
         ENDIF
      ENDIF
   ENDIF
ENDDO
LINE= LINE+1
@ LINE, 1 SAY REPLICATE('-',79)
LINE= LINE+1
@ LINE, 10 SAY '        T O T A L S :'
@ LINE, 53 SAY AMT1 PICTURE '9999999999.99'
@ LINE, 67 SAY AMT2 PICTURE '9999999999.99'
LINE= LINE+1
@ LINE, 1 SAY REPLICATE('-',79)
IF P='P'
   SET PRINTER OFF
   SET DEVICE TO SCREEN
   EJECT
ELSE
   @ 23, 1 SAY ''
   WAIT '       End Of Screen Display     Press Any Key To Go Back ... '
ENDIF
CLOSE ALL
RUN del trl-work.dbf

RETURN
*****************************

*************************
PROCEDURE UTRL_ENT
*************************


CLEAR
CLOSE ALL
SELECT 1
USE ldgrcode ORDER ac1
SELECT 2
USE trl-ref ORDER trl_idx
DO WHILE .T.
   @ 23, 50 SAY 'Press Ctrl Q To Quit '
   @ 2, 10 SAY 'Adding Ledgerheads To This Report  '
   STORE SPACE(30) TO MTITLE
   STORE 0 TO MC1, MC2, MC3
   @ 23, 50 SAY 'Press Ctrl Q To Quit '
   @ 10, 10 SAY 'T i t l e '
   @ 12, 10 GET MTITLE
   READ
   IF READKEY()=12
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
   @ 23, 45 CLEAR TO 23, 78
   DO WHILE .T.
      @ 23, 50 SAY 'Press Ctrl Q To Quit '
      @ 14, 10 SAY 'Ledger Heads Codes '

IF _DOS
      SET COLOR TO /w
ENDIF

      @ 16, 10 SAY '  -  -   '

IF _DOS
      SET COLOR TO 
ENDIF

      @ 16, 10 GET MC1 PICTURE '99'
      @ 16, 13 GET MC2 PICTURE '99'
      @ 16, 16 GET MC3 PICTURE '999'
      READ
      IF READKEY()=12
         CLEAR
         CLOSE ALL
         RETURN
      ENDIF
      @ 23, 45 CLEAR TO 23, 78
      MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MC1))))+LTRIM(STR(MC1))
      MPC2= REPLICATE('0',2-LEN(LTRIM(STR(MC2))))+LTRIM(STR(MC2))
      MPC3= REPLICATE('0',3-LEN(LTRIM(STR(MC3))))+LTRIM(STR(MC3))

IF _DOS
      SET COLOR TO /w
ENDIF

      @ 16, 10 SAY MPC1 PICTURE '99'
      @ 16, 13 SAY MPC2 PICTURE '99'
      @ 16, 16 SAY MPC3 PICTURE '999'

IF _DOS
      SET COLOR TO 
ENDIF

      SELECT 1
      SEEK STR(MC1,2)+STR(MC2,2)+STR(MC3,3)
      IF .not. FOUND()
         @ 23, 15 SAY 'This Code Does Not Exists .. Please Re-try '
         WAIT ''
         @ 22, 10 CLEAR TO 23, 79
         LOOP
      ENDIF
      SELECT 2
      SEEK STR(MC1,2)+STR(MC2,2)+STR(MC3,3)
      IF FOUND()
         @ 23, 10 SAY 'This Code Already Exists In Reference File .. Please Re-try '
         WAIT ''
         @ 22, 9 CLEAR TO 23, 79
         LOOP
      ENDIF
      SELECT 1

IF _DOS
      SET COLOR TO /w
ENDIF

      @ 16, 20 SAY TITLE

IF _DOS
      SET COLOR TO 
ENDIF

      ANS= ' '
      DO WHILE .not. ANS$'YN'
         @ 23, 25 SAY 'Any Correction - Y/N ' GET ANS FUNCTION '!'
         READ
      ENDDO
      @ 23, 1 CLEAR TO 23, 79
      IF ANS='Y'
         LOOP
      ENDIF
      SELECT 2
      APPEND BLANK
      REPLACE C1 WITH MC1
      REPLACE C2 WITH MC2
      REPLACE C3 WITH MC3, TITLE WITH MTITLE
      ANS= ' '
      DO WHILE .not. ANS$'YN'
         @ 23, 22 SAY 'More Ledgerheads For This Title - Y/N ' GET ANS FUNCTION '!'
         READ
      ENDDO
      @ 23, 1 CLEAR TO 23, 79
      IF ANS='N'
         EXIT
      ENDIF
      @ 14, 1 CLEAR TO 24, 79
      STORE 0 TO MC1, MC2, MC3
   ENDDO
   ANS= ' '
   DO WHILE .not. ANS$'YN'
      @ 23, 25 SAY 'More Ledgerheads - Y/N ' GET ANS FUNCTION '!'
      READ
   ENDDO
   @ 23, 1 CLEAR TO 23, 79
   IF ANS='N'
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
   CLEAR
ENDDO


RETURN
***************************


****************************
PROCEDURE UTRL_DEL
****************************

CLEAR
CLOSE ALL
SET DELETED ON
SELECT 1
USE ldgrcode ORDER ac1
SELECT 2
USE trl-ref ORDER trl_idx
DO WHILE .T.
   @ 23, 50 SAY 'Press Ctrl Q To Quit '
   @ 2, 10 SAY 'Delete Ledgerheads To This Report  '
   STORE SPACE(30) TO MTITLE
   STORE 0 TO MC1, MC2, MC3
   @ 23, 50 SAY 'Press Ctrl Q To Quit '
   @ 10, 10 SAY 'T i t l e '
   @ 12, 10 GET MTITLE
   READ
   IF READKEY()=12
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
   @ 23, 45 CLEAR TO 23, 78
   @ 23, 50 SAY 'Press Ctrl Q To Quit '
   @ 14, 10 SAY 'Ledger Heads Codes '

IF _DOS
   SET COLOR TO /w
ENDIF

   @ 16, 10 SAY '  -  -   '

IF _DOS
   SET COLOR TO 
ENDIF

   @ 16, 10 GET MC1 PICTURE '99'
   @ 16, 13 GET MC2 PICTURE '99'
   @ 16, 16 GET MC3 PICTURE '999'
   READ
   IF READKEY()=12
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
   @ 23, 45 CLEAR TO 23, 78
   MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MC1))))+LTRIM(STR(MC1))
   MPC2= REPLICATE('0',2-LEN(LTRIM(STR(MC2))))+LTRIM(STR(MC2))
   MPC3= REPLICATE('0',3-LEN(LTRIM(STR(MC3))))+LTRIM(STR(MC3))

IF _DOS
   SET COLOR TO /w
ENDIF

   @ 16, 10 SAY MPC1 PICTURE '99'
   @ 16, 13 SAY MPC2 PICTURE '99'
   @ 16, 16 SAY MPC3 PICTURE '999'

IF _DOS
   SET COLOR TO 
ENDIF

   SELECT 1
   SEEK STR(MC1,2)+STR(MC2,2)+STR(MC3,3)
   IF .not. FOUND()
      @ 23, 15 SAY 'This Code Does Not Exists .. Please Re-try '
      WAIT ''
      @ 22, 10 CLEAR TO 23, 79
      LOOP
   ENDIF
   SELECT 2
   SEEK STR(MC1,2)+STR(MC2,2)+STR(MC3,3)
   IF .not. FOUND()
      @ 23, 10 SAY 'This Code Does Not Exists In Reference File .. Please Re-try '
      WAIT ''
      @ 22, 9 CLEAR TO 23, 79
      LOOP
   ENDIF
   SELECT 1

IF _DOS
   SET COLOR TO /w
ENDIF

   @ 16, 20 SAY TITLE

IF _DOS
   SET COLOR TO 
ENDIF

   ANS= ' '
   DO WHILE .not. ANS$'YN'
      @ 23, 25 SAY 'Are You Sure - Y/N ' GET ANS FUNCTION '!'
      READ
   ENDDO
   @ 23, 1 CLEAR TO 23, 79
   IF ANS='Y'
      SELECT 2
      DELETE
   ENDIF
   ANS= ' '
   DO WHILE .not. ANS$'YN'
      @ 23, 25 SAY 'More Data Deletion - Y/N ' GET ANS FUNCTION '!'
      READ
   ENDDO
   @ 23, 1 CLEAR TO 23, 79
   IF ANS='N'
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
   CLEAR
ENDDO

RETURN
***************************

*********************
PROCEDURE UTRL_PRT
*********************

CLEAR
CLOSE ALL

IF _DOS
SET COLOR TO 7/1
ENDIF

CLEAR
USE master ORDER mastdate

GOTO BOTTOM
STORE DATE TO MTDATE
CLEAR
@ 3, 5 SAY 'Your last posted voucher is dated '
@ 3, 42 SAY MTDATE
@ 4, 5 SAY 'Do you want to dispaly same date on your Trial Balance'
@ 5, 5 SAY 'Or enter the date you want to dispaly  ' GET MTDATE
READ
CLEAR
CLOSE ALL
SELECT 1
USE ldgrcode ORDER ac1
SELECT 2
USE trl-ref ORDER trl-idx
ANS= ' '
DO WHILE .not. ANS$'PSQ'
   @ 4, 2 SAY 'Printer/Screen/Quit -  P/S/Q ' GET ANS FUNCTION '!'
   READ
ENDDO
IF ANS='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
CLEAR
STORE 0 TO DRTOT, CRTOT, TCR, TDR, LINE
STORE 0 TO MCODE, WRECNO, MSRNO, WCODE, MNO
IF ANS='P'
   CLEAR
   @ 8, 17 SAY 'Subsideries Trial Balance Printing'
   @ 10, 17 SAY 'Please use 80 column (10 inches wide) continous'
   @ 11, 17 SAY 'printer paper and set Top Of Form'
   @ 12, 17 SAY 'Press ENTER when ready...........'
   WAIT ''
   PANS= ' '
   DO prnchk IN tbl_proc.prg
   IF PANS='Q'
      CLOSE ALL
      CLEAR
      RETURN
   ENDIF
   @ 11, 20 SAY 'Please wait ... Printing in progress '
   SET PRINTER ON
   SET DEVICE TO PRINTER
ENDIF
PAGE= 1
HEADING= .T.
WCODE= 0
CLEAR
SELECT 2
DO WHILE .not. EOF()
   IF HEADING
      IF ANS='S'
         DO screen IN tbl_proc.prg
         @ 2, 20 SAY 'TRIAL  BALANCE  AS  ON: '
      ENDIF
      IF ANS='P'
         DO PRNCHK IN tbl_proc.prg
         DO top_prt1 IN tbl_proc.prg
         @ 2, 23 SAY 'TRIAL BALANCE AS ON: '
      ENDIF
      @ 2, 44 SAY MTDATE
      @ 2, 72 SAY 'PAGE: '
      @ 2, 78 SAY PAGE PICTURE '99'
      @ 3, 1 SAY REPLICATE('-',79)
      @ 4, 1 SAY '   ---- ACCOUNT  TITLE ----'
      @ 4, 55 SAY 'D E B I T'
      @ 4, 69 SAY 'C R E D I T'
      @ 5, 1 SAY REPLICATE('-',79)
      LINE= 6
      HEADING= .F.
   ENDIF
   STORE 0 TO MDR, MCR
   MTITLE= TITLE
   DO WHILE TITLE=MTITLE
      IF TITLE<>MTITLE
         EXIT
      ENDIF
      MC1= C1
      MC2= C2
      MC3= C3
      SELECT 1
      SEEK STR(MC1,2)+STR(MC2,2)+STR(MC3,3)
      IF FOUND()
         IF STATUS='DR'
            MDR= MDR+LDGR_BAL
            DRTOT= DRTOT+LDGR_BAL
         ELSE
            MCR= MCR+LDGR_BAL
            CRTOT= CRTOT+LDGR_BAL
         ENDIF
      ENDIF
      SELECT 2
      SKIP
   ENDDO
   @ LINE, 5 SAY MTITLE
   IF MDR<>0
      @ LINE, 48 SAY MDR PICTURE '9,999,999,999.99'
   ENDIF
   IF MCR<>0
      @ LINE, 63 SAY MCR PICTURE '9,999,999,999.99'
   ENDIF
   LINE= LINE+1
   IF ANS='S'.and.LINE>21
      XYZ= ' '
      DO WHILE .not. XYZ$'CQ'
         @ 23, 57 SAY 'Continue/Quit - C/Q' GET XYZ FUNCTION '!'
         READ
      ENDDO
      IF XYZ='Q'
         CLEAR
         CLOSE ALL
         RETURN
      ENDIF
      CLEAR
      PAGE= PAGE+1
      HEADING= .T.
   ENDIF
   IF ANS='P'.and.LINE>=56
      PAGE= PAGE+1
      HEADING= .T.
   ENDIF
ENDDO
@ LINE, 1 SAY REPLICATE('-',79)
LINE= LINE+1
@ LINE, 10 SAY '        T O T A L S :'
@ LINE, 50 SAY DRTOT PICTURE '9999999,999.99'
@ LINE, 66 SAY CRTOT PICTURE '9999999,999.99'
IF ANS='S'
   @ 24, 7 SAY 'End of Screen Printing  -  Press any key to return to menu.... '
   WAIT ''
ENDIF
IF ANS='P'
   EJECT
   SET PRINTER OFF
   SET DEVICE TO SCREEN
ENDIF
CLEAR
SET FILTER TO
CLOSE ALL

RETURN
********************************


************************
PROCEDURE C3_TRL
************************


CLEAR
CLOSE ALL

IF _DOS
SET COLOR TO 7/1
ENDIF

CLEAR
STORE 0 TO DRTOT, CRTOT, TCR, TDR, LINE
@ 2, 2 SAY 'Subsideries Trial Balance '
ZEROBAL= ' '
DO WHILE .not. ZEROBAL$'YN'
   @ 4, 2 SAY 'Do You Want To Include Ledger Heads Having Zero Balance - Y/N ' GET ZEROBAL FUNCTION '!'
   READ
ENDDO
@ 4, 2 SAY SPACE(70)
ANS= ' '
DO WHILE .not. ANS$'PSQ'
   @ 4, 2 SAY 'Printer/Screen/Quit -  P/S/Q ' GET ANS FUNCTION '!'
   READ
ENDDO
IF ANS='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
CLEAR
USE master ORDER mastdate

GOTO BOTTOM
STORE DATE TO MTDATE
CLEAR
@ 3, 5 SAY 'Your last posted voucher is dated '
@ 3, 42 SAY MTDATE
@ 4, 5 SAY 'Do you want to dispaly same date on your Trial Balance'
@ 5, 5 SAY 'Or enter the date you want to dispaly  ' GET MTDATE
READ
GOTO TOP
USE ldgrcode ORDER ac1

STORE 0 TO MCODE, WRECNO, MSRNO, WCODE, MNO
CLEAR
IF ZEROBAL='N'
   TIT= ' '
   DO WHILE .not. TIT$'YN'
      @ 4, 2 SAY 'Report With Control Heads - Y/N ' GET TIT FUNCTION '!'
      READ
   ENDDO
   @ 4, 2 SAY SPACE(70)
ENDIF
IF ANS='P'
   CLEAR
   @ 2, 5 SAY 'No Of Copies       ' GET MNO PICTURE '99'
   READ
   CLEAR
   @ 8, 17 SAY 'Subsideries Trial Balance Printing'
   @ 10, 17 SAY 'Please use 80 column (10 inches wide) continous'
   @ 11, 17 SAY 'printer paper and set Top Of Form'
   @ 12, 17 SAY 'Press ENTER when ready...........'
   WAIT ''
   PANS= ' '
   DO prnchk IN tbl_proc.prg
   IF PANS='Q'
      CLOSE ALL
      CLEAR
      RETURN
   ENDIF
   @ 11, 20 SAY 'Please wait ... Printing in progress '
   SET PRINTER ON
   SET DEVICE TO PRINTER
ENDIF
IF ANS='S'
   MNO= 1
ENDIF
ABC= 1
DO WHILE ABC<=MNO
   PAGE= 1
   HEADING= .T.
   GOTO TOP
   STORE 0 TO DRTOT, CRTOT, TCR, TDR, LINE
   CLEAR
   DO WHILE .not. EOF()
      IF HEADING
         IF ANS='S'
            DO screen IN tbl_proc.prg
            @ 2, 20 SAY 'TRIAL  BALANCE  AS  ON: '
         ENDIF
         IF ANS='P'
            DO PRNCHK IN tbl_proc.prg
            DO top_prt1 IN tbl_proc.prg
            @ 2, 23 SAY 'TRIAL BALANCE AS ON: '
         ENDIF
         @ 2, 44 SAY MTDATE
         @ 2, 72 SAY 'PAGE: '
         @ 2, 78 SAY PAGE PICTURE '99'
         @ 3, 1 SAY REPLICATE('-',79)
         @ 4, 1 SAY 'CODE-----'
         @ 4, 11 SAY '   ---- ACCOUNT  TITLE ----'
         @ 4, 50 SAY 'D E B I T'
         @ 4, 69 SAY 'C R E D I T'
         @ 5, 1 SAY REPLICATE('-',79)
         LINE= 6
         HEADING= .F.
      ENDIF
      IF EOF()
         EXIT
      ENDIF
      STORE SPACE(30) TO WTITLE
      STORE TITLE TO WTITLE
      IF ZEROBAL='N'.and.TIT='N'
         IF LDGR_BAL=0
            SKIP
            LOOP
         ENDIF
      ENDIF
      IF C3<>0
         IF ZEROBAL='N'.and.TIT='Y'
            IF LDGR_BAL=0
               SKIP
               LOOP
            ENDIF
         ENDIF
      ENDIF
      IF C3=0
         LINE= LINE+1
         MPC1= REPLICATE('0',2-LEN(LTRIM(STR(C1))))+LTRIM(STR(C1))
         @ LINE, 1 SAY MPC1
         @ LINE, 3 SAY '-'
         MPC2= REPLICATE('0',2-LEN(LTRIM(STR(C2))))+LTRIM(STR(C2))
         @ LINE, 4 SAY MPC2
         @ LINE, 6 SAY '-'
         MPC3= REPLICATE('0',3-LEN(LTRIM(STR(C3))))+LTRIM(STR(C3))
         @ LINE, 7 SAY MPC3
         @ LINE, 11 SAY TITLE
         MLEN= LEN(RTRIM(TITLE))
         LINE= LINE+1
         @ LINE, 1 SAY REPLICATE('-',15+MLEN)
         LINE= LINE+1
         SKIP
         IF ANS='S'.and.LINE>21
            IF EOF()
               EXIT
            ENDIF
            XYZ= ' '
            DO WHILE .not. XYZ$'CQ'
               SET CONFIRM OFF
               @ 23, 57 SAY 'Continue/Quit - C/Q' GET XYZ FUNCTION '!'
               READ
            ENDDO
            IF XYZ='Q'
               CLEAR
               CLOSE ALL
               RETURN
            ENDIF
            CLEAR
            PAGE= PAGE+1
            HEADING= .T.
         ENDIF
         IF ANS='P'.and.LINE>=56
            PAGE= PAGE+1
            HEADING= .T.
         ENDIF
         LOOP
      ENDIF
      MPC1= REPLICATE('0',2-LEN(LTRIM(STR(C1))))+LTRIM(STR(C1))
      @ LINE, 1 SAY MPC1
      @ LINE, 3 SAY '-'
      MPC2= REPLICATE('0',2-LEN(LTRIM(STR(C2))))+LTRIM(STR(C2))
      @ LINE, 4 SAY MPC2
      @ LINE, 6 SAY '-'
      MPC3= REPLICATE('0',3-LEN(LTRIM(STR(C3))))+LTRIM(STR(C3))
      @ LINE, 7 SAY MPC3
      @ LINE, 11 SAY WTITLE
      COL= IIF(STATUS='DR',45,63)
      @ LINE, COL SAY ABS(LDGR_BAL) PICTURE '9,999,999,999.99'
      IF COL=45
         DRTOT= DRTOT+LDGR_BAL
      ELSE
         CRTOT= CRTOT+LDGR_BAL
      ENDIF
      LINE= LINE+1
      IF .not. EOF()
         SKIP
      ENDIF
      IF ANS='S'.and.LINE>21
         IF EOF()
            EXIT
         ENDIF
         XYZ= ' '
         DO WHILE .not. XYZ$'CQ'
            SET CONFIRM OFF
            @ 23, 57 SAY 'Continue/Quit - C/Q' GET XYZ FUNCTION '!'
            READ
         ENDDO
         IF XYZ='Q'
            CLEAR
            CLOSE ALL
            RETURN
         ENDIF
         CLEAR
         PAGE= PAGE+1
         HEADING= .T.
      ENDIF
      IF ANS='P'.and.LINE>=56
         PAGE= PAGE+1
         HEADING= .T.
      ENDIF
   ENDDO
   IF ANS='S'.and.LINE>21
      LINE= LINE-1
   ENDIF
   LINE= LINE+1
   @ LINE, 1 SAY REPLICATE('-',79)
   LINE= LINE+1
   @ LINE, 10 SAY '        T O T A L S :'
   @ LINE, 47 SAY DRTOT PICTURE '9999999,999.99'
   @ LINE, 65 SAY CRTOT PICTURE '9999999,999.99'
   LINE= LINE+1
   @ LINE, 1 SAY REPLICATE('-',79)
   IF ANS='S'
      @ 24, 7 SAY 'End of Screen Printing  -  Press any key to return to menu.... '
      WAIT ''
   ENDIF
   IF ANS='P'
      EJECT
   ENDIF
   ABC= ABC+1
ENDDO
IF ANS='P'
   SET PRINTER OFF
   SET DEVICE TO SCREEN
ENDIF
CLEAR
SET FILTER TO
CLOSE ALL

RETURN
*******************

*************************
PROCEDURE C2_TRL
*************************

CLEAR
CLOSE ALL

IF _DOS
SET COLOR TO 7/1
ENDIF

CLEAR
* ON ERROR  to
SET TALK OFF
USE master ORDER mastdate

GOTO BOTTOM
STORE DATE TO MTDATE
CLEAR
@ 2, 5 SAY 'Level-2  Trial Balance '
@ 5, 5 SAY 'Your last posted voucher is dated '
@ 5, 42 SAY MTDATE
@ 6, 5 SAY 'Do you want to dispaly same date on your Trial Balance'
@ 7, 5 SAY 'Or enter the date you want to dispaly  ' GET MTDATE
READ
STORE 0 TO TDR, TCR, LINE, MC1, MC2, MC3, GTOTDR, GTOTCR
ANS= ' '
DO WHILE .not. ANS$'PSQ'
   @ 23, 47 SAY 'Printer/Screen/Quit -  P/S/Q ' GET ANS FUNCTION '!'
   READ
ENDDO
IF ANS='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
CLEAR
SELECT 1
USE ldgrcode ORDER ac1

MCODE= 0
HEADING= .T.
PAGE= 1
IF ANS='P'
   CLEAR
   @ 8, 17 SAY 'Level-2  Trial Balance Printing'
   @ 10, 17 SAY 'Please use 80 column (10 inches wide) continous'
   @ 11, 17 SAY 'printer paper and set Top Of Form'
   @ 12, 17 SAY 'Press ENTER when ready...........'
   WAIT ''
   CLEAR
   PANS= ' '
   DO prnchk IN tbl_proc.prg
   IF PANS='Q'
      CLOSE ALL
      CLEAR
      RETURN
   ENDIF
   @ 11, 20 SAY 'Please wait ... Printing in progress '
   SET PRINTER ON
   SET DEVICE TO PRINTER
ENDIF
SELECT 1
GOTO TOP
MC1= C1
STORE SPACE(25) TO WTITLE
STORE SPACE(25) TO WGTITLE
C= 45
DO WHILE .not. EOF()
   SELECT 1
   IF LDGR_BAL=0.and.C3<>0
      SKIP
      LOOP
   ENDIF
   IF EOF()
      EXIT
   ENDIF
   IF HEADING
      IF ANS='S'
         DO screen IN tbl_proc.prg
      ENDIF
      IF ANS='P'
         DO PRNCHK IN tbl_proc.prg
         DO top_prt1 IN tbl_proc.prg
      ENDIF
      @ 2, 14 SAY 'LEVEL-2  TRIAL BALANCE PRINTING AS ON: '
      @ 2, 52 SAY MTDATE
      @ 2, 72 SAY 'PAGE: '
      @ 2, 78 SAY PAGE PICTURE '99'
      @ 3, 1 SAY REPLICATE('-',79)
      @ 4, 1 SAY 'CODE-----'
      @ 4, 14 SAY 'T I T L E -----------------'
      @ 4, 43 SAY '-------D E B I T'
      @ 4, 62 SAY '-------C R E D I T'
      @ 5, 1 SAY REPLICATE('-',79)
      LINE= 6
      HEADING= .F.
   ENDIF
   STORE SPACE(30) TO WGTITLE
   IF C3=0
      STORE TITLE TO WGTITLE
   ENDIF
   STORE TITLE TO WTITLE
   MPC1= REPLICATE('0',2-LEN(LTRIM(STR(C1))))+LTRIM(STR(C1))
   MPC2= REPLICATE('0',2-LEN(LTRIM(STR(C2))))+LTRIM(STR(C2))
   MC1= C1
   MC2= C2
   TAMT= 0
   STORE 0 TO TDR, TCR
   DO WHILE C1=MC1.and.C2=MC2
      IF STATUS='DR'
         TDR= TDR+LDGR_BAL
      ELSE
         TCR= TCR+LDGR_BAL
      ENDIF
      IF EOF()
         EXIT
      ENDIF
      SKIP
   ENDDO
   IF TDR>TCR
      TAMT= TDR-TCR
      GTOTDR= GTOTDR+TAMT
      C= 45
   ENDIF
   IF TCR>TDR
      TAMT= TCR-TDR
      GTOTCR= GTOTCR+TAMT
      C= 60
   ENDIF
   IF TAMT=0
      LOOP
   ENDIF
   @ LINE, 1 SAY MPC1
   @ LINE, 3 SAY '-'
   @ LINE, 4 SAY MPC2
   IF WGTITLE<>SPACE(30)
      @ LINE, 14 SAY WGTITLE
   ELSE
      @ LINE, 14 SAY 'Group Total'
   ENDIF
   @ LINE, C SAY TAMT PICTURE '99,999,999,999.99'
   LINE= LINE+1
   IF ANS='S'.and.LINE>20
      XYZ= ' '
      DO WHILE .not. XYZ$'CQ'
         SET CONFIRM OFF
         @ 23, 57 SAY 'Continue/Quit - C/Q' GET XYZ FUNCTION '!'
         READ
         CLEAR
      ENDDO
      IF XYZ='Q'
         CLEAR
         CLOSE ALL
         RETURN
      ENDIF
      PAGE= PAGE+1
      HEADING= .T.
   ENDIF
   IF ANS='P'.and.LINE>55
      PAGE= PAGE+1
      HEADING= .T.
   ENDIF
ENDDO
LINE= LINE+1
@ LINE, 1 SAY REPLICATE('-',79)
LINE= LINE+1
@ LINE, 20 SAY 'TOTALS:'
@ LINE, 45 SAY GTOTDR PICTURE '99999999,999.99'
@ LINE, 65 SAY GTOTCR PICTURE '99999999,999.99'
LINE= LINE+1
@ LINE, 1 SAY REPLICATE('-',79)
IF ANS='S'
   @ 24, 7 SAY 'End of Screen Printing  -  Press any key to return to menu.... '
   WAIT ''
ENDIF
IF ANS='P'
   EJECT
   SET PRINTER OFF
   SET DEVICE TO SCREEN
ENDIF
CLEAR
SET FILTER TO
CLOSE ALL

RETURN
*********************



**********************
PROCEDURE C1_TRL2
**********************

CLEAR
CLOSE ALL

IF _DOS
SET COLOR TO 7/1
ENDIF

CLEAR
STORE 0 TO DRTOT, CRTOT, TCR, TDR, GTDR, GTCR, LINE
@ 2, 2 SAY 'Level-1  Trial Balance '
ANS= ' '
DO WHILE .not. ANS$'PSQ'
   @ 3, 2 SAY 'Printer/Screen/Quit -  P/S/Q ' GET ANS FUNCTION '!'
   READ
ENDDO
IF ANS='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
CLEAR
USE ldgrcode ORDER ac1

MCODE= 0
STORE 0 TO TOTDR, TOTCR, TDR, TCR
WGTITLE= SPACE(30)
HEADING= .T.
PAGE= 1
MSRNO= 0
WCODE= 0
IF ANS='P'
   CLEAR
   PANS= ' '
   DO prnchk
   IF PANS='Q'
      CLOSE ALL
      CLEAR
      RETURN
   ENDIF
   @ 11, 20 SAY 'Please wait ... Printing in progress '
   SET PRINTER ON
   SET DEVICE TO PRINTER
ENDIF
GOTO TOP
MC1= C1
C= 45
DO WHILE .not. EOF()
   IF LDGR_BAL=0
      SKIP
      LOOP
   ENDIF
   MC1= C1
   STORE 0 TO TDR, TCR, TAMT
   DO WHILE C1=MC1
      IF EOF()
         EXIT
      ENDIF
      IF HEADING
         IF ANS='S'
            DO screen
         ENDIF
         IF ANS='P'
            DO PRNCHK IN tbl_proc.prg
            DO top_prt1 IN tbl_proc.prg
         ENDIF
         @ 2, 18 SAY 'LEVEL-1  TRIAL  BALANCE  AS  ON: '
         @ 2, 52 SAY DATE()
         @ 2, 72 SAY 'PAGE: '
         @ 2, 78 SAY PAGE PICTURE '99'
         @ 3, 1 SAY REPLICATE('-',79)
         @ 4, 1 SAY 'CODE-----'
         @ 4, 14 SAY 'T I T L E -----------------'
         @ 4, 43 SAY '-------D E B I T'
         @ 4, 62 SAY '-------C R E D I T'
         @ 5, 1 SAY REPLICATE('-',79)
         LINE= 6
         HEADING= .F.
      ENDIF
      IF C3=0.and.C2=0
         STORE TITLE TO WGTITLE
      ENDIF
      STORE TITLE TO WTITLE
      IF STATUS='DR'
         TDR= TDR+LDGR_BAL
      ELSE
         TCR= TCR+LDGR_BAL
      ENDIF
      IF EOF()
         EXIT
      ENDIF
      SKIP
   ENDDO
   IF TDR>TCR
      TAMT= TDR-TCR
      TOTDR= TOTDR+TAMT
      C= 45
   ENDIF
   IF TCR>TDR
      TAMT= TCR-TDR
      TOTCR= TOTCR+TAMT
      C= 60
   ENDIF
   MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MC1))))+LTRIM(STR(MC1))
   @ LINE, 1 SAY MPC1
   @ LINE, C SAY TAMT PICTURE '99,999,999,999.99'
   IF ANS='S'.and.LINE>17
      XYZ= ' '
      DO WHILE .not. XYZ$'CQ'
         SET CONFIRM OFF
         @ 24, 57 SAY 'Continue/Quit - C/Q' GET XYZ FUNCTION '!'
         READ
      ENDDO
      CLEAR
      IF XYZ='Q'
         CLOSE ALL
         RETURN
      ENDIF
      PAGE= PAGE+1
      HEADING= .T.
   ENDIF
   IF ANS='P'.and.LINE>53
      PAGE= PAGE+1
      HEADING= .T.
   ENDIF
   STORE 0 TO TDR, TCR
   LINE= LINE+1
   @ LINE, 1 SAY REPLICATE('-',79)
   LINE= LINE+1
   IF WGTITLE<>SPACE(30)
      @ LINE, 1 SAY 'TOTAL '
      @ LINE, 10 SAY WGTITLE
   ELSE
      @ LINE, 1 SAY 'GROUP TOTAL:'
   ENDIF
   WGTITLE= SPACE(30)
   @ LINE, C SAY TAMT PICTURE '99999999,999.99'
   LINE= LINE+1
   @ LINE, 1 SAY REPLICATE('-',79)
   LINE= LINE+1
   STORE 0 TO GTDR, GTCR
   MC1= C1
   LINE= LINE+1
ENDDO
LINE= LINE+1
IF ANS='S'.and.LINE>20
   XYZ= ' '
   DO WHILE .not. XYZ$'CQ'
      SET CONFIRM OFF
      @ 24, 57 SAY 'Continue/Quit - C/Q' GET XYZ FUNCTION '!'
      READ
   ENDDO
   CLEAR
   IF XYZ='Q'
      CLOSE ALL
      RETURN
   ENDIF
   PAGE= PAGE+1
   HEADING= .T.
ENDIF
IF ANS='P'.and.LINE>53
   PAGE= PAGE+1
   HEADING= .T.
ENDIF
@ LINE, 1 SAY REPLICATE('-',79)
LINE= LINE+1
@ LINE, 10 SAY 'G R A N D    T O T A L S :'
@ LINE, 45 SAY TOTDR PICTURE '99999999,999.99'
@ LINE, 60 SAY TOTCR PICTURE '99999999,999.99'
LINE= LINE+1
@ LINE, 1 SAY REPLICATE('-',79)
IF ANS='S'
   @ 24, 7 SAY 'End of Screen Printing  -  Press any key to return to menu.... '
   WAIT ''
ENDIF
IF ANS='P'
   EJECT
   SET PRINTER OFF
   SET DEVICE TO SCREEN
ENDIF
CLEAR
SET FILTER TO
CLOSE ALL

RETURN
*******************




