
-- יצירת טבלאות

CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    name VARCHAR(100),
    birth_year INT
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(150),
    author_id INT,
    genre VARCHAR(50),
    year_published INT,
    available_copies INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

CREATE TABLE Readers (
    reader_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    book_id INT,
    reader_id INT,
    loan_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (reader_id) REFERENCES Readers(reader_id)
);

-- הוספת נתונים

INSERT INTO Authors VALUES
(1, 'J.K. Rowling', 1965),
(2, 'George Orwell', 1903),
(3, 'Isaac Asimov', 1920);

INSERT INTO Books VALUES
(1, 'Harry Potter and the Sorcerer''s Stone', 1, 'Fantasy', 1997, 4),
(2, '1984', 2, 'Dystopian', 1949, 2),
(3, 'Foundation', 3, 'Science Fiction', 1951, 5);

INSERT INTO Readers VALUES
(1, 'Daniel Agas', 'daniel@example.com'),
(2, 'Lior Levi', 'lior@example.com');

INSERT INTO Loans VALUES
(1, 1, 1, '2025-03-01', '2025-03-10'),
(2, 2, 2, '2025-03-05', NULL);

-- שאילתות לדוגמה

-- הצגת כל הספרים עם שם הסופר
SELECT B.title, A.name AS author, B.genre, B.year_published
FROM Books B
JOIN Authors A ON B.author_id = A.author_id;

-- ספרים שהושאלו ועדיין לא הוחזרו
SELECT B.title, R.name AS reader, L.loan_date
FROM Loans L
JOIN Books B ON L.book_id = B.book_id
JOIN Readers R ON L.reader_id = R.reader_id
WHERE L.return_date IS NULL;

-- כמה עותקים זמינים מכל ספר
SELECT title, available_copies FROM Books;

-- קוראים שהשאלו ספרים מסוג 'Fantasy'
SELECT DISTINCT R.name
FROM Readers R
JOIN Loans L ON R.reader_id = L.reader_id
JOIN Books B ON L.book_id = B.book_id
WHERE B.genre = 'Fantasy';
