-- Empty Import tables
DELETE FROM FactImport
-- Import new data
INSERT INTO FactImport(ID, OrderDate, ProductID, Cost) VALUES
(1, '2024-01-02', 1, 34),
(2, '2024-01-03', 2, 48),
(3, '2024-02-02', 1, 60),
(4, '2024-02-03', 2, 23),
(5, '2024-03-02', 1, 76),
(6, '2024-03-03', 2, 12),
(7, '2024-04-02', 1, 95),
(8, '2024-04-03', 2, 34)
DELETE FROM FactImport WHERE MONTH(OrderDate) IN (2, 3, 4) -- Expand by removing , 1, 2, 3, and 4
SELECT * FROM FactImport 