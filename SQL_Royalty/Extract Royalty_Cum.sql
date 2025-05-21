
-- Parameter
--------------------------------------------
DECLARE @Period_Active NVARCHAR(MAX)
DECLARE @Qtr2 NVARCHAR(MAX)
SET @Period_Active = ?
SET @Qtr2 = ?



-- 
-- ---------------------------------------------------
TRUNCATE TABLE [ROYALTY].[dbo].[Royalty_Cum]

IF (@Period_Active = 'Y')
BEGIN

	INSERT INTO [ROYALTY].[dbo].[Royalty_Cum]
	SELECT
		[Agreement]							AS [Agreement],
		SUM([Net_Revenue_KLcl])				AS [Cum_Net_Revenue_KLcl],
		SUM([Net_Revenue_KUSD])				AS [Cum_Net_Revenue_KUSD],
		SUM([Net_qty_Kpcs])					AS [Cum_Net_qty_Kpcs],
		SUM([Royalty_KLcl])					AS [Cum_Royalty_KLcl],
		SUM([Royalty_KUSD])					AS [Cum_Royalty_KUSD],
		SUM([RoyaltyPaid_KLcl])				AS [Cum_RoyaltyPaid_KLcl],
		SUM([RoyaltyPaid_KUSD])				AS [Cum_RoyaltyPaid_KUSD]
	FROM[ROYALTY].[dbo].[Royalty]
	GROUP BY
		[Agreement]

END



-- Elimina NULL
--------------------------------------------
UPDATE [ROYALTY].[dbo].[Royalty_Cum] SET [Agreement]						= 'X' WHERE [Agreement] IS NULL OR LEN([Agreement]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Cum] SET [Cum_Net_Revenue_KLcl]				= 0 WHERE [Cum_Net_Revenue_KLcl] IS NULL 
UPDATE [ROYALTY].[dbo].[Royalty_Cum] SET [Cum_Net_Revenue_KUSD]				= 0 WHERE [Cum_Net_Revenue_KUSD] IS NULL 
UPDATE [ROYALTY].[dbo].[Royalty_Cum] SET [Cum_Net_qty_Kpcs]					= 0 WHERE [Cum_Net_qty_Kpcs] IS NULL 
UPDATE [ROYALTY].[dbo].[Royalty_Cum] SET [Cum_Royalty_KLcl]					= 0 WHERE [Cum_Royalty_KLcl] IS NULL 
UPDATE [ROYALTY].[dbo].[Royalty_Cum] SET [Cum_Royalty_KUSD]					= 0 WHERE [Cum_Royalty_KUSD] IS NULL 
UPDATE [ROYALTY].[dbo].[Royalty_Cum] SET [Cum_RoyaltyPaid_KLcl]				= 0 WHERE [Cum_RoyaltyPaid_KLcl] IS NULL 
UPDATE [ROYALTY].[dbo].[Royalty_Cum] SET [Cum_RoyaltyPaid_KUSD]				= 0 WHERE [Cum_RoyaltyPaid_KUSD] IS NULL 


