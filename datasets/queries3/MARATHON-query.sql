-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	state
FROM
	Marathon
GROUP BY
	state
HAVING COUNT(*) = (
	-- get max number of runners
	SELECT
		MAX(Runners.numRunners)
	FROM (
		-- get number of runners each state
		SELECT
			COUNT(*) numRunners
		FROM
			Marathon
		GROUP BY
			state
	) Runners
);

-- Q2
SELECT
	town
FROM
	Marathon M1
WHERE
	state = 'MA' AND sex = 'F'
GROUP BY
	town
HAVING
	COUNT(*) > 0 AND COUNT(*) > (
	SELECT
		COUNT(*)	
	FROM
		Marathon M2
	WHERE
		state = 'MA' AND sex = 'M' AND M1.town = M2.town
	GROUP BY
		town
	HAVING
		COUNT(*) > 0
);

-- Q3
SELECT
	firstName,
	lastName,
	town,
	state,
	place
FROM
	Marathon
WHERE place < ANY (
	SELECT
		place
	FROM
		Marathon
	WHERE
		state = 'MO'
)
AND town = 'SOUTHBORO' AND state = 'MA';

-- Q4
SELECT
	town
FROM
	Marathon M
WHERE
	state = 'MA' AND sex = 'F' AND date_part('second', pace) < (
	-- get the average pace of marathon
	SELECT
		AVG(date_part('second', Pace.pace))
	FROM (
		-- get runners and their pace
		SELECT
			pace
		FROM
			Marathon
	) Pace
)
GROUP BY
	town
HAVING COUNT(*) = (
	SELECT
		COUNT(*) AS numFemales
	FROM
		Marathon
	WHERE
		sex = 'F' AND town = M.town AND state = 'MA'
);
