-- =========================================================
-- Sample Data — Library Management System
-- =========================================================

INSERT INTO STUDENT (reg_number, first_name, last_name, email, phone_number, course, date_joined) VALUES
('BSC/001/22', 'Amina', 'Mwangi', 'amina.mwangi@student.ac.ke', '0712345001', 'Data Science and Analytics', '2024-09-01'),
('BSC/002/22', 'Brian', 'Otieno', 'brian.otieno@student.ac.ke', '0712345002', 'Information Technology', '2024-09-01'),
('BSC/003/22', 'Faith', 'Wambui', 'faith.wambui@student.ac.ke', '0712345003', 'Business Administration', '2024-09-15'),
('BSC/004/22', 'Kevin', 'Kiprotich', 'kevin.kiprotich@student.ac.ke', '0712345004', 'Data Science and Analytics', '2025-01-10'),
('BSC/005/22', 'Lynn', 'Achieng', 'lynn.achieng@student.ac.ke', '0712345005', 'Health Records and IT', '2025-01-10');

INSERT INTO AUTHOR (first_name, last_name, nationality) VALUES
('Chinua', 'Achebe', 'Nigerian'),
('Ngugi', 'wa Thiong''o', 'Kenyan'),
('Yuval Noah', 'Harari', 'Israeli'),
('Wes', 'McKinney', 'American'),
('Cathy', 'O''Neil', 'American');

INSERT INTO CATEGORY (category_name) VALUES
('African Literature'),
('History'),
('Data Science'),
('Computer Science'),
('Business');

INSERT INTO BOOK (isbn, title, author_id, category_id, total_copies, available_copies, shelf_location) VALUES
('978-0385474542', 'Things Fall Apart', 1, 1, 4, 3, 'A1-01'),
('978-9966466169', 'Weep Not, Child', 2, 1, 3, 3, 'A1-02'),
('978-0062316097', 'Sapiens', 3, 2, 5, 4, 'B2-05'),
('978-1491957660', 'Python for Data Analysis', 4, 3, 6, 5, 'C3-10'),
('978-0553418835', 'Weapons of Math Destruction', 5, 3, 2, 1, 'C3-11');

INSERT INTO BORROW (student_id, book_id, borrow_date, due_date, return_date, fine_amount) VALUES
(1, 4, '2025-06-01', '2025-06-15', '2025-06-14', 0.00),
(2, 3, '2025-06-05', '2025-06-19', NULL, 0.00),
(3, 1, '2025-06-10', '2025-06-24', '2025-07-02', 80.00),
(4, 4, '2025-07-01', '2025-07-15', NULL, 0.00),
(5, 5, '2025-07-10', '2025-07-24', NULL, 0.00),
(1, 3, '2025-05-01', '2025-05-15', '2025-05-13', 0.00),
(2, 1, '2025-04-20', '2025-05-04', '2025-05-10', 60.00);
