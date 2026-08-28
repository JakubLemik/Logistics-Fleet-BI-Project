SELECT DISTINCT [trailer_id] FROM fact_trips 
WHERE [trailer_id] IS NOT NULL AND
[trailer_id] NOT IN ( 
SELECT [trailer_id] FROM Dim_trailers)
