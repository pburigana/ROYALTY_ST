


-- Parameter
--------------------------------------------
DECLARE @Period_Active NVARCHAR(MAX)
DECLARE @Qtr2 NVARCHAR(MAX)
SET @Period_Active = ?
SET @Qtr2 = ?




-- Billing
-- ---------------------------------------------------
IF (@Period_Active = 'Y')
BEGIN

	-- Billing
	DELETE FROM [ROYALTY].[dbo].[Royalty] WHERE [QTR2] >= @Qtr2

	INSERT INTO [ROYALTY].[dbo].[Royalty]
		SELECT
			[Year],
			[Qtr],
			[Qtr2],
			[Month],
			[Subgroup],
			[Division],
			[Division_descr],
			[BU],
			[BU_descr],
			[Product_Line_Code],
			[CP],
			[Customer_Final_Ship_To],
			[Agreement],
			[Condition],
			[LclCurrency],
			[ExchangeRate],
			[Net_Revenue_KLcl],
			[Cum_Net_Revenue_KLcl],
			[Net_Revenue_KUSD],
			[Cum_Net_Revenue_KUSD],
			[Net_qty_Kpcs],
			[Cum_Net_qty_Kpcs],
			[Royalty_KLcl],
			[Cum_Royalty_KLcl],
			[Royalty_KUSD],
			[Cum_Royalty_KUSD],
			[RoyaltyPaid_KLcl],
			[Cum_RoyaltyPaid_KLcl],
			[RoyaltyPaid_KUSD],
			[Cum_RoyaltyPaid_KUSD],
			[Rate_Lcl_per_pcs],
			[Rate_USD_per_pcs],
			[Rate_Rev_percent]
	FROM [ROYALTY].[dbo].[Royalty_Q]


END


-- Remove all records
-- ---------------------------------------------------
TRUNCATE TABLE [ROYALTY].[dbo].[Royalty_Q]

