SELECT
  courses.title as course_title,
  instructors.name as instructor_name
FROM
  courses
INNER JOIN
  instructors ON instructors.id = courses.instructor_id
ORDER BY course_title ASC
;


/*
 * ========== T8.1 Instructions ==========
 *
 * === BUSINESS REQUEST ===
 * The academic team wants a list of all courses together with the name of the instructor responsible for each one.
 * The result must show:
 * - the course title
 * - the instructor name
 * The list must be presented in alphabetical order by course title.
 *
 *
 * === REQUEST ANALYSIS AND DECOMPOSITION ===
 * Courses informations are mostly in the "courses" table.
 * Courses have a many to 1 relationship with "instructors" through "courses.instructor_id" foreign key.
 * Only field we want from instructors is his/her "name".
 * Because the relationship is not "many to many" it's simpler to "start from the many side"
 * Because it would make no sense to have a course without an associated teacher, even though
 *   we don't have the exact, detailed database schema we can safely use an INNER JOIN without missing any course.
 */
