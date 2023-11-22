-- run 25 students first for correct serial
-- Insert data for 5 instructors
INSERT INTO instructor (person_number, first_name, last_name, phone_number, email_address)
VALUES
  ('IN001', 'John', 'Doe', '(011) 11111111', 'john.doe@example.com'),
  ('IN002', 'Jane', 'Smith', '(022) 22222222', 'jane.smith@example.com'),
  ('IN003', 'Robert', 'Johnson', '(033) 33333333', 'robert.johnson@example.com'),
  ('IN004', 'Emily', 'Jones', '(044) 44444444', 'emily.jones@example.com'),
  ('IN005', 'David', 'Davis', '(055) 55555555', 'david.davis@example.com');

-- Insert data for 5 addresses
INSERT INTO address (street, zip, city)
VALUES
  ('123 Instructor St.', '12345', 'Instructorville'),
  ('456 Teaching Ave.', '67890', 'Teachtown'),
  ('789 Lesson Rd.', '98765', 'Lessonburg'),
  ('321 Education Blvd.', '54321', 'Edutown'),
  ('654 Training Ln.', '13579', 'Training City');

-- Link instructors to addresses
INSERT INTO person_address (person_id, address_id)
VALUES
  (26, 26), -- John Doe
  (27, 27), -- Jane Smith
  (28, 28), -- Robert Johnson
  (29, 29), -- Emily Jones
  (30, 30); -- David Davis;

--general insert with all new
INSERT INTO student (person_number, first_name,last_name,phone_number,email_address)
VALUES('personnumber','some_instructor_name','some_surname','some_phone','some_email');

INSERT INTO address (street, zip, city)
VALUES('some_street','zip','some_city');

INSERT INTO person_address (person_id, address_id)
VALUES (currval('person_person_id_seq'), currval('address_id_seq'));

