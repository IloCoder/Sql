use SampleSales
go


-- SELECT FROM PIVOT ( AGG() FOR IN ([COL],[COL2]..) AS PIVOT_TABLE_NAME

-- CONVERTS THE UNIQUE OBSERVATIONS SEESN IN THE RESULTS TABLE INTO FIELDS --
-- SPECIFIES THE CORRESPONDING AGGREGATE VALUES AS ROWS -- 
-- AGG result col; SATIRA d�n���r.
-- GROUP BY �LE KULLANILMAZ --



--------
SELECT [...],[...],....
FROM table_source

PIVOT (
AGG_FUNCTION(COL) FOR IN ([...],[...],...) 
AS pivot_table_new
--------


SELECT *FROM sale.sales_summary



SELECT  * FROM 
(SELECT category, total_sales_price ,model_year FROM sale.sales_summary) as c

PIVOT (
	 SUM(total_sales_price)  -- aggregation
	 FOR category            -- spreading
		IN (	
	[Children Bicycles], 
    [Comfort Bicycles], 
    [Cruisers Bicycles], 
    [Cyclocross Bicycles], 
    [Electric Bikes], 
    [Mountain Bikes], 
    [Road Bikes])
	) AS PIVOT_TABLE
	------------------------------------------







