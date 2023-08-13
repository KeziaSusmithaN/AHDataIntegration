CREATE TABLE [ctrl].[Stage_SourceObjectAttribute] (
    [BusinessFunctionName] NVARCHAR (50)   NULL,
    [SourceName]           NVARCHAR (50)   NULL,
    [SourceSchema]         NVARCHAR (255)  NULL,
    [SourceObjectName]     NVARCHAR (255)  NULL,
    [ColSequenceNo]        INT             NULL,
    [SourceColumnName]     NVARCHAR (100)  NULL,
    [TargetColumnName]     NVARCHAR (100)  NULL,
    [DataType]             NVARCHAR (20)   NULL,
    [Nullable]             CHAR (10)       NULL,
    [DataDefault]          NVARCHAR (250)  NULL,
    [PrimaryKeyPosition]   SMALLINT        NULL,
    [IsPrimaryKey]         BIT             NULL,
    [PartitionKey]         BIT             NULL,
    [ColLength]            SMALLINT        NULL,
    [PrecisionLength]      SMALLINT        NULL,
    [ScaleLength]          SMALLINT        NULL,
    [Comments]             NVARCHAR (4000) NULL,
    [Tags]                 NVARCHAR (4000) NULL
);

