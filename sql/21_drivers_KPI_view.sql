DROP VIEW IF EXISTS [vw_KPI_Drivers_Performance];
GO

CREATE VIEW [dbo].[vw_KPI_Drivers_Performance] AS 

WITH vw_Fact_trips_Clean_CTE AS(												--- creating 1 CTE vw_fact_trips_clean
	SELECT 
	driver_id,
	AVG(average_mpg) AS average_mpg,
	AVG(idle_time_hours) AS idle_time
	FROM vw_Fact_trips_Clean
	GROUP by driver_id),								 

vw_Fact_safety_incidents_Clean_CTE AS (											--- creating 2 CTE vw_safety_incidents_clean
SELECT 
driver_id,
SUM(
	CASE
	WHEN [at_fault_flag] = 1 THEN 1
	ELSE 0
	END) 
AS Sum_of_incidents_at_faults,
SUM(
	CASE
	WHEN [injury_flag] = 1 THEN 1
	ELSE 0
	END)
AS Sum_of_injuries,
SUM([claim_amount]) AS claim_amount,
SUM (
	CASE
	WHEN at_fault_flag = 1 THEN claim_amount
	ELSE 0
	END)
AS claim_amount_at_fault,
SUM (
	CASE
	WHEN preventable_flag = 1 THEN claim_amount
	ELSE 0
	END) 
AS preventable_claim_amount
FROM [vw_Fact_safety_incidents_Clean]
GROUP BY driver_id)

SELECT dd.driver_id,																	--- Creating view and drivers collumns
	CASE
	WHEN dd.[termination_date] IS NOT NULL THEN 1
	ELSE 0
	END AS is_terminated_flag,
CONCAT(dd.first_name, ' ', dd.last_name) AS driver_full_name, 

ISNULL(ft.average_mpg, 0) AS average_mpg,												--- trips CTE collumns
ISNULL(ft.idle_time, 0) AS idle_time,

ISNULL(fsi.Sum_of_incidents_at_faults, 0) AS Sum_of_incidents_at_faults,	 			--- safety incidents CTE collumns
ISNULL(fsi.Sum_of_injuries, 0) AS Sum_of_injuries,
ISNULL(fsi.claim_amount, 0) AS claim_amount,
ISNULL(fsi.claim_amount_at_fault, 0) AS claim_amount_at_fault,
ISNULL(fsi.preventable_claim_amount, 0) AS preventable_claim_amount

FROM vw_Dim_drivers_Clean dd															--- FROM and JOINS
LEFT JOIN vw_Fact_trips_Clean_CTE ft ON dd.driver_id = ft.driver_id
LEFT JOIN vw_Fact_safety_incidents_Clean_CTE fsi ON dd.driver_id = fsi.driver_id
