-- To allow advanced options to be changed.  
EXECUTE sp_configure 'show advanced options', 1;  
GO  
-- To update the currently configured value for advanced options.  
RECONFIGURE;  
GO  
-- To enable the feature.  
EXECUTE sp_configure 'xp_cmdshell', 1;  
GO  
-- To update the currently configured value for this feature.  
RECONFIGURE;  
GO 
DECLARE sql_cursor 
CURSOR FOR SELECT NAME FROM SYSOBJECTS WHERE XTYPE='U'; 
DECLARE @TABELA VARCHAR(100);
DECLARE @BASE varchar(255);
DECLARE @cmd varchar(255);
DECLARE @subdir varchar(255);
DECLARE @Command varchar(500);
select  @BASE = db_name();
set @subdir = 'c:\temp\'+@BASE+'\' 
EXECUTE master.dbo.xp_create_subdir @subdir
OPEN sql_cursor FETCH NEXT FROM sql_cursor INTO @TABELA 
	WHILE @@FETCH_STATUS = 0 
		BEGIN 
			BEGIN TRY 	  
			    
					SELECT @cmd = ' BCP "select * from '+@BASE+'.dbo.'+@TABELA+' ROW for xml auto, root('''+@TABELA+'''), elements" ' + 
					'queryout "'+@subdir+@TABELA+'.xml" -S 127.0.0.1 -T -w -r -t';
					EXEC xp_cmdshell @cmd; 				

			END TRY  
			BEGIN CATCH 
				print ERROR_MESSAGE();
				THROW;
			END CATCH 
		FETCH NEXT FROM sql_cursor INTO @TABELA 
	END 
CLOSE sql_cursor 
DEALLOCATE sql_cursor 
SET @Command = '"C:\Program Files\WinRAR\Rar.exe"  a -ep1  ' +@subdir+@BASE+'.rar '+@subdir+'*.xml'
EXEC MASTER..xp_cmdshell @Command
SET @Command = 'del "'+@subdir+'*.xml"';
EXEC MASTER..xp_cmdshell @Command
-- To allow advanced options to be changed.  
EXECUTE sp_configure 'show advanced options', 1;  
GO  
-- To update the currently configured value for advanced options.  
RECONFIGURE;  
GO  
-- To enable the feature.  
EXECUTE sp_configure 'xp_cmdshell', 0;  
GO  
-- To update the currently configured value for this feature.  
RECONFIGURE;  
GO 