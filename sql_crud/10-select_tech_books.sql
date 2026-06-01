-- Retrieve title/price/stock of technical books published in or after year 2000
SELECT title, price, stock FROM books WHERE genre = 'Tech' AND published_year >= 2000;
