-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	grade,
	COUNT(DISTINCT classroom) AS num
FROM
	List L
GROUP BY
	grade
HAVING
	COUNT(DISTINCT classroom) = (
	-- select the max number of classrooms
	SELECT
		MAX(Classrooms.numClassrooms)
	FROM (
		-- select grade and number of classrooms each grade has
		SELECT
			COUNT(DISTINCT classroom) as numClassrooms
		FROM
			List
		GROUP BY
			grade
	) Classrooms
);

-- Q2
SELECT
	L.classroom,
	T.first,
	T.last
FROM
	List L
	JOIN Teachers T ON L.classroom = T.classroom
GROUP BY
	L.classroom, T.first, T.last
HAVING
	COUNT(*) = (
	SELECT
		MIN(numStudents.countStudents)
	FROM (
		-- select classroom and number of students in each
		SELECT
			COUNT(*) AS countStudents
		FROM
			List L
		GROUP BY
			classroom
	) numStudents
);

-- Q3
SELECT
	(SELECT COUNT(*)
		FROM (
			SELECT
				classroom
			FROM
				List L
			GROUP BY
				classroom
			HAVING
				COUNT(*) > (
				-- select average number of students
				SELECT
				AVG(numStudents.countStudents)
				FROM (
					-- select classroom and number of students in each
					SELECT
						COUNT(*) AS countStudents
					FROM
						List L
					GROUP BY
						classroom
				) numStudents
			)
		) AS classrooms
	) AS largeClasses;

-- Q4
SELECT
	grade
FROM
	List L
GROUP BY
	grade
HAVING COUNT(*) < (
	-- get number of students in grade 4
	SELECT
		COUNT(*)
	FROM
		List L
	WHERE
		grade = 4
);

-- Q5
SELECT
	L1.grade AS grade,
	Students.grade AS grade,
	Students.numStudents AS num
FROM
	List L1
JOIN (
	-- get each grade and number of students in each grade
	SELECT
		grade,
		COUNT(*) AS numStudents
	FROM
		List L2
	GROUP BY
		grade
) Students
ON L1.grade < Students.grade
GROUP BY
	L1.grade, Students.grade, Students.numStudents
HAVING
	COUNT(*) = Students.numStudents;
