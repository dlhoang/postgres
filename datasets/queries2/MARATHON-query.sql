-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	ageGroup,
	sex,
	COUNT(*) total,
	MIN(place) AS bestPlace,
	MAX(place) AS worstPlace
FROM
	Marathon
GROUP BY
	ageGroup, sex
ORDER BY
	ageGroup, sex;

-- Q2
SELECT
	COUNT(*)
FROM
	Marathon M1
	JOIN Marathon M2 ON M1.ageGroup = M2.ageGroup AND M1.sex = M2.sex
WHERE
	M1.groupPlace = 1 AND M2.groupPlace = 2 AND M1.state = M2.state;

-- Q3
SELECT
	date_part('minute', pace) AS paceMins,
	COUNT(*)
FROM
	Marathon
GROUP BY
	date_part('minute', pace)
ORDER BY
	date_part('minute', pace);
	
-- Q4
SELECT
	state,
	COUNT(DISTINCT groupPlace, ageGroup, sex) AS numTop10
FROM
	Marathon
WHERE
	groupPlace <= 10
GROUP BY
	state
ORDER BY
	COUNT(DISTINCT groupPlace, ageGroup, sex) DESC;

-- Q5
SELECT
	town,
	AVG(date_part('second', time)) avgTimeInSecs
FROM
	Marathon
WHERE
	state = 'CT'
GROUP BY
	town
HAVING
	COUNT(*) >= 3
ORDER BY
	AVG(date_part('second', time));
