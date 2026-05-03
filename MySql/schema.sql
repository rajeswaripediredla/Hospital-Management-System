create database Hospital_Management;

use Hospital_Management;

 CREATE table Patient(
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age int,
    gender VARCHAR(10),
    phone VARCHAR(15) UNIQUE,
    address VARCHAR(250),
    blood_group VARCHAR(5),
    registration_date DATE
);

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Patient.csv'
into table patient
fields terminated by ','
ignore 1 rows;


create table Department(
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100),
    location VARCHAR(100)
);
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Department.csv"
into table Department
fields terminated by ','
ignore 1 rows;

create table Doctor(
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
    );
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Doctor.csv"
    into table Doctor
    fields terminated by ','
    ignore 1 rows;

Create table Appointment(
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    appointment_time TIME,
        status VARCHAR(20),
        reason VARCHAR(255),
        FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
       FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Appointment.csv"
    into table Appointment
    fields terminated by ','
    ignore 1 rows;


create table Medical_Record(
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    diagnosis TEXT,
    treatment TEXT,
    prescription TEXT,
    record_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Medical_Record.csv"
into table Medical_Record
fields terminated by ','
ignore 1 rows;


CREATE TABLE Test_Reports (
    test_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    test_name VARCHAR(100),
    test_result TEXT,
    test_date DATE,
    remarks TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Test_Reports.csv"
into table Test_Reports
fields terminated by ','
ignore 1 rows;


CREATE TABLE Admissions (
    admission_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    room_number VARCHAR(10),
    admission_date DATE,
    discharge_date DATE,
    reason TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Admisson.csv"
into table Admissions
fields terminated by ','
ignore 1 rows;


CREATE TABLE Billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    appointment_id INT,
    consultation_fee DECIMAL(10,2),
    medicine_cost DECIMAL(10,2),
    test_cost DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    payment_method VARCHAR(50),
    bill_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Billing.csv'
INTO TABLE Billing
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;