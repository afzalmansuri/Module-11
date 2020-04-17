-- Task 1 -----------------------------

USE MarketDev
GO



ALTER TRIGGER Marketing.TR_CampaignBalance_Update
ON Marketing.CampaignBalance
AFTER UPDATE
AS BEGIN
SET NOCOUNT ON;

INSERT Marketing.CampaignAudit
(AuditTime, ModifyingUser, RemainingBalance)
SELECT SYSDATETIME(),
ORIGINAL_LOGIN(), 
inserted.RemainingBalance
FROM deleted
INNER JOIN inserted
ON deleted.CampaignID = inserted.CampaignID
WHERE ABS(deleted.RemainingBalance - inserted.RemainingBalance) > 10000;

END;

GO 


-Task 2 --------------------------------------

DELETE FROM Marketing.CampaignAudit;
GO 



-Task 3 ---------------------------------------

SELECT * FROM Marketing.CampaignBalance;
GO


EXEC Marketing.MoveCampaignBalance 3,2,10100;
GO

EXEC Marketing.MoveCampaignBalance 3,2,1010;
GO

SELECT * FROM Marketing.CampaignAudit;
GO 