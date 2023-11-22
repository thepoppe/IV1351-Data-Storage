--Type configs
CREATE TYPE instrument_type AS ENUM ('Guitar', 'Piano', 'Violin', 'Drums', 'Other');
CREATE TYPE level_type AS ENUM ('Beginner', 'Intermiediate', 'Advanced');
CREATE TYPE lesson_type AS ENUM ('Individual', 'Group', 'Ensemble');


--Table configs
CREATE TABLE address (
 address_id SERIAL NOT NULL,
 street VARCHAR(200) NOT NULL,
 zip VARCHAR(5) NOT NULL,
 city VARCHAR(100) NOT NULL
);
ALTER TABLE address ADD CONSTRAINT PK_address PRIMARY KEY (id);


CREATE TABLE person (
 person_id SERIAL NOT NULL,
 person_number VARCHAR(12) UNIQUE, --global unique trigger
 first_name VARCHAR(100) NOT NULL,
 last_name VARCHAR(100) NOT NULL,
 phone_number VARCHAR(20) UNIQUE NOT NULL, --global unique trigger
 email_address VARCHAR(100) UNIQUE NOT NULL --global unique trigger
);
ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (person_id);


CREATE TABLE person_address (
 person_id SERIAL NOT NULL,
 address_id SERIAL NOT NULL
);
ALTER TABLE person_address ADD CONSTRAINT PK_person_address PRIMARY KEY (person_id,address_id);


CREATE TABLE price_info (
 price_info_id SERIAL NOT NULL,
 lesson_type lesson_type NOT NULL,
 base_price VARCHAR(10) NOT NULL,
 lesson_level level_type,
 starting_date DATE NOT NULL,
 end_date DATE
);
ALTER TABLE price_info ADD CONSTRAINT PK_price_info PRIMARY KEY (price_info_id);


CREATE TABLE rental_instrument (
 instrument_id SERIAL NOT NULL,
 instrument instrument_type NOT NULL,
 brand VARCHAR(100),
 price VARCHAR(10) NOT NULL,
 quantity_in_stock VARCHAR(10) NOT NULL
);
ALTER TABLE rental_instrument ADD CONSTRAINT PK_rental_instrument PRIMARY KEY (instrument_id);


CREATE TABLE student (
 person_id SERIAL NOT NULL,
 student_id SERIAL NOT NULL,
 enrollment_date DATE DEFAULT CURRENT_DATE NOT NULL
)INHERITS(person);
ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (person_id);


CREATE TABLE timeslot (
 slot_id SERIAL NOT NULL,
 slot_date DATE NOT NULL,
 start_time TIME(0) NOT NULL,
 end_time TIME(0) NOT NULL
);
ALTER TABLE timeslot ADD CONSTRAINT PK_timeslot PRIMARY KEY (slot_id);


CREATE TABLE contact_person (
 phone_number VARCHAR(20) UNIQUE NOT NULL, --global unique trigger
 person_id SERIAL NOT NULL,
 full_name VARCHAR(100) NOT NULL,
 relationship VARCHAR(20)
);
ALTER TABLE contact_person ADD CONSTRAINT PK_contact_person PRIMARY KEY (phone_number,person_id);


CREATE TABLE instructor (
 person_id SERIAL NOT NULL,
 instructor_id SERIAL NOT NULL
)INHERITS(person);
ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (person_id);


CREATE TABLE instructor_timeslot (
 person_id SERIAL NOT NULL,
 slot_id SERIAL NOT NULL,
 is_available BOOLEAN DEFAULT TRUE NOT NULL
);
ALTER TABLE instructor_timeslot ADD CONSTRAINT PK_instructor_timeslot PRIMARY KEY (person_id,slot_id);


CREATE TABLE instrument_rental (
 rental_id SERIAL NOT NULL,
 rental_start DATE DEFAULT CURRENT_DATE NOT NULL,
 rental_end DATE DEFAULT (CURRENT_DATE + INTERVAL '12 months') NOT NULL,
 instrument_id SERIAL NOT NULL,
 person_id SERIAL NOT NULL
);
ALTER TABLE instrument_rental ADD CONSTRAINT PK_instrument_rental PRIMARY KEY (rental_id);


CREATE TABLE lesson (
 lesson_id SERIAL NOT NULL,
 price_info_id SERIAL NOT NULL,
 person_id SERIAL NOT NULL,
 slot_id SERIAL NOT NULL,
 room varCHAR(20)
);
ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (lesson_id);


CREATE TABLE lesson_student (
 person_id SERIAL NOT NULL,
 lesson_id SERIAL NOT NULL
);
ALTER TABLE lesson_student ADD CONSTRAINT PK_lesson_student PRIMARY KEY (person_id,lesson_id);


CREATE TABLE sibling (
 person_id SERIAL NOT NULL,
 sibling_id SERIAL NOT NULL,
 relation_type VARCHAR(10)
);
ALTER TABLE sibling ADD CONSTRAINT PK_sibling PRIMARY KEY (person_id,sibling_id);


CREATE TABLE skill (
 person_id SERIAL NOT NULL,
 skill_level level_type NOT NULL,
 instrument instrument_type NOT NULL
);
ALTER TABLE skill ADD CONSTRAINT PK_skill PRIMARY KEY (person_id);


--Trigger needed to avoid adding more students than max and remove if not enough students applied
CREATE TABLE ensemble (
 lesson_id SERIAL NOT NULL,
 minimum_students VARCHAR(10) NOT NULL,
 maximum_students VARCHAR(10) NOT NULL,
 target_genre VARCHAR(100)
);
ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (lesson_id);


--Trigger needed remove group_lesson if not enough students applied
CREATE TABLE group_lesson (
 lesson_id SERIAL NOT NULL,
 instrument VARCHAR(100) NOT NULL,
 minimum_students VARCHAR(100) NOT NULL
);
ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


CREATE TABLE individual_lesson (
 lesson_id SERIAL NOT NULL,
 instrument VARCHAR(100) NOT NULL
);
ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id);


--FK assigning
--ALTER TABLE person_address ADD CONSTRAINT FK_person_address_0 FOREIGN KEY (person_id) REFERENCES person (person_id); --removed for functionality
--ALTER TABLE person_address ADD CONSTRAINT FK_person_address_1 FOREIGN KEY (address_id) REFERENCES address (id); --removed for functionality




ALTER TABLE contact_person ADD CONSTRAINT FK_contact_person_0 FOREIGN KEY (person_id) REFERENCES student (person_id);




ALTER TABLE instructor_timeslot ADD CONSTRAINT FK_instructor_timeslot_0 FOREIGN KEY (person_id) REFERENCES instructor (person_id);
ALTER TABLE instructor_timeslot ADD CONSTRAINT FK_instructor_timeslot_1 FOREIGN KEY (slot_id) REFERENCES timeslot (slot_id);


ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_0 FOREIGN KEY (instrument_id) REFERENCES rental_instrument (instrument_id);
ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_1 FOREIGN KEY (person_id) REFERENCES student (person_id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (price_info_id) REFERENCES price_info (price_info_id);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (person_id,slot_id) REFERENCES instructor_timeslot (person_id,slot_id);


ALTER TABLE lesson_student ADD CONSTRAINT FK_lesson_student_0 FOREIGN KEY (person_id) REFERENCES student (person_id);
ALTER TABLE lesson_student ADD CONSTRAINT FK_lesson_student_1 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


ALTER TABLE sibling ADD CONSTRAINT FK_sibling_0 FOREIGN KEY (person_id) REFERENCES student (person_id);
ALTER TABLE sibling ADD CONSTRAINT FK_sibling_1 FOREIGN KEY (sibling_id) REFERENCES student (person_id);


ALTER TABLE skill ADD CONSTRAINT FK_skill_0 FOREIGN KEY (person_id) REFERENCES student (person_id);


ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


