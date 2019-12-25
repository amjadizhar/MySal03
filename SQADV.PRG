
SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "EcAdv",;
	   date,advamt;
FROM advance;
INTO CURSOR adv



SELECT STR(deptcode,2,0)+" -"+STR(empno,3,0) AS "Ecded",;
	   mcode,year,advance;
FROM deduct;
INTO CURSOR ded



SELECT EcAdv,date,advamt,;
	   sum(advance) AS "Deducted",;
	   advamt - sum(advance) AS "bal";
FROM adv,ded;
WHERE EcAdv = ded.Ecded;
ORDER BY EcAdv;
GROUP BY EcAdv;
INTO CURSOR tally
