SELECT students.name
FROM students
WHERE students.id IN 
(
    SELECT student_id
    FROM registrations
    -- WHERE course_id IS NOT NULL -- USELESS by definition of the table purpose
)
ORDER BY students.name ASC
;


/*
 * ========== T8.5 Instructions ==========
 *
 * === BUSINESS REQUEST ===
 * Student services wants a list of students who are actively registered in at least one course.
 * The result must show:
 * - the student name
 * Each student must appear only once.
 * The list must be presented in alphabetical order by student name.
 *
 * === REQUEST ANALYSIS AND DECOMPOSITION ===
 * Students are related to courses through a "dedicated relationship table" registrations.
 * We have three approach to get the requested listing since a student wouldn't have its id
 *   stored anywhere in the registrations table if (s)he has no active cursus (we make the 
 *   arbitrary supposition here that when cursus is finished registration is closed and deleted)
 * 1) INNER JOIN with DISTINCT to eliminate duplicates
 * 2) SUBQUERY on registrations to get "the list of students id know by registrations"
 *      then check from students.id if they are "in that subset"
 * 3) Make the count of registrations for a given student then filter on count > 0.
 * As the 2nd approach is theorically more performant because two sequential "individual select"
 *   instead of a "generation of cross dataset from joined tables" we'll use it.
 *
 * === NOTES ===
 * Apparently there is a special syntax and keyword for this kind of use-case but no idea whether
 *   checker supports it and whether allowed so I'll pass.
 * WHERE EXISTS (SELECT 1 FROM registrations WHERE registrations.student_id = students.id)
 */
