-- Applying 10% permanent reduction on Tech books with too much stock
UPDATE books
SET price = price * 0.90
WHERE stock > 5 and genre = 'Tech'

