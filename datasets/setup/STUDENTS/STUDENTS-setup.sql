-- Name: Di Hoang
-- Username: dlhoang

CREATE TABLE Teachers (
	last VARCHAR(40),
	first VARCHAR(40),
	classroom INT,
	CONSTRAINT roomKey PRIMARY KEY (classroom)
);

CREATE TABLE List (
	lastName VARCHAR(40),
	firstName VARCHAR(40),
	grade INT,
	classroom INT,
	CONSTRAINT stKey PRIMARY KEY (lastName, firstName)
);
