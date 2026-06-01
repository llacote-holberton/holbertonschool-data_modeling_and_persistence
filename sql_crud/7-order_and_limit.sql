-- Returning the 5 books with highest stock
-- Meaning books ordered by descending stock, limit to 5 first
SELECT title, stock FROM books
ORDER BY stock DESC LIMIT 5;
