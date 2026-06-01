SELECT books.title, authors.name AS author_name
FROM books INNER JOIN authors ON books.author_id = authors.id
ORDER BY title ASC;

/*
 * ========== T1 Instructions ==========
 *
 * GOAL - Retrieve a list of books along with the name of their corresponding author.
 * RULES:
 * - Must use explicit INNER JOIN
 * - Must precise an ON joining condition
 * - Returned data must use exactly column names "title", "author_name" (use alias if needed)
 * - Results must be alphabetically ordered on title.
 *
 *
 * === NOTES ===
 * 1. Used explicit naming table.column even when there would have been no ambiguity
 *    because I find it better practice anyways as long as query not too "big".
 *  Could have shortened bu using table aliases like so
 *  SELECT b.title, a.name AS author_name
 *  FROM books AS b INNER JOIN authors AS a ON a.id = b.author_id
 * 
 * 2. Quotes for an alias string are not required as long as no special character/space
 *    because SQL understands that what comes after 'AS' keyword must be a litteral.
 */
