DROP TABLE IF EXISTS tblWaterMark;
DROP TABLE IF EXISTS FactImport;
DROP PROCEDURE IF EXISTS updateWatermark;
CREATE TABLE FactImport(
ID INT,
OrderDate DATETIME2(6), -- This has been changed to allow times
ProductID INT,
Cost DECIMAL(7,2))

CREATE TABLE tblWaterMark
(Watermark DATETIME2(6))

INSERT INTO tblWaterMark
VALUES ('2000-01-01')

GO

CREATE PROCEDURE updateWatermark @WaterMark DATETIME2(6)
AS
UPDATE tblWaterMark
SET Watermark = @WaterMark

SELECT * FROM tblWaterMark
EXEC updateWatermark '2000-01-02T00:00:00' -- To test