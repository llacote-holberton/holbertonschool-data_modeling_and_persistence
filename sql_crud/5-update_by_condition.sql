-- Reflecting delivery of 5 new items for books published before 2000
UPDATE books
SET stock = stock + 5
WHERE published_year < 2000

