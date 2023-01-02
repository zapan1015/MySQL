SELECT
t.TABLE_SCHEMA AS `schema`,
t.TABLE_NAME AS `table`,
c.COLUMN_NAME AS `column`,
t.AUTO_INCREMENT AS `auto_increment`,
c.DATA_TYPE AS `pk_type`,
(
  t.AUTO_INCREMENT / 
  (
    CASE c.DATA_TYPE
      WHEN 'tinyint' THEN IF (c.COLUMN_TYPE LIKE '%unsigned', 255, 127)
      WHEN 'smallint' THEN IF (c.COLUMN_TYPE LIKE '%unsigned', 65535, 32767)
      WHEN 'mediumint' THEN IF (c.COLUMN_TYPE LIKE '%unsigned', 16777215, 8388607)
      WHEN 'int' THEN IF (c.COLUMN_TYPE LIKE '%unsigned', 4294967295, 2147483647)
      WHEN 'bigint' THEN IF (c.COLUMN_TYPE LIKE '%unsigned', 18446744073709551615, 9223372036854775807)
    END / 100
  )
) AS `max_value`
FROM information_schema.TABLES AS t
INNER JOIN information_schema.COLUMNS AS c
  ON t.TABLE_SCHEMA = c.TABLE_SCHEMA
  AND t.TABLE_NAME = c.TABLE_NAME
WHERE t.AUTO_INCREMENT IS NOT NULL
  AND c.COLUMN_KEY = 'pri'
  AND c.DATA_TYPE LIKE '%int'
;
