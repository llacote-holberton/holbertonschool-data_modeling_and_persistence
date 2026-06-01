SELECT
  students.name as student_name,
  courses.title as course_title
FROM
  students
  LEFT JOIN registrations
    ON students.id = registrations.student_id
  LEFT JOIN courses
    ON courses.id = registrations.course_id
ORDER BY
  student_name ASC,
  course_title ASC
;


/*
 * ========== T8.3 Instructions ==========
 *
 * === BUSINESS REQUEST ===
 * Student support needs a list showing which courses each student is registered in.
 * The result must show:
 * - the student name
 * - the course title
 * Each row must represent one registration.
 * The list must be presented in alphabetical order by student name, and then by course title.
 *
 * === REQUEST ANALYSIS AND DECOMPOSITION ===
 * Students are related to courses through a "dedicated relationship table" registrations.
 * So we need a two-links joining.
 * As the business request does not precise if the listing should include students without courses,
 *   we make the arbitrary decision to include them case arising thus using a LEFT JOIN instead of INNER.
 */
