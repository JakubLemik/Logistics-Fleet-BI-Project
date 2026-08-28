DROP VIEW [vw_Fact_safety_incidents_Clean];
GO

CREATE VIEW [dbo].[vw_Fact_safety_incidents_Clean] AS
SELECT 
[incident_id],
[trip_id],
[truck_id],
[driver_id],
[incident_date],
[incident_type],
[location_city],
[location_state],
[at_fault_flag],
[injury_flag],
[vehicle_damage_cost],
[cargo_damage_cost],
[claim_amount],
	CASE
		WHEN ABS(([vehicle_damage_cost] + [cargo_damage_cost]) - [claim_amount]) > 0.01 THEN 1
		ELSE 0
		END AS claim_amount_check,
CAST(([vehicle_damage_cost] + [cargo_damage_cost]) - [claim_amount] AS decimal(10,2)) AS claim_amount_diff,
	CASE 
		WHEN [cargo_damage_cost] < 0 OR [vehicle_damage_cost] < 0 THEN 1
		ELSE 0
		END AS is_negative_cost_flag,
[preventable_flag],
[description]
FROM [dbo].[Fact_safety_incidents]