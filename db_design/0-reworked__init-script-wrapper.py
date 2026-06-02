#!/usr/bin/env python3
import sqlite3 # Library to interact with the database.

# 0a. Defining script variables
SQLITE_DB_FILENAME = "0-dataset.db"
SQLITE_INIT_TABLES_SCRIPT_FILENAME  = "0-reworked__init-script__new-tables-creation.sql"
SQLITE_INIT_CONTENT_SCRIPT_FILENAME = "0-reworked__init-script__new-tables-filling-from-old-table-import.sql"


# 0b. Creating a small function to encapsulate sql scripts runs
def run_sql_script(sqlite_driver, script_path, step_label = "Starting next step"):
    print(f"=== Starting step: {step_label} ===")
    try:
        # Grabbing the object charged to trigger sql script execution
        cursor = db_driver.cursor()

        # Trying to read sql instructions source file and get its content as variable.
        with open(script_path, 'r', encoding='utf-8') as script_source:
            script_sql = script_source.read()

        # Starting execution of the instructions sequence.
        # Using executescript to allow chained instructions. Cursor.execute() would stop at the first SQL ';' encountered.
        cursor.executescript(script_sql)

        # Writing the changes in the database file (NOTE: using the db_driver, not the cursor)
        db_driver.commit()
        print(f"Script {script_path} executed with success")

    except sqlite3.Error as e:
        # Rollbacking all potential changes if error encountered
        print(f"Execution of SQL instructions failed!\n {e}")
        db_driver.rollback()

    finally:
        # db_driver.close()
        if cursor: cursor.close()

# 1. Connecting (and initializing file if doesn't exist) to SQLite database file
db_driver = sqlite3.connect(SQLITE_DB_FILENAME)

# NOTE: tip from AI: we can use a volatile database only stored in memory instead, nice for temp tests
# conn = sqlite3.connect(':memory:')

# 2. Starting the execution of the several scripts
# First script: creating new tables
try:
    run_sql_script(db_driver, SQLITE_INIT_TABLES_SCRIPT_FILENAME, "1. Creating new tables")
except sqlite3.Error as e:
    print(f"Something failed during attempt to run script {SQLITE_INIT_TABLES_SCRIPT_FILENAME}")
# Second script: filling them with content
try:
    run_sql_script(db_driver, SQLITE_INIT_CONTENT_SCRIPT_FILENAME, "2. Importing content from old table")
except sqlite3.Error as e:
    print(f"Something failed during attempt to run script {SQLITE_INIT_CONTENT_SCRIPT_FILENAME}")

# 3. Closing cleanly the connection
db_driver.close()

# NOTE: alternative way could have been as such, better to really bring all scripts in a "continuous chain"
# with sqlite3.connect(database_file) as db_driver:
#   try:
#      run_sql_script(db_driver, script1)
#      run_sql_script(db_driver, script2)
#      run_sql_script(db_driver, script3)
#      ...
#   except sqlite3.Error as e:
#     print("Something failed during the execution of all scripts confer error", e)
#   print("End of process")
