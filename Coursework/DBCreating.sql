--CREATING TYPES, TABLES AND MEMBER FUNCTIONS
--TYPES

CREATE TYPE type_Name AS OBJECT
	(title VARCHAR2(10),
	firstName VARCHAR2(20),
	surName VARCHAR2(20))
	FINAL
/
	
CREATE TYPE type_Address AS OBJECT
	(street VARCHAR2(20),
	city VARCHAR2(20),
	postCode VARCHAR2(9))
	NOT FINAL
/

CREATE TYPE type_Phone AS OBJECT
	(phoneType VARCHAR(20),
	phoneNumber VARCHAR(15))
	NOT FINAL
/
CREATE TYPE table_Phone_nested AS TABLE OF type_Phone
/

CREATE TYPE type_Person AS OBJECT
	(name type_Name,
	address type_Address,
	phone table_Phone_nested,
	niNum VARCHAR2(10))
	NOT FINAL
/

CREATE TYPE type_Employee_Position AS OBJECT
	(jobID VARCHAR2(10),
	jobTitle VARCHAR2(15),
	salary VARCHAR2(20))
	FINAL
/

--SUBTYPES

CREATE TYPE type_Branch UNDER type_Address
	(bID VARCHAR2(10),
	phone table_Phone_nested)
	FINAL
/

CREATE TYPE type_Employee UNDER type_Person
	(empID VARCHAR2(10),
	bID REF type_Branch,
	position REF type_Employee_Position,
	supervisorID REF type_Employee,
	joinDate DATE)
	FINAL
/

CREATE TYPE type_Customer UNDER type_Person
	(custID VARCHAR2(10))
	FINAL
/

-- ACCOUNT TYPE

CREATE TYPE type_Account AS OBJECT
	(accNum VARCHAR2(10),
	accType VARCHAR2(12),
	balance VARCHAR2(20),
	bID REF type_Branch,
	inRate VARCHAR2(10),
	limitOfFreeOD VARCHAR2(10),
	openDate DATE)
	FINAL
/

--TABLES

CREATE TABLE table_account OF type_Account
	(accNum PRIMARY KEY,
	CONSTRAINT accType_const CHECK (accType IN ('current', 'savings')),
	CONSTRAINT bID_const CHECK (bID IS NOT NULL),
	CONSTRAINT openDate CHECK (openDate IS NOT NULL));
/

CREATE TABLE table_employee_position OF type_employee_position
	(jobID PRIMARY KEY,
	CONSTRAINT jobTitle_const CHECK (jobTitle IS NOT NULL),
	CONSTRAINT salary_const CHECK (salary IS NOT NULL));
/

CREATE TABLE table_employee OF type_employee
	(empID PRIMARY KEY,
	CONSTRAINT name_const CHECK (name IS NOT NULL),
	CONSTRAINT niNum_const UNIQUE (niNum),
	CONSTRAINT bID_constraint CHECK (bID IS NOT NULL),
	CONSTRAINT phone_const CHECK (phone IS NOT NULL),
	CONSTRAINT joinDate_const CHECK (joinDate IS NOT NULL),
	CONSTRAINT position_const CHECK (position IS NOT NULL))
	NESTED TABLE phone STORE AS employee_phone_nt;
/

CREATE TABLE  table_customer OF type_Customer
	(custID PRIMARY KEY,
	CONSTRAINT name_constraint CHECK (name IS NOT NULL),
	CONSTRAINT address_const CHECK (address IS NOT NULL),
	CONSTRAINT niNum_constraint CHECK (niNum IS NOT NULL))
	NESTED TABLE phone STORE AS customer_phone_nt;
/

CREATE TABLE  table_branch OF type_Branch
	(bID PRIMARY KEY,
	CONSTRAINT street_const CHECK (street IS NOT NULL),
	CONSTRAINT city_const CHECK (city IS NOT NULL),
	CONSTRAINT postCode_const CHECK (postCode IS NOT NULL))
	NESTED TABLE phone STORE AS branch_phone_nt;
/

CREATE TABLE table_customer_account
	(custID REF type_Customer SCOPE IS table_customer,
	accNum REF type_Account SCOPE IS table_account);
/

--MEMBER FUNCTIONS

ALTER TYPE type_person
ADD MEMBER FUNCTION print_name RETURN VARCHAR2,
ADD MEMBER FUNCTION print_address RETURN VARCHAR2 CASCADE;
/
CREATE OR REPLACE TYPE BODY type_person AS
MEMBER FUNCTION print_name RETURN VARCHAR2 IS
BEGIN
	RETURN name.title|| ' '|| name.firstName|| ' ' || name.surName;
END print_name;

MEMBER FUNCTION print_address RETURN VARCHAR2 IS
BEGIN
	RETURN address.street|| ', '|| address.city|| ', ' || address.postCode;
END print_address;
END;
/

ALTER TYPE type_Branch
ADD MEMBER FUNCTION print_address RETURN VARCHAR2 CASCADE;
/
CREATE OR REPLACE TYPE BODY type_Branch AS
MEMBER FUNCTION print_address RETURN VARCHAR2 IS
BEGIN
	RETURN SELF.street|| ', '|| SELF.city|| ', ' || SELF.postCode;
END print_address;
END;
/



