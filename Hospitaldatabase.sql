CREATE DATABASE IF NOT EXISTS HospitalDB;
USE HospitalDB;
-- Department Table

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);
-- Patients Table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Address TEXT,
    BloodGroup VARCHAR(5),
    DateRegistered DATE 
);
-- Doctors Table

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialty VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
-- Appointments table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATETIME,
    Reason TEXT,
    Status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);
-- Medical Records table
CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    Diagnosis TEXT,
    Treatment TEXT,
    RecordDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);
-- Billing
CREATE TABLE Billing (
    BillID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    AppointmentID INT,
    Amount DECIMAL(10, 2),
    PaymentStatus ENUM('Pending', 'Paid'),
    PaymentDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);
-- creating users and grants 
-- admin User
CREATE USER 'hms_admin'@'localhost' IDENTIFIED BY 'Admin#123';
GRANT ALL PRIVILEGES ON HospitalDB.* TO 'hms_admin'@'localhost';

-- Doctors
CREATE USER 'hms_doctor'@'localhost' IDENTIFIED BY 'Doctor#123';
GRANT SELECT, UPDATE ON HospitalDB.Patients TO 'hms_doctor'@'localhost';
GRANT SELECT, INSERT, UPDATE ON HospitalDB.MedicalRecords TO 'hms_doctor'@'localhost';
GRANT SELECT ON HospitalDB.Appointments TO 'hms_doctor'@'localhost';

-- Receptionist
CREATE USER 'hms_receptionist'@'localhost' IDENTIFIED BY 'Reception#123';
GRANT SELECT, INSERT, UPDATE ON HospitalDB.Patients TO 'hms_receptionist'@'localhost';
GRANT SELECT, INSERT, UPDATE ON HospitalDB.Appointments TO 'hms_receptionist'@'localhost';
GRANT SELECT, INSERT ON HospitalDB.Billing TO 'hms_receptionist'@'localhost';

-- Join Queries
SELECT 
    a.AppointmentID,
    CONCAT(p.FirstName, ' ', p.LastName) AS PatientName,
    CONCAT(d.FirstName, ' ', d.LastName) AS DoctorName,
    a.AppointmentDate,
    a.Status
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID;

SELECT 
    b.BillID,
    CONCAT(p.FirstName, ' ', p.LastName) AS PatientName,
    a.AppointmentDate,
    b.Amount,
    b.PaymentStatus
FROM Billing b
JOIN Patients p ON b.PatientID = p.PatientID
LEFT JOIN Appointments a ON b.AppointmentID = a.AppointmentID;
