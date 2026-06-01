-- Creating Books table
CREATE TABLE books (
    id INTEGER PRIMARY KEY AUTOINCREMENT, -- Obvious
    title TEXT NOT NULL,   -- Title should be required, TEXT because no idea of limit to apply
    author TEXT NOT NULL,  -- Same (no VARCHAR(x)) because no good idea of reasonable limit
    genre TEXT NOT NULL,            -- Don't see why it should be mandatory
    price REAL NOT NULL,  -- Consider this required in context of books shop
    stock INTEGER NOT NULL,    -- Same as above
    published_year INTEGER NOT NULL   -- Not a mandatory information IMO
);
