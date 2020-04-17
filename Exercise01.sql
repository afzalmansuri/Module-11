--Task 1 -------------------------------

USE AdventureWorks
GO



CREATE TABLE Production.ProductAudit(
ProductID int NOT NULL,
UpdateTime datetime2(7) NOT NULL,
ModifyingUser nvarchar(100) NOT NULL,
OriginalListPrice money NULL,
NewListPrice money NULL
)
GO





CREATE TRIGGER Production.TR_ProductListPrice_Update
ON Production.Product
AFTER UPDATE
AS BEGIN
 SET NOCOUNT ON;
 INSERT Production.ProductAudit(ProductID, UpdateTime, ModifyingUser,
OriginalListPrice,NewListPrice)
 SELECT Inserted.ProductID,SYSDATETIME(),ORIGINAL_LOGIN(),deleted.ListPrice,
inserted.ListPrice
 FROM deleted
 INNER JOIN inserted 
  ON deleted.ProductID = inserted.ProductID
 WHERE deleted.ListPrice > 1000 OR inserted.ListPrice > 1000;
END;
GO 



-- Task 2 ----------------------


UPDATE Production.Product
SET ListPrice=3978.00
WHERE ProductID BETWEEN 749 and 753;
GO



SELECT * FROM Production.ProductAudit;
GO 