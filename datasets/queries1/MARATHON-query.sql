-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	time,
	pace,
	place
FROM
	Marathon
WHERE firstName = 'TEDDY' AND lastName = 'BRASEL';

-- Q2
SELECT
	firstName,
	lastName,
	time,
	place,
	groupPlace
FROM
	Marathon
WHERE
	sex = 'F' AND town = 'QUINCY' AND state = 'MA'
ORDER BY place;

-- Q3
SELECT
	firstName,
	lastName,
	town,
	time
FROM
	Marathon
WHERE age = 34 AND sex = 'F' AND state = 'CT'
ORDER BY time;

-- Q4
SELECT DISTINCT
	M1.bibNumber
FROM
	Marathon M1
	JOIN Marathon M2 ON M1.bibNumber = M2.bibNumber
WHERE
	M1.groupPlace <> M2.groupPlace OR M1.ageGroup <> M2.ageGroup
	OR M1.sex <> M2.sex
ORDER BY bibNumber;

-- Q5
SELECT DISTINCT
	M1.firstName,
	M1.lastName,
	M1.age,
    M1.sex,
    M1.ageGroup,
	M2.firstName,
	M2.lastName,
	M2.age
FROM
	Marathon M1
	JOIN Marathon M2 ON M1.ageGroup = M2.ageGroup AND M1.sex = M2.sex
	AND (M1.firstName <> M2.firstName OR M1.lastName <> M2.lastName)
WHERE
	((M1.groupPlace = 1) <> (M1.groupPlace = 2))
		AND ((M2.groupPlace = 1) OR
		(M2.groupPlace = 2)) AND (M1.groupPlace <> M2.groupPlace)
		AND M1.groupPlace < M2.groupPlace
ORDER BY M1.sex, M1.ageGroup;
