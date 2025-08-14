DROP PROCEDURE IF EXISTS SCD0
GO

CREATE PROC SCD0 AS
BEGIN
    INSERT INTO DimensionOverall(ProductID, Name, UpdateDate)
    SELECT ProductID, Name, UpdateDate
    FROM DimensionImport
    WHERE ProductID NOT IN (SELECT ProductID FROM DimensionOverall)

    INSERT INTO FactOverall (ID, OrderDate, ProductID, Cost)
    SELECT ID, OrderDate, ProductID, Cost
    FROM FactImport
    WHERE ID NOT IN (SELECT ID FROM FactOverall)

    SELECT * FROM FactOverall ORDER BY ID
    SELECT ProductID, Name FROM DimensionOverall ORDER BY UpdateDate, ProductID
END