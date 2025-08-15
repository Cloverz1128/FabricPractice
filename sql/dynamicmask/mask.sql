DROP TABLE IF EXISTS DynamicDataMasking; 
GO
CREATE TABLE DynamicDataMasking
(ID int                     MASKED WITH (FUNCTION = 'random(1,10)'),
EmailAddress varchar(50)    MASKED WITH (FUNCTION = 'email()'),
FamilyName varchar(30)      MASKED WITH (FUNCTION = 'partial(1, "XXXXXX", 2)'),
Department varchar(30)      MASKED WITH (FUNCTION = 'default()'),
DateOfBirth date            MASKED MASKED WITH (FUNCTION = 'default()'))

INSERT INTO DynamicDataMasking (ID, EmailAddress, FamilyName, Department, DateOfBirth) VALUES
(11, 'john.doe@company. com', 'Doe', 'IT', '1985-02-15')

SELECT * FROM DynamicDataMasking
GRANT SELECT ON DynamicDataMasking TO [xxx@Filecats.onmicrosoft.com] -- 给用户查看数据的权限
ALTER TABLE DynamicDataMasking ALTER COLUMN ID DROP MASKED;
ALTER TABLE DynamicDataMasking
ALTER COLUMN ID ADD MASKED WITH (FUNCTION = 'random(21, 30)')