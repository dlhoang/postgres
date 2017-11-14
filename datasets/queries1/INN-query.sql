-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	roomName,
	roomCode
FROM
	Rooms
WHERE
	basePrice < 160 AND beds = 2 AND decor = 'modern'
ORDER BY roomCode;

-- Q2
SELECT
	lastName,
	checkIn,
	checkOut,
	adults + kids AS numOfPeople,
	rate
FROM
	Rooms R
	JOIN Reservations S ON R.roomCode = S.room
WHERE
	R.roomName = 'Convoke and sanguine' AND date_part('month', checkIn) = 08 AND
	date_part('year', checkIn) = 2010 AND date_part('month', checkOut) = 08 AND date_part('year', checkOut) = 2010
ORDER BY checkIn, checkOut;

-- Q3
SELECT
	roomName,
	checkIn,
	checkOut
FROM
	Rooms R
	JOIN Reservations S ON R.roomCode = S.room
WHERE
	date_part('day', checkIn) <= 06 AND date_part('month', checkIn) <= 02 AND date_part('year', checkIn) <= 2010
    AND date_part('day', checkOut) >= 06 AND date_part('month', checkOut) >= 02 AND
    date_part('year', checkOut) >= 2010
ORDER BY roomName;

-- Q4
SELECT
	S.code,
	checkIn,
	checkOut,
	R.roomName,
	(checkOut - checkIn) * rate AS totalAmount
FROM
	Rooms R
	JOIN Reservations S ON R.roomCode = S.room
WHERE
	firstName = 'GRANT' AND lastName = 'KNERIEN'
ORDER BY checkIn;

-- Q5
SELECT
	R.roomName,
	rate,
    checkOut - checkIn AS nightsStayed,
	basePrice + ((checkOut - checkIn) * rate) AS totalAmount
FROM
	Rooms R
	JOIN Reservations S ON R.roomCode = S.room
WHERE
	date_part('day', checkIn) = 31 AND date_part('month', checkIn) = 12 AND date_part('year', checkIn) = 2010
ORDER BY nightsStayed DESC;

-- Q6
SELECT
	S.code,
	R.roomName,
	R.roomCode,
	S.checkIn,
	S.checkOut
FROM
	Reservations S
	JOIN Rooms R ON S.room = R.roomCode
WHERE bedType = 'Double' AND adults = 4
ORDER BY S.checkIn, R.roomCode;

-- Q7
SELECT
	S.code,
	checkIn,
	checkOut - checkIn AS duration
FROM
	Reservations S
	JOIN Rooms R ON S.room = R.roomCode
WHERE
	date_part('month', checkIn) = 11 AND date_part('year', checkIn) = 2010
	AND R.roomName = 'Immutable before decorum'
ORDER BY checkIn;
