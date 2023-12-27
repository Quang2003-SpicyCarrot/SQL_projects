--------------------------------------
-- Practice Zone
--------------------------------------

-- String function ----------------
-- CHARINDEX()
--Problem: Find orders where the product name contains the word 'Chair'
SELECT * 
FROM Order_Lesson2
WHERE CHARINDEX('Chair', product_name) > 0;


-- CONCAT()
--Problem: Create a list of manager names and their corresponding provinces
SELECT CONCAT(m.manager_name, ' - ', p.province) AS manager_province
FROM Managers_Lesson4 m INNER JOIN Profiles_Lesson3 p ON m.manager_name = p.manager;


-- LEN()
--Problem: Find the length of customer names for orders with a low priority
SELECT o.customer_name, LEN(o.customer_name) AS customer_name_length
FROM Order_Lesson2 o
WHERE o.order_priority = 'Low';


-- LEFT()
--Problem: Extract the first 5 characters of manager names.
SELECT o.customer_name, LEFT(o.customer_name, 5) AS First_5_char_name
FROM Order_Lesson2 o


-- PATINDEX()
--Problem: Find orders where the product name starts with "Eldon".
SELECT *
FROM Order_Lesson2 o
WHERE PATINDEX('Eldon%', product_name) > 0;
--with PATINDEX we could do this to return the relative position of the name specified by PATINDEX
SELECT PATINDEX('Eldon%',product_name), product_name
FROM Order_Lesson2;

SELECT *
FROM Order_Lesson2 o
WHERE product_name LIKE 'Eldon%'; 


--REPLACE():
--Problem: Remove spaces character from shipping_mode in table "Order".
SELECT REPLACE(shipping_mode, ' ', '') FROM Order_Lesson2;


--UPPER():
--Problem: Convert customer names to uppercase.
SELECT UPPER(customer_name) AS u_customer_name FROM Order_Lesson2;


-- REVERSE():
--Problem: Reverse the order of characters in the manager names
SELECT manager_name, UPPER(LEFT(REVERSE(manager_name), 1)) + LOWER(RIGHT(manager_name, LEN(manager_name) - 1)) AS modified_reversed_name
FROM Managers_Lesson4



-- Date Functions ------------------
--Problem: Retrieve the current timestamp
-- GETDATE():
SELECT GETDATE() AS current_datetime;


--DATEADD():
--Problem: Add 7 days to the order date for all orders
SELECT order_id, order_date, DATEADD(DAY, 7, order_date) AS new_order_date
FROM Order_Lesson2;


--DATEDIFF():
--Problem: Calculate the number of days between the order date and the shipping date for each order.
SELECT order_id, DATEDIFF(DAY, order_date, shipping_date) AS duration
FROM Order_Lesson2;


--DATEFROMPARTS()
--Problem: Create a date value for May 1, 2023.
SELECT DATEFROMPARTS(2023, 5, 1) AS custom_date;

--DATEPART(): extract year from the order_date from all orders
--Problem: Extract the year from the order date for all orders
SELECT order_id, DATEPART(YEAR, order_date) AS order_year
FROM Order_Lesson2;


--DAY(): 
--Problem: Extract the day of the month from the returned date for returned orders
SELECT order_id, DAY(returned_date) AS return_day_of_month 
FROM Returns_Lesson3;


-- Convert Functions -------------------------
--CAST(): 
--Problem: Convert the order_quantity column to a decimal
SELECT order_id, CAST(order_quantity AS decimal(10,2)) AS order_quantity_decimal
FROM Order_Lesson2;

--CONVERT():
--Problem: Convert the order_date column to a different date format (e.g. 'YYYY - MM - D')
SELECT order_id, CONVERT(varchar(10), order_date, 120) AS formatted_order_Date
FROM Order_Lesson2; --You can check for CONVERT values for dates data types and other data types

--STR():
--Problem: Convert the profit column to a string with a specific format
SELECT order_id, STR(profit, 10, 3) AS formatted_profit
FROM Order_Lesson2; --Again you can check for STR values for string data types and other data types



--ISNULL(): Replace NULL Vales in the customer_segment column with 'Unknown'
--Problem: Replace NULL values in the customer_segment column with "Unknown"
SELECT order_id, ISNULL(customer_segment, 'Unknown') AS segment
FROM Order_Lesson2;


--ISNUMERIC(): Check if the unit_price column contains numeric values
--Problem: Check if the unit_price column contains numeric values
SELECT
	order_id, 
	unit_price,
	CASE WHEN ISNUMERIC(unit_price) = 1 THEN 'Numeric' ELSE 'Not Numeric' END AS numeric_check --we must have one END statement for every CASE statement
FROM Order_lesson2;


--CASE WHEN -----------------------
/*
Problem: Count how many "Low", "Medium", and "High" value in Orders table in 'value' column
1. if 'value' column in Orders table >= 3000: High
2. if 'value' column in Orders table <= 3000 and >= 1000: Medium
3. if 'value' column in Orders table <= 1000: Low
*/
-----------------------------------

SELECT 
	CASE
		WHEN value >= 3000 THEN 'High'
		WHEN value >= 1000 AND value < 3000 THEN 'Medium'
		WHEN value < 1000 THEN 'Low'
		END AS value_category,
	COUNT(*) AS count_value
FROM Order_Lesson2
GROUP BY --we could use Group By with CASE in this case. 
	CASE
		WHEN value >= 3000 THEN 'High'
		WHEN value >= 1000 AND value < 3000 THEN 'Medium'
		WHEN value < 1000 THEN 'Low'
		END
ORDER BY value_category;
		