CREATE VIEW [dbo].[vw_Dim_Customers_Clean] AS 
SELECT [customer_id],
[customer_name],
[customer_type],
[credit_terms_days],
[primary_freight_type],
[account_status],
	CASE 
		WHEN [account_status] = 'Active' THEN 1
		ELSE 0
END AS is_active_flag,
[contract_start_date],
[annual_revenue_potential]
FROM [dbo].[Dim_Customers];
GO


