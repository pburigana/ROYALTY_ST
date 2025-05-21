
EXEC xp_cmdshell 'whoami'

-- OK IN NT165 che opera nel db QA
-- OK IN QA che opera nel db QA
--------------------------------------------
SELECT *
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0', 
  'Data Source="\\AGRCLFRSSQLQA.agrmfg.stmmfg.com\f$\QA_project\QA_ROYALTY\SOURCE\Agreement.xls";
  Extended Properties=Excel 12.0 Xml')...[Agreement$]



-- NOK IN NT165
-- OK IN QA
--------------------------------------------
SELECT *
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0', 
	'Data Source="\\agrfs005a-prd.agrr2.stmmfg.com\STD_FIN_REP\00 - BUSINESS_CONTINUITY\05 - OPEX\01 - ROYALTY\TEST SOURCE\Agreement_TEST.xls";
	Extended Properties=Excel 12.0 Xml')...[Agreement$]




-- OK IN NT165
-- OK IN QA
--------------------------------------------
EXECUTE AS LOGIN = 'sa_srm'
GO
	SELECT *
	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0', 
		'Data Source="\\agrfs005a-prd.agrr2.stmmfg.com\STD_FIN_REP\00 - BUSINESS_CONTINUITY\05 - OPEX\01 - ROYALTY\TEST SOURCE\Agreement_TEST.xls";
		Extended Properties=Excel 12.0 Xml')...[Agreement$]
GO
REVERT
GO





-- NOK in NT165 ma in QA funziona
--------------------------------------------
EXECUTE AS LOGIN = 'sa_srm'
GO
SELECT *
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0', 
  'Data Source="\\agrfs005a-prd.agrr2.stmmfg.com\STD_FIN_REP\Agreement.xls";
  Extended Properties=Excel 12.0 Xml')...[Agreement$]
GO
REVERT
GO









EXEC master.dbo.xp_cmdshell 'DIR \\agrfs005a-prd.agrr2.stmmfg.com\STD_FIN_REP\'
EXEC master.dbo.xp_cmdshell 'TYPE \\agrfs007a-mfg.agr.st.com\ADGCTLG\CTLG\Agreement.xls'

EXEC master.dbo.xp_dirtree '\\agrfs005a-prd.agrr2.stmmfg.com\STD_FIN_REP\', 1, 1



SELECT * FROM sys.dm_io_cluster_shared_drives
  


DECLARE @FileList TABLE(FileNumber INT IDENTITY, FileName VARCHAR(256))
DECLARE @path VARCHAR(256) = 'dir \\AGRCLFRSSQLQA.agrmfg.stmmfg.com\f$\QA_project\QA_ROYALTY\SOURCE\'
DECLARE @Command varchar(1024) =  @Path + ' /A-D  /B'
INSERT INTO @FileList
EXEC master.dbo.xp_cmdshell @Command
SELECT *
FROM @FileList;





EXEC Master.dbo.xp_fileexist 'S:\Agreement.xls'


EXEC Master.dbo.xp_cmdshell 'dir c:\ /B'



-- SQL Server 2017 onwards dmv  
SELECT file_or_directory_name  
   , level, is_directory, creation_time, size_in_bytes  
FROM sys.dm_os_enumerate_filesystem  
(  
   N'C:\' , N'*.*'  
);  
  
SELECT file_or_directory_name  
   , level, is_directory, creation_time, size_in_bytes  
FROM sys.dm_os_enumerate_filesystem(N'T:\', N'*.*');  


EXEC xp_dirtree '\\agrfs007a-mfg.agr.st.com\ADGCTLG\CTLG', 1, 1

--WHERE file_or_directory_name like '%_raw.xml';  
  
---- bonus stuff  
---- ============================================================  
--SELECT * FROM sys.dm_os_file_exists('c:\Windows\notepad.exe');  
  
--SELECT fixed_drive_path  
--    ,free_space_in_bytes / (1024 * 1024) 'Free Space (GB)'  
--    ,drive_type_desc  
--FROM sys.dm_os_enumerate_fixed_drives;  
---- ============================================================ 




DECLARE @SQL_STRING NVARCHAR(MAX)
DECLARE @EPM_FileName NVARCHAR(MAX)

SET @EPM_FileName = ?

TRUNCATE TABLE [EPM].[dbo].[EPM_SMF_Temp]


SET @SQL_STRING = 
	'BULK INSERT [EPM].[dbo].[EPM_SMF_Temp] ' +
	'FROM ''' + @EPM_FileName + ''' ' +
	'WITH (
		FORMAT = ''CSV'', 
		FIRSTROW = 2,	
		FIELDTERMINATOR = '','', 
		ROWTERMINATOR = ''0x0a'' )'
EXEC (@SQL_STRING)





DECLARE @PATH NVARCHAR(MAX)
SET @PATH = 'S:\'

SELECT 
	file_or_directory_name,
	level, 
	is_directory
FROM sys.dm_os_enumerate_filesystem(N'\\AGRCLFRSSQLQA.agrmfg.stmmfg.com\', N'*.*');  



--  Declare a table variable:
DECLARE @fileList TABLE([FileName] VARCHAR(50), [depth] TINYINT, [isFile] BIT);
--  Fill the table with a file list:
INSERT INTO @fileList
EXEC xp_dirtree '\\AGRCLFRSSQLQA.agrmfg.stmmfg.com\f$\QA_project\QA_ROYALTY\SOURCE\', 2, 1
--  Get the list of files in the table:
SELECT [FileName],
       depth,
       isFile
FROM @fileList
ORDER BY [FileName];





SELECT *
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0', 
  'Data Source="\\agrfs007a-mfg.agr.st.com\ADGCTLG\CTLG\TM\PROJECTS - PAOLO\ROYALTY V3\SOURCE\Agreement da disco di rete.xls";
  Extended Properties=Excel 12.0 Xml')...[Agreement$]




----  Declare a table variable:
--DECLARE @fileList TABLE([FileName] VARCHAR(50), [depth] TINYINT, [isFile] BIT);
----  Fill the table with a file list:
--INSERT INTO @fileList
--EXEC xp_dirtree '\\agrfs007a-mfg.agr.st.com\ADGCTLG\CTLG\TM\PROJECTS - PAOLO\ROYALTY V3\SOURCE\', 2, 1
----  Get the list of files in the table:
--SELECT [FileName],
--       depth,
--       isFile
--FROM @fileList
--ORDER BY [FileName];

--EXEC master.sys.xp_dirtree '\\agrfs007a-mfg.agr.st.com\ADGCTLG\CTLG\TM',0,1


DECLARE @FileList TABLE(FileNumber INT IDENTITY, FileName VARCHAR(256))

DECLARE @path VARCHAR(256) = 'dir "\\agrfs007a-mfg.agr.st.com\ADGCTLG\CTLG\TM\"'
DECLARE @Command varchar(1024) =  @Path + ' /A-D  /B'

INSERT INTO @FileList
EXEC master.dbo.xp_cmdshell @Command

SELECT *
FROM @FileList;

EXEC xp_cmdshell 'whoami'

EXECUTE AS LOGIN='ST\paolo burigana'
EXEC xp_cmdshell 'whoami'



EXEC sp_configure 'show advanced options', 1
GO
RECONFIGURE
GO
EXEC sp_configure 'xp_cmdshell', 1
GO
RECONFIGURE
GO
EXEC xp_cmdshell 'whoami'


EXEC sp_xp_cmdshell_proxy_account 'ST\paolo burigana','Dadadadada-25'
SELECT *
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0', 
  'Data Source="\\agrfs007a-mfg.agr.st.com\ADGCTLG\CTLG\TM\PROJECTS - PAOLO\ROYALTY V3\SOURCE\Agreement da disco di rete.xls";
  Extended Properties=Excel 12.0 Xml')...[Agreement$]

OPENDATASOURCE('SQLNCLI', 'Data Source=server_name;uid=domain\username;pwd="`password"')



USE master;
GO
EXECUTE sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
EXECUTE sp_configure 'xp_cmdshell', 1;
GO
RECONFIGURE;
GO
EXECUTE sp_configure 'show advanced options', 0;
GO
RECONFIGURE;
GO

EXEC xp_cmdshell 'whoami'










st\agrmssql svc



SELECT *
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0', 
  'Data Source="\\AGRCLFRSSQLQA.agrmfg.stmmfg.com\f$\QA_project\QA_ROYALTY\SOURCE\Agreement.xls";
  Extended Properties=Excel 12.0 Xml')...[Agreement$]


OPENDATASOURCE('SQLNCLI', 'Data Source=server_name;uid=domain\username;pwd="`password"')
SELECT *
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0', 
  'Data Source="\\AGRCLFRSSQLQA.agrmfg.stmmfg.com\f$\QA_project\QA_ROYALTY\SOURCE\Agreement.xls";
  uid="ST\paolo burigana";pwd="Dadadadada-25";
  Extended Properties=Excel 12.0 Xml')...[Agreement$]

select session_id,auth_scheme from sys.dm_exec_connections 







---- Import data
--TRUNCATE TABLE [ROYALTY].[dbo].[Royalty] 

--EXECUTE AS LOGIN = 'sa_srm'
--GO
--	INSERT INTO [ROYALTY].[dbo].[Royalty] 
--	SELECT *
--	FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0', 
--		'Data Source="\\agrfs005a-prd.agrr2.stmmfg.com\STD_FIN_REP\00 - BUSINESS_CONTINUITY\05 - OPEX\01 - ROYALTY\TEST SOURCE\Init_TEST.xls";
--		Extended Properties=Excel 12.0 Xml')...[Init$]
--GO
--REVERT
--GO

---- Remove NULL rows
--DELETE FROM [ROYALTY].[dbo].[Royalty] WHERE [Year] IS NULL









