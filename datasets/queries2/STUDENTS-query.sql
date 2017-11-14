-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	first,
	last
FROM
	Teachers T
	JOIN List L ON T.classroom = L.classroom
GROUP BY
	last, first
HAVING
	COUNT(*) >= 3 AND COUNT(*) <= 5
ORDER BY
	last;

-- Q2
SELECT
	grade,
	COUNT(DISTINCT classroom) AS numClasses,
	COUNT(*)
FROM
	List L
GROUP BY
	grade
ORDER BY
	COUNT(DISTINCT classroom) DESC,
	grade;

-- Q3
SELECT
	classroom,
	COUNT(*) AS count
FROM
	List L
WHERE
	grade = 4
GROUP BY
	classroom
ORDER BY
	COUNT(*) DESC;

-- Q4
SELECT
	classroom,
	MIN(lastName)
FROM
	List L
WHERE
	grade = 0
GROUP BY
	classroom
ORDER BY
	classroom;