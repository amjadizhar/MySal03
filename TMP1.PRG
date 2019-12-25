SET TALK OFF
SET STAT ON
SELE 1
USE SlryDat Alia SlryDat
Set Filter To Year=1997
SET ORDER TO DEmpNo
SELE 2
USE Saldtail Alia Saldtail
Set Filter To Year=1997
SET ORDER TO DEMCode
SELE 3
USE 1997 ALIA Summary
Sele SlryDat
Set Relation To Str(Deptcode,2)+str(empno,3)+str(mcode,2) Into Saldtail Additive
GOTO TOP
MDeptCode=0
MEmpNo=0
MName=Spac(20)
Store 0 To MM1,MM2,MM3,MM4,MM5,MM6,MM7,MM8,MM9,MM10,MM11,MM12
Store 0 To MO1,MO2,MO3,MO4,MO5,MO6,MO7,MO8,MO9,MO10,MO11,MO12
Store 0 To MD1,MD2,MD3,MD4,MD5,MD6,MD7,MD8,MD9,MD10,MD11,MD12
Store 0 TO MOT1,MOT2,MOT3,MOT4,MOT5,MOT6,MOT7,MOT8,MOT9,MOT10,MOT11,MOT12
DO WHILE .NOT. EOF()
	MDeptCode=DeptCode
	MEmpNo=EmpNo	
	MName=Name
	Do While DeptCode=MDeptCode .And. EmpNo=MEmpNo
		If MCode=1
			MM1=Tot_Pay
			MO1=Ot_Amt
			MD1=Saldtail.Days
			MOT1=Saldtail.Othrs
		Endif
		If MCode=2
			MM2=Tot_Pay
			MO2=Ot_Amt
			MD2=Saldtail.Days
			MOT2=Saldtail.Othrs
		Endif
		If MCode=3
			MM3=Tot_Pay
			MO3=Ot_Amt
			MD3=Saldtail.Days
			MOT3=Saldtail.Othrs
		Endif
		If MCode=4
			MM4=Tot_Pay
			MO4=Ot_Amt
			MD4=Saldtail.Days
			MOT4=Saldtail.Othrs
		Endif
		If MCode=5
			MM5=Tot_Pay
			MO5=Ot_Amt
			MD5=Saldtail.Days
			MOT5=Saldtail.Othrs
		Endif
		If MCode=6
			MM6=Tot_Pay
			MO6=Ot_Amt
			MD6=Saldtail.Days
			MOT6=Saldtail.Othrs
		Endif
		If MCode=7
			MM7=Tot_Pay
			MO7=Ot_Amt
			MD7=Saldtail.Days
			MOT7=Saldtail.Othrs
		Endif
		If MCode=8
			MM8=Tot_Pay
			MO8=Ot_Amt
			MD8=Saldtail.Days
			MOT8=Saldtail.Othrs
		Endif
		If MCode=9
			MM9=Tot_Pay
			MO9=Ot_Amt
			MD9=Saldtail.Days
			MOT9=Saldtail.Othrs
		Endif
		If MCode=10
			MM10=Tot_Pay
			MO10=Ot_Amt
			MD10=Saldtail.Days
			MOT10=Saldtail.Othrs
		Endif
		If MCode=11
			MM11=Tot_Pay
			MO11=Ot_Amt
			MD11=Saldtail.Days
			MOT11=Saldtail.Othrs
		Endif
		If MCode=12
			MM12=Tot_Pay
			MO12=Ot_Amt
			MD12=Saldtail.Days
			MOT12=Saldtail.Othrs
		Endif
		Skip
	Enddo
	Sele Summary
	Append Blank
	Replace Name With MName
	Replace Deptcode With MDeptcode
	Replace Empno With MEmpNo
	Replace M1 With MM1
	Replace M2 With MM2
	Replace M3 With MM3
	Replace M4 With MM4
	Replace M5 With MM5
	Replace M6 With MM6
	Replace M7 With MM7
	Replace M8 With MM8
	Replace M9 With MM9
	Replace M10 With MM10
	Replace M11 With MM11
	Replace M12 With MM12
	Replace O1 With MO1
	Replace O2 With MO2
	Replace O3 With MO3
	Replace O4 With MO4
	Replace O5 With MO5
	Replace O6 With MO6
	Replace O7 With MO7
	Replace O8 With MO8
	Replace O9 With MO9
	Replace O10 With MO10
	Replace O11 With MO11
	Replace O12 With MO12
	Replace D1 With MD1
	Replace D2 With MD2
	Replace D3 With MD3
	Replace D4 With MD4
	Replace D5 With MD5
	Replace D6 With MD6
	Replace D7 With MD7
	Replace D8 With MD8
	Replace D9 With MD9
	Replace D10 With MD10
	Replace D11 With MD11
	Replace D12 With MD12

	Replace OT1 With MOT1
	Replace OT2 With MOT2
	Replace OT3 With MOT3
	Replace OT4 With MOT4
	Replace OT5 With MOT5
	Replace OT6 With MOT6
	Replace OT7 With MOT7
	Replace OT8 With MOT8
	Replace OT9 With MOT9
	Replace OT10 With MOT10
	Replace OT11 With MOT11
	Replace OT12 With MOT12

	MDeptCode=0
	MEmpNo=0
	MName=Spac(20)
	Store 0 To MM1,MM2,MM3,MM4,MM5,MM6,MM7,MM8,MM9,MM10,MM11,MM12
	Store 0 To MO1,MO2,MO3,MO4,MO5,MO6,MO7,MO8,MO9,MO10,MO11,MO12
	Store 0 To MD1,MD2,MD3,MD4,MD5,MD6,MD7,MD8,MD9,MD10,MD11,MD12
	Store 0 TO MOT1,MOT2,MOT3,MOT4,MOT5,MOT6,MOT7,MOT8,MOT9,MOT10,MOT11,MOT12

	Sele SlryDat
ENDDO
CLOSE ALL
CLEAR ALL
RETURN






