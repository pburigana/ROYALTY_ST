



-- CURRENT BU e PL con la nuova organizzazione
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[Royalty]
	SET [BU] = IIF(c.[BU_CODE] IS NULL OR LEN(c.[BU_CODE]) = 0, roy.[BU], c.[BU_CODE])
FROM [ROYALTY].[dbo].[Royalty] roy
LEFT OUTER JOIN (
		SELECT
			[PRODUCT_LINE_CODE],
			[BU_CODE]
		FROM [MD].[dbo].[PRODUCT_HIERARCHY_CURR]
	) c ON roy.[Product_Line_Code] = c.[PRODUCT_LINE_CODE]





-- CURRENT DIV, SUBGROUP, GROUP
-- ---------------------------------------------------
UPDATE [ROYALTY].[dbo].[Royalty]
   SET [Subgroup]			= IIF(c.[SUB_GROUP_DESCR] IS NULL OR LEN(c.[SUB_GROUP_DESCR]) = 0,	roy.[Subgroup],			c.[SUB_GROUP_DESCR]),
	   [Division]			= IIF(c.[DIV_CODE] IS NULL OR LEN(c.[DIV_CODE]) = 0,				roy.[Division],			c.[DIV_CODE]),
       [Division_descr]		= IIF(c.[DIV_DESCR] IS NULL OR LEN(c.[DIV_DESCR]) = 0,				roy.[Division_descr],	c.[DIV_DESCR]),
       [BU_descr]			= IIF(c.[BU_DESCR] IS NULL OR LEN(c.[BU_DESCR]) = 0,				roy.[BU_descr],			c.[BU_DESCR])
FROM [ROYALTY].[dbo].[Royalty] roy
LEFT OUTER JOIN [MD].[dbo].[PROD_ORG_CURR] c ON roy.[BU] = c.[BU_CODE]





-- CURRENT BU e PL con la nuova organizzazione
-- ---------------------------------------------------
--UPDATE [ADG_CTLDM_MANUF].[dbo].[Royalty_Forecast]
--	SET [BU] = IIF(c.[BU_CODE] IS NULL OR LEN(c.[BU_CODE]) = 0, roy.[BU], c.[BU_CODE])
--FROM [ADG_CTLDM_MANUF].[dbo].[Royalty_Forecast] roy
--LEFT OUTER JOIN (
--		SELECT
--			[PRODUCT_LINE_CODE],
--			[BU_CODE]
--		FROM [MD].[dbo].[PRODUCT_HIERARCHY_CURR]
--	) c ON roy.[Product_Line_Code] = c.[PRODUCT_LINE_CODE]





-- CURRENT DIV, SUBGROUP, GROUP
-- ---------------------------------------------------
--UPDATE [ADG_CTLDM_MANUF].[dbo].[Royalty_Forecast]
--   SET [Subgroup]			= IIF(c.[SUB_GROUP_DESCR] IS NULL OR LEN(c.[SUB_GROUP_DESCR]) = 0,	roy.[Subgroup],			c.[SUB_GROUP_DESCR]),
--	   [Division]			= IIF(c.[DIV_CODE] IS NULL OR LEN(c.[DIV_CODE]) = 0,				roy.[Division],			c.[DIV_CODE]),
--       [Division_descr]		= IIF(c.[DIV_DESCR] IS NULL OR LEN(c.[DIV_DESCR]) = 0,				roy.[Division_descr],	c.[DIV_DESCR]),
--       [BU_descr]			= IIF(c.[BU_DESCR] IS NULL OR LEN(c.[BU_DESCR]) = 0,				roy.[BU_descr],			c.[BU_DESCR])
--FROM [ADG_CTLDM_MANUF].[dbo].[Royalty_Forecast] roy
--LEFT OUTER JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[MD].[dbo].[PROD_ORG_CURR] c ON roy.[BU] = c.[BU_CODE]








