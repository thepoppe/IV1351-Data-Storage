--view for booked lessons
CREATE VIEW
    booked_lessons_view AS
SELECT
    l.lesson_id AS id,
    info.lesson_type AS
TYPE,
it.person_id AS instructor,
ts.slot_date AS date
FROM
    lesson AS l
    LEFT JOIN price_info AS info ON l.price_info_id = info.price_info_id
    LEFT JOIN instructor_timeslot AS it ON l.instructor_timeslot_id = it.instructor_timeslot_id
    LEFT JOIN timeslot AS ts ON it.slot_id = ts.slot_id;


--query 1 display all lessons
--Expected: 30 lessons in total, 18 ensemble(8 in dec), 7 individual and 5 group
SELECT
    TO_CHAR(booked_lessons_view.date, 'Mon') AS "Month",
    COUNT(*) AS "Total Lessons",
    COUNT(*) FILTER (
        WHERE
            booked_lessons_view.type = 'Individual'
    ) AS "Individual",
    COUNT(*) FILTER (
        WHERE
            booked_lessons_view.type = 'Group'
    ) AS "Group",
    COUNT(*) FILTER (
        WHERE
            booked_lessons_view.type = 'Ensemble'
    ) AS "Ensemble"
FROM
    booked_lessons_view
WHERE
    EXTRACT(
        YEAR
        FROM
            booked_lessons_view.date
    ) = 2023
GROUP BY
    TO_CHAR(booked_lessons_view.date, 'Mon')
ORDER BY
    TO_CHAR(booked_lessons_view.date, 'Mon') DESC;


--query 2
-- Exptected 3 students with 2 siblings, 2 students with 1 sibling, 25-3-2 = 20 without
SELECT
    number_of_siblings AS "No of Siblings",
    COUNT(person_id) AS "No of Students"
FROM
    (
        SELECT
            student.person_id,
            COUNT(sibling.person_id) AS number_of_siblings
        FROM
            student
            LEFT JOIN sibling ON student.person_id = sibling.person_id
        GROUP BY
            student.person_id
        HAVING
            COUNT(sibling.person_id) < 3
    ) AS subquery
GROUP BY
    number_of_siblings
ORDER BY
    number_of_siblings;


--query 3
--Expected outcome: 5 instructors, no of lessons depends on current_date
-- for nov total 22, for dec total of 8
--query 3
SELECT
    instructor_info.id AS "Instructor ID",
    instructor_info.first_name AS "First Name",
    instructor_info.last_name AS "Last Name",
    COUNT(instructor_info.id) AS "No of Lessons"
FROM
    booked_lessons_view
    LEFT JOIN (
        SELECT
            person.person_id AS id,
            person.first_name AS first_name,
            person.last_name AS last_name
        FROM
            instructor
            LEFT JOIN person ON person.person_id = instructor.person_id
    ) AS instructor_info ON instructor_info.id = booked_lessons_view.instructor
WHERE
    EXTRACT(
        MONTH
        FROM
            booked_lessons_view.date
    ) = EXTRACT(
        MONTH
        FROM
            CURRENT_DATE
    )
GROUP BY
    instructor_info.id,
    instructor_info.first_name,
    instructor_info.last_name
ORDER BY
    instructor_info.id;


--query 4
--Expected result depends on CURRENT_DATE (CD).
--FOR CD first week of dec (week 45) 4 ensembles, 1 full, 2 with 1or2 and 1 with many seats 
--FOR CD second week of dec (week 46) 4 ensembles, all many seats
SELECT
    TO_CHAR(b_lesson.date, 'Dy') AS DAY,
    ensemble.target_genre AS Genre,
    CASE
        WHEN (
            ensemble.maximum_students - COUNT(stu_les.person_id)
        ) < 1 THEN 'No Seats'
        WHEN (
            ensemble.maximum_students - COUNT(stu_les.person_id)
        ) > 2 THEN 'Many Seats'
        ELSE '1 or 2 Seats'
    END AS "No of Free Seats"
FROM
    ensemble
    LEFT JOIN booked_lessons_view AS b_lesson ON b_lesson.id = ensemble.lesson_id
    LEFT JOIN student_lesson AS stu_les ON stu_les.lesson_id = b_lesson.id
WHERE
    EXTRACT(
        WEEK
        FROM
            b_lesson.date
    ) = EXTRACT(
        WEEK
        FROM
            CURRENT_DATE
    ) + 1
GROUP BY
    TO_CHAR(b_lesson.date, 'Dy'),
    ensemble.target_genre,
    b_lesson.date,
    ensemble.maximum_students
ORDER BY
    b_lesson.date;