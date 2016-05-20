/* Create Database called YBCO */

CREATE DATABASE IF NOT EXISTS YBCO;

-- Use Database called YBCO -- 

USE YBCO;

--  Create Tables in YBCO --

--  Create Table called Users
--  Contains info of all of YBCO's users 


CREATE TABLE IF NOT EXISTS Users 
(
    Username        Varchar(30)         NOT NULL,
    Email           Varchar(30)         NOT NULL,
    Password        Varchar(30)         NOT NULL,
    First_Name      Varchar(255)        NOT NULL,
    Last_Name       Varchar(255)        NOT NULL,
    Address         Varchar(255)        NOT NULL,
    isAdmin         Boolean             NOT NULL,
    CONSTRAINT USERINFO PRIMARY KEY (Username,Email)
);

-- Create Table called Project_Category

CREATE TABLE IF NOT EXISTS Project_Category
(
    P_Category_Name     Varchar(255)        NOT NULL    PRIMARY KEY
);


--  Create Table called Projects
--  Clarify Max values

CREATE TABLE IF NOT EXISTS Projects
(
    Project_Name        Varchar(255)        NOT NULL,
    P_Username          Varchar(30)         NOT NULL    REFERENCES Users(Username),
    Project_Category    Varchar(255)        NOT NULL    REFERENCES Project_Category(P_Category_Name),
    Start_Date          DATE                NOT NULL,
    End_Date            DATE                NOT NULL,
    About_Project       Varchar(9999)       NOT NULL, 
    Inspiration         Varchar(9999)       NOT NULL, 
    Updates             Varchar(9999)       NOT NULL,
    Proposed_Date       DATE                NOT NULL,
    Location            Varchar(255)        NOT NULL,
    Likes               INT,
    Project_Type        Varchar(255)        NOT NULL,
    isApproved          Boolean             NOT NULL,
    PRIMARY KEY (Project_Name)
);


--  Create Table called Project_Members
-- How to store pictures?

CREATE TABLE IF NOT EXISTS Project_Members
(
    P_Name          Varchar(255)        NOT NULL    REFERENCES Projects(Project_Name),
    Member_Name     Varchar(255)        NOT NULL,
    Member_Role     Varchar(255)        NOT NULL,
    Picture         BLOB,                
    PRIMARY KEY (P_Name)
);

--  Create Table called Project_Milestones

CREATE TABLE IF NOT EXISTS Project_Milestones
(
    P_Name              Varchar(255)        NOT NULL    REFERENCES Projects(Project_Name),
    Milestone_Name      Varchar(255)        NOT NULL,
    Milestone_Duration  INT                 NOT NULL,
    M_Start_Date        DATE                NOT NULL,
    M_End_Date          DATE                NOT NULL,
    Amount_Raised       INT                 NOT NULL,
    Target_Amount       INT                 NOT NULL,
    Project_Status      Varchar(255)        NOT NULL,
    PRIMARY KEY (P_Name)
);

-- CREATE TABLE called Project_Rewards

CREATE TABLE IF NOT EXISTS Project_Rewards
(
    P_Name              Varchar(255)        NOT NULL    REFERENCES Projects(Project_Name),
    R_Username          Varchar(30)         NOT NULL,
    Category            INT                 NOT NULL,
    Description         Varchar(9999)       NOT NULL,
    No_Of_Rewards       INT                 NOT NULL,
    Estimated_Delivery  DATE                NOT NULL,
    Reward_Name         Varchar(255)        NOT NULL,
    Funded_Amount       INT                 NOT NULL,
    Shipping_Add        Varchar(255)        NOT NULL,
    PRIMARY KEY (P_Name)
);

-- Create Table called Project_Inspiration

CREATE TABLE IF NOT EXISTS Project_Inspiration
(
    P_Name              Varchar(255)        NOT NULL    REFERENCES Projects(Project_Name),
    Inspiration         Varchar(255)        NOT NULL,
    Description         Varchar(9999)       NOT NULL,
    PRIMARY KEY (P_Name)
);

-- Create Table called Project_Updates

CREATE TABLE IF NOT EXISTS Project_Updates
(
    P_Name              Varchar(255)        NOT NULL    REFERENCES Projects(Project_Name),
    U_Date              DATE                NOT NULL,
    U_Time              TIME                NOT NULL,
    Title               Varchar(255)        NOT NULL,
    Content             Varchar(9999)       NOT NULL,
    PRIMARY KEY (P_Name)
);

-- Create Table called Funding_Overview

CREATE TABLE IF NOT EXISTS Funding_Overview
(
   P_Name               Varchar(255)        NOT NULL    REFERENCES Projects(Project_Name),
   F_Date               DATE                NOT NULL,
   Visits               INT                 NOT NULL,
   Page_Views           INT                 NOT NULL,
   Audience_Size        INT                 NOT NULL,
   PRIMARY KEY (P_Name)
);

