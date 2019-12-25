SELECT 1
USE deduct ORDER empno

SELECT 2
USE employee ORDER empno

SELECT 3
USE month ORDER mcode

SELECT 4
USE instded ORDER empno

SELECT 5
USE salary ORDER empno

SELECT 6
USE saldtail ORDER empno

SELECT 7
USE salcode ORDER salcode

SELECT 8
USE tally ORDER empno

SELECT 5
SET RELATION TO salcode INTO salcode


SELECT 1
SET RELATION TO str(deptcode)+str(empno) INTO employee ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO instded ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO salary ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO saldtail ADDITIVE
SET RELATION TO mcode INTO month ADDITIVE
SET RELATION TO str(deptcode)+str(empno) INTO tally ADDITIVE

