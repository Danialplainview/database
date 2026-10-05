CREATE TABLE directors (
	director_id SERIAL PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL,
	country VARCHAR(50) );
	
CREATE TABLE movies (
	movie_id SERIAL PRIMARY KEY,
	title VARCHAR(150) NOT NULL,
	director_id INTEGER REFERENCES directors(director_id)
	ON DELETE RESTRICT, release_year INTEGER );

INSERT INTO directors (full_name, country) VALUES
	('Takashi Miike', 'Japan'),
	('Bong Joon-ho', 'South Korea');
	
INSERT INTO movies (title, director_id, release_year) VALUES
	('Gozu', 1, 2003),
	('Parasite', 2, 2019);
	
-- This one fails because id 99 doesn't exist

INSERT INTO movies (title, director_id, release_year) VALUES 
	('Ghost Film', 99, 2024);

CREATE TABLE customers ( 
	customer_id SERIAL PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL );
	
CREATE TABLE rental_cards (
	card_id SERIAL PRIMARY KEY,
	customer_id INTEGER UNIQUE NOT NULL REFERENCES customers(customer_id) ON DELETE CASCADE,
	card_number VARCHAR(20) NOT NULL,
	issue_date DATE DEFAULT CURRENT_DATE );

INSERT INTO customers (full_name, email) VALUES
	('Aiperi Chekirova', 'aiperi@auca.kg'),
	('Nurlan Ramisov', 'nurlan@gmail.com');
	
INSERT INTO rental_cards (customer_id, card_number) VALUES 
	(1, 'CARD-1001'), 
	(2, 'CARD-1002'); 

DELETE FROM customers WHERE customer_id = 2;
-- card for customer_id 2 should be gone
SELECT * FROM rental_cards;

CREATE TABLE rentals ( 
	rental_id SERIAL PRIMARY KEY,
	customer_id INTEGER NOT NULL REFERENCES customers(customer_id) ON DELETE CASCADE,
	movie_id INTEGER NOT NULL REFERENCES movies(movie_id) ON DELETE CASCADE,
	rental_date DATE DEFAULT CURRENT_DATE, return_date DATE );

INSERT INTO rentals (customer_id, movie_id) VALUES 
	(1, 1),
	(1, 2);
	
SELECT 
	c.full_name AS customer,
	c.email,
	m.title AS movie,
	d.full_name AS director
FROM customers c
JOIN rentals r ON c.customer_id = r.customer_id
JOIN movies m ON r.movie_id = m.movie_id
JOIN directors d ON m.director_id = d.director_id
ORDER BY c.full_name, m.title;

INSERT INTO customers (full_name, email) VALUES
	('Sagynbubu Duisheeva', 'Sagyn64@gmail.com');

INSERT INTO rental_cards (customer_id, card_number) VALUES 
	(3, 'CARD-1003'); 

DELETE FROM rentals WHERE customer_id = 1 AND movie_id = 2;

INSERT INTO rentals (customer_id, movie_id) VALUES
(3, 2);


	