SELECT
  courses.title as course_title,
  assignments.title as assignment_title
FROM
  courses
LEFT JOIN
  assignments ON courses.id = assignments.course_id
ORDER BY
  course_title ASC,
  assignment_title ASC
;


/*
 * ========== T8.7 Instructions ==========
 *
 * === BUSINESS REQUEST ===
 * The teaching team wants to review all courses and the assignments associated with them.
 * They want the result to include every course, even if a course does not yet have any assignments.
 * The result must show:
 * - the course title
 * - the assignment title, when one exists
 * If a course has no assignments, it must still appear in the result.
 * The list must be presented in alphabetical order by course title.
 * When a course appears in more than one row, its assignment titles must also appear in alphabetical order.
 *
 * === REQUEST ANALYSIS AND DECOMPOSITION ===
 * Course without assignment shown means LEFT JOIN starting from courses (since RIGHT not supported by checker).
 * Presentation requests implies a chained order by.
 *
 *
 *
 * === NOTES ===
 *
 *
 */
