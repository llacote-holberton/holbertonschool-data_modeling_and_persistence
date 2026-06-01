# Overview

This repository will hold many projects tailored to learn UML designing.

# General information - CRUD operations

## Why SQLite?

For this project, you will use **SQLite** as your database system.

SQLite is a **lightweight, file-based relational database** that:

* requires no server setup
* runs locally as a single file
* is widely used for learning, testing, and embedded systems

This makes it ideal for educational environments.

However, it is important to understand that:

* In real-world production systems, databases such as **PostgreSQL, MySQL, Oracle, or SQL Server** are commonly used
* These systems provide additional features such as:

  * user management and permissions
  * advanced indexing and performance tuning
  * concurrency control for multiple users
  * stricter enforcement of data types

SQLite also has some **differences from standard SQL**:

* It uses **dynamic typing** (types are not strictly enforced)
* Some SQL features are simplified or behave differently
* Certain advanced features are not supported or behave differently than in other systems

Throughout the project, when a feature is **SQLite-specific** or differs from standard SQL, it will be clearly indicated.

---

## Context

You are provided with a SQLite database file containing a table with information about books.

Your task is to explore and manipulate this data using SQL queries.

You will work with:

* existing data (for querying and analysis)
* modifications to existing rows
* insertion of new rows

All tasks are **deterministic**, meaning that your queries must produce an exact expected result.

---

## Learning Objectives

By the end of this project, you should be able to:

* Understand the relational model (tables, rows, columns)
* Write SQL queries using standard syntax
* Perform CRUD operations:

  * `INSERT`
  * `SELECT`
  * `UPDATE`
  * `DELETE`
* Filter data using `WHERE`
* Select specific columns
* Sort results using `ORDER BY`
* Limit results using `LIMIT`
* Use aggregate functions:

  * `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
* Group data using `GROUP BY`
* Interpret query results correctly

---

## SQL Scope in This Project

This project focuses on **core SQL concepts that are portable across most relational databases**.

You should aim to write queries that are:

* clear
* simple
* as close as possible to standard SQL

You will **not** use:

* joins
* subqueries
* advanced functions
* database-specific optimizations

When SQLite-specific behavior is required, it will be explicitly mentioned.

---

## Resources

* [SQLite SQL Language Overview](/rltoken/PNuWCh7DGpwHrgUNc5ka0Q)
* [SQLite SELECT](/rltoken/_xOQ9Vw3YCClYV61Tmf-Kg)
* [SQLite INSERT](/rltoken/OYHY_CC-UyGa2u6HlHaAPQ)
* [SQLite UPDATE](/rltoken/bHZr7bgrdFFbU1fnT7qyXw)
* [SQLite DELETE](/rltoken/-rkOUA7lmxsWRUlzgAn5Rw)
* [SQL Standard Overview (W3C summary)](/rltoken/xFmtAvoRbhZr46_dT6oY4w)

---

## Provided Files

You will be given a SQLite database file for some tasks. 

You can download it from here: [https://github.com/hbtn-edu/public_resources/blob/main/3916-sql_crud/books_dataset.db](/rltoken/ksrXbaIDeMX8IbWoH2eaig)

```id=&quot;books-db&quot;
books_dataset.db
```

### Table: `books`

| Column         | Type    | Description               |
| -------------- | ------- | ------------------------- |
| id             | INTEGER | Unique identifier         |
| title          | TEXT    | Book title                |
| author         | TEXT    | Author name               |
| genre          | TEXT    | Book genre                |
| price          | REAL    | Price of the book         |
| stock          | INTEGER | Number of units available |
| published_year | INTEGER | Year of publication       |

&gt; Note: SQLite uses flexible typing. Even though types are declared, they are not strictly enforced. This differs from most production databases.

---

## General Requirements

* Environment used for correction:

  * Ubuntu 20.04
  * SQLite 3.x (CLI)

* Each task must be written in a `.sql` file

* Each task must use:

  * **one SQL query only**, unless stated otherwise

* Queries must be executable using:

  ```
  sqlite3 books.db &lt; file.sql
  ```

* Output must:

  * match exactly the expected result
  * include correct column order
  * include correct row order when required

* If ordering is required, you must use:

  ```
  ORDER BY
  ```

* Do not:

  * modify table structure unless explicitly instructed
  * use joins or subqueries
  * use non-standard SQL unless explicitly allowed

---

## Important Notes

### 1. SQL operates on sets

SQL does not process one row at a time like a typical programming language. It operates on **sets of rows**.

### 2. Order is not guaranteed

Unless you use `ORDER BY`, the order of rows in the result is **undefined**.

### 3. Be careful with UPDATE and DELETE

* `UPDATE` without `WHERE` → updates all rows
* `DELETE` without `WHERE` → deletes all rows

This is valid SQL behavior and a common source of errors.

### 4. SQLite-specific behavior

The following are important SQLite-specific considerations:

* Types are **not strictly enforced**
* Some queries may work in SQLite but fail in stricter systems
* You should still aim to write logically correct SQL, not rely on permissive behavior

# Exercises

| Task name                                         | Filename                        |
|---------------------------------------------------|---------------------------------|
| 00. Understanding and Creating a Table            | 0-create_table.sql              |
| 01. Inserting Data into a Table                   | 1-insert_data.sql               |
| 02. Retrieving All Data from a Table              | 2-select_all.sql                |
| 03. Selecting Specific Columns                    | 3-select_columns.sql            |
| 4. Filtering Rows                                 | 4-filter_by_genre.sql           |
| 05. Updating Rows                                 | 5-update_by_id.sql              |
| 06. Deleting Rows                                 | 6-delete_by_id.sql              |
| 07. Ordering and Limiting Results                 | 7-order_by_price_asc.sql        |
| 08. Aggregate Functions                           | 8-count_books.sql               |
| 09. Grouping Data with `GROUP BY`                 | 9-count_by_genre.sql            |
| 10. Integrative Queries and Data Manipulation     | 10-select_tech_books.sql        |
| 11. Final Quiz                                    | (Quizz)                         |

