-- Creating Books table
CREATE TABLE books (
    id INTEGER PRIMARY KEY AUTOINCREMENT, -- Obvious
    title TEXT NOT NULL,   -- Title should be required, TEXT because no idea of limit to apply
    author TEXT NOT NULL,  -- Same (no VARCHAR(x)) because no good idea of reasonable limit
    genre TEXT,            -- Don't see why it should be mandatory
    price FLOAT NOT NULL,  -- Consider this required in context of books shop
    stock INT NOT NULL,    -- Same as above
    published_year DATE   -- Not a mandatory information IMO
);
