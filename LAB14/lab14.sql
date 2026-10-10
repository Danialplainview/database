INSERT INTO shelf_books (title, author, genre, price, pages, publisher) VALUES
    ('One Hundred Years of Solitude', 'Gabriel Garcia Marquez', 'Magical Realism', 13.90, 656, 'Editorial Sudamericana'),
    ('The Stranger', 'Albert Camus', 'Novella', 10.50, 144, NULL);

INSERT INTO book_sales (book_id, copies_sold, sale_date) VALUES
    (NULL, 8, '2026-04-15');

CREATE TABLE readers (
    reader_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL
);

CREATE TABLE reader_favorites (
    reader_id INTEGER REFERENCES readers(reader_id),
    book_id INTEGER REFERENCES shelf_books(book_id),
    PRIMARY KEY (reader_id, book_id)
);

INSERT INTO readers (full_name) VALUES
    ('Aiganysh Doolotbekova'),
    ('Sagynbubu Duisheeva'),
    ('Doolotbek Chekirov');

INSERT INTO reader_favorites (reader_id, book_id) VALUES
    (1, 1),
    (1, 7),
    (2, 1),
    (2, 3),
    (2, 8);

SELECT b.title, s.copies_sold, s.sale_date
FROM shelf_books b
INNER JOIN book_sales s ON b.book_id = s.book_id
ORDER BY b.title, s.sale_date;

SELECT b.title, s.copies_sold, s.sale_date
FROM shelf_books b
LEFT JOIN book_sales s ON b.book_id = s.book_id
ORDER BY b.title;

SELECT b.title, s.copies_sold, s.sale_date
FROM shelf_books b
RIGHT JOIN book_sales s ON b.book_id = s.book_id
ORDER BY s.sale_date;

SELECT b.title, s.copies_sold, s.sale_date
FROM shelf_books b
FULL OUTER JOIN book_sales s ON b.book_id = s.book_id
ORDER BY b.title, s.sale_date;

SELECT r.full_name, g.genre
FROM readers r
CROSS JOIN (SELECT DISTINCT genre FROM shelf_books) g
ORDER BY r.full_name, g.genre;

SELECT r.full_name, b.title, b.author
FROM readers r
INNER JOIN reader_favorites f ON r.reader_id = f.reader_id
INNER JOIN shelf_books b ON f.book_id = b.book_id
ORDER BY r.full_name, b.title;

SELECT a.author, a.title AS book_1, b.title AS book_2
FROM shelf_books a
INNER JOIN shelf_books b ON a.author = b.author AND a.book_id < b.book_id
ORDER BY a.author, a.title;

SELECT b.title, s.copies_sold, s.sale_date
FROM shelf_books b
INNER JOIN book_sales s ON b.book_id = s.book_id
WHERE s.sale_date >= '2026-03-01' AND s.copies_sold > 20
ORDER BY s.sale_date;

SELECT b.title
FROM shelf_books b
LEFT JOIN book_sales s ON b.book_id = s.book_id
WHERE s.book_id IS NULL;

SELECT r.full_name
FROM readers r
LEFT JOIN reader_favorites f ON r.reader_id = f.reader_id
WHERE f.reader_id IS NULL;

CREATE INDEX idx_book_sales_book_id ON book_sales(book_id);
CREATE INDEX idx_reader_favorites_book_id ON reader_favorites(book_id);

SELECT indexname FROM pg_indexes WHERE tablename = 'book_sales';

