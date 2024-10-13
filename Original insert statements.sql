
-- Insert statements

-- Categories
insert into category (name) values('Entertainment');
insert into category (name) values('Electronics');

-- Subcategories
execute add_subcategory('Phone', 'Electronics');

-- Products
execute add_product('Xiaomi Redmi Note 8 Pro', 'Wifi: Yes<br>5G: No', 'some unique image id', 21.50, 500, 'Phone');

-- Addresses
insert into address (type, country, state, town, zip, address_line_1)
values ('home', 'USA', 'Alabama', 'Tuscaloosa', '35405', '901 Foxrun Ave');

-- Customer
insert into customer (first_name, last_name, email, telephone, default_address_id, salt, password_hash)
values ('Joe', 'Biden', 'joebiden@president.com', '555-1942', 1, 'squirrel', '50d858e0985ecc7f60418aaf0cc5ab587f42c2570a884095a9e8ccacd0f6545c');
select create_customer('Chana', 'Dal', 'chanadal@india.gov', '+912189819221', 'Example_pa$$123', 1);

-- Customer and address connectors
insert into customer_and_address (customer_id, address_id) values (1, 1);

-- Sales
insert into sale (ordered_at, customer_id, address_id)
values ('2004-10-19 10:23:54', 1, 1);

-- Sale and product connectors
insert into sale_and_product (sale_id, product_id, amount, price_per_piece)
values (1, 1, 10, 20.49);

-- Status updates
insert into status_update (sale_id, status_change)
values
    (1, 'Paid!'),
    (1, 'Shipped!'),
    (1, 'Customs cleared!'),
    (1, 'Delivered!');
