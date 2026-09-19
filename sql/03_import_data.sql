USE olist_ecommerce;

-- =========================================
-- 3. Import Data
-- =========================================

-- Enable local CSV imports
SET GLOBAL local_infile = 1;

-- Temporarily disable foreign key checks during data loading
SET FOREIGN_KEY_CHECKS = 0;


-- =========================================
-- Customers
-- =========================================

LOAD DATA LOCAL INFILE 'PATH_TO_DATASET/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
);


-- =========================================
-- Products
-- =========================================

LOAD DATA LOCAL INFILE 'PATH_TO_DATASET/olist_products_dataset.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    product_id,
    product_category_name,
    @product_name_length,
    @product_description_length,
    @product_photos_qty,
    @product_weight_g,
    @product_length_cm,
    @product_height_cm,
    @product_width_cm
)
SET
    product_name_length = NULLIF(@product_name_length, ''),
    product_description_length = NULLIF(@product_description_length, ''),
    product_photos_qty = NULLIF(@product_photos_qty, ''),
    product_weight_g = NULLIF(@product_weight_g, ''),
    product_length_cm = NULLIF(@product_length_cm, ''),
    product_height_cm = NULLIF(@product_height_cm, ''),
    product_width_cm = NULLIF(@product_width_cm, '');


-- =========================================
-- Sellers
-- =========================================

LOAD DATA LOCAL INFILE 'PATH_TO_DATASET/olist_sellers_dataset.csv'
INTO TABLE sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
);


-- =========================================
-- Orders
-- =========================================

LOAD DATA LOCAL INFILE 'PATH_TO_DATASET/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    order_id,
    customer_id,
    order_status,
    @order_purchase_timestamp,
    @order_approved_at,
    @order_delivered_carrier_date,
    @order_delivered_customer_date,
    @order_estimated_delivery_date
)
SET
    order_purchase_timestamp = NULLIF(@order_purchase_timestamp, ''),
    order_approved_at = NULLIF(@order_approved_at, ''),
    order_delivered_carrier_date = NULLIF(@order_delivered_carrier_date, ''),
    order_delivered_customer_date = NULLIF(@order_delivered_customer_date, ''),
    order_estimated_delivery_date = NULLIF(@order_estimated_delivery_date, '');


-- =========================================
-- Order Items
-- =========================================

LOAD DATA LOCAL INFILE 'PATH_TO_DATASET/olist_order_items_dataset.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    order_id,
    order_item_id,
    product_id,
    seller_id,
    @shipping_limit_date,
    price
)
SET
    shipping_limit_date = NULLIF(@shipping_limit_date, '');


-- =========================================
-- Payments
-- =========================================

LOAD DATA LOCAL INFILE 'PATH_TO_DATASET/olist_order_payments_dataset.csv'
INTO TABLE payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    order_id,
    @payment_sequential,
    @payment_type,
    @payment_installments,
    @payment_value
)
SET
    payment_sequential = NULLIF(@payment_sequential, ' '),
    payment_type = NULLIF(@payment_type, ' '),
    payment_installments = NULLIF(@payment_installments, ' '),
    payment_value = NULLIF(@payment_value, ' ');


-- =========================================
-- Reviews
-- =========================================

LOAD DATA LOCAL INFILE 'PATH_TO_DATASET/olist_order_reviews_dataset.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    review_id,
    order_id,
    review_score,
    @comment_title,
    @comment_message,
    @creation_date,
    @answer_date
)
SET
    review_comment_title = NULLIF(@comment_title, ''),
    review_comment_message = NULLIF(@comment_message, ''),
    review_creation_date = NULLIF(@creation_date, ''),
    review_answer_timestamp = NULLIF(@answer_date, '');


-- =========================================
-- Category Translation
-- =========================================

LOAD DATA LOCAL INFILE 'PATH_TO_DATASET/product_category_name_translation.csv'
INTO TABLE category_translation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    product_category_name,
    product_category_name_english
);


-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;