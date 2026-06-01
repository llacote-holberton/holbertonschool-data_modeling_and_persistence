-- Returning the 3 cheapest books
-- Meaning books ordered by ascending prices, limit to 3 first
SELECT title, price FROM books
ORDER BY price ASC LIMIT 3;
