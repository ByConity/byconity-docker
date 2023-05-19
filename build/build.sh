#!/bin/bash

set -x -e

cp $BYCONITY_BINARY_PATH/clickhouse ./clickhouse && strip --strip-all ./clickhouse
docker build .
rm -r clickhouse
