CREATE TABLE authors (
	author_id SERIAL PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL,
	country VARCHAR(50) 
);
INSERT INTO authors (full_name, country) VALUES
('Victor Hugo', 'France'),
('Fyodor Dostoevsky', 'Russia'),
('Erich Maria Remarque', 'Germany');

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    author_id INTEGER,
    published_year INTEGER
);

INSERT INTO books (title, author_id, published_year) VALUES
('Les Miserables', 1, 1862),
('Crime and Punishment', 2, 1866),
('All Quiet on the Western Front', 3, 1929);

CREATE TABLE borrow_records (
    member_id INTEGER,
    book_id INTEGER,
    borrow_date DATE DEFAULT CURRENT_DATE,
    return_date DATE,
    PRIMARY KEY (member_id, book_id, borrow_date)
);

INSERT INTO borrow_records (member_id, book_id, borrow_date) VALUES
(1, 1, '2026-01-10'),
(1, 2, '2026-01-10'),
(2, 1, '2026-01-15'),
(1, 1, '2026-02-01');

INSERT INTO authors (author_id, full_name, country) VALUES
(1, 'Fake Author', 'Nowhere');
