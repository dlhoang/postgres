-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	appellation
FROM
	Appellations
WHERE
	county = 'Monterey'
ORDER BY appellation;

-- Q2
SELECT DISTINCT
	G.grape
FROM
	Grapes G
	JOIN Wine W ON W.grape = G.grape
WHERE
	vintage = 2008 AND score >= 90 AND color = 'White'
ORDER BY G.grape;

-- Q3
SELECT DISTINCT
	A.appellation,
	county
FROM
	Appellations A
	JOIN Wine W ON W.appellation = A.appellation
	JOIN Grapes G ON G.grape = W.grape
WHERE
	county = 'Sonoma' AND score IS NOT NULL AND G.grape = 'Grenache'
ORDER BY county, A.appellation;

-- Q4
SELECT DISTINCT
	vintage
FROM
	Wine W
	JOIN Appellations A ON W.appellation = A.appellation
WHERE
	score > 92 AND grape = 'Zinfandel' AND county = 'Sonoma'
ORDER BY vintage;

-- Q5
SELECT
	name,
	score,
	cases * 12 * price AS revenue
FROM
	Wine
WHERE
	cases IS NOT NULL AND winery = 'Carlisle' AND grape = 'Syrah'
ORDER BY revenue DESC;

-- Q6
SELECT DISTINCT
	A.appellation
FROM
	Appellations A 
	JOIN Wine W1 ON W1.appellation = A.appellation
	JOIN Grapes G1 ON W1.grape = G1.grape AND G1.color = 'Red'
	JOIN Wine W2 ON W2.appellation = W1.appellation
	JOIN Grapes G2 ON W2.grape = G2.grape AND G2.color = 'White'
WHERE
	county = 'Santa Barbara'
		AND W1.score > 90 AND W2.score > 90
		AND W1.vintage = W2.vintage
ORDER BY A.appellation;

-- Q7
SELECT DISTINCT
	W1.price + (W2.price * 2) + W3.price AS totalPrice
FROM
	Wine W1
	NATURAL JOIN Wine W2
	NATURAL JOIN Wine W3
WHERE
	(W1.grape = 'Pinot Noir' AND W1.vintage = 2008 AND W1.winery = 'Kosta Browne'
	AND W1.name = 'Koplen Vineyard')
	AND (W2.grape = 'Cabernet Sauvingnon' AND W2.vintage = 2007
	AND W2.winery = 'Darioush' AND W2.name = 'Darius II')
	AND (W3.grape = 'Chardonnay' AND W3.vintage = 2006 AND
	W3.name = 'McCrea Vineyard' AND W3.winery = 'Kistler');

