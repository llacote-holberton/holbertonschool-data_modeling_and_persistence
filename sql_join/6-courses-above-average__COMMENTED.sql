-- Cannot use WITH syntax because of checker not expecting it sadly.
SELECT courses.title as course_title --,
  -- enrollments_count.total_per_course as course_counts
  FROM courses
JOIN 
(
  SELECT
  enrollments.course_id, -- MUST BE KEPT for correct joining and grouping
  COUNT(enrollments.course_id) AS total_per_course
  FROM enrollments
  GROUP BY enrollments.course_id
) AS enrollments_count 
  ON enrollments_count.course_id = courses.id
-- CANNOT WORK because AVG is an "aggregation function" aka a function
--   which applies some computation on the *resulting set of rows which comes
--   only AFTER the SELECT/FROM/WHERE clauses have been processed!!
-- So only way is another dedicated subrequest
-- WHERE enrollments_count.total_per_course > AVG(course_counts)
WHERE enrollments_count.total_per_course > (
  SELECT AVG(course_subs) -- AS average_count
  FROM (
      SELECT COUNT(course_id) as course_subs
      FROM enrollments
      GROUP BY course_id
  )
)
-- ORDER BY course_counts ASC
ORDER BY course_title ASC;


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
 *
 * === GOAL ANALYSIS ===
 * List of courses that have more enrollments than the average means...
 * a) The "main" query must have an "total enrollments > average enrollments"
 * b) Total enrollments can be obtained by making a "COUNT" on the rows of enrollments
 *    for which enrollments.course_id match the courses.id of the row currently examined in courses.
 * c) Average enrollments can be obtained by using the "total enrollments per course" and making an average of it.
 *
 *
 *
 * === NOTES ===
 * THIS DOES NOT WORK
 *
 * SELECT 
 *   COUNT(enrollments.course_id) AS enrollments_by_course,
 *   AVG(enrollments_by_course) AS enrollments_average
 * FROM enrollments
 * GROUP BY enrollments_by_course;
 *
 * Because aliases cannot be reused directly in the same expression as SQL does NOT "read" the SELECT
 *   from left to right as if it was imperative code.
 * Hence why a subrequest "total enrollments per course" then fed to the WHERE filter of the main select is needed
 *
 *
 *
 * THIS DOES NOT WORK EITHER
 * WHERE course_counts > (
 *  SELECT AVG(course_id) AS average_count
 * FROM enrollments
 * GROUP BY course_id
 * )
 *
 * Because what I return to the average function is NOT the "number of entries with the same id"
 *   but just "all the occurences of the same course_id grouped in a 'subset'"
 *   so obviously average would not work as intended ( for example let's say we have 5 subscriptions for course 1
 *   and 4 of course 3: average of 1 & 1 & 1 & 1 is 1, average of 3 & 3 & 3 & 3 is 3, etc)
 * So there is no other choice than make "NESTED SUBQUERIES"
 */
