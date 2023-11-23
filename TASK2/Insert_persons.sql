--database fill
INSERT INTO student (first_name,last_name,phone_number,email_address)
VALUES
  ('Darius','Spears','(039) 95442473','eget@aol.net'),
  ('Hanae','Underwood','(034) 46128851','sed.hendrerit@hotmail.couk'),
  ('Lyle','Swanson','(025) 89680521','quis.arcu@google.couk'),
  ('Lee','Gay','(086) 38595576','tincidunt.nibh@icloud.couk'),
  ('Mia','Johns','(015) 62565217','egestas.aliquam@protonmail.net'),
  ('Dalton','Conrad','(028) 67937451','tempus@protonmail.net'),
  ('Sigourney','Padilla','(058) 58215374','donec.est.mauris@outlook.edu'),
  ('Aquila','Chase','(085) 05368894','est.mauris@google.org'),
  ('Cruz','Thomas','(011) 61444871','nulla.in.tincidunt@aol.com'),
  ('Maggie','Henson','(075) 51524806','pede.cras@outlook.net'),
  ('Dominic','Villarreal','(076) 17516528','nisi.aenean@google.couk'),
  ('Zahir','Weeks','(037) 51765035','sed.dictum@icloud.net'),
  ('Trevor','Wheeler','(043) 15675326','orci@yahoo.org'),
  ('Hunter','Mercer','(014) 78337484','non@google.edu'),
  ('Signe','Henderson','(044) 82745555','odio.a@yahoo.org'),
  ('Adria','Durham','(042) 45527324','risus.at.fringilla@hotmail.edu'),
  ('Kato','Barrera','(082) 71648651','feugiat.lorem.ipsum@protonmail.ca'),
  ('Wynter','Clarke','(041) 38760564','semper.nam@aol.couk'),
  ('Colton','Vega','(012) 16995266','tincidunt.neque@hotmail.org'),
  ('Gannon','Carlson','(075) 47384455','arcu.ac@aol.com'),
  ('Colby','Avery','(022) 46456312','velit.justo@icloud.net'),
  ('Rowan','Conley','(012) 24280032','id.enim@protonmail.org'),
  ('Wayne','Mcclain','(024) 31507308','sed.molestie.sed@icloud.ca'),
  ('Dean','Cantu','(059) 11691531','urna.suscipit@protonmail.edu'),
  ('Keiko','Horn','(034) 55661255','sed.dolor@yahoo.com');

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
  (101,151),
  (102,152),
  (103,153),
  (104,154),
  (105,155),
  (106,156),
  (107,157),
  (108,158),
  (109,159),
  (110,160),
  (111,161),
  (112,162),
  (113,163),
  (114,164),
  (115,165),
  (116,166),
  (117,167),
  (118,168),
  (119,169),
  (120,170),
  (121,171),
  (122,172),
  (123,173),
  (124,174),
  (125,175);



INSERT INTO contact_person (phone_number, person_id, full_name, relationship)
VALUES
  ('(014) 24148510', 101, 'Jermaine Johns', 'Father'),
  ('(021) 61378213', 102, 'Dane Collins', 'Mother'),
  ('(068) 34946525', 103, 'Jolie Mcfadden', 'Friend'),
  ('(044) 59391198', 104, 'Gage Baird', 'Sibling'),
  ('(009) 60055371', 105, 'Fletcher Hoffman', 'Partner'),
  ('(062) 46175515', 106, 'Macon Vasquez', 'Mother'),
  ('(075) 81055743', 107, 'Xanthus Holder', 'Father'),
  ('(037) 48145592', 108, 'Nash Huffman', 'Mother'),
  ('(044) 91555557', 109, 'Xandra Briggs', 'Father'),
  ('(016) 31615612', 110, 'Noel Buck', 'Sibling'),
  ('(026) 66136522', 111, 'Zephania William', 'Friend'),
  ('(017) 32913665', 112, 'Colby Benjamin', 'Mother'),
  ('(038) 31376961', 113, 'Hiroko Sosa', 'Father'),
  ('(068) 19529585', 114, 'Carson Cantrell', 'Sibling'),
  ('(078) 08910564', 115, 'Deirdre Lawson', 'Friend'),
  ('(086) 50774165', 116, 'Zenaida Navarro', 'Mother'),
  ('(038) 59300209', 117, 'Diana O''connor', 'Father'),
  ('(048) 79592646', 118, 'Chelsea Hawkins', 'Sibling'),
  ('(064) 03938467', 119, 'Brady Palmer', 'Friend'),
  ('(093) 37173680', 120, 'Ishmael Thomas', 'Mother'),
  ('(014) 52471372', 121, 'Kylynn Dennis', 'Father'),
  ('(082) 74976377', 122, 'Lance Carrillo', 'Sibling'),
  ('(004) 85638014', 123, 'Jermaine Griffith', 'Friend'),
  ('(051) 25067841', 124, 'Xavier Solis', 'Mother'),
  ('(030) 73411218', 125, 'Hall Gardner', 'Father');



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




--adding sibling
insert into sibling(person_id,sibling_id,relation_type)
values 
  (101,102, 'Brother'),
  (101,103, 'Sister'),
  (105,110, 'Sister'),
  (111,112, 'Sister'),
  (124,125, 'Brother');

insert into sibling(person_id,sibling_id)
values(102,103);


--general insert for student with all new
INSERT INTO student (person_number, first_name,last_name,phone_number,email_address)
VALUES('personnumber','some_name','some_surname','some_phone','some_email');

INSERT INTO address (street, zip, city)
VALUES('some_street','zip','some_city');

INSERT INTO person_address (person_id, address_id)
VALUES (currval('person_person_id_seq'), currval('address_id_seq'));

INSERT INTO contact_person (phone_number, person_id, full_name, relationship)
VALUES  ('some_phone', currval('person_person_id_seq'), 'some_name', 'some_realtion');



--general insert with all new
INSERT INTO student (person_number, first_name,last_name,phone_number,email_address)
VALUES('personnumber','some_instructor_name','some_surname','some_phone','some_email');

INSERT INTO address (street, zip, city)
VALUES('some_street','zip','some_city');

INSERT INTO person_address (person_id, address_id)
VALUES (currval('person_person_id_seq'), currval('address_id_seq'));