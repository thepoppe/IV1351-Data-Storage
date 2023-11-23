
--create timeslots

INSERT INTO timeslot (slot_date, start_time, end_time)
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
INSERT INTO instructor_timeslot(person_id, slot_id)
VALUES
    (currval('person_person_id_seq') - 4,1),
    (currval('person_person_id_seq') - 4,2),
    (currval('person_person_id_seq') - 4,3),
    (currval('person_person_id_seq') - 3,1),
    (currval('person_person_id_seq')    ,5),
    (currval('person_person_id_seq') - 1,6),
    (currval('person_person_id_seq') - 3,1),
    (currval('person_person_id_seq') - 2,9),
    (currval('person_person_id_seq') - 1,10),
    (currval('person_person_id_seq')    ,10);

--create price information table
INSERT INTO price_info (lesson_type, base_price, lesson_level, starting_date)
VALUES
  ('Individual', '70.00', 'Beginner', '2023-01-01'),
  ('Individual', '75.00', 'Intermediate', '2023-01-15'),
  ('Individual', '80.00', 'Advanced', '2023-02-01'),

  ('Group', '40.00', 'Beginner', '2023-01-01'),
  ('Group', '45.00', 'Intermediate', '2023-01-15'),
  ('Group', '50.00', 'Advanced', '2023-02-01'),

  ('Ensemble', '30.00', null, '2023-01-01');



--assign individual lessons can use a transaction for this??
INSERT INTO individual_lesson (price_info_id, instructor_timeslot_id, instrument)
VALUES
    (1, currval('instructor_timeslot_instructor_timeslot_id_seq') -6, 'Guitar'),
    (2, currval('instructor_timeslot_instructor_timeslot_id_seq') -5, 'Piano'),
    (3, currval('instructor_timeslot_instructor_timeslot_id_seq') -4, 'Violin'),
    (1, currval('instructor_timeslot_instructor_timeslot_id_seq') -3, 'Drums'),
    (2, currval('instructor_timeslot_instructor_timeslot_id_seq') -2, 'Guitar'),
    (3, currval('instructor_timeslot_instructor_timeslot_id_seq') -1, 'Piano'),
    (1, currval('instructor_timeslot_instructor_timeslot_id_seq') -0, 'Violin');
-- set is_available = false
UPDATE instructor_timeslot
SET is_available = false
WHERE (instructor_timeslot_id) 
IN ( 
currval('instructor_timeslot_instructor_timeslot_id_seq') -6,
currval('instructor_timeslot_instructor_timeslot_id_seq') -5,
currval('instructor_timeslot_instructor_timeslot_id_seq') -4,
currval('instructor_timeslot_instructor_timeslot_id_seq') -3,
currval('instructor_timeslot_instructor_timeslot_id_seq') -2,
currval('instructor_timeslot_instructor_timeslot_id_seq') -1,
currval('instructor_timeslot_instructor_timeslot_id_seq') -0
);



--create 5 grouplessons
-- Insert 5 new timeslots
INSERT INTO timeslot (slot_date, start_time, end_time)
VALUES
  ('2023-11-27', '09:00:00', '10:00:00'),
  ('2023-11-27', '10:30:00', '11:30:00'),
  ('2023-11-28', '13:00:00', '14:00:00'),
  ('2023-11-28', '14:30:00', '15:30:00'),
  ('2023-11-29', '16:00:00', '17:00:00');
--map to teachers
INSERT INTO instructor_timeslot (person_id, slot_id, is_available)
VALUES
  (currval('person_person_id_seq') - 4, currval('timeslot_slot_id_seq'), false),
  (currval('person_person_id_seq') - 3, currval('timeslot_slot_id_seq') - 1, false),
  (currval('person_person_id_seq') - 2, currval('timeslot_slot_id_seq') - 2, false),
  (currval('person_person_id_seq') - 1, currval('timeslot_slot_id_seq') - 3, false),
  (currval('person_person_id_seq')    , currval('timeslot_slot_id_seq') - 4, false);
--map to lessons
INSERT INTO group_lesson (price_info_id, instructor_timeslot_id, room, instrument, minimum_students)
VALUES
  (4, currval('instructor_timeslot_instructor_timeslot_id_seq')    , 'RoomA', 'Guitar', 5),
  (4, currval('instructor_timeslot_instructor_timeslot_id_seq') - 1, 'RoomB', 'Piano', 4),
  (5, currval('instructor_timeslot_instructor_timeslot_id_seq') - 2, 'RoomC', 'Violin', 3),
  (6, currval('instructor_timeslot_instructor_timeslot_id_seq') - 3, 'RoomD', 'Drums', 6),
  (6, currval('instructor_timeslot_instructor_timeslot_id_seq') - 4, 'RoomE', 'Guitar', 4);



  --create 5 ensembles
  -- Scatter ensemble lessons over a 2-week period
INSERT INTO timeslot (slot_date, start_time, end_time)
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
INSERT INTO instructor_timeslot (person_id, slot_id, is_available)
VALUES
  (currval('person_person_id_seq') - 4, currval('timeslot_slot_id_seq')    , false),
  (currval('person_person_id_seq') - 3, currval('timeslot_slot_id_seq') - 1, false),
  (currval('person_person_id_seq') - 2, currval('timeslot_slot_id_seq') - 2, false),
  (currval('person_person_id_seq') - 1, currval('timeslot_slot_id_seq') - 3, false),
  (currval('person_person_id_seq')    ,currval('timeslot_slot_id_seq') - 4, false),
  (currval('person_person_id_seq') - 4, currval('timeslot_slot_id_seq') - 5, false),
  (currval('person_person_id_seq') - 3, currval('timeslot_slot_id_seq') - 6, false),
  (currval('person_person_id_seq') - 2, currval('timeslot_slot_id_seq') - 7, false),
  (currval('person_person_id_seq') - 1, currval('timeslot_slot_id_seq') - 8, false),
  (currval('person_person_id_seq')    ,currval('timeslot_slot_id_seq') - 9, false);

-- Map ensemble lessons
INSERT INTO ensemble (price_info_id, instructor_timeslot_id, room, minimum_students, maximum_students, target_genre)
VALUES
  (7, currval('instructor_timeslot_instructor_timeslot_id_seq')    , 'RoomA',    '5', '10', 'Jazz'),
  (7, currval('instructor_timeslot_instructor_timeslot_id_seq') - 1, 'RoomB','4', '8', 'Classical'),
  (7, currval('instructor_timeslot_instructor_timeslot_id_seq') - 2, 'RoomC', '3', '6', 'Orchestral'),
  (7, currval('instructor_timeslot_instructor_timeslot_id_seq') - 3, 'RoomD','6', '12', 'Rock'),
  (7, currval('instructor_timeslot_instructor_timeslot_id_seq') - 4, 'RoomE', '4', '8', 'Folk'),
  (7, currval('instructor_timeslot_instructor_timeslot_id_seq') - 5, 'RoomA','5', '10', 'Classical'),
  (7, currval('instructor_timeslot_instructor_timeslot_id_seq') - 6, 'RoomB', '4', '8', 'Baroque'),
  (7, currval('instructor_timeslot_instructor_timeslot_id_seq') - 7, 'RoomC','3', '6', 'Jazz'),
  (7, currval('instructor_timeslot_instructor_timeslot_id_seq') - 8, 'RoomD', '6', '12', 'Blues'),
  (7, currval('instructor_timeslot_instructor_timeslot_id_seq') - 9, 'RoomE', '4', '8', 'Pop');


--map students to lessons
INSERT INTO student_lesson (person_id, lesson_id)
VALUES
  (currval('person_person_id_seq') - 24, 1),
  (currval('person_person_id_seq') - 23, 2),
  (currval('person_person_id_seq') - 22, 3),
  (currval('person_person_id_seq') - 21, 4),
  (currval('person_person_id_seq') - 20, 5),
  (currval('person_person_id_seq') - 19, 6),
  (currval('person_person_id_seq') - 18, 7),
  (currval('person_person_id_seq') - 17, 8),
  (currval('person_person_id_seq') - 16, 9),
  (currval('person_person_id_seq') - 15, 10),
  (currval('person_person_id_seq') - 29, 11),
  (currval('person_person_id_seq') - 28, 12),
  (currval('person_person_id_seq') - 22, 13),
  (currval('person_person_id_seq') - 21, 14),
  (currval('person_person_id_seq') - 20, 15),
  (currval('person_person_id_seq') - 19, 10),
  (currval('person_person_id_seq') - 18, 11),
  (currval('person_person_id_seq') - 17, 12),
  (currval('person_person_id_seq') - 16, 13),
  (currval('person_person_id_seq') - 15, 14);






