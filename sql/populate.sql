-- Empty Import tables
DELETE FROM FactImport
DELETE FROM DimensionImport

-- Import new DATA
INSERT INTO FactImport(ID, OrderDate, ProductID, Cost) VALUES
(1, '2024-01-02', 1, 34),
(2, '2024-01-03', 2, 48),
(3, '2024-02-02', 1, 60),
(4, '2024-02-03', 2, 23),
(5, '2024-03-02', 1, 76),
(6, '2024-03-03', 2, 12),
(7, '2024-04-02', 1, 95),
(8, '2024-04-03', 2, 34)

INSERT INTO DimensionImport(ProductID, Name, UpdateDate) VALUES
(1, 'Product 1', '2023-12-31'), 
(2, 'Product 2', '2023-12-31'),
(1, 'Product 1', '2024-01-31'),
(2, 'Product 2', '2024-01-31'),
(1, 'Product 1a', '2024-02-29'),
(2, 'Product 2', '2024-02-29'),
(1, 'Product 1a', '2024-03-31'),
(2, 'Product 2', '2024-03-31'),
(1, 'Product 1b', '2024-04-30'),
(2, 'Product 2', '2024-04-30')

DELETE FROM FactImport WHERE MONTH(OrderDate) <> 12
DELETE FROM DimensionImport WHERE MONTH(UpdateDate) <> 12

EXECUTE SCD0
-- EXECUTE SCD1
-- EXECUTE SCD2