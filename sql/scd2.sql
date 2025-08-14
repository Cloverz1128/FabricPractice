DROP PROCEDURE IF EXISTS SCD2
GO

CREATE PROC SCD2 AS
BEGIN
    UPDATE DimensionOverall 
    SET EndDate = (Select Max(UpdateDate) from DimensionOverall), IsCurrent = 'X'
    FROM DimensionImport
    LEFT JOIN DimensionOverall
    ON DimensionImport.ProductID = DimensionOverall.ProductID
    WHERE DimensionImport.ProductID IN (SELECT ProductID FROM DimensionOverall)
     AND (DimensionImport.Name <> DimensionOverall.Name)
     AND EndDate IS NULL;

    INSERT INTO DimensionOverall(ProductID, Name, UpdateDate, StartDate, IsCurrent)
    SELECT DISTINCT ProductID, Name, UpdateDate, dateadd(day, 1, (
        Select Max(UpdateDate) 
        FROM DimensionOverall
        WHERE DimensionOverall.ProductID = DimensionImport.ProductID
        )
    ), 'Y'
    FROM DimensionImport
    WHERE ProductID IN (
        SELECT ProductID 
        FROM DimensionOverall 
        WHERE DimensionImport.ProductID = DimensionOverall.ProductID 
         AND DimensionImport.Name <> DimensionOverall.Name 
         AND DimensionOverall.IsCurrent IN ('Y', 'X')
    );
    
    UPDATE DimensionOverall
    SET IsCurrent = 'N'
    FROM DimensionImport
    WHERE IsCurrent = 'X'

    UPDATE DimensionOverall
    SET UpdateDate = DimensionImport.UpdateDate
    FROM DimensionImport
    LEFT JOIN DimensionOverall
    ON DimensionImport.ProductID = DimensionOverall.ProductID
    WHERE DimensionImport.ProductID IN (SELECT ProductID FROM DimensionOverall)
     AND IsCurrent = 'Y';

    INSERT INTO DimensionOverall(ProductID, Name, UpdateDate, StartDate, IsCurrent)
    SELECT ProductID, Name, UpdateDate, '2010-01-01', 'Y'
    FROM DimensionImport
    WHERE ProductID NOT IN (SELECT ProductID FROM DimensionOverall);

    INSERT INTO FactOverall (ID, OrderDate, ProductID, Cost)
    SELECT ID, OrderDate, ProductID, Cost
    FROM FactImport
    WHERE ID NOT IN (SELECT ID FROM FactOverall);

    SELECT ID, OrderDate, FactOverall.ProductID, Name as ProductName, Cost
    FROM FactOverall
    LEFT JOIN DimensionOverall
    ON FactOverall.ProductID = DimensionOverall.ProductID
    AND OrderDate >= StartDate AND OrderDate <= ISNULL(EndDate, '2099-01-01')
    ORDER BY ID;

    SELECT ProductID, Name, UpdateDate, StartDate, EndDate, IsCurrent FROM DimensionOverall ORDER BY UpdateDate, ProductID;
END