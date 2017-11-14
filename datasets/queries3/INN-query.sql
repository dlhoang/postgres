-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	roomName,
	roomCode AS room,
	COUNT(*) AS numReservations
FROM
	Reservations R
	JOIN Rooms M ON R.room = M.roomCode
GROUP BY
	roomName, roomCode
HAVING
	COUNT(*) = (
	SELECT
		MIN(Res.numReservations)
	FROM (
		SELECT
			COUNT(*) AS numReservations
		FROM
			Reservations R
		GROUP BY
			room
	) AS Res
);

-- Q2
SELECT
	roomName,
	roomCode AS room,
	SUM(checkOut - checkIn) AS occupancy
FROM
	Reservations R
	JOIN Rooms M ON R.room = M.roomCode
GROUP BY
	roomName, roomCode
HAVING
	SUM(checkOut - checkIn) = (
	SELECT
		MAX(Res.duration)
	FROM (
		SELECT
			SUM(checkOut - checkIn) AS duration
		FROM
			Reservations R
		GROUP BY
			room
	) Res
);

-- Q3
SELECT
	roomName,
	checkIn,
	checkOut,
	lastName,
	rate,
	(checkOut - checkIn) * rate AS total
FROM
	Reservations R
	JOIN Rooms M ON R.room = M.roomCode
WHERE
	(checkOut - checkIn) * rate = (
	SELECT
		MAX(Totals.amountPaid)
	FROM (SELECT
			(checkOut - checkIn) * rate  AS amountPaid
		FROM
			Reservations R
		GROUP BY
			code
	) Totals
);

-- Q4
SELECT
	roomName,
	checkIn,
	checkOut,
	lastName,
	rate,
	(checkOut - checkIn) * rate AS total
FROM
	Reservations R
	JOIN Rooms M ON R.room = M.roomCode
WHERE
	(room, (checkOut - checkIn) * rate) IN (
	SELECT
		room,
		MAX(Totals.amountPaid)
	FROM (
		SELECT
			room,
			(checkOut - checkIn) * rate AS amountPaid
		FROM
			Reservations R
		GROUP BY
			room, code
	) Totals
	GROUP BY
		Totals.room
)
ORDER BY
	(checkOut - checkIn) * rate DESC;

-- Q5
SELECT
	date_part('month', checkIn) AS month,
	SUM((checkOut - checkIn) * rate) AS monthlyRevenue,
	(SELECT
		COUNT(*)
	FROM
		Reservations R
	GROUP BY
		date_part('month', checkIn)
	HAVING
		SUM((checkOut - checkIn) * rate) = (
		SELECT
			MAX(Totals.amountPaid)
		FROM
			(SELECT
				date_part('month', checkIn),
				SUM((checkOut - checkIn) * rate) AS amountPaid
			FROM
				Reservations R
			GROUP BY
				date_part('month', checkIn)
			) Totals
		)
	) AS numReservations
FROM
	Reservations R
GROUP BY
	date_part('month', checkIn)
HAVING
	SUM((checkOut - checkIn) * rate) = (
	SELECT
		MAX(Totals.amountPaid)
	FROM
		(SELECT
			date_part('month', checkIn),
			SUM((checkOut - checkIn) * rate) AS amountPaid
		FROM
			Reservations R
		GROUP BY
			date_part('month', checkIn)
		) Totals
	)
;

-- Q6
SELECT
	Unioned.roomName AS roomName,
	Unioned.room room,
	Unioned.status AS status
FROM
(SELECT
	R.roomName AS roomName,
	R.roomCode AS room,
	'Occupied' AS status
FROM
	Reservations S
	JOIN Rooms R ON S.room = R.roomCode
WHERE
	date_part('month', checkIn) <= 10 AND date_part('day', checkIn) <= 22 AND
	date_part('year', checkIn) <= 2010 AND
	date_part('month', checkOut) >= 10 AND date_part('day', checkOut) > 22 AND
	date_part('year', checkOut) >= 2010
UNION
SELECT
	R.roomName AS roomName,
	R.roomCode AS room,
	'Empty' AS status
FROM
	Reservations S
	JOIN Rooms R ON S.room = R.roomCode
WHERE S.room NOT IN
	(SELECT
		S.room
	FROM
		Reservations S
		JOIN Rooms R ON S.room = R.roomCode
	WHERE
		date_part('month', checkIn) <= 10 AND date_part('day', checkIn) <= 22 AND
		date_part('year', checkIn) <= 2010 AND
		date_part('month', checkOut) >= 10 AND date_part('day', checkOut) > 22 AND
		date_part('year', checkOut) >= 2010)
) Unioned
ORDER BY
	Unioned.room;

-- Q7
SELECT
	roomName,
	COUNT(*) AS countMostExpensive
FROM
	Reservations R
	JOIN Rooms M ON R.room = M.roomCode
WHERE (room, rate) IN (SELECT
		room,
		MAX(Totals.rate)
	FROM (
		SELECT
			room,
			rate
		FROM
			Reservations R
		GROUP BY
			room, rate
	) Totals
	GROUP BY
		Totals.room
)
GROUP BY
	roomName
ORDER BY
	COUNT(*);
