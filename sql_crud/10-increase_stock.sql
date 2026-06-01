-- Registering limited resupply for books in low stock
UPDATE books
SET stock = stock + 3
WHERE stock < 5;
