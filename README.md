# Retail Sales Analysis & Exploratory Data Analysis (SQL)

## 📌 Project Overview
This project demonstrates my ability to clean, explore, and analyze retail transaction data using complex SQL queries. Working with a dataset of 2,000+ rows, I structured a relational database schema, tackled missing data, and extracted high-level business insights to evaluate performance across product categories, shifting demographics, and transaction values.

## 📊 Core Business Insights & Analytical Logic
Unlike standard tutorials, this analysis focuses heavily on tracking efficiency and profitability metrics:
* *Profitability Mapping:* Evaluated *COGS (Cost of Goods Sold)* against total_sale to determine the exact gross profit margins across individual transactions (e.g., identifying high-margin $1,116 clothing orders versus low-margin variations).
* *Aggregation Modeling:* Handled data segmentation using GROUP BY optimization to analyze total volume, aggregate orders, and net sales without breaking query efficiency.

---

## 🛠️ Database Schema & Architecture

The database environment is built on *PostgreSQL* utilizing a single core table: retail_sales.

```sql
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
