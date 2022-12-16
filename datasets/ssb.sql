-- Star schema
select sum(LO_EXTENDEDPRICE*LO_DISCOUNT) as revenue
from ssb.lineorder
where toYear(LO_ORDERDATE) = 1993
and LO_DISCOUNT between 1 and 3
and LO_QUANTITY < 25;

select sum(LO_EXTENDEDPRICE*LO_DISCOUNT) as revenue
from ssb.lineorder
where toYYYYMM(LO_ORDERDATE) = 199401
and LO_DISCOUNT between 4 and 6
and LO_QUANTITY between 26 and 35;

select sum(LO_EXTENDEDPRICE*LO_DISCOUNT) as revenue
from ssb.lineorder
where toISOWeek(LO_ORDERDATE) = 6
and toYear(LO_ORDERDATE)= 1994
and LO_DISCOUNT between 5 and 7
and LO_QUANTITY between 26 and 35;

select sum(LO_REVENUE), toYear(LO_ORDERDATE) AS d_year, P_BRAND
from ssb.lineorder, ssb.part, ssb.supplier
where LO_PARTKEY = P_PARTKEY
and LO_SUPPKEY = S_SUPPKEY
and P_CATEGORY = 'MFGR#12'
and S_REGION = 'AMERICA'
group by d_year, P_BRAND
order by d_year, P_BRAND;

select sum(LO_REVENUE), toYear(LO_ORDERDATE) AS d_year, P_BRAND
from ssb.lineorder, ssb.part, ssb.supplier
where LO_PARTKEY = P_PARTKEY
and LO_SUPPKEY = S_SUPPKEY
and P_BRAND between 'MFGR#2221' and 'MFGR#2228'
and S_REGION = 'ASIA'
group by d_year, P_BRAND
order by d_year, P_BRAND;

select sum(LO_REVENUE), toYear(LO_ORDERDATE) AS d_year, P_BRAND
from ssb.lineorder, ssb.part, ssb.supplier
where LO_PARTKEY = P_PARTKEY
and LO_SUPPKEY = S_SUPPKEY
and P_BRAND = 'MFGR#2221'
and S_REGION = 'EUROPE'
group by d_year, P_BRAND
order by d_year, P_BRAND;

select C_NATION, S_NATION, toYear(LO_ORDERDATE) AS d_year, sum(LO_REVENUE) as revenue
from ssb.customer, ssb.lineorder, ssb.supplier
where LO_CUSTKEY = C_CUSTKEY
and LO_SUPPKEY = S_SUPPKEY
and C_REGION = 'ASIA' and S_REGION = 'ASIA'
and d_year >= 1992 and d_year <= 1997
group by C_NATION, S_NATION, d_year
order by d_year asc, revenue desc;

select C_CITY, S_CITY, toYear(LO_ORDERDATE) AS d_year, sum(LO_REVENUE) as revenue
from ssb.customer, ssb.lineorder, ssb.supplier
WHERE LO_CUSTKEY = C_CUSTKEY
AND LO_SUPPKEY = S_SUPPKEY
and C_NATION = 'UNITED STATES'
and S_NATION = 'UNITED STATES'
and d_year >= 1992 and d_year <= 1997
group by C_CITY, S_CITY, d_year
order by d_year asc, revenue desc;


select C_CITY, S_CITY, toYear(LO_ORDERDATE) AS d_year, sum(LO_REVENUE) as revenue
from ssb.customer, ssb.lineorder, ssb.supplier
WHERE LO_CUSTKEY = C_CUSTKEY
AND LO_SUPPKEY = S_SUPPKEY
and (C_CITY='UNITED KI1' or C_CITY='UNITED KI5')
and (S_CITY='UNITED KI1' or S_CITY='UNITED KI5')
and d_year >= 1992 and d_year <= 1997
group by C_CITY, S_CITY, d_year
order by d_year asc, revenue desc;

select C_CITY, S_CITY, toYear(LO_ORDERDATE) AS d_year, sum(LO_REVENUE) as revenue
from ssb.customer, ssb.lineorder, ssb.supplier
where LO_CUSTKEY = C_CUSTKEY
and LO_SUPPKEY = S_SUPPKEY
and (C_CITY='UNITED KI1' or C_CITY='UNITED KI5')
and (S_CITY='UNITED KI1' or S_CITY='UNITED KI5')
and toYYYYMM(LO_ORDERDATE) = 199712
group by C_CITY, S_CITY, d_year
order by d_year asc, revenue desc;

select toYear(LO_ORDERDATE) AS d_year, C_NATION, sum(LO_REVENUE - LO_SUPPLYCOST) as profit
from ssb.customer, ssb.supplier, ssb.part, ssb.lineorder
WHERE LO_CUSTKEY = C_CUSTKEY
 AND LO_SUPPKEY = S_SUPPKEY
 AND LO_PARTKEY = P_PARTKEY
 and C_REGION = 'AMERICA'
 and S_REGION = 'AMERICA'
 and (P_MFGR = 'MFGR#1' or P_MFGR = 'MFGR#2')
group by d_year, C_NATION
order by d_year, C_NATION;

select toYear(LO_ORDERDATE) AS d_year, S_NATION, P_CATEGORY, sum(LO_REVENUE - LO_SUPPLYCOST) as profit
from ssb.customer, ssb.supplier, ssb.part, ssb.lineorder
WHERE LO_CUSTKEY = C_CUSTKEY
AND LO_SUPPKEY = S_SUPPKEY
AND LO_PARTKEY = P_PARTKEY
and C_REGION = 'AMERICA'
and S_REGION = 'AMERICA'
and (d_year = 1997 or d_year = 1998)
and (P_MFGR = 'MFGR#1'
or P_MFGR = 'MFGR#2')
group by d_year, S_NATION, P_CATEGORY Order by d_year, S_NATION, P_CATEGORY;

select toYear(LO_ORDERDATE) AS d_year, S_CITY, P_BRAND, sum(LO_REVENUE - LO_SUPPLYCOST) as profit
from ssb.customer, ssb.supplier, ssb.part, ssb.lineorder
WHERE LO_CUSTKEY = C_CUSTKEY
AND LO_SUPPKEY = S_SUPPKEY
AND LO_PARTKEY = P_PARTKEY
AND C_REGION = 'AMERICA'
AND S_NATION = 'UNITED STATES'
and (d_year = 1997 or d_year = 1998)
AND P_CATEGORY = 'MFGR#14'
group by d_year, S_CITY, P_BRAND order by d_year, S_CITY, P_BRAND;


-- Flat table
SELECT sum(LO_EXTENDEDPRICE * LO_DISCOUNT) AS revenue FROM lineorder_flat WHERE toYear(LO_ORDERDATE) = 1993 AND LO_DISCOUNT BETWEEN 1 AND 3 AND LO_QUANTITY < 25;
SELECT sum(LO_EXTENDEDPRICE * LO_DISCOUNT) AS revenue FROM lineorder_flat WHERE toYYYYMM(LO_ORDERDATE) = 199401 AND LO_DISCOUNT BETWEEN 4 AND 6 AND LO_QUANTITY BETWEEN 26 AND 35;
SELECT sum(LO_EXTENDEDPRICE * LO_DISCOUNT) AS revenue FROM lineorder_flat WHERE toISOWeek(LO_ORDERDATE) = 6 AND toYear(LO_ORDERDATE) = 1994 AND LO_DISCOUNT BETWEEN 5 AND 7 AND LO_QUANTITY BETWEEN 26 AND 35;
SELECT sum(LO_REVENUE), toYear(LO_ORDERDATE) AS year, P_BRAND FROM lineorder_flat WHERE P_CATEGORY = 'MFGR#12' AND S_REGION = 'AMERICA' GROUP BY year, P_BRAND ORDER BY year, P_BRAND;
SELECT sum(LO_REVENUE), toYear(LO_ORDERDATE) AS year, P_BRAND FROM lineorder_flat WHERE P_BRAND >= 'MFGR#2221' AND P_BRAND <= 'MFGR#2228' AND S_REGION = 'ASIA' GROUP BY year, P_BRAND ORDER BY year, P_BRAND;
SELECT sum(LO_REVENUE), toYear(LO_ORDERDATE) AS year, P_BRAND FROM lineorder_flat WHERE P_BRAND = 'MFGR#2239' AND S_REGION = 'EUROPE' GROUP BY year, P_BRAND ORDER BY year, P_BRAND;
SELECT C_NATION, S_NATION, toYear(LO_ORDERDATE) AS year, sum(LO_REVENUE) AS revenue FROM lineorder_flat WHERE C_REGION = 'ASIA' AND S_REGION = 'ASIA' AND year >= '1992' AND year <= '1997' GROUP BY C_NATION, S_NATION, year ORDER BY year ASC, revenue DESC;
SELECT C_CITY, S_CITY, toYear(LO_ORDERDATE) AS year, sum(LO_REVENUE) AS revenue FROM lineorder_flat WHERE C_NATION = 'UNITED STATES' AND S_NATION = 'UNITED STATES' AND year >= 1992 AND year <= 1997 GROUP BY C_CITY, S_CITY, year ORDER BY year ASC, revenue DESC;
SELECT C_CITY, S_CITY, toYear(LO_ORDERDATE) AS year, sum(LO_REVENUE) AS revenue FROM lineorder_flat WHERE (C_CITY = 'UNITED KI1' OR C_CITY = 'UNITED KI5') AND (S_CITY = 'UNITED KI1' OR S_CITY = 'UNITED KI5') AND toYYYYMM(LO_ORDERDATE) = 199712 GROUP BY C_CITY, S_CITY, year ORDER BY year ASC, revenue DESC;
SELECT toYear(LO_ORDERDATE) AS year, C_NATION, sum(LO_REVENUE - LO_SUPPLYCOST) AS profit FROM lineorder_flat WHERE C_REGION = 'AMERICA' AND S_REGION = 'AMERICA' AND (P_MFGR = 'MFGR#1' OR P_MFGR = 'MFGR#2') GROUP BY year, C_NATION ORDER BY year ASC, C_NATION ASC;
SELECT toYear(LO_ORDERDATE) AS year, S_NATION, P_CATEGORY, sum(LO_REVENUE - LO_SUPPLYCOST) AS profit FROM lineorder_flat WHERE C_REGION = 'AMERICA' AND S_REGION = 'AMERICA' AND (year = 1997 OR year = 1998) AND (P_MFGR = 'MFGR#1' OR P_MFGR = 'MFGR#2') GROUP BY year, S_NATION, P_CATEGORY ORDER BY year ASC, S_NATION ASC, P_CATEGORY ASC;
SELECT toYear(LO_ORDERDATE) AS year, S_CITY, P_BRAND, sum(LO_REVENUE - LO_SUPPLYCOST) AS profit FROM lineorder_flat WHERE S_NATION = 'UNITED STATES' AND (year = 1997 OR year = 1998) AND P_CATEGORY = 'MFGR#14' GROUP BY year, S_CITY, P_BRAND ORDER BY year ASC, S_CITY ASC, P_BRAND ASC;
