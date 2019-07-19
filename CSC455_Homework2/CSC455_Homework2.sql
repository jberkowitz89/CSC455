Homework #2
#Table Department#

DROP TABLE Department;
CREATE TABLE Department(
  Dept#	INT,
	DeptName VARCHAR2(25),
	Manager#  INT);
INSERT INTO Department VALUES(5,'Research',102);
INSERT INTO Department VALUES(4,'Admin',104);
INSERT INTO Department VALUES(1,'Main', 108);
COMMIT
SELECT * FROM Department

table DEPARTMENT created.
1 rows inserted.
1 rows inserted.
1 rows inserted.
committed.
     DEPT# DEPTNAME                    MANAGER#
---------- ------------------------- ----------
         5 Research                         102 
         4 Admin                            104 
         1 Main                             108 
		 
#Table Employee#
CREATE TABLE Employee(
	Emp#	INT,
	EName	VARCHAR2(25),
	Super#	INT,
	Dept#	INT);
INSERT INTO Employee VALUES(101,'Smith',102,5);
INSERT INTO Employee VALUES(102,'Wong',108,5);
INSERT INTO Employee VALUES(103,'Zelaya',104,4);
INSERT INTO Employee VALUES(104,'Wallace',108,4);
INSERT INTO Employee VALUES(105,'Narreen',102,5);
INSERT INTO Employee VALUES(106,'English',102,5);
INSERT INTO Employee VALUES(107,'Ahmed',104,4);
INSERT INTO Employee VALUES(108,'Borg',NULL,1);
COMMIT
SELECT * FROM Employee

table EMPLOYEE created.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
committed.
      EMP# ENAME                         SUPER#      DEPT#
---------- ------------------------- ---------- ----------
       101 Smith                            102          5 
       102 Wong                             108          5 
       103 Zelaya                           104          4 
       104 Wallace                          108          4 
       105 Narreen                          102          5 
       106 English                          102          5 
       107 Ahmed                            104          4 
       108 Borg                                          1 

 8 rows selected 
 
#Table Dependent#
CREATE TABLE Dependent(
	Emp#	INT,
	DName	VARCHAR2(25)  );
INSERT INTO Dependent VALUES(102,'Alice');
INSERT INTO Dependent VALUES(102,'Theodore');
INSERT INTO Dependent VALUES(102,'Joy');
INSERT INTO Dependent VALUES(104, 'Sam');
INSERT INTO Dependent VALUES(101, 'Michael');
INSERT INTO Dependent VALUES(101, 'Alice');
INSERT INTO Dependent VALUES(108, 'Elizabeth');
COMMIT
SELECT * FROM Dependent


table DEPENDENT created.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
committed.
      EMP# DNAME                   
---------- -------------------------
       102 Alice                     
       102 Theodore                  
       102 Joy                       
       104 Sam                       
       101 Michael                   
       101 Alice                     
       108 Elizabeth                 

 7 rows selected 
 
#Table DeptLocation#
CREATE TABLE DeptLocation(
	Dept#	INT,
	DeptLocation	VARCHAR2(25)  );
INSERT INTO DeptLocation VALUES(1, 'Houston');
INSERT INTO DeptLocation VALUES(4, 'Stanford');
INSERT INTO DeptLocation VALUES(5, 'Bellaire');
INSERT INTO DeptLocation VALUES(5, 'Chicago');
INSERT INTO DeptLocation VALUES(5, 'Houston');
COMMIT
SELECT * FROM DeptLocation

table DEPTLOCATION created.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
committed.
     DEPT# DEPTLOCATION            
---------- -------------------------
         1 Houston                   
         4 Stanford                  
         5 Bellaire                  
         5 Chicago                   
         5 Houston 
		 
#Table Project#
CREATE TABLE Project(
	Proj#	INT,
	ProjName	VARCHAR2(25),
	PLocation	VARCHAR2(25)  );
INSERT INTO Project VALUES(1, 'Product-X', 'Bellaire');
INSERT INTO Project VALUES(2, 'Product-Y', 'Chicago');
INSERT INTO Project VALUES(3, 'Product-Z', 'Houston');
INSERT INTO Project VALUES(10, 'Computerization', 'Stanford');
INSERT INTO Project VALUES(20, 'Reorganization', 'Houston');
INSERT INTO Project VALUES(30, 'New-Benefits', 'Stanford');
COMMIT
SELECT * FROM Project

table PROJECT created.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
committed.
     PROJ# PROJNAME                  PLOCATION               
---------- ------------------------- -------------------------
         1 Product-X                 Bellaire                  
         2 Product-Y                 Chicago                   
         3 Product-Z                 Houston                   
        10 Computerization           Stanford                  
        20 Reorganization            Houston                   
        30 New-Benefits              Stanford                  

 6 rows selected 
 
 #Table WorksOn#
 CREATE TABLE WorksOn(
	Emp#	INT,
	Proj#	INT,
	Hours	INT	);
INSERT INTO WorksOn VALUES(101, 1, 32);
INSERT INTO WorksOn VALUES(101, 2, 7);
INSERT INTO WorksOn VALUES(105, 3, 40);
INSERT INTO WorksOn VALUES(106, 1, 20);
INSERT INTO WorksOn VALUES(106, 2, 20);
INSERT INTO WorksOn VALUES(102, 2, 10);
INSERT INTO WorksOn VALUES(102, 3, 10);
INSERT INTO WorksOn VALUES(102, 10, 10);
INSERT INTO WorksOn VALUES(102, 20, 10);
INSERT INTO WorksOn VALUES(103, 30, 30);
INSERT INTO WorksOn VALUES(103, 10, 10);
INSERT INTO WorksOn VALUES(104, 10, 35);
INSERT INTO WorksOn VALUES(104, 30, 5);
INSERT INTO WorksOn VALUES(104, 1, 20);
INSERT INTO WorksOn VALUES(104, 20, 15);
INSERT INTO WorksOn VALUES(108, 20, NULL);
COMMIT
SELECT * FROM WorksOn

table WORKSON created.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
1 rows inserted.
committed.
      EMP#      PROJ#      HOURS
---------- ---------- ----------
       101          1         32 
       101          2          7 
       105          3         40 
       106          1         20 
       106          2         20 
       102          2         10 
       102          3         10 
       102         10         10 
       102         20         10 
       103         30         30 
       103         10         10 
       104         10         35 
       104         30          5 
       104          1         20 
       104         20         15 
       108         20            

 16 rows selected 
 

 Get the total number of hours that were put into project number 10

SELECT SUM(HOURS)
FROM WORKSON
WHERE PROJ# = 10;

Get the work records for employees who worked more than 
the average hours for all the employees

SELECT * FROM WORKSON
WHERE HOURS > 
(SELECT AVG(HOURS) 
FROM WORKSON);

For each project get the project number and total hours 
worked on that project. Sort the results by the total number of 
hours worked on the project

SELECT PROJ#, SUM(HOURS) AS TOTAL_HOURS
FROM WORKSON
GROUP By PROJ#
ORDER BY SUM(HOURS);

Find the project numbers and total number of employees who 
worked on each project for the projects who were worked 
on by more than 2 employees

SELECT PROJ#, COUNT(EMP#)
FROM WORKSON
GROUP BY PROJ#
HAVING COUNT(EMP#) > 2;

Get the numbers and names of employees who have dependents
SELECT DISTINCT EMPLOYEE.EMP#, ENAME FROM DEPENDENT, EMPLOYEE
WHERE DEPENDENT.EMP# = EMPLOYEE.EMP#;


Get all pairs of project names such that these two 
projects are located in the same city

SELECT A.PROJNAME, B.PROJNAME FROM PROJECT A, PROJECT B
WHERE A.PLOCATION = B.PLOCATION
AND A.PROJNAME <> B. PROJNAME;