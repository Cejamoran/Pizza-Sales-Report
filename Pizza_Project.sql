-- Create and select the database
CREATE DATABASE PizzaDB;
USE PizzaDB;

-- Inspect the pizza table
SHOW COLUMNS FROM pizza;
SELECT * FROM pizza;

-- Clean and format date and time columns
-- (Choose the correct date format based on your data source)
UPDATE pizza
SET order_date = STR_TO_DATE(order_date, '%m/%d/%Y');

-- Modify column types
ALTER TABLE pizza
MODIFY COLUMN order_date DATE,
MODIFY COLUMN order_time TIME;

-- Add primary key
ALTER TABLE pizza
ADD PRIMARY KEY (pizza_id);

-- ===========================
-- Sales and Order Analysis
-- ===========================

-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue
FROM pizza;

-- Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM pizza;

-- Total Number of Pizzas Sold
SELECT SUM(quantity) AS Total_Of_Pizzas
FROM pizza;

-- Total Number of Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza;

-- Average Pizzas per Order
SELECT SUM(quantity) / COUNT(DISTINCT order_id) AS Avg_Pizzas_Per_Order
FROM pizza;

-- ===========================
-- Time-Based Trends
-- ===========================

-- Daily Order Trend
SELECT DAYNAME(order_date) AS Order_Day,
       COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza
GROUP BY Order_Day
ORDER BY Total_Orders DESC;

-- Monthly Order Trend
SELECT MONTHNAME(order_date) AS Order_Month,
       COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza
GROUP BY Order_Month
ORDER BY Total_Orders DESC;

-- ===========================
--  Category and Size Insights
-- ===========================

-- Percentage of Sales by Pizza Category (January)
SELECT pizza_category,
       SUM(total_price) AS Total_Price,
       SUM(total_price) * 100 / (
           SELECT SUM(total_price)
           FROM pizza
           WHERE MONTHNAME(order_date) = 'January'
       ) AS Percentage_Of_Sales
FROM pizza
WHERE MONTHNAME(order_date) = 'January'
GROUP BY pizza_category
ORDER BY Percentage_Of_Sales DESC;

-- Percentage of Sales by Pizza Size (January)
SELECT pizza_size,
       SUM(total_price) AS Total_Price,
       SUM(total_price) * 100 / (
           SELECT SUM(total_price)
           FROM pizza
           WHERE MONTHNAME(order_date) = 'January'
       ) AS Percentage_Of_Sales
FROM pizza
WHERE MONTHNAME(order_date) = 'January'
GROUP BY pizza_size
ORDER BY Percentage_Of_Sales DESC;

-- ===========================
--  Top Performers
-- ===========================

-- Top 5 Pizzas by Revenue
SELECT pizza_name,
       SUM(total_price) AS Total_Revenue
FROM pizza
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;

-- Top 5 Pizzas by Quantity
SELECT pizza_name,
       SUM(quantity) AS Total_Quantity
FROM pizza
GROUP BY pizza_name
ORDER BY Total_Quantity DESC
LIMIT 5;