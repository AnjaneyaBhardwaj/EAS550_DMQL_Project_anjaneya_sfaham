-- For safety during development, drop tables if they exist
-- DROP TABLE IF EXISTS Admissions CASCADE;
-- DROP TABLE IF EXISTS Medications CASCADE;
-- DROP TABLE IF EXISTS MedicalConditions CASCADE;
-- DROP TABLE IF EXISTS InsuranceProviders CASCADE;
-- DROP TABLE IF EXISTS Hospitals CASCADE;
-- DROP TABLE IF EXISTS Doctors CASCADE;
-- DROP TABLE IF EXISTS Patients CASCADE;

CREATE TABLE Patients (
    Patient_ID SERIAL PRIMARY KEY,   
    Name VARCHAR(100) NOT NULL,
    Age INT CHECK (Age >= 0 AND Age <= 120),
    Gender VARCHAR(20),
    Blood_Type VARCHAR(5)
);

CREATE TABLE Doctors (
    Doctor_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE Hospitals (
    Hospital_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE InsuranceProviders (
    Insurance_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE MedicalConditions (
    Condition_ID SERIAL PRIMARY KEY,
    Condition_Name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Medications (
    Medication_ID SERIAL PRIMARY KEY,
    Medication_Name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Admissions (
    Admission_ID SERIAL PRIMARY KEY,
    
    Patient_ID INT NOT NULL REFERENCES Patients(Patient_ID) ON DELETE CASCADE,
    Doctor_ID INT NOT NULL REFERENCES Doctors(Doctor_ID) ON DELETE CASCADE,
    Hospital_ID INT NOT NULL REFERENCES Hospitals(Hospital_ID) ON DELETE CASCADE,
    Insurance_ID INT REFERENCES InsuranceProviders(Insurance_ID) ON DELETE SET NULL,
    Condition_ID INT NOT NULL REFERENCES MedicalConditions(Condition_ID) ON DELETE CASCADE,
    Medication_ID INT REFERENCES Medications(Medication_ID) ON DELETE SET NULL,
    
    Date_of_Admission DATE NOT NULL,
    Discharge_Date DATE,
    Admission_Type VARCHAR(50) NOT NULL,
    Room_Number INT CHECK (Room_Number > 0),
    Billing_Amount DECIMAL(10, 2) CHECK (Billing_Amount >= 0),
    Test_Results TEXT,
    
    CONSTRAINT check_dates CHECK (Discharge_Date IS NULL OR Discharge_Date >= Date_of_Admission)
);