-- Name: Di Hoang
-- Email: dlhoang@calpoly.edu

-- Q1
SELECT
	score,
	AVG(price) AS averagePrice,
	MIN(price) AS cheapest,
	MAX(price) AS mostExpensive,
	COUNT(DISTINCT W.name) AS numWines,
	COUNT(cases) AS cases
FROM
	Wine W
WHERE
	score > 88
GROUP BY
	score
ORDER BY
	score;

-- Q2
SELECT
	vintage,
	COUNT(W.name) AS goodSB
FROM
	Wine W
	JOIN Appellations A ON W.appellation = A.appellation
	JOIN Grapes G ON G.grape = W.grape
WHERE
	score >= 90 AND county = 'Sonoma' AND color = 'Red'
GROUP BY
	vintage
ORDER BY
	vintage;

-- Q3
SELECT
	W.appellation AS appellation,
	county,
	COUNT(W.name) AS numWines,
	AVG(price) AS avgPrice,
	SUM(cases) * 12 AS bottles
FROM
	Wine W
	JOIN Appellations A ON W.appellation = A.appellation
WHERE
	grape = 'Cabernet Sauvingnon' AND vintage = 2007
GROUP BY
	W.appellation, county
HAVING
	COUNT(*) > 2
ORDER BY
	SUM(cases) DESC;

-- Q4
SELECT
	W.appellation AS appellation,
	SUM(cases) * 12 AS sales
FROM
	Wine W
	JOIN Appellations A ON W.appellation = A.appellation
WHERE
	vintage = 2008 AND area = 'Central Coast'
GROUP BY
	W.appellation
ORDER BY
	SUM(cases) * 12;

-- Q5
SELECT
	county,
	MAX(score) AS bestScore
FROM
	Wine W
	JOIN Appellations A ON W.appellation = A.appellation
	JOIN Grapes G ON G.grape = W.grape
WHERE
	vintage = 2009 AND color = 'Red' AND county <> 'N/A'
GROUP BY
	county
ORDER BY
	MAX(score);
