CREATE TABLE music_artists (
    first_name VARCHAR(50),
    last_name VARCHAR(50),
	band VARCHAR(50),
    birth_date DATE
);

INSERT INTO music_artists (first_name, last_name, band, birth_date) VALUES
	('Freddie', 'Mercury', 'Queen', '05.09.1946'),
	('Brian', 'May', 'Quuen', '19.07.1947'),
	('Ian', 'Curtis', 'Joy Division', '15.07.1956'),
	('Jim', 'Morrison', 'The Doors', '08.12.1943');

UPDATE music_artists
SET band = 'Queen'
WHERE first_name = 'Brian' AND last_name = 'May' AND birth_date = '19.07.1947';

DELETE FROM music_artists
WHERE first_name = 'Brian' AND last_name = 'May' AND birth_date = '19.07.1947';

UPDATE music_artists
SET last_name = 'Curtis'
WHERE last_name IN ('Mercury', 'Morrison');

DELETE FROM music_artists
WHERE first_name IN ('Ian', 'Freddie');

SELECT * FROM music_artists;




