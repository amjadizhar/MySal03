* PROGRAM : STCKPROC.PRG
* WRITTEN BY : AMJAD IZHAR
* WRITTEN ON : 01ST JUN. 2005
* THIS REVISION: 01ST JUNE. 2005 10:00 AM
*********************************************


*1-
************************
PROCEDURE STCK_MEN
************************
DO WHILE .T.
   USE st-key ORDER st_idx
   DELETE ALL FOR FLAG=' '
   CLEAR
   CLOSE ALL
   L= 8
   M= 25

IF _DOS
   SET COLOR TO 7/1
ELSE
	SET COLOR TO
ENDIF	

   CLEAR

   DO top IN TBL_PROC.PRG
   DO bot IN TBL_PROC.PRG

IF _DOS
   SET COLOR TO +7/1
ELSE
	SET COLOR TO
ENDIF	

   @ 6, 20 SAY 'I n v e n t o r y   S t o c k   T r a n s f e r '

IF _DOS
   SET COLOR TO 7/1
ELSE
	SET COLOR TO
ENDIF	

   @ L+0, M PROMPT ' 1 - Stock Transfer ..... Entry      '
   @ L+2, M PROMPT ' 2 - Stock Transfer ..... Correction '
   @ L+4, M PROMPT ' 3 - Stock Transfer ..... Deletion   '
   @ L+6, M PROMPT ' 4 - Stock Transfer ..... Printing   '
   @ L+8, M PROMPT ' 5 - Stock Transfer ..... Display    '
   @ L+10, M PROMPT ' 9 - Return to Previous Menu         '
   MCHOICE= 0
   MENU TO MCHOICE
   DO CASE
      CASE MCHOICE=1
         CLEAR
         DO stck_ent
      CASE MCHOICE=2
         CLEAR
         DO stck_cor
      CASE MCHOICE=3
         CLEAR
         DO stck_del
      CASE MCHOICE=4
         CLEAR
         DO stck_prt
      CASE MCHOICE=5
         CLEAR
         DO stck_dis
      CASE MCHOICE=6
         CLEAR
         CLOSE ALL
         RETURN
   ENDCASE
ENDDO
RETURN
****************

*2-
**************************
PROCEDURE STCK_ENT
**************************

CLEAR
CLOSE ALL

SET DATE brit
SELECT 3

USE item ORDER item_idx
SELECT 4

USE loc ORDER loc_idx
SELECT 6

USE item-bal ORDER itm_bal


DO WHILE .T.

   CLEAR
   MDOC_TYPE= 8

   @ 1, 30 SAY 'STOCK TRANSFER ENTRY '

   STORE DATE() TO MDATE, MDEADLINE
   STORE 0 TO MDOC_NO, MC1, MC2, MC3, MLOC_CODE2, MORDER_NO, MLOC_CODE
   STORE 0 TO MI1, MI2, MI3, MQTY_ORD, MRATE, MQTY, MRATE, MTOT, MSR_NO
   R= 3

   DO WHILE .T.
      @ 23, 50 SAY 'Press Ctrl Q To Quit '
      @ R, 8 SAY 'Transfer Voucher No' GET MDOC_NO PICTURE '9999999'
      READ

      IF READKEY()=12
         CLEAR
         CLOSE ALL
         RETURN
      ENDIF

      @ 23, 45 CLEAR TO 23, 78

      IF MDOC_NO=0
         LOOP
      ENDIF

      MVCH_NO= REPLICATE('0',7-LEN(LTRIM(STR(MDOC_NO))))+LTRIM(STR(MDOC_NO))

IF _DOS
      SET COLOR TO /g
ELSE
	SET COLOR TO
ENDIF	

      @ R, 28 SAY MVCH_NO

IF _DOS
      SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

      SELECT 2
      USE st-key ORDER st_idx
      SEEK STR(MDOC_NO,7)+STR(MDOC_TYPE,1)

      IF FOUND()
         @ 24, 1 SAY SPACE(78)
         @ 24, 15 SAY 'This T.R. No Already Exists  -- Press any key'
         WAIT ''

IF _DOS
         SET COLOR TO 7/1 
ELSE
	SET COLOR TO
ENDIF	

         @ 24, 10 SAY SPACE(75)
         LOOP
      ENDIF

      APPEND BLANK
      IF .not. RLOCK()
         rlock()
      ENDIF
      REPLACE DOC_NO WITH MDOC_NO, DOC_TYPE WITH MDOC_TYPE
      UNLOCK
      SELECT 2
      USE
      @ R, 40 SAY 'Date   ' GET MDATE
      READ

      DO chk IN TBL_PROC.PRG

      R= R+2
      ABC= 0
      DO WHILE ABC=0
         @ R, 8 SAY 'From Location      ' GET MLOC_CODE PICTURE '9999'
         READ
         IF MLOC_CODE=0
            LOOP
         ENDIF
         SELECT 4
         SEEK MLOC_CODE
         IF .not. FOUND()
            ?? CHR(7)
            @ 23, 15 SAY 'This Code Does Not Exist ... Please Re-try'
            WAIT ''
            @ 23, 10 SAY SPACE(50)
            LOOP
         ENDIF

IF _DOS
         SET COLOR TO /w      
ELSE
	SET COLOR TO
ENDIF	

         @ R, 40 SAY LOC

IF _DOS
         SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

         MLOC= LOC
         ABC= 1
      ENDDO
      R= R+2
      ABC= 0
      DO WHILE ABC=0
         @ R, 8 SAY 'To   Location      ' GET MLOC_CODE2 PICTURE '9999'
         READ
         IF MLOC_CODE2=0
            LOOP
         ENDIF
         IF MLOC_CODE2=MLOC_CODE
            LOOP
         ENDIF
         SELECT 4
         SEEK MLOC_CODE2
         IF .not. FOUND()
            ?? CHR(7)
            @ 23, 15 SAY 'This Code Does Not Exist ... Please Re-try'
            WAIT ''
            @ 23, 10 SAY SPACE(50)
            LOOP
         ENDIF

IF _DOS
         SET COLOR TO /w      
ELSE
	SET COLOR TO
ENDIF	

         @ R, 40 SAY LOC

IF _DOS
         SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

         MLOC2= LOC
         ABC= 1
      ENDDO
      R= R+1
      @ R, 1 TO R, 79
      R= R+1
      @ R, 2 SAY 'Item Code'
      @ R, 13 SAY 'Item '
      @ R, 46 SAY 'Unit '
      @ R, 55 SAY 'Qty '
      @ R, 76 SAY 'More'
      R= R+1
      @ R, 0 TO R, 79 DOUBLE
      R= R+1
      DO WHILE .T.
         ABC= 0
         DO WHILE ABC=0

IF _DOS
            SET COLOR TO /w
ELSE
	SET COLOR TO
ENDIF	

            @ R, 2 SAY '  -  -    '

IF _DOS
            SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

            @ R, 2 GET MI1 PICTURE '99'
            READ

IF _DOS
            SET COLOR TO n/g
ELSE
	SET COLOR TO
ENDIF	

            MP1= REPLICATE('0',2-LEN(LTRIM(STR(MI1))))+LTRIM(STR(MI1))
            @ R, 2 SAY MP1
            @ R, 4 SAY '-'
            @ R, 5 GET MI2 PICTURE '99'
            READ
            MP2= REPLICATE('0',2-LEN(LTRIM(STR(MI2))))+LTRIM(STR(MI2))
            @ R, 5 SAY MP2
            @ R, 7 SAY '-'
            @ R, 8 GET MI3 PICTURE '9999'
            READ
            IF MI3=0
               LOOP
            ENDIF
            MP3= REPLICATE('0',4-LEN(LTRIM(STR(MI3))))+LTRIM(STR(MI3))
            @ R, 8 SAY MP3

IF _DOS
            SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

            IF READKEY()=12
               CLEAR
               CLOSE ALL
               RETURN
            ENDIF
            @ 23, 45 CLEAR TO 23, 78
            IF MI1=0.and.MI2=0.and.MI3=0
               LOOP
            ENDIF
            SELECT 3
            STORE STR(MI1,2)+STR(MI2,2)+STR(MI3,4) TO MI_CODE
            SEEK MI_CODE
            IF .not. FOUND()
               ?? CHR(7)
               @ 23, 15 SAY 'This Item Code Does Not Exist ... Please Re-try'
               WAIT ''
               @ 23, 10 SAY SPACE(55)
               LOOP
            ELSE
               MUNIT= UNIT
            ENDIF

IF _DOS
            SET COLOR TO /w      
ELSE
	SET COLOR TO
ENDIF	

            @ R, 13 SAY ITEM

IF _DOS
            SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

            STORE STR(MLOC_CODE,4)+STR(MI1,2)+STR(MI2,2)+STR(MI3,4) TO XYZ
            SELECT 6
            SEEK XYZ
            IF .not. FOUND()
               @ 21, 1 SAY 'Opening Balance For This Item At This Location Does Not Exists . Please Re-try'
               WAIT ''
               @ 21, 1 SAY SPACE(79)
               LOOP
            ENDIF
            STORE STR(MLOC_CODE2,4)+STR(MI1,2)+STR(MI2,2)+STR(MI3,4) TO XYZ
            SELECT 6
            SEEK XYZ
            IF .not. FOUND()
               @ 21, 1 SAY 'Opening Balance For This Item At This Location Does Not Exists . Please Re-try'
               WAIT ''
               @ 21, 1 SAY SPACE(79)
               LOOP
            ENDIF
            ABC= 1
         ENDDO

IF _DOS
         SET COLOR TO /w 
ELSE
	SET COLOR TO
ENDIF	

         @ R, 46 SAY MUNIT

IF _DOS
         SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

         DO WHILE .T.
            @ R, 55 GET MQTY PICTURE '9999999.9999'
            READ
            IF MQTY=0
               LOOP
            ENDIF
            EXIT
         ENDDO
         ANS= ' '
         DO WHILE .not. ANS$'YN'
            ANS= 'Y'
            @ R, 79 GET ANS PICTURE '!'
            READ
         ENDDO
         SELECT 5
         USE st-work
         MSR_NO= MSR_NO+1
         APPEND BLANK
         IF .not. RLOCK()
            rlock()
         ENDIF
         REPLACE DOC_NO WITH MDOC_NO, DOC_TYPE WITH 8, DATE WITH MDATE
         REPLACE T_QTY WITH MQTY, LOC_CODE WITH MLOC_CODE, SR_NO WITH MSR_NO
         REPLACE I1 WITH MI1, I2 WITH MI2, I3 WITH MI3, F_T WITH 'F'
         UNLOCK
         MSR_NO= MSR_NO+1
         APPEND BLANK
         IF .not. RLOCK()
            rlock()
         ENDIF
         REPLACE DOC_NO WITH MDOC_NO, DOC_TYPE WITH 8, DATE WITH MDATE
         REPLACE T_QTY WITH MQTY, LOC_CODE WITH MLOC_CODE2, SR_NO WITH MSR_NO
         REPLACE I1 WITH MI1, I2 WITH MI2, I3 WITH MI3, F_T WITH 'T'
         UNLOCK
         USE
         IF ANS='Y'
            IF R<=21
               STORE 0 TO MI1, MI2, MI3, MQTY
               R= R+1
               LOOP
            ELSE
               STORE 0 TO MI1, MI2, MI3, MQTY
               @ 11, 0 CLEAR TO 24, 79
               R= 11
               LOOP
            ENDIF
         ENDIF
         ANS= ' '
         DO WHILE .not. ANS$'YN'
            @ 24, 25 SAY 'Any Correction - Y/N' GET ANS FUNCTION '!'
            READ
         ENDDO
         IF ANS='Y'
            DO stk-cor
         ENDIF
         SELECT 2
         USE st-tran ORDER stidx
         APPEND FROM st-work FOR DOC_TYPE=MDOC_TYPE.and.DOC_NO=MDOC_NO
         USE
         SELECT 2
         USE st-key ORDER st_idx
         SEEK STR(MDOC_NO,7)+STR(MDOC_TYPE,1)
         IF FOUND()
            REPLACE FLAG WITH 'Y'
         ENDIF
         USE
         SELECT 5
         USE st-work
         DELETE ALL FOR DOC_TYPE=MDOC_TYPE.and.DOC_NO=MDOC_NO
         USE
         EXIT
      ENDDO
      ANS= ' '
      DO WHILE .not. ANS$'YN'
         @ 24, 25 SAY 'More Data Entry - Y/N' GET ANS FUNCTION '!'
         READ
      ENDDO
      IF ANS='N'
         CLEAR
         CLOSE ALL
         RETURN
      ENDIF
      EXIT
   ENDDO
ENDDO
RETURN
*************


*3-
**************************
PROCEDURE STK_DSP
*************************
R= 11
@ R, 0 CLEAR TO 24, 79
SELECT 5
GOTO MREC2
DO WHILE .not. EOF()
   MI1= I1
   MI2= I2
   MI3= I3

IF _DOS
   SET COLOR TO /w
ELSE
	SET COLOR TO
ENDIF	

   @ R, 2 SAY '  -  -    '
   @ R, 2 SAY MI1 PICTURE '99'

IF _DOS
   SET COLOR TO n/g
ELSE
	SET COLOR TO
ENDIF	

   MP1= REPLICATE('0',2-LEN(LTRIM(STR(MI1))))+LTRIM(STR(MI1))
   @ R, 2 SAY MP1
   @ R, 4 SAY '-'
   @ R, 5 SAY MI2 PICTURE '99'
   MP2= REPLICATE('0',2-LEN(LTRIM(STR(MI2))))+LTRIM(STR(MI2))
   @ R, 5 SAY MP2
   @ R, 7 SAY '-'
   @ R, 8 SAY MI3 PICTURE '9999'
   MP3= REPLICATE('0',4-LEN(LTRIM(STR(MI3))))+LTRIM(STR(MI3))
   @ R, 8 SAY MP3

IF _DOS
   SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

   SELECT 2
   STORE STR(MI1,2)+STR(MI2,2)+STR(MI3,4) TO MI_CODE
   SEEK MI_CODE
   IF .not. FOUND()
      ?? CHR(7)
      @ 23, 15 SAY 'This Item Code Does Not Exist ... Please Re-try'
      WAIT ''
      @ 23, 10 SAY SPACE(55)
      LOOP
   ELSE
      MUNIT= UNIT
   ENDIF

IF _DOS
   SET COLOR TO /w      
ELSE
	SET COLOR TO
ENDIF	

   @ R, 13 SAY ITEM
   @ R, 46 SAY MUNIT

IF _DOS
   SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

   SELECT 5

IF _DOS
   SET COLOR TO /w
ELSE
	SET COLOR TO
ENDIF	

   @ R, 55 SAY T_QTY PICTURE '9999999.9999'

IF _DOS
   SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

   R= R+1
   IF R>=23
      RETURN
   ENDIF
   SKIP
   IF I1=MI1.and.I2=MI2.and.I3=MI3
      IF .not. EOF()
         SKIP
         LOOP
      ENDIF
   ENDIF
ENDDO
RETURN
*****************


*4-
**************************
PROCEDURE STK_COR
**************************
SELECT 5
GOTO TOP
MREC2= RECNO()
DO stk-dsp
GOTO TOP
MREC2= RECNO()
R= 10
CK= 0
DO WHILE .T.
   R= R+1
   IF R>=23
      @ 11, 0 CLEAR TO 24, 79
      R= 11
      IF .not. EOF()
         MREC2= RECNO()
         DO stk-dsp
         GOTO MREC2
         R= 11
      ENDIF
   ENDIF
   @ 23, 1 SAY "'D' Delete - 'C' Change -  'N' Next "
   MQES= 'N'
   @ R, 0 GET MQES PICTURE '!' VALID MQES='D'.or.MQES='C'.or.MQES='N'
   READ
   @ 23, 1 CLEAR TO 23, 77
   IF MQES='D'
      SELECT 5
      DELETE
      SKIP
      DELETE
      IF EOF()
         EXIT
      ENDIF
   ENDIF
   IF MQES='N'
      SELECT 5
      IF .not. EOF()
         SKIP  +2
         LOOP
      ENDIF
      IF EOF()
         SELECT 5
         STORE 0 TO MI1, MI2, MI3, MQTY, MORDER_NO, MRATE, MAMOUNT
         DO WHILE .T.

IF _DOS
            SET COLOR TO /w
ELSE
	SET COLOR TO
ENDIF	

            @ R, 2 SAY '  -  -    '

IF _DOS
            SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

            @ R, 2 GET MI1 PICTURE '99'
            READ

IF _DOS
            SET COLOR TO n/g
ELSE
	SET COLOR TO
ENDIF	

            MP1= REPLICATE('0',2-LEN(LTRIM(STR(MI1))))+LTRIM(STR(MI1))
            @ R, 2 SAY MP1
            @ R, 4 SAY '-'
            @ R, 5 GET MI2 PICTURE '99'
            READ
            MP2= REPLICATE('0',2-LEN(LTRIM(STR(MI2))))+LTRIM(STR(MI2))
            @ R, 5 SAY MP2
            @ R, 7 SAY '-'
            @ R, 8 GET MI3 PICTURE '9999'
            READ
            IF MI3=0
               LOOP
            ENDIF
            MP3= REPLICATE('0',4-LEN(LTRIM(STR(MI3))))+LTRIM(STR(MI3))
            @ R, 8 SAY MP3

IF _DOS
            SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

            @ 23, 50 CLEAR TO 23, 78
            IF MI1=0.and.MI2=0.and.MI3=0
               LOOP
            ENDIF
            SELECT 2
            STORE STR(MI1,2)+STR(MI2,2)+STR(MI3,4) TO MI_CODE
            SEEK MI_CODE
            IF .not. FOUND()
               ?? CHR(7)
               @ 23, 15 SAY 'This Code Does Not Exist ... Please Re-try'
               WAIT ''
               @ 23, 10 SAY SPACE(50)
               LOOP
            ENDIF

IF _DOS
            SET COLOR TO /w
ELSE
	SET COLOR TO
ENDIF	

            @ R, 13 SAY ITEM
            @ R, 46 SAY UNIT
            MUNIT= UNIT

IF _DOS
            SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

            @ R, 55 GET MQTY PICTURE '9999999.9999'
            READ
            EXIT
         ENDDO
         SELECT 5
         APPEND BLANK
         REPLACE DOC_NO WITH MDOC_NO, DOC_TYPE WITH 8, DATE WITH MDATE
         REPLACE T_QTY WITH MQTY, LOC_CODE WITH MLOC_CODE
         REPLACE I1 WITH MI1, I2 WITH MI2, I3 WITH MI3, F_T WITH 'F'
         APPEND BLANK
         REPLACE DOC_NO WITH MDOC_NO, DOC_TYPE WITH 8, DATE WITH MDATE
         REPLACE T_QTY WITH MQTY, LOC_CODE WITH MLOC_CODE2
         REPLACE I1 WITH MI1, I2 WITH MI2, I3 WITH MI3, F_T WITH 'T'
      ENDIF
   ENDIF
   IF MQES='C'
      DO WHILE .T.
         SELECT 5
         MI1= I1
         MI2= I2
         MI3= I3
         MQTY= T_QTY

IF _DOS
         SET COLOR TO /w
ELSE
	SET COLOR TO
ENDIF	

         @ R, 2 SAY '  -  -    '

IF _DOS
         SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

         @ R, 2 GET MI1 PICTURE '99'
         READ

IF _DOS
         SET COLOR TO n/g
ELSE
	SET COLOR TO
ENDIF	

         MP1= REPLICATE('0',2-LEN(LTRIM(STR(MI1))))+LTRIM(STR(MI1))
         @ R, 2 SAY MP1
         @ R, 4 SAY '-'
         @ R, 5 GET MI2 PICTURE '99'
         READ
         MP2= REPLICATE('0',2-LEN(LTRIM(STR(MI2))))+LTRIM(STR(MI2))
         @ R, 5 SAY MP2
         @ R, 7 SAY '-'
         @ R, 8 GET MI3 PICTURE '9999'
         READ
         IF MI3=0
            LOOP
         ENDIF
         MP3= REPLICATE('0',4-LEN(LTRIM(STR(MI3))))+LTRIM(STR(MI3))
         @ R, 8 SAY MP3

IF _DOS
         SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

         @ 23, 50 CLEAR TO 23, 78
         IF READKEY()=12
            CLEAR
            CLOSE ALL
            RETURN
         ENDIF
         IF MI1=0.and.MI2=0.and.MI3=0
            LOOP
         ENDIF
         SELECT 2
         STORE STR(MI1,2)+STR(MI2,2)+STR(MI3,4) TO MI_CODE
         SEEK MI_CODE
         IF .not. FOUND()
            ?? CHR(7)
            @ 23, 15 SAY 'This Code Does Not Exist ... Please Re-try'
            WAIT ''
            @ 23, 10 SAY SPACE(50)
            LOOP
         ENDIF

IF _DOS
         SET COLOR TO /w      
ELSE
	SET COLOR TO
ENDIF	

         @ R, 13 SAY ITEM
         @ R, 46 SAY UNIT
         MUNIT= UNIT

IF _DOS
         SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

         @ R, 55 GET MQTY PICTURE '9999999.9999'
         READ
         EXIT
      ENDDO
      SELECT 5
      REPLACE DOC_NO WITH MDOC_NO, DOC_TYPE WITH 8, DATE WITH MDATE
      REPLACE T_QTY WITH MQTY, LOC_CODE WITH MLOC_CODE
      REPLACE I1 WITH MI1, I2 WITH MI2, I3 WITH MI3, F_T WITH 'F'
      SKIP
      REPLACE DOC_NO WITH MDOC_NO, DOC_TYPE WITH 8, DATE WITH MDATE
      REPLACE T_QTY WITH MQTY, LOC_CODE WITH MLOC_CODE2
      REPLACE I1 WITH MI1, I2 WITH MI2, I3 WITH MI3, F_T WITH 'T'
   ENDIF
   SELECT 5
   MANS= ' '
   DO WHILE .not. MANS$'YN'
      @ R, 79 GET MANS PICTURE '!'
      READ
   ENDDO
   IF MANS='Y'
      SKIP
   ENDIF
   IF MANS='N'
      SELECT 5
      EXIT
   ENDIF
ENDDO
RETURN
*************


*5-
*****************************
PROCEDURE STCK_COR
*****************************
CLEAR
CLOSE ALL
SET DATE brit
SET DELETED ON
SELECT 1
USE st-tran ORDER stidx
SET FILTER TO DOC_TYPE=8
GOTO TOP
SELECT 2
USE item ORDER item_idx
SELECT 3
USE loc ORDER loc_idx
SELECT 4
USE item-bal ORDER itm_bal
DO WHILE .T.
   SELECT 1
   CLEAR
   MDOC_TYPE= 8
   @ 1, 28 SAY 'STOCK TRANSFER CORRECTION'
   STORE DATE() TO MDATE, MDEADLINE
   STORE 0 TO MDOC_NO, MC1, MC2, MC3, MLOC_CODE2, MORDER_NO, MLOC_CODE
   STORE 0 TO MI1, MI2, MI3, MQTY_ORD, MRATE, MQTY, MRATE, MTOT
   R= 3
   @ 23, 50 SAY 'Press Ctrl Q To Quit '
   @ R, 8 SAY 'Transfer Voucher No' GET MDOC_NO PICTURE '9999999'
   READ
   IF READKEY()=12
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
   @ 23, 45 CLEAR TO 23, 78
   IF MDOC_NO=0
      LOOP
   ENDIF
   MVCH_NO= REPLICATE('0',7-LEN(LTRIM(STR(MDOC_NO))))+LTRIM(STR(MDOC_NO))

IF _DOS
   SET COLOR TO /g
ELSE
	SET COLOR TO
ENDIF	

   @ R, 28 SAY MVCH_NO

IF _DOS
   SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

   SELECT 1
   SEEK STR(MDOC_NO,7)+STR(MDOC_TYPE,1)
   IF .not. FOUND()
      @ 23, 1 SAY SPACE(78)
      @ 23, 15 SAY 'This Voucher No Does Not Exists  -- Press any key'
      WAIT ''

IF _DOS
      SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

      @ 23, 10 SAY SPACE(75)
      LOOP
   ENDIF
   IF FLAG='Y'
      CLEAR
      @ 12, 15 SAY 'This Voucher has been posted to Ledger, therefore   '
      @ 13, 15 SAY 'you cannot Change/Correct it. If you still want to  '
      @ 14, 15 SAY 'Change/Correct it, please use UN-POST OPTION first. '
      @ 16, 15 SAY 'Press Any Key to Return ............ '
      WAIT ''
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
   SELECT 1
   USE
   SELECT 5
   USE st-cor
   APPEND FROM st-tran FOR DOC_NO=MDOC_NO.and.DOC_TYPE=8
   SELECT 5
   GOTO TOP
   MDATE= DATE
   @ R, 40 SAY 'Date   ' GET MDATE
   READ
   DO chk IN TBL_PROC.PRG
   R= R+2
   ABC= 0
   DO WHILE ABC=0
      MLOC_CODE= LOC_CODE
      @ R, 8 SAY 'From Location      ' GET MLOC_CODE PICTURE '9999'
      READ
      IF MLOC_CODE=0
         LOOP
      ENDIF
      SELECT 3
      SEEK MLOC_CODE
      IF .not. FOUND()
         ?? CHR(7)
         @ 23, 15 SAY 'This Code Does Not Exist ... Please Re-try'
         WAIT ''
         @ 23, 10 SAY SPACE(50)
         LOOP
      ENDIF

IF _DOS
      SET COLOR TO /w      
ELSE
	SET COLOR TO
ENDIF	

      @ R, 40 SAY LOC

IF _DOS
      SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

      MLOC= LOC
      ABC= 1
   ENDDO
   R= R+2
   SELECT 5
   SKIP
   ABC= 0
   DO WHILE ABC=0
      MLOC_CODE2= LOC_CODE
      @ R, 8 SAY 'To   Location      ' GET MLOC_CODE2 PICTURE '9999'
      READ
      IF MLOC_CODE2=0
         LOOP
      ENDIF
      IF MLOC_CODE2=MLOC_CODE
         LOOP
      ENDIF
      SELECT 3
      SEEK MLOC_CODE2
      IF .not. FOUND()
         ?? CHR(7)
         @ 23, 15 SAY 'This Code Does Not Exist ... Please Re-try'
         WAIT ''
         @ 23, 10 SAY SPACE(50)
         LOOP
      ENDIF

IF _DOS
      SET COLOR TO /w      
ELSE
	SET COLOR TO
ENDIF	

      @ R, 40 SAY LOC

IF _DOS
      SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

      MLOC2= LOC
      ABC= 1
   ENDDO
   R= R+1
   @ R, 1 TO R, 79
   R= R+1
   @ R, 2 SAY 'Item Code'
   @ R, 13 SAY 'Item '
   @ R, 46 SAY 'Unit '
   @ R, 55 SAY 'Qty '
   @ R, 76 SAY 'More'
   R= R+1
   @ R, 0 TO R, 79 DOUBLE
   R= R+1
   DO STK-COR
   SELECT 5
   MSR_NO= 0
   GOTO TOP
   DO WHILE .not. EOF()
      MSR_NO= MSR_NO+1
      REPLACE LOC_CODE WITH MLOC_CODE, DATE WITH MDATE, SR_NO WITH MSR_NO
      SKIP
      MSR_NO= MSR_NO+1
      REPLACE LOC_CODE WITH MLOC_CODE2, DATE WITH MDATE, SR_NO WITH MSR_NO
      SKIP
   ENDDO
   USE
   SELECT 1
   USE st-tran ORDER stidx
   DELETE ALL FOR DOC_NO=MDOC_NO.and.DOC_TYPE=8
   APPEND FROM st-cor FOR DOC_NO=MDOC_NO.and.DOC_TYPE=8
   SET FILTER TO DOC_TYPE=8
   GOTO TOP
   SELECT 5
   USE st-cor
   DELETE ALL FOR DOC_NO=MDOC_NO.and.DOC_TYPE=8
   USE
   ANS= ' '
   DO WHILE .not. ANS$'YN'
      @ 24, 25 SAY 'More Data Correction - Y/N' GET ANS FUNCTION '!'
      READ
   ENDDO
   IF ANS='N'
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
ENDDO
RETURN
*************


*6-
******************************
PROCEDURE STCK_DEL
******************************
CLEAR
CLOSE ALL
SET DATE brit
SET DELETED ON
SELECT 1
USE st-tran ORDER stidx
SET FILTER TO DOC_TYPE=8
GOTO TOP
SELECT 2
USE item ORDER item_idx
SELECT 3
USE loc ORDER loc_idx
SELECT 4
USE item-bal ORDER itm_bal
DO WHILE .T.
   SELECT 1
   CLEAR
   MDOC_TYPE= 8
   @ 1, 30 SAY 'STOCK TRANSFER DELETION'
   STORE DATE() TO MDATE, MDEADLINE
   STORE 0 TO MDOC_NO, MC1, MC2, MC3, MLOC_CODE2, MORDER_NO, MLOC_CODE
   STORE 0 TO MI1, MI2, MI3, MQTY_ORD, MRATE, MQTY, MRATE, MTOT
   R= 3
   @ 23, 50 SAY 'Press Ctrl Q To Quit '
   @ R, 8 SAY 'Transfer Voucher No' GET MDOC_NO PICTURE '9999999'
   READ
   IF READKEY()=12
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
   @ 23, 45 CLEAR TO 23, 78
   IF MDOC_NO=0
      LOOP
   ENDIF
   MVCH_NO= REPLICATE('0',7-LEN(LTRIM(STR(MDOC_NO))))+LTRIM(STR(MDOC_NO))

IF _DOS
   SET COLOR TO /g
ELSE
	SET COLOR TO
ENDIF	

   @ R, 28 SAY MVCH_NO

IF _DOS
   SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

   SELECT 1
   SEEK STR(MDOC_NO,7)+STR(MDOC_TYPE,1)
   IF .not. FOUND()
      @ 23, 1 SAY SPACE(78)
      @ 23, 15 SAY 'This Voucher No Does Not Exists  -- Press any key'
      WAIT ''

IF _DOS
      SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

      @ 23, 10 SAY SPACE(75)
      LOOP
   ENDIF
   IF FLAG='Y'
      CLEAR
      @ 12, 15 SAY 'This Voucher has been posted to Ledger, therefore   '
      @ 13, 15 SAY 'you cannot Delete it. If you still want to Delete   '
      @ 14, 15 SAY 'it, please use UN-POST OPTION first. '
      @ 16, 15 SAY 'Press Any Key to Return ............ '
      WAIT ''
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
   SELECT 1
   USE
   SELECT 5
   USE st-cor
   APPEND FROM st-tran FOR DOC_NO=MDOC_NO.and.DOC_TYPE=8
   SELECT 5
   GOTO TOP
   @ R, 40 SAY 'Date   ' GET DATE
   R= R+2
   ABC= 0
   DO WHILE ABC=0
      MLOC_CODE= LOC_CODE
      @ R, 8 SAY 'From Location      ' GET MLOC_CODE PICTURE '9999'
      IF MLOC_CODE=0
         LOOP
      ENDIF
      SELECT 3
      SEEK MLOC_CODE
      IF FOUND()

IF _DOS
         SET COLOR TO /w      
ELSE
	SET COLOR TO
ENDIF	

         @ R, 40 SAY LOC

IF _DOS
         SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

         MLOC= LOC
      ENDIF
      ABC= 1
   ENDDO
   R= R+2
   SELECT 5
   SKIP
   ABC= 0
   DO WHILE ABC=0
      MLOC_CODE2= LOC_CODE
      @ R, 8 SAY 'To   Location      ' GET MLOC_CODE2 PICTURE '9999'
      IF MLOC_CODE2=0
         LOOP
      ENDIF
      SELECT 3
      SEEK MLOC_CODE2
      IF FOUND()

IF _DOS
         SET COLOR TO /w      
ELSE
	SET COLOR TO
ENDIF	

         @ R, 40 SAY LOC

IF _DOS
         SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

         MLOC2= LOC
      ENDIF
      ABC= 1
   ENDDO
   CLEAR GETS
   R= R+1
   @ R, 1 TO R, 79
   R= R+1
   @ R, 2 SAY 'Item Code'
   @ R, 13 SAY 'Item '
   @ R, 46 SAY 'Unit '
   @ R, 55 SAY 'Qty '
   @ R, 76 SAY 'More'
   R= R+1
   @ R, 0 TO R, 79 DOUBLE
   R= R+1
   SELECT 5
   GOTO TOP
   DO WHILE .not. EOF()
      MI1= I1
      MI2= I2
      MI3= I3

IF _DOS
      SET COLOR TO /w
ELSE
	SET COLOR TO
ENDIF	

      @ R, 2 SAY '  -  -    '
      @ R, 2 SAY MI1 PICTURE '99'

IF _DOS
      SET COLOR TO n/g
ELSE
	SET COLOR TO
ENDIF	

      MP1= REPLICATE('0',2-LEN(LTRIM(STR(MI1))))+LTRIM(STR(MI1))
      @ R, 2 SAY MP1
      @ R, 4 SAY '-'
      @ R, 5 SAY MI2 PICTURE '99'
      MP2= REPLICATE('0',2-LEN(LTRIM(STR(MI2))))+LTRIM(STR(MI2))
      @ R, 5 SAY MP2
      @ R, 7 SAY '-'
      @ R, 8 SAY MI3 PICTURE '9999'
      MP3= REPLICATE('0',4-LEN(LTRIM(STR(MI3))))+LTRIM(STR(MI3))
      @ R, 8 SAY MP3

IF _DOS
      SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

      SELECT 2
      STORE STR(MI1,2)+STR(MI2,2)+STR(MI3,4) TO MI_CODE
      SEEK MI_CODE
      IF .not. FOUND()
         ?? CHR(7)
         @ 23, 15 SAY 'This Item Code Does Not Exist ... Please Re-try'
         WAIT ''
         @ 23, 10 SAY SPACE(55)
         LOOP
      ELSE
         MUNIT= UNIT
      ENDIF

IF _DOS
      SET COLOR TO /w      
ELSE
	SET COLOR TO
ENDIF	

      @ R, 13 SAY ITEM
      @ R, 46 SAY MUNIT

IF _DOS
      SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

      SELECT 5

IF _DOS
      SET COLOR TO /w
ELSE
	SET COLOR TO
ENDIF	

      @ R, 55 SAY T_QTY PICTURE '9999999.9999'

IF _DOS
      SET COLOR TO 
ELSE
	SET COLOR TO
ENDIF	

      SKIP
      R= R+1
      IF R>=23
         WAIT
         @ 11, 0 CLEAR TO 24, 79
         R= 11
      ENDIF
      IF I1=MI1.and.I2=MI2.and.I3=MI3
         IF .not. EOF()
            SKIP
            LOOP
         ENDIF
      ENDIF
   ENDDO
   ANS= ' '
   DO WHILE .not. ANS$'YN'
      @ 24, 25 SAY 'Confirm Deletion  - Y/N' GET ANS FUNCTION '!'
      READ
   ENDDO
   @ 24, 20 CLEAR TO 24, 78
   SELECT 1
   USE st-tran ORDER stidx
   IF ANS='Y'
      SELECT 1
      DELETE ALL FOR DOC_NO=MDOC_NO.and.DOC_TYPE=8
      SELECT 5
      USE st-key ORDER st_idx
      SEEK STR(MDOC_NO,7)+STR(MDOC_TYPE,1)
      IF FOUND()
         DELETE
      ENDIF
      USE
   ENDIF
   SELECT 1
   SET FILTER TO DOC_TYPE=8
   GOTO TOP
   SELECT 5
   USE st-cor
   DELETE ALL FOR DOC_NO=MDOC_NO.and.DOC_TYPE=8
   USE
   ANS= ' '
   DO WHILE .not. ANS$'YN'
      @ 24, 25 SAY 'Any More Deletion  - Y/N' GET ANS FUNCTION '!'
      READ
   ENDDO
   IF ANS='N'
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
ENDDO
RETURN
**********


*7-
******************************
PROCEDURE STCK_PRT
******************************
CLEAR ALL
CLEAR
SET DATE brit
SELECT 1
USE st-tran ORDER stidx
SELECT 2
USE ldgrcode ORDER ac1
SELECT 3
USE item ORDER item_idx
SELECT 4
USE loc ORDER loc_idx
MT= 0
DO WHILE MT=0
   SELECT 1
   @ 2, 25 SAY ' STOCK TRANSFER REPORT '
   STORE DATE() TO FDATE, TDATE
   STORE 0 TO MC1, MC2, MC3, MD1, MD2, MD3, MI1, MI2, MI3, MLOC_CODE
   @ 23, 50 SAY 'Press Ctrl Q To Quit '
   @ 8, 20 SAY 'From Date    (dd/mm/yy) :' GET FDATE
   @ 10, 20 SAY 'To   Date    (dd/mm/yy) :' GET TDATE
   READ
   IF READKEY()=12
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
   @ 23, 45 CLEAR TO 23, 78
   IF TDATE<FDATE
      @ 23, 25 SAY 'To Date Should be greater than From Date'
      WAIT ''
      @ 23, 25 SAY '                                        '
      LOOP
   ENDIF
   SELECT 1
   SET FILTER TO DATE>=FDATE.and.DATE<=TDATE.and.DOC_TYPE=8
   COUNT TO RCON
   IF RCON=0
      @ 23, 5 SAY 'No Transactions exist between these two dates - Please Re-try '
      WAIT ''
      @ 23, 4 CLEAR TO 23, 75
      LOOP
   ENDIF
   MT= 1
ENDDO
@ 24, 50 SAY 'Press any key to Continue ... '
WAIT ''
CLEAR
P= ' '
DO WHILE .not. P$'PQ'
   @ 5, 4 SAY 'Printer/Quit - P/Q ' GET P FUNCTION '!'
   READ
ENDDO
IF P='Q'
   CLOSE ALL
   CLEAR
   SET CONFIRM ON
   RETURN
ENDIF
CLEAR
@ 11, 15 SAY 'Please wait ... Printing in progress '
SET PRINTER ON
SET DEVICE TO PRINTER
SELECT 1
GOTO TOP
L= 3
HEADING= .T.
PAGE= 0
MBAL= 0
STORE 0 TO MLOC_CODE1, MLOC_CODE2
MDES= SPACE(15)
STORE SPACE(25) TO MLOC1, MLOC2
PG= 1
SELECT 1
DO WHILE .not. EOF()
   IF HEADING
      PAGE= PAGE+1
      DO top_prt IN TBL_PROC.PRG
      @ L, 1 SAY CHR(14)
      @ L, 12 SAY 'STOCK TRANSFER REPORT'
      L= L+1
      @ L, 1 SAY 'From Date : '+DTOC(FDATE)
      L= L+1
      @ L, 1 SAY 'To   Date : '+DTOC(TDATE)
      @ L, 68 SAY 'Page : '+STR(PG,2)
      L= L+1
      @ L, 1 SAY CHR(15)
      @ L, 1 SAY REPLICATE('-',132)
      L= L+1
      @ L, 3 SAY 'Date'
      @ L, 12 SAY 'Voucher #'
      @ L, 28 SAY 'Location'
      @ L, 65 SAY 'Item Code'
      @ L, 80 SAY 'Description'
      @ L, 115 SAY 'Quantity'
      L= L+1
      @ L, 1 SAY REPLICATE('-',132)
      L= L+1
      HEADING= .F.
   ENDIF
   SELECT 1
   MF_T= F_T
   IF MF_T='F'
      MLOC_CODE1= LOC_CODE
      MDES= 'From :'
   ENDIF
   MDOCNO= DOC_NO
   @ L, 1 SAY DATE
   MDOC_NO= REPLICATE('0',5-LEN(LTRIM(STR(MDOCNO))))+LTRIM(STR(MDOCNO))
   @ L, 12 SAY 'TRANSFER-'+MDOC_NO
   SELECT 4
   SEEK MLOC_CODE1
   IF FOUND()
      MLOC1= LOC
      @ L, 28 SAY MDES+MLOC1
   ENDIF
   SELECT 1
   CNT= 0
   DO WHILE DOC_NO=MDOCNO
      IF DOC_NO<>MDOCNO
         EXIT
      ENDIF
      MI1= I1
      MI2= I2
      MI3= I3
      IF CNT=1
         MF_T= F_T
         IF MF_T='T'
            MLOC_CODE2= LOC_CODE
            MDES= 'To   :'
         ENDIF
         SELECT 4
         GOTO TOP
         SEEK MLOC_CODE2
         IF FOUND()
            MLOC2= LOC
         ENDIF
         @ L, 28 SAY MDES+MLOC2
      ENDIF
      SELECT 1
      MP1= REPLICATE('0',2-LEN(LTRIM(STR(MI1))))+LTRIM(STR(MI1))
      @ L, 65 SAY MP1
      @ L, 67 SAY '-'
      MP2= REPLICATE('0',2-LEN(LTRIM(STR(MI2))))+LTRIM(STR(MI2))
      @ L, 68 SAY MP2
      @ L, 70 SAY '-'
      MP3= REPLICATE('0',4-LEN(LTRIM(STR(MI3))))+LTRIM(STR(MI3))
      @ L, 71 SAY MP3
      SELECT 3
      SEEK STR(MI1,2)+STR(MI2,2)+STR(MI3,4)
      IF FOUND()
         @ L, 80 SAY ITEM
      ENDIF
      SELECT 1
      @ L, 115 SAY T_QTY
      L= L+1
      CNT= CNT+1
      IF .not. EOF()
         SKIP
      ENDIF
   ENDDO
   IF L>=52
      @ 1, 1 SAY CHR(18)
      L= 3
      HEADING= .T.
      PG= PG+1
   ENDIF
   IF EOF()
      EXIT
   ENDIF
   L= L+1
ENDDO
@ 1, 1 SAY CHR(18)
SET PRINTER OFF
SET DEVICE TO SCREEN
CLEAR
RETURN
**************



*8-
************************************
PROCEDURE STCK_DIS
************************************
CLEAR ALL
CLEAR
SET DELETED ON
SET DATE brit
SELECT 2
USE st-tran ORDER stidx
SELECT 3
USE item ORDER item-idx
SELECT 4
USE loc ORDER loc-idx
MT= 0
DO WHILE MT=0
   SELECT 2
   MDOC_TYPE= 8
   @ 2, 25 SAY ' STOCK TRANSFER REPORT '
   STORE DATE() TO FDATE, TDATE
   STORE 0 TO MC1, MC2, MC3, MD1, MD2, MD3, MI1, MI2, MI3, MLOC_CODE, MDOC_NO, MDOC_NO1
   @ 23, 50 SAY 'Press Ctrl Q To Quit '
   @ 10, 20 SAY 'From TR No : '
   @ 10, 35 GET MDOC_NO PICTURE '9999999'
   READ
   IF READKEY()=12
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
   @ 23, 45 CLEAR TO 23, 78
   IF MDOC_NO=0
      LOOP
   ENDIF
   MVCH_NO= REPLICATE('0',7-LEN(LTRIM(STR(MDOC_NO))))+LTRIM(STR(MDOC_NO))

IF _DOS
   SET COLOR TO /w
ELSE
	SET COLOR TO
ENDIF	

   @ 10, 35 SAY MVCH_NO

IF _DOS
   SET COLOR TO 7/1 
ELSE
	SET COLOR TO
ENDIF	

   SELECT 2
   SEEK STR(MDOC_NO,7)+STR(MDOC_TYPE,1)
   IF .not. FOUND()
      @ 23, 1 SAY SPACE(78)
      @ 23, 15 SAY 'This TR No Does not Exists  -- Press any key'
      WAIT ''

IF _DOS
      SET COLOR TO 7/1 
ELSE
	SET COLOR TO
ENDIF	

      @ 23, 10 SAY SPACE(78)
      LOOP
   ENDIF
   @ 12, 20 SAY 'To   TR No : '
   @ 12, 35 GET MDOC_NO1 PICTURE '9999999'
   READ
   IF READKEY()=12
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
   @ 23, 45 CLEAR TO 23, 78
   IF MDOC_NO1=0
      LOOP
   ENDIF
   MVCH_NO1= REPLICATE('0',7-LEN(LTRIM(STR(MDOC_NO1))))+LTRIM(STR(MDOC_NO1))

IF _DOS
   SET COLOR TO /w
ELSE
	SET COLOR TO
ENDIF	

   @ 12, 35 SAY MVCH_NO1

IF _DOS
   SET COLOR TO 7/1 
ELSE
	SET COLOR TO
ENDIF	

   SELECT 2
   SEEK STR(MDOC_NO,7)+STR(MDOC_TYPE,1)
   IF .not. FOUND()
      @ 23, 1 SAY SPACE(78)
      @ 23, 15 SAY 'This TR No Does not Exists  -- Press any key'
      WAIT ''

IF _DOS
      SET COLOR TO 7/1 
ELSE
	SET COLOR TO
ENDIF	


      @ 23, 10 SAY SPACE(78)
      LOOP
   ENDIF
   SELECT 2
   COPY TO st-rep FOR DOC_NO>=MDOC_NO.and.DOC_NO<=MDOC_NO1.and.DOC_TYPE=8
   SELECT 1
   USE st-rep
   GOTO TOP
   IF RECCOUNT()=0
      CLEAR
      @ 12, 12 SAY 'No GRN Exist in Data File  -  Press any key to return to menu .... '
      WAIT ''
      CLEAR
      CLOSE ALL
      RETURN
   ENDIF
   CLEAR
   MT= 1
ENDDO
SELECT 1
GOTO TOP
P= ' '
DO WHILE .not. P$'PSQ'
   @ 5, 4 SAY 'Printer/Screen/Quit  -  P/S/Q  ' GET P FUNCTION '!'
   READ
ENDDO
IF P='Q'
   CLOSE ALL
   CLEAR
   SET CONFIRM ON
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
L= 3
HEADING= .T.
CNT= 0
DO WHILE .not. EOF()
   CLEAR
   MDOC_NO= DOC_NO
   L= 3
   HEADING= .T.
   STORE 0 TO CNT, MTOT, PAGE
   SELECT 1
   DO WHILE DOC_NO=MDOC_NO
      IF HEADING
         PAGE= PAGE+1
         IF P='P'
            DO top_prt IN TBL_PROC.PRG
            @ 3, 30 SAY 'STOCK TRANSFER REPORT'
            L= L+1
            @ L, 30 SAY '------------------ '
            L= L+1
         ELSE
            DO SCREEN IN TBL_PROC.PRG
            @ 3, 30 SAY 'STOCK TRANSFER REPORT'
            L= L+1
            @ L, 30 SAY '------------------ '
            L= L+1
         ENDIF
         MVCH_NO= REPLICATE('0',7-LEN(LTRIM(STR(MDOC_NO))))+LTRIM(STR(MDOC_NO))
         @ L, 1 SAY 'Transfer No  : '
         @ L, 18 SAY MVCH_NO
         @ L, 56 SAY 'Date     : '+DTOC(DATE)
         L= L+1
         MLOC_CODE= LOC_CODE
         @ L, 1 SAY 'From Location: '
         @ L, 18 SAY LOC_CODE PICTURE '9999'
         MLOC_CODE= REPLICATE('0',4-LEN(LTRIM(STR(LOC_CODE))))+LTRIM(STR(LOC_CODE))
         @ L, 18 SAY MLOC_CODE
         SELECT 4
         SEEK MLOC_CODE
         IF FOUND()
            @ L, 30 SAY LOC
         ENDIF
         SELECT 1
         SKIP
         L= L+1
         MLOC_CODE= LOC_CODE
         @ L, 1 SAY 'To Location  : '
         @ L, 18 SAY LOC_CODE PICTURE '9999'
         MLOC_CODE= REPLICATE('0',4-LEN(LTRIM(STR(LOC_CODE))))+LTRIM(STR(LOC_CODE))
         @ L, 18 SAY MLOC_CODE
         SELECT 4
         SEEK MLOC_CODE
         IF FOUND()
            @ L, 30 SAY LOC
         ENDIF
         SELECT 1
         L= L+1
         @ L, 1 SAY REPLICATE('-',79)
         L= L+1
         @ L, 1 SAY 'Item Code'
         @ L, 12 SAY 'Item '
         @ L, 50 SAY 'Unit'
         @ L, 60 SAY 'Qty '
         L= L+1
         @ L, 1 SAY REPLICATE('-',79)
         L= L+1
         HEADING= .F.
      ENDIF
      SELECT 1
      IF F_T='F'
         SKIP
         LOOP
      ENDIF
      MI1= I1
      MI2= I2
      MI3= I3
      MP1= REPLICATE('0',2-LEN(LTRIM(STR(MI1))))+LTRIM(STR(MI1))
      @ L, 1 SAY MP1 PICTURE '99'
      @ L, 3 SAY '-'
      MP2= REPLICATE('0',2-LEN(LTRIM(STR(MI2))))+LTRIM(STR(MI2))
      @ L, 4 SAY MP2 PICTURE '99'
      @ L, 6 SAY '-'
      MP3= REPLICATE('0',4-LEN(LTRIM(STR(MI3))))+LTRIM(STR(MI3))
      @ L, 7 SAY MP3 PICTURE '9999'
      SELECT 3
      SEEK STR(MI1,2)+STR(MI2,2)+STR(MI3,4)
      IF FOUND()
         @ L, 12 SAY ITEM
         @ L, 50 SAY UNIT
      ENDIF
      SELECT 1
      @ L, 60 SAY T_QTY
      L= L+1
      IF .not. EOF()
         SKIP
      ENDIF
      IF P='S'.and.L>21
         @ 24, 15 SAY ''
         XYZ= ' '
         DO WHILE .not. XYZ$'CQ'
            @ 24, 55 SAY 'Continue/Quit - C/Q ' GET XYZ FUNCTION '!'
            READ
         ENDDO
         IF XYZ='Q'
            CLEAR
            CLOSE ALL
            RETURN
         ENDIF
         CLEAR
         L= 3
         HEADING= .T.
      ENDIF
      IF P='P'.and.L>56
         L= 3
         HEADING= .T.
      ENDIF
   ENDDO
   IF P='S'
      @ 24, 15 SAY ''
      XYZ= ' '
      DO WHILE .not. XYZ$'CQ'
         @ 24, 55 SAY 'Continue/Quit - C/Q ' GET XYZ FUNCTION '!'
         READ
      ENDDO
      IF XYZ='Q'
         CLEAR
         CLOSE ALL
         RETURN
      ENDIF
      CLEAR
      L= 3
      HEADING= .T.
   ENDIF
   IF P='P'
      EJECT
   ENDIF
ENDDO
IF P='P'
   SET PRINTER OFF
   SET DEVICE TO SCREEN
ENDIF
SELECT 1
USE
RUN del st-rep.dbf
CLEAR
CLOSE ALL
RETURN
***************************