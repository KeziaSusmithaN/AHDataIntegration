CREATE TABLE [ctrl].[DQRuleDefinition] (
    [BusinessFunctionName] NVARCHAR (100) NULL,
    [SourceName]           NVARCHAR (100) NULL,
    [SourceObjectName]     NVARCHAR (100) NULL,
    [SourceColumnName]     NVARCHAR (100) NULL,
    [DQCheckRequired]      NVARCHAR (10)  NULL,
    [NOT_NULL_Check]       NVARCHAR (100) NULL,
    [BLANK_Check]          NVARCHAR (100) NULL,
    [Date_Check]           NVARCHAR (100) NULL,
    [Email_Check]          NVARCHAR (100) NULL,
    [Future_Date]          NVARCHAR (100) NULL,
    [Numeric_Range]        NVARCHAR (100) NULL,
    [Date_Range]           NVARCHAR (100) NULL,
    [Negative_Check]       NVARCHAR (100) NULL,
    [ISINLIST_Check]       NVARCHAR (100) NULL
);

