-- 테이블의 인덱스별로 데이터 페이지가 버퍼 풀에 적재되어 있는 것을 확인.
SELECT
tbl.name AS Table_Name,
idx.name AS Index_Name,
ca.n_cached_pages AS Cached_Pages
FROM information_schema.innodb_tables AS tbl
INNER JOIN information_schema.innodb_index AS idx
  ON idx.table_id = tbl.table_id
INNER JOIN information_schema.innodb_cached_index AS ca
  ON ca.index_id = idx.index_id
