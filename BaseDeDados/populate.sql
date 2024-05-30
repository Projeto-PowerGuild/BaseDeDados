-- Insert data into the platforms table
INSERT INTO platforms (name) VALUES 
('PlayStation'),
('Xbox'),
('Nintendo Switch'),
('PC'),
('Mobile');

-- Insert data into the developers table
INSERT INTO developers (name, location, contact_email) VALUES 
('Epic Games', 'Cary, NC, USA', 'contact@epicgames.com'),
('Nintendo', 'Kyoto, Japan', 'support@nintendo.co.jp'),
('Valve Corporation', 'Bellevue, WA, USA', 'contact@valvesoftware.com'),
('Rockstar Games', 'New York, NY, USA', 'support@rockstargames.com'),
('CD Projekt Red', 'Warsaw, Poland', 'contact@cdprojektred.com');

-- Insert data into the suppliers table
INSERT INTO suppliers (name, price) VALUES 
('Gamer Supplies Inc.', 500.00),
('Tech Warehouse', 300.50),
('Game Gear', 450.75),
('Hardware Hub', 600.20),
('Digital Distributors', 250.00);

-- Insert data into the distributors table
INSERT INTO distributors (name, price, location) VALUES 
('Game Distribution Co.', 50.00, 'New York, NY'),
('Tech Distributors LLC', 45.00, 'Los Angeles, CA'),
('Digital Delivery Inc.', 40.00, 'Chicago, IL'),
('Electronics Distributors', 35.00, 'Houston, TX'),
('Gadget Distributors', 30.00, 'Phoenix, AZ');

-- Insert data into the payments table
INSERT INTO payments (card_name, card_number, cvc, due_date) VALUES 
('John Doe', 1234567890123456, '123', '2025-12-31 23:59:59'),
('Jane Smith', 2345678901234567, '234', '2024-11-30 23:59:59'),
('Alice Johnson', 3456789012345678, '345', '2026-10-31 23:59:59'),
('Bob Brown', 4567890123456789, '456', '2023-09-30 23:59:59'),
('Charlie Davis', 5678901234567890, '567', '2027-08-31 23:59:59');

-- Insert data into the users table
INSERT INTO users (name, email, pwd) VALUES 
('Michael Scott', 'michael.scott@dundermifflin.com', 'pw1MSc#2024'),
('Pam Beesly', 'pam.beesly@dundermifflin.com', 'pw2PBs*2024'),
('Jim Halpert', 'jim.halpert@dundermifflin.com', 'pw3JHs&2024'),
('Dwight Schrute', 'dwight.schrute@dundermifflin.com', 'pw4DSr@2024'),
('Stanley Hudson', 'stanley.hudson@dundermifflin.com', 'pw5SHu%2024');

-- Insert data into the wishlists table
INSERT INTO wishlists (added_date, fk_user_id) VALUES 
('2024-05-18 12:34:56', 1),
('2024-05-18 09:15:23', 2),
('2024-05-18 16:47:12', 3),
('2024-05-18 11:22:33', 4),
('2024-05-18 18:45:00', 5);

-- Insert data into the customers table
INSERT INTO customers (address, postal_code, phone_number, fk_user_id) VALUES 
('Scranton Business Park, 1725 Slough Avenue', '18503', '123456789', 1),
('456 Elm Street', '18504', '987654321', 2),
('789 Maple Avenue', '18505', '456789123', 3),
('321 Oak Drive', '18506', '789123456', 4),
('654 Pine Lane', '18507', '321654987', 5);

-- Insert data into the products table
INSERT INTO products (name, description, discount, price, quantity, launch_date, Type, category, fk_developers_id, fk_suppliers_id) VALUES 
('Fortnite', 'Battle Royale Game', 10, 5.99, 1000, '2024-05-18 14:32:11', 'Non-Physical', 'Game', 1, 1),
('The Legend of Zelda: Breath of the Wild', 'Adventure Game', 5, 59.99, 500, '2024-05-18 08:22:45', 'Physical', 'Game', 2, 2),
('Half-Life: Alyx', 'VR Game', 15, 39.99, 300, '2024-05-18 19:11:30', 'Non-Physical', 'Game', 3, 3),
('Grand Theft Auto V', 'Action-Adventure Game', 20, 29.99, 700, '2024-05-18 10:58:05', 'Physical', 'Game', 4, 4),
('Cyberpunk 2077', 'RPG Game', 25, 49.99, 400, '2024-05-18 17:45:55', 'Physical', 'Game', 5, 5);

-- Insert data into the sales table
INSERT INTO sales (date, discount, distributorsPrice, fk_distributors_id) VALUES 
('2024-05-18 13:24:50', 5, 50, 1),
('2024-05-18 15:47:20', 10, 45, 2),
('2024-05-18 09:33:25', 15, 40, 3),
('2024-05-18 11:59:59', 20, 35, 4),
('2024-05-18 16:40:30', 25, 30, 5);

-- Insert data into the reviews table
INSERT INTO reviews (ratings, review_text, review_date, fk_user_id, fk_product_id) VALUES 
(5, 'Amazing game!', '2024-05-18 14:15:22', 1, 1),
(4, 'Really enjoyed it!', '2024-05-18 10:25:35', 2, 2),
(3, 'It was okay.', '2024-05-18 17:05:45', 3, 3),
(2, 'Not my type.', '2024-05-18 09:11:50', 4, 4),
(1, 'Terrible game.', '2024-05-18 13:55:30', 5, 5);

-- Insert data into the customers_payments table
INSERT INTO customers_payments (fk_customers_id, fk_payments_id, fk_sales_id) VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

-- Insert data into the products_platforms table
INSERT INTO products_platforms (fk_platforms_id, fk_products_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Insert data into the sales_products table
INSERT INTO sales_products (quantity, price, fk_sales_id, fk_products_platforms_id) VALUES 
(100, 59.99, 1, 1),
(200, 49.99, 2, 2),
(150, 39.99, 3, 3),
(250, 29.99, 4, 4),
(300, 19.99, 5, 5);

-- Insert data into the products_wishlists table
INSERT INTO products_wishlists (fk_products_id, fk_wishlists_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
