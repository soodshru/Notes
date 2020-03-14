-- Question 4
CREATE TABLE "Aircraft" (
	"aid"	INTEGER,
	"aname"	TEXT,
	"cruisingrange"	INTEGER,
	PRIMARY KEY("aid")
);

CREATE TABLE "Certified" (
	"eid"	INTEGER,
	"aid"	INTEGER,
	PRIMARY KEY("eid","aid")
);

CREATE TABLE "Employees" (
	"eid"	INTEGER,
	"ename"	TEXT,
	"salary"	INTEGER,
	PRIMARY KEY("eid")
);

CREATE TABLE "Flights" (
	"flno"	INTEGER,
	"from"	TEXT,
	"to"	TEXT,
	"distance"	TEXT,
	"departs"	INTEGER,
	"arrives"	INTEGER,
	PRIMARY KEY("flno")
);



--i)
SELECT DISTINCT C.eid 
FROM Aircraft A, Certified C 
WHERE A.aid = C.aid AND A.aname = "Boeing";

--ii);
SELECT ename 
FROM (SELECT DISTINCT ename, eid
				FROM (Aircraft NATURAL JOIN CERTIFIED NATURAL JOIN EMPLOYEES)
					WHERE aname = "Boeing");

--iii)
SELECT DISTINCT A.aid 
FROM Aircraft A, Flights F 
WHERE F.'from' = "Bonn" AND F.'to' = "Madras" AND A.cruisingrange > F.distance;

--iv)
SELECT DISTINCT flno
FROM (Flights F INNER JOIN Aircraft A ON F.distance < A.cruisingrange) NATURAL JOIN Certified NATURAL JOIN Employees
WHERE salary > 100000
GROUP BY flno
HAVING count(DISTINCT eid) = (SELECT count(*) FROM Employees WHERE salary > 100000);

--v)
SELECT ename 
FROM (SELECT DISTINCT E.ename, E.eid
		  FROM Certified C, Employees E, Aircraft A 
		  WHERE A.aid = C.aid 
			  AND E.eid = C.eid 
			  AND A.cruisingrange > 3000 
			  AND A.aname <> "Boeing");


--vi);
SELECT DISTINCT eid 
FROM Employees
WHERE salary = (SELECT Max(salary) FROM Employees);

--vii)
SELECT DISTINCT E.eid 
FROM Employees E 
WHERE E.salary = (SELECT MAX (E2.salary) 
							FROM Employees E2 
							WHERE E2.salary  <> (SELECT MAX (E3.salary) 
															 FROM Employees E3 ));


--viii)

						
						
--ix)
SELECT DISTINCT C1.eid 
FROM Certified C1, Certified C2, Certified C3 
WHERE (C1.eid = C2.eid 
	AND C2.eid = C3.eid 
	AND C1.aid  <> C2.aid 
	AND C2.aid <> C3.aid 
EXCEPT 
SELECT DISTINCT C4.eid 
FROM Certified C4, Certified C5, Certified C6, Certified C7 
WHERE (C4.eid = C5.eid 
	AND C5.eid = C6.eid 
	AND C6.eid = C7.eid 
	AND C4.aid  <> C5.aid
	AND C4.aid <> C6.aid 
	AND C4.aid <> C7.aid 
	AND C5.aid <> C6.aid 
	AND C5.aid <> C7.aid 
	AND C6.aid <> C7.aid );


--x)
SELECT SUM(Salary) 
FROM Employees;