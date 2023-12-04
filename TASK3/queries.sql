--query 1 display all lessons
--Expected: 30 lessons in total, 18 ensemble(8 in dec), 7 individual and 5 group
SELECT
    TO_CHAR(all_times.slot_date, 'Mon') AS "Month",
    COUNT(*) AS "Total Lessons",
    COUNT(*) FILTER (
        WHERE
            info.lesson_type = 'Individual'
    ) AS "Individual",
    COUNT(*) FILTER (
        WHERE
            info.lesson_type = 'Group'
    ) AS "Group",
    COUNT(*) FILTER (
        WHERE
            info.lesson_type = 'Ensemble'
    ) AS "Ensemble"
FROM
    lesson
    LEFT JOIN price_info AS info ON lesson.price_info_id = info.price_info_id
    LEFT JOIN (
        SELECT
            instructor_timeslot_id,
            slot_date
        FROM
            instructor_timeslot AS instr_time
            LEFT JOIN timeslot ON instr_time.slot_id = timeslot.slot_id
    ) AS all_times ON all_times.instructor_timeslot_id = lesson.instructor_timeslot_id
WHERE
    EXTRACT(
        YEAR
        FROM
            all_times.slot_date
    ) = 2023
GROUP BY
    TO_CHAR(all_times.slot_date, 'Mon')
ORDER BY
    TO_CHAR(all_times.slot_date, 'Mon') DESC;


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
CREATE VIEW
    instructor_info AS
SELECT
    person.*,
    instructor.instructor_id
FROM
    instructor
    INNER JOIN person ON person.person_id = instructor.person_id;


--The query using the view
SELECT
    instructor_info.person_id AS "Instructor ID",
    instructor_info.first_name AS "First Name",
    instructor_info.last_name AS "Last Name",
    COUNT(instructor_info.person_id) AS "No of Lessons"
FROM
    lesson AS l
    LEFT JOIN instructor_timeslot AS instr_time ON l.instructor_timeslot_id = instr_time.instructor_timeslot_id
    LEFT JOIN timeslot AS TIME ON TIME.slot_id = instr_time.slot_id
    LEFT JOIN instructor_info ON instructor_info.person_id = instr_time.person_id
WHERE
    EXTRACT(
        MONTH
        FROM
            TIME.slot_date
    ) = EXTRACT(
        MONTH
        FROM
            CURRENT_DATE
    )
GROUP BY
    instructor_info.person_id,
    instructor_info.first_name,
    instructor_info.last_name
ORDER BY
    instructor_info.person_id;


--query 4
--Expected result depends on CURRENT_DATE (CD).
--FOR CD first week of dec (week 45) 4 ensembles, 1 full, 2 with 1or2 and 1 with many seats 
--FOR CD second week of dec (week 46) 4 ensembles, all many seats
SELECT
    TO_CHAR(subquery.slot_date, 'Dy') AS DAY,
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
    LEFT JOIN lesson ON lesson.lesson_id = ensemble.lesson_id
    LEFT JOIN student_lesson AS stu_les ON stu_les.lesson_id = lesson.lesson_id
    LEFT JOIN price_info AS info ON info.price_info_id = lesson.price_info_id
    INNER JOIN (
        SELECT
            inst_time.instructor_timeslot_id,
            ts.slot_id,
            ts.slot_date
        FROM
            instructor_timeslot AS inst_time
            LEFT JOIN timeslot AS ts ON inst_time.slot_id = ts.slot_id
        WHERE
            EXTRACT(
                WEEK
                FROM
                    ts.slot_date
            ) = EXTRACT(
                WEEK
                FROM
                    CURRENT_DATE
            ) + 1
    ) AS subquery ON lesson.instructor_timeslot_id = subquery.instructor_timeslot_id
WHERE
    info.lesson_type = 'Ensemble'
GROUP BY
    TO_CHAR(subquery.slot_date, 'Dy'),
    ensemble.target_genre,
    subquery.slot_date,
    ensemble.maximum_students
ORDER BY
    subquery.slot_date;