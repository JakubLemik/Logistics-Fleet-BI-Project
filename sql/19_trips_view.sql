CREATE VIEW [dbo].[vw_Fact_trips_Clean] AS
SELECT 
[trip_id],
[load_id],
[driver_id],
[truck_id],
[trailer_id],
[dispatch_date],
[actual_distance_miles],
[actual_duration_hours],
[fuel_gallons_used],
[average_mpg],
	CASE
		WHEN ABS(([actual_distance_miles] / NULLIF([fuel_gallons_used], 0)) - [average_mpg]) > 0.01 THEN 1
		ELSE 0 
		END AS average_mpg_check,
CAST(([actual_distance_miles] / NULLIF([fuel_gallons_used], 0)) - [average_mpg] AS decimal(10,2)) AS average_mpg_diff,
[idle_time_hours],
[trip_status],
	CASE
		WHEN [trip_status] = 'Completed' THEN 1
		ELSE 0
		END AS is_status_completed_flag,
	CASE
		WHEN [fuel_gallons_used] < 0 OR
		[actual_duration_hours] < 0 OR
		[actual_distance_miles] < 0 OR
		[idle_time_hours] < 0 THEN 1
		ELSE 0
		END AS has_negative_metric_flag
FROM [dbo].[Fact_trips]