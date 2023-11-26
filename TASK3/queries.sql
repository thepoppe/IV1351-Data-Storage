--query 1 display all lessons
SELECT
    TO_CHAR (t.slot_date, 'YYYY-MM') AS month,
    COUNT(*) AS total_lessons,
    COUNT(*) FILTER (
        WHERE
            pi.lesson_type = 'Individual'
    ) AS individual_lessons,
    COUNT(*) FILTER (
        WHERE
            pi.lesson_type = 'Group'
    ) AS group_lessons,
    COUNT(*) FILTER (
        WHERE
            pi.lesson_type = 'Ensemble'
    ) AS ensemble_lessons
FROM
    lesson l
    JOIN price_info pi ON l.price_info_id = pi.price_info_id
    JOIN instructor_timeslot it ON l.instructor_timeslot_id = it.slot_id
    JOIN timeslot t ON it.slot_id = t.slot_id
WHERE
    DATE_PART ('YEAR', t.slot_date) = 2023
GROUP BY
    TO_CHAR (t.slot_date, 'YYYY-MM')
ORDER BY
    TO_CHAR (t.slot_date, 'YYYY-MM');

--query 2
SELECT
    number_of_siblings,
    COUNT(person_id) AS number_of_students
FROM
    (
        SELECT
            stu.person_id,
            CASE
                WHEN COUNT(sib.person_id) = 0 THEN '0'
                WHEN COUNT(sib.person_id) = 1 THEN '1'
                WHEN COUNT(sib.person_id) = 2 THEN '2'
            END AS number_of_siblings
        FROM
            student AS stu
            LEFT JOIN sibling AS sib ON stu.person_id = sib.person_id
        GROUP BY
            stu.person_id
    ) AS subquery
GROUP BY
    number_of_siblings
ORDER BY
    number_of_siblings;

--query 3
SELECT
    it.person_id as "Instructor ID",
    ins.first_name as "First Name",
    ins.last_name as "Last Name",
    count(it.person_id) as "Number of Lessons"
from
    lesson as l
    left join instructor_timeslot as it on l.instructor_timeslot_id = it.instructor_timeslot_id
    inner join instructor as ins on ins.person_id = it.person_id
    left join timeslot as ts on ts.slot_id = it.slot_id
WHERE
    EXTRACT(
        MONTH
        FROM
            ts.slot_date
    ) = EXTRACT(
        MONTH
        FROM
            CURRENT_DATE
    )
group by
    it.person_id,
    ins.first_name,
    ins.last_name;

--query 4
SELECT
    TO_CHAR (sub.slot_date, 'Dy') AS Day,
    ens.target_genre AS Genre,
    sub.slot_date,
    CASE
        WHEN (ens.maximum_students::int - COUNT(sl.person_id)) < 1 THEN 'No Seats'
        WHEN (ens.maximum_students::int - COUNT(sl.person_id)) > 2 THEN 'Many Seats'
        ELSE '1 or 2 Seats'
    END AS "No of Free Seats"
FROM
    ensemble AS ens
    left JOIN student_lesson AS sl ON sl.lesson_id = ens.lesson_id
    inner JOIN price_info AS pi ON pi.price_info_id = ens.price_info_id
    inner JOIN instructor_timeslot AS it ON ens.instructor_timeslot_id = it.instructor_timeslot_id
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
    ) AS sub ON it.slot_id = sub.slot_id
WHERE
    pi.lesson_type = 'Ensemble'
GROUP BY
    TO_CHAR (sub.slot_date, 'Dy'),
    ens.target_genre,
    sub.slot_date,
    ens.maximum_students;