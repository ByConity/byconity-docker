#!/bin/bash
./clickhouse client --time --query "DROP DATABASE IF EXISTS ssb"
./clickhouse client --time --query "CREATE DATABASE ssb"
./clickhouse client --database ssb --multiquery --time < datasets/ssb_ddl.sql

cd datasets
rm -rf *.tbl
# replace 1 with 10, 100, or 1000 bigger data
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    ./dbgen -s 10 -T a
elif [[ "$OSTYPE" == "darwin"* ]]; then
    ./dbgen-mac -s 10 -T a
fi
cd ..

echo "Create table and import data"
./clickhouse client --database ssb --time --query "INSERT INTO customer FORMAT CSV" < datasets/customer.tbl
./clickhouse client --database ssb --time --query "INSERT INTO part FORMAT CSV" < datasets/part.tbl
./clickhouse client --database ssb --time --query "INSERT INTO supplier FORMAT CSV" < datasets/supplier.tbl
./clickhouse client --database ssb --time --query "INSERT INTO lineorder FORMAT CSV" < datasets/lineorder.tbl
echo "Create flat table"
./clickhouse client --database ssb --multiquery --time < datasets/ssb_flat_table.sql
echo "Done!"
