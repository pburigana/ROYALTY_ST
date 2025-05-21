
-- Parameter
--------------------------------------------
DECLARE @Period_Active NVARCHAR(MAX)
DECLARE @Qtr2 NVARCHAR(MAX)
SET @Period_Active = ?
SET @Qtr2 = ?



-- Delete all quarters greater or equal
-- ---------------------------------------------------
DELETE FROM [ROYALTY].[dbo].[Royalty]
WHERE [Qtr2] >= @Qtr2




