﻿CREATE TABLE [ctrl].[SourceObject] (
    [SourceObjectID]          INT             IDENTITY (1, 1) NOT NULL,
    [BusinessFunctionID]      INT             NOT NULL,
    [FormatID]                INT             NULL,
    [SourceConnectionID]      INT             NULL,
    [SourceSchema]            NVARCHAR (255)  NULL,
    [SourceObjectName]        NVARCHAR (100)  NULL,
    [TargetObjectName]        NVARCHAR (100)  NULL,
    [TargetFolderName]        NVARCHAR (500)  NULL,
    [BronzePath]              NVARCHAR (500)  NULL,
    [SilverPath]              NVARCHAR (500)  NULL,
    [GoldPath]                NVARCHAR (500)  NULL,
    [IsActive]                BIT             NULL,
    [BenchMarkField]          NVARCHAR (500)  NULL,
    [BenchMarkCriteria]       NVARCHAR (1000) NULL,
    [BusinessFunctionTags]    NVARCHAR (1000) NULL,
    [TableSize_MB]            FLOAT (53)      NULL,
    [ETL_Tbl_Control_Key]     NVARCHAR (255)  NULL,
    [LoadType]                VARCHAR (20)    CONSTRAINT [DF_SourceObject_LoadType] DEFAULT (NULL) NULL,
    [LoadFrequency]           VARCHAR (10)    CONSTRAINT [DF_SourceObject_LoadFrequency] DEFAULT (NULL) NULL,
    [SourceFormat]            VARCHAR (10)    CONSTRAINT [DF_SourceObject_SourceFormat] DEFAULT (NULL) NULL,
    [FieldDelimiter]          VARCHAR (10)    CONSTRAINT [DF_SourceObject_FieldDelimiter] DEFAULT (NULL) NULL,
    [TableComments]           NVARCHAR (4000) NULL,
    [ToBeProcessed]           CHAR (1)        NULL,
    [CreatedBy]               NVARCHAR (100)  CONSTRAINT [DF_SourceObject_CreatedBy] DEFAULT (suser_name()) NOT NULL,
    [CreatedDate]             DATETIME        CONSTRAINT [DF_SourceObject_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]               NVARCHAR (100)  CONSTRAINT [DF_SourceObject_UpdatedBy] DEFAULT (suser_name()) NOT NULL,
    [UpdatedDate]             DATETIME        CONSTRAINT [DF_SourceObject_UpdatedDate] DEFAULT (getdate()) NOT NULL,
    [temp_EDW_Schema]         NVARCHAR (255)  CONSTRAINT [DF_SourceObject_temp_EDW_Schema] DEFAULT (NULL) NULL,
    [temp_EDW_Table_Name]     NVARCHAR (255)  CONSTRAINT [DF_SourceObject_temp_EDW_Table_Name] DEFAULT (NULL) NULL,
    [temp_EDW_BenchMarkField] NVARCHAR (255)  CONSTRAINT [DF_SourceObject_temp_EDW_BenchMarkField] DEFAULT (NULL) NULL,
    [temp_EDW_BenchMarkValue] NVARCHAR (255)  CONSTRAINT [DF_SourceObject_temp_EDW_BenchMarkValue] DEFAULT (NULL) NULL,
    CONSTRAINT [PK_SourceObject] PRIMARY KEY CLUSTERED ([SourceObjectID] ASC),
    CONSTRAINT [FK_SourceObject_BusinessFunction] FOREIGN KEY ([BusinessFunctionID]) REFERENCES [ctrl].[BusinessFunction] ([BusinessFunctionID]),
    CONSTRAINT [FK_SourceObject_FileFormat] FOREIGN KEY ([FormatID]) REFERENCES [ctrl].[FileFormat] ([FormatID]),
    CONSTRAINT [FK_SourceObject_SourceConnection] FOREIGN KEY ([SourceConnectionID]) REFERENCES [ctrl].[SourceConnection] ([SourceConnectionID])
);

