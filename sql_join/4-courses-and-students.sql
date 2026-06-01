-- We must use 3 tables because "enrollments" table is the only way to make the bridge
--   between students and courses.
SELECT
  courses.title AS course_title,
  students.name AS student_name
FROM
  courses
LEFT JOIN enrollments
  ON courses.id = enrollments.course_id
LEFT JOIN students
  ON students.id = enrollments.student_id
ORDER BY
  course_title ASC,
  student_name ASC
;

/*
 * ========== T3 Instructions ==========
 *
 * GOAL - Retrieve a list of all courses, even the ones without students, and (case arising) the students enrolled in each one.
 *
 * RULES:
 * - Must use explicit LEFT JOIN to link three tables together.
 * - Must precise an ON joining condition
 * - Returned data must use exactly column names "course_title" then "student_name".
 * - Results must be alphabetically ordered on course title then student name.
 *
 * Note: common mistakes to avoid:
 * Common Mistakes to Avoid
 * - Starting from enrollments instead of courses
 * - Forgetting that enrollments is required
 * - Expecting a course with students to also appear once with NULL
 *
 *
 * === NOTES ===
 * 1. We MUST use LEFT JOIN on BOTH linking because otherwise if we made LEFT JOIN then INNER JOIN
 *   SQL when evaluating the first condition would keep the "course row" but then because enrollment <-> student
 *   because in previous step we kept the line then "enrollment.student_id" would be NULL therefore
 *   enrollments.student_id = students.id would match no row (because student.id is the PRIMARY KEY so CANNOT BE EMPTY)
 *   and therefore would not keep the row in final result.
 * 2. Actually after digging, even with a "regular column" we would have an evaluation NULL = s.id which is "UNKNOWN"
 *    and consequently put aside in inner join.
 */
