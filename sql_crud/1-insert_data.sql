-- Inserting values into Books table
INSERT INTO books 
(title, 'author', "genre", price, stock, published_year)
VALUES 
-- BEWARE! ' ' MUST be used ONLY to describe "textual values"
-- WHILE   " " MUST be used ONLY to describe "SQL objects's names"  (table, column etc)
('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 10.99, 5, 1937),
('1984', 'George Orwell', 'Dystopian', 8.99, 12, 1949),
('Clean Code', 'Robert C. Martin', 'Tech', 32.50, 7, 2008),
('The Pragmatic Programmer', 'Andrew Hunt', 'Tech', 28.75, 4, 1999),
('Dune', 'Frank Herbert', 'Sci-Fi', 9.50, 9, 1965)
;
