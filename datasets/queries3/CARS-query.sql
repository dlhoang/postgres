-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	K.make,
	D.year
FROM	
	CarMakers C
	JOIN Models M ON M.maker = C.id
	JOIN Makes K ON K.model = M.model
	JOIN CarData D ON D.id = K.id
WHERE
	accelerate = (
	SELECT
		MIN(Data.accelerate)
	FROM (
		-- acceleration
		SELECT
			accelerate
		FROM
			CarMakers C
			JOIN Models M ON M.maker = C.id
			JOIN Makes K ON K.model = M.model
			JOIN CarData D ON D.id = K.id
	) Data
) AND ABS(accelerate - 
	(SELECT
		MIN(Data.accelerate)
	FROM (
		-- acceleration
		SELECT
			accelerate
		FROM
			CarMakers C
			JOIN Models M ON M.maker = C.id
			JOIN Makes K ON K.model = M.model
			JOIN CarData D ON D.id = K.id
	) Data
	)) <= 0.0001
;

-- Q2
SELECT
	K.make,
	D.year
FROM	
	CarMakers C
	JOIN Models M ON M.maker = C.id
	JOIN Makes K ON K.model = M.model
	JOIN CarData D ON D.id = K.id
WHERE
	horsepower = (
		SELECT
			MAX(PowerData.horsepower)
		FROM (
			SELECT
				horsepower
			FROM
				CarMakers C
				JOIN Models M ON M.maker = C.id
				JOIN Makes K ON K.model = M.model
				JOIN CarData D ON D.id = K.id
			WHERE
				accelerate = (
				SELECT
					MIN(Data.accelerate)
				FROM (
					-- acceleration
					SELECT
						accelerate
					FROM
						CarMakers C
						JOIN Models M ON M.maker = C.id
						JOIN Makes K ON K.model = M.model
						JOIN CarData D ON D.id = K.id
				) Data
			)
		) PowerData
	)
	AND accelerate = (
		SELECT
			MIN(Data.accelerate)
		FROM (
			-- acceleration
			SELECT
				accelerate
			FROM
				CarMakers C
				JOIN Models M ON M.maker = C.id
				JOIN Makes K ON K.model = M.model
				JOIN CarData D ON D.id = K.id
		) Data
	);

-- Q3
SELECT
	C.maker,
	COUNT(*) AS mileage,
	AVG(mpg) AS num
FROM
	CarMakers C
	JOIN Models M ON M.maker = C.id
	JOIN Makes K ON K.model = M.model
	JOIN CarData D ON D.id = K.id
WHERE
	year = 1976
GROUP BY
	C.maker
HAVING
	AVG(mpg) = (
	SELECT
		MAX(avgMpg)
	FROM (SELECT
			C.maker AS maker,
			COUNT(*) AS numVehicles,
			AVG(mpg) AS avgMpg
		FROM
			CarMakers C
			JOIN Models M ON M.maker = C.id
			JOIN Makes K ON K.model = M.model
			JOIN CarData D ON D.id = K.id
		WHERE
			year = 1976
		GROUP BY
			C.maker
		HAVING
			COUNT(*) > 2
	) Average
);

-- Q4
SELECT
	C.maker,
	year,
	COUNT(*) AS mileage,
	AVG(mpg) AS num
FROM
	CarMakers C
	JOIN Models M ON M.maker = C.id
	JOIN Makes K ON K.model = M.model
	JOIN CarData D ON D.id = K.id
GROUP BY
	year, C.maker
HAVING
	(year, AVG(mpg)) IN (
	SELECT
		Average.year,
		MAX(Average.avgMpg)
	FROM (
		SELECT
			year,
			AVG(mpg) AS avgMpg
		FROM
			CarMakers C
			JOIN Models M ON M.maker = C.id
			JOIN Makes K ON K.model = M.model
			JOIN CarData D ON D.id = K.id
		GROUP BY
			year, C.maker
	) Average
	GROUP BY
		Average.year
);

-- Q5
SELECT
	K.make,
	D.year,
	T.name,
	D.mpg
FROM
	CarMakers C
	JOIN Countries T ON C.country = T.id
	JOIN Models M ON M.maker = C.id
	JOIN Makes K ON K.model = M.model
	JOIN CarData D ON D.id = K.id
WHERE mpg = (
	SELECT
		MAX(Data.mpg)
	FROM (
		SELECT
			mpg
		FROM
			CarMakers C
			JOIN Models M ON M.maker = C.id
			JOIN Makes K ON K.model = M.model
			JOIN CarData D ON D.id = K.id
		WHERE
			cylinders = 8
	) Data
) AND cylinders = 8;

-- Q6
SELECT
	((SELECT
		MAX(Data1.mpg)
	FROM (
		SELECT
			mpg
		FROM
			CarMakers C
			JOIN Models M ON M.maker = C.id
			JOIN Makes K ON K.model = M.model
			JOIN CarData D ON D.id = K.id
		WHERE
			cylinders = 8
	) Data1
	) - 
	(SELECT
		MIN(Data2.mpg)
	FROM (
		SELECT
			mpg
		FROM
			CarMakers C
			JOIN Models M ON M.maker = C.id
			JOIN Makes K ON K.model = M.model
			JOIN CarData D ON D.id = K.id
		WHERE
			cylinders = 4
	) Data2
	))
	AS diff
;

-- Q7
SELECT
	T.name,
	COUNT(*)
FROM
	CarMakers C
	JOIN Countries T ON C.country = T.id
	JOIN Models M ON M.maker = C.id
	JOIN Makes K ON K.model = M.model
	JOIN CarData D ON D.id = K.id
WHERE
	cylinders = 4 AND year >= 1970 AND year <= 1979
	AND horsepower > ANY (
		SELECT
			horsepower
		FROM
			CarMakers C
			JOIN Models M ON M.maker = C.id
			JOIN Makes K ON K.model = M.model
			JOIN CarData D ON D.id = K.id
		WHERE
			cylinders = 8 AND year >= 1970 AND year <= 1979
	)
GROUP BY
	C.country, T.name;
