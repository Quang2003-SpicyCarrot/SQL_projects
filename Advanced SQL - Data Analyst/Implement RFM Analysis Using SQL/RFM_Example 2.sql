select   h.*,
    ntile(5) over (order by recency) as n_tile_recency,
    percentile_disc(0.2) within group (order by recency) over () as percent_20_recency,
    percentile_disc(0.4) within group (order by recency) over () as percent_40_recency,
    percentile_disc(0.6) within group (order by recency) over () as percent_60_recency,
    percentile_disc(0.8) within group (order by recency) over () as percent_80_recency,

	ntile(5) over (order by frequency) as n_tile_frequency,
	percentile_disc(0.2) within group (order by frequency) over () as percent_20_frequency,
    percentile_disc(0.4) within group (order by frequency) over () as percent_40_frequency,
    percentile_disc(0.6) within group (order by frequency) over () as percent_60_frequency,
    percentile_disc(0.8) within group (order by frequency) over () as percent_80_frequency,

	ntile(5) over (order by monetary) as n_tile_monetary,
	percentile_disc(0.2) within group (order by monetary) over () as percent_20_monetary,
    percentile_disc(0.4) within group (order by monetary) over () as percent_40_monetary,
    percentile_disc(0.6) within group (order by monetary) over () as percent_60_monetary,
    percentile_disc(0.8) within group (order by monetary) over () as percent_80_monetary
--into RFM_RawData
from (select customerid,
			datediff(day, max(orderdate), '2014-01-01') recency,
			datediff(day, min(orderdate), '2014-01-01') / count(*) frequency,
			sum(subtotal) / count(*) monetary
      from sales.salesorderheader
      where year(orderdate) = 2013
      group by customerid) as h
;
-- declare variables for recency
declare @percentile_20_r decimal(10, 2);
declare @percentile_40_r decimal(10, 2);
declare @percentile_60_r decimal(10, 2);
declare @percentile_80_r decimal(10, 2);

-- declare variables for frequency
declare @percentile_20_f decimal(10, 2);
declare @percentile_40_f decimal(10, 2);
declare @percentile_60_f decimal(10, 2);
declare @percentile_80_f decimal(10, 2);

-- declare variables for monetary
declare @percentile_20_m decimal(10, 2);
declare @percentile_40_m decimal(10, 2);
declare @percentile_60_m decimal(10, 2);
declare @percentile_80_m decimal(10, 2);

select 
    @percentile_20_r = max(percent_20_recency),
    @percentile_40_r = max(percent_40_recency),
    @percentile_60_r = max(percent_60_recency),
    @percentile_80_r = max(percent_80_recency),
    
	@percentile_20_f = max(percent_20_frequency),
    @percentile_40_f = max(percent_40_frequency),
    @percentile_60_f = max(percent_60_frequency),
    @percentile_80_f = max(percent_80_frequency),

	@percentile_20_m = max(percent_20_monetary),
    @percentile_40_m = max(percent_40_monetary),
    @percentile_60_m = max(percent_60_monetary),
    @percentile_80_m = max(percent_80_monetary)

from 
    RFM_RawData;

-- Output the results or use the variables as needed
select 
    @percentile_20_r as percentile_20_recency,
    @percentile_40_r as percentile_40_recency,
    @percentile_60_r as percentile_60_recency,
    @percentile_80_r as percentile_80_recency,

	@percentile_20_f as percentile_20_frequency,
    @percentile_40_f as percentile_40_frequency,
    @percentile_60_f as percentile_60_frequency,
    @percentile_80_f as percentile_80_frequency,
	
	@percentile_20_m as percentile_20_monetary,
    @percentile_40_m as percentile_40_monetary,
    @percentile_60_m as percentile_60_monetary,
    @percentile_80_m as percentile_80_monetary
	;

select rb * 100 + fb * 10 + mb as rfm
, count(*) as Num_Cust --Or CustomerID
from (
	select customerid,
		(case	when recency <= @percentile_20_r then 1 
				when recency > @percentile_20_r and recency <= @percentile_40_r then 2
				when recency > @percentile_40_r and recency <= @percentile_60_r then 3 
				when recency > @percentile_60_r and recency <= @percentile_80_r then 4
              else 5 end) as rb
         ,(case	when frequency <= @percentile_20_f then 1 
				when frequency > @percentile_20_f and frequency <= @percentile_40_f then 2
				when frequency > @percentile_40_f and frequency <= @percentile_60_f then 3 
				when frequency > @percentile_60_f and frequency <= @percentile_80_f then 4
              else 5 end) as fb,
         (case	when monetary <= @percentile_20_m then 1 
				when monetary > @percentile_20_m and monetary <= @percentile_40_m then 2
				when monetary > @percentile_40_m and monetary <= @percentile_60_m then 3 
				when monetary > @percentile_60_m and monetary <= @percentile_80_m then 4
              else 5 end) as mb
from (select customerid,
			datediff(day, max(orderdate), '2014-01-01') recency,
			datediff(day, min(orderdate), '2014-01-01') / count(*) frequency,
			sum(subtotal) / count(*) monetary
      from sales.salesorderheader
      where year(orderdate) = 2013
      group by customerid) a 
	) b
group by rb * 100 + fb * 10 + mb
order by rfm