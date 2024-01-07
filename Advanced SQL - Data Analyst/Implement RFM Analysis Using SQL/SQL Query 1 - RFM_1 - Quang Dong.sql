SELECT * FROM sales;
SELECT * FROM customer;
SELECT * FROM [segment scores];
------------------------------------------------
--------------------------------------------------------------
-- RFM CACULATION
--------------------------------------------------------------

--ALTER TABLE sales ALTER COLUMN Sales FLOAT

WITH RFM_Base AS 
(
	SELECT
		b.[Customer Name] AS CustomerName,
		DATEDIFF(DAY, MAX(a.[Order Date]), '2015-12-31') AS Recency_Value,
		COUNT(DISTINCT a.[Order Date]) AS Frequency_Value,
		ROUND(SUM(a.sales),2) AS Monetary_Value
	FROM sales a INNER JOIN customer b ON a.[Customer ID] = b.[Customer ID]
	WHERE YEAR([Order Date]) = 2015
	GROUP BY b.[Customer Name]
),
RFM_Score AS 
(
	SELECT *,
		NTILE(5) OVER (ORDER BY Recency_Value DESC) AS R_Score,
		NTILE(5) OVER (ORDER BY Frequency_Value ASC) AS F_Score, 
		NTILE(5) OVER (ORDER BY Monetary_Value ASC) AS M_Score
	FROM RFM_Base
),
RFM_Final AS 
(
	SELECT *,
		CONCAT(R_Score, F_Score, M_Score) AS RFM_Overall
	FROM RFM_Score
)

---------------------------------------------------------------------
SELECT
	f.*,
	s.Segment
FROM RFM_Final f JOIN [segment scores] s ON f.RFM_Overall = s.Scores;