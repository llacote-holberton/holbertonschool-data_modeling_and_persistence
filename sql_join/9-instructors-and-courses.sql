SELECT
  instructors.name as instructor_name,
  courses.title as course_title
FROM
  courses
RIGHT JOIN
  instructors ON instructors.id = courses.instructor_id
ORDER BY
  instructor_name ASC,
  course_title ASC
;


/*
 * ========== T8.2 Instructions ==========
 *
 * === BUSINESS REQUEST ===
 * The platform administrators want to review all instructors, including those who are not currently assigned to any course.
 * For each instructor, they want to see:
 * - the instructor name
 * - the course title, when one exists.
 * If an instructor is not assigned to any course, that instructor must still appear in the result.
 * The list must be presented in alphabetical order by instructor name. 
 * When an instructor appears in more than one row, their courses must also appear in alphabetical order.
 *
 * === REQUEST ANALYSIS AND DECOMPOSITION ===
 * Courses have a many to 1 relationship with "instructors" through "courses.instructor_id" foreign key.
 * Only field we want from instructors is his/her "name".
 * Because the relationship is not "many to many" it would normally be simpler to "start from the many side".
 *   So although we only practiced LEFT JOIN and not RIGHT JOIN so far let's use the latter this time.
 * While a course cannot exist without instructor, the reverse is not true, hence while we want a LEFT join to see 
 *   instructors not linked to any course.
 * Last business requirement implies a "chained ORDER BY".
 */
