-- Name: Di Hoang
-- Username: dlhoang

CREATE TABLE Appellations (
	num INT,
	appellation VARCHAR(60),
	county VARCHAR(40),
	stateLocation VARCHAR(40),
	area VARCHAR(60),
	isAVA VARCHAR(10),
	CONSTRAINT numKey PRIMARY KEY (num),
	UNIQUE(appellation)
);

CREATE TABLE Grapes (
	id INT,
	grape VARCHAR(40),
	color VARCHAR(40),
	CONSTRAINT idKey PRIMARY KEY (id),
	UNIQUE(grape)
);

CREATE TABLE Wine (
	wineNum INT,
	grape VARCHAR(40),
	winery VARCHAR(40),
	appellation VARCHAR(60),
	name VARCHAR(60),
	vintage INT,
	price FLOAT,
	score INT,
	cases INT,
	FOREIGN KEY (appellation) REFERENCES Appellations (appellation),
	FOREIGN KEY (grape) REFERENCES Grapes (grape),
	CONSTRAINT wineNumKey PRIMARY KEY (wineNum)
);
