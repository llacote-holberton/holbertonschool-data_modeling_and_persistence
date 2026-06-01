SELECT
  courses.title as course_title,
  COUNT(enrollments.student_id) as enrollment_count
FROM courses
  LEFT JOIN enrollments
    ON enrollments.course_id = courses.id
GROUP BY
  courses.id
ORDER BY
  enrollment_count DESC,
  course_title ASC
;

-- WARNING: the GROUP BY must explicitely target the id column from courses table (courses.id)
--   "course_id" is not the right id to target because in spite of the LEFT JOIN
--   if there are several courses without any students then they will all end up
--   in a "NULL id" group and therefore only one of them will have its title listed.

/*
 * ========== T7 Instructions ==========
 *
 * GOAL - Retrieve a list of all courses along with the number of students enrolled in each course (courses without any student must be kept).
 *
 * RULES:
 * - Must use combine keywords GROUP BY, COUNT() and LEFT JOIN.
 * - Columns must be exactly course_title & enrollment_count in that order
 * - Results must be sorted first by "most enrollments count" then alphabetically on title.
 *
 * Note: common mistakes to avoid:
 * Common Mistakes to Avoid
 * - Using INNER JOIN (will exclude courses without students)
 * - COUNTING all (COUNT(*)) may have weird results with a left join
 * - Forgetting the group by or order by, returning ids instead of title.
 */
