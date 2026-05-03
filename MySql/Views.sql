CREATE VIEW patient_full_view AS
    SELECT
        p.patient_id,
        p.name,
        p.age,
        p.gender,
         p.phone,
     
         a.appointment_id,
         a.appointment_date,
         a.appointment_time,
         a.status,
    
         m.diagnosis,
         m.treatment,
    
         b.total_amount,
         b.payment_status,
    
         t.test_name,
         t.test_result
    
     FROM Patient p
     LEFT JOIN Appointment a ON p.patient_id = a.patient_id
     LEFT JOIN Medical_Record m ON p.patient_id = m.patient_id
     LEFT JOIN Billing b ON p.patient_id = b.patient_id
     LEFT JOIN Test_Reports t ON p.patient_id = t.patient_id;

CREATE VIEW appointment_details AS
     SELECT
         a.appointment_id,
         p.name AS patient_name,
         d.name AS doctor_name,
         a.appointment_date,
         a.appointment_time,
         a.status,
         a.reason
     FROM Appointment a
     JOIN Patient p ON a.patient_id = p.patient_id
     JOIN Doctor d ON a.doctor_id = d.doctor_id;

CREATE VIEW medical_history AS
     SELECT
         m.record_id,
         p.name AS patient_name,
         d.name AS doctor_name,
         m.diagnosis,
         m.treatment,
         m.prescription,
         m.record_date
     FROM Medical_Record m
     JOIN Patient p ON m.patient_id = p.patient_id
     JOIN Doctor d ON m.doctor_id = d.doctor_id;

CREATE VIEW billing_summary AS
     SELECT
         b.bill_id,
         p.name AS patient_name,
         b.consultation_fee,
         b.medicine_cost,
         b.test_cost,
         b.total_amount,
         b.payment_status,
         b.payment_method,
         b.bill_date
     FROM Billing b
     JOIN Patient p ON b.patient_id = p.patient_id;

CREATE VIEW test_report_view AS
     SELECT
         t.test_id,
         p.name AS patient_name,
         d.name AS doctor_name,
         t.test_name,
         t.test_result,
         t.test_date,
         t.remarks
     FROM Test_Reports t
     JOIN Patient p ON t.patient_id = p.patient_id
     JOIN Doctor d ON t.doctor_id = d.doctor_id;


/*CREATE USERS8*/

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin123';

CREATE USER 'doctor_user'@'localhost' IDENTIFIED BY 'doc123';

CREATE USER 'reception_user'@'localhost' IDENTIFIED BY 'rec123';

CREATE USER 'lab_user'@'localhost' IDENTIFIED BY 'lab123';

CREATE USER 'patient1'@'localhost' IDENTIFIED BY 'p123';


/*Admin → full access*/

GRANT ALL PRIVILEGES ON hospital_db.* TO 'admin'@'localhost';


/*Doctor → limited access*/

GRANT SELECT ON hospital_management.patient_details TO 'doctor_user'@'localhost';

GRANT SELECT ON hospital_management.medical_history TO 'doctor_user'@'localhost';

GRANT SELECT ON hospital_management.test_report_view TO 'doctor_user'@'localhost';



/*RECEPTIONIST  BILLING, Appointment details*/

GRANT SELECT ON hospital_management.appointment_details TO 'reception_user'@'localhost';

GRANT SELECT ON hospital_management.billing_summary TO 'reception_user'@'localhost';


/*Lab Staff → test reports only*/

GRANT SELECT ON hospital_management.test_report_view TO 'lab_user'@'localhost';


/*Patient  their details*/

GRANT SELECT ON hospital_management.patient_full_view TO 'patient1'@'localhost';


FLUSH PRIVILEGES;

