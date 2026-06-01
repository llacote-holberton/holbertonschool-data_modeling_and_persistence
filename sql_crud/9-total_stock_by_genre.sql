-- 9.3 Returns total book stocks per genre.
SELECT genre, SUM(stock) as total_stock_per_genre FROM books GROUP BY genre;
