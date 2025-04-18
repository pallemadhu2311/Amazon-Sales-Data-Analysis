show databases;

CREATE DATABASE amazon_data;

use amazon_data;

CREATE TABLE products(
	product_id VARCHAR(50) PRIMARY KEY,
    product_name TEXT,
    category VARCHAR(100),
    actual_price FLOAT,
    discounted_price FLOAT,
    discount_percentage FLOAT,
    rating FLOAT
);

CREATE TABLE users(
	user_id VARCHAR(50) PRIMARY KEY,
    user_name VARCHAR(100)
);


CREATE TABLE reviews(
	review_id VARCHAR(50) PRIMARY KEY,
    product_id VARCHAR(50),
    user_id VARCHAR(50),
    review_title TEXT,
    review_content TEXT,
    rating_count INT,
    FOREIGN KEY(product_id) references products(product_id),
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);
