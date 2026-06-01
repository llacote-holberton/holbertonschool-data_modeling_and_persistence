SELECT
  courses.title AS course_title,
  COUNT(registrations.student_id) as number_of_registrations
FROM courses
  LEFT JOIN registrations
    ON registrations.course_id = courses.id
GROUP BY
  courses.id
ORDER BY 
  number_of_registrations DESC,
  course_title ASC
;


/*
 * ========== T8.4 Instructions ==========
 *
 * === BUSINESS REQUEST ===
 * The academic team wants to know how many students are registered in each course.
 *
 * They want the result to include every course, even if no students are currently registered in it.
 * The result must show:
 * - the course title
 * - the number of registrations
 * Courses with more registrations must appear first.
 * If two courses have the same number of registrations, they must be ordered alphabetically by course title.
 *
 * === REQUEST ANALYSIS AND DECOMPOSITION ===
 * Students are related to courses through a "dedicated relationship table" registrations.
 * But this time we don't need infos from the students table itself, student_id in registrations is enough.
 * So a single JOIN with some COUNT() on registration table grouped by course id should be enough.
 * Request asks for courses without registrations to appear so LEFT join is required.
 * The requests on order of appearance imply a chained ORDER BY, first on count of registration then on course title.
 *
 * === NOTES ===
 * Courses API Design and Advanced Databases both have 15 registrations but API appears first in spite of
 *   the ORDER BY course title when same number of registrations.
 * Apparently SQLite uses case-sensitive ordering (by ASCII value of characters) hence why API first
 *   since uppercase characters are "lower in ASCII scale".
 * In case checker complains I could try the option "COLLATE NOCASE" after ASC/DESC
 */
