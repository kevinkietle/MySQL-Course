CREATE DATABASE book_shop;
USE book_shop;

CREATE TABLE books 
	(
		book_id INT NOT NULL AUTO_INCREMENT,
		title VARCHAR(100),
		author_fname VARCHAR(100),
		author_lname VARCHAR(100),
		released_year INT,
		stock_quantity INT,
		pages INT,
		PRIMARY KEY(book_id)
	);

INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);

SELECT * FROM books;
SELECT CONCAT(author_fname,' ', author_lname) AS author_name FROM books;
SELECT CONCAT_WS('-',title, author_fname, author_lname) FROM books;
SELECT SUBSTRING(title, 1, 10) AS 'short title' FROM books;
SELECT CONCAT
    (
        SUBSTRING(title, 1, 10),
        '...'
    ) AS 'short title'
FROM books;
SELECT REPLACE(title, ' ', '-') FROM books;
SELECT REVERSE(author_fname) FROM books;
SELECT CHAR_LENGTH(title) as length, title FROM books;
SELECT CONCAT('I LOVE ', UPPER(title), '!!!') FROM books;
SELECT INSERT('Hello Bobby', 6, 0, 'There'); 
SELECT LEFT('omghahalol!', 3);
SELECT RIGHT('omghahalol!', 4);
SELECT REPEAT('ha', 4);
SELECT TRIM('  pickle  ');

-- String Functions Exercise

SELECT REVERSE(UPPER("Why does my cat look at me with such hatred?"));
SELECT REPLACE(title, ' ', '->') FROM books;
SELECT author_lname AS forwards, REVERSE(author_lname) AS backwards FROM books;
SELECT UPPER(CONCAT(author_fname, ' ', author_lname)) AS full_name FROM books;
SELECT CONCAT(title, ' was released in ', released_year) AS blurb FROM books;
SELECT title, CHAR_LENGTH(title) AS character_count FROM books;
SELECT 
CONCAT(LEFT(title, 10), '...') AS 'short title', 
CONCAT(author_lname, ',', author_fname) AS author,
CONCAT(stock_quantity, ' in stock') AS quantity
FROM books;

-- End of exercise

INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);
           
SELECT DISTINCT author_fname, author_lname FROM books;
SELECT * FROM books ORDER BY author_lname;
SELECT * FROM books ORDER BY author_lname DESC;
SELECT book_id, author_fname, author_lname, pages FROM books ORDER BY 2 desc;
SELECT book_id, author_fname, author_lname, pages FROM books ORDER BY author_lname, author_fname;
SELECT title FROM books LIMIT 10;
SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 1,3;
SELECT title, author_fname, author_lname, pages 
FROM books
WHERE author_fname LIKE '%da%';
SELECT * FROM books
WHERE author_fname LIKE '_a_';
-- To select books with '%' in their title, also works with '_':
SELECT * FROM books
WHERE title LIKE '%\%%';

-- Refining Selections Exercise
SELECT title FROM books WHERE title LIKE '%Stories%';
SELECT title FROM books ORDER BY pages DESC LIMIT 1;
SELECT CONCAT(title, ' - ', released_year) AS summary FROM books ORDER BY released_year DESC LIMIT 3;
SELECT title, author_lname FROM books WHERE author_lname LIKE '% %';
SELECT title, released_year, stock_quantity FROM books ORDER BY stock_quantity LIMIT 3;
SELECT title, author_lname FROM books ORDER BY author_lname, title;
SELECT UPPER(CONCAT('My favorite author is ', author_fname, ' ', author_lname, '!')) AS yell
FROM books ORDER BY author_lname;

-- End of exercise

SELECT COUNT(*) FROM books;
SELECT COUNT(DISTINCT author_lname) FROM books;
SELECT author_lname, COUNT(*) 
FROM books
GROUP BY author_lname;
SELECT MAX(pages) FROM books;
SELECT title, pages FROM books
WHERE pages = (SELECT MAX(pages) FROM books);
SELECT MIN(released_year) FROM books;
SELECT author_fname, author_lname, COUNT(*) 
FROM books 
GROUP BY author_lname, author_fname;
SELECT CONCAT(author_fname, ' ', author_lname) AS author,  COUNT(*)
FROM books
GROUP BY author;
SELECT author_lname, MAX(released_year), MIN(released_year) FROM books GROUP BY author_lname;
SELECT 
	author_lname, 
	COUNT(*) as books_written, 
	MAX(released_year) AS latest_release,
	MIN(released_year)  AS earliest_release,
	MAX(pages) AS longest_page_count
FROM books GROUP BY author_lname;
SELECT author_lname, COUNT(*), SUM(pages)
FROM books
GROUP BY author_lname;
SELECT 
    released_year, 
    AVG(stock_quantity), 
    COUNT(*) FROM books
GROUP BY released_year;

-- Aggregate Functions Exercise

SELECT COUNT(*) FROM books;
SELECT released_year, COUNT(*) FROM books GROUP BY released_year;
SELECT SUM(stock_quantity) FROM books;
SELECT author_fname, author_lname, AVG(released_year) FROM books GROUP BY author_fname, author_lname;
SELECT CONCAT(author_fname, ' ', author_lname), pages FROM books WHERE pages = (SELECT MAX(pages) FROM books);
SELECT released_year AS year, COUNT(*) AS '# books', AVG(pages) AS 'avg pages' 
FROM books GROUP BY released_year ORDER BY released_year;

-- End of exercise

CREATE TABLE people (
	name VARCHAR(100),
    birthdate DATE,
    birthtime TIME,
    birthdt DATETIME
);
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Elton', '2000-12-25', '11:00:00', '2000-12-25 11:00:00');
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Hazel', CURDATE(), CURTIME(), NOW());
SELECT 
    birthdate,
    DAY(birthdate),
    DAYOFWEEK(birthdate),
    DAYOFYEAR(birthdate)
FROM people;
 
SELECT 
    birthdate,
    MONTHNAME(birthdate),
    YEAR(birthdate)
FROM people;
SELECT 
    birthdt,
    MONTH(birthdt),
    DAY(birthdt),
    HOUR(birthdt),
    MINUTE(birthdt)
FROM people;
SELECT birthdate, DATE_FORMAT(birthdate, '%a %b %D') FROM people;
CREATE TABLE captions (
  text VARCHAR(150),
  created_at TIMESTAMP default CURRENT_TIMESTAMP
);
 
CREATE TABLE captions2 (
  text VARCHAR(150),
  created_at TIMESTAMP default CURRENT_TIMESTAMP,
  updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Revisiting Data Types Exercise

SELECT CURTIME();
 
SELECT CURDATE();
 
SELECT DAYOFWEEK(CURDATE());
SELECT DAYOFWEEK(NOW());
SELECT DATE_FORMAT(NOW(), '%w') + 1;
 
SELECT DAYNAME(NOW());
SELECT DATE_FORMAT(NOW(), '%W');
 
SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');
 
SELECT DATE_FORMAT(NOW(), '%M %D at %h:%i');
 
CREATE TABLE tweets(
    content VARCHAR(140),
    username VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW()
);
 
INSERT INTO tweets (content, username) VALUES('this is my first tweet', 'coltscat');
SELECT * FROM tweets;
 
INSERT INTO tweets (content, username) VALUES('this is my second tweet', 'coltscat');
SELECT * FROM tweets;

-- End of exercise


