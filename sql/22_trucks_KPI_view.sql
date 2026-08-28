DROP VIEW IF EXISTS	vw_KPI_Trucks_Performance;
GO

CREATE VIEW vw_KPI_Trucks_Performance AS


WITH fuel_costs AS (														--- CTE 1 Fuel Costs
SELECT 
truck_id,
SUM([gallons]) AS gallons,
SUM([total_cost]) AS total_cost,
SUM([total_cost])/NULLIF(SUM([gallons]),0) AS weighted_avg_price_per_gallon,
COUNT([fuel_purchase_id]) AS fuel_purchase_count
FROM [dbo].[vw_Fact_fuel_purchases_clean]
GROUP BY truck_id),

maintenance_costs AS (														--- CTE 2 Maintenance Costs
SELECT
[truck_id],
SUM(parts_cost) AS parts_cost,
SUM(labor_cost) AS labor_cost,
SUM(total_cost) AS total_cost_meintenance,
SUM(downtime_hours) AS downtime_hours,
COUNT(maintenance_id) AS maintenance_count,
MAX([odometer_reading]) AS odometer_reading
FROM [dbo].[vw_Fact_maintenance_records_Clean]
GROUP BY [truck_id])

SELECT																--- creating VIEW, trucks collumns
dt.truck_id,	
dt.unit_number,
[status],
[is_truck_active_flag],
																	--- creating VIEW, fuel costs collumns
ISNULL(fc.gallons, 0) AS gallons,											
ISNULL(fc.total_cost, 0) AS total_cost,
ISNULL(fc.weighted_avg_price_per_gallon, 0) AS weighted_avg_price_per_gallon,
ISNULL(fc.fuel_purchase_count, 0) AS fuel_purchase_count,


mc.parts_cost,														--- creating VIEW, maintenance costs collumns	
mc.labor_cost,
mc.total_cost_meintenance,
mc.downtime_hours,
mc.maintenance_count,
mc.odometer_reading - dt.acquisition_mileage AS total_distance_traveled,

																	--- additional KPI's collumns
(ISNULL(fc.total_cost, 0) + ISNULL(mc.total_cost_meintenance, 0)) 
/ NULLIF((mc.odometer_reading - dt.acquisition_mileage), 0)
AS cost_per_mile,

ISNULL(mc.total_cost_meintenance, 0) / NULLIF(mc.maintenance_count, 0) 
AS avg_cost_per_maintenance

FROM  [dbo].[vw_Dim_trucks_Clean] dt

LEFT JOIN fuel_costs fc ON dt.truck_id = fc.truck_id				--- 1 CTE JOIN

LEFT JOIN maintenance_costs mc ON dt.truck_id = mc.truck_id			--- 2 CTE JOIN
WHERE dt.truck_id <> 'UNKNOWN'										--- cutting off 'UNKNOWN' strings