
SELECT * FROM sales;
SELECT * FROM customer;
SELECT * FROM [segment scores];

-- -- -- -- -- -- -- RFM Calculate -- -- -- -- -- -- -- 
WITH RFM_Base 
AS
(
  SELECT b.Customer_Name AS CustomerName,
    DATEDIFF(DAY, MAX(a.Order_Date), '2015-12-31') AS Recency_Value,
    COUNT(DISTINCT a.Order_Date) AS Frequency_Value,
    ROUND(SUM(a.Sales), 2) AS Monetary_Value
  FROM sales AS a
  INNER JOIN customer AS b ON a.Customer_ID = b.Customer_ID
  WHERE Year(Order_Date) = 2015
  GROUP BY b.Customer_Name
)
-- SELECT * FROM RFM_Base
, RFM_Score 
AS
(
  SELECT *,
    NTILE(5) OVER (ORDER BY Recency_Value DESC) as R_Score,
    NTILE(5) OVER (ORDER BY Frequency_Value ASC) as F_Score,
    NTILE(5) OVER (ORDER BY Monetary_Value ASC) as M_Score
  FROM RFM_Base
)
--SELECT * FROM RFM_Score

, RFM_Final
AS
(
SELECT *,
  CONCAT(R_Score, F_Score, M_Score) as RFM_Overall
  -- , (R_Score + F_Score + M_Score) as RFM_Overall1
  -- , CAST(R_Score AS char(1))+CAST(F_Score AS char(1))+CAST(M_Score AS char(1)) as RFM_Overall2
FROM RFM_Score
)
--SELECT * FROM RFM_Final

SELECT f.*, s.Segment
FROM RFM_Final f
JOIN [segment scores] s ON f.RFM_Overall = s.Scores
; 
-- -- -- -- -- -- -- Done -- -- -- -- -- -- -- 
