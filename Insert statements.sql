prepare add_subcategory (varchar, varchar) as
insert into subcategory (category_id, name)
select category.id, $1 from category
where category.name = $2;

prepare add_product (varchar, varchar, varchar, varchar) as
insert into product (name, description, image_id, subcategory_id)
select $1, $2, $3, subcategory.id from subcategory
where subcategory.name = $4;

insert into category (name) values ('Entertainment');
insert into category (name) values ('Electronics');

execute add_subcategory ('Phone', 'Electronics');
execute add_product ('Xiaomi Redmi Note 8 Pro', 'Wifi: Yes<br>5G: No', 'some unique image id', 'Phone');

insert into address (type, country, state, town, zip, address_line_1)
values ('home', 'USA', 'Alabama', 'Tuscaloosa', '35405', '901 Foxrun Ave');

insert into customer (first_name, last_name, email, telephone, default_address_id, salt, password_hash)
values ('Joe', 'Biden', 'joebiden@president.com', '555-1942', 1, 'squirrel', '50d858e0985ecc7f60418aaf0cc5ab587f42c2570a884095a9e8ccacd0f6545c');

insert into customer_and_address (customer_id, address_id) values (1, 1);

insert into purchase (ordered_at, customer_id, address_id)
values ('2004-10-19 10:23:54', 1, 1);

insert into purchase_and_product (purchase_id, product_id, amount, price_per_piece)
values (1, 1, 10, 20.49);

insert into status_update (purchase_id, status_change)
values
    (1, 'Paid!'),
    (1, 'Shipped!'),
    (1, 'Customs cleared!'),
    (1, 'Delivered!');
