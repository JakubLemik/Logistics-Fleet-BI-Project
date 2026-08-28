CREATE VIEW [dbo].[vw_Fact_delivery_events_clean] AS
SELECT 
[event_id],
[load_id],
[trip_id],
[event_type],
[facility_id],
[scheduled_datetime],
[actual_datetime],
[detention_minutes],
detention_minutes / 60.0 AS detention_hours,
DATEDIFF(minute, [scheduled_datetime], [actual_datetime]) AS actual_delay_minutes,
	CASE
		WHEN detention_minutes > 0 THEN 1
		ELSE 0
		END AS has_detention_flag,
[on_time_flag],
[location_city],
[location_state]
FROM [dbo].[Fact_delivery_events]









