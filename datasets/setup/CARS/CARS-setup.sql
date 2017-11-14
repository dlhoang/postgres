-- Name: Di Hoang
-- Username: dlhoang

CREATE TABLE Continents (
	contId INT,
	continent VARCHAR(20),
	CONSTRAINT contKey PRIMARY KEY (contId)
);

CREATE TABLE Countries (
	id INT,
	name VARCHAR(50),
	continent INT,
	CONSTRAINT countryKey PRIMARY KEY (id),
	FOREIGN KEY (continent) REFERENCES Continents (contId)
);

CREATE TABLE CarMakers (
	id INT,
	maker VARCHAR(30),
	fullName VARCHAR(50),
	country INT,
	CONSTRAINT idKey PRIMARY KEY (id),
	FOREIGN KEY (country) REFERENCES Countries (id)
);

CREATE TABLE Models (
	modelId INT,
	maker INT,
	model VARCHAR(40),
	CONSTRAINT modelKey PRIMARY KEY (modelId),
	FOREIGN KEY (maker) REFERENCES CarMakers (id),
	UNIQUE(model)
);

CREATE TABLE Makes (
	id INT,
	model VARCHAR(40),
	make VARCHAR(70),
	FOREIGN KEY (model) REFERENCES Models (model),
	CONSTRAINT makeKey PRIMARY KEY (id)
);

CREATE TABLE CarData (
	id INT,
	mpg FLOAT,
	cylinders INT,
	edispl INT,
	horsepower INT,
	weight INT,
	accelerate FLOAT,
	year INT,
	CONSTRAINT dataId PRIMARY KEY (id),
	FOREIGN KEY (id) REFERENCES Makes (id)
);
