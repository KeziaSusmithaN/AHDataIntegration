﻿CREATE TABLE [ctrl].[SourceObjectAttribute] (
    [SourceAttributeID]    INT             IDENTITY (1, 1) NOT NULL,
    [SourceObjectID]       INT             NOT NULL,
    [ColSequenceNo]        INT             NULL,
    [SourceColumnName]     NVARCHAR (200)  NULL,
    [TargetColumnName]     NVARCHAR (200)  NULL,
    [DataType]             NVARCHAR (20)   NULL,
    [Nullable]             BIT             NULL,
    [IsPrimaryKey]         BIT             NULL,
    [PartitionKey]         BIT             CONSTRAINT [DF__SourceObj__Parti__08B54D69] DEFAULT ((0)) NULL,
    [ColLength]            SMALLINT        NULL,
    [PrecisionLength]      SMALLINT        NULL,
    [ScaleLength]          SMALLINT        NULL,
    [DateFormat]           VARCHAR (50)    NULL,
    [CreatedBy]            NVARCHAR (100)  CONSTRAINT [DF_SourceObjectAttribute_CreatedBy] DEFAULT (suser_name()) NOT NULL,
    [CreatedDate]          DATETIME        CONSTRAINT [DF_SourceObjectAttribute_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]            NVARCHAR (100)  CONSTRAINT [DF_SourceObjectAttribute_UpdatedBy] DEFAULT (suser_name()) NOT NULL,
    [UpdatedDate]          DATETIME        CONSTRAINT [DF_SourceObjectAttribute_UpdatedDate] DEFAULT (getdate()) NOT NULL,
    [BusinessFunctionTags] NVARCHAR (4000) NULL,
    [PrimaryKeyPosition]   SMALLINT        NULL,
    [DataDefault]          NVARCHAR (250)  NULL,
    CONSTRAINT [PK_SourceObjectAttribute] PRIMARY KEY CLUSTERED ([SourceAttributeID] ASC),
    CONSTRAINT [FK_SourceObjectAttribute_SourceObject] FOREIGN KEY ([SourceObjectID]) REFERENCES [ctrl].[SourceObject] ([SourceObjectID])
);

