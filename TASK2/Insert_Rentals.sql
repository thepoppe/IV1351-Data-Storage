
--create instruments
INSERT INTO instrument (instrument_type, brand, price, quantity_in_stock)
VALUES
  ('Guitar', 'Fender', '500', 10),
  ('Piano', 'Yamaha', '2000', 5),
  ('Drums', 'Pearl', '1200', 8),
  ('Violin', 'Stradivarius', '3000', 3),
  ('Other', 'Bach', '800', 12);

--make rentals with deafult 12 months
INSERT INTO instrument_rental (instrument_id, person_id)
VALUES
  (1, currval('person_person_id_seq') - 24),
  (2, currval('person_person_id_seq') - 23),
  (3, currval('person_person_id_seq') - 22),
  (4, currval('person_person_id_seq') - 21),
  (5, currval('person_person_id_seq') - 20),
  (1, currval('person_person_id_seq') - 19),
  (2, currval('person_person_id_seq') - 18),
  (3, currval('person_person_id_seq') - 17),
  (4, currval('person_person_id_seq') - 16),
  (5, currval('person_person_id_seq') - 15);


--reduce quantity
UPDATE instrument
SET quantity_in_stock = quantity_in_stock - 2
WHERE instrument_id IN (1, 2, 3, 4, 5);


