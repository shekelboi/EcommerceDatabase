-- Generated data

-- Categories
insert into category (name, logo) values
('electronics', 'electronics_logo.png'),
('clothing', 'clothing_logo.png'),
('home & kitchen', 'home_kitchen_logo.png'),
('books', 'books_logo.png'),
('toys', 'toys_logo.png');

-- Subcategories
insert into subcategory (category_id, name) values
(1, 'mobile phones'),
(1, 'laptops'),
(2, 'men''s clothing'),
(2, 'women''s clothing'),
(3, 'kitchen appliances'),
(3, 'furniture'),
(4, 'fiction'),
(4, 'non-fiction'),
(5, 'action figures'),
(5, 'board games');

-- Products
insert into product (public_id, name, description, slug, image_id, price, stock, subcategory_id) values
(generate_base_32(), 'Smartphone XYZ', 'Latest model smartphone with amazing features.', shortened_slug('Smartphone XYZ'), 'img1.png', 699.99, 50, 1),
(generate_base_32(), 'Laptop ABC', 'High-performance laptop for gaming and work.', shortened_slug('Laptop ABC'), 'img2.png', 1299.99, 30, 2),
(generate_base_32(), 'Men''s T-Shirt', 'Comfortable cotton t-shirt.', shortened_slug('Men''s T-Shirt'), 'img3.png', 19.99, 100, 3),
(generate_base_32(), 'Women''s Dress', 'Elegant dress for special occasions.', shortened_slug('Women''s Dress'), 'img4.png', 49.99, 75, 4),
(generate_base_32(), 'Blender', 'High-speed blender for smoothies.', shortened_slug('Blender'), 'img5.png', 89.99, 20, 5),
(generate_base_32(), 'Dining Table', 'Beautiful wooden dining table.', shortened_slug('Dining Table'), 'img6.png', 399.99, 15, 6),
(generate_base_32(), 'Best-Selling Novel', 'A gripping fiction novel that you won''t put down.', shortened_slug('Best-Selling Novel'), 'img7.png', 14.99, 200, 7),
(generate_base_32(), 'Science Book', 'An insightful exploration of the universe.', shortened_slug('Science Book'), 'img8.png', 24.99, 150, 8),
(generate_base_32(), 'Action Figure', 'Collectible action figure from popular series.', shortened_slug('Action Figure'), 'img9.png', 29.99, 100, 9),
(generate_base_32(), 'Board Game', 'Fun board game for family nights.', shortened_slug('Board Game'), 'img10.png', 39.99, 60, 10),
(generate_base_32(), 'Incredible All-in-One Kitchen Appliance for All Your Cooking Needs', 'This kitchen appliance combines a blender, a steamer, and a pressure cooker into one convenient device.', shortened_slug('Incredible All-in-One Kitchen Appliance for All Your Cooking Needs'), 'img11.png', 199.99, 25, 5),
(generate_base_32(), 'Ultimate Travel Backpack with Multiple Compartments for Easy Organization and Comfort', 'A versatile backpack designed for travelers, featuring various compartments and ergonomic support.', shortened_slug('Ultimate Travel Backpack with Multiple Compartments for Easy Organization and Comfort'), 'img12.png', 89.99, 40, 1);

-- Addresses
insert into address (type, country, state, town, zip, address_line_1, address_line_2) values
('Home', 'USA', 'California', 'Los Angeles', '90001', '123 Elm St', 'Apt 4A'),
('Home', 'USA', 'New York', 'New York', '10001', '456 Maple Ave', 'Floor 2'),
('Office', 'USA', 'Texas', 'Austin', '73301', '789 Oak Dr', 'Suite 100'),
('Home', 'USA', 'Florida', 'Miami', '33101', '101 Pine Rd', ''),
('Home', 'USA', 'Illinois', 'Chicago', '60601', '202 Birch Blvd', 'Unit 3B');

-- Customers
select create_customer('John', 'Doe', 'john.doe@example.com', '1234567890', 'simplepass', 1); -- Simple password
select create_customer('Jane', 'Smith', 'jane.smith@example.com', '0987654321', 'S3cureP@ssw0rd!', 2); -- Complex password
select create_customer('Alice', 'Johnson', 'alice.johnson@example.com', '5551234567', 'Password123', 3); -- Realistic password
select create_customer('Bob', 'Williams', 'bob.williams@example.com', '5559876543', 'qwerty', 4); -- Simple password
select create_customer('Charlie', 'Brown', 'charlie.brown@example.com', '5550001111', 'A1b2C3d4!', 5); -- Complex password
select create_customer('Diana', 'Prince', 'diana.prince@example.com', '5552223333', '123456', NULL); -- Simple password
select create_customer('Ethan', 'Hunt', 'ethan.hunt@example.com', '5554445555', 'DifficultP@ssword!123', NULL); -- Complex password
select create_customer('Fiona', 'Green', 'fiona.green@example.com', '5556667777', 'ilovepizza', NULL); -- Simple password
select create_customer('George', 'Black', 'george.black@example.com', '5558889999', 'JustA$imple1', NULL); -- Realistic password
select create_customer('Hannah', 'White', 'hannah.white@example.com', '5551112222', 'C0mpl3x&Secure!', NULL); -- Complex password

-- Customer and address connections
insert into customer_and_address (customer_id, address_id) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 1),
(7, 2),
(8, 3),
(9, 4),
(10, 5);

-- Sales
insert into sale (ordered_at, shipping_status, customer_id, address_id, is_paid) values
(now(), 'Not sent', 1, 1, TRUE),
(now() - interval '1 day', 'Shipped', 2, 2, TRUE),
(now() - interval '2 days', 'Delivered', 3, 3, TRUE),
(now() - interval '3 days', 'Processing', 4, 4, FALSE),
(now() - interval '4 days', 'Cancelled', 5, 5, FALSE);

-- Sale and product connections
insert into sale_and_product (sale_id, product_id, amount, price_per_piece) values
(1, 1, 1, 699.99),
(1, 3, 2, 19.99),
(2, 2, 1, 1299.99),
(2, 4, 1, 49.99),
(3, 7, 3, 14.99),
(4, 5, 2, 89.99),
(5, 10, 1, 39.99),
(5, 6, 1, 399.99);

-- Status updates
insert into status_update (sale_id, status_change) values
(1, 'Order placed successfully.'),
(2, 'Order has been shipped.'),
(3, 'Order has been delivered.'),
(4, 'Order is being processed.'),
(5, 'Order has been cancelled by the customer.');
