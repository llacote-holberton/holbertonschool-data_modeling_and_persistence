-- Deleting books too old and not pricey enough
DELETE FROM books
WHERE published_year < 1950 AND price < 9;

