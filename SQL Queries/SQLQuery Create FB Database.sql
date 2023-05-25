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
DROP TABLE IF EXISTS TICKETS;
DROP TABLE IF EXISTS PASSENGERS;
DROP TABLE IF EXISTS BOOKINGS;
DROP TABLE IF EXISTS USERGROUPS;
DROP TABLE IF EXISTS GROUPS;
DROP TABLE IF EXISTS USERTAGS;
DROP TABLE IF EXISTS TAGS;
DROP TABLE IF EXISTS MESSAGE;
DROP TABLE IF EXISTS CHAT;
DROP TABLE IF EXISTS POOLDEPOSIT;
DROP TABLE IF EXISTS POOL;
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
	questionnaireCompleted	VARCHAR(8),
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

CREATE TABLE CHAT
(
	chatID		CHAR(8) PRIMARY KEY,
)


CREATE TABLE MESSAGE
(
	messageID CHAR(8) PRIMARY KEY,
	chatID CHAR(8) FOREIGN KEY REFERENCES CHAT(chatID),
	message VARCHAR(MAX),
	messageTime VARCHAR(20),
	userID CHAR(8) FOREIGN KEY REFERENCES USERS(userID),
)

CREATE TABLE POOL
(
	poolID CHAR(8) PRIMARY KEY,
	totalAmount	FLOAT,
	amountRemaining FLOAT,
)

CREATE TABLE POOLDEPOSIT
(
	poolDepositID CHAR(8) PRIMARY KEY,
	poolID CHAR(8) FOREIGN KEY REFERENCES POOL(poolID),
	userID CHAR(8) FOREIGN KEY REFERENCES USERS(userID),
	amount FLOAT,
)

DROP TABLE IF EXISTS GROUPS;

CREATE TABLE GROUPS
(
	groupID 	CHAR(8) PRIMARY KEY,
	groupName		VARCHAR(20),
	chatID	CHAR(8) FOREIGN KEY REFERENCES CHAT(chatID),
	poolID 	CHAR(8) FOREIGN KEY REFERENCES POOL(poolID),
	-- faveListID

)
CREATE TABLE USERGROUPS
(
	userGroupsID		CHAR(8) PRIMARY KEY,
	userID	CHAR(8) FOREIGN KEY REFERENCES USERS(userID),
	groupID CHAR(8) FOREIGN KEY REFERENCES GROUPS(groupID),
	isAdmin		INT DEFAULT(0),
)

CREATE TABLE BOOKINGS
(
  BookingId CHAR(8) NOT NULL PRIMARY KEY,
  BookingUserId CHAR(8) NOT NULL FOREIGN KEY REFERENCES USERS(userID),
  DepartureAirlineCode CHAR(2) NOT NULL FOREIGN KEY REFERENCES Airlines(AirlineCode),
  DepartureFlightNumber VARCHAR(6) NOT NULL,
  DepartureTime DATETIME NOT NULL,
  ReturnAirlineCode CHAR(2) NULL,
  ReturnFlightNumber VARCHAR(6) NULL,
  ReturnTime DATETIME NULL,
  TotalAmount DECIMAL(10,2) NULL,
  Progress BIT NOT NULL
)

CREATE TABLE PASSENGERS
(
  PassengerId CHAR(8) NOT NULL PRIMARY KEY,
  LastName VARCHAR(MAX) NOT NULL,
  GivenNames VARCHAR(MAX) NOT NULL,
  Email VARCHAR(MAX) NULL,
  PhoneNumber VARCHAR(20) NULL,
  DateOfBirth DATE NOT NULL,
  BookingId CHAR(8) NOT NULL FOREIGN KEY REFERENCES BOOKINGS(BookingId)
)

CREATE TABLE TICKETS
(
  TicketId CHAR(8) NOT NULL PRIMARY KEY,
  BookingId CHAR(8) NOT NULL FOREIGN KEY REFERENCES BOOKINGS(BookingId),
  PassengerId CHAR(8) NOT NULL FOREIGN KEY REFERENCES PASSENGERS(PassengerId),
  AirlineCode CHAR(2) NOT NULL FOREIGN KEY REFERENCES Airlines(AirlineCode),
  FlightNumber VARCHAR(6) NOT NULL,
  DepartureTime DATETIME NOT NULL,
  TicketClass CHAR(3) NOT NULL FOREIGN KEY REFERENCES TicketClass(ClassCode),
  TicketType CHAR(1) NOT NULL FOREIGN KEY REFERENCES TicketType(TicketCode)
)

go

INSERT INTO USERS VALUES ('01010101', 'Lachlan', 'ONeill', 'lachlan@gmail.com', 'lo', '04 123 456', 'user', '12 Main St, Carrington, NSW, Australia', 'Simple', 'AUD', '+10', 'Light', 0, '1997-08-29')
INSERT INTO USERS VALUES ('11112222', 'Jordan', 'Eade', 'jordan@gmail.com', 'je', '04 454 678', 'user', '45 Smith St, Brisbane, QLD, Australia', 'Simple', 'AUD', '+10', 'Light', 1, '2003-07-14');
INSERT INTO USERS VALUES ('98765432', 'Lucy', 'Knight', 'lucy@gmail.com', 'lk', '04 474 235', 'user', '87 George St, Adelaide, SA, Australia', 'Stripe', 'AUD', '+10', 'Dark', 0, '2004-03-21');
INSERT INTO USERS VALUES ('12345678', 'Blake', 'Baldin', 'blake@gmail.com', 'bb', '04 123 456', 'user', '39 High St, Melbourne, VIC, Australia', 'Recommend', 'AUD', '+10', 'Dark', 0, '2002-10-06')
go

CREATE TABLE TAGS
(
	tagID		CHAR(8) PRIMARY KEY,
	tagName		VARCHAR(20),
	DESCRIPTION	VARCHAR(100)
)

CREATE TABLE USERTAGS
(
	userTagsID	CHAR(8) PRIMARY KEY,
	tagID 		CHAR(8) FOREIGN KEY REFERENCES TAGS(tagID),
	userID		CHAR(8) FOREIGN KEY REFERENCES USERS(userID)
)

INSERT INTO TAGS VALUES('12341234', 'Tropical', 'Sunny, tropical locations with coastal resorts.')
INSERT INTO TAGS VALUES('11111111', 'Snowy', 'Snowy, cold, mountains, good for skiing.')
INSERT INTO TAGS VALUES('22222222', 'Budget', 'Cheap flights.')
INSERT INTO TAGS VALUES('55511155', 'Family', 'Flight suitable for family groups.')
SELECT * FROM USERTAGS;


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

INSERT INTO TicketType (TicketCode, Name, Transferrable, Refundable, Exchangeable, FrequentFlyerPoints)
VALUES
	('A','Standby','0','0','0','0'),
	('B','Premium Discounted','0','0','0','0'),
	('C','Discounted','0','0','0','1'),
	('D','Standard','0','0','0','1'),
	('E','Premium','1','0','1','1'),
	('F','ld','1','1','1','1'),
	('G','Platinum','1','1','1','1');

  INSERT INTO Availability (AirlineCode, FlightNumber, DepartureTime, ClassCode, TicketCode, NumberAvailableSeatsLeg1, NumberAvailableSeatsLeg2)
VALUES
	('AA','AA1735','2014-09-23 09:50:00','BUS','B',17,18),
	('AA','AA1735','2014-09-23 09:50:00','BUS','D',18,0),
	('AA','AA1735','2014-09-23 09:50:00','ECO','A',8,0),
	('AA','AA1735','2014-09-23 09:50:00','ECO','F',2,0),
	('AA','AA1735','2014-09-23 09:50:00','FIR','B',6,0),
	('AA','AA1735','2014-09-23 09:50:00','FIR','G',10,10),
	('AA','AA1735','2014-09-23 09:50:00','PME','B',0,18),
	('AA','AA1735','2014-09-23 09:50:00','PME','E',16,6);

	INSERT INTO Flights (AirlineCode, FlightNumber, DepartureCode, StopOverCode, DestinationCode, DepartureTime, ArrivalTimeStopOver, DepartureTimeStopOver, ArrivalTime, PlaneCode, Duration, DurationSecondLeg)
VALUES
	('AA','AA1735','ATL','MIA','GIG','2014-09-23 09:50:00','2014-09-23 11:50:00','2014-09-23 23:20:00','2014-09-24 09:00:00','A380',120,520);

  INSERT INTO Price (AirlineCode, FlightNumber, ClassCode, TicketCode, StartDate, EndDate, Price, PriceLeg1, PriceLeg2)
VALUES
	('AA','AA1735','BUS','A','2014-09-10 00:00:00','2014-11-19 00:00:00',2831.78,2445.56,1015.33),
	('AA','AA1735','BUS','A','2014-11-20 00:00:00','2014-12-17 00:00:00',3192.88,2757.41,1144.81),
	('AA','AA1735','BUS','A','2014-12-18 00:00:00','2015-01-04 00:00:00',3439.95,2970.78,1233.39),
	('AA','AA1735','BUS','A','2015-01-05 00:00:00','2015-03-25 00:00:00',2736.76,2363.49,981.26),
	('AA','AA1735','BUS','A','2015-03-26 00:00:00','2015-06-25 00:00:00',2318.64,2002.40,831.35),
	('AA','AA1735','BUS','A','2015-06-26 00:00:00','2015-09-09 00:00:00',1900.52,1641.31,681.43),
	('AA','AA1735','BUS','A','2015-09-10 00:00:00','2015-11-19 00:00:00',2831.78,2445.56,1015.33),
	('AA','AA1735','BUS','A','2015-11-20 00:00:00','2015-12-17 00:00:00',3192.88,2757.41,1144.81),
	('AA','AA1735','BUS','A','2015-12-18 00:00:00','2016-01-04 00:00:00',3439.95,2970.78,1233.39),
	('AA','AA1735','BUS','B','2014-09-10 00:00:00','2014-11-19 00:00:00',2916.73,2518.93,1045.79),
	('AA','AA1735','BUS','B','2014-11-20 00:00:00','2014-12-17 00:00:00',3288.67,2840.13,1179.15),
	('AA','AA1735','BUS','B','2014-12-18 00:00:00','2015-01-04 00:00:00',3543.15,3059.90,1270.39),
	('AA','AA1735','BUS','B','2015-01-05 00:00:00','2015-03-25 00:00:00',2818.86,2434.40,1010.70),
	('AA','AA1735','BUS','B','2015-03-26 00:00:00','2015-06-25 00:00:00',2388.20,2062.48,856.29),
	('AA','AA1735','BUS','B','2015-06-26 00:00:00','2015-09-09 00:00:00',1957.54,1690.55,701.88),
	('AA','AA1735','BUS','B','2015-09-10 00:00:00','2015-11-19 00:00:00',2916.73,2518.93,1045.79),
	('AA','AA1735','BUS','B','2015-11-20 00:00:00','2015-12-17 00:00:00',3288.67,2840.13,1179.15),
	('AA','AA1735','BUS','B','2015-12-18 00:00:00','2016-01-04 00:00:00',3543.15,3059.90,1270.39),
	('AA','AA1735','BUS','C','2014-09-10 00:00:00','2014-11-19 00:00:00',3030.01,2616.75,1086.41),
	('AA','AA1735','BUS','C','2014-11-20 00:00:00','2014-12-17 00:00:00',3416.38,2950.43,1224.94),
	('AA','AA1735','BUS','C','2014-12-18 00:00:00','2015-01-04 00:00:00',3680.75,3178.73,1319.73),
	('AA','AA1735','BUS','C','2015-01-05 00:00:00','2015-03-25 00:00:00',2928.33,2528.94,1049.95),
	('AA','AA1735','BUS','C','2015-03-26 00:00:00','2015-06-25 00:00:00',2480.94,2142.57,889.54),
	('AA','AA1735','BUS','C','2015-06-26 00:00:00','2015-09-09 00:00:00',2033.56,1756.21,729.13),
	('AA','AA1735','BUS','C','2015-09-10 00:00:00','2015-11-19 00:00:00',3030.01,2616.75,1086.41),
	('AA','AA1735','BUS','C','2015-11-20 00:00:00','2015-12-17 00:00:00',3416.38,2950.43,1224.94),
	('AA','AA1735','BUS','C','2015-12-18 00:00:00','2016-01-04 00:00:00',3680.75,3178.73,1319.73),
	('AA','AA1735','BUS','D','2014-09-10 00:00:00','2014-11-19 00:00:00',3086.64,2665.66,1106.71),
	('AA','AA1735','BUS','D','2014-11-20 00:00:00','2014-12-17 00:00:00',3480.24,3005.58,1247.84),
	('AA','AA1735','BUS','D','2014-12-18 00:00:00','2015-01-04 00:00:00',3749.54,3238.15,1344.40),
	('AA','AA1735','BUS','D','2015-01-05 00:00:00','2015-03-25 00:00:00',2983.06,2576.21,1069.58),
	('AA','AA1735','BUS','D','2015-03-26 00:00:00','2015-06-25 00:00:00',2527.32,2182.62,906.17),
	('AA','AA1735','BUS','D','2015-06-26 00:00:00','2015-09-09 00:00:00',2071.57,1789.03,742.76),
	('AA','AA1735','BUS','D','2015-09-10 00:00:00','2015-11-19 00:00:00',3086.64,2665.66,1106.71),
	('AA','AA1735','BUS','D','2015-11-20 00:00:00','2015-12-17 00:00:00',3480.24,3005.58,1247.84),
	('AA','AA1735','BUS','D','2015-12-18 00:00:00','2016-01-04 00:00:00',3749.54,3238.15,1344.40),
	('AA','AA1735','BUS','E','2014-09-10 00:00:00','2014-11-19 00:00:00',3199.91,2763.48,1147.33),
	('AA','AA1735','BUS','E','2014-11-20 00:00:00','2014-12-17 00:00:00',3607.96,3115.87,1293.63),
	('AA','AA1735','BUS','E','2014-12-18 00:00:00','2015-01-04 00:00:00',3887.14,3356.98,1393.73),
	('AA','AA1735','BUS','E','2015-01-05 00:00:00','2015-03-25 00:00:00',3092.53,2670.75,1108.83),
	('AA','AA1735','BUS','E','2015-03-26 00:00:00','2015-06-25 00:00:00',2620.06,2262.72,939.42),
	('AA','AA1735','BUS','E','2015-06-26 00:00:00','2015-09-09 00:00:00',2147.59,1854.69,770.02),
	('AA','AA1735','BUS','E','2015-09-10 00:00:00','2015-11-19 00:00:00',3199.91,2763.48,1147.33),
	('AA','AA1735','BUS','E','2015-11-20 00:00:00','2015-12-17 00:00:00',3607.96,3115.87,1293.63),
	('AA','AA1735','BUS','E','2015-12-18 00:00:00','2016-01-04 00:00:00',3887.14,3356.98,1393.73),
	('AA','AA1735','BUS','F','2014-09-10 00:00:00','2014-11-19 00:00:00',3256.55,2812.39,1167.63),
	('AA','AA1735','BUS','F','2014-11-20 00:00:00','2014-12-17 00:00:00',3671.81,3171.02,1316.53),
	('AA','AA1735','BUS','F','2014-12-18 00:00:00','2015-01-04 00:00:00',3955.94,3416.40,1418.40),
	('AA','AA1735','BUS','F','2015-01-05 00:00:00','2015-03-25 00:00:00',3147.27,2718.02,1128.45),
	('AA','AA1735','BUS','F','2015-03-26 00:00:00','2015-06-25 00:00:00',2666.44,2302.76,956.05),
	('AA','AA1735','BUS','F','2015-06-26 00:00:00','2015-09-09 00:00:00',2185.60,1887.51,783.65),
	('AA','AA1735','BUS','F','2015-09-10 00:00:00','2015-11-19 00:00:00',3256.55,2812.39,1167.63),
	('AA','AA1735','BUS','F','2015-11-20 00:00:00','2015-12-17 00:00:00',3671.81,3171.02,1316.53),
	('AA','AA1735','BUS','F','2015-12-18 00:00:00','2016-01-04 00:00:00',3955.94,3416.40,1418.40),
	('AA','AA1735','BUS','G','2014-09-10 00:00:00','2014-11-19 00:00:00',3341.50,2885.76,1198.09),
	('AA','AA1735','BUS','G','2014-11-20 00:00:00','2014-12-17 00:00:00',3767.60,3253.74,1350.87),
	('AA','AA1735','BUS','G','2014-12-18 00:00:00','2015-01-04 00:00:00',4059.14,3505.52,1455.40),
	('AA','AA1735','BUS','G','2015-01-05 00:00:00','2015-03-25 00:00:00',3229.37,2788.92,1157.89),
	('AA','AA1735','BUS','G','2015-03-26 00:00:00','2015-06-25 00:00:00',2736.00,2362.84,980.99),
	('AA','AA1735','BUS','G','2015-06-26 00:00:00','2015-09-09 00:00:00',2242.62,1936.75,804.09),
	('AA','AA1735','BUS','G','2015-09-10 00:00:00','2015-11-19 00:00:00',3341.50,2885.76,1198.09),
	('AA','AA1735','BUS','G','2015-11-20 00:00:00','2015-12-17 00:00:00',3767.60,3253.74,1350.87),
	('AA','AA1735','BUS','G','2015-12-18 00:00:00','2016-01-04 00:00:00',4059.14,3505.52,1455.40),
	('AA','AA1735','ECO','A','2014-09-10 00:00:00','2014-11-19 00:00:00',1758.87,1518.98,630.64),
	('AA','AA1735','ECO','A','2014-11-20 00:00:00','2014-12-17 00:00:00',1983.16,1712.68,711.06),
	('AA','AA1735','ECO','A','2014-12-18 00:00:00','2015-01-04 00:00:00',2136.61,1845.20,766.08),
	('AA','AA1735','ECO','A','2015-01-05 00:00:00','2015-03-25 00:00:00',1699.85,1468.01,609.48),
	('AA','AA1735','ECO','A','2015-03-26 00:00:00','2015-06-25 00:00:00',1440.15,1243.73,516.37),
	('AA','AA1735','ECO','A','2015-06-26 00:00:00','2015-09-09 00:00:00',1180.45,1019.45,423.25),
	('AA','AA1735','ECO','A','2015-09-10 00:00:00','2015-11-19 00:00:00',1758.87,1518.98,630.64),
	('AA','AA1735','ECO','A','2015-11-20 00:00:00','2015-12-17 00:00:00',1983.16,1712.68,711.06),
	('AA','AA1735','ECO','A','2015-12-18 00:00:00','2016-01-04 00:00:00',2136.61,1845.20,766.08),
	('AA','AA1735','ECO','B','2014-09-10 00:00:00','2014-11-19 00:00:00',1811.64,1564.55,649.56),
	('AA','AA1735','ECO','B','2014-11-20 00:00:00','2014-12-17 00:00:00',2042.65,1764.06,732.39),
	('AA','AA1735','ECO','B','2014-12-18 00:00:00','2015-01-04 00:00:00',2200.71,1900.56,789.06),
	('AA','AA1735','ECO','B','2015-01-05 00:00:00','2015-03-25 00:00:00',1750.84,1512.05,627.76),
	('AA','AA1735','ECO','B','2015-03-26 00:00:00','2015-06-25 00:00:00',1483.35,1281.04,531.86),
	('AA','AA1735','ECO','B','2015-06-26 00:00:00','2015-09-09 00:00:00',1215.86,1050.03,435.95),
	('AA','AA1735','ECO','B','2015-09-10 00:00:00','2015-11-19 00:00:00',1811.64,1564.55,649.56),
	('AA','AA1735','ECO','B','2015-11-20 00:00:00','2015-12-17 00:00:00',2042.65,1764.06,732.39),
	('AA','AA1735','ECO','B','2015-12-18 00:00:00','2016-01-04 00:00:00',2200.71,1900.56,789.06),
	('AA','AA1735','ECO','C','2014-09-10 00:00:00','2014-11-19 00:00:00',1881.99,1625.31,674.79),
	('AA','AA1735','ECO','C','2014-11-20 00:00:00','2014-12-17 00:00:00',2121.98,1832.56,760.83),
	('AA','AA1735','ECO','C','2014-12-18 00:00:00','2015-01-04 00:00:00',2286.18,1974.37,819.71),
	('AA','AA1735','ECO','C','2015-01-05 00:00:00','2015-03-25 00:00:00',1818.84,1570.77,652.14),
	('AA','AA1735','ECO','C','2015-03-26 00:00:00','2015-06-25 00:00:00',1540.96,1330.79,552.51),
	('AA','AA1735','ECO','C','2015-06-26 00:00:00','2015-09-09 00:00:00',1263.08,1090.81,452.88),
	('AA','AA1735','ECO','C','2015-09-10 00:00:00','2015-11-19 00:00:00',1881.99,1625.31,674.79),
	('AA','AA1735','ECO','C','2015-11-20 00:00:00','2015-12-17 00:00:00',2121.98,1832.56,760.83),
	('AA','AA1735','ECO','C','2015-12-18 00:00:00','2016-01-04 00:00:00',2286.18,1974.37,819.71),
	('AA','AA1735','ECO','D','2014-09-10 00:00:00','2014-11-19 00:00:00',1917.17,1655.69,687.40),
	('AA','AA1735','ECO','D','2014-11-20 00:00:00','2014-12-17 00:00:00',2161.64,1866.82,775.06),
	('AA','AA1735','ECO','D','2014-12-18 00:00:00','2015-01-04 00:00:00',2328.91,2011.27,835.03),
	('AA','AA1735','ECO','D','2015-01-05 00:00:00','2015-03-25 00:00:00',1852.83,1600.13,664.33),
	('AA','AA1735','ECO','D','2015-03-26 00:00:00','2015-06-25 00:00:00',1569.76,1355.66,562.84),
	('AA','AA1735','ECO','D','2015-06-26 00:00:00','2015-09-09 00:00:00',1286.69,1111.20,461.34),
	('AA','AA1735','ECO','D','2015-09-10 00:00:00','2015-11-19 00:00:00',1917.17,1655.69,687.40),
	('AA','AA1735','ECO','D','2015-11-20 00:00:00','2015-12-17 00:00:00',2161.64,1866.82,775.06),
	('AA','AA1735','ECO','D','2015-12-18 00:00:00','2016-01-04 00:00:00',2328.91,2011.27,835.03),
	('AA','AA1735','ECO','E','2014-09-10 00:00:00','2014-11-19 00:00:00',1987.52,1716.45,712.63),
	('AA','AA1735','ECO','E','2014-11-20 00:00:00','2014-12-17 00:00:00',2240.97,1935.32,803.50),
	('AA','AA1735','ECO','E','2014-12-18 00:00:00','2015-01-04 00:00:00',2414.37,2085.08,865.67),
	('AA','AA1735','ECO','E','2015-01-05 00:00:00','2015-03-25 00:00:00',1920.83,1658.85,688.71),
	('AA','AA1735','ECO','E','2015-03-26 00:00:00','2015-06-25 00:00:00',1627.37,1405.41,583.49),
	('AA','AA1735','ECO','E','2015-06-26 00:00:00','2015-09-09 00:00:00',1333.91,1151.98,478.27),
	('AA','AA1735','ECO','E','2015-09-10 00:00:00','2015-11-19 00:00:00',1987.52,1716.45,712.63),
	('AA','AA1735','ECO','E','2015-11-20 00:00:00','2015-12-17 00:00:00',2240.97,1935.32,803.50),
	('AA','AA1735','ECO','E','2015-12-18 00:00:00','2016-01-04 00:00:00',2414.37,2085.08,865.67),
	('AA','AA1735','ECO','F','2014-09-10 00:00:00','2014-11-19 00:00:00',2022.70,1746.83,725.24),
	('AA','AA1735','ECO','F','2014-11-20 00:00:00','2014-12-17 00:00:00',2280.63,1969.58,817.72),
	('AA','AA1735','ECO','F','2014-12-18 00:00:00','2015-01-04 00:00:00',2457.11,2121.99,880.99),
	('AA','AA1735','ECO','F','2015-01-05 00:00:00','2015-03-25 00:00:00',1954.83,1688.21,700.90),
	('AA','AA1735','ECO','F','2015-03-26 00:00:00','2015-06-25 00:00:00',1656.17,1430.29,593.82),
	('AA','AA1735','ECO','F','2015-06-26 00:00:00','2015-09-09 00:00:00',1357.52,1172.37,486.74),
	('AA','AA1735','ECO','F','2015-09-10 00:00:00','2015-11-19 00:00:00',2022.70,1746.83,725.24),
	('AA','AA1735','ECO','F','2015-11-20 00:00:00','2015-12-17 00:00:00',2280.63,1969.58,817.72),
	('AA','AA1735','ECO','F','2015-12-18 00:00:00','2016-01-04 00:00:00',2457.11,2121.99,880.99),
	('AA','AA1735','ECO','G','2014-09-10 00:00:00','2014-11-19 00:00:00',2075.47,1792.40,744.16),
	('AA','AA1735','ECO','G','2014-11-20 00:00:00','2014-12-17 00:00:00',2340.12,2020.96,839.05),
	('AA','AA1735','ECO','G','2014-12-18 00:00:00','2015-01-04 00:00:00',2521.21,2177.34,903.98),
	('AA','AA1735','ECO','G','2015-01-05 00:00:00','2015-03-25 00:00:00',2005.82,1732.25,719.19),
	('AA','AA1735','ECO','G','2015-03-26 00:00:00','2015-06-25 00:00:00',1699.38,1467.60,609.31),
	('AA','AA1735','ECO','G','2015-06-26 00:00:00','2015-09-09 00:00:00',1392.93,1202.95,499.44),
	('AA','AA1735','ECO','G','2015-09-10 00:00:00','2015-11-19 00:00:00',2075.47,1792.40,744.16),
	('AA','AA1735','ECO','G','2015-11-20 00:00:00','2015-12-17 00:00:00',2340.12,2020.96,839.05),
	('AA','AA1735','ECO','G','2015-12-18 00:00:00','2016-01-04 00:00:00',2521.21,2177.34,903.98),
	('AA','AA1735','FIR','A','2014-09-10 00:00:00','2014-11-19 00:00:00',3693.63,3189.86,1324.35),
	('AA','AA1735','FIR','A','2014-11-20 00:00:00','2014-12-17 00:00:00',4164.63,3596.62,1493.23),
	('AA','AA1735','FIR','A','2014-12-18 00:00:00','2015-01-04 00:00:00',4486.89,3874.93,1608.77),
	('AA','AA1735','FIR','A','2015-01-05 00:00:00','2015-03-25 00:00:00',3569.68,3082.82,1279.91),
	('AA','AA1735','FIR','A','2015-03-26 00:00:00','2015-06-25 00:00:00',3024.31,2611.83,1084.37),
	('AA','AA1735','FIR','A','2015-06-26 00:00:00','2015-09-09 00:00:00',2478.95,2140.85,888.83),
	('AA','AA1735','FIR','A','2015-09-10 00:00:00','2015-11-19 00:00:00',3693.63,3189.86,1324.35),
	('AA','AA1735','FIR','A','2015-11-20 00:00:00','2015-12-17 00:00:00',4164.63,3596.62,1493.23),
	('AA','AA1735','FIR','A','2015-12-18 00:00:00','2016-01-04 00:00:00',4486.89,3874.93,1608.77),
	('AA','AA1735','FIR','B','2014-09-10 00:00:00','2014-11-19 00:00:00',3804.44,3285.55,1364.08),
	('AA','AA1735','FIR','B','2014-11-20 00:00:00','2014-12-17 00:00:00',4289.57,3704.52,1538.02),
	('AA','AA1735','FIR','B','2014-12-18 00:00:00','2015-01-04 00:00:00',4621.50,3991.18,1657.04),
	('AA','AA1735','FIR','B','2015-01-05 00:00:00','2015-03-25 00:00:00',3676.77,3175.30,1318.31),
	('AA','AA1735','FIR','B','2015-03-26 00:00:00','2015-06-25 00:00:00',3115.04,2690.19,1116.90),
	('AA','AA1735','FIR','B','2015-06-26 00:00:00','2015-09-09 00:00:00',2553.31,2205.07,915.49),
	('AA','AA1735','FIR','B','2015-09-10 00:00:00','2015-11-19 00:00:00',3804.44,3285.55,1364.08),
	('AA','AA1735','FIR','B','2015-11-20 00:00:00','2015-12-17 00:00:00',4289.57,3704.52,1538.02),
	('AA','AA1735','FIR','B','2015-12-18 00:00:00','2016-01-04 00:00:00',4621.50,3991.18,1657.04),
	('AA','AA1735','FIR','C','2014-09-10 00:00:00','2014-11-19 00:00:00',3952.18,3413.15,1417.05),
	('AA','AA1735','FIR','C','2014-11-20 00:00:00','2014-12-17 00:00:00',4456.15,3848.38,1597.75),
	('AA','AA1735','FIR','C','2014-12-18 00:00:00','2015-01-04 00:00:00',4800.97,4146.17,1721.39),
	('AA','AA1735','FIR','C','2015-01-05 00:00:00','2015-03-25 00:00:00',3819.56,3298.61,1369.50),
	('AA','AA1735','FIR','C','2015-03-26 00:00:00','2015-06-25 00:00:00',3236.01,2794.66,1160.27),
	('AA','AA1735','FIR','C','2015-06-26 00:00:00','2015-09-09 00:00:00',2652.47,2290.70,951.04),
	('AA','AA1735','FIR','C','2015-09-10 00:00:00','2015-11-19 00:00:00',3952.18,3413.15,1417.05),
	('AA','AA1735','FIR','C','2015-11-20 00:00:00','2015-12-17 00:00:00',4456.15,3848.38,1597.75),
	('AA','AA1735','FIR','C','2015-12-18 00:00:00','2016-01-04 00:00:00',4800.97,4146.17,1721.39),
	('AA','AA1735','FIR','D','2014-09-10 00:00:00','2014-11-19 00:00:00',4026.05,3476.95,1443.54),
	('AA','AA1735','FIR','D','2014-11-20 00:00:00','2014-12-17 00:00:00',4539.44,3920.32,1627.62),
	('AA','AA1735','FIR','D','2014-12-18 00:00:00','2015-01-04 00:00:00',4890.71,4223.67,1753.56),
	('AA','AA1735','FIR','D','2015-01-05 00:00:00','2015-03-25 00:00:00',3890.95,3360.27,1395.10),
	('AA','AA1735','FIR','D','2015-03-26 00:00:00','2015-06-25 00:00:00',3296.50,2846.90,1181.96),
	('AA','AA1735','FIR','D','2015-06-26 00:00:00','2015-09-09 00:00:00',2702.05,2333.52,968.82),
	('AA','AA1735','FIR','D','2015-09-10 00:00:00','2015-11-19 00:00:00',4026.05,3476.95,1443.54),
	('AA','AA1735','FIR','D','2015-11-20 00:00:00','2015-12-17 00:00:00',4539.44,3920.32,1627.62),
	('AA','AA1735','FIR','D','2015-12-18 00:00:00','2016-01-04 00:00:00',4890.71,4223.67,1753.56),
	('AA','AA1735','FIR','E','2014-09-10 00:00:00','2014-11-19 00:00:00',4173.80,3604.54,1496.51),
	('AA','AA1735','FIR','E','2014-11-20 00:00:00','2014-12-17 00:00:00',4706.03,4064.18,1687.35),
	('AA','AA1735','FIR','E','2014-12-18 00:00:00','2015-01-04 00:00:00',5070.19,4378.67,1817.91),
	('AA','AA1735','FIR','E','2015-01-05 00:00:00','2015-03-25 00:00:00',4033.74,3483.58,1446.30),
	('AA','AA1735','FIR','E','2015-03-26 00:00:00','2015-06-25 00:00:00',3417.47,2951.37,1225.33),
	('AA','AA1735','FIR','E','2015-06-26 00:00:00','2015-09-09 00:00:00',2801.21,2419.15,1004.37),
	('AA','AA1735','FIR','E','2015-09-10 00:00:00','2015-11-19 00:00:00',4173.80,3604.54,1496.51),
	('AA','AA1735','FIR','E','2015-11-20 00:00:00','2015-12-17 00:00:00',4706.03,4064.18,1687.35),
	('AA','AA1735','FIR','E','2015-12-18 00:00:00','2016-01-04 00:00:00',5070.19,4378.67,1817.91),
	('AA','AA1735','FIR','F','2014-09-10 00:00:00','2014-11-19 00:00:00',4247.67,3668.34,1523.00),
	('AA','AA1735','FIR','F','2014-11-20 00:00:00','2014-12-17 00:00:00',4789.32,4136.11,1717.21),
	('AA','AA1735','FIR','F','2014-12-18 00:00:00','2015-01-04 00:00:00',5159.92,4456.17,1850.09),
	('AA','AA1735','FIR','F','2015-01-05 00:00:00','2015-03-25 00:00:00',4105.13,3545.24,1471.89),
	('AA','AA1735','FIR','F','2015-03-26 00:00:00','2015-06-25 00:00:00',3477.96,3003.61,1247.02),
	('AA','AA1735','FIR','F','2015-06-26 00:00:00','2015-09-09 00:00:00',2850.79,2461.97,1022.15),
	('AA','AA1735','FIR','F','2015-09-10 00:00:00','2015-11-19 00:00:00',4247.67,3668.34,1523.00),
	('AA','AA1735','FIR','F','2015-11-20 00:00:00','2015-12-17 00:00:00',4789.32,4136.11,1717.21),
	('AA','AA1735','FIR','F','2015-12-18 00:00:00','2016-01-04 00:00:00',5159.92,4456.17,1850.09),
	('AA','AA1735','FIR','G','2014-09-10 00:00:00','2014-11-19 00:00:00',4358.48,3764.03,1562.73),
	('AA','AA1735','FIR','G','2014-11-20 00:00:00','2014-12-17 00:00:00',4914.26,4244.01,1762.01),
	('AA','AA1735','FIR','G','2014-12-18 00:00:00','2015-01-04 00:00:00',5294.53,4572.42,1898.35),
	('AA','AA1735','FIR','G','2015-01-05 00:00:00','2015-03-25 00:00:00',4212.22,3637.72,1510.29),
	('AA','AA1735','FIR','G','2015-03-26 00:00:00','2015-06-25 00:00:00',3568.69,3081.96,1279.55),
	('AA','AA1735','FIR','G','2015-06-26 00:00:00','2015-09-09 00:00:00',2925.16,2526.20,1048.81),
	('AA','AA1735','FIR','G','2015-09-10 00:00:00','2015-11-19 00:00:00',4358.48,3764.03,1562.73),
	('AA','AA1735','FIR','G','2015-11-20 00:00:00','2015-12-17 00:00:00',4914.26,4244.01,1762.01),
	('AA','AA1735','FIR','G','2015-12-18 00:00:00','2016-01-04 00:00:00',5294.53,4572.42,1898.35),
	('AA','AA1735','PME','A','2014-09-10 00:00:00','2014-11-19 00:00:00',2163.41,1868.35,775.69),
	('AA','AA1735','PME','A','2014-11-20 00:00:00','2014-12-17 00:00:00',2439.28,2106.59,874.60),
	('AA','AA1735','PME','A','2014-12-18 00:00:00','2015-01-04 00:00:00',2628.04,2269.60,942.28),
	('AA','AA1735','PME','A','2015-01-05 00:00:00','2015-03-25 00:00:00',2090.81,1805.65,749.66),
	('AA','AA1735','PME','A','2015-03-26 00:00:00','2015-06-25 00:00:00',1771.38,1529.79,635.13),
	('AA','AA1735','PME','A','2015-06-26 00:00:00','2015-09-09 00:00:00',1451.95,1253.92,520.60),
	('AA','AA1735','PME','A','2015-09-10 00:00:00','2015-11-19 00:00:00',2163.41,1868.35,775.69),
	('AA','AA1735','PME','A','2015-11-20 00:00:00','2015-12-17 00:00:00',2439.28,2106.59,874.60),
	('AA','AA1735','PME','A','2015-12-18 00:00:00','2016-01-04 00:00:00',2628.04,2269.60,942.28),
	('AA','AA1735','PME','B','2014-09-10 00:00:00','2014-11-19 00:00:00',2228.31,1924.40,798.96),
	('AA','AA1735','PME','B','2014-11-20 00:00:00','2014-12-17 00:00:00',2512.46,2169.79,900.84),
	('AA','AA1735','PME','B','2014-12-18 00:00:00','2015-01-04 00:00:00',2706.88,2337.69,970.55),
	('AA','AA1735','PME','B','2015-01-05 00:00:00','2015-03-25 00:00:00',2153.54,1859.82,772.15),
	('AA','AA1735','PME','B','2015-03-26 00:00:00','2015-06-25 00:00:00',1824.52,1575.68,654.18),
	('AA','AA1735','PME','B','2015-06-26 00:00:00','2015-09-09 00:00:00',1495.51,1291.54,536.22),
	('AA','AA1735','PME','B','2015-09-10 00:00:00','2015-11-19 00:00:00',2228.31,1924.40,798.96),
	('AA','AA1735','PME','B','2015-11-20 00:00:00','2015-12-17 00:00:00',2512.46,2169.79,900.84),
	('AA','AA1735','PME','B','2015-12-18 00:00:00','2016-01-04 00:00:00',2706.88,2337.69,970.55),
	('AA','AA1735','PME','C','2014-09-10 00:00:00','2014-11-19 00:00:00',2314.85,1999.13,829.99),
	('AA','AA1735','PME','C','2014-11-20 00:00:00','2014-12-17 00:00:00',2610.03,2254.05,935.83),
	('AA','AA1735','PME','C','2014-12-18 00:00:00','2015-01-04 00:00:00',2812.00,2428.47,1008.24),
	('AA','AA1735','PME','C','2015-01-05 00:00:00','2015-03-25 00:00:00',2237.17,1932.05,802.14),
	('AA','AA1735','PME','C','2015-03-26 00:00:00','2015-06-25 00:00:00',1895.38,1636.87,679.59),
	('AA','AA1735','PME','C','2015-06-26 00:00:00','2015-09-09 00:00:00',1553.59,1341.70,557.04),
	('AA','AA1735','PME','C','2015-09-10 00:00:00','2015-11-19 00:00:00',2314.85,1999.13,829.99),
	('AA','AA1735','PME','C','2015-11-20 00:00:00','2015-12-17 00:00:00',2610.03,2254.05,935.83),
	('AA','AA1735','PME','C','2015-12-18 00:00:00','2016-01-04 00:00:00',2812.00,2428.47,1008.24),
	('AA','AA1735','PME','D','2014-09-10 00:00:00','2014-11-19 00:00:00',2358.12,2036.50,845.50),
	('AA','AA1735','PME','D','2014-11-20 00:00:00','2014-12-17 00:00:00',2658.82,2296.18,953.32),
	('AA','AA1735','PME','D','2014-12-18 00:00:00','2015-01-04 00:00:00',2864.56,2473.87,1027.09),
	('AA','AA1735','PME','D','2015-01-05 00:00:00','2015-03-25 00:00:00',2278.99,1968.16,817.13),
	('AA','AA1735','PME','D','2015-03-26 00:00:00','2015-06-25 00:00:00',1930.81,1667.47,692.29),
	('AA','AA1735','PME','D','2015-06-26 00:00:00','2015-09-09 00:00:00',1582.63,1366.78,567.45),
	('AA','AA1735','PME','D','2015-09-10 00:00:00','2015-11-19 00:00:00',2358.12,2036.50,845.50),
	('AA','AA1735','PME','D','2015-11-20 00:00:00','2015-12-17 00:00:00',2658.82,2296.18,953.32),
	('AA','AA1735','PME','D','2015-12-18 00:00:00','2016-01-04 00:00:00',2864.56,2473.87,1027.09),
	('AA','AA1735','PME','E','2014-09-10 00:00:00','2014-11-19 00:00:00',2444.65,2111.23,876.53),
	('AA','AA1735','PME','E','2014-11-20 00:00:00','2014-12-17 00:00:00',2756.39,2380.45,988.30),
	('AA','AA1735','PME','E','2014-12-18 00:00:00','2015-01-04 00:00:00',2969.68,2564.65,1064.78),
	('AA','AA1735','PME','E','2015-01-05 00:00:00','2015-03-25 00:00:00',2362.62,2040.38,847.12),
	('AA','AA1735','PME','E','2015-03-26 00:00:00','2015-06-25 00:00:00',2001.66,1728.66,717.70),
	('AA','AA1735','PME','E','2015-06-26 00:00:00','2015-09-09 00:00:00',1640.71,1416.93,588.28),
	('AA','AA1735','PME','E','2015-09-10 00:00:00','2015-11-19 00:00:00',2444.65,2111.23,876.53),
	('AA','AA1735','PME','E','2015-11-20 00:00:00','2015-12-17 00:00:00',2756.39,2380.45,988.30),
	('AA','AA1735','PME','E','2015-12-18 00:00:00','2016-01-04 00:00:00',2969.68,2564.65,1064.78),
	('AA','AA1735','PME','F','2014-09-10 00:00:00','2014-11-19 00:00:00',2487.92,2148.60,892.04),
	('AA','AA1735','PME','F','2014-11-20 00:00:00','2014-12-17 00:00:00',2805.17,2422.58,1005.79),
	('AA','AA1735','PME','F','2014-12-18 00:00:00','2015-01-04 00:00:00',3022.24,2610.04,1083.62),
	('AA','AA1735','PME','F','2015-01-05 00:00:00','2015-03-25 00:00:00',2404.43,2076.50,862.11),
	('AA','AA1735','PME','F','2015-03-26 00:00:00','2015-06-25 00:00:00',2037.09,1759.25,730.40),
	('AA','AA1735','PME','F','2015-06-26 00:00:00','2015-09-09 00:00:00',1669.75,1442.01,598.69),
	('AA','AA1735','PME','F','2015-09-10 00:00:00','2015-11-19 00:00:00',2487.92,2148.60,892.04),
	('AA','AA1735','PME','F','2015-11-20 00:00:00','2015-12-17 00:00:00',2805.17,2422.58,1005.79),
	('AA','AA1735','PME','F','2015-12-18 00:00:00','2016-01-04 00:00:00',3022.24,2610.04,1083.62),
	('AA','AA1735','PME','G','2014-09-10 00:00:00','2014-11-19 00:00:00',2552.82,2204.65,915.31),
	('AA','AA1735','PME','G','2014-11-20 00:00:00','2014-12-17 00:00:00',2878.35,2485.78,1032.03),
	('AA','AA1735','PME','G','2014-12-18 00:00:00','2015-01-04 00:00:00',3101.08,2678.13,1111.89),
	('AA','AA1735','PME','G','2015-01-05 00:00:00','2015-03-25 00:00:00',2467.16,2130.67,884.60),
	('AA','AA1735','PME','G','2015-03-26 00:00:00','2015-06-25 00:00:00',2090.23,1805.15,749.45),
	('AA','AA1735','PME','G','2015-06-26 00:00:00','2015-09-09 00:00:00',1713.31,1479.63,614.31),
	('AA','AA1735','PME','G','2015-09-10 00:00:00','2015-11-19 00:00:00',2552.82,2204.65,915.31),
	('AA','AA1735','PME','G','2015-11-20 00:00:00','2015-12-17 00:00:00',2878.35,2485.78,1032.03),
	('AA','AA1735','PME','G','2015-12-18 00:00:00','2016-01-04 00:00:00',3101.08,2678.13,1111.89);