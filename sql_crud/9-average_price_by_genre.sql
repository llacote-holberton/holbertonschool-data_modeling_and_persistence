-- 9.2 Computes average price of books for each genrer
SELECT genre, AVG(price) as avg_price_for_genre FROM books GROUP BY genre;
