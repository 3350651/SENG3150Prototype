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
	first_name				  varchar(20),
	last_name				  varchar(20),
	email				VARCHAR(30),
	userPassword		 VARCHAR(100),
	phoneNo    			VARCHAR(15),
	roles         VARCHAR(20),

	PRIMARY KEY (userID),
)
go

INSERT INTO USERS VALUES (NEWID(), 'Lachlan', 'ONeill', 'lachlan@gmail.com', 'lo', '04 123 456', 'user')
INSERT INTO USERS VALUES (NEWID(), 'Jordan', 'Eade', 'jordan@gmail.com', 'je', '04 454 678', 'user')
INSERT INTO USERS VALUES (NEWID(), 'Lucy', 'Knight', 'lucy@gmail.com', 'lk', '04 474 235', 'user')
INSERT INTO USERS VALUES (NEWID(), 'Blake', 'Baldin', 'blake@gmail.com', 'bb', '04 123 456', 'user')


go
