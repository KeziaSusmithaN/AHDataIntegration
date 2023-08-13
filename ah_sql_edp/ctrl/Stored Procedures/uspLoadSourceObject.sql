





CREATE PROCEDURE [ctrl].[uspLoadSourceObject]
	@UpdatedBy nvarchar(100)='PL_SourceObject_Load_csv'
AS
BEGIN
	
	DECLARE @FormatID int, @SourceConnectionID int,@LandingPath nvarchar(500), @StagePath nvarchar(500)
	DECLARE @CurrentDateTime DATETIME = GETDATE()
	/*
	UPDATE [ctrl].[Stage_SourceObject] SET 
		--[Target_Folder_Name]=UPPER([Target_Folder_Name]),
		[Target_Table_Name]=UPPER([Target_Table_Name])
		--[Source_Schema]=UPPER([Source_Schema]),
		--[Source_Table_Name]=UPPER([Source_Table_Name]);
	*/
	MERGE INTO [ctrl].[SourceObject] as TARGET  
	USING   
	(SELECT DISTINCT 
			B.[BusinessFunctionID],F.[FormatID],sc.[SourceConnectionID],[Source_Schema] as [SourceSchema]
			,[Source_Table_Name] as [SourceObjectName],[Target_Table_Name] as [TargetObjectName],[Target_Folder_Name] as [TargetFolderName]
			,(CASE WHEN [isACTIVE]='YES' THEN 1 ELSE 0 END) as [IsActive],[ETL_TBL_CONTROL_KEY]
			,[LoadType],[LoadFrequency],[SourceFormat],[FieldDelimiter]
			,(CASE 
				WHEN [isACTIVE]='YES' THEN (CASE WHEN soa.[Target_Folder_Name]<>'vmc-integration' THEN 'Y' ELSE STR(1) END) 
				WHEN [isACTIVE]='NO' THEN (CASE WHEN soa.[Target_Folder_Name]<>'vmc-integration' THEN 'N' ELSE STR(0) END) 
				ELSE NULL				
				END) as [ToBeProcessed]
			,[BenchMarkField],[BenchMarkValue] AS [BenchMarkCriteria],[TABLE_SIZE (MB)] as [TableSize_MB]
			,[Table_COMMENTS] as [TableComments],[Business_Function_Tags] as [BusinessFunctionTags]
			,'bronze/'+[Target_Folder_Name] as [BronzePath],'silver/'+[Target_Folder_Name] as [SilverPath],'gold/'+[Target_Folder_Name] as [GoldPath]
			,[temp_EDW_Schema],[temp_EDW_Table_Name],[temp_EDW_BenchMarkField],[temp_EDW_BenchMarkValue]
			,@UpdatedBy as [CreatedBy],@CurrentDateTime as [CreatedDate],@UpdatedBy as [UpdatedBy],@CurrentDateTime as [UpdatedDate]			
		FROM [ctrl].[Stage_SourceObject] soa
		LEFT JOIN [ctrl].[SourceConnection] sc ON sc.[SourceName]=(
			CASE WHEN soa.[Target_Folder_Name] IN ('AH_ANALYTICS','AH_DM','AH Castle','AH Delano','AH Mendocino Coast',
													'Integration Reference','EDW Reference','ODS Reference') THEN 'EDW'
				WHEN soa.[Target_Folder_Name]='Cerner PIC' THEN 'Cerner-PIC'
				WHEN soa.[Target_Folder_Name]='Cerner RCI' THEN 'Cerner-RCI'
				WHEN soa.[Target_Folder_Name]='vmc-integration' THEN 'VMC'
			ELSE NULL END)
		LEFT JOIN [ctrl].[BusinessFunction] B ON B.[BusinessFunctionName]=(
			CASE WHEN soa.[Target_Folder_Name] IN ('AH_ANALYTICS','AH_DM','AH Castle','AH Delano','AH Mendocino Coast',
													'Integration Reference','EDW Reference','ODS Reference','Cerner PIC','Cerner RCI') THEN 'RCM'
				WHEN soa.[Target_Folder_Name]='vmc-integration' THEN 'VMC'
				WHEN soa.Source_Schema='EDW' THEN 'RCM'
			ELSE NULL END)
		LEFT JOIN [ctrl].[FileFormat] F ON UPPER(F.[FormatName])=UPPER(soa.[SourceFormat]) AND ISNULL(F.[DelimiterInd],'')=ISNULL(soa.[FieldDelimiter],'')
		WHERE soa.[Source_TABLE_NAME] IS NOT NULL 
		--AND soa.[Target_Folder_Name] NOT IN ('Dameron Hospital Association','AH Castle','AH Delano','AH Mendocino Coast')
		--AND soa.[Target_Folder_Name] IN ('Cerner PIC','Cerner RCI')
	) as  SOURCE
	ON (TARGET.[BusinessFunctionID]=SOURCE.[BusinessFunctionID] AND TARGET.[SourceConnectionID]=SOURCE.[SourceConnectionID] 
		AND TARGET.[SourceSchema]=SOURCE.[SourceSchema] AND TARGET.[TargetFolderName]=SOURCE.[TargetFolderName] AND TARGET.[SourceObjectName]=SOURCE.[SourceObjectName])

	WHEN MATCHED THEN
		UPDATE SET 
			TARGET.[TargetObjectName]=SOURCE.[TargetObjectName],			
			TARGET.[SourceSchema]=SOURCE.[SourceSchema],
			TARGET.[TableSize_MB]=SOURCE.[TableSize_MB],
			TARGET.[ETL_TBL_CONTROL_KEY]=SOURCE.[ETL_TBL_CONTROL_KEY],
			TARGET.[TableComments]=SOURCE.[TableComments],
			TARGET.[BusinessFunctionTags]=SOURCE.[BusinessFunctionTags],
			TARGET.[LoadType]=SOURCE.[LoadType],
			TARGET.[LoadFrequency]=SOURCE.[LoadFrequency],
			TARGET.[BronzePath]=SOURCE.[BronzePath],
			TARGET.[SilverPath]=SOURCE.[SilverPath],
			TARGET.[GoldPath]=SOURCE.[GoldPath],
			TARGET.[IsActive]=SOURCE.[IsActive],
			TARGET.[ToBeProcessed]=SOURCE.[ToBeProcessed],
			TARGET.[BenchMarkField]=SOURCE.[BenchMarkField],
			TARGET.[BenchMarkCriteria]=SOURCE.[BenchMarkCriteria],
			TARGET.[SourceFormat]=SOURCE.[SourceFormat],
			TARGET.[FieldDelimiter]=SOURCE.[FieldDelimiter],
			TARGET.[temp_EDW_Schema]=SOURCE.[temp_EDW_Schema],
			TARGET.[temp_EDW_Table_Name]=SOURCE.[temp_EDW_Table_Name],
			TARGET.[temp_EDW_BenchMarkField]=SOURCE.[temp_EDW_BenchMarkField],
			TARGET.[temp_EDW_BenchMarkValue]=SOURCE.[temp_EDW_BenchMarkValue],
			TARGET.[UpdatedBy]=SOURCE.[UpdatedBy],
			TARGET.[UpdatedDate]=SOURCE.[UpdatedDate]

	WHEN NOT MATCHED BY TARGET 
	THEN INSERT 
		([BusinessFunctionID],
		[FormatID],
		[SourceConnectionID],[SourceSchema],[SourceObjectName],[IsActive],[ETL_TBL_CONTROL_KEY]
		,[TargetObjectName],[TargetFolderName],[LoadType],[ToBeProcessed],[SourceFormat],[FieldDelimiter]
		,[BenchMarkField],[BenchMarkCriteria],[TABLESIZE_MB],[TableCOMMENTS],[BusinessFunctionTags]
		,[BronzePath],[SilverPath],[GoldPath]
		,[CreatedBy],[CreatedDate],[UpdatedBy],[UpdatedDate])
	VALUES ([BusinessFunctionID],
	[FormatID],
	[SourceConnectionID],[SourceSchema],[SourceObjectName],[IsActive],[ETL_TBL_CONTROL_KEY]
		,[TargetObjectName],[TargetFolderName],[LoadType],[ToBeProcessed],[SourceFormat],[FieldDelimiter]
		,[BenchMarkField],[BenchMarkCriteria],[TABLESIZE_MB],[TableCOMMENTS],[BusinessFunctionTags]
		,[BronzePath],[SilverPath],[GoldPath]
		,[CreatedBy],[CreatedDate],[UpdatedBy],[UpdatedDate]);
END