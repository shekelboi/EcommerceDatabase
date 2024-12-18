-- Drop pgcrypto extension
drop extension if exists pgcrypto;

-- Deallocate all prepared statements
deallocate all;

-- Random base32 generator
create or replace function generate_base_32(p_length int)
returns text as $$
declare
    v_result text;
begin
    select string_agg(substr('ABCDEFGHIJKLMNOPQRSTUVWXYZ234567', ceil(random() * 32)::integer, 1), '') into v_result
    from generate_series(1, p_length);
    return v_result;
end $$ language plpgsql;

-- Generate base32 ID until it's confirmed to be unique
create or replace function generate_unique_base_32(p_table_name text, p_field_name text, p_length int default 12)
returns text as $$
declare
    v_unique_id text;
    v_query_result text;
begin
    raise info 'Attempting to find unique id:';
    while true loop
        v_unique_id := generate_base_32(p_length);
        raise info 'id: %', v_unique_id;
        execute format('select 1 from %I where %I = %L', p_table_name, p_field_name, v_unique_id)
        into v_query_result;
        if v_query_result is null then
            exit;
        end if;
    end loop;
    raise info 'unique id found: %', v_unique_id;
    return v_unique_id;
end $$ language plpgsql;

-- Name to slug generator
create or replace function name_to_slug(
    p_name text
)
returns text as $$
declare
    v_result text;
begin
    select regexp_replace(p_name, '([^a-zA-Z0-9])', '-', 'g') into v_result;
    return v_result;
end $$ language plpgsql;

-- Name to shortened generator
create or replace function shortened_slug(
    p_name text
)
returns text as $$
declare
    v_array text[];
    v_short_slug text;
begin
    v_short_slug := array_to_string((select (select string_to_array(name_to_slug(p_name), '-'))[:5]), '-');
    return v_short_slug;
end $$ language plpgsql;



prepare add_subcategory (varchar, varchar) as
insert into subcategory (category_id, name)
select category.id, $1 from category
where category.name = $2;

prepare add_product (varchar, varchar, varchar, decimal(20, 4), int, varchar) as
insert into product (name, description, slug, image_id, price, stock, subcategory_id)
select $1, $2, shortened_slug($1), $3, $4, $5, subcategory.id from subcategory
where subcategory.name = $6;

-- Add pgcrypto extension for password hashing
create extension if not exists pgcrypto;

create or replace function create_customer(
    first_name text,
    last_name text,
    email text,
    telephone text,
    password text,
    default_address_id bigint default null
)
returns boolean as $$
declare
    computed_hash bytea;
    salt bytea;
    hex_computed_hash text;
    hex_salt text;
begin
    salt := gen_random_bytes(16);
    hex_salt := encode(salt, 'hex');
    computed_hash := digest(password::bytea || salt, 'sha256');
    hex_computed_hash := encode(computed_hash, 'hex');
    raise info 'Checksum: %, salt: %', hex_computed_hash, hex_salt;
    insert into customer (first_name, last_name, email, telephone, default_address_id, salt, password_hash)
    values (first_name, last_name, email, telephone, default_address_id, salt, computed_hash);
    raise info 'Record created for % %', first_name, last_name;
    return true;
exception when others then
    return false;
end $$ language plpgsql;

create or replace function check_password(
    p_email text,
    p_password text
)
returns boolean as $$
declare
    v_computed_hash bytea;
    v_salt bytea;
begin
    select password_hash, salt
    into v_computed_hash, v_salt
    from customer
    where email = p_email;
    -- Return false of the user cannot be found
    if v_computed_hash is null or v_salt is null then
        return false;
    end if;
    -- Compare the hashed password with the stored hash
    return digest(p_password::bytea || v_salt, 'sha256') = v_computed_hash;
end $$ language plpgsql;
