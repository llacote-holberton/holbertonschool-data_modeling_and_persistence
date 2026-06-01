-- 9.1 Count books by genre
SELECT genre, COUNT(stock) as stock_by_genre FROM books GROUP BY genre;
