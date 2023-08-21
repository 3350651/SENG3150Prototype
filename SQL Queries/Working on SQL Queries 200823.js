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

DROP TABLE IF EXISTS CALENDAR;
go
DROP TABLE IF EXISTS USERGROUPS;
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
DROP TABLE IF EXISTS MESSAGE;
go
DROP TABLE IF EXISTS POOLDEPOSIT;
go
DROP TABLE IF EXISTS MEMBERFLIGHTVOTE;
go
DROP TABLE IF EXISTS GROUPFAVEFLIGHT;
go
DROP TABLE IF EXISTS CHAT;
go
DROP TABLE IF EXISTS GROUPS;
go
DROP TABLE IF EXISTS POOL;
go
DROP TABLE IF EXISTS USERBOOKMARKEDFLIGHTS
go
DROP TABLE IF EXISTS USERSAVEDSEARCHES
go
DROP TABLE IF EXISTS Flights;
go
DROP TABLE IF EXISTS Price;
go
DROP TABLE IF EXISTS Distances;
go
DROP TABLE IF EXISTS Availability;
go
DROP TABLE IF EXISTS Destinations;
go
DROP TABLE IF EXISTS PlaneType;
go
DROP TABLE IF EXISTS TICKETS;
go
DROP TABLE IF EXISTS PASSENGERS;
go
DROP TABLE IF EXISTS BOOKINGS;
go
DROP TABLE IF EXISTS TicketType;
go
DROP TABLE IF EXISTS TicketClass;
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


CREATE TABLE BOOKMARKEDFLIGHT(
    flightPathID CHAR(8) NOT NULL,
    userID CHAR(8) NOT NULL,
    FOREIGN KEY (userID) REFERENCES USERS (userID),
    FOREIGN KEY (flightPathID) REFERENCES FLIGHTPATH (flightPathID)
)
GO

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
    FlexibleDays INT,
    AdultPassengers INT,
    ChildPassengers INT,
    userID CHAR(8) NOT NULL FOREIGN KEY REFERENCES USERS (userID),
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

INSERT INTO TAGS (tagID, tagName, [DESCRIPTION])
VALUES
('0001', 'Tropical', 'This destination has sunny, hot weather.'),
    ('0002', 'Snowy', 'This destinnation contains snowy weather.'),
    ('0003', 'Northern Hemisphere',  'This destination is located in the Northern Hemisphere'),
    ('0004', 'Southern Hemisphere',  'This destination is located in the Southern Hemisphere'),
    ('0005', 'Family',  'This destination is great for family trips!'),
    ('0006', 'Festivals',  'This destinantion has festivals.'),
    ('0007', 'Sightseeing',  'This destination has great locations for sightseeing!'),
    ('0008', 'Food & Drink',  'This destination is famous for resturants and dining.'),
    ('0009', 'Landmarks',  'This destination has many unique landmarks.'),
    ('0010', 'Snowsports',  'This destination is great for snowsports'),
    ('0011', 'Watersports',  'This destination is great for watersports.'),
    ('0012', 'Beaches',  'This destination has fantastic beaches.'),
    ('0013', 'Summer',  'It is currently summer in this destination.'),
    ('0014', 'Autumn',  'It is currently autumn in this destination.'),
    ('0015', 'Winter',  'It is currently winter in this destination.'),
    ('0016', 'Spring',  'It is currently spring in this destination.'),
    ('0017', 'Camping',  'This destination is great for camping.'),
    ('0018', 'Outdoors',  'This destination is great for bush-walking, parks and forests.'),
    ('0019', 'Relaxation',  'This destination is great for rest and relaxation.'),
    ('0020', 'City',  'This destination contains large city areas.'),
    ('0021', 'Cruises',  'This destination contains boat cruises.'),
    ('0022', 'Public Transport',  'This destination has great public transport.'),
    ('0023', 'Tours',  'This destination is great for tourist tours.'),
    ('0024', 'Attractions',  'This destination contains many attractions for tourists.'),
    ('0025', 'Culture',  'This destination is great for exploring culture.'),
    ('0026', 'Art',  'This destination contains many art museums.'),
    ('0027', 'Shopping',  'This destination is great for shopping.'),
    ('0028', 'Sports',  'This destination is great watching or playing sports.'),
    ('0029', 'History',  'This destination is great for learning about history.'),
    ('0030', 'Budget',  'This destination is great for budget flights.');
go

SELECT * FROM FLIGHTS WHERE DepartureCode='JFK'
SELECT * FROM FLIGHTS WHERE StopOverCode='JFK'
SELECT * FROM FLIGHTS WHERE DestinationCode='JFK'
SELECT * FROM FLIGHTS WHERE DepartureCode='LAX'

INSERT INTO DESTINATIONTAGS (DestinationTagID, DestinationCode, tagID)
VALUES
('0001', 'ADL', '0020'),
    ('0002', 'ADL', '0026'),
    ('0003', 'ADL', '0008'),
    ('0004', 'ADL', '0022'),
    ('0005', 'ADL', '0026'),
    ('0006', 'AMS', '0019'),
    ('0007', 'AMS', '0023'),
    ('0008', 'AMS', '0025'),
    ('0009', 'AMS', '0008'),
    ('0010', 'AMS', '0006'),
    ('0012', 'ATL', '0028'),
    ('0013', 'ATL', '0029'),
    ('0014', 'ATL', '0009'),
    ('0015', 'ATL', '0008'),
    ('0016', 'BKK', '0025'),
    ('0017', 'BKK', '0020'),
    ('0018', 'BKK', '0006'),
    ('0019', 'BKK', '0024'),
    ('0020', 'BKK', '0008'),
    ('0021', 'BNE', '0008'),
    ('0022', 'BNE', '0009'),
    ('0023', 'BNE', '0012'),
    ('0024', 'BNE', '0019'),
    ('0025', 'BNE', '0024'),
    ('0026', 'CBR', '0007'),
    ('0027', 'CBR', '0005'),
    ('0028', 'CBR', '0010'),
    ('0029', 'CBR', '0020'),
    ('0030', 'CBR', '0009'),
    ('0031', 'CDG', '0008'),
    ('0032', 'CDG', '0007'),
    ('0033', 'CDG', '0009'),
    ('0034', 'CDG', '0020'),
    ('0035', 'CDG', '0026'),
    ('0036', 'CNS', '0001'),
    ('0037', 'CNS', '0025'),
    ('0038', 'CNS', '0012'),
    ('0039', 'CNS', '0019'),
    ('0040', 'CNS', '0020'),
    ('0041', 'DOH', '0008'),
    ('0042', 'DOH', '0020'),
    ('0043', 'DOH', '0025'),
    ('0045', 'DOH', '0023'),
    ('0046', 'DRW', '0029'),
    ('0047', 'DRW', '0017'),
    ('0048', 'DRW', '0018'),
    ('0049', 'DRW', '0019'),
    ('0050', 'DRW', '0004'),
    ('0051', 'DXB', '0027'),
    ('0052', 'DXB', '0020'),
    ('0053', 'DXB', '0001'),
    ('0054', 'DXB', '0013'),
    ('0055', 'DXB', '0024'),
    ('0056', 'FCO', '0008'),
    ('0057', 'FCO', '0029'),
    ('0058', 'FCO', '0020'),
    ('0059', 'FCO', '0009'),
    ('0060', 'FCO', '0005'),
    ('0061', 'GIG', '0025'),
    ('0062', 'GIG', '0028'),
    ('0063', 'GIG', '0009'),
    ('0064', 'GIG', '0003'),
    ('0065', 'GIG', '0020'),
    ('0066', 'HBA', '0020'),
    ('0067', 'HBA', '0008'),
    ('0068', 'HBA', '0007'),
    ('0069', 'HBA', '0017'),
    ('0070', 'HBA', '0018'),
    ('0071', 'HEL', '0018'),
    ('0072', 'HEL', '0025'),
    ('0073', 'HEL', '0029'),
    ('0074', 'HEL', '0012'),
    ('0075', 'HEL', '0008'),
    ('0076', 'HKG', '0006'),
    ('0077', 'HKG', '0027'),
    ('0078', 'HKG', '0008'),
    ('0079', 'HKG', '0005'),
    ('0080', 'HKG', '0007'),
    ('0081', 'HNL', '0001'),
    ('0082', 'HNL', '0005'),
    ('0083', 'HNL', '0011'),
    ('0084', 'HNL', '0012'),
    ('0085', 'HNL', '0019'),
    ('0086', 'JFK', '0020'),
    ('0087', 'JFK', '0021'),
    ('0088', 'JFK', '0007'),
    ('0089', 'JFK', '0008'),
    ('0090', 'JFK', '0009'),
    ('0091', 'JNB', '0029'),
    ('0092', 'JNB', '0024'),
    ('0093', 'JNB', '0009'),
    ('0094', 'JNB', '0005'),
    ('0095', 'JNB', '0004'),
    ('0096', 'KUL', '0005'),
    ('0097', 'KUL', '0009'),
    ('0098', 'KUL', '0022'),
    ('0099', 'KUL', '0027'),
    ('0100', 'KUL', '0008'),
    ('0101', 'LAX', '0020'),
    ('0102', 'LAX', '0007'),
    ('0103', 'LAX', '0010'),
('0104', 'LAX', '0023'),
('0105', 'LAX', '0024'),
('0106', 'LGA', '0020'),
('0107', 'LGA', '0021'),
('0108', 'LGA', '0007'),
('0109', 'LGA', '0008'),
('0110', 'LGA', '0009'),
('0111', 'LGW', '0029'),
('0112', 'LGW', '0020'),
('0113', 'LGW', '0022'),
('0114', 'LGW', '0005'),
('0115', 'LGW', '0023'),
('0116', 'LHR', '0029'),
('0117', 'LHR', '0020'),
('0118', 'LHR', '0022'),
('0119', 'LHR', '0005'),
('0120', 'LHR', '0023'),
('0121', 'MAD', '0029'),
('0122', 'MAD', '0026'),
('0123', 'MAD', '0008'),
('0124', 'MAD', '0003'),
('0125', 'MAD', '0025'),
('0126', 'MEL', '0005'),
('0127', 'MEL', '0008'),
('0128', 'MEL', '0020'),
('0129', 'MEL', '0027'),
('0130', 'MEL', '0009'),
('0131', 'MIA', '0001'),
('0132', 'MIA', '0012'),
('0133', 'MIA', '0020'),
('0134', 'MIA', '0023'),
('0135', 'MIA', '0007'),
('0136', 'MUC', '0029'),
('0137', 'MUC', '0008'),
('0138', 'MUC', '0020'),
('0139', 'MUC', '0023'),
('0140', 'MUC', '0025'),
('0141', 'NRT', '0029'),
('0142', 'NRT', '0025'),
('0143', 'NRT', '0007'),
('0144', 'NRT', '0008'),
('0145', 'NRT', '0019'),
('0146', 'OOL', '0001'),
('0147', 'OOL', '0011'),
('0148', 'OOL', '0012'),
('0149', 'OOL', '0005'),
('0150', 'OOL', '0020'),
('0151', 'ORD', '0008'),
('0152', 'ORD', '0007'),
('0153', 'ORD', '0023'),
('0154', 'ORD', '0025'),
('0155', 'ORD', '0027'),
('0156', 'ORY', '0008'),
('0157', 'ORY', '0029'),
('0158', 'ORY', '0026'),
('0159', 'ORY', '0009'),
('0160', 'ORY', '0007'),
('0161', 'PER', '0005'),
('0162', 'PER', '0020'),
('0163', 'PER', '0027'),
('0164', 'PER', '0018'),
('0165', 'PER', '0001'),
('0166', 'SFO', '0020'),
('0167', 'SFO', '0007'),
('0168', 'SFO', '0009'),
('0169', 'SFO', '0024'),
('0170', 'SFO', '0029'),
('0171', 'SIN', '0007'),
('0172', 'SIN', '0022'),
('0173', 'SIN', '0025'),
('0174', 'SIN', '0009'),
('0175', 'SIN', '0005'),
('0176', 'SYD', '0012'),
('0177', 'SYD', '0022'),
('0178', 'SYD', '0027'),
('0179', 'SYD', '0008'),
('0180', 'SYD', '0005'),
('0181', 'VIE', '0025'),
('0182', 'VIE', '0009'),
('0183', 'VIE', '0008'),
('0184', 'VIE', '0005'),
('0185', 'VIE', '0019'),
('0186', 'YYZ', '0007'),
('0187', 'YYZ', '0005'),
('0188', 'YYZ', '0010'),
('0189', 'YYZ', '0020'),
('0190', 'YYZ', '0003');
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

SELECT gf.*, fpf.*, fp.*
FROM GROUPFAVEFLIGHT gf
JOIN FLIGHTPATH fp ON gf.flightPathID = fp.flightPathID
JOIN FLIGHTPATHFLIGHT fpf ON fp.flightPathID = fpf.flightPathID;

SELECT bf.*, fpf.*, fp.*, f.DepartureCode, f.StopOverCode, f.DestinationCode
FROM GROUPFAVEFLIGHT bf
JOIN FLIGHTPATH fp ON bf.flightPathID = fp.flightPathID
JOIN FLIGHTPATHFLIGHT fpf ON fp.flightPathID = fpf.flightPathID
JOIN FLIGHTS f ON f.AirlineCode = fpf.AirlineCode
AND f.FlightNumber = fpf.FlightNumber
AND f.DepartureTime = fpf.DepartureTime
GROUP BY bf.flightPathID;

SELECT bf.*, fpf.*, fp.*
FROM BOOKMARKEDFLIGHT bf
JOIN FLIGHTPATH fp ON bf.flightPathID = fp.flightPathID
JOIN FLIGHTPATHFLIGHT fpf ON fp.flightPathID = fpf.flightPathID;

SELECT bf.*, fpf.*, fp.*, f.DepartureCode, f.StopOverCode, f.DestinationCode
FROM BOOKMARKEDFLIGHT bf
JOIN FLIGHTPATH fp ON bf.flightPathID = fp.flightPathID
JOIN FLIGHTPATHFLIGHT fpf ON fp.flightPathID = fpf.flightPathID
JOIN FLIGHTS f ON f.AirlineCode = fpf.AirlineCode
AND f.FlightNumber = fpf.FlightNumber
AND f.DepartureTime = fpf.DepartureTime
GROUP BY bf.flightPathID
ORDER BY f.DepartureTime;

SELECT * FROM FLIGHTPATHFLIGHT;

SELECT * FROM Flights WHERE AirlineCode='DL' AND FlightNumber='DL8' AND DepartureTime='2014-12-25 13:03:00.000';