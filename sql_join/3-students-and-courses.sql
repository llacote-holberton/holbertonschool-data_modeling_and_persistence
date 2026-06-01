-- We must use 3 tables because "enrollments" table is the only way to make the bridge
--   between students and courses.
SELECT
  s.name AS student_name,
  c.title AS course_title
FROM
  students AS s
  INNER JOIN enrollments AS e
    ON s.id = e.student_id
  INNER JOIN courses AS c
    ON c.id = e.course_id
ORDER BY
  s.name ASC,
  c.title ASC
;

/*
 * ========== T3 Instructions ==========
 *
 * GOAL - Retrieve a list of students and the courses they are enrolled in.
 *
 * RULES:
 * - Must use explicit INNER JOIN to link three tables together.
 * - Must precise an ON joining condition
 * - Returned data must use exactly column names "student_name", "course_title"
 * - Results must be alphabetically ordered on student name then course title.
 * Note: common mistakes to avoid:
 * Common Mistakes to Avoid
 * - Joining students directly to courses
 * - Forgetting that enrollments is required
 * - Returning IDs instead of names/titles
 * - Using incorrect aliases or column names
 * - Forgetting ORDER BY
 *
 * === NOTES ===
 * 1. The order in which JOINS are made is not always important BUT
 *   what matters is that the table targeted by a "ON" clause is "known"
 *   by the interpreter before it reads that line.
 * So cannot do FROM students INNER JOIN enrollments ON courses.id = enrollments.course_id
 *    because we didn't "declare" the use of courses table yet.
 * Besides that it is probably best practice to try and follow the most "humanly logical" order I guess...
 */
