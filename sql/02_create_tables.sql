-- =========================================
-- 2. Create Tables
-- =========================================

-- Table 1 : customers 
CREATE TABLE customers(
customer_id VARCHAR(50) PRIMARY KEY,
customer_unique_id VARCHAR(50) NOT NULL,
customer_zip_code_prefix INT,
customer_city VARCHAR(100),
customer_state VARCHAR(10)
);

-- Table 2 : Products
CREATE TABLE products(
product_id VARCHAR(50) PRIMARY KEY,
product_category_name VARCHAR(100),
product_name_length INT,
product_description_length INT,
product_photos_qty INT,
product_weight_g INT,
product_length_cm INT,
product_height_cm INT,
product_width_cm INT
);

-- Table 3 : Sellers
CREATE TABLE sellers(
seller_id VARCHAR(50) PRIMARY KEY,
seller_zip_code_prefix INT,
seller_city VARCHAR(100),
seller_state VARCHAR(10)
);

-- Table 4 : Orders
CREATE TABLE orders (
order_id VARCHAR(50) PRIMARY KEY,
customer_id VARCHAR(50) NOT NULL,
order_status VARCHAR(30),
order_purchase_timestamp DATETIME,
order_approved_at DATETIME,
order_delivered_carrier_date DATETIME,
order_delivered_customer_date DATETIME,
order_estimated_delivery_date DATETIME,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Table 5 : Order Items
CREATE TABLE order_items(
order_id VARCHAR(50) NOT NULL,
order_item_id INT NOT NULL,
product_id VARCHAR(50) NOT NULL,
seller_id VARCHAR(50) NOT NULL,
shipping_limit_date DATETIME,
price DECIMAL(10,2),
PRIMARY KEY (order_id, order_item_id),
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id),
FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

-- Table 6 : Payments
CREATE TABLE payments(
order_id VARCHAR(50) NOT NULL,
payment_sequential INT NOT NULL,
payment_type VARCHAR(30),
payment_installments INT,
payment_value DECIMAL(10,2),
PRIMARY KEY (order_id, payment_sequential),
FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Table 7 : Reviews
CREATE TABLE reviews(
review_record_id INT AUTO_INCREMENT PRIMARY KEY,
review_id VARCHAR(50),
order_id VARCHAR(50) NOT NULL,
review_score INT,
review_comment_title VARCHAR(255),
review_comment_message TEXT,
review_creation_date DATETIME,
review_answer_timestamp DATETIME,
FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Table 8 : Category Translation
CREATE TABLE category_translation (
product_category_name VARCHAR(100) PRIMARY KEY,
product_category_name_english VARCHAR(100)
);

