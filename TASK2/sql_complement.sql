-- To populate the database exhange price_info and student tables in LogicalAndPhysicalModel.sql
-- to the new ones. exchange the pricetable insertion with the new priceinfo below in Insert_lessons.sql
--Changed tables, the rest are uncahnged
CREATE TABLE
    price_info (
        price_info_id SERIAL PRIMARY KEY,
        lesson_type lesson_type NOT NULL,
        base_price VARCHAR(10) NOT NULL,
        sibling_discount INT NOT NULL CHECK (
            sibling_discount >= 0
            AND sibling_discount <= 100
        ),
        instructor_payment VARCHAR(10) NOT NULL,
        lesson_level level_type,
        starting_date DATE NOT NULL,
        end_date DATE
    );


CREATE TABLE
    student (
        person_id INT NOT NULL,
        student_id SERIAL NOT NULL,
        enrollment_date DATE DEFAULT CURRENT_DATE NOT NULL,
        max_rentals INT NOT NULL DEFAULT 2 CHECK (max_rentals >= 0),
        FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE,
        CONSTRAINT PK_student PRIMARY KEY (person_id)
    );


--changes to insert_lessons.sql
--create price information table 
INSERT INTO
    price_info (
        lesson_type,
        base_price,
        sibling_discount,
        instructor_payment,
        lesson_level,
        starting_date
    )
VALUES
    (
        'Individual',
        '70.00',
        25,
        '50',
        'Beginner',
        '2023-01-01'
    ),
    (
        'Individual',
        '75.00',
        25,
        '60',
        'Intermediate',
        '2023-01-15'
    ),
    (
        'Individual',
        '80.00',
        25,
        '70',
        'Advanced',
        '2023-02-01'
    ),
    (
        'Group',
        '40.00',
        25,
        '100',
        'Beginner',
        '2023-01-01'
    ),
    (
        'Group',
        '45.00',
        25,
        '110',
        'Intermediate',
        '2023-01-15'
    ),
    (
        'Group',
        '50.00',
        25,
        '120',
        'Advanced',
        '2023-02-01'
    ),
    (
        'Ensemble',
        '30.00',
        25,
        '150',
        NULL,
        '2023-01-01'
    );