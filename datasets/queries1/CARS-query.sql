-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	model
FROM
	Models M
	JOIN CarMakers C ON M.maker = C.id
WHERE C.maker = 'chrysler'
ORDER BY model;

-- Q2
SELECT
	M.id,
	year
FROM
	Makes M
	JOIN CarData D ON D.id = M.id
WHERE
	model = 'renault'
ORDER BY year;

-- Q3
SELECT
	M.id,
	year
FROM
	Makes M
	JOIN CarData D ON D.id = M.id
WHERE
	model = 'volvo' AND year >= 1975 AND year <= 1980
ORDER BY year;

-- Q4
SELECT
	M.id,
	K.maker
FROM
	CarData D
	JOIN Makes M ON D.id = M.id
	JOIN Models O ON M.model = O.model
	JOIN CarMakers K ON O.maker = K.id
WHERE
	year = 1981 AND weight > 3000 AND accelerate > 17
ORDER BY K.maker;

-- Q5
SELECT DISTINCT
	K.fullName,
	C.Name AS country
FROM
	CarData D
	JOIN Makes M ON D.id = M.id
	JOIN Models O ON M.model = O.model
	JOIN CarMakers K ON O.maker = K.id
	JOIN Countries C ON K.country = C.id
WHERE
	C.name <> 'germany' AND C.name <> 'france' AND C.name <> 'italy'
	AND C.name <> 'sweden' AND C.name <> 'uk' AND C.name <> 'russia'
	AND weight < 2000 AND year >= 1979 AND year <= 1981
ORDER BY K.fullName;

-- Q6
SELECT
	M.make,
	year,
	weight / horsepower AS weightHorsePowerRatio
FROM
	CarData D
	JOIN Makes M ON D.id = M.id
	JOIN Models O ON M.model = O.model
WHERE
	year > 1978 AND M.model = 'mazda'
ORDER BY weightHorsePowerRatio DESC;

-- Q7
SELECT DISTINCT
	C.name
FROM
	CarData D
	JOIN Makes M ON D.id = M.id
	JOIN Models O ON M.model = O.model
	JOIN CarMakers K ON O.maker = K.id
	JOIN Countries C ON K.country = C.id
WHERE
	C.name <> 'usa' AND cylinders = 6
ORDER BY C.name;
