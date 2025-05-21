

-- Copia la lista dei mesi dalla tabella NOW a PREVIOUS
-- ---------------------------------------------------
TRUNCATE TABLE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_MONTH_LAST_UPDATE]

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






