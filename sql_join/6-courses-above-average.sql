-- Cannot use WITH syntax because of checker not expecting it sadly.
SELECT courses.title as course_title
  FROM courses
JOIN 
(
  SELECT
  enrollments.course_id,
  COUNT(enrollments.course_id) AS total_per_course
  FROM enrollments
  GROUP BY enrollments.course_id
) AS enrollments_count 
  ON enrollments_count.course_id = courses.id
WHERE enrollments_count.total_per_course > (
  SELECT AVG(course_subs) -- AS average_count
  FROM (
      SELECT COUNT(course_id) as course_subs
      FROM enrollments
      GROUP BY course_id
  )
)
ORDER BY course_title ASC
;


/*
 * ========== T6 Instructions ==========
 *
 * GOAL - Retrieve the list of courses that have more enrollments than the average number of enrollments per course.
 *
 * RULES:
 * - Must use a GROUP BY, COUNT() and a subquery.
 * - Must compare against an aggregated value (average)
 * - Results must be alphabetically ordered on the column exactly named "course_title"
 *
 * Note: common mistakes to avoid:
 * Common Mistakes to Avoid
 * - Forgetting GROUP BY, comparing against average of rows instead of grouped counts
 * - Incorrect aggregation logic
 * - Missing the subquery
 */
