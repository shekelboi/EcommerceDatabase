# Ecommerce Database

DB schema and SQL scripts for creating an ecommerce database.

## Folder Structure

The root directory contains the SQL scripts to create the tables, the functions and load the tables with data.

### Documentation

The `Documentation` folder contains an image of the ER diagram of the DB schema and an editable `.drawio` file, which can be updated on [draw.io](https://app.diagrams.net/), in case the schema changes.

## How To Recreate The Database

Run the `provisioner.cmd` file. You will need to enter the password for the `postgres` user then the `shopadmin` user (this can be adjusted in the `User Creation.sql` script).

The user, the database and the entities are created.

## Scripts

SQL scripts in order of execution.

### User Creation.sql

> Make sure that JDBC is not connected to the database during this process (the Spring Boot application should not be running).

If the `shopadmin` user and the `ecommerce` database has not been created it can be created using the `User and DB Creation.sql`.

### Table Creation.sql

The script that creates the tables and the sequences (used for automatic ID generation) of the database.

### Functions.sql

Useful custom functions (base32 generator, salt generator/password hasher and password checker) functions and prepared statements.

### Generated.sql

Generated data, insert statements to fill up the database.

## Additional Scripts

### recreate-db.psql

[Psql commands](https://www.postgresql.org/docs/current/app-psql.html) to delete and recreate the `ecommerce` database. 

### Original Insert Statements.sql

Original inserts, data created by me.