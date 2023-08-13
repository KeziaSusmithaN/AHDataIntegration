CREATE TABLE [ctrl].[EDWTableTransformLoad] (
    [SourceObjectLoadSeq] SMALLINT        NULL,
    [SourceObjectID]      INT             NULL,
    [EDWTableName]        VARCHAR (255)   NULL,
    [IdentityColumn]      VARCHAR (255)   NULL,
    [KeyCols]             NVARCHAR (4000) NULL,
    [SourceSystem]        NVARCHAR (4000) NULL,
    [SourceLoadSeq]       SMALLINT        NULL,
    [LoadType]            VARCHAR (10)    NULL,
    [SourceFrequency]     VARCHAR (10)    NULL,
    [EDWTableQuery]       NVARCHAR (MAX)  NULL,
    [SourceQuery]         NVARCHAR (MAX)  NULL
);

