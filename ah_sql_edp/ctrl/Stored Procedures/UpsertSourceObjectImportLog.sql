
CREATE PROCEDURE ctrl.UpsertSourceObjectImportLog
AS
BEGIN
	UPDATE  S1 SET
		[LastImportDate]=ISNULL(S2.CreatedDate,DATEADD(day,1,S2.CreatedDate)),
		[LastImportRows]=ISNULL(S2.[RecordsImported],0),
		[LastImportStatus]=ISNULL(S2.[Status],'Succeeded')
	FROM [ctrl].[SourceObjectImportLog] S1
	INNER JOIN
		(SELECT L1.SourceObjectID, L1.CreatedDate, L1.[RecordsImported], L1.[Status]
		FROM [log].[PipelineExecutionLog] L1, 
			(SELECT SourceObjectID, MAX(CreatedDate) MaxCreatedDate 
			FROM [log].[PipelineExecutionLog] 
			WHERE CreatedDate>=format(GETDATE(),'yyyy-MM-dd')
			GROUP BY SourceObjectID) L2
		WHERE L1.SourceObjectID=L2.SourceObjectID AND L1.CreatedDate=L2.MaxCreatedDate) S2
	ON S1.SourceObjectID=S2.SourceObjectID

END