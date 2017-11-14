-- Name: Di Hoang
-- Username: dlhoang

CREATE TABLE Customers (
	cId INT,
	lastName VARCHAR(40),
	firstName VARCHAR(40),
	CONSTRAINT idKey PRIMARY KEY (cId),
	CONSTRAINT name UNIQUE(lastName, firstName)
);

CREATE TABLE Goods (
	gId VARCHAR(40),
	flavor VARCHAR(40),
	food VARCHAR(40),
	price DECIMAL(4,2),
	CONSTRAINT goodsKey PRIMARY KEY (gId)
);

CREATE TABLE Receipts (
	rNumber INT,
	saleDate DATE,
	customer INT,
	FOREIGN KEY (customer) REFERENCES Customers (cId),
	CONSTRAINT recKey PRIMARY KEY (rNumber)
);

CREATE TABLE Items (
	receipt INT,
	ordinal INT,
	item VARCHAR(40),
	FOREIGN KEY (receipt) REFERENCES Receipts (rNumber),
	FOREIGN KEY (item) REFERENCES Goods (gId),
	CONSTRAINT itemKey PRIMARY KEY (receipt, ordinal)
);
