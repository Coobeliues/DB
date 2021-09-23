
-- "  1  " --

-- DDL:
-- DDL is Data Definition Language which is used to define data structures.
-- For example: create table, alter table are instructions in SQL.

-- DML:
-- DML is Data Manipulation Language which is used to manipulate data itself.
-- For example: insert, update, delete are instructions in SQL.

-- Difference between DDL and DML:

-- DDL:
-- It is used to create database schema and can be used to define some constraints as well.
-- It basically defines the column (Attributes) of the table.
-- Basic command present in DDL are CREATE, DROP, RENAME etc.
-- DDL does not use WHERE clause in its statement.

-- DML:
-- It is used to add, retrieve or update the data.
-- It add or update the row of the table.
-- BASIC command present in DML are UPDATE, INSERT, DELETE, MERGE etc.
-- DML uses WHERE clause in its statement.


-- "  2  " --

CREATE TABLE customers
(
    id               INTEGER PRIMARY KEY,
    full_name        VARCHAR(50) NOT NULL,
    timestamp        TIMESTAMP   NOT NULL,
    delivery_address text        NOT NULL
);

CREATE TABLE products
(
    id          VARCHAR PRIMARY KEY,
    name        VARCHAR UNIQUE   NOT NULL,
    description TEXT,
    price       DOUBLE PRECISION NOT NULL CHECK (price > 0)
);


CREATE TABLE orders
(
    code        INTEGER PRIMARY KEY,
    customer_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE,
    total_sum   DOUBLE PRECISION NOT NULL CHECK (total_sum > 0),
    is_paid     BOOLEAN          NOT NULL
);

CREATE TABLE order_items
(
    order_code INTEGER UNIQUE NOT NULL,
    product_id VARCHAR UNIQUE NOT NULL,
    FOREIGN KEY (order_code) REFERENCES orders (code) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE,
    quantity   INTEGER        NOT NULL CHECK (quantity >= 1),
    PRIMARY KEY (order_code, product_id)
);


-- "  3  " --

CREATE TABLE genders
(
    id           INTEGER PRIMARY KEY,
    gender_type VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE students
(
    id                INTEGER PRIMARY KEY,
    last_name         VARCHAR(255)     NOT NULL,
    first_name        VARCHAR(255)     NOT NULL,
    daddys_name       VARCHAR(255)     NOT NULL,
    age               INTEGER          NOT NULL CHECK (age >=18),
    birth_date        DATE             NOT NULL,
    gender            VARCHAR(31)      NOT NULL,
    FOREIGN KEY (gender) REFERENCES genders (gender_type) ON DELETE CASCADE,
    gpa               DOUBLE PRECISION NOT NULL CHECK (0 <= gpa AND gpa <= 4.0),
    self_info         TEXT             NOT NULL,
    need_in_dormitory BOOLEAN          NOT NULL,
    additional_info   TEXT

);

CREATE TABLE instructors
(
    id             INTEGER PRIMARY KEY,
    last_name      VARCHAR(255) NOT NULL,
    first_name     VARCHAR(255) NOT NULL,
    fathers_name   VARCHAR(255) NOT NULL,
    languages      VARCHAR(255) NOT NULL,
    works          VARCHAR(255) NOT NULL,
    remote_lessons BOOLEAN      NOT NULL
);

CREATE TABLE instructor_language
(
    instructor_id INTEGER NOT NULL,
    language_id   INTEGER NOT NULL,
    PRIMARY KEY (language_id, instructor_id),
    FOREIGN KEY (instructor_id) REFERENCES instructors (id) ON DELETE CASCADE,
    FOREIGN KEY (language_id) REFERENCES languages (id) ON DELETE CASCADE
);

CREATE TABLE instructor_workPlaces
(
    instructor_id INTEGER NOT NULL,
    work_id       INTEGER NOT NULL,
    PRIMARY KEY (work_id, instructor_id),
    FOREIGN KEY (instructor_id) REFERENCES instructors (id) ON DELETE CASCADE,
    FOREIGN KEY (work_id) REFERENCES work_places (id) ON DELETE CASCADE
);

CREATE TABLE languages
(
    id             INTEGER PRIMARY KEY,
    language_title VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE work_places
(
    id         INTEGER PRIMARY KEY,
    work_title VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE lesson
(
    id                     INTEGER PRIMARY KEY,
    lesson_title           VARCHAR(255)   NOT NULL UNIQUE,
    instructor_id          INTEGER        NOT NULL UNIQUE,
    instructor_lastName    VARCHAR(255)   NOT NULL,
    instructor_name        VARCHAR(255)   NOT NULL,
    instructor_fathersName VARCHAR(255)   NOT NULL,
    students_ids           INTEGER UNIQUE NOT NULL,
    room                   INTEGER        NOT NULL UNIQUE CHECK (room >= 1)
);

CREATE TABLE student_class
(
    student_id INTEGER NOT NULL,
    lesson_id  INTEGER NOT NULL,
    PRIMARY KEY (student_id, lesson_id),
    FOREIGN KEY (student_id) REFERENCES students (id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE
);

INSERT INTO genders(gender_type)
VALUES ('Male');
INSERT INTO genders(gender_type)
VALUES ('Female');

INSERT INTO students
VALUES (1, 'Naryshov', 'Yernar', 'Zhumatuly', 18, '11.02.2003', 'Male', 3.17, 'Likes nothing', True);
INSERT INTO students
VALUES (2, 'Abdykerim', 'Akezhan', 'Gelmanuly', 18, '24.11.2002', 'Male', 2.18, 'Likes gossip', True);
INSERT INTO students
VALUES (3, 'Kipshakbaev', 'Sanzhar', 'Yerdenovich', 19, '06.05.2002', 'Male', 3.66, 'Likes zhylanit', True, 'he is lox');

INSERT INTO work_places(work_title)
VALUES ('1Fit');
INSERT INTO work_places(work_title)
VALUES ('NoWhere');

INSERT INTO languages(language_title)
VALUES ('English');
INSERT INTO languages(language_title)
VALUES ('Kazakh');
INSERT INTO languages(language_title)
VALUES ('Russian');

INSERT INTO instructors
VALUES (1, 'Akshabayev', 'Askar', 'Kurmanalievich', 'English', '1Fit', true);
INSERT INTO instructor_language
VALUES (1, 1);
INSERT INTO instructor_language
VALUES (1, 3);

INSERT INTO instructor_workPlaces
VALUES (1, 1);

SELECT instructors.last_name, language_title
FROM languages,
     instructor_language,
     instructors
WHERE (instructors.id = instructor_language.instructor_id and instructor_language.language_id = languages.id);



-- "  4  " --

INSERT INTO customers
VALUES (1, 'Keosido', current_timestamp, 'Tastack turgut ozala 70');
INSERT INTO customers
VALUES (2, 'Dr Armani', current_timestamp, 'New York');

INSERT INTO products
VALUES ('VOD', 'Vodka', 'Sinyaya gora', 2590);
INSERT INTO products
VALUES ('BEE', 'Beer', 'Shymkentskoe razlivnoe', 500);

INSERT INTO orders
VALUES (1, 2, 2590, TRUE);
INSERT INTO orders
VALUES (2, 1, 500 * 30, TRUE);

UPDATE orders
SET total_sum = 500 * 60
WHERE code = 2;
UPDATE orders
SET is_paid = FALSE
WHERE code = 2;

INSERT INTO order_items
VALUES (1, 'VOD', 1);
INSERT INTO order_items
VALUES (2, 'BER', 60);

DELETE
FROM orders
WHERE customer_id = 2;
