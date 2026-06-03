-- Creating tables structures to apply 1-reworked-OrderSystem__docs__entity-relationships-structure.mmd
-- IMPORTANT: script written specifically for SQLite3 (notably specific data types)

-- Keeping the same specificity as original table structure
PRAGMA foreign_keys = OFF;

-- Displaying information messages with "universal method"
SELECT '===== OrderSystem Rework: (re)Creating new structure =====' AS [LOG];
SELECT '  Entities: Customer, Product, Category, Order, Order_line' AS [LOG];

-- ----------------------------------------
-- Task 0: (re)creating students table
-- ----------------------------------------
SELECT '--- Forcefully (re)creating the customers table ---' AS [LOG];

DROP TABLE IF EXISTS customers;
-- Keeping "if not exists" to easily change the script mode by just removing above line.
CREATE TABLE IF NOT EXISTS customers
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL
);

-- ---------------------------------------
-- Task 1: (re)creating categories table
-- ---------------------------------------
SELECT '--- Forcefully (re)creating the categories table ---' AS [LOG];

DROP TABLE IF EXISTS categories;
CREATE TABLE IF NOT EXISTS categories
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
    -- WARNING: ALWAYS CHECK YOUR LAST CLAUSE HAS NO TRAILING COMMA (',')!
);

-- --------------------------------------
-- Task 2: (re)creating products table
-- NOTE: MUST be created after categories conceptually because of the use of foreign keys.
--   Although here we disabled foreign_keys enforcment so technically we could use whatever order.
-- --------------------------------------
SELECT '--- Forcefully (re)creating the products table ---' AS [LOG];

DROP TABLE IF EXISTS products;
CREATE TABLE IF NOT EXISTS products
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    code TEXT NOT NULL, -- "code = Business Id aka something provided by humans"
    unit_price REAL NOT NULL, -- reminder: REAL SQLite exclusive, = FLOAT in standard
    category_id INTEGER REFERENCES categories(id)
);

-- --------------------------------------
-- Task 3: (re)creating orders table
-- NOTE: MUST be created after the others conceptually because of the use of foreign keys.
-- --------------------------------------
SELECT '--- Forcefully (re)creating the orders table ---' AS [LOG];

DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    -- IMPORTANT! "date" is a reserved keyword.
    placed_at DATETIME NOT NULL, -- Confer comments in "Notes & Design choice" for explanations on "DATETIME"
    -- Using the FOREIGN KEY syntax for good practice and training although a bit more verbose.
    customer_id INTEGER NOT NULL,
    -- Reminder: all "explicit foreign keys constraints" must be placed after all columns definitions.
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);


-- --------------------------------------
-- Task 4: (re)creating order_lines table
-- NOTE: MUST be created after the others conceptually because of the use of foreign keys.
--   This table is required to efficiently store the representations of "many to many" relationships between two entity types.
-- --------------------------------------
SELECT '--- Forcefully (re)creating the order_lines table ---' AS [LOG];

DROP TABLE IF EXISTS order_lines;
CREATE TABLE IF NOT EXISTS order_lines
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    -- Using "short-hand syntax" for foreign keys declarations because...
    -- a) 3 "dependencies" and b) allows defining columns in an order which feels >intuitive.
    -- ESSENTIAL: Constraints on Value MUST be declared BEFORE relationships (so NOT NULL first)
    order_id INT NOT NULL REFERENCES orders(id),
    product_id INT NOT NULL REFERENCES products(id),
    unit_price_paid REAL NOT NULL, -- Reminder: REAL (SQLite) = FLOAT (SQL standard)
    quantity INT NOT NULL
);


/*
 * ==== NOTES AND DESIGN CHOICES =====
 * === ON "FOREIGN KEYS" concept (primary keys for another table, "referenced" in current table) ===
 *
 * 1/ It is technically possible to create a table B which uses table A's primary key "as a foreign key" in whatever order
 * UNLESS you use the specific syntax: FOREIGN KEY (targettable_id) REFERENCES target_table(id)
 *   in which case SQL enforces the constraints IMMEDIATELY.
 * OTHERWISE constraint validation will be enabled as soon as PRAGMA foreign_keys = ON; is set
 *   then will be checked whenever queries targeting that column to modify data are attempted.
 *
 * 2/ Explicit "FOREIGN KEY" clauses MUST always ALL be AFTER ALL columns declarations
 *   as SQLite (and many other engines) will consider that the first "FOREIGN KEY" encountered means
 *   all column definitions are finished.
 *
 * 3/ When using "short-hand" syntax the "REFERENCES another_table(primarykey_column_name)" MUST COME AFTER
 *    the column name then its datatype then its value contraint(s) (typical example being "not null").
 *
 * === ON DATETIME (and more generally date management in SQLite specifically) ===
 *
 * 1/ "date" is a reserved keyword (actually a built-in function to get a "human-readable date" from compatible value)
 *
 * 2/ ESSENTIAL! "DATETIME" is not an actual datatype but rather a wrapper for TEXT.
 *    SQLite "understands" it means "TEXT string which respects a format making it understandable as date"
 *
 * 3/ In fact, SQLite has no native "Date" datatype. It only supports either string (TEXT) provided values stored
 *      strictly respects one of the ISO-8601 formats, or an INTEGER representing the Epoch timestamp in seconds.
 *    For more info confer official doc https://sqlite.org/lang_datefunc.html
 */
