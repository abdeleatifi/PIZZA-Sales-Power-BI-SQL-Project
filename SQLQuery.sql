SELECT *
FROM [dbo].[pizza_sales];

---Total revenue
SELECT SUM(total_price) AS total_revenue 
FROM pizza_sales;
= 817860.05083847

---Average order value
SELECT SUM(total_price) / 
	COUNT(DISTINCT order_id) AS Average_order_value
FROM pizza_sales;
= 38.3072623343546

---Total pizzas sold
SELECT SUM(quantity) AS Total_pizzas_sold
FROM pizza_sales;
= 49574

---Total number of orders placed
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;
= 21350

---Average Pizzas per Order
SELECT CAST(SUM(quantity) AS FLOAT) / 
	COUNT(DISTINCT order_id) AS avg_pizza_per_order
FROM pizza_sales;
= 2.32196721311475

---Daily total orders
SELECT DATENAME(WEEKDAY, order_date) AS day_name, 
	COUNT(DISTINCT order_id) AS number_of_orders
FROM pizza_sales
GROUP BY DATENAME(WEEKDAY, order_date)
ORDER BY number_of_orders DESC;

---Monthly total orders
SELECT DATENAME(MONTH, order_date) AS month_name, 
	COUNT(DISTINCT order_id) AS number_of_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY number_of_orders DESC;

---Sales rate by pizza category
SELECT pizza_category,
	SUM(quantity) AS total_sales,
	CAST(SUM(quantity) AS FLOAT) * 100 / 
	(SELECT SUM(quantity) 
	FROM pizza_sales
	WHERE MONTH(order_date) = 12) AS sales_rate
FROM pizza_sales
WHERE MONTH(order_date) = 12
GROUP BY pizza_category;

---revenue rate by pizza category
SELECT pizza_category,
	SUM(total_price) AS total_price,
	CAST(SUM(total_price) AS FLOAT) * 100 / 
	(SELECT SUM(total_price) 
	FROM pizza_sales
	WHERE MONTH(order_date) = 1) AS revenue_rate
FROM [dbo].[pizza_sales]
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

---revenue by Pizza size
SELECT pizza_size,
	CAST(SUM(total_price) AS DECIMAL(10, 2)) AS total_price,
	CAST(SUM(total_price) * 100 / 
	(SELECT SUM(total_price) 
	FROM pizza_sales) AS DECIMAL(10, 2)) AS revenue_rate
FROM [dbo].[pizza_sales]
GROUP BY pizza_size
ORDER BY total_price DESC;

---best selling pizzas by total_revenue
SELECT TOP 5 pizza_name, 
	SUM(total_price) AS total_revenue, 
	SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC;

---least selling pizzas by total_revenue
SELECT TOP 5 pizza_name, 
	SUM(total_price) AS total_revenue, 
	SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC;