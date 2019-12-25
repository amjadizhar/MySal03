****************************************************************************
***************************** Daily Attendence *****************************
****************************************************************************
Set Talk Off
Set Date To Brit

Clear 
CLOSE DATA

PUBLIC mmcode,myear
mmcode = 0
myear = 0

USE attend
STORE mcode TO mmcode
STORE year TO myear
USE

SELECT 1
USE employee ORDER empno

SELECT 2
USE attend ORDER empno2

SELECT 3
USE ovtime ORDER empno2

SELECT 4
USE artime ORDER empno2

SELECT 5
USE dptime ORDER empno2

SELECT 6

USE deduct ORDER empno2
SET FILTER TO
SET FILTER TO mcode = mmcode AND year = myear

SELECT 7
USE Salary ORDER empno

SELECT 8
USE Salcode && ORDER salcode

SELECT 9
USE Deptt ORDER deptcode

SELE 10
USE Depatt


SELECT Salary
SET RELATION TO salcode INTO salcode ADDITIVE

SELECT Employee

SET RELATION TO deptcode INTO deptt ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO attend ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO ovtime ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO artime ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO dptime ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO deduct ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO salary ADDITIVE

Clear

Public Row
mDate={}
A=.T.

Do While A

@10,25 say "Today Is :" Get mDate
Read

mDay     = Day(mDate)
mMonth   = Month(mDate)
mYear    = Year(mDate)

If mMonth <> Attend.mCode OR mYear <> Attend.Year
   Wait Wind  'In-Valid Date In-Put' Nowait
   Loop
 Else 
   Exit
Endif
Enddo

mTdate  ="D"+Alltrim(str(Day(mDate)))
mArtime ="D"+Alltrim(str(Day(mDate)))+"lt"
mOvtime ="D"+Alltrim(str(Day(mDate)))+"OT"
Clear

@01,09 to 21,66
Define Wind Attend From 2,10 To 40,130 Double

Do Attend

************
Proce Attend
************

On Key Label Ctrl+R Do mAttend
On Key Label F5     Do mVtime
On Key Label F6     Do mRtime

Repl All Employee.Option with 'N'

Brow Field Dept = Str(Employee.Deptcode,2)+'-'+Str(Employee.Empno,3)+'³'+Employee.Name+'³' :H= 'Code    Employee Name' :W=.F., Attend.&mTdate :H=' ':P='@!' :W= Dept() :V= Inlist(Attend.&mTdate,'P','A','L','F') :E= '(P)resent (A)bsent (L)ive (F)riday',;
Ovtime.Deptcode = '³':H=' ':W=.F., Artime.&mArtime  :P='XX.XX' :H='Time', Artime.Deptcode='³' :H=' ':W=.F. ,;
Artime.Empno='³' :H=' ':W=.F. ,Ovtime.&mOvtime :H='O/Time',Employee.Option :P='@!' :H=' ' :V= mDept() :F For Employee.Working = .T.  Wind Attend Title 'Daily Attendence'

If Readkey() = 12 Or Readkey() = 268
   Clear
   Close All
   Retu
Endif
    
*************
Proce mSum
*************

@22,09 Say str(Employee.Deptcode,2)+'-'+str(Employee.Empno,3)
@22,18 Say Employee.Salutation+'. '+Employee.Name

Sele 2

mPresent = occur('P',d1+d2+d3+D4+d5+d6+d7+d8+d9+d10+d11+d12+d13+d14+d15+d16+d17+d18+d19+d20+d21+d22+d23+d24+d25+d26+d27+d28+d29+d30+d31)
mAbsent  = occur('A',d1+d2+d3+D4+d5+d6+d7+d8+d9+d10+d11+d12+d13+d14+d15+d16+d17+d18+d19+d20+d21+d22+d23+d24+d25+d26+d27+d28+d29+d30+d31)
mLeave   = occur('L',d1+d2+d3+D4+d5+d6+d7+d8+d9+d10+d11+d12+d13+d14+d15+d16+d17+d18+d19+d20+d21+d22+d23+d24+d25+d26+d27+d28+d29+d30+d31)

Repl Attend.Present With mPresent
Repl Attend.Leave   With mLeave
Repl Attend.Absent  With mAbsent

Sele 3

mOvertime = d1ot+d2ot+d3ot+d4ot+d5ot+d6ot+d7ot+d8ot+d9ot+d10ot+d11ot+d12ot+d13ot+d14ot+d15ot+d16ot+d17ot+d18ot+d19ot+d20ot+d21ot+d22ot+d22ot+d23ot;
			+d24ot+d25ot+d26ot+d27ot+d28ot+d29ot+d30ot+d31ot

Repl Ovtime.Totalot With mOvertime

@24,30 Say "Total Over Time :"+Str(Ovtime.Totalot,3)+' .Hrs'
@24,10 Say "P=" +Str(Attend.Present,2)
@24,15 Say "L=" +Str(Attend.Leave,2)
@24,20 Say "A=" +Str(Attend.Absent,2)
@1,65 SAY mDate

*********
Func Dept 
*********

mDept = Employee.Deptcode
Sele 9
Seek mDept

If Found()
       @0,10 Say  'Department Name :' +Space(4)+Deptt.Deptname
       Do mSum
Endif

***********************
FUNCTION mDEPT
***********************
If Employee.Option = "Y" Or Employee.Option = "N" Or Employee.Option = "E" Or Employee.Option = "M"
If Employee.Option = "Y" Or Employee.Option = "M" And Salary.Otdaily = .T.
 
    Sele 10
    Set Order to DaName
    Seek Dtoc(mDate)+Employee.Name
    mTname=Employee.Name
 
    If Found()
        Wait Wind 'Date Al-Ready Exisit' Timeout 1
        Do mModify
        Retu
    Endif
 
    Sele 10            
    Append Blank
    Repl Depatt.Depcode With  Employee.Deptcode
    Repl Depatt.Name    With  Employee.Name
    Repl Depatt.Date    With  mDate
    Repl Depatt.O_Time  With  Ovtime  .&mOvtime
    Repl Depatt.Time    With  Artime  .&mArtime
    mOtotal = Ovtime.&mOvtime
    Do Detail
Endif 

    IF Employee.Option = "N" And Employee.Working = .T. And Salary.Otdaily = .T.
        
        Sele 10
        Set Order to CND
        
    Locate For Depatt.Depcode = Employee.Deptcode And Depatt.Name = Employee.Name And Depatt.Date = mDate 
   
   If !Found()
   
       Append Blank
       Repl Depatt.Depcode With  Employee.Deptcode
       Repl Depatt.Name    With  Employee.Name
       Repl Depatt.Date    With  mDate
       Repl Depatt.O_Time  With  Ovtime  .&mOvtime
       Repl Depatt.Time    With  Artime  .&mArtime
   Else 
        Wait Wind 'Record Al-Ready Exisit' Nowait
        Retu
    Endif
    
Endif

    IF Employee.Option = "E" And Employee.Working = .T. And Salary.Otdaily = .T.

        Sele 10
        Set Order to CND
        
       Locate For Depatt.Depcode = Employee.Deptcode And Depatt.Name = Employee.Name And Depatt.Date = mDate 

       If Found()
       
       Repl Depatt.Depcode With  Employee.Deptcode
       Repl Depatt.Name    With  Employee.Name
       Repl Depatt.Date    With  mDate
       Repl Depatt.O_Time  With  Ovtime  .&mOvtime
       Repl Depatt.Time    With  Artime  .&mArtime
       
   Endif
   Endif
Else
   Wait Wind '(Y)Detail O.T (N)Un-Detail (M)odiy In Overtime Detail (E)edit ' Nowait
   Retu 0
Endif  
 
Retu


****************
PROCEDURE DETAIL
****************

Define Wind Detail From 2,2 To 21,60 Shad Title ' Detail Of Over time  Daily' Footer '±± Escape For Exit From Detail ±±'
Acti wind Detail

Row =2

@0,0 Say 'DepCode  Employee Name     Date    Time   O-Time    More '  Color Scheme 5

mCode  = 0
mName  = Employee.Name
mDt    = mDate
mTime  = 'XX.XX'
mOtime = 0
mOption = Space(1)

Do While .T.

   @Row,2   Get mCode Pict '99' Valid Depart ()
   Read

   If Readkey() = 12 Or Readkey() = 268
      Repl Ovtime.&mOvtime With mOtotal
      Exit
   Endif
   
   @Row,08  Get mName Pict '@!XS15'
   @Row,25  Get mDate
   Clear Get 
   @Row,35  Get mTime   Pict 'XX.XX'
   @Row,42  Get mOtime  Pict '999.99'
   @Row,53  Get mOption Pict '!' Valid Inlist(mOption,'Y','N') Error('(Y)es (N)o')
   Read

If mOption = 'Y'
  
       Sele 10

       mOtotal=mOtotal+mOtime
              
       Append Blank

       Repl Depcode With mCode
       Repl Name    With mName
       Repl Date    With mDate
       Repl Time    With mTime 
       Repl O_Time  With mOtime

	   mCode   = 0
	   mTime   = '  .  '
	   mOtime  = 0
	   mOption = Space(1)
	   
	   Row = Row +1
	   If Row > 10
	      Row = 10	    
	      Scroll 02,02,10,60,1
	   Endif
	    Else 
    	    A=.T.
    Endif	    
Enddo	      

Deac Wind Detail
Retu

****************
Func  Depart
****************

Sele 9
     Seek mCode
     If found()
        mCode = Deptt.Deptcode
        Wait Wind 'Department :'+Space(3)+Deptname Nowait
        Retu 1
     Else
       Do Genpopup With 05,15,18,50,"'³'+str(Deptcode,2)+'³'+Deptname",'Department List'
       mCode = Deptt.DeptCode
     Endif
Retu     

**************
Proc mAttend
*************

Repl All Attend.&mTdate With 'P'

Brow Field Dept = Str(Employee.Deptcode,2)+'-'+Str(Employee.Empno,3)+'³'+Employee.Name+'³' :H= 'Employee Name' :W=.F., Attend.&mTdate :H=' ':P='@!' :W= Dept() :V= Inlist(Attend.&mTdate,'P','A','L','F') :E= '(P)resent (A)bsent (L)ive (F)riday',;
Ovtime.Deptcode = '³':H=' ':W=.F., Artime.&mArtime  :P='XX.XX' :H='Time', Artime.Deptcode='³' :H=' ':W=.F. ,;
Artime.Empno='³' :H=' ':W=.F. ,Ovtime.&mOvtime :H='O/Time',Employee.Option :P='@!' :H=' ' :V= mDept() :F For Employee.Working = .T.  Wind Attend Title 'Daily Attendence' Nowait
Retu

************
Proc mModify
************
Sele 10

Public mTota
mTota = 0

Define Wind Detail From 2,2 To 21,60 Shad Title ' Detail Of Over time  Daily' Footer '±± Escape For Exit From Detail ±±'
Set Filter To Depatt.Date = mDate And Depatt.Name = mTname 

Brow Fields Depcode :H= 'Code', Na = '³'+Name+'³' :H= 'Employee Name' :P='AAAAAAAAAAAAAAAAAAAAA' :W=.F.,;
Time,O_time,Da= '³'+Dtoc(Date)+'³' :W=.F. Wind Detail

Go Top
Do While !Eof()
    mTota = O_Time + mTota
	Skip 
Enddo
Set Filter To 

Sele 3
Repl Ovtime.&mOvtime With mTota
Retu

*****************
Procedure mVtime
*****************
Define Wind mVtime From 5,20 to 10,65  Title 'Over Time Range Wise Entry ' Shad Color Scheme 5
Acti Wind mVtime

mDep = 0
mVti = 0
@1,1 Say "Department Code :" Get mDep Pict '99'
@3,1 Say "Overtime        :" Get mVti Pict '999.99'
Read

Set Filter To Employee.Deptcode = mDep

*Repl All Ovtime.&mOvtime With mVti
Go Top
Do While !eof()
      If Employee.Working = .T.
      	 Repl  Ovtime.&mOvtime With mVti
      Endif
      Skip
Enddo      	 

Brow Field Dept = Str(Employee.Deptcode,2)+'-'+Str(Employee.Empno,3)+'³'+Employee.Name+'³' :H= 'Employee Name' :W=.F., Attend.&mTdate :H=' ':P='@!' :W= Dept() :V= Inlist(Attend.&mTdate,'P','A','L','F') :E= '(P)resent (A)bsent (L)ive (F)riday',;
Ovtime.Deptcode = '³':H=' ':W=.F., Artime.&mArtime  :P='XX.XX' :H='Time', Artime.Deptcode='³' :H=' ':W=.F. ,;
Artime.Empno='³' :H=' ':W=.F. ,Ovtime.&mOvtime :H='O/Time',Employee.Option :P='@!' :H=' ' :V= mDept() :F For Employee.Working = .T.  Wind Attend Title 'Daily Attendence' Nowait
Deac Wind mVtime
Set Filter To
Retu

Deac Wind mVtime

*****************
Procedure mRtime
*****************

Define Wind mVtime From 5,20 to 10,65  Title 'Arrival Time Range Wise Entry ' Shad Color Scheme 5
Acti Wind mVtime

mDep = 0
mVti = Space(5)

@1,1 Say "Department Code :" Get mDep Pict '99'
@3,1 Say "Arrival Time    :" Get mVti Pict 'XX.XX'
Read

Set Filter To Employee.Deptcode = mDep

Go Top
Do While !eof()
      If Employee.Working = .T.
      	 Repl  Artime.&mArtime With mVti
      Endif
      Skip
Enddo      	 

Brow Field Dept = Str(Employee.Deptcode,2)+'-'+Str(Employee.Empno,3)+'³'+Employee.Name+'³' :H= 'Employee Name' :W=.F., Attend.&mTdate :H=' ':P='@!' :W= Dept() :V= Inlist(Attend.&mTdate,'P','A','L','F') :E= '(P)resent (A)bsent (L)ive (F)riday',;
Ovtime.Deptcode = '³':H=' ':W=.F., Artime.&mArtime  :P='XX.XX' :H='Time', Artime.Deptcode='³' :H=' ':W=.F. ,;
Artime.Empno='³' :H=' ':W=.F. ,Ovtime.&mOvtime :H='O/Time',Employee.Option :P='@!' :H=' ' :V= mDept() :F For Employee.Working = .T.  Wind Attend Title 'Daily Attendence' Nowait

Deac Wind mVtime
Set Filter To
Retu
Deac Wind mVtime




