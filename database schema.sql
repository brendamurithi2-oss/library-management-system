
-- =========================================================
-- Library Management System - Database Schema
-- Author: Bree
-- Description: Relational schema for a College Library
--              Management System (3NF normalized)
-- =========================================================

DROP TABLE IF EXISTS BORROW;
DROP TABLE IF EXISTS BOOK;
DROP TABLE IF EXISTS AUTHOR;
DROP TABLE IF EXISTS CATEGORY;
DROP TABLE IF EXISTS STUDENT;

-- ---------------------------------------------------------
-- STUDENT: library members who can borrow books
-- ---------------------------------------------------------
CREATE TABLE STUDENT (
    student_id      INT PRIMARY KEY AUTO_INCREMENT,
    reg_number      VARCHAR(20) NOT NULL UNIQUE,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    email           VARCHAR(100) UNIQUE,
    phone_number    VARCHAR(15),
    course          VARCHAR(100),
    date_joined     DATE NOT NULL DEFAULT (CURRENT_DATE)
);

-- ---------------------------------------------------------
-- AUTHOR: book authors (many-to-many with BOOK in theory,
-- simplified here to one primary author per book for clarity)
-- ---------------------------------------------------------
CREATE TABLE AUTHOR (
    author_id       INT PRIMARY KEY AUTO_INCREMENT,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    nationality     VARCHAR(50)
);

-- ---------------------------------------------------------
-- CATEGORY: book genre/subject classification
-- ---------------------------------------------------------
CREATE TABLE CATEGORY (
    category_id     INT PRIMARY KEY AUTO_INCREMENT,
    category_name   VARCHAR(50) NOT NULL UNIQUE
);

-- ---------------------------------------------------------
-- BOOK: library inventory
-- ---------------------------------------------------------
CREATE TABLE BOOK (
    book_id         INT PRIMARY KEY AUTO_INCREMENT,
    isbn            VARCHAR(20) NOT NULL UNIQUE,
    title           VARCHAR(200) NOT NULL,
    author_id       INT,
    category_id     INT,
    total_copies    INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,
    shelf_location  VARCHAR(20),
    CONSTRAINT fk_book_author FOREIGN KEY (author_id)
        REFERENCES AUTHOR(author_id),
    CONSTRAINT fk_book_category FOREIGN KEY (category_id)
        REFERENCES CATEGORY(category_id),
    CONSTRAINT chk_copies CHECK (available_copies <= total_copies)
);

-- ---------------------------------------------------------
-- BORROW: associative/junction entity resolving the
-- many-to-many relationship between STUDENT and BOOK
-- ---------------------------------------------------------
CREATE TABLE BORROW (
    borrow_id       INT PRIMARY KEY AUTO_INCREMENT,
    student_id      INT NOT NULL,
    book_id         INT NOT NULL,
    borrow_date     DATE NOT NULL DEFAULT (CURRENT_DATE),
    due_date        DATE NOT NULL,
    return_date     DATE,
    fine_amount     DECIMAL(8,2) DEFAULT 0.00,
    CONSTRAINT fk_borrow_student FOREIGN KEY (student_id)
        REFERENCES STUDENT(student_id),
    CONSTRAINT fk_borrow_book FOREIGN KEY (book_id)
        REFERENCES BOOK(book_id),
    CONSTRAINT chk_dates CHECK (due_date >= borrow_date)
);

-- Indexes to speed up common lookups
CREATE INDEX idx_borrow_student ON BORROW(student_id);
CREATE INDEX idx_borrow_book ON BORROW(book_id);
CREATE INDEX idx_book_title ON BOOK(title)
