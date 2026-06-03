-- Filling in reworked tables enforcing structure defined in 1-reworked-OrderSystem__docs__entity-relationships-structure.mmd
--   Using data retrieved from the old table order_lines_flat
-- IMPORTANT: script written specifically for SQLite3 (notably specific data types)

-- Keeping the same specificity as original table structure
PRAGMA foreign_keys = OFF;

-- ----------------------------------------------------------------------------
-- Task -1 (Don't Judge xd): Creating a table for "log messages templates".
-- ----------------------------------------------------------------------------
-- Confer "Notes and Design choices" section for infos on the "TEMP" keyword
CREATE TEMP TABLE IF NOT EXISTS log_templates
(
    code TEXT PRIMARY KEY,
    template TEXT NOT NULL
);
INSERT INTO log_templates VALUES
('SOURCE_FALLBACK'     , 'Trying "create if not exists" for source table %s as safety'  ),
('CLEAN_EXISTING_DATA' , '%s: deleting all existing values to recreate from scratch' ),
('CLEAN_CONFIRMATION'  , '--> %d %s deleted'                                         ),
('IMPORT_STARTING'     , 'Starting (re)import of %s data'                            ),
('IMPORT_CONFIRMATION' , 'Success: %d %s inserted'                                   ),
('TEST'                , 'SQL is %s'                                                 )
; -- NEVER FORGET the comma signaling instruction end on multi-line ones ^^

-- HOW TO USE (simple example), note the temp. prefix specific syntax for SQLite3
SELECT replace(template, '%s', 'Good!') AS [LOG] FROM temp.log_templates WHERE code = 'TEST';
