# 🛒 Zepto Retail Product Analytics (SQL-Only Project)

Welcome to my SQL-based analytics project using product data from Zepto, one of India's fastest-growing quick-commerce startups. This project answers **key business questions** using only **SQL** — no BI tools, no dashboards — just raw data and powerful queries.

## 🔍 Objective

- Extract key insights about product performance
- Segment products by profitability, discount, and stock availability
- Use SQL analytics functions like `ROW_NUMBER()`, `CASE`, and `CTEs`

## 🧠 Skills Demonstrated

- Joins, Aggregation, Filtering
- Conditional Logic with `CASE WHEN`
- Window Functions (`RANK()`, `ROW_NUMBER()`)
- Common Table Expressions (CTEs)
- Business-oriented SQL analysis

## 📂 Files

- `zepto_queries.sql` → All SQL queries
- `business_insights.md` → Key business insights from the data
- `domain_knowledge.md` → Domain context and use-case mapping
- `zepto_v2.csv` → Original dataset

## 🧾 Sample Insights from SQL

- 🎯 **Top-selling products** by quantity
- 💸 **Revenue loss** from products with 0% discounts
- ❌ **1169 zero-profit products** found (same MRP and selling price)
- 📉 Identification of **low margin high MRP products**
- 🏷 **Discount segmentation**: Low, Medium, High
- ⚠️ Highlighted **stockouts causing revenue leakage**

## 🛠 Tools Used

- MySQL / PostgreSQL (works on both)
- Local CSV import using `LOAD DATA INFILE` or via SQL GUI

## 📈 Why This Project Matters

This project simulates how **real-world e-commerce analysts** at companies like Zepto, Blinkit, or BigBasket use SQL to drive business insights daily. No dashboards — just SQL mastery.

