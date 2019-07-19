Select * FROM Suppliers;
Select * FROM Parts;
Select * FROM Projects;
Select * FROM SPJ;
Suppliers
SNO   SNAME               STATUS CITY     
----- --------------- ---------- ----------
S1    SMITH                   20 LONDON     
S2    JONES                   10 PARIS      
S3    BLAKE                   30 PARIS      
S4    CLARK                   20 LONDON     
S5    ADAMS                   30 ATHENS     
Parts
PNO   PNAME      COLOR          WEIGHT CITY     
----- ---------- ---------- ---------- ----------
P1    NUT        RED                12 LONDON     
P2    BOLT       GREEN              17 PARIS      
P3    SCREW      BLUE               17 ROME       
P4    SCREW      RED                14 LONDON     
P5    CAMERA     BLUE               32 PARIS      
P6    WRENCH     RED                19 LONDON     
P7    C-O-G      GREEN              12 ROME       

 7 rows selected 
Projects
JNO   JNAME      CITY     
----- ---------- ----------
J1    SORTER     PARIS      
J2    PUNCH      ROME       
J3    READER     ATHENS     
J4    CONSOLE    ATHENS     
J5    COLLATOR   LONDON     
J6    TERMINAL   OSLO       
J7    TAPE       LONDON     
J8    DRUM       LONDON     

 8 rows selected 
SPJ
SNO   PNO   JNO          QTY
----- ----- ----- ----------
S1    P1    J1           200 
S1    P1    J4           700 
S1    P3    J1           450 
S1    P3    J2           210 
S1    P3    J3           700 
S2    P3    J4           509 
S2    P3    J5           600 
S2    P3    J6           400 
S2    P3    J7           812 
S3    P5    J6           750 
S3    P3    J2           215 
S3    P4    J1           512 
S3    P6    J2           313 
S4    P6    J3           314 
S4    P2    J6           250 
S4    P5    J5           179 
S4    P5    J2           513 
S5    P7    J4           145 
S5    P1    J5           269 
S5    P3    J7           874 
S5    P4    J4           476 
S5    P5    J4           529 
S5    P6    J4           318 
S5    P2    J4           619 

 24 rows selected 


Part 1


2.	Get supplier names for suppliers who shipped any part to the COLLATOR project.  

Select SNAME from Suppliers, SPJ Where SPJ.JNO  = 'J5' And SPJ.SNO = Suppliers.SNO;
SNAME         
---------------
JONES           
CLARK           
ADAMS           

4.	Get supplier name, part name, and project name triples such that 
the indicated supplier, part and project are all co-located (in the same city).

Select SName, PName, JName from Suppliers, Parts, Projects 
Where Suppliers.City = Parts.City And Suppliers.City = Projects.City And 
Parts.City = Projects.City;

SNAME           PNAME      JNAME    
--------------- ---------- ----------
SMITH           NUT        DRUM       
CLARK           NUT        DRUM       
SMITH           NUT        TAPE       
CLARK           NUT        TAPE       
SMITH           NUT        COLLATOR   
CLARK           NUT        COLLATOR   
JONES           BOLT       SORTER     
BLAKE           BOLT       SORTER     
SMITH           SCREW      DRUM       
CLARK           SCREW      DRUM       
SMITH           SCREW      TAPE       
CLARK           SCREW      TAPE       
SMITH           SCREW      COLLATOR   
CLARK           SCREW      COLLATOR   
JONES           CAMERA     SORTER     
BLAKE           CAMERA     SORTER     
SMITH           WRENCH     DRUM       
CLARK           WRENCH     DRUM       
SMITH           WRENCH     TAPE       
CLARK           WRENCH     TAPE       
SMITH           WRENCH     COLLATOR   
CLARK           WRENCH     COLLATOR

5.	Get part names for parts located in 
London and shipped to any project in LONDON.

Select PNAME FROM Parts, Projects, SPJ
WHERE Parts.City = 'LONDON'
AND Projects.City = 'LONDON'
AND Parts.PNO = SPJ.PNO
AND Projects.JNO = SPJ.JNO;

PNAME    
----------
NUT

6.	Get the supplier names for suppliers who did not 
ship any parts to any project in LONDON.

SELECT DISTINCT SNAME FROM Suppliers
WHERE SNO NOT IN 
  (SELECT SNO FROM SPJ, Projects
  WHERE SPJ.JNO = Projects.JNO
  AND Projects.City = 'LONDON');
 
SNAME         
---------------
SMITH           
BLAKE

8.	Get all the colors that are not shipped by the supplier S1. 

SELECT DISTINCT COLOR FROM PARTS
WHERE COLOR NOT IN
  (SELECT COLOR FROM PARTS, SPJ
  WHERE Parts.PNO = SPJ.PNO
  AND SPJ.SNO = 'S1');

COLOR    
----------
GREEN

9.	Get the supplier names for the suppliers 
who did not ship any part that is green. 

SELECT DISTINCT SNAME FROM SUPPLIERS
WHERE SNO NOT IN
  (SELECT SNO FROM SPJ, Parts
  WHERE SPJ.PNO = Parts.PNO
  AND Parts.Color = 'GREEN');
 
11.	Get project names for projects that were sent shipments by both suppliers S1 and S2.

SELECT DISTINCT JNAME from Projects
WHERE EXISTS (SELECT JNO FROM SPJ WHERE SNO = 'S1' AND SPJ.JNO = Projects.JNO)
AND EXISTS (SELECT JNO FROM SPJ WHERE SNO = 'S2' AND SPJ.JNO = Projects.JNO);

JNAME    
----------
CONSOLE    

14.	Get part names for parts shipped by at least 2 different suppliers in LONDON

Couldn't figure out any of the "hard" section.

SELECT distinct JNO FROM Parts, SPJ
WHERE
parts.PNO = SPJ.PNO
and SPJ.SNO = 'S1'
group by JNO having count(1) >= 2;


JNO 
-----
J1    



SNO   SNAME               STATUS CITY       PNO   PNAME      COLOR          WEIGHT CITY       JNO   JNAME      CITY       SNO   PNO   JNO          QTY
----- --------------- ---------- ---------- ----- ---------- ---------- ---------- ---------- ----- ---------- ---------- ----- ----- ----- ----------
S3    BLAKE                   30 PARIS      P4    SCREW      RED                14 LONDON     J1    SORTER     PARIS      S3    P4    J1           512 
S1    SMITH                   20 LONDON     P3    SCREW      BLUE               17 ROME       J1    SORTER     PARIS      S1    P3    J1           450 
S1    SMITH                   20 LONDON     P1    NUT        RED                12 LONDON     J1    SORTER     PARIS      S1    P1    J1           200 
S3    BLAKE                   30 PARIS      P6    WRENCH     RED                19 LONDON     J2    PUNCH      ROME       S3    P6    J2           313 
S4    CLARK                   20 LONDON     P5    CAMERA     BLUE               32 PARIS      J2    PUNCH      ROME       S4    P5    J2           513 
S1    SMITH                   20 LONDON     P3    SCREW      BLUE               17 ROME       J2    PUNCH      ROME       S1    P3    J2           210 
S3    BLAKE                   30 PARIS      P3    SCREW      BLUE               17 ROME       J2    PUNCH      ROME       S3    P3    J2           215 
S4    CLARK                   20 LONDON     P6    WRENCH     RED                19 LONDON     J3    READER     ATHENS     S4    P6    J3           314 
S1    SMITH                   20 LONDON     P3    SCREW      BLUE               17 ROME       J3    READER     ATHENS     S1    P3    J3           700 
S5    ADAMS                   30 ATHENS     P7    C-O-G      GREEN              12 ROME       J4    CONSOLE    ATHENS     S5    P7    J4           145 
S5    ADAMS                   30 ATHENS     P6    WRENCH     RED                19 LONDON     J4    CONSOLE    ATHENS     S5    P6    J4           318 
S5    ADAMS                   30 ATHENS     P5    CAMERA     BLUE               32 PARIS      J4    CONSOLE    ATHENS     S5    P5    J4           529 
S5    ADAMS                   30 ATHENS     P4    SCREW      RED                14 LONDON     J4    CONSOLE    ATHENS     S5    P4    J4           476 
S2    JONES                   10 PARIS      P3    SCREW      BLUE               17 ROME       J4    CONSOLE    ATHENS     S2    P3    J4           509 
S5    ADAMS                   30 ATHENS     P2    BOLT       GREEN              17 PARIS      J4    CONSOLE    ATHENS     S5    P2    J4           619 
S1    SMITH                   20 LONDON     P1    NUT        RED                12 LONDON     J4    CONSOLE    ATHENS     S1    P1    J4           700 
S4    CLARK                   20 LONDON     P5    CAMERA     BLUE               32 PARIS      J5    COLLATOR   LONDON     S4    P5    J5           179 
S2    JONES                   10 PARIS      P3    SCREW      BLUE               17 ROME       J5    COLLATOR   LONDON     S2    P3    J5           600 
S5    ADAMS                   30 ATHENS     P1    NUT        RED                12 LONDON     J5    COLLATOR   LONDON     S5    P1    J5           269 
S3    BLAKE                   30 PARIS      P5    CAMERA     BLUE               32 PARIS      J6    TERMINAL   OSLO       S3    P5    J6           750 
S2    JONES                   10 PARIS      P3    SCREW      BLUE               17 ROME       J6    TERMINAL   OSLO       S2    P3    J6           400 
S4    CLARK                   20 LONDON     P2    BOLT       GREEN              17 PARIS      J6    TERMINAL   OSLO       S4    P2    J6           250 
S2    JONES                   10 PARIS      P3    SCREW      BLUE               17 ROME       J7    TAPE       LONDON     S2    P3    J7           812 
S5    ADAMS                   30 ATHENS     P3    SCREW      BLUE               17 ROME       J7    TAPE       LONDON     S5    P3    J7           874 

 24 rows selected 

6.	Get the supplier names for suppliers who did not ship any parts to any project in LONDON.





1.	Get full part-details of all parts that are shipped to any project in LONDON.

 SELECT * FROM PARTS WHERE PNO IN
(SELECT DISTINCT SPJ.PNO FROM PARTS, SPJ, PROJECTS
WHERE SPJ.JNO = PROJECTS.JNO
AND PROJECTS.CITY = 'LONDON');

PNO   PNAME      COLOR          WEIGHT CITY     
----- ---------- ---------- ---------- ----------
P1    NUT        RED                12 LONDON     
P3    SCREW      BLUE               17 ROME       
P5    CAMERA     BLUE               32 PARIS      


2.	Get supplier names for suppliers who shipped any part to the COLLATOR project.  

SELECT DISTINCT SNAME FROM SUPPLIERS WHERE SNO IN
(SELECT DISTINCT SPJ.SNO FROM SPJ, PROJECTS
WHERE SPJ.JNO = PROJECTS.JNO
AND PROJECTS.JNAME = 'COLLATOR');

SNAME         
---------------
JONES           
CLARK           
ADAMS      

3.	Get all pairs of city names such that a supplier in the first city ships 
to a project in the second city.


SELECT SUPPLIERS.CITY, PROJECTS.CITY FROM
SUPPLIERS, PROJECTS, SPJ WHERE
SUPPLIERS.SNO = SPJ.SNO AND
PROJECTS.JNO = SPJ.JNO;

CITY       CITY     
---------- ----------
PARIS      PARIS      
LONDON     PARIS      
LONDON     PARIS      
LONDON     ROME       
PARIS      ROME       
PARIS      ROME       
LONDON     ROME       
LONDON     ATHENS     
LONDON     ATHENS     
ATHENS     ATHENS     
ATHENS     ATHENS     
ATHENS     ATHENS     
ATHENS     ATHENS     
ATHENS     ATHENS     
PARIS      ATHENS     
LONDON     ATHENS     
ATHENS     LONDON     
LONDON     LONDON     
PARIS      LONDON     
LONDON     OSLO       
PARIS      OSLO       
PARIS      OSLO       
ATHENS     LONDON     
PARIS      LONDON     

 24 rows selected 

4.	Get supplier name, part name, and project name triples such that the indicated 
supplier, part and project are all co-located (in the same city).

Select SName, PName, JName from Suppliers, Parts, Projects 
Where Suppliers.City = Parts.City And Suppliers.City = Projects.City And 
Parts.City = Projects.City;

SNAME           PNAME      JNAME    
--------------- ---------- ----------
SMITH           NUT        DRUM       
CLARK           NUT        DRUM       
SMITH           NUT        TAPE       
CLARK           NUT        TAPE       
SMITH           NUT        COLLATOR   
CLARK           NUT        COLLATOR   
JONES           BOLT       SORTER     
BLAKE           BOLT       SORTER     
SMITH           SCREW      DRUM       
CLARK           SCREW      DRUM       
SMITH           SCREW      TAPE       
CLARK           SCREW      TAPE       
SMITH           SCREW      COLLATOR   
CLARK           SCREW      COLLATOR   
JONES           CAMERA     SORTER     
BLAKE           CAMERA     SORTER     
SMITH           WRENCH     DRUM       
CLARK           WRENCH     DRUM       
SMITH           WRENCH     TAPE       
CLARK           WRENCH     TAPE       
SMITH           WRENCH     COLLATOR   
CLARK           WRENCH     COLLATOR


5.	Get part names for parts located in London and shipped to any project in LONDON.

Select PNAME FROM Parts, Projects, SPJ
WHERE Parts.City = 'LONDON'
AND Projects.City = 'LONDON'
AND Parts.PNO = SPJ.PNO
AND Projects.JNO = SPJ.JNO;
PNAME    
----------
NUT        

6.	Get the supplier names for suppliers who did not ship any 
parts to any project in LONDON.

SELECT SNAME FROM SUPPLIERS
WHERE SNO NOT IN
(SELECT DISTINCT SPJ.SNO FROM SPJ, PROJECTS
WHERE PROJECTS.CITY = 'LONDON'
AND SPJ.JNO = PROJECTS.JNO);
SNAME         
---------------
SMITH           
BLAKE          

7.	Get the supplier names of suppliers who only shipped parts 
that weigh less than 15 oz. 

8.	Get all the colors that are not shipped by the supplier S1. 
SELECT DISTINCT COLOR FROM PARTS WHERE
COLOR NOT IN(
SELECT DISTINCT COLOR FROM PARTS, SPJ
WHERE PARTS.PNO = SPJ.PNO
AND SPJ.SNO = 'S1');

9.	Get the supplier names for the suppliers who did not ship 
any part that is green. 

SELECT DISTINCT SNAME FROM SUPPLIERS WHERE
SNO NOT IN(
SELECT DISTINCT SNO FROM PARTS, SPJ
WHERE PARTS.PNO = SPJ.PNO
AND PARTS.COLOR = 'GREEN');
SNAME         
---------------
JONES           
SMITH           
BLAKE

10.	Get part numbers for parts that were shipped by a supplier in LONDON and 
that supplier ships only to projects that are located in LONDON.


Wouldn't have any results

11.	Get project names for projects that were sent shipments by both 
suppliers S1 and S2.

SELECT DISTINCT JNAME FROM PROJECTS
WHERE EXISTS (SELECT JNO FROM SPJ WHERE SNO = 'S1' AND SPJ.JNO = PROJECTS.JNO)
AND EXISTS (SELECT JNO FROM SPJ WHERE SNO = 'S2' AND SPJ.JNO = PROJECTS.JNO);

JNAME    
----------
CONSOLE    

12.	Get project names for projects that were not sent any 
shipments either supplier S1 or S2.

SELECT DISTINCT JNAME FROM PROJECTS
WHERE EXISTS (SELECT JNO FROM SPJ WHERE SNO = 'S1' AND SPJ.JNO = PROJECTS.JNO)
AND EXISTS (SELECT JNO FROM SPJ WHERE SNO = 'S2' AND SPJ.JNO = PROJECTS.JNO);

JNAME    
----------
DRUM     

13.	Get project names for projects using at least 
two parts from supplier S1. 

SELECT DISTINCT JNAME FROM PROJECTS 
WHERE JNO IN(
SELECT DISTINCT JNO FROM PARTS, SPJ WHERE
SPJ.SNO = 'S1' 
AND PARTS.PNO = SPJ.PNO
GROUP BY JNO having count(1) >= 2);

JNAME    
----------
SORTER     

14.	Get part names for parts shipped by at least 2 different 
suppliers in LONDON.

16.	Get the suppliers details for suppliers who supplied parts 
to only one project.