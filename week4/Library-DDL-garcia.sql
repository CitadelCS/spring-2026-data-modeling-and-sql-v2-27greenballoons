CREATE SCHEMA IF NOT EXISTS library;

-- Publisher Table
CREATE TABLE library.publisher (
    Name    VARCHAR(100) PRIMARY KEY,
    Address VARCHAR(255) NOT NULL,
    Phone   VARCHAR(30)  NOT NULL
);

-- Library Branch Table
CREATE TABLE library.library_branch (
    Branch_id    SERIAL PRIMARY KEY,
    Branch_name  VARCHAR(100) NOT NULL,
    Address      VARCHAR(255) NOT NULL
);

-- Book Table
CREATE TABLE library.book (
    Book_id         SERIAL PRIMARY KEY,
    Title           VARCHAR(300) NOT NULL,
    Publisher_name  VARCHAR(100) NOT NULL,

    FOREIGN KEY (Publisher_name) REFERENCES library.publisher(Name)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Borrower Table
CREATE TABLE library.borrower (
    Card_no  INT PRIMARY KEY,
    Name     VARCHAR(100) NOT NULL,
    Address  VARCHAR(255) NOT NULL,
    Phone    VARCHAR(30)
);

-- Book Authors (many-to-many)
CREATE TABLE library.book_authors (
    Book_id     INT NOT NULL,
    Author_name VARCHAR(100) NOT NULL,

    PRIMARY KEY (Book_id, Author_name),

    FOREIGN KEY (Book_id) REFERENCES library.book(Book_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Book Copies Table
CREATE TABLE library.book_copies (
    Book_id      INT NOT NULL,
    Branch_id    INT NOT NULL,
    No_of_copies INT NOT NULL DEFAULT 0 CHECK (No_of_copies >= 0),

    PRIMARY KEY (Book_id, Branch_id),

    FOREIGN KEY (Book_id)   REFERENCES library.book(Book_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (Branch_id) REFERENCES library.library_branch(Branch_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Book Loans Table
CREATE TABLE library.book_loans (
    Book_id     INT NOT NULL,
    Branch_id   INT NOT NULL,
    Card_no     INT NOT NULL,
    Date_out    DATE NOT NULL,
    Due_date    DATE NOT NULL,

    PRIMARY KEY (Book_id, Branch_id, Card_no, Date_out),

    FOREIGN KEY (Book_id, Branch_id) REFERENCES library.book_copies(Book_id, Branch_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (Card_no) REFERENCES library.borrower(Card_no)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT duedate_after_checkdate CHECK (Due_date >= Date_out)
);