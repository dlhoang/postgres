-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	campus
FROM
	Campuses
WHERE
	year = 1947
ORDER BY id;

-- Q2
SELECT
	D.year,
	degrees
FROM
	Campuses C
	JOIN Degrees D ON D.campusId = C.id
WHERE
	C.campus = 'California State University-San Marcos'
		AND D.year >= 1994 AND D.year <= 2000
ORDER BY year;

-- Q3
SELECT
	C.campus,
	D.name,
	E.graduate,
	E.undergrad
FROM
	DisciplineEnrollments E
	JOIN Disciplines D ON E.discipline = D.id
	JOIN Campuses C ON E.campusId = C.id
WHERE
	(C.campus = 'California Polytechnic State University-San Luis Obispo'
		OR C.campus = 'California State Polytechnic University-Pomona')
		AND (D.name = 'Mathematics' OR D.name = 'Engineering'
		OR D.name = 'Computer and Info. Sciences')
ORDER BY C.campus, D.name;

-- Q4
SELECT DISTINCT
	campus,
	E.fte AS fullTimeEnrollment,
	F.fte AS numOfFaculty,
	E.fte/F.fte AS studentsFacultyRatio
FROM
	Enrollments E
	JOIN Campuses C ON E.campusId = C.id
	JOIN Faculty F ON C.id = F.campusId AND F.year = E.year
WHERE
	E.fte > 20000 AND E.year = 2003
ORDER BY studentsFacultyRatio DESC;

-- Q5
SELECT
	C.campus,
	enrolled/degrees * 100 AS graduationPercentage
FROM
	Campuses C
	JOIN Enrollments E ON C.id = E.campusId
	JOIN Degrees D ON E.campusId = D.campusId
WHERE
	D.year = 2002 AND E.year = 2002 AND C.county = 'Los Angeles'
ORDER BY graduationPercentage;

-- Q6
SELECT
	C.campus,
	D.name
FROM
	DisciplineEnrollments E
	JOIN Disciplines D ON E.discipline = D.id
	JOIN Campuses C ON E.campusId = C.id
WHERE
	E.year = 2004 AND (E.graduate >= 3 * E.undergrad)
ORDER BY C.campus, D.name;

-- Q7
SELECT DISTINCT
	F.year,
	fee * E.fte AS totalStudentFees,
	fee * E.fte / T.fte AS studentFeesPerFaculty
FROM
	Campuses C
	JOIN Fees F ON F.campusId = C.id
	JOIN Faculty T ON C.id = T.campusId
	JOIN Enrollments E ON C.id = E.campusId
WHERE
	C.campus = 'Fresno State University' AND F.year >= 2002 AND F.year <= 2004
	AND E.year = F.year AND T.year = F.year
ORDER BY F.year;