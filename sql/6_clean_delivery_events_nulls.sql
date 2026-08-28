UPDATE [dbo].[Fact_delivery_events]
SET [load_id] = 'UNKNOWN'
WHERE [load_id] IS NULL OR [load_id] = '';
GO
UPDATE [dbo].[Fact_delivery_events]
SET [trip_id] = 'UNKNOWN'
WHERE [trip_id] IS NULL OR [trip_id] = '';
GO
UPDATE [dbo].[Fact_delivery_events]
SET [facility_id] = 'UNKNOWN'
WHERE [facility_id] IS NULL OR [facility_id] = '';
