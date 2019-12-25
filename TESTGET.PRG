* Program testget
* Calculates During Gets

CLEAR

SET TALK OFF
SET SYSMENU OFF

var1 = 0
var2 = 0
var3 = 0
total = 0

@ 5,5 GET var1 PICT "9999" WHEN total()
@ 6,5 GET var2 PICT "9999" WHEN total()
@ 7,5 GET var3 PICT "9999" WHEN total()

READ VALID total()

FUNCTION total

@ 10,0 SAY "Tot:"

total = var1+var2+var3

@ 10,4 SAY IIF(total=0,0,total) PICT "99999"

var1Pc = ROUND(IIF(var1=0,0,var1/total*100),2)
var2Pc = ROUND(IIF(var2=0,0,var2/total*100),2)
var3Pc = ROUND(IIF(var3=0,0,var3/total*100),2)

@ 5,12 SAY var1Pc PICT "999.99"
@ 6,12 SAY var2Pc PICT "999.99"
@ 7,12 SAY var3Pc PICT "999.99"

@ 10,12 SAY ROUND(Var1Pc+Var2Pc+Var3Pc,1) PICT "999.99"

@ 5,20 SAY "%"
@ 6,20 SAY "%"
@ 7,20 SAY "%"
@ 10,20 SAY "%"

RETURN .T.