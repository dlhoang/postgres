-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	flavor,
	AVG(price) AS avgPrice,
	COUNT(*)
FROM
	Goods G
GROUP BY
	flavor
HAVING
	COUNT(*) > 3
ORDER BY
	AVG(price);

-- Q2
SELECT
	SUM(price)
FROM
	Items I
	JOIN Goods G ON I.item = G.gId
	JOIN Receipts R ON R.rNumber = I.receipt
WHERE
	date_part('day', saleDate) >= 10 AND date_part('day', saleDate) <= 15 AND
	date_part('month', saleDate) = 10 AND date_part('year', saleDate) = 2007;

-- Q3
SELECT
	rNumber,
	saleDate,
	COUNT(*),
	SUM(price) AS paid
FROM
	Items I
	JOIN Goods G ON I.item = G.gId
	JOIN Receipts R ON R.rNumber = I.receipt
	JOIN Customers C ON R.customer = C.cId
WHERE
	C.lastName = 'MESDAQ' AND C.firstName = 'CHARLENE'
GROUP BY
	rNumber
ORDER BY
	SUM(price);

-- Q4
SELECT
	to_char(saleDate, 'day') AS saleDate,
	COUNT(DISTINCT R.rNumber) AS purchases,
	COUNT(DISTINCT G.food) AS items,
	SUM(price) AS revenue
FROM
	Receipts R
	JOIN Items I ON I.receipt = R.rNumber
	JOIN Goods G ON I.item = G.gId
WHERE
	date_part('day', saleDate) >= 8 AND date_part('day', saleDate) <= 14 AND
	date_part('month', saleDate) = 10 AND date_part('year', saleDate) = 2007
GROUP BY
	to_char(saleDate, 'day');

-- Q5
SELECT
	saleDate
FROM
	Receipts R
	JOIN Items I ON I.receipt = R.rNumber
	JOIN Goods G ON I.item = G.gId
WHERE
	G.food = 'Cake'
GROUP BY
	saleDate
HAVING
	COUNT(*) > 5
ORDER BY
	saleDate;
