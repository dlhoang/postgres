-- Name: Di Hoang
-- Username: dlhoang

CREATE TABLE Rooms (
	roomCode CHAR(3),
	roomName VARCHAR(40),
	beds INT,
	bedType VARCHAR(40),
	maxOccupancy INT,
	basePrice INT,
	decor VARCHAR(40),
	CONSTRAINT roomId PRIMARY KEY (roomCode)
);

CREATE TABLE Reservations (
	code INT,
	room CHAR(3),
	checkIn DATE,
	checkOut DATE,
	rate DECIMAL(5,2),
	lastName VARCHAR(40),
	firstName VARCHAR(40),
	adults INT,
	kids INT,
	FOREIGN KEY (room) REFERENCES Rooms (roomCode),
	CONSTRAINT resKey PRIMARY KEY (code)
);

