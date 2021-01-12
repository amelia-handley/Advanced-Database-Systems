--ANSWERS TO TASK 4

-- QUESTION A

SELECT  e.print_name() AS "Employee Name"
FROM 	table_employee e 
WHERE 	lower(e.name.firstName) LIKE lower('%st%') 
AND e.address.city = 'Edinburgh';

-- QUESTION B 

SELECT b.bID.bID AS "Branch ID",
	   b.bID.print_address() AS "Branch Address",
	   COUNT(b.accType) AS "Number of Savings Accounts"
FROM table_account b
WHERE accType = 'savings'
GROUP BY b.bID.bID, b.bID.print_address()
ORDER BY b.bID.bID ASC;

-- QUESTION C
  
SELECT c.accNum.bID.bID AS "Branch ID",
	   c.custID.print_name() AS "Customer Name",
	   c.accNum.balance AS "Savings Balance"
FROM   table_customer_account c,
       (SELECT a.bID.bID AS bID,
               a.accType AS accType,
               MAX(a.balance) AS balance
        FROM table_account a
        GROUP BY a.bID.bID, a.accType) highestBalance
WHERE c.accNum.bID.bID = highestBalance.bID
AND c.accNum.balance = highestBalance.balance
AND c.accNum.accType = highestBalance.accType
AND c.accNum.accType = 'savings'
ORDER BY c.accNum.bID.bID ASC;

-- QUESTION D   

SELECT e.bID.print_address() AS "Work Address",
       c.accNum.bID.print_address() AS "Customer Branch Address",
	   e.print_name() AS "Employee Name"
FROM table_employee e, table_customer_account c
WHERE c.custID.print_name() = e.print_name()
AND e.supervisorID.position.jobTitle = 'Manager'
ORDER BY e.bID ASC;

-- QUESTION E  

SELECT c.accNum.bID.bID AS "Branch ID",
       c.accNum.accNum AS "Customer Account Number",
	   c.accNum.limitOfFreeOD AS "Overdraft Limit"
FROM   table_customer_account c,
       (SELECT a.bID.bID AS bID,
		      MAX(a.limitOfFreeOD) AS odLimit
	   FROM table_account a
	   GROUP BY a.bID.bID) freeOD
WHERE c.accNum.limitOfFreeOD = freeOD.odLimit
AND c.accNum.bID.bID = freeOD.bID
AND c.accNum.accType = 'current'
GROUP BY c.accNum.bID.bID, c.accNum.accNum, c.accNum.limitOfFreeOD
HAVING COUNT(c.accNum) = 2
ORDER BY c.accNum.bID.bID ASC;

-- QUESTION F  

SELECT c.custID AS "Customer ID",
       t.phoneType AS "Phone Type",
       t.phoneNumber AS "Mobile Number"
FROM table_customer c, table(c.phone) t
WHERE t.phoneType LIKE '%Mobile2%'
AND t.phoneNumber LIKE '%0750%'
GROUP BY c.custID, t.phoneType, t.phoneNumber;

-- QUESTION G  

SELECT e.supervisorID.print_name() AS "Supervisor",
       COUNT(e.empID) AS "Number of Employees"
FROM table_employee e
WHERE  e.supervisorID.name.title  = 'Mrs'
AND e.supervisorID.name.surName = 'Smith'
OR e.supervisorID.name.title = 'Mr'
AND e.supervisorID.name.surName = 'Jones'
GROUP BY e.supervisorID.print_name()

-- QUESTION H