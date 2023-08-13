

CREATE PROCEDURE [dbo].[uspFetchDataFromBenchMarkeFieldValue]
	@LoadType varchar(10)='I',
	@TableName nvarchar(255)='ratings_small',
	@BenchMarkField nvarchar(50)='timestamp',
	@BenchMarkValue nvarchar(50)='2023-02-01'
AS
BEGIN
	DECLARE @sqlquery nvarchar(1000)=''

	IF @LoadType='I' OR @BenchMarkValue=''
		SET @sqlquery = 'select * from dbo.'+@TableName
	ELSE
		SET @sqlquery = 'select * from dbo.'+@TableName+' where ['+@BenchMarkField+'] > '''+@BenchMarkValue+''''

	EXEC(@sqlquery)
END