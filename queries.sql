CREATE DATABASE book_notes

CREATE TABLE authors(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL
);

CREATE TABLE books(
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL, 
    isbn VARCHAR(20),
    author_id INTEGER REFERENCES authors(id) -- Many to one --
);

CREATE TABLE notes(
    id SERIAL PRIMARY KEY,
    book_id INTEGER REFERENCES books(id) UNIQUE, -- One to one --
    date_read DATE NOT NULL,
    summary TEXT,
    notes TEXT,
    rating FLOAT
);

INSERT INTO authors(name)
VALUES ('Andrzej Sapkowski'),('Frank Herbert'),('Lewis Carroll');

INSERT INTO books(title, isbn, author_id)
VALUES ('The Last Wish', '9780316029186', 1),
('Sword of Destiny', '1473231086', 1),
('Dune', '0441172717', 2),
('Alice in Wonderland', '184022780X', 3);

INSERT INTO notes(book_id, date_read, summary, notes, rating)
VALUES (1, '2024-03-22', 'The Last Wish Summary', 'The last Wish Notes', '10'),
(2, '2024-03-23', 'Sword of Destiny Summary', 'Sword of Destiny Notes', '10'), 
(3, '2022-01-22', 'Dune Summary', 'Dune Notes', '10'), 
(4, '2019-01-20', 'Alice in Wonderland Summary', 'Alice in Wonderland Notes', '8');