-------------------------------------------------
-- Practice Zone
-------------------------------------------------
-- Pivot Table
SELECT --2nd to query
	Customer_name,
	"Office Supplies",
	"Furniture",
	"Technology"
FROM ( --1st to query 
	SELECT
		Customer_name, 
		product_category, 
		profit 
	FROM Order_Lesson2) AS PivotData
PIVOT( -- 3rd to query -- Convert rows into columns
	SUM(Profit)
	FOR product_category IN ("Office Supplies", "Furniture", "Technology")) AS PivotTable;




-- RANKING Topic: ----------------
--ROW_NUMBER(), RANK(), DENSE_RANK()
SELECT
	Customer_name,
	order_id,
	Order_Date,
	ROW_NUMBER() OVER (ORDER BY Order_Date ASC) AS ROW_NUMBER, -- ranking rows based on row number.
	-- ROW_NUMBER() OVER ([PARTITION BY Columns] ORDER BY Column ASC|DESC) AS Row_num
	RANK() OVER (ORDER BY Order_Date ASC) AS RANK, --ranking rows based on current row number and previous ranking of record.
	-- RANK() OVER ([PARTITION BY Columns] ORDER BY Column ASC|DESC) AS rank_col
	DENSE_RANK() OVER (ORDER BY Order_Date ASC) AS DENSE_RANK --ranking rows consecutively based on previous ranking of record.
	-- DENSE_RANK() OVER ([PARTITION BY Columns] ORDER BY Column ASC|DESC) AS dense_rank_col
FROM Order_Lesson2
WHERE Customer_name = 'Tamara Chand';


--DENSE_RANK()
SELECT
	province,
	order_id,
	profit,
	DENSE_RANK() OVER (PARTITION BY province ORDER BY profit ASC) AS dense_rank_col 
	--Partition is like Aggregation, where you aggregate columns, ORDER BY these columns and RANK based on aggregated values.
	FROM Order_Lesson2;


--RANK()
SELECT
	province,
	order_id,
	profit,
	RANK() OVER (PARTITION BY province ORDER BY profit ASC) AS rank_col
FROM Order_Lesson2;



-------------------------------------
/*
Question 1: Query all the order_ids that have profits ranked highest to lowest by each province.
- Use DENSE_RANK() to rank
Answer includes: province, order_id, profit, dense_rank_column
*/
-------------------------------------
SELECT
	province,
	order_id,
	profit,
	DENSE_RANK() OVER (PARTITION BY province ORDER BY profit DESC) AS dense_rank_col
FROM Order_Lesson2
ORDER BY 
	dense_rank_col ASC;


-------------------------------------
/*
Question 2: Query the top 3 products that produce the highest profit by each province.
- Use ROW_NUMBER() to rank
Answer should include: province, product_category, total_profit, row_num_column
*/
-------------------------------------
SELECT 
	province,
	product_category,
	SUM(profit) AS total_profit,
	ROW_NUMBER() OVER (PARTITION BY province ORDER BY SUM(profit) DESC) AS row_num
FROM Order_Lesson2
GROUP BY
	province,
	product_category
ORDER BY
	province ASC,
	row_num ASC;




----------------------------------------------------------
-- Homework
----------------------------------------------------------

-------------------------------------
/*
Question 1: Use the PivotTable method, calculate the total_value gained by each province from each product_category.
Answer should include: province, "Office Supplies", "Furniture", "Technology"
*/
-------------------------------------

SELECT * FROM Order_Lesson2;
SELECT
	province,
	"Office Supplies" AS Total_value_Office_Supplies,
	"Furniture" AS Total_value_Furniture,
	"Technology" AS Total_value_Technology
FROM (
	SELECT
		province,
		product_category,
		value
	FROM Order_Lesson2) AS PivotData
PIVOT (
	SUM(value)
	FOR product_category IN ("Office Supplies", "Furniture", "Technology")) AS PivotTable;



-------------------------------------
/*
Question 2: List the top 3 products that produce the lowest total_profit by each product_category.
Use ROW_NUMBER()
Answer sholuld include: product_category, product_name, total_profit, row_num
*/
-------------------------------------
SELECT * FROM Order_Lesson2;

SELECT * FROM (
	SELECT
		product_category,
		product_name,
		SUM(profit) AS total_profit,
		ROW_NUMBER() OVER (PARTITION BY product_category ORDER BY SUM(profit) ASC) AS row_num
	FROM Order_Lesson2
	GROUP BY
		product_category,
		product_name) AS tab1
WHERE row_num <= 3;



-------------------------------------
/*
-- Question 3: Use DENSE_RANK(), Identify the product_name ranked third highest by each province.
Answer should include: province, product_name, total_profit, denseRank column
*/
-------------------------------------
SELECT * FROM (
	SELECT
		province,
		product_name,
		SUM(profit) AS total_profit,
		DENSE_RANK() OVER (PARTITION BY province ORDER BY SUM(profit) DESC) AS denseRank
	FROM Order_Lesson2
	GROUP BY
		province,
		product_name) AS tab1
WHERE denseRank = 3;



-------------------------------------
/*
-- Question 4: Use RANK(), Identify the product_names ranked third (lowest) by each province.
Use RANK()
Answer should include: province, product_name, total_profit, Rank column.
*/
-------------------------------------
SELECT * FROM (
	SELECT
		province,
		product_name,
		SUM(profit) AS total_profit,
		DENSE_RANK() OVER (PARTITION BY province ORDER BY SUM(profit) ASC) AS Rankk
	FROM Order_Lesson2
	GROUP BY
		province,
		product_name) AS tab1
WHERE Rankk = 3