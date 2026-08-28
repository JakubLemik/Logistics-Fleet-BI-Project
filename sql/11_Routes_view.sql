CREATE VIEW [dbo].[vw_Dim_routes_Clean] AS
SELECT 
[route_id],
[origin_city],
[origin_state],
[destination_city],
[destination_state],
[typical_distance_miles],
[base_rate_per_mile],
[fuel_surcharge_rate],
[base_rate_per_mile] + [fuel_surcharge_rate] AS total_rate_per_mile,
([base_rate_per_mile] + [fuel_surcharge_rate] ) * [typical_distance_miles] AS standard_total_cost,
[typical_transit_days]
FROM [dbo].[Dim_routes]

