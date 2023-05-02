

IF DB_ID (N'SENG2050_finalProject') IS NOT NULL
USE [master];

IF DB_ID (N'SENG2050_finalProject') IS NOT NULL
DROP DATABASE [SENG2050_finalProject];

CREATE DATABASE [SENG2050_finalProject];
GO
USE [SENG2050_finalProject];

IF SUSER_ID(N'SENG2050_Users') IS NOT NULL
BEGIN
	DROP LOGIN [SENG2050_Users];
END
CREATE LOGIN SENG2050_Users
WITH PASSWORD = 'seng2050';

IF USER_ID(N'SENG2050_Users') IS NOT NULL
BEGIN
	DROP USER [SENG2050_Users];
END
CREATE USER SENG2050_Users
FOR LOGIN SENG2050_Users;



GRANT SELECT, INSERT, UPDATE, DELETE, ALTER TO SENG2050_Users;

IF OBJECT_ID(N'Comments', N'U') IS NOT NULL
    BEGIN
        DROP TABLE [Comments];
    END

IF OBJECT_ID(N'Issues', N'U') IS NOT NULL
    BEGIN
        DROP TABLE [Issues];
    END

IF OBJECT_ID(N'person', N'U') IS NOT NULL
BEGIN
	DROP TABLE [person];
END


CREATE TABLE person
(
	personID			  UNIQUEIDENTIFIER,
	first_name				  varchar(20),
	last_name				  varchar(20),
	email				VARCHAR(30),
	userPassword		 VARCHAR(100),
	phoneNo    			VARCHAR(15),
	roles         VARCHAR(20),

	PRIMARY KEY (personID),
)
go




CREATE TABLE Issues
(
	issueID				 UNIQUEIDENTIFIER PRIMARY KEY,
	personID			 UNIQUEIDENTIFIER,
	issueState			 varchar(30),
	category			 varchar(30),
	subCategory          varchar(30),
	title				 varchar(50),
	resolutionDetails     varchar(MAX),
	dateReported		 varchar(30),
	timeReported	   	varchar(30),
	dateSolved			varchar(30),
	description      varchar(MAX),
	KBArticle        varchar(1),
	FOREIGN KEY(personID) REFERENCES person(personID)
	ON DELETE CASCADE
)
go



CREATE TABLE Comments
(
	commentsId      UNIQUEIDENTIFIER,
	personID			  UNIQUEIDENTIFIER,
	description    varchar(MAX),
	issueID				 UNIQUEIDENTIFIER,
	commentDate 		varchar(30),
	commentTime			varchar(30),
	PRIMARY KEY (commentsId),
	FOREIGN KEY(issueID) REFERENCES Issues(issueId)
	ON DELETE NO ACTION,
	FOREIGN KEY(personID) REFERENCES person(personID)
	ON DELETE CASCADE

)
go


INSERT INTO Person VALUES (NEWID(), 'Jason', 'Walls', 'jason@gmail.com', 'pass123', '04 123 456', 'user')
INSERT INTO Person VALUES (NEWID(), 'Ahmed', 'Al-khazraji', 'ahmed@gmail.com', 'ahmed123', '04 121 232', 'user')
INSERT INTO Person VALUES (NEWID(), 'Jordan', 'Eade', 'jordan@gmail.com', 'e123', '04 454 678', 'staff')
INSERT INTO Person VALUES (NEWID(), 'Lucy', 'Knight', 'lucy@gmail.com', 'knight1', '04 474 235', 'staff')
INSERT INTO Person VALUES (NEWID(), 'Yuqing', 'Lin', 'yuqing@gmail.com', 'superadmin', '04 938 843', 'admin')

go
