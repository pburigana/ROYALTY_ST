
-- Import data
TRUNCATE TABLE [ROYALTY].[dbo].[Royalty_Agreement] 

EXECUTE AS LOGIN = 'sa_srm'
GO
	INSERT INTO [ROYALTY].[dbo].[Royalty_Agreement] 
	SELECT *
	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0', 
	'Data Source="\\agrfs005a-prd.agrr2.stmmfg.com\STD_FIN_REP\00 - BUSINESS_CONTINUITY\05 - OPEX\01 - ROYALTY\TEST SOURCE\Agreement_TEST.xls";
	Extended Properties=Excel 12.0 Xml')...[Agreement$]
	WHERE
		[Agreement_Active] = 'Y'
	ORDER BY
		[Id_Agreement]
GO
REVERT
GO



-- Remove NULL rows
DELETE FROM [ROYALTY].[dbo].[Royalty_Agreement] WHERE [Agreement] IS NULL



-- Elimina NULL
--------------------------------------------
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Id_Agreement]					= 0 WHERE [Id_Agreement] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Agreement_Active]				= 'X' WHERE [Agreement_Active] IS NULL OR LEN([Agreement_Active]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Agreement]						= 'X' WHERE [Agreement] IS NULL OR LEN([Agreement]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Model]							= 'X' WHERE [Model] IS NULL OR LEN([Model]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Slot]							= 0 WHERE [Slot] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Agreement_Date_Start]			= 'X' WHERE [Agreement_Date_Start] IS NULL OR LEN([Agreement_Date_Start]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Agreement_Date_End]				= 'X' WHERE [Agreement_Date_End] IS NULL OR LEN([Agreement_Date_End]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [PL_String]						= 'X' WHERE [PL_String] IS NULL OR LEN([PL_String]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [PL_Cond]						= 'X' WHERE [PL_Cond] IS NULL OR LEN([PL_Cond]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [CP_String]						= 'X' WHERE [CP_String] IS NULL OR LEN([CP_String]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [CP_Cond]						= 'X' WHERE [CP_Cond] IS NULL OR LEN([CP_Cond]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Customer_String]				= 'X' WHERE [Customer_String] IS NULL OR LEN([Customer_String]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Customer_Cond]					= 'X' WHERE [Customer_Cond] IS NULL OR LEN([Customer_Cond]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Condition1]						= 'X' WHERE [Condition1] IS NULL OR LEN([Condition1]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Limit1]							= 0 WHERE [Limit1] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Rate1]							= 0 WHERE [Rate1] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Min1]							= 0 WHERE [Min1] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Max1]							= 0 WHERE [Max1] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra1A]						= 0 WHERE [Extra1A] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra1B]						= 0 WHERE [Extra1B] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra1C]						= 0 WHERE [Extra1C] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra1D]						= 0 WHERE [Extra1D] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra1E]						= 0 WHERE [Extra1E] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra1F]						= 0 WHERE [Extra1F] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Condition2]						= 'X' WHERE [Condition2] IS NULL OR LEN([Condition2]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Limit2]							= 0 WHERE [Limit2] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Rate2]							= 0 WHERE [Rate2] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Min2]							= 0 WHERE [Min2] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Max2]							= 0 WHERE [Max2] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra2A]						= 0 WHERE [Extra2A] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra2B]						= 0 WHERE [Extra2B] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra2C]						= 0 WHERE [Extra2C] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra2D]						= 0 WHERE [Extra2D] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra2E]						= 0 WHERE [Extra2E] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra2F]						= 0 WHERE [Extra2F] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Condition3]						= 'X' WHERE [Condition3] IS NULL OR LEN([Condition3]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Limit3]							= 0 WHERE [Limit3] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Rate3]							= 0 WHERE [Rate3] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Min3]							= 0 WHERE [Min3] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Max3]							= 0 WHERE [Max3] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra3A]						= 0 WHERE [Extra3A] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra3B]						= 0 WHERE [Extra3B] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra3C]						= 0 WHERE [Extra3C] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra3D]						= 0 WHERE [Extra3D] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra3E]						= 0 WHERE [Extra3E] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra3F]						= 0 WHERE [Extra3F] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Condition4]						= 'X' WHERE [Condition4] IS NULL OR LEN([Condition4]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Limit4]							= 0 WHERE [Limit4] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Rate4]							= 0 WHERE [Rate4] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Min4]							= 0 WHERE [Min4] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Max4]							= 0 WHERE [Max4] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra4A]						= 0 WHERE [Extra4A] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra4B]						= 0 WHERE [Extra4B] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra4C]						= 0	WHERE [Extra4C] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra4D]						= 0 WHERE [Extra4D] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra4E]						= 0 WHERE [Extra4E] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra4F]						= 0 WHERE [Extra4F] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Condition5]						= 'X' WHERE [Condition5] IS NULL OR LEN([Condition5]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Limit5]							= 0 WHERE [Limit5] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Rate5]							= 0 WHERE [Rate5] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Min5]							= 0 WHERE [Min5] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Max5]							= 0 WHERE [Max5] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra5A]						= 0 WHERE [Extra5A] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra5B]						= 0 WHERE [Extra5B] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra5C]						= 0 WHERE [Extra5C] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra5D]						= 0 WHERE [Extra5D] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra5E]						= 0 WHERE [Extra5E] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra5F]						= 0 WHERE [Extra5F] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Condition6]						= 'X' WHERE [Condition6] IS NULL OR LEN([Condition6]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Limit6]							= 0 WHERE [Limit6] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Rate6]							= 0 WHERE [Rate6] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Min6]							= 0 WHERE [Min6] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Max6]							= 0 WHERE [Max6] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra6A]						= 0 WHERE [Extra6A] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra6B]						= 0 WHERE [Extra6B] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra6C]						= 0 WHERE [Extra6C] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra6D]						= 0 WHERE [Extra6D] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra6E]						= 0 WHERE [Extra6E] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Extra6F]						= 0 WHERE [Extra6F] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [RateOver]						= 0 WHERE [RateOver] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [MinOver]						= 0 WHERE [MinOver] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [MaxOver]						= 0 WHERE [MaxOver] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [ExtraOverA]						= 0 WHERE [ExtraOverA] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [ExtraOverB]						= 0 WHERE [ExtraOverB] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [ExtraOverC]						= 0 WHERE [ExtraOverC] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [ExtraOverD]						= 0 WHERE [ExtraOverD] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [ExtraOverE]						= 0 WHERE [ExtraOverE] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [ExtraOverF]						= 0 WHERE [ExtraOverF] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [LclCurrency]					= 'X' WHERE [LclCurrency] IS NULL OR LEN([LclCurrency]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Min_Cum_Royalty_KLcl]			= 0 WHERE [Min_Cum_Royalty_KLcl] IS NULL
UPDATE [ROYALTY].[dbo].[Royalty_Agreement] SET [Max_Cum_Royalty_KLcl]			= 0 WHERE [Max_Cum_Royalty_KLcl] IS NULL










-- Import data
TRUNCATE TABLE [ROYALTY].[dbo].[Royalty_ExchangeRate] 

EXECUTE AS LOGIN = 'sa_srm'
GO
	INSERT INTO [ROYALTY].[dbo].[Royalty_ExchangeRate] 
	SELECT *
	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0', 
	'Data Source="\\agrfs005a-prd.agrr2.stmmfg.com\STD_FIN_REP\00 - BUSINESS_CONTINUITY\05 - OPEX\01 - ROYALTY\TEST SOURCE\Exchange rate_TEST.xls";
	Extended Properties=Excel 12.0 Xml')...[ExchangeRate$]
GO
REVERT
GO

-- Remove NULL rows
DELETE FROM [ROYALTY].[dbo].[Royalty_ExchangeRate] WHERE [Qtr2] IS NULL




-- Elimina NULL
--------------------------------------------
UPDATE [ROYALTY].[dbo].[Royalty_ExchangeRate] SET [Qtr2]				= 'X' WHERE [Qtr2] IS NULL OR LEN([Qtr2]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_ExchangeRate] SET [LclCurrency]			= 'X' WHERE [LclCurrency] IS NULL OR LEN([LclCurrency]) = 0
UPDATE [ROYALTY].[dbo].[Royalty_ExchangeRate] SET [ExchangeRate]		= 0 WHERE [ExchangeRate] IS NULL




-- Append ST Exchange Rate
--------------------------------------------
INSERT INTO [ROYALTY].[dbo].[Royalty_ExchangeRate] (
	[Qtr2],
	[LclCurrency],
	[ExchangeRate])
SELECT
	CASE
		WHEN RIGHT([MONTH_LABEL_MYYYYMM],2) = '01' THEN 'Q' + SUBSTRING([MONTH_LABEL_MYYYYMM],2,4) + '01'
		WHEN RIGHT([MONTH_LABEL_MYYYYMM],2) = '04' THEN 'Q' + SUBSTRING([MONTH_LABEL_MYYYYMM],2,4) + '02'
		WHEN RIGHT([MONTH_LABEL_MYYYYMM],2) = '07' THEN 'Q' + SUBSTRING([MONTH_LABEL_MYYYYMM],2,4) + '03'
		ELSE 'Q' + SUBSTRING([MONTH_LABEL_MYYYYMM],2,4) + '04'
	END AS [Qtr2],
	[CURR_FROM_SHORT_DESCR] + '-ST' AS [Currency],
	[Value] AS [ExchangeRate]
FROM [MD].[dbo].[EXCHANGE_RATE]
WHERE
	RIGHT([MONTH_LABEL_MYYYYMM],2) IN ('01','04','07','10')












-- Import data
TRUNCATE TABLE [ROYALTY].[dbo].[Royalty_Period] 

EXECUTE AS LOGIN = 'sa_srm'
GO
	INSERT INTO [ROYALTY].[dbo].[Royalty_Period] 
	SELECT *
	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0', 
	'Data Source="\\agrfs005a-prd.agrr2.stmmfg.com\STD_FIN_REP\00 - BUSINESS_CONTINUITY\05 - OPEX\01 - ROYALTY\TEST SOURCE\Period_TEST.xls";
	Extended Properties=Excel 12.0 Xml')...[Period$]
GO
REVERT
GO

-- Remove NULL rows
DELETE FROM [ROYALTY].[dbo].[Royalty_Period] WHERE [Qtr2] IS NULL



-- Remove Period_Active = N
DELETE FROM [ROYALTY].[dbo].[Royalty_Period] WHERE [Period_Active] = 'N'













