-- Deleting books with no stock left to clean state.
DELETE FROM books
WHERE stock = 0;
