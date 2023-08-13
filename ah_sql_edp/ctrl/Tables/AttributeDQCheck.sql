CREATE TABLE [ctrl].[AttributeDQCheck] (
    [DQCheckAttributeID] INT             IDENTITY (1, 1) NOT NULL,
    [SourceAttributeID]  INT             NOT NULL,
    [DQCheckID]          INT             NOT NULL,
    [RuleType]           NVARCHAR (255)  NULL,
    [RuleValue]          NVARCHAR (1000) NULL,
    [RulePriority]       INT             NULL,
    [IsRuleActive]       BIT             NULL,
    [CreatedBy]          NVARCHAR (100)  CONSTRAINT [DF_AttributeDQCheck_CreatedBy] DEFAULT (suser_name()) NOT NULL,
    [CreatedDate]        DATETIME        CONSTRAINT [DF_AttributeDQCheck_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [UpdatedBy]          NVARCHAR (100)  CONSTRAINT [DF_AttributeDQCheck_UpdatedBy] DEFAULT (suser_name()) NOT NULL,
    [UpdatedDate]        DATETIME        CONSTRAINT [DF_AttributeDQCheck_UpdatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_AttributeDQCheck] PRIMARY KEY CLUSTERED ([DQCheckAttributeID] ASC),
    CONSTRAINT [FK_AttributeDQCheck_SourceObjectAttribute] FOREIGN KEY ([SourceAttributeID]) REFERENCES [ctrl].[SourceObjectAttribute] ([SourceAttributeID])
);

