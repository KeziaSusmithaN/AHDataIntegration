







/*
SELECT * FROM [ctrl].[fnGetODSSourceObjects] ('ODS')
UNION ALL
SELECT * FROM [ctrl].[fnGetEDWSourceObjects] ('EDW')
*/
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE FUNCTION [ctrl].[fnGetODSSourceObjects]
(	
	@SourceObjectType varchar(10)='ODS'
)
RETURNS TABLE 
AS
RETURN 
(	
	SELECT DISTINCT 
		SourceObjectType, BusinessFunctionID, TargetFolderName,''''+TargetFolderName+'''' AS TargetFolderNameQuoted, 
		SourceSchema, ''''+SourceSchema+'''' AS SourceSchemaQuoted, 
		SourceObjectName, ''''+SourceObjectName+'''' AS SourceObjectNameQuoted, SourceObjectID, TargetObjectName, 
		(CASE SourceObjectType WHEN 'RCI' THEN 1 ELSE 2 END) AS GroupId,
		LandingPath, RawPath, StagePath, CuratedPath,
		1 AS FormatID, 'database' AS FormatName, GETDATE() AS ImportDatetime, BenchMarkField,
		(CASE WHEN SourceObjectName='RCI_RC_F_PATIENT_AR_BALANCE' THEN 'activity_dt_nbr> = TO_DATE(20220101, ''YYYYMMDD'') - TO_DATE(17991229, ''YYYYMMDD'')'
		WHEN SourceObjectName='AH_RC_F_PATIENT_AR_BALANCE' THEN 'activity_dt_nbr> = TO_DATE(20220101, ''YYYYMMDD'') - TO_DATE(17991229, ''YYYYMMDD'')'
		ELSE '1=1' END) AS BenchMarkCondition, 
		'ahaidq' AS AdlsContainerName, 'ODS' AS TargetSchema, ROW_NUMBER() OVER(ORDER BY SourceObjectName) AS RowID				
	FROM (
			SELECT 				
			[BusinessFunctionID], SourceObjectID, [temp_EDW_Schema] AS [TargetFolderName],[temp_EDW_Schema] AS [SourceSchema],
			[temp_EDW_Table_Name] AS [SourceObjectName],[temp_EDW_Table_Name] AS [TargetObjectName], BenchMarkField,
			'bronze/AH_ANALYTICS' AS LandingPath, NULL AS RawPath, NULL AS StagePath, 'gold/edwtest' AS CuratedPath, 				
			(CASE WHEN SourceObjectName LIKE 'RCI%' THEN 'RCI' ELSE 'AH' END) AS SourceObjectType
			FROM [ctrl].[SourceObject]
			WHERE --[IsActive]=1 
			[temp_EDW_Schema] IN ('AH_ANALYTICS')  
			AND [temp_EDW_Table_Name] IN ('AH_RC_F_PATIENT_AR_BALANCE','RCI_RC_F_PATIENT_AR_BALANCE',
				'ah_omf_date','ah_rc_d_balance_type','ah_rc_d_dnfb_status','rci_omf_date','rci_rc_d_balance_type')
	) so 		
	WHERE SourceObjectType=(CASE WHEN @SourceObjectType='ODS' THEN SourceObjectType ELSE @SourceObjectType END)
)