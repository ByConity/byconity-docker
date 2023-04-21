#!/bin/bash

set -x -e

cp $BYCONITY_BINARY_PATH/clickhouse ./clickhouse
docker build .
rm -r clickhouse
