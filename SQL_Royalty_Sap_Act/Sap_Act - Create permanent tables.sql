

---- ---------------------------------------------------
IF OBJECT_ID('[ROYALTY].[dbo].[ROYALTY_SAP_ACT]') IS NOT NULL DROP TABLE [ROYALTY].[dbo].[ROYALTY_SAP_ACT]
CREATE TABLE [ROYALTY].[dbo].[ROYALTY_SAP_ACT] (

	-- Period
	[YEAR (Yyyyy)]							VARCHAR(MAX) NULL,
	[YEAR (Yyy)]							VARCHAR(MAX) NULL,
	[QUARTER (yyyyQq)]						VARCHAR(MAX) NULL,
	[QUARTER (yyQq)]						VARCHAR(MAX) NULL,
	[MONTH (yyyyMmm)]						VARCHAR(MAX) NULL,
	[MONTH (yyMmm)]							VARCHAR(MAX) NULL,

	-- Organization
	[GROUP_CODE_ORIGINAL]					VARCHAR(MAX) NULL,
	[SUBGROUP_CODE_ORIGINAL]				VARCHAR(MAX) NULL,
	[DIV_CODE_ORIGINAL]						VARCHAR(MAX) NULL,
	[BU_CODE_ORIGINAL]						VARCHAR(MAX) NULL,
	[BU_CODE_CURRENT]						VARCHAR(MAX) NULL,

	-- Product
	[CP]									VARCHAR(MAX) NULL,
	[PRODUCT_LINE_ORIGINAL]					VARCHAR(MAX) NULL,
	[PRODUCT_LINE_CURRENT]					VARCHAR(MAX) NULL,

	-- Reason
	[REASON_CODE]							VARCHAR(MAX) NULL,
	[REASON_DESCR]							VARCHAR(MAX) NULL,
	[REASON_TYPE]							VARCHAR(MAX) NULL,
	[REASON_FLAG_QUANTITY]					VARCHAR(MAX) NULL,

	-- Customer Direct
	[CUSTOMER_DIRECT_CODE]					VARCHAR(MAX) NULL,
	[CUSTOMER_DIRECT_DESCR]					VARCHAR(MAX) NULL,
	[CUSTOMER_DIRECT_TYPE_CODE]				VARCHAR(MAX) NULL,
	[CUSTOMER_DIRECT_TYPE_DESCR]			VARCHAR(MAX) NULL,
	[CUSTOMER_DIRECT_GROUP_CODE]			VARCHAR(MAX) NULL,
	[CUSTOMER_DIRECT_GROUP_DESCR]			VARCHAR(MAX) NULL,
	[CUSTOMER_DIRECT_SHIPTO_CODE]			VARCHAR(MAX) NULL,
	[CUSTOMER_DIRECT_SHIPTO_DESCR]			VARCHAR(MAX) NULL,
	[CUSTOMER_DIRECT_REGION_CODE]			VARCHAR(MAX) NULL,
	[CUSTOMER_DIRECT_REGION_DESCR]			VARCHAR(MAX) NULL,
	[CUSTOMER_DIRECT_SALES_AREA_CODE]		VARCHAR(MAX) NULL,
	[CUSTOMER_DIRECT_SALES_AREA_DESCR]		VARCHAR(MAX) NULL,

	-- Customer Final
	[CUSTOMER_FINAL_CODE]					VARCHAR(MAX) NULL,
	[CUSTOMER_FINAL_DESCR]					VARCHAR(MAX) NULL,
	[CUSTOMER_FINAL_TYPE_CODE]				VARCHAR(MAX) NULL,
	[CUSTOMER_FINAL_TYPE_DESCR]				VARCHAR(MAX) NULL,
	[CUSTOMER_FINAL_GROUP_CODE]				VARCHAR(MAX) NULL,
	[CUSTOMER_FINAL_GROUP_DESCR]			VARCHAR(MAX) NULL,
	[CUSTOMER_FINAL_SHIPTO_CODE]			VARCHAR(MAX) NULL,
	[CUSTOMER_FINAL_SHIPTO_DESCR]			VARCHAR(MAX) NULL,
	[CUSTOMER_FINAL_REGION_CODE]			VARCHAR(MAX) NULL,
	[CUSTOMER_FINAL_REGION_DESCR]			VARCHAR(MAX) NULL,
	[CUSTOMER_FINAL_SALES_AREA_CODE]		VARCHAR(MAX) NULL,
	[CUSTOMER_FINAL_SALES_AREA_DESCR]		VARCHAR(MAX) NULL,

	-- Data
	[NET_QTY]								FLOAT NULL,
	[NET_QTY_BIBA]							FLOAT NULL,
	[NET_REVENUES]							FLOAT NULL

) ON [PRIMARY]




---- ---------------------------------------------------
IF OBJECT_ID('[ROYALTY].[dbo].[ROYALTY_SAP_ACT_MONTH_LAST_UPDATE]') IS NOT NULL DROP TABLE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_MONTH_LAST_UPDATE]
CREATE TABLE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_MONTH_LAST_UPDATE] (
	[MONTH]			VARCHAR(MAX) NULL,
	[MONTH_COUNT]	FLOAT NULL

) ON [PRIMARY]


INSERT INTO [ROYALTY].[dbo].[ROYALTY_SAP_ACT_MONTH_LAST_UPDATE]
SELECT
	'M' + LEFT([Period year],4) + RIGHT([Period year],2)			AS [MONTH],
	COUNT('M' + LEFT([Period year],4) + RIGHT([Period year],2))		AS [MONTH_COUNT]
FROM [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[PNL].[dbo].[PNL]
WHERE
	LEFT([Period year],4) >= '2022'
GROUP BY
	'M' + LEFT([Period year],4) + RIGHT([Period year],2)
ORDER BY
	'M' + LEFT([Period year],4) + RIGHT([Period year],2)









