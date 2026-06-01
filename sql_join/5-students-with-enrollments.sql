SELECT DISTINCT students.name AS student_name
FROM students
WHERE students.id IN (
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
 */
