-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION ctrl.fnGetSourceObjectMetaData()
RETURNS TABLE 
AS
RETURN 
(
	SELECT so.SourceObjectName, so.TargetObjectName, so.TargetFolderName, so.RawPath, so.StagePath, so.SourceObjectID, so.LoadType, so.BenchMarkField,
		(SELECT STRING_AGG(''''+SourceColumnName+'''',',') FROM [ctrl].[SourceObjectAttribute] WHERE [SourceObjectID]=so.SourceObjectID AND IsPrimaryKey=1) PKCols,
		(SELECT STRING_AGG(''''+SourceColumnName+'''',',') FROM [ctrl].[SourceObjectAttribute] WHERE [SourceObjectID]=so.SourceObjectID AND [Nullable]=1) NotNullCols,
		(SELECT STRING_AGG('#'+SourceColumnName+':#'+
			(CASE WHEN DataType LIKE '%char%' THEN 'string' WHEN DataType LIKE '%int%' THEN 'int' ELSE 'timestamp' END),'#,') 
		FROM [ctrl].[SourceObjectAttribute] WHERE [SourceObjectID]=so.SourceObjectID AND ISNULL(IsPrimaryKey,0)<>1) Cols
	FROM [ctrl].[fnGetListOfSourceObjects]() so
)