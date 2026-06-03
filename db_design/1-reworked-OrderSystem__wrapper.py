#!/usr/bin/env python3
import sqlite3  # Library to interact with the database.
# Useful to have immutability of tuples AND readability of dictionaries
from collections import namedtuple

# 0a. Defining script variables
SQLITE_DB_FILENAME = "1-reworked-OrderSystem__dataset.db"
SQLITE_INIT_TABLES_SCRIPT_FILENAME  = "1-reworked-OrderSystem__migration__new-tables-creation.sql"
SQLITE_INIT_CONTENT_SCRIPT_FILENAME = "1-reworked-OrderSystem__migration__new-tables-filling.sql"


# 0b. Creating a small function to encapsulate sql scripts runs
def run_sql_script(sqlite_driver, script_path, step_label = "Starting next step"):
    print(f"=== Starting step: {step_label} ===")
    try:
        # Grabbing the object charged to trigger sql script execution
        cursor = db_driver.cursor()

        # Trying to read sql instructions source file.
        with open(script_path, 'r', encoding='utf-8') as script_source:
            script_sql = script_source.read()

        # Starting execution of the instructions sequence.
        # Using executescript to allow chained instructions. 
        # Cursor.execute() would stop at the first SQL ';' encountered.
        cursor.executescript(script_sql)

        # Writing the changes in the database file
        db_driver.commit()
        print(f"Script {script_path} executed with success")

    except sqlite3.Error as e:
        # Rollbacking all potential changes if error encountered
        print(f"Execution of SQL instructions failed!\n {e}")
        db_driver.rollback()

    finally:
        # db_driver.close()
        if cursor: cursor.close()

# Isolating the actual script run for better portability
if __name__ == "__main__":
    # 1. Connecting to SQLite database file (creating it if need be)
    # Using the "with syntax" to make code more readable and concise
    with sqlite3.connect(SQLITE_DB_FILENAME) as db_driver:
        # 2. Starting the execution of the several scripts
        # 2a: defining a dict of scripts
        SqlScript = namedtuple("SqlScript", ["label", "filename"])
        migration_scripts = [
            SqlScript(label="1. Creating new tables",
                      filename=SQLITE_INIT_TABLES_SCRIPT_FILENAME),
            SqlScript(label="2. Importing content from old table",
                      filename=SQLITE_INIT_CONTENT_SCRIPT_FILENAME)
        ]
        # 2b: starting the loop to execute each sequentially
        for s in migration_scripts:
            try:
                run_sql_script(db_driver, s.filename, s.label)
            except sqlite3.Error as e:
                print(f"Something failed when running script {s.filename}")
        # 3. Explicit closing of connection not required anymore
