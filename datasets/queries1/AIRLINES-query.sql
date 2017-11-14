-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT DISTINCT
	A.name,
	A.abbreviation
FROM
	Airlines A
	JOIN
	Flights F ON A.id = F.airline
	JOIN Airports P ON P.code = F.source
WHERE F.source = 'AXX'
ORDER BY A.name;

-- Q2
SELECT
	flightNo,
	code,
	P.name
FROM
	Airports P
	JOIN Flights F ON F.destination = P.code
	JOIN Airlines L ON F.airline = L.id
WHERE
	source = 'AXX' AND abbreviation = 'Northwest'
ORDER BY flightNo;

-- Q3
SELECT
	F1.flightNo,
	F2.flightNo,
	P.code,
	P.name
FROM
	Flights F1
	JOIN Flights F2 ON F1.destination = F2.source
	AND F2.destination <> F1.source
	JOIN Airlines L1 ON F1.airline = L1.id
	JOIN Airlines L2 ON F2.airline = L2.id
	JOIN Airports P ON P.code = F2.destination
WHERE
	F1.source = 'AXX' AND L1.abbreviation = 'Northwest' 
	AND L2.abbreviation = 'Northwest'
ORDER BY P.code;

-- Q4
SELECT DISTINCT
	P1.code,
	P3.code,
	L1.abbreviation,
	L2.abbreviation
FROM
	Flights F1
	JOIN Flights F2 ON F1.source = F2.source
	JOIN Airports P1 ON F1.source = P1.code
	JOIN Airports P3 ON F1.destination = P3.code
	JOIN Airlines L1 ON L1.id = F1.airline
	JOIN Airlines L2 ON L2.id = F2.airline
WHERE
	P1.code < P3.code AND L1.abbreviation = 'Frontier'
	AND L2.abbreviation = 'JetBlue'
	AND F1.source = F2.source
	AND F1.destination = F2.destination
ORDER BY P1.code, P3.code;

-- Q5
SELECT DISTINCT
    code
FROM
	Flights F1
	JOIN Flights F2 ON F1.source = F2.source
	JOIN Flights F3 ON F1.source = F3.source
	JOIN Flights F4 ON F1.source = F4.source
	JOIN Flights F5 ON F1.source = F5.source
	JOIN Airports P ON F1.source = P.code
	JOIN Airlines L1 ON L1.id = F1.airline AND L1.abbreviation = 'Delta'
	JOIN Airlines L2 ON L2.id = F2.airline AND L2.abbreviation = 'Frontier'
	JOIN Airlines L3 ON L3.id = F3.airline AND L3.abbreviation = 'USAir'
	JOIN Airlines L4 ON L4.id = F4.airline AND L4.abbreviation = 'UAL'
	JOIN Airlines L5 ON L5.id = F5.airline AND L5.abbreviation = 'Southwest'
ORDER BY code;

-- Q6
SELECT DISTINCT
	F1.source
FROM
	Flights F1
	JOIN Flights F2 ON F1.source = F2.source AND F1.flightNo <> F2.flightNo
	JOIN Flights F3 ON F3.source = F2.source AND F3.flightNo <> F2.flightNo
		AND F3.flightNo <> F1.flightNo
	JOIN Airlines L1 ON F1.airline = L1.id
	JOIN Airlines L2 ON F2.airline = L2.id
	JOIN Airlines L3 ON F3.airline = L3.id
WHERE
	L1.abbreviation = 'Southwest' AND L2.abbreviation = 'Southwest'
	AND L3.abbreviation = 'Southwest'
ORDER BY F1.source;

