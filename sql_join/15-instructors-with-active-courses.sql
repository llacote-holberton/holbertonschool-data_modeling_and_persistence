SELECT DISTINCT instructors.name
FROM courses
  INNER JOIN instructors   ON courses.instructor_id = instructors.id
  INNER JOIN registrations ON registrations.course_id = courses.id
ORDER BY instructors.name ASC
;

/*
 * ========== T8.8 Instructions ==========
 *
 * === BUSINESS REQUEST ===
 * The academic director wants a list of instructors who are currently teaching at least one course with at least one registered student.
 * The result must show:
 * - the instructor name
 * Each instructor must appear only once.
 * The list must be presented in alphabetical order by instructor name.
 *
 * === REQUEST ANALYSIS AND DECOMPOSITION ===
 * Instructors with at least one course with at least one registered student means...
 * a) we could make a "prefilter" with subquery to get course_ids from registrations
 * b) we could make the same for instructors...
 * But in fact what is most obvious is that since courses is the "pivot table"
 *   holding both relationships with registrations and instructors respectively with foreign key constraints,
 *   the easiest is to "start from courses" and make inner join on the other two.
 *
 * === NOTES ===
 * SQL parses everything encompassing FROM and JOIN before SELECT
 *  hence why we can target a column from instructors table even if it's not the "starting table"
 *
 */
