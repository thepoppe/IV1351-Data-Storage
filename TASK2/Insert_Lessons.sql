--create timeslots
INSERT INTO
  timeslot (slot_date, start_time, end_time)
VALUES
  ('2023-11-22', '09:00:00', '10:00:00'),
  ('2023-11-22', '10:30:00', '11:30:00'),
  ('2023-11-23', '13:00:00', '14:00:00'),
  ('2023-11-23', '14:30:00', '15:30:00'),
  ('2023-11-24', '16:00:00', '17:00:00'),
  ('2023-11-24', '17:30:00', '18:30:00'),
  ('2023-11-25', '09:00:00', '10:00:00'),
  ('2023-11-25', '10:30:00', '11:30:00'),
  ('2023-11-26', '13:00:00', '14:00:00'),
  ('2023-11-26', '14:30:00', '15:30:00');


--add available times
INSERT INTO
  instructor_timeslot (person_id, slot_id)
VALUES
  (CURRVAL('person_person_id_seq') - 4, 1),
  (CURRVAL('person_person_id_seq') - 4, 2),
  (CURRVAL('person_person_id_seq') - 4, 3),
  (CURRVAL('person_person_id_seq') - 3, 1),
  (CURRVAL('person_person_id_seq'), 5),
  (CURRVAL('person_person_id_seq') - 1, 6),
  (CURRVAL('person_person_id_seq') - 3, 1),
  (CURRVAL('person_person_id_seq') - 2, 9),
  (CURRVAL('person_person_id_seq') - 1, 10),
  (CURRVAL('person_person_id_seq'), 10);


--create price information table
INSERT INTO
  price_info (lesson_type, base_price, lesson_level, starting_date)
VALUES
  ('Individual', '70.00', 'Beginner', '2023-01-01'),
  ('Individual', '75.00', 'Intermediate', '2023-01-15'),
  ('Individual', '80.00', 'Advanced', '2023-02-01'),
  ('Group', '40.00', 'Beginner', '2023-01-01'),
  ('Group', '45.00', 'Intermediate', '2023-01-15'),
  ('Group', '50.00', 'Advanced', '2023-02-01'),
  ('Ensemble', '30.00', NULL, '2023-01-01');


--assign individual lessons can use a transaction for this??
INSERT INTO
  lesson (price_info_id, instructor_timeslot_id)
VALUES
  (1, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -6),
  (2, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -5),
  (3, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -4),
  (1, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -3),
  (2, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -2),
  (3, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -1),
  (1, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -0);


-- set is_available = false
UPDATE instructor_timeslot
SET
  is_available = FALSE
WHERE
  (instructor_timeslot_id) IN (
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -6,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -5,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -4,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -3,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -2,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -1,
    CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') -0
  );


INSERT INTO
  individual_lesson (lesson_id, instrument)
VALUES
  (CURRVAL('lesson_lesson_id_seq') -6, 'Guitar'),
  (CURRVAL('lesson_lesson_id_seq') -5, 'Piano'),
  (CURRVAL('lesson_lesson_id_seq') -4, 'Violin'),
  (CURRVAL('lesson_lesson_id_seq') -3, 'Drums'),
  (CURRVAL('lesson_lesson_id_seq') -2, 'Guitar'),
  (CURRVAL('lesson_lesson_id_seq') -1, 'Piano'),
  (CURRVAL('lesson_lesson_id_seq') -0, 'Violin');


--create 5 grouplessons
-- Insert 5 new timeslots
INSERT INTO
  timeslot (slot_date, start_time, end_time)
VALUES
  ('2023-11-27', '09:00:00', '10:00:00'),
  ('2023-11-27', '10:30:00', '11:30:00'),
  ('2023-11-28', '13:00:00', '14:00:00'),
  ('2023-11-28', '14:30:00', '15:30:00'),
  ('2023-11-29', '16:00:00', '17:00:00');


--map to teachers
INSERT INTO
  instructor_timeslot (person_id, slot_id, is_available)
VALUES
  (CURRVAL('person_person_id_seq') - 4, CURRVAL('timeslot_slot_id_seq'), FALSE),
  (CURRVAL('person_person_id_seq') - 3, CURRVAL('timeslot_slot_id_seq') - 1, FALSE),
  (CURRVAL('person_person_id_seq') - 2, CURRVAL('timeslot_slot_id_seq') - 2, FALSE),
  (CURRVAL('person_person_id_seq') - 1, CURRVAL('timeslot_slot_id_seq') - 3, FALSE),
  (CURRVAL('person_person_id_seq'), CURRVAL('timeslot_slot_id_seq') - 4, FALSE);


--map to lessons
INSERT INTO
  lesson (price_info_id, instructor_timeslot_id, room)
VALUES
  (4, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq'), 'RoomA'),
  (4, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 1, 'RoomB'),
  (5, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 2, 'RoomC'),
  (6, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 3, 'RoomD'),
  (6, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 4, 'RoomE');


INSERT INTO
  group_lesson (lesson_id, instrument, minimum_students)
VALUES
  (CURRVAL('lesson_lesson_id_seq') -6, 'Guitar', 5),
  (CURRVAL('lesson_lesson_id_seq') -5, 'Piano', 4),
  (CURRVAL('lesson_lesson_id_seq') -4, 'Violin', 3),
  (CURRVAL('lesson_lesson_id_seq') -3, 'Drums', 6),
  (CURRVAL('lesson_lesson_id_seq') -2, 'Guitar', 4);


--create 10 ensembles
INSERT INTO
  timeslot (slot_date, start_time, end_time)
VALUES
  ('2023-11-27', '09:00:00', '10:00:00'),
  ('2023-11-27', '10:30:00', '11:30:00'),
  ('2023-11-28', '13:00:00', '14:00:00'),
  ('2023-11-28', '14:30:00', '15:30:00'),
  ('2023-11-29', '16:00:00', '17:00:00'),
  ('2023-12-01', '09:00:00', '10:00:00'),
  ('2023-12-01', '10:30:00', '11:30:00'),
  ('2023-12-02', '13:00:00', '14:00:00'),
  ('2023-12-02', '14:30:00', '15:30:00'),
  ('2023-12-03', '16:00:00', '17:00:00');


-- Map timeslots to teachers
INSERT INTO
  instructor_timeslot (person_id, slot_id, is_available)
VALUES
  (CURRVAL('person_person_id_seq') - 4, CURRVAL('timeslot_slot_id_seq'), FALSE),
  (CURRVAL('person_person_id_seq') - 3, CURRVAL('timeslot_slot_id_seq') - 1, FALSE),
  (CURRVAL('person_person_id_seq') - 2, CURRVAL('timeslot_slot_id_seq') - 2, FALSE),
  (CURRVAL('person_person_id_seq') - 1, CURRVAL('timeslot_slot_id_seq') - 3, FALSE),
  (CURRVAL('person_person_id_seq'), CURRVAL('timeslot_slot_id_seq') - 4, FALSE),
  (CURRVAL('person_person_id_seq') - 4, CURRVAL('timeslot_slot_id_seq') - 5, FALSE),
  (CURRVAL('person_person_id_seq') - 3, CURRVAL('timeslot_slot_id_seq') - 6, FALSE),
  (CURRVAL('person_person_id_seq') - 2, CURRVAL('timeslot_slot_id_seq') - 7, FALSE),
  (CURRVAL('person_person_id_seq') - 1, CURRVAL('timeslot_slot_id_seq') - 8, FALSE),
  (CURRVAL('person_person_id_seq'), CURRVAL('timeslot_slot_id_seq') - 9, FALSE);


-- Map ensemble lessons
INSERT INTO
  lesson (price_info_id, instructor_timeslot_id, room)
VALUES
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq'), 'RoomA'),
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 1, 'RoomB'),
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 2, 'RoomC'),
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 3, 'RoomD'),
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 4, 'RoomE'),
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 5, 'RoomA'),
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 6, 'RoomB'),
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 7, 'RoomC'),
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 8, 'RoomD'),
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 9, 'RoomE');


INSERT INTO
  ensemble (lesson_id, minimum_students, maximum_students, target_genre)
VALUES
  (CURRVAL('lesson_lesson_id_seq'), 5, 10, 'Jazz'),
  (CURRVAL('lesson_lesson_id_seq') - 1, 4, 8, 'Classical'),
  (CURRVAL('lesson_lesson_id_seq') - 2, 3, 6, 'Orchestral'),
  (CURRVAL('lesson_lesson_id_seq') - 3, 6, 12, 'Rock'),
  (CURRVAL('lesson_lesson_id_seq') - 4, 4, 8, 'Folk'),
  (CURRVAL('lesson_lesson_id_seq') - 5, 5, 10, 'Classical'),
  (CURRVAL('lesson_lesson_id_seq') - 6, 4, 8, 'Baroque'),
  (CURRVAL('lesson_lesson_id_seq') - 7, 3, 6, 'Jazz'),
  (CURRVAL('lesson_lesson_id_seq') - 8, 6, 12, 'Blues'),
  (CURRVAL('lesson_lesson_id_seq') - 9, 4, 8, 'Pop');


--map students to lessons
INSERT INTO
  student_lesson (person_id, lesson_id)
VALUES
  (CURRVAL('person_person_id_seq') - 24, 1),
  (CURRVAL('person_person_id_seq') - 23, 2),
  (CURRVAL('person_person_id_seq') - 22, 3),
  (CURRVAL('person_person_id_seq') - 21, 4),
  (CURRVAL('person_person_id_seq') - 20, 5),
  (CURRVAL('person_person_id_seq') - 19, 6),
  (CURRVAL('person_person_id_seq') - 18, 7),
  (CURRVAL('person_person_id_seq') - 17, 8),
  (CURRVAL('person_person_id_seq') - 16, 9),
  (CURRVAL('person_person_id_seq') - 15, 10),
  (CURRVAL('person_person_id_seq') - 29, 11),
  (CURRVAL('person_person_id_seq') - 28, 12),
  (CURRVAL('person_person_id_seq') - 22, 13),
  (CURRVAL('person_person_id_seq') - 21, 14),
  (CURRVAL('person_person_id_seq') - 20, 15),
  (CURRVAL('person_person_id_seq') - 19, 10),
  (CURRVAL('person_person_id_seq') - 18, 11),
  (CURRVAL('person_person_id_seq') - 17, 12),
  (CURRVAL('person_person_id_seq') - 16, 13),
  (CURRVAL('person_person_id_seq') - 15, 14);


--inser 8 ensembles for December 
--
INSERT INTO
  timeslot (slot_date, start_time, end_time)
VALUES
  ('2023-12-11', '09:00:00', '10:00:00'),
  ('2023-12-12', '09:00:00', '10:00:00'),
  ('2023-12-14', '09:00:00', '10:00:00'),
  ('2023-12-15', '09:00:00', '10:00:00'),
  ('2023-12-18', '09:00:00', '10:00:00'),
  ('2023-12-19', '09:00:00', '10:00:00'),
  ('2023-12-21', '09:00:00', '10:00:00'),
  ('2023-12-22', '09:00:00', '10:00:00');


-- Map timeslots to teachers
INSERT INTO
  instructor_timeslot (person_id, slot_id, is_available)
VALUES
  (CURRVAL('person_person_id_seq') - 4, CURRVAL('timeslot_slot_id_seq') - 7, FALSE),
  (CURRVAL('person_person_id_seq') - 3, CURRVAL('timeslot_slot_id_seq') - 6, FALSE),
  (CURRVAL('person_person_id_seq') - 2, CURRVAL('timeslot_slot_id_seq') - 5, FALSE),
  (CURRVAL('person_person_id_seq') - 1, CURRVAL('timeslot_slot_id_seq') - 4, FALSE),
  (CURRVAL('person_person_id_seq'), CURRVAL('timeslot_slot_id_seq') - 3, FALSE),
  (CURRVAL('person_person_id_seq') - 4, CURRVAL('timeslot_slot_id_seq') - 2, FALSE),
  (CURRVAL('person_person_id_seq') - 3, CURRVAL('timeslot_slot_id_seq') - 1, FALSE),
  (CURRVAL('person_person_id_seq') - 2, CURRVAL('timeslot_slot_id_seq'), FALSE);


-- Map ensemble lessons
INSERT INTO
  lesson (price_info_id, instructor_timeslot_id)
VALUES
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 7),
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 6),
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 5),
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 4),
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 3),
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 2),
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq') - 1),
  (7, CURRVAL('instructor_timeslot_instructor_timeslot_id_seq'));


INSERT INTO
  ensemble (lesson_id, minimum_students, maximum_students, target_genre)
VALUES
  (CURRVAL('lesson_lesson_id_seq') - 7, 5, 10, 'Jazz'),
  (CURRVAL('lesson_lesson_id_seq') - 6, 4, 8, 'Classical'),
  (CURRVAL('lesson_lesson_id_seq') - 5, 3, 6, 'Orchestral'),
  (CURRVAL('lesson_lesson_id_seq') - 4, 6, 12, 'Rock'),
  (CURRVAL('lesson_lesson_id_seq') - 3, 4, 8, 'Folk'),
  (CURRVAL('lesson_lesson_id_seq') - 2, 5, 10, 'Rock'),
  (CURRVAL('lesson_lesson_id_seq') - 1, 4, 8, 'Baroque'),
  (CURRVAL('lesson_lesson_id_seq'), 3, 6, 'Rock');


--map students to new ensembles 
--10students to jazz ensemble making it full 2023-12-11
--7 into classsical leaving one spot  2023-12-12
--4 into orchestral leaving 2 spots 2023-12-14
INSERT INTO
  student_lesson (person_id, lesson_id)
VALUES
  (CURRVAL('person_person_id_seq') - 24, CURRVAL('lesson_lesson_id_seq') -7),
  (CURRVAL('person_person_id_seq') - 23, CURRVAL('lesson_lesson_id_seq') -7),
  (CURRVAL('person_person_id_seq') - 22, CURRVAL('lesson_lesson_id_seq') -7),
  (CURRVAL('person_person_id_seq') - 21, CURRVAL('lesson_lesson_id_seq') -7),
  (CURRVAL('person_person_id_seq') - 20, CURRVAL('lesson_lesson_id_seq') -7),
  (CURRVAL('person_person_id_seq') - 19, CURRVAL('lesson_lesson_id_seq') -7),
  (CURRVAL('person_person_id_seq') - 18, CURRVAL('lesson_lesson_id_seq') -7),
  (CURRVAL('person_person_id_seq') - 17, CURRVAL('lesson_lesson_id_seq') -7),
  (CURRVAL('person_person_id_seq') - 16, CURRVAL('lesson_lesson_id_seq') -7),
  (CURRVAL('person_person_id_seq') - 15, CURRVAL('lesson_lesson_id_seq') -7),
  (CURRVAL('person_person_id_seq') - 29, CURRVAL('lesson_lesson_id_seq') -6),
  (CURRVAL('person_person_id_seq') - 28, CURRVAL('lesson_lesson_id_seq') -6),
  (CURRVAL('person_person_id_seq') - 22, CURRVAL('lesson_lesson_id_seq') -6),
  (CURRVAL('person_person_id_seq') - 21, CURRVAL('lesson_lesson_id_seq') -6),
  (CURRVAL('person_person_id_seq') - 20, CURRVAL('lesson_lesson_id_seq') -6),
  (CURRVAL('person_person_id_seq') - 19, CURRVAL('lesson_lesson_id_seq') -6),
  (CURRVAL('person_person_id_seq') - 18, CURRVAL('lesson_lesson_id_seq') -6),
  (CURRVAL('person_person_id_seq') - 17, CURRVAL('lesson_lesson_id_seq') -5),
  (CURRVAL('person_person_id_seq') - 16, CURRVAL('lesson_lesson_id_seq') -5),
  (CURRVAL('person_person_id_seq') - 15, CURRVAL('lesson_lesson_id_seq') -5),
  (CURRVAL('person_person_id_seq') - 14, CURRVAL('lesson_lesson_id_seq') -5);