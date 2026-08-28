CREATE VIEW [dbo].[vw_Dim_facilities_clean] AS
SELECT
[facility_id],
[facility_name],
[facility_type],
[city],
[state],
[latitude],
[longitude],
[dock_doors],
[operating_hours],
	CASE 
		WHEN [operating_hours] = '24/7' THEN 1
		ELSE 0
	END AS is_24_7_operation_flag
FROM [dbo].[Dim_facilities]

