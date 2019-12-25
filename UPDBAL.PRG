*-----------------------------------*
*Program to Upto Date Balances		*
*Author		:	Muhammad Usman		*
*Date		:	08-02-2000			*
*Prog		:	Updbal				*
*Last Modify:	08-02-2000			*
*-----------------------------------*
* Window Defination
	DEFINE WINDOW updbal ;
		FROM INT((SROW()-15)/1),INT((SCOL()-68)/1) ;
		TO INT((SROW()-15)/1)+6,INT((SCOL()-68)/1)+50 ;
		TITLE "UPDATE BALANCES" ;
		NOFLOAT ;
		NOCLOSE ;
		SHADOW ;
		NOMINIMIZE ;
		PANEL ;
		COLOR SCHEME 1

*-----------------------------------
Close Databases
ACTIVATE WINDOW updbal SAME
@ 01,06 Say 'Dont Use This Program On Any Terminal'
@ 02,04 Say 'Updating in progress, Please Dont Distrub'

Sele 1
Use ITran Alia ITran Shared

Sele 2
Use Tran2 Alia Tran2 Shared

Sele 3
Use LdgrCod Alia LdgrCod Shared

*-----------------------------------
*Veriable Initialization
MDoc_No=Spac(6)						&& Document Number
MDoc_Type=0							&& Document Type
MAmount=0							&& Total Amount
MDate=Ctod("  /  /    ")			&& Invoice Date
MC1=0								&& Party Code 1
MC2=0								&& Party Code 2
MC3=0								&& Party Code 3
MCR_DR=Spac(2)						&& Credit / Debit
*-----------------------------------
Sele ITran
Set Order To Type_No
Goto Top
Do While .Not. Eof()
	MDoc_No=Doc_No
	MDoc_Type=Doc_Type
	MDate=Date
	MC1=C1
	MC2=C2
	MC3=C3
	Do While Doc_Type=MDoc_Type .And. Doc_No=MDoc_No
		MAmount=MAmount+Amount
		Skip
	Enddo			
	Sele Tran2
	Set Order To Type_No
	Seek Str(MDoc_Type,1)+MDoc_No
	IF .Not. Found()
		Append Blank
		Replace Date With MDate
		Replace C1 With MC1
		Replace C2 With MC2
		Replace C3 With MC3
		Replace Amount With MAmount
		Replace Doc_Type With MDoc_Type
		Replace Doc_No With MDoc_No
		Replace Cr_Dr With "DR"
		Replace Disc With "SALE INVOICE"
	Else
		Replace Amount With MAmount
		Replace Cr_Dr With "DR"
		Replace Disc With "SALE INVOICE"
	Endif
	Flush
	MDoc_No=Spac(6)						&& Document Number
	MDoc_Type=0							&& Document Type
	MAmount=0							&& Total Amount
	MDate=Ctod("  /  /    ")			&& Invoice Date
	MC1=0								&& Party Code 1
	MC2=0								&& Party Code 2
	MC3=0								&& Party Code 3
	Sele ITran
Enddo
Sele LdgrCod
Replace All Ldgr_Bal With 0
Replace All Status With "  "
Sele Tran2
Set Order To DDD_No
Goto Top
MC1=0								&& Party Code 1
MC2=0								&& Party Code 2
MC3=0								&& Party Code 3
MAmount=0							&& Total Amount
MCR_DR=Spac(2)						&& Credit / Debit
Do While .Not. Eof()
	MC1=C1
	MC2=C2
	MC3=C3
	MAmount=Amount
	MCR_DR=Cr_Dr
	Sele Ldgrcod
	Set Order To C123
	Seek Str(MC1,2)+Str(MC2,2)+Str(MC3,3)
	If Status="  "
		If MCr_Dr="DR"
			MLdgr_Bal=MAmount
			MStatus="DR"
		Else
			MLdgr_Bal=MAmount
			MStatus="CR"
		Endif
	Endif
	If Status="DR"
		If MCr_Dr="DR"
			MLdgr_Bal=Ldgr_Bal+MAmount
			MStatus="DR"
		Else
			MLdgr_Bal=Ldgr_Bal-MAmount
			If MLdgr_Bal>0
				MStatus="DR"
			Else
				MStatus="CR"
			Endif				
		Endif
	Endif				
	If Status="CR"
		If MCr_Dr="CR"
			MLdgr_Bal=Ldgr_Bal+MAmount
			MStatus="CR"
		Else
			MLdgr_Bal=Ldgr_Bal-MAmount
			If MLdgr_Bal>0
				MStatus="CR"
			Else
				MStatus="DR"
			Endif				
		Endif
	Endif				
	Replace Ldgr_Bal With ABS(MLdgr_Bal)
	Replace Status With MStatus
	Flush
	MC1=0								&& Party Code 1
	MC2=0								&& Party Code 2
	MC3=0								&& Party Code 3
	MAmount=0							&& Total Amount
	MCR_DR=Spac(2)						&& Credit / Debit
	Sele Tran2
	Skip
Enddo

Rele Wind updbal
Wait Wind 'Updating Process Completed' Nowait
Return
