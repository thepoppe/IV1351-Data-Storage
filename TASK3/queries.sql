--query 1 display all lessons
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
SELECT
    number_of_siblings AS "No of Siblings",
    COUNT(person_id) AS "No of Students"
FROM
    (
        SELECT
            student.person_id,
            CASE
                WHEN COUNT(sibling.person_id) = 0 THEN '0'
                WHEN COUNT(sibling.person_id) = 1 THEN '1'
                WHEN COUNT(sibling.person_id) = 2 THEN '2'
            END AS number_of_siblings
        FROM
            student
            LEFT JOIN sibling ON student.person_id = sibling.person_id
        GROUP BY
            student.person_id
    )
GROUP BY
    number_of_siblings
ORDER BY
    number_of_siblings;


--query 3
SELECT
    instr_time.person_id AS "Instructor ID",
    person.first_name AS "First Name",
    person.last_name AS "Last Name",
    COUNT(instr_time.person_id) AS "No of Lessons"
FROM
    lesson AS l
    LEFT JOIN instructor_timeslot AS instr_time ON l.instructor_timeslot_id = instr_time.instructor_timeslot_id
    INNER JOIN instructor ON instructor.person_id = instr_time.person_id
    INNER JOIN person ON person.person_id = instructor.person_id
    LEFT JOIN timeslot AS TIME ON TIME.slot_id = instr_time.slot_id
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
    instr_time.person_id,
    person.first_name,
    person.last_name;


--alt use the boolean is_available => one less join
SELECT
    instr_time.person_id AS "Instructor ID",
    person.first_name AS "First Name",
    person.last_name AS "Last Name",
    COUNT(instr_time.person_id) AS "No of Lessons"
FROM
    instructor_timeslot AS instr_time
    LEFT JOIN instructor ON instructor.person_id = instr_time.person_id
    LEFT JOIN person ON person.person_id = instructor.person_id
    LEFT JOIN timeslot AS TIME ON TIME.slot_id = instr_time.slot_id
WHERE
    instr_time.is_available = FALSE
    AND EXTRACT(
        MONTH
        FROM
            TIME.slot_date
    ) = EXTRACT(
        MONTH
        FROM
            CURRENT_DATE
    )
GROUP BY
    instr_time.person_id,
    person.first_name,
    person.last_name;


--query 4
SELECT
    TO_CHAR(subquery.slot_date, 'Dy') AS DAY,
    ensemble.target_genre AS Genre,
    subquery.slot_date,
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
    INNER JOIN lesson ON lesson.lesson_id = ensemble.lesson_id
    LEFT JOIN student_lesson AS stu_les ON stu_les.lesson_id = lesson.lesson_id
    INNER JOIN price_info AS info ON info.price_info_id = lesson.price_info_id
    INNER JOIN instructor_timeslot AS inst_time ON lesson.instructor_timeslot_id = inst_time.instructor_timeslot_id
    INNER JOIN (
        SELECT
            ts.slot_id,
            ts.slot_date
        FROM
            timeslot AS ts
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
    ) AS subquery ON inst_time.slot_id = subquery.slot_id
WHERE
    info.lesson_type = 'Ensemble'
GROUP BY
    TO_CHAR(subquery.slot_date, 'Dy'),
    ensemble.target_genre,
    subquery.slot_date,
    ensemble.maximum_students
ORDER BY
    subquery.slot_date;