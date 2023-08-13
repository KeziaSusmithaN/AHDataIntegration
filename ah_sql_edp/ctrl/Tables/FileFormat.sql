CREATE TABLE [ctrl].[FileFormat] (
    [FormatID]     INT            IDENTITY (1, 1) NOT NULL,
    [FormatName]   NVARCHAR (50)  NULL,
    [Description]  NVARCHAR (500) NULL,
    [DelimiterInd] NVARCHAR (50)  NULL,
    [Compression]  NVARCHAR (50)  NULL,
    [CreatedBy]    NVARCHAR (100) CONSTRAINT [DF_FileFormat_CreatedBy] DEFAULT (suser_name()) NOT NULL,
    [CreatedDate]  DATETIME       CONSTRAINT [DF_FileFormat_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]    NVARCHAR (100) CONSTRAINT [DF_FileFormat_UpdatedBy] DEFAULT (suser_name()) NOT NULL,
    [UpdatedDate]  DATETIME       CONSTRAINT [DF_FileFormat_UpdatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_FileFormat] PRIMARY KEY CLUSTERED ([FormatID] ASC)
);

