-- Question 3
CREATE TABLE "Catalog" (
	"sid"	INTEGER,
	"pid"	INTEGER,
	"cost"	REAL,
	PRIMARY KEY("sid","pid")
);

CREATE TABLE "Parts" (
	"pid"	INTEGER,
	"pname"	TEXT,
	"color"	TEXT,
	PRIMARY KEY("pid")
);

CREATE TABLE "Suppliers" (
	"sid"	INTEGER,
	"sname"	TEXT,
	"address"	TEXT,
	PRIMARY KEY("sid")
);

--i);
SELECT sname
FROM (SELECT DISTINCT S.sid, S.sname 
		  FROM Suppliers S, Parts P, Catalog C 
		  WHERE P.color="red" 
				AND C.pid=P.pid 
				AND C.sid=S.sid);

-- ii);
SELECT DISTINCT sid 
FROM (Catalog NATURAL JOIN Parts)
WHERE color = "red" OR color = "green";

--iii)
SELECT DISTINCT S.sid 
FROM Suppliers S 
WHERE S.address = "1065 Military Trail" 
	OR S.sid IN (SELECT C.sid 
					  FROM Parts P, Catalog C 
					  WHERE P.color="red" AND P.pid = C.pid );

--iv)
SELECT DISTINCT sid 
FROM (Catalog NATURAL JOIN Parts)
WHERE color = "red"
INTERSECT
SELECT DISTINCT sid 
FROM (Catalog NATURAL JOIN Parts)
WHERE color = "green";

--v)
SELECT DISTINCT C.sid 
FROM Catalog C 
WHERE NOT EXISTS (SELECT P.pid 
							  FROM Parts P 
							  WHERE NOT EXISTS (SELECT C1.sid 
															FROM Catalog C1
															WHERE C1.sid = C.sid AND C1.pid = P.pid));

--vi)
SELECT DISTINCT sid
FROM (Catalog NATURAL JOIN Parts)
WHERE color = "red"
Group by sid
HAVING count(*) = (SELECT count(*) 
							 FROM Parts 
							 WHERE color = "red");

--vii)
SELECT DISTINCT sid
FROM (Catalog NATURAL JOIN Parts)
WHERE color = "red" OR color = "green"
Group by sid
HAVING count(*) = (SELECT count(*) FROM Parts WHERE color = "red" OR color = "green"); 
					
--viii)
SELECT DISTINCT sid
FROM (Catalog NATURAL JOIN Parts)
WHERE color = "red"
Group by sid
HAVING count(*) = (SELECT count(*) FROM Parts WHERE color = "red")
UNION
SELECT DISTINCT sid
FROM Catalog NATURAL JOIN Parts
WHERE color = "green"
Group by sid
HAVING count(*) = (SELECT count(*) FROM Parts WHERE color = "green");

--ix)
SELECT DISTINCT C1.sid, C2.sid 
FROM Catalog C1, Catalog C2 
WHERE C1.pid = C2.pid 
	AND C1.sid != C2.sid 
	AND C1.cost > C2.cost ;


--x)
SELECT DISTINCT pid
FROM (Catalog NATURAL JOIN Parts)
GROUP BY pid
HAVING count(*)>=2;

--xi)							
SELECT DISTINCT pid
FROM (SELECT pid, max(cost)
		  FROM (Catalog NATURAL JOIN Suppliers)
		  WHERE sname = "Canada Suppliers");
		  
--xii)
SELECT DISTINCT pid 
FROM (Catalog NATURAL JOIN Parts)
WHERE cost < 200
GROUP BY pid
HAVING count(*) = (SELECT COUNT(*) FROM Suppliers);