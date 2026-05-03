/*Automatically calculate total Bill*/

DELIMITER $$
CREATE TRIGGER before_billing_insert
    BEFORE INSERT ON Billing
    FOR EACH ROW
    BEGIN
        SET NEW.total_amount = NEW.consultation_fee +NEW.medicine_cost +NEW.test_cost;
    END$$
DELIMITER;

/*Update total on modification*/

DELIMITER $$

CREATE TRIGGER before_billing_update
BEFORE UPDATE ON Billing
FOR EACH ROW
BEGIN
    SET NEW.total_amount = NEW.consultation_fee + NEW.medicine_cost + NEW.test_cost;
END$$
DELIMITER ;

/*Set Default Appointment Status*/

DELIMITER $$
CREATE TRIGGER before_appointment_insert
BEFORE INSERT ON Appointment
FOR EACH ROW
BEGIN
    IF NEW.status IS NULL OR NEW.status = '' THEN
        SET NEW.status = 'Booked';
    END IF;
END$$
DELIMITER ;

/*Prevent Invalid Age*/

DELIMITER $$
CREATE TRIGGER check_patient_age
BEFORE INSERT ON Patient
FOR EACH ROW
BEGIN
    IF NEW.age <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid age';
    END IF;
END$$
DELIMITER ;

/*Auto Set Registration Date*/

DELIMITER $$
CREATE TRIGGER set_registration_date
    BEFORE INSERT ON Patient
    FOR EACH ROW
    BEGIN
        IF NEW.registration_date IS NULL THEN
            SET NEW.registration_date = CURDATE();
        END IF;
END$$
DELIMITER ;


/*Prevent Discharge Before Admission*/

DELIMITER $$
CREATE TRIGGER check_discharge_date
    BEFORE INSERT ON Admissions
    FOR EACH ROW
    BEGIN
    IF NEW.discharge_date < NEW.admission_date THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Discharge date cannot be before admission date';
    END IF;
END$$
DELIMITER ;