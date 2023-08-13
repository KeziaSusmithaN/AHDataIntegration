





/*
SELECT * FROM [ctrl].[[fnGetListOfVendorFiles]]() 
WHERE TargetFolderName IN ('EPIC OHSU') 
ORDER BY TableSize_MB DESC
--TargetFolderName,GroupID,RowNumber
*/
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE FUNCTION [ctrl].[fnGetListOfVendorFiles]()
RETURNS TABLE 
AS
RETURN 
(
	WITH SourceObjects AS (
		SELECT DISTINCT 
			BusinessFunctionID, TargetFolderName, GroupID, RowNumber, SourceObjectID, SourceSchema, SourceObjectName, TargetObjectName, 
			AdlsContainerName, SourcePath, LandingPath, RawPath, StagePath, CuratedPath, 
			ff.FormatID, (case [TargetFolderName] when 'Cerner RCI' then 'database-rci' when 'Cerner PIC' then 'database-pic' when 'EPIC OHSU' then 'database-epic' else ff.FormatName end) FormatName, ff.DelimiterInd ,ff.[Compression], '*'+'.'+ff.FormatName FormatNaming,
			BenchMarkField, BenchMarkCondition,	LoadType, sc.[ServerName], sc.[Port], sc.[ServiceName], sc.UserName, sc.[PasswordKVKey],
			[TableSize_MB], TableCount,  
			''''+SourceSchema+'''' AS SourceSchemaQuoted, ''''+SourceObjectName+'''' AS SourceObjectNameQuoted, ''''+TargetFolderName+'''' AS TargetFolderNameQuoted, 
			GETDATE() AS ImportDatetime
		FROM (	
			SELECT C.AdlsContainerName, A.*, 
				(CASE WHEN Rownumber<=B.BucketSize THEN 1 
					  WHEN (Rownumber%B.BucketSize)=0 THEN (Rownumber/BucketSize) 
					  ELSE (Rownumber/B.BucketSize)+1 
				END) AS GroupID
			FROM (				
					SELECT [BusinessFunctionID],[TargetFolderName],[SourceSchema],[SourceObjectName],[TargetObjectName],							
						S.[SourceObjectID], FormatID, SourceConnectionID, 
						'RevenueCycle-FileStore-'+S.TargetFolderName+'/08012023' AS SourcePath,RIGHT(S.[SourceObjectName],3) FileType,
						BronzePath AS LandingPath,BronzePath AS RawPath,SilverPath AS StagePath,GoldPath AS CuratedPath,						
						[BenchMarkField], [BenchMarkCriteria],
						--(CASE WHEN L.LastImportDate IS NULL THEN '1=1' ELSE [BenchMarkField]+'>=sysdate - interval '''+CAST((CASE WHEN L.LastImportStatus='Failed' THEN (DATEDIFF(hh,L.LastImportDate,GETDATE())+CAST(REPLACE([BenchMarkCriteria],' hrs','') AS INT)-24) ELSE CAST(REPLACE([BenchMarkCriteria],' hrs','') AS INT) END) AS varchar)+''' hour' END) AS BenchMarkCondition, 
						(CASE WHEN L.LastImportDate IS NULL THEN '1=1' ELSE [BenchMarkField]+'>=sysdate - interval '''+CAST((DATEDIFF(hh,L.LastImportDate,GETDATE())+26) AS varchar)+''' hour' END) AS BenchMarkCondition, 
						(CASE WHEN L.LastImportDate IS NULL THEN 'FULL' ELSE 'INCR' END) AS LoadType,
						--S.LoadType
						[TableSize_MB],	
						ROW_NUMBER() OVER(PARTITION BY [TargetFolderName] ORDER BY [SourceObjectName]) AS Rownumber,
						COUNT([SourceObjectName]) OVER(PARTITION BY [TargetFolderName]) AS TableCount
					FROM [ctrl].[SourceObject] S
					LEFT JOIN [ctrl].[SourceObjectImportLog] L ON S.SourceObjectID=L.SourceObjectID
					WHERE S.[SourceSchema] ='VENDOR_FILES'
					--AND [TargetObjectName] LIKE 'PIC_CODE_VALUE%'
					AND S.[IsActive]=1 AND S.[ToBeProcessed]='Y'
					--AND S.[SourceObjectName]=(CASE WHEN S.[TargetFolderName]='EPIC OHSU' THEN 'PAT_ENC' ELSE S.[SourceObjectName] END)
				) A
				CROSS APPLY (SELECT [ConfigValue] AS BucketSize FROM [ctrl].[Configuration_Details] WHERE [ConfigKey]='BucketSize') B
				CROSS APPLY (SELECT [ConfigValue] AS AdlsContainerName FROM [ctrl].[Configuration_Details] WHERE [ConfigKey]='AdlsContainerName') C				
		) so 
		INNER JOIN [ctrl].[FileFormat] ff ON so.FormatID=ff.FormatID
		LEFT JOIN [ctrl].[SourceConnection] sc ON sc.SourceConnectionID=so.SourceConnectionID		
		) 
	SELECT T1.*, T2.SourceObjectIDList, T2.SourceObjectList, T2.TargetObjectList, 0 AS PopulateSilverDatabase
	FROM SourceObjects T1 
	INNER JOIN 
		(SELECT TargetFolderName, GroupID, 
		STRING_AGG(CONVERT(NVARCHAR(max),SourceObjectID),',') AS SourceObjectIDList,
		STRING_AGG(CONVERT(NVARCHAR(max),''''+SourceObjectName+''''),',') AS SourceObjectList,
		STRING_AGG(CONVERT(NVARCHAR(max),''''+TargetObjectName+''''),',') AS TargetObjectList
		FROM SourceObjects
		GROUP BY TargetFolderName, GroupId) T2 
	ON T1.TargetFolderName=T2.TargetFolderName AND T1.GroupId=T2.GroupID
)