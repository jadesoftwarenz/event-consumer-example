CREATE DATABASE BankApplicationDB;
GO

USE BankApplicationDB;
GO

CREATE SCHEMA BankModelSchema;
GO

CREATE TABLE [BankModelSchema].[Bank] (
    InstanceId NVARCHAR(50) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);
GO

-- Insert mock bank data
INSERT INTO BankModelSchema.Bank (InstanceId, Name)
VALUES (1, 'SampleBankName');
GO

CREATE TABLE [BankModelSchema].[District] (
    InstanceId NVARCHAR(50) PRIMARY KEY,
    City VARCHAR(100) NOT NULL,
    Division VARCHAR(100) NOT NULL,
    Id INT NOT NULL,
    Region VARCHAR(100) NOT NULL,
    StateAbbrev VARCHAR(5) NOT NULL,
    StateName VARCHAR(100) NOT NULL,
    MyBank NVARCHAR(50) NOT NULL	
);
GO

CREATE TABLE [BankModelSchema].[Customer] (
    InstanceId NVARCHAR(50) PRIMARY KEY,
    Active BIT NOT NULL,
    Address1 VARCHAR(100) NOT NULL,
    Address2 VARCHAR(100),
    City VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    DistrictId NVARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    FirstName VARCHAR(100) NOT NULL,
    Gender VARCHAR(50),
    Id VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    MiddleName VARCHAR(100),
    PhoneNumber VARCHAR(15),
    Ssn VARCHAR(11),
    State VARCHAR(5) NOT NULL,
    ZipCode VARCHAR(10) NOT NULL,
    MyBank NVARCHAR(50) NOT NULL,
    MyDistrict NVARCHAR(50) NOT NULL	
);
GO

CREATE TABLE [BankModelSchema].[Account] (
    InstanceId NVARCHAR(50) PRIMARY KEY,
    Active BIT NOT NULL,
    Date DATE NOT NULL,
    DistrictId NVARCHAR(50) NOT NULL,
    Frequency VARCHAR(50),
    Id VARCHAR(100) NOT NULL,
	MyBank NVARCHAR(50) NOT NULL,
    MyDistrict NVARCHAR(50) NOT NULL	
);
GO

CREATE TABLE [BankModelSchema].[Transaction] (
    InstanceId NVARCHAR(50) PRIMARY KEY,
    AccountId NVARCHAR(50) NOT NULL,
    Amount DECIMAL(18, 2) NOT NULL,
    Id VARCHAR(100) NOT NULL,
    KSymbol VARCHAR(100),
    Operation VARCHAR(50),
    OtherAccount VARCHAR(100),
    OtherBank VARCHAR(100),
    Timestamp DATETIMEOFFSET NOT NULL,
    Type VARCHAR(50),
    MyAccount NVARCHAR(50) NOT NULL,
    MyBank NVARCHAR(50) NOT NULL	
);
GO
