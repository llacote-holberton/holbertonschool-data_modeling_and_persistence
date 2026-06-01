-- 9.3 Count books for each author
SELECT author, COUNT(title) as count_written_books FROM books GROUP BY author;
