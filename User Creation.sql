-- Make sure you are connected to the ecommerce database.
\c ecommerce

-- Revoke all privileges and drop user if exists
do
$$begin
if exists (select from pg_roles where rolname = 'shopadmin') then
    revoke all privileges on database ecommerce from shopadmin;
    drop user shopadmin;
end if;
end$$;

-- Create user with specified password and grant access to the ecommerce database
create user shopadmin with password 'yourpass';
grant all privileges on all tables in schema public to shopadmin;
alter default privileges in schema public grant all privileges on tables to shopadmin;

