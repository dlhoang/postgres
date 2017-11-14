-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	C.maker AS maker,
	MAX(mpg) AS bestMpg,
	AVG(accelerate) AS avgAcc
FROM
	CarMakers C
	JOIN Countries T ON C.country = T.id
	JOIN Models M ON M.maker = C.id
	JOIN Makes K ON K.model = M.model
	JOIN CarData D ON D.id = K.id
WHERE
	T.name = 'japan'
GROUP BY
	C.maker
ORDER BY
	MAX(mpg);

-- Q2
SELECT
	C.maker AS maker,
	COUNT(*) AS fast
FROM
	CarMakers C
	JOIN Countries T ON C.country = T.id
	JOIN Models M ON M.maker = C.id
	JOIN Makes K ON K.model = M.model
	JOIN CarData D ON D.id = K.id
WHERE
	T.name = 'usa' AND cylinders = 4 AND weight < 4000
	AND accelerate < 14
GROUP BY
	C.maker 
ORDER BY
	COUNT(*) DESC;

-- Q3
SELECT
	year,
	MAX(mpg) AS best,
	AVG(mpg) AS average,
	MIN(mpg) AS worst
FROM
	CarMakers C
	JOIN Models M ON M.maker = C.id
	JOIN Makes K ON K.model = M.model
	JOIN CarData D ON D.id = K.id
WHERE
	C.maker = 'honda'
GROUP BY
	year
HAVING
	COUNT(*) > 2
ORDER BY
	year;

-- Q4
SELECT
	year,
	MIN(eDispl) AS smallest,
	MAX(eDispl) AS largest
FROM
	CarMakers C
	JOIN Countries T ON C.country = T.id
	JOIN Models M ON M.maker = C.id
	JOIN Makes K ON K.model = M.model
	JOIN CarData D ON D.id = K.id
WHERE
	T.name = 'usa'
GROUP BY
	year
HAVING
	AVG(horsepower) < 100
ORDER BY
	year;