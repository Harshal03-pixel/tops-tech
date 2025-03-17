create database MYDB;
use MYDB;

create table company (
CompanyID INT PRIMARY KEY,
CompanyName VARCHAR(45) NOT NULL,
Street VARCHAR(45),
City VARCHAR(45),
State VARCHAR(2),
Zip VARCHAR(10));
        
create table contact (
Contact_ID INT PRIMARY KEY,
Company_ID INT,
First_Name VARCHAR(45) NOT NULL,
Last_Name VARCHAR(45) NOT NULL,
Street VARCHAR(45),
City VARCHAR(45),
State VARCHAR(2),
Zip VARCHAR(10),
IsMain BOOLEAN,
Email VARCHAR(45),
Phone VARCHAR(12),
FOREIGN KEY (Company_ID) REFERENCES company(CompanyID)
);        

create table Employee (
Employee_ID INT PRIMARY KEY,
FirstName VARCHAR(45) NOT NULL,
LastName VARCHAR(45) NOT NULL,
Salary DECIMAL(10,2),
HireDate DATE,
JobTitle VARCHAR(25),
Email VARCHAR(45),
Phone VARCHAR(12)
);

create table ContactEmployee (
ContactEmployeeID INT PRIMARY KEY,
ContactID INT,
EmployeeID INT,
ContactDate DATE,
Description VARCHAR(100),
FOREIGN KEY (ContactID) REFERENCES Contact(Contact_ID),
FOREIGN KEY (EmployeeID) REFERENCES Employee(Employee_ID));

insert into company
value
(1, 'TechCorp', '123 Main St', 'New York', 'NY', '10001'),
(2, 'MarketCo', '456 Elm St', 'Los Angeles', 'CA', '90001');

insert into contact
value
(1, 1, 'John', 'Doe', '123 Main St', 'New York', 'NY', '10001', TRUE, 'johndoe@techcorp.com', '123-456-7890'),
(2, 2, 'Jane', 'Smith', '456 Elm St', 'Los Angeles', 'CA', '90001', FALSE, 'janesmith@marketco.com', '987-654-3210');

insert into Employee
value
(1, 'Michael', 'Johnson', 75000.00, '2020-06-15', 'Manager', 'michael@company.com', '111-222-3333'),
(2, 'Sarah', 'Williams', 65000.00, '2019-09-20', 'Sales Rep', 'sarah@company.com', '444-555-6666');

insert into ContactEmployee
value
(1, 1, 1, '2024-03-10', 'Discussed new software solutions');


-- 4) In the Employee table, the statement that changes Lesley Bland’s phone number to 215-555-8800 

use MYDB;
update Employee
set phone = '215-555-8888'
where FirstName = 'Michael' and LastName = 'Johnson';
select * from Employee;

-- 5) In the Company table, the statement that changes the name of “UrbanOutfitters, Inc.” to “Urban Outfitters”

use MYDB;
update company
set CompanyName = 'UrbanOutfitters'
where CompanyName = 'TechCorp';
select * from company;

-- 6) In ContactEmployee table, the statement that removes Dianne Connor’s contact
-- event with Jack Lee (one statement).

use MYDB;
delete from ContactEmployee
where ContactID = (select Contact_ID from Contact where First_Name = 'John' and Last_Name = 'Doe')
and EmployeeID = (select Employee_ID from Employee where FirstName = 'Michael' and LastName = 'Johnson');
select*from ContactEmployee;
select * from Contact;
select * from Employee;

-- 7) Write the SQL SELECT query that displays the names of the employees that
-- have contacted MarketCo (one statement). Run the SQL SELECT query in
-- MySQL Workbench. Copy the results below as well. 

select Employee.FirstName, Employee.LastName
from Employee
join ContactEmployee on Employee.Employee_ID = ContactEmployee.EmployeeID
join Contact on Contact.Contact_ID = ContactEmployee.ContactID
join Company on Contact.Company_ID = Company.CompanyID
where Company.CompanyName = 'MarketCo';

-- 8) What is the significance of “%” and “_” operators in the LIKE statement?

-- % (Percentage Wildcard): Represents zero or more characters.
-- Example: 'J%' matches John, James, Jack.

-- _ (Underscore Wildcard): Represents exactly one character.
-- Example: 'J_n' matches Jon, Jen, but not John.

-- 9) Explain normalization in the context of databases. 

-- Normalization is the process of structuring a database to reduce redundancy and improve data integrity
-- by organizing data into multiple related tables

-- 10) What does a join in MySQL mean? 

-- A JOIN in MySQL is used to combine rows from two or more tables based on a related column. 
-- It helps retrieve data from multiple tables in a single query.

-- Types of JOINs:
-- INNER JOIN :– Returns matching rows from both tables.
-- LEFT JOIN :– Returns all rows from the left table and matching rows from the right.
-- RIGHT JOIN :– Returns all rows from the right table and matching rows from the left.
-- FULL OUTER JOIN (not directly supported in MySQL) :– Returns all rows when there is a match in either table. 🚀

-- 11) What do you understand about DDL, DCL, and DML in MySQL?

-- DDL (Data Definition Language): Manages database structure (e.g., CREATE, ALTER, DROP).
-- DML (Data Manipulation Language): Handles data operations (e.g., INSERT, UPDATE, DELETE, SELECT).
-- DCL (Data Control Language): Manages access control (e.g., GRANT, REVOKE). 