--------------------------------------------------------------------
-- Practice Zone --
--------------------------------------------------------------------

-- LEFT JOIN -- 
SELECT *
FROM Order_Lesson2 o LEFT JOIN Returns_Lesson3 r ON o.order_id = r.order_id
WHERE r.status LIKE 'Returned';


-- INNER JOIN --
SELECT *
FROM Order_Lesson2 o INNER JOIN Returns_Lesson3 r ON o.order_id = r.order_id
WHERE r.status LIKE 'Returned';


-- RIGHT JOIN --

SELECT * 
FROM Order_Lesson2 o RIGHT JOIN Returns_Lesson3 r ON o.order_id = r.order_id
WHERE r.status LIKE 'Returned';


-- SELF JOIN --
-- Allow to join itself, Self-join is used to compare rows within the same table.
/*
SELECT
	o1.Province,
	o1.customer_name,
	o2.customer_name
FROM Order_Lesson2 o1 INNER JOIN Order_Lesson2 o2 ON o1.province = o2.province --We will learn inner join later
ORDER BY 
	o1.province, 
	o1.customer_name,
	o2.customer_name
*/



----------------------------------
/*
-- Task 2: Using 2 tables orders and profiles. 
Calculate total_order_quantity, total_value, total_profit of each manager.
*/
----------------------------------
SELECT 
	p.manager, 
	SUM(order_quantity) AS total_order_quantity,
	SUM(value) AS total_value, SUM(profit) AS total_profit
FROM Order_Lesson2 o LEFT JOIN Profiles_Lesson3 p ON o.province = p.province
GROUP BY p.manager; 



----------------------------------
/*
-- Task 4: Calculate the total_profit for each "order_priority" using UNION ALL.
*/
----------------------------------
SELECT 
	order_priority, 
	SUM(profit) AS total_profit
FROM Order_Lesson2
GROUP BY order_priority
-- Do the same as above but include where statement and put in the UNION ALl to the other query SELECT statement

SELECT
	order_priority,
	SUM(profit) AS total_profit
FROM Order_Lesson2
GROUP BY
	order_priority
UNION ALL
SELECT
	'Total' AS order_priority,
	SUM(profit) AS total_profit
FROM Order_Lesson2



----------------------------------
/*
--Task 5: Display total_profit based on each level including the total
*/
----------------------------------
SELECT order_priority, SUM(profit) As total_profit
FROM Order_Lesson2
GROUP BY order_priority
UNION ALL 
SELECT 'Total' AS order_priority, SUM(profit) AS Total_profit
FROM Order_Lesson2


