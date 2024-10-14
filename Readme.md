# Ecommerce Database

DB schema and SQL scripts for creating an ecommerce database.

## Folder Structure

The root directory contains the SQL scripts to create the tables, the functions and load the tables with data.

### Documentation

The `Documentation` folder contains an image of the ER diagram of the DB schema and an editable `.drawio` file, which can be updated on [draw.io](https://app.diagrams.net/), in case the schema changes.

## Scripts

SQL scripts in order of execution.

### Table Creation.sql

The script that creates the tables and the sequences (used for automatic ID generation) of the database.

### Functions.sql

Useful custom functions (base32 generator, salt generator/password hasher and password checker) functions and prepared statements.

### Generated.sql

Generated data, insert statements to fill up the database.

## Additional Scripts

### User Creation.sql

> It is crucial for this step to ensure that the database exists and the admin is connected to the database.

If the `shopadmin` user has not been crated it can be created using the `User Creation.sql`, which will have access to the ecommerce database.

### recreate-db.psql

[Psql commands](https://www.postgresql.org/docs/current/app-psql.html) to delete and recreate the `ecommerce` database. 

### Original Insert Statements.sql

Original inserts, data created by me.