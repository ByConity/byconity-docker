#!/bin/bash
set -x -e

./clickhouse client --time --query "CREATE DATABASE IF NOT EXISTS test"
./clickhouse client --time --query "DROP TABLE IF EXISTS test.hits"

cd datasets
wget --continue --no-clobber 'https://datasets.clickhouse.com/hits_compatible/hits.tsv.gz'
gzip -d hits.tsv.gz
cd ..

echo "Create table and import data"
./clickhouse client --time < datasets/clickbench_ddl.sql
./clickhouse client --time --query "INSERT INTO test.hits FORMAT TSV" < datasets/hits.tsv
echo "Done!"
