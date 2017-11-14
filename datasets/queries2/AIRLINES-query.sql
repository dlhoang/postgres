-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT DISTINCT
	name,
    F.source
FROM
	Flights F
	JOIN Airports P ON P.code = F.source
GROUP BY
	F.source, P.code
HAVING
	COUNT(*) = 19
ORDER BY F.source;

-- Q2
SELECT
	COUNT(DISTINCT F1.source)
FROM
	Flights F1
	JOIN Flights F2 ON F1.destination = F2.source AND F2.destination <> F1.source
WHERE
	F2.destination = 'ASY'
GROUP BY
	F2.destination;

-- Q3
SELECT
	F1.source AS source,
	COUNT(F2.destination <> F1.source) AS reachable
FROM
	Flights F1
	JOIN Flights F2 ON F1.destination = F2.source
GROUP BY
	F1.source, F2.destination
HAVING
	COUNT(F1.source) = 19
ORDER BY
	COUNT(DISTINCT F2.destination);

-- Q4
SELECT
	COUNT(DISTINCT F1.source)
FROM
	Flights F1
	JOIN Flights F2 ON F1.destination = F2.source
WHERE
	(F1.destination = 'ATE' OR F2.destination = 'ATE') AND F1.source <> 'ATE';

-- Q5
SELECT DISTINCT
	L.name,
	COUNT(DISTINCT P.code) AS operationalAirports
FROM
	Airlines L
	JOIN Flights F ON F.airline = L.id
	JOIN Airports P ON F.source = P.code
GROUP BY
	L.name
HAVING
	COUNT(DISTINCT P.code) > 1
ORDER BY
	COUNT(DISTINCT P.code) DESC;
