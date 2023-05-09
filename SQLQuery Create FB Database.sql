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
	userID			    CHAR(8),
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
go

INSERT INTO USERS VALUES ('01010101', 'Lachlan', 'ONeill', 'lachlan@gmail.com', 'lo', '04 123 456', 'user', '12 Main St, Carrington, NSW, Australia', 'Simple', 'AUD', '+10', 'Light', 0, '1997-08-29')
INSERT INTO USERS VALUES ('11112222', 'Jordan', 'Eade', 'jordan@gmail.com', 'je', '04 454 678', 'user', '45 Smith St, Brisbane, QLD, Australia', 'Simple', 'AUD', '+10', 'Light', 1, '2003-07-14');
INSERT INTO USERS VALUES ('98765432', 'Lucy', 'Knight', 'lucy@gmail.com', 'lk', '04 474 235', 'user', '87 George St, Adelaide, SA, Australia', 'Stripe', 'AUD', '+10', 'Dark', 0, '2004-03-21');
INSERT INTO USERS VALUES ('12345678', 'Blake', 'Baldin', 'blake@gmail.com', 'bb', '04 123 456', 'user', '39 High St, Melbourne, VIC, Australia', 'Recommend', 'AUD', '+10', 'Dark', 0, '2002-10-06')


go


-- Create groups and associated tables
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

CREATE TABLE GROUPS
(
	groupID 	CHAR(8) PRIMARY KEY,
	groupName		VARCHAR(20),
	chatID	CHAR(8) FOREIGN KEY REFERENCES CHAT(chatID),
	poolID 	CHAR(8) FOREIGN KEY REFERENCES POOL(poolID),
	-- faveListID

)
go

CREATE TABLE USERGROUPS
(
	userGroupsID		CHAR(8) PRIMARY KEY,
	userID	CHAR(8) FOREIGN KEY REFERENCES USERS(userID),
	groupID CHAR(8) FOREIGN KEY REFERENCES GROUPS(groupID),
	isAdmin		INT DEFAULT(0),
)

