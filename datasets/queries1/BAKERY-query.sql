-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	flavor,
	food,
	price
FROM
	Goods
WHERE flavor = 'Chocolate' AND price < 5.00
ORDER BY price DESC;

-- Q2
SELECT
	flavor,
	food,
	price
FROM
	Goods
WHERE
	(flavor = 'Lemon') OR (food = 'Cookie' AND price > 1.10)
		OR (flavor = 'Apple' AND food <> 'Pie')
ORDER BY flavor, food;

-- Q3
SELECT DISTINCT
	firstName,
	lastName
FROM
	Customers C
	JOIN Receipts R ON R.customer = C.cId
WHERE
	date_part('day', R.saleDate) = 3 AND date_part('month', R.saleDate) = 10 AND date_part('year', R.saleDate) = 2007
ORDER BY lastName;

-- Q4
SELECT DISTINCT
	flavor,
	food
FROM
	Goods G
	JOIN Items I ON I.item = G.gId
	JOIN Receipts R ON I.receipt = R.rNumber
WHERE
	food = 'Cake' AND date_part('day', R.saleDate) = 4 AND date_part('month', R.saleDate) = 10
	AND date_part('year', R.saleDate) = 2007
ORDER BY flavor;

-- Q5
SELECT
	flavor,
	food,
	price
FROM
	Receipts R
	JOIN Customers C ON R.customer = C.cId
	JOIN Items I ON R.rNumber = I.receipt
	JOIN Goods G ON I.item = G.gId
WHERE
	firstName = 'ARIANE' AND lastName = 'CRUZEN' AND date_part('day', R.saleDate) = 25
	AND date_part('month', R.saleDate) = 10 AND date_part('year', R.saleDate) = 2007
ORDER BY ordinal;

-- Q6
SELECT
	flavor,
	food
FROM
	Goods G
	JOIN Items I ON I.item = G.gId
	JOIN Receipts R ON I.receipt = R.rNumber
	JOIN Customers C ON  R.customer = C.cId
WHERE
	firstName = 'KIP' AND lastName = 'ARNN' AND food = 'Cookie'
		AND date_part('month', R.saleDate) = 10 AND date_part('year', R.saleDate) = 2007
ORDER BY flavor;
