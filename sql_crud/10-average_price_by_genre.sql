-- List average price by genre
SELECT genre, AVG(price) FROM books GROUP BY genre;
