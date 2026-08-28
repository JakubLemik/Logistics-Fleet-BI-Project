

ALTER TABLE [dbo].[Fact_delivery_events]
ADD CONSTRAINT FK_delivery_events_facility
FOREIGN KEY (facility_id) 
REFERENCES [dbo].[Dim_facilities](facility_id);