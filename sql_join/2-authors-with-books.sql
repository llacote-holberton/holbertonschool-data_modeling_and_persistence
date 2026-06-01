SELECT a.name as author_name, b.title
FROM 
  authors AS a 
    LEFT JOIN books AS b 
    ON a.id = b.author_id
ORDER BY
  author_name ASC,
  title ASC
;

/*
 * ========== T2 Instructions ==========
 *
 * GOAL - Retrieve a list of all authors, including those who do not have any books, 
 *   along with their book titles when available.
 * RULES:
 * - Must use explicit LEFT JOIN
 * - Must precise an ON joining condition
 * - Returned data must use exactly column names "author_name"then "title",  (use alias if needed)
 * - Results must be alphabetically ordered on author name then title.
 * Note that NULL values will appear first when ordering ascending ("empty" < "any character" ;))
 *
 *
 * === NOTES ===
 * 1. This time used aliases on tables and columns for practice.
 *    IMPORTANT NOTE: in spite of using aliases on tables, the "SELECT" clause
 *       MUST STILL COME BEFORE THE "FROM" one.
 * => ORDER of clauses is predefined even though the "writing order" is actually different from the "evaluation order"
 *      (which is as follows: FROM -> JOIN -> WHERE- > GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT)
 * 2. Requirement "return authors even those who don't have written any book yet"
 *      can be reformulated as "keep authors even those with no book registered matching their id"
 *      meaning that we MUST make the select on authors first because task imposes a "LEFT" join.
 * 3. Used newlines and indentation to make query more readable since normally it doesn't affect interpretation.
 */
