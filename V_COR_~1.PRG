* PROGRAM: V_COR_WIN.PRG


********************
*PROCEDURE V_COR_WIN
********************

 SET CLOCK ON
 SET CLOCK TO 30,100


SELECT 1
GOTO TOP

MREC2= RECNO()

DO vdisp_WIN

GOTO TOP

MREC2= RECNO()

R= 8

DO WHILE .T.

   R= R+1


   IF R>19
      PAGE= PAGE+1
      @ 2, 67 SAY PAGE PICTURE '999' FONT 'FoxFont',11
      @ 9, 0 CLEAR TO 19, 79
      R= 9
      IF .not. EOF()

         MREC2= RECNO()
         
         DO vdisp_WIN
         
         GOTO MREC2
         
         R= 9
      
      ENDIF
   
   ENDIF
   
   SELECT 1

IF _DOS
   SET COLOR TO 7/1 
ENDIF

   @ 23, 50 SAY 'Press Ctrl Q To Return' FONT 'FoxFont',11
   @ 23, 1 SAY "'D' Delete - 'C' Change -  'N' Next " FONT 'FoxFont',11
   MQES= 'N'

   @ R, 0 GET MQES PICTURE '!' VALID MQES='D'.or.MQES='C'.or.MQES='N' FONT 'FoxFont',11
   READ

IF _DOS
   SET COLOR TO 7/1 
ENDIF

   @ 23, 1 CLEAR TO 23, 77

   IF MQES='D'
      SELECT 1
      DELETE
   ENDIF

   IF MQES='N'
      SELECT 1

      IF .not. EOF()
         MSR_NO= SR_NO
         SKIP
         LOOP
      ENDIF

      IF EOF()

         SELECT 1
         @ 23, 50 SAY 'Press Ctrl Q To Return' FONT 'FoxFont',11

         STORE SPACE(30) TO MTITLE
         STORE SPACE(42) TO MDESCRIP, MDESCRIP1

         STORE 0 TO MC1, MC2, MC3, MAMOUNT
         GOTO BOTTOM

         MSR_NO= SR_NO+1

         DO WHILE .T.

            @ R, 1 SAY MSR_NO PICTURE '999' FONT 'FoxFont',11
            @ R, 5 GET MC1 PICTURE '99' FONT 'FoxFont',11

IF _DOS
            SET COLOR TO /w
ENDIF

            @ R, 7 SAY '-' FONT 'FoxFont',11
            @ R, 8 GET MC2 PICTURE '99' FONT 'FoxFont',11
            @ R, 10 SAY '-' FONT 'FoxFont',11
            @ R, 11 GET MC3 PICTURE '999' FONT 'FoxFont',11
            READ

            MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MC1))))+LTRIM(STR(MC1))
            MPC2= REPLICATE('0',2-LEN(LTRIM(STR(MC2))))+LTRIM(STR(MC2))
            MPC3= REPLICATE('0',3-LEN(LTRIM(STR(MC3))))+LTRIM(STR(MC3))

IF _DOS
            SET COLOR TO /w
ENDIF

            @ R, 5 SAY MPC1 PICTURE '99' FONT 'FoxFont',11
            @ R, 8 SAY MPC2 PICTURE '99' FONT 'FoxFont',11
            @ R, 11 SAY MPC3 PICTURE '999' FONT 'FoxFont',11

IF _DOS
            SET COLOR TO 7/1
ENDIF

            @ 23, 50 SAY SPACE(35) 
            IF READKEY()=12

IF _DOS
               SET COLOR TO 7/1
ENDIF

               SELECT 1
               ZAP
               CLEAR
               RETURN
            ENDIF

            IF MC3=0
               ?? CHR(7)

IF _DOS
               SET COLOR TO 7/1
ENDIF

               @ 23, 0 CLEAR TO 23, 77
               @ 23, 17 SAY 'You Can Not Post in Consolided Head - Retry' FONT 'FoxFont',11
               WAIT ''

IF _DOS
               SET COLOR TO 7/1
ENDIF

               @ 23, 10 SAY SPACE(60)
               LOOP
            ENDIF

            SELECT 3
            STORE STR(MC1,2)+STR(MC2,2)+STR(MC3,3) TO MCODE

            SEEK MCODE

            IF FOUND()

IF _DOS
               SET COLOR TO /w
ENDIF

               @ R, 15 SAY TITLE FONT 'FoxFont',11
               STORE TITLE TO MTITLE

IF _DOS
               SET COLOR TO 7/1 
ENDIF

            ELSE
               ?? CHR(7)

IF _DOS
               SET COLOR TO 7/1
ENDIF

               @ 23, 0 CLEAR TO 23, 77
               @ 23, 17 SAY 'Code Does Not Exist In File - Retry' FONT 'FoxFont',11
               WAIT ''

IF _DOS
               SET COLOR TO 7/1
ENDIF

               @ 23, 10 SAY SPACE(60)
               LOOP
            ENDIF

            IF LOCK='Y'
               ?? CHR(7)
               @ 23, 13 SAY 'This Code Has Been Defined As Lock ... Please Re-try ' FONT 'FoxFont',11
               WAIT ''

IF _DOS
               SET COLOR TO 7/1
ENDIF

               @ 23, 10 SAY SPACE(79)
               LOOP
            ENDIF

IF _DOS
            SET COLOR TO 7/1
ENDIF

            @ 5, 32 SAY 'Description   ' GET MDESCRIP;
            PICTURE "@! XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
            FONT 'FoxFont',11

            @ 5, 32 SAY 'Description   ' GET MDESCRIP1;
            PICTURE "@! XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
            FONT 'FoxFont',11
            READ

IF _DOS
            SET COLOR TO /w
ENDIF

            MDR_CR= ' '

            DO WHILE .not. MDR_CR$'DC'
               @ R, 46 GET MDR_CR PICTURE '!!' FONT 'FoxFont',11
               READ
            ENDDO

            IF MDR_CR='D'
               STORE 'DR' TO MDR_CR
            ELSE
               STORE 'CR' TO MDR_CR
            ENDIF

            @ R, 46 SAY MDR_CR PICTURE '!!' FONT 'FoxFont',11
            COL= IIF(MDR_CR='DR',50,62)

            MT= 0

            DO WHILE MT=0
               @ R, COL GET MAMOUNT PICTURE '999999,999.99' FONT 'FoxFont',11
               READ


* CHANGES MADE ON 11TH JULY
* TO ACCEPT EMPTY AMOUNT VOUCHERS

*               IF MAMOUNT<=0
*                  LOOP
*               ENDIF

               MT= 1

            ENDDO

            EXIT

         ENDDO


         SELECT 1
         APPEND BLANK
         REPLACE DATE WITH MDATE, VCH_TYPE WITH MVCH_TYPE
         REPLACE VCH_NO1 WITH MVCH_NO1, VCH_NO2 WITH MVCH_NO2
         REPLACE C1 WITH MC1, C2 WITH MC2, C3 WITH MC3
         REPLACE DESCRIP WITH MDESCRIP, SR_NO WITH MSR_NO
         REPLACE AMOUNT WITH MAMOUNT, DR_CR WITH MDR_CR
         REPLACE DESCRIP1 WITH MDESCRIP1
         FLUSH
      ENDIF

   ENDIF

   IF MQES='C'
      DO WHILE .T.
         SELECT 1
         MC1= C1
         MC2= C2
         MC3= C3

         MDESCRIP= DESCRIP
         MDESCRIP1= DESCRIP1

         MAMOUNT= AMOUNT
         MDR_CR= DR_CR

IF _DOS
         SET COLOR TO 7/1
ENDIF

         @ R, 1 SAY SR_NO PICTURE '999' FONT 'FoxFont',11
         @ R, 5 GET MC1 PICTURE '99' FONT 'FoxFont',11

IF _DOS
         SET COLOR TO /w
ENDIF

         @ R, 7 SAY '-' FONT 'FoxFont',11
         @ R, 8 GET MC2 PICTURE '99' FONT 'FoxFont',11
         @ R, 10 SAY '-' FONT 'FoxFont',11
         @ R, 11 GET MC3 PICTURE '999' FONT 'FoxFont',11
         READ

         MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MC1))))+LTRIM(STR(MC1))
         MPC2= REPLICATE('0',2-LEN(LTRIM(STR(MC2))))+LTRIM(STR(MC2))
         MPC3= REPLICATE('0',3-LEN(LTRIM(STR(MC3))))+LTRIM(STR(MC3))

IF _DOS
         SET COLOR TO /w
ENDIF

         @ R, 5 SAY MPC1 PICTURE '99' FONT 'FoxFont',11
         @ R, 8 SAY MPC2 PICTURE '99' FONT 'FoxFont',11
         @ R, 11 SAY MPC3 PICTURE '999' FONT 'FoxFont',11

IF _DOS
         SET COLOR TO 7/1 
ENDIF

         @ 23, 50 SAY SPACE(35)
         IF READKEY()=12

IF _DOS
            SET COLOR TO 7/1
ENDIF

            SELECT 1
            ZAP
            CLEAR
            RETURN
         ENDIF

         IF MC3=0
            ?? CHR(7)
            @ 23, 0 CLEAR TO 23, 77
            @ 23, 17 SAY 'You Can Not Post in Consolided Head - Retry' FONT 'FoxFont',11
            WAIT ''

IF _DOS
            SET COLOR TO 7/1
ENDIF

            @ 23, 10 SAY SPACE(60)
            LOOP
         ENDIF

         SELECT 3
         STORE STR(MC1,2)+STR(MC2,2)+STR(MC3,3) TO MCODE
         SEEK MCODE
         IF FOUND()

IF _DOS
            SET COLOR TO /w
ENDIF

            @ R, 15 SAY TITLE FONT 'FoxFont',11
            STORE TITLE TO MTITLE

IF _DOS
            SET COLOR TO 7/1 
ENDIF

         ELSE
            ?? CHR(7)

IF _DOS
            SET COLOR TO 7/1
ENDIF

            @ 23, 0 CLEAR TO 23, 77
            @ 23, 17 SAY 'Code Does Not Exist In File - Retry' FONT 'FoxFont',11
            WAIT ''

IF _DOS
            SET COLOR TO 7/1
ENDIF

            @ 23, 10 SAY SPACE(60)
            LOOP
         ENDIF

         IF LOCK='Y'
            ?? CHR(7)
            @ 23, 13 SAY 'This Code Has Been Defined As Lock ... Please Re-try ' FONT 'FoxFont',11
            WAIT ''

IF _DOS
            SET COLOR TO 7/1
ENDIF

            @ 23, 10 SAY SPACE(79)
            LOOP
         ENDIF

IF _DOS
         SET COLOR TO 7/1
ENDIF

         @ 5, 32 SAY 'Description   ' GET MDESCRIP;
         PICTURE "@! XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
         SIZE 1,30 ;
         FONT 'FoxFont',11
         
         READ

         @ 5, 32 SAY 'Description   ' GET MDESCRIP1;
         PICTURE "@! XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
         SIZE 1,30 ;
         FONT 'FoxFont',11

         READ

IF _DOS
         SET COLOR TO /w
ENDIF

         DO WHILE .not. MDR_CR$'DC'
            @ R, 46 GET MDR_CR PICTURE '!!' FONT 'FoxFont',11
            READ
            EXIT
         ENDDO
         IF MDR_CR='D'
            STORE 'DR' TO MDR_CR
         ELSE
            STORE 'CR' TO MDR_CR
         ENDIF
         COL= IIF(MDR_CR='DR',50,62)
         DO WHILE .T.

IF _DOS
            SET COLOR TO 7/1
ENDIF

            @ R, 50 SAY SPACE(28)

IF _DOS
            SET COLOR TO /w 
ENDIF

            @ R, COL GET MAMOUNT PICTURE '999999,999.99' FONT 'FoxFont',11
            READ

* Amended on 11th July 2005
* for accepting Empty entries in voucher
* for the problem of Sohni Traders
* geting multiline Description of single entry

*            IF MAMOUNT<=0
*               LOOP
*            ENDIF

            EXIT


         ENDDO
         EXIT


      ENDDO

      SELECT 1
      REPLACE DATE WITH MDATE, VCH_TYPE WITH MVCH_TYPE
      REPLACE VCH_NO1 WITH MVCH_NO1, VCH_NO2 WITH MVCH_NO2
      REPLACE C1 WITH MC1, C2 WITH MC2, C3 WITH MC3, DR_CR WITH MDR_CR
      REPLACE DESCRIP WITH MDESCRIP, AMOUNT WITH MAMOUNT
      REPLACE DESCRIP1 WITH MDESCRIP1
      FLUSH

   ENDIF

   SELECT 1

   MANS= ' '

   DO WHILE .not. MANS$'YN'

IF _DOS
      SET COLOR TO 7/1 
ENDIF

      @ R, 78 GET MANS PICTURE '!' FONT 'FoxFont',11
      READ
   ENDDO

   IF MANS='Y'
      IF .not. EOF()
         SKIP
      ENDIF
   ENDIF

   IF MANS='N'

IF _DOS
      SET COLOR TO 7/1
ENDIF

      SUM FOR DR_CR='DR'.and.VCH_TYPE=MVCH_TYPE.and.VCH_NO1=MVCH_NO1.and.VCH_NO2=MVCH_NO2 AMOUNT TO AMT1
      SUM FOR DR_CR='CR'.and.VCH_TYPE=MVCH_TYPE.and.VCH_NO1=MVCH_NO1.and.VCH_NO2=MVCH_NO2 AMOUNT TO AMT2

      @ 21, 49 SAY AMT1 PICTURE '9999999,999.99' FONT 'FoxFont',11
      @ 21, 64 SAY AMT2 PICTURE '9999999,999.99' FONT 'FoxFont',11

      SELECT 1

      IF AMT1<>AMT2
         ?? CHR(7)

IF _DOS
         SET COLOR TO 7/1
ENDIF

         @ 23, 0 CLEAR TO 23, 77
         @ 23, 15 SAY 'Unbalanced Voucher - Please Correct ' FONT 'FoxFont',11
         WAIT ''
         @ 23, 15
         @ 10, 0 CLEAR TO 23, 79
         SELECT 1
         GOTO TOP
         MREC2= RECNO()

         DO vdisp_WIN

         SELECT 1

         GOTO TOP

         MREC2= RECNO()
         R= 8
         LOOP
      ENDIF

      SELECT 1
      GOTO MREC2
      MSRNO= 0

      DO WHILE .not. EOF()
         MSRNO= MSRNO+1
         REPLACE SR_NO WITH MSRNO
         SKIP
      ENDDO

      MANS= ' '
      MQES= ' '
      EXIT
   ENDIF
ENDDO

IF _DOS
 SET CLOCK ON
 SET CLOCK TO 24,68
ELSE
	SET CLOCK TO 29,100
ENDIF
RETURN
*************************
