--Type configs
CREATE TYPE instrument_type AS ENUM('Guitar', 'Piano', 'Violin', 'Drums', 'Other');


CREATE TYPE level_type AS ENUM('Beginner', 'Intermediate', 'Advanced');


CREATE TYPE lesson_type AS ENUM('Individual', 'Group', 'Ensemble');


--Table configs
CREATE TABLE
  address (
    address_id SERIAL PRIMARY KEY,
    street VARCHAR(200) NOT NULL,
    zip VARCHAR(5) NOT NULL,
    city VARCHAR(100) NOT NULL
  );


CREATE TABLE
  person (
    person_id SERIAL PRIMARY KEY,
    person_number CHAR(12) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    email_address VARCHAR(100) UNIQUE NOT NULL
  );


CREATE TABLE
  person_address (
    person_address_id SERIAL PRIMARY KEY,
    person_id INTEGER NOT NULL,
    address_id INTEGER NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE,
    FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE CASCADE
  );


CREATE TABLE
  instructor (
    person_id INT NOT NULL,
    instructor_id SERIAL NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE,
    CONSTRAINT PK_instructor PRIMARY KEY (person_id)
  );


CREATE TABLE
  student (
    person_id INT NOT NULL,
    student_id SERIAL NOT NULL,
    enrollment_date DATE DEFAULT CURRENT_DATE NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE,
    CONSTRAINT PK_student PRIMARY KEY (person_id)
  );


CREATE TABLE
  contact_person (
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    person_id INTEGER NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    relationship VARCHAR(20),
    CONSTRAINT PK_contact_person PRIMARY KEY (phone_number, person_id),
    FOREIGN KEY (person_id) REFERENCES student (person_id) ON DELETE CASCADE
  );


CREATE TABLE
  sibling (
    person_id INTEGER NOT NULL,
    sibling_id INTEGER NOT NULL,
    relation_type VARCHAR(10),
    CONSTRAINT PK_sibling PRIMARY KEY (person_id, sibling_id),
    CHECK (person_id <> sibling_id), --added to prevent duplicates
    FOREIGN KEY (person_id) REFERENCES student (person_id) ON DELETE CASCADE,
    FOREIGN KEY (sibling_id) REFERENCES student (person_id) ON DELETE CASCADE
  );


CREATE TABLE
  price_info (
    price_info_id SERIAL PRIMARY KEY,
    lesson_type lesson_type NOT NULL,
    base_price VARCHAR(10) NOT NULL,
    lesson_level level_type,
    starting_date DATE NOT NULL,
    end_date DATE
  );


CREATE TABLE
  instrument (
    instrument_id SERIAL PRIMARY KEY,
    instrument_type instrument_type NOT NULL,
    brand VARCHAR(100),
    price VARCHAR(10) NOT NULL,
    quantity_in_stock INTEGER,
    description VARCHAR(500)
  );


CREATE TABLE
  timeslot (
    slot_id SERIAL PRIMARY KEY,
    slot_date DATE NOT NULL,
    start_time TIME(0) NOT NULL,
    end_time TIME(0) NOT NULL
  );


CREATE TABLE
  instructor_timeslot (
    instructor_timeslot_id SERIAL PRIMARY KEY,
    person_id INTEGER NOT NULL,
    slot_id INTEGER NOT NULL,
    is_available BOOLEAN DEFAULT TRUE NOT NULL,
    FOREIGN KEY (person_id) REFERENCES instructor (person_id) ON DELETE CASCADE,
    FOREIGN KEY (slot_id) REFERENCES timeslot (slot_id) ON DELETE CASCADE
  );


CREATE TABLE
  instrument_rental (
    rental_id SERIAL PRIMARY KEY,
    rental_start DATE DEFAULT CURRENT_DATE NOT NULL,
    rental_end DATE DEFAULT (CURRENT_DATE + INTERVAL '12 months') NOT NULL,
    instrument_id INTEGER NOT NULL,
    person_id INTEGER NOT NULL,
    FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id) ON DELETE CASCADE,
    FOREIGN KEY (person_id) REFERENCES student (person_id) ON DELETE CASCADE
  );


CREATE TABLE
  lesson (
    lesson_id SERIAL PRIMARY KEY,
    price_info_id INTEGER NOT NULL,
    instructor_timeslot_id INTEGER NOT NULL,
    room VARCHAR(20),
    FOREIGN KEY (price_info_id) REFERENCES price_info (price_info_id) ON DELETE CASCADE,
    FOREIGN KEY (instructor_timeslot_id) REFERENCES instructor_timeslot (instructor_timeslot_id) ON DELETE CASCADE
  );


CREATE TABLE
  student_lesson (
    person_id INTEGER NOT NULL,
    lesson_id INTEGER NOT NULL,
    CONSTRAINT PK_lesson_student PRIMARY KEY (person_id, lesson_id),
    FOREIGN KEY (person_id) REFERENCES student (person_id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id) ON DELETE CASCADE
  );


--Trigger needed to avoid adding more students than max and remove if not enough students applied
CREATE TABLE
  ensemble (
    lesson_id INT NOT NULL,
    minimum_students INT NOT NULL,
    maximum_students INT NOT NULL,
    target_genre VARCHAR(100),
    FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id) ON DELETE CASCADE,
    CONSTRAINT PK_ensemble PRIMARY KEY (lesson_id)
  );


--Trigger needed remove group_lesson if not enough students applied
CREATE TABLE
  group_lesson (
    lesson_id INT NOT NULL,
    instrument instrument_type NOT NULL,
    minimum_students INT NOT NULL,
    FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id) ON DELETE CASCADE,
    CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id)
  );


CREATE TABLE
  individual_lesson (
    lesson_id INT NOT NULL,
    instrument instrument_type NOT NULL,
    FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id) ON DELETE CASCADE,
    CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id)
  );


--insert 25 students
INSERT INTO
  person (
    person_number,
    first_name,
    last_name,
    phone_number,
    email_address
  )
VALUES
  (
    '000000000001',
    'Darius',
    'Spears',
    '(039) 95442473',
    'eget@aol.net'
  ),
  (
    '000000000002',
    'Hanae',
    'Underwood',
    '(034) 46128851',
    'sed.hendrerit@hotmail.couk'
  ),
  (
    '000000000003',
    'Lyle',
    'Swanson',
    '(025) 89680521',
    'quis.arcu@google.couk'
  ),
  (
    '000000000004',
    'Lee',
    'Gay',
    '(086) 38595576',
    'tincidunt.nibh@icloud.couk'
  ),
  (
    '000000000005',
    'Mia',
    'Johns',
    '(015) 62565217',
    'egestas.aliquam@protonmail.net'
  ),
  (
    '000000000006',
    'Dalton',
    'Conrad',
    '(028) 67937451',
    'tempus@protonmail.net'
  ),
  (
    '000000000007',
    'Sigourney',
    'Padilla',
    '(058) 58215374',
    'donec.est.mauris@outlook.edu'
  ),
  (
    '000000000008',
    'Aquila',
    'Chase',
    '(085) 05368894',
    'est.mauris@google.org'
  ),
  (
    '000000000009',
    'Cruz',
    'Thomas',
    '(011) 61444871',
    'nulla.in.tincidunt@aol.com'
  ),
  (
    '000000000010',
    'Maggie',
    'Henson',
    '(075) 51524806',
    'pede.cras@outlook.net'
  ),
  (
    '000000000011',
    'Dominic',
    'Villarreal',
    '(076) 17516528',
    'nisi.aenean@google.couk'
  ),
  (
    '000000000012',
    'Zahir',
    'Weeks',
    '(037) 51765035',
    'sed.dictum@icloud.net'
  ),
  (
    '000000000013',
    'Trevor',
    'Wheeler',
    '(043) 15675326',
    'orci@yahoo.org'
  ),
  (
    '000000000014',
    'Hunter',
    'Mercer',
    '(014) 78337484',
    'non@google.edu'
  ),
  (
    '000000000015',
    'Signe',
    'Henderson',
    '(044) 82745555',
    'odio.a@yahoo.org'
  ),
  (
    '000000000016',
    'Adria',
    'Durham',
    '(042) 45527324',
    'risus.at.fringilla@hotmail.edu'
  ),
  (
    '000000000017',
    'Kato',
    'Barrera',
    '(082) 71648651',
    'feugiat.lorem.ipsum@protonmail.ca'
  ),
  (
    '000000000018',
    'Wynter',
    'Clarke',
    '(041) 38760564',
    'semper.nam@aol.couk'
  ),
  (
    '000000000019',
    'Colton',
    'Vega',
    '(012) 16995266',
    'tincidunt.neque@hotmail.org'
  ),
  (
    '000000000020',
    'Gannon',
    'Carlson',
    '(075) 47384455',
    'arcu.ac@aol.com'
  ),
  (
    '000000000021',
    'Colby',
    'Avery',
    '(022) 46456312',
    'velit.justo@icloud.net'
  ),
  (
    '000000000022',
    'Rowan',
    'Conley',
    '(012) 24280032',
    'id.enim@protonmail.org'
  ),
  (
    '000000000023',
    'Wayne',
    'Mcclain',
    '(024) 31507308',
    'sed.molestie.sed@icloud.ca'
  ),
  (
    '000000000024',
    'Dean',
    'Cantu',
    '(059) 11691531',
    'urna.suscipit@protonmail.edu'
  ),
  (
    '000000000025',
    'Keiko',
    'Horn',
    '(034) 55661255',
    'sed.dolor@yahoo.com'
  );


INSERT INTO
  student (person_id)
VALUES
  (CURRVAL('person_person_id_seq') - 24),
  (CURRVAL('person_person_id_seq') - 23),
  (CURRVAL('person_person_id_seq') - 22),
  (CURRVAL('person_person_id_seq') - 21),
  (CURRVAL('person_person_id_seq') - 20),
  (CURRVAL('person_person_id_seq') - 19),
  (CURRVAL('person_person_id_seq') - 18),
  (CURRVAL('person_person_id_seq') - 17),
  (CURRVAL('person_person_id_seq') - 16),
  (CURRVAL('person_person_id_seq') - 15),
  (CURRVAL('person_person_id_seq') - 14),
  (CURRVAL('person_person_id_seq') - 13),
  (CURRVAL('person_person_id_seq') - 12),
  (CURRVAL('person_person_id_seq') - 11),
  (CURRVAL('person_person_id_seq') - 10),
  (CURRVAL('person_person_id_seq') - 9),
  (CURRVAL('person_person_id_seq') - 8),
  (CURRVAL('person_person_id_seq') - 7),
  (CURRVAL('person_person_id_seq') - 6),
  (CURRVAL('person_person_id_seq') - 5),
  (CURRVAL('person_person_id_seq') - 4),
  (CURRVAL('person_person_id_seq') - 3),
  (CURRVAL('person_person_id_seq') - 2),
  (CURRVAL('person_person_id_seq') - 1),
  (CURRVAL('person_person_id_seq'));


INSERT INTO
  address (street, zip, city)
VALUES
  ('123 Ac St.', '92518', 'dignissim'),
  ('7430 Metus. Avenue', '78164', 'velit.'),
  ('603-3121 Mauris St.', '88077', 'magnis'),
  ('Ap #126-5711 Ornare, Rd.', '60318', 'nisl.'),
  ('9872 Dolor. Road', '98665', 'Vivamus'),
  ('Ap #546-641 Augue St.', '42667', 'luctus'),
  ('Ap #475-9039 Vitae Rd.', '72329', 'mattis.'),
  ('9334 Morbi Street', '28437', 'vitae,'),
  ('Ap #453-3499 Hendrerit Av.', '98304', 'blandit'),
  (
    'P.O. Box 915, 9414 Donec Av.',
    '24525',
    'lacinia'
  ),
  ('Ap #636-6586 Felis Road', '15154', 'et'),
  ('437-4279 Scelerisque Rd.', '24825', 'elit,'),
  ('Ap #831-4305 Pellentesque Av.', '15909', 'Nunc'),
  (
    'P.O. Box 683, 3690 Rutrum Avenue',
    '81868',
    'Vivamus'
  ),
  ('505-5919 Ridiculus Rd.', '02489', 'vulputate'),
  ('Ap #790-4644 Faucibus Street', '10814', 'nunc'),
  ('261-8151 Proin Rd.', '21146', 'Suspendisse'),
  ('302-2234 Facilisis St.', '64187', 'Quisque'),
  ('1573 Ornare. Ave', '25384', 'Praesent'),
  ('4520 Curabitur Av.', '82545', 'in'),
  ('456-3771 Volutpat Road', '48834', 'fringilla'),
  ('622-6879 Aliquam Av.', '05622', 'magna'),
  ('Ap #614-8176 Aliquam Avenue', '82463', 'nec,'),
  ('655-4208 Suspendisse Ave', '27510', 'interdum'),
  ('P.O. Box 483, 7374 Elit Ave', '46978', 'dictum');


INSERT INTO
  person_address (person_id, address_id)
VALUES
  (
    CURRVAL('person_person_id_seq') - 24,
    CURRVAL('address_address_id_seq') - 24
  ),
  (
    CURRVAL('person_person_id_seq') - 23,
    CURRVAL('address_address_id_seq') - 23
  ),
  (
    CURRVAL('person_person_id_seq') - 22,
    CURRVAL('address_address_id_seq') - 22
  ),
  (
    CURRVAL('person_person_id_seq') - 21,
    CURRVAL('address_address_id_seq') - 21
  ),
  (
    CURRVAL('person_person_id_seq') - 20,
    CURRVAL('address_address_id_seq') - 20
  ),
  (
    CURRVAL('person_person_id_seq') - 19,
    CURRVAL('address_address_id_seq') - 19
  ),
  (
    CURRVAL('person_person_id_seq') - 18,
    CURRVAL('address_address_id_seq') - 18
  ),
  (
    CURRVAL('person_person_id_seq') - 17,
    CURRVAL('address_address_id_seq') - 17
  ),
  (
    CURRVAL('person_person_id_seq') - 16,
    CURRVAL('address_address_id_seq') - 16
  ),
  (
    CURRVAL('person_person_id_seq') - 15,
    CURRVAL('address_address_id_seq') - 15
  ),
  (
    CURRVAL('person_person_id_seq') - 14,
    CURRVAL('address_address_id_seq') - 14
  ),
  (
    CURRVAL('person_person_id_seq') - 13,
    CURRVAL('address_address_id_seq') - 13
  ),
  (
    CURRVAL('person_person_id_seq') - 12,
    CURRVAL('address_address_id_seq') - 12
  ),
  (
    CURRVAL('person_person_id_seq') - 11,
    CURRVAL('address_address_id_seq') - 11
  ),
  (
    CURRVAL('person_person_id_seq') - 10,
    CURRVAL('address_address_id_seq') - 10
  ),
  (
    CURRVAL('person_person_id_seq') - 9,
    CURRVAL('address_address_id_seq') - 9
  ),
  (
    CURRVAL('person_person_id_seq') - 8,
    CURRVAL('address_address_id_seq') - 8
  ),
  (
    CURRVAL('person_person_id_seq') - 7,
    CURRVAL('address_address_id_seq') - 7
  ),
  (
    CURRVAL('person_person_id_seq') - 6,
    CURRVAL('address_address_id_seq') - 6
  ),
  (
    CURRVAL('person_person_id_seq') - 5,
    CURRVAL('address_address_id_seq') - 5
  ),
  (
    CURRVAL('person_person_id_seq') - 4,
    CURRVAL('address_address_id_seq') - 4
  ),
  (
    CURRVAL('person_person_id_seq') - 3,
    CURRVAL('address_address_id_seq') - 3
  ),
  (
    CURRVAL('person_person_id_seq') - 2,
    CURRVAL('address_address_id_seq') - 2
  ),
  (
    CURRVAL('person_person_id_seq') - 1,
    CURRVAL('address_address_id_seq') - 1
  ),
  (
    CURRVAL('person_person_id_seq'),
    CURRVAL('address_address_id_seq')
  );


INSERT INTO
  contact_person (phone_number, person_id, full_name, relationship)
VALUES
  (
    '(014) 24148510',
    CURRVAL('person_person_id_seq') - 24,
    'Jermaine Johns',
    'Father'
  ),
  (
    '(021) 61378213',
    CURRVAL('person_person_id_seq') - 23,
    'Dane Collins',
    'Mother'
  ),
  (
    '(068) 34946525',
    CURRVAL('person_person_id_seq') - 22,
    'Jolie Mcfadden',
    'Friend'
  ),
  (
    '(044) 59391198',
    CURRVAL('person_person_id_seq') - 21,
    'Gage Baird',
    'Sibling'
  ),
  (
    '(009) 60055371',
    CURRVAL('person_person_id_seq') - 20,
    'Fletcher Hoffman',
    'Partner'
  ),
  (
    '(062) 46175515',
    CURRVAL('person_person_id_seq') - 19,
    'Macon Vasquez',
    'Mother'
  ),
  (
    '(075) 81055743',
    CURRVAL('person_person_id_seq') - 18,
    'Xanthus Holder',
    'Father'
  ),
  (
    '(037) 48145592',
    CURRVAL('person_person_id_seq') - 17,
    'Nash Huffman',
    'Mother'
  ),
  (
    '(044) 91555557',
    CURRVAL('person_person_id_seq') - 16,
    'Xandra Briggs',
    'Father'
  ),
  (
    '(016) 31615612',
    CURRVAL('person_person_id_seq') - 15,
    'Noel Buck',
    'Sibling'
  ),
  (
    '(026) 66136522',
    CURRVAL('person_person_id_seq') - 14,
    'Zephania William',
    'Friend'
  ),
  (
    '(017) 32913665',
    CURRVAL('person_person_id_seq') - 13,
    'Colby Benjamin',
    'Mother'
  ),
  (
    '(038) 31376961',
    CURRVAL('person_person_id_seq') - 12,
    'Hiroko Sosa',
    'Father'
  ),
  (
    '(068) 19529585',
    CURRVAL('person_person_id_seq') - 11,
    'Carson Cantrell',
    'Sibling'
  ),
  (
    '(078) 08910564',
    CURRVAL('person_person_id_seq') - 10,
    'Deirdre Lawson',
    'Friend'
  ),
  (
    '(086) 50774165',
    CURRVAL('person_person_id_seq') - 9,
    'Zenaida Navarro',
    'Mother'
  ),
  (
    '(038) 59300209',
    CURRVAL('person_person_id_seq') - 8,
    'Diana O''connor',
    'Father'
  ),
  (
    '(048) 79592646',
    CURRVAL('person_person_id_seq') - 7,
    'Chelsea Hawkins',
    'Sibling'
  ),
  (
    '(064) 03938467',
    CURRVAL('person_person_id_seq') - 6,
    'Brady Palmer',
    'Friend'
  ),
  (
    '(093) 37173680',
    CURRVAL('person_person_id_seq') - 5,
    'Ishmael Thomas',
    'Mother'
  ),
  (
    '(014) 52471372',
    CURRVAL('person_person_id_seq') - 4,
    'Kylynn Dennis',
    'Father'
  ),
  (
    '(082) 74976377',
    CURRVAL('person_person_id_seq') - 3,
    'Lance Carrillo',
    'Sibling'
  ),
  (
    '(004) 85638014',
    CURRVAL('person_person_id_seq') - 2,
    'Jermaine Griffith',
    'Friend'
  ),
  (
    '(051) 25067841',
    CURRVAL('person_person_id_seq') - 1,
    'Xavier Solis',
    'Mother'
  ),
  (
    '(030) 73411218',
    CURRVAL('person_person_id_seq'),
    'Hall Gardner',
    'Father'
  );


--insert 5 siblings, 3 with 2 and 2 with 1
INSERT INTO
  sibling (person_id, sibling_id, relation_type)
VALUES
  (
    CURRVAL('person_person_id_seq') - 24,
    CURRVAL('person_person_id_seq') - 23,
    'Brother'
  ),
  (
    CURRVAL('person_person_id_seq') - 24,
    CURRVAL('person_person_id_seq') - 22,
    'Sister'
  ),
  (
    CURRVAL('person_person_id_seq') - 23,
    CURRVAL('person_person_id_seq') - 24,
    'Sister'
  ),
  (
    CURRVAL('person_person_id_seq') - 23,
    CURRVAL('person_person_id_seq') - 22,
    'Sister'
  ),
  (
    CURRVAL('person_person_id_seq') - 22,
    CURRVAL('person_person_id_seq') - 24,
    'Sister'
  ),
  (
    CURRVAL('person_person_id_seq') - 22,
    CURRVAL('person_person_id_seq') - 23,
    'Sister'
  ),
  (
    CURRVAL('person_person_id_seq') - 20,
    CURRVAL('person_person_id_seq') - 15,
    'Sister'
  ),
  (
    CURRVAL('person_person_id_seq') - 10,
    CURRVAL('person_person_id_seq') - 5,
    'Brother'
  );


-- Insert data for 5 instructors
INSERT INTO
  person (
    person_number,
    first_name,
    last_name,
    phone_number,
    email_address
  )
VALUES
  (
    'IN0000000001',
    'John',
    'Doe',
    '(011) 11111111',
    'john.doe@example.com'
  ),
  (
    'IN0000000002',
    'Jane',
    'Smith',
    '(022) 22222222',
    'jane.smith@example.com'
  ),
  (
    'IN0000000003',
    'Robert',
    'Johnson',
    '(033) 33333333',
    'robert.johnson@example.com'
  ),
  (
    'IN0000000004',
    'Emily',
    'Jones',
    '(044) 44444444',
    'emily.jones@example.com'
  ),
  (
    'IN0000000005',
    'David',
    'Davis',
    '(055) 55555555',
    'david.davis@example.com'
  );


INSERT INTO
  instructor (person_id)
VALUES
  (CURRVAL('person_person_id_seq') - 4),
  (CURRVAL('person_person_id_seq') - 3),
  (CURRVAL('person_person_id_seq') - 2),
  (CURRVAL('person_person_id_seq') - 1),
  (CURRVAL('person_person_id_seq'));


-- Insert data for 5 addresses
INSERT INTO
  address (street, zip, city)
VALUES
  ('123 Instructor St.', '12345', 'Instructorville'),
  ('456 Teaching Ave.', '67890', 'Teachtown'),
  ('789 Lesson Rd.', '98765', 'Lessonburg'),
  ('321 Education Blvd.', '54321', 'Edutown'),
  ('654 Training Ln.', '13579', 'Training City');


-- Link instructors to addresses
INSERT INTO
  person_address (person_id, address_id)
VALUES
  (
    CURRVAL('person_person_id_seq') - 4,
    CURRVAL('address_address_id_seq') - 4
  ),
  (
    CURRVAL('person_person_id_seq') - 3,
    CURRVAL('address_address_id_seq') - 3
  ),
  (
    CURRVAL('person_person_id_seq') - 2,
    CURRVAL('address_address_id_seq') - 2
  ),
  (
    CURRVAL('person_person_id_seq') - 1,
    CURRVAL('address_address_id_seq') - 1
  ),
  (
    CURRVAL('person_person_id_seq'),
    CURRVAL('address_address_id_seq')
  );


--create 10 timeslots
INSERT INTO
  timeslot (slot_date, start_time, end_time)
VALUES
  ('2023-11-22', '09:00:00', '10:00:00'),
  ('2023-11-22', '10:30:00', '11:30:00'),
  ('2023-11-23', '13:00:00', '14:00:00'),
  ('2023-11-23', '14:30:00', '15:30:00'),
  ('2023-11-24', '16:00:00', '17:00:00'),
  ('2023-11-24', '17:30:00', '18:30:00'),
  ('2023-11-25', '09:00:00', '10:00:00'),
  ('2023-11-25', '10:30:00', '11:30:00'),
  ('2023-11-26', '13:00:00', '14:00:00'),
  ('2023-11-26', '14:30:00', '15:30:00');


--map to teachers
INSERT INTO
  instructor_timeslot (person_id, slot_id)
VALUES
  (CURRVAL('person_person_id_seq') - 4, 1),
  (CURRVAL('person_person_id_seq') - 4, 2),
  (CURRVAL('person_person_id_seq') - 4, 3),
  (CURRVAL('person_person_id_seq') - 3, 1),
  (CURRVAL('person_person_id_seq'), 5),
  (CURRVAL('person_person_id_seq') - 1, 6),
  (CURRVAL('person_person_id_seq') - 3, 1),
  (CURRVAL('person_person_id_seq') - 2, 9),
  (CURRVAL('person_person_id_seq') - 1, 10),
  (CURRVAL('person_person_id_seq'), 10);


--create price information table
INSERT INTO
  price_info (
    lesson_type,
    base_price,
    lesson_level,
    starting_date
  )
VALUES
  ('Individual', '70.00', 'Beginner', '2023-01-01'),
  (
    'Individual',
    '75.00',
    'Intermediate',
    '2023-01-15'
  ),
  ('Individual', '80.00', 'Advanced', '2023-02-01'),
  ('Group', '40.00', 'Beginner', '2023-01-01'),
  ('Group', '45.00', 'Intermediate', '2023-01-15'),
  ('Group', '50.00', 'Advanced', '2023-02-01'),
  ('Ensemble', '30.00', NULL, '2023-01-01');


--map available time to a lesson 
--map 7 individual lessons
INSERT INTO
  lesson (price_info_id, instructor_timeslot_id)
VALUES
  (
    1,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -6
  ),
  (
    2,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -5
  ),
  (
    3,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -4
  ),
  (
    1,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -3
  ),
  (
    2,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -2
  ),
  (
    3,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -1
  ),
  (
    1,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -0
  );


-- set is_available = false
UPDATE instructor_timeslot
SET
  is_available = FALSE
WHERE
  (instructor_timeslot_id) IN (
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -6,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -5,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -4,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -3,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -2,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -1,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -0
  );


INSERT INTO
  individual_lesson (lesson_id, instrument)
VALUES
  (CURRVAL('lesson_lesson_id_seq') -6, 'Guitar'),
  (CURRVAL('lesson_lesson_id_seq') -5, 'Piano'),
  (CURRVAL('lesson_lesson_id_seq') -4, 'Violin'),
  (CURRVAL('lesson_lesson_id_seq') -3, 'Drums'),
  (CURRVAL('lesson_lesson_id_seq') -2, 'Guitar'),
  (CURRVAL('lesson_lesson_id_seq') -1, 'Piano'),
  (CURRVAL('lesson_lesson_id_seq') -0, 'Violin');


--create 5 grouplessons
-- Insert 5 new timeslots
INSERT INTO
  timeslot (slot_date, start_time, end_time)
VALUES
  ('2023-11-27', '09:00:00', '10:00:00'),
  ('2023-11-27', '10:30:00', '11:30:00'),
  ('2023-11-28', '13:00:00', '14:00:00'),
  ('2023-11-28', '14:30:00', '15:30:00'),
  ('2023-11-29', '16:00:00', '17:00:00');


--map to teachers
INSERT INTO
  instructor_timeslot (person_id, slot_id, is_available)
VALUES
  (
    CURRVAL('person_person_id_seq') - 4,
    CURRVAL('timeslot_slot_id_seq'),
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq') - 3,
    CURRVAL('timeslot_slot_id_seq') - 1,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq') - 2,
    CURRVAL('timeslot_slot_id_seq') - 2,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq') - 1,
    CURRVAL('timeslot_slot_id_seq') - 3,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq'),
    CURRVAL('timeslot_slot_id_seq') - 4,
    FALSE
  );


--map to lessons
INSERT INTO
  lesson (price_info_id, instructor_timeslot_id, room)
VALUES
  (
    4,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq'),
    'RoomA'
  ),
  (
    4,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 1,
    'RoomB'
  ),
  (
    5,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 2,
    'RoomC'
  ),
  (
    6,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 3,
    'RoomD'
  ),
  (
    6,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 4,
    'RoomE'
  );


INSERT INTO
  group_lesson (lesson_id, instrument, minimum_students)
VALUES
  (CURRVAL('lesson_lesson_id_seq') -6, 'Guitar', 5),
  (CURRVAL('lesson_lesson_id_seq') -5, 'Piano', 4),
  (CURRVAL('lesson_lesson_id_seq') -4, 'Violin', 3),
  (CURRVAL('lesson_lesson_id_seq') -3, 'Drums', 6),
  (CURRVAL('lesson_lesson_id_seq') -2, 'Guitar', 4);


--create 10 ensembles
INSERT INTO
  timeslot (slot_date, start_time, end_time)
VALUES
  ('2023-11-01', '09:00:00', '10:00:00'),
  ('2023-11-02', '10:30:00', '11:30:00'),
  ('2023-11-06', '13:00:00', '14:00:00'),
  ('2023-11-08', '14:30:00', '15:30:00'),
  ('2023-11-13', '16:00:00', '17:00:00'),
  ('2023-11-15', '09:00:00', '10:00:00'),
  ('2023-11-20', '10:30:00', '11:30:00'),
  ('2023-11-22', '13:00:00', '14:00:00'),
  ('2023-11-27', '14:30:00', '15:30:00'),
  ('2023-11-29', '16:00:00', '17:00:00');


-- Map timeslots to teachers
INSERT INTO
  instructor_timeslot (person_id, slot_id, is_available)
VALUES
  (
    CURRVAL('person_person_id_seq') - 4,
    CURRVAL('timeslot_slot_id_seq'),
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq') - 3,
    CURRVAL('timeslot_slot_id_seq') - 1,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq') - 2,
    CURRVAL('timeslot_slot_id_seq') - 2,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq') - 1,
    CURRVAL('timeslot_slot_id_seq') - 3,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq'),
    CURRVAL('timeslot_slot_id_seq') - 4,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq') - 4,
    CURRVAL('timeslot_slot_id_seq') - 5,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq') - 3,
    CURRVAL('timeslot_slot_id_seq') - 6,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq') - 2,
    CURRVAL('timeslot_slot_id_seq') - 7,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq') - 1,
    CURRVAL('timeslot_slot_id_seq') - 8,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq'),
    CURRVAL('timeslot_slot_id_seq') - 9,
    FALSE
  );


-- Map ensemble lessons
INSERT INTO
  lesson (price_info_id, instructor_timeslot_id, room)
VALUES
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq'),
    'RoomA'
  ),
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 1,
    'RoomB'
  ),
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 2,
    'RoomC'
  ),
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 3,
    'RoomD'
  ),
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 4,
    'RoomE'
  ),
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 5,
    'RoomA'
  ),
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 6,
    'RoomB'
  ),
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 7,
    'RoomC'
  ),
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 8,
    'RoomD'
  ),
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 9,
    'RoomE'
  );


INSERT INTO
  ensemble (
    lesson_id,
    minimum_students,
    maximum_students,
    target_genre
  )
VALUES
  (CURRVAL('lesson_lesson_id_seq'), 5, 10, 'Jazz'),
  (
    CURRVAL('lesson_lesson_id_seq') - 1,
    4,
    8,
    'Classical'
  ),
  (
    CURRVAL('lesson_lesson_id_seq') - 2,
    3,
    6,
    'Orchestral'
  ),
  (
    CURRVAL('lesson_lesson_id_seq') - 3,
    6,
    12,
    'Rock'
  ),
  (CURRVAL('lesson_lesson_id_seq') - 4, 4, 8, 'Folk'),
  (
    CURRVAL('lesson_lesson_id_seq') - 5,
    5,
    10,
    'Classical'
  ),
  (
    CURRVAL('lesson_lesson_id_seq') - 6,
    4,
    8,
    'Baroque'
  ),
  (CURRVAL('lesson_lesson_id_seq') - 7, 3, 6, 'Jazz'),
  (
    CURRVAL('lesson_lesson_id_seq') - 8,
    6,
    12,
    'Blues'
  ),
  (CURRVAL('lesson_lesson_id_seq') - 9, 4, 8, 'Pop');


--map students to lessons
INSERT INTO
  student_lesson (person_id, lesson_id)
VALUES
  (CURRVAL('person_person_id_seq') - 24, 1),
  (CURRVAL('person_person_id_seq') - 23, 2),
  (CURRVAL('person_person_id_seq') - 22, 3),
  (CURRVAL('person_person_id_seq') - 21, 4),
  (CURRVAL('person_person_id_seq') - 20, 5),
  (CURRVAL('person_person_id_seq') - 19, 6),
  (CURRVAL('person_person_id_seq') - 18, 7),
  (CURRVAL('person_person_id_seq') - 17, 8),
  (CURRVAL('person_person_id_seq') - 16, 9),
  (CURRVAL('person_person_id_seq') - 15, 10),
  (CURRVAL('person_person_id_seq') - 29, 11),
  (CURRVAL('person_person_id_seq') - 28, 12),
  (CURRVAL('person_person_id_seq') - 22, 13),
  (CURRVAL('person_person_id_seq') - 21, 14),
  (CURRVAL('person_person_id_seq') - 20, 15),
  (CURRVAL('person_person_id_seq') - 19, 10),
  (CURRVAL('person_person_id_seq') - 18, 11),
  (CURRVAL('person_person_id_seq') - 17, 12),
  (CURRVAL('person_person_id_seq') - 16, 13),
  (CURRVAL('person_person_id_seq') - 15, 14);


--inser 8 ensembles for December 
--
INSERT INTO
  timeslot (slot_date, start_time, end_time)
VALUES
  ('2023-12-11', '09:00:00', '10:00:00'), --not used
  ('2023-12-18', '09:00:00', '10:00:00'), --not used
  ('2023-12-11', '09:00:00', '10:00:00'),
  ('2023-12-12', '09:00:00', '10:00:00'),
  ('2023-12-14', '09:00:00', '10:00:00'),
  ('2023-12-15', '09:00:00', '10:00:00'),
  ('2023-12-18', '09:00:00', '10:00:00'),
  ('2023-12-19', '09:00:00', '10:00:00'),
  ('2023-12-21', '09:00:00', '10:00:00'),
  ('2023-12-22', '09:00:00', '10:00:00');


-- Map timeslots to teachers
INSERT INTO
  instructor_timeslot (person_id, slot_id, is_available)
VALUES
  (
    CURRVAL('person_person_id_seq') - 4,
    CURRVAL('timeslot_slot_id_seq') - 7,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq') - 3,
    CURRVAL('timeslot_slot_id_seq') - 6,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq') - 2,
    CURRVAL('timeslot_slot_id_seq') - 5,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq') - 1,
    CURRVAL('timeslot_slot_id_seq') - 4,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq'),
    CURRVAL('timeslot_slot_id_seq') - 3,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq') - 4,
    CURRVAL('timeslot_slot_id_seq') - 2,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq') - 3,
    CURRVAL('timeslot_slot_id_seq') - 1,
    FALSE
  ),
  (
    CURRVAL('person_person_id_seq') - 2,
    CURRVAL('timeslot_slot_id_seq'),
    FALSE
  );


-- Map ensemble lessons
INSERT INTO
  lesson (price_info_id, instructor_timeslot_id)
VALUES
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 7
  ),
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 6
  ),
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 5
  ),
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 4
  ),
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 3
  ),
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 2
  ),
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 1
  ),
  (
    7,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq')
  );


INSERT INTO
  ensemble (
    lesson_id,
    minimum_students,
    maximum_students,
    target_genre
  )
VALUES
  (
    CURRVAL('lesson_lesson_id_seq') - 7,
    5,
    10,
    'Jazz'
  ),
  (
    CURRVAL('lesson_lesson_id_seq') - 6,
    4,
    8,
    'Classical'
  ),
  (
    CURRVAL('lesson_lesson_id_seq') - 5,
    3,
    6,
    'Orchestral'
  ),
  (
    CURRVAL('lesson_lesson_id_seq') - 4,
    6,
    12,
    'Rock'
  ),
  (CURRVAL('lesson_lesson_id_seq') - 3, 4, 8, 'Folk'),
  (
    CURRVAL('lesson_lesson_id_seq') - 2,
    5,
    10,
    'Rock'
  ),
  (
    CURRVAL('lesson_lesson_id_seq') - 1,
    4,
    8,
    'Baroque'
  ),
  (CURRVAL('lesson_lesson_id_seq'), 3, 6, 'Rock');


--map students to new ensembles 
--10students to jazz ensemble making it full 2023-12-11
--7 into classsical leaving one spot  2023-12-12
--4 into orchestral leaving 2 spots 2023-12-14
INSERT INTO
  student_lesson (person_id, lesson_id)
VALUES
  (
    CURRVAL('person_person_id_seq') - 24,
    CURRVAL('lesson_lesson_id_seq') -7
  ),
  (
    CURRVAL('person_person_id_seq') - 23,
    CURRVAL('lesson_lesson_id_seq') -7
  ),
  (
    CURRVAL('person_person_id_seq') - 22,
    CURRVAL('lesson_lesson_id_seq') -7
  ),
  (
    CURRVAL('person_person_id_seq') - 21,
    CURRVAL('lesson_lesson_id_seq') -7
  ),
  (
    CURRVAL('person_person_id_seq') - 20,
    CURRVAL('lesson_lesson_id_seq') -7
  ),
  (
    CURRVAL('person_person_id_seq') - 19,
    CURRVAL('lesson_lesson_id_seq') -7
  ),
  (
    CURRVAL('person_person_id_seq') - 18,
    CURRVAL('lesson_lesson_id_seq') -7
  ),
  (
    CURRVAL('person_person_id_seq') - 17,
    CURRVAL('lesson_lesson_id_seq') -7
  ),
  (
    CURRVAL('person_person_id_seq') - 16,
    CURRVAL('lesson_lesson_id_seq') -7
  ),
  (
    CURRVAL('person_person_id_seq') - 15,
    CURRVAL('lesson_lesson_id_seq') -7
  ),
  (
    CURRVAL('person_person_id_seq') - 29,
    CURRVAL('lesson_lesson_id_seq') -6
  ),
  (
    CURRVAL('person_person_id_seq') - 28,
    CURRVAL('lesson_lesson_id_seq') -6
  ),
  (
    CURRVAL('person_person_id_seq') - 22,
    CURRVAL('lesson_lesson_id_seq') -6
  ),
  (
    CURRVAL('person_person_id_seq') - 21,
    CURRVAL('lesson_lesson_id_seq') -6
  ),
  (
    CURRVAL('person_person_id_seq') - 20,
    CURRVAL('lesson_lesson_id_seq') -6
  ),
  (
    CURRVAL('person_person_id_seq') - 19,
    CURRVAL('lesson_lesson_id_seq') -6
  ),
  (
    CURRVAL('person_person_id_seq') - 18,
    CURRVAL('lesson_lesson_id_seq') -6
  ),
  (
    CURRVAL('person_person_id_seq') - 17,
    CURRVAL('lesson_lesson_id_seq') -5
  ),
  (
    CURRVAL('person_person_id_seq') - 16,
    CURRVAL('lesson_lesson_id_seq') -5
  ),
  (
    CURRVAL('person_person_id_seq') - 15,
    CURRVAL('lesson_lesson_id_seq') -5
  ),
  (
    CURRVAL('person_person_id_seq') - 14,
    CURRVAL('lesson_lesson_id_seq') -5
  );


--Persons:
--25 students 
--3students with 2 siblings
--2students with 1 sibling
--5instructors
--Lessons:
-- total november
-- timeslots: 10+5+10 = 25
-- 7 individual lessons, 5 group 10 ensemble = 22 lessons => 3 available times
-- December
-- 10 timeslots
-- 8 ensembles, 4 2nd week 4 third week
--map students to new ensembles 
--10students to jazz ensemble making it full 2023-12-11
--7 into classsical leaving one spot  2023-12-12
--4 into orchestral leaving 2 spots 2023-12-14
--Total 22+8=30, 18 ensembles