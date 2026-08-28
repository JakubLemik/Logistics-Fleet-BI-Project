DROP VIEW vw_Fact_fuel_purchases_clean;
GO

CREATE VIEW [dbo].[vw_Fact_fuel_purchases_clean] AS
SELECT 
[fuel_purchase_id],
[trip_id],
[truck_id],
[driver_id],
[purchase_date],
[location_city],
[location_state],
[gallons],
[price_per_gallon],
[total_cost],
	CASE
		WHEN ABS(([gallons] * [price_per_gallon]) - [total_cost]) > 0.01 THEN 1
		ELSE 0
		END AS total_cost_check,
CAST(([gallons] * [price_per_gallon]) - [total_cost] AS decimal (10,2)) AS total_cost_diff,
[fuel_card_number]
FROM [dbo].[Fact_fuel_purchases]