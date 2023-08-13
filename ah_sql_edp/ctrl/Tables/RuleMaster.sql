CREATE TABLE [ctrl].[RuleMaster] (
    [DQCheckID]          INT            IDENTITY (1, 1) NOT NULL,
    [BusinessFunctionID] INT            NOT NULL,
    [RuleName]           NVARCHAR (255) NULL,
    [IsRuleActive]       BIT            DEFAULT ((1)) NULL,
    CONSTRAINT [PK_RuleMaster_1] PRIMARY KEY CLUSTERED ([DQCheckID] ASC),
    CONSTRAINT [FK_RuleMaster_BusinessFunction] FOREIGN KEY ([BusinessFunctionID]) REFERENCES [ctrl].[BusinessFunction] ([BusinessFunctionID])
);

