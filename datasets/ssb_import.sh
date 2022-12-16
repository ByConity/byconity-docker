#!/bin/bash
./clickhouse client --host 127.0.0.1 --port 52145 --time --query "DROP DATABASE IF EXISTS ssb"
./clickhouse client --host 127.0.0.1 --port 52145 --time --query "CREATE DATABASE ssb"
./clickhouse client --host 127.0.0.1 --port 52145 --database ssb --multiquery --time < datasets/ssb_ddl.sql

cd datasets
rm -rf *.tbl
# replace 1 with 10, 100, or 1000 bigger data
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    ./dbgen -s 1 -T a
elif [[ "$OSTYPE" == "darwin"* ]]; then
    ./dbgen-mac -s 1 -T a
fi
cd ..

echo "Create table and import data"
./clickhouse client --port 52145 --database ssb --query "INSERT INTO customer FORMAT CSV" < datasets/customer.tbl
./clickhouse client --port 52145 --database ssb --query "INSERT INTO part FORMAT CSV" < datasets/part.tbl
./clickhouse client --port 52145 --database ssb --query "INSERT INTO supplier FORMAT CSV" < datasets/supplier.tbl
./clickhouse client --port 52145 --database ssb --query "INSERT INTO lineorder FORMAT CSV" < datasets/lineorder.tbl
echo "Create flat table"
./clickhouse client --port 52145 --database ssb --multiquery --time < datasets/ssb_flat_table.sql
echo "Done!"