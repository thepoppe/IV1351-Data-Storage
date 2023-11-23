--database fill
INSERT INTO student (person_number, first_name, last_name, phone_number, email_address)
VALUES
  ('000000000001', 'Darius', 'Spears', '(039) 95442473', 'eget@aol.net'),
  ('000000000002', 'Hanae', 'Underwood', '(034) 46128851', 'sed.hendrerit@hotmail.couk'),
  ('000000000003', 'Lyle', 'Swanson', '(025) 89680521', 'quis.arcu@google.couk'),
  ('000000000004', 'Lee', 'Gay', '(086) 38595576', 'tincidunt.nibh@icloud.couk'),
  ('000000000005', 'Mia', 'Johns', '(015) 62565217', 'egestas.aliquam@protonmail.net'),
  ('000000000006', 'Dalton', 'Conrad', '(028) 67937451', 'tempus@protonmail.net'),
  ('000000000007', 'Sigourney', 'Padilla', '(058) 58215374', 'donec.est.mauris@outlook.edu'),
  ('000000000008', 'Aquila', 'Chase', '(085) 05368894', 'est.mauris@google.org'),
  ('000000000009', 'Cruz', 'Thomas', '(011) 61444871', 'nulla.in.tincidunt@aol.com'),
  ('000000000010', 'Maggie', 'Henson', '(075) 51524806', 'pede.cras@outlook.net'),
  ('000000000011', 'Dominic', 'Villarreal', '(076) 17516528', 'nisi.aenean@google.couk'),
  ('000000000012', 'Zahir', 'Weeks', '(037) 51765035', 'sed.dictum@icloud.net'),
  ('000000000013', 'Trevor', 'Wheeler', '(043) 15675326', 'orci@yahoo.org'),
  ('000000000014', 'Hunter', 'Mercer', '(014) 78337484', 'non@google.edu'),
  ('000000000015', 'Signe', 'Henderson', '(044) 82745555', 'odio.a@yahoo.org'),
  ('000000000016', 'Adria', 'Durham', '(042) 45527324', 'risus.at.fringilla@hotmail.edu'),
  ('000000000017', 'Kato', 'Barrera', '(082) 71648651', 'feugiat.lorem.ipsum@protonmail.ca'),
  ('000000000018', 'Wynter', 'Clarke', '(041) 38760564', 'semper.nam@aol.couk'),
  ('000000000019', 'Colton', 'Vega', '(012) 16995266', 'tincidunt.neque@hotmail.org'),
  ('000000000020', 'Gannon', 'Carlson', '(075) 47384455', 'arcu.ac@aol.com'),
  ('000000000021', 'Colby', 'Avery', '(022) 46456312', 'velit.justo@icloud.net'),
  ('000000000022', 'Rowan', 'Conley', '(012) 24280032', 'id.enim@protonmail.org'),
  ('000000000023', 'Wayne', 'Mcclain', '(024) 31507308', 'sed.molestie.sed@icloud.ca'),
  ('000000000024', 'Dean', 'Cantu', '(059) 11691531', 'urna.suscipit@protonmail.edu'),
  ('000000000025', 'Keiko', 'Horn', '(034) 55661255', 'sed.dolor@yahoo.com');

INSERT INTO address (street, zip, city)
VALUES
  ('123 Ac St.','92518','dignissim'),
  ('7430 Metus. Avenue','78164','velit.'),
  ('603-3121 Mauris St.','88077','magnis'),
  ('Ap #126-5711 Ornare, Rd.','60318','nisl.'),
  ('9872 Dolor. Road','98665','Vivamus'),
  ('Ap #546-641 Augue St.','42667','luctus'),
  ('Ap #475-9039 Vitae Rd.','72329','mattis.'),
  ('9334 Morbi Street','28437','vitae,'),
  ('Ap #453-3499 Hendrerit Av.','98304','blandit'),
  ('P.O. Box 915, 9414 Donec Av.','24525','lacinia'),
  ('Ap #636-6586 Felis Road','15154','et'),
  ('437-4279 Scelerisque Rd.','24825','elit,'),
  ('Ap #831-4305 Pellentesque Av.','15909','Nunc'),
  ('P.O. Box 683, 3690 Rutrum Avenue','81868','Vivamus'),
  ('505-5919 Ridiculus Rd.','02489','vulputate'),
  ('Ap #790-4644 Faucibus Street','10814','nunc'),
  ('261-8151 Proin Rd.','21146','Suspendisse'),
  ('302-2234 Facilisis St.','64187','Quisque'),
  ('1573 Ornare. Ave','25384','Praesent'),
  ('4520 Curabitur Av.','82545','in'),
  ('456-3771 Volutpat Road','48834','fringilla'),
  ('622-6879 Aliquam Av.','05622','magna'),
  ('Ap #614-8176 Aliquam Avenue','82463','nec,'),
  ('655-4208 Suspendisse Ave','27510','interdum'),
  ('P.O. Box 483, 7374 Elit Ave','46978','dictum');

INSERT INTO person_address (person_id, address_id)
VALUES
  (currval('person_person_id_seq') - 24, currval('address_address_id_seq') - 24),
  (currval('person_person_id_seq') - 23, currval('address_address_id_seq') - 23),
  (currval('person_person_id_seq') - 22, currval('address_address_id_seq') - 22),
  (currval('person_person_id_seq') - 21, currval('address_address_id_seq') - 21),
  (currval('person_person_id_seq') - 20, currval('address_address_id_seq') - 20),
  (currval('person_person_id_seq') - 19, currval('address_address_id_seq') - 19),
  (currval('person_person_id_seq') - 18, currval('address_address_id_seq') - 18),
  (currval('person_person_id_seq') - 17, currval('address_address_id_seq') - 17),
  (currval('person_person_id_seq') - 16, currval('address_address_id_seq') - 16),
  (currval('person_person_id_seq') - 15, currval('address_address_id_seq') - 15),
  (currval('person_person_id_seq') - 14, currval('address_address_id_seq') - 14),
  (currval('person_person_id_seq') - 13, currval('address_address_id_seq') - 13),
  (currval('person_person_id_seq') - 12, currval('address_address_id_seq') - 12),
  (currval('person_person_id_seq') - 11, currval('address_address_id_seq') - 11),
  (currval('person_person_id_seq') - 10, currval('address_address_id_seq') - 10),
  (currval('person_person_id_seq') - 9 , currval('address_address_id_seq') - 9),
  (currval('person_person_id_seq') - 8 , currval('address_address_id_seq') - 8),
  (currval('person_person_id_seq') - 7 , currval('address_address_id_seq') - 7),
  (currval('person_person_id_seq') - 6 , currval('address_address_id_seq') - 6),
  (currval('person_person_id_seq') - 5 , currval('address_address_id_seq') - 5),
  (currval('person_person_id_seq') - 4 , currval('address_address_id_seq') - 4),
  (currval('person_person_id_seq') - 3 , currval('address_address_id_seq') - 3),
  (currval('person_person_id_seq') - 2 , currval('address_address_id_seq') - 2),
  (currval('person_person_id_seq') - 1 , currval('address_address_id_seq') - 1),
  (currval('person_person_id_seq')     , currval('address_address_id_seq') );





INSERT INTO contact_person (phone_number, person_id, full_name, relationship)
VALUES
  ('(014) 24148510', currval('person_person_id_seq') - 24, 'Jermaine Johns', 'Father'),
  ('(021) 61378213', currval('person_person_id_seq') - 23, 'Dane Collins', 'Mother'),
  ('(068) 34946525', currval('person_person_id_seq') - 22, 'Jolie Mcfadden', 'Friend'),
  ('(044) 59391198', currval('person_person_id_seq') - 21, 'Gage Baird', 'Sibling'),
  ('(009) 60055371', currval('person_person_id_seq') - 20, 'Fletcher Hoffman', 'Partner'),
  ('(062) 46175515', currval('person_person_id_seq') - 19, 'Macon Vasquez', 'Mother'),
  ('(075) 81055743', currval('person_person_id_seq') - 18, 'Xanthus Holder', 'Father'),
  ('(037) 48145592', currval('person_person_id_seq') - 17, 'Nash Huffman', 'Mother'),
  ('(044) 91555557', currval('person_person_id_seq') - 16, 'Xandra Briggs', 'Father'),
  ('(016) 31615612', currval('person_person_id_seq') - 15, 'Noel Buck', 'Sibling'),
  ('(026) 66136522', currval('person_person_id_seq') - 14, 'Zephania William', 'Friend'),
  ('(017) 32913665', currval('person_person_id_seq') - 13, 'Colby Benjamin', 'Mother'),
  ('(038) 31376961', currval('person_person_id_seq') - 12, 'Hiroko Sosa', 'Father'),
  ('(068) 19529585', currval('person_person_id_seq') - 11, 'Carson Cantrell', 'Sibling'),
  ('(078) 08910564', currval('person_person_id_seq') - 10, 'Deirdre Lawson', 'Friend'),
  ('(086) 50774165', currval('person_person_id_seq') - 9 , 'Zenaida Navarro', 'Mother'),
  ('(038) 59300209', currval('person_person_id_seq') - 8 , 'Diana O''connor', 'Father'),
  ('(048) 79592646', currval('person_person_id_seq') - 7 , 'Chelsea Hawkins', 'Sibling'),
  ('(064) 03938467', currval('person_person_id_seq') - 6 , 'Brady Palmer', 'Friend'),
  ('(093) 37173680', currval('person_person_id_seq') - 5 , 'Ishmael Thomas', 'Mother'),
  ('(014) 52471372', currval('person_person_id_seq') - 4 , 'Kylynn Dennis', 'Father'),
  ('(082) 74976377', currval('person_person_id_seq') - 3 , 'Lance Carrillo', 'Sibling'),
  ('(004) 85638014', currval('person_person_id_seq') - 2 , 'Jermaine Griffith', 'Friend'),
  ('(051) 25067841', currval('person_person_id_seq') - 1 , 'Xavier Solis', 'Mother'),
  ('(030) 73411218', currval('person_person_id_seq')     , 'Hall Gardner', 'Father');



-- Insert data for 5 instructors
INSERT INTO instructor (person_number, first_name, last_name, phone_number, email_address)
VALUES
  ('IN0000000001', 'John', 'Doe', '(011) 11111111', 'john.doe@example.com'),
  ('IN0000000002', 'Jane', 'Smith', '(022) 22222222', 'jane.smith@example.com'),
  ('IN0000000003', 'Robert', 'Johnson', '(033) 33333333', 'robert.johnson@example.com'),
  ('IN0000000004', 'Emily', 'Jones', '(044) 44444444', 'emily.jones@example.com'),
  ('IN0000000005', 'David', 'Davis', '(055) 55555555', 'david.davis@example.com');

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
  (currval('person_person_id_seq') - 4 , currval('address_address_id_seq') - 4),
  (currval('person_person_id_seq') - 3 , currval('address_address_id_seq') - 3),
  (currval('person_person_id_seq') - 2 , currval('address_address_id_seq') - 2),
  (currval('person_person_id_seq') - 1 , currval('address_address_id_seq') - 1),
  (currval('person_person_id_seq')     , currval('address_address_id_seq') );



--adding sibling
insert into sibling(person_id,sibling_id,relation_type)
values 
  (currval('person_person_id_seq') - 29,currval('person_person_id_seq') - 28, 'Brother'),
  (currval('person_person_id_seq') - 29,currval('person_person_id_seq') - 27, 'Sister'),
  (currval('person_person_id_seq') - 28,currval('person_person_id_seq') - 28, 'Sister'),
  (currval('person_person_id_seq') - 25,currval('person_person_id_seq') - 20, 'Sister'),
  (currval('person_person_id_seq') - 19,currval('person_person_id_seq') - 18, 'Brother');




--general insert for student with all new
INSERT INTO student (person_number, first_name,last_name,phone_number,email_address)
VALUES('personnumber','some_name','some_surname','some_phone1','some_email1');

INSERT INTO address (street, zip, city)
VALUES('some_street','zip','some_city');

INSERT INTO person_address (person_id, address_id)
VALUES (currval('person_person_id_seq'), currval('address_address_id_seq'));

INSERT INTO contact_person (phone_number, person_id, full_name, relationship)
VALUES  ('some_phone', currval('person_person_id_seq'), 'some_name', 'some_realtion');



--general insert with all new
INSERT INTO instructor (person_number, first_name,last_name,phone_number,email_address)
VALUES('personnumbe1','some_instructor_name','some_surname','some_phone2','some_email2');

INSERT INTO address (street, zip, city)
VALUES('some_street','zip','some_city');

INSERT INTO person_address (person_id, address_id)
VALUES (currval('person_person_id_seq'), currval('address_address_id_seq'));