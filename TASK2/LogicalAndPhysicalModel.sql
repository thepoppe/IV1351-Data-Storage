--Type configs
CREATE TYPE instrument_type AS ENUM ('Guitar', 'Piano', 'Violin', 'Drums', 'Other');
CREATE TYPE level_type AS ENUM ('Beginner', 'Intermediate', 'Advanced');
CREATE TYPE lesson_type AS ENUM ('Individual', 'Group', 'Ensemble');


--Table configs
CREATE TABLE address (
 address_id SERIAL PRIMARY KEY,
 street VARCHAR(200) NOT NULL,
 zip VARCHAR(5) NOT NULL,
 city VARCHAR(100) NOT NULL
);



CREATE TABLE person (
 person_id SERIAL PRIMARY KEY,
 person_number CHAR(12) UNIQUE NOT NULL, 
 first_name VARCHAR(100) NOT NULL,
 last_name VARCHAR(100) NOT NULL,
 phone_number VARCHAR(20) UNIQUE NOT NULL, --global unique trigger possibly needed
 email_address VARCHAR(100) UNIQUE NOT NULL --global unique trigger possibly needed
);


CREATE TABLE person_address (
    person_address_id SERIAL PRIMARY KEY,
    person_id Integer NOT NULL,
    address_id INteger NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(person_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);
--FKs dont allow polulation
ALTER TABLE person_address
DROP CONSTRAINT person_address_person_id_fkey;


CREATE TABLE price_info (
 price_info_id SERIAL PRIMARY KEY,
 lesson_type lesson_type NOT NULL,
 base_price VARCHAR(10) NOT NULL,
 lesson_level level_type,
 starting_date DATE NOT NULL,
 end_date DATE
);



CREATE TABLE instrument (
 instrument_id SERIAL PRIMARY KEY,
 instrument_type instrument_type NOT NULL,
 brand VARCHAR(100),
 price VARCHAR(10) NOT NULL,
 quantity_in_stock INTEGER,
 description VARCHAR(500)
);



CREATE TABLE student (
 student_id SERIAL NOT NULL,
 enrollment_date DATE DEFAULT CURRENT_DATE NOT NULL
)INHERITS(person);
ALTER TABLE student ADD CONSTRAINT unique_student_person_id UNIQUE (person_id);


CREATE TABLE timeslot (
 slot_id SERIAL PRIMARY KEY,
 slot_date DATE NOT NULL,
 start_time TIME(0) NOT NULL,
 end_time TIME(0) NOT NULL
);



CREATE TABLE contact_person (
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    person_id INTEGER NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    relationship VARCHAR(20),
    CONSTRAINT PK_contact_person PRIMARY KEY (phone_number, person_id),
    FOREIGN KEY (person_id) REFERENCES student(person_id)
);




CREATE TABLE instructor (
 instructor_id SERIAL NOT NULL
)INHERITS(person);
ALTER TABLE instructor ADD CONSTRAINT unique_instructor_person_id UNIQUE (person_id);


CREATE TABLE instructor_timeslot (
    instructor_timeslot_id SERIAL PRIMARY KEY,
    person_id INTEGER NOT NULL,
    slot_id INTEGER NOT NULL,
    is_available BOOLEAN DEFAULT TRUE NOT NULL,
    FOREIGN KEY (person_id) REFERENCES instructor (person_id),
    FOREIGN KEY (slot_id) REFERENCES timeslot (slot_id)
);


CREATE TABLE instrument_rental (
    rental_id SERIAL PRIMARY KEY,
    rental_start DATE DEFAULT CURRENT_DATE NOT NULL,
    rental_end DATE DEFAULT (CURRENT_DATE + INTERVAL '12 months') NOT NULL,
    instrument_id INTEGER NOT NULL,
    person_id Integer NOT NULL,
    FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id),
    FOREIGN KEY (person_id) REFERENCES student (person_id)
);




CREATE TABLE lesson (
    lesson_id SERIAL PRIMARY KEY,
    price_info_id INTEGER NOT NULL,
    instructor_timeslot_id INTEGER NOT NULL,
    room VARCHAR(20),
    FOREIGN KEY (price_info_id) REFERENCES price_info (price_info_id),
    FOREIGN KEY (instructor_timeslot_id) REFERENCES instructor_timeslot (instructor_timeslot_id)
);



CREATE TABLE student_lesson (
    person_id INTEGER NOT NULL,
    lesson_id INTEGER NOT NULL,
    CONSTRAINT PK_lesson_student PRIMARY KEY (person_id, lesson_id),
    FOREIGN KEY (person_id) REFERENCES student (person_id),
    FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id)
);
--FKs dont allow polulation
ALTER TABLE student_lesson
DROP CONSTRAINT student_lesson_person_id_fkey,
DROP CONSTRAINT student_lesson_lesson_id_fkey;





CREATE TABLE sibling (
 person_id INTEGER NOT NULL,
 sibling_id INTEGER NOT NULL,
 relation_type VARCHAR(10),
 CONSTRAINT PK_sibling PRIMARY KEY (person_id,sibling_id),
 FOREIGN KEY (person_id) REFERENCES student (person_id),
 FOREIGN KEY (sibling_id) REFERENCES student (person_id)
);



--Trigger needed to avoid adding more students than max and remove if not enough students applied
CREATE TABLE ensemble (
 minimum_students VARCHAR(10) NOT NULL,
 maximum_students VARCHAR(10) NOT NULL,
 target_genre VARCHAR(100)
)INHERITS(lesson);
ALTER TABLE ensemble ADD CONSTRAINT unique_ensemble_id UNIQUE (lesson_id);


--Trigger needed remove group_lesson if not enough students applied
CREATE TABLE group_lesson (
 instrument instrument_type NOT NULL,
 minimum_students VARCHAR(100) NOT NULL
)INHERITS(lesson);
ALTER TABLE group_lesson ADD CONSTRAINT unique_group_lesson_id UNIQUE (lesson_id);


CREATE TABLE individual_lesson (
 instrument instrument_type NOT NULL
)INHERITS(lesson);
ALTER TABLE individual_lesson ADD CONSTRAINT unique_individual_lesson_id UNIQUE (lesson_id);