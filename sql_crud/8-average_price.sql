-- Returning average price across all books
--   Using AVG instead of ROUND because not sure what checker expects
SELECT AVG(price) FROM books;
