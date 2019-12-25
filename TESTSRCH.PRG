*** PROGRAM TESTSRCH.PRG
* Testing to search name in employee.name
* From a loop

FOR f = 1 to 20
FOR t = 1 to 20

LOCATE FOR SUBSTR(Name,f,t) = "Amjad"

IF FOUND()
EXIT
ENDIF


ENDFOR

IF FOUND()
EXIT
ENDIF

ENDFOR
