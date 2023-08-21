DROP DATABASE flightPub
go

CREATE DATABASE flightPub;
go

USE flightPub;
go
 
DROP LOGIN fb1;
go

DROP USER fb1;
go

CREATE LOGIN fb1
WITH PASSWORD = 'mySecur3Passw0rd!';
go

CREATE USER fb1
FOR LOGIN fb1;
go

GRANT SELECT, INSERT, UPDATE, DELETE
TO fb1;
go

DROP TABLE IF EXISTS USERSAVEDSEARCHES
GO
DROP TABLE IF EXISTS CALENDAR;
go
DROP TABLE IF EXISTS TICKETS;
go
DROP TABLE IF EXISTS PASSENGERS;
GO
DROP TABLE IF EXISTS BOOKINGS;
go
DROP TABLE IF EXISTS DESTINATIONTAGS;
go
DROP TABLE IF EXISTS USERFAVOURITEDDESTINATIONS;
go
DROP TABLE IF EXISTS BOOKMARKEDFLIGHT;
go
DROP TABLE IF EXISTS FLIGHTPATHFLIGHT
GO
DROP TABLE IF EXISTS MEMBERFLIGHTVOTE;
go
DROP TABLE IF EXISTS GROUPFAVEFLIGHT;
go
DROP TABLE IF EXISTS FLIGHTPATH;
go
DROP TABLE IF EXISTS USERTAGS;
go
DROP TABLE IF EXISTS BOOKMARKEDFLIGHT;
go
DROP TABLE IF EXISTS FLIGHTPATH;
go
DROP TABLE IF EXISTS USERFAVOURITEDDESTINATIONS;
go
DROP TABLE IF EXISTS DESTINATIONTAGS;
go
DROP TABLE IF EXISTS TAGS;
go
DROP TABLE IF EXISTS USERGROUPS;
go
DROP TABLE IF EXISTS GROUPS;
go
DROP TABLE IF EXISTS POOLDEPOSIT;
go
DROP TABLE IF EXISTS POOL;
go
DROP TABLE IF EXISTS MESSAGE;
go
DROP TABLE IF EXISTS CHAT;
go
DROP TABLE IF EXISTS Price;
go
DROP TABLE IF EXISTS Availability;
go
DROP TABLE IF EXISTS Flights;
go
DROP TABLE IF EXISTS Distances;
go
DROP TABLE IF EXISTS TicketType;
go
DROP TABLE IF EXISTS TicketClass;
go
DROP TABLE IF EXISTS Destinations;
go
DROP TABLE IF EXISTS PlaneType;
go
DROP TABLE IF EXISTS Airlines;
go
DROP TABLE IF EXISTS Country;
go
DROP TABLE IF EXISTS USERS;
go

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
	questionnaireCompleted	VARCHAR(8),
	dateOfBirth			DATE,

	PRIMARY KEY (userID),
)
go

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
go

CREATE TABLE Airlines (
  AirlineCode CHAR(2) NOT NULL,
  AirlineName VARCHAR(30) NOT NULL,
  CountryCode3 CHAR(3) NOT NULL,
  PRIMARY KEY (AirlineCode),
  CONSTRAINT AirlinesCountryCode3_FK FOREIGN KEY (CountryCode3) REFERENCES Country (countryCode3)
  ON UPDATE CASCADE ON DELETE CASCADE
)
go

CREATE TABLE PlaneType (
  PlaneCode VARCHAR(20) NOT NULL,
  Details VARCHAR(50) NOT NULL,
  NumFirstClass INT NOT NULL,
  NumBusiness INT NOT NULL,
  NumPremiumEconomy INT NOT NULL,
  Economy INT NOT NULL,
  PRIMARY KEY (PlaneCode)
)
go

CREATE TABLE Destinations (
  DestinationCode CHAR(3) NOT NULL,
  Airport VARCHAR(30) NOT NULL,
  CountryCode3 CHAR(3) NOT NULL,
  PRIMARY KEY (DestinationCode),
  CONSTRAINT DestinationCountryCode_FK FOREIGN KEY (CountryCode3) REFERENCES Country (countryCode3)
  ON UPDATE CASCADE ON DELETE CASCADE
)
go

CREATE TABLE TicketClass (
  ClassCode CHAR(3) NOT NULL,
  Details VARCHAR(20) NOT NULL,
  PRIMARY KEY (ClassCode)
)
go

CREATE TABLE TicketType (
  TicketCode CHAR(1) NOT NULL,
  Name VARCHAR(50) NOT NULL,
  Transferrable BIT NOT NULL,
  Refundable BIT NOT NULL,
  Exchangeable BIT NOT NULL,
  FrequentFlyerPoINTs BIT NOT NULL,
  PRIMARY KEY (TicketCode)
)
go

CREATE TABLE Availability (
  AirlineCode CHAR(2) NOT NULL,
  FlightNumber VARCHAR(6) NOT NULL,
  DepartureTime DATETIME NOT NULL,
  ClassCode CHAR(3) NOT NULL,
  TicketCode CHAR(1) NOT NULL,
  NumberAvailableSeatsLeg1 INT NOT NULL,
  NumberAvailableSeatsLeg2 INT DEFAULT NULL,
  PRIMARY KEY (AirlineCode,FlightNumber,DepartureTime,ClassCode,TicketCode),
  CONSTRAINT AvailabilityTicketCode_FK FOREIGN KEY (TicketCode) REFERENCES TicketType (TicketCode)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT AvailabilityAirlineCode_FK FOREIGN KEY (AirlineCode) REFERENCES Airlines (AirlineCode)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT AvailabilityClassCode_FK FOREIGN KEY (ClassCode) REFERENCES TicketClass (ClassCode)
  ON UPDATE CASCADE ON DELETE CASCADE
)
go

CREATE TABLE Distances (
  DestinationCode1 CHAR(3) NOT NULL,
  DestinationCode2 CHAR(3) NOT NULL,
  DistancesInKms INT NOT NULL,
  PRIMARY KEY (DestinationCode1,DestinationCode2),
  CONSTRAINT DestinationCode2_FK FOREIGN KEY (DestinationCode2) REFERENCES Destinations (DestinationCode)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT DestinationCode1_FK FOREIGN KEY (DestinationCode1) REFERENCES Destinations (DestinationCode)
)
go

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
  CONSTRAINT PriceAirlineCode_FK FOREIGN KEY (AirlineCode) REFERENCES Airlines (AirlineCode)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT PriceClassCode_FK FOREIGN KEY (ClassCode) REFERENCES TicketClass (ClassCode)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT PriceTicketCode_FK FOREIGN KEY (TicketCode) REFERENCES TicketType (TicketCode)
  ON UPDATE CASCADE ON DELETE CASCADE
)
go

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
  CONSTRAINT FlightsPlaneCode_FK FOREIGN KEY (PlaneCode) REFERENCES PlaneType (PlaneCode)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT FlightsAirlineCode_FK FOREIGN KEY (AirlineCode) REFERENCES Airlines (AirlineCode)
  ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT FlightsDepartureCode_FK FOREIGN KEY (DepartureCode) REFERENCES Destinations (DestinationCode),
  CONSTRAINT FlightsDestinationCode_FK FOREIGN KEY (DestinationCode) REFERENCES Destinations (DestinationCode),
  CONSTRAINT FlightsStopOverCode_FK FOREIGN KEY (StopOverCode) REFERENCES Destinations (DestinationCode)
)
go

CREATE TABLE CHAT
(
	chatID		CHAR(8) PRIMARY KEY,
)
go

CREATE TABLE MESSAGE
(
	messageID CHAR(8) PRIMARY KEY,
	chatID CHAR(8) FOREIGN KEY REFERENCES CHAT(chatID)
  ON UPDATE CASCADE ON DELETE CASCADE,
	message VARCHAR(MAX),
	messageTime VARCHAR(20),
	userID CHAR(8) FOREIGN KEY REFERENCES USERS(userID)
  ON UPDATE CASCADE ON DELETE CASCADE,
)
go

CREATE TABLE POOL
(
	poolID CHAR(8) PRIMARY KEY,
	totalAmount	FLOAT,
	amountRemaining FLOAT,
)
go

CREATE TABLE POOLDEPOSIT
(
	poolDepositID CHAR(8) PRIMARY KEY,
	poolID CHAR(8) FOREIGN KEY REFERENCES POOL(poolID)
  ON UPDATE CASCADE ON DELETE CASCADE,
	userID CHAR(8) FOREIGN KEY REFERENCES USERS(userID)
  ON UPDATE CASCADE ON DELETE CASCADE,
	amount FLOAT,
)
go

CREATE TABLE GROUPS
(
	groupID 	CHAR(8) PRIMARY KEY,
	groupName		VARCHAR(20),
	poolID 	CHAR(8) FOREIGN KEY REFERENCES POOL(poolID),
	questionnaireCompleted	VARCHAR(8),
)

CREATE TABLE USERGROUPS
(
	userGroupsID		CHAR(8) PRIMARY KEY,
	userID	CHAR(8) FOREIGN KEY REFERENCES USERS(userID)
  ON UPDATE CASCADE ON DELETE CASCADE,
	groupID CHAR(8) FOREIGN KEY REFERENCES GROUPS(groupID)
  ON UPDATE CASCADE ON DELETE CASCADE,
	isAdmin		INT DEFAULT(0),
)
go

CREATE TABLE TAGS
(
	tagID		CHAR(8) PRIMARY KEY,
	tagName		VARCHAR(30),
	DESCRIPTION	VARCHAR(100)
)
go

CREATE TABLE USERTAGS
(
	userTagsID	CHAR(8) PRIMARY KEY,
	tagID 		CHAR(8) FOREIGN KEY REFERENCES TAGS(tagID)
  ON UPDATE CASCADE ON DELETE CASCADE,
	userID		CHAR(8) FOREIGN KEY REFERENCES USERS(userID)
  ON UPDATE CASCADE ON DELETE CASCADE
)
go

CREATE TABLE FLIGHTPATH(
	flightPathID CHAR(8) PRIMARY KEY,
	minimumPrice FLOAT NOT NULL
)
GO

CREATE TABLE FLIGHTPATHFLIGHT(
	flightPathID CHAR(8) NOT NULL,
	AirlineCode CHAR(2) NOT NULL,
	FlightNumber VARCHAR(6) NOT NULL,
	DepartureTime DATETIME NOT NULL,
	Leg INT NOT NULL,
	FOREIGN KEY (flightPathID) REFERENCES FLIGHTPATH (flightPathID),
	FOREIGN KEY (AirlineCode, FlightNumber, DepartureTime) REFERENCES Flights(AirlineCode, FlightNumber, DepartureTime) ON UPDATE CASCADE ON DELETE CASCADE
)
GO

CREATE TABLE GROUPFAVEFLIGHT
(
	groupFaveFlightID CHAR(8) PRIMARY KEY,
	rank   DECIMAL(3,1),
	flightPathID CHAR(8) FOREIGN KEY (flightPathID) REFERENCES FLIGHTPATH (flightPathID),
    chatID  CHAR(8) FOREIGN KEY REFERENCES CHAT(chatID),
    groupID CHAR(8) FOREIGN KEY REFERENCES GROUPS(groupID)
  	ON UPDATE CASCADE ON DELETE CASCADE,

)
go

CREATE TABLE MEMBERFLIGHTVOTE
(
    memberFlightVoteID    CHAR(8) PRIMARY KEY,
    groupID CHAR(8) FOREIGN KEY REFERENCES GROUPS(groupID),
    userID	CHAR(8) FOREIGN KEY REFERENCES USERS(userID)
  ON UPDATE CASCADE ON DELETE CASCADE,
    groupFaveFlightID   CHAR(8) FOREIGN KEY REFERENCES GROUPFAVEFLIGHT(groupFaveFlightID)
  ON UPDATE CASCADE ON DELETE CASCADE,
    score DECIMAL(3,1)
)
go

CREATE TABLE BOOKMARKEDFLIGHT(
	flightPathID CHAR(8) NOT NULL,
	userID CHAR(8) NOT NULL,
	FOREIGN KEY (userID) REFERENCES USERS (userID),
	FOREIGN KEY (flightPathID) REFERENCES FLIGHTPATH (flightPathID)
)
GO

CREATE TABLE USERFAVOURITEDDESTINATIONS(
  userFavouritedDestinationID   CHAR(8) PRIMARY KEY,
  DestinationCode 		          CHAR(3) FOREIGN KEY REFERENCES Destinations(DestinationCode)
  ON UPDATE CASCADE ON DELETE CASCADE,
	userID		                    CHAR(8) FOREIGN KEY REFERENCES USERS(userID)
  ON UPDATE CASCADE ON DELETE CASCADE
)
go

CREATE TABLE DESTINATIONTAGS(
  DestinationTagID    CHAR(8) PRIMARY KEY,
  DestinationCode     CHAR(3) FOREIGN KEY REFERENCES Destinations (DestinationCode)
  ON UPDATE CASCADE ON DELETE CASCADE,
  tagID               CHAR(8) FOREIGN KEY REFERENCES TAGS (tagID)
  ON UPDATE CASCADE ON DELETE CASCADE
)
go

CREATE TABLE BOOKINGS
(
  BookingId CHAR(8) NOT NULL PRIMARY KEY,
  BookingUserId CHAR(8) NOT NULL FOREIGN KEY REFERENCES USERS(userID)
  ON UPDATE CASCADE ON DELETE CASCADE,
  DepartureAirlineCode CHAR(2) NOT NULL FOREIGN KEY REFERENCES Airlines(AirlineCode)
  ON UPDATE CASCADE ON DELETE CASCADE,
  DepartureFlightNumber VARCHAR(6) NOT NULL,
  DepartureTime DATETIME NOT NULL,
  ReturnAirlineCode CHAR(2) NULL,
  ReturnFlightNumber VARCHAR(6) NULL,
  ReturnTime DATETIME NULL,
  TotalAmount DECIMAL(10,2) NULL,
  Progress BIT NOT NULL
)
go

CREATE TABLE PASSENGERS
(
  PassengerId CHAR(8) NOT NULL PRIMARY KEY,
  LastName VARCHAR(MAX) NOT NULL,
  GivenNames VARCHAR(MAX) NOT NULL,
  Email VARCHAR(MAX) NULL,
  PhoneNumber VARCHAR(20) NULL,
  DateOfBirth DATE NOT NULL,
  BookingId CHAR(8) NOT NULL FOREIGN KEY REFERENCES BOOKINGS(BookingId)
  ON UPDATE CASCADE ON DELETE CASCADE
)
go

CREATE TABLE TICKETS
(
  TicketId CHAR(8) NOT NULL PRIMARY KEY,
  BookingId CHAR(8) NOT NULL FOREIGN KEY REFERENCES BOOKINGS(BookingId),
  PassengerId CHAR(8) NOT NULL FOREIGN KEY REFERENCES PASSENGERS(PassengerId)
  ON UPDATE CASCADE ON DELETE CASCADE,
  AirlineCode CHAR(2) NOT NULL FOREIGN KEY REFERENCES Airlines(AirlineCode),
  FlightNumber VARCHAR(6) NOT NULL,
  DepartureTime DATETIME NOT NULL,
  TicketClass CHAR(3) NOT NULL FOREIGN KEY REFERENCES TicketClass(ClassCode)
  ON UPDATE CASCADE ON DELETE CASCADE,
  TicketType CHAR(1) NOT NULL FOREIGN KEY REFERENCES TicketType(TicketCode)
  ON UPDATE CASCADE ON DELETE CASCADE
)
go

 CREATE TABLE CALENDAR
(
	calendarID 	CHAR(8) PRIMARY KEY,
	startDate DATETIME,
	endDate DATETIME,
	userID 	CHAR(8) FOREIGN KEY REFERENCES USERS(userID)
  ON UPDATE CASCADE ON DELETE CASCADE,
	groupID CHAR(8) FOREIGN KEY REFERENCES GROUPS(groupID)
  ON UPDATE CASCADE ON DELETE CASCADE
)
go

CREATE TABLE USERSAVEDSEARCHES
(
	SearchID CHAR(8) NOT NULL PRIMARY KEY,
	DepartureTime DATETIME,
	DepartureLocation VARCHAR(20),
	Destination VARCHAR(20),
	FlexibleDays VARCHAR(3),
	AdultPassengers VARCHAR(3),
	ChildPassengers VARCHAR(3),
	userID CHAR(8) NOT NULL FOREIGN KEY REFERENCES USERS,
)
go

INSERT INTO TAGS VALUES('12341234', 'Tropical', 'Sunny, tropical location.')
INSERT INTO TAGS VALUES('22222222', 'Mild Weather', 'Mild, comfortable climate.')
INSERT INTO TAGS VALUES('33333333', 'Snowsports', 'Knows for great snowsports, very popular in winter.')
INSERT INTO TAGS VALUES('44444444', 'Watersports', 'Surfing, jet skiiing and diving are very popular here, especially in summer')
INSERT INTO TAGS VALUES('55555555', 'Sightseeing', 'Knows for its many great natural and built sights.')
INSERT INTO TAGS VALUES('66666666', 'Famous For Landmarks', 'Incredible landmarks to visit at this location')
INSERT INTO TAGS VALUES('77777777', 'Famous For Food & Drink', 'Diverse and excellent food and drink selections here, people from all over visit to try.')
INSERT INTO TAGS VALUES('11111111', 'Snowy', 'Snowy, cold, mountains, good for skiing.')
INSERT INTO TAGS VALUES('88888888', 'Budget', 'Cheap flights.')
INSERT INTO TAGS VALUES('55511155', 'Family', 'Flight suitable for family groups.')
INSERT INTO TAGS VALUES('11111112', 'Exploration', 'Great for people wishing to experience new things, travel to new locations - hiking, culture etc.')
INSERT INTO TAGS VALUES('11111113', 'Outdoor Adventures', 'Hiking, mountain climbing, 4WD & ATVing, absailing')
INSERT INTO TAGS VALUES('11111114', 'Relaxing', 'Resorts, calm, quiet')
INSERT INTO TAGS VALUES('11111115', 'Experiencing New Cultures', 'Multicultural or a cultural city hub')
INSERT INTO TAGS VALUES('11111116', 'Tourist', 'Frequent tourist type locations - e.g. New York, Paris, Rome, Tokyo etc.')
INSERT INTO TAGS VALUES('11111117', 'Remote', 'Locations rarely holidayed in or with small populations - e.g. Alice Springs, Nova Scotia, Ohio')
INSERT INTO TAGS VALUES('11111118', 'Snowy', 'Locations known for often being heavily covered in snow, e.g. Ontario, Nepal, etc.')
INSERT INTO TAGS VALUES('11111119', 'City', 'Locations know for skyscrapers, being a population center, a wide variety of things to do')
INSERT INTO TAGS VALUES('11111120', 'Popular', 'Popular travel destination - e.g. Sydney, Los Angeles, Greece etc.')
INSERT INTO TAGS VALUES('00000000', 'Cold', 'Cold climate.')
INSERT INTO TAGS VALUES('00000001', 'Desert', 'Hot and Dry climate.')
go

INSERT INTO USERS VALUES ('01010101', 'Lachlan', 'ONeill', 'lachlan@gmail.com', 'lo', '04 123 456', 'user', '12 Main St, Carrington, NSW, Australia', 'Simple', 'AUD', '+10', 'Light', 'No', '1997-08-29')
INSERT INTO USERS VALUES ('11112222', 'Jordan', 'Eade', 'jordan@gmail.com', 'je', '04 454 678', 'user', '45 Smith St, Brisbane, QLD, Australia', 'Simple', 'AUD', '+10', 'Light', 'No', '2003-07-14');
INSERT INTO USERS VALUES ('98765432', 'Lucy', 'Knight', 'lucy@gmail.com', 'lk', '04 474 235', 'user', '87 George St, Adelaide, SA, Australia', 'Stripe', 'AUD', '+10', 'Dark', 'No', '2004-03-21');
INSERT INTO USERS VALUES ('12345678', 'Blake', 'Baldin', 'blake@gmail.com', 'bb', '04 123 456', 'user', '39 High St, Melbourne, VIC, Australia', 'Recommend', 'AUD', '+10', 'Dark', 'Yes', '2002-10-06')
go

INSERT INTO Country (countryCode2, countryCode3, countryName, alternateName1, alternateName2, motherCountryCode3, motherCountryComment)
VALUES
	('AO','A','Anla','Republic of Anla','','',''),
	('AW','ABW','Aruba','','','NLD','Self-verning country in the Kingdom of the Netherlands'),
	('AF','AFG','Afghanistan','Islamic Republic of Afghanistan','','',''),
	('AI','AIA','Anguilla','','','GBR','UK overseas territory'),
	('AX','ALA','Åland Islands','Åland','','FIN','Autonomous province of Finland'),
	('AL','ALB','Albania','Republic of Albania','','',''),
	('AD','AND','Andorra','Principality of Andorra','','',''),
	('AN','ANT','Netherlands Antilles','','','NLD','Self-verning country in the Kingdom of the Netherlands'),
	('AE','ARE','United Arab Emirates','','','',''),
	('AR','ARG','Argentina','Argentine Republic','','',''),
	('AM','ARM','Armenia','Republic of Armenia','','',''),
	('AS','ASM','American Samoa','Territory of American Samoa','','USA','US territory'),
	('AQ','ATA','Antarctica','','','',''),
	('TF','ATF','French Southern Territories','','','FRA','French overseas collectivity'),
	('AG','ATG','Antigua and Barbuda','','','',''),
	('AU','AUS','Australia','Commonwealth of Australia','','',''),
	('AT','AUT','Austria','Republic of Austria','','',''),
	('AZ','AZE','Azerbaijan','Republic of Azerbaijan','','',''),
	('BI','BDI','Burundi','Republic of Burundi','','',''),
	('BE','BEL','Belgium','Kingdom of Belgium','','',''),
	('BJ','BEN','Benin','Republic of Benin','','',''),
	('BF','BFA','Burkina Faso','','','',''),
	('BD','BGD','Bangladesh','People''s Republic of Bangladesh','','',''),
	('BG','BGR','Bulgaria','Republic of Bulgaria','','',''),
	('BH','BHR','Bahrain','Kingdom of Bahrain','','',''),
	('BS','BHS','Bahamas','The Bahamas','Commonwealth of The Bahamas','',''),
	('BA','BIH','Bosnia and Herzevina','Bosnia & Herzevina','','',''),
	('BY','BLR','Belarus','Republic of Belarus','','',''),
	('BZ','BLZ','Belize','','','',''),
	('BM','BMU','Bermuda','','','GBR','UK overseas territory'),
	('BO','BOL','Bolivia','Republic of Bolivia','','',''),
	('BR','BRA','Brazil','Federative Republic of Brazil','','',''),
	('BB','BRB','Barbados','','','',''),
	('BN','BRN','Brunei Darussalam','Brunei','Negara Brunei Darussalam','',''),
	('BT','BTN','Bhutan','Kingdom of Bhutan','','',''),
	('BV','BVT','Bouvet Island','','','NOR','Territory of Norway'),
	('BW','BWA','Botswana','Republic of Botswana','','',''),
	('CF','CAF','Central African Republic','','','',''),
	('CA','CAN','Canada','','','',''),
	('CC','CCK','Cocos (Keeling) Islands','Territory of Cocos (Keeling) Islands','Keeling Islands','AUS','Australian overseas territory'),
	('CH','CHE','Switzerland','Swiss Confederation','','',''),
	('CL','CHL','Chile','Republic of Chile','','',''),
	('CN','CHN','China','People''s Republic of China','China, People''s Republic of','',''),
	('CI','CIV','Côte d''Ivoire','Republic of Côte d''Ivoire','Ivory Coast','',''),
	('CM','CMR','Cameroon','Republic of Cameroon','','',''),
	('CD','COD','Democratic Republic of the Con','Zaire','Con, the Democratic Republic of','',''),
	('CG','COG','Con','Republic of the Con','Con, Republic of','',''),
	('CK','COK','Cook Islands','','','NZL','Associated state of New Zealand'),
	('CO','COL','Colombia','Republic of Colombia','','',''),
	('KM','COM','Comoros','Union of the Comoros','','',''),
	('CV','CPV','Cape Verde','Republic of Cape Verde','','',''),
	('CR','CRI','Costa Rica','Republic of Costa Rica','','',''),
	('CU','CUB','Cuba','Republic of Cuba','','',''),
	('CX','CXR','Christmas Island','Territory of Christmas Island','','AUS','Australian overseas territory'),
	('KY','CYM','Cayman Islands','','','GBR','UK overseas territory'),
	('CY','CYP','Cyprus','Republic of Cyprus','','',''),
	('CZ','CZE','Czech Republic','','','',''),
	('DE','DEU','Germany','Federal Republic of Germany','','',''),
	('DJ','DJI','Djibouti','Republic of Djibouti','','',''),
	('DM','DMA','Dominica','Commonwealth of Dominica','','',''),
	('DK','DNK','Denmark','Kingdom of Denmark','','',''),
	('DO','DOM','Dominican Republic','','','',''),
	('DZ','DZA','Algeria','People''s Democratic Republic of Algeria','','',''),
	('EC','ECU','Ecuador','Republic of Ecuador','','',''),
	('EG','EGY','Egypt','Arab Republic of Egypt','','',''),
	('EN','ENG','England','','','GBR','UK territory'),
	('ER','ERI','Eritrea','State of Eritrea','','',''),
	('EH','ESH','Western Sahara','Sahrawi Arab Democratic Republic','','',''),
	('ES','ESP','Spain','Kingdom of Spain','','',''),
	('EE','EST','Estonia','Republic of Estonia','','',''),
	('ET','ETH','Ethiopia','Federal Democratic Republic of Ethiopia','','',''),
	('FI','FIN','Finland','Republic of Finland','','',''),
	('FJ','FJI','Fiji','Republic of the Fiji Islands','','',''),
	('FK','FLK','Falkland Islands (Malvinas)','Malvinas','Falkland Islands','GBR','UK overseas territory'),
	('FR','FRA','France','French Republic','','',''),
	('FO','FRO','Faroe Islands','','','DNK','Self-verning country in the Kingdom of Denmark'),
	('FM','FSM','Micronesia, Federated States of','Federated States of Micronesia','','',''),
	('GA','GAB','Gabon','Gabonese Republic','','',''),
	('GB','GBR','United Kingdom','United Kingdom of Great Britain and Northern Ireland','Great Britain','',''),
	('GE','GEO','Georgia','','','',''),
	('GG','GGY','Guernsey','Bailiwick of Guernsey','','GBR','British Crown dependency'),
	('GH','GHA','Ghana','Republic of Ghana','','',''),
	('GI','GIB','Gibraltar','','','GBR','UK overseas territory'),
	('GN','GIN','Guinea','Republic of Guinea','','',''),
	('GP','GLP','Guadeloupe','','','',''),
	('GM','GMB','Gambia','Republic of The Gambia','The Gambia','',''),
	('GW','GNB','Guinea-Bissau','Republic of Guinea-Bissau','','',''),
	('GQ','GNQ','Equatorial Guinea','Republic of Equatorial Guinea','','',''),
	('GR','GRC','Greece','Hellenic Republic','','',''),
	('GD','GRD','Grenada','','','',''),
	('GL','GRL','Greenland','','','DNK','Self-verning country in the Kingdom of Denmark'),
	('GT','GTM','Guatemala','Republic of Guatemala','','',''),
	('GF','GUF','French Guiana','','','',''),
	('GU','GUM','Guam','Territory of Guam','','USA','US organized territory'),
	('GY','GUY','Guyana','Co-operative Republic of Guyana','','',''),
	('HK','HKG','Hong Kong','Hong Kong Special Administrative Region of the People''s Republic of China','','CHN','Area of special sovereignty'),
	('HM','HMD','Heard Island and McDonald Islands','','','AUS','Australian overseas territory'),
	('HN','HND','Honduras','Republic of Honduras','','',''),
	('HR','HRV','Croatia','Republic of Croatia','','',''),
	('HT','HTI','Haiti','Republic of Haiti','','',''),
	('HU','HUN','Hungary','Republic of Hungary','','',''),
	('ID','IDN','Indonesia','Republic of Indonesia','','',''),
	('IM','IMN','Isle of Man','','','GBR','British Crown dependency'),
	('IN','IND','India','Republic of India','','',''),
	('IO','IOT','British Indian Ocean Territory','','','GBR','UK overseas territory'),
	('IE','IRL','Ireland','Eire','','',''),
	('IR','IRN','Iran, Islamic Republic of','Islamic Republic of Iran','','',''),
	('IQ','IRQ','Iraq','Republic of Iraq','','',''),
	('IS','ISL','Iceland','Republic of Iceland','','',''),
	('IL','ISR','Israel','State of Israel','','',''),
	('IT','ITA','Italy','Italian Republic','','',''),
	('JM','JAM','Jamaica','','','',''),
	('JE','JEY','Jersey','Bailiwick of Jersey','','GBR','British Crown dependency'),
	('JO','JOR','Jordan','Hashemite Kingdom of Jordan','','',''),
	('JP','JPN','Japan','','','',''),
	('KZ','KAZ','Kazakhstan','Republic of Kazakhstan','','',''),
	('KE','KEN','Kenya','Republic of Kenya','','',''),
	('KG','KGZ','Kyrgyzstan','Kyrgyz Republic','','',''),
	('KH','KHM','Cambodia','Kingdom of Cambodia','','',''),
	('KI','KIR','Kiribati','Republic of Kiribati','','',''),
	('KN','KNA','Saint Kitts and Nevis','Federation of Saint Christopher and Nevis','','',''),
	('KR','KOR','Republic of Korea','Korea','South Korea','',''),
	('KW','KWT','Kuwait','State of Kuwait','','',''),
	('LA','LAO','Lao People''s Democratic Republic','Laos','','',''),
	('LB','LBN','Lebanon','Republic of Lebanon','The Lebanon','',''),
	('LR','LBR','Liberia','Republic of Liberia','','',''),
	('LY','LBY','Libyan Arab Jamahiriya','Libya','Great Socialist People''s Libyan Arab Jamahiriya','',''),
	('LC','LCA','Saint Lucia','','','',''),
	('LI','LIE','Liechtenstein','Principality of Liechtenstein','','',''),
	('LK','LKA','Sri Lanka','Democratic Socialist Republic of Sri Lanka','','',''),
	('LS','LSO','Lesotho','Kingdom of Lesotho','','',''),
	('LT','LTU','Lithuania','Republic of Lithuania','','',''),
	('LU','LUX','Luxembourg','Grand Duchy of Luxembourg','','',''),
	('LV','LVA','Latvia','Republic of Latvia','','',''),
	('MO','MAC','Macao','Macao Special Administrative Region of the People''s Republic of China','','CHN','Area of special sovereignty'),
	('MA','MAR','Morocco','Kingdom of Morocco','','',''),
	('MC','MCO','Monaco','Principality of Monaco','','',''),
	('MD','MDA','Moldova, Republic of','Republic of Moldova','','',''),
	('MG','MDG','Madagascar','Republic of Madagascar','','',''),
	('MV','MDV','Maldives','Republic of Maldives','','',''),
	('MX','MEX','Mexico','United Mexican States','','',''),
	('MH','MHL','Marshall Islands','Republic of the Marshall Islands','','',''),
	('MK','MKD','Macedonia, the former Yuslav Republic of','Republic of Macedonia','Macedonia','',''),
	('ML','MLI','Mali','Republic of Mali','','',''),
	('MT','MLT','Malta','Republic of Malta','','',''),
	('MM','MMR','Myanmar','Burma','Union of Myanmar','',''),
	('ME','MNE','Montenegro','Republic of Montenegro','','',''),
	('MN','MNG','Monlia','','','',''),
	('MP','MNP','Northern Mariana Islands','','','USA','US organized territory'),
	('MZ','MOZ','Mozambique','Republic of Mozambique','','',''),
	('MR','MRT','Mauritania','Islamic Republic of Mauritania','','',''),
	('MS','MSR','Montserrat','','','GBR','UK overseas territory'),
	('MQ','MTQ','Martinique','','','',''),
	('MU','MUS','Mauritius','Republic of Mauritius','','',''),
	('MW','MWI','Malawi','Republic of Malawi','','',''),
	('MY','MYS','Malaysia','','','',''),
	('YT','MYT','Mayotte','Departmental Collectivity of Mayotte','','FRA','French overseas collectivity'),
	('NA','NAM','Namibia','Republic of Namibia','','',''),
	('NC','NCL','New Caledonia','Territory of New Caledonia and Dependencies','','FRA','French community sui generis'),
	('NE','NER','Niger','Republic of Niger','','',''),
	('NF','NFK','Norfolk Island','Territory of Norfolk Island','','AUS','Australian overseas territory'),
	('NG','NGA','Nigeria','Federal Republic of Nigeria','','',''),
	('NI','NIC','Nicaragua','Republic of Nicaragua','','',''),
	('ND','NIR','Northern Island','','','GBR','UK territory'),
	('NU','NIU','Niue','','','NZL','Associated state of New Zealand'),
	('NL','NLD','Netherlands','The Netherlands','Holland','',''),
	('NO','NOR','Norway','Kingdom of Norway','','',''),
	('NP','NPL','Nepal','State of Nepal','','',''),
	('NR','NRU','Nauru','Republic of Nauru','','',''),
	('NZ','NZL','New Zealand','','','',''),
	('OM','OMN','Oman','Sultanate of Oman','','',''),
	('PK','PAK','Pakistan','Islamic Republic of Pakistan','','',''),
	('PA','PAN','Panama','Republic of Panama','','',''),
	('PN','PCN','Pitcairn','Pitcairn, Henderson, Ducie, and Oeno Islands','','GBR','UK overseas territory'),
	('PE','PER','Peru','Republic of Peru','','',''),
	('PH','PHL','Philippines','Republic of the Philippines','','',''),
	('PW','PLW','Palau','Republic of Palau','','USA','US organized territory'),
	('PG','PNG','Papua New Guinea','Independent State of Papua New Guinea','','',''),
	('PL','POL','Poland','Republic of Poland','','',''),
	('PR','PRI','Puerto Rico','Commonwealth of Puerto Rico','','USA','US commonwealth'),
	('KP','PRK','Korea, Democratic People''s Republic of','Democratic People''s Republic of Korea','North Korea','',''),
	('PT','PRT','Portugal','Portuguese Republic','','',''),
	('PY','PRY','Paraguay','Republic of Paraguay','','',''),
	('PS','PSE','Palestinian Territory, Occupied','State of Palestine','Palestine','',''),
	('PF','PYF','French Polynesia','','','FRA','French overseas collectivity'),
	('QA','QAT','Qatar','State of Qatar','','',''),
	('RE','REU','Réunion','Reunion Island','','',''),
	('RO','ROU','Romania','','','',''),
	('RU','RUS','Russian Federation','The Russian Federation','Russia','',''),
	('RW','RWA','Rwanda','Republic of Rwanda','','',''),
	('SA','SAU','Saudi Arabia','Kingdom of Saudi Arabia','','',''),
	('SS','SCO','Scotland','','','GBR','UK territory'),
	('SD','SDN','Sudan','Republic of the Sudan','','',''),
	('SN','SEN','Senegal','Republic of Senegal','','',''),
	('SG','SGP','Singapore','Republic of Singapore','','',''),
	('GS','SGS','South Georgia and the South Sandwich Islands','','','GBR','UK overseas territory'),
	('SH','SHN','Saint Helena','','','GBR','UK overseas territory'),
	('SJ','SJM','Svalbard and Jan Mayen','Svalbard','','NOR','Territory of Norway'),
	('SB','SLB','Solomon Islands','','','',''),
	('SL','SLE','Sierra Leone','Republic of Sierra Leone','','',''),
	('SV','SLV','El Salvador','Republic of El Salvador','','',''),
	('SM','SMR','San Marino','Most Serene Republic of San Marino','','',''),
	('SO','SOM','Somalia','','','',''),
	('PM','SPM','Saint Pierre and Miquelon','Territorial Collectivity of Saint Pierre and Miquelon','','FRA','French overseas collectivity'),
	('RS','SRB','Serbia','Republic of Serbia','Yuslavia','',''),
	('ST','STP','Sao Tome and Principe','Democratic Republic of São Tomé and Príncipe','','',''),
	('SR','SUR','Suriname','Republic of Suriname','','',''),
	('SK','SVK','Slovakia','Slovak Republic','','',''),
	('SI','SVN','Slovenia','Republic of Slovenia','','',''),
	('SE','SWE','Sweden','Kingdom of Sweden','','',''),
	('SZ','SWZ','Swaziland','Kingdom of Swaziland','','',''),
	('SC','SYC','Seychelles','Republic of Seychelles','','',''),
	('SY','SYR','Syrian Arab Republic','Syria','','',''),
	('TG','T','To','Tolese Republic','','',''),
	('TC','TCA','Turks and Caicos Islands','','','GBR','UK overseas territory'),
	('TD','TCD','Chad','Republic of Chad','','',''),
	('TH','THA','Thailand','Kingdom of Thailand','','',''),
	('TJ','TJK','Tajikistan','Republic of Tajikistan','','',''),
	('TK','TKL','Tokelau','','','NZL','Overseas territory of New Zealand'),
	('TM','TKM','Turkmenistan','','','',''),
	('TL','TLS','Timor-Leste','East Timor','Democratic Republic of Timor-Leste','',''),
	('TO','TON','Tonga','Kingdom of Tonga','','',''),
	('TT','TTO','Trinidad and Toba','Republic of Trinidad and Toba','','',''),
	('TN','TUN','Tunisia','Tunisian Republic','','',''),
	('TR','TUR','Turkey','Republic of Turkey','','',''),
	('TV','TUV','Tuvalu','','','',''),
	('TW','TWN','Taiwan','Taiwan, Province of China','','',''),
	('TZ','TZA','Tanzania, United Republic of','United Republic of Tanzania','','',''),
	('UG','UGA','Uganda','Republic of Uganda','','',''),
	('UA','UKR','Ukraine','','','',''),
	('UM','UMI','United States Minor Outlying Islands','','','USA','US organized territory'),
	('UY','URY','Uruguay','Eastern Republic of Uruguay','','',''),
	('US','USA','United States','United States of America','U.S.A.','',''),
	('UZ','UZB','Uzbekistan','Republic of Uzbekistan','','',''),
	('VA','VAT','Holy See (Vatican City State)','Vatican City State','Holy See','',''),
	('VC','VCT','Saint Vincent and the Grenadines','','','',''),
	('VE','VEN','Venezuela','Bolivarian Republic of Venezuela','','',''),
	('VG','VGB','Virgin Islands, British','British Virgin Islands','','GBR','UK overseas territory'),
	('VI','VIR','Virgin Islands, U.S.','United States Virgin Islands','','USA','US organized territory'),
	('VN','VNM','Viet Nam','Vietnam','Socialist Republic of Vietnam','',''),
	('VU','VUT','Vanuatu','Republic of Vanuatu','','',''),
	('WA','WAL','Wales','','','GBR','UK territory'),
	('WF','WLF','Wallis and Futuna','Territory of Wallis and Futuna Islands','','FRA','French overseas collectivity'),
	('WS','WSM','Samoa','Independent State of Samoa','','',''),
	('YE','YEM','Yemen','Republic of Yemen','','',''),
	('ZA','ZAF','South Africa','Republic of South Africa','','',''),
	('ZM','ZMB','Zambia','Republic of Zambia','','',''),
	('ZW','ZWE','Zimbabwe','Republic of Zimbabwe','','','');
go

INSERT INTO Destinations (DestinationCode, Airport, CountryCode3)
VALUES
	('ADL','Adelaide','AUS'),
	('AMS','Amsterdam','NLD'),
	('ATL','Atlanta','USA'),
	('BKK','Bangkok','THA'),
	('BNE','Brisbane','AUS'),
	('CBR','Canberra','AUS'),
	('CDG','Paris - Charles De Gaulle','FRA'),
	('CNS','Cairns','AUS'),
	('DOH','Doha','QAT'),
	('DRW','Darwin','AUS'),
	('DXB','Dubai','ARE'),
	('FCO','Rome-Fiumicino','ITA'),
	('GIG','Rio De Janeiro','BRA'),
	('HBA','Hobart','AUS'),
	('HEL','Helsinki','FIN'),
	('HKG','Hong Kong','CHN'),
	('HNL','Honolulu','USA'),
	('JFK','New York - JFK','USA'),
	('JNB','Johannesburg','ZAF'),
	('KUL','Kuala Lumpur','MYS'),
	('LAX','Los Angeles','USA'),
	('LGA','New York - Laguardia','USA'),
	('LGW','London-Gatwick','GBR'),
	('LHR','London-Heathrow','GBR'),
	('MAD','Madrid','ESP'),
	('MEL','Melbourne','AUS'),
	('MIA','Miami','USA'),
	('MUC','Munich','DEU'),
	('NRT','Tokyo - Narita','JPN'),
	('OOL','Gold Coast','AUS'),
	('ORD','Chicago - OHare Intl.','USA'),
	('ORY','Paris - Orly','FRA'),
	('PER','Perth','AUS'),
	('SFO','San Francisco','USA'),
	('SIN','Singapore','SGP'),
	('SYD','Sydney','AUS'),
	('VIE','Vienna','AUT'),
	('YYZ','Toronto','CAN');
  go

INSERT INTO Airlines (AirlineCode, AirlineName, CountryCode3)
VALUES
	('AA','American Airlines','USA'),
	('AC','Air Canada','CAN'),
	('AF','Air France','FRA'),
	('AI','Air India','IND'),
	('AM','Air Mexico','MEX'),
	('AR','Aerolineas Argentinas','ARG'),
	('AY','Finnair','FIN'),
	('BA','British Airways','GBR'),
	('CA','Air China','CHN'),
	('CI','China Airlines','CHN'),
	('CO','Continental Airlines','USA'),
	('CX','Cathay Pacific Airways','CHN'),
	('DJ','Virgin Blue','AUS'),
	('DL','Delta Air Lines','USA'),
	('EI','Aer Lingus','IRL'),
	('EK','Qatar Airways','QAT'),
	('IB','Iberia','ESP'),
	('JL','Japan Airlines','JPN'),
	('JQ','Jetstar Airlines','AUS'),
	('KE','Korean Airlines','KOR'),
	('KL','KLM-Royal Dutch Airlines','NLD'),
	('LH','Lufthansa','DEU'),
	('LY','El Al Israel Airlines','ISR'),
	('MH','Malaysia Airlines','MYS'),
	('MS','Egyptair','EGY'),
	('MX','Mexicana de Aviacion','MEX'),
	('NA','North American Airlines','USA'),
	('NW','Northwest Airlines','USA'),
	('NZ','Air New Zealand','NZL'),
	('OS','Austrian Airlines','AUT'),
	('PR','Philippine Airlines','PHL'),
	('QF','Qantas Airways','AUS'),
	('QR','Emirates Airlines','ARE'),
	('RJ','Royal Jordanian','JOR'),
	('SA','South African','ZAF'),
	('SK','SAS-Scandinavian Airlines','SWE'),
	('SQ','Singapore Airlines','SGP'),
	('SU','Aeroflot','RUS'),
	('TG','Thai Airways','THA'),
	('TK','Turkish Airlines','TUR'),
	('TW','Trans World Airlines','USA'),
	('UA','United Airlines','USA'),
	('VH','Aeropostal Alas de Venezuela','VEN'),
	('VS','Virgin Atlantic Airways','GBR');

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

  INSERT INTO TicketClass (ClassCode, Details)
VALUES
	('BUS','Business Class'),
	('ECO','Economy'),
	('FIR','First Class'),
	('PME','Premium Economy');
  go

INSERT INTO TicketType (TicketCode, Name, Transferrable, Refundable, Exchangeable, FrequentFlyerPoints)
VALUES
	('A','Standby','0','0','0','0'),
	('B','Premium Discounted','0','0','0','0'),
	('C','Discounted','0','0','0','1'),
	('D','Standard','0','0','0','1'),
	('E','Premium','1','0','1','1'),
	('F','ld','1','1','1','1'),
	('G','Platinum','1','1','1','1');
  go

	BULK INSERT dbo.Flights
	FROM 'C:\flightPub_database_files\Flights.csv'
	WITH(
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n',  
		FIRSTROW = 2
	);
	GO

	BULK INSERT dbo.Price
	FROM 'C:\flightPub_database_files\Prices.csv'
	WITH(
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n',
		FIRSTROW = 2
	);
	GO

	BULK INSERT dbo.Availability
	FROM 'C:\flightPub_database_files\Availabilities.csv'
	WITH(
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n',
		FIRSTROW = 2
	);
	GO

	INSERT INTO DESTINATIONTAGS (DestinationCode, DestinationTagID, tagID)
	VALUES
		('ADL','00000000','88888888'),
		('ADL','00000001','11111119'),
		('AMS','00000002','11111120'),
		('AMS','00000003','11111115'),
		('AMS','00000004','55555555'),
		('AMS','00000005','66666666'),
		('ATL','00000006','22222222'),
		('ATL','00000007','11111119'),
		('ATL','00000008','11111120'),
		('BKK','00000009','88888888'),
		('BKK','00000010','11111115'),
		('BKK','00000011','11111116'),
		('BKK','00000012','12341234'),
		('BKK','00000013','44444444'),
		('BKK','00000014','11111120'),
		('BNE','00000015','12341234'),
		('BNE','00000016','44444444'),
		('BNE','00000017','55511155'),
		('BNE','00000018','11111113'),
		('CBR','00000019','00000000'),
		('CBR','00000020','11111119'),
		('CDG','00000021','55555555'),
		('CDG','00000022','66666666'),
		('CDG','00000023','11111115'),
		('CDG','00000024','77777777'),
		('CDG','00000025','11111114'),
		('CDG','00000026','11111116'),
		('CDG','00000027','11111119'),
		('CDG','00000028','11111120'),
		('CNS','00000029','11111117'),
		('CNS','00000030','12341234'),
		('CNS','00000031','11111112'),
		('CNS','00000032','11111113'),
		('DOH','00000033','00000001'),
		('DOH','00000034','44444444'),
		('DOH','00000035','55555555'),
		('DOH','00000036','66666666'),
		('DOH','00000037','11111112'),
		('DOH','00000038','11111113'),
		('DOH','00000039','11111115'),
		('DOH','00000040','11111116'),
		('DOH','00000041','11111119'),
		('DRW','00000042','12341234'),
		('DRW','00000043','11111112'),
		('DRW','00000044','11111113'),
		('DXB','00000045','00000001'),
		('DXB','00000046','55555555'),
		('DXB','00000047','66666666'),
		('DXB','00000048','11111113'),
		('DXB','00000049','11111115'),
		('DXB','00000050','11111116'),
		('DXB','00000051','11111119'),
		('FCO','00000052','22222222'),
		('FCO','00000053','66666666'),
		('FCO','00000054','77777777'),
		('FCO','00000055','55511155'),
		('FCO','00000056','11111115'),
		('FCO','00000057','11111116'),
		('FCO','00000058','11111120'),
		('GIG','00000059','12341234'),
		('GIG','00000060','44444444'),
		('GIG','00000061','55555555'),
		('GIG','00000062','66666666'),
		('GIG','00000063','77777777'),
		('GIG','00000064','11111112'),
		('GIG','00000065','11111113'),
		('GIG','00000066','11111115'),
		('GIG','00000067','11111116'),
		('GIG','00000068','11111120'),
		('HBA','00000069','00000000'),
		('HBA','00000225','88888888'),
		('HEL','00000070','11111111'),
		('HEL','00000071','00000000'),
		('HEL','00000072','33333333'),
		('HEL','00000073','11111112'),
		('HEL','00000074','11111112'),
		('HKG','00000075','12341234'),
		('HKG','00000076','55555555'),
		('HKG','00000077','55511155'),
		('HKG','00000078','11111114'),
		('HKG','00000079','11111115'),
		('HKG','00000080','11111116'),
		('HKG','00000081','11111119'),
		('HKG','00000082','11111120'),
		('HNL','00000083','12341234'),
		('HNL','00000084','44444444'),
		('HNL','00000085','55555555'),
		('HNL','00000086','55511155'),
		('HNL','00000087','11111112'),
		('HNL','00000088','11111113'),
		('HNL','00000089','11111114'),
		('HNL','00000090','11111115'),
		('HNL','00000091','11111120'),
		('JFK','00000092','00000000'),
		('JFK','00000093','55555555'),
		('JFK','00000094','77777777'),
		('JFK','00000095','11111115'),
		('JFK','00000096','11111116'),
		('JFK','00000097','11111119'),
		('JFK','00000098','11111120'),
		('JNB','00000099','22222222'),
		('JNB','00000100','44444444'),
		('JNB','00000101','88888888'),
		('JNB','00000102','11111112'),
		('JNB','00000103','11111113'),
		('JNB','00000104','11111113'),
		('KUL','00000105','12341234'),
		('KUL','00000106','55555555'),
		('KUL','00000107','66666666'),
		('KUL','00000108','11111112'),
		('KUL','00000109','11111113'),
		('KUL','00000110','11111116'),
		('KUL','00000111','11111117'),
		('LAX','00000112','22222222'),
		('LAX','00000113','44444444'),
		('LAX','00000114','66666666'),
		('LAX','00000115','11111116'),
		('LAX','00000116','11111119'),
		('LAX','00000117','11111120'),
		('LGA','00000118','00000000'),
		('LGA','00000119','55555555'),
		('LGA','00000120','77777777'),
		('LGA','00000121','11111115'),
		('LGA','00000122','11111116'),
		('LGA','00000123','11111119'),
		('LGA','00000124','11111120'),
		('LGW','00000125','22222222'),
		('LGW','00000126','55555555'),
		('LGW','00000127','66666666'),
		('LGW','00000128','55511155'),
		('LGW','00000129','11111112'),
		('LGW','00000130','11111115'),
		('LGW','00000131','11111116'),
		('LGW','00000132','11111119'),
		('LGW','00000133','11111120'),
		('LGW','00000134','22222222'),
		('LGW','00000135','55555555'),
		('LGW','00000136','66666666'),
		('LGW','00000137','55511155'),
		('LGW','00000138','11111112'),
		('LGW','00000139','11111115'),
		('LGW','00000140','11111116'),
		('LGW','00000141','11111119'),
		('LGW','00000142','11111120'),
		('MAD','00000143','22222222'),
		('MAD','00000144','55555555'),
		('MAD','00000145','66666666'),
		('MAD','00000146','11111115'),
		('MAD','00000147','11111116'),
		('MEL','00000148','00000000'),
		('MEL','00000149','11111119'),
		('LAX','00000150','22222222'),
		('LAX','00000151','44444444'),
		('LAX','00000152','66666666'),
		('LAX','00000153','11111116'),
		('LAX','00000154','11111119'),
		('LAX','00000155','11111120'),
		('MUC','00000156','00000000'),
		('MUC','00000157','55555555'),
		('MUC','00000158','77777777'),
		('MUC','00000159','11111112'),
		('MUC','00000160','11111114'),
		('MUC','00000161','11111115'),
		('MUC','00000162','11111116'),
		('MUC','00000163','11111119'),
		('NRT','00000164','12341234'),
		('NRT','00000165','55555555'),
		('NRT','00000166','55511155'),
		('NRT','00000167','11111114'),
		('NRT','00000168','11111115'),
		('NRT','00000169','11111116'),
		('NRT','00000170','11111119'),
		('NRT','00000171','11111120'),
		('OOL','00000172','12341234'),
		('OOL','00000173','44444444'),
		('OOL','00000174','55511155'),
		('OOL','00000175','11111113'),
		('ORD','00000176','00000000'),
		('ORD','00000177','55555555'),
		('ORD','00000178','77777777'),
		('ORD','00000179','11111112'),
		('ORD','00000180','11111115'),
		('ORD','00000181','11111119'),
		('ORY','00000182','55555555'),
		('ORY','00000183','66666666'),
		('ORY','00000184','11111115'),
		('ORY','00000185','77777777'),
		('ORY','00000186','11111114'),
		('ORY','00000187','11111116'),
		('ORY','00000188','11111119'),
		('ORY','00000189','11111120'),
		('PER','00000190','22222222'),
		('PER','00000191','44444444'),
		('PER','00000192','55555555'),
		('PER','00000193','55511155'),
		('PER','00000194','11111112'),
		('PER','00000195','11111113'),
		('PER','00000196','11111114'),
		('SFO','00000197','22222222'),
		('SFO','00000198','66666666'),
		('SFO','00000199','11111116'),
		('SFO','00000200','11111119'),
		('SIN','00000201','88888888'),
		('SIN','00000202','11111115'),
		('SIN','00000203','11111116'),
		('SIN','00000204','12341234'),
		('SIN','00000205','44444444'),
		('SIN','00000206','11111120'),
		('SYD','00000207','22222222'),
		('SYD','00000208','44444444'),
		('SYD','00000209','55555555'),
		('SYD','00000210','55511155'),
		('SYD','00000211','11111112'),
		('SYD','00000212','11111113'),
		('SYD','00000213','11111114'),
		('VIE','00000214','00000000'),
		('VIE','00000215','55555555'),
		('VIE','00000216','11111112'),
		('VIE','00000217','11111115'),
		('YYZ','00000218','00000000'),
		('YYZ','00000219','33333333'),
		('YYZ','00000220','66666666'),
		('YYZ','00000221','11111111'),
		('YYZ','00000222','55511155'),
		('YYZ','00000223','11111119'),
		('YYZ','00000224','11111115');



