--Violating 1NF
CREATE TABLE movies_bad (
	movie_id INT PRIMARY KEY,
	title VARCHAR(150),
	actors TEXT 
);

INSERT INTO movies_bad VALUES
	(1, 'The Good, the Bad and the Ugly',
	' Clint Eastwood, Lee Van Cleef,
	Eli Wallach'); 
	
SELECT * FROM movies_bad;

--Following 1NF

CREATE TABLE movie (
	movie_id SERIAL PRIMARY KEY,
	title VARCHAR(150) NOT NULL );
	
CREATE TABLE actors (
	actor_id SERIAL PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL );
	
INSERT INTO movie (title) VALUES
	('The Good, the Bad and the Ugly');
INSERT INTO actors (full_name) VALUES 
	('Clint Eastwood'),
	('Lee Van Cleef'),
	('Eli Wallach');

--Following 2NF

CREATE TABLE movie_actors (
	movie_id INTEGER REFERENCES movies(movie_id),
	actor_id INTEGER REFERENCES actors(actor_id), 
	role_name VARCHAR(100), 
	PRIMARY KEY (movie_id, actor_id) );
	
INSERT INTO movie_actors (movie_id, actor_id, role_name) VALUES
	(1, 1, 'The Good'),
	(1, 2, 'The Bad'), 
	(1, 3, 'The Ugly');

SELECT * FROM movie_actors;

--Violating 3NF

CREATE TABLE movies_with_genre_bad (
    movie_id INT PRIMARY KEY,
    title VARCHAR(150),
    genre_id INT,
    genre_name VARCHAR(50) 
);

INSERT INTO movies_with_genre_bad VALUES (1, 'Forrest Gump', 1, 'Drama');

--Following 3NF

CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL
);

CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    genre_id INTEGER REFERENCES genres(genre_id)
);

INSERT INTO genres (genre_name) VALUES
	('Drama'),
	('Comedy'),
	('Action');

INSERT INTO movies (title, genre_id) VALUES ('Forrest Gump', 1); 

--Design process

CREATE TABLE viewers (
    viewer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL
);

CREATE TABLE viewing_history (
    view_id SERIAL PRIMARY KEY,
    viewer_id INTEGER NOT NULL REFERENCES viewers(viewer_id),
    movie_id INTEGER NOT NULL REFERENCES movies(movie_id),
    watched_date DATE DEFAULT CURRENT_DATE,
    rating SMALLINT CHECK (rating BETWEEN 1 AND 5)
);

INSERT INTO viewers (full_name) VALUES ('Aiganysh Doolotbekova');

INSERT INTO viewing_history (viewer_id, movie_id, rating) VALUES (1, 1, 5);

SELECT v.full_name AS viewer, m.title, g.genre_name, vh.watched_date, vh.rating
FROM viewers v
JOIN viewing_history vh ON v.viewer_id = vh.viewer_id
JOIN movies m ON vh.movie_id = m.movie_id
JOIN genres g ON m.genre_id = g.genre_id;

