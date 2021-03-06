--! qt:dataset:alltypesorc
set hive.mapred.mode=nonstrict;
set hive.explain.user=false;
SET hive.vectorized.execution.enabled=true;
set hive.fetch.task.conversion=none;

CREATE TABLE decimal_date_test STORED AS ORC AS SELECT cdouble, CAST (((cdouble*22.1)/37) AS DECIMAL(20,10)) AS cdecimal1, CAST (((cdouble*9.3)/13) AS DECIMAL(23,14)) AS cdecimal2, CAST(CAST((CAST(cint AS BIGINT) *ctinyint) AS TIMESTAMP) AS DATE) AS cdate FROM alltypesorc ORDER BY cdate;

-- Add a single NULL row that will come from ORC as isRepeated.
insert into decimal_date_test values (NULL, NULL, NULL, NULL);

EXPLAIN VECTORIZATION EXPRESSION SELECT cdate FROM decimal_date_test WHERE cdate IN (CAST("1969-10-26" AS DATE), CAST("1969-07-14" AS DATE)) ORDER BY cdate;

EXPLAIN VECTORIZATION EXPRESSION SELECT COUNT(*) FROM decimal_date_test WHERE cdate NOT IN (CAST("1969-10-26" AS DATE), CAST("1969-07-14" AS DATE), CAST("1970-01-21" AS DATE));

EXPLAIN VECTORIZATION EXPRESSION SELECT cdecimal1 FROM decimal_date_test WHERE cdecimal1 IN (2365.8945945946, 881.0135135135, -3367.6517567568) ORDER BY cdecimal1;

EXPLAIN VECTORIZATION EXPRESSION SELECT COUNT(*) FROM decimal_date_test WHERE cdecimal1 NOT IN (2365.8945945946, 881.0135135135, -3367.6517567568);

EXPLAIN VECTORIZATION EXPRESSION SELECT cdate FROM decimal_date_test WHERE cdate BETWEEN CAST("1969-12-30" AS DATE) AND CAST("1970-01-02" AS DATE) ORDER BY cdate;

EXPLAIN VECTORIZATION EXPRESSION SELECT cdate FROM decimal_date_test WHERE cdate NOT BETWEEN CAST("1968-05-01" AS DATE) AND CAST("1971-09-01" AS DATE) ORDER BY cdate;

EXPLAIN VECTORIZATION EXPRESSION SELECT cdecimal1 FROM decimal_date_test WHERE cdecimal1 BETWEEN -20 AND 45.9918918919 ORDER BY cdecimal1;

EXPLAIN VECTORIZATION EXPRESSION SELECT COUNT(*) FROM decimal_date_test WHERE cdecimal1 NOT BETWEEN -2000 AND 4390.1351351351;

SELECT cdate FROM decimal_date_test WHERE cdate IN (CAST("1969-10-26" AS DATE), CAST("1969-07-14" AS DATE)) ORDER BY cdate;

SELECT COUNT(*) FROM decimal_date_test WHERE cdate NOT IN (CAST("1969-10-26" AS DATE), CAST("1969-07-14" AS DATE), CAST("1970-01-21" AS DATE));

SELECT cdecimal1 FROM decimal_date_test WHERE cdecimal1 IN (2365.8945945946, 881.0135135135, -3367.6517567568) ORDER BY cdecimal1;

SELECT COUNT(*) FROM decimal_date_test WHERE cdecimal1 NOT IN (2365.8945945946, 881.0135135135, -3367.6517567568);

SELECT cdate FROM decimal_date_test WHERE cdate BETWEEN CAST("1969-12-30" AS DATE) AND CAST("1970-01-02" AS DATE) ORDER BY cdate;

SELECT cdate FROM decimal_date_test WHERE cdate NOT BETWEEN CAST("1968-05-01" AS DATE) AND CAST("1971-09-01" AS DATE) ORDER BY cdate;

SELECT cdecimal1 FROM decimal_date_test WHERE cdecimal1 BETWEEN -20 AND 45.9918918919 ORDER BY cdecimal1;

SELECT COUNT(*) FROM decimal_date_test WHERE cdecimal1 NOT BETWEEN -2000 AND 4390.1351351351;



-- projections

EXPLAIN VECTORIZATION EXPRESSION SELECT c0, count(1) from (SELECT cdate IN (CAST("1969-10-26" AS DATE), CAST("1969-07-14" AS DATE)) as c0 FROM decimal_date_test) tab GROUP BY c0 ORDER BY c0;

EXPLAIN VECTORIZATION EXPRESSION SELECT c0, count(1) from (SELECT cdecimal1 IN (2365.8945945946, 881.0135135135, -3367.6517567568) as c0 FROM decimal_date_test) tab GROUP BY c0 ORDER BY c0;

EXPLAIN VECTORIZATION EXPRESSION SELECT c0, count(1) from (SELECT  cdate BETWEEN CAST("1969-12-30" AS DATE) AND CAST("1970-01-02" AS DATE) as c0  FROM decimal_date_test) tab GROUP BY c0 ORDER BY c0;

EXPLAIN VECTORIZATION EXPRESSION SELECT c0, count(1) from (SELECT cdecimal1 NOT BETWEEN -2000 AND 4390.1351351351 as c0 FROM decimal_date_test) tab GROUP BY c0 ORDER BY c0;

SELECT c0, count(1) from (SELECT cdate IN (CAST("1969-10-26" AS DATE), CAST("1969-07-14" AS DATE)) as c0 FROM decimal_date_test) tab GROUP BY c0 ORDER BY c0;

SELECT c0, count(1) from (SELECT cdecimal1 IN (2365.8945945946, 881.0135135135, -3367.6517567568) as c0 FROM decimal_date_test) tab GROUP BY c0 ORDER BY c0;

SELECT c0, count(1) from (SELECT  cdate BETWEEN CAST("1969-12-30" AS DATE) AND CAST("1970-01-02" AS DATE) as c0 FROM decimal_date_test) tab GROUP BY c0 ORDER BY c0;

SELECT c0, count(1) from (SELECT cdecimal1 NOT BETWEEN -2000 AND 4390.1351351351 as c0 FROM decimal_date_test) tab GROUP BY c0 ORDER BY c0;

set hive.vectorized.execution.enabled=false;

SELECT c0, count(1) from (SELECT cdate IN (CAST("1969-10-26" AS DATE), CAST("1969-07-14" AS DATE)) as c0 FROM decimal_date_test) tab GROUP BY c0 ORDER BY c0;

SELECT c0, count(1) from (SELECT cdecimal1 IN (2365.8945945946, 881.0135135135, -3367.6517567568) as c0 FROM decimal_date_test) tab GROUP BY c0 ORDER BY c0;

SELECT c0, count(1) from (SELECT  cdate BETWEEN CAST("1969-12-30" AS DATE) AND CAST("1970-01-02" AS DATE) as c0 FROM decimal_date_test) tab GROUP BY c0 ORDER BY c0;

SELECT c0, count(1) from (SELECT cdecimal1 NOT BETWEEN -2000 AND 4390.1351351351 as c0 FROM decimal_date_test) tab GROUP BY c0 ORDER BY c0;
