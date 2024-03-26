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
('Sword of Destiny', '0316389706', 1),
('Dune', '0441172717', 2),
('Alice Adventures in Wonderland', '1503222683', 3);

INSERT INTO notes(book_id, date_read, summary, notes, rating)
VALUES (1, '2024-03-22', 'The Last Wish Summary. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam mattis felis non venenatis sodales. Morbi lacus ipsum, consectetur non massa at, aliquet volutpat libero. Sed consectetur auctor tortor sed consequat. Duis lobortis ipsum eu tortor efficitur dapibus. Praesent eu faucibus urna. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nulla imperdiet nec neque a accumsan. Proin maximus, nulla in tristique sagittis, leo libero elementum enim, sit amet sagittis velit odio vitae felis.', 'The last Wish Notes.', '10'),
(2, '2024-03-23', 'Sword of Destiny Summary. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam mattis felis non venenatis sodales. Morbi lacus ipsum, consectetur non massa at, aliquet volutpat libero. Sed consectetur auctor tortor sed consequat. Duis lobortis ipsum eu tortor efficitur dapibus. Praesent eu faucibus urna. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nulla imperdiet nec neque a accumsan. Proin maximus, nulla in tristique sagittis, leo libero elementum enim, sit amet sagittis velit odio vitae felis.', 'Sword of Destiny Notes.', '10'), 
(3, '2022-01-22', 'Dune Summary. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam mattis felis non venenatis sodales. Morbi lacus ipsum, consectetur non massa at, aliquet volutpat libero. Sed consectetur auctor tortor sed consequat. Duis lobortis ipsum eu tortor efficitur dapibus. Praesent eu faucibus urna. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nulla imperdiet nec neque a accumsan. Proin maximus, nulla in tristique sagittis, leo libero elementum enim, sit amet sagittis velit odio vitae felis.', 'Dune Notes.', '10'), 
(4, '2019-01-20', 'Alice Adventures in Wonderland Summary. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam mattis felis non venenatis sodales. Morbi lacus ipsum, consectetur non massa at, aliquet volutpat libero. Sed consectetur auctor tortor sed consequat. Duis lobortis ipsum eu tortor efficitur dapibus. Praesent eu faucibus urna. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nulla imperdiet nec neque a accumsan. Proin maximus, nulla in tristique sagittis, leo libero elementum enim, sit amet sagittis velit odio vitae felis.', 'Alice Adventures in Wonderland Notes.', '8');

UPDATE notes
SET notes='Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam mattis felis non venenatis sodales. Morbi lacus ipsum, consectetur non massa at, aliquet volutpat libero. Sed consectetur auctor tortor sed consequat. Duis lobortis ipsum eu tortor efficitur dapibus. Praesent eu faucibus urna. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nulla imperdiet nec neque a accumsan. Proin maximus, nulla in tristique sagittis, leo libero elementum enim, sit amet sagittis velit odio vitae felis.

Nunc mauris felis, pharetra non ultricies vulputate, dignissim vitae nisl. Ut bibendum laoreet justo vitae placerat. Aliquam euismod risus quis bibendum volutpat. Proin at bibendum nulla. Suspendisse potenti. Donec quis augue tincidunt, pretium quam quis, semper risus. Nulla laoreet orci dolor, eu auctor quam maximus non. Donec turpis leo, malesuada ut elit vitae, maximus sagittis metus. Donec sit amet lacus sit amet massa auctor aliquet id eu odio. Nulla facilisi. Donec quis arcu vulputate, viverra diam sed, efficitur turpis. Suspendisse nec ultricies magna. Sed ipsum urna, malesuada vitae tristique vel, gravida et nulla. Curabitur iaculis placerat arcu, cursus tincidunt quam consectetur sed. Nulla ac leo sit amet dolor sollicitudin gravida vel nec ligula. Nam mattis, libero quis luctus ornare, leo neque rhoncus velit, id maximus quam felis sit amet elit.

Nunc libero orci, condimentum ut fringilla sit amet, hendrerit hendrerit eros. Phasellus placerat id nisi eu ultrices. Ut finibus turpis turpis, sit amet tincidunt arcu viverra ac. Quisque in consectetur lectus. Nam purus leo, dignissim non molestie ut, tempus pharetra lacus. Etiam rhoncus ullamcorper leo, vitae auctor lacus mattis in. Morbi ac laoreet ligula.

Donec sed ante nisl. Maecenas lobortis eleifend cursus. Proin facilisis metus sit amet est rutrum luctus. Donec sit amet mollis lectus. Quisque sed accumsan erat. Quisque vitae quam ac risus consequat varius. Nulla lacinia blandit mattis. Praesent ac orci at sem varius maximus. Praesent nec bibendum urna, quis elementum nisl. Nullam interdum placerat aliquam. Cras quis orci sed elit porta viverra. Pellentesque rhoncus mattis neque, vel hendrerit massa porttitor non. Phasellus nulla nunc, lacinia ut eros eget, viverra laoreet metus. Proin neque diam, pellentesque ut tortor eget, tincidunt euismod enim. Etiam vitae cursus diam.

Quisque ut hendrerit mi. Maecenas a fringilla neque. Cras risus lacus, elementum in ante ac, venenatis tristique nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum vitae mi elementum tellus auctor efficitur sit amet vel ante. Donec consequat nibh vitae metus condimentum, vitae aliquet dui feugiat. Fusce imperdiet lorem in felis lobortis elementum. Nunc ac egestas justo. Ut dapibus ornare pulvinar.'

SELECT books.title, books.isbn, notes.date_read, notes.summary, notes.rating, authors.name
FROM books
JOIN notes ON books.id = notes.book_id
JOIN authors ON books.author_id = authors.id;

SELECT books.id, books.title, books.isbn, notes.date_read, notes.summary, notes.notes, notes.rating, authors.name
FROM books
JOIN notes ON books.id = notes.book_id
JOIN authors ON books.author_id = authors.id
WHERE books.id = 1;

SELECT books.title, books.isbn, notes.date_read, notes.summary, notes.rating, authors.name
FROM books
JOIN notes ON books.id = notes.book_id
JOIN authors ON books.author_id = authors.id
WHERE
    books.title ILIKE '%' || 'your_search_string' || '%'
    OR notes.summary ILIKE '%' || 'your_search_string' || '%'
    OR authors.name ILIKE '%' || 'your_search_string' || '%';

SELECT books.title, books.isbn, notes.date_read, notes.summary, notes.rating, authors.name
FROM books
JOIN notes ON books.id = notes.book_id
JOIN authors ON books.author_id = authors.id
ORDER BY <column_to_sort_by> DESC;    