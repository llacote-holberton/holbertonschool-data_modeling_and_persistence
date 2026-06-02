-- Filling in reworked tables structures following the schema of 0-reworked_entity-relationships-structures.mmd
--   Using data retrieved from the old table student_courses
-- IMPORTANT: script written specifically for SQLite3 (notably specific data types)

-- Keeping the same specificity as original table structure
PRAGMA foreign_keys = OFF;

-- -------------------------
-- Task 0: creating the student_courses IF NOT EXIST
-- -------------------------
SELECT '--- Triggering a fallback "create if not exists" for student_courses table    ' AS [LOG];
SELECT '    in order to avoid script crashing on the select which follow           ---' AS [LOG];

-- Keeping "if not exists" to easily change the script mode by just removing above line.
CREATE TABLE IF NOT EXISTS student_tables
(
    student_id INTEGER,
    student_name TEXT,
    student_email TEXT,
    course_id TEXT,
    course_name TEXT,
    instructor_name TEXT,
    instructor_email TEXT
);

SELECT '--- However we make the assumption all new tables exist as this script is     ' AS [LOG];
SELECT '    normally executed ONLY "sequentially after the table creations on      ---' AS [LOG];
-- ------------------------------------------------------------
-- Task 1: Reading the source table's data to fill in students
-- ------------------------------------------------------------
/* Example "direct select"*/
SELECT '--- Students: deleting all existing values to recreate from scratch     ' AS [LOG];

-- Arbitrary choice to remove all existing rows to avoid both duplicates and crash from id unique constraint violation.
-- Attempt to use "concatenation" approach to print dynamic data
SELECT 'Warning:' || COUNT(*) || ' students will be deleted.' AS [LOG]
  FROM students;

DELETE FROM students;
-- REQUIRED IF/WHEN we also want to reset the auto-increment counter for the primary key id (SQLite specific instruction)
DELETE FROM sqlite_sequence WHERE name = 'students';

SELECT '--> ' || COUNT(*) || ' students deleted.' AS [LOG]
  FROM students;


-- Making the (re)insertion
INSERT INTO students (id, name, email)
  -- DISTINCT NECESSARY because original table has several courses for some students so id will be repeated
  SELECT DISTINCT student_id, student_name, student_email
  FROM student_courses
  ORDER BY student_id ASC
;

-- Attempt to use "printing as table"
SELECT 
    'Inserted Students' AS [STEP], 
    COUNT(*) AS [INSERTED ROWS COUNT] 
FROM students;


-- ------------------------------------------------------------
-- Task 2: Filling the new tables instructors
-- ------------------------------------------------------------
SELECT '--- Instructors: deleting all existing values to recreate from scratch     ' AS [LOG];

SELECT 'Warning: removing ' || COUNT(*) || ' instructors' AS [LOG] FROM instructors;
DELETE FROM instructors;
-- For this exercise we always recreate all from scratch so ok to reset.
DELETE FROM sqlite_sequence WHERE name = 'instructors';

SELECT 'Starting (re)insertion of instructors' AS [LOG];

-- Using WITH to make things clearer
WITH instructors_data AS 
(
    SELECT DISTINCT
      instructor_name AS name,
      instructor_email AS email
    FROM student_courses
)
-- Listing explicitely the filled columns is REQUIRED to let SQL complete for the autoincrement id column
INSERT INTO instructors (name, email)
SELECT i.name, i.email
FROM instructors_data as i
;
SELECT 'Success: ' || COUNT(*) || ' instructors inserted' AS [LOG] FROM instructors;



-- ------------------------------------------------------------
-- Task 3: Filling the new tables courses
-- ------------------------------------------------------------
SELECT '--- Courses: deleting all existing values to recreate from scratch     ' AS [LOG];

SELECT 'Warning: removing ' || COUNT(*) || ' courses' AS [LOG] FROM courses;
DELETE FROM courses;
DELETE FROM sqlite_sequence WHERE name = 'courses';
SELECT 'Warning: courses id counter reset' AS [LOG];


SELECT 'Starting (re)insertion of courses' AS [LOG];
-- Using WITH to make things clearer
WITH courses_data AS 
(
    SELECT DISTINCT
      -- Course data
      sc.course_id AS course_id,
      sc.course_name AS course_name,
      -- Instructor data
      i.id AS instructor_id
    FROM
      student_courses AS sc
      JOIN instructors AS i 
        ON sc.instructor_name = i.name
    ORDER BY course_id
)
INSERT INTO courses (bid, name, instructor_id)
SELECT * FROM courses_data
;

SELECT 
    'Inserted Courses' AS [STEP], 
    COUNT(*) AS [INSERTED ROWS COUNT] 
FROM courses;


-- ------------------------------------------------------------
-- Task 4: Filling the new tables enrollments
-- ------------------------------------------------------------
SELECT '--- Courses: deleting all existing values to recreate from scratch     ' AS [LOG];

SELECT 'Warning: removing ' || COUNT(*) || ' enrollments' AS [LOG] FROM enrollments;
DELETE FROM enrollments;
DELETE FROM sqlite_sequence WHERE name = 'enrollments';
SELECT 'Warning: enrollments id counter reset' AS [LOG];


SELECT 'Starting (re)insertion of enrollments' AS [LOG];
-- Using WITH to make things clearer
WITH enrollments_data AS  --- FIXME
(
    SELECT DISTINCT
      -- Course data
      sc.course_id AS course_id,
      -- Student id
      s.id AS student_id
    FROM
      student_courses AS sc
      JOIN students AS s
        ON sc.student_id = s.id
    ORDER BY course_id
)
INSERT INTO enrollments (course_id, student_id)
SELECT * FROM enrollments_data
;

SELECT 
    'Inserted Enrollments' AS [STEP], 
    COUNT(*) AS [INSERTED ROWS COUNT] 
FROM enrollments;




/*
 * IMPORTANT NOTES on using INSERT while using data from other tables
 *
 * 1/ THERE IS NO IF/ELSE in SQL so only two ways to avoid a script error because of a SELECT
 *    trying to query unexistant table or columns is...
 *    a) Using a "fallback creation instruction" aka making a "CREATE TABLE IF NOT EXISTS" BEFORE the selects
 *       (and potentiallly using similar logic to ALTER TABLE for each column to ensure all targeted ones exist)
 *    b) Delegating the logic branching to an external language's script such as Python/PHP where its code would
 *       FIRST interrogate the database structure with something like (SQLite3 specific example)
 *        `SELECT name FROM sqlite_schema WHERE type = 'table' AND name = 'courses';`
 *       THEN decide whether to proceed or not with the selects.
 *
 * 2/ For INSERT INTO instructions you can directly use "SELECT" clauses to fill in the values array!!!
 *    So technically WITH is not needed. BUT it can still be useful if you want to "prepare" the source data,
 *    for example filtering, sorting, using aggregated functions etc.
 *
 * 3/ Even on columns with AUTO-INCREMENT you can force the value. There is no "collision" nor "continuity" check
 *    just because it would be auto increment. Only if you define such constraints directlyl (or indirectly with PRIMARY KEY)
 *    would such checks occur.
 *
 * 4/ There are several ways to push information on standard output: "concatenate", "as a table", or for SQLite specifically .print
 *    Confer above code for examples
 * 5/ Technically I did only one complex WITH but you can make several separate WITH before making a SELECT with JOIN.
 * 6/ There is no standard information_schema in SQLite to dig structure information 
 *    (ex SELECT column_name, data_type, is_nullable FROM information_schema.columns WHERE table_name = 'students'; )
 *    IN SQLite you have to either target specific table (ex SELECT sql FROM sqlite_schema WHERE type = 'table' AND name = 'students';)
 *      or use the .schema command (ex .schema students) or PRAGMA table_info(tablename)
 */
