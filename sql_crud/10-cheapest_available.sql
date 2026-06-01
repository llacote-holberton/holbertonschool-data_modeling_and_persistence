-- Finding the 4 cheapest books with available stock
SELECT title, price FROM books
WHERE stock > 0
ORDER BY price ASC
LIMIT 4;
