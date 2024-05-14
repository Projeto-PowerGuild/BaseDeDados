CREATE DATABASE IF NOT EXISTS powerguild;

USE powerguild;

CREATE TABLE IF NOT EXISTS platforms (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS developers (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    contact_email VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    card_name VARCHAR(50) NOT NULL,
    card_number BIGINT NOT NULL,    
    cvc VARCHAR(3) NOT NULL,
    due_date TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS suppliers (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name VARCHAR(255) NOT NULL,
    price INT NOT NULL
) DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS distributors (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name VARCHAR(255) NOT NULL,
    price FLOAT NOT NULL,
    location VARCHAR(255) NOT NULL
) DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(250) NOT NULL,
    email VARCHAR(250) NOT NULL,
    pwd VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    address VARCHAR(50) NOT NULL,
    postal_code VARCHAR(7) NOT NULL,
    phone_number VARCHAR(9) NOT NULL,
    fk_user_id INT
);

CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    discount INT,
    price FLOAT NOT NULL,
    quantity INT,
    launch_date TIMESTAMP,
    Type ENUM('Physical', 'Non-Physical'),
    category VARCHAR(255),
    fk_developers_id INT,
    fk_wishlist_id INT
) DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS sales (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    date TIMESTAMP,
    price INT,
    discount INT,
    quantity INT,
    priceDistributors INT
);

CREATE TABLE IF NOT EXISTS reviews (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    ratings INT NOT NULL,
    review_text VARCHAR(250),
    review_date TIMESTAMP NOT NULL,
    fk_user_id INT,
    fk_product_id INT
);

CREATE TABLE IF NOT EXISTS wishlists (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    added_date TIMESTAMP NOT NULL,
    fk_user_id INT,
    fk_product_id INT
);

CREATE TABLE IF NOT EXISTS customers_payments (
    fk_customers_id INT,
    fk_payments_id INT,
    fk_sales_id INT,
    PRIMARY KEY (fk_customers_id, fk_payments_id, fk_sales_id)
);

CREATE TABLE IF NOT EXISTS products_platforms (
    fk_platforms_id INT,
    fk_sales_id INT,
    fk_products_id INT,
    PRIMARY KEY (fk_platforms_id, fk_sales_id, fk_products_id)
);

CREATE TABLE IF NOT EXISTS sales_products (
    fk_products_id INT,
    fk_sales_id INT,
    PRIMARY KEY (fk_products_id, fk_sales_id)
);

ALTER TABLE customers 
    ADD CONSTRAINT fk_customers_users FOREIGN KEY (fk_user_id) REFERENCES users(id);

ALTER TABLE products 
    ADD CONSTRAINT fk_products_developers FOREIGN KEY (fk_developers_id) REFERENCES developers(id),
    ADD CONSTRAINT fk_products_wishlists FOREIGN KEY (fk_wishlist_id) REFERENCES wishlists(id);

ALTER TABLE reviews 
    ADD CONSTRAINT fk_reviews_users FOREIGN KEY (fk_user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_reviews_products FOREIGN KEY (fk_product_id) REFERENCES products(id);

ALTER TABLE wishlists 
    ADD CONSTRAINT fk_wishlists_users FOREIGN KEY (fk_user_id) REFERENCES users(id),
    ADD CONSTRAINT fk_wishlists_products FOREIGN KEY (fk_product_id) REFERENCES products(id);

ALTER TABLE customers_payments 
    ADD CONSTRAINT fk_customers_payments_customers FOREIGN KEY (fk_customers_id) REFERENCES customers(id),
    ADD CONSTRAINT fk_customers_payments_payments FOREIGN KEY (fk_payments_id) REFERENCES payments(id),
    ADD CONSTRAINT fk_customers_payments_sales FOREIGN KEY (fk_sales_id) REFERENCES sales(id);

ALTER TABLE products_platforms 
    ADD CONSTRAINT fk_products_platforms_platforms FOREIGN KEY (fk_platforms_id) REFERENCES platforms(id),
    ADD CONSTRAINT fk_products_platforms_sales FOREIGN KEY (fk_sales_id) REFERENCES sales(id),
    ADD CONSTRAINT fk_products_platforms_products FOREIGN KEY (fk_products_id) REFERENCES products(id);

ALTER TABLE sales_products 
    ADD CONSTRAINT fk_sales_products_products FOREIGN KEY (fk_products_id) REFERENCES products(id),
    ADD CONSTRAINT fk_sales_products_sales FOREIGN KEY (fk_sales_id) REFERENCES sales(id);