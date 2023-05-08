DROP DATABASE flightPub
go

CREATE DATABASE flightPub;
go

USE flightPub; 

DROP LOGIN fb1;
DROP USER fb1;

CREATE LOGIN fb1
WITH PASSWORD = 'mySecur3Passw0rd!';

CREATE USER fb1 
FOR LOGIN fb1;

GRANT SELECT, INSERT, UPDATE, DELETE 
TO fb1;

DROP TABLE IF EXISTS USERGROUPS;
DROP TABLE IF EXISTS GROUPS;
DROP TABLE IF EXISTS Flights;
DROP TABLE IF EXISTS Price;
DROP TABLE IF EXISTS Distances;
DROP TABLE IF EXISTS Availability;
DROP TABLE IF EXISTS TicketType;
DROP TABLE IF EXISTS TicketClass;
DROP TABLE IF EXISTS Destinations;
DROP TABLE IF EXISTS PlaneType;
DROP TABLE IF EXISTS Airlines;
DROP TABLE IF EXISTS Country;
DROP TABLE IF EXISTS USERS;

CREATE TABLE USERS
(
	userID			  CHAR(8),
	first_name			VARCHAR(20),
	last_name			VARCHAR(20),
	email				VARCHAR(30),
	userPassword		VARCHAR(100),
	phoneNo    			VARCHAR(15),
	roles         		VARCHAR(20),
	address				VARCHAR(50),
	defaultSearch		VARCHAR(10),
	defaultCurrency		VARCHAR(5),
	defaultTimeZone		VARCHAR(5),
	themePreference		VARCHAR(10),
	quesCompl			BIT,
	dateOfBirth			DATE,

	PRIMARY KEY (userID),
)

CREATE TABLE Country 
(
  countryCode2 CHAR(2) NOT NULL,
  countryCode3 CHAR(3) NOT NULL,
  countryName VARCHAR(80) NOT NULL DEFAULT '',
  alternateName1 VARCHAR(80) NOT NULL DEFAULT '',
  alternateName2 VARCHAR(80) NOT NULL DEFAULT '',
  motherCountryCode3 CHAR(3) NOT NULL DEFAULT '',
  motherCountryComment VARCHAR(80) NOT NULL DEFAULT '',
  PRIMARY KEY (countryCode3)
)

CREATE TABLE Airlines (
  AirlineCode CHAR(2) NOT NULL,
  AirlineName VARCHAR(30) NOT NULL,
  CountryCode3 CHAR(3) NOT NULL,
  PRIMARY KEY (AirlineCode),
  CONSTRAINT AirlinesCountryCode3_FK FOREIGN KEY (CountryCode3) REFERENCES Country (countryCode3)
)

CREATE TABLE PlaneType (
  PlaneCode VARCHAR(20) NOT NULL,
  Details VARCHAR(50) NOT NULL,
  NumFirstClass INT NOT NULL,
  NumBusiness INT NOT NULL,
  NumPremiumEconomy INT NOT NULL,
  Economy INT NOT NULL,
  PRIMARY KEY (PlaneCode)
)

CREATE TABLE Destinations (
  DestinationCode CHAR(3) NOT NULL,
  Airport VARCHAR(30) NOT NULL,
  CountryCode3 CHAR(3) NOT NULL,
  PRIMARY KEY (DestinationCode),
  CONSTRAINT DestinationCountryCode_FK FOREIGN KEY (CountryCode3) REFERENCES Country (countryCode3)
)

CREATE TABLE TicketClass (
  ClassCode CHAR(3) NOT NULL,
  Details VARCHAR(20) NOT NULL,
  PRIMARY KEY (ClassCode)
)

CREATE TABLE TicketType (
  TicketCode CHAR(1) NOT NULL,
  Name VARCHAR(50) NOT NULL,
  Transferrable BIT NOT NULL,
  Refundable BIT NOT NULL,
  Exchangeable BIT NOT NULL,
  FrequentFlyerPoINTs BIT NOT NULL,
  PRIMARY KEY (TicketCode)
)

CREATE TABLE Availability (
  AirlineCode CHAR(2) NOT NULL,
  FlightNumber VARCHAR(6) NOT NULL,
  DepartureTime DATETIME NOT NULL,
  ClassCode CHAR(3) NOT NULL,
  TicketCode CHAR(1) NOT NULL,
  NumberAvailableSeatsLeg1 INT NOT NULL,
  NumberAvailableSeatsLeg2 INT DEFAULT NULL,
  PRIMARY KEY (AirlineCode,FlightNumber,DepartureTime,ClassCode,TicketCode),
  CONSTRAINT AvailabilityTicketCode_FK FOREIGN KEY (TicketCode) REFERENCES TicketType (TicketCode),
  CONSTRAINT AvailabilityAirlineCode_FK FOREIGN KEY (AirlineCode) REFERENCES Airlines (AirlineCode),
  CONSTRAINT AvailabilityClassCode_FK FOREIGN KEY (ClassCode) REFERENCES TicketClass (ClassCode)
)

CREATE TABLE Distances (
  DestinationCode1 CHAR(3) NOT NULL,
  DestinationCode2 CHAR(3) NOT NULL,
  DistancesInKms INT NOT NULL,
  PRIMARY KEY (DestinationCode1,DestinationCode2),
  CONSTRAINT DestinationCode2_FK FOREIGN KEY (DestinationCode2) REFERENCES Destinations (DestinationCode),
  CONSTRAINT DestinationCode1_FK FOREIGN KEY (DestinationCode1) REFERENCES Destinations (DestinationCode)
)

CREATE TABLE Price (
  AirlineCode CHAR(2) NOT NULL,
  FlightNumber VARCHAR(6) NOT NULL,
  ClassCode CHAR(3) NOT NULL,
  TicketCode CHAR(1) NOT NULL,
  StartDate DATETIME NOT NULL,
  EndDate DATETIME NOT NULL,
  Price DECIMAL(10,2) NOT NULL,
  PriceLeg1 DECIMAL(10,2) DEFAULT NULL,
  PriceLeg2 DECIMAL(10,2) DEFAULT NULL,
  PRIMARY KEY (AirlineCode,FlightNumber,ClassCode,TicketCode,StartDate),
  CONSTRAINT PriceAirlineCode_FK FOREIGN KEY (AirlineCode) REFERENCES Airlines (AirlineCode),
  CONSTRAINT PriceClassCode_FK FOREIGN KEY (ClassCode) REFERENCES TicketClass (ClassCode),
  CONSTRAINT PriceTicketCode_FK FOREIGN KEY (TicketCode) REFERENCES TicketType (TicketCode)
)

CREATE TABLE Flights (
  AirlineCode CHAR(2) NOT NULL,
  FlightNumber VARCHAR(6) NOT NULL,
  DepartureCode CHAR(3) NOT NULL,
  StopOverCode CHAR(3) DEFAULT NULL,
  DestinationCode CHAR(3) NOT NULL,
  DepartureTime DATETIME NOT NULL,
  ArrivalTimeStopOver DATETIME DEFAULT NULL,
  DepartureTimeStopOver DATETIME DEFAULT NULL,
  ArrivalTime DATETIME NOT NULL,
  PlaneCode VARCHAR(20) NOT NULL,
  Duration INT NOT NULL,
  DurationSecondLeg INT DEFAULT NULL,
  PRIMARY KEY (AirlineCode,FlightNumber,DepartureTime),
  CONSTRAINT FlightsPlaneCode_FK FOREIGN KEY (PlaneCode) REFERENCES PlaneType (PlaneCode),
  CONSTRAINT FlightsAirlineCode_FK FOREIGN KEY (AirlineCode) REFERENCES Airlines (AirlineCode),
  CONSTRAINT FlightsDepartureCode_FK FOREIGN KEY (DepartureCode) REFERENCES Destinations (DestinationCode),
  CONSTRAINT FlightsDestinationCode_FK FOREIGN KEY (DestinationCode) REFERENCES Destinations (DestinationCode),
  CONSTRAINT FlightsStopOverCode_FK FOREIGN KEY (StopOverCode) REFERENCES Destinations (DestinationCode)
)

-- Create groups

CREATE TABLE GROUPS
(
	groupID 	CHAR(8) PRIMARY KEY,
	groupName		VARCHAR(20),
	-- poolID
	-- chatID
	-- faveListID

)
CREATE TABLE USERGROUPS
(
	userGroupsID		CHAR(8),
	userID	CHAR(8) FOREIGN KEY REFERENCES USERS(userID),
	groupID CHAR(8) FOREIGN KEY REFERENCES GROUPS(groupID),
	isAdmin		BIT DEFAULT(0),
)

go

INSERT INTO USERS VALUES ('01010101', 'Lachlan', 'ONeill', 'lachlan@gmail.com', 'lo', '04 123 456', 'user', '12 Main St, Carrington, NSW, Australia', 'Simple', 'AUD', '+10', 'Light', 0, '1997-08-29')
INSERT INTO USERS VALUES ('11112222', 'Jordan', 'Eade', 'jordan@gmail.com', 'je', '04 454 678', 'user', '45 Smith St, Brisbane, QLD, Australia', 'Simple', 'AUD', '+10', 'Light', 1, '2003-07-14');
INSERT INTO USERS VALUES ('98765432', 'Lucy', 'Knight', 'lucy@gmail.com', 'lk', '04 474 235', 'user', '87 George St, Adelaide, SA, Australia', 'Stripe', 'AUD', '+10', 'Dark', 0, '2004-03-21');
INSERT INTO USERS VALUES ('12345678', 'Blake', 'Baldin', 'blake@gmail.com', 'bb', '04 123 456', 'user', '39 High St, Melbourne, VIC, Australia', 'Recommend', 'AUD', '+10', 'Dark', 0, '2002-10-06')


INSERT INTO Country (countryCode2, countryCode3, countryName, alternateName1, alternateName2, motherCountryCode3, motherCountryComment)
VALUES
	('BR','BRA','Brazil','Federative Republic of Brazil','','',''),
	('US','USA','United States','United States of America','U.S.A.','','');

INSERT INTO Destinations (DestinationCode, Airport, CountryCode3)
VALUES
	('ATL','Atlanta','USA'),
	('GIG','Rio De Janeiro','BRA'),
	('MIA','Miami','USA');

INSERT INTO Airlines (AirlineCode, AirlineName, CountryCode3)
VALUES
	('AA','American Airlines','USA');

INSERT INTO PlaneType (PlaneCode, Details, NumFirstClass, NumBusiness, NumPremiumEconomy, Economy)
VALUES
	('747-100','Boeing 747-100',55,58,100,210),
	('757-200','Boeing 757-200',44,26,106,197),
	('757-300','Boeing 757-300',44,28,106,197),
	('767-200','Boeing 767-200',40,48,115,189),
	('767-300','Boeing 767-300',42,33,132,211),
	('767-400','Boeing 767-400',42,50,121,220),
	('A330-200','Airbus A330-200',42,40,120,177),
	('A330-300','Airbus A330-300',44,46,91,210),
	('A340-200','Airbus A340-200',42,50,124,208),
	('A340-300','Airbus A340-300',41,36,112,196),
	('A340-500','Airbus A340-500',39,62,131,187),
	('A340-600','Airbus A340-600',35,55,98,200),
	('A380','Airbus A380',46,47,111,203);

INSERT INTO Flights (AirlineCode, FlightNumber, DepartureCode, StopOverCode, DestinationCode, DepartureTime, ArrivalTimeStopOver, DepartureTimeStopOver, ArrivalTime, PlaneCode, Duration, DurationSecondLeg)
VALUES
	('AA','AA1735','ATL','MIA','GIG','2014-09-23 09:50:00','2014-09-23 11:50:00','2014-09-23 23:20:00','2014-09-24 09:00:00','A380',120,520)