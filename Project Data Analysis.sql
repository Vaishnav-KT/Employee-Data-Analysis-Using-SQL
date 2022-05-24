CREATE DATABASE Projects;
USE Projects;
CREATE TABLE Employee(Empid int primary key,EmpName varchar(100),Department varchar(100),ContactNo bigint,EmailId varchar(100),EmpHeadId int);
DESCRIBE Employee;
INSERT INTO Employee(Empid,EmpName,Department,ContactNo,EmailId,EmpHeadId)
VALUES(101,'Isha','E-101',1234567890,'isha@gmail.com',105),
	  (102,'Priya','E-104',1234567890,'priya@yahoo.com',103),
      (103,'Neha','E-101',1234567890,'neha@gmail.com',101),
      (104,'Rahul','E-102',1234567890,'rahul@yahoo.com',105),
      (105,'Abhishek','E-101',1234567890,'abhishek@gmail.com',102);
SELECT * FROM Employee;

CREATE TABLE EmpDept(DeptId varchar(30) primary key,DeptName varchar(30),Dept_off varchar(40),DeptHead int);
INSERT INTO EmpDept(DeptId,DeptName,Dept_off,DeptHead)
VALUES('E-101','HR','Monday',105),
      ('E-102','Developement','Tuesday',101),
      ('E-103','HouseKeeping','Saturday',103),
      ('E-104','Sales','Sunday',104),
      ('E-105','Purchase','Tuesday',104);
SELECT * FROM EmpDept;

CREATE TABLE EmpSalary(EmpId int,Salary bigint,IsPermanent varchar(3),foreign key(EmpId) references Employee(Empid));
INSERT INTO EmpSalary(EmpId,Salary,IsPermanent)
VALUES(101,2000,'Yes'),
      (102,10000,'Yes'),
      (103,5000,'No'),
      (104,1900,'Yes'),
      (105,2300,'Yes');
SELECT * FROM EmpSalary;

CREATE TABLE Project(ProjectId varchar(30) primary key,Duration int);
INSERT INTO Project(ProjectId,Duration)
VALUES('p-1',23),
      ('p-2',15),
      ('p-3',45),
      ('p-4',2),
      ('p-5',30);
	SELECT * FROM Project;
    
CREATE TABLE Country(CId varchar(30) primary key,Cname varchar(50));
INSERT INTO Country(CId,Cname)
VALUES('c-1','India'),
      ('c-2','USA'),
      ('c-3','China'),
      ('c-4','Pakistan'),
      ('c-5','Russia');
SELECT * FROM Country;

CREATE TABLE ClientTable(ClientId varchar(30) primary key,ClientName varchar(50),cid varchar(30));
INSERT INTO ClientTable(ClientId,ClientName,cid)
VALUES('c1-1','ABC Group','c-1'),
      ('c1-2','PQR','c-1'),
      ('c1-3','XYZ','c-2'),
      ('c1-4','tech altum','c-3'),
      ('c1-5','mnp','c-5');
SELECT * FROM ClientTable;

CREATE TABLE EmpProject(EmpId int,ProjectId varchar(30),ClientId varchar(30),StartYear int,EndYear int,foreign key(EmpId) references Employee(Empid),foreign key(ProjectId) references Project(ProjectId),foreign key(ClientId) references ClientTable(ClientId));
DESCRIBE EmpProject;
INSERT INTO EmpProject(EmpId,ProjectId,ClientId,StartYear,EndYear)
VALUES(103,'p-1','C1-3',2013,Null),
      (104,'p-4','C1-1',2014,2015),
      (105,'p-4','C1-5',2015,Null);
      
SELECT * FROM EmpProject;


-- QUESTIONS
-- 1. Select the detail of employee whose name starts with p
SELECT * FROM Employee WHERE Empname like 'p%';

-- 2. How Many Permanent candidate take salary more than 5000
SELECT COUNT(SALARY) FROM EmpSalary WHERE IsPermanent = "Yes" and Salary > 5000;

-- 3. Select all details of employee whose emailid is in gmail
SELECT * FROM Employee WHERE EmailId like '%%gmail.com';

-- 4. Select the details of the employee who work either for department E-104 or E-102.
SELECT * FROM Employee WHERE Department = 'E-104' or Department = 'E-102';

-- 5. What is the department name for DeptID E-102?
SELECT DeptName FROM EmpDept WHERE DeptId = 'E-102';

-- 6. What is total salary that is paid to permanent employees?
SELECT SUM(SALARY) FROM EmpSalary WHERE IsPermanent = 'Yes';

-- 7. List name of all employees whose name ends with a.
 SELECT Empname FROM Employee WHERE EmpName LIKE '%a';
 
--  8. List the number of department of employees in each project.
 SELECT COUNT(EmpId) as Employee, ProjectId FROM EmpProject GROUP BY ProjectId;
 
--  9. How many project started in year 2010.
SELECT COUNT(ProjectId) FROM EmpProject WHERE StartYear = 2010;

-- 10. How many project started and finished in the same year.
SELECT COUNT(ProjectId) FROM EmpProject WHERE StartYear=EndYear;

-- 11. Select the name of the employee whose name's 3rd charactor is 'h'.
SELECT EmpName FROM Employee WHERE EmpName LIKE '__h%';

-- Nested Queries
-- 1.  Select the department name of the company which is assigned to the employee whose employee id is greater 103.
SELECT DeptName FROM EmpDept WHERE DeptId IN (SELECT Department FROM Employee WHERE EmpId>103);

-- 2.  Select the name of the employee who is working under Abhishek.
SELECT EmpName FROM Employee WHERE Empheadid =(SELECT EmpId FROM Employee WHERE EmpName='abhishek');

-- 3.   Select the name of the employee who is department head of HR.
SELECT EmpName FROM Employee WHERE Empid =(SELECT DeptHead FROM EmpDept WHERE DeptName = 'hr');

-- 4.   Select the name of the employee head who is permanent.
SELECT EmpName FROM Employee WHERE Empid in(SELECT Empheadid FROM Employee) AND Empid in(SELECT Empid FROM EmpSalary WHERE ispermanent='yes');

-- 5.   Select the name and email of the Dept Head who is not Permanent.
SELECT EmpName, EmailId FROM Employee WHERE Empid in(SELECT DeptHead FROM EmpDept ) AND empid in(select EmpId from EmpSalary WHERE ispermanent='no');

-- 6.   Select the employee whose department off is monday
SELECT * FROM Employee WHERE Department in(SELECT DeptId FROM EmpDept WHERE Dept_off='monday')

-- 7.   Select the indian clinets details.
SELECT * FROM ClientTable WHERE cid in(SELECT cid FROM Country WHERE Cname='India')

-- 8.   Select the details of all employee working in development department.
SELECT * FROM Employee WHERE Department in(SELECT DeptId FROM EmpDept WHERE DeptName='Developement')






























