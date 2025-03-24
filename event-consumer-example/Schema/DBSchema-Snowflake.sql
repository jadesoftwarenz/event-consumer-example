-- Create Database
CREATE DATABASE BankApplicationDB;

-- Use Database
USE DATABASE BankApplicationDB;

-- Create Schema
CREATE SCHEMA BankModelSchema;

-- Create Table Bank
CREATE TABLE BankModelSchema.Bank (
    InstanceId NUMBER PRIMARY KEY,
    Name STRING NOT NULL
);

-- Insert mock bank data
INSERT INTO BankModelSchema.Bank (InstanceId, Name)
VALUES (1, 'SampleBankName');

-- Create Table District
CREATE TABLE BankModelSchema.District (
    InstanceId NUMBER PRIMARY KEY,
    City STRING NOT NULL,
    Division STRING NOT NULL,
    Id NUMBER NOT NULL,
    Region STRING NOT NULL,
    StateAbbrev STRING(5) NOT NULL,
    StateName STRING NOT NULL,
    MyBank NUMBER NOT NULL
);

-- Create Table Customer
CREATE TABLE BankModelSchema.Customer (
    InstanceId NUMBER PRIMARY KEY,
    Active BOOLEAN NOT NULL,
    Address1 STRING NOT NULL,
    Address2 STRING,
    City STRING NOT NULL,
    DateOfBirth DATE NOT NULL,
    DistrictId NUMBER NOT NULL,
    Email STRING,
    FirstName STRING NOT NULL,
    Gender STRING,
    Id STRING NOT NULL,
    LastName STRING NOT NULL,
    MiddleName STRING,
    PhoneNumber STRING(15),
    Ssn STRING(11),
    State STRING(5) NOT NULL,
    ZipCode STRING(10) NOT NULL,
    MyBank NUMBER NOT NULL,
    MyDistrict NUMBER NOT NULL
);

-- Create Table Account
CREATE TABLE BankModelSchema.Account (
    InstanceId NUMBER PRIMARY KEY,
    Active BOOLEAN NOT NULL,
    Date DATE NOT NULL,
    DistrictId NUMBER NOT NULL,
    Frequency STRING,
    Id STRING NOT NULL,
    MyBank NUMBER NOT NULL,
    MyDistrict NUMBER NOT NULL
);

-- Create Table Transaction
CREATE TABLE BankModelSchema.Transaction (
    InstanceId NUMBER PRIMARY KEY,
    AccountId STRING NOT NULL,
    Amount NUMBER(18, 2) NOT NULL,
    Id STRING NOT NULL,
    KSymbol STRING,
    Operation STRING,
    OtherAccount STRING,
    OtherBank STRING,
    Timestamp TIMESTAMP_TZ NOT NULL,
    Type STRING,
    MyAccount NUMBER NOT NULL,
    MyBank NUMBER NOT NULL
);
