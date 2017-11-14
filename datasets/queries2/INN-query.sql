-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	roomName,
	SUM(rate * (checkOut - checkIn)) AS revenue,
	AVG(rate * (checkOut - checkIn)) AS average
FROM
	Reservations S
	JOIN Rooms R ON R.roomCode = S.room
WHERE
    date_part('month', checkIn) >= 9 AND date_part('month', checkIn) <= 11
GROUP BY
	roomName
ORDER BY
	SUM(rate * (checkOut - checkIn)) DESC;

-- Q2
SELECT
	COUNT(code) AS stays,
	SUM(rate * (checkOut - checkIn)) AS revenue
FROM
	Reservations S
	JOIN Rooms R ON R.roomCode = S.room
WHERE
	EXTRACT(dow FROM checkIn) = 5
GROUP BY
	EXTRACT(dow FROM checkIn);

-- Q3
SELECT
	to_char(checkIn, 'day') AS day,
	COUNT(code) AS stays,
	SUM(rate * (checkOut - checkIn)) AS revenue
FROM
	Reservations S
	JOIN Rooms R ON R.roomCode = S.room
GROUP BY
	to_char(checkIn, 'day')
ORDER BY
	to_char(checkIn, 'day');

-- Q4
SELECT
	roomName,
	ABS(MAX(rate - basePrice)) AS markup,
	ABS(MIN(rate - basePrice)) AS discount
FROM
	Rooms R
	JOIN Reservations S ON R.roomCode = S.room
GROUP BY
	roomName
ORDER BY
	ABS(MAX(rate - basePrice)) DESC;
