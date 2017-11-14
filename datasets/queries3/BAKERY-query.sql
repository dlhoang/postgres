-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT DISTINCT
	C.firstName,
	C.lastName
FROM
	Customers C
	JOIN Receipts R ON R.customer = C.cId
WHERE R.rNumber IN (
	-- receipt with the highest revenue
	SELECT R.rNumber
	FROM
		Receipts R
		JOIN Items I ON I.receipt = R.rNumber
		JOIN Goods G ON G.gId = I.item
	WHERE
		date_part('month', saleDate) = 10 AND date_part('year', saleDate) = 2007
	GROUP BY
		R.rNumber
	HAVING SUM(G.price) = (
		-- maximum revenue from a specific purchase
		SELECT MAX(Totals.sumPrices)
		FROM (
			-- each receipt and its revenue
			SELECT
				R.rNumber,
				SUM(G.price) AS sumPrices
			FROM
				Receipts R
				JOIN Items I ON I.receipt = R.rNumber
				JOIN Goods G ON G.gId = I.item
			GROUP BY
				R.rNumber
		) Totals
	)
);

-- Q2
SELECT
	G.flavor,
	G.food
FROM
	Items I
	JOIN Receipts R ON I.receipt = R.rNumber
	JOIN Goods G ON G.gId = I.item
GROUP BY
	food, flavor
HAVING SUM(G.price) = (
	-- max revenue from a certain good
	SELECT
		MAX(Totals.sumPrices)
	FROM (
		-- sum of each goods revenue
		SELECT
			SUM(G.price) AS sumPrices
		FROM
			Items I
			JOIN Receipts R ON I.receipt = R.rNumber
			JOIN Goods G ON G.gId = I.item
		GROUP BY
			food, flavor
	) Totals
);

-- Q3
SELECT
	G.flavor,
	G.food
FROM
	Items I
	JOIN Receipts R ON I.receipt = R.rNumber
	JOIN Goods G ON G.gId = I.item
GROUP BY
	G.flavor, G.food
HAVING COUNT(*) = (
	-- food with most purchases
	SELECT
		MAX(Totals.numPurchases)
	FROM (
		-- each food with number of purchases
		SELECT
		G.food,
		G.flavor,
		COUNT(*) AS numPurchases
		FROM
			Items I
			JOIN Receipts R ON I.receipt = R.rNumber
			JOIN Goods G ON G.gId = I.item
		GROUP BY
			G.food, G.flavor
	) Totals
);

-- Q4
SELECT
	date_part('day', saleDate) AS saleDate
FROM
	Receipts R
	JOIN Items I ON I.receipt = R.rNumber
	JOIN Goods G ON G.gId = I.item
GROUP BY
	date_part('day', saleDate)
HAVING SUM(price) = (
	-- highest revenue
	SELECT
		MAX(Totals.sumPrices)
	FROM (
		-- each day with its revenue
		SELECT
			date_part('day', saleDate),
			SUM(price) AS sumPrices
		FROM	
			Receipts R
			JOIN Items I ON I.receipt = R.rNumber
			JOIN Goods G ON G.gId = I.item
		GROUP BY
			date_part('day', saleDate)
	) Totals
);

-- Q5
SELECT
	firstName,
	lastName,
	COUNT(*) AS numPurchase,
	SUM(price) AS moneySpent
FROM
	Customers C
	JOIN Receipts R ON R.customer = C.cId
	JOIN Items I ON I.receipt = R.rNumber
	JOIN Goods G ON G.gId = I.item
WHERE cId NOT IN (
	-- customers who made a purchase on day of highest revenue
	SELECT
		cId
	FROM
		Customers C
		JOIN Receipts R ON R.customer = C.cId
	WHERE date_part('day', saleDate) IN (
		-- day with highest revenue
		SELECT
			date_part('day', saleDate)
		FROM
			Receipts R
			JOIN Items I ON I.receipt = R.rNumber
			JOIN Goods G ON G.gId = I.item
		GROUP BY
			date_part('day', saleDate)
		HAVING SUM(price) = (
			-- highest revenue
			SELECT
				MAX(Totals.sumPrices)
			FROM (
				-- each day with its revenue
				SELECT
					date_part('day', saleDate),
					SUM(price) AS sumPrices
				FROM	
					Receipts R
					JOIN Items I ON I.receipt = R.rNumber
					JOIN Goods G ON G.gId = I.item
				GROUP BY
					date_part('day', saleDate)
			) Totals
		)
	)
)
GROUP BY cId
ORDER BY SUM(price);

-- Q6
SELECT
	Item.first,
	Item.last,
	Item.flavor,
	Item.food,
	Item.price
FROM
(SELECT
	C.cId AS customer,
	C.firstName AS first,
	C.lastName AS last,
	G.gId AS good,
	G.flavor AS flavor,
	G.food AS food,
	SUM(price) AS price
FROM
	Customers C
	JOIN Receipts R ON R.customer = C.cId
	JOIN Items I ON I.receipt = R.rNumber
	JOIN Goods G ON G.gId = I.item
GROUP BY
	C.cId, G.gId) Item
JOIN
(SELECT
	Prices.customer AS customer,
	MAX(Prices.price) AS maxPrice
FROM (
	SELECT
		C.cId AS customer,
		SUM(G.price) AS price
	FROM
		Customers C
		JOIN Receipts R ON R.customer = C.cId
		JOIN Items I ON I.receipt = R.rNumber
		JOIN Goods G ON G.gId = I.item
	GROUP BY
		C.cId, G.gId
	) Prices
GROUP BY
	Prices.customer) Customer
ON Item.customer = Customer.customer AND Item.price = Customer.maxPrice
ORDER BY
	Item.last
;


-- Q7
SELECT
	C1.firstName,
	C1.lastName,
	(SELECT
		MIN(Purchases1.day)
	FROM (
		-- customer and each day in October they made a purchase
 		SELECT
 			firstName,
 			lastName,
			saleDate AS day
		FROM
			Customers C3
			JOIN Receipts R3 ON R3.customer = C3.cId
		WHERE
			date_part('month', saleDate) = 10
	) Purchases1
	WHERE
		C1.firstName = Purchases1.firstName
		AND C1.lastName = Purchases1.lastName
	) AS saleDate
FROM
	Customers C1
	JOIN Receipts R1 ON R1.customer = C1.cId
WHERE
	date_part('month', saleDate) = 10 AND (firstName, lastName, date_part('day', saleDate)) IN (
	-- customer and the last date of purchase of October
	SELECT
		Purchases.firstName,
		Purchases.lastName,
		MAX(Purchases.day)
	FROM (
		-- customer and each day in October they made a purchase
 		SELECT
 			firstName,
 			lastName,
			date_part('day', saleDate) AS day
		FROM
			Customers C2
			JOIN Receipts R2 ON R2.customer = C2.cId
		WHERE
			date_part('month', saleDate) = 10
	) Purchases
	GROUP BY
		Purchases.lastName, Purchases.firstName
) 
GROUP BY
	firstName, lastName
HAVING
	COUNT(*) > 1
ORDER BY
	saleDate;
