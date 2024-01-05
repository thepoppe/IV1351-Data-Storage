-- queries for histoircal database
-- requirements: lesson type, lesson price, genre, intstrument, lesson price, student name, student email
-- plan db creaetion: Split the lesson from the students to avoid data redundancy on grouplessons and ensembles.
CREATE TABLE
    historical_lesson_attendees (
        lesson_id INT NOT NULL,
        student_name VARCHAR(200) NOT NULL,
        student_email VARCHAR(200) NOT NULL,
        PRIMARY KEY (lesson_id, student_email),
        FOREIGN KEY (lesson_id) REFERENCES historical_lessons (lesson_id) ON DELETE CASCADE
    );


CREATE TABLE
    historical_lessons (
        id INT NOT NULL,
        lesson_type lesson_type NOT NULL,
        genre VARCHAR(100),
        instrument instrument_type,
        price VARCHAR(10) NOT NULL,
        PRIMARY KEY (id),
    )
    -- plan sql data extraction: Createa view for joining the lesson info together.
    -- extract student info from all lessons in the student_lesson conjunction table.
    ------------------------------------------
CREATE VIEW
    all_lessons_info AS
SELECT
    lesson.lesson_id AS id,
    price_info.lesson_type AS lesson_type,
    target_genre AS genre,
    single_instrument_lesson.instrument AS instrument,
    price_info.base_price AS price
FROM
    lesson
    LEFT JOIN price_info ON lesson.price_info_id = price_info.price_info_id
    LEFT JOIN (
        SELECT
            lesson_id,
            instrument
        FROM
            individual_lesson
        UNION ALL
        SELECT
            lesson_id,
            instrument
        FROM
            group_lesson
    ) AS single_instrument_lesson ON single_instrument_lesson.lesson_id = lesson.lesson_id
    LEFT JOIN ensemble ON lesson.lesson_id = ensemble.lesson_id;


-----------------------------------------
-- data insertions statements
--insert the registerewd lessons and their info
INSERT INTO
    historical_lessons (id, lesson_type, genre, instrument, price) (
        SELECT
            *
        FROM
            all_lessons_info
    )
    --insert student information on all registered lessons
INSERT INTO
    historical_lesson_attendees (lesson_id, student_name, student_email) (
        SELECT DISTINCT
            lessons.lesson_id,
            person.first_name || ' ' || last_name AS student_name,
            person.email_address AS student_email
        FROM
            student_lesson AS lessons
            INNER JOIN person ON lessons.person_id = person.person_id
        ORDER BY
            person.email_address
    );


-- Viewing the the historical database
SELECT
    *
FROM
    historical_lesson_attendees AS attendees
    LEFT JOIN historical_lessons AS lessons ON attendees.lesson_id = lessons.id