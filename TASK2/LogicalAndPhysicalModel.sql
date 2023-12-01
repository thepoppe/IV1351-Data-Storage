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