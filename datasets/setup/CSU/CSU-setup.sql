-- Name: Di Hoang
-- Username: dlhoang

CREATE TABLE Campuses (
	id INT,
	campus VARCHAR(100),
	location VARCHAR(50),
	county VARCHAR(50),
	year INT,
	CONSTRAINT idKey PRIMARY KEY (id)
);

CREATE TABLE Fees (
	campusId INT,
	year INT,
	fee INT,
	FOREIGN KEY (campusId) REFERENCES Campuses (id),
	CONSTRAINT campusKey PRIMARY KEY (campusId, year)
);

CREATE TABLE Degrees (
	year INT,
	campusId INT,
	degrees INT,
	FOREIGN KEY (campusId) REFERENCES Campuses (id),
	CONSTRAINT degreeKey PRIMARY KEY (year, campusId)
);

CREATE TABLE Disciplines (
	id INT,
	name VARCHAR(40),
	CONSTRAINT disKey PRIMARY KEY (id)
);

CREATE TABLE DisciplineEnrollments (
	campusId INT,
	discipline INT,
	year INT,
	undergrad INT,
	graduate INT,
	FOREIGN KEY (discipline) REFERENCES Disciplines (id),
	FOREIGN KEY (campusId) REFERENCES Campuses (id),
	CONSTRAINT disEnKey PRIMARY KEY (campusId, discipline, year)
);

CREATE TABLE Enrollments (
	campusId INT,
	year INT,
	enrolled INT,
	fte INT,
	FOREIGN KEY (campusId) REFERENCES Campuses (id),
	CONSTRAINT enrollKey PRIMARY KEY (campusId, year)
);

CREATE TABLE Faculty (
	campusId INT,
	year INT,
	fte FLOAT,
	FOREIGN KEY (campusId) REFERENCES Campuses (id),
	CONSTRAINT facultyKey PRIMARY KEY (campusId, year)
);
