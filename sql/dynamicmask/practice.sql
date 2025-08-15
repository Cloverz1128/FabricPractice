SELECT *
FROM Geography
GRANT SELECT ON Geography to [xxx@filecats.onmicrosoft.com]

ALTER TABLE Geography
ALTER COLUMN City ADD MASKED WITH (FUNCTION = 'default()')

ALTER TABLE Geography
ALTER COLUMN ZipCode ADD MASKED WITH (FUNCTION = 'partial(1, "XXXXX", 1)') -- 第一个和最后一个不mask