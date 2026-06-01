WITH assignments_per_course AS 
(
  SELECT
    course_id, -- REQUIRED FOR GROUP BY AND JOIN
    count(id) as assignments_count
  FROM assignments
  GROUP BY course_id
)

SELECT courses.title
FROM courses
JOIN assignments_per_course
  ON assignments_per_course.course_id = courses.id
WHERE assignments_per_course.assignments_count > 
  (
      SELECT AVG(assignments_per_course.assignments_count) as average_count
      FROM assignments_per_course
  )

ORDER BY courses.title ASC
;


/*
 * ========== T8.6 Instructions ==========
 *
 * === BUSINESS REQUEST ===
 * The curriculum team wants to identify courses that have a heavier-than-average assignment load.
 * They define this as:
 * - courses whose number of assignments is greater than the average number of assignments per course in the dataset
 * The result must show:
 * - the course title
 * The list must be presented in alphabetical order by course title.
 *
 * === REQUEST ANALYSIS AND DECOMPOSITION ===
 * To fulfill the request we need to...
 * a) Get the count of assignments for each course
 * b) Get the average across all courses
 * c) Combine both to filter one compared to the other
 *
 * === NOTES ===
 * Support of WITH keyword is very old (3.8.3) so I hope checker version will support it.
 */
