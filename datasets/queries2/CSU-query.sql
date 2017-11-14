-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	campus,
	SUM(fee) AS sumFee
FROM
	Campuses C
	JOIN Fees F ON F.campusId = C.id
WHERE
	F.year >= 2000 AND F.year <= 2005
GROUP BY
	campus
HAVING
	AVG(fee) > 2500
ORDER BY
	sumFee;

-- Q2
SELECT
	campus,
	MIN(enrolled) AS minimum,
	AVG(enrolled) AS average,
	MAX(enrolled) AS maximum
FROM
	Campuses C
	JOIN Enrollments E ON E.campusId = C.id
GROUP BY
	campus
HAVING
	COUNT(*) > 60
ORDER BY
	AVG(enrolled);

-- Q3
SELECT
	campus,
	SUM(degrees) AS totalDegrees
FROM
	Campuses C
	JOIN Degrees D ON D.campusId = C.id
WHERE
	(county = 'Los Angeles'  OR county = 'Orange')
	AND (D.year >= 1998 AND D.year <= 2002)
GROUP BY
	campus
ORDER BY
	SUM(degrees) DESC;

-- Q4
SELECT
	campus,
	COUNT(*)
FROM
	Campuses C
	JOIN Enrollments E ON E.campusId = C.id
	JOIN DisciplineEnrollments D ON D.campusId = C.id
	JOIN Disciplines P ON D.discipline = P.id
WHERE
	enrolled > 20000 AND E.year = 2004 AND D.graduate > 0
GROUP BY
	campus
HAVING
	COUNT(*) > 0
ORDER BY
	campus;

-- Q5
SELECT
	E.year AS year,
	MIN(E.fte/F.fte) AS best,
	AVG(E.fte/F.fte) AS average,
	MAX(E.fte/F.fte) AS worst
FROM
	Campuses C
	JOIN Enrollments E ON E.campusId = C.id
	JOIN Faculty F ON F.campusId = C.id
WHERE
	E.year = F.year AND E.year >= 2002 AND E.year <= 2004
GROUP BY
	E.year
ORDER BY
	E.year;
