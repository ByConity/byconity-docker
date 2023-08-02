#!/bin/bash

set -x -e

cp $BYCONITY_BINARY_PATH/clickhouse ./clickhouse && strip --strip-all ./clickhouse
cp $BYCONITY_BINARY_PATH/../build_info.txt ./build_info.txt
docker build . -t byconity/byconity
rm -r clickhouse
