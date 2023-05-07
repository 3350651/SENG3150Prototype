CREATE DATABASE flightPub;
USE flightPub; 

CREATE LOGIN fb1
WITH PASSWORD = 'mySecur3Passw0rd!';

CREATE USER fb1 
FOR LOGIN fb1;

GRANT SELECT, INSERT, UPDATE, DELETE 
TO fb1;

DROP TABLE USERS;

CREATE TABLE USERS
(
	userID			  UNIQUEIDENTIFIER,
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
  NumFirstClass INT(11) NOT NULL,
  NumBusiness INT(11) NOT NULL,
  NumPremiumEconomy INT(11) NOT NULL,
  Economy INT(11) NOT NULL,
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
  Transferrable BIT(1) NOT NULL,
  Refundable BIT(1) NOT NULL,
  Exchangeable BIT(1) NOT NULL,
  FrequentFlyerPoINTs BIT(1) NOT NULL,
  PRIMARY KEY (TicketCode)
)

CREATE TABLE Availability (
  AirlineCode CHAR(2) NOT NULL,
  FlightNumber VARCHAR(6) NOT NULL,
  DepartureTime DATETIME NOT NULL,
  ClassCode CHAR(3) NOT NULL,
  TicketCode CHAR(1) NOT NULL,
  NumberAvailableSeatsLeg1 INT(11) NOT NULL,
  NumberAvailableSeatsLeg2 INT(11) DEFAULT NULL,
  PRIMARY KEY (AirlineCode,FlightNumber,DepartureTime,ClassCode,TicketCode),
  CONSTRAINT AvailabilityTicketCode_FK FOREIGN KEY (TicketCode) REFERENCES TicketType (TicketCode),
  CONSTRAINT AvailabilityAirlineCode_FK FOREIGN KEY (AirlineCode) REFERENCES Airlines (AirlineCode),
  CONSTRAINT AvailabilityClassCode_FK FOREIGN KEY (ClassCode) REFERENCES TicketClass (ClassCode)
)

CREATE TABLE Distances (
  DestinationCode1 CHAR(3) NOT NULL,
  DestinationCode2 CHAR(3) NOT NULL,
  DistancesInKms INT(11) NOT NULL,
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
  Duration INT(11) NOT NULL,
  DurationSecondLeg INT(11) DEFAULT NULL,
  PRIMARY KEY (AirlineCode,FlightNumber,DepartureTime),
  CONSTRAINT FlightsPlaneCode_FK FOREIGN KEY (PlaneCode) REFERENCES PlaneType (PlaneCode),
  CONSTRAINT FlightsAirlineCode_FK FOREIGN KEY (AirlineCode) REFERENCES Airlines (AirlineCode),
  CONSTRAINT FlightsDepartureCode_FK FOREIGN KEY (DepartureCode) REFERENCES Destinations (DestinationCode),
  CONSTRAINT FlightsDestinationCode_FK FOREIGN KEY (DestinationCode) REFERENCES Destinations (DestinationCode),
  CONSTRAINT FlightsStopOverCode_FK FOREIGN KEY (StopOverCode) REFERENCES Destinations (DestinationCode)
)


go

INSERT INTO USERS VALUES (NEWID(), 'Lachlan', 'ONeill', 'lachlan@gmail.com', 'lo', '04 123 456', 'user', '12 Main St, Carrington, NSW, Australia', 'Simple', 'AUD', '+10', 'Light', 0, '1997-08-29')
INSERT INTO USERS VALUES (NEWID(), 'Jordan', 'Eade', 'jordan@gmail.com', 'je', '04 454 678', 'user', '45 Smith St, Brisbane, QLD, Australia', 'Simple', 'AUD', '+10', 'Light', 1, '2003-07-14');
INSERT INTO USERS VALUES (NEWID(), 'Lucy', 'Knight', 'lucy@gmail.com', 'lk', '04 474 235', 'user', '87 George St, Adelaide, SA, Australia', 'Stripe', 'AUD', '+10', 'Dark', 0, '2004-03-21');
INSERT INTO USERS VALUES (NEWID(), 'Blake', 'Baldin', 'blake@gmail.com', 'bb', '04 123 456', 'user', '39 High St, Melbourne, VIC, Australia', 'Recommend', 'AUD', '+10', 'Dark', 0, '2002-10-06')


go

SELECT * FROM USERS;