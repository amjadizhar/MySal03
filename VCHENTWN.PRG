* PROGRAM : VCHENTWN.PRG
**********************************
* 1 - Vouchers ....... Entry New Voucher     *
*************************************************
* New Voucher Entry Program
* For Windows
* Written by: Amjad Izhar
* Written on: Wed. 5th July, 2006 
**********************************
*PROCEDURE vch_ent
********************

CLEAR
CLOSE DATABASES 

SET DELETED ON
SET EXCLUSIVE ON
SET DATE brit
SET CENT ON


	SET CLOCK ON
	SET CLOCK TO 30,100



CLEAR

* Used databases
* Area 3 - ldgrcode.dbf
* Area 4 - tran-key.dbf
* Area 5 - master.dbf

SELECT 3
USE ldgrcode ALIAS ldgrcode EXCLUSIVE
INDEX ON STR(C1,2)+STR(C2,2)+STR(C3,3) TAG ac1
SET ORDER TO ac1

SELECT 5
USE master ALIAS master EXCLUSIVE
INDEX ON STR(C1,2)+STR(C2,2)+STR(C3,3) TAG ac2 
SET ORDER TO ac2

			*****  Vouchers Types Array  *****

* Memory Array Voucher Type
DECLARE MAVT( 7)

			******  Initialize Variables for Voucher Types *****

MAVT( 1)= 'CR'
MAVT( 2)= 'CP'
MAVT( 3)= 'BR'
MAVT( 4)= 'BP'
MAVT( 5)= 'JV'
MAVT( 6)= 'SV'
MAVT( 7)= 'PV'

      MVCH1= '  '  && Variable for vch_no1  N   2   0
      MVCH2= '    '  && Variable for vch_no2  N  5   0

      STORE 0 TO MCODE, MSRNO, MAMOUNT, AMT1, AMT2
      STORE 0 TO MC1, MC2, MC3, MVCH_NO1, MVCH_NO2




		STORE DATE() TO MDATE
		STORE SPACE(1) TO CANS, MQES

      STORE SPACE(30) TO MTITLE
      STORE SPACE(42) TO MDESCRIP, MDESCRIP1

      STORE SPACE(1) TO Y, MDR_CR, MANS
      STORE 0 TO MVCH_TYPE, AMT1, AMT2




			***  Main Loop  ***
			***  Do While Loop  A-1 / vch_ent ***



DO WHILE .T.  && MAIN LOOP


   IF CANS<>'Y'

			*******  Initializing Variables  *******

      PAGE= 1

      CLEAR

      MVCH1= '  '  && Variable for vch_no1  N   2   0
      MVCH2= '    '  && Variable for vch_no2  N  5   0

      STORE 0 TO MCODE, MSRNO, MAMOUNT, AMT1, AMT2
      STORE 0 TO MC1, MC2, MC3, MVCH_NO1, MVCH_NO2

      STORE SPACE(30) TO MTITLE
*      STORE SPACE(42) TO MDESCRIP, MDESCRIP1

      M= 6
      L= 16

      STORE SPACE(1) TO Y, MDR_CR, MANS
      STORE 0 TO MVCH_TYPE, AMT1, AMT2

   ENDIF


   R= 1  && Row

	
   		@ 2, 1 TO 2, 120 DOUBLE
   		@ 21, 1 TO 21, 120 DOUBLE
   		@ 1, 30 SAY 'VOUCHER  ENTRY' FONT 'FoxFont',11
   		@ 1, 90 SAY 'PAGE #' FONT 'FoxFont',11
   	


	
   		@ 1, 100 SAY PAGE FONT 'FoxFont',11;
   		PICTURE '9999';
   		SIZE 1,5
	


*Amended on Sunday 02-07-2006



	   	@ 30, 90 SAY 'Press Esc to Return' FONT 'FoxFont',11

   		R= 3  && Row

   		@ R, 5 SAY 'Date' FONT 'FoxFont',11
   		@ R, 15 GET MDATE FONT 'FoxFont',11  && Voucher Date

   		READ



	**** If Esc key is pressed Return to Daily Transactions Menu ***

   IF READKEY()=12  && If Esc key is pressed
      CLEAR
      CLOSE DATA
      RETURN
   ENDIF

		***** Check date is not of the next year *****

   DO chk IN tbl_proc.prg

	

	   @ 30, 1 CLEAR TO 30, 120  && Clear the words 'Press Esc to Return'



   * (R) Row is 3
   * getting mVch_Type Variable for vch_type  N  1  0





   @ R, 40 SAY 'Voucher Type' FONT 'FoxFont',11
   @ R, 60 GET MVCH_TYPE PICTURE '9' FONT 'FoxFont',11
   
   
   * Screen's Bottom 3 lines Below double line at Row 21

   @ 22, 1 SAY 'Voucher Types:' FONT 'FoxFont',11
   @ 23, 1 SAY '1 - ' FONT 'FoxFont',11
   @ 24, 1 SAY '2 - ' FONT 'FoxFont',11
   @ 25, 1 SAY '3 - ' FONT 'FoxFont',11
   @ 26, 1 SAY '4 - ' FONT 'FoxFont',11
   @ 27, 1 SAY '5 - ' FONT 'FoxFont',11
   @ 28, 1 SAY '6 - ' FONT 'FoxFont',11
   @ 29, 1 SAY '7 - ' FONT 'FoxFont',11
   @ 23, 10 SAY 'Cash Receipt - ' FONT 'FoxFont',11
   @ 24, 10 SAY 'Cash Payment - ' FONT 'FoxFont',11
   @ 25, 10 SAY 'Bank Receipt - ' FONT 'FoxFont',11
   @ 26, 10 SAY 'Bank Payment - ' FONT 'FoxFont',11
   @ 27, 10 SAY 'Journal      - ' FONT 'FoxFont',11
   @ 28, 10 SAY 'Sales        - ' FONT 'FoxFont',11
   @ 29, 10 SAY 'Purchase     - ' FONT 'FoxFont',11



   * Set Background to White and letters to black






   @ 23, 30 SAY 'CR' FONT 'FoxFont',11
   @ 24, 30 SAY 'CP' FONT 'FoxFont',11
   @ 25, 30 SAY 'BR' FONT 'FoxFont',11
   @ 26, 30 SAY 'BP' FONT 'FoxFont',11
   @ 27, 30 SAY 'JV' FONT 'FoxFont',11
   @ 28, 30 SAY 'SV' FONT 'FoxFont',11
   @ 29, 30 SAY 'PV' FONT 'FoxFont',11





   READ

   IF MVCH_TYPE=0
      LOOP  && Loop back to TOP MAIN Do While Loop  A-1 / vch_ent
   ENDIF

   IF MVCH_TYPE>=8



      		@ R, 55 SAY '  ' FONT 'FoxFont',11
      		@ R, 30 SAY 'No such Voucher type exist -- Press any key' FONT 'FoxFont',11
      		WAIT ''
	  		* Clear words 'No such Voucher type exist -- Press any key'
      		@ R, 30 SAY SPACE(55) FONT 'FoxFont',11



      LOOP  && Loop back to TOP MAIN Do While Loop  A-1 / vch_ent

   ENDIF





   * Clear after first double line
   @ 21, 1 CLEAR TO 29, 120







   @ R, 65 SAY MAVT(MVCH_TYPE) FONT 'FoxFont',11  && Give voucher type its characters Like "CP" etc.

	DO CASE
		CASE MVCH_TYPE = 1
			@ R, 75 SAY 'Cash Receipt Voucher' FONT 'FoxFont',11
		CASE MVCH_TYPE = 2
			@ R, 75 SAY 'Cash Payment Voucher' FONT 'FoxFont',11
		CASE MVCH_TYPE = 3
			@ R, 75 SAY 'Bank Receipt Voucher' FONT 'FoxFont',11
		CASE MVCH_TYPE = 4
			@ R, 75 SAY 'Bank Payment Voucher' FONT 'FoxFont',11
		CASE MVCH_TYPE = 5
			@ R, 75 SAY 'Journal Voucher' FONT 'FoxFont',11
		CASE MVCH_TYPE = 6
			@ R, 75 SAY 'Sales Voucher' FONT 'FoxFont',11
		CASE MVCH_TYPE = 7
			@ R, 75 SAY 'Purchase Voucher' FONT 'FoxFont',11
	ENDCASE
	




   ABC= 0

			***  Do While Loop  A-2 / vch_ent ***

   DO WHILE ABC=0


*Amended on Sunday 02-07-2006

      		@ 30, 90 SAY 'Press Esc to Return' FONT 'FoxFont',11
      		@ 5, 22 SAY SPACE(15) FONT 'FoxFont',11
      		@ 5, 4 SAY 'Voucher No ' FONT 'FoxFont',11





      @ 5, 26 SAY MAVT(MVCH_TYPE) FONT 'FoxFont',11
      @ 23, 1 TO 30,70 CLEAR




      MVCH_NO1 = MONTH(DATE())
      @ 5, 32 GET MVCH_NO1 PICTURE '@z 99' FONT 'FoxFont',11
	  @ 4, 32 SAY 'Enter Month Number' FONT 'FoxFont',11



      READ
      

      	@ 4, 32 SAY SPACE(40)


      IF READKEY()=12
         CLEAR
         CLOSE ALL
         RETURN
      ENDIF





      @ 23, 1 TO 30,70 CLEAR



      IF MVCH_NO1=0
         LOOP && Loop back to SECOND Do While Loop  A-2 / vch_ent
      ENDIF

      MVCH1= REPLICATE('0',2-LEN(LTRIM(STR(MVCH_NO1))))+LTRIM(STR(MVCH_NO1))





      @ 5, 32 SAY MVCH1 FONT 'FoxFont',11





      SELECT 4
      USE tran-key ORDER key

	  * Set filter to go to the last voucher entered of this type

      SET FILTER TO VCH_TYPE=MVCH_TYPE .and. VCH_NO1=MVCH_NO1
      GOTO BOTTOM

	  * Give the next number to this voucher adding +1 to the last voucher

      MVCH_NO2 = VCH_NO2+1






      @ 5, 40 GET MVCH_NO2 PICTURE '@z 99999' FONT 'FoxFont',11
      READ
		@ 5,39 SAY SPACE(30)



   IF READKEY()=12  && If Esc key is pressed
      CLEAR
      CLOSE DATA
      CLOSE ALL
      RETURN
   ENDIF


      IF MVCH_NO2=0
         LOOP  && SECOND Do While Loop  A-2 / vch_ent
      ENDIF

      MVCH2 = REPLICATE('0',5-LEN(LTRIM(STR(MVCH_NO2))))+LTRIM(STR(MVCH_NO2))






      @ 5, 22 TO 5,120 CLEAR
      @ 5, 22 SAY MAVT(MVCH_TYPE)+"-"+MVCH1+"-"+MVCH2 FONT 'FoxFont',11




      SELECT 4  && tran-key order key
      USE tran-key ORDER key
      
      SEEK STR(MVCH_TYPE,1)+STR(MVCH_NO1,2)+STR(MVCH_NO2,5)

      IF FOUND()



         		@ 23, 1 SAY SPACE(78) FONT 'FoxFont',11
         		@ 23, 15 SAY 'This Voucher Already Exists  -- Press any key' FONT 'FoxFont',11
         		WAIT ''
         		@ 23, 10 SAY SPACE(75) FONT 'FoxFont',11



         LOOP
      ELSE

         APPEND BLANK && Add voucher type and voucher no to tran-key
         REPLACE VCH_TYPE WITH MVCH_TYPE
         REPLACE VCH_NO1 WITH MVCH_NO1, VCH_NO2 WITH MVCH_NO2
         FLUSH

      ENDIF

      ABC= 1 && Exiting this Do while Loop   A-2 / vch_ent


   ENDDO

			****  End of Do While Loop  A-2 / vch_ent ****

   SELECT 4  && tran-key.dbf
   USE





   		R= 5
   		R= R+1
   		@ R, 1 TO R, 120 CLEAR
   		R= R+1
   		@ R, 2 SAY 'Sr' FONT 'FoxFont',11
   		@ R, 10 SAY 'Acct-No.' FONT 'FoxFont',11
   		@ R, 30 SAY 'Title' FONT 'FoxFont',11
   		@ R, 65 SAY 'Dr/Cr' FONT 'FoxFont',11
   		@ R, 80 SAY 'Dr-Amt' FONT 'FoxFont',11
   		@ R, 100 SAY 'Cr-Amt' FONT 'FoxFont',11
   		@ R, 120 SAY 'More' FONT 'FoxFont',11
   		R= R+1
   		@ R, 1 TO R, 120 DOUBLE

   		R= 8
   		PAGE= 1



   MANS= 'Y'

			***  Do While Loop  A-3 / vch_ent ***

	** Do while Loop for getting multiline entries of voucher **

   DO WHILE .T.  && THIRD LOOP
      IF MANS='Y'.or.MQES='N'
         MQES= ' '
         R= R+1  && Initialy R = 8
         IF R>19
            PAGE= PAGE+1

			

	            @ 1, 67 SAY PAGE PICTURE '9999' FONT 'FoxFont',11
    	        @ 9, 0 TO 22, 120 CLEAR  && Clear the body of voucher



            R= 9

         ENDIF

         STORE 0 TO MCODE, MAMOUNT
         STORE 0 TO MC1, MC2, MC3
         STORE SPACE(30) TO MTITLE
*         STORE SPACE(42) TO MDESCRIP, MDESCRIP1
         STORE SPACE(1) TO MDR_CR, MANS

      ENDIF

      MSRNO= 1+MSRNO

      *@ 23, 50 SAY 'Press Esc to Return'

      



      		@ R, 1 SAY MSRNO PICTURE '999' FONT 'FoxFont',11




      ABC= 0

			***  Do While Loop  A-4 / vch_ent ***



	 DO WHILE ABC=0 && fourth loop A-4


* AMENDMENT MADE ON 22-AUG-2005
********************************




* Amending on 6th June, 2006


       		@ R, 10 GET MC1 PICTURE '99' FONT 'FoxFont',11








* Amending at home 05th June, 2006

         @ R, 12 SAY '-' FONT 'FoxFont',11
         @ R, 13 GET MC2 PICTURE '99' FONT 'FoxFont',11
         @ R, 15 SAY '-' FONT 'FoxFont',11
         @ R, 16 GET MC3 PICTURE '999' FONT 'FoxFont',11
         READ



         MPC1= REPLICATE('0',2-LEN(LTRIM(STR(MC1))))+LTRIM(STR(MC1))
         MPC2= REPLICATE('0',2-LEN(LTRIM(STR(MC2))))+LTRIM(STR(MC2))
         MPC3= REPLICATE('0',3-LEN(LTRIM(STR(MC3))))+LTRIM(STR(MC3))





         @ R, 8 SAY SPACE(30)
         @ R, 10 SAY MPC1+"-"+MPC2+"-"+MPC3 FONT 'FoxFont',11




         IF READKEY()=12


            CLOSE DATA
            CLEAR
            RETURN
         ENDIF




         @ 23, 50 SAY SPACE(25)




         IF MC3=0
            LOOP  && Loop back to FOURTH Do While Loop  A-4 / vch_ent
         ENDIF

         SELECT 5 && master.dbf
         SEEK STR(MC1,2)+STR(MC2,2)+STR(MC3,3)

         IF FOUND()

			** MDATE is Voucher Date
			** DATE is first entry of this account in master file
			**      which is ** Opening Balance ** entry line

            IF MDATE<DATE

               ?? CHR(7)




               @ 13, 20 SAY 'This Voucher Dated earlier than the Head' FONT 'FoxFont',11
               @ 14, 20 SAY 'Creation Date of this Head Please Correct.' FONT 'FoxFont',11
               @ 15, 20 SAY 'Head Creation Date before Entering this Voucher.' FONT 'FoxFont',11








               @ 17, 25 SAY 'Press Any Key To Continue...' FONT 'FoxFont',11
               A= INKEY(10000000)





               @ 13, 20 CLEAR TO , 69


               EXIT  && Exit from FOURTH Do While Loop  A-4 / vch_ent
               LOOP && When exited FROM FOURTH can not run this line

            ENDIF

         ENDIF

         SELECT 3
         STORE STR(MC1,2)+STR(MC2,2)+STR(MC3,3) TO MCODE

         SEEK MCODE






* Amending on 06-06-2006

         IF FOUND()
            
            @ R, 30 SAY TITLE FONT 'FoxFont',11
            STORE TITLE TO MTITLE
         
         ELSE

			IF _DOS
            SET COLOR TO 7/1 
			ENDIF

            ?? CHR(7)
            @ 23, 20 SAY 'This Code Does Not Exist ... Please Re-try ' FONT 'FoxFont',11
            WAIT ''

			IF _DOS
            SET COLOR TO 7/1
			ENDIF

            @ 23, 10 SAY SPACE(70) FONT 'FoxFont',11
            SELECT 2
            LOOP && BACK TO FOURTH LOOP A-4
         ENDIF



         

         IF LOCK='Y'
            ?? CHR(7)
            @ 23, 13 SAY 'This Code Has Been Defined As Lock ... Please Re-try ' FONT 'FoxFont',11
            WAIT ''


            @ 23, 10 SAY SPACE(79) FONT 'FoxFont',11
            SELECT 2
            LOOP  && RETURN TO FOURTH LOOP A-4
         ENDIF



         ABC= 1

      
      
      ENDDO

			***  End of Do While Loop  A-4 / vch_ent ***

			*** Continuing ... Do While Loop  A-3 / vch_ent ***





      @ 4, 65 SAY 'Description' FONT 'FoxFont',11
      @ 4, 80 GET MDESCRIP;
      FONT 'FoxFont',11;
      PICTURE "@! XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
      SIZE 1,30
      
      @ 5, 65 SAY '              ' FONT 'FoxFont',11
      @ 5, 80 GET MDESCRIP1;
      FONT 'FoxFont',11;
      PICTURE "@! XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
      SIZE 1,30
      
      READ






      MDR_CR= ' '

			***  Do While Loop  A-5 / vch_ent ***


     DO WHILE .not. MDR_CR$'DC'
         @ R, 65 GET MDR_CR PICTURE '@!'
         READ
     ENDDO



			***  End of Do While Loop  A-5 / vch_ent ***

			*** Continuing ... Do While Loop  A-3 / vch_ent ***

      IF MDR_CR='D'
         STORE 'DR' TO MDR_CR
      ELSE
         STORE 'CR' TO MDR_CR
      ENDIF



*Current Amending 06-06-2006


      @ R, 65 SAY MDR_CR PICTURE '!!' FONT 'FoxFont',11

      COL= IIF(MDR_CR='DR',80,100)




			***  Do While Loop  A-6 / vch_ent ***



      DO WHILE .T.
         @ R, COL GET MAMOUNT PICTURE '999999,999.99' FONT 'FoxFont',11
         READ

* Amendment Made on 11th July,2005 1:07 pm
* for description entering muliline for single item
* to accept 0 entry lines
* ALSO TO ACCEPT EMPTY AMOUNT VOUCERS.

*         IF MAMOUNT<=0
*            LOOP && 6TH LOOP
*         ENDIF


         EXIT
      ENDDO



			***  End of Do While Loop  A-6 / vch_ent ***

			*** Continuing ... Do While Loop  A-3 / vch_ent ***






      IF MDR_CR='DR'
         AMT1= AMT1+MAMOUNT
         @ 29, 80 SAY AMT1 FONT 'FoxFont',11
         
      ELSE
         AMT2= AMT2+MAMOUNT
         @ 29, 100 SAY AMT2 FONT 'FoxFont',11
         
      ENDIF




      IF MSRNO<>1
         MANS= ' '

			***  Do While Loop  A-7 / vch_ent ***








         DO WHILE .not. MANS$'YN'  && SEVENTH LOOP
            MANS= 'Y'
            @ R, 120 GET MANS PICTURE '!' FONT 'FoxFont',11
            READ
         ENDDO



			***  End of Do While Loop  A-7 / vch_ent ***

			*** Continuing ... Do While Loop  A-3 / vch_ent ***




				*		below ELSE is coming from .........
				*      IF MSRNO<>1
				*         MANS= ' '

      ELSE
         MANS= 'Y'

      ENDIF




      SELECT 1
      USE voucher
					
      IF MANS='Y'
         APPEND BLANK
         REPLACE VCH_NO1 WITH MVCH_NO1, VCH_NO2 WITH MVCH_NO2
         REPLACE DATE WITH MDATE, VCH_TYPE WITH MVCH_TYPE
         REPLACE C1 WITH MC1, C2 WITH MC2, C3 WITH MC3
         REPLACE DESCRIP WITH MDESCRIP, SR_NO WITH MSRNO
         REPLACE AMOUNT WITH MAMOUNT, DR_CR WITH MDR_CR
         REPLACE DESCRIP1 WITH MDESCRIP1
         FLUSH
         LOOP
      ELSE
         APPEND BLANK
         REPLACE VCH_NO1 WITH MVCH_NO1, VCH_NO2 WITH MVCH_NO2
         REPLACE DATE WITH MDATE, VCH_TYPE WITH MVCH_TYPE
         REPLACE C1 WITH MC1, C2 WITH MC2, C3 WITH MC3
         REPLACE DESCRIP WITH MDESCRIP, SR_NO WITH MSRNO
         REPLACE AMOUNT WITH MAMOUNT, DR_CR WITH MDR_CR
         REPLACE DESCRIP1 WITH MDESCRIP1
         FLUSH
      ENDIF
      
      SUM FOR DR_CR='DR'.and.VCH_TYPE=MVCH_TYPE.and.VCH_NO1=MVCH_NO1.and.VCH_NO2=MVCH_NO2 AMOUNT TO AMT1
      SUM FOR DR_CR='CR'.and.VCH_TYPE=MVCH_TYPE.and.VCH_NO1=MVCH_NO1.and.VCH_NO2=MVCH_NO2 AMOUNT TO AMT2
      






      @ 29, 1 CLEAR TO 30, 120
      @ 29, 80 SAY AMT1 PICTURE '9999,999,999.99' FONT 'FoxFont',11
      @ 29, 100 SAY AMT2 PICTURE '9999,999,999.99' FONT 'FoxFont',11







      IF AMT1<>AMT2
         ?? CHR(7)
         @ 29, 15 SAY 'Unbalanced Voucher - Please Correct ' FONT 'FoxFont',11
         WAIT ''
         @ 29, 15 SAY SPACE(70)
         MANS= ' '
         @ 10, 0 CLEAR TO 29, 120
         
         DO V_COR_WIN
         
         
         IF READKEY()=12

			IF _DOS
            SET COLOR TO 7/1 
			ENDIF

            CLOSE DATA
            CLEAR
            RETURN
         ENDIF
         IF MANS='Y'
            LOOP
         ENDIF
         IF MQES='N'
            LOOP
         ENDIF
      ENDIF





      IF AMT1=AMT2
         COR= ' '




*Current Amending 02-07-2006 Sunday


         DO WHILE .not. COR$'YN'
            @ 29, 0 SAY SPACE(120)
            @ 29, 30 SAY 'Any Correction Y/N  ' FONT 'FoxFont',11
            @ 29, 58 GET COR PICTURE '!' FONT 'FoxFont',11
            READ
         ENDDO



			*** Continuing ... Do While Loop  A-3 / vch_ent ***









         @ 29, 30 SAY SPACE(50)
         IF COR='Y'
            @ 10, 0 CLEAR TO 29, 120
            DO V_COR_WIN
            IF READKEY()=12

			IF _DOS
               SET COLOR TO 7/1 
			ENDIF

               CLOSE DATA
               RETURN
            ENDIF
            IF MANS='Y'
               LOOP
            ENDIF
            IF MQES='N'
               LOOP
            ENDIF
         ELSE
            @ 29, 30 SAY SPACE(50)
         ENDIF


   IF READKEY()=12  && If Esc key is pressed
      CLEAR
      CLOSE DATA
      CLOSE ALL
      RETURN
   ENDIF

         SELECT 1
         USE

         SELECT 2
         USE tran ORDER tranent

         APPEND FROM voucher FOR VCH_TYPE=MVCH_TYPE.and.VCH_NO1=MVCH_NO1.and.VCH_NO2=MVCH_NO2
         FLUSH

         USE
         SELECT 4
         USE tran-key ORDER key
         SEEK STR(MVCH_TYPE,1)+STR(MVCH_NO1,2)+STR(MVCH_NO2,5)
         IF FOUND()
            REPLACE FLAG WITH 'Y'
         ENDIF
         USE
         SELECT 1
         USE voucher
         ZAP
         USE
         EXIT
      ENDIF


   ENDDO

			***  End of Do While Loop  A-3 / vch_ent ***


			*** Continuing ... Do While Loop  A-1 / vch_ent ***

   ANS= ' '


*Current Amending 04-07-2006 Tuesday


   		DO WHILE .not. ANS$'YN'
      		@ 29, 0 SAY SPACE(50)
      		@ 29, 27 SAY 'More Vouchers To Enter - Y/N  ' FONT 'FoxFont',11
      		@ 29, 65 GET ANS PICTURE '!' FONT 'FoxFont',11
      		READ
   		ENDDO




   IF ANS='Y'
      LOOP && Loop Back to Do While Loop A-1 / vch_ent
   ELSE
      EXIT && Exit from Do While Loop  A-1 / vch_ent
   ENDIF


ENDDO
				***  End of Do While Loop  A-1 / vch_ent ***



CLEAR
CLOSE ALL

 SET CLOCK ON
 SET CLOCK TO 30,100


RETURN
******************
