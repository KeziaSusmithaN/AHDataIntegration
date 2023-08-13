CREATE TABLE [ctrl].[SourceConnection] (
    [SourceConnectionID] INT            IDENTITY (1, 1) NOT NULL,
    [SourceName]         NVARCHAR (50)  NULL,
    [Description]        NVARCHAR (500) NULL,
    [ConnectionType]     NVARCHAR (50)  NULL,
    [IRName]             NVARCHAR (128) NULL,
    [ServerName]         NVARCHAR (128) NULL,
    [ServiceName]        NVARCHAR (128) NULL,
    [Port]               NVARCHAR (50)  NULL,
    [UserName]           NVARCHAR (50)  NULL,
    [PasswordKVKey]      NVARCHAR (50)  NULL,
    [DBName]             NVARCHAR (128) NULL,
    [Directory]          NVARCHAR (128) NULL,
    [CreatedBy]          NVARCHAR (100) CONSTRAINT [DF_SourceConnection_CreatedBy] DEFAULT (suser_name()) NOT NULL,
    [CreatedDate]        DATETIME       CONSTRAINT [DF_SourceConnection_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]          NVARCHAR (100) CONSTRAINT [DF_SourceConnection_UpdatedBy] DEFAULT (suser_name()) NOT NULL,
    [UpdatedDate]        DATETIME       CONSTRAINT [DF_SourceConnection_UpdatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_SourceConnection] PRIMARY KEY CLUSTERED ([SourceConnectionID] ASC)
);

