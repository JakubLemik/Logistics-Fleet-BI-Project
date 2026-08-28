DROP VIEW [vw_Fact_maintenance_records_Clean];
GO
CREATE VIEW [dbo].[vw_Fact_maintenance_records_Clean] AS
SELECT 
[maintenance_id],
[truck_id],
[maintenance_date],
[maintenance_type],
[odometer_reading],
[labor_hours],
[labor_cost],
[parts_cost],
[total_cost],
	CASE 
		WHEN ABS(([labor_cost] + [parts_cost]) - total_cost) > 0.01 THEN 1
		ELSE 0
		END AS total_cost_check,
CAST(([labor_cost] + [parts_cost]) - total_cost AS decimal (10,2)) AS total_cost_diff,
[facility_location],
[downtime_hours],
[service_description],
	CASE 
		WHEN [labor_hours] < 0 THEN 1
		ELSE 0
		END AS is_labour_hours_negative_flag,
	CASE 
		WHEN [downtime_hours] < 0 THEN 1
		ELSE 0
		END AS is_downtime_hours_negative_flag
FROM  [dbo].[Fact_maintenance_records]