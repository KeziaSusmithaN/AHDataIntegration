CREATE TABLE [ctrl].[Stage_SourceObject] (
    [Target_Folder_Name]      NVARCHAR (255)  NULL,
    [Source_Schema]           NVARCHAR (255)  NULL,
    [Source_Table_Name]       NVARCHAR (255)  NULL,
    [temp_EDW_Schema]         NVARCHAR (255)  NULL,
    [temp_EDW_Table_Name]     NVARCHAR (255)  NULL,
    [Target_Table_Name]       NVARCHAR (255)  NULL,
    [Table_Size (MB)]         FLOAT (53)      NULL,
    [ETL_Tbl_Control_Key]     NVARCHAR (255)  NULL,
    [BenchMarkField]          NVARCHAR (255)  NULL,
    [BenchMarkValue]          NVARCHAR (255)  NULL,
    [temp_EDW_BenchMarkField] NVARCHAR (255)  NULL,
    [temp_EDW_BenchMarkValue] NVARCHAR (255)  NULL,
    [Table_Comments]          NVARCHAR (MAX)  NULL,
    [isActive]                NVARCHAR (5)    NULL,
    [Business_Function_Tags]  NVARCHAR (1000) NULL,
    [LoadType]                VARCHAR (20)    NULL,
    [LoadFrequency]           VARCHAR (10)    NULL,
    [SourceFormat]            VARCHAR (10)    NULL,
    [FieldDelimiter]          VARCHAR (10)    NULL
);

