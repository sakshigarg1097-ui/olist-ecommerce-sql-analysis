# Olist E-commerce SQL Analysis

## Project Overview

This project analyzes the Olist Brazilian e-commerce dataset using MySQL.

The objective is to explore business performance and identify insights related to orders, revenue, customers, product categories, sellers, payment methods, reviews, and order status.

The project covers the complete SQL workflow:

- Database creation
- Table creation
- Data import
- Data validation
- Business analysis

## Tools Used

- MySQL
- MySQL Workbench
- SQL

## Dataset

The project uses the Olist Brazilian E-commerce Public Dataset.

The dataset contains information about customers, orders, order items, products, sellers, payments, reviews, and product category translations.

The raw dataset is not included in this repository. Users can download the dataset separately and update the file paths in the data import script before loading the data into MySQL.

## Data Validation & Quality Checks

Before analysis, the dataset was validated using SQL checks for:

- Row counts across all tables
- Primary key uniqueness
- NULL values in key columns
- Foreign key and relationship integrity
- Review score ranges
- Negative payment values and product prices
- Invalid payment installments
- Invalid delivery dates
- Invalid product measurements

A small data anomaly was identified in the payment data: 2 records had zero payment installments. The records were retained without modification.

## Business Questions

The analysis answers the following business questions:

1. What are the total orders, unique customers, and total revenue?
2. How do orders and revenue trend month by month?
3. What is the average order value?
4. Which product categories generate the most revenue?
5. Which sellers generate the most revenue?
6. Which states have the most customers?
7. Which customer states generate the most revenue?
8. Which payment methods are most commonly used?
9. How does payment value vary by payment method?
10. What is the average customer review score?
11. How are customer reviews distributed across the 1–5 scale?
12. What is the distribution of order statuses?

## Key Insights

- Health & Beauty was the highest-revenue product category.
- São Paulo (SP) had the largest customer base among Brazilian states.
- Credit card was the most commonly used payment method by number of orders.
- The average order value was approximately R$137.75.
- The average customer review score was approximately 4.09 out of 5.
- October 2018 did not appear in the monthly revenue results because the orders from that month without matching order items were canceled.

## Project Structure

```text
olist-ecommerce-sql-analysis/
│
├── README.md
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_import_data.sql
│   ├── 04_data_validation.sql
│   └── 05_analysis.sql
│
└── dataset/
    └── README.md