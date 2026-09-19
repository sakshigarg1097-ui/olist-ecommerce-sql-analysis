-- ==============================================
-- 1. Overall Business Performance
-- ==============================================

-- Total orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Total unique customers
SELECT COUNT(DISTINCT customer_unique_id) AS total_customers
FROM customers;

-- Total revenue
SELECT SUM(price) AS total_revenue
FROM order_items;

-- ========================================
-- 2. Monthly Orders and Revenue Trend
-- ========================================

-- Monthly order volume
SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY month;

-- Monthly revenue
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY month;

-- Note: October 2018 does not appear in the revenue results because
-- the orders from this month without matching order_items were canceled.

-- ===============================
-- 3. Average Order Value
-- ===============================

SELECT
ROUND(SUM(price)/COUNT(DISTINCT order_id), 2) AS average_order_value
FROM order_items;

-- =======================================
-- 4. Top Product Categories by Revenue
-- =======================================

SELECT
    ct.product_category_name_english AS category,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;

-- ======================================
-- 5. Top sellers by revenue
-- ======================================

SELECT
    oi.seller_id,
    s.seller_city,
    s.seller_state,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN sellers s
    ON oi.seller_id = s.seller_id
GROUP BY
    oi.seller_id,
    s.seller_city,
    s.seller_state
ORDER BY total_revenue DESC
LIMIT 10;

-- ==========================================
-- 6. Customer distribution by state
-- ==========================================

SELECT 
customer_state AS state,
COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM customers
GROUP BY customer_state
ORDER BY unique_customers DESC;

-- ===========================================
-- 7. Revenue by Customer State
-- ===========================================

SELECT
c.customer_state as state,
ROUND(SUM(oi.price), 2) AS total_revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC;

-- ================================
-- 8. Most used Payment Methods
-- ================================

SELECT payment_type,
COUNT(DISTINCT order_id) AS total_orders
FROM payments
GROUP BY payment_type
ORDER BY total_orders DESC;

-- =====================================
-- 9. Payment Value by Payment Method
-- =====================================

SELECT
payment_type,
ROUND(SUM(payment_value), 2) AS total_payment_value
FROM payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;

-- =====================================
-- 10. Average Review Score
-- ===================================== 

SELECT 
ROUND(AVG(review_score), 2) AS average_review_score
FROM reviews;

-- =====================================
-- 11. Review Score Distribution
-- =====================================

SELECT 
review_score,
COUNT(*) AS total_reviews
FROM reviews
GROUP BY review_score
ORDER BY review_score;

-- ====================================
-- 12. Order Status Distribution
-- ====================================

SELECT
order_status,
COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;
