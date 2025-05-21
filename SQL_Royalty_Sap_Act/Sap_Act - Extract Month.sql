

-- Parameter
--------------------------------------------
DECLARE @MONTH NVARCHAR(MAX)
SET @MONTH = ?
--SET @MONTH = 'M202201'


-- Estrae dati da PNL
-- ---------------------------------------------------
TRUNCATE TABLE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]

INSERT INTO [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
SELECT

	-- Period
	'Y' + SUBSTRING(z.[Period Year],1,4)														AS [YEAR (Yyyyy)],
	'Y' + SUBSTRING(z.[Period Year],3,2)														AS [YEAR (Yyy)],
	CASE
		WHEN RIGHT(z.[Period year],2) = '01' THEN SUBSTRING(z.[Period Year],1,4) + 'Q1'
		WHEN RIGHT(z.[Period year],2) = '02' THEN SUBSTRING(z.[Period Year],1,4) + 'Q1'
		WHEN RIGHT(z.[Period year],2) = '03' THEN SUBSTRING(z.[Period Year],1,4) + 'Q1'
		WHEN RIGHT(z.[Period year],2) = '04' THEN SUBSTRING(z.[Period Year],1,4) + 'Q2'
		WHEN RIGHT(z.[Period year],2) = '05' THEN SUBSTRING(z.[Period Year],1,4) + 'Q2'
		WHEN RIGHT(z.[Period year],2) = '06' THEN SUBSTRING(z.[Period Year],1,4) + 'Q2'
		WHEN RIGHT(z.[Period year],2) = '07' THEN SUBSTRING(z.[Period Year],1,4) + 'Q3'
		WHEN RIGHT(z.[Period year],2) = '08' THEN SUBSTRING(z.[Period Year],1,4) + 'Q3'
		WHEN RIGHT(z.[Period year],2) = '09' THEN SUBSTRING(z.[Period Year],1,4) + 'Q3'
		WHEN RIGHT(z.[Period year],2) = '10' THEN SUBSTRING(z.[Period Year],1,4) + 'Q4'
		WHEN RIGHT(z.[Period year],2) = '11' THEN SUBSTRING(z.[Period Year],1,4) + 'Q4'
		WHEN RIGHT(z.[Period year],2) = '12' THEN SUBSTRING(z.[Period Year],1,4) + 'Q4'
		ELSE SUBSTRING(z.[Period Year],1,4) + 'Q9'
	END																					AS [QUARTER (yyyyQq)],
	CASE
		WHEN RIGHT(z.[Period year],2) = '01' THEN SUBSTRING(z.[Period Year],3,2) + 'Q1'
		WHEN RIGHT(z.[Period year],2) = '02' THEN SUBSTRING(z.[Period Year],3,2) + 'Q1'
		WHEN RIGHT(z.[Period year],2) = '03' THEN SUBSTRING(z.[Period Year],3,2) + 'Q1'
		WHEN RIGHT(z.[Period year],2) = '04' THEN SUBSTRING(z.[Period Year],3,2) + 'Q2'
		WHEN RIGHT(z.[Period year],2) = '05' THEN SUBSTRING(z.[Period Year],3,2) + 'Q2'
		WHEN RIGHT(z.[Period year],2) = '06' THEN SUBSTRING(z.[Period Year],3,2) + 'Q2'
		WHEN RIGHT(z.[Period year],2) = '07' THEN SUBSTRING(z.[Period Year],3,2) + 'Q3'
		WHEN RIGHT(z.[Period year],2) = '08' THEN SUBSTRING(z.[Period Year],3,2) + 'Q3'
		WHEN RIGHT(z.[Period year],2) = '09' THEN SUBSTRING(z.[Period Year],3,2) + 'Q3'
		WHEN RIGHT(z.[Period year],2) = '10' THEN SUBSTRING(z.[Period Year],3,2) + 'Q4'
		WHEN RIGHT(z.[Period year],2) = '11' THEN SUBSTRING(z.[Period Year],3,2) + 'Q4'
		WHEN RIGHT(z.[Period year],2) = '12' THEN SUBSTRING(z.[Period Year],3,2) + 'Q4'
		ELSE SUBSTRING(z.[Period Year],3,2) + 'Q9'
	END																					AS [QUARTER (yyQq)],
	SUBSTRING(z.[Period Year],1,4) + 'M' + RIGHT(z.[Period year],2)						AS [MONTH (yyyyMmm)],
	SUBSTRING(z.[Period Year],3,2) + 'M' + RIGHT(z.[Period year],2)						AS [MONTH (yyMmm)],

	-- Organization
	z.[Product Group]	AS [GROUP_CODE_ORIGINAL],
	z.[SubGroup]		AS [SUBGROUP_CODE_ORIGINAL],
	z.[Division]		AS [DIV_CODE_ORIGINAL],
	z.[BU]				AS [BU_CODE_ORIGINAL],
	''					AS [BU_CODE_CURRENT],

	-- Product
	z.[Product]						AS [PRODUCT],
	z.[CP]							AS [CP],
	z.[Product Line Code]			AS [PRODUCT_LINE_ORIGINAL],
	z.[Product Line Code]			AS [PRODUCT_LINE_CURRENT],

	-- Reason
	z.[Reason]													AS [REASON_CODE],
	IIF(c.[DESCR] IS NULL, '', c.[DESCR]) 						AS [REASON_DESCR],
	IIF(c.[ReasonType] IS NULL, '', c.[ReasonType])				AS [REASON_TYPE],
	IIF(c.[FLAG_QUANTITY] IS NULL, 'Y', c.[FLAG_QUANTITY])		AS [REASON_FLAG_QUANTITY],

	-- PNL Structure
	z.[Activity]			AS [ACTIVITY],
	z.[Activity_New]		AS [PLINE],
	p.[Pline Description]	AS [PLINE_DESCR],
	p.[Level0]				AS [LEVEL0],
	p.[Level1]				AS [LEVEL1],
	p.[Level1 Descr]		AS [LEVEL1_DESCR],
	p.[Level2]				AS [LEVEL2],
	p.[Level2 Descr]		AS [LEVEL2_DESCR],
	p.[Level3]				AS [LEVEL3],
	p.[Level3 Descr]		AS [LEVEL3_DESCR],

	-- Customer Direct
	SUBSTRING(z.[Customer],3,LEN(z.[Customer]))						AS [CUSTOMER_DIRECT_CODE],
	''																AS [CUSTOMER_DIRECT_DESCR],
	z.[Customer Type]												AS [CUSTOMER_DIRECT_TYPE_CODE],
	''																AS [CUSTOMER_DIRECT_TYPE_DESCR],
	z.[Customer Group]												AS [CUSTOMER_DIRECT_GROUP_CODE],
	''																AS [CUSTOMER_DIRECT_GROUP_DESCR],
	SUBSTRING(z.[Customer],3,LEN(z.[Customer])) + z.[Ship-to code]	AS [CUSTOMER_DIRECT_SHIPTO_CODE],
	''																AS [CUSTOMER_DIRECT_SHIPTO_DESCR],
	''																AS [CUSTOMER_DIRECT_REGION_CODE],
	''																AS [CUSTOMER_DIRECT_REGION_DESCR],
	''																AS [CUSTOMER_DIRECT_SALES_AREA_CODE],
	''																AS [CUSTOMER_DIRECT_SALES_AREA_DESCR],

	-- Customer Final
	''							AS [CUSTOMER_FINAL_CODE],
	''							AS [CUSTOMER_FINAL_DESCR],
	''							AS [CUSTOMER_FINAL_TYPE_CODE],
	''							AS [CUSTOMER_FINAL_TYPE_DESCR],
	z.[Customer Group Final]	AS [CUSTOMER_FINAL_GROUP_CODE],
	''							AS [CUSTOMER_FINAL_GROUP_DESCR],
	z.[Final Ship To]			AS [CUSTOMER_FINAL_SHIPTO_CODE],
	''							AS [CUSTOMER_FINAL_SHIPTO_DESCR],
	''							AS [CUSTOMER_FINAL_REGION_CODE],
	''							AS [CUSTOMER_FINAL_REGION_DESCR],
	''							AS [CUSTOMER_FINAL_SALES_AREA_CODE],
	''							AS [CUSTOMER_FINAL_SALES_AREA_DESCR],

	-- Other
	z.[Record Type]			AS [RECORD_TYPE],
	z.[Cpy]					AS [COMPANY_CODE],
	z.[Location]			AS [LOCATION],
	z.[Site]				AS [SITE],
	z.[Sender cost ctr]		AS [SENDER_COST_CENTER],

	-- Flag
	''						AS [POSTING_IN_TARIFF301],

	-- Data
	SUM(IIF(p.[Level0] = 'Sales', z.[Gross Sales Quantity], 0))	AS [GROSS_SALES_QTY],

	SUM(IIF(p.[Level0] = 'Sales', z.[Gross Sales Quantity], 0))	+
		SUM(IIF(p.[Level0] = 'Sales' AND 
			z.[Reason] IN ('0001','0004','0005','0006','0007','0008','0009','0016','0023','0027','0031','0084','0086'), 
			z.[Sales quantity], 0))								AS [NET_QTY],

	SUM(IIF(p.[Level0] = 'Sales' AND (LEN(z.[Reason]) = 0 OR z.[Reason] IS NULL), z.[Gross Sales Quantity], 0))	+
		SUM(IIF(p.[Level0] = 'Sales' AND c.[FLAG_QUANTITY] = 'Y', 
			z.[Sales quantity], 0))								AS [NET_QTY_BIBA],

	SUM(IIF(p.[Level3] = '01.01.01', z.[USD], 0))				AS [SALES_PRODUCT],
	SUM(IIF(p.[Level3] = '01.01.02', z.[USD], 0))				AS [SALES_MATERIALS],
	SUM(IIF(p.[Level3] = '01.01.03', z.[USD], 0))				AS [GROSS_SALES],
	SUM(IIF(p.[Level3] = '01.01.04', z.[USD], 0))				AS [RETURNS],
	SUM(IIF(p.[Level3] = '01.01.05', z.[USD], 0))				AS [OTHER_DEDUCTIONS],
	0															AS [NET_SALES],
	SUM(IIF(p.[Level3] = '01.02.01', z.[USD], 0)) + -- Other Revenue Services
		SUM(IIF(p.[Level3] = '01.02.02', z.[USD], 0)) + -- Other Revenue Royalties
		SUM(IIF(p.[Level3] = '01.02.03', z.[USD], 0)) + -- Other Revenue Patents
		SUM(IIF(p.[Level3] = '01.02.05', z.[USD], 0)) + -- Other Revenue Copper Sales
		SUM(IIF(p.[Level3] = '01.02.06', z.[USD], 0)) -- Other Revenue Test Wafer Sales
			   		 											AS [OTHER_REVENUES],
	0															AS [NET_REVENUES]

FROM [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[PNL].[dbo].[PNL] z
LEFT OUTER JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[MD].[dbo].[RETURN_CAUSE]		c ON z.[Reason]			= c.[CODE]
LEFT OUTER JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[MD].[dbo].[PNL_STRUCTURE_NEW]	p ON z.[Activity_New]	= p.[Pline]

WHERE 
	'M' + LEFT(z.[Period year],4) + RIGHT(z.[Period year],2) = @MONTH
GROUP BY
	z.[Period Year],
	z.[Product Group],
	z.[SubGroup],
	z.[Division],
	z.[BU],
	z.[Product],
	z.[CP],
	z.[Product Line Code],
	z.[Reason],
	c.[DESCR],
	c.[ReasonType],
	c.[BillingCostCalc],
	c.[FLAG_QUANTITY],
	z.[Activity],
	z.[Activity_New],
	p.[Pline Description],
	p.[Level0],
	p.[Level1],
	p.[Level1 Descr],
	p.[Level2],
	p.[Level2 Descr],
	p.[Level3],
	p.[Level3 Descr],
	z.[Customer],
	z.[Customer Type],
	z.[Customer Group],
	z.[Ship-to code],
	z.[Customer Group Final],
	z.[Final Ship To],
	z.[Record Type],
	z.[Cpy],
	z.[Location],
	z.[Site],
	z.[Sender cost ctr]







-- CURRENT BU e PL con la nuova organizzazione
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
	SET [BU_CODE_CURRENT]		= IIF(c.[BU_CODE] IS NULL OR LEN(c.[BU_CODE]) = 0, sap.[BU_CODE_ORIGINAL],		c.[BU_CODE]),
		[PRODUCT_LINE_CURRENT]	= IIF(c.[BU_CODE] IS NULL OR LEN(c.[BU_CODE]) = 0, sap.[PRODUCT_LINE_ORIGINAL],	c.[PRODUCT_LINE_CODE])
FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE] sap
LEFT OUTER JOIN (
		SELECT
			[PRODUCT_CODE_V2],
			[PRODUCT_LINE_CODE],
			[BU_CODE]
		FROM [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[MD].[dbo].[PRODUCT_HIERARCHY_CURR]
	) c ON sap.[Product] = c.[PRODUCT_CODE_V2]





-- Customer Direct - Name
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
   SET [CUSTOMER_DIRECT_DESCR] = IIF(c.[SHORT_NAME] IS NULL OR LEN(c.[SHORT_NAME]) = 0,	sap.[CUSTOMER_DIRECT_DESCR], c.[SHORT_NAME])
FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE] sap
LEFT OUTER JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[MD].[dbo].[CUSTOMER] c ON sap.[CUSTOMER_DIRECT_CODE] = c.[CODE]





-- Customer Direct - Type descr
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
   SET [CUSTOMER_DIRECT_TYPE_DESCR] =  IIF(c.[DESCR] IS NULL OR LEN(c.[DESCR]) = 0,	sap.[CUSTOMER_DIRECT_DESCR], c.[DESCR])
FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE] sap
LEFT OUTER JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[MD].[dbo].[CUSTOMER_TYPE] c ON sap.[CUSTOMER_DIRECT_TYPE_CODE] = c.[CODE]







-- Customer Direct - Group descr
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
   SET [CUSTOMER_DIRECT_GROUP_DESCR] = IIF(c.[DESCR] IS NULL OR LEN(c.[DESCR]) = 0,	sap.[CUSTOMER_DIRECT_GROUP_DESCR], c.[DESCR])
FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE] sap
LEFT OUTER JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[MD].[dbo].[CUSTOMER_GROUP] c ON sap.[CUSTOMER_DIRECT_GROUP_CODE] = c.[CODE]






-- Customer Direct - Ship-to descr
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
   SET [CUSTOMER_DIRECT_SHIPTO_DESCR] = IIF(c.[SHORT_NAME] IS NULL OR LEN(c.[SHORT_NAME]) = 0, sap.[CUSTOMER_DIRECT_SHIPTO_DESCR], c.[SHORT_NAME])
FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE] sap
LEFT OUTER JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[MD].[dbo].[CUSTOMER_SHIP_TO] c ON sap.[CUSTOMER_DIRECT_SHIPTO_CODE] = c.[CUST_SHIP_TO_ID]






-- Customer Direct - Region, Area
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
   SET [CUSTOMER_DIRECT_REGION_CODE]		= IIF(c.[REGION__CODE] IS NULL OR LEN(c.[REGION__CODE]) = 0,			sap.[CUSTOMER_DIRECT_REGION_CODE],		c.[REGION__CODE]),
       [CUSTOMER_DIRECT_REGION_DESCR]		= IIF(c.[REGION] IS NULL OR LEN(c.[REGION]) = 0,						sap.[CUSTOMER_DIRECT_REGION_DESCR],		c.[REGION]),
       [CUSTOMER_DIRECT_SALES_AREA_CODE]	= IIF(c.[SALES_AREA__CODE] IS NULL OR LEN(c.[SALES_AREA__CODE]) = 0,	sap.[CUSTOMER_DIRECT_SALES_AREA_CODE],	c.[SALES_AREA__CODE]),
       [CUSTOMER_DIRECT_SALES_AREA_DESCR]	= IIF(c.[SALES_AREA] IS NULL OR LEN(c.[SALES_AREA]) = 0,				sap.[CUSTOMER_DIRECT_SALES_AREA_DESCR], c.[SALES_AREA])
FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE] sap
LEFT OUTER JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[MD].[dbo].[CUSTOMER_ASHIPTO_FLAT] c ON sap.[CUSTOMER_DIRECT_SHIPTO_CODE] = c.[CODE]






-- Customer Final - Code
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
   SET [CUSTOMER_FINAL_CODE] = IIF(c.[CUSTOMER__CODE] IS NULL OR LEN(c.[CUSTOMER__CODE]) = 0, sap.[CUSTOMER_FINAL_CODE], c.[CUSTOMER__CODE])
FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE] sap
LEFT OUTER JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[MD].[dbo].[CUSTOMER_SHIP_TO] c ON sap.[CUSTOMER_FINAL_SHIPTO_CODE] = c.[CUST_SHIP_TO_ID]







-- Customer Final - Name
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
   SET [CUSTOMER_FINAL_DESCR] = IIF(c.[SHORT_NAME] IS NULL OR LEN(c.[SHORT_NAME]) = 0, sap.[CUSTOMER_FINAL_DESCR], c.[SHORT_NAME])
FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE] sap
LEFT OUTER JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[MD].[dbo].[CUSTOMER] c ON sap.[CUSTOMER_FINAL_CODE] = c.[CODE]





-- Customer Final - Type code
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
   SET [CUSTOMER_FINAL_TYPE_CODE] = IIF(c.[CUSTOMER_TYPE__CODE] IS NULL OR LEN(c.[CUSTOMER_TYPE__CODE]) = 0, sap.[CUSTOMER_FINAL_TYPE_CODE], c.[CUSTOMER_TYPE__CODE])
FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE] sap
LEFT OUTER JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[MD].[dbo].[CUSTOMER] c ON sap.[CUSTOMER_FINAL_CODE] = c.[CODE]





-- Customer Final - Type descr
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
   SET [CUSTOMER_FINAL_TYPE_DESCR] = IIF(c.[DESCR] IS NULL OR LEN(c.[DESCR]) = 0, sap.[CUSTOMER_FINAL_TYPE_DESCR], c.[DESCR])
FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE] sap
LEFT OUTER JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[MD].[dbo].[CUSTOMER_TYPE] c ON sap.[CUSTOMER_FINAL_TYPE_CODE] = c.[CODE]







-- Customer Final - Group descr
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
   SET [CUSTOMER_FINAL_GROUP_DESCR] = IIF(c.[DESCR] IS NULL OR LEN(c.[DESCR]) = 0, sap.[CUSTOMER_FINAL_GROUP_DESCR], c.[DESCR])
FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE] sap
LEFT OUTER JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[MD].[dbo].[CUSTOMER_GROUP] c ON sap.[CUSTOMER_FINAL_GROUP_CODE] = c.[CODE]







-- Customer Final - Ship-to descr
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
   SET [CUSTOMER_FINAL_SHIPTO_DESCR] = IIF(c.[SHORT_NAME] IS NULL OR LEN(c.[SHORT_NAME]) = 0, sap.[CUSTOMER_FINAL_SHIPTO_DESCR], c.[SHORT_NAME])
FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE] sap
LEFT OUTER JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[MD].[dbo].[CUSTOMER_SHIP_TO] c ON sap.[CUSTOMER_FINAL_SHIPTO_CODE] = c.[CUST_SHIP_TO_ID]





-- Customer Final - Region, Area
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
   SET [CUSTOMER_FINAL_REGION_CODE]			= IIF(c.[REGION__CODE] IS NULL OR LEN(c.[REGION__CODE]) = 0,			sap.[CUSTOMER_FINAL_REGION_CODE],		c.[REGION__CODE]),
       [CUSTOMER_FINAL_REGION_DESCR]		= IIF(c.[REGION] IS NULL OR LEN(c.[REGION]) = 0,						sap.[CUSTOMER_FINAL_REGION_DESCR],		c.[REGION]),
       [CUSTOMER_FINAL_SALES_AREA_CODE]		= IIF(c.[SALES_AREA__CODE] IS NULL OR LEN(c.[SALES_AREA__CODE]) = 0,	sap.[CUSTOMER_FINAL_SALES_AREA_CODE],	c.[SALES_AREA__CODE]),
       [CUSTOMER_FINAL_SALES_AREA_DESCR]	= IIF(c.[SALES_AREA] IS NULL OR LEN(c.[SALES_AREA]) = 0,				sap.[CUSTOMER_FINAL_SALES_AREA_DESCR],	c.[SALES_AREA])
FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE] sap
LEFT OUTER JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[MD].[dbo].[CUSTOMER_ASHIPTO_FLAT] c ON sap.[CUSTOMER_FINAL_SHIPTO_CODE] = c.[CODE]





-- POSTING_IN_TARIFF301
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
	SET [POSTING_IN_TARIFF301] = 
		IIF([REASON_CODE] IN ('0G21','0G01','0G11'),'tariff_301',
			IIF([COMPANY_CODE]='STXX',
				IIF([SENDER_COST_CENTER]='XXWW02','no_tariff_301',
					'no_tariff_301'), 'no_tariff_301'))
FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]







-- NET_SALES
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
	SET [NET_SALES] = [SALES_PRODUCT] + [SALES_MATERIALS] + [GROSS_SALES] + [RETURNS] + [OTHER_DEDUCTIONS] 
FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]



-- NET_REVENUES
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
	SET [NET_REVENUES] = [NET_SALES] + [OTHER_REVENUES]
FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]






-- Estrae dati da PNL
-- ---------------------------------------------------
TRUNCATE TABLE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP]

INSERT INTO [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP]
SELECT

	-- Period
	[YEAR (Yyyyy)],
	[YEAR (Yyy)],
	[QUARTER (yyyyQq)],
	[QUARTER (yyQq)],
	[MONTH (yyyyMmm)],
	[MONTH (yyMmm)],

	-- Organization
	[GROUP_CODE_ORIGINAL],
	[SUBGROUP_CODE_ORIGINAL],
	[DIV_CODE_ORIGINAL],
	[BU_CODE_ORIGINAL],
	[BU_CODE_CURRENT],

	-- Product
	[CP],
	[PRODUCT_LINE_ORIGINAL],
	[PRODUCT_LINE_CURRENT],

	-- Reason
	[REASON_CODE],
	[REASON_DESCR],
	[REASON_TYPE],
	[REASON_FLAG_QUANTITY],

	-- Customer Direct
	[CUSTOMER_DIRECT_CODE],
	[CUSTOMER_DIRECT_DESCR],
	[CUSTOMER_DIRECT_TYPE_CODE],
	[CUSTOMER_DIRECT_TYPE_DESCR],
	[CUSTOMER_DIRECT_GROUP_CODE],
	[CUSTOMER_DIRECT_GROUP_DESCR],
	[CUSTOMER_DIRECT_SHIPTO_CODE],
	[CUSTOMER_DIRECT_SHIPTO_DESCR],
	[CUSTOMER_DIRECT_REGION_CODE],
	[CUSTOMER_DIRECT_REGION_DESCR],
	[CUSTOMER_DIRECT_SALES_AREA_CODE],
	[CUSTOMER_DIRECT_SALES_AREA_DESCR],

	-- Customer Final
	[CUSTOMER_FINAL_CODE],
	[CUSTOMER_FINAL_DESCR],
	[CUSTOMER_FINAL_TYPE_CODE],
	[CUSTOMER_FINAL_TYPE_DESCR],
	[CUSTOMER_FINAL_GROUP_CODE],
	[CUSTOMER_FINAL_GROUP_DESCR],
	[CUSTOMER_FINAL_SHIPTO_CODE],
	[CUSTOMER_FINAL_SHIPTO_DESCR],
	[CUSTOMER_FINAL_REGION_CODE],
	[CUSTOMER_FINAL_REGION_DESCR],
	[CUSTOMER_FINAL_SALES_AREA_CODE],
	[CUSTOMER_FINAL_SALES_AREA_DESCR],

	-- Data
	SUM([NET_QTY]) AS [NET_QTY],
	SUM([NET_QTY_BIBA]) AS [NET_QTY_BIBA],
	SUM([NET_REVENUES]) AS [NET_REVENUES]

FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP_PRE]
WHERE
	[POSTING_IN_TARIFF301] = 'no_tariff_301'
GROUP BY
	[YEAR (Yyyyy)],
	[YEAR (Yyy)],
	[QUARTER (yyyyQq)],
	[QUARTER (yyQq)],
	[MONTH (yyyyMmm)],
	[MONTH (yyMmm)],
	[GROUP_CODE_ORIGINAL],
	[SUBGROUP_CODE_ORIGINAL],
	[DIV_CODE_ORIGINAL],
	[BU_CODE_ORIGINAL],
	[BU_CODE_CURRENT],
	[CP],
	[PRODUCT_LINE_ORIGINAL],
	[PRODUCT_LINE_CURRENT],
	[REASON_CODE],
	[REASON_DESCR],
	[REASON_TYPE],
	[REASON_FLAG_QUANTITY],
	[CUSTOMER_DIRECT_CODE],
	[CUSTOMER_DIRECT_DESCR],
	[CUSTOMER_DIRECT_TYPE_CODE],
	[CUSTOMER_DIRECT_TYPE_DESCR],
	[CUSTOMER_DIRECT_GROUP_CODE],
	[CUSTOMER_DIRECT_GROUP_DESCR],
	[CUSTOMER_DIRECT_SHIPTO_CODE],
	[CUSTOMER_DIRECT_SHIPTO_DESCR],
	[CUSTOMER_DIRECT_REGION_CODE],
	[CUSTOMER_DIRECT_REGION_DESCR],
	[CUSTOMER_DIRECT_SALES_AREA_CODE],
	[CUSTOMER_DIRECT_SALES_AREA_DESCR],
	[CUSTOMER_FINAL_CODE],
	[CUSTOMER_FINAL_DESCR],
	[CUSTOMER_FINAL_TYPE_CODE],
	[CUSTOMER_FINAL_TYPE_DESCR],
	[CUSTOMER_FINAL_GROUP_CODE],
	[CUSTOMER_FINAL_GROUP_DESCR],
	[CUSTOMER_FINAL_SHIPTO_CODE],
	[CUSTOMER_FINAL_SHIPTO_DESCR],
	[CUSTOMER_FINAL_REGION_CODE],
	[CUSTOMER_FINAL_REGION_DESCR],
	[CUSTOMER_FINAL_SALES_AREA_CODE],
	[CUSTOMER_FINAL_SALES_AREA_DESCR]













-- Cancella eventuali record gia' esistenti nella tabella
-- ---------------------------------------------------
DELETE FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT] 
WHERE [MONTH (yyyyMmm)] = SUBSTRING(@MONTH,2,4) + 'M' + SUBSTRING(@MONTH,6,2) 


-- Append
-- ---------------------------------------------------
INSERT INTO [ROYALTY].[dbo].[ROYALTY_SAP_ACT]
SELECT *
FROM [ROYALTY].[dbo].[ROYALTY_SAP_ACT_TEMP]














