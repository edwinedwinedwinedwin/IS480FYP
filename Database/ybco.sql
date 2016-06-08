/* Create Database called YBCO */

CREATE DATABASE IF NOT EXISTS YBCO;

-- Use Database called YBCO -- 

USE YBCO;

--  Create Tables in YBCO --

--  Create Table called Users
--  Contains info of all of YBCO's users 


CREATE TABLE IF NOT EXISTS Users
(
	UserID			int					NOT NULL,
    Username        Varchar(30)         NOT NULL,
    Email           Varchar(30)         NOT NULL,
    Password        Varchar(30)         NOT NULL,
    First_Name      Varchar(255)        NOT NULL,
    Last_Name       Varchar(255)        NOT NULL,
    Address         Varchar(255)        NOT NULL,
    isAdmin         Boolean             NOT NULL,
    CONSTRAINT USERINFO PRIMARY KEY (UserID,Email)
);

-- Create Table called Project_Category

CREATE TABLE IF NOT EXISTS Project_Category
(
	P_Category_ID		int					NOT NULL,
    P_Category_Name     Varchar(255)        NOT NULL,
    PRIMARY KEY (P_Category_ID)
);


--  Create Table called Projects
--  Clarify Max values
-- 	Status is an int where e.g. 1 represents Pending Approval, 2 represents Completed, etc.
--  Project_type - 1=Fundraise, 0=Get Suggestion

CREATE TABLE IF NOT EXISTS Project
(
	Project_ID			INT					NOT NULL,
    Project_Name        Varchar(255)        NOT NULL,
    P_Username          Varchar(30)         NOT NULL    REFERENCES Users(Username),
    Project_Category    Varchar(255)        NOT NULL    REFERENCES Project_Category(P_Category_Name),
    Start_Date          DATE                NOT NULL,
    End_Date            DATE                NOT NULL,
    Created_On			DATE				NOT NULL,
    About_Project       Varchar(9999)       NOT NULL, 
    Inspiration         Varchar(9999)       NOT NULL, 
    Description			Varchar(9999)		NOT NULL,
    Updates             Varchar(9999)       NOT NULL,
    P_Status			INT					NOT NULL, 
    Location            Varchar(255)        NOT NULL,
    Likes               INT,
    Project_Type        BOOLEAN			    NOT NULL,
    PRIMARY KEY (Project_ID, Project_Name)
);


--  Create Table called Project_Members
--  How to store pictures?

CREATE TABLE IF NOT EXISTS Project_Member
(
	P_ID			INT					NOT NULL	REFERENCES Project(Project_ID),
    P_Member_ID		INT					NOT NULL,
    P_Name          Varchar(255)        NOT NULL    REFERENCES Project(Project_Name),
    Member_Name     Varchar(255)        NOT NULL,
    Member_Role     Varchar(255)        NOT NULL,
    Picture         BLOB,                
    PRIMARY KEY (P_ID, P_Member_ID, P_Name)
);

--  Create Table called Project_Milestones

CREATE TABLE IF NOT EXISTS Project_Milestone
(
	P_ID				INT					NOT NULL	REFERENCES Project(Project_ID),
    P_Name              Varchar(255)        NOT NULL    REFERENCES Project(Project_Name),
    Milestone_ID		INT					NOT NULL,
    Milestone_Name      Varchar(255)        NOT NULL,
    Milestone_Duration  INT                 NOT NULL,
    M_Start_Date        DATE                NOT NULL,
    M_End_Date          DATE                NOT NULL,
    Amount_Raised       INT                 NOT NULL,
    Target_Amount       INT                 NOT NULL,
    Project_Status      Varchar(255)        NOT NULL,
    PRIMARY KEY (P_ID, P_Name, Milestone_ID)
);

-- CREATE TABLE called Project_Rewards
-- R_Username is username from table user

CREATE TABLE IF NOT EXISTS Project_Reward
(
	P_ID				INT					NOT NULL	REFERENCES Project(Project_ID),
    P_Name              Varchar(255)        NOT NULL    REFERENCES Project(Project_Name),
    R_Username          Varchar(30)         NOT NULL,
    Category            INT                 NOT NULL,
    Description         Varchar(9999)       NOT NULL,
    No_Of_Rewards       INT                 NOT NULL,
    Estimated_Delivery  DATE                NOT NULL,
    Reward_Name         Varchar(255)        NOT NULL,
    Funded_Amount       INT                 NOT NULL,
    Shipping_Add        Varchar(255)        NOT NULL,
    PRIMARY KEY (P_ID, P_Name)
);

-- Create Table called Project_Updates

CREATE TABLE IF NOT EXISTS Project_Update
(
	P_ID				INT					NOT NULL	REFERENCES Project(Project_ID),
    P_Name              Varchar(255)        NOT NULL    REFERENCES Project(Project_Name),
    U_ID				INT					NOT NULL,
    U_Date              DATE                NOT NULL,
    U_Time              TIME                NOT NULL,
    Title               Varchar(255)        NOT NULL,
    Content             Varchar(9999)       NOT NULL,
    PRIMARY KEY (P_ID, P_Name, U_ID)
);

-- Create Table called Funding_Overview

CREATE TABLE IF NOT EXISTS Funding_Overview
(
	P_ID				INT					NOT NULL	REFERENCES Project(Project_ID),
	P_Name              Varchar(255)        NOT NULL    REFERENCES Project(Project_Name),
	F_Date              DATE                NOT NULL,
	Visits              INT                 NOT NULL,
	Page_Views          INT                 NOT NULL,
	Audience_Size       INT                 NOT NULL,
	PRIMARY KEY (P_ID, P_Name)
);

-- Create Table called Message

CREATE TABLE IF NOT EXISTS Message
(
	Message_ID				INT				NOT NULL,
    Title					Varchar(100)	NOT NULL,
    Message					Varchar(9999)	NOT NULL,
    Date_Sent				DATE			NOT NULL,
    M_Read					BOOLEAN			NOT NULL,
    M_Visible				BOOLEAN			NOT NULL,
    Sender_ID				INT				NOT NULL	REFERENCES Users(User_ID),
    Recipient_ID			INT				NOT NULL	REFERENCES Users(User_ID),
    PRIMARY KEY (Message_ID)
);