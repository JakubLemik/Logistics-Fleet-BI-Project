ALTER TABLE [dbo].[Fact_trips]
ALTER COLUMN [dispatch_date] date;
GO
ALTER TABLE [dbo].[Fact_trips]
ALTER COLUMN [actual_distance_miles] varchar(5);
GO
ALTER TABLE [dbo].[Fact_trips]
ALTER COLUMN [actual_duration_hours] decimal(5,1);
GO
ALTER TABLE [dbo].[Fact_trips]
ALTER COLUMN [fuel_gallons_used] decimal(5,1);
GO
ALTER TABLE [dbo].[Fact_trips]
ALTER COLUMN [average_mpg] decimal(4,1);
GOw
ALTER TABLE [dbo].[Fact_trips]
ALTER COLUMN [idle_time_hours] decimal(3,1);
GO
ALTER TABLE [dbo].[Fact_trips]
ALTER COLUMN [trip_status] varchar(10);
