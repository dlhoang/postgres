-- Name: Di Hoang
-- Username: dlhoang

CREATE TABLE Airlines (
	id INT,
	name VARCHAR(40),
	abbreviation VARCHAR(40),
	country VARCHAR(40),
	CONSTRAINT prKey PRIMARY KEY (id)
);

CREATE TABLE Airports (
	city VARCHAR(40),
	code CHAR(3),
	name VARCHAR(60),
	country VARCHAR(40),
	countryAbbrev VARCHAR(40),
	CONSTRAINT code PRIMARY KEY (code)
);

CREATE TABLE Flights (
	airline INT,
	flightNo INT,
	source CHAR(3),
	destination CHAR(3),
	FOREIGN KEY (airline) REFERENCES Airlines (id),
	FOREIGN KEY (source) REFERENCES Airports (code),
	FOREIGN KEY (destination) REFERENCES Airports (code),
	CONSTRAINT flight PRIMARY KEY (airline, flightNo)
);
