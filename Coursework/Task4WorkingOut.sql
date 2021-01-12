-- ANSWERS TO TASK 4


-- 	QUESTION A (3 MARKS)
/* SELECT e.name.title|| ' '||
       e.name.firstName|| ' '||
       e.name.surName|| ' '|| */
	   
SELECT  e.print_name() AS "Employee Name"
FROM 	table_employee e 
WHERE 	lower(e.name.firstName) LIKE lower('%st%') AND e.address.city = 'Edinburgh';


-- QUESTION B (3 MARKS)

SELECT b.bID.bID AS "Branch ID",
	   b.bID.print_address() AS "Branch Address",
	   COUNT(b.accType) AS "Number of Savings Accounts"
FROM table_account b
WHERE accType = 'savings'
GROUP BY b.bID.bID, 
         b.bID.print_address(),
         b.accType
ORDER BY b.bID.bID ASC;


-- QUESTION C (3 MARKS)

/* SELECT a.bID.bID AS "Branch ID",
       --a.accType AS "Account Type",
	   --a.print_name() AS "Customer Name",
       MAX(a.balance) AS "Max Balance"
FROM table_account a
WHERE a.accType = 'savings'
GROUP BY a.bID.bID, a.balance 

SELECT a.bID.bID AS "Branch ID",
       a.accType AS "Account Type",
	   c.custID.print_name() AS "Customer Name",
	   MAX(a.balance) AS "highestBalance"
	   FROM (
	   SELECT a.accNum.bID.bID,
	          a.accNum.accType
			  MAX(a.accNum.balance)
			  FROM table_account accNum
			  GROUP BY a.accNum.bID.bID, c.accNum.accType
			 ) account, table_customer_account c
		WHERE c.accNum.bID.bID = account.bID
		AND c.accNum.accType = 'savings'
		AND c.accNum.accType = account.accType
		AND c.accNum.balance = account.highestBalance
	   	
	   	   
/* SELECT c.accNum.bID.bID AS "bID", 
        c.print_name() AS "Customer Name",
	   c.balance AS "savingsBalance"
	   FROM(
	   SELECT c.accNum.bID.bID,
			  c.accNum.accType,
			  MAX (c.accNum.balance)
			  FROM table_account c
			  GROUP BY c.accNum.bID.bID, c.accNum.accType
		) balance, table_customer_account c
		WHERE  c.accNum.bID.bID = balance.bID
		AND c.accNum.accType = 'savings'
		AND c.accNum.accType = balance.accType
		AND c.accNum.balance = balance.highestBalance */ 

/* SELECT a.accNum.bID.bID AS "Branch ID",
       a.accNum.accType AS "Account Type",
	   c.custID.print_name() AS "Customer Name",
	   MAX(a.accNum.balance) AS "Balance"
	   FROM (
           SELECT a.bID.bID AS "Branch ID",
                  a.accType AS "Account Type",
                  --a.print_name() AS "Customer Name",
                  MAX(a.balance) AS highestBalance
           FROM table_account a
           GROUP BY a.bID.bID, a.accType, a.balance
			 ) balance, table_customer_account c
		WHERE c.accNum.bID.bID = balance.bID
		AND c.accNum.accType = 'savings'
		AND c.accNum.accType = balance.accType
		AND c.accNum.balance = balance.highestBalance */

SELECT c.accNum.bID.bID AS "Branch ID",
	   c.custID.print_name() AS "Customer Name",
	   c.accNum.balance AS "Savings Balance"
FROM   table_customer_account c,
       (SELECT a.bID.bID AS bID,
               a.accType AS accType,
               MAX(a.balance) AS balance
        FROM table_account a
        GROUP BY a.bID.bID, a.accType
        ) highestBalance
WHERE c.accNum.bID.bID = highestBalance.bID
AND c.accNum.accType = 'savings'
AND c.accNum.balance = highestBalance.Balance
AND c.accNum.accType = highestBalance.accType
ORDER BY c.accNum.bID.bID ASC;

-- QUESTION D (3 MARKS)

/* SELECT e.print_name AS "Employee Name",
          e.bID.city AS "Branch City",
		 e.bID.street AS "Branch Street",
		 e.bID.postCode AS "Branch PostCode",
		 c.custID.print_address() AS "Home Address"
*/

SELECT e.print_name() AS "Employee Name",
       c.accNum.accNum AS "Account Number",
       e.empID AS "Employee ID",
       e.supervisorID.print_name() AS "Supervisor Name",
       e.supervisorID.position.jobTitle AS "Supervisor Job Title",
       e.bID.print_address() AS "Work Address",
       c.custID.print_address() AS "Employee Home Address"
FROM table_employee e, table_customer_account c
WHERE c.custID.name.firstName = e.name.firstName
AND c.custID.name.surName = e.name.surName
AND e.supervisorID.position.jobTitle = 'Manager'
ORDER BY e.empID ASC;
	   
	   
-- QUESTION E(5 MARKS)

/* SELECT c.accNum.bID.bID AS branchID,
       MAX(c.accNum.limitOfFreeOD) AS odLimit
FROM table_customer_account c
GROUP BY c.accNum.bID.bID */

/* SELECT c.accNum.bID AS bID,
       c.custID.print_name() AS customerName,
	   c.custID.limitOfFreeOD AS overdraftLimit
	   FROM (
		   SELECT c.accNum.bID.bID AS bID,
				  MAX(c.accNum.limitOfFreeOD) AS odLimit
		   FROM table_customer_account c
		   GROUP BY c.accNum.bID.bID
        ) odLimit, table_customer_account c
WHERE c.accNum.limitOFFreeOD = odLimit.odLimit
AND a.accNum.bID.bID = odLimit.bID */

/* SELECT c.accNum.bID.bID AS "Branch ID",
       c.accNum AS "Customer Account Number",
       --c.custID.name.firstName AS "First Name",
       --c.custID.name.surName As "Surname",
	   c.accNum.limitOfFreeOD AS "Overdraft Limit"
FROM   table_customer_account c,
       (SELECT a.bID.bID AS bID,
		      MAX(a.limitOfFreeOD) AS odLimit
	   FROM table_account a
	   GROUP BY a.bID.bID) freeOD
WHERE c.accNum.limitOfFreeOD = freeOD.odLimit
AND c.accNum.bID.bID = freeOD.bID
AND c.accNum.accType = 'current'
GROUP BY c.accNum.bID.bID, c.custID.name.surName, c.accNum.limitOfFreeOD
HAVING COUNT(c.accNum) = 2
ORDER BY c.accNum.bID.bID ASC; */

SELECT c.accNum.bID.bID AS bID,
       c.custID.print_name()AS customerName,
	   c.accNum.limitOfFreeOD AS overdraftLimit
	   FROM (
		   SELECT c.accNum.bID.bID AS bID,
				  MAX(c.accNum.limitOfFreeOD) AS odLimit
		   FROM table_customer_account c
		   GROUP BY c.accNum.bID.bID
           HAVING COUNT(c.accNum) = 2
        ) odLimit, table_customer_account c
WHERE c.accNum.limitOfFreeOD = odLimit.odLimit
AND c.accNum.bID.bID = odLimit.bID
AND c.accNum.accType = 'current'
ORDER BY c.accNum.bID.bID ASC;



-- QUESTION F (5 MARKS)

/* SELECT c.custID AS custID,
       COUNT(t.phoneType) AS mobileCount,
       t.phoneType AS phoneType,
       t.phoneNumber AS mobileNumber
FROM table_customer c, table(c.phone) t
WHERE t.phoneType LIKE '%Mobile%'
AND t.phoneNumber LIKE '%0750%'
GROUP BY c.custID, t.phoneType, t.phoneNumber */

/* SELECT c.custID AS custID,
       t.phoneType AS phoneType,
       t.phoneNumber AS mobileNumber,
       (SELECT COUNT(t.phoneType) AS mobileCount,
               t.phoneType AS phoneType,
               c.custID AS custID
       FROM table_customer_account c, table(c.phone)t
       WHERE c.phoneType LIKE '%Mobile1%'
       AND t.phoneNumber LIKE '%0750%') phoneCount
FROM table_customer c, table(c.phone) t
WHERE c.phone.phoneType = t.phoneType
AND phoneCount.mobile =2; */

	   
	   
SELECT c.custID AS custID,
       c.print_name() AS custName,
       t.phoneType AS phoneType,
       t.phoneNumber AS phoneNumber
FROM (
        SELECT c.custID AS custID,
               t.phoneType AS phoneType,
               COUNT(t.phoneType) AS countPhone
        FROM table_customer c, table(c.phone) t
        WHERE t.phoneType LIKE '%Mobile%'
        GROUP BY c.custID, t.phoneType
        ) mobilePhone, table_customer c, table(c.phone) t
WHERE c.custID = mobilePhone.custID
AND t.phoneType = mobilePhone.phoneType
AND t.phoneType LIKE '%Mobile%'
AND t.phoneNumber LIKE '%0750%'
AND mobilePhone.countPhone = 2



-- QUESTION G (5 MARKS)

SELECT e.supervisorID.print_name() AS "Supervisor",
       COUNT(e.empID) AS "Number of Employees"
FROM table_employee e
FROM table_employee e
WHERE  e.supervisorID.name.title = 'Mrs'
AND e.supervisorID.name.surName = 'Smith'
OR e.supervisorID.name.title = 'Mr'
AND e.supervisorID.name.surName = 'Jones'
GROUP BY e.supervisorID.print_name()

/* SELECT e.name.title AS "Title",
       e.name.firstName AS "Firstname",
       e.name.surName AS "Surname",
       COUNT(e.empID) AS "Number of Employees",
	   e.supervisorID.print_name() "Supervisor"
FROM table_employee e
WHERE  e.name.title = 'Mrs'
AND e.name.surName = 'Smith'
OR e.name.title = 'Mr'
AND e.name.surName = 'Jones'
GROUP BY e.name.title, e.name.firstName,e.name.surName, e.supervisorID.print_name(); */

-- QUESTION H (8 MARKS)

/* CREATE OR REPLACE TYPE ah_job2 AS OBJECT (
jobtitle varchar(20),
job_id int,
salary_amount int,
years_of_experience int,
MEMBER FUNCTION evaluate_qualification RETURN STRING,
MEMBER FUNCTION salary_fraction(N real) RETURN real
);
/
CREATE OR REPLACE TYPE BODY ah_job2 AS
MEMBER FUNCTION evaluate_qualification RETURN STRING IS
BEGIN
IF self.years_of_experience < 2 THEN
RETURN 'too bad';
ELSIF self.years_of_experience = 2 THEN
RETURN 'OK';
ELSE
RETURN 'great!';
END IF;
END evaluate_qualification;
MEMBER FUNCTION salary_fraction(N real) RETURN real IS
sal real;
BEGIN
sal :=(self.salary_amount/n);
return sal;
END salary_fraction;
END;
 */




