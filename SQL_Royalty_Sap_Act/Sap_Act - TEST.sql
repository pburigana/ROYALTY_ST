SELECT 
	last_user_update
FROM sys.dm_db_index_usage_stats
WHERE  
	database_id = db_id() AND
	object_id = object_id('[AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[PNL].[dbo].[PNL]') 



SELECT 
	last_user_update, 
	t.name
FROM [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[PNL].[sys].[dm_db_index_usage_stats] us
JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[PNL].[sys].[tables] t
	ON t.object_id = us.object_id
WHERE 
	database_id = db_id()



SELECT 
	last_user_update, 
	t.name
FROM [PNL].[sys].[dm_db_index_usage_stats] us
JOIN [PNL].[sys].[tables] t
	ON t.object_id = us.object_id
WHERE 
	database_id = db_id()


SELECT 
	us.*, 
	t.[name]
FROM [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[PNL].[sys].[dm_db_index_usage_stats] us
JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[PNL].[sys].[tables] t
	ON t.object_id = us.object_id
WHERE 
	t.[name] = 'PNL'



SELECT 
	t.[name]					AS [TABLE_NAME],
	MAX(us.[last_user_update])	AS [LAST_UPDATE]
FROM [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[PNL].[sys].[dm_db_index_usage_stats] us
JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[PNL].[sys].[tables] t
	ON t.[object_id] = us.[object_id]
WHERE
	t.[name] = 'PNL'
GROUP BY 
	t.[object_id],
	t.[name]
ORDER BY 
	MAX(us.[last_user_update]) DESC;





SELECT 
	t.[name] AS [TableName],
	MAX(us.[last_user_update]) [LastUpdate]
FROM [ROYALTY].[sys].[dm_db_index_usage_stats] us
JOIN [ROYALTY].[sys].[tables] t
	ON t.[object_id] = us.[object_id]
WHERE
	t.[name] = 'ROYALTY_SAP_ACT'
GROUP BY 
	t.[object_id],
	t.[name]
ORDER BY 
	MAX(us.[last_user_update]) DESC;


	
---- ---------------------------------------------------
IF OBJECT_ID('[ROYALTY].[dbo].[ROYALTY_SAP_ACT_PNL_LAST_UPDATE]') IS NOT NULL DROP TABLE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_PNL_LAST_UPDATE]
CREATE TABLE [ROYALTY].[dbo].[ROYALTY_SAP_ACT_PNL_LAST_UPDATE] (
	[TABLE_NAME]	VARCHAR(MAX) NULL,
	[LAST_UPDATE]	DATETIME NULL

) ON [PRIMARY]


INSERT INTO [ROYALTY].[dbo].[ROYALTY_SAP_ACT_PNL_LAST_UPDATE]
SELECT 
	t.[name]					AS [TABLE_NAME],
	MAX(us.[last_user_update])	AS [LAST_UPDATE]
FROM [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[PNL].[sys].[dm_db_index_usage_stats] us
JOIN [AGRCLFRSSQLPR.AGRMFG.STMMFG.COM\SRMPRD].[PNL].[sys].[tables] t
	ON t.[object_id] = us.[object_id]
WHERE
	t.[name] = 'PNL'
GROUP BY 
	t.[object_id],
	t.[name]
ORDER BY 
	MAX(us.[last_user_update]) DESC
