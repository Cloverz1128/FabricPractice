DROP TABLE IF EXISTS FactImport
CREATE TABLE FactImport (
ID INT,
OrderDate DATE, 
ProductID INT,
Cost DECIMAL (7,2))

DROP TABLE IF EXISTS DimensionImport
CREATE TABLE DimensionImport (
ProductID INT,
Name VARCHAR (20),
UpdateDate DATE)

DROP TABLE IF EXISTS FactOverall
CREATE TABLE FactOverall(
ID INT,
OrderDate DATE, 
ProductID INT,
Cost DECIMAL (7,2))

DROP TABLE IF EXISTS DimensionOverall
CREATE TABLE DimensionOverall(
ProductID INT,
Name VARCHAR (20),
UpdateDate DATE
--, StartDate DATE
--, EndDate DATE
--, IsCurrent CHAR(1)
)