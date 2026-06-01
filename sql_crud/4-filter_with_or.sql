-- Retrieving only title and price for all books
SELECT title, genre FROM books WHERE genre = 'Fantasy' OR price < 10
