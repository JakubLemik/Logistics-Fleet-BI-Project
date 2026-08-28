DROP VIEW [vw_Fact_loads_Clean];
GO

CREATE VIEW [dbo].[vw_Fact_loads_Clean] AS
SELECT 
[load_id],
[customer_id],
[route_id],
[load_date],
[load_type],
[weight_lbs],
[pieces],
[revenue],
[fuel_surcharge],
[accessorial_charges],
[revenue] + [fuel_surcharge] + [accessorial_charges] AS total_load_revenue,
[load_status],
	CASE
		WHEN load_status = 'Completed' THEN 1
		ELSE 0
		END AS is_load_status_comleted_flag,
	CASE
		WHEN [weight_lbs] < 0 OR 
		[revenue] < 0 THEN 1
		ELSE 0
		END AS is_negative_value_flag,
[booking_type]
FROM  [dbo].[Fact_loads]