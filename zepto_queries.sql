##Zepto_queries.sql
-- 📦 Total number of orders (rows)
SELECT COUNT(*) AS total_orders FROM zepto_v2;

-- 🔝 Top-selling products by quantity
SELECT name, SUM(quantity) AS total_quantity
FROM zepto_v2
GROUP BY name
ORDER BY total_quantity DESC
LIMIT 3;

-- 💸 Top MRP products by category
SELECT category, MAX(mrp) AS max_mrp
FROM zepto_v2
GROUP BY category
ORDER BY max_mrp DESC
LIMIT 3;

-- 🔖 High Discounted Products (>30%)
SELECT DISTINCT category, name, discountPercent
FROM zepto_v2
WHERE discountPercent > 30
ORDER BY discountPercent DESC;

-- 📦 Count of products in each category (with > 100 products)
SELECT category, COUNT(*) AS num_products
FROM zepto_v2
GROUP BY category
HAVING COUNT(*) > 100;

-- 💰 Top Profitable Products by Category
SELECT DISTINCT (mrp - discountedSellingPrice) AS Profit, category, name
FROM zepto_v2
ORDER BY Profit DESC
LIMIT 4;

-- 🏷 Discount Category Segmentation
SELECT category, name, discountPercent,
  CASE  
    WHEN discountPercent < 10 THEN 'Low Discount'
    WHEN discountPercent BETWEEN 10 AND 29 THEN 'Medium Discount'
    ELSE 'High Discount'
  END AS discount_category
FROM zepto_v2;

-- 📊 Revenue Estimation (CTE + Window Function)
WITH revenue_cte AS (
  SELECT name, category, mrp,
         (availableQuantity * discountedSellingPrice) AS estimated_revenue
  FROM zepto_v2
  WHERE outOfStock = FALSE
)
SELECT *, ROW_NUMBER() OVER(PARTITION BY mrp ORDER BY estimated_revenue DESC) AS rnk
FROM revenue_cte;

-- ❌ Zero Discounted Products
SELECT category, name, discountedSellingPrice
FROM zepto_v2
WHERE discountPercent = 0;

-- 💯 Over 80% Discount
SELECT *
FROM zepto_v2
WHERE discountPercent > 80;

-- ⚠️ Flagging Low Margin Expensive Products
SELECT name, category, mrp, discountedSellingPrice,
       (mrp - discountedSellingPrice) AS profit_per_unit,
       CASE
         WHEN mrp > 5000 AND (mrp - discountedSellingPrice) < 500 THEN 'Low Margin Warning'
         ELSE 'OK'
       END AS flag
FROM zepto_v2
ORDER BY mrp DESC;

-- 📉 Weighted Average Discount by Category
SELECT category,
       ROUND(SUM(discountPercent * availableQuantity) / SUM(availableQuantity), 2) AS weighted_avg_discount
FROM zepto_v2
GROUP BY category
ORDER BY weighted_avg_discount DESC;

-- 📌 Count of High-MRP Products
SELECT COUNT(*) AS items_over_5000
FROM zepto_v2
WHERE mrp > 5000;

-- 💸 Products with 0 or Negative Profit
SELECT category, name, (mrp - discountedSellingPrice) AS profit
FROM zepto_v2
WHERE (mrp - discountedSellingPrice) < 1;

-- 🚨 Count of Zero-Profit Products by Category
SELECT category, COUNT(*) AS zero_profit_count
FROM zepto_v2
WHERE mrp = discountedSellingPrice
GROUP BY category
ORDER BY zero_profit_count DESC;

-- 📊 Average Discount by Category
SELECT category, ROUND(AVG(discountPercent), 2) AS avg_discount
FROM zepto_v2
GROUP BY category
ORDER BY avg_discount DESC;

-- ✅ Profit Status Segmentation
SELECT 
  CASE
    WHEN mrp = discountedSellingPrice THEN 'Zero Profit'
    WHEN mrp > discountedSellingPrice THEN 'Profitable'
    ELSE 'Negative Profit'
  END AS profit_status,
  COUNT(*) AS product_count
FROM zepto_v2
GROUP BY profit_status;

-- 💼 Highest Stock Value Products (no discount)
SELECT name, category, availableQuantity, discountedSellingPrice,
       (availableQuantity * discountedSellingPrice) AS stock_value
FROM zepto_v2
WHERE mrp = discountedSellingPrice
ORDER BY stock_value DESC
LIMIT 5;

-- 🔻 Out-of-Stock Products That Lost Revenue
SELECT category, name, (availableQuantity * discountedSellingPrice) AS estimated_revenue
FROM zepto_v2
WHERE outOfStock = TRUE
ORDER BY estimated_revenue DESC
LIMIT 3;

-- 🔁 Products in Multiple Categories
SELECT name, COUNT(*) AS num_rows, COUNT(DISTINCT category) AS category_count
FROM zepto_v2
GROUP BY name
HAVING category_count > 1;

-- 🏆 Product Ranking by MRP in Category
SELECT DISTINCT mrp, name, category,
       RANK() OVER(PARTITION BY category ORDER BY mrp DESC) AS rnk
FROM zepto_v2;
