-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	G.grape,
	G.color,
	COUNT(DISTINCT A.appellation) AS numAppellations
FROM
	Wine W
	JOIN Appellations A ON W.appellation = A.appellation
	JOIN Grapes G ON W.grape = G.grape
GROUP BY
	G.grape, G.color
HAVING COUNT(DISTINCT A.appellation) = (
	SELECT
		MAX(Grape.count)
	FROM (SELECT
			COUNT(DISTINCT A.appellation) AS count
		FROM
			Wine W
			JOIN Appellations A ON W.appellation = A.appellation
			JOIN Grapes G ON W.grape = G.grape
		GROUP BY
			W.grape
	) Grape
);

-- Q2
SELECT
	G.grape
FROM
	Grapes G
	JOIN Wine W ON W.grape = G.grape
GROUP BY
	G.grape
HAVING
	SUM(cases) = (
	SELECT
		MAX(Grape.cases)
	FROM
		(SELECT
			G.grape,
			SUM(cases) AS cases
		FROM
			Grapes G
			JOIN Wine W ON W.grape = G.grape
		WHERE
			G.color = 'White'
		GROUP BY
			G.grape
	) Grape
);

-- Q3
SELECT
	G.grape
FROM
	Grapes G
	JOIN Wine W ON W.grape = G.grape
WHERE
	score >= 93
GROUP BY
	G.grape
HAVING COUNT(*) = (
	SELECT
		MAX(Grape.count)
	FROM (SELECT
			G.grape,
			COUNT(*) AS count
		FROM
			Grapes G
			JOIN Wine W ON W.grape = G.grape
		WHERE
			score >= 93
		GROUP BY
			G.grape
	) Grape
);

-- Q4
SELECT
	W.appellation
FROM
	Wine W
	JOIN Appellations A ON A.appellation = W.appellation
WHERE
	score >= 93
GROUP BY
	W.appellation
HAVING COUNT(*) = (
	SELECT
		MAX(Appellation.count)
	FROM (SELECT
			A.appellation,
			COUNT(*) AS count
		FROM
			Wine W
			JOIN Appellations A ON A.appellation = W.appellation
		WHERE
			score >= 93
		GROUP BY
			A.appellation
	) Appellation
);

-- Q5
SELECT
	vintage,
	winery,
	name,
	score,
	cases * price AS revenue
FROM
	Wine W
WHERE
	(cases * price) = (
	SELECT
		MAX(Total.total)
	FROM (
		SELECT
			cases * price AS total
		FROM
			Wine W
		WHERE
			score >= 93
		GROUP BY
			name, cases, price
	) Total
);

-- Q6
SELECT
	Appellation1.Caneros AS carneros,
	Appellation2.DryCreekValley AS dryCreek
FROM (
	SELECT
		'1' AS id,
		COUNT(DISTINCT name) AS Caneros
	FROM
		Wine W
		JOIN Appellations A ON A.appellation = W.appellation
	WHERE
		A.appellation = 'Carneros' AND
		(vintage, score) IN (
		SELECT
			vintage,
			MAX(score)
		FROM
			Wine W
			JOIN Appellations A ON A.appellation = W.appellation
		WHERE
			A.appellation = 'Carneros' OR A.appellation = 'Dry Creek Valley'
		GROUP BY
			vintage
	)) Appellation1
    JOIN
	(SELECT
		'1' AS id,
		COUNT(DISTINCT name) AS DryCreekValley
	FROM
		Wine W
		JOIN Appellations A ON A.appellation = W.appellation
	WHERE
		A.appellation = 'Dry Creek Valley' AND
		(vintage, score) IN (
		SELECT
			vintage,
			MAX(score)
		FROM
			Wine W
			JOIN Appellations A ON A.appellation = W.appellation
		WHERE
			A.appellation = 'Carneros' OR A.appellation = 'Dry Creek Valley'
		GROUP BY
			vintage
	)
	) Appellation2
;

-- Q7
SELECT
	cases
FROM
	Wine W
	JOIN Appellations A ON A.appellation = W.appellation
	JOIN Grapes G ON W.grape = G.grape
WHERE
	color = 'Red' AND county = 'San Luis Obispo'
	AND price = (
		SELECT
			MAX(Price.price)
		FROM (
			SELECT
				price
			FROM
				Wine W
				JOIN Appellations A ON A.appellation = W.appellation
				JOIN Grapes G ON W.grape = G.grape
			WHERE
				color = 'Red' AND county = 'San Luis Obispo'
			GROUP BY
				name, price
		) Price
);
