CREATE TABLE [ctrl].[EmailAlertRecipients] (
    [RecipientID]        INT            IDENTITY (1, 1) NOT NULL,
    [BusinessFunctionID] INT            NOT NULL,
    [FromEmailAddress]   NVARCHAR (100) NOT NULL,
    [ToEmailAddress]     NVARCHAR (MAX) NOT NULL,
    [IsActive]           BIT            NOT NULL,
    [CreatedBy]          NVARCHAR (100) CONSTRAINT [DF_EmailAlertRecipients_CreatedBy] DEFAULT (suser_name()) NOT NULL,
    [CreatedDate]        DATETIME       CONSTRAINT [DF_EmailAlertRecipients_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]          NVARCHAR (100) CONSTRAINT [DF_EmailAlertRecipients_UpdatedBy] DEFAULT (suser_name()) NOT NULL,
    [UpdatedDate]        DATETIME       CONSTRAINT [DF_EmailAlertRecipients_UpdatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_EmailAlertRecipients] PRIMARY KEY CLUSTERED ([RecipientID] ASC),
    CONSTRAINT [FK_EmailAlertRecipients_BusinessFunction] FOREIGN KEY ([BusinessFunctionID]) REFERENCES [ctrl].[BusinessFunction] ([BusinessFunctionID])
);

