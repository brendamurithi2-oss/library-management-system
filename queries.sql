-- =========================================================
-- Analytical Queries - Library Management System
-- These demonstrate joins, aggregation, subqueries, and
-- business-relevant reporting.
-- =========================================================

-- 1. All currently borrowed (not yet returned) books, with borrower details
SELECT
    s.first_name, s.last_name, b.title, br.borrow_date, br.due_date
FROM BORROW br
JOIN STUDENT s ON br.student_id = s.student_id
JOIN BOOK b ON br.book_id = b.book_id
WHERE br.return_date IS NULL;

-- 2. Overdue books as of today (not returned, past due date)
SELECT
    s.first_name, s.last_name, s.email, b.title, br.due_date,
    DATEDIFF(CURRENT_DATE, br.due_date) AS days_overdue
FROM BORROW br
JOIN STUDENT s ON br.student_id = s.student_id
JOIN BOOK b ON br.book_id = b.book_id
WHERE br.return_date IS NULL
  AND br.due_date < CURRENT_DATE;

-- 3. Most borrowed books (popularity ranking)
SELECT
    b.title, COUNT(br.borrow_id) AS times_borrowed
FROM BOOK b
JOIN BORROW br ON b.book_id = br.book_id
GROUP BY b.title
ORDER BY times_borrowed DESC;

-- 4. Total fines collected per student
SELECT
    s.first_name, s.last_name, SUM(br.fine_amount) AS total_fines
FROM STUDENT s
JOIN BORROW br ON s.student_id = br.student_id
GROUP BY s.first_name, s.last_name
HAVING SUM(br.fine_amount) > 0
ORDER BY total_fines DESC;

-- 5. Books currently available for borrowing
SELECT title, available_copies
FROM BOOK
WHERE available_copies > 0;

-- 6. Students who have never borrowed a book (LEFT JOIN + NULL check)
SELECT s.first_name, s.last_name
FROM STUDENT s
LEFT JOIN BORROW br ON s.student_id = br.student_id
WHERE br.borrow_id IS NULL;

-- 7. Most active category by borrow count (subquery + join)
SELECT
    c.category_name, COUNT(br.borrow_id) AS total_borrows
FROM CATEGORY c
JOIN BOOK b ON c.category_id = b.category_id
JOIN BORROW br ON b.book_id = br.book_id
GROUP BY c.category_name
ORDER BY total_borrows DESC
LIMIT 1;

-- 8. Average number of days books are kept before return
SELECT
    ROUND(AVG(DATEDIFF(return_date, borrow_date)), 1) AS avg_days_kept
FROM BORROW
WHERE return_date IS NOT NULL;
