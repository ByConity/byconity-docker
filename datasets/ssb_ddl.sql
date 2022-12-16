
CREATE TABLE customer
(
	C_CUSTKEY     UInt32,
	C_NAME        String,
	C_ADDRESS     String,
	C_CITY        LowCardinality(String),
	C_NATION      LowCardinality(String),
	C_REGION      LowCardinality(String),
	C_PHONE       FixedString(15),
	C_MKTSEGMENT  LowCardinality(String)
) ENGINE=CnchMergeTree() ORDER BY (C_CUSTKEY);

CREATE TABLE lineorder
(
	LO_ORDERKEY             UInt32,
	LO_LINENUMBER           UInt8,
	LO_CUSTKEY              UInt32,
	LO_PARTKEY              UInt32,
	LO_SUPPKEY              UInt32,
	LO_ORDERDATE            Date,
	LO_ORDERPRIORITY        LowCardinality(String),
	LO_SHIPPRIORITY         UInt8,
	LO_QUANTITY             UInt8,
	LO_EXTENDEDPRICE        UInt32,
	LO_ORDTOTALPRICE        UInt32,
	LO_DISCOUNT             UInt8,
	LO_REVENUE              UInt32,
	LO_SUPPLYCOST           UInt32,
	LO_TAX                  UInt8,
	LO_COMMITDATE           Date,
	LO_SHIPMODE             LowCardinality(String)
) ENGINE=CnchMergeTree() ORDER BY (LO_ORDERDATE, LO_ORDERKEY);

CREATE TABLE part
(
	P_PARTKEY       UInt32,
	P_NAME          String,
	P_MFGR          LowCardinality(String),
	P_CATEGORY      LowCardinality(String),
	P_BRAND         LowCardinality(String),
	P_COLOR         LowCardinality(String),
	P_TYPE          LowCardinality(String),
	P_SIZE          UInt8,
	P_CONTAINER     LowCardinality(String)
) ENGINE=CnchMergeTree() ORDER BY (P_PARTKEY);

CREATE TABLE supplier
(
	S_SUPPKEY       UInt32,
	S_NAME          String,
	S_ADDRESS       String,
	S_CITY          LowCardinality(String),
	S_NATION        LowCardinality(String),
	S_REGION        LowCardinality(String),
	S_PHONE         String
) ENGINE=CnchMergeTree() ORDER BY (S_SUPPKEY);