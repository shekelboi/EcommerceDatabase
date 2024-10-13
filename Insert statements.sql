-- Random base32 generator
create or replace function generate_base_32()
returns text as $$
declare
    v_result text;
begin
    select string_agg(substr('ABCDEFGHIJKLMNOPQRSTUVWXYZ234567', ceil(random() * 32)::integer, 1), '') into v_result
    from generate_series(1, 10);
    return v_result;
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
insert into product (name, description, image_id, price, stock, subcategory_id)
select $1, $2, $3, $4, $5, subcategory.id from subcategory
where subcategory.name = $6;

insert into category (name) values ('Entertainment');
insert into category (name) values ('Electronics');

execute add_subcategory ('Phone', 'Electronics');
execute add_product ('Xiaomi Redmi Note 8 Pro', 'Wifi: Yes<br>5G: No', 'some unique image id', 21.50, 500, 'Phone');

insert into address (type, country, state, town, zip, address_line_1)
values ('home', 'USA', 'Alabama', 'Tuscaloosa', '35405', '901 Foxrun Ave');

insert into customer (first_name, last_name, email, telephone, default_address_id, salt, password_hash)
values ('Joe', 'Biden', 'joebiden@president.com', '555-1942', 1, 'squirrel', '50d858e0985ecc7f60418aaf0cc5ab587f42c2570a884095a9e8ccacd0f6545c');

insert into customer_and_address (customer_id, address_id) values (1, 1);

insert into sale (ordered_at, customer_id, address_id)
values ('2004-10-19 10:23:54', 1, 1);

insert into sale_and_product (sale_id, product_id, amount, price_per_piece)
values (1, 1, 10, 20.49);

insert into status_update (sale_id, status_change)
values
    (1, 'Paid!'),
    (1, 'Shipped!'),
    (1, 'Customs cleared!'),
    (1, 'Delivered!');


-- Add pgcrypto extension for password hashing
create extension if not exists pgcrypto;

create or replace function create_customer(
    first_name text,
    last_name text,
    email text,
    telephone text,
    password text,
    default_address_id int default null
)
returns void as $$
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
end $$ language plpgsql;

select create_customer('Chana', 'Dal', 'chanadal@india.gov', '+912189819221', 'Example_pa$$123', 1);

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

