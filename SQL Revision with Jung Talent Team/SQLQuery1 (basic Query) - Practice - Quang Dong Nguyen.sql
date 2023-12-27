-------------------------------------------------
-- Home Assignment
-------------------------------------------------


----------------------------------
/*
-- Task 1: SELECT order_id, order_date, order_quantiy, value, profit with revenue and total cost from Order Table
- create a new column named 'revenue' where it equals order_quantity * unit_price * (1 - discount)
- create a new column named 'total_cost' where it equals product_base_margin * unit_price + shipping_cost
- create a new column named 'net_profit' where the formula is revenue - total_cost
*/
----------------------------------

WITH order_1 AS 
(SELECT *,
	(order_quantity * unit_price * (1 - discount)) AS revenue,
	(product_base_margin * unit_price + shipping_cost) AS total_cost
FROM Order_Lesson2)
SELECT order_id, order_date,order_quantity, value, profit, revenue, total_cost,
	(revenue - total_cost) AS net_profit FROM order_1;





----------------------------------
/*
-- Task 2: From the "Order" table. Create queries with the following conditions:
1. region is "West"
2. where "order_priority" does not include "Critical" 
3. where "order_priority" is "High" or "Low" or "Medium" or "Not Specified"
4. where "province" includes "New"
5. where "shipping_mode" does not include "Air" and "value" is smaller than 500.
6. where "product_category" starts with "Co"
7. where "customer_segment" ends with "e" and "order_quantity" is larger than 10.
*/
----------------------------------
SELECT * FROM Order_Lesson2
WHERE region LIKE 'West'

SELECT * FROM Order_Lesson2
WHERE order_priority NOT LIKE 'Critical';

SELECT * FROM Order_Lesson2
WHERE order_priority LIKE 'High' 
	OR order_priority LIKE 'LOW' 
	OR order_priority LIKE 'Medium' 
	OR order_priority LIKE 'Not Specified';

SELECT * FROM Order_Lesson2
WHERE province LIKE '%New%';

SELECT * FROM Order_Lesson2
WHERE shipping_mode NOT LIKE '%Air%' AND value < 500;

SELECT * FROM Order_Lesson2
WHERE product_subcategory LIKE 'Co%';

SELECT * FROM Order_Lesson2
WHERE customer_segment LIKE '%e' AND order_quantity > 10;


----------------------------------
/*
-- Final Task: Task3 write a query that returns top 10 customers of Nunavut province 
that brought back the most profit
*/
----------------------------------
SELECT TOP 10 province, customer_name, SUM(profit) AS total_profit
FROM Order_Lesson2
WHERE province LIKE 'Nunavut'
GROUP BY province, customer_name
ORDER BY total_profit DESC