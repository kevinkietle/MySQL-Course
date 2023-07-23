USE book_shop;

SELECT * FROM books WHERE released_year != 2017;
SELECT * FROM books WHERE title NOT LIKE '%e%';
SELECT * FROM books WHERE pages > 500;
SELECT * FROM books WHERE released_year <= 1985;
SELECT title, author_lname, released_year FROM books WHERE released_year > 2010
AND author_lname = 'Eggers' AND title LIKE '%novel%';
SELECT title, pages FROM books WHERE pages < 200  OR title LIKE '%stories%';
SELECT title, released_year FROM books WHERE released_year BETWEEN 2004 AND 2014;
SELECT * FROM people WHERE birthtime BETWEEN CAST('12:00:00' AS TIME) AND CAST('16:00:00' AS TIME);
SELECT title, author_lname FROM books WHERE author_lname NOT IN ('Carver', 'Lahiri', 'Smith');
SELECT title, released_year FROM books WHERE released_year >= 2000 AND released_year % 2 = 1;
SELECT 
    title,
    stock_quantity,
    CASE
        WHEN stock_quantity BETWEEN 0 AND 40 THEN '*'
        WHEN stock_quantity BETWEEN 41 AND 70 THEN '**'
        WHEN stock_quantity BETWEEN 71 AND 100 THEN '***'
        WHEN stock_quantity BETWEEN 101 AND 140 THEN '****'
        ELSE '*****'
    END AS stock
FROM
    books;
    
-- Comparison and Logical Operators Exercise

SELECT title, author_lname, released_year FROM books WHERE released_year < 1980;
SELECT title, author_lname FROM books WHERE author_lname IN ('Eggers', 'Chabon');
SELECT title, author_lname, released_year FROM books WHERE author_lname = 'Lahiri' AND released_year > 2000;
SELECT title, pages FROM books WHERE pages BETWEEN 100 AND 200;
SELECT title, author_lname FROM books WHERE author_lname LIKE 'C%' OR author_lname LIKE 'S%';
SELECT title, author_lname, 
CASE
	WHEN title LIKE '%Stories%' THEN 'Short Stories'
    WHEN title = 'Just Kids' OR title LIKE 'A Heartbreaking Work%' THEN 'Memoir'
    ELSE 'Novel'
END AS 'TYPE'
FROM books;
SELECT author_fname, author_lname, 
CASE
	WHEN COUNT(*) = 1 THEN '1 book'
    ELSE CONCAT(COUNT(*), ' books')
END AS 'COUNT'
FROM books
GROUP BY author_fname, author_lname;

-- End of exercise

CREATE TABLE contacts (
	name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE users (
	username VARCHAR(20) NOT NULL,
    age INT CHECK (age > 0)
);

CREATE TABLE users2 (
    username VARCHAR(20) NOT NULL,
    age INT,
    CONSTRAINT age_not_negative CHECK (age >= 0)
);

CREATE TABLE companies (
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    CONSTRAINT name_address UNIQUE (name , address)
);
 
CREATE TABLE houses (
  purchase_price INT NOT NULL,
  sale_price INT NOT NULL,
  CONSTRAINT sprice_gt_pprice CHECK(sale_price >= purchase_price)
);

ALTER TABLE companies ADD COLUMN phone VARCHAR(15);
ALTER TABLE companies ADD COLUMN employee_count INT NOT NULL DEFAULT 1;
ALTER TABLE companies DROP COLUMN phone;
RENAME TABLE companies to suppliers;
ALTER TABLE suppliers RENAME TO companies;
ALTER TABLE companies RENAME COLUMN name TO company_name;
ALTER TABLE companies MODIFY company_name VARCHAR(100) DEFAULT 'unknown';
ALTER TABLE companies CHANGE company_name biz_name VARCHAR(50);
ALTER TABLE houses  ADD CONSTRAINT positive_pprice CHECK (purchase_price >= 0);
ALTER TABLE houses DROP CONSTRAINT positive_pprice;

-- One to Many and Joins

CREATE DATABASE example;
USE example;

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
 
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);
 
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);
       
-- To perform a (kind of useless) cross join:
SELECT * FROM customers, orders;
-- Our first inner join!
SELECT * FROM customers
JOIN orders ON orders.customer_id = customers.id;
SELECT 
    first_name, last_name, SUM(amount) AS total
FROM
    customers
        JOIN
    orders ON orders.customer_id = customers.id
GROUP BY first_name , last_name
ORDER BY total;
SELECT 
    first_name, last_name, order_date, amount
FROM
    customers
        LEFT JOIN
    orders ON orders.customer_id = customers.id;
SELECT 
    first_name, 
    last_name, 
    IFNULL(SUM(amount), 0) AS money_spent
FROM
    customers
        LEFT JOIN
    orders ON customers.id = orders.customer_id
GROUP BY first_name , last_name;
SELECT 
    first_name, last_name, order_date, amount
FROM
    customers
        RIGHT JOIN
    orders ON customers.id = orders.customer_id;

CREATE TABLE orders2 (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8 , 2 ),
    customer_id INT,
    FOREIGN KEY (customer_id)
        REFERENCES customers (id)
        ON DELETE CASCADE
);

-- One to Many and Joins Exercise

CREATE TABLE students(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(20));
    
CREATE TABLE papers(
	title VARCHAR(20),
    grade INT CHECK (grade BETWEEN 0 AND 100),
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students (id) ON DELETE CASCADE);

INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

ALTER TABLE papers MODIFY title VARCHAR(200);
INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

SELECT first_name, title, grade FROM papers
	JOIN students ON papers.student_id = students.id
    ORDER BY grade DESC;
SELECT first_name, title, grade FROM papers
	RIGHT JOIN students ON papers.student_id = students.id;
SELECT first_name, IFNULL(title, 'MISSING'), IFNULL(grade, 0) FROM papers
	RIGHT JOIN students ON papers.student_id = students.id;
SELECT first_name, IFNULL(AVG(grade), 0) AS 'average'
FROM
    papers
        RIGHT JOIN
    students ON papers.student_id = students.id
GROUP BY first_name
ORDER BY average DESC;
SELECT first_name, IFNULL(AVG(grade), 0) AS 'average',
CASE
	WHEN IFNULL(AVG(grade), 0) > 75 THEN 'PASSING'
    ELSE 'FAILING'
END AS 'passing_status'
FROM
    papers
        RIGHT JOIN
    students ON papers.student_id = students.id
GROUP BY first_name
ORDER BY average DESC;

-- End of exercise


