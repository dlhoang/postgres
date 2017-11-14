-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	firstName,
	lastName
FROM
	List
WHERE
	classroom = 102
ORDER BY lastName;

-- Q2
SELECT DISTINCT
	classroom,
	grade
FROM
	List
ORDER BY grade, classroom;

-- Q3
SELECT DISTINCT
	T.first,
	T.last,
	T.classroom
FROM
	Teachers T
	JOIN List L ON T.classroom = L.classroom
WHERE grade = 0
ORDER BY classroom;

-- Q4
SELECT DISTINCT
	L.firstName,
	L.lastName
FROM
	List L
	JOIN Teachers T ON T.classroom = L.classroom
WHERE
	T.first = 'KIRK' AND T.last = 'MARROTTE'
ORDER BY L.lastName;

-- Q5
SELECT DISTINCT
	first,
	last,
	grade
FROM
	Teachers T
	JOIN List L ON T.classroom = L.classroom
ORDER BY grade, last;