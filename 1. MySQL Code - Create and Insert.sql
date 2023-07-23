CREATE DATABASE pet_shop;
CREATE DATABASE slime_store;
SHOW DATABASES;
DROP DATABASE slime_store;

USE pet_shop;
SELECT database();

CREATE TABLE cats
	(
		name VARCHAR(100),
        age int
	);
    
CREATE TABLE dogs (
    name VARCHAR(50),
    breed VARCHAR(50),
    age INT
);

SHOW TABLES;
SHOW COLUMNS FROM cats;
DESC dogs;
-- End of Section 3 activity
CREATE TABLE pastries 
	(name VARCHAR(50),
    quantity INT);
DESC pastries;
DROP TABLE pastries;

INSERT INTO cats (name, age)
VALUES("Blue", 5);

INSERT INTO cats(age, name)
VALUES(2, "Beth");

INSERT INTO cats(name, age)
VALUES("Meatball", 5),
("Turkey", 1),
("Potato Face", 15);

SELECT * FROM cats;

CREATE TABLE people(
	first_name VARCHAR(20),
	last_name VARCHAR(20),
    age INT);
    
INSERT INTO people(first_name, last_name, age)
VALUES('Tina', 'Belcher', 13);

INSERT INTO people(first_name, last_name, age)
VALUES('Linda', 'Belcher', 45),
	('Phillip', 'Frond', 38),
    ('Calvin', 'Fischoeder', 70);
    
SELECT * FROM people;
DROP TABLE people;

CREATE TABLE cats2(
	name VARCHAR(100) NOT NULL,
    age INT NOT NULL);
    
DESC cats;

CREATE TABLE cats3(
	name VARCHAR(100) DEFAULT 'unnamed',
    age INT DEFAULT 99);
    
INSERT INTO cats3(age) VALUES(13);

SELECT * FROM cats3;

CREATE TABLE unique_cats(
	cat_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(100),
    age INT);
-- Primary keys already cannot be null

CREATE TABLE unique_cats2(
	cat_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    PRIMARY KEY (cat_id));
-- Can also do primary key on same line

INSERT INTO unique_cats2(name, age) VALUES('Oingo', 6);

SELECT * FROM unique_cats2;

-- Section 4 activity

CREATE TABLE employees(
	id INT AUTO_INCREMENT PRIMARY KEY,
    last_name VARCHAR(20) NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    middle_name VARCHAR(20),
    age INT NOT NULL,
    current_status VARCHAR(50) NOT NULL DEFAULT 'employed');
    
