
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
    (126,1),
    (126,2),
    (126,3),
    (127,1),
    (128,5),
    (128,6),
    (130,1),
    (130,9),
    (130,10);

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
    (1, 1, 'Guitar'),
    (2, 2, 'Piano'),
    (3, 1, 'Violin'),
    (1, 5, 'Drums'),
    (2, 6, 'Guitar'),
    (3, 1, 'Piano'),
    (1, 9, 'Violin');
-- set is_available = false
UPDATE instructor_timeslot
SET is_available = false
WHERE (instructor_timeslot_id,) 
IN ( 1, 2, 1, 5, 6, 1, 9);



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
  (126, currval('timeslot_slot_id_seq'), false),
  (127, currval('timeslot_slot_id_seq') - 1, false),
  (128, currval('timeslot_slot_id_seq') - 2, false),
  (129, currval('timeslot_slot_id_seq') - 3, false),
  (130, currval('timeslot_slot_id_seq') - 4, false);
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
  (6, currval('timeslot_slot_id_seq')    , false),
  (7, currval('timeslot_slot_id_seq') - 1, false),
  (8, currval('timeslot_slot_id_seq') - 2, false),
  (9, currval('timeslot_slot_id_seq') - 3, false),
  (10,currval('timeslot_slot_id_seq') - 4, false),
  (6, currval('timeslot_slot_id_seq') - 5, false),
  (7, currval('timeslot_slot_id_seq') - 6, false),
  (8, currval('timeslot_slot_id_seq') - 7, false),
  (9, currval('timeslot_slot_id_seq') - 8, false),
  (10,currval('timeslot_slot_id_seq') - 9, false);

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








