*-------------------------------*
*Program To Close Year			*
*Author		:	Muhammad Usman	*
*Date		:	21-10-1999		*
*Prog		:	Year			*
*Last Modify:	21-10-1999		*
*-------------------------------*
*-----------------------------------------------
* Window Defination
	DEFINE WINDOW Year ;
		FROM INT((SROW()-16)/2),INT((SCOL()-69)/2) ;
		TO INT((SROW()-16)/2)+15,INT((SCOL()-69)/2)+68 ;
		TITLE " CLOSING YEAR " ;
		NOFLOAT ;
		NOCLOSE ;
		SHADOW ;
		NOMINIMIZE ;
		PANEL ;
		COLOR SCHEME 5
		
	ACTIVATE WINDOW Year SAME
*-----------------------------------
Do DspHedPro
Wait Wind 'Press Enter To Continue'
Rele Wind Year
Return
*-----------------------------------
Procedure DspHedPro							&& Display Heading Procdure
@ 4,10 Say "Please Refer To.........."
@ 6,10 Say "Mr. Muhammad Usman"
@ 8,10 Say "M/s. Dynamic Software, Lahore."
@ 10,10 Say "Ph: 0092-42-6373896, 6374558"
*-----------------------------------
