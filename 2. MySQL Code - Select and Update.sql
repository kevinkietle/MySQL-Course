SHOW DATABASES;
USE pet_shop;

SHOW TABLES;
DROP TABLE cats;

CREATE TABLE cats (
    cat_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    breed VARCHAR(100),
    age INT,
    PRIMARY KEY (cat_id)
); 

INSERT INTO cats(name, breed, age) 
VALUES ('Ringo', 'Tabby', 4),
       ('Cindy', 'Maine Coon', 10),
       ('Dumbledore', 'Maine Coon', 11),
       ('Egg', 'Persian', 4),
       ('Misty', 'Tabby', 13),
       ('George Michael', 'Ragdoll', 9),
       ('Jackson', 'Sphynx', 7);
       
SELECT name, age FROM cats;

SELECT * FROM cats WHERE age=4;

SELECT cat_id AS id, name FROM cats;

SELECT * FROM cats;
UPDATE cats SET breed='Shorthair' WHERE breed='Tabby';
UPDATE cats SET age=14 WHERE name='Misty';

DELETE FROM cats WHERE name='Egg';

-- CRUD Mega Challenge

CREATE DATABASE shirts_db;
USE shirts_db;

CREATE TABLE shirts(
	shirt_id INT AUTO_INCREMENT PRIMARY KEY,
    article VARCHAR(100) NOT NULL,
    color VARCHAR(100) NOT NULL,
    shirt_size VARCHAR(3) NOT NULL,
    last_worn INT DEFAULT 0 NOT NULL);
    
INSERT INTO shirts(article, color, shirt_size, last_worn)
VALUES('t-shirt', 'white', 'S', 10),
('t-shirt', 'green', 'S', 200),
('polo shirt', 'black', 'M', 10),
('tank top', 'blue', 'S', 50),
('t-shirt', 'pink', 'S', 0),
('polo shirt', 'red', 'M', 5),
('tank top', 'white', 'S', 200),
('tank top', 'blue', 'M', 15);

INSERT INTO shirts(color, article, shirt_size, last_worn)
VALUES ('purple', 'polo shirt', 'M', 50);

SELECT article, color FROM shirts;
SELECT article, color, shirt_size, last_worn FROM shirts WHERE shirt_size='M';
UPDATE shirts SET shirt_size='L';
UPDATE shirts SET last_worn = 0 WHERE last_worn=15;
UPDATE shirts SET shirt_size='XS', color='off white' WHERE color='white';
DELETE FROM shirts WHERE last_worn=200;
DELETE FROM shirts WHERE article='tank top';
DELETE FROM shirts;
DROP TABLE shirts;

-- End of CRUD Mega Challenge


    