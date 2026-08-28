CREATE VIEW [dbo].[vw_Dim_trucks_Clean] AS 
SELECT
[truck_id],
[unit_number],
[make],
[model_year],
(2026 - model_year) AS truck_age_years,
[vin],
[acquisition_date],
DATEDIFF(year, [acquisition_date], GETDATE()) AS years_in_fleet,
[acquisition_mileage],
[fuel_type],
[tank_capacity_gallons],
[status],
	CASE
		WHEN status = 'Active' THEN 1
		ELSE 0
		END AS is_truck_active_flag,
[home_terminal]
FROM Dim_trucks







