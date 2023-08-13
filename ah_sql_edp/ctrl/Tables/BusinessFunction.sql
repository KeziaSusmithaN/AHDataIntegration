CREATE TABLE [ctrl].[BusinessFunction] (
    [BusinessFunctionID]   INT            IDENTITY (1, 1) NOT NULL,
    [BusinessFunctionName] NVARCHAR (50)  NULL,
    [CreatedBy]            NVARCHAR (100) CONSTRAINT [DF_BusinessFunction_CreatedBy] DEFAULT (suser_name()) NOT NULL,
    [CreatedDate]          DATETIME       CONSTRAINT [DF_BusinessFunction_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]            NVARCHAR (100) CONSTRAINT [DF_BusinessFunction_UpdatedBy] DEFAULT (suser_name()) NOT NULL,
    [UpdatedDate]          DATETIME       CONSTRAINT [DF_BusinessFunction_UpdatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_BusinessFunction] PRIMARY KEY CLUSTERED ([BusinessFunctionID] ASC)
);

