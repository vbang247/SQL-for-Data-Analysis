# SQL-for-Data-Analysis

This repository contains the solutions to the SQL quizzes which are part of the course: [SQL for Data Analysis](https://www.udacity.com/course/sql-for-data-analysis--ud198) by [Udacity](https://www.udacity.com/).

Steps to create the Parch & Posey database schema:
  1. Download the parch-and-posey.sql prsent at the root of this repository to your local machine
  2. Launch PostgreSQL terminal: `psql`
  3. Now create a new database - `CREATE DATABASE postgresdb;`
  4. Exit the PostgreSQL terminal
  5. Enter the command: **psql -U postgres -d postgresdb -a -f parch-and-posey.sql**
  6. Enter the password for postgres user when prompted

Your database is now ready!
