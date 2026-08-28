CREATE VIEW [dbo].[vw_Dim_drivers_Clean] AS
SELECT
[driver_id],
[first_name],
[last_name],
[hire_date],
[termination_date],
[license_number],
[license_state],
[date_of_birth],
[home_terminal],
[employment_status],
	CASE
		WHEN [employment_status] = 'Active' THEN 1
		ELSE 0
	END AS is_employment_active_flag,
[cdl_class],
[years_experience]
FROM [dbo].[Dim_drivers]