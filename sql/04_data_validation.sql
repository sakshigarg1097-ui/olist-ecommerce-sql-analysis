----------------------------------------
-- 1. ROW COUNT VALIDATIONS
----------------------------------------

USE olist_ecommerce;

SELECT 'customers' AS table_name, COUNT(*) AS row_count
FROM customers

UNION ALL

SELECT 'orders', COUNT(*)
FROM orders

UNION ALL

SELECT 'order_items', COUNT(*)
FROM order_items

UNION ALL

SELECT 'payments', COUNT(*)
FROM payments

UNION ALL

SELECT 'products', COUNT(*)
FROM products

UNION ALL

SELECT 'reviews', COUNT(*)
FROM reviews

UNION ALL

SELECT 'sellers', COUNT(*)
FROM sellers

UNION ALL

SELECT 'category_translation', COUNT(*)
FROM category_translation;

------------------------------------
-- 2. PRIMARY KEY VALIDATION
------------------------------------

-- Orders
SELECT order_id, COUNT(*) AS occurences
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Customers
SELECT customer_id, COUNT(*) AS occurences
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Products
SELECT product_id, COUNT(*) AS occurences
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Sellers
SELECT seller_id, COUNT(*) AS occurences
FROM sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;

-- Reviews
SELECT review_record_id, COUNT(*) AS occurences
FROM reviews
GROUP BY review_record_id
HAVING COUNT(*) > 1;

-- order_items
SELECT order_id, order_item_id,
COUNT(*) AS occurences
FROM order_items 
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;

-- payments
SELECT order_id, payment_sequential,
COUNT(*) AS occurences
FROM payments
GROUP BY order_id, payment_sequential
HAVING COUNT(*) > 1;

------------------------------------
-- 3. NULL/missing-value validation
------------------------------------

-- customers
SELECT COUNT(*) AS null_customer_id
FROM customers
WHERE customer_id IS NULL;

-- orders
SELECT COUNT(*) AS null_order_id
FROM orders
WHERE order_id IS NULL;

-- order_items
SELECT COUNT(*) AS null_order_id
FROM order_items
WHERE order_id IS NULL;

SELECT COUNT(*) AS null_order_item_id
FROM order_items
WHERE order_item_id IS NULL;

-- payments
SELECT COUNT(*) AS null_order_id
FROM payments
WHERE order_id IS NULL;

SELECT COUNT(*) AS null_payment_sequential
FROM payments
WHERE payment_sequential IS NULL;

-- products
SELECT COUNT(*) AS null_product_id
FROM products
WHERE product_id IS NULL;

-- sellers
SELECT COUNT(*) AS null_seller_id
FROM sellers
WHERE seller_id IS NULL;

-- reviews
SELECT COUNT(*) AS null_review_record_id
FROM reviews
WHERE review_record_id IS NULL;

-------------------------------------------
-- 4. FOREIGN KEY/relationship validation
-------------------------------------------

-- 1. orders -) customers
SELECT COUNT(*) AS orphan_orders
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- 2. order items -> orders
SELECT COUNT(*) AS orphan_order_items
FROM order_items oi
LEFT JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- 3. order items -> products
SELECT COUNT(*) AS orphan_product_items
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- 4. order items -> sellers
SELECT COUNT(*) AS orphan_seller_items
FROM order_items oi
LEFT JOIN sellers s
ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;

-- 5. payments -> orders
SELECT COUNT(*) AS orphan_payments
FROM payments p
LEFT JOIN orders o
ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

-- 6. reviews -> orders
SELECT COUNT(*) AS orphan_reviews
FROM reviews r
LEFT JOIN orders o
ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

-----------------------------
-- 5. BUSINESS SANITY CHECKS
-----------------------------

-- 1.review scores
SELECT 
MIN(review_score) AS min_score,
MAX(review_score) AS max_score
FROM reviews;

-- 2. negative payment values
SELECT COUNT(*) AS negative_payments
FROM payments
WHERE payment_value < 0;

-- 3. negative product prices
SELECT COUNT(*) AS negative_prices
FROM order_items
WHERE price < 0;

-- 4. invalid payment installments(should be atleast 1)
SELECT COUNT(*) AS invalid_installments
FROM payments
WHERE payment_installments <= 0;

-- Result: 2 records have payment_installments = 0.
-- Data anomaly retained without modification.

-- 5. invalid delivery dates
SELECT COUNT(*) AS invalid_delivery_dates
FROM orders
WHERE order_delivered_customer_date < order_purchase_timestamp;

-- 6. invalid estimated delivery dates
-- should not be earlier than the purchase date
SELECT COUNT(*) AS invalid_estimated_dates
FROM orders
WHERE order_estimated_delivery_date < DATE(order_purchase_timestamp);

-- 7. invalid product dimensions/weights
SELECT COUNT(*) AS  invalid_product_measurements
FROM products
WHERE product_weight_g < 0
OR product_length_cm < 0
OR product_height_cm < 0
OR product_width_cm < 0;
