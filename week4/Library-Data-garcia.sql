-- 1. Publishers
INSERT INTO library.publisher (Name, Address, Phone) VALUES
    ('Penguin Random House', '1745 Broadway, New York, NY 10019, USA', '+1-212-782-9000'),
    ('HarperCollins Publishers', '195 Broadway, New York, NY 10007, USA', '+1-212-207-7000'),
    ('Simon & Schuster', '1230 Avenue of the Americas, New York, NY 10020, USA', '+1-212-698-7000');


-- 2. Library Branches
INSERT INTO library.library_branch (Branch_name, Address) VALUES
    ('Downtown Main Branch', '75 Calhoun St, Charleston, SC 29401'),
    ('West Ashley Branch', '2055 Charlie Hall Blvd, Charleston, SC 29414'),
    ('James Island Branch', '1240 Camp Rd, Charleston, SC 29412');


-- 3. Books
INSERT INTO library.book (Title, Publisher_name) VALUES
    ('The Great Gatsby', 'Simon & Schuster'),
    ('To Kill a Mockingbird', 'HarperCollins Publishers'),
    ('1984', 'Penguin Random House');


-- 4. Borrowers
INSERT INTO library.borrower (Card_no, Name, Address, Phone) VALUES
    (1001, 'Emma Thompson', '142 Meeting St, Charleston, SC 29401', '843-555-0123'),
    (1002, 'Liam Patel', '317 King St, Charleston, SC 29401', '843-555-0456'),
    (1003, 'Sophia Rodriguez', '89 Broad St, Charleston, SC 29401', '843-555-0789');


-- 5. Book Authors
INSERT INTO library.book_authors (Book_id, Author_name) VALUES
    (1, 'F. Scott Fitzgerald'),
    (2, 'Harper Lee'),
    (3, 'George Orwell');


-- 6. Book Copies (includes the previously missing row)
INSERT INTO library.book_copies (Book_id, Branch_id, No_of_copies) VALUES
    (1, 1, 5),   -- Gatsby → Downtown
    (1, 2, 3),   -- Gatsby → West Ashley
    (2, 1, 4),   -- Mockingbird → Downtown
    (2, 2, 3),   -- Mockingbird → West Ashley     ← this was missing
    (2, 3, 2),   -- Mockingbird → James Island
    (3, 1, 6),   -- 1984 → Downtown
    (3, 2, 4);   -- 1984 → West Ashley


-- 7. Book Loans (now valid)
INSERT INTO library.book_loans (Book_id, Branch_id, Card_no, Date_out, Due_date) VALUES
    (1, 1, 1001, '2026-02-10', '2026-02-24'),   -- Gatsby from Downtown
    (2, 2, 1002, '2026-02-12', '2026-02-26'),   -- Mockingbird from West Ashley
    (3, 1, 1003, '2026-02-15', '2026-03-01');   -- 1984 from Downtown

-- verify data is there
SELECT count(*) FROM library.publisher;     -- should be 3
SELECT count(*) FROM library.book_loans;    -- should be 3
SELECT * FROM library.book_copies WHERE book_id = 2;   -- should show branch 2 now