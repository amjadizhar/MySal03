SET TALK OFF
SET STAT ON
SELE 1
USE 1999 ALIA F1999
Set Order To Dempno

Sele 2
Use 1998 Alia F1998
Set Order To DEmpno

Sele F1999
Set Order To DEmpno
Goto Top

MDeptCode=0
MEmpNo=0
MName=Spac(20)
MLine=1


*Set Device To Print
*Set Printer On

Do While .Not. Eof()
	MDeptCode=DeptCode
	MEmpNo=EmpNo	
	MName=Name

	Sele F1998
	Set Order To DEmpno
	Seek Str(MDeptcode,2)+Str(MEmpNo,3)
	If .Not. Found()
*		@ MLine,10 Say Str(MDeptCode,2)+"  "+Str(MEmpNo,3)+"  "+MName
*		MLine=MLine+1
		Append Blank
		Replace Deptcode With MDeptCode
		Replace EmpNo With MempNo
		Replace Name With MName
	Endif		
	Sele F1999
	Skip
	MDeptCode=0
	MEmpNo=0
	MName=Spac(20)
Enddo
Set Device To Screen
CLOSE ALL
CLEAR ALL
RETURN






