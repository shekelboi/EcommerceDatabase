-- Drop database as admin (must be logged in as admin)
drop database ecommerce;

-- Revoke all privileges and drop user if exists
do
$$begin
if exists (select from pg_roles where rolname = 'shopadmin') then
    drop owned by shopadmin;
    drop user shopadmin;
end if;
end$$;

-- Create user, assume its role and create the ecommerce database
create user shopadmin with password 'yourpass';
alter role shopadmin with login createdb;
set role shopadmin;
create database ecommerce;
