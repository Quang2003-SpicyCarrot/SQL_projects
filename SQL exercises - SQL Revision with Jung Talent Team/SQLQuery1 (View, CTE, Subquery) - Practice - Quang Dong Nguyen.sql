--------------------------------------
-- Practice Zone
--------------------------------------
-- Subquery SQL: Query is also called INNER QUERY/ INNER SELECT
-- Main query is called OUTER QUERY/ OUTER SELECT
SELECT 
	order_id,
	order_quantity,
	product_name
FROM Order_Lesson2
WHERE order_quantity > (SELECT AVG(order_quantity) FROM Order_Lesson2);



-- CTE - Common Table Expression: that keeps your code organised, allow multi-level aggregations on data.
-- CTE is used for recursive query, replacing view
WITH Engineers AS (
	SELECT *
	FROM Order_Lesson2
	WHERE order_quantity = 10)
SELECT * FROM Engineers WHERE order_priority LIKE 'Not Specified';

--Another  Example
WITH PivotOrders_CTE (order_id, Total_quantity, Total_value) AS (
	SELECT 
		order_id,
		SUM(order_quantity) AS Total_quantity,
		SUM(value) AS Total_value
	FROM Order_Lesson2
	GROUP BY order_id)
SELECT 
	order_id, 
	Total_quantity, 
	Total_value
FROM PivotOrders_CTE
WHERE Total_quantity > 100
ORDER BY Total_quantity DESC;



-- TEMPorary TABLE: when full access is not granted to person, we use Temp table
drop TABLE #temptable1;
CREATE TABLE #temptable1 (
id INT IDENTITY PRIMARY KEY NOT NULL,
Name VARCHAR(10) NOT NULL,
DOB DATETIME NULL)
GO

INSERT INTO #temptable1 VALUES ('TONA', GETDATE())
GO

SELECT * FROM #temptable1


---------------------------------------------
/*
-- TASK 1: From Order and Return table, create a query that includes:
- Year
- Month
- Total orders
- Total returned orders
-> Use both Subquery and CTE.
*/
---------------------------------------------
SELECT * FROM Order_Lesson2;
SELECT * FROM Returns_Lesson3;

WITH a AS (
	SELECT 
		YEAR(order_date) AS year,
		MONTH(order_date) AS month,
		COUNT(DISTINCT order_id) AS total_orders
	FROM Order_Lesson2
	GROUP BY 
		YEAR(order_date),
		MONTH(order_date)),
	b AS (
	SELECT
		YEAR(returned_date) AS year,
		MONTH(returned_date) AS month,
		COUNT(order_ID) as total_returns
	FROM Returns_Lesson3
	GROUP BY
		YEAR(returned_date),
		MONTH(returned_date))
SELECT a.year, b.month, a.total_orders, b.total_returns
FROM a LEFT JOIN b ON a.year = b.year AND a.month = b.month
ORDER BY a.year, b.month;


---------------------------------------------
/*
-- Task 2: From Orders and Returns, creat a query that includes:
1. Year
2. Month
3. Product_category
4. Total value
5. Total value of returned orders 
*/
---------------------------------------------
WITH a AS (
	SELECT
		YEAR(order_date) AS year,
		MONTH(order_date) AS month,
		product_category,
		SUM(value) AS total_value
	FROM Order_Lesson2
	GROUP BY
		YEAR(order_date),
		MONTH(order_date),
		product_category),
	b AS (
	SELECT
		YEAR(returned_date) AS year,
		MONTH(returned_date) AS month,
		product_category,
		SUM(value) AS total_value_return
	FROM Returns_Lesson3 r INNER JOIN Order_Lesson2 o ON r.order_id = o.order_id
	GROUP BY
		YEAR(returned_date),
		MONTH(returned_date),
		product_category)
SELECT a.year, a.month, a.product_category, a.total_value, b.total_value_return
FROM a LEFT JOIN b ON a.year = b.year AND a.month = b.month AND a.product_category = b.product_category
ORDER BY a.year, b.month;


---------------------------------------------
/*
-- TASK 3: From given tables, query all orders from the year 2012 (2012-01-01 to 2012-12-31), which includes:
1. manager name
2. manager level
3. manager id
4. number of items (total number of items, not including returned orders)
5. total quantity (total quantity of products sold, not including returned orders)
6. total value
7. total profit
*/
---------------------------------------------
-- Manager (id, name) -> Profiles (manager, province, region) -> Order (province, region, order_id) -> Returns (order_id)
WITH a AS (
	SELECT 
		o.order_id, o.order_date, o.order_quantity, o.value, o.profit, 
		p.province, p.region, r.status, 
		m.manager_name,m.manager_id, m.manager_level
	FROM
	(((Order_Lesson2 o LEFT JOIN Returns_Lesson3 r ON o.order_id = r.order_id)
	LEFT JOIN Profiles_Lesson3 p ON o.province = p.province AND o.region = p.region)
	LEFT JOIN Managers_Lesson4 m ON p.manager = m.manager_name)
	WHERE o.order_date BETWEEN '2012-01-01' AND '2012-12-31')
SELECT
	a.manager_name, a.manager_level, a.manager_id,
	COUNT(a.order_id) AS number_items,
	SUM(a.order_quantity) AS total_quantity,
	SUM(a.value) AS total_value,
	SUM(a.profit) AS total_profit
FROM a
WHERE a.status IS NULL
GROUP BY
	a.manager_name,
	a.manager_id,
	a.manager_level;