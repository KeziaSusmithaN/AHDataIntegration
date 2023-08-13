CREATE TABLE [ctrl].[Stage_AttributeDQCheck] (
    [SourceAttributeID] INT            NOT NULL,
    [RuleType]          NVARCHAR (255) NULL,
    [RuleValue]         NVARCHAR (255) NULL,
    [RulePriority]      INT            NULL,
    [IsRuleActive]      BIT            NULL,
    [DQCheckID]         INT            NULL
);

