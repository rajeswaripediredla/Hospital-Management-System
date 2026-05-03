/*Patents with bills higher than Average*/
SELECT name
FROM Patient
WHERE patient_id IN (
    SELECT patient_id
    FROM Billing
    WHERE total_amount > (
        SELECT AVG(total_amount) FROM Billing
    )
);

/*Patients Who Visited Same Doctor as Patient 1*/
SELECT name
FROM Patient
WHERE patient_id IN (
    SELECT patient_id
    FROM Appointment
    WHERE doctor_id IN (
        SELECT doctor_id
        FROM Appointment
        WHERE patient_id = 1
    )
);

/*Doctor with Maximum Appointments*/
SELECT name
FROM Doctor
WHERE doctor_id = (
    SELECT doctor_id
    FROM Appointment
    GROUP BY doctor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

/*Patients Who Took Tests*/
SELECT name 
FROM Patient 
WHERE patient_id IN (
    SELECT patient_id 
    FROM Test_Reports
);