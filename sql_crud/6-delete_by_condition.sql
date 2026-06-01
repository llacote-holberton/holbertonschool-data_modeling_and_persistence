-- Deleting books with depleted stock
DELETE FROM books
WHERE stock = 0;

