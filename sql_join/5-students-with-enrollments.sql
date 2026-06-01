-- Student is enrolled in at least one course can be reformulated as
--   "student is registered in at least one row of enrollments table"
--   so "get enrollment rows where for current student_id there is at least one row with non-empty course_id"
SELECT DISTINCT students.name AS student_name
FROM students
WHERE students.id IN (
     -- SUBQUERY returning only ids of students enrolled in at least 1 course
    SELECT student_id FROM enrollments
    WHERE course_id IS NOT NULL
)
ORDER BY student_name ASC
;

/*
 * ========== T5 Instructions ==========
 *
 * GOAL - Retrieve a list of students who are enrolled in at least one course, using subquery.
 *
 * RULES:
 * - Must use a subquery with an IN condition.
 * - Returned data must use exactly column names "student_name".
 * - Results must be alphabetically ordered on student name.
 *
 * Note: common mistakes to avoid:
 * Common Mistakes to Avoid
 * - Using JOIN instead of subquery, not using IN
 *
 *
 * === NOTES ===
 * 1. Not sure if JOIN was usable but subquery is more practical because it is basically
 *   making a "multi-step filtering then selection process"
 *   to allow a "virtual table" to be generated on the fly with only the adequate data
 *   before all the formatting or additional filter instructions.
 *   NOTE: technical name of this virtual table is "derived table"
 * 2. Subqueries can be aliased as everything else and it's very common practice as it allows
 *    readers to get a shortname giving a clue on what this subquery does.
 * 3. For more readable queries, subqueries CAN be declared BEFORE the main one using them
 *    by using a slightly different syntax.
 *    Instead of SELECT xxx JOIN (subquery body) AS subquery_alias, where "SELECT" is the "main query"
 *    one can define a "WITH subquery_alias AS (subquery body)" ... "SELECT xxx"
 * 4. Not explicit in instructions but it makes no sense having duplicate listings of student names 
 *    for the same student so I added "DISTINCT" keyword related to select which makes SQL automatically
 *    "compress" all duplicates in a single instance.
 *
 * === DRAFTS ===
 * trying to design the subquery 
 * SELECT student_id, course_id FROM enrollments WHERE course_id IS NOT NULL;
 *
 */

/** ====== V1 for reference (works but NOT compliant with task requirements) ======
SELECT DISTINCT students.name AS student_name
FROM students
JOIN ( -- SUBQUERY returning only ids of students enrolled in at least 1 course
    SELECT student_id FROM enrollments
    WHERE course_id IS NOT NULL
) AS enrolled_students -- ALIAS mandatory for embedded subquery
ON students.id = enrolled_students.student_id
ORDER BY student_name ASC
;
 */
