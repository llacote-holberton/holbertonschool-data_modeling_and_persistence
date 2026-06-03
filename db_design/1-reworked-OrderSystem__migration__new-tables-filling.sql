-- Filling in reworked tables enforcing structure defined in 1-reworked-OrderSystem__docs__entity-relationships-structure.mmd
--   Using data retrieved from the old table order_lines_flat
-- IMPORTANT: script written specifically for SQLite3 (notably specific data types)

-- Keeping the same specificity as original table structure
PRAGMA foreign_keys = OFF;

-- ----------------------------------------------------------------------------
-- Task -1 (Don't Judge xd): Creating a table for "log messages templates".
-- ----------------------------------------------------------------------------
-- Confer "Notes and Design choices" section for infos on the "TEMP" keyword
CREATE TEMP TABLE IF NOT EXISTS log_templates
(
    code TEXT PRIMARY KEY,
    template TEXT NOT NULL
);
INSERT INTO log_templates VALUES
('SOURCE_FALLBACK'     , 'Trying "create if not exists" for source table %s as safety'  ),
('CLEAN_EXISTING_DATA' , '%s: deleting all existing values to recreate from scratch' ),
('CLEAN_WARNING'       , 'Warning! %d %s will be deleted'                            ),
('CLEAN_CONFIRMATION'  , '--> %d %s remaining'                                       ),
('IMPORT_STARTING'     , 'Starting (re)import of %s data'                            ),
('IMPORT_CONFIRMATION' , 'Success: %d %s inserted'                                   ),
('TEST'                , 'SQL is %s'                                                 )
; -- NEVER FORGET the comma signaling instruction end on multi-line ones ^^

-- HOW TO USE (simple example), note the temp. prefix specific syntax for SQLite3
SELECT replace(template, '%s', 'Good!') AS [LOG] FROM temp.log_templates WHERE code = 'TEST';

-- ----------------------------------------------------------------------------
-- Task 0: Ensuring "source table exists" to prevent script crash later.
-- ----------------------------------------------------------------------------
SELECT replace(template, '%s', 'order_lines_flat') AS [LOG] FROM temp.log_templates WHERE code = 'SOURCE_FALLBACK';
SELECT '    in order to avoid script crashing on the select which follow           ---' AS [LOG];

-- Keeping "if not exists" to easily change the script mode by just removing above line.
CREATE TABLE IF NOT EXISTS order_lines_flat
(
    order_id INTEGER,
    order_date TEXT,
    customer_name TEXT,
    customer_email TEXT,
    product_code TEXT,
    product_name TEXT,
    category_name TEXT,
    unit_price_paid REAL,
    quantity INTEGER
);

SELECT '--- However we make the assumption all new tables exist as this script is     ' AS [LOG];
SELECT '    normally executed ONLY "sequentially after the table creations one"      ---' AS [LOG];
SELECT 'IMPORTANT: please note that this script DELETES all existing data before reimporting' AS [LOG];

-- ----------------------------------------------------------------------------
-- Task 1: Reading the source table's data to fill in customers
-- ----------------------------------------------------------------------------
-- INFO/Warning about existing content deletion
SELECT replace(template, '%s', 'customers') AS [LOG] FROM temp.log_templates WHERE code = 'CLEAN_EXISTING_DATA';
SELECT replace
(
    -- Using a nested replace call to provide template with first replacement made
    replace(template, '%s', 'customers'),
    '%d',
    (SELECT COUNT(*) FROM customers)
)
AS [LOG] FROM temp.log_templates WHERE code = 'CLEAN_WARNING';


-- Deleting
DELETE FROM customers;
DELETE FROM sqlite_sequence WHERE name = 'customers';

SELECT replace
(
    replace(template, '%s', 'customers'),
    '%d',
    (SELECT COUNT(*) FROM customers)
)
AS [LOG] FROM temp.log_templates WHERE code = 'CLEAN_CONFIRMATION';


-- Importing from source
SELECT replace(template, '%s', 'customers') AS [LOG]
  FROM temp.log_templates WHERE code = 'IMPORT_STARTING';

INSERT INTO customers (name, email)
  SELECT DISTINCT customer_name, customer_email FROM order_lines_flat;


-- Confirming
SELECT replace
(
    replace(template, '%s', 'customers'),
    '%d',
    (SELECT COUNT(*) FROM customers)
)
AS [LOG] FROM temp.log_templates WHERE code = 'IMPORT_CONFIRMATION';

-- ----------------------------------------------------------------------------
-- Task 2: Reading the source table's data to fill in categories
-- ----------------------------------------------------------------------------
SELECT replace(template, '%s', 'categories') AS [LOG] FROM temp.log_templates WHERE code = 'CLEAN_EXISTING_DATA';
SELECT replace
(
    -- Using a nested replace call to provide template with first replacement made
    replace(template, '%s', 'categories'),
    '%d',
    (SELECT COUNT(*) FROM categories)
)
AS [LOG] FROM temp.log_templates WHERE code = 'CLEAN_WARNING';


-- Deleting
DELETE FROM categories;
DELETE FROM sqlite_sequence WHERE name = 'categories';

SELECT replace
(
    replace(template, '%s', 'categories'),
    '%d',
    (SELECT COUNT(*) FROM categories)
)
AS [LOG] FROM temp.log_templates WHERE code = 'CLEAN_CONFIRMATION';


-- Importing from source
SELECT replace(template, '%s', 'categories') AS [LOG]
  FROM temp.log_templates WHERE code = 'IMPORT_STARTING';

INSERT INTO categories (name)
  SELECT DISTINCT category_name FROM order_lines_flat;


-- Confirming
SELECT replace
(
    replace(template, '%s', 'categories'),
    '%d',
    (SELECT COUNT(*) FROM categories)
)
AS [LOG] FROM temp.log_templates WHERE code = 'IMPORT_CONFIRMATION';


-- ----------------------------------------------------------------------------
-- Task 3: Reading the source table's data to fill in products
-- ----------------------------------------------------------------------------
SELECT replace(template, '%s', 'products') AS [LOG] FROM temp.log_templates WHERE code = 'CLEAN_EXISTING_DATA';
SELECT replace
(
    -- Using a nested replace call to provide template with first replacement made
    replace(template, '%s', 'products'),
    '%d',
    (SELECT COUNT(*) FROM products)
)
AS [LOG] FROM temp.log_templates WHERE code = 'CLEAN_WARNING';


-- Deleting
DELETE FROM products;
DELETE FROM sqlite_sequence WHERE name = 'products';

SELECT replace
(
    replace(template, '%s', 'products'),
    '%d',
    (SELECT COUNT(*) FROM products)
)
AS [LOG] FROM temp.log_templates WHERE code = 'CLEAN_CONFIRMATION';

-- Importing from source
SELECT replace(template, '%s', 'products') AS [LOG]
  FROM temp.log_templates WHERE code = 'IMPORT_STARTING';

INSERT INTO products (name, code, unit_price, category_id)
  SELECT DISTINCT
    product_name, product_code, unit_price_paid,
    categories.id
    FROM order_lines_flat as olf
    JOIN categories ON olf.category_name = categories.name
;


-- Confirming
SELECT replace
(
    replace(template, '%s', 'products'),
    '%d',
    (SELECT COUNT(*) FROM products)
)
AS [LOG] FROM temp.log_templates WHERE code = 'IMPORT_CONFIRMATION';



-- ----------------------------------------------------------------------------
-- Task 4: Reading the source table's data to fill in orders
-- ----------------------------------------------------------------------------
SELECT replace(template, '%s', 'orders') AS [LOG] FROM temp.log_templates WHERE code = 'CLEAN_EXISTING_DATA';
SELECT replace
(
    -- Using a nested replace call to provide template with first replacement made
    replace(template, '%s', 'orders'),
    '%d',
    (SELECT COUNT(*) FROM orders)
)
AS [LOG] FROM temp.log_templates WHERE code = 'CLEAN_WARNING';


-- Deleting
DELETE FROM orders;
DELETE FROM sqlite_sequence WHERE name = 'orders';

SELECT replace
(
    replace(template, '%s', 'orders'),
    '%d',
    (SELECT COUNT(*) FROM orders)
)
AS [LOG] FROM temp.log_templates WHERE code = 'CLEAN_CONFIRMATION';


-- Importing from source
SELECT replace(template, '%s', 'orders') AS [LOG]
  FROM temp.log_templates WHERE code = 'IMPORT_STARTING';
-- NOTE: forgot to add the "total_price" in table definition but couldn't be filled in now anyways.
INSERT INTO orders (placed_at, customer_id)
  SELECT olf.order_date, c.id
    FROM order_lines_flat as olf
    JOIN customers as c
      ON olf.customer_name = c.name AND olf.customer_email = c.email
    GROUP BY olf.order_id
    ORDER BY olf.order_id;
;


-- Confirming
SELECT replace
(
    replace(template, '%s', 'orders'),
    '%d',
    (SELECT COUNT(*) FROM orders)
)
AS [LOG] FROM temp.log_templates WHERE code = 'IMPORT_CONFIRMATION';



-- ----------------------------------------------------------------------------
-- Task 5: Reading the source table's data to fill in order_lines
-- ----------------------------------------------------------------------------
SELECT replace(template, '%s', 'order_lines') AS [LOG] FROM temp.log_templates WHERE code = 'CLEAN_EXISTING_DATA';
SELECT replace
(
    -- Using a nested replace call to provide template with first replacement made
    replace(template, '%s', 'order_lines'),
    '%d',
    (SELECT COUNT(*) FROM order_lines)
)
AS [LOG] FROM temp.log_templates WHERE code = 'CLEAN_WARNING';

-- Deleting
DELETE FROM order_lines;
DELETE FROM sqlite_sequence WHERE name = 'order_lines';

SELECT replace
(
    replace(template, '%s', 'order_lines'),
    '%d',
    (SELECT COUNT(*) FROM order_lines)
)
AS [LOG] FROM temp.log_templates WHERE code = 'CLEAN_CONFIRMATION';

-- Importing from source
SELECT replace(template, '%s', 'order_lines') AS [LOG]
  FROM temp.log_templates WHERE code = 'IMPORT_STARTING';

-- Confirming
SELECT replace
(
    replace(template, '%s', 'order_lines'),
    '%d',
    (SELECT COUNT(*) FROM order_lines)
)
AS [LOG] FROM temp.log_templates WHERE code = 'IMPORT_CONFIRMATION';











