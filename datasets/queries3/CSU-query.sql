-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	campus,
	enrolled
FROM
	Campuses C
	JOIN Enrollments E ON E.campusId = C.id
WHERE
	E.year = 1957 AND enrolled = (
	SELECT
		MAX(Enrollment.enrolled)
	FROM
		(SELECT
			enrolled
		FROM
			Enrollments E
		WHERE
			year = 1957
		) Enrollment
);

-- Q2
SELECT
	campus,
	SUM(degrees) AS degrees
FROM
	Degrees D
	JOIN Campuses C ON D.campusId = C.id
GROUP BY
	campus, campusId
HAVING
	SUM(degrees) = (
	SELECT
		MAX(Degree.totalDegrees)
	FROM (
		SELECT
			SUM(degrees) AS totalDegrees
		FROM
			Degrees D
		GROUP BY
			campusId
	) Degree
);

-- Q3
SELECT
	campus,
	enrolled AS totalEnrollments,
	E.fte AS enrollmentFTE,
	F.fte AS facultyFTE,
	F.fte/E.fte AS facultyToStudent,
	E.fte/F.fte AS studentToFaculty
FROM
	Faculty F
	JOIN Enrollments E ON F.campusId = E.campusId
	JOIN Campuses C ON F.campusId = C.id
		AND F.year = E.year
WHERE
	F.year = 2002 AND
	F.fte/E.fte = (
	SELECT
		MAX(fteData.fteRatio)
	FROM (SELECT
			F.fte/E.fte AS fteRatio
		FROM
			Faculty F
			JOIN Enrollments E ON F.campusId = E.campusId
				AND F.year = E.year
		WHERE
			F.year = 2002
		GROUP BY
			F.campusId, F.fte, E.fte
	) fteData
);

-- Q4
SELECT
	C.campus,
	undergrad/enrolled
FROM
	DisciplineEnrollments P
	JOIN Disciplines D ON P.discipline = D.id
	JOIN Campuses C ON P.campusId = C.id
	JOIN Enrollments E ON E.campusId = C.id AND E.year = P.year
WHERE
	undergrad/enrolled =
	(SELECT
		MAX(Percentage.percent)
	FROM (
		SELECT
			C.id AS id,
			undergrad/enrolled AS percent
		FROM
			DisciplineEnrollments P
			JOIN Disciplines D ON P.discipline = D.id
			JOIN Campuses C ON P.campusId = C.id
			JOIN Enrollments E ON E.campusId = C.id AND E.year = P.year
		WHERE
			E.year = 2004 AND D.name = 'Engineering'
	) Percentage
);

-- Q5
SELECT
	CampusIncrease.year,
	CampusIncrease.campus
FROM
	(SELECT
		E1.year AS year,
		C.campus AS campus,
		(E1.enrolled - E2.enrolled) / E2.enrolled AS increase
	FROM
		Campuses C
		JOIN Enrollments E1 ON E1.campusId = C.id
		JOIN Enrollments E2 ON E1.campusId = E2.campusId AND E1.year = E2.year + 1
	WHERE
		E1.year >= 2000 AND E1.year <= 2004
	GROUP BY
		E1.year, C.campus) CampusIncrease
	JOIN
	(SELECT
		Increase.year,
		MAX(Increase.relIncrease) AS maxIncrease
	FROM
		(SELECT
			E1.year AS year,
			C.campus AS campus,
			(E1.enrolled - E2.enrolled) / E2.enrolled AS relIncrease
		FROM
			Campuses C
			JOIN Enrollments E1 ON E1.campusId = C.id
			JOIN Enrollments E2 ON E1.campusId = E2.campusId AND E1.year = E2.year + 1
		WHERE
			E1.year >= 2000 AND E1.year <= 2004
		GROUP BY
			E1.year, C.campus
		) Increase
	GROUP BY
		Increase.year) Data
	ON CampusIncrease.year = Data.year AND CampusIncrease.increase = Data.maxIncrease;

-- Q6
SELECT
	Ratio.year AS year,
	Ratio.campus AS campus,
	MAX(Ratio.ratio) AS dpe
FROM (SELECT
		D.year AS year,
		C.campus AS campus,
		D.degrees / E.enrolled AS ratio
	FROM
		Campuses C
		JOIN Degrees D ON D.campusId = C.id
		JOIN Enrollments E ON E.campusId = C.id AND D.year = E.year
	WHERE
		D.year >= 1997 AND D.year <= 2003
	GROUP BY
		year, C.campus
	ORDER BY ratio DESC, E.year ASC, C.campus
) Ratio
GROUP BY Ratio.year
ORDER BY
	Ratio.year;

-- Q7

SELECT
	C.campus AS campus,
	R.FTE / F.FTE AS ratio
FROM
	Campuses C
	JOIN DisciplineEnrollments E ON E.campusId = C.id
	JOIN Disciplines D ON D.id = E.discipline
	JOIN Enrollments R ON R.campusId = E.campusId AND R.year = E.year
	JOIN Faculty F ON F.campusId = E.campusId AND F.year = E.year
WHERE
	E.year = 2004 AND D.name = 'Engineering' AND undergrad > 0;
