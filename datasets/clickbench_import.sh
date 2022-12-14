#!/bin/bash
./clickhouse client --host 127.0.0.1 --port 52145 --time --query "CREATE DATABASE IF NOT EXISTS test"
./clickhouse client --host 127.0.0.1 --port 52145 --time --query "DROP TABLE IF EXISTS test.hits"

cd datasets
wget --continue --no-clobber 'https://datasets.clickhouse.com/hits_compatible/hits.tsv.gz'
gzip -d hits.tsv.gz
cd ..

echo "Create table and import data"
./clickhouse client --host 127.0.0.1 --port 52145 < datasets/clickbench_ddl.sql
./clickhouse client --host 127.0.0.1 --port 52145 --time --query "INSERT INTO test.hits FORMAT TSV" < datasets/hits.tsv
echo "Done!"
