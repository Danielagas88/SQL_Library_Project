
-- ✅ מציאת שמות קוראים עם כתובת מייל שמסתיימת ב-@example.com
SELECT name
FROM Readers
WHERE email LIKE '%@example.com';

-- ✅ הוספת סופר חדש בשם Robert Martin שנולד ב-1952
INSERT INTO Authors VALUES (4, 'Robert Martin', 1952);

-- ✅ הוספת ספר חדש בשם 'Clean Code' של Robert Martin משנת 2008 עם 3 עותקים זמינים
INSERT INTO Books VALUES (4, 'Clean Code', 4, 'Programming', 2008, 3);

-- ✅ הצגת כמות הספרים שכל קורא השאיל
SELECT R.name, COUNT(*) AS total_loans
FROM Loans L
JOIN Readers R ON L.reader_id = R.reader_id
GROUP BY R.name;

-- ✅ הצגת רק קוראים שהשאילו יותר מספר אחד
SELECT R.name, COUNT(*) AS total_loans
FROM Loans L
JOIN Readers R ON L.reader_id = R.reader_id
GROUP BY R.name
HAVING COUNT(*) > 1;

-- ✅ הצגת שמות ספרים וסופרים מסוג 'Fantasy'
SELECT B.title, A.name AS author
FROM Books B
JOIN Authors A ON B.author_id = A.author_id
WHERE B.genre = 'Fantasy';

-- ✅ הצגת שמות ספרים זמינים להשאלה (כלומר שיש להם עותקים זמינים)
SELECT title, available_copies
FROM Books
WHERE available_copies > 0;

-- ✅ הצגת כל הספרים שהושאלו אך טרם הוחזרו
SELECT B.title, R.name AS reader, L.loan_date
FROM Loans L
JOIN Books B ON L.book_id = B.book_id
JOIN Readers R ON L.reader_id = R.reader_id
WHERE L.return_date IS NULL;
