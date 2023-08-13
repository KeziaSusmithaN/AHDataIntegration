



CREATE PROCEDURE [ctrl].[uspLoadSourceObjectAttribute]
	@UpdatedBy NVARCHAR(100) = 'PL_SourceObjectAttribute_Load_csv'
AS
BEGIN
	DECLARE @CurrentDateTime DATETIME = GETDATE()

	MERGE INTO [ctrl].[SourceObjectAttribute] AS TARGET  
	USING    
		(SELECT DISTINCT so.[SourceObjectID],sso.[ColSequenceNo],sso.[SourceColumnName],sso.[TargetColumnName],sso.[DataType]
				,(CASE WHEN sso.[Nullable]='Y' THEN 1 ELSE 0 END) as [Nullable]
				,sso.[IsPrimaryKey],sso.[PartitionKey],sso.[ColLength],sso.[PrecisionLength],sso.[ScaleLength]
				,NULL as [DateFormat],so.[BusinessFunctionTags],sso.[PrimaryKeyPosition],sso.[DataDefault]
		FROM [ctrl].[SourceObject] so		
		INNER JOIN ([ctrl].[Stage_SourceObjectAttribute] sso 
		--INNER JOIN [ctrl].[BusinessFunction] b ON sso.[BusinessFunctionName]=b.[BusinessFunctionName]
		INNER JOIN [ctrl].[SourceConnection] sc ON sso.[SourceName] = sc.[SourceName])		
		--so.[BusinessFunctionID] = b.[BusinessFunctionID] AND 
		ON so.[SourceConnectionID] = sc.[SourceConnectionID] AND 
		so.SourceSchema = sso.SourceSchema AND (so.TargetObjectName = sso.SourceObjectName OR so.SourceObjectName = sso.SourceObjectName)
		) AS SOURCE 
	ON (TARGET.SourceObjectID = SOURCE.SourceObjectID AND TARGET.SourceColumnName = SOURCE.SourceColumnName)
			
	WHEN MATCHED THEN
		UPDATE SET 
			TARGET.[ColSequenceNo] =  SOURCE.[ColSequenceNo],
			TARGET.[TargetColumnName] = SOURCE.[TargetColumnName],	
			TARGET.[IsPrimaryKey] = SOURCE.[IsPrimaryKey],
			TARGET.[DataType] =  SOURCE.[DataType],
			TARGET.[Nullable] =  SOURCE.[Nullable],
			TARGET.[PartitionKey] = SOURCE.[PartitionKey],	
			TARGET.[ColLength] = SOURCE.[ColLength],
			TARGET.[PrecisionLength] =  SOURCE.[PrecisionLength],
			TARGET.[ScaleLength] = SOURCE.[ScaleLength],	
			TARGET.[DateFormat] = SOURCE.[DateFormat],
			TARGET.[BusinessFunctionTags] = SOURCE.[BusinessFunctionTags],
			TARGET.[PrimaryKeyPosition]= SOURCE.[PrimaryKeyPosition],
			TARGET.[DataDefault]= SOURCE.[DataDefault],
			TARGET.[UpdatedBy] = @UpdatedBy,
			TARGET.[UpdatedDate] = @CurrentDateTime	
	WHEN NOT MATCHED BY TARGET 
	THEN INSERT 
		([SourceObjectID],[ColSequenceNo],[SourceColumnName],[TargetColumnName],[DataType],[Nullable]
		,[IsPrimaryKey],[PartitionKey],[ColLength],[PrecisionLength],[ScaleLength]
		,[DateFormat],[BusinessFunctionTags],[PrimaryKeyPosition],[DataDefault]
		,[CreatedBy],[CreatedDate],[UpdatedBy],[UpdatedDate])
	VALUES 
		(SOURCE.[SourceObjectID],SOURCE.[ColSequenceNo],SOURCE.[SourceColumnName],SOURCE.[TargetColumnName],SOURCE.[DataType],SOURCE.[Nullable]
		,SOURCE.[IsPrimaryKey],SOURCE.[PartitionKey],SOURCE.[ColLength],SOURCE.[PrecisionLength],SOURCE.[ScaleLength]
		,SOURCE.[DateFormat],SOURCE.[BusinessFunctionTags],[PrimaryKeyPosition],[DataDefault]
		,@UpdatedBy,@CurrentDateTime,@UpdatedBy,@CurrentDateTime);
END