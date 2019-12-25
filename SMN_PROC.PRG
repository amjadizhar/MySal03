*********************************************
* PROGRAM: SMN_PROC.PRG						*
* Author: Amjad Izhar						*
* system Maintenance						*
* Written : 21-09-96						*
* Revised Again On : 19-01-2001 7:15 PM
*********************************************



*************************
PROCEDURE BACK_UP1
*************************

CLEAR
CLOSE DATA

IF _DOS
 SET COLOR TO 7/1
ENDIF 

CLEAR
ANS= ' '

DO WHILE .not. ANS$'YN'
   ANS2= ' '
   DO WHILE .not. ANS2$'AB'
      @ 5, 15 SAY 'Enter Drive On Which You Want To Make Backup - A/B ' GET ANS2 PICTURE '!'
      READ
   ENDDO
   @ 8, 15 SAY 'Please Insert Diskette in Drive To Backup Data Files '
   @ 10, 15 SAY 'Do You Want To Continue  - Y/N ' GET ANS PICTURE '!'
   READ
   IF ANS='Y'
      CLEAR
      IF ANS2='A'
         RUN backup *.dbf a:
      ELSE
         RUN backup *.dbf b:
      ENDIF
   ELSE
      EXIT
   ENDIF
ENDDO
CLEAR

RETURN
**********************

************************
PROCEDURE BACK_UP2
*************************

CLEAR
CLOSE DATA

IF _DOS
 SET COLOR TO 7/1
ENDIF

CLEAR
ANS= ' '
DO WHILE .not. ANS$'YN'
   ANS2= ' '
   DO WHILE .not. ANS2$'AB'
      @ 5, 15 SAY 'Enter Drive On Which You Want To Make Backup - A/B ' GET ANS2 PICTURE '!'
      READ
   ENDDO
   @ 8, 15 SAY 'Please Insert Diskette in Drive To Backup Data Files '
   @ 10, 15 SAY 'Do You Want To Continue  - Y/N ' GET ANS PICTURE '!'
   READ
   IF ANS='Y'
      CLEAR
      IF ANS2='A'
         RUN backup c:*.dbf a:
      ELSE
         RUN backup c:*.dbf b:
      ENDIF
   ELSE
      EXIT
   ENDIF
ENDDO
CLEAR

RETURN
**************************

**********************
PROCEDURE REINDEX
**********************

CLEAR
CLOSE ALL

SET EXCLUSIVE ON
SET DELETED OFF

IF _DOS
 SET COLOR TO 7/1
ENDIF

CLEAR

@ 2, 2 SAY 'Reindex/Re-organize Data Files'
P= ' '
DO WHILE .not. P$'CQ'
   @ 3, 2 SAY 'Continue/Quit  -  C/Q  ' GET P FUNCTION '!'
   READ
ENDDO
IF P='Q'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
CLEAR
@ 2, 20 SAY 'Re-indexing Data Files  --- Please wait'
SET EXCLUSIVE ON
USE ldgrcode
PACK
USE tran-key
PACK
USE master
PACK
USE voucher
ZAP
USE vch-cor
ZAP
USE tran-rep
ZAP
USE trl-ref
PACK
USE pl-work2
ZAP
USE work
ZAP
USE tran
PACK
CLOSE ALL
SELECT 1
USE tran
INDEX ON STR(VCH_TYPE,1)+STR(VCH_NO1,2)+STR(VCH_NO2,5) TAG tranent 
SELECT 2
USE tran-key
INDEX ON STR(VCH_TYPE,1)+STR(VCH_NO1,2)+STR(VCH_NO2,5) TAG key 
ZAP
SELECT 1
DO WHILE .not. EOF()
   MVCH_TYPE= VCH_TYPE
   MVCH_NO1= VCH_NO1
   MVCH_NO2= VCH_NO2
   SELECT 2
   SEEK STR(MVCH_TYPE,1)+STR(MVCH_NO1,2)+STR(MVCH_NO2,5)
   IF .not. FOUND()
      APPEND BLANK
      REPLACE VCH_TYPE WITH MVCH_TYPE
      REPLACE VCH_NO1 WITH MVCH_NO1, VCH_NO2 WITH MVCH_NO2
   ENDIF
   SELECT 1
   SKIP
ENDDO
SELECT 2
GOTO TOP
REPLACE ALL FLAG WITH 'Y'
CLOSE ALL
CLEAR
SET EXCLUSIVE ON
CLOSE ALL

USE ldgrcode
INDEX ON STR(C1,2)+STR(C2,2)+STR(C3,3) TAG ac1 
INDEX ON TITLE TAG tit 

USE tran
INDEX ON STR(VCH_TYPE,1)+STR(VCH_NO1,2)+STR(VCH_NO2,5) TAG tranent 
INDEX ON STR(C1,2)+STR(C2,2)+STR(C3,3) TAG tr 
INDEX ON DATE TAG trandate 

USE tran-key
INDEX ON STR(VCH_TYPE,1)+STR(VCH_NO1,2)+STR(VCH_NO2,5) TAG key 

USE master
INDEX ON STR(C1,2)+STR(C2,2)+STR(C3,3) TAG ac2 
INDEX ON DATE TAG mastdate 

USE chart
INDEX ON STR(FR,2)+STR(TO,2) TAG crt 
INDEX ON CHART_NO TAG cht 

USE tran-rep
INDEX ON STR(VCH_TYPE,1)+STR(VCH_NO1,2)+STR(VCH_NO2,5) TAG rep 

USE trl-ref
INDEX ON STR(C1,2)+STR(C2,2)+STR(C3,3) TAG trl_idx 

USE pl-work2
INDEX ON CHART_NO TAG blc1 
INDEX ON STR(CHART_NO,2)+STR(C1,2)+STR(C2,2)+STR(C3,3) TAG bl_c1 


*USE mldgr
*INDEX ON STR(C1,2)+STR(C2,2)+STR(C3,3) TAG mac2 


CLEAR
CLOSE ALL
SET EXCLUSIVE ON
SET DELETED ON
CLOSE ALL

RETURN
*****************

*********************
PROCEDURE SORTDATE
*********************

CLEAR PROGRAM
CLOSE DATA
CLEAR

IF _DOS
 SET COLOR TO 7/1
ENDIF

CLEAR
SET DATE brit
@ 10, 18 SAY 'Ledgers Being Sorted Date Wise - Please Wait '
USE master
SORT ON DATE, SR_NO TO mastsort
USE mastsort
INDEX ON STR(C1,2)+STR(C2,2)+STR(C3,3) TAG mastsort 
HEAD= .T.
Q= 10
DO WHILE .not. EOF()
   STORE STR(C1,2)+STR(C2,2)+STR(C3,3) TO MCODE
   IF SR_NO<>1
      IF Q=10
         CLEAR
         @ 14, 26 SAY 'Please Switch Your Printer On '
         WAIT
      ENDIF
      CLEAR
      PANS= ' '
      DO prnchk IN tbl_proc.prg
      IF PANS='Q'
         CLOSE ALL
         CLEAR
         RETURN
      ENDIF
      @ 11, 20 SAY 'Please wait ... Printing In Progress '
      SET PRINTER ON
      SET DEVICE TO PRINTER
      Q= 21
      IF HEAD
         R= 5
         @ R, 1 SAY 'The Following Vouchers Are Dated Before The Opening Balance Date '
         R= R+1
         @ R, 1 SAY "Please Correct Voucher's Date Before Using This Option "
         R= R+2
         @ R, 1 SAY 'Date'
         @ R, 10 SAY 'Vch-Type'
         @ R, 20 SAY 'Vch-No'
         @ R, 35 SAY 'C o d e'
         @ R, 47 SAY 'Description'
         R= R+1
         @ R, 1 SAY REPLICATE('-',79)
         HEAD= .F.
         R= R+2
      ENDIF
      @ R, 1 SAY DATE
      @ R, 10 SAY VCH_TYPE
      @ R, 20 SAY VCH_NO
      @ R, 30 SAY C1
      @ R, 33 SAY C2
      @ R, 37 SAY C3
      @ R, 45 SAY DESC
      R= R+1
      IF R>54
         EJECT
         HEAD= .F.
      ENDIF
   ENDIF
   DO WHILE STR(C1,2)+STR(C2,2)+STR(C3,3)=MCODE
      SKIP
   ENDDO
ENDDO
IF Q=21
   SET DEVICE TO SCREEN
   EJECT
   CLOSE DATA
   RETURN
ENDIF
REPLACE FOR SR_NO<>1 BL_AMOUNT WITH 0
USE mastsort ORDER mastsort
DO WHILE .not. EOF()
   MSRNO= 0
   STORE STR(C1,2)+STR(C2,2)+STR(C3,3) TO MCODE
   IF SR_NO<>1
      @ 16, 25 SAY 'The Voucher No'
      @ 16, 45 SAY VCH_NO
      @ 17, 25 SAY 'Is Dated Before The Opening Balance Date '
      @ 18, 25 SAY 'Please Correct Data/Voucher Date '
      WAIT ''
      CLOSE DATA
      RETURN
   ELSE
      IF BL_AMOUNT=0
         MSRNO= MSRNO+1
         REPLACE SR_NO WITH MSRNO
         SKIP
      ENDIF
   ENDIF
   MAMT= BL_AMOUNT
   MST= STATUS
   DO WHILE STR(C1,2)+STR(C2,2)+STR(C3,3)=MCODE
      MSRNO= MSRNO+1
      REPLACE SR_NO WITH MSRNO
      IF MST='DR'
         IF DR_AMOUNT>0
            REPLACE BL_AMOUNT WITH MAMT+DR_AMOUNT
            REPLACE STATUS WITH 'DR'
         ENDIF
         IF CR_AMOUNT>0
            IF CR_AMOUNT>MAMT
               REPLACE BL_AMOUNT WITH CR_AMOUNT-MAMT
               REPLACE STATUS WITH 'CR'
            ENDIF
            IF CR_AMOUNT<MAMT
               REPLACE BL_AMOUNT WITH MAMT-CR_AMOUNT
               REPLACE STATUS WITH 'DR'
            ENDIF
            IF CR_AMOUNT<>0
               IF CR_AMOUNT=MAMT
                  REPLACE BL_AMOUNT WITH MAMT-CR_AMOUNT
                  REPLACE STATUS WITH 'DR'
               ENDIF
            ENDIF
         ENDIF
      ENDIF
      IF MST='CR'
         IF CR_AMOUNT>0
            REPLACE BL_AMOUNT WITH MAMT+CR_AMOUNT
            REPLACE STATUS WITH 'CR'
         ENDIF
         IF DR_AMOUNT>0
            IF DR_AMOUNT>MAMT
               REPLACE BL_AMOUNT WITH DR_AMOUNT-MAMT
               REPLACE STATUS WITH 'DR'
            ENDIF
            IF DR_AMOUNT<MAMT
               REPLACE BL_AMOUNT WITH MAMT-DR_AMOUNT
               REPLACE STATUS WITH 'CR'
            ENDIF
            IF DR_AMOUNT<>0
               IF DR_AMOUNT=MAMT
                  REPLACE BL_AMOUNT WITH MAMT-DR_AMOUNT
                  REPLACE STATUS WITH 'DR'
               ENDIF
            ENDIF
         ENDIF
      ENDIF
      MAMT= BL_AMOUNT
      MST= STATUS
      SKIP
   ENDDO
ENDDO
CLOSE DATA
USE mastsort
COPY TO master
RUN del mastsort.*
RETURN
**********************************


***********************
PROCEDURE PASSWORD
***********************

CLEAR
CLOSE ALL
USE pw
GOTO TOP
STORE SPACE(6) TO MPW1, MPW2, MPW3, MPW4, MPW5, MPW6, MPW7, MPW8
R= 5
DO WHILE .T.
   
   IF _DOS
    SET COLOR TO 7/1
   ENDIF
   
   CLEAR
   NCODE1= SUBSTR(PW,1,1)
   NCODE2= SUBSTR(PW,2,1)
   NCODE3= SUBSTR(PW,3,1)
   NCODE4= SUBSTR(PW,4,1)
   NCODE5= SUBSTR(PW,5,1)
   NCODE6= SUBSTR(PW,6,1)
   mm1    = chr(asc("&ncode1")+26)+chr(asc("&ncode2")+30)+chr(asc("&ncode3")+29)+chr(asc("&ncode4")+21)+chr(asc("&ncode5")+19)+chr(asc("&ncode6")+13)
   @ R, 24 SAY 'Password For Menu 1'
   @ R, 46 GET MM1 FUNCTION '!'
   READ
   MCODE= MM1
   MCODE1= SUBSTR(MCODE,1,1)
   MCODE2= SUBSTR(MCODE,2,1)
   MCODE3= SUBSTR(MCODE,3,1)
   MCODE4= SUBSTR(MCODE,4,1)
   MCODE5= SUBSTR(MCODE,5,1)
   MCODE6= SUBSTR(MCODE,6,1)
   FMCODE= CHR(ASC(MCODE1)-26)+CHR(ASC(MCODE2)-30)+CHR(ASC(MCODE3)-29)+CHR(ASC(MCODE4)-21)+CHR(ASC(MCODE5)-19)+CHR(ASC(MCODE6)-13)
   IF RLOCK()
      REPLACE PW WITH FMCODE
      FLUSH
   ENDIF
   R= R+2
   SKIP
   NCODE1= SUBSTR(PW,1,1)
   NCODE2= SUBSTR(PW,2,1)
   NCODE3= SUBSTR(PW,3,1)
   NCODE4= SUBSTR(PW,4,1)
   NCODE5= SUBSTR(PW,5,1)
   NCODE6= SUBSTR(PW,6,1)
   mm2     = chr(asc("&ncode1")+26)+chr(asc("&ncode2")+30)+chr(asc("&ncode3")+29)+chr(asc("&ncode4")+21)+chr(asc("&ncode5")+19)+chr(asc("&ncode6")+13)
   @ R, 24 SAY 'Password For Menu 2'
   @ R, 46 GET MM2 FUNCTION '!'
   READ
   MCODE= MM2
   MCODE1= SUBSTR(MCODE,1,1)
   MCODE2= SUBSTR(MCODE,2,1)
   MCODE3= SUBSTR(MCODE,3,1)
   MCODE4= SUBSTR(MCODE,4,1)
   MCODE5= SUBSTR(MCODE,5,1)
   MCODE6= SUBSTR(MCODE,6,1)
   FMCODE= CHR(ASC(MCODE1)-26)+CHR(ASC(MCODE2)-30)+CHR(ASC(MCODE3)-29)+CHR(ASC(MCODE4)-21)+CHR(ASC(MCODE5)-19)+CHR(ASC(MCODE6)-13)
   IF RLOCK()
      REPLACE PW WITH FMCODE
      FLUSH
   ENDIF
   R= R+2
   SKIP
   NCODE1= SUBSTR(PW,1,1)
   NCODE2= SUBSTR(PW,2,1)
   NCODE3= SUBSTR(PW,3,1)
   NCODE4= SUBSTR(PW,4,1)
   NCODE5= SUBSTR(PW,5,1)
   NCODE6= SUBSTR(PW,6,1)
   mm3     = chr(asc("&ncode1")+26)+chr(asc("&ncode2")+30)+chr(asc("&ncode3")+29)+chr(asc("&ncode4")+21)+chr(asc("&ncode5")+19)+chr(asc("&ncode6")+13)
   @ R, 24 SAY 'Password For Menu 3'
   @ R, 46 GET MM3 FUNCTION '!'
   READ
   MCODE= MM3
   MCODE1= SUBSTR(MCODE,1,1)
   MCODE2= SUBSTR(MCODE,2,1)
   MCODE3= SUBSTR(MCODE,3,1)
   MCODE4= SUBSTR(MCODE,4,1)
   MCODE5= SUBSTR(MCODE,5,1)
   MCODE6= SUBSTR(MCODE,6,1)
   FMCODE= CHR(ASC(MCODE1)-26)+CHR(ASC(MCODE2)-30)+CHR(ASC(MCODE3)-29)+CHR(ASC(MCODE4)-21)+CHR(ASC(MCODE5)-19)+CHR(ASC(MCODE6)-13)
   IF RLOCK()
      REPLACE PW WITH FMCODE
      FLUSH
   ENDIF
   R= R+2
   SKIP
   NCODE1= SUBSTR(PW,1,1)
   NCODE2= SUBSTR(PW,2,1)
   NCODE3= SUBSTR(PW,3,1)
   NCODE4= SUBSTR(PW,4,1)
   NCODE5= SUBSTR(PW,5,1)
   NCODE6= SUBSTR(PW,6,1)
   mm4     = chr(asc("&ncode1")+26)+chr(asc("&ncode2")+30)+chr(asc("&ncode3")+29)+chr(asc("&ncode4")+21)+chr(asc("&ncode5")+19)+chr(asc("&ncode6")+13)
   @ R, 24 SAY 'Password For Menu 4'
   @ R, 46 GET MM4 FUNCTION '!'
   READ
   MCODE= MM4
   MCODE1= SUBSTR(MCODE,1,1)
   MCODE2= SUBSTR(MCODE,2,1)
   MCODE3= SUBSTR(MCODE,3,1)
   MCODE4= SUBSTR(MCODE,4,1)
   MCODE5= SUBSTR(MCODE,5,1)
   MCODE6= SUBSTR(MCODE,6,1)
   FMCODE= CHR(ASC(MCODE1)-26)+CHR(ASC(MCODE2)-30)+CHR(ASC(MCODE3)-29)+CHR(ASC(MCODE4)-21)+CHR(ASC(MCODE5)-19)+CHR(ASC(MCODE6)-13)
   IF RLOCK()
      REPLACE PW WITH FMCODE
      FLUSH
   ENDIF
   R= R+2
   SKIP
   NCODE1= SUBSTR(PW,1,1)
   NCODE2= SUBSTR(PW,2,1)
   NCODE3= SUBSTR(PW,3,1)
   NCODE4= SUBSTR(PW,4,1)
   NCODE5= SUBSTR(PW,5,1)
   NCODE6= SUBSTR(PW,6,1)
   mm5     = chr(asc("&ncode1")+26)+chr(asc("&ncode2")+30)+chr(asc("&ncode3")+29)+chr(asc("&ncode4")+21)+chr(asc("&ncode5")+19)+chr(asc("&ncode6")+13)
   @ R, 24 SAY 'Password For Menu 5'
   @ R, 46 GET MM5 FUNCTION '!'
   READ
   MCODE= MM5
   MCODE1= SUBSTR(MCODE,1,1)
   MCODE2= SUBSTR(MCODE,2,1)
   MCODE3= SUBSTR(MCODE,3,1)
   MCODE4= SUBSTR(MCODE,4,1)
   MCODE5= SUBSTR(MCODE,5,1)
   MCODE6= SUBSTR(MCODE,6,1)
   FMCODE= CHR(ASC(MCODE1)-26)+CHR(ASC(MCODE2)-30)+CHR(ASC(MCODE3)-29)+CHR(ASC(MCODE4)-21)+CHR(ASC(MCODE5)-19)+CHR(ASC(MCODE6)-13)
   IF RLOCK()
      REPLACE PW WITH FMCODE
      FLUSH
   ENDIF
   R= R+2
   SKIP
   NCODE1= SUBSTR(PW,1,1)
   NCODE2= SUBSTR(PW,2,1)
   NCODE3= SUBSTR(PW,3,1)
   NCODE4= SUBSTR(PW,4,1)
   NCODE5= SUBSTR(PW,5,1)
   NCODE6= SUBSTR(PW,6,1)
   mm6     = chr(asc("&ncode1")+26)+chr(asc("&ncode2")+30)+chr(asc("&ncode3")+29)+chr(asc("&ncode4")+21)+chr(asc("&ncode5")+19)+chr(asc("&ncode6")+13)
   @ R, 24 SAY 'Password For Menu 6'
   @ R, 46 GET MM6 FUNCTION '!'
   READ
   MCODE= MM6
   MCODE1= SUBSTR(MCODE,1,1)
   MCODE2= SUBSTR(MCODE,2,1)
   MCODE3= SUBSTR(MCODE,3,1)
   MCODE4= SUBSTR(MCODE,4,1)
   MCODE5= SUBSTR(MCODE,5,1)
   MCODE6= SUBSTR(MCODE,6,1)
   FMCODE= CHR(ASC(MCODE1)-26)+CHR(ASC(MCODE2)-30)+CHR(ASC(MCODE3)-29)+CHR(ASC(MCODE4)-21)+CHR(ASC(MCODE5)-19)+CHR(ASC(MCODE6)-13)
   IF RLOCK()
      REPLACE PW WITH FMCODE
      FLUSH
   ENDIF
   SKIP
   R= R+2
   NCODE1= SUBSTR(PW,1,1)
   NCODE2= SUBSTR(PW,2,1)
   NCODE3= SUBSTR(PW,3,1)
   NCODE4= SUBSTR(PW,4,1)
   NCODE5= SUBSTR(PW,5,1)
   NCODE6= SUBSTR(PW,6,1)
   mm7     = chr(asc("&ncode1")+26)+chr(asc("&ncode2")+30)+chr(asc("&ncode3")+29)+chr(asc("&ncode4")+21)+chr(asc("&ncode5")+19)+chr(asc("&ncode6")+13)
   @ R, 24 SAY 'Password For Menu 7'
   @ R, 46 GET MM7 FUNCTION '!'
   READ
   MCODE= MM7
   MCODE1= SUBSTR(MCODE,1,1)
   MCODE2= SUBSTR(MCODE,2,1)
   MCODE3= SUBSTR(MCODE,3,1)
   MCODE4= SUBSTR(MCODE,4,1)
   MCODE5= SUBSTR(MCODE,5,1)
   MCODE6= SUBSTR(MCODE,6,1)
   FMCODE= CHR(ASC(MCODE1)-26)+CHR(ASC(MCODE2)-30)+CHR(ASC(MCODE3)-29)+CHR(ASC(MCODE4)-21)+CHR(ASC(MCODE5)-19)+CHR(ASC(MCODE6)-13)
   IF RLOCK()
      REPLACE PW WITH FMCODE
      FLUSH
   ENDIF
   SKIP
   R= R+2
   NCODE1= SUBSTR(PW,1,1)
   NCODE2= SUBSTR(PW,2,1)
   NCODE3= SUBSTR(PW,3,1)
   NCODE4= SUBSTR(PW,4,1)
   NCODE5= SUBSTR(PW,5,1)
   NCODE6= SUBSTR(PW,6,1)
   mm8     = chr(asc("&ncode1")+26)+chr(asc("&ncode2")+30)+chr(asc("&ncode3")+29)+chr(asc("&ncode4")+21)+chr(asc("&ncode5")+19)+chr(asc("&ncode6")+13)
   @ R, 24 SAY 'Password For Menu 8'
   @ R, 46 GET MM8 FUNCTION '!'
   READ
   MCODE= MM8
   MCODE1= SUBSTR(MCODE,1,1)
   MCODE2= SUBSTR(MCODE,2,1)
   MCODE3= SUBSTR(MCODE,3,1)
   MCODE4= SUBSTR(MCODE,4,1)
   MCODE5= SUBSTR(MCODE,5,1)
   MCODE6= SUBSTR(MCODE,6,1)
   FMCODE= CHR(ASC(MCODE1)-26)+CHR(ASC(MCODE2)-30)+CHR(ASC(MCODE3)-29)+CHR(ASC(MCODE4)-21)+CHR(ASC(MCODE5)-19)+CHR(ASC(MCODE6)-13)
   IF RLOCK()
      REPLACE PW WITH FMCODE
      FLUSH
   ENDIF
   ANS= ' '
   DO WHILE .not. ANS$'YN'
      @ 23, 20 SAY 'Any Change In These Passwords - Y/N ' GET ANS FUNCTION '!'
      READ
   ENDDO
   @ 23, 19 CLEAR TO 23, 66
   IF ANS='Y'
      R= 5
      GOTO TOP
      LOOP
   ENDIF
   EXIT
ENDDO
CLEAR
CLOSE ALL


RETURN
********************

**********************
PROCEDURE UNPOST
**********************

SET EXCLUSIVE ON
CLOSE ALL
CLEAR
ANS= ' '
DO WHILE .not. ANS$'YN'
   
   IF _DOS
    SET COLOR TO 7/1
   ENDIF
   
   CLEAR
   @ 10, 15 SAY ' This option will un-post all posted vouchers'
   @ 11, 15 SAY ' from the ledger.'
   @ 13, 15 SAY ' Do you want to continue...... Y/N ' GET ANS PICTURE '!'
   READ
   IF ANS='Y'
      EXIT
   ELSE
      CLEAR
      RETURN
   ENDIF
ENDDO
CLEAR
USE ldgrcode
DO WHILE .not. EOF()
   IF C3=0
      SKIP
      LOOP
   ENDIF
   REPLACE LDGR_BAL WITH OPEN_BAL, STATUS WITH OPEN_STAT, SR_NO WITH 1
   SKIP
   IF EOF()
      EXIT
   ENDIF
ENDDO
USE master
DELETE ALL FOR SR_NO<>1
PACK
USE TRAN
REPLACE FOR FLAG='Y' FLAG WITH ' '
SET EXCLUSIVE ON
CLOSE ALL
CLEAR

RETURN
**************************

**************************
PROCEDURE INITIAL
**************************

CLEAR
CLOSE ALL

IF _DOS
 SET COLOR TO 7/1
ENDIF

CLEAR
@ 10, 15 SAY 'Running this program will erase all data from'
@ 11, 15 SAY 'your data files'
P= ' '
DO WHILE .not. P$'YN'
   @ 12, 15 SAY 'Want to proceed ......Y/N' GET P FUNCTION '!'
   READ
   IF P='N'
      CLOSE ALL
      CLEAR
      RETURN
   ENDIF
   IF P='Y'
      CLEAR
      
      IF _DOS
       SET COLOR TO +7/1
      ENDIF
      
      @ 10, 25 SAY ' Please  Refer  to .... '
      @ 12, 25 SAY ' Amjad Izhar'
      
      IF _DOS
       SET COLOR TO 7/1
      ENDIF
      
      @ 14, 25 SAY ' Press any key to Return to Menu'
      WAIT ''
      CLOSE ALL
      CLEAR
      RETURN
   ENDIF
ENDDO

RETURN
*****************************

************************
PROCEDURE INIT_PW
************************

CLEAR
CLOSE ALL

IF _DOS
SET COLOR TO 7/1
ENDIF

CLEAR
@ 10, 15 SAY 'Running This Program Will Initialize All Passwords '
P= ' '
DO WHILE .not. P$'YN'
   @ 12, 15 SAY 'Want to proceed ......Y/N' GET P FUNCTION '!'
   READ
ENDDO
IF P='N'
   CLOSE ALL
   CLEAR
   RETURN
ENDIF
USE pw
GOTO TOP
STORE SPACE(6) TO MPW1, MPW2, MPW3, MPW4, MPW5, MPW6, MPW7, MPW8
R= 5
DO WHILE .T.
   MCODE= MPW1
   MCODE1= SUBSTR(MCODE,1,1)
   MCODE2= SUBSTR(MCODE,2,1)
   MCODE3= SUBSTR(MCODE,3,1)
   MCODE4= SUBSTR(MCODE,4,1)
   MCODE5= SUBSTR(MCODE,5,1)
   MCODE6= SUBSTR(MCODE,6,1)
   FMCODE= CHR(ASC(MCODE1)-26)+CHR(ASC(MCODE2)-30)+CHR(ASC(MCODE3)-29)+CHR(ASC(MCODE4)-21)+CHR(ASC(MCODE5)-19)+CHR(ASC(MCODE6)-13)
   IF RLOCK()
      REPLACE PW WITH FMCODE
      FLUSH
   ENDIF
   SKIP
   MCODE= MPW2
   MCODE1= SUBSTR(MCODE,1,1)
   MCODE2= SUBSTR(MCODE,2,1)
   MCODE3= SUBSTR(MCODE,3,1)
   MCODE4= SUBSTR(MCODE,4,1)
   MCODE5= SUBSTR(MCODE,5,1)
   MCODE6= SUBSTR(MCODE,6,1)
   FMCODE= CHR(ASC(MCODE1)-26)+CHR(ASC(MCODE2)-30)+CHR(ASC(MCODE3)-29)+CHR(ASC(MCODE4)-21)+CHR(ASC(MCODE5)-19)+CHR(ASC(MCODE6)-13)
   IF RLOCK()
      REPLACE PW WITH FMCODE
      FLUSH
   ENDIF
   SKIP
   MCODE= MPW3
   MCODE1= SUBSTR(MCODE,1,1)
   MCODE2= SUBSTR(MCODE,2,1)
   MCODE3= SUBSTR(MCODE,3,1)
   MCODE4= SUBSTR(MCODE,4,1)
   MCODE5= SUBSTR(MCODE,5,1)
   MCODE6= SUBSTR(MCODE,6,1)
   FMCODE= CHR(ASC(MCODE1)-26)+CHR(ASC(MCODE2)-30)+CHR(ASC(MCODE3)-29)+CHR(ASC(MCODE4)-21)+CHR(ASC(MCODE5)-19)+CHR(ASC(MCODE6)-13)
   IF RLOCK()
      REPLACE PW WITH FMCODE
      FLUSH
   ENDIF
   SKIP
   MCODE= MPW4
   MCODE1= SUBSTR(MCODE,1,1)
   MCODE2= SUBSTR(MCODE,2,1)
   MCODE3= SUBSTR(MCODE,3,1)
   MCODE4= SUBSTR(MCODE,4,1)
   MCODE5= SUBSTR(MCODE,5,1)
   MCODE6= SUBSTR(MCODE,6,1)
   FMCODE= CHR(ASC(MCODE1)-26)+CHR(ASC(MCODE2)-30)+CHR(ASC(MCODE3)-29)+CHR(ASC(MCODE4)-21)+CHR(ASC(MCODE5)-19)+CHR(ASC(MCODE6)-13)
   IF RLOCK()
      REPLACE PW WITH FMCODE
      FLUSH
   ENDIF
   SKIP
   MCODE= MPW5
   MCODE1= SUBSTR(MCODE,1,1)
   MCODE2= SUBSTR(MCODE,2,1)
   MCODE3= SUBSTR(MCODE,3,1)
   MCODE4= SUBSTR(MCODE,4,1)
   MCODE5= SUBSTR(MCODE,5,1)
   MCODE6= SUBSTR(MCODE,6,1)
   FMCODE= CHR(ASC(MCODE1)-26)+CHR(ASC(MCODE2)-30)+CHR(ASC(MCODE3)-29)+CHR(ASC(MCODE4)-21)+CHR(ASC(MCODE5)-19)+CHR(ASC(MCODE6)-13)
   IF RLOCK()
      REPLACE PW WITH FMCODE
      FLUSH
   ENDIF
   SKIP
   MCODE= MPW6
   MCODE1= SUBSTR(MCODE,1,1)
   MCODE2= SUBSTR(MCODE,2,1)
   MCODE3= SUBSTR(MCODE,3,1)
   MCODE4= SUBSTR(MCODE,4,1)
   MCODE5= SUBSTR(MCODE,5,1)
   MCODE6= SUBSTR(MCODE,6,1)
   FMCODE= CHR(ASC(MCODE1)-26)+CHR(ASC(MCODE2)-30)+CHR(ASC(MCODE3)-29)+CHR(ASC(MCODE4)-21)+CHR(ASC(MCODE5)-19)+CHR(ASC(MCODE6)-13)
   IF RLOCK()
      REPLACE PW WITH FMCODE
      FLUSH
   ENDIF
   SKIP
   MCODE= MPW7
   MCODE1= SUBSTR(MCODE,1,1)
   MCODE2= SUBSTR(MCODE,2,1)
   MCODE3= SUBSTR(MCODE,3,1)
   MCODE4= SUBSTR(MCODE,4,1)
   MCODE5= SUBSTR(MCODE,5,1)
   MCODE6= SUBSTR(MCODE,6,1)
   FMCODE= CHR(ASC(MCODE1)-26)+CHR(ASC(MCODE2)-30)+CHR(ASC(MCODE3)-29)+CHR(ASC(MCODE4)-21)+CHR(ASC(MCODE5)-19)+CHR(ASC(MCODE6)-13)
   IF RLOCK()
      REPLACE PW WITH FMCODE
      FLUSH
   ENDIF
   SKIP
   MCODE= MPW8
   MCODE1= SUBSTR(MCODE,1,1)
   MCODE2= SUBSTR(MCODE,2,1)
   MCODE3= SUBSTR(MCODE,3,1)
   MCODE4= SUBSTR(MCODE,4,1)
   MCODE5= SUBSTR(MCODE,5,1)
   MCODE6= SUBSTR(MCODE,6,1)
   FMCODE= CHR(ASC(MCODE1)-26)+CHR(ASC(MCODE2)-30)+CHR(ASC(MCODE3)-29)+CHR(ASC(MCODE4)-21)+CHR(ASC(MCODE5)-19)+CHR(ASC(MCODE6)-13)
   IF RLOCK()
      REPLACE PW WITH FMCODE
      FLUSH
   ENDIF
   EXIT
ENDDO
CLEAR
CLOSE ALL

RETURN
******************************



***************************
PROCEDURE LOCK_ENT
***************************

CLEAR
CLOSE ALL
SET CONFIRM OFF

IF _DOS
SET COLOR TO 7/1
ENDIF

SET DELETED ON
SELECT 1
USE ldgrcode ORDER ac1
DO WHILE .T.
   CLEAR
   R= 8
   DO top IN tbl_proc.prg
   
   IF _DOS
   SET COLOR TO +7/1
   ENDIF
   
   @ 6, 28 SAY 'Party Locks .. Entry  '
   
   IF _DOS
   SET COLOR TO 7/1
   ENDIF
   
   @ 23, 1 TO 23, 79
   STORE 0 TO MC1, MC2, MC3, MLDGR_BAL
   @ 24, 51 SAY 'Press Ctrl Q To Quit '
   @ R, 8 SAY 'Ledger Head Code '
   
   IF _DOS
   SET COLOR TO /w
   ENDIF
   
   @ R, 30 SAY '  -  -   '
   @ R, 30 GET MC1 PICTURE '@z 99'

IF _DOS
   SET COLOR TO 7/1
ENDIF

   READ
   IF READKEY()=12
      CLEAR
      CLOSE ALL
      SET CONFIRM OFF
      RETURN
   ENDIF
   @ 24, 50 CLEAR TO 24, 78
   IF MC1=0
      LOOP
   ENDIF
   MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MC1))))+LTRIM(STR(MC1))

IF _DOS
   SET COLOR TO /w
ENDIF

   @ R, 30 SAY MPC1

IF _DOS
   SET COLOR TO 7/1
ENDIF

   @ R, 33 GET MC2 PICTURE '@z 99'
   READ
   MPC2= REPLICATE('0',2-LEN(LTRIM(STR(MC2))))+LTRIM(STR(MC2))

IF _DOS
   SET COLOR TO /w 
ENDIF

   @ R, 33 SAY MPC2

IF _DOS
   SET COLOR TO 7/1
ENDIF

   @ R, 36 GET MC3 PICTURE '@z 999'
   READ
   IF MC3=0
      LOOP
   ENDIF
   MPC3= REPLICATE('0',3-LEN(LTRIM(STR(MC3))))+LTRIM(STR(MC3))

IF _DOS
   SET COLOR TO /w 
ENDIF

   @ R, 36 SAY MPC3

IF _DOS
   SET COLOR TO 7/1
ENDIF

   IF READKEY()=12
      CLOSE ALL
      CLEAR
      SET CONFIRM OFF
      RETURN
   ENDIF
   SELECT 1
   STORE STR(MC1,2)+STR(MC2,2)+STR(MC3,3) TO MLCODE
   SEEK MLCODE
   IF .not. FOUND()
      @ 24, 15 SAY 'This Code Does Not Exist -- Please Re-try '
      WAIT ''
      @ 24, 8 CLEAR TO 24, 63
      LOOP
   ENDIF
   IF LOCK='Y'
      @ 24, 12 SAY 'This Party Code Is Already Defined As Lock -- Please Re-try '
      WAIT ''
      @ 24, 8 CLEAR TO 24, 63
      LOOP
   ENDIF
   SELECT 1
   R= R+2
   @ R, 8 SAY 'Title of Ledger Head '

IF _DOS
   SET COLOR TO /w
ENDIF

   @ R, 30 SAY TITLE

IF _DOS
   SET COLOR TO 7/1
ENDIF

   R= R+2
   IF ADDRESS1<>SPACE(25)
      @ R, 8 SAY 'Address              '

IF _DOS
      SET COLOR TO /w
ENDIF

      @ R, 30 SAY ADDRESS1

IF _DOS
      SET COLOR TO 7/1
ENDIF

      R= R+2
      @ R, 8 SAY '                     '

IF _DOS
      SET COLOR TO /w
ENDIF

      @ R, 30 SAY ADDRESS2

IF _DOS
      SET COLOR TO 7/1
ENDIF

      R= R+2
   ENDIF
   P= ' '
   DO WHILE .not. P$'YN'
      @ 24, 25 SAY 'Are you Sure - Y/N' GET P FUNCTION '!'
      READ
   ENDDO
   @ 24, 1 CLEAR TO 24, 64
   IF P='Y'
      SELECT 1
      REPLACE LOCK WITH 'Y'
   ENDIF
   P= ' '
   DO WHILE .not. P$'YN'
      @ 24, 24 SAY 'More Data Entry - Y/N' GET P FUNCTION '!'
      READ
   ENDDO
   IF P='N'
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
ENDDO

RETURN
******************



***********************
PROCEDURE LOCK_DEL
***********************


CLEAR
CLOSE ALL
SET CONFIRM OFF

IF _DOS
SET COLOR TO 7/1
ENDIF

SET DELETED ON
SELECT 1
USE ldgrcode ORDER ac1
DO WHILE .T.
   CLEAR
   R= 8
   DO top IN tbl_proc.prg

IF _DOS
   SET COLOR TO +7/1
ENDIF

   @ 6, 28 SAY 'Party Locks .. Deletion '

IF _DOS
   SET COLOR TO 7/1
ENDIF

   @ 23, 1 TO 23, 79
   STORE 0 TO MC1, MC2, MC3, MLDGR_BAL
   @ 24, 51 SAY 'Press Ctrl Q To Quit '
   @ R, 8 SAY 'Ledger Head Code '

IF _DOS
   SET COLOR TO /w
ENDIF

   @ R, 30 SAY '  -  -   '
   @ R, 30 GET MC1 PICTURE '@z 99'

IF _DOS
   SET COLOR TO 7/1
ENDIF

   READ
   IF READKEY()=12
      CLEAR
      CLOSE ALL
      SET CONFIRM OFF
      RETURN
   ENDIF
   @ 24, 50 CLEAR TO 24, 78
   IF MC1=0
      LOOP
   ENDIF
   MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MC1))))+LTRIM(STR(MC1))

IF _DOS
   SET COLOR TO /w
ENDIF

   @ R, 30 SAY MPC1

IF _DOS
   SET COLOR TO 7/1
ENDIF

   @ R, 33 GET MC2 PICTURE '@z 99'
   READ
   MPC2= REPLICATE('0',2-LEN(LTRIM(STR(MC2))))+LTRIM(STR(MC2))

IF _DOS
   SET COLOR TO /w 
ENDIF

   @ R, 33 SAY MPC2

IF _DOS
   SET COLOR TO 7/1
ENDIF

   @ R, 36 GET MC3 PICTURE '@z 999'
   READ
   IF MC3=0
      LOOP
   ENDIF
   MPC3= REPLICATE('0',3-LEN(LTRIM(STR(MC3))))+LTRIM(STR(MC3))

IF _DOS
   SET COLOR TO /w 
ENDIF

   @ R, 36 SAY MPC3

IF _DOS
   SET COLOR TO 7/1
ENDIF

   IF READKEY()=12
      CLOSE ALL
      CLEAR
      SET CONFIRM OFF
      RETURN
   ENDIF
   SELECT 1
   STORE STR(MC1,2)+STR(MC2,2)+STR(MC3,3) TO MLCODE
   SEEK MLCODE
   IF .not. FOUND()
      @ 24, 15 SAY 'This Code Does Not Exist -- Please Re-try '
      WAIT ''
      @ 24, 8 CLEAR TO 24, 63
      LOOP
   ENDIF
   IF LOCK=' '
      @ 24, 12 SAY 'This Party Code Has Not Been Defined As Lock -- Please Re-try '
      WAIT ''
      @ 24, 8 CLEAR TO 24, 63
      LOOP
   ENDIF
   SELECT 1
   R= R+2
   @ R, 8 SAY 'Title of Ledger Head '

IF _DOS
   SET COLOR TO /w
ENDIF

   @ R, 30 SAY TITLE

IF _DOS
   SET COLOR TO 7/1
ENDIF

   R= R+2
   IF ADDRESS1<>SPACE(25)
      @ R, 8 SAY 'Address              '

IF _DOS
      SET COLOR TO /w
ENDIF

      @ R, 30 SAY ADDRESS1

IF _DOS
      SET COLOR TO 7/1
ENDIF

      R= R+2
      @ R, 8 SAY '                     '

IF _DOS
      SET COLOR TO /w
ENDIF

      @ R, 30 SAY ADDRESS2

IF _DOS
      SET COLOR TO 7/1
ENDIF

      R= R+2
   ENDIF
   P= ' '
   DO WHILE .not. P$'YN'
      @ 24, 25 SAY 'Are you Sure - Y/N' GET P FUNCTION '!'
      READ
   ENDDO
   @ 24, 1 CLEAR TO 24, 64
   IF P='Y'
      SELECT 1
      REPLACE LOCK WITH ' '
   ENDIF
   P= ' '
   DO WHILE .not. P$'YN'
      @ 24, 24 SAY 'More Data Entry - Y/N' GET P FUNCTION '!'
      READ
   ENDDO
   IF P='N'
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
ENDDO

RETURN
****************


*************************
PROCEDURE LOCK_PRT
**************************

CLEAR
CLOSE ALL
SET CONFIRM OFF

IF _DOS
SET COLOR TO 7/1
ENDIF

CLEAR
USE ldgrcode ORDER ac1
IF RECCOUNT()=0
   CLEAR
   @ 12, 5 SAY 'No Ledger Heads Exist in Data File  -  Press any key to return to menu .... '
   WAIT ''
   CLEAR
   CLOSE ALL
   RETURN
ENDIF
MC1= 0
DO WHILE .T.

IF _DOS
   SET COLOR TO +7/1
ENDIF

   @ 10, 14 SAY 'Please give "First Level Code" '
   @ 11, 14 SAY 'that you have Defined in your Chart of Accounts.'
   @ 11, 66 GET MC1 PICTURE '99'
   @ 11, 69 SAY '-xx-xxx'

IF _DOS
   SET COLOR TO 7/1
ENDIF

   READ
   IF MC1=0.or.MC1<10
      LOOP
   ENDIF
   EXIT
ENDDO
SET FILTER TO C1=MC1.and.LOCK='Y'
GOTO TOP
P= ' '
DO WHILE .not. P$'PSQ'
   @ 22, 40 SAY 'Printer/Screen/Quit  -  P/S/Q  ' GET P FUNCTION '!'
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
CNT= 0
PAGE= 1
HEADING= .T.
DO WHILE .not. EOF()
   IF HEADING
      L= 3
      IF P='P'
		 do PRNCHK in tbl_proc
         DO top_prt1 IN tbl_proc.prg
         @ 2, 15 SAY CHR(18)
         @ 2, 32 SAY 'LIST OF CODES '
         @ 3, 32 SAY '--------------'
         @ 4, 65 SAY 'Page -'
         @ 4, 71 SAY PAGE PICTURE '99'
         L= L+1
      ELSE
         DO screen IN tbl_proc.prg
         @ 3, 32 SAY 'LIST OF CODES '
         L= L+1
         @ L, 32 SAY '------------- '
         L= L+1
         @ L, 65 SAY 'Page - '
         @ L, 70 SAY PAGE PICTURE '999'
         CNT= 0
         MREC2= RECNO()
      ENDIF
      L= L+1
      @ L, 5 SAY REPLICATE('-',72)
      L= L+1
      @ L, 8 SAY 'Code'
      @ L, 25 SAY 'Title '
      L= L+1
      @ L, 5 SAY REPLICATE('-',72)
      HEADING= .F.
      L= L+1
   ENDIF
   IF C3=0
      SKIP
      LOOP
   ENDIF
   IF C2=0.and.C3=0.and.RIGHT(STR(C1),1)='0'
      L= L+1
      MPC1= REPLICATE('0',2-LEN(LTRIM(STR(C1))))+LTRIM(STR(C1))
      @ L, 5 SAY MPC1
      @ L, 7 SAY '-'
      MPC2= REPLICATE('0',2-LEN(LTRIM(STR(C2))))+LTRIM(STR(C2))
      @ L, 8 SAY MPC2
      @ L, 10 SAY '-'
      MPC3= REPLICATE('0',3-LEN(LTRIM(STR(C3))))+LTRIM(STR(C3))
      @ L, 11 SAY MPC3
      @ L, 20 SAY TITLE
      MLEN= LEN(RTRIM(TITLE))
      L= L+1
      @ L, 5 SAY REPLICATE('-',15+MLEN)
   ENDIF
   IF C3=0.and.RIGHT(STR(C1),1)<>'0'
      L= L+1
      MPC1= REPLICATE('0',2-LEN(LTRIM(STR(C1))))+LTRIM(STR(C1))
      @ L, 5 SAY MPC1
      @ L, 7 SAY '-'
      MPC2= REPLICATE('0',2-LEN(LTRIM(STR(C2))))+LTRIM(STR(C2))
      @ L, 8 SAY MPC2
      @ L, 10 SAY '-'
      MPC3= REPLICATE('0',3-LEN(LTRIM(STR(C3))))+LTRIM(STR(C3))
      @ L, 11 SAY MPC3
      @ L, 20 SAY TITLE
   ELSE
      IF C3<>0
         MPC1= REPLICATE('0',2-LEN(LTRIM(STR(C1))))+LTRIM(STR(C1))
         @ L, 8 SAY MPC1
         @ L, 10 SAY '-'
         MPC2= REPLICATE('0',2-LEN(LTRIM(STR(C2))))+LTRIM(STR(C2))
         @ L, 11 SAY MPC2
         @ L, 13 SAY '-'
         MPC3= REPLICATE('0',3-LEN(LTRIM(STR(C3))))+LTRIM(STR(C3))
         @ L, 14 SAY MPC3
         @ L, 20 SAY TITLE
      ENDIF
   ENDIF
   SKIP
   CNT= CNT+1
   L= L+2
   IF P='S'.and.L>=19
      @ 23, 1 SAY REPLICATE('-',79)
      @ 24, 5 SAY 'For Next Page Press :'
      @ 24, 30 SAY 'For Previous Page :'
      @ 24, 60 SAY 'Quit :'

IF _DOS
      SET COLOR TO /w
ENDIF

      @ 24, 27 SAY CHR(25)
      @ 24, 50 SAY CHR(24)
      @ 24, 67 SAY CHR(17)+CHR(45)+CHR(45)

IF _DOS
      SET COLOR TO 7/1
ENDIF

      CHO= 0
      DO WHILE .T.
         @ 24, 70 GET CHO PICTURE '@z 9'
         READ
         IF READKEY()=0.or.READKEY()=4.or.READKEY()=5
            EXIT
         ENDIF
      ENDDO
      IF READKEY()=0
         CLEAR
         CLOSE ALL
         CLOSE DATA
         RETURN
      ENDIF
      IF READKEY()=4
         CLEAR
         GOTO MREC2
         SKIP  -CNT
         HEADING= .T.
         PAGE= PAGE-1
         IF PAGE<=1
            PAGE= 1
         ENDIF
      ENDIF
      IF READKEY()=5
         CLEAR
         HEADING= .T.
         PAGE= PAGE+1
      ENDIF
   ENDIF
   IF P='P'.and.L>56
      HEADING= .T.
      PAGE= PAGE+1
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
CLEAR
CLOSE ALL

RETURN
**********************

***********************
PROCEDURE LOCKPRT
***********************

CLEAR
CLOSE ALL
SET CONFIRM OFF

IF _DOS
SET COLOR TO 7/1
ENDIF

CLEAR
USE ldgrcode ORDER tit
IF RECCOUNT()=0
   CLEAR
   @ 12, 5 SAY 'No Ledger Heads Exist in Data File  -  Press any key to return to menu .... '
   WAIT ''
   CLEAR
   CLOSE ALL
   RETURN
ENDIF
MC1= 0
DO WHILE .T.

IF _DOS
   SET COLOR TO +7/1
ENDIF

   @ 10, 14 SAY 'Please give "First Level Code" '
   @ 11, 14 SAY 'that you have Defined in your Chart of Accounts.'

IF _DOS
   SET COLOR TO 7/1
ENDIF

   @ 11, 66 GET MC1 PICTURE '99'
   @ 11, 69 SAY '-xx-xxx'
   READ
   IF MC1=0.or.MC1<10
      LOOP
   ENDIF
   EXIT
ENDDO
SET FILTER TO C1=MC1.and.LOCK='Y'
GOTO TOP
P= ' '
DO WHILE .not. P$'PSQ'
   @ 22, 40 SAY 'Printer/Screen/Quit  -  P/S/Q  ' GET P FUNCTION '!'
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
CNT= 0
PAGE= 1
HEADING= .T.
DO WHILE .not. EOF()
   IF HEADING
      L= 3
      IF P='P'
		 do PRNCHK in tbl_proc
         DO top_prt1 IN tbl_proc.prg
         @ 2, 15 SAY CHR(18)
         @ 2, 36 SAY 'LIST OF CODES '
         @ 3, 36 SAY '------------- '
         @ 4, 32 SAY '(Alphabetically Sorted)'
         @ 4, 65 SAY 'Page -'
         @ 4, 71 SAY PAGE PICTURE '99'
         L= L+1
      ELSE
         DO SCREEN IN tbl_proc.prg
         @ 3, 36 SAY 'LIST OF CODES '
         L= L+1
         @ L, 36 SAY '------------- '
         L= L+1
         @ L, 32 SAY '(Alphabetically Sorted)          Page - '
         @ L, 70 SAY PAGE PICTURE '999'
         CNT= 0
         MREC2= RECNO()
      ENDIF
      L= L+1
      @ L, 5 SAY REPLICATE('-',72)
      L= L+1
      @ L, 8 SAY 'Code'
      @ L, 25 SAY 'Title'
      L= L+1
      @ L, 5 SAY REPLICATE('-',72)
      HEADING= .F.
      L= L+1
   ENDIF
   IF C3=0
      SKIP
      LOOP
   ENDIF
   IF C2=0.and.C3=0.and.RIGHT(STR(C1),1)='0'
      L= L+1
      MPC1= REPLICATE('0',2-LEN(LTRIM(STR(C1))))+LTRIM(STR(C1))
      @ L, 5 SAY MPC1
      @ L, 7 SAY '-'
      MPC2= REPLICATE('0',2-LEN(LTRIM(STR(C2))))+LTRIM(STR(C2))
      @ L, 8 SAY MPC2
      @ L, 10 SAY '-'
      MPC3= REPLICATE('0',3-LEN(LTRIM(STR(C3))))+LTRIM(STR(C3))
      @ L, 11 SAY MPC3
      @ L, 20 SAY TITLE
      MLEN= LEN(RTRIM(TITLE))
      L= L+1
      @ L, 5 SAY REPLICATE('-',15+MLEN)
   ENDIF
   IF C3=0.and.RIGHT(STR(C1),1)<>'0'
      L= L+1
      MPC1= REPLICATE('0',2-LEN(LTRIM(STR(C1))))+LTRIM(STR(C1))
      @ L, 5 SAY MPC1
      @ L, 7 SAY '-'
      MPC2= REPLICATE('0',2-LEN(LTRIM(STR(C2))))+LTRIM(STR(C2))
      @ L, 8 SAY MPC2
      @ L, 10 SAY '-'
      MPC3= REPLICATE('0',3-LEN(LTRIM(STR(C3))))+LTRIM(STR(C3))
      @ L, 11 SAY MPC3
      @ L, 20 SAY TITLE
   ELSE
      IF C3<>0
         MPC1= REPLICATE('0',2-LEN(LTRIM(STR(C1))))+LTRIM(STR(C1))
         @ L, 8 SAY MPC1
         @ L, 10 SAY '-'
         MPC2= REPLICATE('0',2-LEN(LTRIM(STR(C2))))+LTRIM(STR(C2))
         @ L, 11 SAY MPC2
         @ L, 13 SAY '-'
         MPC3= REPLICATE('0',3-LEN(LTRIM(STR(C3))))+LTRIM(STR(C3))
         @ L, 14 SAY MPC3
         @ L, 20 SAY TITLE
      ENDIF
   ENDIF
   SKIP
   CNT= CNT+1
   L= L+2
   IF P='S'.and.L>=21
      @ 23, 1 SAY REPLICATE('-',79)
      @ 24, 5 SAY 'For Next Page Press :'
      @ 24, 30 SAY 'For Previous Page :'
      @ 24, 60 SAY 'Quit :'

IF _DOS
      SET COLOR TO /w
ENDIF

      @ 24, 27 SAY CHR(25)
      @ 24, 50 SAY CHR(24)
      @ 24, 67 SAY CHR(17)+CHR(45)+CHR(45)

IF _DOS
      SET COLOR TO 7/1
ENDIF


      CHO= 0
      DO WHILE .T.
         @ 24, 70 GET CHO PICTURE '@z 9'
         READ
         IF READKEY()=0.or.READKEY()=4.or.READKEY()=5
            EXIT
         ENDIF
      ENDDO
      IF READKEY()=0
         CLEAR
         CLOSE ALL
         CLOSE DATA
         RETURN
      ENDIF
      IF READKEY()=4
         CLEAR
         GOTO MREC2
         SKIP  -CNT
         HEADING= .T.
         PAGE= PAGE-1
         IF PAGE<=1
            PAGE= 1
         ENDIF
      ENDIF
      IF READKEY()=5
         CLEAR
         HEADING= .T.
         PAGE= PAGE+1
      ENDIF
   ENDIF
   IF P='P'.and.L>56
      HEADING= .T.
      PAGE= PAGE+1
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
CLEAR
CLOSE ALL

RETURN
*************************

