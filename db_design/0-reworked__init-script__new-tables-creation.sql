-- Creating tables structures following the schema of 0-reworked_entity-relationships-structures.mmd
-- IMPORTANT: script written specifically for SQLite3 (notably specific data types)

-- Keeping the same specificity as original table structure
PRAGMA foreign_keys = OFF;

-- Displaying information messages with "univeral method" (SQLite 3 also has .print 'Message to display')
SELECT '--- Initialisation du script ---' AS [LOG];

-- ----------------------------------------
-- Task 0: (re)creating students table
-- ----------------------------------------
SELECT '--- Forcefully (re)creating the Students table ---' AS [LOG];

DROP TABLE IF EXISTS students;
-- Keeping "if not exists" to easily change the script mode by just removing above line.
CREATE TABLE IF NOT EXISTS students
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL
);

-- ---------------------------------------
-- Task 1: (re)creating instructors table
-- ---------------------------------------
SELECT '--- Forcefully (re)creating the Instructors table ---' AS [LOG];

DROP TABLE IF EXISTS instructors;
CREATE TABLE IF NOT EXISTS instructors -- Same remark as above
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL
);

-- --------------------------------------
-- Task 2: (re)creating courses table
-- NOTE: MUST be created after the two others conceptually because of the use of foreign keys.
--   Although here we disabled foreign_keys enforcment so technically we could use whatever order.
-- --------------------------------------
SELECT '--- Forcefully (re)creating the Courses table ---' AS [LOG];

DROP TABLE IF EXISTS courses;
CREATE TABLE IF NOT EXISTS courses
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    bid TEXT NOT NULL, -- "bid for Business Id aka something provided by humans"

    -- Compact version variant of the below "detailed/explicit" syntax
    -- NOTE THAT explicit "FOREIGN KEYS" declaration MUST ALL BE MADE AFTER column definitions.
    -- Hence that order if you want to mix "compact syntax" and "detailed syntax"
    instructor_id INTEGER REFERENCES instructors(id),
    -- Using the FOREIGN KEY syntax for good practice even though 
    --   constraints validation have been disabled from the PRAGMA instruction at the top.
    student_id INTEGER,  -- No "not null" because a course can have no students yet, or left.
    FOREIGN KEY (student_id) REFERENCES students(id)
);

/*
 * IMPORTANT NOTES on the concept of "Foreign keys" (primary keys for another table, "referenced" in current table)
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
 */
