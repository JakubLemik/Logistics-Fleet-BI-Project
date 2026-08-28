CREATE VIEW [dbo].[vw_Dim_trailers_Clean] AS
SELECT 
[trailer_id],
[trailer_number],
[trailer_type],
[length_feet],
[model_year],
(2026 - [model_year]) AS trailer_age_years,
[vin],
[acquisition_date],
DATEDIFF(year, acquisition_date, GETDATE()) AS years_in_fleet,
[status],
	CASE
		WHEN status = 'Active' THEN 1
		ELSE 0
		END AS is_trailer_active_flag,
[current_location]
FROM [dbo].[Dim_trailers]

