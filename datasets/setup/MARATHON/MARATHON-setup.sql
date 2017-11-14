-- Name: Di Hoang
-- Username: dlhoang

CREATE TABLE Marathon (
	place INT,
	time TIME,
	pace TIME,
	groupPlace INT,
	ageGroup VARCHAR(10),
	age INT,
	sex CHAR(1),
	bibNumber INT,
	firstName VARCHAR(40),
	lastName VARCHAR(40),
	town VARCHAR(40),
	state CHAR(2),
	CONSTRAINT placeKey PRIMARY KEY (place)
);
