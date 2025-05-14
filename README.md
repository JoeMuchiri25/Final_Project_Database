# Final_Project_Database

Hospital Management System (HMS) Database Summary
Database: HospitalDB
This database is designed to manage key operations in a hospital such as patient registration, appointments, medical records, billing, and user roles.

Entity-Relationship Diagram (ERD)
The diagram illustrates relationships among core entities:

![ERD Diagram](https://github.com/JoeMuchiri25/Final_Project_Database/blob/259671d28a75f02778ff22f3e03842e2fe85f43d/ERD.jpeg)

One-to-Many between:
Departments → Doctors
Patients → Appointments, MedicalRecords, Billing
Doctors → Appointments, MedicalRecords

This diagram visually enforces the relational structure and foreign key constraints of the system.

Core Tables:
Table Name	Description
Departments	List of hospital departments.
Doctors	Doctors with contact info and department links.
Patients	Patient records including demographics.
Appointments	Appointment schedule with doctor-patient links.
MedicalRecords	Diagnosis and treatment records.
Billing	Payment tracking for appointments.

User Roles and Permissions
User Role	Permissions Summary
hms_admin	Full access to all tables and operations.
hms_doctor	Can view/update patients, manage medical records, view appointments.
hms_receptionist	Can manage patients, appointments, and billing entries.

Sample SQL Queries Included
Appointments Summary: Joins Appointments, Doctors, and Patients.

Billing Summary: Joins Billing, Appointments, and Patients.

Key Features:
Normalized structure for efficient data management.
Foreign key constraints ensure data consistency.
ENUMs used for controlled status values.
Secure access via role-based user permissions.

What's Included in the Project
SQL scripts to:
Create database and tables
Insert user roles and assign permissions
Run sample queries

