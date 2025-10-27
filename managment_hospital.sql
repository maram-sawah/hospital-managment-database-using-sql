CREATE DATABASE hospital;
USE hospital;

CREATE TABLE Departments (
  department_id INT IDENTITY(1,1) PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

CREATE TABLE Doctors (
  doctor_id INT IDENTITY(1,1) PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  department_id INT,
  phone VARCHAR(20),
  email VARCHAR(100),
  FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);


CREATE TABLE Patients (
  patient_id INT IDENTITY(1,1) PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  gender VARCHAR(10),
  phone VARCHAR(20)
);


CREATE TABLE Appointments (
  appointment_id INT IDENTITY(1,1) PRIMARY KEY,
  patient_id INT,
  doctor_id INT,
  appointment_date DATETIME,
  status VARCHAR(20), -- scheduled, completed, cancelled
  notes TEXT,
  FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);


CREATE TABLE Prescriptions (
  prescription_id INT IDENTITY(1,1) PRIMARY KEY,
  appointment_id INT,
  doctor_id INT,
  patient_id INT,
  medication VARCHAR(200),
  dose VARCHAR(100),
  FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
  FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

INSERT INTO Departments (name) VALUES
('Cardiology'),
('Pediatrics'),
('Dermatology');


INSERT INTO Doctors (first_name, last_name, department_id, phone, email) VALUES
('Ahmed', 'Ali', 1, '01012345678', 'ahmed@example.com'),
('Mona', 'Hassan', 2, '01098765432', 'mona@example.com');


INSERT INTO Patients (first_name, last_name, gender, phone) VALUES
('Salma', 'Mahmoud', 'F', '01022223333'),
('Omar', 'Naguib', 'M', '01033334444');


INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status, notes) VALUES
(1, 1, '2025-10-25 10:00:00', 'completed', 'Regular checkup'),
(2, 2, '2025-10-26 11:30:00', 'scheduled', 'Skin allergy');


INSERT INTO Prescriptions (appointment_id, doctor_id, patient_id, medication, dose) VALUES
(1, 1, 1, 'Paracetamol 500mg', '1 tablet twice daily');

--BASIC SQL OPERATIONS
SELECT * FROM Doctors;
SELECT* FROM Patients;
SELECT * FROM Appointments;

--patients from gender 'f'
SELECT * FROM Patients 
WHERE gender='F';

--DOCTORS IN SPECIFIC DEPARTMENT
SELECT * FROM Doctors
WHERE department_id=1;

SELECT * FROM Appointments
WHERE status='scheduled';

--update patient's phone
UPDATE Patients SET phone='01099998888'
WHERE patient_id=1;
--DELETE PATIENT 
DELETE FORM Patients WHERE patient_id=3;

--ANALYTICAL QUERIES

--count of doctors in every department
SELECT d.name AS department,
COUNT (doc.doctor_id) AS num_doctors FROM Departments d
LEFT JOIN Doctors doc ON D.department_id=doc.department_id
GROUP BY d.name;

--Number of appointments per doctor 
SELECT doc.first_name, doc.last_name, COUNT(a.appointment_id) AS total_appointments
FROM Doctors doc
LEFT JOIN Appointments a ON doc.doctor_id = a.doctor_id
GROUP BY doc.first_name, doc.last_name
ORDER BY total_appointments DESC;


--Most prescribed medications
SELECT medication, COUNT(*) AS times_prescribed
FROM Prescriptions
GROUP BY medication
ORDER BY times_prescribed DESC;

--Number of appointments according to the case
SELECT status, COUNT(*) AS count
FROM Appointments
GROUP BY status;


